defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("side",globalPropertyi("sim/custom/checklist/side")) 
defineProperty("fishka_1",globalPropertyi("sim/custom/checklist/fishka_1")) 
defineProperty("fishka_2",globalPropertyi("sim/custom/checklist/fishka_2")) 
defineProperty("fishka_3",globalPropertyi("sim/custom/checklist/fishka_3")) 
defineProperty("fishka_4",globalPropertyi("sim/custom/checklist/fishka_4")) 
defineProperty("fishka_5",globalPropertyi("sim/custom/checklist/fishka_5")) 
defineProperty("fishka_6",globalPropertyi("sim/custom/checklist/fishka_6")) 
defineProperty("fishka_7",globalPropertyi("sim/custom/checklist/fishka_7")) 
defineProperty("fishka_8",globalPropertyi("sim/custom/checklist/fishka_8")) 
defineProperty("fishka_9",globalPropertyi("sim/custom/checklist/fishka_9")) 
defineProperty("fishka_10",globalPropertyi("sim/custom/checklist/fishka_10")) 
defineProperty("fishka_11",globalPropertyi("sim/custom/checklist/fishka_11")) 
defineProperty("fishka_12",globalPropertyi("sim/custom/checklist/fishka_12")) 
defineProperty("fishka_13",globalPropertyi("sim/custom/checklist/fishka_13")) 
defineProperty("fishka_14",globalPropertyi("sim/custom/checklist/fishka_14")) 
defineProperty("fishka_15",globalPropertyi("sim/custom/checklist/fishka_15")) 
defineProperty("fishka_16",globalPropertyi("sim/custom/checklist/fishka_16")) 
defineProperty("fishka_17",globalPropertyi("sim/custom/checklist/fishka_17")) 
defineProperty("fishka_18",globalPropertyi("sim/custom/checklist/fishka_18")) 
defineProperty("fishka_19",globalPropertyi("sim/custom/checklist/fishka_19")) 
defineProperty("fishka_20",globalPropertyi("sim/custom/checklist/fishka_20")) 
defineProperty("checklist_selected",globalPropertyi("sim/custom/checklist/checklist_selected")) 
defineProperty("gen_1_on", globalPropertyi("sim/custom/switchers/eng/gen_1_on")) 
defineProperty("gen_2_on", globalPropertyi("sim/custom/switchers/eng/gen_2_on")) 
defineProperty("gen_3_on", globalPropertyi("sim/custom/switchers/eng/gen_3_on")) 
defineProperty("bat1_on", globalPropertyi("sim/custom/switchers/eng/bat1_on")) 
defineProperty("bat2_on", globalPropertyi("sim/custom/switchers/eng/bat2_on")) 
defineProperty("bat3_on", globalPropertyi("sim/custom/switchers/eng/bat3_on")) 
defineProperty("bat4_on", globalPropertyi("sim/custom/switchers/eng/bat4_on")) 
defineProperty("gen_fail_1", globalPropertyf("sim/custom/lights/small/gen_fail_1")) 
defineProperty("gen_fail_2", globalPropertyf("sim/custom/lights/small/gen_fail_2")) 
defineProperty("gen_fail_3", globalPropertyf("sim/custom/lights/small/gen_fail_3")) 
defineProperty("left_bus_use_bat", globalPropertyf("sim/custom/lights/small/left_bus_use_bat")) 
defineProperty("right_bus_use_bat", globalPropertyf("sim/custom/lights/small/right_bus_use_bat")) 
defineProperty("sard_cabin_press_set", globalPropertyf("sim/custom/switchers/sard/sard_cabin_press_set")) 
defineProperty("skv_bleed_fail_1", globalPropertyf("sim/custom/lights/small/skv_bleed_fail_1")) 
defineProperty("skv_bleed_fail_2", globalPropertyf("sim/custom/lights/small/skv_bleed_fail_2")) 
defineProperty("skv_bleed_fail_3", globalPropertyf("sim/custom/lights/small/skv_bleed_fail_3")) 
defineProperty("skv_bleed_closed_1", globalPropertyf("sim/custom/lights/small/skv_bleed_closed_1")) 
defineProperty("skv_bleed_closed_2", globalPropertyf("sim/custom/lights/small/skv_bleed_closed_2")) 
defineProperty("skv_bleed_closed_3", globalPropertyf("sim/custom/lights/small/skv_bleed_closed_3")) 
defineProperty("nvu_on_lit", globalPropertyf("sim/custom/lights/small/nvu_on")) 
defineProperty("nav1_pow_cc", globalPropertyf("sim/custom/radio/nav1_pow_cc"))
defineProperty("nav2_pow_cc", globalPropertyf("sim/custom/radio/nav2_pow_cc"))
defineProperty("ark15_L_cc", globalPropertyf("sim/custom/radio/ark15_L_cc")) 
defineProperty("ark15_R_cc", globalPropertyf("sim/custom/radio/ark15_R_cc")) 
defineProperty("xpdr_mode", globalPropertyf("sim/cockpit/radios/transponder_mode"))
defineProperty("buster_on_1", globalPropertyi("sim/custom/switchers/console/buster_on_1")) 
defineProperty("buster_on_2", globalPropertyi("sim/custom/switchers/console/buster_on_2")) 
defineProperty("buster_on_3", globalPropertyi("sim/custom/switchers/console/buster_on_3")) 
defineProperty("busters_cap", globalPropertyi("sim/custom/switchers/console/busters_cap")) 
defineProperty("contr_force_set", globalPropertyi("sim/custom/controll/contr_force_set")) 
defineProperty("mgv_contr_fail", globalPropertyi("sim/custom/bkk/mgv_contr_fail")) 
defineProperty("pkp_fail_left", globalPropertyi("sim/custom/bkk/pkp_fail_left")) 
defineProperty("pkp_fail_right", globalPropertyi("sim/custom/bkk/pkp_fail_right")) 
defineProperty("pitch_corr_hdl_1", globalPropertyf("sim/custom/gauges/ahz/pitch_corr_L")) 
defineProperty("pitch_corr_hdl_2", globalPropertyf("sim/custom/gauges/ahz/pitch_corr_R")) 
defineProperty("course_ga_1", globalPropertyf("sim/custom/tks/course_ga_1")) 
defineProperty("course_ga_2", globalPropertyf("sim/custom/tks/course_ga_2")) 
defineProperty("course_bgmk_1", globalPropertyf("sim/custom/tks/course_bgmk_1")) 
defineProperty("course_bgmk_2", globalPropertyf("sim/custom/tks/course_bgmk_2")) 
defineProperty("absu_work", globalPropertyf("sim/custom/lights/absu_work")) 
defineProperty("absu_roll_mode", globalPropertyi("sim/custom/gauges/console/absu_roll_mode")) 
defineProperty("absu_pitch_mode", globalPropertyi("sim/custom/gauges/console/absu_pitch_mode")) 
defineProperty("window_heat_1", globalPropertyi("sim/custom/switchers/ovhd/window_heat_1")) 
defineProperty("window_heat_2", globalPropertyi("sim/custom/switchers/ovhd/window_heat_2")) 
defineProperty("window_heat_3", globalPropertyi("sim/custom/switchers/ovhd/window_heat_3")) 
local checklist_started = false
local stage = 0
local stage_status = 0 
local speak_timer = 0
function checklist_2()
	if not checklist_started and get(checklist_selected) == 2 then 
		checklist_started = true 
		stage = 1
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["before_taxiing"][lang], 2}
		speak_timer = 2
	end
	if get(checklist_selected) ~= 2 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	if checklist_started then
		if stage == 1 and get(fishka_11) == 0 then stage = 2 stage_status = 0 end 
		if stage == 2 and get(fishka_12) == 0 then stage = 3 stage_status = 0 end 
		if stage == 3 and get(fishka_13) == 0 then stage = 4 stage_status = 0 end 
		if stage == 4 and get(fishka_14) == 0 then stage = 5 stage_status = 0 end 
		if stage == 5 and get(fishka_15) == 0 then stage = 6 stage_status = 0 end 
		if stage == 6 and get(fishka_16) == 0 then stage = 7 stage_status = 0 end 
		if stage == 7 and get(fishka_17) == 0 then stage = 8 stage_status = 0 end 
		if stage == 8 and get(fishka_18) == 0 then stage = 9 stage_status = 0 end 
		if stage == 9 and get(fishka_19) == 0 then stage = 10 stage_status = 0 end 
		if stage == 10 and get(fishka_20) == 0 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end 
	end
	if stage == 1 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["elektro_system"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and (get(gen_1_on) + get(gen_2_on) + get(gen_3_on) ~= 3 or get(bat1_on) + get(bat2_on) + get(bat3_on) + get(bat4_on) ~= 4
			or get(gen_fail_1) + get(gen_fail_2) + get(gen_fail_3) > 0 or get(left_bus_use_bat) + get(right_bus_use_bat) > 0) then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(gen_1_on) + get(gen_2_on) + get(gen_3_on) == 3 and get(bat1_on) + get(bat2_on) + get(bat3_on) + get(bat4_on) == 4
			and get(gen_fail_1) + get(gen_fail_2) + get(gen_fail_3) == 0 and get(left_bus_use_bat) + get(right_bus_use_bat) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["chk_on"][lang], 2}
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_11, 0) end	
	if stage == 2 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["SRD"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and (math.abs(get(sard_cabin_press_set) - 650) > 10 or get(skv_bleed_fail_1) + get(skv_bleed_fail_2) + get(skv_bleed_fail_3) +
			get(skv_bleed_closed_1) + get(skv_bleed_closed_2) + get(skv_bleed_closed_3) > 0) then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and math.abs(get(sard_cabin_press_set) - 650) <= 10 and get(skv_bleed_fail_1) + get(skv_bleed_fail_2) + get(skv_bleed_fail_3) +
			get(skv_bleed_closed_1) + get(skv_bleed_closed_2) + get(skv_bleed_closed_3) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["press_650_set"][lang], 3}
			speak_timer = 4
			stage_status = 10 
		end
	end
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_12, 0) end	
	if stage == 3 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["navigation_complex"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and get(nvu_on_lit) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(nvu_on_lit) > 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["switch_on"][lang], 2}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_13, 0) end	
	if stage == 4 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["course_mp_ark"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and get(nvu_on_lit) == 0 and (get(nav1_pow_cc) == 0 or get(nav2_pow_cc) == 0 or get(ark15_L_cc) == 0 or get(ark15_R_cc) == 0) then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(nav1_pow_cc) > 0 and get(nav2_pow_cc) > 0 and get(ark15_L_cc) > 0 and get(ark15_R_cc) > 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["switch_on_1"][lang], 2}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 4 and stage_status == 10 and speak_timer < 0.1 then set(fishka_14, 0) end		
	if stage == 5 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["UVD"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and get(xpdr_mode) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(xpdr_mode) > 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["turned_on"][lang], 2}
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 5 and stage_status == 10 and speak_timer < 0.1 then set(fishka_15, 0) end	
	if stage == 6 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["booster"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and (get(busters_cap) == 1 or get(contr_force_set) ~= 0) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(busters_cap) == 0 and get(contr_force_set) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["turned_on_cap_closed_auto"][lang], 3}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 6 and stage_status == 10 and speak_timer < 0.1 then set(fishka_16, 0) end		
	if stage == 7 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["air_horizons"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and (get(mgv_contr_fail) == 1 or get(pkp_fail_left) == 1 or get(pkp_fail_right) == 1 or
			math.abs(get(pitch_corr_hdl_1)) > 0.1 or math.abs(get(pitch_corr_hdl_2)) > 0.1) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(mgv_contr_fail) == 0 and get(pkp_fail_left) == 0 and get(pkp_fail_right) == 0 and
			math.abs(get(pitch_corr_hdl_1)) < 0.1 and math.abs(get(pitch_corr_hdl_2)) < 0.1 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["check_lines_fit"][lang], 2}
			phrases_tbl[num+1] = {cop_tbl["chk_lines_up"][lang], 2}
			speak_timer = 5
			stage_status = 10 
		end
	end
	if stage == 7 and stage_status == 10 and speak_timer < 0.1 then set(fishka_17, 0) end	
	if stage == 8 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["TKS"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and (math.abs(get(course_ga_1) - get(course_ga_2)) >= 0.5 or math.abs(get(course_bgmk_1) - get(course_bgmk_2)) >= 0.5) then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and math.abs(get(course_ga_1) - get(course_ga_2)) < 0.5 and math.abs(get(course_bgmk_1) - get(course_bgmk_2)) < 0.5 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["switch_on_agreed"][lang], 3}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 8 and stage_status == 10 and speak_timer < 0.1 then set(fishka_18, 0) end
	if stage == 9 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["ABSU"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and (get(absu_work) == 0 or get(absu_roll_mode) ~= 1 or get(absu_pitch_mode) ~= 1) then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(absu_work) == 1 and get(absu_roll_mode) == 1 and get(absu_pitch_mode) == 1 then
			local num = find_empty()
			phrases_tbl[num] = {eng_tbl["absu_ok"][lang], 3}
			speak_timer = 3
			stage_status = 10 
		end
	end
	if stage == 9 and stage_status == 10 and speak_timer < 0.1 then set(fishka_19, 0) end
	if stage == 10 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["deicing"][lang], 2}
			stage_status = 1 
			speak_timer = 3 
		end
		if stage_status == 1 and (get(window_heat_1) + get(window_heat_2) + get(window_heat_3) > -3) then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(window_heat_1) + get(window_heat_2) + get(window_heat_3) == -3 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["turned_on_2"][lang], 1}
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 10 and stage_status == 10 and speak_timer < 0.1 then set(fishka_20, 0) end	
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