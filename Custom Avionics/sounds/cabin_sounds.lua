defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external")) 
defineProperty("dh_set_L", globalPropertyf("sim/custom/gauges/alt/radioalt_dh_left"))  
defineProperty("dh_set_R", globalPropertyf("sim/custom/gauges/alt/radioalt_dh_right"))  
defineProperty("rv_angle_L", globalPropertyf("sim/custom/gauges/alt/radioalt_needle_left"))  
defineProperty("rv_angle_R", globalPropertyf("sim/custom/gauges/alt/radioalt_needle_right"))  
defineProperty("rv5_dh_signal_left", globalPropertyi("sim/custom/misc/rv5_dh_signal_left"))
defineProperty("rv5_dh_signal_right", globalPropertyi("sim/custom/misc/rv5_dh_signal_right"))
defineProperty("roll_main_mode", globalPropertyi("sim/custom/absu/roll_main_mode")) 
defineProperty("pitch_main_mode", globalPropertyi("sim/custom/absu/pitch_main_mode")) 
defineProperty("stu_mode", globalPropertyi("sim/custom/absu/stu_mode")) 
defineProperty("absu_fail_signal", globalPropertyi("sim/custom/absu/absu_fail_signal")) 
defineProperty("main_gear_flaps", globalPropertyi("sim/custom/alarm/main_gear_flaps")) 
defineProperty("main_pressure", globalPropertyi("sim/custom/alarm/main_pressure")) 
defineProperty("speaker_auasp", globalPropertyi("sim/custom/alarm/speaker_auasp")) 
defineProperty("speaker_fuel", globalPropertyi("sim/custom/alarm/speaker_fuel")) 
defineProperty("speaker_speed", globalPropertyi("sim/custom/alarm/speaker_speed")) 
defineProperty("speaker_absu", globalPropertyi("sim/custom/alarm/speaker_absu")) 
defineProperty("fire_siren", globalPropertyi("sim/custom/fire/fire_siren")) 
defineProperty("srd_buzzer", globalPropertyi("sim/custom/switchers/eng/srd_buzzer")) 
defineProperty("fuel_buzzer", globalPropertyi("sim/custom/switchers/eng/fuel_buzzer")) 
defineProperty("srd_buzzer_cap", globalPropertyi("sim/custom/switchers/eng/srd_buzzer_cap")) 
defineProperty("fuel_buzzer_cap", globalPropertyi("sim/custom/switchers/eng/fuel_buzzer_cap")) 
defineProperty("srd_buzzer_test", globalPropertyi("sim/custom/buttons/eng/srd_buzzer_test")) 
defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))   
defineProperty("middle_marker", globalPropertyi("sim/cockpit/misc/middle_marker_lit"))
defineProperty("inner_marker", globalPropertyi("sim/cockpit/misc/inner_marker_lit"))
defineProperty("light_open_left", globalPropertyf("sim/custom/anim/light_open_left")) 
defineProperty("light_open_right", globalPropertyf("sim/custom/anim/light_open_right")) 
defineProperty("airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) 
defineProperty("bus27_volt_L", globalPropertyf("sim/custom/elec/bus27_volt_left"))
defineProperty("bus27_volt_R", globalPropertyf("sim/custom/elec/bus27_volt_right"))
defineProperty("bus27_source_left", globalPropertyf("sim/custom/elec/bus27_source_left")) 
defineProperty("bus27_source_right", globalPropertyf("sim/custom/elec/bus27_source_right")) 
defineProperty("pilot_Z", globalPropertyf("sim/aircraft/view/acf_peZ")) 
defineProperty("air_usage_L", globalPropertyf("sim/custom/bleed/air_usage_L")) 
defineProperty("air_usage_R", globalPropertyf("sim/custom/bleed/air_usage_R")) 
defineProperty("deflection_mtr_2", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]")) 
defineProperty("deflection_mtr_3", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]")) 
defineProperty("groundspeed", globalPropertyf("sim/flightmodel/position/groundspeed")) 
defineProperty("flaps_lever", globalPropertyf("sim/custom/controll/flaps_lever")) 
defineProperty("engine_volume_ratio", globalPropertyf("sim/operation/sound/engine_volume_ratio")) 
defineProperty("prop_volume_ratio", globalPropertyf("sim/operation/sound/prop_volume_ratio")) 
defineProperty("ground_volume_ratio", globalPropertyf("sim/operation/sound/ground_volume_ratio")) 
defineProperty("weather_volume_ratio", globalPropertyf("sim/operation/sound/weather_volume_ratio")) 
defineProperty("warning_volume_ratio", globalPropertyf("sim/operation/sound/warning_volume_ratio")) 
defineProperty("radio_volume_ratio", globalPropertyf("sim/operation/sound/radio_volume_ratio")) 
defineProperty("fan_volume_ratio", globalPropertyf("sim/operation/sound/fan_volume_ratio")) 
defineProperty("main_alarm_fail", globalPropertyi("sim/custom/failures/main_alarm_fail")) 
defineProperty("speaker_alarm_fail", globalPropertyi("sim/custom/failures/speaker_alarm_fail")) 
defineProperty("failures_enabled", globalPropertyi("sim/custom/failures/failures_enabled"))
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local absu_sound = loadSample('Custom Sounds/short_speaker.wav') 
local long_speaker = loadSample('Custom Sounds/long_speaker.wav')
local inverters = loadSample('Custom Sounds/inverters.wav') 
local long_sirena = loadSample('Custom Sounds/long_siren.wav')
local short_sirena = loadSample('Custom Sounds/short_siren.wav')
local bell = loadSample('Custom Sounds/mrp_bell.wav') 
local rv5_tone = loadSample('Custom Sounds/rv5_tone.wav') 
local lights_noise = loadSample('Custom Sounds/lights_noise.wav') 
local air_cond_noise = loadSample('Custom Sounds/air_noise.wav') 
local taxi_noise = loadSample('Custom Sounds/roll_inn.wav') 
local flaps_sound = loadSample('Custom Sounds/flaps_hnd.wav') 
local RV_counter = 0
local RV_played = true
local absu_last = get(roll_main_mode) + get(pitch_main_mode)
local stu_last = get(stu_mode)
local invert_counter = 0
playSample(inverters, 1)
setSampleGain(inverters, 0)
local short_siren_timer = 0
local short_speaker_timer = 0
local long_speaker_timer = 0
playSample(air_cond_noise, 1)
setSampleGain(air_cond_noise, 0)
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')
local cap_sound = loadSample('Custom Sounds/cap.wav')
local switchers_last = 0
local caps_last = 0
local buttons_last = 0
local fail_counter = 0
local check_time = math.random(15, 30)
function update()
	local passed = get(frame_time)
	local run = bool2int(passed ~= 0)
	local external = get(external_view)
	local power = get(bus27_volt_L) > 13 or get(bus27_volt_R) > 13
	local warn_vl = get(warning_volume_ratio)
	local switchers = get(srd_buzzer) + get(fuel_buzzer)
	if switchers ~= switchers_last then playSample(switcher_sound, 0) end
	switchers_last = switchers
	local caps = get(srd_buzzer_cap) + get(fuel_buzzer_cap)
	if caps ~= caps_last then playSample(cap_sound, 0) end
	caps_last = caps
	local buttons = get(srd_buzzer_test)
	if buttons ~= buttons_last then playSample(button_sound, 0) end
	buttons_last = buttons	
	local RV_must_play = get(rv5_dh_signal_left) == 1 or get(rv5_dh_signal_right) == 1 and power
	if RV_must_play and not RV_played and external == 0 then 
		RV_counter = 7 
		RV_played = true
	end
	if not RV_must_play then 
		RV_played = false 
		RV_counter = 0
	end
	RV_counter = RV_counter - passed
	if not isSamplePlaying(rv5_tone) and RV_counter > 0 then playSample(rv5_tone, 1) end
	if RV_counter <= 0 then stopSample(rv5_tone) end
	setSampleGain(rv5_tone, 1000 * warn_vl)
	if (get(main_gear_flaps) == 1 or get(fire_siren) == 1) and power and get(srd_buzzer) == 1 and external == 0 and get(main_alarm_fail) == 0 then 
		if not isSamplePlaying(long_sirena) then playSample(long_sirena, 1) end
	elseif get(srd_buzzer) == 1 and get(main_pressure) == 1 and power and external == 0 and get(main_alarm_fail) == 0 then
		short_siren_timer = short_siren_timer + passed
		if not isSamplePlaying(long_sirena) and short_siren_timer > 0.2 then playSample(long_sirena, 1) end
		if short_siren_timer > 0.4 then 
			short_siren_timer = 0 
			stopSample(long_sirena)
		end
	else
		stopSample(long_sirena)
	end
	if passed == 0 or external == 1 then
		stopSample(long_sirena)		
	end
	if short_siren_timer > 0.4 then short_siren_timer = 0 end
	setSampleGain(long_sirena, 1000 * warn_vl)
	local absu_now = get(roll_main_mode) + get(pitch_main_mode)
	local stu_now = get(stu_mode)
	if power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0 and get(absu_fail_signal) == 1 then 
		if not isSamplePlaying(absu_sound) then playSample(absu_sound, 0) end
		stopSample(long_speaker)
	elseif get(speaker_auasp) == 1 and power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0 then 
		if not isSamplePlaying(long_speaker) then playSample(long_speaker, 1) end
		stopSample(absu_sound)
	elseif (get(speaker_fuel) == 1 or get(speaker_speed) == 1) and power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0  then
		short_speaker_timer = short_speaker_timer + passed
		if not isSamplePlaying(long_speaker) and short_speaker_timer > 0.3 then playSample(long_speaker, 1) end
		if short_speaker_timer > 0.6 then 
			short_speaker_timer = 0 
			stopSample(long_speaker)
		end
		stopSample(absu_sound)
	elseif ((absu_now ~= absu_last and absu_now < 4) or (stu_last >= 3 and stu_now <= 2)) and power and external == 0 and get(fuel_buzzer) == 1 and get(speaker_alarm_fail) == 0 then 
		playSample(absu_sound, 0) 
		stopSample(long_speaker)
	else
		stopSample(long_speaker)
	end
	absu_last = absu_now
	stu_last = stu_now
	setSampleGain(long_speaker, 1000 * warn_vl)
	local inner = get(inner_marker) == 1
	local middle = get(middle_marker) == 1
	local outer = get(outer_marker) == 1
	local mrp_power = power 
	if (inner or middle or outer) and mrp_power and external == 0 then 
		if not isSamplePlaying(bell) then playSample(bell, 0) end
	else 
	end
	setSampleGain(bell, 1000 * warn_vl)
	local fan_vl = get(fan_volume_ratio)
	local vu_L = get(bus27_source_left)
	local vu_R = get(bus27_source_right)
	if power then invert_counter = invert_counter + passed
	else invert_counter = invert_counter - passed * 0.3 end
	if invert_counter > 1 then invert_counter = 1
	elseif invert_counter < 0 then invert_counter = 0 end
	local dist = -get(pilot_Z) + 9 
	setSampleGain(inverters, fan_vl * invert_counter * 200 * (bool2int(vu_L == 1 or vu_L == 2) + bool2int(vu_R == 1 or vu_R == 2)) * (1 - external) * math.max(dist - 25, 0) * 0.2 * run)
	setSamplePitch(inverters, invert_counter * 800 + 200)
	if passed == 0 or external == 1 then
		setSampleGain(inverters, 0)
	end	
	local air_usage = get(air_usage_L) + get(air_usage_R)
	setSampleGain(air_cond_noise, fan_vl * math.min(600, air_usage) * 1 * (1 - external) * run)
	setSamplePitch(air_cond_noise, 1000)
	local taxi_gain = bool2int(math.max(get(deflection_mtr_2), get(deflection_mtr_3)) > 0.001) * math.max(get(groundspeed) - 50, 0) * (1 - external) 
	local taxi_pitch = 1000 + (get(groundspeed) - 80) * 3
	if taxi_gain > 0 then
		if not isSamplePlaying(taxi_noise) then playSample(taxi_noise, 1) end
	else
		stopSample(taxi_noise)
	end
	setSampleGain(taxi_noise, taxi_gain * 10 * get(ground_volume_ratio))
	setSamplePitch(taxi_noise, taxi_pitch)
	local light_L = get(light_open_left)
	local light_R = get(light_open_right)
	local IAS = get(airspeed)
	if light_L + light_R > 0.1 then
		if not isSamplePlaying(lights_noise) then playSample(lights_noise, 1) end
		local gain =  math.max(IAS - 150, 0) * (light_L + light_R) * (1 - external) * 1 * get(weather_volume_ratio)
		setSampleGain(lights_noise, gain)
		setSamplePitch(lights_noise, 250 + IAS * 1)
	else
		stopSample(lights_noise)
	end
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		fail_counter = fail_counter + passed
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			if get(main_alarm_fail) ~= 1 then set(main_alarm_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(speaker_alarm_fail) ~= 1 then set(speaker_alarm_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
		end
	else
		fail_counter = 0
		set(main_alarm_fail, 0)
		set(speaker_alarm_fail, 0)
	end
end	
end