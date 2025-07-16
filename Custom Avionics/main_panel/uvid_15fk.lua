defineProperty("static_fail_L", globalPropertyi("sim/operation/failures/rel_static"))  
defineProperty("bus27_volt", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("bus115_volt", globalPropertyf("sim/custom/elec/bus115_1_volt")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("uvid_fail", globalPropertyi("sim/custom/failures/uvid15_fail")) 
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  
defineProperty("msl_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  
defineProperty("uvid_needle_left", globalPropertyf("sim/custom/gauges/alt/uvid_needle_left"))  
defineProperty("uvid_feet_counter", globalPropertyf("sim/custom/gauges/alt/uvid_feet_counter"))  
defineProperty("uvid_hundreads_counter", globalPropertyf("sim/custom/gauges/alt/uvid_hundreads_counter"))  
defineProperty("uvid_thousands_counter", globalPropertyf("sim/custom/gauges/alt/uvid_thousands_counter"))  
defineProperty("uvid_tens_thousands_counter", globalPropertyf("sim/custom/gauges/alt/uvid_tens_thousands_counter"))  
defineProperty("uvid_pressure_knob", globalPropertyf("sim/custom/gauges/alt/uvid_pressure_knob"))  
defineProperty("uvid_pressure_one", globalPropertyf("sim/custom/gauges/alt/uvid_pressure_one"))  
defineProperty("uvid_pressure_ten", globalPropertyf("sim/custom/gauges/alt/uvid_pressure_ten"))  
defineProperty("uvid_pressure_hund", globalPropertyf("sim/custom/gauges/alt/uvid_pressure_hund"))  
defineProperty("uvid_pressure_thous", globalPropertyf("sim/custom/gauges/alt/uvid_pressure_thous"))  
defineProperty("uvid_on", globalPropertyi("sim/custom/switchers/ovhd/uvid_on"))  
defineProperty("sim_barometer_setting", globalPropertyf("sim/cockpit/misc/barometer_setting"))  
defineProperty("vd15_lamp", globalPropertyf("sim/custom/lights/small/vd15_lamp"))  
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local left_MSL = 0
local uvid_alt = 0
local uvid_alt_act = 0
local switcher_last = get(uvid_on)
function update()
	local passed = get(frame_time)
	local staticFail_left = get(static_fail_L) == 6
	local msl = get(msl_alt) * 3.28083 
	if not staticFail_left then
		left_MSL = msl 
	end
	local power27 = get(bus27_volt) > 13
	local power115 = get(bus115_volt) > 110
	local sw_on = get(uvid_on) == 1
	local press_set = get(uvid_pressure_knob)
	local press_inHg = press_set * 0.0295300586467
	if switcher_last ~= sw_on then
		playSample(switcher_sound, 0)
	end
	switcher_last = sw_on
	if power27 and power115 and sw_on and get(uvid_fail) == 0 then
		uvid_alt = left_MSL + (press_inHg - get(msl_press)) * 1000  
	end
	uvid_alt_act = uvid_alt_act + (uvid_alt - uvid_alt_act) * passed * 5
	local alt_dr_1 = uvid_alt_act % 100
	local alt_dr_100 = math.floor((uvid_alt_act % 1000) * 0.01) + math.max(math.max((alt_dr_1 - 50), 0) / 50, 0)
	local alt_dr_1000 = math.floor((uvid_alt_act % 10000) * 0.001) + math.max(math.max((alt_dr_100 - 9), 0), 0)
	local alt_dr_10th = math.floor((uvid_alt_act % 100000) * 0.0001) + math.max(math.max((alt_dr_1000 - 9), 0), 0)
	local press_1 = press_set % 10
	local press_10 = math.floor((press_set % 100) * 0.1) + math.max(math.max((press_1 - 9), 0), 0)
	local press_100 = math.floor((press_set % 1000) * 0.01) + math.max(math.max((press_10 - 9), 0), 0)
	local press_1000 = math.floor((press_set % 10000) * 0.001) + math.max(math.max((press_100 - 9), 0), 0)
	local lamp_shine = power27 and sw_on and (not power115 or uvid_alt > 50000 or press_set < 788 or press_set > 1074)
	set(vd15_lamp, bool2int(lamp_shine))
	set(uvid_needle_left, uvid_alt_act * 360 / 1000)
	set(uvid_feet_counter, uvid_alt_act)
	set(uvid_hundreads_counter, alt_dr_100)
	set(uvid_thousands_counter, alt_dr_1000)
	set(uvid_tens_thousands_counter, alt_dr_10th)
	set(uvid_pressure_one, press_1)
	set(uvid_pressure_ten, press_10)
	set(uvid_pressure_hund, press_100)
	set(uvid_pressure_thous, press_1000)
	set(sim_barometer_setting, press_inHg)
end