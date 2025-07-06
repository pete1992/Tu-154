-- this is an APU panel
-- gauges and controlls
defineProperty("apu_main_switch", globalPropertyi("tu154ce/switchers/eng/apu_main_switch")) -- APU main switch
defineProperty("apu_start_mode", globalPropertyi("tu154ce/switchers/eng/apu_start_mode")) -- APU start mode
defineProperty("apu_air_bleed", globalPropertyi("tu154ce/switchers/eng/apu_air_bleed")) -- Air bleed valve control. -1 = closed, 0 = neutral, +1 = open
defineProperty("apu_start", globalPropertyi("tu154ce/buttons/eng/apu_start")) -- APU start button
defineProperty("apu_stop", globalPropertyi("tu154ce/buttons/eng/apu_stop")) -- APU stop button

defineProperty("apu_rpm", globalPropertyf("tu154ce/gauges/eng/apu_rpm")) -- APU RPM. 0–100%
defineProperty("apu_egt_gau", globalPropertyf("tu154ce/gauges/eng/apu_egt")) -- APU EGT. 0–900°C
defineProperty("apu_oil_temp", globalPropertyf("tu154ce/gauges/eng/apu_oil_temp")) -- APU oil temperature -50 to 150°C

-- lamps
defineProperty("low_oil", globalPropertyf("tu154ce/lights/apu/low_oil")) -- Low oil quantity
defineProperty("low_oil_press", globalPropertyf("tu154ce/lights/apu/low_oil_press")) -- Low oil pressure
defineProperty("high_temp", globalPropertyf("tu154ce/lights/apu/high_temp")) -- Overtemperature
defineProperty("high_rpm", globalPropertyf("tu154ce/lights/apu/high_rpm")) -- Overspeed
defineProperty("pta6_fail", globalPropertyf("tu154ce/lights/apu/pta6_fail")) -- PTA-6A failure
defineProperty("doors_open", globalPropertyf("tu154ce/lights/apu/doors_open")) -- APU doors open
defineProperty("fuel_press", globalPropertyf("tu154ce/lights/apu/fuel_press")) -- Fuel pressure
defineProperty("start_ready", globalPropertyf("tu154ce/lights/apu/start_ready")) -- Ready to start
defineProperty("work_mode", globalPropertyf("tu154ce/lights/apu/work_mode")) -- Operating mode active
defineProperty("start_apu", globalPropertyf("tu154ce/lights/apu/start_apu")) -- Start the APU

-- internal datarefs
defineProperty("apu_n1", globalPropertyf("tu154ce/eng/apu_n1")) -- APU RPM
defineProperty("apu_oil_t", globalPropertyf("tu154ce/eng/apu_oil_t")) -- APU oil temperature
defineProperty("apu_oil_q", globalPropertyf("tu154ce/eng/apu_oil_q")) -- APU oil quantity
defineProperty("apu_oil_p", globalPropertyf("tu154ce/eng/apu_oil_p")) -- APU oil pressure
defineProperty("apu_egt", globalPropertyf("tu154ce/eng/apu_egt")) -- APU exhaust gas temperature
defineProperty("apu_air_press", globalPropertyf("tu154ce/eng/apu_air_press")) -- APU air pressure for engine start

defineProperty("apu_air_doors", globalPropertyf("tu154ce/eng/apu_air_doors")) -- APU air doors position
defineProperty("apu_fuel_p", globalPropertyf("tu154ce/eng/apu_fuel_p")) -- APU fuel pressure

defineProperty("apu_start_bus", globalPropertyf("tu154ce/elec/apu_start_bus")) -- APU electrical bus voltage
defineProperty("apu_start_cc", globalPropertyf("tu154ce/elec/apu_start_cc")) -- APU starter current consumption
defineProperty("apu_start_seq", globalPropertyi("tu154ce/elec/apu_start_seq")) -- APU start sequence status

