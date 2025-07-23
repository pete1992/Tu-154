-- brake_system.lua
-- Complete brake system simulation for Tu-154M

-- Smart Copilot
-- Master: 0 = plugin not found, 1 = slave, 2 = master
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))
-- Have control: 0 = plugin not found, 1 = no control, 2 = has control
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

-- Bulk DataRef registration
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
	{"brake_heat_left", "tu154ce/failures/brake_heat_left", globalPropertyf},
	{"brake_heat_right", "tu154ce/failures/brake_heat_right", globalPropertyf},
	{"brake_runtime_left",  "tu154ce/failures/brake_runtime_left", globalPropertyf},
	{"brake_runtime_right", "tu154ce/failures/brake_runtime_right", globalPropertyf},
	{"gear2_deploy", "sim/flightmodel2/gear/deploy_ratio[1]", globalProperty},
	{"gear3_deploy", "sim/flightmodel2/gear/deploy_ratio[2]", globalProperty},
	{"speed", "sim/flightmodel/position/true_airspeed", globalPropertyf},
	{"gear_vent_set", "tu154ce/switchers/eng/gear_fan", globalPropertyi},
	{"xplane_version", "sim/version/xplane_internal_version", globalPropertyi},
    {"have_pedals", "tu154ce/have_pedals", globalPropertyi},
    -- Hydraulics
    {"gs_press_1", "tu154ce/hydro/gs_press_1", globalPropertyf},
    {"gs_press_2", "tu154ce/hydro/gs_press_2", globalPropertyf},
    {"gs_press_3", "tu154ce/hydro/gs_press_3", globalPropertyf},
    {"gs_press_4", "tu154ce/hydro/gs_press_4", globalPropertyf},
    -- Timing
    {"frame_time", "tu154ce/time/frame_time", globalPropertyf},
    -- Sim brakes
    {"l_brake_add", "sim/flightmodel/controls/l_brake_add", globalPropertyf},
    {"r_brake_add", "sim/flightmodel/controls/r_brake_add", globalPropertyf},
    {"parkbrake", "sim/flightmodel/controls/parkbrake", globalPropertyf},
    {"parkbrake_2", "sim/cockpit2/controls/parking_brake_ratio", globalPropertyf},
    -- Controls & animation
    {"gear_blocks", "tu154ce/anim/gear_blocks", globalPropertyf},
    {"brake_emerg", "tu154ce/controlls/brake_emerg", globalPropertyf},
    {"brake_emerg_L", "tu154ce/controlls/brake_emerg_L", globalPropertyf},
    {"brake_emerg_R", "tu154ce/controlls/brake_emerg_R", globalPropertyf},
    {"parking_brake", "tu154ce/controll/parking_brake", globalPropertyi},
    {"brake_L", "tu154ce/controlls/brake_L", globalPropertyf},
    {"brake_R", "tu154ce/controlls/brake_R", globalPropertyf},
    {"int_brakes_L", "tu154ce/brakes/int_brakes_L", globalPropertyf},
    {"int_brakes_R", "tu154ce/brakes/int_brakes_R", globalPropertyf},
    {"overr", "sim/operation/override/override_gearbrake", globalPropertyi},
    -- Failures
    {"rel_lbrakes", "sim/operation/failures/rel_lbrakes", globalPropertyi},
    {"rel_rbrakes", "sim/operation/failures/rel_rbrakes", globalPropertyi},
    {"failures_enabled", "tu154ce/failures/failures_enabled", globalPropertyi},
})

-- Helper: boolean to int conversion
local function bool2int(val)
    return val and 1 or 0
end

-- Temperature coefficient for brake fade simulation
local termo_coef = {
    {0, 1},
    {100, 1.5},
    {200, 2},
    {300, 5},
    {1000, 50},
    {1000000, 500}
}

