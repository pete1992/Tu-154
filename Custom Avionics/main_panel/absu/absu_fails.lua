defineProperty("absu_ra56_roll_fail", globalPropertyi("tu154ce/failures/absu_ra56_roll_fail")) 
defineProperty("absu_ra56_pitch_fail", globalPropertyi("tu154ce/failures/absu_ra56_pitch_fail")) 
defineProperty("absu_ra56_yaw_fail", globalPropertyi("tu154ce/failures/absu_ra56_yaw_fail")) 
defineProperty("absu_at1_fail", globalPropertyi("tu154ce/failures/absu_at1_fail")) 
defineProperty("absu_at2_fail", globalPropertyi("tu154ce/failures/absu_at2_fail")) 
defineProperty("absu_damp_roll_fail", globalPropertyi("tu154ce/failures/absu_damp_roll_fail")) 
defineProperty("absu_damp_pitch_fail", globalPropertyi("tu154ce/failures/absu_damp_pitch_fail")) 
defineProperty("absu_damp_yaw_fail", globalPropertyi("tu154ce/failures/absu_damp_yaw_fail")) 
defineProperty("absu_contr_roll_fail", globalPropertyi("tu154ce/failures/absu_contr_roll_fail")) 
defineProperty("absu_contr_pitch_fail", globalPropertyi("tu154ce/failures/absu_contr_pitch_fail")) 
defineProperty("absu_calc_toga_fail", globalPropertyi("tu154ce/failures/absu_calc_toga_fail")) 
defineProperty("absu_calc_roll_fail", globalPropertyi("tu154ce/failures/absu_calc_roll_fail")) 
defineProperty("absu_calc_pitch_fail", globalPropertyi("tu154ce/failures/absu_calc_pitch_fail")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("failures_enabled", globalPropertyi("tu154ce/failures/failures_enabled"))
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local fail_counter = 0
local check_time = math.random(15, 30)
function update()
	local passed = get(frame_time)
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		fail_counter = fail_counter + passed
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			if get(absu_at1_fail) ~= 1 then set(absu_at1_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_at2_fail) ~= 1 then set(absu_at2_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			local roll_1 = bool2int(get(absu_ra56_roll_fail) >= 1)
			local roll_2 = bool2int(get(absu_ra56_roll_fail) >= 2)
			local roll_3 = bool2int(get(absu_ra56_roll_fail) >= 3)
			if roll_1 ~= 1 then roll_1 = bool2int(math.random() < 0.00001 * FAIL * 0.3)
			elseif roll_2 ~= 1 then roll_2 = bool2int(math.random() < 0.00001 * FAIL * 0.3) 
			elseif roll_3 ~= 1 then roll_3 = bool2int(math.random() < 0.00001 * FAIL * 0.3) 
			end
			set(absu_ra56_roll_fail, roll_1 + roll_2 + roll_3)
			local pitch_1 = bool2int(get(absu_ra56_pitch_fail) >= 1)
			local pitch_2 = bool2int(get(absu_ra56_pitch_fail) >= 2)
			local pitch_3 = bool2int(get(absu_ra56_pitch_fail) >= 3)
			if pitch_1 ~= 1 then pitch_1 = bool2int(math.random() < 0.00001 * FAIL * 0.3)
			elseif pitch_2 ~= 1 then pitch_2 = bool2int(math.random() < 0.00001 * FAIL * 0.3) 
			elseif pitch_3 ~= 1 then pitch_3 = bool2int(math.random() < 0.00001 * FAIL * 0.3) 
			end
			set(absu_ra56_pitch_fail, pitch_1 + pitch_2 + pitch_3)
			local yaw_1 = bool2int(get(absu_ra56_yaw_fail) >= 1)
			local yaw_2 = bool2int(get(absu_ra56_yaw_fail) >= 2)
			local yaw_3 = bool2int(get(absu_ra56_yaw_fail) >= 3)
			if yaw_1 ~= 1 then yaw_1 = bool2int(math.random() < 0.00001 * FAIL * 0.3)
			elseif yaw_2 ~= 1 then yaw_2 = bool2int(math.random() < 0.00001 * FAIL * 0.3) 
			elseif yaw_3 ~= 1 then yaw_3 = bool2int(math.random() < 0.00001 * FAIL * 0.3) 
			end
			set(absu_ra56_yaw_fail, yaw_1 + yaw_2 + yaw_3)
			if get(absu_damp_roll_fail) ~= 1 then set(absu_damp_roll_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_damp_pitch_fail) ~= 1 then set(absu_damp_pitch_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_damp_yaw_fail) ~= 1 then set(absu_damp_yaw_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_contr_roll_fail) ~= 1 then set(absu_contr_roll_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_contr_pitch_fail) ~= 1 then set(absu_contr_pitch_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_calc_toga_fail) ~= 1 then set(absu_calc_toga_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_calc_roll_fail) ~= 1 then set(absu_calc_roll_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(absu_calc_pitch_fail) ~= 1 then set(absu_calc_pitch_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
		end
	else
		fail_counter = 0
		set(absu_ra56_roll_fail, 0)
		set(absu_ra56_pitch_fail, 0)
		set(absu_ra56_yaw_fail, 0)
		set(absu_at1_fail, 0)
		set(absu_at2_fail, 0)
		set(absu_damp_roll_fail, 0)
		set(absu_damp_pitch_fail, 0)
		set(absu_damp_yaw_fail, 0)
		set(absu_contr_roll_fail, 0)
		set(absu_contr_pitch_fail, 0)
		set(absu_calc_toga_fail, 0)
		set(absu_calc_roll_fail, 0)
		set(absu_calc_pitch_fail, 0)
	end
end
end