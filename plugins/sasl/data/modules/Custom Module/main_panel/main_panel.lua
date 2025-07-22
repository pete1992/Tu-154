-- This is the actual panel. All gauges for panel.png and 2D popup panels will be placed here.

size = { 2048, 2048 }

components = {
	vers {},        -- version info component (likely empty placeholder)
	sc_controls {}, -- some controls component (placeholder)

	achs1 {},        -- clocks (time instruments)
	clock24 {},      -- 24-hour clocks on rear side panel
	mech_aneroid {}, -- membrane instruments (mechanical pressure gauges)
	svs {},          -- SVS system (possibly Synthetic Vision System)
	termo {},        -- thermometers
	uvid_15fk {},    -- foot altimeter
	mach_meters {},  -- Mach number indicators
	uap14 {},        -- AUASP indicator (some flight control or system indicator)
	eup53 {},        -- turn indicator
	agr {},          -- backup artificial horizon (AGR)
	pkp {},          -- left artificial horizon (PKP)

	pkp {            -- right artificial horizon (PKP)
		pitch_corr_hdl = globalPropertyf("tu154ce/gauges/ahz/pitch_corr_R"), -- pitch correction on AGR + right
		pkp_on = globalPropertyi("tu154ce/switchers/ovhd/pkp_right_on"), --switch for right PKP
		pkp_fail = globalPropertyi("tu154ce/bkk/pkp_fail_right"),            -- BKK signal - PKP failure
		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_right"), --power supply voltage 27V
		bus36_volt = globalPropertyf("tu154ce/elec/bus36_volt_right"), --power supply voltage 36V

		res_pitch = globalPropertyf("tu154ce/gauges/ahz/pitch_R"),           -- pitch on AGR + nose up
		pitch_int = globalPropertyf("tu154ce/gyro/ahz_pitch_int_R"),         -- pitch on AGR + up (integrated gyro)
		res_roll = globalPropertyf("tu154ce/gauges/ahz/roll_R"),             -- roll on AGR + right
		res_roll_bkk = globalPropertyf("tu154ce/bkk/pkp_roll_right"), --roll for BKK + right
		ahz_flag = globalPropertyf("tu154ce/gauges/ahz/ahz_flag_R"),         -- AGR pitch flag + nose up

		course_plank = globalPropertyf("tu154ce/gauges/ahz/course_plank_R"), -- AGR course bar pilot + right
		gs_plank = globalPropertyf("tu154ce/gauges/ahz/gs_plank_R"),         -- AGR glideslope bar pilot + up

		dir_roll = globalPropertyf("tu154ce/gauges/ahz/dir_roll_R"),         -- AGR roll director pilot + right
		dir_pitch = globalPropertyf("tu154ce/gauges/ahz/dir_pitch_R"), --AGR pitch director pilot + up

		dir_roll_flag = globalPropertyf("tu154ce/gauges/ahz/dir_roll_flag_R"), --AGR roll director failure flag
		dir_pitch_flag = globalPropertyf("tu154ce/gauges/ahz/dir_pitch_flag_R"), -- AGR pitch director failure flag

		absu_pnp_mode = globalPropertyi("tu154ce/absu/absu_pnp_mode_2"), --PNP indication mode: 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
		absu_at_dif = globalPropertyf("tu154ce/absu_at_dif_right"),          -- speed difference for indication on PKP
		speed_plank = globalPropertyf("tu154ce/gauges/ahz/speed_plank_R"), --speed change on AGR 2P + up

		power_cc = globalPropertyf("tu154ce/bkk/pkp_right_power_cc"), --current consumption PKP
		fail = globalPropertyi("sim/operation/failures/rel_cop_ahz"), --failure signal
	},
	mgv {}, -- control artificial horizon without indication output
	bkk {}, -- roll control block BKK

	-- electronic altimeters
	vbe_altimeter { -- left electronic altimeter
		position = { 733, 839, 424, 424 },
	},

	vbe_altimeter { -- right electronic altimeter
		position = { 1166, 839, 424, 424 },
		gauge_num = 1,
		static_fail = globalPropertyi("sim/operation/failures/rel_static2"),
		pressure = globalPropertyf("tu154ce/gauges/alt/vbe_press_right"),
		brt_knob = globalPropertyf("tu154ce/gauges/alt/vbe_brt_right"),
		press_knob = globalPropertyi("tu154ce/gauges/alt/vbe_press_knob_right"),
		fl_knob = globalPropertyi("tu154ce/gauges/alt/vbe_fl_knob_right"),
		mode_button = globalPropertyi("tu154ce/gauges/alt/vbe_mode_but_right"),
		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_right"),
		bus115_volt = globalPropertyf("tu154ce/elec/bus115_3_volt"),
		vbe_on = globalPropertyi("tu154ce/switchers/ovhd/vbe_2_on"),
		vbe_mode = globalPropertyi("tu154ce/gauges/alt/vbe_mode_right"),
		vbe_std = globalPropertyi("tu154ce/gauges/alt/vbe_std_right"),
		alt_mtr = globalPropertyf("tu154ce/gauges/alt/vbe_alt_right"),           
		vbe_flightlevel = globalPropertyf("tu154ce/gauges/alt/vbe_flightlevel_right"), -- flight level right gauge 
		fail = globalPropertyi("sim/operation/failures/rel_cop_alt"),            
	},

	rv5 {},

	rv5 {
		altitude = globalPropertyf("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_copilot"), 
		dh_set = globalPropertyf("tu154ce/gauges/alt/radioalt_dh_right"),
		test_btn = globalPropertyf("tu154ce/gauges/alt/radioalt_button_right"), 
		rv_on = globalPropertyf("tu154ce/switchers/ovhd/rv5_2_on"),
		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_right"),
		bus115_volt = globalPropertyf("tu154ce/elec/bus115_3_volt"),
		rv_angle = globalPropertyf("tu154ce/gauges/alt/radioalt_needle_right"),
		rv_flag = globalPropertyf("tu154ce/gauges/alt/radioalt_flag_right"),
		rv_lamp = globalPropertyf("tu154ce/lights/small/rv5_right_dh"),
		rv5_dh_signal = globalPropertyi("tu154ce/misc/rv5_dh_signal_right"),
		rv_cc = globalPropertyf("tu154ce/elec/rv5_right_cc"),
		rv5_alt = globalPropertyf("tu154ce/misc/rv5_alt_right"), -- right altimeter
		rv_fail = globalPropertyi("tu154ce/failures/rv2_fail"), --failure flag
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
	pnp {},

	pnp {
		gauge_num = 1,
		course_ga = globalPropertyf("tu154ce/tks/course_ga_2"), 
		course_bgmk = globalPropertyf("tu154ce/tks/course_bgmk_2"), 
		gyro_fail = globalPropertyi("tu154ce/tks/fail_right"), --failure flag
		obs = globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_R"), 
		obs_side = globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_L"),
		-- controls
		pnp_mode = globalPropertyi("tu154ce/switchers/ovhd/curs_pnp_mode_2"), -- PNP course mode: 0 = GMK, 1 = GPK
		pkp_obs_knob = globalPropertyf("tu154ce/gauges/compas/pkp_obs_knob_R"), -- course setting knob
		pkp_gyro_course = globalPropertyf("tu154ce/gauges/compas/pkp_gyro_course_R"), -- PKP gyro course
		pkp_obs = globalPropertyf("tu154ce/gauges/compas/pkp_obs_R"),               -- PKP flight course
		pkp_helper_course = globalPropertyf("tu154ce/gauges/compas/pkp_helper_course_R"), -- yellow needle course setting on PKP
		pkp_slip_angle = globalPropertyf("tu154ce/gauges/compas/pkp_slip_angle_R"), -- slip angle on PKP
		pkp_course_plank = globalPropertyf("tu154ce/gauges/compas/pkp_course_plank_R"), -- PKP course bar pilot + right deviation
		pkp_gs_plank = globalPropertyf("tu154ce/gauges/compas/pkp_gs_plank_R"), --PKP glideslope bar pilot + up deviation
		pkp_gs_flag = globalPropertyi("tu154ce/gauges/compas/pkp_gs_flag_R"), --glideslope bar failure flag
		pkp_course_flag = globalPropertyi("tu154ce/gauges/compas/pkp_course_flag_R"), -- course bar failure flag
		pkp_main_flag = globalPropertyi("tu154ce/gauges/compas/pkp_main_flag_R"), --course failure flag
		pkp_obs_flag = globalPropertyi("tu154ce/gauges/compas/pkp_obs_flag_R"), --,course counter failure flag
		pkp_obs_one = globalPropertyf("tu154ce/gauges/compas/pkp_obs_one_R"), --course counter units
		pkp_obs_ten = globalPropertyf("tu154ce/gauges/compas/pkp_obs_ten_R"), --course counter tens
		pkp_obs_hundr = globalPropertyf("tu154ce/gauges/compas/pkp_obs_hundr_R"), --course counter hundreds		

		absu_pnp_mode = globalPropertyi("tu154ce/absu/absu_pnp_mode_2"),            -- PNP indication mode: 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
		absu_pnp_mode_2 = globalPropertyi("tu154ce/absu/absu_pnp_mode_1"),          -- PNP indication mode (alternate)

		pnp_sp_lamp = globalPropertyf("tu154ce/lights/small/pnp_sp_right"),         -- PNP special lamp right
		pnp_vor_lamp = globalPropertyf("tu154ce/lights/small/pnp_vor_right"), --PNP VOR lamp right
		pnp_nv_lamp = globalPropertyf("tu154ce/lights/small/pnp_nv_right"),         -- PNP NV lamp right

		bus27_volt = globalPropertyf("tu154ce/elec/bus27_volt_left"),
		bus36_volt = globalPropertyf("tu154ce/elec/bus36_volt_right"),
		fail_ga = globalPropertyf("sim/operation/failures/rel_cop_dgy"),
		tks_on = globalPropertyi("tu154ce/switchers/ovhd/tks_on_2"),
	},

	rmi {}, -- radio compass Captain

	rmi {
		-- sources
		course_bgmk = globalPropertyf("tu154ce/tks/course_bgmk_1"),                 -- course on BGMK (left)
		-- power
		bus36_volt = globalPropertyf("tu154ce/elec/bus36_volt_pts250_2"),           -- 36V bus voltage for PTS250 2
		-- results
		radiocomp_scale = globalPropertyf("tu154ce/gauges/compas/radiocomp_scale_right"), -- radio compass course scale right
		bearing_1 = globalPropertyf("tu154ce/gauges/compas/bearing_1_right"), --direction needle 1 for radio compass right
		bearing_2 = globalPropertyf("tu154ce/gauges/compas/bearing_2_right"), --direction needle 2 for radio compass right
		source_1_switch = globalPropertyi("tu154ce/gauges/compas/source_1_switch_right"), -- switch for radio compass needle 1 (0 = none, 1 = ARK1, 2 = ARK2, 3 = VOR1, 4 = VOR2, 5 = RSBN)
		source_2_switch = globalPropertyi("tu154ce/gauges/compas/source_2_switch_right"), -- switch for radio compass needle 2
	},

	diss {}, -- Doppler system
	usvp {}, -- true and ground speed
	rsbn {}, -- short range radio navigation system

	radio { -- radio panel
		position = { 0, 0, 2048, 2048 },
	},

	nvu {},     -- navigation computer
	absu {},    -- autopilot system
	misc_lamps {}, -- miscellaneous lamps

	radar {
		position = { 0, 0, 2048, 2048 },
	},
	vent {},
	water_panel {},
	gns430 {},
	-- ins_test {},  -- inertial navigation system test (commented out)
	misc_fails {}, -- miscellaneous failures
}