defineProperty("course_bgmk", globalPropertyf("tu154ce/tks/course_bgmk_2")) 
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("adf_bear_1", globalPropertyf("tu154ce/radio/adf_bear_1"))
defineProperty("adf_bear_2", globalPropertyf("tu154ce/radio/adf_bear_2"))
defineProperty("vor_bear_1", globalPropertyf("tu154ce/radio/vor_bear_1"))
defineProperty("vor_bear_2", globalPropertyf("tu154ce/radio/vor_bear_2"))
defineProperty("ark15_L_ON", globalPropertyf("tu154ce/radio/ark15_L_cc")) 
defineProperty("ark15_R_ON", globalPropertyf("tu154ce/radio/ark15_R_cc")) 
defineProperty("nav_L_ON", globalPropertyf("tu154ce/radio/nav1_pow_cc")) 
defineProperty("nav_R_ON", globalPropertyf("tu154ce/radio/nav2_pow_cc")) 
defineProperty("bus36_volt", globalPropertyf("tu154ce/elec/bus36_volt_right")) 
defineProperty("radiocomp_scale", globalPropertyf("tu154ce/gauges/compas/radiocomp_scale_left")) 
defineProperty("bearing_1", globalPropertyf("tu154ce/gauges/compas/bearing_1_left")) 
defineProperty("bearing_2", globalPropertyf("tu154ce/gauges/compas/bearing_2_left")) 
defineProperty("source_1_switch", globalPropertyi("tu154ce/gauges/compas/source_1_switch_left")) 
defineProperty("source_2_switch", globalPropertyi("tu154ce/gauges/compas/source_2_switch_left")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local main_scale_act = math.random(-180, 180)
set(radiocomp_scale, main_scale_act)
local nd_1_angle = math.random(-180, 180)
local nd_2_angle = math.random(-180, 180)
local nd_1_act = math.random(-180, 180)
local nd_2_act = math.random(-180, 180)
function update()
	local MASTER = get(ismaster) ~= 1	
	local passed = get(frame_time)
	local power = get(bus36_volt) > 30
	main_scale_act = get(main_scale_act)
	if power then
		local course = get(course_bgmk)
		local cur_delta = main_scale_act - course
		if cur_delta > 180 then cur_delta = cur_delta - 360
		elseif cur_delta < -180 then cur_delta = cur_delta + 360 end
		if cur_delta > 1 then main_scale_act = main_scale_act - passed * 30
		elseif cur_delta < -1 then main_scale_act = main_scale_act + passed * 30
		else main_scale_act = main_scale_act - cur_delta * passed * 20
		end
	end
	if main_scale_act > 180 then main_scale_act = main_scale_act - 360
	elseif main_scale_act < -180 then main_scale_act = main_scale_act + 360 end
	if MASTER then set(radiocomp_scale, main_scale_act) end
	if power then
		local source_1 = get(source_1_switch)
		local source_2 = get(source_2_switch)
		if source_1 == 1 and get(ark15_L_ON) == 1 then 
			nd_1_angle = get(adf_bear_1)
		elseif source_1 == 3 and get(nav_L_ON) == 1 then 
			nd_1_angle = get(vor_bear_1) 
		end
		if source_2 == 2 and get(ark15_R_ON) == 1 then 
			nd_2_angle = get(adf_bear_2)
		elseif source_2 == 4 and get(nav_R_ON) == 1 then 
			nd_2_angle = get(vor_bear_2) 
		end
		local delta_1 = nd_1_angle - nd_1_act
		while delta_1 > 180 do delta_1 = delta_1 - 360 end
		while delta_1 < -180 do delta_1 = delta_1 + 360 end
		nd_1_act = nd_1_act + delta_1 * passed * 2
		local delta_2 = nd_2_angle - nd_2_act
		while delta_2 > 180 do delta_2 = delta_2 - 360 end
		while delta_2 < -180 do delta_2 = delta_2 + 360 end
		nd_2_act = nd_2_act + delta_2 * passed * 2
	end
if MASTER then	
	set(bearing_1, nd_1_act)
	set(bearing_2, nd_2_act)
end	
end