-- Local DataRefs for joystick brake axes
local joy_work_L = globalProperty("sim/joystick/joy_mapped_axis_avail[6]")
local joy_work_R = globalProperty("sim/joystick/joy_mapped_axis_avail[7]")
local joy_value_L = globalProperty("sim/joystick/joy_mapped_axis_value[6]")
local joy_value_R = globalProperty("sim/joystick/joy_mapped_axis_value[7]")

-- Sound samples for parking brake lever
local brake_hnd_on = loadSample('Custom Sounds/parking_on.wav')
local brake_hnd_off = loadSample('Custom Sounds/parking_off.wav')

-- State variables
set(brake_runtime_left, 1)
set(brake_runtime_right, 1)
set(parking_brake, 1)
set(overr, 1)
set(joy_value_L, 0)
set(joy_value_R, 0)

local park_lever_last = get(parking_brake)
local e_brake_last = get(brake_emerg)
local left_brk = 0
local right_brk = 0
local sim_brake = 0
local passed = 0
local termo_left = get(brake_heat_left)
local termo_right = get(brake_heat_right)
local fail_counter = 0
local check_time = math.random(15, 30)
local resetTimer = 0

-- Register all relevant command handlers (unchanged)
regular_brk_comm = findCommand("sim/flight_controls/brakes_regular")
max_brk_comm = findCommand("sim/flight_controls/brakes_max")
park_brk_max_comm = findCommand("sim/flight_controls/brakes_toggle_max")
park_brk_reg_comm = findCommand("sim/flight_controls/brakes_toggle_regular")
local left_brk_cmd = findCommand("sim/flight_controls/left_brake")
local right_brk_cmd = findCommand("sim/flight_controls/right_brake")

function regular_brk_hnd(phase)
    if 1 == phase then
        set(parking_brake, 0)
        sim_brake = sim_brake + passed * 2
        if sim_brake > 1 then sim_brake = 1 end
    else
        sim_brake = 0
        if get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
    end
    return 0
end
registerCommandHandler(regular_brk_comm, 0, regular_brk_hnd)

function max_brk_hnd(phase)
    if 1 == phase then
        set(parking_brake, 0)
        sim_brake = sim_brake + passed * 4
        if sim_brake > 1 then sim_brake = 1 end
    else
        sim_brake = 0
        if get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
    end
    return 0
end
registerCommandHandler(max_brk_comm, 0, max_brk_hnd)

function park_brk_max_hnd(phase)
    if 0 == phase then
        local brk = 1 - get(parking_brake)
        if brk == 0 and get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
        set(parking_brake, brk)
    end
    return 0
end
registerCommandHandler(park_brk_max_comm, 0, park_brk_max_hnd)

function park_brk_reg_hnd(phase)
    if 0 == phase then
        local brk = 1 - get(parking_brake)
        if brk == 0 and get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0)
            set(r_brake_add, 0)
        end
        set(parking_brake, brk)
    end
    return 0
end
registerCommandHandler(park_brk_reg_comm, 0, park_brk_reg_hnd)

function left_brk_cmd_hnd(phase)
    if 1 == phase then
        left_brk = left_brk + passed * 2
        if left_brk > 1 then left_brk = 1 end
        set(parking_brake, 0)
    else
        left_brk = 0
    end
    return 0
end

function right_brk_cmd_hnd(phase)
    if 1 == phase then
        right_brk = right_brk + passed * 2
        if right_brk > 1 then right_brk = 1 end
        set(parking_brake, 0)
    else
        right_brk = 0
    end
    return 0
end
registerCommandHandler(left_brk_cmd, 0, left_brk_cmd_hnd)
registerCommandHandler(right_brk_cmd, 0, right_brk_cmd_hnd)

