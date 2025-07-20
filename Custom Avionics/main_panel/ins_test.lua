defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("groundspeed", globalPropertyf("sim/flightmodel/position/groundspeed")) 
defineProperty("latitude", globalPropertyd("sim/flightmodel/position/latitude")) 
defineProperty("longitude", globalPropertyd("sim/flightmodel/position/longitude")) 
defineProperty("elevation", globalPropertyd("sim/flightmodel/position/elevation")) 
defineProperty("true_course", globalPropertyf("sim/flightmodel/position/hpath")) 
include("nav_funcs.lua")
local lat_start = get(latitude)
local lon_start = get(longitude)
local lat_last = get(latitude)
local lon_last = get(longitude)
local counter = 0
local spd_last = get(groundspeed) * 1.943844492441
local crs_last = get(true_course)
function update()
	local passed = get(frame_time)
	if counter > 1 then
		local speed_now = get(groundspeed) * 1.943844492441
		local speed = (speed_now + spd_last) / 2
		spd_last = speed_now
		local crs_now = get(true_course)
		local crs = (crs_now + crs_last) / 2
		crs_last = crs_now
		local de_dest = dist_new(speed, counter)
		local lat_new, lon_new = calcDest(lat_last, lon_last, crs, de_dest)
		lat_last = lat_new
		lon_last = lon_new
		counter = 0
	end
	counter = counter + passed
end