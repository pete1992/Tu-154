-- nosewheel.lua
-- Nosewheel steering logic Tu-154M | X-Plane 12 | SASL 3.19+
-- Full batch DataRef, X-Plane array handling, safe for multiplayer and plugin pushback

local function getArr(dref, idx)
    local v = get(dref)
    if type(v) == "table" then return v[idx+1] or 0 else return 0 end
end
local function setArr(dref, idx, value)
    local v = get(dref)
    if type(v) == "table" then v[idx+1] = value; set(dref, v) end
end

-- DataRef batch setup (array-refs as full arrays!)
local props = {
    {"nosewheel_turn_enable", "tu154ce/switchers/nosewheel_turn_enable", globalPropertyi},
    {"nosewheel_turn_sel",    "tu154ce/switchers/nosewheel_turn_sel",    globalPropertyi},
    {"bus27_volt_left",       "tu154ce/elec/bus27_volt_left",            globalPropertyf},
    {"bus27_volt_right",      "tu154ce/elec/bus27_volt_right",           globalPropertyf},
    {"gs_press_2",            "tu154ce/hydro/gs_press_2",                globalPropertyf},
    {"have_pedals",           "tu154ce/have_pedals",                     globalPropertyi},
    {"override_wheel_steer",  "sim/operation/override/override_wheel_steer", globalPropertyi},
    {"weel_angle1",           "sim/aircraft/gear/acf_nw_steerdeg1",      globalPropertyf},
    {"weel_angle2",           "sim/aircraft/gear/acf_nw_steerdeg2",      globalPropertyf},
    {"lock",                  "sim/cockpit2/controls/nosewheel_steer_on",globalPropertyi},
    {"tire_steer_command_arr","sim/flightmodel2/gear/tire_steer_command_deg",globalPropertyf}, -- [10]
    {"tiller_avail",          "sim/joystick/joy_mapped_axis_avail[37]",  globalPropertyi},
    {"tiller_val",            "sim/joystick/joy_mapped_axis_value[37]",  globalPropertyf},
    {"joy_yaw",               "sim/cockpit2/controls/yoke_heading_ratio",globalPropertyf},
    {"tire_steer_actual_arr", "sim/flightmodel2/gear/tire_steer_actual_deg",globalPropertyf},  -- [10]
}
for _, d in ipairs(props) do defineProperty(d[1], d[3](d[2])) end

-- Optional: Pushback plugin support (safe pattern: just check after defineProperty, never use findDataRef)
local pushback = function() return false end
if pcall(function() return globalPropertyi("bp/connected") end) then
    defineProperty("bp_connected", globalPropertyi("bp/connected"))
    pushback = function() return get(bp_connected) == 1 end
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

    -- Choose input axis: Tiller, Yaw
    local steerInput
    if get(have_pedals) == 1 and get(tiller_avail)==1 then
        steerInput = get(tiller_val)
    else
        steerInput = get(joy_yaw)
    end

    -- Only drive if not pushback active
    if not pushback() then
        setArr(tire_steer_command_arr, 0, steerInput * get(weel_angle1))
    end
end

-- Toggle command for cockpit switch
local toggleCmd = findCommand and findCommand("sim/flight_controls/nwheel_steer_toggle")
function gear_toggle_handler(phase)
    if phase == 0 then
        set(nosewheel_turn_enable, 1 - get(nosewheel_turn_enable))
    end
    return 0
end
if toggleCmd and registerCommandHandler then
    registerCommandHandler(toggleCmd, 0, gear_toggle_handler)
end

function onAvionicsDone()
    set(override_wheel_steer, 0)
end