function interpolate(tbl, x)
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
    passed = get(frame_time)
    local brake_1 = get(joy_value_L)
    local brake_2 = get(joy_value_R)
    local park_lvr = get(parking_brake)
    local e_brake = get(brake_emerg)

    -- Reset pedals when parking brake is released
    if (park_lever_last ~= park_lvr and park_lvr == 0) then
        brake_1 = 0
        brake_2 = 0
    end

    -- Play parking brake lever sounds
    if park_lever_last ~= park_lvr then
        if park_lvr == 1 then if get(xplane_version) < 120000 then playSample(brake_hnd_on, false) end
        else if get(xplane_version) < 120000 then playSample(brake_hnd_off, false) end end
    end

    park_lever_last = park_lvr
    e_brake_last = e_brake

    local blocks = get(gear_blocks)
    local main_press = math.min(get(gs_press_1) / 120, 1)
    local emer_press = math.min(get(gs_press_4) / 120, 1)

    local left_blake = math.max(brake_1 * main_press, sim_brake * main_press, left_brk * main_press)
    local right_blake = math.max(brake_2 * main_press, sim_brake * main_press, right_brk * main_press)
    local park = math.max(blocks * 5, e_brake * emer_press, park_lvr * main_press)

    if left_blake < 0.07 then left_blake = 0 end
    if right_blake < 0.07 then right_blake = 0 end

    -- Failures logic
    left_blake = left_blake * bool2int(get(rel_lbrakes) ~= 6)
    right_blake = right_blake * bool2int(get(rel_rbrakes) ~= 6)

    if get(ismaster) ~= 1 then
        local FAIL = get(failures_enabled)
        FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)

        if FAIL > 0 then
            fail_counter = fail_counter + passed
            if fail_counter > check_time then
                fail_counter = 0
                check_time = math.random(15, 30)
                if get(rel_lbrakes) ~= 1 then set(rel_lbrakes, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_rbrakes) ~= 1 then set(rel_rbrakes, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(brake_runtime_left) == 0 and left_blake > 0.1 then
                    if get(rel_lbrakes) ~= 1 then set(rel_lbrakes, bool2int(math.random() < 0.1) * 6) end
                end
                if get(brake_runtime_right) == 0 and right_blake > 0.1 then
                    if get(rel_rbrakes) ~= 1 then set(rel_rbrakes, bool2int(math.random() < 0.1) * 6) end
                end
            end

            if get(gear2_deploy) > 0.05 then
                set(brake_runtime_left, math.max(0, get(brake_runtime_left) - passed * left_blake * get(speed) * 0.00002 * interpolate(termo_coef, math.max(0, termo_left))))
            end
            if get(gear3_deploy) > 0.05 then
                set(brake_runtime_right, math.max(0, get(brake_runtime_right) - passed * right_blake * get(speed) * 0.00002 * interpolate(termo_coef, math.max(0, termo_right))))
            end

        else
            set(brake_runtime_left, 1)
            set(brake_runtime_right, 1)
            set(rel_lbrakes, 0)
            set(rel_rbrakes, 0)
        end
    end

	-- Calculate the average brake temperature for fade simulation
	local thermo = (get(brake_heat_left) + get(brake_heat_right)) * 0.5

    termo_left = termo_left + left_blake * get(speed) * 0.9 * bool2int(get(gear2_deploy) > 0.05) * passed
    termo_left = termo_left + (thermo - termo_left) * passed * (1 + get(gear_vent_set) * 4) * 0.01

    termo_right = termo_right + right_blake * get(speed) * 0.9 * bool2int(get(gear3_deploy) > 0.05) * passed
    termo_right = termo_right + (thermo - termo_right) * passed * (1 + get(gear_vent_set) * 4) * 0.01

    set(brake_heat_left, termo_left)
    set(brake_heat_right, termo_right)

    local have_control = get(hascontrol_1) ~= 1
    if have_control then
        set(l_brake_add, left_blake)
        set(r_brake_add, right_blake)
        set(int_brakes_L, math.max(left_blake, park))
        set(int_brakes_R, math.max(right_blake, park))
        set(parkbrake, park)
        set(parkbrake_2, park)
        if brake_1 > 0.8 and brake_2 > 0.8 then set(parking_brake, 0) end
    end

    set(brake_L, math.max(left_blake, brake_1, park_lvr))
    set(brake_R, math.max(right_blake, brake_2, park_lvr))
end

function onAvionicsDone()
    set(overr, 0)
end
