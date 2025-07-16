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
defineProperty("spoilers_mid_left", globalPropertyf("sim/custom/lights/spoilers_mid_left")) 
defineProperty("spoilers_mid_right", globalPropertyf("sim/custom/lights/spoilers_mid_right")) 
defineProperty("stab_setting", globalPropertyi("sim/custom/controll/stab_setting")) 
defineProperty("radioalt_dh_left", globalPropertyf("sim/custom/gauges/alt/radioalt_dh_left")) 
local angle2alt = {
{-100000, 0},
{0, 0},
{30, 20},
{80, 50},
{160, 100},
{314, 700},
{340, 800},
{8000000, 1000}
}
local checklist_started = false
local stage = 0
local stage_status = 0 
local speak_timer = 0
function checklist_8()
	if not checklist_started and get(checklist_selected) == 8 then 
		checklist_started = true 
		stage = 1
		local num = find_empty()
		phrases_tbl[num] = {nav_tbl["before_3_turn"][lang], 3}
		speak_timer = 3
	end
	if get(checklist_selected) ~= 8 then 
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
			phrases_tbl[num] = {nav_tbl["speed_br"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and (get(spoilers_mid_left) > 0 or get(spoilers_mid_right) > 0) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and get(spoilers_mid_left) == 0 and get(spoilers_mid_right) == 0 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["retracted"][lang], 2}
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 1 and stage_status == 10 and speak_timer < 0.1 then set(fishka_1, 1) end
	if stage == 2 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["stabilizer"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		if stage_status == 1 and (get(spoilers_mid_left) > 0 or get(spoilers_mid_right) > 0) then
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) then
			local num = find_empty()
			if get(stab_setting) == 0 then
				phrases_tbl[num] = {cpt_tbl["stab_set_b"][lang], 2}
			elseif get(stab_setting) == 1 then
				phrases_tbl[num] = {cpt_tbl["stab_set_m"][lang], 2}
			else 
				phrases_tbl[num] = {cpt_tbl["stab_set_f"][lang], 2}
			end
			speak_timer = 2
			stage_status = 10 
		end
	end
	if stage == 2 and stage_status == 10 and speak_timer < 0.1 then set(fishka_2, 1) end
	if stage == 3 and speak_timer == 0 then
		if stage_status == 0 then
			local num = find_empty()
			phrases_tbl[num] = {nav_tbl["RV"][lang], 2}
			stage_status = 1 
			speak_timer = 2 
		end
		local DH = interpolate(angle2alt, get(radioalt_dh_left))
		if stage_status == 1 and (DH < 10 or DH > 400) then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["fail_"..math.random(1,5)][lang], 1}
			speak_timer = 1
			stage_status = 2
		end
		if (stage_status == 1 or stage_status == 2) and DH < 400 and DH > 10 then
			local num = find_empty()
			phrases_tbl[num] = {cpt_tbl["turned_on2"][lang], 1}
			capt_say_num(math.floor(DH/10 + 0.5)*10, 3, lang)
			phrases_tbl[num+4] = {cpt_tbl["meters"][lang], 1}
			speak_timer = 5
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
