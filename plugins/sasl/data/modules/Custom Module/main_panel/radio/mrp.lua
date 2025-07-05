size = {2048, 2048}

-- define property table
-- datarefs
defineProperty("outer_marker", globalPropertyi("sim/cockpit/misc/outer_marker_lit"))   -- runway markers
defineProperty("middle_marker", globalPropertyi("sim/cockpit/misc/middle_marker_lit"))
defineProperty("inner_marker", globalPropertyi("sim/cockpit/misc/inner_marker_lit"))

defineProperty("alt", globalPropertyf("sim/flightmodel/position/y_agl"))
defineProperty("mrp_mode", globalPropertyi("tu154ce/switchers/ovhd/sp50_nav_mode")) -- 0 - landing, 1 = navigation
--defineProperty("marker_audio", globalPropertyi("sim/cockpit/radios/gear_audio_working"))


-- SP-50 mode selector: 0 = ILS, 1 = Katet, 2 = SP-50
--defineProperty("sp50_mode", globalPropertyi("tu154ce/switchers/ovhd/sp50_mode"))

-- SP-50 navigation mode: 0 = landing, 1 = enroute
--defineProperty("sp50_nav_mode", globalPropertyi("tu154ce/switchers/ovhd/sp50_nav_mode"))

--local mode = get(sp50_mode)
--local nav_mode = get(sp50_nav_mode)

-- interpret SP-50 main mode
--local current_mode = "ILS"  -- default

--if mode == 1 then
--    current_mode = "Katet"
--elseif mode == 2 then
--    current_mode = "SP-50"
--end

-- interpret SP-50 nav/landing mode
--local current_nav_mode = "Landing"  -- default

--if nav_mode == 1 then
 --   current_nav_mode = "Navigation"
--end


-- power
defineProperty("bus27_volt_left", globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))

--defineProperty("mrp_cc", globalPropertyf("tu154ce/xap/An24_gauges/mrp_cc"))
defineProperty("mrp_cc", createGlobalPropertyf("tu154ce/xap/An24_gauges/mrp_cc", 0))

-- sfail
--defineProperty("sim_fail", globalPropertyi("sim/operation/sim_failures/rel_marker"))
defineProperty("sim_fail", globalPropertyi("sim/operation/failures/rel_marker"))
defineProperty("mrp_fail", globalPropertyi("tu154ce/failures/mrp_fail"))




-- lamps
defineProperty("marker_1", globalPropertyf("tu154ce/lights/marker_1")) -- marker 1
defineProperty("marker_2", globalPropertyf("tu154ce/lights/marker_2")) -- marker 2
defineProperty("marker_3", globalPropertyf("tu154ce/lights/marker_3")) -- marker 3

defineProperty("lamp_test", globalPropertyi("tu154ce/buttons/lamp_test_front")) -- кнопка проверки ламп на передней панели	0
defineProperty("day_night_set", globalPropertyf("tu154ce/lights/day_night_set")) -- переключатель день - ночь. 0 - день, 1 - ночь. приглушает яркость сигнальных ламп.



local out_lit = 0
local mid_lit = 0
local in_lit = 0


function update()
	local mode = get(mrp_mode)
	--print(mode)
	if get(bus27_volt_left) > 13 and ((get(alt) < 5000 and mode == 1) or mode == 0) and get(mrp_fail) == 0 then
		set(mrp_cc, 2)
		set(sim_fail, 0)
		out_lit = get(outer_marker)
		mid_lit = get(middle_marker)
		in_lit = get(inner_marker)
	else
		set(mrp_cc, 0)
		set(sim_fail, 6)
		out_lit = 0
		mid_lit = 0
		in_lit = 0
	end
	
	local test_btn = get(lamp_test) * math.max(get(bus27_volt_right) - 10 / 18.5, 0)
	local day_night = 1 - get(day_night_set) * 0.8
	local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - 10) / 18.5, 0) * day_night
	
	
	
	
	set(marker_1, math.max(out_lit * lamps_brt, test_btn))
	set(marker_2, math.max(mid_lit * lamps_brt, test_btn))
	set(marker_3, math.max(in_lit * lamps_brt, test_btn))
	
	

end





