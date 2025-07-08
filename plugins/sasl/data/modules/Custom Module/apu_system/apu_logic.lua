-- apu_logic.lua (optimized) --
-- Handles APU start/stop logic, bleed air, fuel and oil parameters, and custom failures for Tu-154M SASL 3.19

-- Batch property definition utility
local defineBatch = function(defs)
    for _, d in ipairs(defs) do defineProperty(d[1], d[3](d[2])) end
end

-- Property definitions (clear, uniform English)
local prop_defs = {
    -- Controls
    {"apu_main_switch",     "tu154ce/switchers/eng/apu_main_switch",     globalPropertyi},
    {"apu_start_mode",      "tu154ce/switchers/eng/apu_start_mode",      globalPropertyi},
    {"apu_air_bleed",       "tu154ce/switchers/eng/apu_air_bleed",       globalPropertyi},
    {"apu_start",           "tu154ce/buttons/eng/apu_start",             globalPropertyi},
    {"apu_stop",            "tu154ce/buttons/eng/apu_stop",              globalPropertyi},
    -- Internals
    {"apu_n1",              "tu154ce/eng/apu_n1",                        globalPropertyf},
    {"apu_oil_t",           "tu154ce/eng/apu_oil_t",                     globalPropertyf},
    {"apu_oil_q",           "tu154ce/eng/apu_oil_q",                     globalPropertyf},
    {"apu_oil_p",           "tu154ce/eng/apu_oil_p",                     globalPropertyf},
    {"apu_egt",             "tu154ce/eng/apu_egt",                       globalPropertyf},
    -- Electrical
    {"bus27_L",             "tu154ce/elec/bus27_volt_left",              globalPropertyf},
    {"bus27_R",             "tu154ce/elec/bus27_volt_right",             globalPropertyf},
    {"gen4_amp",            "tu154ce/elec/gen4_amp",                     globalPropertyf},
    -- Status/Result
    {"apu_system_on",       "tu154ce/eng/apu_system_on",                 globalPropertyi},
    {"apu_fuel_last",       "tu154ce/eng/apu_fuel_last",                 globalPropertyf},
    {"apu_air_press",       "tu154ce/eng/apu_air_press",                 globalPropertyf},
    {"apu_air_doors",       "tu154ce/eng/apu_air_doors",                 globalPropertyf},
    {"apu_fuel_p",          "tu154ce/eng/apu_fuel_p",                    globalPropertyf},
    {"apu_start_seq",       "tu154ce/elec/apu_start_seq",                globalPropertyi},
    {"apu_start_cc",        "tu154ce/elec/apu_start_cc",                 globalPropertyf},
    {"fuel_pumps_cc",       "tu154ce/elec/fuel_pumps_27_cc",             globalPropertyf},
    {"apu_doors",           "tu154ce/anim/apu_doors",                    globalPropertyf},
    {"apu_burn_fuel",       "tu154ce/elec/apu_burning_fuel",             globalPropertyf},
    -- External
    {"tank1_w",             "sim/flightmodel/weight/m_fuel[0]",          globalPropertyf},
    {"rpm_eng2",            "tu154ce/gauges/engine/rpm_high_2",          globalPropertyf},
    {"outside_temp",        "sim/cockpit2/temperature/outside_air_temp_degc", globalPropertyf},
    {"alt_msl",             "sim/flightmodel/position/elevation",        globalPropertyf},
    {"baro_press",          "sim/weather/barometer_sealevel_inhg",       globalPropertyf},
    {"frame_time",          "tu154ce/time/frame_time",                   globalPropertyf},
    -- Failures
    {"fail_start",          "tu154ce/failures/apu_start_fail",           globalPropertyi},
    {"fail_gen",            "tu154ce/failures/apu_gen_fail",             globalPropertyi},
    {"fail_oilt",           "tu154ce/failures/apu_fail_oilt",            globalPropertyi},
    {"fail_egt",            "tu154ce/failures/apu_fail_egt",             globalPropertyi},
    {"fail_fuel_left",      "tu154ce/failures/apu_fail_fuel_left",       globalPropertyi},
    {"fail_press",          "tu154ce/failures/apu_press_fail",           globalPropertyi},
    {"fail_enabled",        "tu154ce/failures/failures_enabled",         globalPropertyi},
    {"apu_runtime",         "tu154ce/failures/apu_runtime",              globalPropertyf}
}
defineBatch(prop_defs)

-- State initialization
local state = {
    RPM = 0,
    oil_q = 1,
    egt = get(apu_egt),
    temp_oil = get(apu_oil_t),
    temp_eg = get(outside_temp),
    fuel_last = get(apu_fuel_last),
    bleed_pos = get(apu_air_doors),
    starter_on = 0,
    start_timer = 100,
    emerg_off = 0
}

