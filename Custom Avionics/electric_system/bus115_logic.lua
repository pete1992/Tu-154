defineProperty("gen1_volt_bus", globalPropertyf("tu154ce/elec/gen1_volt"))  
defineProperty("gen2_volt_bus", globalPropertyf("tu154ce/elec/gen2_volt"))
defineProperty("gen3_volt_bus", globalPropertyf("tu154ce/elec/gen3_volt"))
defineProperty("gen4_volt_bus", globalPropertyf("tu154ce/elec/gen4_volt"))
defineProperty("gpu_volt_bus", globalPropertyf("tu154ce/elec/gpu_volt"))
defineProperty("gen1_work_bus", globalPropertyi("tu154ce/elec/gen1_work"))  
defineProperty("gen2_work_bus", globalPropertyi("tu154ce/elec/gen2_work"))
defineProperty("gen3_work_bus", globalPropertyi("tu154ce/elec/gen3_work"))
defineProperty("gen4_work_bus", globalPropertyi("tu154ce/elec/gen4_work"))
defineProperty("gpu_work_bus", globalPropertyi("tu154ce/elec/gpu_work"))
defineProperty("bus115_1_volt", globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("bus115_2_volt", globalPropertyf("tu154ce/elec/bus115_2_volt"))
defineProperty("bus115_3_volt", globalPropertyf("tu154ce/elec/bus115_3_volt"))
defineProperty("bus115_em_1_volt", globalPropertyf("tu154ce/elec/bus115_em_1_volt"))
defineProperty("bus115_em_2_volt", globalPropertyf("tu154ce/elec/bus115_em_2_volt"))
defineProperty("bus115_1_amp", globalPropertyf("tu154ce/elec/bus115_1_amp"))
defineProperty("bus115_2_amp", globalPropertyf("tu154ce/elec/bus115_2_amp"))
defineProperty("bus115_3_amp", globalPropertyf("tu154ce/elec/bus115_3_amp"))
defineProperty("bus115_em_1_amp", globalPropertyf("tu154ce/elec/bus115_em_1_amp"))
defineProperty("bus115_em_2_amp", globalPropertyf("tu154ce/elec/bus115_em_2_amp"))
defineProperty("gen1_amp", globalPropertyf("tu154ce/elec/gen1_amp"))
defineProperty("gen2_amp", globalPropertyf("tu154ce/elec/gen2_amp"))
defineProperty("gen3_amp", globalPropertyf("tu154ce/elec/gen3_amp"))
defineProperty("gen4_amp", globalPropertyf("tu154ce/elec/gen4_amp"))
defineProperty("gpu_amp", globalPropertyf("tu154ce/elec/gpu_amp"))
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
function update()
	if get(frame_time) > 0 then
		local bus1_volt = 0
		local bus2_volt = 0
		local bus3_volt = 0
		local bus_em_1_volt = 0
		local bus_em_2_volt = 0
		local bus1_amp = get(bus115_1_amp)
		local bus2_amp = get(bus115_2_amp)
		local bus3_amp = get(bus115_3_amp)
		local bus_em1_amp = get(bus115_em_1_amp)
		local bus_em2_amp = get(bus115_em_2_amp)
		local gen1_work = get(gen1_work_bus) == 1
		local gen2_work = get(gen2_work_bus) == 1
		local gen3_work = get(gen3_work_bus) == 1
		local gen4_work = get(gen4_work_bus) == 1
		local gpu_work = get(gpu_work_bus) == 1
		local gen1_volt = get(gen1_volt_bus)
		local gen2_volt = get(gen2_volt_bus)
		local gen3_volt = get(gen3_volt_bus)
		local gen4_volt = get(gen4_volt_bus)
		local gpu_volt = get(gpu_volt_bus)
		if gen1_work and gen2_work and gen3_work then 
			bus1_volt = gen1_volt
			bus2_volt = gen2_volt
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp)
			set(gen2_amp, bus2_amp)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)
		elseif gen2_work and gen3_work then 
			bus1_volt = gen2_volt
			bus2_volt = gen2_volt
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, bus2_amp + bus1_amp)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen1_work and gen3_work and gpu_work then 
			bus1_volt = gen1_volt
			bus2_volt = gpu_volt
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp)
			set(gen2_amp, 0)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, bus2_amp)
		elseif gen1_work and gen3_work then 
			bus1_volt = gen1_volt
			bus2_volt = gen1_volt
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp + bus2_amp)
			set(gen2_amp, 0)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen1_work and gen2_work  and gpu_work  then 
			bus1_volt = gen1_volt
			bus2_volt = gen2_volt
			bus3_volt = gpu_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp)
			set(gen2_amp, bus2_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus3_amp)	
		elseif gen1_work and gen2_work then 
			bus1_volt = gen1_volt
			bus2_volt = gen2_volt
			bus3_volt = gen2_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp )
			set(gen2_amp, bus2_amp + bus3_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen1_work and gen4_work then 
			bus1_volt = gen1_volt
			bus2_volt = gen4_volt
			bus3_volt = gen1_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp + bus3_amp)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, bus2_amp)
			set(gpu_amp, 0)	
		elseif gen2_work and gen4_work then 
			bus1_volt = gen2_volt
			bus2_volt = gen4_volt
			bus3_volt = gen2_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, bus1_amp + bus3_amp)
			set(gen3_amp, 0)
			set(gen4_amp, bus2_amp)
			set(gpu_amp, 0)	
		elseif gen3_work and gen4_work then 
			bus1_volt = gen3_volt
			bus2_volt = gen4_volt
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, bus1_amp + bus3_amp)
			set(gen4_amp, bus2_amp)
			set(gpu_amp, 0)
		elseif gen1_work and gpu_work then 
			bus1_volt = gen1_volt
			bus2_volt = gpu_volt
			bus3_volt = gpu_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus2_amp + bus3_amp)	
		elseif gen2_work and gpu_work then 
			bus1_volt = gpu_volt
			bus2_volt = gen2_volt
			bus3_volt = gpu_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, bus2_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus1_amp + bus3_amp)	
		elseif gen3_work and gpu_work then 
			bus1_volt = gpu_volt
			bus2_volt = gpu_volt
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, bus1_amp + bus2_amp)	
		elseif gen1_work then 
			bus1_volt = gen1_volt
			bus2_volt = 0
			bus3_volt = gen1_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, bus1_amp + bus3_amp)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen2_work then 
			bus1_volt = gen2_volt
			bus2_volt = 0
			bus3_volt = gen2_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, bus1_amp + bus3_amp)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen3_work then 
			bus1_volt = gen3_volt
			bus2_volt = 0
			bus3_volt = gen3_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, bus1_amp + bus3_amp)
			set(gen4_amp, 0)
			set(gpu_amp, 0)	
		elseif gen4_work and gpu_work then 
			bus1_volt = gen4_volt
			bus2_volt = gen4_volt
			bus3_volt = gpu_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, bus1_amp + bus2_amp)
			set(gpu_amp, bus3_amp)		
		elseif gpu_work then 
			bus1_volt = gpu_volt
			bus2_volt = gpu_volt
			bus3_volt = gpu_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, bus1_amp + bus2_amp + bus3_amp)		
		elseif gen4_work then 
			bus1_volt = gen4_volt
			bus2_volt = gen4_volt
			bus3_volt = gen4_volt
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, bus1_amp + bus2_amp + bus3_amp)
			set(gpu_amp, 0)
		else
			bus1_volt = 0
			bus2_volt = 0
			bus3_volt = 0
			bus_em_1_volt = bus1_volt
			bus_em_2_volt = bus3_volt
			set(gen1_amp, 0)
			set(gen2_amp, 0)
			set(gen3_amp, 0)
			set(gen4_amp, 0)
			set(gpu_amp, 0)		
		end
		set(bus115_1_volt, bus1_volt)
		set(bus115_2_volt, bus2_volt)
		set(bus115_3_volt, bus3_volt)
		set(bus115_em_1_volt, bus_em_1_volt)
		set(bus115_em_2_volt, bus_em_2_volt)
	end
end