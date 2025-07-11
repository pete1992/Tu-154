-- this is logic for all electrical system's failures

-- define properties for fails
defineProperty("bat_fail_1", globalPropertyi("tu154ce/failures/bat_1_fail")) 
defineProperty("bat_fail_2", globalPropertyi("tu154ce/failures/bat_2_fail")) 
defineProperty("bat_fail_3", globalPropertyi("tu154ce/failures/bat_3_fail"))
defineProperty("bat_fail_4", globalPropertyi("tu154ce/failures/bat_4_fail"))
defineProperty("bat_1_kz", globalPropertyi("tu154ce/failures/bat_1_kz")) 
defineProperty("bat_2_kz", globalPropertyi("tu154ce/failures/bat_2_kz")) 
defineProperty("bat_3_kz", globalPropertyi("tu154ce/failures/bat_3_kz")) 
defineProperty("bat_4_kz", globalPropertyi("tu154ce/failures/bat_4_kz")) 
defineProperty("vu1_fail", globalPropertyi("tu154ce/failures/vu1_fail")) 
defineProperty("vu2_fail", globalPropertyi("tu154ce/failures/vu2_fail"))
defineProperty("vu3_fail", globalPropertyi("tu154ce/failures/vu3_fail"))
defineProperty("tr1_fail", globalPropertyi("tu154ce/failures/tr1_fail"))
defineProperty("tr2_fail", globalPropertyi("tu154ce/failures/tr2_fail"))
defineProperty("pts250_1_fail", globalPropertyi("tu154ce/failures/pts250_1_fail"))
defineProperty("pts250_2_fail", globalPropertyi("tu154ce/failures/pts250_2_fail")) 
defineProperty("inv115_fail", globalPropertyf("tu154ce/failures/inv115_fail"))
defineProperty("sim_gen1_fail", globalPropertyi("sim/operation/failures/rel_genera0"))
defineProperty("sim_gen2_fail", globalPropertyi("sim/operation/failures/rel_genera1"))
defineProperty("sim_gen3_fail", globalPropertyi("sim/operation/failures/rel_genera2"))




-- define sources
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) -- flight time
defineProperty("failures_enabled", globalPropertyi("tu154ce/failures/failures_enabled"))

defineProperty("vu1_amp", globalPropertyf("tu154ce/elec/vu1_amp")) 
defineProperty("vu2_amp", globalPropertyf("tu154ce/elec/vu2_amp")) 
defineProperty("vu3_amp", globalPropertyf("tu154ce/elec/vu_res_amp"))

-- Smart Copilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- Master. 0 = plugin not found, 1 = slave 2 = master
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) -- Have control. 0 = plugin not found, 1 = no control 2 = has control



-- timers for VU failures. maximum - 180 sec.
local vu_timer_1 = 0
local vu_timer_2 = 0
local vu_timer_3 = 0

local fail_counter = 0
local check_time = math.random(15, 30)

function update()
	local passed = get(frame_time)
	
local MASTER = get(ismaster) ~= 1	
	

if MASTER then	

	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	
	-- check failures
	if FAIL > 0 then
		
		fail_counter = fail_counter + passed
		
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			
			-- random failures
			if get(bat_fail_1) ~= 1 then set(bat_fail_1, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(bat_fail_2) ~= 1 then set(bat_fail_2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(bat_fail_3) ~= 1 then set(bat_fail_3, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(bat_fail_4) ~= 1 then set(bat_fail_4, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(bat_1_kz) ~= 1 then set(bat_1_kz, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(bat_2_kz) ~= 1 then set(bat_2_kz, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(bat_3_kz) ~= 1 then set(bat_3_kz, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(bat_4_kz) ~= 1 then set(bat_4_kz, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(vu1_fail) ~= 1 then set(vu1_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(vu2_fail) ~= 1 then set(vu2_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(vu3_fail) ~= 1 then set(vu3_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(tr1_fail) ~= 1 then set(tr1_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(tr2_fail) ~= 1 then set(tr2_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(pts250_1_fail) ~= 1 then set(pts250_1_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(pts250_2_fail) ~= 1 then set(pts250_2_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(inv115_fail) ~= 1 then set(inv115_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			if get(sim_gen1_fail) ~= 1 then set(sim_gen1_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(sim_gen2_fail) ~= 1 then set(sim_gen2_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(sim_gen3_fail) ~= 1 then set(sim_gen3_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			
			
		
		end
		
		-- dependent failures
		
		
		-- set failures for VUs
		-- 300 A will burn out a VU in 3 minutes (180 s); 
		-- current above 400 A will do so in 5 seconds


		local vu_amp_1 = get(vu1_amp)
		if vu_amp_1 > 300 then vu_timer_1 = vu_timer_1 + passed * (vu_amp_1 - 297.5) * 0.4
		elseif vu_timer_1 > 0 then vu_timer_1 = vu_timer_1 - passed * 3
		end
		if vu_timer_1 > 180 then set(vu1_fail, 1) end
		
		local vu_amp_2 = get(vu2_amp)
		if vu_amp_2 > 300 then vu_timer_2 = vu_timer_2 + passed * (vu_amp_2 - 297.5) * 0.4
		elseif vu_timer_2 > 0 then vu_timer_2 = vu_timer_2 - passed * 3
		end
		if vu_timer_2 > 180 then set(vu2_fail, 1) end
		
		local vu_amp_3 = get(vu3_amp)
		if vu_amp_3 > 300 then vu_timer_3 = vu_timer_3 + passed * (vu_amp_3 - 297.5) * 0.4
		elseif vu_timer_3 > 0 then vu_timer_3 = vu_timer_3 - passed * 3
		end
		if vu_timer_3 > 180 then set(vu3_fail, 1) end
		
		
	
	
		else
			-- no failures enabled
			fail_counter = 0
			set(bat_fail_1, 0)
			set(bat_fail_2, 0)
			set(bat_fail_3, 0)
			set(bat_fail_4, 0)
			set(bat_1_kz, 0)
			set(bat_2_kz, 0)
			set(bat_3_kz, 0)
			set(bat_4_kz, 0)
			set(vu1_fail, 0)
			set(vu2_fail, 0)
			set(vu3_fail, 0)
			set(tr1_fail, 0)
			set(tr2_fail, 0)
			set(pts250_1_fail, 0)
			set(pts250_2_fail, 0)
			set(inv115_fail, 0)
			set(sim_gen1_fail, 0)
			set(sim_gen2_fail, 0)
			set(sim_gen3_fail, 0)
	
		end
	end
end
