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
defineProperty("antiice_slats", globalPropertyi("tu154ce/switchers/eng/antiice_slats")) 
defineProperty("antiice_eng_1", globalPropertyi("tu154ce/switchers/eng/antiice_eng_1")) 
defineProperty("antiice_eng_2", globalPropertyi("tu154ce/switchers/eng/antiice_eng_2")) 
defineProperty("antiice_eng_3", globalPropertyi("tu154ce/switchers/eng/antiice_eng_3")) 
defineProperty("antiice_wing", globalPropertyi("tu154ce/switchers/eng/antiice_wing")) 
local checklist_started = false
local stage = 0
local stage_status = 0 
local speak_timer = 0
function checklist_3()
	if not checklist_started and get(checklist_selected) == 3 then 
		checklist_started = true 
		stage = 1
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["on_taxiing"][lang], 2}
		speak_timer = 2
	end
	if get(checklist_selected) ~= 3 then 
		checklist_started = false
		stage = 0
		stage_status = 0 
	end
	if checklist_started then
		if stage == 1 and get(fishka_1) == 1 then stage = 2 stage_status = 0 end 
		if stage == 2 and get(fishka_2) == 1 then stage = 3 stage_status = 0 end 
		if stage == 3 and get(fishka_3) == 1 then 
			stage = 100 stage_status = 0 
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["checklist_completed"][lang], 2}
		end 
	end
	if stage == 1 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["brake"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and not v_var["check_brk_said"] then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and v_var["check_brk_said"] then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["checked"][lang], 2}
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_1, 1) end	
	if stage == 2 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["deicing"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and get(window_heat_1) + get(window_heat_2) + get(window_heat_3) > -3 and get(window_heat_1) + get(window_heat_2) + get(window_heat_3) < 3 then
			stage_status = 2
		end
	if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			if get(antiice_slats) + get(antiice_eng_1) + get(antiice_eng_2) + get(antiice_eng_3) + get(antiice_wing) > 0 then
				phrases_tbl[num] = {eng_tbl["turned_on_2"][lang], 2}
			else 
				phrases_tbl[num] = {eng_tbl["turned_off_2"][lang], 2}
			end
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_2, 1) end		
	if stage == 3 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["EUP"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and not v_var["eup_chk_said"] then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and v_var["eup_chk_said"] then
			local num = find_empty()
			phrases_tbl[num] = {cop_tbl["turned_on_chk"][lang], 2}
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 3 and stage_status == 10 and speak_timer < 0.1 then set(fishka_3, 1) end	
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