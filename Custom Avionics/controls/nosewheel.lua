defineProperty("nosewheel_turn_enable", globalPropertyi("tu154ce/switchers/nosewheel_turn_enable")) 
defineProperty("nosewheel_turn_sel", globalPropertyi("tu154ce/switchers/nosewheel_turn_sel")) 
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right")) 
defineProperty("gs_press_2", globalPropertyf("tu154ce/hydro/gs_press_2")) 
defineProperty("have_pedals", globalPropertyi("tu154ce/have_pedals"))
tiller_avail = globalPropertyi("sim/joystick/joy_mapped_axis_avail[37]") 
tiller_val = globalPropertyf("sim/joystick/joy_mapped_axis_value[37]") 
joy_yaw = globalPropertyf("sim/cockpit2/controls/yoke_heading_ratio") 
tire_steer_command_deg = globalPropertyf("sim/flightmodel2/gear/tire_steer_command_deg[0]")
tire_steer_actual_deg = globalPropertyf("sim/flightmodel2/gear/tire_steer_actual_deg[0]")
pushback = globalPropertyi("bp/connected")
override_wheel_steer = globalPropertyi("sim/operation/override/override_wheel_steer")
defineProperty("weel_angle1", globalPropertyf("sim/aircraft/gear/acf_nw_steerdeg1"))
defineProperty("weel_angle2", globalPropertyf("sim/aircraft/gear/acf_nw_steerdeg2"))
defineProperty("lock", globalPropertyi("sim/cockpit2/controls/nosewheel_steer_on"))
function update()
	set(override_wheel_steer, 1)
	local press = math.min(get(gs_press_2) / 200, 1)
	if (get(bus27_volt_left) > 13 or get(bus27_volt_right) < 13) and get(nosewheel_turn_enable) == 1 and press > 0.2 then
		set(lock, 1) 
		local turn_mode = get(nosewheel_turn_sel)
		if turn_mode == 0 then set(weel_angle1, 10 * press) set(weel_angle2, 10 * press)
		else set(weel_angle1, 65 * press) set(weel_angle2, 65 * press)
		end
	else
		set(lock, 0)
		set(weel_angle1, 0) 
		set(weel_angle2, 0)
	end
	local pbConnect = get(pushback) == 1
	if not pbConnect then
		if get(have_pedals) == 1 then 
			set(tire_steer_command_deg, get(tiller_val) * get(weel_angle1))
		else 
			set(tire_steer_command_deg, get(joy_yaw) * get(weel_angle1))
		end
	end
end
gear_togle_command = findCommand("sim/flight_controls/nwheel_steer_toggle")
function gear_toggle_handler(phase)
	if 0 == phase then
		if get(nosewheel_turn_enable) ~= 1 then set(nosewheel_turn_enable, 1)
		else set(nosewheel_turn_enable, 0) end
	end
return 0
end
registerCommandHandler(gear_togle_command, 0, gear_toggle_handler)
function onAvionicsDone()
	set(override_wheel_steer, 0)
end