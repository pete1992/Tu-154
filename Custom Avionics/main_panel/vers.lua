print("Tu154 v2.0.6")
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
local counter = 0
function update()
	counter = counter + get(frame_time)
	if counter > 1 then
		counter = 0
		print(get(mem))
	end
end
