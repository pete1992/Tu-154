defineProperty("cl", globalPropertyf("sim/aircraft/controls/acf_flap_cl"))
defineProperty("cd", globalPropertyf("sim/aircraft/controls/acf_flap_cd"))
defineProperty("cm", globalPropertyf("sim/aircraft/controls/acf_flap_cm"))
defineProperty("cl2", globalPropertyf("sim/aircraft/controls/acf_flap2_cl"))
defineProperty("cd2", globalPropertyf("sim/aircraft/controls/acf_flap2_cd"))
defineProperty("cm2", globalPropertyf("sim/aircraft/controls/acf_flap2_cm"))
sim/aircraft/controls/acf_flap_cl	float	y
sim/aircraft/controls/acf_flap_cd	float	y
sim/aircraft/controls/acf_flap_cm	float	y
sim/aircraft/controls/acf_flap2_cl	float	y
sim/aircraft/controls/acf_flap2_cd	float	y
sim/aircraft/controls/acf_flap2_cm	float	y
defineProperty("flap", globalPropertyf("sim/flightmodel/controls/flaprat"))
defineProperty("alt", globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot"))
defineProperty("flap_inn_L", globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")) 
defineProperty("flap_inn_R", globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")) 
defineProperty("flap_mid_L", globalPropertyf("sim/flightmodel/controls/wing2l_fla2def")) 
defineProperty("flap_mid_R", globalPropertyf("sim/flightmodel/controls/wing2r_fla2def")) 
local flap1_cl_tbl = {
{-10, 1.029},
{0, 1.2},
{15, 1.2},
{28, 1.1},
{36, 1.2},
{45, 1.35},
{100, 1.2}
}
local flap2_cl_tbl = {
{-10, 1.189},
{0, 1.4},
{13, 1.4},
{25, 1.3},
{32, 1.4},
{40, 1.55},
{100, 1.4}
}
local flap1_cm_tbl = {
{-10, -0.15},
{0, -0.15},
{15, -0.16},
{28, -0.18},
{45, -0.25},
{100, -0.2}
}
local flap2_cm_tbl = {
{-10, -0.25},
{0, -0.2}, 
{13, -0.2}, 
{25, -0.23}, 
{40, -0.35}, 
{100, -0.3}
}
function update()
	local flap_inn = get(flap_inn_L)
	local flap_out = get(flap_mid_L)
	local flap1_cl = interpolate(flap1_cl_tbl, flap_inn)
	local flap2_cl = interpolate(flap2_cl_tbl, flap_out)
	local flap1_cm = interpolate(flap1_cm_tbl, flap_inn)
	local flap2_cm = interpolate(flap2_cm_tbl, flap_out)
	set(cl, flap1_cl)
	set(cl2, flap2_cl)
	set(cm, flap1_cm)
	set(cm2, flap2_cm)
end
