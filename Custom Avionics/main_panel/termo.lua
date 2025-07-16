defineProperty("thermo", globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc")) 
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("thermo_outside", globalPropertyf("sim/custom/gauges/misc/thermo_outside")) 
local termENG_act = -55
function update()
	local passed = get(frame_time)
	local therm = -55
	if get(bus27_volt_right) > 13 then
		therm = get(thermo)
	end
	if therm > 115 then therm = 115
	elseif therm < -55 then therm = -55 end
	termENG_act = termENG_act + (therm - termENG_act) * passed * 5
	set(thermo_outside, termENG_act)
end
