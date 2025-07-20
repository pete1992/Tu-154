defineProperty("ias_left", globalPropertyf("tu154ce/gauges/speed/ias_left")) 
defineProperty("ias_right", globalPropertyf("tu154ce/gauges/speed/ias_right")) 
defineProperty("absu_speed_change", globalPropertyi("tu154ce/switchers/console/absu_speed_change")) 
defineProperty("absu_speed_off", globalPropertyi("tu154ce/switchers/console/absu_speed_off")) 
defineProperty("absu_speed_prepare", globalPropertyi("tu154ce/switchers/console/absu_speed_prepare")) 
defineProperty("absu_speed_us_right_left", globalPropertyi("tu154ce/switchers/console/absu_speed_us_right_left")) 
defineProperty("absu_stab_speed", globalPropertyi("tu154ce/buttons/console/absu_stab_speed")) 
defineProperty("absu_throt_off_1", globalPropertyi("tu154ce/buttons/console/absu_throt_off_1")) 
defineProperty("absu_throt_off_2", globalPropertyi("tu154ce/buttons/console/absu_throt_off_2")) 
defineProperty("absu_throt_off_3", globalPropertyi("tu154ce/buttons/console/absu_throt_off_3")) 
defineProperty("anim_rud1", globalPropertyf("tu154ce/controlls/throttle_1")) 
defineProperty("anim_rud2", globalPropertyf("tu154ce/controlls/throttle_2")) 
defineProperty("anim_rud3", globalPropertyf("tu154ce/controlls/throttle_3")) 
defineProperty("tro_comm_1", globalPropertyf("tu154ce/SC/engine/ENGN_thro_0")) 
defineProperty("tro_comm_2", globalPropertyf("tu154ce/SC/engine/ENGN_thro_1")) 
defineProperty("tro_comm_3", globalPropertyf("tu154ce/SC/engine/ENGN_thro_2"))
defineProperty("absu_nav_on", globalPropertyi("tu154ce/switchers/console/absu_nav_on")) 
defineProperty("absu_landing_on", globalPropertyi("tu154ce/switchers/console/absu_landing_on")) 
defineProperty("roll_main_mode", globalPropertyi("tu154ce/absu/roll_main_mode")) 
defineProperty("pitch_main_mode", globalPropertyi("tu154ce/absu/pitch_main_mode")) 
defineProperty("roll_sub_mode", globalPropertyi("tu154ce/absu/roll_sub_mode")) 
defineProperty("pitch_sub_mode", globalPropertyi("tu154ce/absu/pitch_sub_mode")) 
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("bus36_volt_left", globalPropertyf("tu154ce/elec/bus36_volt_left"))
defineProperty("bus115_1_volt", globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("absu_at_power_cc", globalPropertyf("tu154ce/absu_at_power_cc")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("ias_yellow_left", globalPropertyf("tu154ce/gauges/speed/ias_yellow_left")) 
defineProperty("ias_yellow_right", globalPropertyf("tu154ce/gauges/speed/ias_yellow_right")) 
defineProperty("absu_at_dif_left", globalPropertyf("tu154ce/absu_at_dif_left")) 
defineProperty("absu_at_dif_right", globalPropertyf("tu154ce/absu_at_dif_right")) 
defineProperty("rud_1_spd", globalPropertyf("tu154ce/absu/rud_1_spd")) 
defineProperty("rud_2_spd", globalPropertyf("tu154ce/absu/rud_2_spd")) 
defineProperty("rud_3_spd", globalPropertyf("tu154ce/absu/rud_3_spd")) 
defineProperty("stu_mode", globalPropertyi("tu154ce/absu/stu_mode")) 
defineProperty("toga_command", globalPropertyi("tu154ce/absu/toga_comm")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
defineProperty("absu_at1_fail", globalPropertyi("tu154ce/failures/absu_at1_fail")) 
defineProperty("absu_at2_fail", globalPropertyi("tu154ce/failures/absu_at2_fail")) 
defineProperty("sim_vers", globalPropertyi("sim/version/xplane_internal_version")) 
local AT_mode = 0 
local THR_dn = findCommand("sim/engines/throttle_down")
function THR_dn_hnd(phase)
	if 1 == phase then
		if get(stu_mode) > 2 then set(stu_mode, 2) end
	end
	return 0
end
registerCommandHandler(THR_dn, 0, THR_dn_hnd)
local THR_up = findCommand("sim/engines/throttle_up")
function THR_up_hnd(phase)
	if 1 == phase then
		if get(stu_mode) > 2 then set(stu_mode, 2) end
	end
	return 0
end
registerCommandHandler(THR_up, 0, THR_up_hnd)
local spd_hold = 0
local IAS_smth = 0
local prepare_counter = 0
local rud_chng = false
local rud_last = get(tro_comm_1) + get(tro_comm_2) + get(tro_comm_3)
local rud_last_1 = get(tro_comm_1)
local rud_last_2 = get(tro_comm_2)
local rud_last_3 = get(tro_comm_3)
local marker_act_L = get(ias_left)
local marker_act_R = get(ias_right)
IAS_last = 0
local stab_counter = 0
local spd_diff_ind_L = 0
local spd_diff_ind_R = 0
function update()
	local MASTER = get(ismaster) ~= 1
	local passed = get(frame_time)
	local channel_off = get(absu_speed_off) 
	local power = get(bus36_volt_left) > 30 and get(bus115_1_volt) > 110 and (get(bus27_volt_left) > 13 or get(bus27_volt_right) > 13)
	local at_1_work = bool2int(get(bus27_volt_left) > 13 and channel_off ~= 1 and get(absu_at1_fail) == 0) 
	local at_2_work = bool2int(get(bus27_volt_right) > 13 and channel_off ~= -1 and get(absu_at2_fail) == 0)
	local prepare = get(absu_speed_prepare) == 1
	local rud_now = get(tro_comm_1) + get(tro_comm_2) + get(tro_comm_3)
	local rud_work_1 = (1 - get(absu_throt_off_1))
	local rud_work_2 = (1 - get(absu_throt_off_2))
	local rud_work_3 = (1 - get(absu_throt_off_3))
	local rud_now_1 = get(tro_comm_1)
	local rud_now_2 = get(tro_comm_2)
	local rud_now_3 = get(tro_comm_3)
	local stu_roll_ready = get(roll_main_mode) > 0 and get(absu_nav_on) == 1
	local stu_pitch_ready = get(pitch_main_mode) > 0 and get(absu_landing_on) == 1
	local stab_button = get(absu_stab_speed) == 1
	AT_mode = get(stu_mode)
	if not power then 
		AT_mode = 0 
	elseif at_1_work + at_2_work == 0 then 
		AT_mode = -1
	elseif prepare_counter < 1 and power then 
		AT_mode = 1 
	elseif power and prepare and prepare_counter >= 1 and AT_mode == 1 then 
		AT_mode = 2 
	elseif power and prepare and rud_work_1 + rud_work_2 + rud_work_3 > 1 and stab_button and AT_mode == 2 and stab_counter > 0.1 then 
		AT_mode = 3 
		rud_last = rud_now
		rud_last_1 = rud_now_1
		rud_last_2 = rud_now_2
		rud_last_3 = rud_now_3
		stab_counter = 0
	elseif power and prepare and AT_mode == 3 and stu_pitch_ready and get(pitch_sub_mode) == 6 then
		AT_mode = 4 
		rud_last = rud_now
		rud_last_1 = rud_now_1
		rud_last_2 = rud_now_2
		rud_last_3 = rud_now_3
		stab_counter = 0
	elseif rud_work_1 + rud_work_2 + rud_work_3 < 2 and AT_mode >= 3 then 
		AT_mode = 2 
		stab_counter = 0
	elseif rud_chng and AT_mode >= 3 then
		AT_mode = 2 
		stab_counter = 0
	elseif AT_mode == 4 and get(anim_rud1) > 0.98 * rud_work_1 and get(anim_rud2) > 0.98 * rud_work_2 and get(anim_rud3) > 0.98 * rud_work_3 then
		AT_mode = 2 
		stab_counter = 0
	elseif stab_counter > 0.1 and stab_button and AT_mode > 2 then
		AT_mode = 2 
		stab_counter = 0
	end
	if not stab_button then stab_counter = stab_counter + passed end
	if MASTER then set(stu_mode, AT_mode) end
	if power and prepare then prepare_counter = prepare_counter + passed 
	else prepare_counter = 0
	end
	if prepare_counter > 1 then prepare_counter = 1 end
	local rud_moved = bool2int(math.abs(rud_last_1 - rud_now_1) > 0.1 and rud_work_1 == 1) + bool2int(math.abs(rud_last_2 - rud_now_2) > 0.1 and rud_work_2 == 1) + bool2int(math.abs(rud_last_3 - rud_now_3) > 0.1 and rud_work_3 == 1)
	if rud_moved > 1 then
		rud_last = rud_now
		rud_last_1 = rud_now_1
		rud_last_2 = rud_now_2
		rud_last_3 = rud_now_3
		rud_chng = true
	else 
		rud_chng = false
	end
	local IAS = get(ias_left)
	marker_act_L = get(ias_yellow_left)
	marker_act_R = get(ias_yellow_right)
	local source = 1 - get(absu_speed_us_right_left)
	if source == 1 then 
		IAS = get(ias_right)
	end
	IAS_smth = IAS_smth + (IAS - IAS_smth) * passed * 2
	if AT_mode == 1 or AT_mode == 2 then 
		marker_act_L = marker_act_L + (IAS_smth - marker_act_L) * passed * 2
		marker_act_R = marker_act_R + (IAS_smth - marker_act_R) * passed * 2
		set(rud_1_spd, 0)
		set(rud_2_spd, 0)
		set(rud_3_spd, 0)
		spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
		spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
	elseif AT_mode == 3 then 
		local work_spd = 0
		if source == 0 then 
			marker_act_L = marker_act_L + get(absu_speed_change) * passed * 4
			marker_act_R = marker_act_R + (IAS_smth - marker_act_R) * passed * 2
			work_spd = marker_act_L
			spd_diff_ind_L = IAS_smth - marker_act_L
			spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
		else
			marker_act_R = marker_act_R + get(absu_speed_change) * passed * 4
			marker_act_L = marker_act_L + (IAS_smth - marker_act_L) * passed * 2
			work_spd = marker_act_R
			spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
			spd_diff_ind_R =  IAS_smth - marker_act_R
		end
		local P = work_spd - IAS_smth
		local D = 0 
		if passed ~= 0 then D = (IAS_smth - IAS_last) / passed end
		IAS_last = IAS_smth
		local K_P = 0.015
		local K_D = -0.11
if get(sim_vers) then
	if get(sim_vers) >= 111000 then
		K_P = 0.008
		K_D = -0.05
	end
end		
		local main_rud_spd = P * K_P + D * K_D
		if main_rud_spd > 0.3 then main_rud_spd = 0.3
		elseif main_rud_spd < -0.3 then main_rud_spd = -0.3 end
		local rud_current = (get(anim_rud1) + get(anim_rud2) + get(anim_rud3)) / 3
		if rud_current > 0.95 and main_rud_spd > 0 then main_rud_spd = 0 end 
		local rud_spd_1 = main_rud_spd * math.random(95, 105) * 0.01
		local rud_spd_2 = main_rud_spd * math.random(95, 105) * 0.01
		local rud_spd_3 = main_rud_spd * math.random(95, 105) * 0.01
		if MASTER then
			set(rud_1_spd, rud_spd_1 * rud_work_1 * (at_1_work + at_2_work) * 0.6)
			set(rud_2_spd, rud_spd_2 * rud_work_2 * (at_1_work + at_2_work) * 0.6)
			set(rud_3_spd, rud_spd_3 * rud_work_3 * (at_1_work + at_2_work) * 0.6)
		end
	elseif AT_mode == 4 then 
		marker_act_L = marker_act_L + (IAS_smth - marker_act_L) * passed * 2
		marker_act_R = marker_act_R + (IAS_smth - marker_act_R) * passed * 2
		if MASTER then
			set(rud_1_spd, 0.3 * rud_work_1 * (at_1_work + at_2_work) * 0.6)
			set(rud_2_spd, 0.3 * rud_work_2 * (at_1_work + at_2_work) * 0.6)
			set(rud_3_spd, 0.3 * rud_work_3 * (at_1_work + at_2_work) * 0.6)
		end
		spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
		spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
	else
		set(rud_1_spd, 0)
		set(rud_2_spd, 0)
		set(rud_3_spd, 0)
		spd_diff_ind_L = spd_diff_ind_L - spd_diff_ind_L * passed
		spd_diff_ind_R = spd_diff_ind_R - spd_diff_ind_R * passed
	end
	if marker_act_L > 350 then marker_act_L = 350
	elseif marker_act_L < 0 then marker_act_L = 0 end
	if marker_act_R > 350 then marker_act_R = 350
	elseif marker_act_R < 0 then marker_act_R = 0 end
if MASTER then
	set(ias_yellow_left, marker_act_L)
	set(ias_yellow_right, marker_act_R)
	if get(toga_command) == 1 and AT_mode ~= 4 then 
		set(rud_1_spd, -0.00001)
		set(rud_2_spd, -0.00001)
		set(rud_3_spd, -0.00001)
	end
end
	set(absu_at_dif_left, spd_diff_ind_L)
	set(absu_at_dif_right, spd_diff_ind_R)
	set(absu_at_power_cc, bool2int(power and channel_off ~= 1) + bool2int(power and channel_off ~= -1))
end
