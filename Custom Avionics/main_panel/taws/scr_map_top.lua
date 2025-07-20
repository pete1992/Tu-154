size = {1000, 770}
defineProperty("mode_set", globalPropertyi("tu154ce/taws/mode_set")) 
defineProperty("distance_set", globalPropertyi("tu154ce/taws/distance_set")) 
defineProperty("brt_handle", globalPropertyf("tu154ce/rotary/srpbz/brightness")) 
defineProperty("scale_top_img", loadImage("taws_scale_1.png", 0, 0, 1000, 770))
defineProperty("pos_x", globalPropertyf("sim/flightmodel/position/local_x")) 
defineProperty("pos_y", globalPropertyf("sim/flightmodel/position/local_y")) 
defineProperty("pos_z", globalPropertyf("sim/flightmodel/position/local_z")) 
defineProperty("speed", globalPropertyf("sim/flightmodel/position/groundspeed"))
defineProperty("course", globalPropertyf("sim/flightmodel/position/psi")) 
defineProperty("course_fly", globalPropertyf("sim/flightmodel/position/hpath")) 
defineProperty("gear1_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[0]"))  
defineProperty("gear2_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[1]"))  
defineProperty("gear3_deploy", globalPropertyf("sim/aircraft/parts/acf_gear_deploy[2]"))  
local rows = 60
local cols = 80
local low_qlty = false
if low_qlty then
	rows = 30
	cols = 40
end
local colorTable = {[1]={0.1, 0.1, 0.1}, [2]={0.2, 0.5, 0.2}, [3]={0.3, 1, 0.3}, [4]={1, 1, 0.3}, [5]={1, 0.8, 0.2}, [6]={1, 0.6, 0.2}, [7]={1,0.3,0.3}, [8]={0.1,0.1,1}, [9] = {1,0.1,1}}
local heightTable = {}
for i = 1, cols, 1 do
	table.insert(heightTable, {})
	for j = 1, rows, 1 do
		table.insert(heightTable[i], 1)
	end
end
local tempHeightTable = {}
for i = 1, cols, 1 do
	table.insert(tempHeightTable, {})
	for j = 1, rows, 1 do
		table.insert(tempHeightTable[i], 1)
	end
end
function giveColor(acf_alt, terr_alt, wet, gears)
	local colorID = 8
	if not terr_alt then return 8 end 
	local alt = (terr_alt - acf_alt) 
	if alt >= 600 then colorID = 7 
	elseif alt >= 300 then colorID = 6 
	elseif alt >= 0 then colorID = 5 
	elseif alt >= -150 then colorID = 4 
	elseif alt >=- 300 then colorID = 3 
	elseif alt >=- 600 then colorID = 2 
	elseif alt < -600 then colorID = 1 
	end
	return colorID
end
function giveColor(acf_alt, terr_alt, wet, gears)
	local colorID = 8
	if not terr_alt then return 8 end 
	local alt = (terr_alt - acf_alt) * 3.2808399 
	if alt >= 2000 then colorID = 6 
	elseif alt >= 1000 and alt < 2000 then colorID = 5 
	elseif ((alt >= -250 and gears) or (alt >= -500 and not gears)) and alt < 1000 then colorID = 4 
	elseif alt >= -1000 and ((alt < -250 and gears) or (alt < -500 and not gears)) then colorID = 3 
	elseif alt >=-2000 and alt < -1000 then colorID = 2 
	elseif alt < -2000 then colorID = 1 
	end
	return colorID
end
local frame_counter = 1 
local dir = math.rad(get(course))
local dir_x = math.sin(dir); 
local dir_z = -math.cos(dir);
local right_x = -dir_z; 
local right_z = dir_x;
local height, width = 20000, 25000 
local plane_x = get(pos_x)
local plane_y = get(pos_y)
local plane_z = get(pos_z)
local LG = false
local text_font = loadFont('taws_scr.fnt')
local range_text = " 20"
local brightness = 0.8
local screen_work = get(mode_set) == 1
function update()
	screen_work = get(mode_set) == 1
	if not screen_work then 
		brightness = 0 
		frame_counter = 1
	else brightness = get(brt_handle)
	end
	local dist = get(distance_set)
	local distance = 20
	range_text = " 20"
	if dist == 0 then distance = 10 range_text = " 10"
	elseif dist == 2 then distance = 40 range_text = " 40"
	elseif dist == 3 then distance = 80 range_text = " 80"
	elseif dist == 4 then distance = 160 range_text = "160"
	elseif dist == 5 then distance = 320 range_text = "320"
	elseif dist == 6 then distance = 640 range_text = "640"
	end
	if frame_counter > rows/2 then frame_counter = 1 end
	if frame_counter == 1 and screen_work then
		dir = math.rad(get(course))
		if get(speed) > 11 then dir = math.rad(get(course_fly)) end
		dir_x = math.sin(dir); 
		dir_z = -math.cos(dir);
		right_x = -dir_z; 
		right_z = dir_x;
		plane_x = get(pos_x)
		plane_y = get(pos_y)
		plane_z = get(pos_z)
		LG = get(gear1_deploy) > 0.99 and get(gear2_deploy) > 0.99 and get(gear2_deploy) > 0.99
		height = distance * 1000
		width = distance * 1250
		for i = 1, cols, 1 do
			for j = 1, rows, 1 do
				heightTable[i][j] = tempHeightTable[i][j]
				tempHeightTable[i][j] = 1
			end
		end		
	end	
	if screen_work then
		local acf_lat, acf_lon, acf_alt = localToWorld(plane_x, plane_y, plane_z)
		for row = frame_counter * 2 - 1, frame_counter * 2, 1 do
			for col = 1, cols, 1 do
				local p_x = plane_x + dir_x * height * row/rows - right_x * width / 2 + right_x * width * col/cols;
				local p_z = plane_z + dir_z * height * row/rows - right_z * width / 2 + right_z * width * col/cols;
				local prob, locationX, locationY, locationZ, normalX, normalY, normalZ, velocityX, velocityY, vlocityZ, isWet = probeTerrain(p_x, plane_y, p_z)
				local lat, lon, alt = localToWorld(locationX, locationY, locationZ)
				tempHeightTable[col][row] = giveColor(acf_alt, alt, isWet, LG)
			end	
		end
	else
		for i = 1, cols, 1 do
			for j = 1, rows, 1 do
				heightTable[i][j] = 1
				tempHeightTable[i][j] = 1
			end
		end	
		frame_counter = 0
	end
	frame_counter = frame_counter + 1	
end
components = {
	draw_map {
		position = {0, 0, size[1], size[2]},
		size_x = cols,
		size_y = rows,
		image_table = function()
			return heightTable
		end,
		colors = function()
			return colorTable
		end,
		visible = function()
			return screen_work
		end,
	},
	texture {
		position = {0, 0, size[1], size[2]},
		image = get(scale_top_img),
		visible = function()
			return screen_work
		end,
	},
	rectangle {
		position = {0, 600, 120, 120},
		color = {0.1,0.1,0.1,1},
		visible = function()
			return screen_work
		end,
	},
	text_draw {
		position = {0, 660, 160, 160},
		text = function()
			return range_text
		end,
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work
		end,
	},
	text_draw {
		position = {20, 610, 160, 160},
		text = "км",
		font = text_font,
		color = {1,1,1,1},
		visible = function()
			return screen_work
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