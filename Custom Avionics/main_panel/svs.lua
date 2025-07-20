defineProperty("mach_sim", globalPropertyf("sim/flightmodel/misc/machno")) 
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  
defineProperty("msl_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  
defineProperty("airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed")) 
defineProperty("true_airspeed", globalPropertyf("sim/flightmodel/position/true_airspeed")) 
defineProperty("svs_contr", globalPropertyi("tu154ce/buttons/ovhd/svs_contr")) 
defineProperty("svs_on", globalPropertyi("tu154ce/switchers/ovhd/svs_on")) 
defineProperty("svs_heat", globalPropertyi("tu154ce/switchers/ovhd/svs_heat")) 
defineProperty("rel_pitot", globalPropertyi("sim/operation/failures/rel_pitot")) 
defineProperty("rel_pitot2", globalPropertyi("sim/operation/failures/rel_pitot2")) 
defineProperty("static_fail_L", globalPropertyi("sim/operation/failures/rel_static"))  
defineProperty("static_fail_R", globalPropertyi("sim/operation/failures/rel_static2"))  
defineProperty("svs_fail", globalPropertyi("sim/operation/failures/rel_adc_comp"))  
defineProperty("mach_svs", globalPropertyf("tu154ce/svs/machno")) 
defineProperty("alt_svs", globalPropertyf("tu154ce/svs/altitude")) 
defineProperty("tas_svs", globalPropertyf("tu154ce/svs/true_airspeed")) 
defineProperty("bus27_volt", globalPropertyf("tu154ce/elec/bus27_volt_left")) 
defineProperty("bus36_volt", globalPropertyf("tu154ce/elec/bus36_volt_left")) 
defineProperty("bus115_volt", globalPropertyf("tu154ce/elec/bus115_1_volt")) 
defineProperty("svs27_cc", globalPropertyf("tu154ce/svs/power_27cc")) 
defineProperty("svs36_cc", globalPropertyf("tu154ce/svs/power_36cc")) 
defineProperty("svs115_cc", globalPropertyf("tu154ce/svs/power_115cc")) 
defineProperty("sensors_caps", globalPropertyi("tu154ce/anim/sensors_caps"))  
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local alt_kus_tbl = {{ -50000000, 0.5},    
				  { 0, 1 },    
          		  {  2000, 1.0288 },
				  {  4000, 1.0571 },
				  {  6000, 1.0879 },
				  {  8000, 1.1205 },
				  {  10000, 1.1549 },
				  {  12000, 1.1901 },
				  {  14000, 1.2223 },
				  {  16000, 1.2558 },  
          		  {  18000, 1.2924 },   
          		  {  20000, 1.3341 },
				  {  22000, 1.3708 },
				  {  24000, 1.4154 },
				  {  26000, 1.4558 },
				  {  28000, 1.5005 },
				  {  30000, 1.5500 },
				  {  32000, 1.6039 },
				  {  34000, 1.6597 },
				  {  36000, 1.7164 },
				  {  38000, 1.7920 },
				  {  40000, 1.8762 },
				  {  42000, 1.9653 },
          		  {  10000000, 10 }}   
local mach = 0
local tas = 0
local altitude = 0
function update()
	local power = get(svs_on) == 1 and get(bus27_volt) > 13 and get(bus36_volt) > 30 and get(bus115_volt) > 110 and get(svs_fail) == 0
	local test = power and get(svs_contr) == 1
	local heat = power and get(svs_heat) == 1
	local cc_27 = bool2int(power) * 10 + bool2int(test) * 4 + bool2int(heat) * 17
	local cc_other = bool2int(power)
	set(svs27_cc, cc_27)
	set(svs36_cc, cc_other * 1.5)
	set(svs115_cc, cc_other * 3.5)
	local pitot_fail = (get(rel_pitot) == 6 and get(rel_pitot2) == 6)
	if not pitot_fail and power then mach = get(mach_sim) end
	if test then mach = 0.8 end 
	local alt_QNE = get(msl_alt) * 3.28083 + (29.92 - get(msl_press)) * 1000  
	local static_fail = (get(static_fail_L) == 6 and get(static_fail_R) == 6)
	if power and not static_fail then altitude = alt_QNE * 0.3048 end
	if test then altitude = 12000 end
	if power and not pitot_fail then tas = get(true_airspeed) * 3.6 end 
	if tas < 180 then tas = 0 end
	if test then tas = 900 end
local MASTER = get(ismaster) ~= 1	
if MASTER then	
	set(mach_svs, mach)
	set(alt_svs, altitude)	
	set(tas_svs, tas)
end
end
