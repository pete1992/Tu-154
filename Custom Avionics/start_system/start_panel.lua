defineProperty("starter_press", globalPropertyf("sim/custom/gauges/eng/starter_press")) 
defineProperty("starter_cap", globalPropertyi("sim/custom/switchers/eng/starter_cap")) 
defineProperty("starter_switch", globalPropertyi("sim/custom/switchers/eng/starter_switch")) 
defineProperty("starter_eng_select", globalPropertyi("sim/custom/switchers/eng/starter_eng_select")) 
defineProperty("starter_mode", globalPropertyi("sim/custom/switchers/eng/starter_mode")) 
defineProperty("starter_start", globalPropertyi("sim/custom/buttons/eng/starter_start")) 
defineProperty("starter_stop", globalPropertyi("sim/custom/buttons/eng/starter_stop")) 
defineProperty("flight_start_1", globalPropertyi("sim/custom/buttons/eng/flight_start_1")) 
defineProperty("flight_start_2", globalPropertyi("sim/custom/buttons/eng/flight_start_2")) 
defineProperty("flight_start_3", globalPropertyi("sim/custom/buttons/eng/flight_start_3")) 
defineProperty("reserv_pump_test", globalPropertyi("sim/custom/buttons/eng/reserv_pump_test")) 
defineProperty("apd_work_1", globalPropertyf("sim/custom/lights/small/apd_work_1")) 
defineProperty("apd_work_2", globalPropertyf("sim/custom/lights/small/apd_work_2")) 
defineProperty("apd_work_3", globalPropertyf("sim/custom/lights/small/apd_work_3")) 
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right")) 
defineProperty("bus36_volt_left", globalPropertyf("sim/custom/elec/bus36_volt_left")) 
defineProperty("bus36_volt_right", globalPropertyf("sim/custom/elec/bus36_volt_right")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("starter_pressure", globalPropertyf("sim/custom/start/starter_pressure")) 
defineProperty("apd_working_1", globalPropertyf("sim/custom/start/apd_working_1")) 
defineProperty("apd_working_2", globalPropertyf("sim/custom/start/apd_working_2")) 
defineProperty("apd_working_3", globalPropertyf("sim/custom/start/apd_working_3")) 
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')
local passed = 0
local starter_cap_last = get(starter_cap)
local starter_switch_last = get(starter_switch)
local starter_eng_select_last = get(starter_eng_select)
local starter_mode_last = get(starter_mode)
local starter_start_last = get(starter_start)
local starter_stop_last = get(starter_stop)
local flight_start_1_last = get(flight_start_1)
local flight_start_2_last = get(flight_start_2)
local flight_start_3_last = get(flight_start_3)
local reserv_pump_test_last = get(reserv_pump_test)
local function check_controls()
	local starter_cap_sw = get(starter_cap)
	local starter_switch_sw = get(starter_switch)
	local starter_eng_select_sw = get(starter_eng_select)
	local starter_mode_sw = get(starter_mode)
	if starter_cap_sw - starter_cap_last ~= 0 then playSample(cap_sound, 0) end
	if starter_cap_sw == 0 then
		set(starter_switch, 0)
		set(starter_eng_select, 0)
	end
	local switch_change = starter_switch_sw + starter_eng_select_sw + starter_mode_sw
	switch_change = switch_change - starter_switch_last - starter_eng_select_last - starter_mode_last
	if switch_change ~= 0 then playSample(switcher_sound, 0) end
	local starter_start_sw = get(starter_start)
	local starter_stop_sw = get(starter_stop)
	local flight_start_1_sw = get(flight_start_1)
	local flight_start_2_sw = get(flight_start_2)
	local flight_start_3_sw = get(flight_start_3)
	local reserv_pump_test_sw = get(reserv_pump_test)
	local button_change = starter_start_sw + starter_stop_sw + flight_start_1_sw + flight_start_2_sw + flight_start_3_sw + reserv_pump_test_sw
	button_change = button_change - starter_start_last - starter_stop_last - flight_start_1_last - flight_start_2_last - flight_start_3_last - reserv_pump_test_last
	if button_change ~= 0 then playSample(button_sound, 0) end
	starter_cap_last = starter_cap_sw
	starter_switch_last = starter_switch_sw
	starter_eng_select_last = starter_eng_select_sw
	starter_mode_last = starter_mode_sw
	starter_start_last = starter_start_sw
	starter_stop_last = starter_stop_sw
	flight_start_1_last = flight_start_1_sw
	flight_start_2_last = flight_start_2_sw
	flight_start_3_last = flight_start_3_sw
	reserv_pump_test_last = reserv_pump_test_sw
end
local function lamps()
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	local apd_work_1_brt = get(apd_working_1) * lamps_brt 
	set(apd_work_1, apd_work_1_brt)	
	local apd_work_2_brt = get(apd_working_2) * lamps_brt 
	set(apd_work_2, apd_work_2_brt)	
	local apd_work_3_brt = get(apd_working_3) * lamps_brt 
	set(apd_work_3, apd_work_3_brt)	
end
local start_press_act = 0
function update()
	passed = get(frame_time)
	check_controls()
	lamps()
	local start_press = 0
	if get(bus36_volt_left) > 30 and get(bus36_volt_right) > 30 then start_press = get(starter_pressure) end
	start_press_act = start_press_act + (start_press - start_press_act) * passed * 2
	set(starter_press, start_press_act)
end
