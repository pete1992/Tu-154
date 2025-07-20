size = {2048, 2048}
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("deg1", globalPropertyf("sim/flightmodel/position/psi")) 
defineProperty("deg2", globalPropertyf("sim/flightmodel/position/hpath")) 
defineProperty("rls_on", globalPropertyi("tu154ce/switchers/console/rls_on")) 
defineProperty("rls_mode", globalPropertyi("tu154ce/switchers/console/rls_mode")) 
defineProperty("rls_distance", globalPropertyi("tu154ce/switchers/console/rls_distance")) 
defineProperty("rls_brt", globalPropertyf("tu154ce/switchers/console/rls_brt")) 
defineProperty("rls_contr", globalPropertyf("tu154ce/switchers/console/rls_contr")) 
defineProperty("rls_signs", globalPropertyf("tu154ce/switchers/console/rls_signs")) 
defineProperty("rls_ready", globalPropertyf("tu154ce/lights/small/rls_ready")) 
defineProperty("rls_weather", globalPropertyf("tu154ce/lights/small/rls_weather")) 
tu154ce/switchers/console/rls_on
tu154ce/switchers/console/rls_mode
tu154ce/switchers/console/rls_distance
defineProperty("rls_power_sw", globalPropertyi("tu154ce/xap/An24_rls/rls_power_sw")) 
defineProperty("rls_power_cc", globalPropertyf("tu154ce/xap/An24_rls/rls_power_cc")) 
defineProperty("rls_scan_spd", globalPropertyi("tu154ce/xap/An24_rls/rls_scan_spd")) 
defineProperty("rls_mode", globalPropertyi("tu154ce/xap/An24_rls/rls_mode")) 
defineProperty("rls_mode_lamp", globalPropertyi("tu154ce/xap/An24_rls/rls_mode_lamp")) 
defineProperty("rls_bright", globalPropertyf("tu154ce/xap/An24_rls/rls_bright")) 
defineProperty("rls_contr", globalPropertyf("tu154ce/xap/An24_rls/rls_contr")) 
defineProperty("rls_signs", globalPropertyf("tu154ce/xap/An24_rls/rls_signs")) 
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("bus36_volt_pts250_1", globalPropertyf("tu154ce/elec/bus36_volt_pts250_1"))
defineProperty("bus115_3_volt", globalPropertyf("tu154ce/elec/bus115_3_volt"))
defineProperty("radar_cc", globalPropertyf("tu154ce/radio/radar_cc")) потребление тока от РЛС Гроза
defineProperty("map_mode", globalPropertyi("sim/cockpit2/EFIS/map_mode"))
defineProperty("map_mode_is_HSI", globalPropertyi("sim/cockpit2/EFIS/map_mode_is_HSI"))
defineProperty("map_range", globalPropertyi("sim/cockpit/switches/EFIS_map_range_selector"))
defineProperty("EFIS_weather_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_weather_on"))
defineProperty("EFIS_tcas_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_tcas_on"))
defineProperty("EFIS_airport_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_airport_on"))
defineProperty("EFIS_vor_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_vor_on"))
defineProperty("EFIS_ndb_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_ndb_on"))
defineProperty("EFIS_weather_alpha", globalPropertyi("sim/cockpit/switches/EFIS_weather_alpha"))
defineProperty("EFIS_fix_on", globalPropertyi("sim/cockpit2/EFIS/EFIS_fix_on"))
defineProperty("EFIS_page", globalPropertyi("sim/cockpit2/EFIS/EFIS_page"))
defineProperty("EFIS_fail", globalPropertyi("sim/operation/failures/rel_efis_2"))
defineProperty("mask1", loadImage("radar_mask1.png", 0, 0, 256, 256))
defineProperty("mask2", loadImage("radar_mask2.png", 0, 0, 256, 256))
defineProperty("scale", loadImage("radar_scale.png", 0, 0, 512, 345))
defineProperty("needle_1", loadImage("radar_scale.png", 0, 190, 256, 4))
defineProperty("needle_2", loadImage("radar_scale.png", 0, 200, 256, 4))
defineProperty("needle_3", loadImage("radar_scale.png", 0, 210, 256, 4))
defineProperty("scale_1", loadImage("radar_scale_marks.png", 0, 0, 130, 80))
defineProperty("scale_3", loadImage("radar_scale_marks.png", 144, 0, 250, 156))
defineProperty("scale_4", loadImage("radar_scale_marks.png", 0, 310, 250, 156))
defineProperty("scale_5", loadImage("radar_scale_marks.png", 0, 154, 250, 156))
defineProperty("scale_6", loadImage("radar_scale_marks.png", 251, 154, 250, 156))
defineProperty("eng1_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[0]")) 
defineProperty("eng2_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[1]")) 
defineProperty("eng3_N1", globalPropertyf("sim/flightmodel/engine/ENGN_N1_[2]")) 
defineProperty("radar_fail", globalPropertyi("tu154ce/failures/radar_fail")) 
local notLoaded = true
local start_timer = 0
local function sw_reset()
	if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
		set(rls_on, 0)
		set(rls_distance, 4)
	end
	notLoaded = false
