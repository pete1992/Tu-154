defineProperty("gs_press_1", globalPropertyf("sim/custom/hydro/gs_press_1")) 
defineProperty("gs_press_2", globalPropertyf("sim/custom/hydro/gs_press_2")) 
defineProperty("gs_press_3", globalPropertyf("sim/custom/hydro/gs_press_3")) 
defineProperty("gears_retr_lock", globalPropertyi("sim/custom/switchers/gears_retr_lock")) 
defineProperty("gears_ext_3GS", globalPropertyi("sim/custom/switchers/gears_ext_3GS")) 
defineProperty("emerg_gear_ext", globalPropertyi("sim/custom/controll/emerg_gear_ext")) 
defineProperty("gear_lever", globalPropertyi("sim/custom/controll/gear_lever")) 
defineProperty("gear1_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  
defineProperty("gear2_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  
defineProperty("gear3_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  
defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  
defineProperty("airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))  
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("G", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) 
defineProperty("total_time", globalPropertyf("sim/time/total_flight_time_sec"))
defineProperty("agl", globalPropertyf("sim/flightmodel/position/y_agl"))
defineProperty("retract1_fail", globalPropertyi("sim/operation/failures/rel_lagear1")) 
defineProperty("retract2_fail", globalPropertyi("sim/operation/failures/rel_lagear2")) 
defineProperty("retract3_fail", globalPropertyi("sim/operation/failures/rel_lagear3")) 
defineProperty("actuator_fail", globalPropertyi("sim/operation/failures/rel_gear_act")) 
defineProperty("rel_wing1L", globalPropertyi("sim/operation/failures/rel_wing1L"))  
defineProperty("rel_wing1R", globalPropertyi("sim/operation/failures/rel_wing1R"))  
defineProperty("rel_collapse1", globalPropertyi("sim/operation/failures/rel_collapse1"))
defineProperty("rel_collapse2", globalPropertyi("sim/operation/failures/rel_collapse2"))
defineProperty("rel_collapse3", globalPropertyi("sim/operation/failures/rel_collapse3"))
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right")) 
defineProperty("cam_in_cockpit", globalPropertyi("sim/graphics/view/view_is_external"))
defineProperty("gear_handle_1", globalPropertyi("sim/cockpit/switches/gear_handle_status"))
defineProperty("gear_handle_2", globalPropertyi("sim/cockpit2/controls/gear_handle_down"))
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
set(gear1_deploy, 1)
set(gear2_deploy, 1)	
set(gear3_deploy, 1)
гонка шасси.
уборка основных: 0:11 - 0:38/0:41 = 27-30 сек
уборка передней ноги: 0:11 - 0:28 = 27 сек
выпуск шасси
основных: 0:57 - 1:15 = 18 сек
переднейноги: 0:57 - 1:14 = 17 сек
среднее время основных: 24 сек
среднее время передней: 22 сек
local lock_sound = loadSample('Custom Sounds/gear_lock.wav') 
local handle_sound = loadSample('Custom Sounds/geal_lvr.wav') 
gear_command_up = findCommand("sim/flight_controls/landing_gear_up")
gear_command_down = findCommand("sim/flight_controls/landing_gear_down")
gear_toggle = findCommand("sim/flight_controls/landing_gear_toggle")
local passed = 0
local lock1 = true  
local lock2 = true
local lock3 = true
local fake_command = false 
local power = 1
function gear_up_handler(phase)
	if 0 == phase then
		if get(gear_lever) > -1 then set(gear_lever, get(gear_lever) - 1) end
		else set(gear_lever, 0) end
		set(gear_handle_1, 0)
		set(gear_handle_2, 0)
	end
	return 0
end
function gear_down_handler(phase)
	if 0 == phase then
		if get(gear_lever) < 1 then set(gear_lever, get(gear_lever) + 1) end
		else set(gear_lever, 0) end
		set(gear_handle_1, 1)
		set(gear_handle_2, 1)
	end
	return 0
end
function gear_toggle_handler(phase)
	if 0 == phase then
		local a = get(gear_lever)
		if a ~= 0 then
			if a == 1 then
				set(gear_handle_1, 1)
				set(gear_handle_2, 1)
			elseif a == -1 then
				set(gear_handle_1, 0)
				set(gear_handle_2, 0)
			end
			a = 0
		else
			if get(gear1_deploy) > 0.7 then
				a = -1
				set(gear_handle_1, 0)
				set(gear_handle_2, 0)
			elseif get(gear1_deploy) < 0.3 then
				a =  1
				set(gear_handle_1, 1)
				set(gear_handle_2, 1)
			end
		end
		set(gear_lever, a)
	end
	return 0
end
registerCommandHandler(gear_command_up, 0, gear_up_handler)
registerCommandHandler(gear_command_down, 0, gear_down_handler)
registerCommandHandler(gear_toggle, 0, gear_toggle_handler)
local lock1_last = lock1
local lock2_last = lock2
local lock3_last = lock3
local pos1_last = get(gear1_deploy)
local pos2_last = get(gear2_deploy)
local pos3_last = get(gear3_deploy)
local pos1 = get(gear1_deploy)  
local pos2 = get(gear2_deploy)
local pos3 = get(gear3_deploy)
if pos1 < 0.5 then 
	pos1 = 0 
	lock1 = true
end
if pos2 < 0.5 then 
	pos2 = 0 
	lock2 = true
end
if pos3 < 0.5 then 
	pos3 = 0 
	lock3 = true
end
if pos1 > 0 then pos1 = 1 end
if pos2 > 0 then pos2 = 1 end
if pos3 > 0 then pos3 = 1 end
local GEAR_SPEED_FRONT = 0.039 
local GEAR_SPEED_LEFT = 0.039 
local GEAR_SPEED_RIGHT = 0.039 
local G_coef_front = 0.08
local G_coef_main = 0.08
local A_coef_front = 0.000025
local A_coef_main =  0.00003
local start_timer = 0
local lever_last = get(gear_lever)
function update()
	if get(total_time) < 10 and get(agl) < 50 then
		pos1 = 1
		pos2 = 1
		pos3 = 1
	end
	if get(total_time) < 5 then
		if get(agl) < 50 then
			pos1 = 1
			pos2 = 1
			pos3 = 1
		else
			pos1 = 0
			pos2 = 0
			pos3 = 0
		end
	end
local MASTER = get(ismaster) ~= 1
	local view_ext = get(cam_in_cockpit)
	passed = get(frame_time)
	if passed > 0 then
		local main_hydro = math.min(get(gs_press_1) / 100, 1)
		local main_hydro_2 = math.min(get(gs_press_2) / 100, 1)
		local aux_hydro = math.min(get(gs_press_3) / 100, 1)
		local power_L = bool2int(get(bus27_volt_left) > 13)
		local power_R = bool2int(get(bus27_volt_right) > 13)
		local IAS = get(airspeed) ^ 2
		local retract = false
		if get(gear2_deflect) < 0.01 or get(gears_retr_lock) ~= 0 then retract = true else retract = false end
		local gs_in_use = get(gears_ext_3GS)
		local lever = get(gear_lever) * bool2int(get(actuator_fail) ~= 6)
		local dirrection = lever * main_hydro * power_L * (1 - gs_in_use) * 2 + lever * aux_hydro * power_R * gs_in_use * 1.3 + get(emerg_gear_ext) * main_hydro_2 * 1.3
		if lever == -1 then
			set(gear_handle_1, 0)
			set(gear_handle_2, 0)
		elseif lever == 1 then
			set(gear_handle_1, 1)
			set(gear_handle_2, 1)
		end
		if lever ~= lever_last then playSample(handle_sound, 0) end
		lever_last = lever
		local gear_move = bool2int(power_L * (1 - gs_in_use) == 1 or power_R * gs_in_use == 1)
		if not lock1 and retract then
			pos1 = pos1_last + GEAR_SPEED_FRONT * (dirrection * bool2int(get(retract1_fail) < 6) + get(G) * (math.cos(math.pi * pos1_last / 4) + 0.2) * G_coef_front - IAS * math.sin(math.pi * pos1_last / 3) * A_coef_front) * passed * gear_move
			if pos1 < 0 then  
				pos1 = 0
				lock1 = true
			elseif pos1 > 1 then
				pos1 = 1
				lock1 = true
			end
		end
		if not lock2 and retract then
			pos2 = pos2_last + GEAR_SPEED_LEFT * (dirrection * bool2int(get(retract2_fail) < 6) + get(G) * (math.cos(math.pi * pos1_last / 5) + 0.3) * G_coef_main - IAS * math.sin(math.pi * pos1_last / 5) * A_coef_main) * passed * gear_move
			if pos2 < 0 then  
				pos2 = 0
				lock2 = true
			elseif pos2 > 1 then
				pos2 = 1
				lock2 = true
			end
		end
		if not lock3 and retract then
			pos3 = pos3_last + GEAR_SPEED_RIGHT * (dirrection * bool2int(get(retract3_fail) < 6) + get(G) * (math.cos(math.pi * pos1_last / 5) + 0.3) * G_coef_main - IAS * math.sin(math.pi * pos1_last / 5) * A_coef_main) * passed * gear_move
			if pos3 < 0 then  
				pos3 = 0
				lock3 = true
			elseif pos3 > 1 then
				pos3 = 1
				lock3 = true
			end
		end
		if pos1 > 1 then pos1 = 1 end
		if pos1 < 0 then pos1 = 0 end
		if pos2 > 1 then pos2 = 1 end
		if pos2 < 0 then pos2 = 0 end
		if pos3 > 1 then pos3 = 1 end
		if pos3 < 0 then pos3 = 0 end
		lock1 = dirrection < 1 and pos1 == 0 or dirrection > -1 and pos1 == 1
		lock2 = dirrection < 1 and pos2 == 0 or dirrection > -1 and pos2 == 1
		lock3 = dirrection < 1 and pos3 == 0 or dirrection > -1 and pos3 == 1
		if get(emerg_gear_ext) == 1 then
			if pos1 < 0.9 then lock1 = false end
			if pos2 < 0.9 then lock2 = false end
			if pos3 < 0.9 then lock3 = false end
			if pos1 > 0.99 then lock1 = true pos1 = 1 end
			if pos2 > 0.99 then lock2 = true pos2 = 1 end
			if pos3 > 0.99 then lock3 = true pos3 = 1 end
		end
		if lock1_last ~= lock1 then 
			playSample(lock_sound, 0)
		end
		if get(rel_collapse1) == 6 then pos1 = 0.1 end
		if get(rel_collapse2) == 6 then pos2 = 0.1 end
		if get(rel_collapse3) == 6 then pos3 = 0.1 end
		if get(rel_wing1L) == 6 then pos3 = 0 end
		if get(rel_wing1R) == 6 then pos2 = 0 end
if MASTER then	
		set(gear1_deploy, pos1)
		set(gear2_deploy, pos2)	
		set(gear3_deploy, pos3)
else 
		pos1 = get(gear1_deploy)
		pos2 = get(gear2_deploy)
		pos3 = get(gear3_deploy)
end
		pos1_last = pos1
		pos2_last = pos2
		pos3_last = pos3
		lock1_last = lock1
		lock2_last = lock2
		lock3_last = lock3		
	end
end
function onAvionicsDone()
	set(gear1_deploy, 1)
	set(gear2_deploy, 1)	
	set(gear3_deploy, 1)
	print("gears reset to extended")
end
