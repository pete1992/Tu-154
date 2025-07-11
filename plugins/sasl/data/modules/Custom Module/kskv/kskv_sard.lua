-- Tu-154M SARD Pressure Control Logic (SASL3.x+ robust)

-- Helper: Interpolate (X1,Y1)-(X2,Y2)
local function interpolate(tbl, x)
    for i = 1, #tbl - 1 do
        if x <= tbl[i + 1][1] then
            local x0, y0 = tbl[i][1], tbl[i][2]
            local x1, y1 = tbl[i + 1][1], tbl[i + 1][2]
            return y0 + (y1 - y0) * (x - x0) / (x1 - x0)
        end
    end
    return tbl[#tbl][2]
end

-- Robust DataRef for has_press_controls
local has_press_controls_ref = "sim/aircraft/view/acf_has_press_controls"
if not findDataRef(has_press_controls_ref) then
    -- Create fallback custom DataRef
    has_press_controls_ref = "tu154ce/compat/has_press_controls"
    createGlobalPropertyi(has_press_controls_ref, 1)
end
defineProperty("acf_has_press_controls", globalPropertyi(has_press_controls_ref))

-- DataRefs
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time"))
defineProperty("xp_version", globalPropertyi("sim/version/xplane_internal_version"))

defineProperty("air_usage_L", globalPropertyf("tu154ce/bleed/air_usage_L"))
defineProperty("air_usage_R", globalPropertyf("tu154ce/bleed/air_usage_R"))

defineProperty("bus27_volt_left",  globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("bus115_1_volt",    globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("sard_panel_lit",   globalPropertyf("tu154ce/lights/sard_panel_lit"))

defineProperty("start_sys_work", globalPropertyf("tu154ce/start/start_sys_work"))

defineProperty("sard_cabin_press_set", globalPropertyf("tu154ce/switchers/sard/sard_cabin_press_set"))
defineProperty("sard_abs_press_set",   globalPropertyf("tu154ce/switchers/sard/sard_abs_press_set"))
defineProperty("sard_diff_set",        globalPropertyf("tu154ce/switchers/sard/sard_diff_set"))
defineProperty("sard_spd_set",         globalPropertyf("tu154ce/switchers/sard/sard_spd_set"))

defineProperty("emerg_decompress", globalPropertyi("tu154ce/switchers/airbleed/emerg_decompress"))
defineProperty("sard_disable",     globalPropertyi("tu154ce/switchers/eng/sard_disable"))

defineProperty("cockpit_window_left",  globalPropertyf("tu154ce/anim/cockpit_window_left"))
defineProperty("cockpit_window_right", globalPropertyf("tu154ce/anim/cockpit_window_right"))
defineProperty("pax_door_1",           globalPropertyf("tu154ce/anim/pax_door_1"))
defineProperty("pax_door_2",           globalPropertyf("tu154ce/anim/pax_door_2"))
defineProperty("pax_door_3",           globalPropertyf("tu154ce/anim/pax_door_3"))

defineProperty("sard_valve_fail", globalPropertyi("tu154ce/failures/sard_valve_fail"))

defineProperty("msl_alt",   globalPropertyf("sim/flightmodel/position/elevation"))
defineProperty("msl_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))

defineProperty("dump_to_altitude_on", globalPropertyi("sim/cockpit2/pressurization/actuators/dump_to_altitude_on"))
defineProperty("cabin_altitude_ft",   globalPropertyf("sim/cockpit2/pressurization/actuators/cabin_altitude_ft"))
defineProperty("cabin_vvi_fpm",       globalPropertyf("sim/cockpit2/pressurization/actuators/cabin_vvi_fpm"))
defineProperty("dump_all_on",         globalPropertyi("sim/cockpit2/pressurization/actuators/dump_all_on"))
defineProperty("cabin_alt_now_ft",    globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft"))
defineProperty("pressure_diff_psi",   globalPropertyf("sim/cockpit2/pressurization/indicators/pressure_diffential_psi"))

-- Reference Table
local press_alt_tbl = {
    { -100000, 1000000 },
    {  525, 3000 }, { 560, 2500 }, { 597, 2000 }, { 635, 1500 }, { 674, 1000 },
    { 714, 500 }, { 760, 0 }, { 806, -500 }, {  10000000, -100000 }
}

local press_reg = 0      -- pressure valve position
local cab_alt_need = -200
local decomp_last = 0

function update()
    local passed = get(frame_time)
    local XP11 = get(xp_version) > 11000

    local power_L = get(bus27_volt_left)  > 13
    local power_R = get(bus27_volt_right) > 13

    -- Altitudes (meters)
    local acf_alt = get(msl_alt) + (29.92 - get(msl_press)) * 1000 * 0.3048
    local current_alt = get(cabin_alt_now_ft) * 0.3048

    -- System variables
    local airflow    = get(air_usage_L) + get(air_usage_R)
    local current_diff = get(pressure_diff_psi) * 0.0778
    local alt_set    = interpolate(press_alt_tbl, get(sard_cabin_press_set))
    local diff_set   = get(sard_diff_set)

    -- Automatic pressure regulation
    if acf_alt < alt_set + 200 then
        press_reg = (current_alt < acf_alt - 200) and 1 or 0
    elseif current_diff < diff_set then
        press_reg = (current_alt < alt_set) and 1 or 0
    end
    if current_diff > diff_set then press_reg = 1 end

    -- Cabin decompress
    local dumpall = 0
    local fast_decomp = 0
    local fast_decomp_coef = (acf_alt / 12000) * (-400) + 500
    local start_sys = get(start_sys_work) == 1

    if (get(emerg_decompress) == 1 or press_reg == 1) and get(sard_valve_fail) == 0 and get(sard_disable) == 0 and power_R and not start_sys then
        fast_decomp = current_alt + (acf_alt - current_alt) * passed * fast_decomp_coef
        dumpall = 1
    end

    -- Windows/doors decompression
    local windows_decomp = 0
    local cabin_vvi = 10000
    if get(cockpit_window_left) + get(cockpit_window_right) + get(pax_door_1) + get(pax_door_2) + get(pax_door_3) > 0.2 then
        windows_decomp = current_alt + (acf_alt - current_alt) * passed * 1000
        cabin_vvi = 100000
        dumpall = 1
    end

    -- Slow decompress & airflow compensation
    local slow_decomp = (acf_alt - current_alt) * passed * 1
    local airflow_comp = (acf_alt - 10500 - current_alt) * passed * airflow * 1

    -- Resulting cabin altitude
    local sys_alt = current_alt + airflow_comp + slow_decomp + fast_decomp + windows_decomp

    -- Write outputs (only if master or not SmartCopilot slave)
    local MASTER = get(ismaster) ~= 1
    if MASTER then
        set(cabin_vvi_fpm, cabin_vvi)
        set(cabin_altitude_ft, sys_alt / 0.3048)
        set(dump_all_on, dumpall)
    end

    set(sard_panel_lit, get(bus115_1_volt) / 115)
end
