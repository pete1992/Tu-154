size = {512, 700}
defineProperty("save_state", globalPropertyi("tu154ce/save_state")) 
defineProperty("bg_img", loadImage("repair_tex.png"))
defineProperty("show_fail_panel", globalPropertyi("tu154ce/panels/show_fail_panel")) 
defineProperty("reset_state", globalPropertyi("tu154ce/reset_state")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("failures_enabled", globalPropertyi("tu154ce/failures/failures_enabled")) 
local runtime_tbl = {}
runtime_tbl[1] = {"APU", globalPropertyd("tu154ce/failures/apu_runtime")} 
runtime_tbl[2] = {"Eng #1", globalPropertyf("tu154ce/failures/engine_runtime_1")}
runtime_tbl[3] = {"Eng #2", globalPropertyf("tu154ce/failures/engine_runtime_2")}
runtime_tbl[4] = {"Eng #3", globalPropertyf("tu154ce/failures/engine_runtime_3")}
local brakes_tbl = {}
brakes_tbl[1] = {"Brake L", globalPropertyf("tu154ce/failures/brake_runtime_left")} 
brakes_tbl[2] = {"Brake R", globalPropertyf("tu154ce/failures/brake_runtime_right")} 
local liqd_tbl = {}
liqd_tbl[1] = {"Engine #1 Oil", globalPropertyf("tu154ce/failures/engn_oil_qty_1")} 
liqd_tbl[2] = {"Engine #2 Oil", globalPropertyf("tu154ce/failures/engn_oil_qty_2")} 
liqd_tbl[3] = {"Engine #3 Oil", globalPropertyf("tu154ce/failures/engn_oil_qty_3")} 
local hydro_tbl = {}
hydro_tbl[1] = {"Hydro Sys #1", globalPropertyf("tu154ce/hydro/gs_qty_1")} 
hydro_tbl[2] = {"Hydro Sys #2", globalPropertyf("tu154ce/hydro/gs_qty_2")} 
hydro_tbl[3] = {"Hydro Sys #3", globalPropertyf("tu154ce/hydro/gs_qty_3")} 
local customFails = {}
local simFails = {}
customFails["ABSU Pitot heat"] = globalPropertyi("tu154ce/antiice/ppd_3_heat_fail")
simFails["Engine #1 inlet heat"] = globalPropertyi("sim/operation/failures/rel_ice_inlet_heat")
simFails["Engine #2 inlet heat"] = globalPropertyi("sim/operation/failures/rel_ice_inlet_heat2")
simFails["Engine #3 inlet heat"] = globalPropertyi("sim/operation/failures/rel_ice_inlet_heat3")
simFails["Left Pitot heat"] = globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1")
simFails["Right Pitot heat"] = globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2")
simFails["Wings heat"] = globalPropertyi("sim/operation/failures/rel_ice_surf_heat")
simFails["Stab heat"] = globalPropertyi("sim/operation/failures/rel_ice_surf_heat2")
customFails["Ice detect"] = globalPropertyi("tu154ce/failures/rio_fail")
customFails["Left window heat"] = globalPropertyi("tu154ce/failures/window_heat_fail_1")
customFails["Center window heat"] = globalPropertyi("tu154ce/failures/window_heat_fail_2")
customFails["Right window heat"] = globalPropertyi("tu154ce/failures/window_heat_fail_3")
customFails["APU burnt"] = globalPropertyi("tu154ce/failures/apu_fail_fuel_left") 
customFails["APU starter"] = globalPropertyi("tu154ce/failures/apu_start_fail") 
customFails["APU"] = globalPropertyi("tu154ce/failures/apu_fail") 
customFails["APU air pressure"] = globalPropertyi("tu154ce/failures/apu_press_fail") 
simFails["!!!Left brakes"] = globalPropertyi("sim/operation/failures/rel_lbrakes") 
simFails["!!!Right brakes"] = globalPropertyi("sim/operation/failures/rel_rbrakes") 
customFails["!!!Aileron left"] = globalPropertyi("tu154ce/failures/ail_fail_left") 
customFails["!!!Aileron right"] = globalPropertyi("tu154ce/failures/ail_fail_right") 
customFails["Left inner spoiler "] = globalPropertyi("tu154ce/failures/fail_spoil_inn_left") 
customFails["Right inner spoiler"] = globalPropertyi("tu154ce/failures/fail_spoil_inn_right") 
customFails["!!!Left middle spoiler"] = globalPropertyi("tu154ce/failures/fail_spoil_mid_left") 
customFails["!!!Right middle spoiler"] = globalPropertyi("tu154ce/failures/fail_spoil_mid_right") 
customFails["Left outter spoiler"] = globalPropertyi("tu154ce/failures/fail_spoil_out_left") 
customFails["Right outter spoiler"] = globalPropertyi("tu154ce/failures/fail_spoil_out_right") 
customFails["!!!Rudder"] = globalPropertyi("tu154ce/failures/rudder_fail") 
customFails["!!!Left elevator"] = globalPropertyi("tu154ce/failures/elev_fail_left") 
customFails["!!!Right elevator"] = globalPropertyi("tu154ce/failures/elev_fail_right") 
simFails["!!!Rudder trimm"] = globalPropertyi("sim/operation/failures/rel_trim_rud") 
simFails["!!!Aileron trimm"] = globalPropertyi("sim/operation/failures/rel_trim_ail") 
simFails["!!!Elevator trimm"] = globalPropertyi("sim/operation/failures/rel_trim_elv") 
customFails["!!!Emerg elev trimm"] = globalPropertyi("tu154ce/failures/trim_emerg_elv_fail") 
customFails["!!!Left flaps"] = globalPropertyi("tu154ce/failures/flap_fail_left") 
customFails["!!!Right flpas"] = globalPropertyi("tu154ce/failures/flap_fail_right") 
customFails["!!!Stab mechanics"] = globalPropertyi("tu154ce/failures/stab_eng_fail") 
customFails["!!!Stab automatic"] = globalPropertyi("tu154ce/failures/stab_automatic_fail") 
customFails["!!!Slats"] = globalPropertyi("tu154ce/failures/slats_fail") 
simFails["Front gear retract"] = globalPropertyi("sim/operation/failures/rel_lagear1") 
simFails["Left gear retract"] = globalPropertyi("sim/operation/failures/rel_lagear2") 
simFails["Right gear retract"] = globalPropertyi("sim/operation/failures/rel_lagear3") 
simFails["Gear actuator"] = globalPropertyi("sim/operation/failures/rel_gear_act") 
simFails["!!!Generator #1"] = globalPropertyi("sim/operation/failures/rel_genera0")
simFails["!!!Generator #2"] = globalPropertyi("sim/operation/failures/rel_genera1")
simFails["!!!Generator #3"] = globalPropertyi("sim/operation/failures/rel_genera2")
customFails["APU Generator"] = globalPropertyi("tu154ce/failures/apu_gen_fail")
customFails["!!!VU 1"] = globalPropertyi("tu154ce/failures/vu1_fail")
customFails["!!!VU 2"] = globalPropertyi("tu154ce/failures/vu2_fail")
customFails["!!!Aux VU"] = globalPropertyi("tu154ce/failures/vu3_fail")
customFails["!!!TR 1"] = globalPropertyi("tu154ce/failures/tr1_fail")
customFails["!!!TR 2"] = globalPropertyi("tu154ce/failures/tr2_fail")
customFails["!!!PTS250 #1"] = globalPropertyi("tu154ce/failures/pts250_1_fail")
customFails["!!!PTS250 #2"] = globalPropertyi("tu154ce/failures/pts250_2_fail")
customFails["!!!Inv 115v"] = globalPropertyi("tu154ce/failures/inv115_fail")
customFails["!!!Battery #1"] = globalPropertyi("tu154ce/failures/bat_1_fail")
customFails["!!!Battery #2"] = globalPropertyi("tu154ce/failures/bat_2_fail")
customFails["!!!Battery #3"] = globalPropertyi("tu154ce/failures/bat_3_fail")
customFails["!!!Battery #4"] = globalPropertyi("tu154ce/failures/bat_4_fail")
customFails["!!!Battery #1 heat"] = globalPropertyi("tu154ce/failures/bat_1_kz")
customFails["!!!Battery #2 heat"] = globalPropertyi("tu154ce/failures/bat_2_kz")
customFails["!!!Battery #3 heat"] = globalPropertyi("tu154ce/failures/bat_3_kz")
customFails["!!!Battery #4 heat"] = globalPropertyi("tu154ce/failures/bat_4_kz")
simFails["!!!Engine #1"] = globalPropertyi("sim/operation/failures/rel_engfai0")
simFails["!!!Engine #2"] = globalPropertyi("sim/operation/failures/rel_engfai1")
simFails["!!!Engine #3"] = globalPropertyi("sim/operation/failures/rel_engfai2")
customFails["Engine #1 fuel pump"] = globalPropertyi("tu154ce/failures/eng_fuel_pmp_fail_1")
customFails["Engine #2 fuel pump"] = globalPropertyi("tu154ce/failures/eng_fuel_pmp_fail_2")
customFails["Engine #3 fuel pump"] = globalPropertyi("tu154ce/failures/eng_fuel_pmp_fail_3")
customFails["!!!Engine #1 oil leak"] = globalPropertyi("tu154ce/failures/engn_oil_leak_1")
customFails["!!!Engine #2 oil leak"] = globalPropertyi("tu154ce/failures/engn_oil_leak_2")
customFails["!!!Engine #3 oil leak"] = globalPropertyi("tu154ce/failures/engn_oil_leak_3")
simFails["Engine #1 oil pump"] = globalPropertyi("sim/operation/failures/rel_oilpmp0")
simFails["Engine #2 oil pump"] = globalPropertyi("sim/operation/failures/rel_oilpmp1")
simFails["Engine #3 oil pump"] = globalPropertyi("sim/operation/failures/rel_oilpmp2")
simFails["Engine #1 fuel filter"] = globalPropertyi("sim/operation/failures/rel_eng_lo0")
simFails["Engine #2 fuel filter"] = globalPropertyi("sim/operation/failures/rel_eng_lo1")
simFails["Engine #3 fuel filter"] = globalPropertyi("sim/operation/failures/rel_eng_lo2")
simFails["Engine #1 starter"] = globalPropertyi("sim/operation/failures/rel_startr0")
simFails["Engine #2 starter"] = globalPropertyi("sim/operation/failures/rel_startr1")
simFails["Engine #3 starter"] = globalPropertyi("sim/operation/failures/rel_startr2")
simFails["Engine #1 igniter"] = globalPropertyi("sim/operation/failures/rel_ignitr0")
simFails["Engine #2 igniter"] = globalPropertyi("sim/operation/failures/rel_ignitr1")
simFails["Engine #3 igniter"] = globalPropertyi("sim/operation/failures/rel_ignitr2")
simFails["Engine #1 reverser"] = globalPropertyi("sim/operation/failures/rel_revers0")
simFails["Engine #3 reverser"] = globalPropertyi("sim/operation/failures/rel_revers2")
customFails["Fuel pump 2L"] = globalPropertyi("tu154ce/failures/fuel_pump_2l_fail")
customFails["Fuel pump 2R"] = globalPropertyi("tu154ce/failures/fuel_pump_2r_fail")
customFails["Fuel pump 3L"] = globalPropertyi("tu154ce/failures/fuel_pump_3l_fail")
customFails["Fuel pump 3R"] = globalPropertyi("tu154ce/failures/fuel_pump_3r_fail")
customFails["Fuel pump 1"] = globalPropertyi("tu154ce/failures/fuel_pump_1_fail")
customFails["Fuel pump 4"] = globalPropertyi("tu154ce/failures/fuel_pump_4_fail")
customFails["Fuel cue system"] = globalPropertyi("tu154ce/failures/fuel_auto_fail")
customFails["Fuel leveler"] = globalPropertyi("tu154ce/failures/fuel_level_fail")
customFails["Fuel portion system"] = globalPropertyi("tu154ce/failures/fuel_porc_fail")
customFails["Fuel meter 2L"] = globalPropertyi("tu154ce/failures/fuel_meter_2l_fail")
customFails["Fuel meter 2R"] = globalPropertyi("tu154ce/failures/fuel_meter_2r_fail")
customFails["Fuel meter 3L"] = globalPropertyi("tu154ce/failures/fuel_meter_3l_fail")
customFails["Fuel meter 3R"] = globalPropertyi("tu154ce/failures/fuel_meter_3r_fail")
customFails["Fuel meter 1"] = globalPropertyi("tu154ce/failures/fuel_meter_1_fail")
customFails["Fuel meter 4"] = globalPropertyi("tu154ce/failures/fuel_meter_4_fail")
customFails["Fuel meter summ"] = globalPropertyi("tu154ce/failures/fuel_meter_summ")
customFails["FF meter #1"] = globalPropertyi("tu154ce/failures/fuel_flowmeter_1_fail")
customFails["FF meter #2"] = globalPropertyi("tu154ce/failures/fuel_flowmeter_2_fail")
customFails["FF meter #3"] = globalPropertyi("tu154ce/failures/fuel_flowmeter_3_fail")
customFails["!!!Hydraulic #1 leak"] = globalPropertyi("tu154ce/failures/hydro_leak_1")
customFails["!!!Hydraulic #2 leak"] = globalPropertyi("tu154ce/failures/hydro_leak_2")
customFails["!!!Hydraulic #3 leak"] = globalPropertyi("tu154ce/failures/hydro_leak_3")
customFails["!!!Hydraulic #4 leak"] = globalPropertyi("tu154ce/failures/hydro_leak_4")
customFails["!!!Engine hydraulic pump 1-1"] = globalPropertyi("tu154ce/failures/hydro_pump_fail_11")
customFails["!!!Engine hydraulic pump 1-2"] = globalPropertyi("tu154ce/failures/hydro_pump_fail_12")
customFails["!!!Engine hydraulic pump 2"] = globalPropertyi("tu154ce/failures/hydro_pump_fail_2")
customFails["!!!Engine hydraulic pump 3"] = globalPropertyi("tu154ce/failures/hydro_pump_fail_3")
customFails["!!!Electric hydraulic pump #2"] = globalPropertyi("tu154ce/failures/hydro_elec_fail_2")
customFails["!!!Electric hydraulic pump #3"] = globalPropertyi("tu154ce/failures/hydro_elec_fail_3")
customFails["Left turbo cooler"] = globalPropertyi("tu154ce/failures/tth_left_fail") 
customFails["Right turbo cooler"] = globalPropertyi("tu154ce/failures/tth_right_fail") 
customFails["Engine #1 airbleed"] = globalPropertyi("tu154ce/failures/airbleed_1") 
customFails["Engine #2 airbleed"] = globalPropertyi("tu154ce/failures/airbleed_2") 
customFails["Engine #3 airbleed"] = globalPropertyi("tu154ce/failures/airbleed_3") 
customFails["Left PSVP"] = globalPropertyi("tu154ce/failures/psvp_fail_left") 
customFails["Right PSVP"] = globalPropertyi("tu154ce/failures/psvp_fail_right") 
customFails["Air pressure valve"] = globalPropertyi("tu154ce/failures/sard_valve_fail") 
customFails["Front-Left landing light"] = globalPropertyi("tu154ce/failures/lan_lamp_fail_FL") 
customFails["Front-Right landing light"] = globalPropertyi("tu154ce/failures/lan_lamp_fail_FR") 
customFails["Wing-Left landing light"] = globalPropertyi("tu154ce/failures/lan_lamp_fail_WL") 
customFails["Wing-Right landing light"] = globalPropertyi("tu154ce/failures/lan_lamp_fail_WR") 
simFails["Nav lights"] = globalPropertyi("sim/operation/failures/rel_lites_nav") 
simFails["Beacon lights"] = globalPropertyi("sim/operation/failures/rel_lites_beac") 
customFails["Main alarm"] = globalPropertyi("tu154ce/failures/main_alarm_fail") 
customFails["Speaker alarm"] = globalPropertyi("tu154ce/failures/speaker_alarm_fail") 
customFails["ABSU RA56 roll"] = globalPropertyi("tu154ce/failures/absu_ra56_roll_fail") 
customFails["ABSU RA56 pitch"] = globalPropertyi("tu154ce/failures/absu_ra56_pitch_fail") 
customFails["ABSU RA56 yaw"] = globalPropertyi("tu154ce/failures/absu_ra56_yaw_fail") 
customFails["ABSU AT1"] = globalPropertyi("tu154ce/failures/absu_at1_fail") 
customFails["ABSU AT2"] = globalPropertyi("tu154ce/failures/absu_at2_fail") 
customFails["ABSU Roll damper"] = globalPropertyi("tu154ce/failures/absu_damp_roll_fail") 
customFails["ABSU Pitch damper"] = globalPropertyi("tu154ce/failures/absu_damp_pitch_fail") 
customFails["ABSU Yaw damper"] = globalPropertyi("tu154ce/failures/absu_damp_yaw_fail") 
customFails["ABSU Roll control"] = globalPropertyi("tu154ce/failures/absu_contr_roll_fail") 
customFails["ABSU Pitch control"] = globalPropertyi("tu154ce/failures/absu_contr_pitch_fail") 
customFails["ABSU TOGA Calc"] = globalPropertyi("tu154ce/failures/absu_calc_toga_fail") 
customFails["ABSU Roll Calc"] = globalPropertyi("tu154ce/failures/absu_calc_roll_fail") 
customFails["ABSU Pitch Calc"] = globalPropertyi("tu154ce/failures/absu_calc_pitch_fail") 
customFails["Doppler system"] = globalPropertyi("tu154ce/failures/diss_fail") 
customFails["Navigational system"] = globalPropertyi("tu154ce/failures/nvu_fail") 
customFails["Weather radar"] = globalPropertyi("tu154ce/failures/radar_fail") 
simFails["ADF #1"] = globalPropertyi("sim/operation/failures/rel_adf1")
simFails["ADF #2"] = globalPropertyi("sim/operation/failures/rel_adf2")
customFails["Course MP #1"] = globalPropertyi("tu154ce/failures/nav1_fail") 
customFails["Course MP #2"] = globalPropertyi("tu154ce/failures/nav2_fail") 
customFails["DME #1"] = globalPropertyi("tu154ce/failures/dme1_fail") 
customFails["DME #2"] = globalPropertyi("tu154ce/failures/dme2_fail") 
customFails["Marker receiver"] = globalPropertyi("tu154ce/failures/mrp_fail")
customFails["RSBN"] = globalPropertyi("tu154ce/failures/rsbn_fail")
customFails["TAWS"] = globalPropertyi("tu154ce/failures/taws_fail")
simFails["TKS gyro #1"] = globalPropertyi("sim/operation/failures/rel_ss_dgy")
simFails["TKS gyro #2"] = globalPropertyi("sim/operation/failures/rel_cop_dgy")
customFails["TKS Magnetic sensor #1"] = globalPropertyi("tu154ce/failures/tks_km1_fail")
customFails["TKS Magnetic sensor #2"] = globalPropertyi("tu154ce/failures/tks_km2_fail")
customFails["TKS magnetic corrector #1"] = globalPropertyi("tu154ce/failures/tks_bgmk1_fail")
customFails["TKS magnetic corrector #2"] = globalPropertyi("tu154ce/failures/tks_bgmk2_fail")
simFails["Captain's altimeter"] = globalPropertyi("sim/operation/failures/rel_ss_alt")
simFails["CoPilot's altimeter"] = globalPropertyi("sim/operation/failures/rel_cop_alt")
simFails["Turn indicator"] = globalPropertyi("sim/operation/failures/rel_ss_tsi")
customFails["Clock left"] = globalPropertyi("tu154ce/failures/acs1_fail")
customFails["Clock right"] = globalPropertyi("tu154ce/failures/acs2_fail")
customFails["Clock engineer"] = globalPropertyi("tu154ce/failures/acs3_fail")
customFails["Aux art horizon"] = globalPropertyi("tu154ce/failures/agr_fail")
customFails["BKK system"] = globalPropertyi("tu154ce/failures/bkk_fail")
customFails["!!!Left pitot block"] = globalPropertyi("tu154ce/failures/pitot1") 
customFails["!!!Right pitot block"] = globalPropertyi("tu154ce/failures/pitot2") 
customFails["!!!Left static"] = globalPropertyi("tu154ce/failures/static1")  
customFails["!!!Right static"] = globalPropertyi("tu154ce/failures/static2")  
simFails["!!!SVS system"] = globalPropertyi("sim/operation/failures/rel_adc_comp")  
customFails["Controll gyro"] = globalPropertyi("tu154ce/failures/mgv_fail") 
simFails["Captain's art horizon"] = globalPropertyi("sim/operation/failures/rel_ss_ahz")
simFails["CoPilot's art horizon"] = globalPropertyi("sim/operation/failures/rel_cop_ahz")
customFails["Radioaltimeter #1"] = globalPropertyi("tu154ce/failures/rv1_fail")  
customFails["Radioaltimeter #2"] = globalPropertyi("tu154ce/failures/rv2_fail")  
customFails["AOA"] = globalPropertyi("tu154ce/failures/AOA") 
simFails["AOA alarm"] = globalPropertyi("sim/operation/failures/rel_stall_warn") 
customFails["Feet altimeter"] = globalPropertyi("tu154ce/failures/uvid15_fail") 
simFails["Left VVI"] = globalPropertyi("sim/operation/failures/rel_ss_vvi") 
simFails["Right VVI"] = globalPropertyi("sim/operation/failures/rel_cop_vvi") 
defineProperty("system_qty_1", globalPropertyf("tu154ce/hydro/gs_qty_1")) 
defineProperty("system_qty_2", globalPropertyf("tu154ce/hydro/gs_qty_2")) 
defineProperty("system_qty_3", globalPropertyf("tu154ce/hydro/gs_qty_3")) 
local runTimeDrawTbl = {}
local brakesShowTbl = {}
local liqd_show_tbl = {}
local failDrawTbl = {}
local function readAll()
	for k,v in ipairs(runtime_tbl) do
		runTimeDrawTbl[k] = {v[1], string.format("%.01f", tostring(get(v[2])/3600))}
	end
	for k,v in ipairs(brakes_tbl) do
		brakesShowTbl[k] = {v[1], string.format("%.03f", tostring(get(v[2])))}
	end
	for k,v in ipairs(liqd_tbl) do
		liqd_show_tbl[k] = {v[1], string.format("%.01f", tostring(get(v[2])))}
	end
	failDrawTbl = {} 
	for k,v in pairs(customFails) do 
		if get(v) > 0 then
			table.insert(failDrawTbl, k)
		end
	end
	for k,v in pairs(simFails) do 
		if get(v) == 6 then
			table.insert(failDrawTbl, k)
		end
	end
	table.sort(failDrawTbl)
end
local function fixAll()
	for k,v in pairs(customFails) do 
		set(v, 0)
	end
	for k,v in pairs(simFails) do 
		set(v, 0)
	end
	set(hydro_tbl[1][2], 58)
	set(hydro_tbl[2][2], 58)
	set(hydro_tbl[3][2], 45)
	set(save_state, 1)
	return true
end
local lag_time = 0
function update()
	local passed = get(frame_time)
	lag_time = lag_time - passed
	if lag_time < 0 then
		readAll()
		lag_time = 1
	end
end
components = {
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img),
	},
	text_draw {
		position = {20, 600, 50, 50},
		text = "
	},
	fail_runtime {
		position = {20, 580, 50, 50},
		drawTable = function() return runTimeDrawTbl end,
		value = "h",
	},
	rectangle {
		position = {290, 550, 170, 30},
		color = {0, 0, 0, 1},
	},
	rectangle {
		position = {290+1, 550+1, 170-2, 30-2},
		color = {0.9, 0.9, 0.9, 1},
	},
	text_draw {
		position = {300, 550+10, 50, 50},
		text = "ENGINE REPAIR",
	},
	clickable {
		position = {290, 550, 170, 30},
		onMouseClick = function()
			set(runtime_tbl[1][2], math.random(280,320) * 3600)
			set(runtime_tbl[2][2], math.random(280,320) * 3600)
			set(runtime_tbl[3][2], math.random(280,320) * 3600)
			set(runtime_tbl[4][2], math.random(280,320) * 3600)
			set(save_state, 1)
		end
	}, 
	text_draw {
		position = {20, 510, 50, 50},
		text = "
	},
	fail_runtime {
		position = {20, 480, 50, 50},
		drawTable = function() return brakesShowTbl end,
		value = "thick",
	},
	rectangle {
		position = {290, 465, 170, 30},
		color = {0, 0, 0, 1},
	},
	rectangle {
		position = {290+1, 465+1, 170-2, 30-2},
		color = {0.9, 0.9, 0.9, 1},
	},
	text_draw {
		position = {300, 465+10, 50, 50},
		text = "REPLACE BRAKES",
	},
	clickable {
		position = {290, 465, 170, 30},
		onMouseClick = function()
			set(brakes_tbl[1][2], 1)
			set(brakes_tbl[2][2], 1)
			set(save_state, 1)
		end
	},	
	text_draw {
		position = {20, 440, 50, 50},
		text = "
	},
	fail_runtime {
		position = {20, 410, 50, 50},
		drawTable = function() return liqd_show_tbl end,
		value = "L",
	},	
	rectangle {
		position = {290, 390, 170, 30},
		color = {0, 0, 0, 1},
	},
	rectangle {
		position = {290+1, 390+1, 170-2, 30-2},
		color = {0.9, 0.9, 0.9, 1},
	},
	text_draw {
		position = {300, 390+10, 50, 50},
		text = "REFILL ENGN OIL",
	},
	clickable {
		position = {290, 390, 170, 30},
		onMouseClick = function()
			set(liqd_tbl[1][2], math.random() + 26)
			set(liqd_tbl[2][2], math.random() + 26)
			set(liqd_tbl[3][2], math.random() + 26)
			set(save_state, 1)			
		end
	},
	text_draw {
		position = {20, 350, 50, 50},
		text = "
	},
	failures_draw {
		position = {20, 320, 50, 50},
		drawTable = function() return failDrawTbl end,
		maxDraw = 32,
	},
	rectangle {
		position = {210, 25, 85, 40},
		color = {0, 0, 0, 1},
	},
	rectangle {
		position = {210+1, 25+1, 85-2, 40-2},
		color = {0.9, 0.9, 0.9, 1},
	},
	text_draw {
		position = {220, 40, 50, 50},
		text = "FIX ALL",
	},
	clickable {
		position = {210, 25, 85, 40},
   		onMouseClick = fixAll,
	}, 
	rectangle {
		position = {290, 420, 170, 30},
		color = {0, 0, 0, 1},
	},
	rectangle {
		position = {290+1, 420+1, 170-2, 30-2},
		color = {1, 1, 1, 1},
	},
	text_draw {
		position = {300, 430, 50, 50},
		text = "REFIL HYDRO",
	},
	clickable {
		position = {290, 420, 170, 30},
		onMouseClick = function()
			set(liqd_tbl[1][2], 58)
			set(liqd_tbl[2][2], 58)
			set(liqd_tbl[3][2], 45)
		end
	}, 
	clickable {
		position = {size[1] - 30, size[2] - 30, 30, 30 },
		onMouseClick = function() 
			set(show_fail_panel, 0)
			return true
		end,
	}, 	
}
