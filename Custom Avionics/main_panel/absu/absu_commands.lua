defineProperty("absu_zk", globalPropertyi("tu154ce/buttons/console/absu_zk")) 
defineProperty("absu_reset", globalPropertyi("tu154ce/buttons/console/absu_reset")) 
defineProperty("absu_nvu", globalPropertyi("tu154ce/buttons/console/absu_nvu")) 
defineProperty("absu_app", globalPropertyi("tu154ce/buttons/console/absu_app")) 
defineProperty("absu_gs", globalPropertyi("tu154ce/buttons/console/absu_gs")) 
defineProperty("absu_stab_m", globalPropertyi("tu154ce/buttons/console/absu_stab_m")) 
defineProperty("absu_stab_v", globalPropertyi("tu154ce/buttons/console/absu_stab_v")) 
defineProperty("absu_stab_h", globalPropertyi("tu154ce/buttons/console/absu_stab_h")) 
defineProperty("absu_stab", globalPropertyi("tu154ce/buttons/console/absu_stab")) 
defineProperty("absu_stab_speed", globalPropertyi("tu154ce/buttons/console/absu_stab_speed")) 
defineProperty("absu_speed_change", globalPropertyi("tu154ce/switchers/console/absu_speed_change")) 
defineProperty("absu_turn_handle", globalPropertyi("tu154ce/switchers/console/absu_turn_handle")) 
defineProperty("absu_pitch_wheel_dir", globalPropertyi("tu154ce/switchers/console/absu_pitch_wheel_dir")) 
defineProperty("pkp_course_L", globalPropertyf("tu154ce/gauges/compas/pkp_helper_course_L")) 
defineProperty("pkp_course_R", globalPropertyf("tu154ce/gauges/compas/pkp_helper_course_R")) 
local AP_stab = findCommand("sim/autopilot/fdir_on")
function AP_stab_hnd(phase)
	if 1 == phase then
		set(absu_stab, 1)
	else 
		set(absu_stab, 0)
	end
	return 0
end
registerCommandHandler(AP_stab, 0, AP_stab_hnd)
local AP_AT = findCommand("sim/autopilot/autothrottle_toggle")
function AP_AT_hnd(phase)
	if 1 == phase then
		set(absu_stab_speed, 1)
	else 
		set(absu_stab_speed, 0)
	end
	return 0
end
registerCommandHandler(AP_AT, 0, AP_AT_hnd)
local AP_ZK = findCommand("sim/autopilot/heading")
function AP_ZK_hnd(phase)
	if 1 == phase then
		set(absu_zk, 1)
	else 
		set(absu_zk, 0)
	end
	return 0
end
registerCommandHandler(AP_ZK, 0, AP_ZK_hnd)
local AP_wing_level = findCommand("sim/autopilot/wing_leveler")
function AP_wing_level_hnd(phase)
	if 1 == phase then
		set(absu_turn_handle, 0)
	else 
	end
	return 0
end
registerCommandHandler(AP_wing_level, 0, AP_wing_level_hnd)
local AP_turn_left = findCommand("sim/autopilot/override_left")
function AP_turn_left_hnd(phase)
	if 0 == phase then
		local a = get(absu_turn_handle)
		a = a - 5
		if a < -50 then a = -50 end
		set(absu_turn_handle, a)
	else 
	end
	return 0
end
registerCommandHandler(AP_turn_left, 0, AP_turn_left_hnd)
local AP_turn_right = findCommand("sim/autopilot/override_right")
function AP_turn_right_hnd(phase)
	if 0 == phase then
		local a = get(absu_turn_handle)
		a = a + 5
		if a > 50 then a = 50 end
		set(absu_turn_handle, a)
	else 
	end
	return 0
end
registerCommandHandler(AP_turn_right, 0, AP_turn_right_hnd)
local AP_NVU = findCommand("sim/autopilot/NAV")
function AP_NVU_hnd(phase)
	if 1 == phase then
		set(absu_nvu, 1)
	else 
		set(absu_nvu, 0)
	end
	return 0
end
registerCommandHandler(AP_NVU, 0, AP_NVU_hnd)
local AP_stab_V = findCommand("sim/autopilot/airspeed_sync")
function AP_stab_V_hnd(phase)
	if 1 == phase then
		set(absu_stab_v, 1)
	else 
		set(absu_stab_v, 0)
	end
	return 0
