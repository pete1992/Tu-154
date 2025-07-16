defineProperty("gen1_volt_bus", globalPropertyf("sim/custom/elec/gen1_volt"))  
defineProperty("gen2_volt_bus", globalPropertyf("sim/custom/elec/gen2_volt"))
defineProperty("gen3_volt_bus", globalPropertyf("sim/custom/elec/gen3_volt"))
defineProperty("gen4_volt_bus", globalPropertyf("sim/custom/elec/gen4_volt"))
defineProperty("gpu_volt_bus", globalPropertyf("sim/custom/elec/gpu_volt"))
defineProperty("gen1_amp_bus", globalPropertyf("sim/custom/elec/gen1_amp")) 
defineProperty("gen2_amp_bus", globalPropertyf("sim/custom/elec/gen2_amp")) 
defineProperty("gen3_amp_bus", globalPropertyf("sim/custom/elec/gen3_amp"))
defineProperty("gen4_amp_bus", globalPropertyf("sim/custom/elec/gen4_amp"))
defineProperty("gpu_amp", globalPropertyf("sim/custom/elec/gpu_amp"))
defineProperty("gen1_overload", globalPropertyf("sim/custom/elec/gen1_overload")) 
defineProperty("gen2_overload", globalPropertyf("sim/custom/elec/gen2_overload"))
defineProperty("gen3_overload", globalPropertyf("sim/custom/elec/gen3_overload"))
defineProperty("gen4_overload", globalPropertyf("sim/custom/elec/gen4_overload"))
defineProperty("gpu_overload", globalPropertyi("sim/custom/elec/gpu_overload"))
defineProperty("gen_1_on", globalPropertyi("sim/custom/switchers/eng/gen_1_on")) 
defineProperty("gen_2_on", globalPropertyi("sim/custom/switchers/eng/gen_2_on")) 
defineProperty("gen_3_on", globalPropertyi("sim/custom/switchers/eng/gen_3_on")) 
defineProperty("apu_gen_on", globalPropertyi("sim/custom/switchers/eng/apu_gen_on")) 
defineProperty("gpu_on_sw", globalPropertyi("sim/custom/switchers/eng/gpu_on")) 
defineProperty("gen1_work", globalPropertyf("sim/custom/elec/gen1_work"))  
defineProperty("gen2_work", globalPropertyf("sim/custom/elec/gen2_work"))
defineProperty("gen3_work", globalPropertyf("sim/custom/elec/gen3_work"))
defineProperty("gen4_work", globalPropertyf("sim/custom/elec/gen4_work"))
defineProperty("gpu_work_bus", globalPropertyi("sim/custom/elec/gpu_work"))
defineProperty("DC_27_volt1", globalPropertyf("sim/custom/elec/bus27_volt_left")) 
defineProperty("DC_27_volt2", globalPropertyf("sim/custom/elec/bus27_volt_right")) 
defineProperty("eng1_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]")) 
defineProperty("eng2_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]")) 
defineProperty("eng3_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[2]")) 
defineProperty("eng4_N1", globalPropertyf("sim/custom/eng/apu_n1")) 
defineProperty("sim_gen1_on", globalPropertyi("sim/cockpit/electrical/generator_on[0]"))
defineProperty("sim_gen2_on", globalPropertyi("sim/cockpit/electrical/generator_on[1]"))
defineProperty("sim_gen3_on", globalPropertyi("sim/cockpit/electrical/generator_on[2]"))
defineProperty("sim_gen4_on", globalPropertyi("sim/cockpit2/electrical/APU_generator_on"))
defineProperty("sim_gen1_fail", globalPropertyi("sim/operation/failures/rel_genera0"))
defineProperty("sim_gen2_fail", globalPropertyi("sim/operation/failures/rel_genera1"))
defineProperty("sim_gen3_fail", globalPropertyi("sim/operation/failures/rel_genera2"))
defineProperty("apu_gen_fail", globalPropertyi("sim/custom/failures/apu_gen_fail"))
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local apu_gen_counter = 0
local gen_1_counter = 1
local gen_2_counter = 1
local gen_3_counter = 1
local gpu_counter = 0
local gen_on_1_last = get(gen_1_on)
local gen_on_2_last = get(gen_2_on)
local gen_on_3_last = get(gen_3_on)
local ovrld_count_1 = 0
local ovrld_count_2 = 0
local ovrld_count_3 = 0
local ovrld_count_4 = 0
function update() 
	local passed = get(frame_time)
