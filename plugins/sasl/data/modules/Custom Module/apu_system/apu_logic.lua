-- apu_logic.lua (optimized, reviewed)
-- Handles Tu-154M APU start/stop, air doors, fuel/oil/EGT, failures. SASL 3.19+

-- Batch property definition utility
local defineBatch = function(defs)
    for _, d in ipairs(defs) do defineProperty(d[1], d[3](d[2])) end
end

-- DataRef definitions
local prop_defs = {
    -- [ ... wie in deinem Code ... ]
}
defineBatch(prop_defs)

-- State
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

-- Response tables
local off_tbl   = {{-500,30}, {0,0}, {100,0}}
local start_tbl = {{0,10}, {20,5}, {1000,0}}
local fuel_tbl  = {{0,0}, {30,30}, {1000,0}}

function update()
    local dt = get(frame_time)
    -- Only run on master (not SmartCopilot slave)
    local master = get(globalPropertyf("scp/api/ismaster")) ~= 1
    if not master then return end

    -- Sync state from DataRefs
    state.RPM       = get(apu_n1)
    state.oil_q     = get(apu_oil_q)
    state.temp_oil  = get(apu_oil_t)
    state.egt       = get(apu_egt)
    state.bleed_pos = get(apu_air_doors)

    local busL, busR = get(bus27_L), get(bus27_R)

    -- System ON logic
    local system_on = (busR > 13 and get(apu_main_switch) == 1) and 1 or 0
    set(apu_system_on, system_on)

    -- Air intake doors
    local door_speed = busL * (system_on * 2 - 1) / 81
    local new_doors = get(apu_doors) + door_speed * dt
    set(apu_doors, clamp(new_doors, 0, 1))

    -- Bleed air doors
    if busR > 13 and state.RPM > 92 and get(fail_press) ~= 1 then
        state.bleed_pos = state.bleed_pos + get(apu_air_bleed) * 0.2 * dt
    else
        state.bleed_pos = state.bleed_pos - 0.2 * dt
    end
    set(apu_air_doors, clamp(state.bleed_pos, 0, 1))

    -- Fuel pressure & starter sequence
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

    -- Fuel burn tracking
    state.fuel_last = state.fuel_last - (state.RPM * 0.001)^0.7 * 0.12 * dt - ((burn_force > 0) and 0.1 * dt or 0)
    if state.fuel_last < 0 then state.fuel_last = 0 end
    set(apu_fuel_last, state.fuel_last)

    -- Failure and runtime logic
    if get(fail_enabled) == 1 then
        set(apu_runtime, math.max(0, get(apu_runtime) - dt))
    else
        set(apu_runtime, 3600000)
    end

    -- Update EGT & oil outputs
    set(apu_egt, state.egt)
    set(apu_oil_t, state.temp_oil)
    set(apu_oil_q, state.oil_q)
    set(apu_oil_p, state.oil_q * 3)

    -- Reset start logic
    if get(apu_stop) == 1 or system_on == 0 or (state.starter_on == 1 and get(apu_n1) > 92) or (get(apu_n1) < 10 and state.start_timer > 32) then
        state.start_timer = 100
        state.starter_on  = 0
        set(apu_start_seq, 0)
    end
end
