-- landing_gears.lua 
-- Landing gear extend/retract logic for Tu-154M | X-Plane 12 | SASL 3.19+

-- Utility functions
local function clamp(x, minv, maxv)
    if x < minv then return minv end
    if x > maxv then return maxv end
    return x
end
local function bool2int(b) return b and 1 or 0 end
local function getArr(dref, idx)
    local v = get(dref)
    if type(v) == "table" then return v[idx+1] or 0 else return 0 end
end

-- Batch DataRef definitions
local props = {
    -- Hydraulics & timing
    {"gs_press_1",    "tu154ce/hydro/gs_press_1",             "f"},
    {"gs_press_2",    "tu154ce/hydro/gs_press_2",             "f"},
    {"gs_press_3",    "tu154ce/hydro/gs_press_3",             "f"},
    {"frame_time",    "tu154ce/time/frame_time",              "f"},
    -- Controls & switches
    {"gears_retr_lock","tu154ce/switchers/gears_retr_lock",  "i"},
    {"gears_ext_3GS", "tu154ce/switchers/gears_ext_3GS",      "i"},
    {"emerg_gear_ext","tu154ce/controll/emerg_gear_ext",      "i"},
    {"gear_lever",    "tu154ce/controll/gear_lever",          "i"},
    {"gear_handle_1", "sim/cockpit/switches/gear_handle_status","i"},
    {"gear_handle_2", "sim/cockpit2/controls/gear_handle_down","i"},
    -- Gear positions & deflections (as arrays!)
    {"gear_deflect_arr","sim/flightmodel2/gear/tire_vertical_deflection_mtr","f"},
    {"gear1_deploy","sim/aircraft/parts/acf_gear_deploy[0]","f"},
    {"gear2_deploy","sim/aircraft/parts/acf_gear_deploy[1]","f"},
    {"gear3_deploy","sim/aircraft/parts/acf_gear_deploy[2]","f"},
    -- Environment & indicators
    {"airspeed",     "sim/flightmodel/position/indicated_airspeed","f"},
    {"total_time",   "sim/time/total_flight_time_sec","f"},
    {"agl",          "sim/flightmodel/position/y_agl","f"},
    {"G",            "sim/flightmodel2/misc/gforce_normal","f"},
    -- Failures
    {"retract1_fail","sim/operation/failures/rel_lagear1","i"},
    {"retract2_fail","sim/operation/failures/rel_lagear2","i"},
    {"retract3_fail","sim/operation/failures/rel_lagear3","i"},
    {"actuator_fail","sim/operation/failures/rel_gear_act","i"},
    {"rel_wing1L",   "sim/operation/failures/rel_wing1L","i"},
    {"rel_wing1R",   "sim/operation/failures/rel_wing1R","i"},
    {"rel_collapse1","sim/operation/failures/rel_collapse1","i"},
    {"rel_collapse2","sim/operation/failures/rel_collapse2","i"},
    {"rel_collapse3","sim/operation/failures/rel_collapse3","i"},
    -- Electrical
    {"bus27_volt_left", "tu154ce/elec/bus27_volt_left","f"},
    {"bus27_volt_right","tu154ce/elec/bus27_volt_right","f"},
    -- SmartCopilot
    {"ismaster",     "scp/api/ismaster","f"},
    {"hascontrol_1", "scp/api/hascontrol_1","f"},
    -- X-Plane version (for sound)
    {"xplane_version","sim/aircraft/view/acf_version","f"},
}
for _, p in ipairs(props) do
    if p[3] == "f" then
        defineProperty(p[1], globalPropertyf(p[2]))
    else
        defineProperty(p[1], globalPropertyi(p[2]))
    end
end

-- Sounds & commands
local lock_sound   = loadSample('Custom Sounds/gear_lock.wav')
local handle_sound = loadSample('Custom Sounds/gear_lvr.wav')
local cmd_up       = findCommand("sim/flight_controls/landing_gear_up")
local cmd_down     = findCommand("sim/flight_controls/landing_gear_down")
local cmd_toggle   = findCommand("sim/flight_controls/landing_gear_toggle")

-- State
local last_time = get(frame_time)
local pos_front, pos_left, pos_right = 1, 1, 1
local lock_front, lock_left, lock_right = true, true, true
local last_lever = get(gear_lever)
local latch_front, latch_left, latch_right = lock_front, lock_left, lock_right

-- Command handlers
local function onGearUp(phase)
    if phase == 0 then
        local g = get(gear_lever)
        if g > -1 then set(gear_lever, g - 1) end
        set(gear_handle_1, 0)
        set(gear_handle_2, 0)
    end
    return 0
end
local function onGearDown(phase)
    if phase == 0 then
        local g = get(gear_lever)
        if g < 1 then set(gear_lever, g + 1) end
        set(gear_handle_1, 1)
        set(gear_handle_2, 1)
    end
    return 0
end
local function onGearToggle(phase)
    if phase == 0 then
        local g = get(gear_lever)
        if g ~= 0 then
            set(gear_handle_1, bool2int(g == 1))
            set(gear_handle_2, bool2int(g == 1))
            g = 0
        else
            if get(gear1_deploy) > 0.7 then g = -1
            elseif get(gear1_deploy) < 0.3 then g = 1 end
            set(gear_handle_1, bool2int(g == 1))
            set(gear_handle_2, bool2int(g == 1))
        end
        set(gear_lever, g)
    end
    return 0
