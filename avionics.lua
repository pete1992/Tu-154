size = { 2048, 2048 }
print("Lua version is", _VERSION)
fixedPanelWidth = 2048
fixedPanelHeight = 2048
math.randomseed( os.time() ) 
function interpolate(tbl, value)
    local lastActual = 0
    local lastReference = 0
    for _k, v in pairs(tbl) do
        if value == v[1] then
            return v[2]
        end
        if value < v[1] then
            local a = value - lastActual
            local m = v[2] - lastReference
            return lastReference + a / (v[1] - lastActual) * m
        end
        lastActual = v[1]
        lastReference = v[2]
    end
    return value - lastActual + lastReference
end
function sign(x)
	if x >= 0 then return 1 else return -1 end
end
function bool2int(var)
	if var then return 1
	else return 0 end
end
function line (x, x1, y1, x2, y2) 
	if x2 - x1 ~= 0 then 
		return (x - x1)*(y2 - y1)/(x2 - x1) + y1
	else return 0 
	end
end
function isILS(freq)
    if (10810 > freq) or (11195 < freq) then
        return false
    end
    local v, f = math.modf(freq / 100)
	v = math.floor(f * 10 + 0.001)
    return 1 == (v % 2)
end
components = {
	dataref_creator_1 {}, 
	dataref_creator_2 {}, 
	dataref_creator_3 {}, 
	dataref_creator_4 {}
	save_state {}, 
	time_logic {},
	flap_aero {},
	KLN90 {
			position = { 1018, 506, 1029, 329 }  
	},	
	main_panel { 
		position = {0, 0, 2048, 2048},
	}, 
	overhead {},
	animation {},
	electric_system{},
	lights_system{},
	apu_system {},
	engines_system {},
	fuel_system {},
	hydro_system {},
	kskv {},
	start_system {},
	controls {},
	fire_system {},
	antiice{},
	msrp {},
	brake_system {},
	sounds {},
	panels_2d {},
}