-- Math helpers
local function clamp(v, a, b) return v < a and a or (v > b and b or v) end
local function interpolateTbl(tbl, x)
    for i = 1, #tbl - 1 do
        if x <= tbl[i + 1][1] then
            local x0, v0 = tbl[i][1], tbl[i][2]
            local x1, v1 = tbl[i + 1][1], tbl[i + 1][2]
            return v0 + (v1 - v0) * (x - x0) / (x1 - x0)
        end
    end
    return tbl[#tbl][2]
end

-- Tables for response curves (RPM, starter, fuel effect)
local off_tbl   = {{-500,30}, {0,0}, {100,0}}
local start_tbl = {{0,10}, {20,5}, {1000,0}}
local fuel_tbl  = {{0,0}, {30,30}, {1000,0}}

-- Main update function
function update()
    local dt = get(frame_time)

    -- Synchronize current APU state from DataRefs
    state.RPM       = get(apu_n1)
    state.oil_q     = get(apu_oil_q)
    state.temp_oil  = get(apu_oil_t)
    state.egt       = get(apu_egt)
    state.bleed_pos = get(apu_air_doors)

    -- Only run logic if this is not a SmartCopilot slave
    local master = get(globalPropertyf("scp/api/ismaster")) ~= 1
    if not master then return end

    local busL, busR = get(bus27_L), get(bus27_R)

    -- Determine system ON state
    local system_on = (busR > 13 and get(apu_main_switch) == 1) and 1 or 0
    set(apu_system_on, system_on)

    -- Animate APU air intake doors
    local door_speed = busL * (system_on * 2 - 1) / 81
    local new_doors = get(apu_doors) + door_speed * dt
    set(apu_doors, clamp(new_doors, 0, 1))

    -- Bleed air door logic
    if busR > 13 and state.RPM > 92 and get(fail_press) ~= 1 then
        state.bleed_pos = state.bleed_pos + get(apu_air_bleed) * 0.2 * dt
    else
        state.bleed_pos = state.bleed_pos - 0.2 * dt
    end
    set(apu_air_doors, clamp(state.bleed_pos, 0, 1))

    -- Fuel pressure and starter sequence
    local fuel_p = get(apu_fuel_p)
    if get(apu_start_mode) == 1 and system_on == 1 and busR > 13 and get(tank1_w) > 150 then
        fuel_p = fuel_p + dt
        state.start_timer = state.start_timer + dt
        state.starter_on = (state.start_timer > 1 and state.start_timer < 32) and 1 or 0
    else
        fuel_p = fuel_p - dt
        state.starter_on = 0
    end
    set(apu_fuel_p, clamp(fuel_p, 0, 1))
    set(apu_start_seq, state.starter_on)

    -- APU RPM calculation
    local off_force   = interpolateTbl(off_tbl, state.RPM)
    local start_force = interpolateTbl(start_tbl, state.RPM) * state.starter_on
    local burn_force  = interpolateTbl(fuel_tbl, state.RPM) * state.fuel_last
    state.RPM = state.RPM + (off_force + start_force + burn_force) * dt
    set(apu_n1, state.RPM)

    -- Fuel burn and tracking
    state.fuel_last = state.fuel_last - (state.RPM * 0.001)^0.7 * 0.12 * dt - ((burn_force > 0) and 0.1 * dt or 0)
    if state.fuel_last < 0 then state.fuel_last = 0 end
    set(apu_fuel_last, state.fuel_last)

    -- Failure and runtime logic
    if get(fail_enabled) == 1 then
        set(apu_runtime, math.max(0, get(apu_runtime) - dt))
    else
        set(apu_runtime, 3600000)
    end

    -- EGT & oil temp output
    set(apu_egt, state.egt)
    set(apu_oil_t, state.temp_oil)
    set(apu_oil_q, state.oil_q)
    set(apu_oil_p, state.oil_q * 3)

    -- ===========================
    -- Reset logic for start/stop
    -- ===========================
    -- Resets timer and starter when:
    -- 1. APU stop button pressed
    -- 2. System switched OFF
    -- 3. Start cycle ends (APU reached stable speed)
    -- 4. APU falls below idle after running
    if get(apu_stop) == 1 or system_on == 0 or (state.starter_on == 1 and get(apu_n1) > 92) or (get(apu_n1) < 10 and state.start_timer > 32) then
        state.start_timer = 100
        state.starter_on  = 0
        set(apu_start_seq, 0)
    end
end
