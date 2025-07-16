defineProperty("nvu_param_sel", globalPropertyi("sim/custom/switchers/console/nvu_param_sel")) 
defineProperty("nvu_turn_sel", globalPropertyi("sim/custom/switchers/console/nvu_turn_sel")) 
defineProperty("nvu_power_on", globalPropertyi("sim/custom/switchers/console/nvu_power_on")) 
defineProperty("nvu_calc_on", globalPropertyi("sim/custom/switchers/console/nvu_calc_on")) 
defineProperty("nvu_corr_on", globalPropertyi("sim/custom/switchers/console/nvu_corr_on")) 
defineProperty("nvu_left_btn", globalPropertyi("sim/custom/buttons/nvu/nvu_left_btn")) 
defineProperty("nvu_ctr_btn", globalPropertyi("sim/custom/buttons/nvu/nvu_ctr_btn")) 
defineProperty("nvu_right_btn", globalPropertyi("sim/custom/buttons/nvu/nvu_right_btn")) 
defineProperty("zpu_1_left_btn", globalPropertyi("sim/custom/buttons/nvu/zpu_1_left_btn")) 
defineProperty("zpu_1_ctr_btn", globalPropertyi("sim/custom/buttons/nvu/zpu_1_ctr_btn")) 
defineProperty("zpu_1_right_btn", globalPropertyi("sim/custom/buttons/nvu/zpu_1_right_btn")) 
defineProperty("zpu_2_left_btn", globalPropertyi("sim/custom/buttons/nvu/zpu_2_left_btn")) 
defineProperty("zpu_2_ctr_btn", globalPropertyi("sim/custom/buttons/nvu/zpu_2_ctr_btn")) 
defineProperty("zpu_2_right_btn", globalPropertyi("sim/custom/buttons/nvu/zpu_2_right_btn")) 
defineProperty("map_angle", globalPropertyf("sim/custom/gauges/console/map_angle")) 
defineProperty("course_gpk", globalPropertyf("sim/custom/tks/course_gpk")) 
defineProperty("course_gmk", globalPropertyf("sim/custom/tks/course_gmk")) 
defineProperty("compas_knob", globalPropertyf("sim/custom/gauges/misc/compas_knob")) 
defineProperty("diss_groundspeed", globalPropertyf("sim/custom/nvu/diss_groundspeed")) 
defineProperty("diss_slip_angle", globalPropertyf("sim/custom/nvu/diss_slip_angle")) 
defineProperty("distance", globalPropertyf("sim/custom/rsbn/distance")) 
defineProperty("azimuth", globalPropertyf("sim/custom/rsbn/azimuth")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("rsbn_distance", globalPropertyf("sim/custom/rsbn/distance")) 
defineProperty("rsbn_azimuth", globalPropertyf("sim/custom/rsbn/azimuth")) 
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left"))
defineProperty("bus36_volt_left", globalPropertyf("sim/custom/elec/bus36_volt_left"))
defineProperty("bus115_1_volt", globalPropertyf("sim/custom/elec/bus115_1_volt"))
defineProperty("nvu_mode", globalPropertyi("sim/custom/nvu/nvu_mode")) 
defineProperty("nvu_active", globalPropertyi("sim/custom/nvu/nvu_active")) 
defineProperty("nvu_res_course", globalPropertyf("sim/custom/nvu/nvu_res_course")) 
defineProperty("nvu_res_z", globalPropertyf("sim/custom/nvu/nvu_res_z")) 
defineProperty("nvu_changing_ort", globalPropertyi("sim/custom/nvu/nvu_changing_ort")) 
defineProperty("nvu_fail_signal", globalPropertyi("sim/custom/nvu/nvu_fail")) 
defineProperty("nvu_cc", globalPropertyf("sim/custom/nvu/nvu_cc")) 
defineProperty("current_Z1", globalPropertyf("sim/custom/nvu/current_Z1")) 
defineProperty("current_S1", globalPropertyf("sim/custom/nvu/current_S1")) 
defineProperty("next_Z1", globalPropertyf("sim/custom/nvu/next_Z1")) 
defineProperty("next_S1", globalPropertyf("sim/custom/nvu/next_S1")) 
defineProperty("current_Z2", globalPropertyf("sim/custom/nvu/current_Z2")) 
defineProperty("current_S2", globalPropertyf("sim/custom/nvu/current_S2")) 
defineProperty("next_Z2", globalPropertyf("sim/custom/nvu/next_Z2")) 
defineProperty("next_S2", globalPropertyf("sim/custom/nvu/next_S2")) 
defineProperty("zpu1", globalPropertyf("sim/custom/nvu/zpu1")) 
defineProperty("zpu2", globalPropertyf("sim/custom/nvu/zpu2")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
defineProperty("nvu_fail", globalPropertyi("sim/custom/failures/nvu_fail")) 
local nvu_switched = false
local change_cho_timer = 10
local change_timer = 0
function update()
	local MASTER = get(ismaster) ~= 1	
	local passed = get(frame_time)
	local power = get(nvu_power_on) == 1 and get(bus27_volt_left) > 13 and get(bus36_volt_left) > 30 and get(bus115_1_volt) > 110
	local fail = get(nvu_fail) == 1
	set(nvu_cc, bool2int(power))
	local calc_on = get(nvu_calc_on) == 1
	local corr_on = get(nvu_corr_on) == 1
	local dist = get(rsbn_distance) 
	local mode = 0
	if power then
		mode = 1
		if calc_on and not fail then 
			mode = 2
		end
		if corr_on and dist > 0.1 and not fail then  
			mode = 3 
		end
	end
	local cur_Z1 = get(current_Z1) 
	local cur_S1 = get(current_S1)
	local nxt_Z1 = get(next_Z1) 
	local nxt_S1 = get(next_S1)
	local cur_Z2 = get(current_Z2) 
	local cur_S2 = get(current_S2)
	local nxt_Z2 = get(next_Z2) 
	local nxt_S2 = get(next_S2)
	local active = get(nvu_active)
	change_timer = change_timer + passed
	if power then 
		local selector = get(nvu_turn_sel)
		local dist_sel = math.max(selector, 0) * 5
		if active == 1 and (change_timer > 5 or selector == -1) then
			if cur_S1 >= -dist_sel and dist_sel > 0 then 
				active = 2 
			elseif cur_S1 >= -dist_sel - 2 and dist_sel > 0 then
				change_cho_timer = 0			
			elseif not nvu_switched and selector == -1 then 
				nvu_switched = true
				active = 2
				change_cho_timer = 0
			end
			change_timer = 0	
		elseif active == 2 and (change_timer > 5 or selector == -1) then
			if cur_S2 >= -dist_sel and dist_sel > 0 then 
				active = 1
			elseif cur_S2 >= -dist_sel - 2 and dist_sel > 0 then
				change_cho_timer = 0
			elseif not nvu_switched and selector == -1 then 
				nvu_switched = true
				active = 1
				change_cho_timer = 0
			end
			change_timer = 0
		end
		if selector >= 0 then nvu_switched = false end 
	end
	change_cho_timer = change_cho_timer + passed
if MASTER then	
	if change_cho_timer < 10 then set(nvu_changing_ort, 1)
	else set(nvu_changing_ort, 0) end
end	
	local zpu_1 = get(zpu1)
	local zpu_2 = get(zpu2)
	local but_zpu_L1 = get(zpu_1_left_btn)
	local but_zpu_C1 = get(zpu_1_ctr_btn)
	local but_zpu_R1 = get(zpu_1_right_btn)
	local but_zpu_L2 = get(zpu_2_left_btn)
	local but_zpu_C2 = get(zpu_2_ctr_btn)
	local but_zpu_R2 = get(zpu_2_right_btn)
	if power then	
		zpu_1 = zpu_1 + (but_zpu_R1 - but_zpu_L1) * (0.5 + 30 * but_zpu_C1) * passed
		zpu_2 = zpu_2 + (but_zpu_R2 - but_zpu_L2) * (0.5 + 30 * but_zpu_C2) * passed
	end
	if zpu_1 > 360 then zpu_1 = zpu_1 - 360
	elseif zpu_1 < 0 then zpu_1 = zpu_1 + 360 end
	if zpu_2 > 360 then zpu_2 = zpu_2 - 360
	elseif zpu_2 < 0 then zpu_2 = zpu_2 + 360 end	
if MASTER then	
	set(zpu1, zpu_1)
	set(zpu2, zpu_2)
end
	local nvu_but_L = get(nvu_left_btn)
	local nvu_but_C = get(nvu_ctr_btn)
	local nvu_but_R = get(nvu_right_btn)
	local parameter_sel = get(nvu_param_sel) 
	if active == 1 and power then
		if parameter_sel == -4 or parameter_sel == 4 then
			cur_Z1 = cur_Z1 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == -3 or parameter_sel == 3 then
			cur_S1 = cur_S1 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == -2 then
			nxt_Z1 = nxt_Z1 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == -1 then
			nxt_S1 = nxt_S1 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == 1 then
			nxt_S2 = nxt_S2 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == 2 then
			nxt_Z2 = nxt_Z2 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		end
	elseif active == 2 and power then
		if parameter_sel == -4 or parameter_sel == 4 then
			cur_Z2 = cur_Z2 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == -3 or parameter_sel == 3 then
			cur_S2 = cur_S2 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == -2 then
			nxt_Z2 = nxt_Z2 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == -1 then
			nxt_S2 = nxt_S2 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == 1 then
			nxt_S1 = nxt_S1 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		elseif parameter_sel == 2 then
			nxt_Z1 = nxt_Z1 + (nvu_but_R - nvu_but_L) * (1 + 19 * nvu_but_C) * passed
		end		
	end
	local gpk_course = get(course_gpk) 
	local correct_course = get(compas_knob)
	local slip_angle = get(diss_slip_angle) 
	local groundspeed = get(diss_groundspeed) / 3600 
	if groundspeed * 3600 < 180 then groundspeed = 0 end
	if mode == 2 then 
		if active == 1 then
			local delta_course = math.rad(gpk_course + correct_course + slip_angle - zpu_1)
			cur_S1 = cur_S1 + groundspeed * math.cos(delta_course) * passed
			cur_Z1 = cur_Z1 + groundspeed * math.sin(delta_course) * passed
			local delta_zpu = math.rad(zpu_1 - zpu_2)
			cur_S2 = nxt_S2 + cur_S1 * math.cos(delta_zpu) - cur_Z1 * math.sin(delta_zpu)
			cur_Z2 = nxt_Z2 + cur_S1 * math.sin(delta_zpu) + cur_Z1 * math.cos(delta_zpu)
			SПР = SC1 cos ЗПУ – ZC1 sin ЗПУ;
            ZПР = SC1 sin ЗПУ + ZC1 cos ЗПУ.
		elseif active == 2 then
			local delta_course = math.rad(gpk_course + correct_course + slip_angle - zpu_2)
			cur_S2 = cur_S2 + groundspeed * math.cos(delta_course) * passed
			cur_Z2 = cur_Z2 + groundspeed * math.sin(delta_course) * passed
			local delta_zpu = math.rad(zpu_2 - zpu_1)
			cur_S1 = nxt_S1 + cur_S2 * math.cos(delta_zpu) - cur_Z2 * math.sin(delta_zpu)
			cur_Z1 = nxt_Z1 + cur_S2 * math.sin(delta_zpu) + cur_Z2 * math.cos(delta_zpu)
		end
	elseif mode == 3 then 
		local alpha = math.rad(get(rsbn_azimuth) - get(map_angle))
		local S_rsbn = dist * math.cos(alpha)
		local Z_rsbn = dist * math.sin(alpha)
		if active == 1 then
			cur_S1 = nxt_S1 + S_rsbn
			cur_Z1 = nxt_Z1 + Z_rsbn
			local delta_zpu = math.rad(zpu_1 - zpu_2)
			cur_S2 = nxt_S2 + cur_S1 * math.cos(delta_zpu) - cur_Z1 * math.sin(delta_zpu)
			cur_Z2 = nxt_Z2 + cur_S1 * math.sin(delta_zpu) + cur_Z1 * math.cos(delta_zpu)
		elseif active == 2 then
			cur_S2 = nxt_S2 + S_rsbn
			cur_Z2 = nxt_Z2 + Z_rsbn
			local delta_zpu = math.rad(zpu_2 - zpu_1)
			cur_S1 = nxt_S1 + cur_S2 * math.cos(delta_zpu) - cur_Z2 * math.sin(delta_zpu)
			cur_Z1 = nxt_Z1 + cur_S2 * math.sin(delta_zpu) + cur_Z2 * math.cos(delta_zpu)
		end	
	end
	if cur_S1 > 950 then cur_S1 = 950
	elseif cur_S1 < -950 then cur_S1 = -950 end
	if cur_Z1 > 500 then cur_Z1 = 500
	elseif cur_Z1 < -500 then cur_Z1 = -500 end
	if nxt_S1 > 950 then nxt_S1 = 950
	elseif nxt_S1 < -950 then nxt_S1 = -950 end
	if nxt_Z1 > 500 then nxt_Z1 = 500
	elseif nxt_Z1 < -500 then nxt_Z1 = -500 end
	if cur_S2 > 950 then cur_S2 = 950
	elseif cur_S2 < -950 then cur_S2 = -950 end
	if cur_Z2 > 500 then cur_Z2 = 500
	elseif cur_Z2 < -500 then cur_Z2 = -500 end
	if nxt_S2 > 950 then nxt_S2 = 950
	elseif nxt_S2 < -950 then nxt_S2 = -950 end
	if nxt_Z2 > 500 then nxt_Z2 = 500
	elseif nxt_Z2 < -500 then nxt_Z2 = -500 end	
if MASTER then	
	if active == 1 then
		set(nvu_res_course, zpu_1 + correct_course)
		set(nvu_res_z, cur_Z1)
	elseif active == 2 then
		set(nvu_res_course, zpu_2 + correct_course)
		set(nvu_res_z, cur_Z2)
	end
	set(nvu_fail_signal, bool2int(power and fail))
	set(nvu_mode, mode)
	set(nvu_active, active)
	set(current_Z1, cur_Z1)
	set(current_S1, cur_S1)
	set(next_Z1, nxt_Z1)
	set(next_S1, nxt_S1)
	set(current_Z2, cur_Z2)
	set(current_S2, cur_S2)
	set(next_Z2, nxt_Z2)
	set(next_S2, nxt_S2)	
end
end