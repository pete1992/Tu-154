-- asu_apu.lua
-- Handles TA-6A (ASU) APU RPM, air pressure, visibility, and start/stop behavior

-- Batch define DataRefs helper
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Define all properties at once
defineProps({
    {"rpm",        "tu154ce/asu/rpm",      globalPropertyf},
    {"air_press",  "tu154ce/asu/press",    globalPropertyf},
    {"work",       "tu154ce/asu/work",     globalPropertyi},
    {"GS",         "sim/flightmodel/position/groundspeed", globalPropertyf},
    {"show",       "tu154ce/anim/asu_show",               globalPropertyf},
    {"frame_time", "tu154ce/time/frame_time",             globalPropertyf}
})

-- Helper: boolean → integer
local function bool2int(b) return b and 1 or 0 end

-- Helpers: clamp and lerp
local function clamp(v,a,b) return v < a and a or (v > b and b or v) end
local function lerp(c,t,r,dt) return c + (t - c) * r * dt end

-- State
local state = {
    stopped = true,
}

-- Parameters
local RPM_TARGET    = 100
local RPM_IDLE_RATE = 1.0     -- per second when spinning down
local RPM_UP_RATE   = 0.1     -- fraction per dt when spinning up
local PRESS_TARGET  = 3.8
local GS_THRESHOLD  = 1.0     -- m/s threshold for “stationary”

function update()
    local dt    = get(frame_time)
    local curRPM = get(rpm)
    local curPR  = get(air_press)
    local isOn   = get(work) == 1
    local gs     = get(GS)

    if isOn and gs < GS_THRESHOLD then
        -- APU running at standstill
        set(show, 1)
        state.stopped = false

        -- Ramp RPM toward target
        if curRPM < RPM_TARGET then
            local upRate = math.min(RPM_UP_RATE, RPM_UP_RATE * dt)
            set(rpm, clamp(curRPM + (RPM_TARGET - curRPM) * upRate, 0, RPM_TARGET))
        end

        -- Bleed valve opens above 90%
        local bleed = bool2int(get(rpm) > 90)

        -- Build air pressure smoothly
        local pressDelta = (PRESS_TARGET - curPR) * 0.1 * dt
        set(air_press, clamp(bleed * (curPR + pressDelta), 0, PRESS_TARGET))

    else
        -- If aircraft moves, mark stopping
        if gs >= GS_THRESHOLD then
            state.stopped = true
        end

        if not state.stopped then
            -- Spin down before full stop
            local downDelta = curRPM * RPM_IDLE_RATE * dt
            set(rpm, clamp(curRPM - downDelta, 0, RPM_TARGET))
            return  -- wait until fully spun down
        end

        -- Fully stopped: reset everything
        set(rpm,      0)
        set(air_press,0)
        set(show,     0)
        -- leave `work` flag as-is or clear if desired:
        -- set(work, 0)
    end
end