defineProperty("apu_doors", globalPropertyf("tu154ce/anim/apu_doors")) -- APU doors position. 0 = closed, 1 = open

defineProperty("cockpit_window_left", globalPropertyf("tu154ce/anim/cockpit_window_left")) -- Left cockpit window open
defineProperty("cockpit_window_right", globalPropertyf("tu154ce/anim/cockpit_window_right")) -- Right cockpit window open

-- other sources
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left")) -- 27V electrical bus voltage (left)
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right")) -- 27V electrical bus voltage (right)

defineProperty("outside_air_temp", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) -- Outside air temperature in °C

-- lamp sources
defineProperty("test_lamps", globalPropertyi("tu154ce/buttons/lamp_test_apu")) -- APU panel lamp test button
defineProperty("day_night_set", globalPropertyf("tu154ce/lights/day_night_set")) -- Day/night switch. 0 = day, 1 = night (dims indicator lamps)
defineProperty("gear_vent_set", globalPropertyi("tu154ce/switchers/eng/gear_fan")) -- Gear ventilation switch

-- environment
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external")) -- External camera view active

-- time
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) -- flight time

-- default sim APU
defineProperty("APU_generator_on", globalPropertyi("sim/cockpit2/electrical/APU_generator_on")) -- boolean	APU generator is turned on, 0 or 1.
defineProperty("APU_starter_switch", globalPropertyi("sim/cockpit2/electrical/APU_starter_switch")) -- boolean	APU power switch, 0 is off, 1 is on, 2 is start-er-up!
defineProperty("APU_N1_percent", globalPropertyf("sim/cockpit2/electrical/APU_N1_percent")) -- percent	N1 of the APU
defineProperty("APU_running", globalPropertyi("sim/cockpit2/electrical/APU_running")) -- boolean	APU actually running, 0 or 1.

-- only define if available
if findDataRef("sim/cockpit/engine/APU_switch") then
    defineProperty("has_apu_switch", globalPropertyi("sim/cockpit/engine/APU_switch"))
end
--defineProperty("acf_has_APU_switch", globalPropertyi("sim/aircraft/overflow/acf_has_APU_switch")) -- 
defineProperty("rel_APU_press", globalPropertyi("sim/operation/failures/rel_APU_press")) -- 
defineProperty("bleed_air_mode", globalPropertyi("sim/cockpit2/pressurization/actuators/bleed_air_mode")) -- Bleed air mode, 0=of, 1=left,2=both,3=right,4=apu,5=auto

-- coordinates of airplane and camera
defineProperty("local_x", globalPropertyf("sim/flightmodel/position/local_x")) -- position X
defineProperty("local_y", globalPropertyf("sim/flightmodel/position/local_y")) -- position Y
defineProperty("local_z", globalPropertyf("sim/flightmodel/position/local_z")) -- position Z

defineProperty("view_x", globalPropertyf("sim/graphics/view/view_x")) -- camera position X
defineProperty("view_y", globalPropertyf("sim/graphics/view/view_y")) -- camera position Y
defineProperty("view_z", globalPropertyf("sim/graphics/view/view_z")) -- camera position Z


-- failures
defineProperty("apu_start_fail", globalPropertyi("tu154ce/failures/apu_start_fail")) -- Starter failure
defineProperty("apu_gen_fail", globalPropertyi("tu154ce/failures/apu_gen_fail")) -- Generator failure
defineProperty("apu_fail_oilt", globalPropertyi("tu154ce/failures/apu_fail_oilt")) -- Oil temperature failure
defineProperty("apu_fail_egt", globalPropertyi("tu154ce/failures/apu_fail_egt")) -- EGT failure
defineProperty("apu_fail_fuel_left", globalPropertyi("tu154ce/failures/apu_fail_fuel_left")) -- Failure due to residual fuel in combustion chamber at startup
defineProperty("apu_fail", globalPropertyi("tu154ce/failures/apu_fail")) -- Failure due to service life
defineProperty("apu_press_fail", globalPropertyi("tu154ce/failures/apu_press_fail")) -- Air bleed failure from engine


