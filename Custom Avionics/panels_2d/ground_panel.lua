--ground panel.lua
size = {655, 880}

-- Helper to define multiple datarefs at once
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
	{"save_state", "sim/custom/save_state", globalPropertyi},
	{"frame_time", "sim/custom/time/frame_time", globalPropertyf},
	{"show_ground_panel", "sim/custom/panels/show_ground_panel", globalPropertyi},
	{"reset_crew", "sim/custom/sound/reset_crew", globalPropertyi},
	{"failures_enabled", "sim/custom/failures/failures_enabled", globalPropertyi},
	{"have_pedals", "sim/custom/have_pedals", globalPropertyi},
	{"reset_state", "sim/custom/reset_state", globalPropertyi},
	{"hide_rus_objects", "sim/custom/lang/hide_rus_objects", globalPropertyi},
	{"hide_eng_objects", "sim/custom/lang/hide_eng_objects", globalPropertyi},
	{"sounds_volume", "sim/custom/sounds_volume", globalPropertyi},
	{"slider_1", "sim/cockpit2/switches/custom_slider_on[0]", globalPropertyi},
	{"slider_2", "sim/cockpit2/switches/custom_slider_on[1]", globalPropertyi},
	{"slider_3", "sim/cockpit2/switches/custom_slider_on[2]", globalPropertyi},
	{"slider_4", "sim/cockpit2/switches/custom_slider_on[3]", globalPropertyi},
	{"slider_5", "sim/cockpit2/switches/custom_slider_on[4]", globalPropertyi},
	{"slider_6", "sim/cockpit2/switches/custom_slider_on[5]", globalPropertyi},
	{"slider_7", "sim/cockpit2/switches/custom_slider_on[6]", globalPropertyi},
	{"slider_8", "sim/cockpit2/switches/custom_slider_on[7]", globalPropertyi},
	{"slider_9", "sim/cockpit2/switches/custom_slider_on[8]", globalPropertyi},
	{"slider_10", "sim/cockpit2/switches/custom_slider_on[9]", globalPropertyi},
	{"slider_11", "sim/cockpit2/switches/custom_slider_on[10]", globalPropertyi},
	{"slider_12", "sim/cockpit2/switches/custom_slider_on[11]", globalPropertyi},
	{"gear_blocks", "sim/custom/anim/gear_blocks", globalPropertyi},
	{"sensors_caps", "sim/custom/anim/sensors_caps", globalPropertyi},
	{"engine_caps", "sim/custom/anim/engine_caps", globalPropertyi},
	{"gpu_present", "sim/custom/anim/gpu_present", globalPropertyi},
	{"ladder_1_call", "sim/custom/anim/ladder_1_call", globalPropertyi},
	{"ladder_2_call", "sim/custom/anim/ladder_2_call", globalPropertyi},
	{"catering_call", "sim/custom/anim/catering_call", globalPropertyi},
	{"fuel_tanker_call", "sim/custom/anim/fuel_tanker_call", globalPropertyi},
	{"ladder_1", "sim/custom/anim/ladder_1", globalPropertyf},
	{"ladder_2", "sim/custom/anim/ladder_2", globalPropertyf},
	{"catering", "sim/custom/anim/catering", globalPropertyf},
	{"fuel_tanker", "sim/custom/anim/fuel_tanker", globalPropertyf},
	{"ground_speed", "sim/flightmodel/position/groundspeed", globalPropertyf},
	{"eng_rpm1", "sim/flightmodel/engine/ENGN_N2_[0]", globalPropertyf},
	{"eng_rpm2", "sim/flightmodel/engine/ENGN_N2_[1]", globalPropertyf},
	{"eng_rpm3", "sim/flightmodel/engine/ENGN_N2_[2]", globalPropertyf},
	{"zone_1_pr", "sim/custom/payload/zone_1", globalPropertyi},
	{"zone_2_pr", "sim/custom/payload/zone_2", globalPropertyi},
	{"zone_4_pr", "sim/custom/payload/zone_4", globalPropertyi},
	{"zone_5_pr", "sim/custom/payload/zone_5", globalPropertyi},
	{"zone_6_pr", "sim/custom/payload/zone_6", globalPropertyi},
	{"cargo_1_pr", "sim/custom/payload/cargo_1", globalPropertyi},
	{"cargo_2_pr", "sim/custom/payload/cargo_2", globalPropertyi},
	{"kitchens_pr", "sim/custom/payload/kitchens", globalPropertyi},
	{"static_fail_L", "sim/operation/failures/rel_static", globalPropertyi},
	{"static_fail_R", "sim/operation/failures/rel_static2", globalPropertyi},
	{"rel_pitot", "sim/operation/failures/rel_pitot", globalPropertyi},
	{"rel_pitot2", "sim/operation/failures/rel_pitot2", globalPropertyi},
	{"alpha_fail", "sim/operation/failures/rel_AOA", globalPropertyi},
	{"deflection_mtr_1", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]", globalPropertyf},
	{"deflection_mtr_2", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalPropertyf},
	{"deflection_mtr_3", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalPropertyf},
	{"enable_crew_vo", "sim/custom/sounds/enable_crew_vo", globalPropertyi},
	{"show_fail_panel", "sim/custom/panels/show_fail_panel", globalPropertyi},
	{"show_gns", "sim/custom/anim/show_gns", globalPropertyi},
	{"show_RXP", "sim/custom/anim/RXP", globalPropertyi},
	{"starter_torq", "sim/aircraft/engine/acf_starter_torque_ratio", globalPropertyf},
	{"pitot_fail1", "sim/custom/failures/pitot1", globalPropertyi},
	{"pitot_fail2", "sim/custom/failures/pitot2", globalPropertyi},
	{"static_fail_L", "sim/custom/failures/static1", globalPropertyi},
	{"static_fail_R", "sim/custom/failures/static2", globalPropertyi},
	{"uap_fail", "sim/custom/failures/AOA", globalPropertyi},
})