local MASTER = get(ismaster) ~= 1	
	if passed > 0 and MASTER then
		local eng_rpm1 = get(eng1_N1)
		local eng_rpm2 = get(eng2_N1)
		local eng_rpm3 = get(eng3_N1)
		local eng_rpm4 = get(eng4_N1)
		local eng1_work = 0
		local eng2_work = 0
		local eng3_work = 0
		local eng4_work = 0
		local gen1_amp = get(gen1_amp_bus)
		local gen2_amp = get(gen2_amp_bus)
		local gen3_amp = get(gen3_amp_bus)
		local gen4_amp = get(gen4_amp_bus)
		local DC = 0
		if get(DC_27_volt1) > 13 or get(DC_27_volt2) > 13 then
			DC = 1 
		end
		local gen_on1 = get(gen_1_on)
		local gen_on2 = get(gen_2_on)
		local gen_on3 = get(gen_3_on)
		local gen_on4 = 0
		if gen_on1 ~= gen_on_1_last then gen_on1 = 0 end 
		if gen_on2 ~= gen_on_2_last then gen_on2 = 0 end 
		if gen_on3 ~= gen_on_3_last then gen_on3 = 0 end 
		gen_on_1_last = get(gen_1_on)
		gen_on_2_last = get(gen_2_on)
		gen_on_3_last = get(gen_3_on)
		if eng_rpm1 > 25 then eng1_work = 1 else eng1_work = 0 end
		if eng_rpm2 > 25 then eng2_work = 1 else eng2_work = 0 end
		if eng_rpm3 > 25 then eng3_work = 1 else eng3_work = 0 end
		if eng_rpm4 > 92 then eng4_work = 1 else eng4_work = 0 end
		local gen1_fail = get(sim_gen1_fail) == 6 or get(gen1_overload) == 1
		local gen2_fail = get(sim_gen2_fail) == 6 or get(gen2_overload) == 1
		local gen3_fail = get(sim_gen3_fail) == 6 or get(gen3_overload) == 1
		local gen4_fail = get(gen4_overload) == 1 or get(apu_gen_fail) == 1
		local gen_work_1 = 0
		if math.abs(gen_on1) * DC * eng1_work == 1 then gen_1_counter = gen_1_counter + passed * 0.5
		else gen_1_counter = 0 end
		if gen_1_counter > 1 then 
			gen_1_counter = 1
			gen_work_1 = 1
		end
		local gen1_volt = (119 - gen1_amp / 100) * math.abs(gen_on1) * gen_work_1   
		if gen1_fail then gen1_volt = 0 end 
		set(gen1_volt_bus, gen1_volt) 
		if gen1_volt > 110 and gen_on1 == 1 then set(gen1_work, 1) else set(gen1_work, 0) end
		local gen_work_2 = 0
		if math.abs(gen_on2) * DC * eng2_work == 1 then gen_2_counter = gen_2_counter + passed * 0.5
		else gen_2_counter = 0 end
		if gen_2_counter > 1 then 
			gen_2_counter = 1
			gen_work_2 = 1
		end
		local gen2_volt = (119 - gen2_amp / 100) * math.abs(gen_on2) * gen_work_2   
		if gen2_fail then gen2_volt = 0 end 
		set(gen2_volt_bus, gen2_volt) 
		if gen2_volt > 110 and gen_on2 == 1 then set(gen2_work, 1) else set(gen2_work, 0) end
		local gen_work_3 = 0
		if math.abs(gen_on3) * DC * eng3_work == 1 then gen_3_counter = gen_3_counter + passed * 0.5
		else gen_3_counter = 0 end
		if gen_3_counter > 1 then 
			gen_3_counter = 1
			gen_work_3 = 1
		end
		local gen3_volt = (119 - gen3_amp / 100) * math.abs(gen_on3) * gen_work_3   
		if gen3_fail then gen3_volt = 0 end 
		set(gen3_volt_bus, gen3_volt) 
		if gen3_volt > 110 and gen_on3 == 1 then set(gen3_work, 1) else set(gen3_work, 0) end
		if get(apu_gen_on) * DC * eng4_work == 1 then apu_gen_counter = apu_gen_counter + passed * 0.5
		else apu_gen_counter = 0 end
		if apu_gen_counter > 1 then 
			apu_gen_counter = 1
			gen_on4 = 1
		end
		local gen4_volt = (119 - gen4_amp / 100) * gen_on4  
		if gen4_fail then gen4_volt = 0 end 
		set(gen4_volt_bus, gen4_volt) 
		if gen4_volt > 110 and gen_on4 == 1 then set(gen4_work, 1) else set(gen4_work, 0) end
		if gen1_amp > 145 then ovrld_count_1 = ovrld_count_1 + passed
		else ovrld_count_1 = 0 end
		if ovrld_count_1 > 5 then set(gen1_overload, 1)
		elseif gen_on1 == 0 then set(gen1_overload, 0) end
		if gen2_amp > 145 then ovrld_count_2 = ovrld_count_2 + passed
		else ovrld_count_2 = 0 end
		if ovrld_count_2 > 5 then set(gen2_overload, 1)
		elseif gen_on2 == 0 then set(gen2_overload, 0) end
		if gen3_amp > 145 then ovrld_count_3 = ovrld_count_3 + passed
		else ovrld_count_3 = 0 end
		if ovrld_count_3 > 5 then set(gen3_overload, 1)
		elseif gen_on3 == 0 then set(gen3_overload, 0) end
		if gen4_amp > 145 then ovrld_count_4 = ovrld_count_4 + passed
		else ovrld_count_4 = 0 end
		if ovrld_count_4 > 5 then set(gen4_overload, 1)
		elseif gen_on4 == 0 then set(gen4_overload, 0) end
		if gen1_volt * gen_on1 > 0 then 
			set(sim_gen1_on, 1)
		else 
			set(sim_gen1_on, 0)
		end
		if gen2_volt * gen_on2 > 0 then 
			set(sim_gen2_on, 1)
		else 
			set(sim_gen2_on, 0)
		end
		if gen3_volt * gen_on3 > 0 then 
			set(sim_gen3_on, 1)
		else 
			set(sim_gen3_on, 0)
		end
		if gen4_volt * gen_on4 > 0 then 
			set(sim_gen4_on, 1)
		else 
			set(sim_gen4_on, 0)
		end
	end
end
