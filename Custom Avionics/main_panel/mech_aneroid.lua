defineProperty("vvi_L", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_pilot")) 
defineProperty("vvi_R", globalPropertyf("sim/cockpit2/gauges/indicators/vvi_fpm_copilot"))
defineProperty("vvi_cab", globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_vvi_fpm"))
defineProperty("ias_L", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) 
defineProperty("ias_R", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_copilot"))
defineProperty("actual_cabin_alt", globalPropertyf("sim/cockpit2/pressurization/indicators/cabin_altitude_ft"))
defineProperty("cabin_press_diff", globalPropertyf("sim/cockpit2/pressurization/indicators/pressure_diffential_psi"))
defineProperty("msl_alt", globalPropertyf("sim/flightmodel/position/elevation"))  
defineProperty("msl_press", globalPropertyf("sim/weather/barometer_sealevel_inhg"))  
defineProperty("static_fail_L", globalPropertyi("sim/operation/failures/rel_static"))  
defineProperty("static_fail_R", globalPropertyi("sim/operation/failures/rel_static2"))  
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("sensors_caps", globalPropertyi("tu154ce/anim/sensors_caps"))  
defineProperty("kus_ias_left", globalPropertyf("tu154ce/gauges/speed/kus_ias_left")) 
defineProperty("kus_tas_left", globalPropertyf("tu154ce/gauges/speed/kus_tas_left")) 
defineProperty("kus_ias_right", globalPropertyf("tu154ce/gauges/speed/kus_ias_right")) 
defineProperty("kus_tas_right", globalPropertyf("tu154ce/gauges/speed/kus_tas_right")) 
defineProperty("kus_ias_eng", globalPropertyf("tu154ce/gauges/speed/kus_ias_eng")) 
defineProperty("kus_tas_eng", globalPropertyf("tu154ce/gauges/speed/kus_tas_eng")) 
defineProperty("ias_left", globalPropertyf("tu154ce/gauges/speed/ias_left")) 
defineProperty("ias_right", globalPropertyf("tu154ce/gauges/speed/ias_right")) 
defineProperty("var75", globalPropertyf("tu154ce/gauges/alt/var75")) 
defineProperty("var30", globalPropertyf("tu154ce/gauges/alt/var30")) 
defineProperty("var30_cabin", globalPropertyf("tu154ce/gauges/airbleed/cabin_vvi")) 
defineProperty("cabin_diff", globalPropertyf("tu154ce/gauges/airbleed/cabin_diff")) 
defineProperty("cabin_alt", globalPropertyf("tu154ce/gauges/airbleed/cabin_alt")) 
defineProperty("vd15_alt_left", globalPropertyf("tu154ce/gauges/alt/vd15_alt_left")) 
defineProperty("vd15_tri_needle_left", globalPropertyf("tu154ce/gauges/alt/vd15_tri_needle_left")) 
defineProperty("vd15_pressure_left", globalPropertyf("tu154ce/gauges/alt/vd15_pressure_left")) 
defineProperty("vd15_alt_right", globalPropertyf("tu154ce/gauges/alt/vd15_alt_right")) 
defineProperty("vd15_tri_needle_right", globalPropertyf("tu154ce/gauges/alt/vd15_tri_needle_right")) 
defineProperty("vd15_pressure_right", globalPropertyf("tu154ce/gauges/alt/vd15_pressure_right")) 
defineProperty("vd15_alt_eng", globalPropertyf("tu154ce/gauges/alt/vd15_alt_eng")) 
defineProperty("vd15_tri_needle_eng", globalPropertyf("tu154ce/gauges/alt/vd15_tri_needle_eng")) 
defineProperty("vd15_pressure_eng", globalPropertyf("tu154ce/gauges/alt/vd15_pressure_eng")) 
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
local var30_tbl = { 
{  -10000000, -180 },
{  -30, -180 },
{  -20, -150 }, 
{  -10, -85 },
{  10, 85 },
{  20, 150 },
{  30, 180 },
{ 10000000, 180 }} 
local var75_tbl = { 
{  -10000000, -180 },
{  -75, -180 },
{  -45, -135 }, 
{  -15, -45 },
{  15, 45 },
{  45, 135 },
{  75, 180 },
{ 10000000, 180 }} 
local kus_ias_act_L = 0
local kus_tas_act_L = 0
local ias_cpt_act = 0
local ias_copil_act = 0
local kus_ias_act_R = 0
local kus_tas_act_R = 0
local kus_ias_act_ENG = 0
local kus_tas_act_ENG = 0
local var75_act = 0
local var30_act = 0
local var30_cabin_act = 0
local left_MSL = 0
local right_MSL = 0
function update()
local MASTER = get(ismaster) ~= 1
	local passed = get(frame_time)
	local alt_QNE = get(msl_alt) * 3.28083 + (29.92 - get(msl_press)) * 1000  
	local alt_tas_coef = interpolate(alt_kus_tbl, alt_QNE)
	local airspeed_L = get(ias_L) * 1.852
	local airspeed_R = get(ias_R) * 1.852
	local cpt_speed_ang = 0
	if airspeed_L > 50 and airspeed_L < 750 then 
		cpt_speed_ang = (airspeed_L - 50) * 142.5 / 300 + 6
	elseif airspeed_L >= 750 then 
		cpt_speed_ang = 339
	end
	local tas_L = airspeed_L * alt_tas_coef
	local cpt_tas_ang = 0
	if tas_L >= 400 and tas_L < 1100 then
		cpt_tas_ang = (tas_L - 400) * 330 / 700 + 15
	elseif tas_L > 1100 then
		cpt_tas_ang = 345
	end
	kus_ias_act_L = kus_ias_act_L + (cpt_speed_ang - kus_ias_act_L) * passed * 10
	kus_tas_act_L = kus_tas_act_L + (cpt_tas_ang - kus_tas_act_L) * passed * 10
	local cpt_IAS_ang = 0
	if airspeed_L > 150 and airspeed_L < 1000 then
		cpt_IAS_ang = (airspeed_L - 150) * 260 / 650 + 10
	elseif airspeed_L > 1000 then
		cpt_IAS_ang = 350
	end
	ias_cpt_act = ias_cpt_act + (cpt_IAS_ang - ias_cpt_act) * passed * 10
	local copil_IAS_ang = 0
	if airspeed_R > 150 and airspeed_R < 1000 then
		copil_IAS_ang = (airspeed_R - 150) * 260 / 650 + 10
	elseif airspeed_R > 1000 then
		copil_IAS_ang = 350
	end
	ias_copil_act = ias_copil_act + (copil_IAS_ang - ias_copil_act) * passed * 10	
	local copil_speed_ang = 0
	local ias_kts_R = airspeed_R / 1.852
	if ias_kts_R > 50 and ias_kts_R < 400 then 
		copil_speed_ang = (ias_kts_R - 50) * 327 / 350 + 13
	elseif ias_kts_R >= 400 then 
		copil_speed_ang = 340
	end
	local tas_R = ias_kts_R * alt_tas_coef
	local copil_tas_ang = 0
	if tas_R >= 200 and tas_R < 600 then
		copil_tas_ang = (tas_R - 200) * 335 / 400 + 10
	elseif tas_R > 600 then
		copil_tas_ang = 345
	end	
	kus_ias_act_R = kus_ias_act_R + (copil_speed_ang - kus_ias_act_R) * passed * 10
	kus_tas_act_R = kus_tas_act_R + (copil_tas_ang - kus_tas_act_R) * passed * 10
	local eng_speed_ang = 0
	if airspeed_R > 50 and airspeed_R < 750 then 
		eng_speed_ang = (airspeed_R - 50) * 142.5 / 300 + 6
	elseif airspeed_R >= 750 then 
		eng_speed_ang = 339
	end
	local tas_ENG = airspeed_R * alt_tas_coef
	local eng_tas_ang = 0
	if tas_ENG >= 400 and tas_ENG < 1100 then
		eng_tas_ang = (tas_ENG - 400) * 330 / 700 + 15
	elseif tas_ENG > 1100 then
		eng_tas_ang = 345
	end
	kus_ias_act_ENG = kus_ias_act_ENG + (eng_speed_ang - kus_ias_act_ENG) * passed * 10
	kus_tas_act_ENG = kus_tas_act_ENG + (eng_tas_ang - kus_tas_act_ENG) * passed * 10	
	var75_act = var75_act + (interpolate(var75_tbl, get(vvi_L) * 0.00508) - var75_act) * passed * 1
	var30_act = var30_act + (interpolate(var30_tbl, get(vvi_R) * 0.00508) - var30_act) * passed * 1
	var30_cabin_act = var30_cabin_act + (interpolate(var30_tbl, get(vvi_cab) * 0.00508) - var30_cabin_act) * passed * 0.08
	local staticFail_left = get(static_fail_L) == 6
	local staticFail_right = get(static_fail_R) == 6
	local msl = get(msl_alt) * 3.28083 
	if not staticFail_left then
		left_MSL = msl 
	end
	if not staticFail_right then
		right_MSL = msl 
	end	
	local cpt_VM15_press = get(vd15_pressure_left) * 0.0393701
	local cpt_VM15_alt = left_MSL * 0.3048 + (cpt_VM15_press - get(msl_press)) * 1000 * 0.3048  
	local copt_VM15_press = get(vd15_pressure_right) * 0.0393701
	local copt_VM15_alt = right_MSL * 0.3048 + (copt_VM15_press - get(msl_press)) * 1000 * 0.3048  
	local eng_VM15_press = get(vd15_pressure_eng) * 0.0393701
	local eng_VM15_alt = right_MSL * 0.3048 + (eng_VM15_press - get(msl_press)) * 1000 * 0.3048  
	local cab_alt = get(actual_cabin_alt) * 0.3048 * 0.001 
	if cab_alt < -0.45 then cab_alt = -0.45
	elseif cab_alt > 5.05 then cab_alt = 5.05 end
	local press_diff = get(cabin_press_diff) * 0.0778  
	if press_diff < -0.03 then press_diff = -0.03
	elseif press_diff > 0.95 then press_diff = 0.95 end
	set(kus_ias_left, kus_ias_act_L)
	set(kus_tas_left, kus_tas_act_L)
	set(ias_left, ias_cpt_act)
	set(ias_right, ias_copil_act)
	set(kus_ias_right, kus_ias_act_R)
	set(kus_tas_right, kus_tas_act_R)
	set(kus_ias_eng, kus_ias_act_ENG)
	set(kus_tas_eng, kus_tas_act_ENG)
if MASTER then 
	set(var75, var75_act)
	set(var30, var30_act)
end
	set(var30_cabin, var30_cabin_act)
	set(vd15_alt_left, cpt_VM15_alt)
	set(vd15_alt_right, copt_VM15_alt)
	set(vd15_alt_eng, eng_VM15_alt)
	set(cabin_alt, cab_alt)
	set(cabin_diff, press_diff)
end