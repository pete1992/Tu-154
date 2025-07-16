components = {
	km5 {}, 
	km5 { 
		bus27_volt = globalPropertyf("sim/custom/elec/bus27_volt_right"),  
		bus36_volt = globalPropertyf("sim/custom/elec/bus36_volt_right"), 
		km5_knob = globalPropertyf("sim/custom/gauges/eng/km5_knob_2"), 
		fail = globalPropertyf("sim/custom/failures/tks_km2_fail"), 
		km5_scale = globalPropertyf("sim/custom/gauges/eng/km5_scale_2"), 
		km5_needle = globalPropertyf("sim/custom/gauges/eng/km5_needle_2"), 
		course_mk = globalPropertyf("sim/custom/tks/course_mk_2"), 
		km5_cc = globalPropertyf("sim/custom/tks/km5_2_cc"), 
	},
	gyro {}, 
	ush3 {}, 
	bgmk {}, 
	tks_panel {}, 
	tks_fails {},
}