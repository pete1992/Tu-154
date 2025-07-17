-- brake_system.lua

-- Smartcopilot
defineProperty("ismaster",   globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1",globalPropertyf("scp/api/hascontrol_1"))

-- Bulk DataRef definitions
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    {"have_pedals",         "sim/custom/have_pedals",                           globalPropertyi},
    {"gs_press_1",          "sim/custom/hydro/gs_press_1",                      globalPropertyf},
    {"gs_press_2",          "sim/custom/hydro/gs_press_2",                      globalPropertyf},
    {"gs_press_3",          "sim/custom/hydro/gs_press_3",                      globalPropertyf},
    {"gs_press_4",          "sim/custom/hydro/gs_press_4",                      globalPropertyf},
    {"frame_time",          "sim/custom/time/frame_time",                       globalPropertyf},
    {"l_brake_add",         "sim/flightmodel/controls/l_brake_add",             globalPropertyf},
    {"r_brake_add",         "sim/flightmodel/controls/r_brake_add",             globalPropertyf},
    {"parkbrake",           "sim/flightmodel/controls/parkbrake",               globalPropertyf},
    {"parkbrake_2",         "sim/cockpit2/controls/parking_brake",              globalPropertyf},
    {"l_brake_add_2",       "sim/cockpit2/controls/left_brake_ratio",           globalPropertyf},
    {"r_brake_add_2",       "sim/cockpit2/controls/right_brake_ratio",          globalPropertyf},
    {"gear_blocks",         "sim/custom/anim/gear_blocks",                      globalPropertyf},
    {"brake_emerg",         "sim/custom/controlls/brake_emerg",                 globalPropertyf},
    {"brake_emerg_L",       "sim/custom/controlls/brake_emerg_L",               globalPropertyf},
    {"brake_emerg_R",       "sim/custom/controlls/brake_emerg_R",               globalPropertyf},
    {"parking_brake",       "sim/custom/controll/parking_brake",                globalPropertyi},
    {"brake_L",             "sim/custom/controlls/brake_L",                     globalPropertyf},
    {"brake_R",             "sim/custom/controlls/brake_R",                     globalPropertyf},
    {"int_brakes_L",        "sim/custom/brakes/int_brakes_L",                   globalPropertyf},
    {"int_brakes_R",        "sim/custom/brakes/int_brakes_R",                   globalPropertyf},
    {"overr",               "sim/operation/override/override_gearbrake",        globalPropertyi},
    {"brake_heat_left",     "sim/custom/failures/brake_heat_left",              globalPropertyf},
    {"brake_heat_right",    "sim/custom/failures/brake_heat_right",             globalPropertyf},
    {"brake_runtime_left",  "sim/custom/failures/brake_runtime_left",           globalPropertyf},
    {"brake_runtime_right", "sim/custom/failures/brake_runtime_right",          globalPropertyf},
    {"rel_lbrakes",         "sim/operation/failures/rel_lbrakes",               globalPropertyi},
    {"rel_rbrakes",         "sim/operation/failures/rel_rbrakes",               globalPropertyi},
    {"failures_enabled",    "sim/custom/failures/failures_enabled",            globalPropertyi},
    {"speed",               "sim/flightmodel/position/groundspeed",             globalPropertyf},
    {"thermo",              "sim/cockpit2/temperature/outside_air_temp_degc",   globalPropertyf},
    {"gear_vent_set",       "sim/custom/switchers/eng/gear_fan",                globalPropertyi},
    {"gear2_deflect",       "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalPropertyf},
    {"gear3_deflect",       "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalPropertyf},
})

-- Helper functions
local function bool2int(v) return v and 1 or 0 end

local function interpolate(tbl, x)
    if x <= tbl[1][1] then
        return tbl[1][2]
    end
    for i = 1, #tbl - 1 do
        local x0, y0 = tbl[i][1], tbl[i][2]
        local x1, y1 = tbl[i+1][1], tbl[i+1][2]
        if x <= x1 then
            local t = (x - x0) / (x1 - x0)
            return y0 + (y1 - y0) * t
        end
    end
    return tbl[#tbl][2]
end

-- Initial settings
set(brake_runtime_left,  1)
set(brake_runtime_right, 1)

-- Temperature coefficient table for brake wear
local termo_coef = {
    {    0,    1},
    {  100,  1.5},
    {  200,    2},
    {  300,    5},
    { 1000,   50},
    {1e6,    500},
}

-- Joystick axis mapping arrays
local axies_asgn = {}
local axies_val  = {}
local axies_inv  = {}
for i = 0, 500 do
    axies_asgn[i+1] = globalPropertyi("sim/joystick/joystick_axis_assignments["..i.."]")
    axies_val[i+1]  = globalPropertyf("sim/joystick/joystick_axis_values["..i.."]")
    axies_inv[i+1]  = globalPropertyf("sim/joystick/joystick_axis_reverse["..i.."]")
end

local joy_work_L = globalPropertyi("sim/joystick/joy_mapped_axis_avail[6]")
local joy_work_R = globalPropertyi("sim/joystick/joy_mapped_axis_avail[7]")
local joy_value_L = globalPropertyf("sim/joystick/joy_mapped_axis_value[6]")
local joy_value_R = globalPropertyf("sim/joystick/joy_mapped_axis_value[7]")
local left_pedal_num, right_pedal_num

-- Detect which axes are assigned to left/right pedals
local function find_pedals()
    for i = 0, 500 do
        local a = get(axies_asgn[i+1])
        if not left_pedal_num  and a == 6 then left_pedal_num  = i+1 end
        if not right_pedal_num and a == 7 then right_pedal_num = i+1 end
        if left_pedal_num and right_pedal_num then break end
    end
end

-- Initialize brake handle commands
local sim_brake = 0
local passed    = 0
local comm_brake = 0

local reg_cmd = findCommand("sim/flight_controls/brakes_regular")
local max_cmd = findCommand("sim/flight_controls/brakes_max")
local park_max = findCommand("sim/flight_controls/brakes_toggle_max")
local park_reg = findCommand("sim/flight_controls/brakes_toggle_regular")
local left_cmd = findCommand("sim/flight_controls/left_brake")
local right_cmd= findCommand("sim/flight_controls/right_brake")

-- Brake handle callbacks
local function regular_brk_hnd(phase)
    if phase == 1 then
        set(parking_brake, 0)
        sim_brake = math.min(1, sim_brake + passed * 2)
    else
        sim_brake = 0
        if get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0); set(r_brake_add, 0)
        end
    end
    return 0
end
registerCommandHandler(reg_cmd, 0, regular_brk_hnd)

local function max_brk_hnd(phase)
    if phase == 1 then
        set(parking_brake, 0)
        sim_brake = math.min(1, sim_brake + passed * 4)
    else
        sim_brake = 0
        if get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0); set(r_brake_add, 0)
        end
    end
    return 0
