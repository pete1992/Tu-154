size = {1000, 770}
defineProperty("mode_set", globalPropertyi("sim/custom/taws/mode_set")) 
defineProperty("brt_handle", globalPropertyf("sim/custom/rotary/srpbz/brightness")) 
defineProperty("distance_set", globalPropertyi("sim/custom/taws/distance_set")) 
defineProperty("course_fly", globalPropertyf("sim/flightmodel/position/hpath")) 
defineProperty("latitude", globalPropertyf("sim/flightmodel/position/latitude")) 
defineProperty("longitude", globalPropertyf("sim/flightmodel/position/longitude")) 
defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("sim_time", globalPropertyf("sim/time/zulu_time_sec"))  
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("wc_screen_img", loadImage("taws_welcome.png", 0, 0, 1000, 770))
local text_font = loadFont('taws_scr.fnt')
local screen_work = get(mode_set) == 4
local brightness = 0.8
0:01 - старт. желтый экран - 1
0:23 - синий экран и счетчик 015 - 2
0:28 - счетчик замирает на 010 - 2
0:34 - черный экран - 3
0:39 - экран приветствия - 4
0:48 - серый экран и надпись НЕТ РП на черном фоне - 5
1:01 - рабочий режим. масштаб 20км. - 6
local time_counter = 0 
local sequence_phase = 0
local counter_text = "0  0  0"
local last_mode = get(mode_set)
function update()
	local current_mode = get(mode_set)
	screen_work = current_mode == 4
	local passed = get(frame_time)
	time_counter = time_counter + passed
	if not screen_work then 
		brightness = 0 
		time_counter = 0	
	else
		brightness = get(brt_handle)
		if current_mode == 0 then time_counter = 0 end 
		if time_counter < 1 then 
			sequence_phase = 0 
		elseif time_counter >= 1  and time_counter < 23 then
			sequence_phase = 1 
		elseif time_counter < 34 then
			sequence_phase = 2 
		elseif time_counter < 39 then
			sequence_phase = 3 
		elseif time_counter < 48 then
			sequence_phase = 4 
		elseif time_counter < 61 then
			sequence_phase = 5 
		elseif time_counter >= 61 and time_counter < 62 then
			sequence_phase = 6 
			set(mode_set, 1)
			set(distance_set, 1)
		end
		local count = math.floor(math.max(0, 5 - (time_counter - 24)))
		counter_text = "0  1  "..count
	end
	last_mode = current_mode
end
components = {
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0.1, 0.1, 0.1, 1},
		visible = function()
			return screen_work
		end,
	},
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {1, 1, 0.5, 1},
		visible = function()
			return screen_work and sequence_phase == 1
		end,
	},	
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0.2, 0.5, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	rectangle {
		position = {380, 400, 330, 200},
		color = {1, 1, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},
	rectangle {
		position = {385, 405, 320, 190},
		color = {0.2, 0.5, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	rectangle {
		position = {390, 410, 100, 180},
		color = {1, 1, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	rectangle {
		position = {395, 415, 90, 170},
		color = {0.2, 0.5, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},		
	rectangle {
		position = {495, 410, 100, 180},
		color = {1, 1, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	rectangle {
		position = {500, 415, 90, 170},
		color = {0.2, 0.5, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	rectangle {
		position = {600, 410, 100, 180},
		color = {1, 1, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	rectangle {
		position = {605, 415, 90, 170},
		color = {0.2, 0.5, 1, 1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},	
	text_draw {
		position = {413, 480, 220, 150},
		text = function()
			return counter_text
		end,
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work and sequence_phase == 2
		end,
	},
	textureLit {
		position = {0, 0, size[1], size[2]},
		image = get(wc_screen_img),
		visible = function()
			return screen_work and sequence_phase == 4
		end,
	},
	rectangle {
		position = {0, 0, size[1], size[2]},
		color = {0.7, 0.7, 0.6, 1},
		visible = function()
			return screen_work and sequence_phase == 5
		end,
	},	
	rectangle {
		position = {330, 335, 340, 80},
		color = {0.1, 0.1, 0.1, 1},
		visible = function()
			return screen_work and sequence_phase == 5
		end,
	},	
	text_draw {
		position = {360, 350, 185, 160},
		text = function()
			return "НЕТ РП"
		end,
		font = text_font,
		color = {1,0.8,0,1},
		visible = function()
			return screen_work and sequence_phase == 5
		end,
	},	
	rectangle_ctr {
		R = 0,
		G = 0,
		B = 0,
		A = function()
			return 1 - brightness
		end, 
		position_x = 0,
		position_y = 0,
		width = size[1],
		height = size[2],
		visible = function()
			return screen_work
		end,
	},
}