size = {500, 385}
defineProperty("mode_set", globalPropertyi("tu154ce/taws/mode_set")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("but_view", globalPropertyi("tu154ce/buttons/srpbz/but_view")) 
defineProperty("but_empty", globalPropertyi("tu154ce/buttons/srpbz/but_empty")) 
defineProperty("but_down", globalPropertyi("tu154ce/buttons/srpbz/but_down")) 
defineProperty("but_up", globalPropertyi("tu154ce/buttons/srpbz/but_up")) 
local pong_sound = loadSample('Custom Sounds/pong.wav') 
local sqr_sound = loadSample('Custom Sounds/square.wav') 
local text_font = loadFont('taws_scr.fnt')
local screen_work = false
local player = {}
local ball = {}
local level = 0
local barrels = {}
local barrel_x = size[1] / 10 - 3
local barrel_y = 15
local ball_init_pos = (math.random() * 2 - 1)
local game_lost = false
local game_started = false
local score = 0
function next_life()
	player.size_x = 100
	player.size_y = 20
	player.x = size[1]/2
	player.y = 0
	ball.size = 15
	ball.x = player.x + ball_init_pos * player.size_x / 4
	ball.y = player.size_y + ball.size/2 + 1
	ball.vel_x = math.sin((ball.x - player.x) / player.size_x * 2)
	ball.vel_y = math.abs(math.cos((ball.x - player.x) / player.size_x * 2))
	game_started = false
end
function next_level()
	ball_init_pos = (math.random() * 2 - 1)
	next_life()
	level = level + 1
	ball.spd = ball.spd + level * 0.5
	for h = 0, 9 do
		for v = 0, 2 do
			table.insert(barrels, {x = h * (barrel_x + 3), y = size[2] - 70 - (barrel_y + 3) * v - barrel_y })
		end
	end
end
function reset()
	level = 0
	ball.spd = 1
	barrels = {}
	next_level()
	player.life = 3
	game_lost = false
	score = 0
end
reset()
local but_last = 0
function update()
	screen_work = get(mode_set) == 6
	local passed = get(frame_time)
	if screen_work and get(ismaster) ~= 0 then set(mode_set, 1) end
	if get(but_empty) == 1 and but_last ~= get(but_empty) then reset() end
	but_last = get(but_empty)
	if screen_work and not game_lost then
		if get(but_down) == 1 then
			player.x = player.x - passed * 1000
			if player.x <= player.size_x/2 then player.x = player.size_x/2 end
			game_started = true
		end
		if get(but_up) == 1 then
			player.x = player.x + passed * 1000
			if player.x >= size[1]-player.size_x/2 then player.x = size[1]-player.size_x/2 end
			game_started = true
		end
		if game_started then
			ball.x = ball.x + ball.vel_x * passed * 100 * ball.spd
			ball.y = ball.y + ball.vel_y * passed * 100 * ball.spd
		end
		if ball.x <= ball.size/2 then 
			ball.x = ball.size/2
			ball.vel_x = math.abs(ball.vel_x) 
			playSample(pong_sound, 0) 
		end 
		if ball.x >= size[1]-ball.size/2 then 
			ball.x = size[1]-ball.size/2
			ball.vel_x = -math.abs(ball.vel_x) 
			playSample(pong_sound, 0) 
		end 
		if ball.y >= size[2]-ball.size/2 - 50 then 
			ball.y = size[2]-ball.size/2 - 50
			ball.vel_y = -math.abs(ball.vel_y) 
			playSample(pong_sound, 0) 
		end 
		if ball.y <= ball.size/2 then 
			player.life = player.life - 1
			if player.life > 0 then 
				next_life() 
			else
				game_lost = true
				next_life() 
			end
		end
		for i, v in pairs(barrels) do
			if ball.x + ball.size/2 >= v.x and ball.x - ball.size/2 <= v.x + barrel_x and
			ball.y - ball.size/2 <= v.y + barrel_y and ball.y + ball.size/2 >= v.y then
				table.remove(barrels, i)
				score = score + 10
				playSample(sqr_sound, 0)
				if ball.x + ball.size/2 < v.x + barrel_x / 10 or ball.x - ball.size/2 > v.x + barrel_x - barrel_x / 10 then
					ball.vel_x = -ball.vel_x
				else 
					ball.vel_y = -ball.vel_y
				end
				break
			end
		end
		if ball.y - ball.size/2 <= player.size_y and 
		ball.x + ball.size/2 > player.x - player.size_x/2 and ball.x - ball.size/2 < player.x + player.size_x/2 then
			ball.y = player.size_y + ball.size / 2
			ball.vel_x = math.sin((ball.x - player.x) / player.size_x * 2)
			ball.vel_y = math.abs(math.cos((ball.x - player.x) / player.size_x * 2))
			if game_started then playSample(pong_sound, 0) end
		end
		if #barrels == 0 then next_level() end
	end
end
function draw()
if screen_work then
	drawRectangle(0, 0, size[1], size[2]-50, 0.0, 0.1, 0.2, 1) 
	drawRectangle(player.x - player.size_x/2, player.y, player.size_x, player.size_y, 0.3, 0.8, 0.5, 1) 
	drawRectangle(ball.x - ball.size/2, ball.y - ball.size/2, ball.size, ball.size, 0.9, 0.4, 0.1, 1) 
	for _, v in pairs(barrels) do
		drawRectangle(v.x, v.y, barrel_x, barrel_y, 0.8, 0.8, 0.5, 1)
	end
	drawText(text_font, 10, 350, "P: "..player.life, 1,1,1,1)
	drawText(text_font, 100, 350, "LVL: "..level, 1,1,1,1)
	drawText(text_font, 250, 350, "PTS: "..score, 1,1,1,1)
	if game_lost then
		drawText(text_font, 130, 210, "GAME OVER", 1,1,1,1)
		drawText(text_font, 40, 150, "PRESS MOD TO EXIT", 1,1,1,1)
		drawText(text_font, 15, 100, "PRESS BUT2 TO RESET", 1,1,1,1)
	end
	if not game_started then
		drawText(text_font, 160, 170, "LEVEL: "..level, 1,1,1,1)
	end
end
end