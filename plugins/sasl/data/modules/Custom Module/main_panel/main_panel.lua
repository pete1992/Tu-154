-- this is actual panel. here will be placed all gauges for panel.png and 2D popup panels

size = { 2048, 2048 }

components = {

--	test_hud {	
--		position = {1600, 0, 400, 400},
--	},

	vers {},

	sc_controls {},                                                        -- SmartCopilot controls

	achs1 {},                                                              -- clock
	clock24 {},                                                            -- clock on the rear side panel
	mech_aneroid {},                                                       -- aneroid (membrane) gauges
	svs {},                                                                -- SVS system
	termo {},                                                              -- thermometers
	uvid_15fk {},                                                          -- feet altimeter
	mach_meters {},                                                        -- Mach number indicators
	uap14 {},                                                              -- AUASP indicator
	eup53 {},                                                              -- turn indicator
	agr {},                                                                -- backup attitude indicator
	pkp {},                                                                -- left attitude indicator
	pkp {                                                                  -- right attitude indicator
		pitch_corr_hdl = globalPropertyf("tu154ce/gauges/ahz/pitch_corr_R"), -- pitch correction on AGR + right
		pkp_on = globalPropertyi("tu154ce/switchers/ovhd/pkp_right_on"),     -- switch

		pkp_fail = globalPropertyi("tu154ce/bkk/pkp_fail_right"),            -- signal from BKK - PKP failure
		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_right"),       -- power supply
		bus36_volt = globalPropertyf("tu154ce/elec/bus36_volt_right"),       -- power supply

		res_pitch = globalPropertyf("tu154ce/gauges/ahz/pitch_R"),           -- pitch on AGR + nose up
		pitch_int = globalPropertyf("tu154ce/gyro/ahz_pitch_int_R"),         -- pitch on AGR + up
		res_roll = globalPropertyf("tu154ce/gauges/ahz/roll_R"),             -- roll on AGR + to the right
		res_roll_bkk = globalPropertyf("tu154ce/bkk/pkp_roll_right"),        -- roll for BKK + to the right
		ahz_flag = globalPropertyf("tu154ce/gauges/ahz/ahz_flag_R"),         -- pitch on AGR + nose up

		course_plank = globalPropertyf("tu154ce/gauges/ahz/course_plank_R"), -- course bar AGD CPT + to the right
		gs_plank = globalPropertyf("tu154ce/gauges/ahz/gs_plank_R"),         -- glide slope bar AGD CPT + up

		dir_roll = globalPropertyf("tu154ce/gauges/ahz/dir_roll_R"),         -- roll director AGD CPT + to the right
		dir_pitch = globalPropertyf("tu154ce/gauges/ahz/dir_pitch_R"),       -- pitch director AGD CPT + up

		dir_roll_flag = globalPropertyf("tu154ce/gauges/ahz/dir_roll_flag_R"),   -- roll director failure flag AGD CPT
		dir_pitch_flag = globalPropertyf("tu154ce/gauges/ahz/dir_pitch_flag_R"), -- pitch director failure flag AGD CPT

		absu_pnp_mode = globalPropertyi("tu154ce/absu/absu_pnp_mode_2"),     -- PNP indication mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
		absu_at_dif = globalPropertyf("tu154ce/absu_at_dif_right"),          -- speed difference for indication on PKP
		speed_plank = globalPropertyf("tu154ce/gauges/ahz/speed_plank_R"),   -- speed change AGD 2P + up

		power_cc = globalPropertyf("tu154ce/bkk/pkp_right_power_cc"),        -- PKP current consumption
		fail = globalPropertyi("sim/operation/failures/rel_cop_ahz"),
	},
	mgv {}, -- control (reference) attitude indicator without display output
	bkk {}, -- bank control block (BKK)

	-- electronic altimeter
	vbe_altimeter { -- left electronic altimeter
		position = { 733, 839, 424, 424 },
	},

	-- electronic altimeter
	vbe_altimeter { -- right electronic altimeter
		position = { 1166, 839, 424, 424 },
		gauge_num = 1,
		static_fail = globalPropertyi("sim/operation/failures/rel_static2"),
		pressure = globalPropertyf("tu154ce/gauges/alt/vbe_press_right"),        -- pressure in hPa
		brt_knob = globalPropertyf("tu154ce/gauges/alt/vbe_brt_right"),          -- brightness knob
		press_knob = globalPropertyi("tu154ce/gauges/alt/vbe_press_knob_right"), -- pressure knob
		fl_knob = globalPropertyi("tu154ce/gauges/alt/vbe_fl_knob_right"),       -- flight level knob
		mode_button = globalPropertyi("tu154ce/gauges/alt/vbe_mode_but_right"),  -- mode button
		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_right"),           -- 27V network voltage
		bus115_volt = globalPropertyf("tu154ce/elec/bus115_3_volt"),             -- 115V network voltage
		vbe_on = globalPropertyi("tu154ce/switchers/ovhd/vbe_2_on"),             -- power switch
		vbe_mode = globalPropertyi("tu154ce/gauges/alt/vbe_mode_right"),         -- meters/feet mode
		vbe_std = globalPropertyi("tu154ce/gauges/alt/vbe_std_right"),           -- standard pressure mode
		alt_mtr = globalPropertyf("tu154ce/gauges/alt/vbe_alt_right"),           -- indicated altitude in meters
		vbe_flightlevel = globalPropertyf("tu154ce/gauges/alt/vbe_flightlevel_right"), -- flight level
		fail = globalPropertyi("sim/operation/failures/rel_cop_alt"),            --
	},

	rv5 {},

	rv5 {
		altitude = globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_copilot"), -- altitude measured by gauge
		dh_set = globalPropertyf("tu154ce/gauges/alt/radioalt_dh_right"),                         -- DH (Decision Height) setting
		test_btn = globalPropertyf("tu154ce/gauges/alt/radioalt_button_right"),                   -- DH test button
		rv_on = globalPropertyf("tu154ce/switchers/ovhd/rv5_2_on"),                               -- power switch
		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_right"),
		bus115_volt = globalPropertyf("tu154ce/elec/bus115_3_volt"),
		rv_angle = globalPropertyf("tu154ce/gauges/alt/radioalt_needle_right"), -- RV needle
		rv_flag = globalPropertyf("tu154ce/gauges/alt/radioalt_flag_right"), -- RV flag
		rv_lamp = globalPropertyf("tu154ce/lights/small/rv5_right_dh"),   -- RV lamp
		rv5_dh_signal = globalPropertyi("tu154ce/misc/rv5_dh_signal_right"),
		rv_cc = globalPropertyf("tu154ce/elec/rv5_right_cc"),             -- RV current
		rv5_alt = globalPropertyf("tu154ce/misc/rv5_alt_right"),          -- height on the right altimeter
		rv_fail = globalPropertyi("tu154ce/failures/rv2_fail"),           -- fail
	},

	msrp_clock { -- MSRP clock
		position = { 12, 762, 195, 84 },
	},

	door_panel {}, -- door and hatch indicators

	tcas {
		position = { 0, 0, 2048, 2048 },
	},
	taws {
		position = { 1034, 1270, 1000, 770 },
	},

	tks {},

	pnp {},                                                          -- PNP CPT

	pnp {                                                            -- PNP COP
		gauge_num = 1,                                               -- right
		course_ga = globalPropertyf("tu154ce/tks/course_ga_2"),      -- course to GA
		course_bgmk = globalPropertyf("tu154ce/tks/course_bgmk_2"),  -- course to BGMK
		gyro_fail = globalPropertyi("tu154ce/tks/fail_right"),       -- failure flag

		obs = globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_R"), -- set course
		obs_side = globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_L"), -- set course

		-- controls
		pnp_mode = globalPropertyi("tu154ce/switchers/ovhd/curs_pnp_mode_2"), -- PNP course mode. 0 - GMK, 1 - GPK
		pkp_obs_knob = globalPropertyf("tu154ce/gauges/compas/pkp_obs_knob_R"), -- course adjustment knob

		-- results
		pkp_gyro_course = globalPropertyf("tu154ce/gauges/compas/pkp_gyro_course_R"), -- PKP gyro course
		pkp_obs = globalPropertyf("tu154ce/gauges/compas/pkp_obs_R"),               -- flight course on PKP
		pkp_helper_course = globalPropertyf("tu154ce/gauges/compas/pkp_helper_course_R"), -- yellow arrow course setting on PKP
		pkp_slip_angle = globalPropertyf("tu154ce/gauges/compas/pkp_slip_angle_R"), -- sideslip angle on PKP
		pkp_course_plank = globalPropertyf("tu154ce/gauges/compas/pkp_course_plank_R"), -- course bar PKP CPT + bar deflection right
		pkp_gs_plank = globalPropertyf("tu154ce/gauges/compas/pkp_gs_plank_R"),     -- glide slope bar PKP CPT + bar deflection up
		pkp_gs_flag = globalPropertyi("tu154ce/gauges/compas/pkp_gs_flag_R"),       -- glide slope bar failure flag
		pkp_course_flag = globalPropertyi("tu154ce/gauges/compas/pkp_course_flag_R"), -- course bar failure flag
		pkp_main_flag = globalPropertyi("tu154ce/gauges/compas/pkp_main_flag_R"),   -- course failure flag
		pkp_obs_flag = globalPropertyi("tu154ce/gauges/compas/pkp_obs_flag_R"),     -- course counter failure flag
		pkp_obs_one = globalPropertyf("tu154ce/gauges/compas/pkp_obs_one_R"),       -- course counter, units
		pkp_obs_ten = globalPropertyf("tu154ce/gauges/compas/pkp_obs_ten_R"),       -- course counter, tens
		pkp_obs_hundr = globalPropertyf("tu154ce/gauges/compas/pkp_obs_hundr_R"),   -- course counter, hundreds		

		absu_pnp_mode = globalPropertyi("tu154ce/absu/absu_pnp_mode_2"),            -- PNP indication mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
		absu_pnp_mode_2 = globalPropertyi("tu154ce/absu/absu_pnp_mode_1"),          -- PNP indication mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS

		pnp_sp_lamp = globalPropertyf("tu154ce/lights/small/pnp_sp_right"),         --
		pnp_vor_lamp = globalPropertyf("tu154ce/lights/small/pnp_vor_right"),       --
		pnp_nv_lamp = globalPropertyf("tu154ce/lights/small/pnp_nv_right"),         --

		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_left"),
		bus36_volt = globalPropertyf("tu154ce/elec/bus36_volt_right"),
		fail_ga = globalPropertyf("sim/operation/failures/rel_cop_dgy"),
		tks_on = globalPropertyi("tu154ce/switchers/ovhd/tks_on_2"),
	},

	rmi {}, -- radiocompass CPT

	rmi {

		-- sources
		course_bgmk = globalPropertyf("tu154ce/tks/course_bgmk_1"),                 -- course to BGMK
		-- power
		bus36_volt = globalPropertyf("tu154ce/elec/bus36_volt_pts250_2"),           -- 36V power supply
		-- results
		radiocomp_scale = globalPropertyf("tu154ce/gauges/compas/radiocomp_scale_right"), -- radiocompass course scale
		bearing_1 = globalPropertyf("tu154ce/gauges/compas/bearing_1_right"),       -- bearing 1 needle of radiocompass
		bearing_2 = globalPropertyf("tu154ce/gauges/compas/bearing_2_right"),       -- bearing 2 needle of radiocompass
		source_1_switch = globalPropertyi("tu154ce/gauges/compas/source_1_switch_right"), -- source selector for bearing 1. 0 - none, 1 - ARK1, 2 - ARK2, 3 - VOR1, 4 - VOR2, 5 - RSBN
		source_2_switch = globalPropertyi("tu154ce/gauges/compas/source_2_switch_right"), -- source selector for bearing 2
	},

	diss {}, -- doppler system

	usvp {}, -- true and ground speed

	rsbn {}, -- short range radio navigation system

	radio { -- radio panel
		position = { 0, 0, 2048, 2048 },
	},

	nvu {},     -- navigation computer

	absu {},    -- autopilot

	misc_lamps {}, -- various lamps

	radar {
		position = { 0, 0, 2048, 2048 },
	},

	vent {},

	water_panel {},

	gns430 {},

	--ins_test {},

	misc_fails {},

}

