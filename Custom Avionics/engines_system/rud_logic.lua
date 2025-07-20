defineProperty("xp_version", globalPropertyi("sim/version/xplane_internal_version"))
defineProperty("tro_comm_1", globalPropertyf("tu154ce/SC/engine/ENGN_thro_0")) 
defineProperty("tro_comm_2", globalPropertyf("tu154ce/SC/engine/ENGN_thro_1")) 
defineProperty("tro_comm_3", globalPropertyf("tu154ce/SC/engine/ENGN_thro_2"))
defineProperty("sim_rud_1", globalPropertyf("sim/flightmodel/engine/ENGN_thro_use[0]"))
defineProperty("sim_rud_2", globalPropertyf("sim/flightmodel/engine/ENGN_thro_use[1]"))
defineProperty("sim_rud_3", globalPropertyf("sim/flightmodel/engine/ENGN_thro_use[2]"))
defineProperty("revers_flap_L", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]")) 
defineProperty("revers_flap_R", globalPropertyf("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]")) 
defineProperty("eng_modL", globalPropertyf("sim/flightmodel/engine/ENGN_propmode[0]")) 
defineProperty("eng_modR", globalPropertyf("sim/flightmodel/engine/ENGN_propmode[2]")) 
defineProperty("anim_rud1", globalPropertyf("tu154ce/controlls/throttle_1")) 
defineProperty("anim_rud2", globalPropertyf("tu154ce/controlls/throttle_2")) 
defineProperty("anim_rud3", globalPropertyf("tu154ce/controlls/throttle_3")) 
defineProperty("anim_rud1_ENG", globalPropertyf("tu154ce/controlls/throttle_1_ENG")) 
defineProperty("anim_rud2_ENG", globalPropertyf("tu154ce/controlls/throttle_2_ENG")) 
defineProperty("anim_rud3_ENG", globalPropertyf("tu154ce/controlls/throttle_3_ENG")) 
defineProperty("revers_L", globalPropertyf("tu154ce/controlls/revers_L")) 
defineProperty("revers_R", globalPropertyf("tu154ce/controlls/revers_R")) 
defineProperty("throttle_lock", globalPropertyf("tu154ce/controlls/throttle_lock")) 
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  
defineProperty("baro_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  
defineProperty("rud_1_spd", globalPropertyf("tu154ce/absu/rud_1_spd")) 
defineProperty("rud_2_spd", globalPropertyf("tu154ce/absu/rud_2_spd")) 
defineProperty("rud_3_spd", globalPropertyf("tu154ce/absu/rud_3_spd")) 
defineProperty("comsta0", globalPropertyi("sim/operation/failures/rel_comsta0")) 
defineProperty("comsta1", globalPropertyi("sim/operation/failures/rel_comsta1"))
defineProperty("comsta2", globalPropertyi("sim/operation/failures/rel_comsta2"))
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("outside_air_temp", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) 
defineProperty("rev_fail", globalPropertyi("sim/operation/failures/rel_revloc1")) 
defineProperty("rev_fail_2", globalPropertyi("sim/operation/failures/rel_revers1")) 
defineProperty("override", globalPropertyi("sim/operation/override/override_throttles"))
defineProperty("acf_tmax", globalPropertyf("sim/aircraft/engine/acf_tmax")) 
defineProperty("throttle_ratio_all", globalPropertyf("sim/cockpit2/engine/actuators/throttle_ratio_all")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
set(override, 1) 
local XP11 = get(xp_version) > 11000
set(sim_rud_1, 0.04)
set(sim_rud_2, 0.04)
set(sim_rud_3, 0.04)
if XP11 then
	set(sim_rud_1, 0.25)
	set(sim_rud_2, 0.25)
	set(sim_rud_3, 0.25)
end
local forward_table = {{ -10000, 0.00 }, 
                  {  0.0, 0.02 },	
				  {  0.5, 0.38 },	
				  {  0.6, 0.55}, 
				  {  0.65, 0.637 }, 
                  {  0.7, 0.805}, 
           	      {  0.8, 0.886 }, 
				  {  1.0, 0.975 },	
				  {  1.1, 1.0 },	
				  {  1.2, 1.2 },	
          	      {  100000, 1.3 }} 
local reverse_table = {{ -10000, 0.04 }, 
                  {  0.0, 0.18 },	
				  {  0.5, 0.18 },	
				  {  0.6, 0.8}, 
           	      {  1.0, 0.8 }, 
          	      {  100000, 0.8 }} 
local rud_T_tbl = {{ -10000, 10 }, 
                  {  -60, 10 },	
				   {  0, 1}, 
				  {  40, 0.4}, 
				  {  60, 0.3}, 
          	      {  100000, 0.1 }} 
local thro_1_pos = 0
local thro_2_pos = 0
local thro_3_pos = 0
local thro_1_pos_ENG = 0
local thro_3_pos_ENG = 0
local rev_L_pos = 0
local rev_R_pos = 0
local joy_pos_last_1 = get(tro_comm_1)
local joy_pos_last_2 = get(tro_comm_2)
local joy_pos_last_3 = get(tro_comm_3)
local virtual_rud_1 = 0.02
local virtual_rud_2 = 0.02
local virtual_rud_3 = 0.02
local virtual_rud_1_act = 0.02
local virtual_rud_2_act = 0.02
local virtual_rud_3_act = 0.02
local joy_rud_pos_1 = get(tro_comm_1)
local joy_rud_pos_2 = get(tro_comm_2)
local joy_rud_pos_3 = get(tro_comm_3)
rev_comm = findCommand("sim/engines/thrust_reverse_toggle")
function rev_comm_hnd(phase)
	if 0 == phase then 
		set(throttle_ratio_all, 0)
	end
	return 0
end
registerCommandHandler(rev_comm, 0, rev_comm_hnd)
function update()
	local passed = get(frame_time)
	local stop_lever = get(throttle_lock) 
	local rev_L = get(eng_modL) == 3
	local rev_R = get(eng_modR) == 3
	local T_coef = interpolate(rud_T_tbl, get(outside_air_temp))
	local T_coef_1 = T_coef
	if rev_L then T_coef_1 = T_coef_1 / 1.5 end
	local T_coef_3 = T_coef
	if rev_R then T_coef_3 = T_coef_3 / 1.5 end
	local joy_rud_MAX_1 = 1
	local joy_rud_MIN_1 = 0.02 
	local joy_rud_MAX_2 = 1
	local joy_rud_MIN_2 = 0.02
	local joy_rud_MAX_3 = 1
	local joy_rud_MIN_3 = 0.02
	if XP11 then
		joy_rud_MIN_1 = 0.175 
		joy_rud_MIN_2 = 0.175
		joy_rud_MIN_3 = 0.175
	end
	local alt = get(msl_alt) * 3.28083 
	local alt_baro = alt * 0.3048 + (29.92 - get(baro_press)) * 1000 * 0.3048 
	local height_coef = line(alt_baro, 0, 1, 11000, 1.6) 
	if XP11 then height_coef = line(alt_baro, 0, 1, 11000, 0.975) end 
	local stall_1 = get(comsta0) == 6
	if stall_1 then 
		joy_rud_MAX_1 = 0.05 
		joy_rud_MIN_1 = 0
	end
	local stall_2 = get(comsta1) == 6
	if stall_2 then 
		joy_rud_MAX_2 = 0.05 
		joy_rud_MIN_2 = 0
	end
	local stall_3 = get(comsta2) == 6
	if stall_3 then 
		joy_rud_MAX_3 = 0.05 
		joy_rud_MIN_3 = 0 
	end	
	local rud_spd_1 = get(rud_1_spd)
	local rud_spd_2 = get(rud_2_spd)
	local rud_spd_3 = get(rud_3_spd)
	local joy_pos_1 = get(tro_comm_1)
	local joy_pos_2 = get(tro_comm_2)
	local joy_pos_3 = get(tro_comm_3)
	if rud_spd_1 ~= 0 then
		joy_rud_pos_1 = joy_rud_pos_1 + rud_spd_1 * passed
	elseif math.abs(joy_pos_1 - joy_pos_last_1) > 0.001 then
		joy_rud_pos_1 = joy_pos_1
	end
	if rud_spd_2 ~= 0 then
		joy_rud_pos_2 = joy_rud_pos_2 + rud_spd_2 * passed
	elseif math.abs(joy_pos_2 - joy_pos_last_2) > 0.001 then
		joy_rud_pos_2 = joy_pos_2
	end
	if rud_spd_3 ~= 0 then
		joy_rud_pos_3 = joy_rud_pos_3 + rud_spd_3 * passed
	elseif math.abs(joy_pos_3 - joy_pos_last_3) > 0.001 then
		joy_rud_pos_3 = joy_pos_3
	end
	if math.abs(joy_pos_last_1 - joy_pos_1) > 0.001 then joy_pos_last_1 = joy_pos_1 end
	if math.abs(joy_pos_last_2 - joy_pos_2) > 0.001 then joy_pos_last_2 = joy_pos_2 end
	if math.abs(joy_pos_last_3 - joy_pos_3) > 0.001 then joy_pos_last_3 = joy_pos_3 end
	if joy_rud_pos_1 > 1 then joy_rud_pos_1 = 1
	elseif joy_rud_pos_1 < 0 then joy_rud_pos_1 = 0 end
	if joy_rud_pos_2 > 1 then joy_rud_pos_2 = 1
	elseif joy_rud_pos_2 < 0 then joy_rud_pos_2 = 0 end
	if joy_rud_pos_3 > 1 then joy_rud_pos_3 = 1
	elseif joy_rud_pos_3 < 0 then joy_rud_pos_3 = 0 end
	if stop_lever < 0.2 then
		if rev_L then
			thro_1_pos = 0
			thro_1_pos_ENG = -interpolate(reverse_table, joy_rud_pos_1) * 0.4
			rev_L_pos = -thro_1_pos_ENG * 2.5
			virtual_rud_1 = joy_rud_MIN_1 + (joy_rud_MAX_1 - joy_rud_MIN_1) * interpolate(reverse_table, joy_rud_pos_1)
		else
			thro_1_pos = joy_rud_pos_1
			thro_1_pos_ENG = joy_rud_pos_1
			rev_L_pos = 0
			virtual_rud_1 = joy_rud_MIN_1 + (joy_rud_MAX_1 - joy_rud_MIN_1) * interpolate(forward_table, joy_rud_pos_1)
		end
		if rev_L or rev_R then 
			thro_2_pos = 0
			virtual_rud_2 = joy_rud_MIN_2 + (joy_rud_MAX_2 - joy_rud_MIN_2) * interpolate(forward_table, joy_rud_MIN_2)
		else
			thro_2_pos = joy_rud_pos_2
			virtual_rud_2 = joy_rud_MIN_2 + (joy_rud_MAX_2 - joy_rud_MIN_2) * interpolate(forward_table, joy_rud_pos_2)
		end
		if rev_R then
			thro_3_pos = 0
			thro_3_pos_ENG = -interpolate(reverse_table, joy_rud_pos_3) * 0.4
			rev_R_pos = -thro_3_pos_ENG * 2.5
			virtual_rud_3 = joy_rud_MIN_3 + (joy_rud_MAX_3 - joy_rud_MIN_3) * interpolate(reverse_table, joy_rud_pos_3)
		else
			thro_3_pos = joy_rud_pos_3
			thro_3_pos_ENG = joy_rud_pos_3
			rev_R_pos = 0
			virtual_rud_3 = joy_rud_MIN_3 + (joy_rud_MAX_3 - joy_rud_MIN_3) * interpolate(forward_table, joy_rud_pos_3)
		end
	end
	if virtual_rud_1_act < virtual_rud_1 then 
		virtual_rud_1_act = virtual_rud_1_act - (virtual_rud_1_act - virtual_rud_1) * passed * T_coef_1
	else 
		virtual_rud_1_act = virtual_rud_1_act - (virtual_rud_1_act - virtual_rud_1) * passed
	end
	if virtual_rud_2_act < virtual_rud_2 then 
		virtual_rud_2_act = virtual_rud_2_act - (virtual_rud_2_act - virtual_rud_2) * passed * T_coef
	else 
		virtual_rud_2_act = virtual_rud_2_act - (virtual_rud_2_act - virtual_rud_2) * passed
	end
	if virtual_rud_3_act < virtual_rud_3 then 
		virtual_rud_3_act = virtual_rud_3_act - (virtual_rud_3_act - virtual_rud_3) * passed * T_coef_3
	else 
		virtual_rud_3_act = virtual_rud_3_act - (virtual_rud_3_act - virtual_rud_3) * passed
	end
	local thro_high_1 = line(virtual_rud_1_act, 0, 0.35, 1, 1.1)
	local thro_high_2 = line(virtual_rud_2_act, 0, 0.35, 1, 1.1)
	local thro_high_3 = line(virtual_rud_3_act, 0, 0.35, 1, 1.1)
if XP11 then
	thro_high_1 = line(virtual_rud_1_act, 0, 0.54, 1, 1.1)
	thro_high_2 = line(virtual_rud_2_act, 0, 0.54, 1, 1.1)
	thro_high_3 = line(virtual_rud_3_act, 0, 0.54, 1, 1.1)
	thro_high_1 = line(virtual_rud_1_act, 0, 0.525, 1, 1.07)
	thro_high_2 = line(virtual_rud_2_act, 0, 0.525, 1, 1.07)
	thro_high_3 = line(virtual_rud_3_act, 0, 0.525, 1, 1.07)
end
	local thro_1 = line(alt_baro, 0, virtual_rud_1_act, 11000, thro_high_1)
	local thro_2 = line(alt_baro, 0, virtual_rud_2_act, 11000, thro_high_2)
	local thro_3 = line(alt_baro, 0, virtual_rud_3_act, 11000, thro_high_3)
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	set(anim_rud1, thro_1_pos)
	set(anim_rud2, thro_2_pos)
	set(anim_rud3, thro_3_pos)
	set(anim_rud1_ENG, thro_1_pos_ENG)
	set(anim_rud2_ENG, thro_2_pos)
	set(anim_rud3_ENG, thro_3_pos_ENG)
	set(throttle_lock, stop_lever)
	set(revers_L, rev_L_pos)
	set(revers_R, rev_R_pos)
	set(sim_rud_1, thro_1)
	set(sim_rud_2, thro_2)
	set(sim_rud_3, thro_3)
end
	set(rev_fail, 6) 
	set(rev_fail_2, 6)
	set(acf_tmax, 108288 * height_coef)
end
function onAvionicsDone()
	set(override, 0)
	print("throttles released")
end