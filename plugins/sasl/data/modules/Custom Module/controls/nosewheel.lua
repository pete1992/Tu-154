-- nosewheel.lua
-- DataRefs (Batch for clarity/robustness)
local function defineProps(defs)
    for _, d in ipairs(defs) do defineProperty(d[1], d[3](d[2])) end
end

defineProps({
	 {"nosewheel_turn_enable", "tu154ce/switchers/nosewheel_turn_enable", globalPropertyi},
	 {"nosewheel_turn_sel", "tu154ce/switchers/nosewheel_turn_sel", globalPropertyi},
	 {"bus27_volt_left", "tu154ce/elec/bus27_volt_left", globalPropertyf},
	 {"bus27_volt_right", "tu154ce/elec/bus27_volt_right", globalPropertyf},
	 {"gs_press_2", "tu154ce/hydro/gs_press_2", globalPropertyf},
	 {"have_pedals", "tu154ce/have_pedals", globalPropertyi},
	 {"override_wheel_steer", "sim/operation/override/override_wheel_steer", globalPropertyi},
	 {"weel_angle1", "sim/aircraft/gear/acf_nw_steerdeg1", globalPropertyf},
	 {"weel_angle2", "sim/aircraft/gear/acf_nw_steerdeg2", globalPropertyf},
	 {"lock", "sim/cockpit2/controls/nosewheel_steer_on", globalPropertyi},
	 {"tire_steer_command_deg", "sim/flightmodel2/gear/tire_steer_command_deg[0]", globalPropertyf},
	 {"tiller_avail", "sim/joystick/joy_mapped_axis_avail[37]", globalPropertyi},
	 {"tiller_val", "sim/joystick/joy_mapped_axis_value[37]", globalPropertyf},
	 {"joy_yaw", "sim/cockpit2/controls/yoke_heading_ratio", globalPropertyf},
	 {"tire_steer_actual_deg", "sim/flightmodel2/gear/tire_steer_actual_deg[0]", globalPropertyf},
})

-- Option: menu-based steering source (0=tiller, 1=yaw/joystick) [if you use this!]
-- defineProperty("nosewheel_source", globalPropertyi("tu154ce/switchers/nosewheel_source"))

-- Optional: Pushback plugin support
local pushback = nil
if findDataRef("bp/connected") then
    defineProperty("bp_connected", globalPropertyi("bp/connected"))
    pushback = function() return get(bp_connected) == 1 end
else
    pushback = function() return false end
end

local get, set = get, set

function update()
    set(override_wheel_steer, 1) -- Always override for custom logic

    local press = math.min(get(gs_press_2) / 200, 1)
    local voltsOK = get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13
    local enabled = get(nosewheel_turn_enable) == 1

    -- Max steering angle: 10° (taxi) or 65° (sharp turn)
    local maxAngle = (get(nosewheel_turn_sel) == 0) and 10 or 65

    if voltsOK and enabled and press > 0.2 then
        set(lock, 1)
        set(weel_angle1, maxAngle * press)
        set(weel_angle2, maxAngle * press)
    else
        set(lock, 0)
        set(weel_angle1, 0)
        set(weel_angle2, 0)
    end

    -- Choose input axis: Tiller, Yaw, or menu setting
    local steerInput
    -- If you have a menu option for input source, use that here!
    -- if get(nosewheel_source) == 0 and get(tiller_avail)==1 then
    --     steerInput = get(tiller_val)
    -- else
    --     steerInput = get(joy_yaw)
    -- end

    -- Else: fallback on tiller if pedals detected, otherwise yaw
    if get(have_pedals) == 1 and get(tiller_avail)==1 then
        steerInput = get(tiller_val)
    else
        steerInput = get(joy_yaw)
    end

    -- Only drive if not pushback active
    if not pushback() then
        set(tire_steer_command_deg, steerInput * get(weel_angle1))
    end
end

-- Toggle command for cockpit switch
local toggleCmd = findCommand("sim/flight_controls/nwheel_steer_toggle")
function gear_toggle_handler(phase)
    if phase == 0 then
        set(nosewheel_turn_enable, 1 - get(nosewheel_turn_enable))
    end
    return 0
end
registerCommandHandler(toggleCmd, 0, gear_toggle_handler)

function onAvionicsDone()
    set(override_wheel_steer, 0)
end