include("smooth_light.lua")


-- sounds
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')

local passed = get(frame_time)


local function default_APU()
	set(rel_APU_press, 0)
	set(acf_has_APU_switch, 1)
	set(APU_generator_on, 1)
	set(bleed_air_mode, 4)
	-- start APU if it's not running
	if (get(APU_running) ~= 1 or get(APU_N1_percent) < 50) and (get(bus27_volt_left) > 10 or get(bus27_volt_right) > 10) then
		set(APU_starter_switch, 2)
	elseif get(bus27_volt_left) > 10 or get(bus27_volt_right) > 10 then
		set(APU_starter_switch, 1)
	else set(APU_starter_switch, 0)
	end
end


local n1_table_start = {{ -5000, 0},    -- bugs workaround
				  { 0, 0 },
				  { 8, 0 },   --
				  { 12, 15 },   --
				  { 14, 5 },   --
				  { 16, 18 },   --
				  { 18, 15 },   --
				  { 20, 20 },   --
				  { 110, 110 },  -- 
          		  { 1000, 110 }}   -- bugs workaround

local n1_table_off = {{ -5000, 0},    -- bugs workaround
				  { 0, 0 },
				  { 110, 110 },  -- 
          		  { 1000, 110 }}   -- bugs workaround

local n1_actual = 0
local EGT_actual = 0
local oil_t_actual = -60

local function gauges()
	local n1_angle = 0
	local EGT_angle = 0
	local oil_t_angle = -60
	local n1 = get(apu_n1)
	if n1 > n1_actual then n1_angle = interpolate(n1_table_start, n1) -- if starting, add needle trembling
	else n1_angle = interpolate(n1_table_off, n1) end
	EGT_angle = get(apu_egt)

	if EGT_angle < -10 then EGT_angle = -10 end

	if get(bus27_volt_right) > 13 then
		oil_t_angle = get(apu_oil_t)
	else
		oil_t_angle = -75
	end

	--n1_angle = 99
	--EGT_angle = 300
	--oil_t_angle = 100

	-- set smooth movements
	n1_actual = n1_actual + (n1_angle - n1_actual) * passed * 5
	EGT_actual = EGT_actual + (EGT_angle - EGT_actual) * passed * 3
	oil_t_actual = oil_t_actual + (oil_t_angle - oil_t_actual) * passed * 3

	-- set results
	set(apu_rpm, n1_actual)
	set(apu_egt_gau, EGT_actual)
	set(apu_oil_temp, oil_t_actual)

end



local apu_main_last = get(apu_main_switch)
local apu_start_mod_last = get(apu_start_mode)
local apu_air_last = get(apu_air_bleed)
local apu_start_last = get(apu_start)
local apu_stop_last = get(apu_stop)
local test_lamps_last = get(test_lamps)

local function check_controls()

	local apu_main_sw = get(apu_main_switch)
	local apu_start_mod_sw = get(apu_start_mode)
	local apu_air_sw = get(apu_air_bleed)
	local apu_start_but = get(apu_start)
	local apu_stop_but = get(apu_stop)
	local test_lamps_but = get(test_lamps)

	local changes_sw = apu_main_sw + apu_start_mod_sw + apu_air_sw - apu_main_last - apu_start_mod_last - apu_air_last
	local changes_but = apu_start_but + apu_stop_but + test_lamps_but - apu_start_last - apu_stop_last - test_lamps_last

	if changes_sw ~= 0 then  end
	if changes_but ~= 0 then  end

	apu_main_last = apu_main_sw
	apu_start_mod_last = apu_start_mod_sw
	apu_air_last = apu_air_sw
	apu_start_last = apu_start_but
	apu_stop_last = apu_stop_but
	test_lamps_last = test_lamps_but
end


