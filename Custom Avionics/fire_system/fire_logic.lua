defineProperty("sim_engine_on_fire1", globalPropertyi("sim/operation/failures/rel_engfir0"))  
defineProperty("sim_engine_on_fire2", globalPropertyi("sim/operation/failures/rel_engfir1"))  
defineProperty("sim_engine_on_fire3", globalPropertyi("sim/operation/failures/rel_engfir2"))  
defineProperty("sim_engine_ext1", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[0]"))  
defineProperty("sim_engine_ext2", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[1]"))  
defineProperty("sim_engine_ext3", globalPropertyi("sim/cockpit2/engine/actuators/fire_extinguisher_on[2]"))  
defineProperty("lamp_test", globalPropertyi("tu154ce/buttons/lamp_test_fire_panel")) 
defineProperty("smoke_test", globalPropertyi("tu154ce/buttons/eng/smoke_test")) 
defineProperty("ext_test", globalPropertyi("tu154ce/buttons/eng/ext_test")) 
defineProperty("fire_ext_1", globalPropertyi("tu154ce/buttons/eng/fire_ext_1")) 
defineProperty("fire_ext_2", globalPropertyi("tu154ce/buttons/eng/fire_ext_2")) 
defineProperty("fire_ext_3", globalPropertyi("tu154ce/buttons/eng/fire_ext_3")) 
defineProperty("cold_eng_1", globalPropertyi("tu154ce/buttons/eng/cold_eng_1")) 
defineProperty("cold_eng_2", globalPropertyi("tu154ce/buttons/eng/cold_eng_2")) 
defineProperty("cold_eng_3", globalPropertyi("tu154ce/buttons/eng/cold_eng_3")) 
defineProperty("cold_apu", globalPropertyi("tu154ce/buttons/eng/cold_apu")) 
defineProperty("neutral_gas", globalPropertyi("tu154ce/buttons/eng/neutral_gas")) 
defineProperty("fire_sensor_sel", globalPropertyi("tu154ce/switchers/eng/fire_sensor_sel")) 
defineProperty("fire_place_sel", globalPropertyi("tu154ce/switchers/eng/fire_place_sel")) 
defineProperty("fire_main_switch", globalPropertyi("tu154ce/switchers/eng/fire_main_switch")) 
defineProperty("fire_buzzer", globalPropertyi("tu154ce/switchers/eng/fire_buzzer")) 
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("fire_sys_cc", globalPropertyf("tu154ce/fire/fire_sys_cc")) 
defineProperty("ext_used_1", globalPropertyi("tu154ce/fire/ext_used_1")) 
defineProperty("ext_used_2", globalPropertyi("tu154ce/fire/ext_used_2")) 
defineProperty("ext_used_3", globalPropertyi("tu154ce/fire/ext_used_3")) 
defineProperty("ng_used", globalPropertyi("tu154ce/fire/ng_used")) 
defineProperty("valve_open_1", globalPropertyi("tu154ce/fire/valve_open_1")) 
defineProperty("valve_open_2", globalPropertyi("tu154ce/fire/valve_open_2")) 
defineProperty("valve_open_3", globalPropertyi("tu154ce/fire/valve_open_3")) 
defineProperty("valve_open_4", globalPropertyi("tu154ce/fire/valve_open_4")) 
defineProperty("engine_fire_state_1", globalPropertyi("tu154ce/fire/engine_fire_state_1")) 
defineProperty("engine_fire_state_2", globalPropertyi("tu154ce/fire/engine_fire_state_2")) 
defineProperty("engine_fire_state_3", globalPropertyi("tu154ce/fire/engine_fire_state_3")) 
defineProperty("engine_fire_state_4", globalPropertyi("tu154ce/fire/engine_fire_state_4")) 
defineProperty("fire_detected", globalPropertyi("tu154ce/fire/fire_detected")) 
defineProperty("fire_siren", globalPropertyi("tu154ce/fire/fire_siren")) 
defineProperty("fire_vlv_open_1", globalPropertyf("tu154ce/fuel/fire_vlv_open_1")) 
defineProperty("fire_vlv_open_2", globalPropertyf("tu154ce/fuel/fire_vlv_open_2")) 
defineProperty("fire_vlv_open_3", globalPropertyf("tu154ce/fuel/fire_vlv_open_3")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local valve_1 = get(valve_open_1)
local valve_2 = get(valve_open_2)
local valve_3 = get(valve_open_3)
local valve_4 = get(valve_open_4)
local valves_open = 0 
set(sim_engine_ext1, 0)
set(sim_engine_ext2, 0)
set(sim_engine_ext3, 0)
function update()
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	local power27L = get(bus27_volt_left) > 13
	local power27R = get(bus27_volt_right) > 13
	if power27L and get(fire_main_switch) == 1 then
		if get(cold_eng_1) == 1 then valve_1 = 1 end
		if get(cold_eng_2) == 1 then valve_2 = 1 end
		if get(cold_eng_3) == 1 then valve_3 = 1 end
		if get(cold_apu) == 1 then valve_4 = 1 end
		local fire_1 = get(sim_engine_on_fire1) == 6
		local fire_2 = get(sim_engine_on_fire2) == 6
		local fire_3 = get(sim_engine_on_fire3) == 6
		if fire_1 then valve_1 = 1 end
		if fire_2 then valve_2 = 1 end
		if fire_3 then valve_3 = 1 end
		if get(neutral_gas) == 1 then set(ng_used, 1) end
		valves_open = valve_1 + valve_2 + valve_3 + valve_4
		local ext_1_ready = get(ext_used_1) == 0
		local ext_2_ready = get(ext_used_2) == 0
		local ext_3_ready = get(ext_used_3) == 0
		local fire_1_but = get(fire_ext_1) == 1
		local fire_2_but = get(fire_ext_2) == 1
		local fire_3_but = get(fire_ext_3) == 1
		if valve_1 == 1 then
			if ext_1_ready and (get(fire_vlv_open_1) < 0.5 or fire_1_but)then 
				set(ext_used_1, 1) 
				set(sim_engine_ext1, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire1, 0) 
				end
			end
			if ext_2_ready and fire_2_but then 
				set(ext_used_2, 1) 
				set(sim_engine_ext1, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire1, 0) 
				end
			end
			if ext_3_ready and fire_3_but then 
				set(ext_used_3, 1) 
				set(sim_engine_ext1, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire1, 0) 
				end
			end
		end
		if valve_2 == 1 then
			if ext_1_ready and (get(fire_vlv_open_2) < 0.5 or fire_1_but)then 
				set(ext_used_1, 1) 
				set(sim_engine_ext2, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire2, 0) 
				end
			end
			if ext_2_ready and fire_2_but then 
				set(ext_used_2, 1) 
				set(sim_engine_ext2, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire2, 0) 
				end
			end
			if ext_3_ready and fire_3_but then 
				set(ext_used_3, 1) 
				set(sim_engine_ext2, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire2, 0) 
				end
			end
		end		
		if valve_3 == 1 then
			if ext_1_ready and (get(fire_vlv_open_3) < 0.5 or fire_1_but)then 
				set(ext_used_1, 1) 
				set(sim_engine_ext3, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire3, 0) 
				end
			end
			if ext_2_ready and fire_2_but then 
				set(ext_used_2, 1) 
				set(sim_engine_ext3, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire3, 0) 
				end
			end
			if ext_3_ready and fire_3_but then 
				set(ext_used_3, 1) 
				set(sim_engine_ext3, 1)
				if math.random() < 0.98 / valves_open then 
					set(sim_engine_on_fire3, 0) 
				end
			end
		end	
		if fire_1 or fire_2 or fire_3 or get(smoke_test) == 1 then
			set(fire_detected, 1)
			set(fire_siren, get(fire_buzzer))
		else
			set(fire_detected, 0)
			set(fire_siren, 0)
		end
		if fire_1 then set(engine_fire_state_1, 2)
		else set(engine_fire_state_1, 0) end
		if fire_2 then set(engine_fire_state_2, 2)
		else set(engine_fire_state_2, 0) end
		if fire_3 then set(engine_fire_state_3, 2)
		else set(engine_fire_state_3, 0) end
		else set(engine_fire_state_4, 0) end
		set(fire_sys_cc, 0.8)
	else
		valve_1 = 0
		valve_2 = 0
		valve_3 = 0
		valve_4 = 0
		valves_open = 0
		set(fire_detected, 0)
		set(fire_siren, 0)	
		set(engine_fire_state_1, 0)
		set(engine_fire_state_2, 0)
		set(engine_fire_state_3, 0)
		set(engine_fire_state_4, 0)
		set(fire_sys_cc, 0)
	end
	set(valve_open_1, valve_1)
	set(valve_open_2, valve_2)
	set(valve_open_3, valve_3)
	set(valve_open_4, valve_4)
end
end