end
registerCommandHandler(max_cmd, 0, max_brk_hnd)

local function park_toggle_hnd(phase)
    if phase == 0 then
        local b = 1 - get(parking_brake)
        if b == 0 and get(hascontrol_1) ~= 1 then
            set(l_brake_add, 0); set(r_brake_add, 0)
        end
        set(parking_brake, b)
    end
    return 0
end
registerCommandHandler(park_max, 0, park_toggle_hnd)
registerCommandHandler(park_reg, 0, park_toggle_hnd)

local left_brk, right_brk = 0, 0
local function left_brk_hnd(phase)
    left_brk = (phase == 1) and math.min(1, left_brk + passed * 2) or 0
    if phase == 1 then set(parking_brake, 0) end
    return 0
end
local function right_brk_hnd(phase)
    right_brk = (phase == 1) and math.min(1, right_brk + passed * 2) or 0
    if phase == 1 then set(parking_brake, 0) end
    return 0
end
registerCommandHandler(left_cmd, 0, left_brk_hnd)
registerCommandHandler(right_cmd, 0, right_brk_hnd)

-- update loop, heat & failures, final wiring

-- Persistent state
local park_lever_last = get(parking_brake)
local left_pedal_num, right_pedal_num
local axisCheckTimer, fail_counter, check_time = 0, 0, math.random(15,30)
local resetTimer = 0
local termo_left, termo_right = get(thermo), get(thermo)