local text_font = loadFont('basic_font.fnt')
defineProperty("bg_img", loadImage("ground_tex.png")) 
defineProperty("bg_img_rus", loadImage("ground_tex_RUS.png")) 
defineProperty("green_lamp", loadImage("overhead_tex.png", 1825, 299, 19, 19))
defineProperty("yellow_lamp", loadImage("overhead_tex.png", 1825, 333, 19, 19))
defineProperty("lev_img", loadImage("absu_ess.png", 432, 160, 30, 29))
yokes_cmd = findCommand("sim/operation/toggle_yoke")



function yokes_hnd(phase)
	if 0 == phase then
		set(slider_9, 1 - get(slider_9))
	end
	return 0
end
registerCommandHandler(yokes_cmd, 0, yokes_hnd)


local ladder_1_pos = get(ladder_1)
local ladder_2_pos = get(ladder_2)
local catering_pos = get(catering)
local fuel_tanker_pos = get(fuel_tanker)
local notLoaded = true
local failPanelShow = false
local reset_click = false


local function coldDarkReset()
	if get(eng_rpm1) < 10 and get(eng_rpm2) < 10 and get(eng_rpm3) < 10 then
		set(gear_blocks, 1)
		set(sensors_caps, 1)
		set(engine_caps, 1)
		set(zone_1_pr, 0)
		set(zone_2_pr, 0)
		set(zone_4_pr, 0)
		set(zone_5_pr, 0)
		set(zone_6_pr, 0)
		set(cargo_1_pr, 0)
		set(cargo_2_pr, 0)
		set(kitchens_pr, 20)
	end
	notLoaded = false
	return true
