defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("side",globalPropertyi("tu154ce/checklist/side")) 
defineProperty("fishka_1",globalPropertyi("tu154ce/checklist/fishka_1")) 
defineProperty("fishka_2",globalPropertyi("tu154ce/checklist/fishka_2")) 
defineProperty("fishka_3",globalPropertyi("tu154ce/checklist/fishka_3")) 
defineProperty("fishka_4",globalPropertyi("tu154ce/checklist/fishka_4")) 
defineProperty("fishka_5",globalPropertyi("tu154ce/checklist/fishka_5")) 
defineProperty("fishka_6",globalPropertyi("tu154ce/checklist/fishka_6")) 
defineProperty("fishka_7",globalPropertyi("tu154ce/checklist/fishka_7")) 
defineProperty("fishka_8",globalPropertyi("tu154ce/checklist/fishka_8")) 
defineProperty("fishka_9",globalPropertyi("tu154ce/checklist/fishka_9")) 
defineProperty("fishka_10",globalPropertyi("tu154ce/checklist/fishka_10")) 
defineProperty("fishka_11",globalPropertyi("tu154ce/checklist/fishka_11")) 
defineProperty("fishka_12",globalPropertyi("tu154ce/checklist/fishka_12")) 
defineProperty("fishka_13",globalPropertyi("tu154ce/checklist/fishka_13")) 
defineProperty("fishka_14",globalPropertyi("tu154ce/checklist/fishka_14")) 
defineProperty("fishka_15",globalPropertyi("tu154ce/checklist/fishka_15")) 
defineProperty("fishka_16",globalPropertyi("tu154ce/checklist/fishka_16")) 
defineProperty("fishka_17",globalPropertyi("tu154ce/checklist/fishka_17")) 
defineProperty("fishka_18",globalPropertyi("tu154ce/checklist/fishka_18")) 
defineProperty("fishka_19",globalPropertyi("tu154ce/checklist/fishka_19")) 
defineProperty("fishka_20",globalPropertyi("tu154ce/checklist/fishka_20")) 
defineProperty("checklist_selected",globalPropertyi("tu154ce/checklist/checklist_selected")) 
defineProperty("pressure", globalPropertyf("tu154ce/gauges/alt/vbe_press_left"))  
defineProperty("frequency", globalPropertyf("sim/cockpit2/radios/actuators/nav1_frequency_hz"))  
defineProperty("nav_pow_cc", globalPropertyf("tu154ce/radio/nav1_pow_cc")) 
defineProperty("obs", globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_L"))  
defineProperty("ark15_cc_1", globalPropertyf("tu154ce/radio/ark15_L_cc")) 
defineProperty("ark15_cc_2", globalPropertyf("tu154ce/radio/ark15_R_cc")) 
defineProperty("absu_landing_on", globalPropertyi("tu154ce/switchers/console/absu_landing_on")) 
defineProperty("absu_speed_prepare", globalPropertyi("tu154ce/switchers/console/absu_speed_prepare")) 
defineProperty("at_1_lamp", globalPropertyf("tu154ce/lights/small/at_1")) 
defineProperty("at_2_lamp", globalPropertyf("tu154ce/lights/small/at_2")) 
local checklist_started = false
local stage = 0
local stage_status = 0 
local speak_timer = 0
function checklist_7()
	if not checklist_started and get(checklist_selected) == 7 then 
		checklist_started = true 
		stage = 1
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["pressure_of_the_airfield"][lang], 3}
		speak_timer = 3
	end
	if get(checklist_selected) ~= 7 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	if checklist_started then
		if stage == 1 and get(fishka_15) == 0 then stage = 2 stage_status = 0 end 
		if stage == 2 and get(fishka_16) == 0 then stage = 3 stage_status = 0 end 
		if stage == 3 and get(fishka_17) == 0 then stage = 4 stage_status = 0 end 
		if stage == 4 and get(fishka_18) == 0 then stage = 5 stage_status = 0 end 
		if stage == 5 and get(fishka_19) == 0 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end 
	end
	if stage == 1 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["altimeters"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and get(mars_on) ~= 1 and get(bus27_volt_left) < 13 and get(bus27_volt_right) < 13 then
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["pressure_set_to"][lang], 1.5}
			capt_say_num(get(pressure), 4, lang)
			speak_timer = 5
			stage_status = 10 
		end
	end
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_15, 0) end
	if stage == 2 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["course_mp"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and get(nav_pow_cc) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(nav_pow_cc) ~= 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["turned_on2"][lang], 1}
			capt_say_num(get(frequency), 5, lang)
			speak_timer = 5
			stage_status = 10 
		end
	end
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_16, 0) end
	if stage == 3 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["course_PNP"][lang], 3}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 then
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(nav_pow_cc) ~= 0 then
			local crs = math.floor(get(obs) + 0.5)
			if crs == 0 then crs = 360 end
			capt_say_num(crs, 3, lang)
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_17, 0) end
	if stage == 4 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["ARK"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and get(ark15_cc_1) * get(ark15_cc_2) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(ark15_cc_1) ~= 0 and get(ark15_cc_2) ~= 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["switch_on_1"][lang], 2}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 4 and stage_status == 10 and speak_timer < 0.1 then set(fishka_18, 0) end
	if stage == 5 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["PN-5_PN-6"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and get(absu_landing_on) * get(absu_speed_prepare) * get(at_1_lamp) * get(at_2_lamp) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(absu_landing_on) * get(absu_speed_prepare) * get(at_1_lamp) * get(at_2_lamp) ~= 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["prepared"][lang], 2}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 5 and stage_status == 10 and speak_timer < 0.1 then set(fishka_19, 0) end
	speak_timer = speak_timer - passed_time
	if speak_timer < 0.2 and find_empty() > 1 then speak_timer = phrases_tbl[1][2]
	elseif speak_timer < 0.2 then speak_timer = 0
	end
	if checklist_started then
		if stage == 100 then
			checklist_started = false
			set(checklist_selected, 0)
			stage = 0
			stage_status = 0
		end
	end
end
