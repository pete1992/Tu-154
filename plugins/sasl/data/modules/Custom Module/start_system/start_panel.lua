-- this is start-up panel

-- controls and gauges
defineProperty("starter_press", globalPropertyf("tu154ce/gauges/eng/starter_press")) -- pressure gauge for engine start system

defineProperty("starter_cap", globalPropertyi("tu154ce/switchers/eng/starter_cap")) -- starter panel cover (safety flap)
defineProperty("starter_switch", globalPropertyi("tu154ce/switchers/eng/starter_switch")) -- main starter system switch
defineProperty("starter_eng_select", globalPropertyi("tu154ce/switchers/eng/starter_eng_select")) -- engine selector for startup (1–3)
defineProperty("starter_mode", globalPropertyi("tu154ce/switchers/eng/starter_mode")) -- startup mode selector (manual or auto)

defineProperty("starter_start", globalPropertyi("tu154ce/buttons/eng/starter_start")) -- engine start button
defineProperty("starter_stop", globalPropertyi("tu154ce/buttons/eng/starter_stop")) -- stop/start interruption button

defineProperty("flight_start_1", globalPropertyi("tu154ce/buttons/eng/flight_start_1")) -- in-flight engine start (engine 1)
defineProperty("flight_start_2", globalPropertyi("tu154ce/buttons/eng/flight_start_2")) -- in-flight engine start (engine 2)
defineProperty("flight_start_3", globalPropertyi("tu154ce/buttons/eng/flight_start_3")) -- in-flight engine start (engine 3)

defineProperty("reserv_pump_test", globalPropertyi("tu154ce/buttons/eng/reserv_pump_test")) -- test button for fuel reserve pump



-- lamps
defineProperty("apd_work_1", globalPropertyf("tu154ce/lights/small/apd_work_1")) -- APD status lamp: active (engine 1)
defineProperty("apd_work_2", globalPropertyf("tu154ce/lights/small/apd_work_2")) -- APD status lamp: active (engine 2)
defineProperty("apd_work_3", globalPropertyf("tu154ce/lights/small/apd_work_3")) -- APD status lamp: active (engine 3)


-- sources
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left")) -- voltage on 27 V left bus
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right")) -- voltage on 27 V right bus
defineProperty("bus36_volt_left", globalPropertyf("tu154ce/elec/bus36_volt_left")) -- voltage on 36 V left bus
defineProperty("bus36_volt_right", globalPropertyf("tu154ce/elec/bus36_volt_right")) -- voltage on 36 V right bus

-- time
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) -- time passed per frame (in seconds)

defineProperty("starter_pressure", globalPropertyf("tu154ce/start/starter_pressure")) -- current pressure in start air system

defineProperty("apd_working_1", globalPropertyf("tu154ce/start/apd_working_1")) -- startup system active (engine 1)
defineProperty("apd_working_2", globalPropertyf("tu154ce/start/apd_working_2")) -- startup system active (engine 2)
defineProperty("apd_working_3", globalPropertyf("tu154ce/start/apd_working_3")) -- startup system active (engine 3)

include("smooth_light.lua")

-- sounds
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
	
	----------------
	if starter_cap_sw - starter_cap_last ~= 0 then  end
	
	if starter_cap_sw == 0 then
		set(starter_switch, 0)
		set(starter_eng_select, 0)
		--set(starter_mode, 0)
	
	end
	----------------
	local switch_change = starter_switch_sw + starter_eng_select_sw + starter_mode_sw
	
	switch_change = switch_change - starter_switch_last - starter_eng_select_last - starter_mode_last
	
	if switch_change ~= 0 then  end
	
	----------------
	local starter_start_sw = get(starter_start)
	local starter_stop_sw = get(starter_stop)
	local flight_start_1_sw = get(flight_start_1)
	local flight_start_2_sw = get(flight_start_2)
	local flight_start_3_sw = get(flight_start_3)
	local reserv_pump_test_sw = get(reserv_pump_test)
	
	local button_change = starter_start_sw + starter_stop_sw + flight_start_1_sw + flight_start_2_sw + flight_start_3_sw + reserv_pump_test_sw
	
	button_change = button_change - starter_start_last - starter_stop_last - flight_start_1_last - flight_start_2_last - flight_start_3_last - reserv_pump_test_last
	
	if button_change ~= 0 then  end
	
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
	--local test_btn = get(test_lamps)
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0)
	
	local apd_work_1_brt = get(apd_working_1) * lamps_brt 
	set(apd_work_1, smooth_light(apd_work_1_brt, get(apd_work_1)))
	
	local apd_work_2_brt = get(apd_working_2) * lamps_brt 
	set(apd_work_2, smooth_light(apd_work_2_brt, get(apd_work_2)))
	
	local apd_work_3_brt = get(apd_working_3) * lamps_brt 
	set(apd_work_3, smooth_light(apd_work_3_brt, get(apd_work_3)))
	

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



