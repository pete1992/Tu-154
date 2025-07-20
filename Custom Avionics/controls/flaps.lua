defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external")) 
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) 
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")) 
defineProperty("flap_mid_L", globalPropertyf("sim/flightmodel/controls/wing2l_fla2def")) 
defineProperty("flap_mid_R", globalPropertyf("sim/flightmodel/controls/wing2r_fla2def")) 
defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) 
defineProperty("stab_ratio", globalPropertyf("sim/cockpit2/controls/elevator_trim")) 
defineProperty("sim_flap_ratio", globalPropertyf("sim/cockpit2/controls/flap_ratio")) 
defineProperty("flaps_lever", globalPropertyf("tu154ce/controll/flaps_lever")) 
defineProperty("flaps_sel", globalPropertyi("tu154ce/switchers/flaps_sel")) 
defineProperty("slat_man", globalPropertyi("tu154ce/switchers/slat_man")) 
defineProperty("slat_man_cap", globalPropertyi("tu154ce/switchers/slat_man_cap")) 
defineProperty("stab_man_cap", globalPropertyi("tu154ce/controll/stab_man_cap")) 
defineProperty("stab_manual", globalPropertyi("tu154ce/controll/stab_manual")) 
defineProperty("stab_setting", globalPropertyi("tu154ce/controll/stab_setting")) 
defineProperty("gs_press_1", globalPropertyf("tu154ce/hydro/gs_press_1")) 
defineProperty("gs_press_2", globalPropertyf("tu154ce/hydro/gs_press_2")) 
defineProperty("gs_press_3", globalPropertyf("tu154ce/hydro/gs_press_3")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right")) 
defineProperty("bus36_volt_left", globalPropertyf("tu154ce/elec/bus36_volt_left")) 
defineProperty("bus36_volt_right", globalPropertyf("tu154ce/elec/bus36_volt_right")) 
defineProperty("bus115_1_volt", globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("bus115_3_volt", globalPropertyf("tu154ce/elec/bus115_3_volt"))
defineProperty("ctr_115_1_cc", globalPropertyf("tu154ce/control/ctr_115_1_cc")) 
defineProperty("ctr_115_3_cc", globalPropertyf("tu154ce/control/ctr_115_3_cc")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
defineProperty("flap_fail_left", globalPropertyi("tu154ce/failures/flap_fail_left")) 
defineProperty("flap_fail_right", globalPropertyi("tu154ce/failures/flap_fail_right")) 
defineProperty("stab_eng_fail", globalPropertyi("tu154ce/failures/stab_eng_fail")) 
defineProperty("stab_automatic_fail", globalPropertyi("tu154ce/failures/stab_automatic_fail")) 
defineProperty("slats_fail", globalPropertyi("tu154ce/failures/slats_fail")) 
flaps_cmd_up = findCommand("sim/flight_controls/flaps_up")
flaps_cmd_down = findCommand("sim/flight_controls/flaps_down")
local flaps_sound = loadSample('Custom Sounds/flaps_hnd.wav') 
function flaps_up_handler(phase)
	if 0 == phase then
		if get(external_view) == 0 then playSample(flaps_sound, 0) end
	end
	return 0
end
function flaps_down_handler(phase)
	if 0 == phase then
		if get(external_view) == 0 then playSample(flaps_sound, 0) end
	end
	return 0
end
registerCommandHandler(flaps_cmd_up, 0, flaps_up_handler)
registerCommandHandler(flaps_cmd_down, 0, flaps_down_handler)
flap_lever_tbl = {
{-50000, 0},
{0, 0},
{0.20, 15},
{0.25, 15}, 
{0.30, 15},
{0.45, 28},
{0.50, 28}, 
{0.55, 28},
{0.70, 36},
{0.75, 36}, 
{0.80, 36},
{0.95, 45},
{1.00, 45}, 
{10000, 45}
}
local mid_flap_tbl = {
{0, 0},
{15, 13},
{28, 25},
{36, 32},
{45, 40}
}
local flaps_pos_L_cmd = get(flap_inn_L)
local flaps_pos_R_cmd = get(flap_inn_R)
local flaps_dirr_L = 0
local flaps_dirr_R = 0
local flap_SPD = 1.8 
local flap_pos_L_last = flaps_pos_L_cmd
local flap_pos_R_last = flaps_pos_R_cmd
local slats_pos_cmd = get(slats)
local slats_dirr = 0
local spats_spd = 0.2 * 0.5
local stab_pos_now = get(stab_ratio) * 5.5 
local stab_pos_cmd = stab_pos_now
local stab_dirr = 0
local flaps_lever_last = get(flaps_lever)
local lever_moved_dir = -1 
local stab_must_move = false
function update()
	local MASTER = get(ismaster) ~= 1
if MASTER then
	local passed = get(frame_time)
	local flaps_mode = get(flaps_sel)
	local flap_mech_L_fail = get(flap_fail_left)
	local flap_mech_R_fail = get(flap_fail_right)
	local power27_L = bool2int(get(bus27_volt_left) > 13)
	local power27_R = bool2int(get(bus27_volt_right) > 13)
	local power36_L = bool2int(get(bus36_volt_left) > 30)
	local power36_R = bool2int(get(bus36_volt_right) > 30)
	local power115_1 = bool2int(get(bus115_1_volt) > 110)
	local power115_3 = bool2int(get(bus115_3_volt) > 110)
	local CC_115_1 = 0
	local CC_115_3 = 0
	local flap_lever_pos = interpolate(flap_lever_tbl, get(sim_flap_ratio))
	set(flaps_lever, flap_lever_pos)
	flaps_pos_L_cmd = flap_lever_pos 
	flaps_pos_R_cmd = flap_lever_pos 
	local HS1 = math.min(get(gs_press_1) * 0.15, 1)
	local HS2 = math.min(get(gs_press_2) * 0.15, 1)
	local flap_pos_now_L = get(flap_inn_L)
	local flap_pos_now_R = get(flap_inn_R)
	if flaps_mode == 0 then 
		if flap_pos_now_L < flaps_pos_L_cmd - 0.1 then flaps_dirr_L = 1
		elseif flap_pos_now_L > flaps_pos_L_cmd then flaps_dirr_L = -1
		else flaps_dirr_L = 0
		end
		if flap_pos_now_R < flaps_pos_R_cmd - 0.1 then flaps_dirr_R = 1
		elseif flap_pos_now_R > flaps_pos_R_cmd then flaps_dirr_R = -1
		else flaps_dirr_R = 0
		end
	elseif flaps_mode == 1 then 
		if flap_lever_pos > 40 then	
			flaps_dirr_L = 1
			flaps_dirr_R = 1
		elseif flap_lever_pos < 5 then 
			flaps_dirr_L = -1
			flaps_dirr_R = -1
		else 
			flaps_dirr_L = 0 
			flaps_dirr_R = 0
		end
	end
	flaps_dirr_L = flaps_dirr_L * power36_L * power36_R
	flaps_dirr_R = flaps_dirr_R * power36_L * power36_R
	flap_pos_now_L = flap_pos_now_L + flaps_dirr_L * passed * math.max(HS1, HS2) * flap_SPD * (1 - flap_mech_L_fail) 
	flap_pos_now_R = flap_pos_now_R + flaps_dirr_R * passed * math.max(HS1, HS2) * flap_SPD * (1 - flap_mech_R_fail) 
	if flap_pos_now_L > 45 then flap_pos_now_L = 45
	elseif flap_pos_now_L < 0 then flap_pos_now_L = 0 end
	if flap_pos_now_R > 45 then flap_pos_now_R = 45
	elseif flap_pos_now_R < 0 then flap_pos_now_R = 0 end	
	if math.abs(flap_pos_now_L - flap_pos_now_R) < 3 then 
		flap_pos_L_last = flap_pos_now_L
		flap_pos_R_last = flap_pos_now_R
	end
	if flaps_lever_last ~= flap_lever_pos and (flap_lever_pos == 0 or flap_lever_pos == 15 or flap_lever_pos == 28 or flap_lever_pos == 36 or flap_lever_pos == 45) then
		playSample(flaps_sound, 0)
	end
	flaps_lever_last = flap_lever_pos
	set(flap_inn_L, flap_pos_L_last)
	set(flap_inn_R, flap_pos_R_last)
	set(flap_mid_L, interpolate(mid_flap_tbl, flap_pos_L_last))
	set(flap_mid_R, interpolate(mid_flap_tbl, flap_pos_R_last))	
	local slats_pos = get(slats)
	local stats_eng = 2 - get(slats_fail) 
	if get(slat_man_cap) == 0 then 
		if flap_lever_pos >= 5 then slats_pos_cmd = 1
		elseif flap_lever_pos < 5 and flap_pos_L_last <= 14 and flap_pos_R_last <= 14 then slats_pos_cmd = 0
		end	
		if slats_pos_cmd > slats_pos + 0.01 then slats_dirr = 1
		elseif slats_pos_cmd < slats_pos then slats_dirr = -1
		else slats_dirr = 0 end
	else 
		slats_dirr = get(slat_man)
		slats_pos_cmd = slats_pos
	end
	slats_dirr = slats_dirr * power36_L * power36_R
	slats_pos = slats_pos + slats_dirr * passed * spats_spd * (bool2int(stats_eng > 1) * power115_1 * power27_L + bool2int(stats_eng > 0) * power115_3 * power27_R)
	if slats_dirr ~= 0 then
		if stats_eng > 1 then CC_115_1 = 6.5 end
		if stats_eng > 0 then CC_115_3 = 6.5 end
	end
	if slats_pos > 1 then slats_pos = 1
	elseif slats_pos < 0 then slats_pos = 0 end
	set(slats, slats_pos)
	local stab_mechs = 2 - get(stab_eng_fail) 
	if get(stab_man_cap) == 0 and get(stab_automatic_fail) == 0 then 
		local stab_set = get(stab_setting)
		if flap_lever_pos > flap_pos_L_last + 0.1 and flap_lever_pos > flap_pos_R_last + 0.1 then 
			lever_moved_dir = 1
			stab_must_move = true
		elseif flap_lever_pos < flap_pos_L_last - 0.1 and flap_lever_pos < flap_pos_R_last - 0.1 then 
			lever_moved_dir = -1
			stab_must_move = true
		else 
			lever_moved_dir = 0
			stab_must_move = false
		end		
		if lever_moved_dir == 1 and stab_must_move then 
			if flap_lever_pos >= 15 and flap_lever_pos <= 28 then 
				if stab_set == 2 then stab_pos_cmd = 3
				elseif stab_set == 1 then stab_pos_cmd = 1.5
				else stab_pos_cmd = 0 end
			elseif flap_lever_pos >= 36 and flap_pos_L_last >= 31 and flap_pos_R_last >= 31 then
				if stab_set == 2 then stab_pos_cmd = 5.5
				elseif stab_set == 1 then stab_pos_cmd = 3
				else stab_pos_cmd = 0 end			
			end
		elseif lever_moved_dir == -1 and stab_must_move then 
			if 
				if stab_set == 2 then stab_pos_cmd = 3
				elseif stab_set == 1 then stab_pos_cmd = 1.5
				else stab_pos_cmd = 0 end			
			end			
		end
		if flap_lever_pos < 5 and flap_pos_L_last < 25 and flap_pos_R_last < 25 then stab_pos_cmd = 0 end 
		if stab_pos_cmd > stab_pos_now + 0.01 then stab_dirr = 1
		elseif stab_pos_cmd < stab_pos_now then stab_dirr = -1
		else stab_dirr = 0 end
	elseif get(stab_man_cap) == 1 then 
		stab_dirr = get(stab_manual)
		stab_pos_cmd = stab_pos_now
	end
	stab_pos_now = stab_pos_now + stab_dirr * passed * (bool2int(stab_mechs > 0) * power115_1 + bool2int(stab_mechs > 1) * power115_3) * 0.11
	if stab_dirr ~= 0 then
		if stab_mechs > 1 then CC_115_1 = CC_115_1 + 6.5 end
		if stab_mechs > 0 then CC_115_3 = CC_115_3 + 6.5 end
	end
	if stab_pos_now > 5.5 then stab_pos_now = 5.5
	elseif stab_pos_now < 0 then stab_pos_now = 0 end
	set(stab_ratio, stab_pos_now / 5.5)
	set(ctr_115_1_cc, CC_115_1)
	set(ctr_115_3_cc, CC_115_3)
end	
end
