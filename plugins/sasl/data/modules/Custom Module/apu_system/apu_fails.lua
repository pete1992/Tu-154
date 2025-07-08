-- apu_fails.lua (optimized)
-- Handles all APU failure logic for Tu-154M: physical, operational, and random failures

-- Batch DataRef registration
defineBatch = function(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[2](d[3]))
    end
end

defineBatch({
    {"failures_enabled",   "tu154ce/failures/failures_enabled",   globalPropertyi},
    {"frame_time",         "tu154ce/time/frame_time",            globalPropertyf},
    {"ismaster",           "scp/api/ismaster",                   globalPropertyf},
    {"apu_start_fail",     "tu154ce/failures/apu_start_fail",    globalPropertyi},
    {"apu_gen_fail",       "tu154ce/failures/apu_gen_fail",      globalPropertyi},
    {"apu_fail_oilt",      "tu154ce/failures/apu_fail_oilt",     globalPropertyi},
    {"apu_fail_egt",       "tu154ce/failures/apu_fail_egt",      globalPropertyi},
    {"apu_fail_fuel_left", "tu154ce/failures/apu_fail_fuel_left",globalPropertyi},
    {"apu_fail",           "tu154ce/failures/apu_fail",          globalPropertyi},
    {"apu_press_fail",     "tu154ce/failures/apu_press_fail",    globalPropertyi},
    {"apu_runtime",        "tu154ce/failures/apu_runtime",       globalPropertyf},
    {"apu_oil_t",          "tu154ce/eng/apu_oil_t",              globalPropertyf},
    {"apu_egt",            "tu154ce/eng/apu_egt",                globalPropertyf},
    {"apu_burn_fuel",      "tu154ce/elec/apu_burning_fuel",      globalPropertyf},
    {"apu_n1",             "tu154ce/eng/apu_n1",                 globalPropertyf},
    {"apu_start_seq",      "tu154ce/elec/apu_start_seq",         globalPropertyi}
})

local function bool2int(b) return b and 1 or 0 end

local fail_timer = 0
local next_check = math.random(15, 30)

function update()
    local dt = get(frame_time)
    -- Only run on master (not on SmartCopilot slave)
    if get(ismaster) == 1 then return end

    local FAIL = get(failures_enabled)
    if FAIL > 0 then
        -- Scale random failure rates by difficulty
        FAIL = FAIL * 0.05 * 4^(FAIL * 0.5)
        fail_timer = fail_timer + dt

        -- *** Deterministic failures: occur immediately on threshold ***
        -- Oil temperature > 115°C: triggers oil failure and total APU failure (may lead to fire)
        if get(apu_fail_oilt) == 0 and get(apu_oil_t) > 115 then
            set(apu_fail_oilt, 1)
            set(apu_fail, 1)
        end
        -- Starting APU with oil temp > 150°C: triggers EGT and total APU failure (may lead to fire)
        local starting = get(apu_start_seq) == 1 or (get(apu_n1) < 30 and get(apu_burn_fuel) == 1)
        if get(apu_fail_egt) == 0 and starting and get(apu_oil_t) > 150 then
            set(apu_fail_egt, 1)
            set(apu_fail, 1)
        end

        -- *** Stochastic/random failures: run every 15–30 seconds ***
        if fail_timer >= next_check then
            fail_timer = 0
            next_check = math.random(15, 30)

            if get(apu_start_fail) == 0 then
                set(apu_start_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3))
            end
            if get(apu_gen_fail) == 0 then
                set(apu_gen_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3))
            end
            if get(apu_fail) == 0 then
                set(apu_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3))
            end
            -- Increased probability of total APU failure if runtime exceeded
            if get(apu_runtime) == 0 and get(apu_fail) == 0 then
                set(apu_fail, bool2int(math.random() < 0.01 * FAIL * 0.3))
            end
        end
    else
        -- Reset all failures when system is disabled
        fail_timer = 0
        set(apu_start_fail,     0)
        set(apu_gen_fail,       0)
        set(apu_fail_oilt,      0)
        set(apu_fail_egt,       0)
        set(apu_fail_fuel_left, 0)
        set(apu_fail,           0)
        set(apu_press_fail,     0)
    end
end
