defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("tank_1_pr",globalPropertyi("sim/custom/payload/tank_1"))
defineProperty("tank_4_pr",globalPropertyi("sim/custom/payload/tank_4"))
defineProperty("tank_2L_pr",globalPropertyi("sim/custom/payload/tank_2L"))
defineProperty("tank_2R_pr",globalPropertyi("sim/custom/payload/tank_2R"))
defineProperty("tank_3L_pr",globalPropertyi("sim/custom/payload/tank_3L"))
defineProperty("tank_3R_pr",globalPropertyi("sim/custom/payload/tank_3R"))
defineProperty("fuel_tanker_call", globalPropertyi("sim/custom/anim/fuel_tanker_call")) 
defineProperty("gear_blocks", globalPropertyi("sim/custom/anim/gear_blocks")) 
defineProperty("fuel_tanker", globalPropertyf("sim/custom/anim/fuel_tanker")) 
defineProperty("slider_5", globalPropertyi("sim/cockpit2/switches/custom_slider_on[4]")) 
defineProperty("payload", globalPropertyf("sim/flightmodel/weight/m_fixed"))  
defineProperty("CG_load", globalPropertyf("sim/flightmodel/misc/cgz_ref_to_default")) 
defineProperty("fuel_q_1", globalPropertyf("sim/flightmodel/weight/m_fuel[0]")) 
defineProperty("fuel_q_4", globalPropertyf("sim/flightmodel/weight/m_fuel[1]")) 
defineProperty("fuel_q_2R", globalPropertyf("sim/flightmodel/weight/m_fuel[2]")) 
defineProperty("fuel_q_2L", globalPropertyf("sim/flightmodel/weight/m_fuel[3]")) 
defineProperty("fuel_q_3R", globalPropertyf("sim/flightmodel/weight/m_fuel[4]")) 
defineProperty("fuel_q_3L", globalPropertyf("sim/flightmodel/weight/m_fuel[5]")) 
defineProperty("paylod_set", globalPropertyf("sim/custom/payload/paylod_set")) 
defineProperty("cg_set", globalPropertyf("sim/custom/payload/cg_set")) 
defineProperty("load_slow_btn",globalPropertyi("sim/custom/payload/load_slow_btn")) 
local load_started = false
local fuel_load = true
local cg_read = false
local CG_old = get(CG_load)
local CG_need = get(cg_set)
local load_timer = 0
function update()
	local passed = get(frame_time)
	if get(load_slow_btn) == 1 and not load_started and get(gear_blocks) == 1 then
		load_started = true
		cg_read = false
		load_timer = 0
	end
	if load_started then
		set(gear_blocks, 1)
		if get(tank_1_pr) + get(tank_4_pr) + get(tank_2L_pr) + get(tank_2R_pr) + get(tank_3L_pr) + get(tank_3R_pr) > get(fuel_q_1) + get(fuel_q_4) + get(fuel_q_2R) + get(fuel_q_2L) + get(fuel_q_3R) + get(fuel_q_3L) then
			fuel_load = false
		else fuel_load = true
		end
		if get(fuel_tanker) ~= 0 and not fuel_load then set(fuel_tanker_call, 1) end
		if fuel_load then set(fuel_tanker_call, 0) end
		local tank1_load = get(tank_1_pr) > get(fuel_q_1) and get(get(fuel_q_1)) < 3300
		local tank3_1_L_load = get(tank_3L_pr) > get(fuel_q_3L) and get(fuel_q_3L) < 1725 and not tank1_load
		local tank3_1_R_load = get(tank_3R_pr) > get(fuel_q_3R) and get(fuel_q_3R) < 1725 and not tank1_load
		local tank3_2_L_load = get(tank_3L_pr) > get(fuel_q_3L) and get(fuel_q_3L) < 5405 and not tank3_1_L_load and not tank1_load
		local tank3_2_R_load = get(tank_3R_pr) > get(fuel_q_3R) and get(fuel_q_3R) < 5405 and not tank3_1_R_load and not tank1_load
		local tank2_2_L_load = get(tank_2L_pr) > get(fuel_q_2L) and get(fuel_q_2L) < 3700 and not tank3_1_L_load and not tank1_load
		local tank2_2_R_load = get(tank_2R_pr) > get(fuel_q_2R) and get(fuel_q_2R) < 3700 and not tank3_1_R_load and not tank1_load
		local tank2_3_L_load = get(tank_2L_pr) > get(fuel_q_2L) and get(fuel_q_2L) < 9500 and not tank2_2_L_load and not tank1_load and not tank3_1_L_load
		local tank2_3_R_load = get(tank_2R_pr) > get(fuel_q_2R) and get(fuel_q_2R) < 9500 and not tank2_2_R_load and not tank1_load and not tank3_1_R_load
		local tank4_load = get(tank_4_pr) > get(fuel_q_4) and get(fuel_q_4) < 6598 and not tank2_3_L_load and not tank2_3_R_load and not tank1_load and not tank2_2_L_load and not tank2_2_R_load and not tank3_1_L_load and not tank3_1_R_load
		if get(fuel_tanker) == 0 then 
			if tank1_load then 
				local t1_q = get(fuel_q_1) + passed * 64 
				if t1_q > 3300 then t1_q = 3300 end
				set(fuel_q_1, t1_q)
			end
			if tank3_1_L_load then
				set(fuel_q_3L, get(fuel_q_3L) + passed * 64 / (bool2int(tank3_1_L_load) + bool2int(tank3_1_R_load)))
			end
			if tank3_1_R_load then
				set(fuel_q_3R, get(fuel_q_3R) + passed * 64 / (bool2int(tank3_1_L_load) + bool2int(tank3_1_R_load)))
			end
			if tank3_2_L_load then
				local t3_q = get(fuel_q_3L) + passed * 64 / (bool2int(tank3_2_L_load) + bool2int(tank3_2_R_load) + bool2int(tank2_2_L_load) + bool2int(tank2_2_R_load))
				if t3_q > 5405 then t3_q = 5405 end
				set(fuel_q_3L, t3_q)
			end
			if tank3_2_R_load then
				local t3_q = get(fuel_q_3R) + passed * 64 / (bool2int(tank3_2_L_load) + bool2int(tank3_2_R_load) + bool2int(tank2_2_L_load) + bool2int(tank2_2_R_load))
				if t3_q > 5405 then t3_q = 5405 end
				set(fuel_q_3R, t3_q)
			end			
			if tank2_2_L_load then
				local t2_q = get(fuel_q_2L) + passed * 64 / (bool2int(tank3_2_L_load) + bool2int(tank3_2_R_load) + bool2int(tank2_2_L_load) + bool2int(tank2_2_R_load))
				if t2_q > 3700 then t2_q = 3700 end
				set(fuel_q_2L, t2_q)
			end
			if tank2_2_R_load then
				local t2_q = get(fuel_q_2R) + passed * 64 / (bool2int(tank3_2_L_load) + bool2int(tank3_2_R_load) + bool2int(tank2_2_L_load) + bool2int(tank2_2_R_load))
				if t2_q > 3700 then t2_q = 3700 end
				set(fuel_q_2R, t2_q)
			end
			if tank2_3_L_load then
				local t2_q = get(fuel_q_2L) + passed * 64 / (bool2int(tank2_3_L_load) + bool2int(tank2_3_R_load))
				if t2_q > 9500 then t2_q = 9500 end
				set(fuel_q_2L, t2_q)
			end
			if tank2_3_R_load then
				local t2_q = get(fuel_q_2R) + passed * 64 / (bool2int(tank2_3_L_load) + bool2int(tank2_3_R_load))
				if t2_q > 9500 then t2_q = 9500 end
				set(fuel_q_2R, t2_q)
			end
			if tank4_load then 
				local t4_q = get(fuel_q_4) + passed * 64 
				if t4_q > 6598 then t4_q = 6598 end
				set(fuel_q_4, t4_q)
			end
		end
		local load_time = 600 * get(paylod_set) / 20000
		if load_time == 0 and get(fuel_tanker_call) == 0 and fuel_load then load_started = false end
		if get(fuel_tanker_call) == 0 and fuel_load and load_timer < load_time then
			set(slider_5, 1)
			load_timer = load_timer + passed
			local cargo = get(payload) + passed * 33.333333
			if cargo > get(paylod_set) then cargo = get(paylod_set) end
			set(payload, cargo)
			if not cg_read then
				cg_read = true
				CG_old = get(CG_load)
				CG_need = get(cg_set)
			end
			local CG_spd = 0
			if load_time > 0 then CG_spd = (CG_need - CG_old) / load_time end
			set(CG_load, get(CG_load) + passed * CG_spd)
			if load_timer >= load_time then
				set(CG_load, CG_need)
				set(slider_5, 0)
				load_started = false
			end
		end
	end
end