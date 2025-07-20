defineProperty("absu_contr_pitch", globalPropertyf("tu154ce/absu/contr_pitch")) 
defineProperty("absu_contr_roll", globalPropertyf("tu154ce/absu/contr_roll")) 
defineProperty("absu_contr_yaw", globalPropertyf("tu154ce/absu/contr_yaw")) 
defineProperty("int_pitch_trim", globalPropertyf("tu154ce/trimmers/int_pitch_trim")) 
defineProperty("gear1_deflect", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  
defineProperty("rudder_pos_ind", globalPropertyf("tu154ce/gauges/misc/rudder_pos_ind")) 
defineProperty("aileron_pos_ind", globalPropertyf("tu154ce/gauges/misc/aileron_pos_ind")) 
defineProperty("elevator_pos_ind", globalPropertyf("tu154ce/gauges/misc/elevator_pos_ind")) 
function update()
	set(rudder_pos_ind, get(absu_contr_yaw) / 0.4)
	set(aileron_pos_ind, get(absu_contr_roll) / 0.4)
	set(elevator_pos_ind, get(absu_contr_pitch) / 0.4)
	if get(gear1_deflect) > 0.01 and get(int_pitch_trim) < -0.5 then set(elevator_pos_ind, -get(absu_contr_pitch) / 0.4) end
end