-- Main update
function update()
    passed = get(frame_time)

    -- Re-detect pedals every 5s
    axisCheckTimer = axisCheckTimer + passed
    if axisCheckTimer > 5 then
        left_pedal_num, right_pedal_num = nil, nil
        find_pedals()
        axisCheckTimer = 0
    end

    -- Read joystick pedals
    local brake_1 = get(joy_value_L)
    if left_pedal_num then
        brake_1 = get(axies_val[left_pedal_num])
        if get(axies_inv[left_pedal_num]) == 1 then brake_1 = 1 - brake_1 end
    end
    local brake_2 = get(joy_value_R)
    if right_pedal_num then
        brake_2 = get(axies_val[right_pedal_num])
        if get(axies_inv[right_pedal_num]) == 1 then brake_2 = 1 - brake_2 end
    end

    -- Parking brake toggle sound & reset foot brakes
    local park_lvr = get(parking_brake)
    local e_brake  = get(brake_emerg)
    if park_lvr ~= park_lever_last then
        playSample(park_lvr==1 and brake_hnd_on or brake_hnd_off, 0)
        if park_lvr == 0 then brake_1, brake_2 = 0, 0 end
    end
    park_lever_last = park_lvr

    -- Compute brake pressures
    local blocks     = get(gear_blocks)
    local main_press = math.min(get(gs_press_1)/120, 1)
    local emer_press = math.min(get(gs_press_4)/120, 1)
    local left_blake = math.max(brake_1*main_press, sim_brake*main_press, left_brk*main_press)
    local right_blake= math.max(brake_2*main_press, sim_brake*main_press, right_brk*main_press)
    local park_press = math.max(blocks*5, e_brake*emer_press, park_lvr*main_press)
    if left_blake < 0.07 then left_blake = 0 end
    if right_blake< 0.07 then right_blake= 0 end
    left_blake  = left_blake  * bool2int(get(rel_lbrakes) ~= 6)
    right_blake = right_blake * bool2int(get(rel_rbrakes) ~= 6)

    -- Failure and runtime logic
    if get(ismaster) ~= 1 then
        local FAIL = get(failures_enabled)
        FAIL = FAIL * 0.05 * 4^(FAIL * 0.5)
        if FAIL > 0 then
            fail_counter = fail_counter + passed
            if fail_counter > check_time then
                fail_counter = 0
                check_time = math.random(15,30)
                if get(rel_lbrakes) ~= 1 then
                    set(rel_lbrakes, bool2int(math.random() < 1e-5 * FAIL * 0.3) * 6)
                end
                if get(rel_rbrakes) ~= 1 then
                    set(rel_rbrakes, bool2int(math.random() < 1e-5 * FAIL * 0.3) * 6)
                end
            end
            if get(gear2_deflect) > 0.05 then
                set(brake_runtime_left,
                    math.max(0,
                        get(brake_runtime_left)
                        - passed * left_blake * get(speed) * 0.00002
                          * interpolate(termo_coef, termo_left)
                    )
                )
            end
            if get(gear3_deflect) > 0.05 then
                set(brake_runtime_right,
                    math.max(0,
                        get(brake_runtime_right)
                        - passed * right_blake * get(speed) * 0.00002
                          * interpolate(termo_coef, termo_right)
                    )
                )
            end
        else
            set(brake_runtime_left,  1)
            set(brake_runtime_right, 1)
            set(rel_lbrakes,        0)
            set(rel_rbrakes,        0)
        end
    end

    -- Update brake heat
    termo_left  = termo_left  + left_blake  * get(speed) * 0.9 * bool2int(get(gear2_deflect)>0.05) * passed
    termo_left  = termo_left  + (get(thermo) - termo_left) * passed * (1 + get(gear_vent_set)*4) * 0.01
    termo_right = termo_right + right_blake * get(speed) * 0.9 * bool2int(get(gear3_deflect)>0.05) * passed
    termo_right = termo_right + (get(thermo) - termo_right)* passed * (1 + get(gear_vent_set)*4) * 0.01
    set(brake_heat_left,  termo_left)
    set(brake_heat_right, termo_right)

    -- Apply brakes if we have control
    if get(hascontrol_1) ~= 1 then
        set(l_brake_add, left_blake)
        set(r_brake_add, right_blake)
        set(int_brakes_L, math.max(left_blake, park_press))
        set(int_brakes_R, math.max(right_blake, park_press))
        set(parkbrake,    park_press)
        set(parkbrake_2,  park_press)
        if brake_1 > 0.8 and brake_2 > 0.8 then
            set(parking_brake, 0)
        end
    end

    -- Final outputs
    set(brake_L, math.max(left_blake, brake_1, park_lever_last))
    set(brake_R, math.max(right_blake, brake_2, park_lever_last))

    -- Reset joystick mapping if no pedals detected
    resetTimer = (get(have_pedals)==1) and (resetTimer + passed) or 0
    if resetTimer > 5 then
        for i = 1, #axies_asgn do
            set(axies_asgn[i], 0)
            set(axies_inv[i],  0)
        end
        resetTimer = 0
    end
end

-- Called when avionics are done
function onAvionicsDone()
    set(overr, 0)
end
