defineProperty("bkk_on", globalPropertyi("sim/custom/switchers/ovhd/bkk_on")) 
defineProperty("bkk_contr", globalPropertyi("sim/custom/switchers/ovhd/bkk_contr")) 
defineProperty("roll_a", globalPropertyf("sim/custom/bkk/pkp_roll_left")) 
defineProperty("roll_b", globalPropertyf("sim/custom/bkk/pkp_roll_right")) 
defineProperty("roll_c", globalPropertyf("sim/custom/gyro/mgv_contr_roll")) 
defineProperty("pitch_a", globalPropertyf("sim/custom/gyro/ahz_pitch_int_L")) 
defineProperty("pitch_b", globalPropertyf("sim/custom/gyro/ahz_pitch_int_R")) 
defineProperty("pitch_c", globalPropertyf("sim/custom/gyro/mgv_contr_pitch")) 
defineProperty("bkk_fail", globalPropertyi("sim/custom/failures/bkk_fail")) 
defineProperty("left_roll_big", globalPropertyi("sim/custom/bkk/left_roll_big")) 
defineProperty("right_roll_big", globalPropertyi("sim/custom/bkk/right_roll_big")) 
defineProperty("mgv_contr_fail", globalPropertyi("sim/custom/bkk/mgv_contr_fail")) 
defineProperty("no_contr_ag", globalPropertyi("sim/custom/bkk/no_contr_ag")) 
defineProperty("pkp_fail_left", globalPropertyi("sim/custom/bkk/pkp_fail_left")) 
defineProperty("pkp_fail_right", globalPropertyi("sim/custom/bkk/pkp_fail_right")) 
defineProperty("roll_left_high", globalPropertyf("sim/custom/lights/roll_left_high")) 
defineProperty("roll_right_high", globalPropertyf("sim/custom/lights/roll_right_high")) 
defineProperty("mgv_control_fail", globalPropertyf("sim/custom/lights/mgv_control_fail")) 
defineProperty("no_ag_controll", globalPropertyf("sim/custom/lights/no_ag_controll")) 
defineProperty("bkk_ok", globalPropertyf("sim/custom/lights/small/bkk_ok")) 
defineProperty("mgv_flag", globalPropertyf("sim/custom/gyro/mgv_contr_flag")) 
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) 
defineProperty("radio_alt", globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")) 
defineProperty("bkk_pitch", globalPropertyf("sim/custom/bkk/bkk_pitch")) 
defineProperty("bkk_roll", globalPropertyf("sim/custom/bkk/bkk_roll")) 
defineProperty("absu_landing_on", globalPropertyi("sim/custom/switchers/console/absu_landing_on")) 
defineProperty("test_lamps", globalPropertyi("sim/custom/buttons/lamp_test_front")) 
defineProperty("day_night_set", globalPropertyf("sim/custom/lights/day_night_set")) 
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right")) 
local fail_a = false
local fail_b = false
local fail_c = false
local flag_ab = false
local flag_ac = false
local flag_bc = false
local roll_res = 0
local pitch_res = 0
local flight_mode = true 
function update()
	local power = get(bkk_on) == 1 and get(bus27_volt_left) > 13 and get(bus27_volt_right) > 13 and get(bkk_fail) == 0
	local a = get(roll_a)
	local b = get(roll_b)
	local c = get(roll_c)
	if power then
		if math.abs (a - b) > 7 then flag_ab = true end
		if math.abs (a - c) > 7 then flag_ac = true end
		if math.abs (b - c) > 7 then flag_bc = true end
		if not fail_a then fail_a = flag_ab and flag_ac end
		if not fail_b then fail_b = flag_ab and flag_bc end
		if not fail_c then fail_c = flag_ac and flag_bc end
	else
		fail_a = false
		fail_b = false
		fail_c = false	
		flag_ab = false
		flag_ac = false
		flag_bc = false
	end
	local roll_left = 0
	local roll_right = 0
	local pkp_fail_l = 0
	local pkp_fail_r = 0
	local mgv_fail = 0
	local bkk_fail = 0
	local bkk_test_ok = 0
	local test = get(bkk_contr) ~= 0
	local spd = get(ias) * 1.852 
	local alt = get(radio_alt) * 0.3048 
	if spd <= 280 or (alt <= 250 and get(absu_landing_on) == 1) then flight_mode = false 
	elseif spd >= 340 then flight_mode = true end 
	if power then
		roll_left = bool2int(test or (a < -33 and flight_mode) or (a < -15 and not flight_mode))
		roll_right = bool2int(test or (a > 33 and flight_mode) or (a > 15 and not flight_mode))
		pkp_fail_l = bool2int(fail_a or test)
		pkp_fail_r = bool2int(fail_b or test)
		mgv_fail = bool2int(fail_c or get(mgv_flag) == 1 or test)
		bkk_test_ok = bool2int(test)
		if test then
			fail_a = false
			fail_b = false
			fail_c = false
			flag_ab = false
			flag_ac = false
			flag_bc = false
		end
	else
		roll_left = 0
		roll_right = 0
		bkk_test_ok = 0
		bkk_fail = 1
	end
	if pkp_fail_l + pkp_fail_r + mgv_fail < 3 then
		roll_res = (a * (1 - pkp_fail_l) + b * (1 - pkp_fail_r) + c * (1 - mgv_fail)) / ((1 - pkp_fail_l) + (1 - pkp_fail_r) + (1 - mgv_fail))
		local ap = get(pitch_a)
		local bp = get(pitch_b)
		local cp = get(pitch_c)
		pitch_res = (ap * (1 - pkp_fail_l) + bp * (1 - pkp_fail_r) + cp * (1 - mgv_fail)) / ((1 - pkp_fail_l) + (1 - pkp_fail_r) + (1 - mgv_fail))
	end
	set(bkk_pitch, pitch_res)
	set(bkk_roll, roll_res)
	set(left_roll_big, roll_left)
	set(right_roll_big, roll_right)
	set(mgv_contr_fail, mgv_fail)
	set(no_contr_ag, bkk_fail)
	set(pkp_fail_left, pkp_fail_l)
	set(pkp_fail_right, pkp_fail_r)
	local test_btn = get(test_lamps) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	local roll_left_high_brt = math.max(roll_left * lamps_brt, test_btn)
	set(roll_left_high, roll_left_high_brt)
	local roll_right_high_brt = math.max(roll_right * lamps_brt, test_btn)
	set(roll_right_high, roll_right_high_brt)
	local mgv_control_fail_brt = math.max(mgv_fail * lamps_brt, test_btn)
	set(mgv_control_fail, mgv_control_fail_brt)
	local no_ag_controll_brt = math.max(bkk_fail * lamps_brt, test_btn)
	set(no_ag_controll, no_ag_controll_brt)
	set(bkk_ok, bkk_test_ok)
end
