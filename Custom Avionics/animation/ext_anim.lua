-- ext_anim.lua

-- DataRef bulk mapping
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    -- General
    {"frame_time", "tu154ce/time/frame_time", globalPropertyf},
    {"replay_mode", "sim/operation/prefs/replay_mode", globalPropertyi},
    -- Reverse handle
    {"revers_L", "tu154ce/controlls/revers_L", globalPropertyf},
    {"revers_R", "tu154ce/controlls/revers_R", globalPropertyf},
    {"reverse_mid", "tu154ce/anim/reverse_mid", globalPropertyf},
    -- Gear
    {"front_pos", "tu154ce/anim/lg/front_pos", globalPropertyf},
    {"front_defl", "tu154ce/anim/lg/front_defl", globalPropertyf},
    {"front_turn", "tu154ce/anim/lg/front_turn", globalPropertyf},
    {"main_pos_left", "tu154ce/anim/lg/main_pos_left", globalPropertyf},
    {"main_rot_left", "tu154ce/anim/lg/main_rot_left", globalPropertyf},
    {"main_pos_right", "tu154ce/anim/lg/main_pos_right", globalPropertyf},
    {"main_rot_right", "tu154ce/anim/lg/main_rot_right", globalPropertyf},
    -- Tail
    {"rudder_anim", "tu154ce/anim/rudder_anim", globalPropertyf},
    {"elev_anim_L", "tu154ce/anim/elev_anim_L", globalPropertyf},
    {"elev_anim_R", "tu154ce/anim/elev_anim_R", globalPropertyf},
    -- Wings
    {"wing_flx_right", "tu154ce/anim/wing_flx_right", globalPropertyf},
    {"wing_flx_left", "tu154ce/anim/wing_flx_left", globalPropertyf},
    -- Windows and doors
    {"cockpit_window_left", "tu154ce/anim/cockpit_window_left", globalPropertyf},
    {"cockpit_window_right", "tu154ce/anim/cockpit_window_right", globalPropertyf},
    {"cargo_1", "tu154ce/anim/cargo_1", globalPropertyf},
    {"cargo_2", "tu154ce/anim/cargo_2", globalPropertyf},
    {"pax_door_1", "tu154ce/anim/pax_door_1", globalPropertyf},
    {"pax_door_2", "tu154ce/anim/pax_door_2", globalPropertyf},
    {"pax_door_3", "tu154ce/anim/pax_door_3", globalPropertyf},
    {"cockpit_door", "tu154ce/anim/cockpit_door", globalPropertyf},
    {"rise_chair_arm_L", "tu154ce/anim/rise_chair_arm_L", globalPropertyf},
    {"rise_chair_arm_R", "tu154ce/anim/rise_chair_arm_R", globalPropertyf},
    -- Yokes
    {"yokes_show", "tu154ce/anim/show_yokes", globalPropertyi},
    -- Sliders
    {"slider_1", "sim/cockpit2/switches/custom_slider_on[0]", globalProperty},
    {"slider_2", "sim/cockpit2/switches/custom_slider_on[1]", globalProperty},
    {"slider_3", "sim/cockpit2/switches/custom_slider_on[2]", globalProperty},
    {"slider_4", "sim/cockpit2/switches/custom_slider_on[3]", globalProperty},
    {"slider_5", "sim/cockpit2/switches/custom_slider_on[4]", globalProperty},
    {"slider_6", "sim/cockpit2/switches/custom_slider_on[5]", globalProperty},
    {"slider_7", "sim/cockpit2/switches/custom_slider_on[6]", globalProperty},
    {"slider_8", "sim/cockpit2/switches/custom_slider_on[7]", globalProperty},
    {"slider_9", "sim/cockpit2/switches/custom_slider_on[8]", globalProperty},
    {"slider_10", "sim/cockpit2/switches/custom_slider_on[9]", globalProperty},
    {"slider_11", "sim/cockpit2/switches/custom_slider_on[10]", globalProperty},
    {"slider_12", "sim/cockpit2/switches/custom_slider_on[11]", globalProperty},
    -- Brake levers
    {"brake_emerg", "tu154ce/controlls/brake_emerg", globalPropertyf},
    {"brake_emerg_L", "tu154ce/controlls/brake_emerg_L", globalPropertyf},
    {"brake_emerg_R", "tu154ce/controlls/brake_emerg_R", globalPropertyf},
    -- Table
    {"table_up_L", "tu154ce/anim/table_up_L", globalPropertyf},
    {"table_up_R", "tu154ce/anim/table_up_R", globalPropertyf},
    {"ground_stuff_angle", "tu154ce/anim/ground_stuff_angle", globalPropertyf},
    -- Sources
    {"tire_steer_actual_deg", "sim/flightmodel2/gear/tire_steer_actual_deg[0]", globalProperty},
    {"deploy_ratio_1", "sim/flightmodel2/gear/deploy_ratio[0]", globalProperty},
    {"deploy_ratio_2", "sim/flightmodel2/gear/deploy_ratio[1]", globalProperty},
    {"deploy_ratio_3", "sim/flightmodel2/gear/deploy_ratio[2]", globalProperty},
    {"deflection_mtr_1", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]", globalProperty},
    {"deflection_mtr_2", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalProperty},
    {"deflection_mtr_3", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalProperty},
    {"groundspeed", "sim/flightmodel/position/groundspeed", globalPropertyf},
    {"yaw_apd", "sim/flightmodel/position/R", globalPropertyf},
    {"rudder", "sim/flightmodel/controls/vstab2_rud1def", globalPropertyf},
    {"revers_flap_L", "sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]", globalProperty},
    {"revers_flap_R", "sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]", globalProperty},
    {"rpm_high_1", "tu154ce/gauges/engine/rpm_high_1", globalPropertyf},
    {"rpm_high_3", "tu154ce/gauges/engine/rpm_high_3", globalPropertyf},
    {"weel_angle1", "sim/aircraft/gear/acf_nw_steerdeg1", globalPropertyf},
    {"weel_angle2", "sim/aircraft/gear/acf_nw_steerdeg2", globalPropertyf},
    {"brake_L", "sim/flightmodel/controls/l_brake_add", globalPropertyf},
    {"brake_R", "sim/flightmodel/controls/r_brake_add", globalPropertyf},
    {"EC_L", "sim/flightmodel2/gear/eagle_claw_angle_deg[1]", globalProperty},
    {"EC_R", "sim/flightmodel2/gear/eagle_claw_angle_deg[2]", globalProperty},
    {"indicated_airspeed", "sim/flightmodel/position/indicated_airspeed", globalPropertyf},
    {"elevator_L", "sim/flightmodel/controls/hstab1_elv1def", globalPropertyf},
    {"elevator_R", "sim/flightmodel/controls/hstab2_elv1def", globalPropertyf},
    {"wing_tip_defl", "sim/flightmodel2/wing/wing_tip_deflection_deg[0]", globalProperty},
    {"gforce", "sim/flightmodel2/misc/gforce_normal", globalPropertyf},
    {"tank3R_w", "sim/flightmodel/weight/m_fuel[4]", globalProperty},
    {"tank3L_w", "sim/flightmodel/weight/m_fuel[5]", globalProperty},
    {"airspeed", "sim/flightmodel/position/indicated_airspeed", globalPropertyf},
    {"ail_L", "sim/flightmodel/controls/wing3l_ail1def", globalPropertyf},
    {"ail_R", "sim/flightmodel/controls/wing3r_ail1def", globalPropertyf},
    {"cabin_press_diff", "sim/cockpit2/pressurization/indicators/pressure_diffential_psi", globalPropertyf},
    -- Wiper
    {"wiper_left", "tu154ce/switchers/wiper_left", globalPropertyi},
    {"wiper_right", "tu154ce/switchers/wiper_right", globalPropertyi},
    {"bus27_volt_left", "tu154ce/elec/bus27_volt_left", globalPropertyf},
    {"bus27_volt_right", "tu154ce/elec/bus27_volt_right", globalPropertyf},
    {"bus115_1_volt", "tu154ce/elec/bus115_1_volt", globalPropertyf},
    {"bus115_3_volt", "tu154ce/elec/bus115_3_volt", globalPropertyf},
    {"wiper_angle_left", "tu154ce/anim/wiper_angle_left", globalPropertyf},
    {"wiper_angle_right", "tu154ce/anim/wiper_angle_right", globalPropertyf},
	{"cockpit_table_1", "tu154ce/anim/cockpit_table_1" globalPropertyf},
	{"cockpit_table_2", "tu154ce/anim/cockpit_table_2" globalPropertyf},
})

