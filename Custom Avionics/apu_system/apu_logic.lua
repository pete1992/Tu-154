-- apu_logic.lua

-- Smartcopilot
defineProperty("ismaster",    globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

-- Helper to batch-register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register all APU logic DataRefs
defineProps({
    {"apu_main_switch",     "sim/custom/switchers/eng/apu_main_switch",        globalPropertyi},
    {"apu_start_mode",      "sim/custom/switchers/eng/apu_start_mode",         globalPropertyi},
    {"apu_air_bleed",       "sim/custom/switchers/eng/apu_air_bleed",          globalPropertyi},
    {"apu_start",           "sim/custom/buttons/eng/apu_start",                globalPropertyi},
    {"apu_stop",            "sim/custom/buttons/eng/apu_stop",                 globalPropertyi},
    {"apu_n1",              "sim/custom/eng/apu_n1",                           globalPropertyf},
    {"apu_oil_t",           "sim/custom/eng/apu_oil_t",                        globalPropertyf},
    {"apu_oil_q",           "sim/custom/eng/apu_oil_q",                        globalPropertyf},
    {"apu_oil_p",           "sim/custom/eng/apu_oil_p",                        globalPropertyf},
    {"apu_egt",             "sim/custom/eng/apu_egt",                          globalPropertyf},
    {"bus27_volt_left",     "sim/custom/elec/bus27_volt_left",                  globalPropertyf},
    {"bus27_volt_right",    "sim/custom/elec/bus27_volt_right",                 globalPropertyf},
    {"gen4_amp_bus",        "sim/custom/elec/gen4_amp",                         globalPropertyf},
    {"apu_system_on",       "sim/custom/eng/apu_system_on",                    globalPropertyi},
    {"apu_fuel_last",       "sim/custom/eng/apu_fuel_last",                    globalPropertyf},
    {"tank1_w",             "sim/flightmodel/weight/m_fuel[0]",                 globalPropertyf},
    {"apu_air_press",       "sim/custom/eng/apu_air_press",                     globalPropertyf},
    {"apu_air_doors",       "sim/custom/eng/apu_air_doors",                     globalPropertyf},
    {"apu_fuel_p",          "sim/custom/eng/apu_fuel_p",                        globalPropertyf},
    {"apu_start_bus",       "sim/custom/elec/apu_start_bus",                    globalPropertyf},
    {"apu_start_cc",        "sim/custom/elec/apu_start_cc",                     globalPropertyf},
    {"apu_start_seq",       "sim/custom/elec/apu_start_seq",                    globalPropertyi},
    {"fuel_pumps_27_cc",    "sim/custom/elec/fuel_pumps_27_cc",                 globalPropertyf},
    {"apu_doors",           "sim/custom/anim/apu_doors",                        globalPropertyf},
    {"apu_burn_fuel",       "sim/custom/elec/apu_burning_fuel",                 globalPropertyi},
    {"eng_airvalve_2",      "sim/custom/bleed/eng_airvalve_2",                  globalPropertyf},
    {"rpm_high_2",          "sim/custom/gauges/engine/rpm_high_2",              globalPropertyf},
    {"frame_time",          "sim/custom/time/frame_time",                      globalPropertyf},
    {"outside_air_temp",    "sim/cockpit2/temperature/outside_air_temp_degc",   globalPropertyf},
    {"msl_alt",             "sim/flightmodel/position/elevation",               globalPropertyf},
    {"baro_press",          "sim/weather/barometer_sealevel_inhg",              globalPropertyf},
    {"reset_state",         "sim/custom/reset_state",                           globalPropertyi},
    {"apu_start_fail",      "sim/custom/failures/apu_start_fail",               globalPropertyi},
    {"apu_gen_fail",        "sim/custom/failures/apu_gen_fail",                 globalPropertyi},
    {"apu_runtime",         "sim/custom/failures/apu_runtime",                  globalPropertyf},
    {"apu_fail_oilt",       "sim/custom/failures/apu_fail_oilt",                globalPropertyi},
    {"apu_fail_egt",        "sim/custom/failures/apu_fail_egt",                 globalPropertyi},
    {"apu_fail_fuel_left",  "sim/custom/failures/apu_fail_fuel_left",           globalPropertyi},
    {"apu_fail",            "sim/custom/failures/apu_fail",                     globalPropertyi},
    {"apu_press_fail",      "sim/custom/failures/apu_press_fail",               globalPropertyi},
    {"failures_enabled",    "sim/custom/failures/failures_enabled",             globalPropertyi},
})

-- Initialize random runtime
set(apu_runtime, math.random(280, 320) * 3600)

-- Local state variables
local RPM                   = 0
local oil_q                 = 1
set(apu_oil_q, 1)
local apu_burns_fuel        = false
local apd_work_time         = 100
local apu_doors_pos         = get(apu_doors)
local bleed_doors_pos       = get(apu_air_doors)
local apu_burning_fuel      = 0
local apu_starter           = 0
local starter_work          = 1
local starter_worked        = false
local apu_emerg_off         = 0
local apu_fail_last_fuel    = 1
local apu_fail_EGT          = 1
local apu_fail_OIL_T        = 1
local starter_RPM_check     = false
local egt_current           = get(apu_egt)
local apu_temp              = get(outside_air_temp)
local oil_temp              = get(apu_oil_t)
local fuel_last             = get(apu_fuel_last)
local oil_temp_counter      = 0
local minusTimer            = 0

-- Lookup tables for interpolation
local off_tbl = {
    {-500, 30}, {-10, 30}, {0, 0}, {3, -5}, {4, -0.18},
    {5, -0.18}, {10, -0.25}, {20, -2}, {30, -3},
    {40, -5}, {55, -7}, {60, -20}, {100, -20},
    {120, -50}, {1000, -100}
}
local starter_tbl = {
    {-500, 20}, {0, 10}, {3, 8}, {15, 4}, {20, 5},
    {23, 2.5}, {30, 0}, {1000, 0}
}
local fuel_tbl = {
    {-500, 0}, {0,0}, {15,0}, {20,1}, {30,5},
    {55,10}, {60,30}, {98,30}, {102,0}, {1000,0}
}
local oil_temp_tbl = {
    {-500,10}, {-50,1.6}, {-30,1.4}, {-25,1.25},
    {30,1}, {150,0.9}, {1000,0.7}
}
local false_bleed = 0

-- Linear interpolation helper
local function interpolate(tbl, x)
    for i = 1, #tbl - 1 do
        local x1, y1 = tbl[i][1], tbl[i][2]
        local x2, y2 = tbl[i+1][1], tbl[i+1][2]
        if x >= x1 and x <= x2 then
            return y1 + (y2 - y1) * (x - x1) / (x2 - x1)
        end
    end
    return tbl[#tbl][2]
end

function update()
    local passed = get(frame_time)

    -- Handle manual reset of failures
    if get(reset_state) == 1 then
        set(apu_fail_fuel_left, 0)
        set(apu_fail_egt,        0)
        set(apu_fail_oilt,       0)
        apu_fail_last_fuel = 1
        apu_fail_EGT       = 1
        apu_fail_OIL_T     = 1
    end

    -- Read dynamic values
    RPM             = get(apu_n1)
    oil_q           = get(apu_oil_q)
    oil_temp        = get(apu_oil_t)
    apu_doors_pos   = get(apu_doors)
    bleed_doors_pos = get(apu_air_doors)
    apu_burning_fuel= get(apu_burn_fuel)
    egt_current     = get(apu_egt)

    local MASTER = get(ismaster) ~= 1
    if MASTER then
        -- Update failure-inverted flags
        apu_fail_last_fuel = 1 - get(apu_fail_fuel_left)
        apu_fail_EGT       = 1 - get(apu_fail_egt)
        apu_fail_OIL_T     = 1 - get(apu_fail_oilt)

        -- Compute system-on
        local main_sw    = get(apu_main_switch)
        local bus_L      = get(bus27_volt_left)
        local bus_R      = get(bus27_volt_right)
        local system_on  = (bus_R > 13 and main_sw == 1) and 1 or 0

        -- Animate APU doors
        apu_doors_pos = apu_doors_pos + bus_L * (system_on * 2 - 1) * passed / 81
        apu_doors_pos = math.min(1, math.max(0, apu_doors_pos))

        -- Animate bleed doors
        if bus_R > 13 and RPM > 92 and get(apu_press_fail) == 0 then
            bleed_doors_pos = bleed_doors_pos + get(apu_air_bleed) * passed * 0.2
        else
            bleed_doors_pos = bleed_doors_pos - passed * 0.2
        end
        bleed_doors_pos = math.min(1, math.max(0, bleed_doors_pos))

        -- Fuel pressure and flow
        local fuel_press   = get(apu_fuel_p)
        local fuel_current = 0
        if get(apu_start_mode) * system_on == 1 and get(apu_start_bus) > 13 and get(tank1_w) > 150 then
            fuel_press   = fuel_press + passed
            fuel_current = 15
        else
            fuel_press = fuel_press - passed
        end
        fuel_press = math.min(1, math.max(0, fuel_press))

        -- Starter engagement timing
        apd_work_time = apd_work_time + passed
        if (apd_work_time > 32 or RPM > 45) and not starter_worked then
            apu_starter    = 0
            starter_worked = true
        elseif apd_work_time > 1 and apd_work_time < 32 and not starter_worked then
            apu_starter = 1
        end
        if RPM > 92 then
            apu_starter    = 0
            apd_work_time  = 100
        end
        if RPM > 92 or apd_work_time > 32 then
            starter_worked = false
        end

        -- Cold/hot start failure checks
        if RPM > 21 and apd_work_time < 32 and fuel_press > 0.8 and apu_starter == 1 then
            if fuel_last > 0.1 and apu_burning_fuel == 0 then
                if math.random(100 - fuel_last * 80) < 20 then
                    apu_fail_last_fuel = 0
                    set(apu_fail_fuel_left, 1)
                end
            end
            if egt_current > 150 and apu_burning_fuel == 0 then
                if math.random(350 - egt_current) < 50 then
                    apu_fail_EGT = 0
                    set(apu_fail_egt, 1)
                end
            end
            apu_burning_fuel = 1
        elseif fuel_press < 0.5 then
            apu_burning_fuel = 0
        end

        -- Emergency shutdown conditions
        local start_seq = get(apu_start_seq) == 1
        if (start_seq and egt_current > 700) or (not start_seq and egt_current > 570) then
            apu_emerg_off = 1
        end
        if RPM > 105 then apu_emerg_off = 1 end
        if system_on == 0 then apu_emerg_off = 0 end

        -- Runtime decrement
        if get(failures_enabled) > 0 then
            minusTimer = minusTimer + passed * RPM * 0.01
            if minusTimer >= 1 then
                minusTimer = 0
                set(apu_runtime, math.max(0, get(apu_runtime) - 1))
            end
        else
            set(apu_runtime, 300 * 3600)
            set(apu_fail_fuel_left, 0)
            set(apu_fail_egt,        0)
            set(apu_fail_oilt,       0)
            set(apu_start_fail,      0)
        end

        -- Write outputs
        set(apu_system_on,   system_on)
        set(apu_n1,          RPM)
        set(apu_air_doors,   bleed_doors_pos)
        set(apu_doors,       apu_doors_pos)
        set(apu_oil_t,       oil_temp)
        set(apu_oil_q,       oil_q)
        set(apu_oil_p,       oil_q * 3)
        set(apu_egt,         egt_current)
        set(apu_fuel_p,      fuel_press)
        set(apu_start_cc,    apu_starter * (600 / (1 + math.max(RPM - 10, 0) / 5)))
        set(fuel_pumps_27_cc,fuel_current)
        set(apu_burn_fuel,   apu_burning_fuel)
    end
end
