defineProperty("bat_on_bus", globalPropertyi("tu154ce/switchers/eng/bat1_on")) 
defineProperty("bat_source", globalPropertyi("tu154ce/elec/bat_is_source_1")) 
defineProperty("bat_amp_bus", globalPropertyf("tu154ce/elec/bat_amp_1")) 
defineProperty("bat_amp_cc", globalPropertyf("tu154ce/elec/bat_cc_1")) 
defineProperty("bat_volt_bus", globalPropertyf("tu154ce/elec/bat_volt_1")) 
defineProperty("bat_thermo", globalPropertyf("tu154ce/elec/bat_therm_1")) 
defineProperty("bat_fail", globalPropertyi("tu154ce/failures/bat_1_fail")) 
defineProperty("bat_kz", globalPropertyi("tu154ce/failures/bat_1_kz")) 
defineProperty("bus_volt", globalPropertyf("tu154ce/elec/bus27_volt_left")) 
defineProperty("cockpit_temp", globalPropertyf("tu154ce/thermo/cockpit_temp")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("sim_bat_on", globalPropertyf("sim/cockpit2/electrical/battery_on[0]")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local current_table = {{ -5000, 0},    
				  { 0, 0 },   
				  { 600, 100 },   
            	  { 1200, 500 },   
           		  { 1800, 1000 },    
          		  { 20000, 1000 }}   
local bat_capacity = 25 - math.random() * 1.5 
local BAT_CURRENT_COEF = 2 
local kz_timer = 0 
local KzTimer = 1
local thermo = 20
function update()  
local MASTER = get(ismaster) ~= 1	
	local MAX_BAT_CAPACITY = 45 + get(cockpit_temp) 
	if MAX_BAT_CAPACITY > 25 then MAX_BAT_CAPACITY = 25
	elseif MAX_BAT_CAPACITY < 0 then MAX_BAT_CAPACITY = 0 end
	if bat_capacity > MAX_BAT_CAPACITY then 
		bat_capacity = MAX_BAT_CAPACITY
	end
	local passed = get(frame_time)
	local bat_on = get(bat_on_bus)
	local bat_amp = get(bat_amp_bus)
	local fail = get(bat_fail) == 1
	local kz = get(bat_kz) == 1
	set(sim_bat_on, bat_on)
if MASTER then	
	if passed > 0 then
		local bat_volt = 17 + ((bat_capacity - kz_timer) /2.5) - 1.5 * bat_amp / 100
		if bat_on == 1 then   
			if get(bat_source) == 1 then
				bat_capacity = bat_capacity - bat_amp * passed / 3600
				bat_volt = 17 + ((bat_capacity - kz_timer) / 2.5) - 1.5 * bat_amp / 100 
				if bat_capacity < 2 then bat_volt = 3 end
				set(bat_amp_cc, 0)
			else
				if fail then 
					bat_capacity = 0
					bat_volt = 3
					MAX_BAT_CAPACITY = 0
				end
				if get(bus_volt) > bat_volt then
					bat_volt = get(bus_volt)
				end
				bat_capacity = bat_capacity + passed * 0.01
				set(bat_amp_cc, (MAX_BAT_CAPACITY - bat_capacity) * BAT_CURRENT_COEF + interpolate(current_table, kz_timer))   
			end
			if kz and kz_timer < 1800 then 
				kz_timer = kz_timer + passed * KzTimer
			end
			MAX_BAT_CAPACITY = MAX_BAT_CAPACITY - kz_timer
			set(bat_volt_bus, bat_volt)
			if bat_capacity < 0 then
				bat_capacity = 0 
			end
			if bat_capacity > MAX_BAT_CAPACITY then 
				bat_capacity = MAX_BAT_CAPACITY
			end
			thermo = 20 + get(bat_amp_cc) * 0.3
			set(bat_thermo, thermo)
		else 
			if fail then 
				bat_capacity = 0
				bat_volt = 3
				MAX_BAT_CAPACITY = 0
			end
			set(bat_amp_cc, 0)	
			set(bat_volt_bus, bat_volt)
			if thermo > 20 then thermo = thermo - passed * 0.5 end
			set(bat_thermo, thermo)		
		end
	end
end
end