local low_oil_press_sign = 0
local high_temp_sign = 0
local high_rpm_sign = 0

local start_ready_brt = 0
local t = 0
local function lamps()

	local test_btn = get(test_lamps) * math.max((get(bus27_volt_right) - 10) / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.8
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night

	-- local variables
	local rpm = get(apu_n1)
	local start_seq = get(apu_start_seq) == 1
	local thermo = get(apu_egt)
	local main_sw = get(apu_main_switch) == 1

	-- red signs. resets only after disabling APU switcher
	if get(apu_oil_p) < 1 then low_oil_press_sign = 1 end
	if (start_seq and thermo > 700) or (not start_seq and thermo > 570) then high_temp_sign = 1 end
	if rpm > 105 then high_rpm_sign = 1 end

	-- reset red signs
	if not main_sw then
		low_oil_press_sign = 0
		high_temp_sign = 0
		high_rpm_sign = 0
	end

	local low_oil_brt = 0
	if get(apu_oil_q) < 0.4 then low_oil_brt = 1 end


	low_oil_brt = math.max(low_oil_brt * lamps_brt, test_btn) * math.max(math.fmod(sasl.getCurrentCycle() * 0.01, 1), 1.0)

	set(low_oil, smooth_light(low_oil_brt, get(low_oil)))

	local low_oil_press_brt = math.max(low_oil_press_sign * lamps_brt, test_btn)
	set(low_oil_press, smooth_light(low_oil_press_brt, get(low_oil_press)))

	local high_temp_brt = math.max(high_temp_sign * lamps_brt, test_btn)
	set(high_temp, smooth_light(high_temp_brt, get(high_temp)))

	local high_rpm_brt = math.max(high_rpm_sign * lamps_brt, test_btn)
	set(high_rpm, smooth_light(high_rpm_brt, get(high_rpm)))

	local pta6_fail_brt = math.max(0, test_btn) -- TODO: implement PTA-6
	set(pta6_fail, smooth_light(pta6_fail_brt, get(pta6_fail)))

	local doors_open_brt = 0
	if get(apu_doors) > 0.9 then doors_open_brt = 1 end
	doors_open_brt = math.max(doors_open_brt * lamps_brt, test_btn)
	set(doors_open, smooth_light(doors_open_brt, get(doors_open)))

	local fuel_press_brt = 0
	if get(apu_fuel_p) > 0.8 then fuel_press_brt = 1 end
	fuel_press_brt = math.max(fuel_press_brt * lamps_brt, test_btn)
	set(fuel_press, smooth_light(fuel_press_brt, get(fuel_press)))


	if get(apu_air_doors) == 0 and get(apu_doors) == 1 then start_ready_brt = 1 end
	if get(apu_air_doors) == 1 or get(apu_doors) < 0.9 then start_ready_brt = 0 end
	local start_ready_lit = math.max(start_ready_brt * lamps_brt, test_btn)
	set(start_ready, smooth_light(start_ready_lit, get(start_ready)))

	local work_mode_brt = 0
	if rpm > 92 and main_sw then work_mode_brt = 1 end
	work_mode_brt = math.max(work_mode_brt * lamps_brt, test_btn)
	set(work_mode, smooth_light(work_mode_brt, get(work_mode)))

	-- Initialize brightness value for the APU START lamp
local start_apu_brt = 0

-- If the APU RPM is below 92 and the gear ventilation switch is active, turn on the brightness
if rpm < 92 and get(gear_vent_set) == 1 then
	start_apu_brt = 1
end

-- Determine final brightness: either based on dimmer knob (lamps_brt) or test button (test_btn)
start_apu_brt = math.max(start_apu_brt * lamps_brt, test_btn)

-- Set the smoothed brightness value to the lamp
set(start_apu, smooth_light(start_apu_brt, get(start_apu)))

end


function update()
	passed = get(frame_time)

	default_APU()
	check_controls()
	lamps()
	gauges()
	--apu_sound()

end