defineProperty("M", globalPropertyf("sim/flightmodel/position/M"))  
defineProperty("sim_run_time", globalPropertyf("sim/time/total_running_time_sec")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
local time_last = get(sim_run_time)  
local last_m = get(M)
function update()
	local time_now = get(sim_run_time)
	local passed = math.abs(time_now - time_last)
	local curent_m = get(M)
	if curent_m - last_m == 0 then passed = 0 end
	if passed > 0.1 then passed = 0.1 end
	set(frame_time, passed)
	time_last = time_now
end
