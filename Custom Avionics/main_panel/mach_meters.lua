defineProperty("mach", globalPropertyf("sim/flightmodel/misc/machno")) 
defineProperty("mach_svs", globalPropertyf("sim/custom/svs/machno")) 
defineProperty("rel_pitot", globalPropertyi("sim/operation/failures/rel_pitot")) 
defineProperty("rel_pitot2", globalPropertyi("sim/operation/failures/rel_pitot2")) 
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("mach_ind_left", globalPropertyf("sim/custom/gauges/speed/mach_left")) 
defineProperty("mach_ind_right", globalPropertyf("sim/custom/gauges/speed/mach_right")) 
local mach_ind_L = 0
local mach_ind_R = 0
local mach_L_act = 0
local mach_R_act = 0
function update()
	local passed = get(frame_time)
	local mach_sim = get(mach)
	mach_ind_L = get(mach_svs)
	if mach_ind_L > 0.89 then mach_ind_L = 0.89
	elseif mach_ind_L < 0 then mach_ind_L = 0 end
	mach_L_act = mach_L_act + (mach_ind_L - mach_L_act) * passed * 10
	if get(rel_pitot2) < 6 then mach_ind_R = mach_sim end
	if mach_ind_R > 1.03 then mach_ind_R = 1.03 
	elseif mach_ind_R < 0 then mach_ind_R = 0 end
	mach_R_act = mach_R_act + (mach_ind_R - mach_R_act) * passed * 10
	set(mach_ind_left, mach_L_act)
	set(mach_ind_right, mach_R_act)
end