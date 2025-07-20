-- ext_anim.lua

-- Helper to clamp a value between min and max
function math.clamp(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

-- Helper for linear interpolation
function line(x, x1, y1, x2, y2)
    if x2 == x1 then return y1 end
    return y1 + (y2 - y1) * (x - x1) / (x2 - x1)
end

-- Helper to define multiple datarefs at once
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    {"frame_time",              "tu154ce/time/frame_time",                    globalPropertyf},
    {"replay_mode",             "sim/operation/prefs/replay_mode",               globalPropertyi},
    {"revers_L",                "tu154ce/controll/revers_L",                  globalPropertyf},
    {"revers_R",                "tu154ce/controll/revers_R",                  globalPropertyf},
    {"reverse_mid",             "tu154ce/anim/reverse_mid",                   globalPropertyf},
    {"front_pos",               "tu154ce/anim/lg/front_pos",                  globalPropertyf},
    {"front_defl",              "tu154ce/anim/lg/front_defl",                 globalPropertyf},
    {"front_turn",              "tu154ce/anim/lg/front_turn",                 globalPropertyf},
    {"main_pos_left",           "tu154ce/anim/lg/main_pos_left",              globalPropertyf},
    {"main_rot_left",           "tu154ce/anim/lg/main_rot_left",              globalPropertyf},
    {"main_pos_right",          "tu154ce/anim/lg/main_pos_right",             globalPropertyf},
    {"main_rot_right",          "tu154ce/anim/lg/main_rot_right",             globalPropertyf},
    {"rudder_anim",             "tu154ce/anim/rudder_anim",                   globalPropertyf},
    {"elev_anim_L",             "tu154ce/anim/elev_anim_L",                   globalPropertyf},
    {"elev_anim_R",             "tu154ce/anim/elev_anim_R",                   globalPropertyf},
    {"wing_flx_right",          "tu154ce/anim/wing_flx_right",                globalPropertyf},
    {"wing_flx_left",           "tu154ce/anim/wing_flx_left",                 globalPropertyf},
    {"cockpit_window_left",     "tu154ce/anim/cockpit_window_left",           globalPropertyf},
    {"cockpit_window_right",    "tu154ce/anim/cockpit_window_right",          globalPropertyf},
    {"cargo_1",                 "tu154ce/anim/cargo_1",                       globalPropertyf},
    {"cargo_2",                 "tu154ce/anim/cargo_2",                       globalPropertyf},
    {"pax_door_1",              "tu154ce/anim/pax_door_1",                    globalPropertyf},
    {"pax_door_2",              "tu154ce/anim/pax_door_2",                    globalPropertyf},
    {"pax_door_3",              "tu154ce/anim/pax_door_3",                    globalPropertyf},
    {"cockpit_door",            "tu154ce/anim/cockpit_door",                  globalPropertyf},
    {"cockpit_table_1",         "tu154ce/anim/cockpit_table_1",               globalPropertyf},
    {"cockpit_table_2",         "tu154ce/anim/cockpit_table_2",               globalPropertyf},
    {"rise_chair_arm_L",        "tu154ce/anim/rise_chair_arm_L",              globalPropertyf},
    {"rise_chair_arm_R",        "tu154ce/anim/rise_chair_arm_R",              globalPropertyf},
    {"yokes_show",              "tu154ce/anim/show_yokes",                    globalPropertyi},
    {"slider_1",                "sim/cockpit2/switches/custom_slider_on[0]",     globalPropertyf},
    {"slider_2",                "sim/cockpit2/switches/custom_slider_on[1]",     globalPropertyf},
    {"slider_3",                "sim/cockpit2/switches/custom_slider_on[2]",     globalPropertyf},
    {"slider_4",                "sim/cockpit2/switches/custom_slider_on[3]",     globalPropertyf},
    {"slider_5",                "sim/cockpit2/switches/custom_slider_on[4]",     globalPropertyf},
    {"slider_6",                "sim/cockpit2/switches/custom_slider_on[5]",     globalPropertyf},
    {"slider_7",                "sim/cockpit2/switches/custom_slider_on[6]",     globalPropertyf},
    {"slider_8",                "sim/cockpit2/switches/custom_slider_on[7]",     globalPropertyf},
    {"slider_9",                "sim/cockpit2/switches/custom_slider_on[8]",     globalPropertyf},
    {"slider_10",               "sim/cockpit2/switches/custom_slider_on[9]",     globalPropertyf},
    {"slider_11",               "sim/cockpit2/switches/custom_slider_on[10]",    globalPropertyf},
    {"slider_12",               "sim/cockpit2/switches/custom_slider_on[11]",    globalPropertyf},
    {"brake_emerg",             "tu154ce/controll/brake_emerg",               globalPropertyf},
    {"brake_emerg_L",           "tu154ce/controll/brake_emerg_L",             globalPropertyf},
    {"brake_emerg_R",           "tu154ce/controll/brake_emerg_R",             globalPropertyf},
    {"table_up_L",              "tu154ce/anim/table_up_L",                    globalPropertyi},
    {"table_up_R",              "tu154ce/anim/table_up_R",                    globalPropertyi},
    {"ground_stuff_angle",      "tu154ce/anim/ground_stuff_angle",            globalPropertyf},
    {"tire_steer_actual_deg",   "sim/flightmodel2/gear/tire_steer_actual_deg[0]",globalPropertyf},
    {"deploy_ratio_1",          "sim/flightmodel2/gear/deploy_ratio[0]",         globalPropertyf},
    {"deploy_ratio_2",          "sim/flightmodel2/gear/deploy_ratio[1]",         globalPropertyf},
    {"deploy_ratio_3",          "sim/flightmodel2/gear/deploy_ratio[2]",         globalPropertyf},
    {"deflection_mtr_1",        "sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]", globalPropertyf},
    {"deflection_mtr_2",        "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalPropertyf},
    {"deflection_mtr_3",        "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalPropertyf},
    {"groundspeed",             "sim/flightmodel/position/groundspeed",          globalPropertyf},
    {"yaw_apd",                 "sim/flightmodel/position/R",                    globalPropertyf},
    {"rudder",                  "sim/flightmodel/controls/vstab2_rud1def",       globalPropertyf},
    {"revers_flap_L",           "sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]", globalPropertyf},
    {"revers_flap_R",           "sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]", globalPropertyf},
    {"rpm_high_1",              "tu154ce/gauges/engine/rpm_high_1",           globalPropertyf},
    {"rpm_high_3",              "tu154ce/gauges/engine/rpm_high_3",           globalPropertyf},
    {"weel_angle1",             "sim/aircraft/gear/acf_nw_steerdeg1",            globalPropertyf},
    {"weel_angle2",             "sim/aircraft/gear/acf_nw_steerdeg2",            globalPropertyf},
    {"brake_L",                 "sim/flightmodel/controls/l_brake_add",          globalPropertyf},
    {"brake_R",                 "sim/flightmodel/controls/r_brake_add",          globalPropertyf},
    {"EC_L",                    "sim/flightmodel2/gear/eagle_claw_angle_deg[1]", globalPropertyf},
    {"EC_R",                    "sim/flightmodel2/gear/eagle_claw_angle_deg[2]", globalPropertyf},
    {"indicated_airspeed",      "sim/flightmodel/position/indicated_airspeed",   globalPropertyf},
    {"elevator_L",              "sim/flightmodel/controls/hstab1_elv1def",       globalPropertyf},
    {"elevator_R",              "sim/flightmodel/controls/hstab2_elv1def",       globalPropertyf},
    {"wing_tip_defl",           "sim/flightmodel2/wing/wing_tip_deflection_deg[0]", globalPropertyf},
    {"gforce",                  "sim/flightmodel2/misc/gforce_normal",           globalPropertyf},
    {"tank3R_w",                "sim/flightmodel/weight/m_fuel[4]",              globalPropertyf},
    {"tank3L_w",                "sim/flightmodel/weight/m_fuel[5]",              globalPropertyf},
    {"airspeed",                "sim/flightmodel/position/indicated_airspeed",   globalPropertyf},
    {"ail_L",                   "sim/flightmodel/controls/wing3l_ail1def",       globalPropertyf},
    {"ail_R",                   "sim/flightmodel/controls/wing3r_ail1def",       globalPropertyf},
    {"cabin_press_diff",        "sim/cockpit2/pressurization/indicators/pressure_diffential_psi", globalPropertyf},
    {"wiper_left",              "tu154ce/switchers/wiper_left",               globalPropertyi},
    {"wiper_right",             "tu154ce/switchers/wiper_right",              globalPropertyi},
    {"bus27_volt_left",         "tu154ce/elec/bus27_volt_left",               globalPropertyf},
    {"bus27_volt_right",        "tu154ce/elec/bus27_volt_right",              globalPropertyf},
    {"bus115_1_volt",           "tu154ce/elec/bus115_1_volt",                 globalPropertyf},
    {"bus115_3_volt",           "tu154ce/elec/bus115_3_volt",                 globalPropertyf},
    {"wiper_angle_left",        "tu154ce/anim/wiper_angle_left",              globalPropertyf},
    {"wiper_angle_right",       "tu154ce/anim/wiper_angle_right",             globalPropertyf},
})

-- Load sound samples for window operation
local window_open  = loadSample('Custom Sounds/window_open.wav')
local window_close = loadSample('Custom Sounds/window_close.wav')

-- State variables
local gear_turn_pos = 0 -- Actual gear steering position for nose gear animation
local MAX_TURN_SPD  = 40 -- Maximum nose wheel turn speed for smoothing
local turn_need     = 0 -- Target turn angle for nose wheel
local wing_flx_act_L, wing_flx_act_R = 0, 0 -- Animated left/right wing flex
local wiper_pos_L, wiper_pos_R = 0, 0 -- Animated wiper blade positions
local window_L_last = get(cockpit_window_left) -- Last left window value for sound logic
local window_R_last = get(cockpit_window_right) -- Last right window value for sound logic

-- Main update function, called every frame
function update()
    local passed = get(frame_time) -- Time passed since last frame
    local GS     = get(groundspeed) -- Current groundspeed
    local G_force= get(gforce) -- Current G-load

    -- Calculate steering speed based on gear strut deflection and hydro logic
    local defl_F     = get(deflection_mtr_1) -- Nose gear strut deflection
    local hydro_turn = (get(weel_angle1) + get(weel_angle2) > 0) and 1 or 0 -- Hydraulic steering available
    local turn_spd   = (defl_F > 0) and math.min(MAX_TURN_SPD, math.abs(GS) + hydro_turn * 0.5) or MAX_TURN_SPD

    -- Calculate desired turn angle based on gear and yaw
    turn_need = get(tire_steer_actual_deg) * hydro_turn * (1 - math.min(1, math.abs(GS) * 0.1))
        + get(yaw_apd) * 5 * math.max((1 - hydro_turn), math.min(1, math.abs(GS) * 0.1))
    turn_need = math.clamp(turn_need, -65, 65)

    -- Smooth nose gear steering animation
    if passed * turn_spd < 0.5 then
        gear_turn_pos = gear_turn_pos + (turn_need - gear_turn_pos) * passed * turn_spd
    else
        gear_turn_pos = gear_turn_pos + (turn_need - gear_turn_pos) * passed
    end

    set(front_turn, gear_turn_pos)
    set(front_pos, get(deploy_ratio_1))
    set(front_defl, defl_F * 10)

    -- Main gear position and rotation logic
    local pos_L, pos_R = get(deploy_ratio_2), get(deploy_ratio_3)
    local defl_L, defl_R = get(deflection_mtr_2), get(deflection_mtr_3)
    local stuff_angle = (defl_F - 0.215 - (defl_L + defl_R - 0.4682) / 2) * 3.03
    set(ground_stuff_angle, -stuff_angle)

    set(main_pos_left,  pos_L < 0.999 and pos_L or -defl_L * 10 - 1)
    set(main_pos_right, pos_R < 0.999 and pos_R or -defl_R * 10 - 1)

    local rot_L, rot_R = get(EC_L), get(EC_R)
    if pos_L < 0.9 or (get(replay_mode) ~= 0 and defl_L < 0.001) then rot_L = -11 elseif get(replay_mode) ~= 0 then rot_L = -stuff_angle end
    if pos_R < 0.9 or (get(replay_mode) ~= 0 and defl_R < 0.001) then rot_R = -11 elseif get(replay_mode) ~= 0 then rot_R = -stuff_angle end

    set(main_rot_left, rot_L)
    set(main_rot_right, rot_R)

    -- Rudder animation: scale by reverser deployment and RPM
    local rud_L = 1 - math.max(get(revers_flap_L) - 0.5, 0) * get(rpm_high_1) * 0.015
    local rud_R = 1 - math.max(get(revers_flap_R) - 0.5, 0) * get(rpm_high_3) * 0.015
    set(rudder_anim, get(rudder) / ((rud_L + rud_R) * 0.5))

    -- Elevator animation: nonlinear scaling with airspeed
    local ias = get(indicated_airspeed) * 1.852 -- Convert IAS to km/h
    local elev_coef = (ias <= 300) and 1 or (ias <= 400 and line(ias,300,1,400,3) or 3)
    set(elev_anim_L, get(elevator_L) * elev_coef)
    set(elev_anim_R, get(elevator_R) * elev_coef)

    -- Wing flex animation: includes G-load, fuel mass, aileron, and airspeed
    local wing_flx = (get(wing_tip_defl) + 1.3)
    local IAS     = get(airspeed)
    local left_flx  = wing_flx - G_force * get(tank3L_w) * 0.00005 + get(ail_L) * IAS * 0.00003
    local right_flx = wing_flx - G_force * get(tank3R_w) * 0.00005 + get(ail_R) * IAS * 0.00003

    wing_flx_act_L = wing_flx_act_L + (left_flx - wing_flx_act_L) * passed * 10
    wing_flx_act_R = wing_flx_act_R + (right_flx - wing_flx_act_R) * passed * 10
    set(wing_flx_left, wing_flx_act_L)
    set(wing_flx_right, wing_flx_act_R)

    -- Check if doors/windows may open (low cabin pressure differential)
    local door_may_open = get(cabin_press_diff) * 0.0778 < 0.05

    -- Animate left cockpit window with sound
    local wbtn_L = get(slider_1)
    local win_L  = get(cockpit_window_left)
    if (win_L == 0 and door_may_open) or win_L > 0 then
        win_L = win_L + (wbtn_L*2 - 1) * passed / (wbtn_L==1 and 4 or 3)
    end
    win_L = math.clamp(win_L, 0, 1)
    if win_L <= 0.01 and not door_may_open and wbtn_L==1 then set(slider_1,0) end
    set(cockpit_window_left, win_L)

    -- Animate right cockpit window with sound (mirror logic)
    local wbtn_R = get(slider_2)
    local win_R  = get(cockpit_window_right)
    if (win_R == 0 and door_may_open) or win_R > 0 then
        win_R = win_R + (wbtn_R*2 - 1) * passed / (wbtn_R==0 and 4 or 3)
    end
    win_R = math.clamp(win_R, 0, 1)
    if win_R <= 0.01 and not door_may_open and wbtn_R==1 then set(slider_2,0) end
    set(cockpit_window_right, win_R)

    -- Play sound when window starts/stops opening/closing
    if (win_L~=window_L_last and window_L_last==0) or (win_R~=window_R_last and window_R_last==0) then
    playSample(window_open, 0)
    elseif (win_L~=window_L_last and window_L_last==1) or (win_R~=window_R_last and window_R_last==1) then
        playSample(window_close,0)
    end
    window_L_last, window_R_last = win_L, win_R

    -- Animate cargo and passenger doors using sliders (generic loop)
    for i, prop in ipairs({{"cargo_1",3}, {"cargo_2",4},
                           {"pax_door_1",5},{"pax_door_2",6},{"pax_door_3",7}}) do
        local cur   = get(_G[prop[1]])
        local cmd   = get(_G["slider_"..prop[2]])
        if (cur==0 and door_may_open) or cur>0 then
            cur = cur + (cmd*2 - 1) * passed / 5
        end
        if cur<=0.01 and not door_may_open and cmd==1 then set(_G["slider_"..prop[2]],0) end
        set(_G[prop[1]], math.clamp(cur,0,1))
    end

    -- Animate cockpit door (continuous, not clamped at 1)
    local door4 = get(cockpit_door)
    door4 = door4 + (get(slider_8)*2 -1) * passed / 3
    set(cockpit_door, math.clamp(door4,0,1))

    -- Emergency brake handles: left/right track the main handle
    set(brake_emerg_L, get(brake_emerg))
    set(brake_emerg_R, get(brake_emerg))

    -- Animate adjustable armrests via sliders
    for _, arm in ipairs({{"rise_chair_arm_L",11},{"rise_chair_arm_R",12}}) do
        local val = get(_G[arm[1]]) + (get(_G["slider_"..arm[2]])*2 -1)*passed
        set(_G[arm[1]], math.clamp(val,0,1))
    end

    -- Show/hide yokes depending on slider 9 position
    set(yokes_show, 1 - get(slider_9))

    -- Wiper animation: calculate position from state and electrical power
    local function calcWiper(pos, state, power)
        local spd = 0
        if state==-1 then spd = 1.5*power
        elseif state==1 then spd = 3*power
        elseif pos>0.1 then spd=1*power end
        pos = pos + spd * passed
        if pos>1 then pos = pos -1 end
        return pos
    end
    local pL = get(bus27_volt_left)>13 and get(bus115_1_volt)>110 and 1 or 0
    local pR = get(bus27_volt_right)>13 and get(bus115_3_volt)>110 and 1 or 0
    wiper_pos_L = calcWiper(wiper_pos_L, get(wiper_left), pL)
    wiper_pos_R = calcWiper(wiper_pos_R, get(wiper_right), pR)
    set(wiper_angle_left,  (math.cos(math.pi*(wiper_pos_L*2)-math.pi)+1)*0.5*62)
    set(wiper_angle_right, (math.cos(math.pi*(wiper_pos_R*2)-math.pi)+1)*0.5*62)

    -- Cockpit tables up/down logic using switches (table_up_L/R) with clamping
    for _, t in ipairs({{"cockpit_table_1","table_up_L"},{"cockpit_table_2","table_up_R"}}) do
        local pos = get(_G[t[1]])
        local sw  = get(_G[t[2]])
        if pos<1 and sw==1 then pos = pos + passed*0.5
        elseif pos>0 and sw==0 then pos = pos - passed*0.5 end
        pos = math.clamp(pos, 0, 1)
        set(_G[t[1]], pos)
    end

    -- Reverse lever midpoint for animation
    set(reverse_mid, (get(revers_L) + get(revers_R)) / 2)
end
