defineProperty("tks_mode", globalPropertyi("sim/custom/switchers/ovhd/tks_mode")) 
defineProperty("tks_user", globalPropertyi("sim/custom/switchers/ovhd/tks_mode_left")) 
defineProperty("tks_source", globalPropertyi("sim/custom/switchers/ovhd/tks_mode_right")) 
defineProperty("tks_course_set", globalPropertyi("sim/custom/switchers/ovhd/tks_course_set")) 
defineProperty("tks_corrr_button", globalPropertyi("sim/custom/buttons/ovhd/tks_corrr_button")) 
defineProperty("tks_lat_set", globalPropertyf("sim/custom/rotary/ovhd/tks_lat_set")) 
defineProperty("stabil_ga_main", globalPropertyi("sim/custom/switchers/ovhd/stabil_ga_main")) 
defineProperty("stabil_ga_reserv", globalPropertyi("sim/custom/switchers/ovhd/stabil_ga_reserv")) 
defineProperty("fail_left", globalPropertyi("sim/custom/tks/fail_left")) 
defineProperty("fail_right", globalPropertyi("sim/custom/tks/fail_right")) 
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right"))
defineProperty("mgv_flag", globalPropertyf("sim/custom/gyro/mgv_contr_flag")) 
defineProperty("mgv_contr_fail", globalPropertyi("sim/custom/bkk/mgv_contr_fail")) 
defineProperty("tks_main_fail", globalPropertyf("sim/custom/lights/small/tks_main_fail")) 
defineProperty("tks_contr_fail", globalPropertyf("sim/custom/lights/small/tks_contr_fail")) 
defineProperty("ga_main_fail", globalPropertyf("sim/custom/lights/ga_main_fail")) 
defineProperty("ga_reserve_fail", globalPropertyf("sim/custom/lights/ga_reserve_fail")) 
defineProperty("lamp_test", globalPropertyi("sim/custom/buttons/lamp_test_front")) 
defineProperty("day_night_set", globalPropertyf("sim/custom/lights/day_night_set")) 
local switcher_sound = loadSample('Custom Sounds/plastic_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')
local sw_last = 0
local butt_last = get(tks_corrr_button)
local function switchers_check()
	local tks_mode_sw = get(tks_mode)
	local tks_user_sw = get(tks_user)
	local tks_source_sw = get(tks_source)
	local tks_course_set_sw = get(tks_course_set)
	local sw_summ = tks_mode_sw + tks_user_sw + tks_source_sw + tks_course_set_sw
	if sw_summ ~= sw_last then
		playSample(switcher_sound, 0)
	end
	sw_last = sw_summ
	local butt_now = get(tks_corrr_button)
	if butt_last ~= butt_now then
		playSample(button_sound, 0)
	end
	butt_last = butt_now
end
local function lamps()
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	local fail_main = bool2int(get(fail_left) == 1) 
	local tks_main_fail_brt = math.max(fail_main * lamps_brt, 0)
	set(tks_main_fail, tks_main_fail_brt)
	local fail_aux = bool2int(get(fail_right) == 1) 
	local tks_contr_fail_brt = math.max(fail_aux * lamps_brt, 0)
	set(tks_contr_fail, tks_contr_fail_brt)
	local test_btn = get(lamp_test) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	local ga_main_fail_brt = math.max(fail_main * lamps_brt, test_btn)
	set(ga_main_fail, ga_main_fail_brt)
	local ga_reserve_fail_brt = math.max(fail_aux * lamps_brt, test_btn)
	set(ga_reserve_fail, ga_reserve_fail_brt)
end
function update()
	switchers_check()
	lamps()	
end