end
local load_counter = 0
function update()
	local passed = get(frame_time)
	load_counter = load_counter + passed
	if notLoaded and load_counter > 3 then
		coldDarkReset()
	end
	setMasterGain(get(sounds_volume))
	ladder_1_pos = get(ladder_1)
	ladder_2_pos = get(ladder_2)
	catering_pos = get(catering)
	fuel_tanker_pos = get(fuel_tanker)	
	if get(ladder_1_call) == 1 then 
		if ladder_1_pos == 500 then 
			ladder_1_pos = -50
		elseif ladder_1_pos >= -50 and ladder_1_pos < 0 then 
			ladder_1_pos = ladder_1_pos + passed * 2.7
			if ladder_1_pos > 0 then ladder_1_pos = 0 end
		elseif ladder_1_pos > 0 then 
			ladder_1_pos = ladder_1_pos - passed * 2.7
			if ladder_1_pos < 0 then ladder_1_pos = 0 end
		end
	else 
		if ladder_1_pos < 0 and ladder_1_pos > -50 then 
			ladder_1_pos = ladder_1_pos - passed * 2.7
			if ladder_1_pos < -50 then ladder_1_pos = -50 end
		elseif ladder_1_pos >= 0 and ladder_1_pos < 50 then 
			ladder_1_pos = ladder_1_pos + passed * 2.7
			if ladder_1_pos > 50 then ladder_1_pos = 50 end
		end
	end
	if get(ladder_2_call) == 1 then 
		if ladder_2_pos == 500 then 
			ladder_2_pos = -50
		elseif ladder_2_pos >= -50 and ladder_2_pos < 0 then 
			ladder_2_pos = ladder_2_pos + passed * 2.7
			if ladder_2_pos > 0 then ladder_2_pos = 0 end
		elseif ladder_2_pos > 0 then 
			ladder_2_pos = ladder_2_pos - passed * 2.7
			if ladder_2_pos < 0 then ladder_2_pos = 0 end
		end
	else 
		if ladder_2_pos < 0 and ladder_2_pos > -50 then 
			ladder_2_pos = ladder_2_pos - passed * 2.7
			if ladder_2_pos < -50 then ladder_2_pos = -50 end
		elseif ladder_2_pos >= 0 and ladder_2_pos < 50 then 
			ladder_2_pos = ladder_2_pos + passed * 2.7
			if ladder_2_pos > 50 then ladder_2_pos = 50 end
		end
	end
	if get(catering_call) == 1 then 
		if catering_pos == 500 then 
			catering_pos = -50
		elseif catering_pos >= -50 and catering_pos < 0 then 
			catering_pos = catering_pos + passed * 2.7
			if catering_pos > 0 then catering_pos = 0 end
		elseif catering_pos > 0 then 
			catering_pos = catering_pos - passed * 2.7
			if catering_pos < 0 then catering_pos = 0 end
		end
	else 
		if catering_pos < 0 and catering_pos > -50 then 
			catering_pos = catering_pos - passed * 2.7
			if catering_pos < -50 then catering_pos = -50 end
		elseif catering_pos >= 0 and catering_pos < 50 then 
			catering_pos = catering_pos + passed * 2.7
			if catering_pos > 50 then catering_pos = 50 end
		end
	end
	if get(fuel_tanker_call) == 1 then 
		if fuel_tanker_pos == 500 then 
			fuel_tanker_pos = -50
		elseif fuel_tanker_pos >= -50 and fuel_tanker_pos < 0 then 
			fuel_tanker_pos = fuel_tanker_pos + passed * 2.7
			if fuel_tanker_pos > 0 then fuel_tanker_pos = 0 end
		elseif fuel_tanker_pos > 0 then 
			fuel_tanker_pos = fuel_tanker_pos - passed * 2.7
			if fuel_tanker_pos < 0 then fuel_tanker_pos = 0 end
		end
	else 
		if fuel_tanker_pos < 0 and fuel_tanker_pos > -50 then 
			fuel_tanker_pos = fuel_tanker_pos - passed * 2.7
			if fuel_tanker_pos < -50 then fuel_tanker_pos = -50 end
		elseif fuel_tanker_pos >= 0 and fuel_tanker_pos < 50 then 
			fuel_tanker_pos = fuel_tanker_pos + passed * 2.7
			if fuel_tanker_pos > 50 then fuel_tanker_pos = 50 end
		end
	end
	if math.abs(get(GS)) > 1 or get(gear_blocks) < 1 or get(deflection_mtr_1) < 0.001 or get(deflection_mtr_2) < 0.001 or get(deflection_mtr_3) < 0.001 then 
		ladder_1_pos = 500
		ladder_2_pos = 500
		catering_pos = 500
		fuel_tanker_pos = 500
		set(ladder_1_call, 0)
		set(ladder_2_call, 0)
		set(catering_call, 0)
		set(fuel_tanker_call, 0)
	end
	if math.abs(get(GS)) > 2 or get(deflection_mtr_1) < 0.001 or get(deflection_mtr_2) < 0.001 or get(deflection_mtr_3) < 0.001 then 
		set(gear_blocks, 0)
	end	
	set(ladder_1, ladder_1_pos)
	set(ladder_2, ladder_2_pos)
	set(catering, catering_pos)
	set(fuel_tanker, fuel_tanker_pos)
	if get(sensors_caps) == 1 then
		set(static_fail_L, 6)
		set(static_fail_R, 6)
		set(rel_pitot, 6)
		set(rel_pitot2, 6)
		set(alpha_fail, 6)
	else 
		set(static_fail_L, get(static_fail_L) * 6)
		set(static_fail_R, get(static_fail_R) * 6)
		set(rel_pitot, get(pitot_fail1) * 6)
		set(rel_pitot2, get(pitot_fail2) * 6)
		set(alpha_fail, get(uap_fail) * 6)
	end
	if math.abs(get(GS)) > 1 or get(deflection_mtr_1) < 0.001 or get(deflection_mtr_2) < 0.001 or get(deflection_mtr_3) < 0.001 then 
		failPanelShow = false
		set(show_fail_panel, 0)
	else
		failPanelShow = true
	end
