-- controls_panel.lua

-- Smartcopilot master/slave logic
defineProperty("ismaster",        globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1",    globalPropertyf("scp/api/hascontrol_1"))

-- Helper: Batch DataRef registration
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register all DataRefs needed for panel and logic
defineProps({
    {"stab_man_cap",        "sim/custom/controll/stab_man_cap",          globalPropertyi},
    {"stab_manual",         "sim/custom/controll/stab_manual",           globalPropertyi},
    {"stab_setting",        "sim/custom/controll/stab_setting",          globalPropertyi},
    {"ail_trimm_sw",        "sim/custom/controll/ail_trimm_sw",          globalPropertyi},
    {"rudd_trimm_sw",       "sim/custom/controll/rudd_trimm_sw",         globalPropertyi},
    {"contr_force_cap",     "sim/custom/controll/contr_force_cap",       globalPropertyi},
    {"contr_force_set",     "sim/custom/controll/contr_force_set",       globalPropertyi},
    {"nosewheel_turn_enable","sim/custom/switchers/nosewheel_turn_enable",globalPropertyi},
    {"nosewheel_turn_sel",  "sim/custom/switchers/nosewheel_turn_sel",   globalPropertyi},
    {"nosewheel_turn_cap",  "sim/custom/switchers/nosewheel_turn_cap",   globalPropertyi},
    {"slat_man",            "sim/custom/switchers/slat_man",             globalPropertyi},
    {"slat_man_cap",        "sim/custom/switchers/slat_man_cap",         globalPropertyi},
    {"flaps_sel",           "sim/custom/switchers/flaps_sel",            globalPropertyi},
    {"flaps_sel_cap",       "sim/custom/switchers/flaps_sel_cap",        globalPropertyi},
    {"gears_retr_lock",     "sim/custom/switchers/gears_retr_lock",      globalPropertyi},
    {"gears_retr_lock_cap", "sim/custom/switchers/gears_retr_lock_cap",  globalPropertyi},
    {"gears_ext_3GS",       "sim/custom/switchers/gears_ext_3GS",        globalPropertyi},
    {"gears_ext_3GS_cap",   "sim/custom/switchers/gears_ext_3GS_cap",    globalPropertyi},
    {"buster_on_1",         "sim/custom/switchers/console/buster_on_1",   globalPropertyi},
    {"buster_on_2",         "sim/custom/switchers/console/buster_on_2",   globalPropertyi},
    {"buster_on_3",         "sim/custom/switchers/console/buster_on_3",   globalPropertyi},
    {"busters_cap",         "sim/custom/switchers/console/busters_cap",   globalPropertyi},
    {"elev_trimm_switcher","sim/custom/controll/elev_trimm_switcher",    globalPropertyi},
    {"emerg_elev_trimm",   "sim/custom/switchers/console/emerg_elev_trimm",globalPropertyi},
    {"emerg_elev_trimm_cap","sim/custom/switchers/console/emerg_elev_trimm_cap",globalPropertyi},
    {"lamp_test",           "sim/custom/buttons/lamp_test_front",         globalPropertyi},
    {"lamp_test_eng",       "sim/custom/buttons/lamp_test_upper_gear",    globalPropertyi},
    {"flaps_lever",         "sim/custom/controll/flaps_lever",            globalPropertyf},
    {"gear_lever",          "sim/custom/controll/gear_lever",             globalPropertyi},
    {"anim_rud1",           "sim/custom/controlls/throttle_1",            globalPropertyf},
    {"anim_rud2",           "sim/custom/controlls/throttle_2",            globalPropertyf},
    {"anim_rud3",           "sim/custom/controlls/throttle_3",            globalPropertyf},
    {"stab_ind",            "sim/custom/gauges/misc/stab_ind",            globalPropertyf},
    {"elevator_ind",        "sim/custom/gauges/misc/elevator_ind",        globalPropertyf},
    {"flap_left_ind",       "sim/custom/gauges/misc/flap_left_ind",       globalPropertyf},
    {"flap_right_ind",      "sim/custom/gauges/misc/flap_right_ind",      globalPropertyf},
    {"stab_work",           "sim/custom/lights/stab_work",                globalPropertyf},
    {"flaps_1_valve",       "sim/custom/lights/flaps_1_valve",           globalPropertyf},
    {"flaps_2_valve",       "sim/custom/lights/flaps_2_valve",           globalPropertyf},
    {"spoilers_mid_left",   "sim/custom/lights/spoilers_mid_left",       globalPropertyf},
    {"spoilers_mid_right",  "sim/custom/lights/spoilers_mid_right",      globalPropertyf},
    {"spoilers_inn_left",   "sim/custom/lights/spoilers_inn_left",       globalPropertyf},
    {"spoilers_inn_right",  "sim/custom/lights/spoilers_inn_right",      globalPropertyf},
    {"flaps_unsync",        "sim/custom/lights/flaps_unsync",            globalPropertyf},
    {"slats_unsync",        "sim/custom/lights/slats_unsync",            globalPropertyf},
    {"slats_extended",      "sim/custom/lights/slats_extended",          globalPropertyf},
    {"to_rudder",           "sim/custom/lights/to_rudder",               globalPropertyf},
    {"to_elevator",         "sim/custom/lights/to_elevator",             globalPropertyf},
    {"trimm_zero_course",   "sim/custom/lights/trimm_zero_course",       globalPropertyf},
    {"trimm_zero_roll",     "sim/custom/lights/trimm_zero_roll",         globalPropertyf},
    {"trimm_zero_pitch",    "sim/custom/lights/trimm_zero_pitch",        globalPropertyf},
    {"gears_not_ext",       "sim/custom/lights/gears_not_ext",           globalPropertyf},
    {"gears_red_left",      "sim/custom/lights/gears_red_left",          globalPropertyf},
    {"gears_red_front",     "sim/custom/lights/gears_red_front",         globalPropertyf},
    {"gears_red_right",     "sim/custom/lights/gears_red_right",         globalPropertyf},
    {"gears_green_left",    "sim/custom/lights/gears_green_left",        globalPropertyf},
    {"gears_green_front",   "sim/custom/lights/gears_green_front",       globalPropertyf},
    {"gears_green_right",   "sim/custom/lights/gears_green_right",       globalPropertyf},
    {"gears_red_left_eng",  "sim/custom/lights/gears_red_left_eng",      globalPropertyf},
    {"gears_red_front_eng", "sim/custom/lights/gears_red_front_eng",     globalPropertyf},
    {"gears_red_right_eng", "sim/custom/lights/gears_red_right_eng",     globalPropertyf},
    {"gears_green_left_eng","sim/custom/lights/gears_green_left_eng",    globalPropertyf},
    {"gears_green_front_eng","sim/custom/lights/gears_green_front_eng",  globalPropertyf},
    {"gears_green_right_eng","sim/custom/lights/gears_green_right_eng",  globalPropertyf},
    {"elevator_L",          "sim/flightmodel/controls/hstab1_elv1def",   globalPropertyf},
    {"elevator_R",          "sim/flightmodel/controls/hstab2_elv1def",   globalPropertyf},
    {"stab_pos",            "sim/flightmodel2/controls/elevator_trim",   globalPropertyf},
    {"flap_inn_L",          "sim/flightmodel/controls/wing1l_fla1def",   globalPropertyf},
    {"flap_inn_R",          "sim/flightmodel/controls/wing1r_fla1def",   globalPropertyf},
    {"slats",               "sim/flightmodel2/controls/slat1_deploy_ratio",globalPropertyf},
    {"spd_brk_inn_L",       "sim/flightmodel/controls/wing1l_spo1def",   globalPropertyf},
    {"spd_brk_inn_R",       "sim/flightmodel/controls/wing1r_spo1def",   globalPropertyf},
    {"spd_brk_mid_L",       "sim/flightmodel/controls/wing2l_spo2def",   globalPropertyf},
    {"spd_brk_mid_R",       "sim/flightmodel/controls/wing2r_spo2def",   globalPropertyf},
    {"int_pitch_trim",      "sim/custom/trimmers/int_pitch_trim",        globalPropertyf},
    {"int_roll_trim",       "sim/custom/trimmers/int_roll_trim",         globalPropertyf},
    {"int_yaw_trim",        "sim/custom/trimmers/int_yaw_trim",          globalPropertyf},
    {"control_force_pos",   "sim/custom/controls/control_force_pos",     globalPropertyf},
    {"control_force_pos_rud","sim/custom/controls/control_force_pos_rud",globalPropertyf},
    {"gear1_deploy",        "sim/aircraft/parts/acf_gear_deploy[0]",     globalPropertyf},
    {"gear2_deploy",        "sim/aircraft/parts/acf_gear_deploy[1]",     globalPropertyf},
    {"gear3_deploy",        "sim/aircraft/parts/acf_gear_deploy[2]",     globalPropertyf},
    {"deflection_mtr_2",    "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]",globalPropertyf},
    {"deflection_mtr_3",    "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]",globalPropertyf},
    {"indicated_airspeed",  "sim/flightmodel/position/indicated_airspeed",globalPropertyf},
    {"machno",              "sim/flightmodel/misc/machno",               globalPropertyf},
    {"rv5_alt_L",           "sim/custom/misc/rv5_alt_left",              globalPropertyf},
    {"rv5_alt_R",           "sim/custom/misc/rv5_alt_right",             globalPropertyf},
    {"main_gear_flaps",     "sim/custom/alarm/main_gear_flaps",          globalPropertyi},
    {"bus27_volt_left",     "sim/custom/elec/bus27_volt_left",           globalPropertyf},
    {"bus27_volt_right",    "sim/custom/elec/bus27_volt_right",          globalPropertyf},
    {"bus36_volt_left",     "sim/custom/elec/bus36_volt_left",           globalPropertyf},
    {"bus36_volt_right",    "sim/custom/elec/bus36_volt_right",          globalPropertyf},
    {"eng1_N1",             "sim/flightmodel/engine/ENGN_N1_[0]",        globalPropertyf},
    {"eng2_N1",             "sim/flightmodel/engine/ENGN_N1_[1]",        globalPropertyf},
    {"eng3_N1",             "sim/flightmodel/engine/ENGN_N1_[2]",        globalPropertyf},
    {"frame_time",          "sim/custom/time/frame_time",                globalPropertyf},
})

-- Initialize last-state globals for all covers and switches (prevents nil errors, enables sound logic)
stab_man_cap_last, contr_force_cap_last, nosewheel_turn_cap_last = 0, 0, 0
slat_man_cap_last, gears_retr_lock_cap_last, gears_ext_3GS_cap_last = 0, 0, 0
busters_cap_last, flaps_sel_cap_last, emerg_elev_trimm_cap_last = 0, 0, 0
stab_manual_last, stab_setting_last, ail_trimm_sw_last, rudd_trimm_sw_last = 0, 0, 0, 0
contr_force_set_last, nosewheel_turn_enable_last, nosewheel_turn_sel_last = 0, 0, 0
slat_man_last, flaps_sel_last, gears_retr_lock_last, gears_ext_3GS_last = 0, 0, 0, 0
buster_on_1_last, buster_on_2_last, buster_on_3_last = 0, 0, 0
emerg_elev_trimm_last = 0
local stab_pos_last, stab_work_timer, stab_work_lit = 0, 0, false
local flap_L_pos_last, flap_R_pos_last     = 0, 0
local slats_last, slats_timer, slats_lit   = 0, 0, false
local forcer_timer, forcer_lit             = 0, false
local forcer_timer_rud, forcer_rud_lit     = 0, false
local gear_timer                           = 0

-- Sounds
local rotary_sound   = loadSample('Custom Sounds/plastic_switch.wav')
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound      = loadSample('Custom Sounds/cap.wav')
local passed         = get(frame_time)
local notLoaded      = true

-- Helper: Boolean to int
local function bool2int(v) return v and 1 or 0 end

-- Reset covers/caps when engines are stopped (for cold & dark logic)
local function reset_switchers()
    if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
        set(buster_on_1, 0); set(buster_on_2, 0); set(buster_on_3, 0)
        set(busters_cap,   1)
        set(nosewheel_turn_sel, 1)
        set(nosewheel_turn_cap, 1)
    end
    notLoaded = false
end

-- Panel lamp logic
    local function lamps()
	local test_btn = get(lamp_test) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local test_btn_eng = get(lamp_test_eng) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	local stab_work_brt = 0
	local stab_pos_now = get(stab_pos)
	if math.abs(stab_pos_now - stab_pos_last) > 0.01 * passed then 
		stab_work_timer = stab_work_timer + passed
		if stab_work_timer > 0.5 then
			stab_work_timer = 0
			stab_work_lit = not stab_work_lit
		end
	else
		stab_work_timer = 0
		stab_work_lit = false
	end
	if stab_work_lit then stab_work_brt = 1 end
	stab_work_brt = math.max(stab_work_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(stab_work, stab_work_brt) end
	stab_pos_last = stab_pos_now
	local flap_pos_now_L = get(flap_inn_L)
	local flap_pos_now_R = get(flap_inn_R)
	local flaps_1_valve_brt = 0
	if flap_L_pos_last ~= flap_pos_now_L then flaps_1_valve_brt = 1 end
	flaps_1_valve_brt = math.max(flaps_1_valve_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(flaps_1_valve, flaps_1_valve_brt) end
	local flaps_2_valve_brt = 0
	if flap_R_pos_last ~= flap_pos_now_R then flaps_2_valve_brt = 1 end
	flaps_2_valve_brt = math.max(flaps_2_valve_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(flaps_2_valve, flaps_2_valve_brt) end
	flap_L_pos_last = flap_pos_now_L
	flap_R_pos_last = flap_pos_now_R
	local spoilers_mid_left_brt = math.min(1, get(spd_brk_mid_L))
	spoilers_mid_left_brt = math.max(spoilers_mid_left_brt * lamps_brt, test_btn)
	set(spoilers_mid_left, spoilers_mid_left_brt)	
	local spoilers_mid_right_brt = math.min(1, get(spd_brk_mid_R))
	spoilers_mid_right_brt = math.max(spoilers_mid_right_brt * lamps_brt, test_btn) 
	set(spoilers_mid_right, spoilers_mid_right_brt)	
	local spoilers_inn_left_brt = math.min(1, get(spd_brk_inn_L))
	spoilers_inn_left_brt = math.max(spoilers_inn_left_brt * lamps_brt, test_btn) 
	set(spoilers_inn_left, spoilers_inn_left_brt)	
	local spoilers_inn_right_brt = math.min(1, get(spd_brk_inn_R))
	spoilers_inn_right_brt = math.max(spoilers_inn_right_brt * lamps_brt, test_btn)
	set(spoilers_inn_right, spoilers_inn_right_brt)		
	local flaps_unsync_brt = 0
	if math.abs(flap_pos_now_L - flap_pos_now_R) >= 3 then flaps_unsync_brt = 1 end
	flaps_unsync_brt = math.max(flaps_unsync_brt * lamps_brt, test_btn)
	set(flaps_unsync, flaps_unsync_brt)	
	local slats_unsync_brt = 0
	slats_unsync_brt = math.max(slats_unsync_brt * lamps_brt, test_btn)
	set(slats_unsync, slats_unsync_brt)	
	local slats_extended_brt = 0
	local slats_now = get(slats)
	if math.abs(slats_now - slats_last) ~= 0 then 
		slats_timer = slats_timer + passed
		if slats_timer > 0.5 then
			slats_timer = 0
			slats_lit = not slats_lit
		end
	elseif slats_now > 0.1 then
			slats_timer = 0
			slats_lit = true	
	else
		stab_work_timer = 0
		slats_lit = false
	end
	if slats_lit then slats_extended_brt = 1 end
	slats_last = slats_now
	slats_extended_brt = math.max(slats_extended_brt * lamps_brt, test_btn)
	if get(ismaster) ~= 1 then set(slats_extended, slats_extended_brt) end	
	local to_rudder_brt = 0
	local to_elevator_brt = 0
	local forcer_pos = get(control_force_pos)	
	if forcer_pos < 1 and forcer_pos > 0 then 
		forcer_timer = forcer_timer + passed 
		if forcer_timer > 0.5 then
			forcer_timer = 0
			forcer_lit = not forcer_lit
		end
	elseif forcer_pos == 0 then
		forcer_lit = true
	else 
		forcer_lit = false
	end
	if forcer_lit then 
		to_elevator_brt = 1
	end	
	local forcer_rud_pos = get(control_force_pos_rud)
	if forcer_rud_pos < 1 and forcer_rud_pos > 0 then 
		forcer_timer_rud = forcer_timer_rud + passed 
		if forcer_timer_rud > 0.5 then
			forcer_timer_rud = 0
			forcer_rud_lit = not forcer_rud_lit
		end
	elseif forcer_rud_pos == 0 then
		forcer_rud_lit = true
	else 
		forcer_rud_lit = false
	end
	if forcer_rud_lit then 
		to_rudder_brt = 1 
	end		
	to_rudder_brt = math.max(to_rudder_brt * lamps_brt, test_btn)
	set(to_rudder, to_rudder_brt)	
	to_elevator_brt = math.max(to_elevator_brt * lamps_brt, test_btn)
	set(to_elevator, to_elevator_brt)	
	local trimm_zero_course_brt = 0
	if math.abs(get(int_yaw_trim)) < 0.002 then trimm_zero_course_brt = 1 end
	trimm_zero_course_brt = math.max(trimm_zero_course_brt * lamps_brt, test_btn)
	set(trimm_zero_course, trimm_zero_course_brt)	
	local trimm_zero_roll_brt = 0
	if math.abs(get(int_roll_trim)) < 0.002 then trimm_zero_roll_brt = 1 end
	trimm_zero_roll_brt = math.max(trimm_zero_roll_brt * lamps_brt, test_btn)
	set(trimm_zero_roll, trimm_zero_roll_brt)	
	local trimm_zero_pitch_brt = 0
	if math.abs(get(int_pitch_trim)) < 0.004 then trimm_zero_pitch_brt = 1 end
	trimm_zero_pitch_brt = math.max(trimm_zero_pitch_brt * lamps_brt, test_btn)
	set(trimm_zero_pitch, trimm_zero_pitch_brt)		
	local gear_F_pos = get(gear1_deploy)
	local gear_L_pos = get(gear2_deploy)
	local gear_R_pos = get(gear3_deploy)
	local gear_not_ext = (gear_F_pos < 0.99 or gear_L_pos < 0.99 or gear_R_pos < 0.99) and (get(indicated_airspeed) * 1.852 < 325 and math.min(get(rv5_alt_L), get(rv5_alt_R)) < 250)
	gear_not_ext = gear_not_ext and (get(anim_rud1) + get(anim_rud2) + get(anim_rud3) < 2 and get(gear_lever) <= 0) 
	if gear_not_ext then
		gear_timer = gear_timer + passed
	else
		gear_timer = 0
	end
	if gear_timer > 0.6 then gear_timer = 0 end
	local gears_not_ext_brt = math.max(bool2int(gear_timer > 0.3) * lamps_brt, test_btn) 
	set(gears_not_ext, gears_not_ext_brt)	
	local gears_red_left_brt = bool2int(gear_L_pos < 0.99 and gear_L_pos > 0.01)
	gears_red_left_brt = math.max(gears_red_left_brt * lamps_brt, test_btn)
	set(gears_red_left, gears_red_left_brt)
	local gears_red_front_brt = bool2int(gear_F_pos < 0.99 and gear_F_pos > 0.01)
	gears_red_front_brt = math.max(gears_red_front_brt * lamps_brt, test_btn)
	set(gears_red_front, gears_red_front_brt)
	local gears_red_right_brt = bool2int(gear_R_pos < 0.99 and gear_R_pos > 0.01)
	gears_red_right_brt = math.max(gears_red_right_brt * lamps_brt, test_btn)
	set(gears_red_right, gears_red_right_brt)
	local gears_green_left_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_left_brt = math.max(gears_green_left_brt * lamps_brt, test_btn)
	set(gears_green_left, gears_green_left_brt)
	local gears_green_front_brt = bool2int(gear_F_pos >= 0.99)
	gears_green_front_brt = math.max(gears_green_front_brt * lamps_brt, test_btn)
	set(gears_green_front, gears_green_front_brt)
	local gears_green_right_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_right_brt = math.max(gears_green_right_brt * lamps_brt, test_btn)
	set(gears_green_right, gears_green_right_brt)
	local gears_red_left_eng_brt = bool2int(gear_L_pos < 0.99 and gear_L_pos > 0.01)
	gears_red_left_eng_brt = math.max(gears_red_left_eng_brt * lamps_brt, test_btn_eng)
	set(gears_red_left_eng, gears_red_left_eng_brt)
	local gears_red_front_eng_brt = bool2int(gear_F_pos < 0.99 and gear_F_pos > 0.01)
	gears_red_front_eng_brt = math.max(gears_red_front_eng_brt * lamps_brt, test_btn_eng)
	set(gears_red_front_eng, gears_red_front_eng_brt)
	local gears_red_right_eng_brt = bool2int(gear_R_pos < 0.99 and gear_R_pos > 0.01)
	gears_red_right_eng_brt = math.max(gears_red_right_eng_brt * lamps_brt, test_btn_eng)
	set(gears_red_right_eng, gears_red_right_eng_brt)
	local gears_green_left_eng_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_left_eng_brt = math.max(gears_green_left_eng_brt * lamps_brt, test_btn_eng)
	set(gears_green_left_eng, gears_green_left_eng_brt)
	local gears_green_front_eng_brt = bool2int(gear_F_pos >= 0.99)
	gears_green_front_eng_brt = math.max(gears_green_front_eng_brt * lamps_brt, test_btn_eng)
	set(gears_green_front_eng, gears_green_front_eng_brt)
	local gears_green_right_eng_brt = bool2int(gear_L_pos >= 0.99)
	gears_green_right_eng_brt = math.max(gears_green_right_eng_brt * lamps_brt, test_btn_eng)
	set(gears_green_right_eng, gears_green_right_eng_brt)	
	local sound_alarm = gear_not_ext or ((flap_pos_now_L < 14 or flap_pos_now_R < 14 or slats_now < 0.5) and math.max(get(anim_rud1), get(anim_rud2), get(anim_rud3)) > 0.7 and math.max(get(deflection_mtr_2), get(deflection_mtr_3)) > 0.05)
	set(main_gear_flaps, bool2int(sound_alarm))
end
-- Gauge smoothing (for needles/indicators)
local stab_ind_act, elev_ind_act = 0, 0
local flap_L_act, flap_R_act     = 0, 0
local mach_tbl = {
    {-10,1},{0,1},{0.1,1},{0.25,0.5},{0.34,0.28},
    {0.38,0.22},{0.5,0.21},{0.6,0.21},{0.7,0.2},
    {0.8,0.19},{0.9,0.13},{1,0.1},{10,0.1},
}
local function interpolate(tbl,x)
    if x<=tbl[1][1] then return tbl[1][2] end
    for i=1,#tbl-1 do
        local x0,y0=tbl[i][1],tbl[i][2]
        local x1,y1=tbl[i+1][1],tbl[i+1][2]
        if x<=x1 then
            local t=(x-x0)/(x1-x0)
            return y0+(y1-y0)*t
        end
    end
    return tbl[#tbl][2]
end

local function gauges()
    local stabil_ind = get(stab_pos)*5.5
    local elev_ind   = -get(elevator_L)
    local flap_L     = get(flap_inn_L)
    local flap_R     = get(flap_inn_R)
    if get(bus36_volt_left)>30 then
        -- OK
    else
        stabil_ind, elev_ind, flap_L, flap_R = 0,0,0,0
    end
    local ias  = get(indicated_airspeed)*1.852
    local mach = get(machno)
    local elev_coef = mach<1 and 1/interpolate(mach_tbl,mach) or 1/0.1

    local delta = passed
    stab_ind_act    = stab_ind_act    + (stabil_ind - stab_ind_act)    * delta * 10
    elev_ind_act    = elev_ind_act    + (elev_ind*elev_coef - elev_ind_act)* delta * 10
    flap_L_act      = flap_L_act      + (flap_L - flap_L_act)          * delta * 10
    flap_R_act      = flap_R_act      + (flap_R - flap_R_act)          * delta * 10

    set(stab_ind, stab_ind_act)
    set(elevator_ind, elev_ind_act)
    set(flap_left_ind, flap_L_act)
    set(flap_right_ind, flap_R_act)
end

-- Cap covers: check for changes and enforce interlocks, play sound
local function caps_check()
    -- Auto-reset busters cap if any buster switch is open under its cover
    if get(busters_cap) == 0
       and (get(buster_on_1) * get(buster_on_2) * get(buster_on_3)) == 0
    then
        set(busters_cap, 1)
    end

    -- Sum current cover states
    local total =
          get(stab_man_cap)
        + get(contr_force_cap)
        + get(nosewheel_turn_cap)
        + get(slat_man_cap)
        + get(gears_retr_lock_cap)
        + get(gears_ext_3GS_cap)
        + get(busters_cap)
        + get(flaps_sel_cap)
        + get(emerg_elev_trimm_cap)

    -- Sum previous cover states
    local prev =
          stab_man_cap_last
        + contr_force_cap_last
        + nosewheel_turn_cap_last
        + slat_man_cap_last
        + gears_retr_lock_cap_last
        + gears_ext_3GS_cap_last
        + busters_cap_last
        + flaps_sel_cap_last
        + emerg_elev_trimm_cap_last

    -- Play cap sound on any change
    if total ~= prev then
        playSample(cap_sound, 0)
    end

    -- Update last-state variables
    stab_man_cap_last         = get(stab_man_cap)
    contr_force_cap_last      = get(contr_force_cap)
    nosewheel_turn_cap_last   = get(nosewheel_turn_cap)
    slat_man_cap_last         = get(slat_man_cap)
    gears_retr_lock_cap_last  = get(gears_retr_lock_cap)
    gears_ext_3GS_cap_last    = get(gears_ext_3GS_cap)
    busters_cap_last          = get(busters_cap)
    flaps_sel_cap_last        = get(flaps_sel_cap)
    emerg_elev_trimm_cap_last = get(emerg_elev_trimm_cap)

    -- Enforce interlocks (auto-close switches under closed caps)
    if get(nosewheel_turn_cap) == 0 then set(nosewheel_turn_sel, 0) end
    if get(contr_force_cap)   == 0 then set(contr_force_set,   0) end
    if get(gears_retr_lock_cap)== 0 then set(gears_retr_lock,   0) end
    if get(flaps_sel_cap)     == 0 then set(flaps_sel,         0) end
    if get(gears_ext_3GS_cap) == 0 then set(gears_ext_3GS,     0) end
end

-- Switches: detect click changes, enforce cap-logic, play switch sound
local function switchers_check()
    -- Sum current switch states
    local sumNow =
          get(stab_manual)
        + get(stab_setting)
        + get(ail_trimm_sw)
        + get(rudd_trimm_sw)
        + get(contr_force_set)
        + get(nosewheel_turn_enable)
        + get(nosewheel_turn_sel)
        + get(slat_man)
        + get(flaps_sel)
        + get(gears_retr_lock)
        + get(gears_ext_3GS)
        + get(buster_on_1)
        + get(buster_on_2)
        + get(buster_on_3)
        + get(emerg_elev_trimm)

    -- Sum previous switch states
    local sumLast =
          stab_manual_last
        + stab_setting_last
        + ail_trimm_sw_last
        + rudd_trimm_sw_last
        + contr_force_set_last
        + nosewheel_turn_enable_last
        + nosewheel_turn_sel_last
        + slat_man_last
        + flaps_sel_last
        + gears_retr_lock_last
        + gears_ext_3GS_last
        + buster_on_1_last
        + buster_on_2_last
        + buster_on_3_last
        + emerg_elev_trimm_last

    -- Play switch sound on any change
    if sumNow ~= sumLast then
        playSample(switcher_sound, 0)
    end

    -- Update last-state variables
    stab_manual_last        = get(stab_manual)
    stab_setting_last       = get(stab_setting)
    ail_trimm_sw_last       = get(ail_trimm_sw)
    rudd_trimm_sw_last      = get(rudd_trimm_sw)
    contr_force_set_last    = get(contr_force_set)
    nosewheel_turn_enable_last = get(nosewheel_turn_enable)
    nosewheel_turn_sel_last = get(nosewheel_turn_sel)
    slat_man_last           = get(slat_man)
    flaps_sel_last          = get(flaps_sel)
    gears_retr_lock_last    = get(gears_retr_lock)
    gears_ext_3GS_last      = get(gears_ext_3GS)
    buster_on_1_last        = get(buster_on_1)
    buster_on_2_last        = get(buster_on_2)
    buster_on_3_last        = get(buster_on_3)
    emerg_elev_trimm_last   = get(emerg_elev_trimm)

    -- Enforce cap-logic
    if get(nosewheel_turn_cap) == 0 then set(nosewheel_turn_sel, 0) end
    if get(contr_force_cap)   == 0 then set(contr_force_set,   0) end
    if get(gears_retr_lock_cap)== 0 then set(gears_retr_lock,   0) end
    if get(flaps_sel_cap)     == 0 then set(flaps_sel,         0) end
    if get(gears_ext_3GS_cap) == 0 then set(gears_ext_3GS,     0) end
end

-- Startup timer & main update
local sim_start_timer = 0
function update()
    passed = get(frame_time)
    sim_start_timer = sim_start_timer + passed

    -- Delayed cold & dark reset logic and click detection
    if sim_start_timer > 0.3 then
        if notLoaded then reset_switchers() end
        switchers_check()
        caps_check()
    end
    gauges()
    lamps()
end
