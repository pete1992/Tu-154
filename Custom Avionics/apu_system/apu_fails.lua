-- apu_fails.lua

-- Helper to register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register DataRefs
defineProps({
    {"failures_enabled",       "tu154ce/failures/failures_enabled",       globalPropertyi},
    {"frame_time",             "tu154ce/time/frame_time",                 globalPropertyf},
    {"ismaster",               "scp/api/ismaster",                           globalPropertyf},
    {"apu_start_fail",         "tu154ce/failures/apu_start_fail",         globalPropertyi},
    {"apu_gen_fail",           "tu154ce/failures/apu_gen_fail",           globalPropertyi},
    {"apu_runtime",            "tu154ce/failures/apu_runtime",            globalPropertyf},
    {"apu_fail_oilt",          "tu154ce/failures/apu_fail_oilt",          globalPropertyi},
    {"apu_fail_egt",           "tu154ce/failures/apu_fail_egt",           globalPropertyi},
    {"apu_fail_fuel_left",     "tu154ce/failures/apu_fail_fuel_left",     globalPropertyi},
    {"apu_fail",               "tu154ce/failures/apu_fail",               globalPropertyi},
    {"apu_press_fail",         "tu154ce/failures/apu_press_fail",         globalPropertyi},
})

-- Convert boolean to integer
local function bool2int(b) return b and 1 or 0 end

-- Internal state
local fail_counter = 0
local check_time   = math.random(15, 30)

function update()
    local dt = get(frame_time)

    -- do nothing on master instance
    if get(ismaster) == 1 then
        fail_counter = 0
        return
    end

    local F    = get(failures_enabled)
    local prob = F * 0.05 * 4^(F * 0.5)

    if prob > 0 then
        -- accumulate time until next failure check
        fail_counter = fail_counter + dt
        if fail_counter > check_time then
            fail_counter = 0
            check_time   = math.random(15, 30)
            -- attempt random APU failures
            local function tryFail(ref, scale)
                if get(ref) ~= 1 and math.random() < 1e-5 * prob * scale then
                    set(ref, 1)
                end
            end
            tryFail(apu_start_fail,     0.3)
            tryFail(apu_gen_fail,       0.3)
            tryFail(apu_fail_oilt,      0.3)
            tryFail(apu_fail_egt,       0.3)
            tryFail(apu_fail_fuel_left, 0.3)
            tryFail(apu_fail,           0.3)
            tryFail(apu_press_fail,     0.3)
            -- additional failure if APU not running
            if get(apu_runtime) == 0 then
                tryFail(apu_fail, 0.01)
            end
        end
    else
        -- reset all failures when disabled
        fail_counter = 0
        for _, ref in ipairs({
            apu_start_fail,
            apu_gen_fail,
            apu_fail_oilt,
            apu_fail_egt,
            apu_fail_fuel_left,
            apu_fail,
            apu_press_fail
        }) do
            set(ref, 0)
        end
    end
end