-- Sound resources
local window_open = loadSample('Custom Sounds/window_open.wav')
local window_close = loadSample('Custom Sounds/window_close.wav')

-- Local state variables
local gear_turn_pos = 0
local MAX_TURN_SPD = 40
local turn_need = 0
local wing_flx_act_L = 0
local wing_flx_act_R = 0
local wiper_pos_L = 0
local wiper_pos_R = 0
local window_L_last = tonumber(get(cockpit_window_left)) or 0
local window_R_last = tonumber(get(cockpit_window_right)) or 0

-- Helper function for boolean to int
local function bool2int(v)
    return v and 1 or 0
end

-- Helper function for linear interpolation
local function line(x, x0, y0, x1, y1)
    if x1 == x0 then return y0 end
    return y0 + (y1 - y0) * (x - x0) / (x1 - x0)
end

-- Main update function
function update()
    local passed = get(frame_time)
    local GS = get(groundspeed)
    local G_force = get(gforce)

    -- Front gear: steering and suspension
    local turn_spd = MAX_TURN_SPD
    local defl_F = get(deflection_mtr_1)
    local hydro_turn = 0

    if get(weel_angle1) + get(weel_angle2) > 0 then
        hydro_turn = 1
    end

    if defl_F > 0 then
        turn_spd = math.abs(GS) + hydro_turn * 0.5
        if turn_spd > MAX_TURN_SPD then turn_spd = MAX_TURN_SPD end
    end

    turn_need = get(tire_steer_actual_deg) * hydro_turn * (1 - math.min(1, math.abs(GS) * 0.1)) +
                get(yaw_apd) * 5 * math.max((1 - hydro_turn), math.min(1, math.abs(GS) * 0.1))
    -- Clamp turning
    if turn_need > 65 then turn_need = 65
    elseif turn_need < -65 then turn_need = -65 end

    if passed * turn_spd < 0.5 then
        gear_turn_pos = gear_turn_pos + (turn_need - gear_turn_pos) * passed * turn_spd
    else
        gear_turn_pos = gear_turn_pos + (turn_need - gear_turn_pos) * passed
    end
    set(front_turn, gear_turn_pos)

    -- Set gear deployment and deflection
    set(front_pos, get(deploy_ratio_1))
    set(front_defl, defl_F * 10)

    -- Main gear: deployment, deflection, and rotation
    local pos_L = get(deploy_ratio_2)
    local pos_R = get(deploy_ratio_3)
    local defl_L = get(deflection_mtr_2)
    local defl_R = get(deflection_mtr_3)

    -- Ground stuff angle calculation
    local stuff_angle = (defl_F - 0.215 - (defl_L + defl_R - 0.2341 * 2) / 2) * 3.03
    set(ground_stuff_angle, -stuff_angle)

    if pos_L < 0.999 then
        set(main_pos_left, pos_L)
    else
        set(main_pos_left, -defl_L * 10 - 1)
    end

    if pos_R < 0.999 then
        set(main_pos_right, pos_R)
    else
        set(main_pos_right, -defl_R * 10 - 1)
    end

    -- Eagle Claw mechanism for main gear rotation
    local rot_L = get(EC_L)
    local rot_R = get(EC_R)
    if pos_L < 0.9 then rot_L = -11 end
    if pos_R < 0.9 then rot_R = -11 end
    set(main_rot_left, rot_L)
    set(main_rot_right, rot_R)

    -- Rudder animation (thrust reverser effect)
    local rudder_L = 1 - math.max(get(revers_flap_L) - 0.5, 0) * get(rpm_high_1) * 0.015
    local rudder_R = 1 - math.max(get(revers_flap_R) - 0.5, 0) * get(rpm_high_3) * 0.015
    set(rudder_anim, get(rudder) / ((rudder_L + rudder_R) * 0.5))

    -- Elevator animation (IAS-dependent correction)
    local ias = get(indicated_airspeed) * 1.852
    local elev_coef = 1
    if ias >= 300 and ias <= 400 then elev_coef = line(ias, 300, 1, 400, 3)
    elseif ias > 400 then elev_coef = 3 end
    local elev_L = get(elevator_L) * elev_coef
    local elev_R = get(elevator_R) * elev_coef
    set(elev_anim_L, elev_L)
    set(elev_anim_R, elev_R)

    -- Wing flex calculation
    local wing_flx = (get(wing_tip_defl) + 1.3)
    local tank_coef = 0.00005
    local ail_coef = 0.00003
    local IAS = get(airspeed)
    local left_flx = wing_flx - G_force * get(tank3L_w) * tank_coef + get(ail_L) * IAS * ail_coef
    local right_flx = wing_flx - G_force * get(tank3R_w) * tank_coef + get(ail_R) * IAS * ail_coef
    wing_flx_act_L = wing_flx_act_L + (left_flx - wing_flx_act_L) * passed * 10
    wing_flx_act_R = wing_flx_act_R + (right_flx - wing_flx_act_R) * passed * 10
    set(wing_flx_left, wing_flx_act_L)
    set(wing_flx_right, wing_flx_act_R)

    -- Window and door animation
    local door_may_open = get(cabin_press_diff) * 0.0778 < 0.05

    -- Left cockpit window
    local window_but_L = get(slider_1)
    local window_L = get(cockpit_window_left)
    if (window_L == 0 and door_may_open) or window_L > 0 then
        if window_but_L == 1 then
            window_L = window_L + (window_but_L * 2 - 1) * passed / 4
        else
            window_L = window_L + (window_but_L * 2 - 1) * passed / 3
        end
    end
    if window_L <= 0.01 and not door_may_open and window_but_L == 1 then set(slider_1, 0) end
    if window_L > 1 then window_L = 1 elseif window_L < 0 then window_L = 0 end
    set(cockpit_window_left, window_L)

    -- Right cockpit window
    local window_but_R = get(slider_2)
    local window_R = get(cockpit_window_right)
    if (window_R == 0 and door_may_open) or window_R > 0 then
        if window_but_R == 0 then
            window_R = window_R + (window_but_R * 2 - 1) * passed / 4
        else
            window_R = window_R + (window_but_R * 2 - 1) * passed / 3
        end
    end
    if window_R <= 0.01 and not door_may_open and window_but_R == 1 then set(slider_2, 0) end
    if window_R > 1 then window_R = 1 elseif window_R < 0 then window_R = 0 end
    set(cockpit_window_right, window_R)

    -- Window sound effects
    if (window_L ~= window_L_last and window_L_last == 0) or (window_R ~= window_R_last and window_R_last == 0) then
        if get(xplane_version) < 120000 then playSample(window_open, false) end
    elseif (window_L ~= window_L_last and window_L_last == 1) or (window_R ~= window_R_last and window_R_last == 1) then
	if get(xplane_version) < 120000 then playSample(window_close, false) end
	end
	window_L_last = window_L
	window_R_last = window_R
	-- Cargo 1 door
	local cargo_FWD = get(cargo_1)
	local cargo_1_cmd = get(slider_3)
	if (cargo_FWD == 0 and door_may_open) or cargo_FWD > 0 then
		cargo_FWD = cargo_FWD + (cargo_1_cmd * 2 - 1) * passed / 5
	end
	if cargo_FWD <= 0.01 and not door_may_open and cargo_1_cmd == 1 then set(slider_3, 0) end
	if cargo_FWD > 1 then cargo_FWD = 1 elseif cargo_FWD < 0 then cargo_FWD = 0 end
	set(cargo_1, cargo_FWD)

	-- Cargo 2 door
	local cargo_BK = get(cargo_2)
	local cargo_2_cmd = get(slider_4)
	if (cargo_BK == 0 and door_may_open) or cargo_BK > 0 then
		cargo_BK = cargo_BK + (cargo_2_cmd * 2 - 1) * passed / 5
	end
	if cargo_BK <= 0.01 and not door_may_open and cargo_2_cmd == 1 then set(slider_4, 0) end
	if cargo_BK > 1 then cargo_BK = 1 elseif cargo_BK < 0 then cargo_BK = 0 end
	set(cargo_2, cargo_BK)

	-- PAX Door 1
	local door_1 = get(pax_door_1)
	local door_1_cmd = get(slider_5)
	if (door_1 == 0 and door_may_open) or door_1 > 0 then
		door_1 = door_1 + (door_1_cmd * 2 - 1) * passed / 5
	end
	if door_1 <= 0.01 and not door_may_open and door_1_cmd == 1 then set(slider_5, 0) end
	if door_1 > 1 then door_1 = 1 elseif door_1 < 0 then door_1 = 0 end
	set(pax_door_1, door_1)

	-- PAX Door 2
	local door_2 = get(pax_door_2)
	local door_2_cmd = get(slider_6)
	if (door_2 == 0 and door_may_open) or door_2 > 0 then
		door_2 = door_2 + (door_2_cmd * 2 - 1) * passed / 5
	end
	if door_2 <= 0.01 and not door_may_open and door_2_cmd == 1 then set(slider_6, 0) end
	if door_2 > 1 then door_2 = 1 elseif door_2 < 0 then door_2 = 0 end
	set(pax_door_2, door_2)

	-- PAX Door 3
	local door_3 = get(pax_door_3)
	local door_3_cmd = get(slider_7)
	if (door_3 == 0 and door_may_open) or door_3 > 0 then
		door_3 = door_3 + (door_3_cmd * 2 - 1) * passed / 5
	end
	if door_3 <= 0.01 and not door_may_open and door_3_cmd == 1 then set(slider_7, 0) end
	if door_3 > 1 then door_3 = 1 elseif door_3 < 0 then door_3 = 0 end
	set(pax_door_3, door_3)

	-- Cockpit door
	local door_4 = get(cockpit_door)
	local door_4_cmd = get(slider_8)
	door_4 = door_4 + (door_4_cmd * 2 - 1) * passed / 3
	if door_4 > 1 then door_4 = 1 elseif door_4 < 0 then door_4 = 0 end
	set(cockpit_door, door_4)

	-- Brake levers: propagate emergency to L/R
	set(brake_emerg_L, get(brake_emerg))
	set(brake_emerg_R, get(brake_emerg))

	-- Chair armrests
	local chair_L = get(rise_chair_arm_L)
	local chair_L_cmd = get(slider_11)
	chair_L = chair_L + (chair_L_cmd * 2 - 1) * passed
	if chair_L > 1 then chair_L = 1 elseif chair_L < 0 then chair_L = 0 end
	set(rise_chair_arm_L, chair_L)

	local chair_R = get(rise_chair_arm_R)
	local chair_R_cmd = get(slider_12)
	chair_R = chair_R + (chair_R_cmd * 2 - 1) * passed
	if chair_R > 1 then chair_R = 1 elseif chair_R < 0 then chair_R = 0 end
	set(rise_chair_arm_R, chair_R)
	
	-- Yoke show/hide
	set(yokes_show, 1 - get(slider_9))
	
	-- Wiper logic and animation
	local wip_power_L = bool2int(get(bus27_volt_left) > 13 and get(bus115_1_volt) > 110)
	local wip_power_R = bool2int(get(bus27_volt_right) > 13 and get(bus115_3_volt) > 110)
	local wip_spd_L = 0
	if get(wiper_left) == -1 then wip_spd_L = 1.5 * wip_power_L
	elseif get(wiper_left) == 1 then wip_spd_L = 3 * wip_power_L
	else if wiper_pos_L > 0.1 then wip_spd_L = 1 * wip_power_L end end
	local wip_spd_R = 0
	if get(wiper_right) == -1 then wip_spd_R = 1.5 * wip_power_R
	elseif get(wiper_right) == 1 then wip_spd_R = 3 * wip_power_R
	else if wiper_pos_R > 0.1 then wip_spd_R = 1 * wip_power_R end end
	wiper_pos_L = wiper_pos_L + wip_spd_L * passed
	if wiper_pos_L > 1 then wiper_pos_L = wiper_pos_L - 1 end
	wiper_pos_R = wiper_pos_R + wip_spd_R * passed
	if wiper_pos_R > 1 then wiper_pos_R = wiper_pos_R - 1 end
	set(wiper_angle_left, (math.cos(math.pi * wiper_pos_L * 2 - math.pi) + 1) * 0.5 * 62)
	set(wiper_angle_right, (math.cos(math.pi * wiper_pos_R * 2 - math.pi) + 1) * 0.5 * 62)
	
	-- Cockpit tables
	local table_pos_L = tonumber(get(cockpit_table_1)) or 0
	local table_pos_R = tonumber(get(cockpit_table_2)) or 0
	local table_sw_L = get(table_up_L) or 0
	local table_sw_R = get(table_up_R) or 0
	
	if table_pos_L < 1 and table_sw_L == 1 then table_pos_L = table_pos_L + passed * 0.5
	elseif table_pos_L > 0 and table_sw_L == 0 
	then table_pos_L = table_pos_L - passed * 0.5 end
	
	if table_pos_R < 1 and table_sw_R == 1 then table_pos_R = table_pos_R + passed * 0.5
	elseif table_pos_R > 0 and table_sw_R == 0 
	then table_pos_R = table_pos_R - passed * 0.5 end
	
	set(cockpit_table_1, table_pos_L)
	set(cockpit_table_2, table_pos_R)
	
	-- Reverse handle mid animation
	set(reverse_mid, (get(revers_L) + get(revers_R)) / 2)
end
