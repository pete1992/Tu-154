-- asu.lua
-- TA-6A ground power unit (ASU) logic for Tu-154M

-- Bulk DataRef registration
local function defineProps(defs)
    for _, d in ipairs(defs) do
        _G[d[1]] = d[3](d[2])
    end
end

defineProps({
    {"rpm", "tu154ce/asu/rpm", globalPropertyf},                -- ASU RPM
    {"air_press", "tu154ce/asu/press", globalPropertyf},        -- ASU air pressure
    {"work", "tu154ce/asu/work", globalPropertyi},              -- ASU work state
    {"sim_period", "sim/operation/misc/frame_rate_period", globalPropertyf}, -- Frame period
    {"GS", "sim/flightmodel/position/groundspeed", globalPropertyf},         -- Ground speed
    {"show", "tu154ce/anim/asu_show", globalPropertyf}          -- Show ASU animation
})

-- Helper: boolean to int
local function bool2int(val)
    return val and 1 or 0
end

local stopped = true

function update()
    local fps_factor = math.min(0.2, 0.1 * get(sim_period))
    if get(work) == 1 and get(GS) < 0.1 then
        set(show, 1)
        stopped = false
        if get(rpm) < 100 then
            set(rpm, get(rpm) + (100 - get(rpm)) * fps_factor)
        end
        local bleed_valve = bool2int(get(rpm) > 90)
        set(air_press, bleed_valve * (get(air_press) + ((3.8 - get(air_press)) * 0.1 * get(sim_period))))
    else    
        if get(GS) > 0.1 then stopped = true end
        if not stopped then
            set(rpm, get(rpm) - (100 - get(rpm)) * 1 * get(sim_period))
            local bleed_valve = bool2int(get(rpm) > 90)
            if get(rpm) < 0.1 then stopped = true end
            return
        end
        set(rpm, 0)
        set(show, 0)
        set(air_press, 0)
        set(work, 0)
    end
end
