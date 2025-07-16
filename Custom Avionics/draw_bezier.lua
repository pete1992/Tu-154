size = {100, 100}
defineProperty("x_1", 0)
defineProperty("y_1", 0)
defineProperty("x_2", 100)
defineProperty("y_2", 0)
defineProperty("x_p", 50)
defineProperty("y_p", 100)
defineProperty("quality", 100)
defineProperty("thickness", 1)
defineProperty("color_r", 1)
defineProperty("color_g", 0)
defineProperty("color_b", 1)
defineProperty("color_a", 1)
function draw()
		local x1, y1 = get(x_1), get(y_1) 
		local x2, y2 = get(x_2), get(y_2) 
		local xp, yp = get(x_p), get(y_p) 
		local Q = get(quality)
		local TH = get(thickness)
		local r, g, b, a = get(color_r), get(color_g), get(color_b), get(color_a)
		for i = 0, Q, 1 do
			local xp1 = (xp - x1) * i / Q + x1
			local yp1 = (yp - y1) * i / Q + y1
			local xp2 = (x2 - xp) * i / Q + xp
			local yp2 = (y2 - yp) * i / Q + yp
			local bx = (xp2 - xp1) * i / Q + xp1
			local by = (yp2 - yp1) * i / Q + yp1
			drawRectangle(bx-TH/2, by-TH/2, TH, TH, r, g, b, a)
		end
end