end


components = {
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img),
		visible = function()
			return get(hide_eng_objects) == 0
		end,
	},
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(bg_img_rus),
		visible = function()
			return get(hide_eng_objects) == 1
		end,
	},
	textureLit {
		position = {232, 787, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_1) == 0
		end,
	},
	textureLit {
		position = {232, 744, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_5) == 0
		end,
	},	
	textureLit {
		position = {232, 658, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(sensors_caps) == 0
		end,
	},	
	textureLit {
		position = {232, 613, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_6) == 0
		end,
	},	
	textureLit {
		position = {232, 392, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(gear_blocks) == 0
		end,
	},	
	textureLit {
		position = {232, 333, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(engine_caps) == 0
		end,
	},	
	textureLit {
		position = {396, 788, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_2) == 0
		end,
	},	
	textureLit {
		position = {396, 720, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(gpu_present) == 0
		end,
	},		
	textureLit {
		position = {396, 720, 22,22},
		image = get(yellow_lamp),
		visible = function()
			return get(gpu_present) == 1
		end,
	},
	textureLit {
		position = {396, 665, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_3) == 0
		end,
	},
	textureLit {
		position = {396, 619, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_7) == 0
		end,
	},
	textureLit {
		position = {396, 392, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(slider_4) == 0
		end,
	},
	textureLit {
		position = {232, 702, 22,22},
		image = get(yellow_lamp),
		visible = function()
			return get(ladder_1_call) == 1
		end,
	},
	textureLit {
		position = {232, 702, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(ladder_1_call) == 0
		end,
	},
	textureLit {
		position = {232, 571, 22,22},
		image = get(yellow_lamp),
		visible = function()
			return get(ladder_2_call) == 1
		end,
	},
	textureLit {
		position = {232, 571, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(ladder_2_call) == 0
		end,
	},
	textureLit {
		position = {396, 576, 22,22},
		image = get(yellow_lamp),
		visible = function()
			return get(catering_call) == 1
		end,
	},
	textureLit {
		position = {396, 576, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(catering_call) == 0
		end,
	},
	textureLit {
		position = {396, 531, 22,22},
		image = get(yellow_lamp),
		visible = function()
			return get(fuel_tanker_call) == 1
		end,
	},
	textureLit {
		position = {396, 531, 22,22},
		image = get(green_lamp),
		visible = function()
			return get(fuel_tanker_call) == 0
		end,
	},
	clickable {
		position = {6, 824, 275, 45},
		onMouseDown = function() 
			set(hide_rus_objects, 1 - get(hide_rus_objects))
			set(hide_eng_objects, 1 - get(hide_rus_objects))
			set(save_state, 1)
			return true
		end,
	},		
	clickable {
		position = {366, 824, 275, 45},
		onMouseDown = function() 
			set(slider_9, 1 - get(slider_9))
			return true
		end,
	},		
	clickable {
		position = {23, 782, 200, 35},
		onMouseDown = function() 
			set(slider_1, 1 - get(slider_1))
			return true
		end,
	},		
	clickable {
		position = {23, 737, 200, 35},
		onMouseDown = function() 
			set(slider_5, 1 - get(slider_5))
			return true
		end,
	},	
	clickable {
		position = {23, 650, 200, 35},
		onMouseDown = function() 
			if get(GS) <= 0.1 then set(sensors_caps, 1 - get(sensors_caps)) end
			return true
		end,
	},	
	clickable {
		position = {23, 607, 200, 35},
		onMouseDown = function() 
			set(slider_6, 1 - get(slider_6))
			return true
		end,
	},		
	clickable {
		position = {23, 385, 200, 35},
		onMouseDown = function() 
			if get(gear_blocks) ~= 1 and get(GS) < 0.1 then set(gear_blocks, 1) else set(gear_blocks, 0) end
			return true
		end,
	},
	clickable {
		position = {23, 325, 200, 35},
		onMouseDown = function() 
			set(engine_caps, 1 - get(engine_caps))
			if get(eng_rpm1) > 5 or get(eng_rpm2) > 5 or get(eng_rpm3) > 5 then set(engine_caps, 0) end
			return true
		end,
	},
	clickable {
		position = {424, 782, 200, 35},
		onMouseDown = function() 
			set(slider_2, 1 - get(slider_2))
			return true
		end,
	},
	clickable {
		position = {424, 715, 200, 35},
		onMouseDown = function() 
			set(gpu_present, 1 - get(gpu_present))
			return true
		end,
	},
	clickable {
		position = {424, 660, 200, 35},
		onMouseDown = function() 
			set(slider_3, 1 - get(slider_3))
			return true
		end,
	},
	clickable {
		position = {424, 613, 200, 35},
		onMouseDown = function() 
			set(slider_7, 1 - get(slider_7))
			return true
		end,
	},
	clickable {
		position = {424, 386, 200, 35},
		onMouseDown = function() 
			set(slider_4, 1 - get(slider_4))
			return true
		end,
	},
	clickable {
		position = {23, 695, 200, 35},
		onMouseDown = function() 
			set(ladder_1_call, 1 - get(ladder_1_call))
			return true
		end,
	},		
	clickable {
		position = {23, 565, 200, 35},
		onMouseDown = function() 
			set(ladder_2_call, 1 - get(ladder_2_call))
			return true
		end,
	},	
	clickable {
		position = {424, 570, 200, 35},
		onMouseDown = function() 
			set(catering_call, 1 - get(catering_call))
			return true
		end,
	},	
	clickable {
		position = {424, 526, 200, 35},
		onMouseDown = function() 
			set(fuel_tanker_call, 1 - get(fuel_tanker_call))
			return true
		end,
	},	
	clickable {
		position = {424, 230, 200, 35},
		onMouseDown = function() 
			if failPanelShow then 
				set(show_fail_panel, 1 - get(show_fail_panel))
			else
				set(show_fail_panel, 0)
			end
			return true
		end,
	},
	clickable {
		position = {23, 230, 200, 35},
		onMouseClick = function() 
			if reset_click then
				set(reset_crew, 0)
			end
			if not reset_click then 
				set(reset_crew, 1)
				reset_click = true
			end
			return true
		end,
		onMouseUp = function()
			reset_click = false
			set(reset_crew, 0)
			return true
		end,
	},
	lever_hor{
       position = { 456, 125, 139, 29},
       value = sounds_volume,
       lever_img = get(lev_img),
       minimum = 0,
       maximum = 1000,
	   addFunc = function() set(save_state, 1) return true end,
   },	
	clickable {
		position = {426, 125, 30, 29},
		onMouseClick = function() 
			local a = get(sounds_volume) - 100
			if a < 0 then a = 0 end
			set(sounds_volume, a)
			set(save_state, 1)
			return true
		end,
	},
	clickable {
		position = {595, 125, 30, 29},
		onMouseClick = function() 
			local a = get(sounds_volume) + 100
			if a > 1000 then a = 1000 end
			set(sounds_volume, a)
			set(save_state, 1)
			return true
		end,
	},	
	text_draw {
		position = {32, 200, 55, 60},
		text = function()
			if get(enable_crew_vo) == 1 then return "CREW VO ENABLED"
			else return	"CREW VO DISABLED" end
		end,
		font = text_font,
		color = {0,0,0,1},
		visible = true,
	},
	clickable {
		position = {23, 190, 200, 35},
		onMouseDown = function() 
			set(enable_crew_vo, 1 - get(enable_crew_vo))
			set(save_state, 1)
			return true
		end,
	},
	text_draw {
		position = {32, 158, 55, 60},
		text = function()
			if get(failures_enabled) == 0 then return "FAILURES OFF"
			elseif get(failures_enabled) == 1 then return "FAILURES LOW"
			elseif get(failures_enabled) == 2 then return "FAILURES MEDIUM"
			elseif get(failures_enabled) == 3 then return "FAILURES HIGH"
			end
		end,
		font = text_font,
		color = {0,0,0,1},
		visible = true,
	},
	clickable {
		position = {23, 148, 200, 35},
		onMouseDown = function() 
			local a = get(failures_enabled) + 1
			if a > 3 then a = 0 end
			set(failures_enabled, a)
			set(save_state, 1)			
			return true
		end,
	},
	text_draw {
		position = {32, 78, 55, 60},
		text = "NW uses YAW",
		font = text_font,
		color = {0,0,0,1},
		visible = function()
			return get(have_pedals) == 0
		end,
	},
	text_draw {
		position = {32, 78, 55, 60},
		text = "NW uses Tiller",
		font = text_font,
		color = {0,0,0,1},
		visible = function()
			return get(have_pedals) == 1
		end,
	},
	text_draw {
		position = {32, 50, 55, 60},
		text = "WARNING, HOLD FOR 5 SEC",
		font = text_font,
		color = {0,0,0,1},
		visible = true,
	},
	text_draw {
		position = {32, 30, 55, 60},
		text = "TO RESET ALL JOYSTICKS",
		font = text_font,
		color = {0,0,0,1},
		visible = true,
	},
	clickable {
		position = {23, 70, 200, 35},
		onMouseDown = function() 
			set(have_pedals, 1-get(have_pedals))
			set(save_state, 1)
			return true
		end,
		onMouseUp = function() 
			return true
		end,
	},	
	text_draw {
		position = {32, 120, 55, 60},
		text = function()
			if get(show_gns) == 1 and get(show_RXP) == 0 
			then return "GNS430 INSTALLED"
				elseif get(show_gns) == 1 and get(show_RXP) == 1 
					then return "RXP INSTALLED"
						else return	"KLN90 INSTALLED" end
			end,
		font = text_font,
		color = {0,0,0,1},
		visible = true,
	},
	clickable {
		position = {23, 110, 200, 35},
		onMouseDown = function() 
			local a = get(show_gns) + get(show_RXP) + 1
			if a > 2 then a = 0 end
			if a == 0 then 
				set(show_gns, 0)
				set(show_RXP, 0)
			elseif a == 1 then
				set(show_gns, 1)
				set(show_RXP, 0)
			elseif a == 2 then
				set(show_gns, 1)
				set(show_RXP, 1)
			end
			set(save_state, 1)
			return true
		end,
	},	
	text_draw {
		position = {507, 52, 55, 60},
		text = function()
			return math.floor(get(starter_torq) *100 + 0.5) / 100
		end,
		font = text_font,
		color = {0,0,0,1},
		visible = true,
	},
	clickable {
		position = {426, 47, 30, 29},
		onMouseClick = function() 
			local a = get(starter_torq) - 0.01
			if a < 0.1 then a = 0.1 end
			set(starter_torq, a)
			set(save_state, 1)
			return true
		end,
	},
	clickable {
		position = {595, 47, 30, 29},
		onMouseClick = function() 
			local a = get(starter_torq) + 0.01
			if a > 1 then a = 1 end
			set(starter_torq, a)
			set(save_state, 1)
			return true
		end,
	},	
	clickable {
		position = {476, 12, 100, 29},
		onMouseClick = function() 
			set(starter_torq, 0.2)
			set(save_state, 1)
			return true
		end,
	},	
	clickable {
		position = {size[1] - 15, size[2] - 15, 15, 15 },
		onMouseClick = function() 
			set(show_ground_panel, 0)
			return true
		end,
	}, 
}
