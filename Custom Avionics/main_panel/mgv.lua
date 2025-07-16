defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("pitch_sim", globalPropertyf("sim/flightmodel/position/theta"))
defineProperty("roll_sim", globalPropertyf("sim/flightmodel/position/phi"))
defineProperty("N1", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[1]"))   
defineProperty("N2", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[0]"))
defineProperty("N3", globalPropertyf("sim/flightmodel/engine/ENGN_N2_[2]"))
defineProperty("mgv_contr", globalPropertyi("sim/custom/switchers/ovhd/mgv_contr")) 
defineProperty("arrest_btn", globalPropertyi("sim/custom/buttons/console/absu_arrest")) 
defineProperty("bus36_volt", globalPropertyf("sim/custom/elec/bus36_volt_left"))
defineProperty("mgv_ctr_power_cc", globalPropertyf("sim/custom/bkk/mgv_ctr_power_cc")) 
defineProperty("bus36_volt_left", globalPropertyf("sim/custom/elec/bus36_volt_left")) 
defineProperty("bus36_volt_right", globalPropertyf("sim/custom/elec/bus36_volt_right")) 
defineProperty("bus36_volt_pts250_1", globalPropertyf("sim/custom/elec/bus36_volt_pts250_1")) 
defineProperty("bus36_volt_pts250_2", globalPropertyf("sim/custom/elec/bus36_volt_pts250_2")) 
defineProperty("bus115_1_volt", globalPropertyf("sim/custom/elec/bus115_1_volt"))
defineProperty("bus115_2_volt", globalPropertyf("sim/custom/elec/bus115_2_volt"))
defineProperty("bus115_3_volt", globalPropertyf("sim/custom/elec/bus115_3_volt"))
defineProperty("res_pitch", globalPropertyf("sim/custom/gyro/mgv_contr_pitch")) 
defineProperty("res_roll", globalPropertyf("sim/custom/gyro/mgv_contr_roll")) 
defineProperty("ahz_flag", globalPropertyi("sim/custom/gyro/mgv_contr_flag")) 
defineProperty("mgv_fail", globalPropertyi("sim/custom/failures/mgv_fail")) 
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
function update()
	local passed = get(frame_time)
	local power = get(bus36_volt) > 30 and get(mgv_contr) == 1 and get(mgv_fail) == 0
	time_counter = time_counter + passed	
	if time_counter > 0.3 and time_counter < 0.4 and notLoaded and get(N1) < 10 and get(N2) < 10 and get(N3) < 10 then
		initial_roll_err = math.random(-20, 20)
		roll_off = math.random(-1, 1)
		initial_pitch_err = math.random(-20, 20)
		pitch_off = math.random(-1, 1)
		notLoaded = false
	elseif time_counter > 0.3 and time_counter < 0.4 and notLoaded then 
		roll_off = math.random(-1, 1)
		pitch_off = math.random(-1, 1)	
		initial_roll_err = 0
		initial_pitch_err = 0
		pitch_corr = 0
		roll_corr = 0
		power_roll = 0
		power_pitch = 0
		notLoaded = false	
	end
	if not power then
		power_roll = get(roll_sim)
		power_pitch = get(pitch_sim)
	end 
	if not power then
		if math.abs(initial_roll_err) < 20 then initial_roll_err = initial_roll_err + passed * roll_off * 0.1 end
		if math.abs(initial_pitch_err) < 20 then initial_pitch_err = initial_pitch_err + passed * pitch_off * 0.1 end
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
		if roll_corr > 0.01 then roll_corr = roll_corr - 0.1 * passed
		elseif roll_corr < -0.01 then roll_corr = roll_corr + 0.1 * passed 
		else roll_corr = 0 end
		if pitch_corr > 0.01 then pitch_corr = pitch_corr - 0.1 * passed
		elseif pitch_corr < -0.01 then pitch_corr = pitch_corr + 0.1 * passed 
		else pitch_corr = 0 end
	end
	if get(arrest_btn) > 0 and power then
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
	pitch_show = get(pitch_sim) - power_pitch + initial_pitch_err - pitch_corr
	if pitch_show > 90 then pitch_show = 90
	elseif pitch_show < -90 then pitch_show = -90 end
	local flag = bool2int(not power or get(arrest_btn) > 0 or math.abs(initial_roll_err) + math.abs(initial_pitch_err) + math.abs(power_roll) + math.abs(power_pitch) > 5 )
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	set(res_roll, roll_show)
	set(res_pitch, pitch_show)
	set(ahz_flag, flag)
	set(mgv_ctr_power_cc, bool2int(power))
end
if math.abs (a - b) > 7 then flag_ab = true else flag_ab = false end
if math.abs (a - c) > 7 then flag_ac = true else flag_ac = false end
if math.abs (b - c) > 7 then flag_bc = true else flag_bc = false end
fail_a = flag_ab and flag_ac
fail_b = flag_ab and flag_bc
fail_c = flag_ac and flag_bc
end
