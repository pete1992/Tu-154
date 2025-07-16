defineProperty("bus36_tr_left_to_right", globalPropertyi("sim/custom/switchers/eng/bus36_tr_left_to_right")) 
defineProperty("bus36_tr_right_to_left", globalPropertyi("sim/custom/switchers/eng/bus36_tr_right_to_left")) 
defineProperty("pts250_on", globalPropertyi("sim/custom/switchers/eng/pts250_on")) 
defineProperty("pts250_mode", globalPropertyi("sim/custom/switchers/eng/pts250_mode")) 
defineProperty("agr_on", globalPropertyi("sim/custom/switchers/ovhd/agr_on")) 
defineProperty("bus36_tr1_work", globalPropertyi("sim/custom/elec/bus36_tr1_work")) 
defineProperty("bus36_tr2_work", globalPropertyi("sim/custom/elec/bus36_tr2_work")) 
defineProperty("bus36_pts1_work", globalPropertyi("sim/custom/elec/bus36_pts1_work")) 
defineProperty("bus36_pts2_work", globalPropertyi("sim/custom/elec/bus36_pts2_work")) 
defineProperty("bus36_src_L", globalPropertyi("sim/custom/elec/bus36_src_L")) 
defineProperty("bus36_src_R", globalPropertyi("sim/custom/elec/bus36_src_R")) 
defineProperty("bus115_1_volt", globalPropertyf("sim/custom/elec/bus115_1_volt")) 
defineProperty("bus115_3_volt", globalPropertyf("sim/custom/elec/bus115_3_volt")) 
defineProperty("bus115_1_amp", globalPropertyf("sim/custom/elec/bus115_1_amp"))
defineProperty("bus115_3_amp", globalPropertyf("sim/custom/elec/bus115_3_amp"))
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right")) 
defineProperty("bus27_amp_left", globalPropertyf("sim/custom/elec/bus27_amp_left")) 
defineProperty("bus27_amp_right", globalPropertyf("sim/custom/elec/bus27_amp_right")) 
defineProperty("bus36_volt_left", globalPropertyf("sim/custom/elec/bus36_volt_left")) 
defineProperty("bus36_volt_right", globalPropertyf("sim/custom/elec/bus36_volt_right")) 
defineProperty("bus36_volt_pts250_1", globalPropertyf("sim/custom/elec/bus36_volt_pts250_1")) 
defineProperty("bus36_volt_pts250_2", globalPropertyf("sim/custom/elec/bus36_volt_pts250_2")) 
defineProperty("bus36_amp_left", globalPropertyf("sim/custom/elec/bus36_amp_left")) 
defineProperty("bus36_amp_right", globalPropertyf("sim/custom/elec/bus36_amp_right")) 
defineProperty("bus36_amp_pts250_1", globalPropertyf("sim/custom/elec/bus36_amp_pts250_1")) 
defineProperty("bus36_amp_pts250_2", globalPropertyf("sim/custom/elec/bus36_amp_pts250_2")) 
defineProperty("tr1_fail", globalPropertyi("sim/custom/failures/tr1_fail")) 
defineProperty("tr2_fail", globalPropertyi("sim/custom/failures/tr2_fail")) 
defineProperty("pts250_1_fail", globalPropertyi("sim/custom/failures/pts250_1_fail")) 
defineProperty("pts250_2_fail", globalPropertyi("sim/custom/failures/pts250_2_fail")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
function update()
	if get(frame_time) > 0 and get(ismaster) ~= 1 then
		local tr1_sw = get(bus36_tr_left_to_right)
		local tr2_sw = get(bus36_tr_right_to_left)
		local tr1_volt = (get(bus115_1_volt) / 3.27) * (1 - get(tr1_fail)) 
		local tr2_volt = (get(bus115_3_volt) / 3.27) * (1 - get(tr2_fail)) 
		local bus_source_L = 0 
		local bus_source_R = 0 
		local bus_L_volt = 0
		if tr1_sw == 0 and tr1_volt > 30 then 
			bus_L_volt = tr1_volt
			bus_source_L = 0
		else
			bus_source_L = 1
			bus_L_volt = tr2_volt
		end
		local bus_R_volt = 0
		if tr2_sw == 0 and tr2_volt > 30 then
			bus_source_R = 0
			bus_R_volt = tr2_volt
		else
			bus_source_R = 1
			bus_R_volt = tr1_volt
		end
		set(bus36_volt_left, bus_L_volt)
		set(bus36_volt_right, bus_R_volt)
		set(bus36_src_L, bus_source_L)
		set(bus36_src_R, bus_source_R)
		if tr1_volt > 0 then 
			set(bus36_tr1_work, 1)
		else
			set(bus36_tr1_work, 0)
		end
		if tr2_volt > 0 then 
			set(bus36_tr2_work, 1)
		else
			set(bus36_tr2_work, 0)
		end
		local bus27_L = get(bus27_volt_left)
		local bus27_R = get(bus27_volt_right)
		local pts_1_volt = 0
		if bus27_R > 13 and (get(pts250_on) == 1 or get(agr_on) == 1) and get(pts250_1_fail) == 0 then 
			pts_1_volt = 36
			set(bus36_pts1_work, 1)
		else
			pts_1_volt = 0
			set(bus36_pts1_work, 0)
		end
		local pts_2_volt = 0
		if (bus_L_volt < 30 or get(pts250_mode) == 1) and bus27_L > 13 and get(pts250_2_fail) == 0 then
			pts_2_volt = 36
			set(bus36_pts2_work, 1)
		else
			pts_2_volt = 0
			set(bus36_pts2_work, 0)
		end
		local bus_1_volt = 0
		local pts_1_fail = false 
		if pts_1_volt > 0 then
			bus_1_volt = 36
			set(bus27_amp_right, get(bus27_amp_right) + get(bus36_amp_pts250_1) * 1.4) 
		elseif pts_1_fail then
			bus_1_volt = get(bus36_volt_right)
			set(bus36_amp_right, get(bus36_amp_right) + get(bus36_amp_pts250_1) * 1.05) 
		end
		local bus_2_volt = 0
		local pts_2_fail = false 
		if bus_L_volt > 30 then
			bus_2_volt = bus_L_volt
			set(bus36_amp_left, get(bus36_amp_left) + get(bus36_amp_pts250_2) * 1.05)
		else
			bus_2_volt = pts_2_volt
			set(bus27_amp_left, get(bus27_amp_left) + get(bus36_amp_pts250_2) * 1.4)
		end
		set(bus36_volt_pts250_1, bus_1_volt)
		set(bus36_volt_pts250_2, bus_2_volt)
		set(bus115_1_amp, get(bus115_1_amp) + (get(bus36_amp_left) / 3.25) * (1 - bus_source_L) + (get(bus36_amp_right) / 3.25) * bus_source_R)
		set(bus115_3_amp, get(bus115_3_amp) + (get(bus36_amp_left) / 3.25) * (bus_source_L) + (get(bus36_amp_right) / 3.25) * (1 - bus_source_R))
	end
end