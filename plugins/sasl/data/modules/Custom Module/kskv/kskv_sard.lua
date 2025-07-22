-- kskv_sard.lua
-- Tu-154M SARD Pressure Control Logic | X-Plane 12 | SASL 3.19+

-- Helper: table interpolation (X1,Y1)-(X2,Y2)
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

-- Batch DataRef definitions ------------------------------------------------
local props = {
    { "frame_time",           "tu154ce/time/frame_time",                             "f" },
    { "xp_version",           "sim/version/xplane_internal_version",                 "i" },
    { "air_usage_L",          "tu154ce/bleed/air_usage_L",                           "f" },
    { "air_usage_R",          "tu154ce/bleed/air_usage_R",                           "f" },
    { "bus27_volt_left",      "tu154ce/elec/bus27_volt_left",                        "f" },
    { "bus27_volt_right",     "tu154ce/elec/bus27_volt_right",                       "f" },
    { "bus115_1_volt",        "tu154ce/elec/bus115_1_volt",                          "f" },
    { "sard_panel_lit",       "tu154ce/lights/sard_panel_lit",                       "f" },
    { "start_sys_work",       "tu154ce/start/start_sys_work",                        "f" },
    { "sard_cabin_press_set", "tu154ce/switchers/sard/sard_cabin_press_set",         "f" },
    { "sard_abs_press_set",   "tu154ce/switchers/sard/sard_abs_press_set",           "f" },
    { "sard_diff_set",        "tu154ce/switchers/sard/sard_diff_set",                "f" },
    { "sard_spd_set",         "tu154ce/switchers/sard/sard_spd_set",                 "f" },
    { "emerg_decompress",     "tu154ce/switchers/airbleed/emerg_decompress",         "i" },
    { "sard_disable",         "tu154ce/switchers/eng/sard_disable",                  "i" },
    { "cockpit_window_left",  "tu154ce/anim/cockpit_window_left",                    "f" },
    { "cockpit_window_right", "tu154ce/anim/cockpit_window_right",                   "f" },
    { "pax_door_1",           "tu154ce/anim/pax_door_1",                             "f" },
    { "pax_door_2",           "tu154ce/anim/pax_door_2",                             "f" },
    { "pax_door_3",           "tu154ce/anim/pax_door_3",                             "f" },
    { "sard_valve_fail",      "tu154ce/failures/sard_valve_fail",                    "i" },
    { "msl_alt",              "sim/flightmodel/position/elevation",                  "f" },
    { "msl_press",            "sim/weather/barometer_sealevel_inhg",                 "f" },
    { "dump_to_altitude_on",  "sim/cockpit2/pressurization/actuators/dump_to_altitude_on","i" },
    { "cabin_altitude_ft",    "sim/cockpit2/pressurization/actuators/cabin_altitude_ft","f" },
    { "cabin_vvi_fpm",        "sim/cockpit2/pressurization/actuators/cabin_vvi_fpm","f" },
    { "dump_all_on",          "sim/cockpit2/pressurization/actuators/dump_all_on",   "i" },
    { "cabin_alt_now_ft",     "sim/cockpit2/pressurization/indicators/cabin_altitude_ft","f" },
    { "pressure_diff_psi",    "sim/cockpit2/pressurization/indicators/pressure_diffential_psi","f" },
    { "ismaster",             "scp/api/ismaster",                                    "f" },
}

for _, p in ipairs(props) do
    if p[3] == "f" then
        defineProperty(p[1], globalPropertyf(p[2]))
    else
        defineProperty(p[1], globalPropertyi(p[2]))
    end
end

-- Reference table: cabin-pressure setpoint → altitude differential (m)
local press_alt_tbl = {
    { -1e5, 1e6 },
    {  525, 3000 }, { 560, 2500 }, { 597, 2000 },
    { 635, 1500 }, { 674, 1000 }, { 714,  500 },
    { 760,    0 }, { 806, -500 }, { 1e7, -1e5 },
}

-- State variables
local last_time = get(frame_time)

function update()
    -- Delta-time
    local now = get(frame_time)
    local dt  = now - last_time
    last_time = now

    -- Power availability
    local power_L = get(bus27_volt_left)  > 13
    local power_R = get(bus27_volt_right) > 13

    -- Ambient & cabin altitudes (m)
    local acf_alt     = get(msl_alt) + (29.92 - get(msl_press)) * 1000 * 0.3048
    local current_alt = get(cabin_alt_now_ft) * 0.3048

    -- Pneumatic & pressurization settings
    local airflow      = get(air_usage_L) + get(air_usage_R)
    local current_diff = get(pressure_diff_psi) * 0.0778
    local alt_set      = interpolate(press_alt_tbl, get(sard_cabin_press_set))
    local diff_set     = get(sard_diff_set)
    local start_sys    = get(start_sys_work) == 1

    -- Pressure regulator logic
    local press_reg = 0
    if acf_alt < alt_set + 200 then
        press_reg = (current_alt < acf_alt - 200) and 1 or 0
    elseif current_diff < diff_set then
        press_reg = (current_alt < alt_set) and 1 or 0
    end
    if current_diff > diff_set then press_reg = 1 end

    -- Emergency & system decompression
    local dumpall = 0
    local fast_decomp = 0
    if (get(emerg_decompress) == 1 or press_reg == 1)
       and get(sard_valve_fail) == 0
       and get(sard_disable)   == 0
       and power_R
       and not start_sys
    then
        local coef = (acf_alt / 12000) * (-400) + 500
        fast_decomp = current_alt + (acf_alt - current_alt) * dt * coef
        dumpall = 1
    end

    -- Windows/doors decompression
    local windows_decomp = 0
    local cabin_vvi = 10000
    if get(cockpit_window_left)
       + get(cockpit_window_right)
       + get(pax_door_1)
       + get(pax_door_2)
       + get(pax_door_3) > 0.2
    then
        windows_decomp = current_alt + (acf_alt - current_alt) * dt * 1000
        cabin_vvi = 100000
        dumpall = 1
    end

    -- Slow bleed & airflow compensation
    local slow_decomp    = (acf_alt - current_alt) * dt * 1
    local airflow_comp   = (acf_alt - 10500 - current_alt) * dt * airflow * 1

    -- Compute new cabin altitude
    local new_cab_alt = current_alt
                      + airflow_comp
                      + slow_decomp
                      + fast_decomp
                      + windows_decomp

    -- Write outputs only if master or plugin absent
    local MASTER = get(ismaster) ~= 1
    if MASTER then
        set(cabin_vvi_fpm, cabin_vvi)
        set(cabin_altitude_ft, new_cab_alt / 0.3048)
        set(dump_all_on, dumpall)
    end

    -- Panel lighting
    set(sard_panel_lit, get(bus115_1_volt) / 115)
end


