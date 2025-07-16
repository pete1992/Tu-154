defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("ias", globalPropertyf("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")) 
defineProperty("mach", globalPropertyf("sim/flightmodel/misc/machno")) 
defineProperty("gforce", globalPropertyf("sim/flightmodel2/misc/gforce_normal")) 
defineProperty("alpha", globalPropertyf("sim/flightmodel2/misc/AoA_angle_degrees"))  
defineProperty("alpha_fail", globalPropertyi("sim/operation/failures/rel_AOA"))  
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) 
defineProperty("slats", globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")) 
defineProperty("rel_pitot", globalPropertyi("sim/operation/failures/rel_pitot")) 
defineProperty("deflection_mtr_1", globalPropertyf("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]")) 
defineProperty("lamp_test", globalPropertyi("sim/custom/buttons/lamp_test_front")) 
defineProperty("auasp_on", globalPropertyi("sim/custom/switchers/ovhd/auasp_on")) 
defineProperty("auasp_contr", globalPropertyi("sim/custom/switchers/ovhd/auasp_contr")) 
defineProperty("gforce_reset", globalPropertyi("sim/custom/buttons/misc/gforce_reset")) 
defineProperty("lamp_test", globalPropertyi("sim/custom/buttons/lamp_test_front")) 
defineProperty("day_night_set", globalPropertyf("sim/custom/lights/day_night_set")) 
defineProperty("bus27_volt_right", globalPropertyf("sim/custom/elec/bus27_volt_right"))
defineProperty("bus115_3_volt", globalPropertyf("sim/custom/elec/bus115_3_volt"))
defineProperty("bus27_volt_left", globalPropertyf("sim/custom/elec/bus27_volt_left"))
defineProperty("auasp_pow27_cc", globalPropertyf("sim/custom/elec/auasp_pow27_cc"))
defineProperty("auasp_pow115_cc", globalPropertyf("sim/custom/elec/auasp_pow115_cc"))
defineProperty("uap_fail", globalPropertyi("sim/operation/failures/rel_AOA")) 
defineProperty("warn_fail", globalPropertyi("sim/operation/failures/rel_stall_warn")) 
defineProperty("aoa_ind", globalPropertyf("sim/custom/gauges/misc/aoa_ind")) 
defineProperty("aoa_sector", globalPropertyf("sim/custom/gauges/misc/aoa_sector")) 
defineProperty("gforce_ind", globalPropertyf("sim/custom/gauges/misc/gforce_ind")) 
defineProperty("gforce_max", globalPropertyf("sim/custom/gauges/misc/gforce_max")) 
defineProperty("gforce_min", globalPropertyf("sim/custom/gauges/misc/gforce_min")) 
defineProperty("auasp_lamp", globalPropertyf("sim/custom/lights/auasp_lamp")) 
defineProperty("alpha_high", globalPropertyf("sim/custom/lights/alpha_high")) 
defineProperty("g_force_high", globalPropertyf("sim/custom/lights/g_force_high")) 
defineProperty("alpha_critical", globalPropertyi("sim/custom/auasp/alpha_critical")) 
defineProperty("gforce_critical", globalPropertyi("sim/custom/auasp/gforce_critical")) 
defineProperty("speaker_auasp", globalPropertyi("sim/custom/alarm/speaker_auasp")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local m_tbl = {
{-1000, 12},
{0, 12},
{0.6, 12},
{0.63, 11},
{0.67, 10},
{0.69, 9},
{0.77, 8},
{0.87, 7},
{0.96, 6},
{1, 4.5},
{1.5, 0},
{100000, 0},
}
local sector_ang = 12
local aoa_ang_act = 0
local aoa_ang_need = 0
local lamp_lit = false
local lamp_counter = 0
local mach_act = 0
local gf_act = 0
local gf_max = 0
local gf_min = 0
function update()
	local MASTER = get(ismaster) ~= 1	
	local power = bool2int(get(bus27_volt_right) > 13 and get(bus115_3_volt) > 110 and get(auasp_on) == 1 and get(uap_fail) < 6)
	local passed = get(frame_time)
	local mode_sw = get(auasp_contr)
	set(auasp_pow27_cc, power * 10)
	set(auasp_pow115_cc, power * 3)
	local sector_ang_need = 12
	local flaps = get(flap_inn_L)
	local slat = get(slats)
	if get(rel_pitot) < 6 then mach_act = get(mach) end
	if mode_sw == 1 then sector_ang_need = 10
	elseif slat > 0.9 and flaps < 25 then sector_ang_need = 14
	elseif flaps >= 25 then sector_ang_need = 12 
	else
		if mach_act <= 0.42 then sector_ang_need = 12
		else sector_ang_need = (0.42 - mach_act) * 6 / 0.48 + 12 end
	end
	if sector_ang > sector_ang_need + 0.01 then sector_ang = sector_ang - passed * power * 0.4
	elseif sector_ang < sector_ang_need - 0.01 then sector_ang = sector_ang + passed * power * 0.4 end
	set(aoa_sector, sector_ang)
	if mode_sw == 1 and get(alpha_fail) < 6 then 
		aoa_ang_need = 10
	elseif mode_sw == -1 then 
		aoa_ang_need = 0
	else
		if get(ias) > 50 and get(alpha_fail) < 6 then
			aoa_ang_need = get(alpha) + 3
		end
	end
	aoa_ang_act = aoa_ang_act + (aoa_ang_need - aoa_ang_act) * passed * power * 3
	if aoa_ang_act > 15 then aoa_ang_act = 15
	elseif aoa_ang_act < 0 then aoa_ang_act = 0 end
	set(aoa_ind, aoa_ang_act)
	local gf_need = 0
	if mode_sw == 1 then gf_need = 2.0
	else
		gf_need = get(gforce)
	end	
	gf_act = gf_act + (gf_need - gf_act) * passed * 2 * power
	if gf_act > 3 then gf_act = 3
	elseif gf_act < -1 then gf_act = -1 end		
	set(gforce_ind, gf_act)
	local button = get(gforce_reset)
	if gf_max < gf_act then gf_max = gf_act 
	elseif gf_max > gf_act + 0.01 then gf_max = gf_max - passed * button * 2
	end
	if gf_min > gf_act then gf_min = gf_act 
	elseif gf_min < gf_act - 0.01 then gf_min = gf_min + passed * button * 2
	end
if MASTER then	
	set(gforce_max, gf_max)
	set(gforce_min, gf_min)
end
	local aoa_crit = bool2int(aoa_ang_act >= sector_ang - 0.5) * power
	local gf_crit = bool2int(gf_act >= 1.8 or gf_act <= -0.8) * power                                                                                                                                                   
	if aoa_crit + gf_crit > 0 then 
		lamp_counter = lamp_counter + passed
		if lamp_counter > 0.3 then
			lamp_counter = 0
			lamp_lit = not lamp_lit
		end
	else
		lamp_lit = false
	end
	set(alpha_critical, aoa_crit)
	set(gforce_critical, gf_crit)
	set(auasp_lamp, bool2int(lamp_lit))
	set(speaker_auasp, math.max(aoa_crit, gf_crit) * bool2int(get(warn_fail) < 6))
	local test_btn = get(lamp_test) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.25
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	set(alpha_high, math.max(aoa_crit * lamps_brt, test_btn))
	set(g_force_high, math.max(gf_crit * lamps_brt, test_btn))
end
по ПТ
закрылки между 2 - 28 - сектор на 13
при закрылках 28+ - сектор на 12
при убраных - 12
на скорости М 0.6 сектор начинает движение
0.63 = 11
0.67 = 10
0.69 = 9
0.77 = 8
0.87 = 7
0.96 = 6
1 = 4.5
1.5 = 0
при проверке сектор на 11, стрелка на 11. лампа мигает
лампа не реагирует на кнопку проверки ламп