end
registerCommandHandler(AP_stab_V, 0, AP_stab_V_hnd)
local AP_stab_M = findCommand("sim/autopilot/level_change")
function AP_stab_M_hnd(phase)
	if 1 == phase then
		set(absu_stab_m, 1)
	else 
		set(absu_stab_m, 0)
	end
	return 0
end
registerCommandHandler(AP_stab_M, 0, AP_stab_M_hnd)
local AP_stab_H = findCommand("sim/autopilot/altitude_hold")
function AP_stab_H_hnd(phase)
	if 1 == phase then
		set(absu_stab_h, 1)
	else 
		set(absu_stab_h, 0)
	end
	return 0
end
registerCommandHandler(AP_stab_H, 0, AP_stab_H_hnd)
local AP_stab_H = findCommand("sim/autopilot/altitude_hold")
function AP_stab_H_hnd(phase)
	if 1 == phase then
		set(absu_stab_h, 1)
	else 
		set(absu_stab_h, 0)
	end
	return 0
end
registerCommandHandler(AP_stab_H, 0, AP_stab_H_hnd)
local AP_GS = findCommand("sim/autopilot/glide_slope")
function AP_GS_hnd(phase)
	if 1 == phase then
		set(absu_gs, 1)
	else 
		set(absu_gs, 0)
	end
	return 0
end
registerCommandHandler(AP_GS, 0, AP_GS_hnd)
local AP_APP = findCommand("sim/autopilot/approach")
function AP_APP_hnd(phase)
	if 1 == phase then
		set(absu_app, 1)
	else 
		set(absu_app, 0)
	end
	return 0
end
registerCommandHandler(AP_APP, 0, AP_APP_hnd)
local AP_down = findCommand("sim/autopilot/nose_down")
function AP_down_hnd(phase)
	if 1 == phase then
		set(absu_pitch_wheel_dir, -1)
	else 
		set(absu_pitch_wheel_dir, 0)
	end
	return 0
end
registerCommandHandler(AP_down, 0, AP_down_hnd)
local AP_up = findCommand("sim/autopilot/nose_up")
function AP_up_hnd(phase)
	if 1 == phase then
		set(absu_pitch_wheel_dir, 1)
	else 
		set(absu_pitch_wheel_dir, 0)
	end
	return 0
end
registerCommandHandler(AP_up, 0, AP_up_hnd)
local AP_spd_up = findCommand("sim/autopilot/airspeed_up")
function AP_spd_up_hnd(phase)
	if 1 == phase then
		set(absu_speed_change, 1)
	else 
		set(absu_speed_change, 0)
	end
	return 0
end
registerCommandHandler(AP_spd_up, 0, AP_spd_up_hnd)
local AP_spd_down = findCommand("sim/autopilot/airspeed_down")
function AP_spd_down_hnd(phase)
	if 1 == phase then
		set(absu_speed_change, -1)
	else 
		set(absu_speed_change, 0)
	end
	return 0
end
registerCommandHandler(AP_spd_down, 0, AP_spd_down_hnd)
local PNP_head_left_L = findCommand("sim/autopilot/heading_down")
function PNP_head_left_L_hnd(phase)
	if 1 == phase then
		set(pkp_course_L, get(pkp_course_L) - 1)
	else 
	end
	return 0
end
registerCommandHandler(PNP_head_left_L, 0, PNP_head_left_L_hnd)
local PNP_head_right_L = findCommand("sim/autopilot/heading_up")
function PNP_head_right_L_hnd(phase)
	if 1 == phase then
		set(pkp_course_L, get(pkp_course_L) + 1)
	else 
	end
	return 0
end
registerCommandHandler(PNP_head_right_L, 0, PNP_head_right_L_hnd)
local PNP_head_left_R = findCommand("sim/autopilot/heading_copilot_down")
function PNP_head_left_R_hnd(phase)
	if 1 == phase then
		set(pkp_course_R, get(pkp_course_R) - 1)
	else 
	end
	return 0
end
registerCommandHandler(PNP_head_left_R, 0, PNP_head_left_R_hnd)
local PNP_head_right_R = findCommand("sim/autopilot/heading_copilot_up")
function PNP_head_right_R_hnd(phase)
	if 1 == phase then
		set(pkp_course_R, get(pkp_course_R) + 1)
	else 
	end
	return 0
end
registerCommandHandler(PNP_head_right_R, 0, PNP_head_right_R_hnd)
