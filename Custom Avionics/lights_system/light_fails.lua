defineProperty("lan_lamp_fail_FL", globalPropertyi("sim/custom/failures/lan_lamp_fail_FL")) 
defineProperty("lan_lamp_fail_FR", globalPropertyi("sim/custom/failures/lan_lamp_fail_FR")) 
defineProperty("lan_lamp_fail_WL", globalPropertyi("sim/custom/failures/lan_lamp_fail_WL")) 
defineProperty("lan_lamp_fail_WR", globalPropertyi("sim/custom/failures/lan_lamp_fail_WR")) 
defineProperty("rel_lites_nav", globalPropertyi("sim/operation/failures/rel_lites_nav")) 
defineProperty("rel_lites_beac", globalPropertyi("sim/operation/failures/rel_lites_beac")) 
defineProperty("sim_lan_FL", globalPropertyf("sim/cockpit2/switches/landing_lights_switch[7]")) 
defineProperty("sim_lan_FR", globalPropertyf("sim/cockpit2/switches/landing_lights_switch[6]")) 
defineProperty("sim_lan_WL", globalPropertyf("sim/cockpit2/switches/landing_lights_switch[5]")) 
defineProperty("sim_lan_WR", globalPropertyf("sim/cockpit2/switches/landing_lights_switch[4]")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("failures_enabled", globalPropertyi("sim/custom/failures/failures_enabled"))
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local timeToFail_FL = (5 + math.random(5)) * 60 
local timeToFail_FR = (5 + math.random(5)) * 60
local timeToFail_WL = (5 + math.random(5)) * 60
local timeToFail_WR = (5 + math.random(5)) * 60
local timer_FL = 0 
local timer_FR = 0 
local timer_WL = 0 
local timer_WR = 0 
local time_table = {{ -5000, -2},    
				  { 0, -2 },   
				  { 0.6, -0.5 },   
            	  { 1.5,  1 },   
          		  { 1000, 1 }}   
local fail_counter = 0
local check_time = math.random(15, 30)
function update()
	local passed = get(frame_time)
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		fail_counter = fail_counter + passed
		timer_FL = timer_FL + interpolate(time_table, get(sim_lan_FL)) * passed
		timer_FR = timer_FR + interpolate(time_table, get(sim_lan_FR)) * passed
		timer_WL = timer_WL + interpolate(time_table, get(sim_lan_WL)) * passed
		timer_WR = timer_WR + interpolate(time_table, get(sim_lan_WR)) * passed
		if timer_FL > timeToFail_FL then set(lan_lamp_fail_FL, 1) end
		if timer_FR > timeToFail_FR then set(lan_lamp_fail_FR, 1) end
		if timer_WL > timeToFail_WL then set(lan_lamp_fail_WL, 1) end
		if timer_WR > timeToFail_WR then set(lan_lamp_fail_WR, 1) end
		if timer_FL < 0 then timer_FL = 0 end
		if timer_FR < 0 then timer_FR = 0 end
		if timer_WL < 0 then timer_WL = 0 end
		if timer_WR < 0 then timer_WR = 0 end	
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			if get(lan_lamp_fail_FL) ~= 1 then set(lan_lamp_fail_FL, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(lan_lamp_fail_FR) ~= 1 then set(lan_lamp_fail_FR, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(lan_lamp_fail_WL) ~= 1 then set(lan_lamp_fail_WL, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(lan_lamp_fail_WR) ~= 1 then set(lan_lamp_fail_WR, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(rel_lites_nav) ~= 6 then set(rel_lites_nav, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
			if get(rel_lites_beac) ~= 6 then set(rel_lites_beac, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
		end
	else
		fail_counter = 0
		set(lan_lamp_fail_FL, 0)
		set(lan_lamp_fail_FR, 0)
		set(lan_lamp_fail_WL, 0)
		set(lan_lamp_fail_WR, 0)
		set(rel_lites_nav, 0)
		set(rel_lites_beac, 0)
	end
end
end