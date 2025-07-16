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
defineProperty("course_ga_1", globalPropertyf("sim/custom/tks/course_ga_1")) 
defineProperty("course_ga_2", globalPropertyf("sim/custom/tks/course_ga_2")) 
defineProperty("course_bgmk_1", globalPropertyf("sim/custom/tks/course_bgmk_1")) 
defineProperty("course_bgmk_2", globalPropertyf("sim/custom/tks/course_bgmk_2")) 
defineProperty("pitot_heat_1", globalPropertyi("sim/custom/switchers/ovhd/pitot_heat_1")) 
defineProperty("pitot_heat_2", globalPropertyi("sim/custom/switchers/ovhd/pitot_heat_2")) 
defineProperty("pitot_heat_3", globalPropertyi("sim/custom/switchers/ovhd/pitot_heat_3")) 
defineProperty("xpdr_mode", globalPropertyf("sim/cockpit/radios/transponder_mode"))
defineProperty("to_ready", globalPropertyi("sim/custom/checklist/to_ready")) 
local checklist_started = false
local stage = 0
local stage_status = 0 
local speak_timer = 0
function checklist_5()
	if not checklist_started and get(checklist_selected) == 5 then 
		checklist_started = true 
		stage = 1
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["takeoff_start"][lang], 2}
		speak_timer = 1
	end
	if get(checklist_selected) ~= 5 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	if checklist_started then
		if stage == 1 and get(fishka_13) == 1 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end 
	end
	if stage == 1 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["ready_takeoff"][lang], 2}
			phrases_tbl[num+1] = {eng_tbl["ready"][lang], 1}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and (math.abs(get(course_ga_1) - get(course_ga_2)) > 0.5 or math.abs(get(course_bgmk_1) - get(course_bgmk_2)) > 0.5) then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and math.abs(get(course_ga_1) - get(course_ga_2)) < 0.5 and math.abs(get(course_bgmk_1) - get(course_bgmk_2)) < 0.5 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["TKS_ready"][lang], 2}
			local crs = math.floor(get(course_ga_1) + 0.5)
			while crs <= 0 do crs = crs + 360 end
			while crs > 360 do crs = crs - 360 end
			nav_say_num(crs, 3, lang)
			phrases_tbl[num+4] = {nav_tbl["ready"][lang], 2}
			speak_timer = 6
			stage_status = 3 
		end
		if stage_status == 1 and get(pitot_heat_1) + get(pitot_heat_2) + get(pitot_heat_3) < 3 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 4
		end		
		if (stage_status == 3 or stage_status == 4) and get(pitot_heat_1) + get(pitot_heat_2) + get(pitot_heat_3) == 3 then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["ready"][lang], 2}
			speak_timer = 3
			stage_status = 5 
		end		
		if stage_status == 1 and (get(xpdr_mode) ~= 2 or get(to_ready) == 1) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 6
		end		
		if (stage_status == 5 or stage_status == 6) and get(xpdr_mode) == 2 and get(to_ready) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["ready_to_takeoff"][lang], 5}
			speak_timer = 6
			stage_status = 10 
		end		
	end
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_13, 1) end
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