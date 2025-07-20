defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("pitch_sim", globalPropertyf("sim/flightmodel/position/theta"))
defineProperty("roll_sim", globalPropertyf("sim/flightmodel/position/phi"))
sim/flightmodel/position/theta	float	y	degrees	The pitch relative to the plane normal to the Y axis in degrees
sim/flightmodel/position/phi	float	y	degrees	The roll of the aircraft in degrees
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))
defineProperty("N3", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[2]"))
defineProperty("pitch_corr_hdl", globalPropertyf("tu154ce/gauges/ahz/pitch_corr_C")) 
defineProperty("agr_on", globalPropertyi("tu154ce/switchers/ovhd/agr_on")) 
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu154ce/elec/bus36_volt_pts250_1"))
defineProperty("bus115_1_volt", globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("bus115_2_volt", globalPropertyf("tu154ce/elec/bus115_2_volt"))
defineProperty("bus115_3_volt", globalPropertyf("tu154ce/elec/bus115_3_volt"))
defineProperty("agr_fail", globalPropertyi("tu154ce/failures/agr_fail")) 
defineProperty("res_pitch", globalPropertyf("tu154ce/gauges/ahz/pitch_C")) 
defineProperty("res_roll", globalPropertyf("tu154ce/gauges/ahz/roll_C")) 
defineProperty("agr_cc", globalPropertyf("tu154ce/ahz/agr_cc")) 
defineProperty("ahz_flag", globalPropertyf("tu154ce/gauges/ahz/ahz_flag_C")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local initial_roll_err = 0 
local roll_corr = 0  
local roll_show = 0  
local roll_off = 0 
local initial_pitch_err = 0 
local pitch_corr = 0  
local pitch_show = 0  
local pitch_off = 0 
local arrest = 0  
local arrest_push = false 
local pitch_rot = 0
local ahz_fail = true
local fail = 0
local power_roll = 0 
local power_pitch = 0 
local time_counter = 0
local notLoaded = true
local roll_show_2 = roll_show
local pitch_show_2 = pitch_show
function update()
	local passed = get(frame_time)
	local power = get(bus27_volt_left) > 13 and get(bus36_volt_pts250_1) > 30 and get(agr_on) == 1 and get(agr_fail) == 0
	set(agr_cc, bool2int(power))
	time_counter = time_counter + passed	
	if time_counter > 0.3 and time_counter < 0.4 and notLoaded and get(N1) < 10 and get(N2) < 10 and get(N3) < 10 then
		initial_roll_err = math.random(-30, 30)
		roll_off = math.random(-1, 1)
		initial_pitch_err = math.random(-30, 30)
		pitch_off = math.random(-1, 1)
		notLoaded = false
	elseif time_counter > 0.3 and time_counter < 0.4 and notLoaded then 
		roll_off = math.random(-1, 1)
		pitch_off = math.random(-1, 1)	
		notLoaded = false	
	end
	if not power then
		power_roll = get(roll_sim)
		power_pitch = get(pitch_sim)
	end 
	if not power then
		if math.abs(initial_roll_err) < 30 then initial_roll_err = initial_roll_err + passed * roll_off * 0.1 end
		if math.abs(initial_pitch_err) < 30 then initial_pitch_err = initial_pitch_err + passed * pitch_off * 0.1 end
	else
		if initial_roll_err > 0.1 then initial_roll_err = initial_roll_err - passed * 0.3
		elseif initial_roll_err < -0.1 then initial_roll_err = initial_roll_err + passed * 0.3
		else initial_roll_err = 0 end
		if initial_pitch_err > 0.1 then initial_pitch_err = initial_pitch_err - passed * 0.3
		elseif initial_pitch_err < -0.1 then initial_pitch_err = initial_pitch_err + passed * 0.3
		else initial_pitch_err = 0 end
		if power_roll > 0.05 then power_roll = power_roll - passed * 0.1
		elseif power_roll < -0.05 then power_roll = power_roll + passed * 0.1 
		else power_roll = 0 end
		if power_pitch > 0.05 then power_pitch = power_pitch - passed * 0.1
		elseif power_pitch < -0.05 then power_pitch = power_pitch + passed * 0.1 
		else power_pitch = 0 end
		if roll_corr > 0.05 then roll_corr = roll_corr - 0.1 * passed
		elseif roll_corr < -0.05 then roll_corr = roll_corr + 0.1 * passed 
		else roll_corr = 0 end
		if pitch_corr > 0.05 then pitch_corr = pitch_corr - 0.1 * passed
		elseif pitch_corr < -0.05 then pitch_corr = pitch_corr + 0.1 * passed 
		else pitch_corr = 0 end
	end
	if arrest > 0 and power then
		if math.abs(initial_roll_err) < 0.1 then
			if roll_show > 0.1 then roll_corr = roll_corr + 6 * passed
			elseif roll_show < -0.1 then roll_corr = roll_corr - 6 * passed end
		end
		if math.abs(initial_pitch_err) < 0.1 then
			if pitch_show > 0.1 then pitch_corr = pitch_corr + 6 * passed
			elseif pitch_show < -0.1 then pitch_corr = pitch_corr - 6 * passed end
		end
		if power_roll > 0.1 then power_roll = power_roll - passed
		elseif power_roll < -0.1 then power_roll = power_roll + passed end
		if power_pitch > 0.1 then power_pitch = power_pitch - passed
		elseif power_pitch < -0.1 then power_pitch = power_pitch + passed end
		if initial_roll_err > 0.1 then initial_roll_err = initial_roll_err - passed * 6
		elseif initial_roll_err < -0.1 then initial_roll_err = initial_roll_err + passed * 6 end
		if initial_pitch_err > 0.1 then initial_pitch_err = initial_pitch_err - passed * 6
		elseif initial_pitch_err < -0.1 then initial_pitch_err = initial_pitch_err + passed * 6 end
	end	
	roll_show = get(roll_sim) - power_roll + initial_roll_err - roll_corr
	pitch_show = get(pitch_sim) - power_pitch + initial_pitch_err - pitch_corr - get(pitch_corr_hdl) * 20
	if pitch_show > 90 then pitch_show = 90
	elseif pitch_show < -90 then pitch_show = -90 end
	local roll_delta = roll_show - roll_show_2
	if roll_delta > 180 then roll_delta = roll_delta - 360
	elseif roll_delta < -180 then roll_delta = roll_delta + 360 end
	roll_show_2 = roll_show_2 + (roll_delta) * passed * 8
	pitch_show_2 = pitch_show_2 + (pitch_show - pitch_show_2) * passed * 8
	local flag = bool2int(not power or math.abs(initial_roll_err) + math.abs(initial_pitch_err) + math.abs(power_roll) + math.abs(power_pitch) > 5)
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	set(res_pitch, pitch_show_2)
	set(res_roll, roll_show_2)
	set(ahz_flag, flag)
end
end