end

registerCommandHandler(cmd_up,     0, onGearUp)
registerCommandHandler(cmd_down,   0, onGearDown)
registerCommandHandler(cmd_toggle, 0, onGearToggle)

-- Update loop
function update()
    -- Delta time
    local now = get(frame_time)
    local dt  = now - last_time
    last_time = now

    -- SmartCopilot master or plugin not present: allow write
    local sc     = get(ismaster)
    local MASTER = (sc == 2) or (sc == 0)

    -- Inputs and environment cache
    local lever    = get(gear_lever)
    local pL       = get(bus27_volt_left)  > 13
    local pR       = get(bus27_volt_right) > 13
    local h1       = math.min(get(gs_press_1)/100,1)
    local h2       = math.min(get(gs_press_2)/100,1)
    local h3       = math.min(get(gs_press_3)/100,1)
    local IAS2     = get(airspeed)^2

    -- Read gear deflection from array
    local gear1_deflect = getArr(gear_deflect_arr,0)
    local gear2_deflect = getArr(gear_deflect_arr,1)
    local gear3_deflect = getArr(gear_deflect_arr,2)

    -- Play handle sound if lever was changed
    if lever ~= last_lever and get(xplane_version) < 120000 then
        playSample(handle_sound, false)
    end
    last_lever = lever

    -- Allow retract logic
    local canRetract = (gear2_deflect < 0.01) and (get(gears_retr_lock) == 0)
    local use3GS     = get(gears_ext_3GS)

    -- Compute command for deployment direction & motion flag
    local dir = lever * (
          h1 * bool2int(not use3GS) * bool2int(pL) * 2
        + h3 * bool2int(    use3GS) * bool2int(pR) * 1.3
      ) + get(emerg_gear_ext) * h2 * 1.3
    local moving = bool2int((pL and not use3GS) or (pR and use3GS))

    -- GEAR MOTION
    -- Nose gear
    if not lock_front and canRetract then
        pos_front = pos_front + dt * 0.039 * (
            dir * bool2int(get(retract1_fail) < 6)
          + get(G) * (math.cos(math.pi*pos_front/4) + 0.2) * 0.08
          - IAS2    * math.sin(math.pi*pos_front/3) * 0.000025
        ) * moving
        if pos_front < 0 then pos_front,lock_front = 0,true
        elseif pos_front > 1 then pos_front,lock_front = 1,true end
    end
    -- Left main gear
    if not lock_left and canRetract then
        pos_left = pos_left + dt * 0.039 * (
            dir * bool2int(get(retract2_fail) < 6)
          + get(G) * (math.cos(math.pi*pos_left/5) + 0.3) * 0.08
          - IAS2    * math.sin(math.pi*pos_left/5) * 0.00003
        ) * moving
        if pos_left < 0 then pos_left,lock_left = 0,true
        elseif pos_left > 1 then pos_left,lock_left = 1,true end
    end
    -- Right main gear
    if not lock_right and canRetract then
        pos_right = pos_right + dt * 0.039 * (
            dir * bool2int(get(retract3_fail) < 6)
          + get(G) * (math.cos(math.pi*pos_right/5) + 0.3) * 0.08
          - IAS2    * math.sin(math.pi*pos_right/5) * 0.00003
        ) * moving
        if pos_right < 0 then pos_right,lock_right = 0,true
        elseif pos_right > 1 then pos_right,lock_right = 1,true end
    end

    -- Emergency extension override
    if get(emerg_gear_ext) == 1 then
        if pos_front < 0.9 then lock_front = false elseif pos_front > 0.99 then pos_front,lock_front = 1,true end
        if pos_left  < 0.9 then lock_left  = false elseif pos_left  > 0.99 then pos_left,lock_left   = 1,true end
        if pos_right < 0.9 then lock_right = false elseif pos_right > 0.99 then pos_right,lock_right = 1,true end
    end

    -- Collapse/separation failures
    if get(rel_collapse1)==6 then pos_front = 0.1 end
    if get(rel_collapse2)==6 then pos_left  = 0.1 end
    if get(rel_collapse3)==6 then pos_right = 0.1 end
    if get(rel_wing1L)   ==6 then pos_right = 0   end
    if get(rel_wing1R)   ==6 then pos_left  = 0   end

    -- Write-back or sync with sim/SmartCopilot
    if MASTER then
        set(gear1_deploy, clamp(pos_front,0,1))
        set(gear2_deploy, clamp(pos_left,0,1))
        set(gear3_deploy, clamp(pos_right,0,1))
    else
        pos_front, pos_left, pos_right = get(gear1_deploy), get(gear2_deploy), get(gear3_deploy)
    end

    -- Lock/unlock sounds
    if latch_front ~= lock_front then playSample(lock_sound, false) end
    if latch_left  ~= lock_left  then playSample(lock_sound, false) end
    if latch_right ~= lock_right then playSample(lock_sound, false) end
    latch_front, latch_left, latch_right = lock_front, lock_left, lock_right
end

-- Cleanup on plugin unload
function onAvionicsDone()
    set(gear1_deploy, 1)
    set(gear2_deploy, 1)
    set(gear3_deploy, 1)
    print("gears reset to down")
end