end
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')
local rotary_sound = loadSample('Custom Sounds/plastic_switch.wav')
local rotary_sound_pl = loadSample('Custom Sounds/rot_click.wav')
local mask_angle = -10  
local rot_spd = 70  
local slip_angle = 0
local needle_show = 1
local mode = 0
local first_mask = true  
local power_counter = 0
local power = false
local brightness = 1
local sign_brt = 1
local contrast = 1
local range = get(map_range)
local power_sw_last = 0
local mode_sw_last = 0
local range_last = 2
local power_el = false
function update()
	local passed = get(frame_time)
	start_timer = start_timer + passed
	if notLoaded and start_timer > 0.3 then
		sw_reset()
	end
	local power_switch = get(rls_on)
	if power_switch ~= power_sw_last then playSample(button_sound, 0) end
	power_sw_last = power_switch
	mode = get(rls_mode)
	if mode ~= mode_sw_last then playSample(rotary_sound, 0) end
	mode_sw_last = mode
	range = get(map_range)
	if range ~= range_last then playSample(rotary_sound_pl, 0) end
	range_last = range
	set(map_mode, 1)
	set(map_mode_is_HSI, 0)
	set(EFIS_page, 0)
	set(EFIS_weather_on, 1)
	set(EFIS_tcas_on, 0)
	set(EFIS_airport_on, 0)
	set(EFIS_vor_on, 0)
	set(EFIS_ndb_on, 0)
	set(EFIS_fix_on, 0)
	set(map_range, get(rls_distance))
	local current = 0  
	power_el = get(bus27_volt_right) > 13 and (get(bus36_volt_pts250_1) > 30 or get(bus115_3_volt) > 110) and get(radar_fail) == 0
	if power_switch == 1 and mode == 0 and power_el then 
		power_counter = power_counter + passed * 10
		current = 1
	elseif power_switch == 0 and power_counter > 180 and power_el then 
		power_counter = 160 
		current = 0
	elseif (power_switch == 0 or not power_el) and power_counter <= 160 and power_counter > 0 then 
		power_counter = power_counter - passed
	end
	if not power_el then 
		power_counter = 0 
		current = 0
	end
	power = power_counter > 180
	if power and mode == 1 then 
		current = current + 1
		mask_angle = mask_angle + passed * rot_spd
		if mask_angle > 245 then
			mask_angle = -25
			first_mask = not first_mask
		end
	else
		mask_angle = -25
		first_mask = false
		current = current + 3
		slip_angle = get(deg2) - get(deg1)
		needle_show = math.random(1, 3)
	end
	if power then brightness = get(rls_brt) else brightness = 0 end
	contrast = get(rls_contr)
	sign_brt = get(rls_signs)
	if power then 
		set(rls_ready, bool2int(mode == 0)) 
		set(rls_weather, bool2int(mode == 1))
	else 
		set(rls_ready, 0) 
		set(rls_weather, 0)
	end
	current = current + brightness * 0.5 + sign_brt * 0.5
	set(EFIS_weather_alpha, 1)
	 очищаем штатную фмс. GPS на самолете не предусмотрен
	if countFMSEntries() > 0 then 
		for i = 1, countFMSEntries() do 
			clearFMSEntry(i) 
		end 
	end
	set(radar_cc, bool2int(power_el) * 0.2 + bool2int(power) * 0.1 + bool2int(mode > 0) * 0.7)
end
components = {
	rectangle_ctr {
		position = {69, 1534, 484, 345},
		R = 0,
		G = 0,
		B = 0,
		A = function()
			return 1 - sign_brt + rot_spd / 200
		end,
	},
	textureLit {
		position = {52, 1523, 510, 330},
		image = get(scale_3),
		visible = function()
			return range == 3
		end,
	},
	textureLit {
		position = {62, 1527, 500, 320},
		image = get(scale_4),
		visible = function()
			return range == 4
		end,
	},
	textureLit {
		position = {62, 1527, 500, 320},
		image = get(scale_5),
		visible = function()
			return range == 5
		end,
	},
	textureLit {
		position = {48, 1523, 510, 330},
		image = get(scale_6),
		visible = function()
			return range == 6
		end,
	},
	needleLit {
		position = {32, 1320, 560, 560},
		image = get(mask1),
		angle = function()
			return -mask_angle + 90
		end,
		visible = function()
			return first_mask
		end
	},
	needleLit {
		position = {32, 1320, 560, 560},
		image = get(mask2),
		angle = function()
			return mask_angle - 90
		end,
		visible = function()
			return not first_mask
		end
	},
	rectangle {
		position = {69, 1534, 484, 345},
		color = {0,0,0,1},
		visible = function()
			return mode ~= 1 or not power_el
		end
	},
	needleLit {
		position = {-10, -10, 276, 276},
		image = function()
			local a
			if needle_show == 1 then a = get(needle_1)
			elseif needle_show == 2 then a = get(needle_2)
			else a = get(needle_3) end
			return a
		end,
		angle = function()
			return slip_angle - 90
		end,
		visible = function()
			return mode == 2
		end,
	},	
	rectangle_ctr {
		position = {69, 1532, 485, 347},
		R = 0,
		G = 0.2,
		B = 0,
		A = function()
			return math.max((0.5 + brightness/2 - contrast * 2) / 2, 0.1 * bool2int(power))
		end,
	},
	textureLit {
		position = {69, 1532, 485, 347},
		image = get(scale),
		visible = function()
			return power
		end
	},
	rectangle_ctr {
		position = {69, 1532, 485, 347},
		R = 0,
		G = 0,
		B = 0,
		A = function()
			return 1 - brightness
		end
	}, 
	texture {
		position = {69, 1532, 485, 347},
		image = get(scale),
	},
}
