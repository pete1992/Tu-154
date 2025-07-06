createGlobalPropertyi("tu154ce/lang/hide_rus_objects", 1) -- hide Russian cockpit objects
createGlobalPropertyi("tu154ce/lang/hide_eng_objects", 0) -- hide English cockpit objects
createGlobalPropertyi("tu154ce/have_pedals", 0) -- pedals with brakes available
createGlobalPropertyi("tu154ce/sounds_voulme", 1000) -- master sound volume

createGlobalPropertyi("tu154ce/sounds/master_voulme", 1000) -- master sound volume
createGlobalPropertyi("tu154ce/sounds/engines_voulme", 1000) -- engine sound volume
createGlobalPropertyi("tu154ce/sounds/avionics_voulme", 1000) -- avionics sound volume
createGlobalPropertyi("tu154ce/sounds/switches_voulme", 1000) -- manipulator sound volume (buttons, switches)
createGlobalPropertyf("tu154ce/elec/bat_volt_1", 25) -- battery voltage
createGlobalPropertyf("tu154ce/elec/bat_volt_2", 25) -- battery voltage
createGlobalPropertyf("tu154ce/elec/bat_volt_3", 25) -- battery voltage
createGlobalPropertyf("tu154ce/elec/bat_volt_4", 25) -- battery voltage
createGlobalPropertyf("tu154ce/elec/bat_amp_1", 0) -- battery current
createGlobalPropertyf("tu154ce/elec/bat_amp_2", 0) -- battery current
createGlobalPropertyf("tu154ce/elec/bat_amp_3", 0) -- battery current
createGlobalPropertyf("tu154ce/elec/bat_amp_4", 0) -- battery current
createGlobalPropertyf("tu154ce/elec/bat_cc_1", 0) -- battery charging current
createGlobalPropertyf("tu154ce/elec/bat_cc_2", 0) -- battery charging current
createGlobalPropertyf("tu154ce/elec/bat_cc_3", 0) -- battery charging current
createGlobalPropertyf("tu154ce/elec/bat_cc_4", 0) -- battery charging current
createGlobalPropertyf("tu154ce/elec/bat_therm_1", 20) -- battery temperature
createGlobalPropertyf("tu154ce/elec/bat_therm_2", 20) -- battery temperature
createGlobalPropertyf("tu154ce/elec/bat_therm_3", 20) -- battery temperature
createGlobalPropertyf("tu154ce/elec/bat_therm_4", 20) -- battery temperature
createGlobalPropertyf("tu154ce/elec/vu1_volt", 27) -- AVU in operation
createGlobalPropertyf("tu154ce/elec/vu2_volt", 27) -- AVU in operation
createGlobalPropertyf("tu154ce/elec/vu_res_volt", 27) -- AVU in operation
createGlobalPropertyf("tu154ce/elec/vu1_amp", 0) -- AVU current
createGlobalPropertyf("tu154ce/elec/vu2_amp", 0) -- AVU current
createGlobalPropertyf("tu154ce/elec/vu_res_amp", 0) -- AVU current
createGlobalPropertyi("tu154ce/elec/vu_res_to_L", 0) -- reserve AVU connected to left bus
createGlobalPropertyi("tu154ce/elec/vu_res_to_R", 0) -- reserve AVU connected to right bus
createGlobalPropertyf("tu154ce/elec/bus27_volt_left", 27) -- left 27V bus voltage
createGlobalPropertyf("tu154ce/elec/bus27_amp_left", 27) -- left 27V bus voltage
createGlobalPropertyf("tu154ce/elec/bus27_amp_right", 0) -- right 27V bus current
createGlobalPropertyf("tu154ce/elec/bus27_volt_right", 0) -- right 27V bus current
createGlobalPropertyi("tu154ce/elec/bus27_source_left", 1) -- left bus power source. 0 - none, 1 - AVU1, 2 - AVU reserve, 3 - batteries 1 and 3, 4 - bat 1, 5 - bat 2
createGlobalPropertyi("tu154ce/elec/bus27_source_right", 0) -- right bus power source. 0 - none, 1 - AVU2, 2 - AVU reserve, 3 - batteries 1 and 3, 4 - bat 1, 5 - bat 2
createGlobalPropertyi("tu154ce/elec/bat_is_source_1", 1) -- battery is power source
createGlobalPropertyi("tu154ce/elec/bat_is_source_2", 1) -- battery is power source
createGlobalPropertyi("tu154ce/elec/bat_is_source_3", 1) -- battery is power source
createGlobalPropertyi("tu154ce/elec/bat_is_source_4", 1) -- battery is power source
createGlobalPropertyi("tu154ce/elec/bat_connected", 0) -- is at least one battery connected (for FMOD)
createGlobalPropertyi("tu154ce/elec/bus_connected", 0) -- buses are connected
createGlobalPropertyf("tu154ce/elec/bus36_volt_left", 36) -- left 36V bus voltage
createGlobalPropertyf("tu154ce/elec/bus36_volt_right", 36) -- right 36V bus voltage
createGlobalPropertyf("tu154ce/elec/bus36_volt_pts250_1", 36) -- 36V bus voltage PTS 1
createGlobalPropertyf("tu154ce/elec/bus36_volt_pts250_2", 36) -- 36V bus voltage PTS 2
createGlobalPropertyf("tu154ce/elec/bus36_amp_left", 0) -- left 36V bus current
createGlobalPropertyf("tu154ce/elec/bus36_amp_right", 0) -- right 36V bus current
createGlobalPropertyf("tu154ce/elec/bus36_amp_pts250_1", 0) -- PTS250 bus 36 1 current
createGlobalPropertyf("tu154ce/elec/bus36_amp_pts250_2", 0) -- PTS250 bus 36 2 current
createGlobalPropertyi("tu154ce/elec/bus36_tr1_work", 1) -- transformer 1 operates
createGlobalPropertyi("tu154ce/elec/bus36_tr2_work", 1) -- transformer 2 operates
createGlobalPropertyi("tu154ce/elec/bus36_pts1_work", 1) -- PTS250 1 operates
createGlobalPropertyi("tu154ce/elec/bus36_pts2_work", 0) -- PTS250 2 operates
createGlobalPropertyi("tu154ce/elec/bus36_src_L", 0) -- left bus power source. 0 = TR1, 1 = TR2
createGlobalPropertyi("tu154ce/elec/bus36_src_R", 0) -- right bus power source. 0 = TR2, 1 = TR1
createGlobalPropertyi("tu154ce/elec/gen1_work", 1) -- generator 1 operates
createGlobalPropertyi("tu154ce/elec/gen2_work", 1) -- generator 2 operates
createGlobalPropertyi("tu154ce/elec/gen3_work", 1) -- generator 3 operates
createGlobalPropertyi("tu154ce/elec/gen4_work", 0) -- APU generator operates
createGlobalPropertyi("tu154ce/elec/gpu_work", 0) -- GPU operates
createGlobalPropertyi("tu154ce/elec/gen1_overload", 0) -- generator 1 overload
createGlobalPropertyi("tu154ce/elec/gen2_overload", 0) -- generator 2 overload
createGlobalPropertyi("tu154ce/elec/gen3_overload", 0) -- generator 3 overload
createGlobalPropertyi("tu154ce/elec/gen4_overload", 0) -- APU generator operates
createGlobalPropertyi("tu154ce/elec/gpu_overload", 0) -- GPU overload
createGlobalPropertyf("tu154ce/elec/gen1_volt", 115) -- generator voltage
createGlobalPropertyf("tu154ce/elec/gen2_volt", 115) -- generator voltage
createGlobalPropertyf("tu154ce/elec/gen3_volt", 115) -- generator voltage
createGlobalPropertyf("tu154ce/elec/gen4_volt", 115) -- generator voltage
createGlobalPropertyf("tu154ce/elec/gpu_volt", 115) -- generator voltage
createGlobalPropertyf("tu154ce/elec/bus115_1_volt", 115) -- 115V bus voltage
createGlobalPropertyf("tu154ce/elec/bus115_2_volt", 115) -- 115V bus voltage
createGlobalPropertyf("tu154ce/elec/bus115_3_volt", 115) -- 115V bus voltage
createGlobalPropertyf("tu154ce/elec/bus115_em_1_volt", 115) -- emergency 115V bus voltage
createGlobalPropertyf("tu154ce/elec/bus115_em_2_volt", 115) -- emergency 115V bus voltage
createGlobalPropertyf("tu154ce/elec/bus115_1_amp", 0) -- 115V bus current
createGlobalPropertyf("tu154ce/elec/bus115_2_amp", 0) -- 115V bus current
createGlobalPropertyf("tu154ce/elec/bus115_3_amp", 0) -- 115V bus current
createGlobalPropertyf("tu154ce/elec/bus115_em_1_amp", 0) -- 115V bus current
createGlobalPropertyf("tu154ce/elec/bus115_em_2_amp", 0) -- 115V bus current
createGlobalPropertyf("tu154ce/elec/gen1_amp", 0) -- generator load
createGlobalPropertyf("tu154ce/elec/gen2_amp", 0) -- generator load
createGlobalPropertyf("tu154ce/elec/gen3_amp", 0) -- generator load
createGlobalPropertyf("tu154ce/elec/gen4_amp", 0) -- generator load
createGlobalPropertyf("tu154ce/elec/gpu_amp", 0) -- generator load
createGlobalPropertyf("tu154ce/thermo/cockpit_temp", 20) -- cockpit temperature
createGlobalPropertyf("tu154ce/thermo/cabin1_temp", 20) -- cabin 1 temperature
createGlobalPropertyf("tu154ce/thermo/cabin2_temp", 20) -- cabin 2 temperature
createGlobalPropertyf("tu154ce/elec/apu_start_bus", 27) -- APU bus voltage
createGlobalPropertyf("tu154ce/elec/apu_start_cc", 0) -- APU starter current
createGlobalPropertyi("tu154ce/elec/apu_start_seq", 0) -- APU start sequence in progress
createGlobalPropertyf("tu154ce/elec/apu_burning_fuel", 0) -- APU starter current
createGlobalPropertyf("tu154ce/elec/cockpit_light_cc_left", 0) -- left bus load from cockpit lighting
createGlobalPropertyf("tu154ce/elec/cockpit_light_cc_right", 0) -- right bus load from cockpit lighting
createGlobalPropertyf("tu154ce/elec/cockpit_light_cc_115", 0) -- 115V bus load from cockpit lighting
createGlobalPropertyf("tu154ce/elec/ext_light_cc_left", 0) -- left bus load from exterior lighting
createGlobalPropertyf("tu154ce/elec/ext_light_cc_right", 0) -- left bus load from exterior lighting
createGlobalPropertyf("tu154ce/elec/ext_light_cc_115", 0) -- left bus load from exterior lighting
createGlobalPropertyf("tu154ce/eng/apu_n1", 0) -- APU RPM
createGlobalPropertyf("tu154ce/eng/apu_oil_t", 0) -- APU oil temperature
createGlobalPropertyf("tu154ce/eng/apu_oil_q", 0) -- APU oil quantity
createGlobalPropertyf("tu154ce/eng/apu_oil_p", 0) -- APU oil pressure
createGlobalPropertyf("tu154ce/eng/apu_fuel_p", 0) -- APU fuel pressure
createGlobalPropertyf("tu154ce/eng/apu_fuel_last", 0) -- APU fuel pressure
createGlobalPropertyf("tu154ce/eng/apu_egt", 0) -- APU exhaust gas temperature
createGlobalPropertyf("tu154ce/eng/apu_air_press", 0) -- air pressure for engine start
createGlobalPropertyf("tu154ce/eng/apu_air_doors", 0) -- air supply door position
createGlobalPropertyi("tu154ce/eng/apu_system_on", 0) -- APU system activation
createGlobalPropertyf("tu154ce/eng/vibration_1", 0) -- engine vibration
createGlobalPropertyf("tu154ce/eng/vibration_2", 0) -- engine vibration
createGlobalPropertyf("tu154ce/eng/vibration_3", 0) -- engine vibration
createGlobalPropertyi("tu154ce/fuel/eng_fuel_press_1", 1) -- fuel can be supplied to engine (regardless of fuel shutoff valves)
createGlobalPropertyi("tu154ce/fuel/eng_fuel_press_2", 1) -- fuel can be supplied to engine (regardless of fuel shutoff valves)
createGlobalPropertyi("tu154ce/fuel/eng_fuel_press_3", 1) -- fuel can be supplied to engine (regardless of fuel shutoff valves)
createGlobalPropertyi("tu154ce/fuel/pump_tank2_left_work", 1) -- tank 2 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank2_right_work", 1) -- tank 2 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank3_left_work", 1) -- tank 3 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank3_right_work", 1) -- tank 3 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank4_work", 1) -- tank 4 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank1_1_work", 1) -- tank 1 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank1_2_work", 1) -- tank 1 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank1_3_work", 1) -- tank 1 pumps
createGlobalPropertyi("tu154ce/fuel/pump_tank1_4_work", 1) -- tank 1 pumps
createGlobalPropertyi("tu154ce/fuel/reserv_trans", 0) -- reserve fuel transfer enabled
createGlobalPropertyi("tu154ce/fuel/auto_tanks_turn", 0) -- working sequential tanks. 0, 1 - not working, 2, 3, 4
createGlobalPropertyi("tu154ce/fuel/auto_tank_level_2", 0) -- balancing in tanks 2. -1 = L, 0 = none, +1 = R
createGlobalPropertyi("tu154ce/fuel/auto_tank_level_3", 0) -- balancing in tanks 3. -1 = L, 0 = none, +1 = R
createGlobalPropertyf("tu154ce/fuel/fire_vlv_open_1", 1) -- fire shutoff valve open
createGlobalPropertyf("tu154ce/fuel/fire_vlv_open_2", 1) -- fire shutoff valve open
createGlobalPropertyf("tu154ce/fuel/fire_vlv_open_3", 1) -- fire shutoff valve open
createGlobalPropertyf("tu154ce/elec/fuel_pumps_115_1_cc", 0) -- bus 1 load from fuel pumps
createGlobalPropertyf("tu154ce/elec/fuel_pumps_115_3_cc", 0) -- bus 3 load from fuel pumps
createGlobalPropertyf("tu154ce/elec/fuel_pumps_27_cc", 0) -- 27V bus load from fuel pumps
createGlobalPropertyf("tu154ce/hydro/gs_press_1", 0) -- pressure in GS1
createGlobalPropertyf("tu154ce/hydro/gs_press_2", 0) -- pressure in GS2
createGlobalPropertyf("tu154ce/hydro/gs_press_3", 0) -- pressure in GS3
createGlobalPropertyf("tu154ce/hydro/gs_press_4", 0) -- pressure in emergency brake system
createGlobalPropertyf("tu154ce/hydro/gs_qty_1", 55) -- system oil quantity
createGlobalPropertyf("tu154ce/hydro/gs_qty_2", 55) -- system oil quantity
createGlobalPropertyf("tu154ce/hydro/gs_qty_3", 49) -- system oil quantity
createGlobalPropertyf("tu154ce/hydro/gs_qty_12_show", 48) -- hydraulic reservoir oil quantity
createGlobalPropertyf("tu154ce/hydro/gs_qty_3_show", 24) -- hydraulic reservoir oil quantity
createGlobalPropertyf("tu154ce/hydro/gs_pump_2_cc", 0) -- pump station current
createGlobalPropertyf("tu154ce/hydro/gs_pump_3_cc", 0) -- pump station current
createGlobalPropertyf("tu154ce/hydro/gs_bak_qty_1", 17.17) -- oil quantity in the tank
createGlobalPropertyf("tu154ce/hydro/gs_bak_qty_2", 17.17) -- oil quantity in the tank
createGlobalPropertyf("tu154ce/hydro/gs_bak_qty_3", 23.8)  -- oil quantity in the tank
createGlobalPropertyf("tu154ce/bleed/air_usage_L", 0) -- left air consumption
createGlobalPropertyf("tu154ce/bleed/air_usage_R", 0) -- left air consumption
createGlobalPropertyf("tu154ce/bleed/eng_airvalve_1", 1) -- engine bleed air valve open
createGlobalPropertyf("tu154ce/bleed/eng_airvalve_2", 1) -- engine bleed air valve open
createGlobalPropertyf("tu154ce/bleed/eng_airvalve_3", 1) -- engine bleed air valve open
createGlobalPropertyf("tu154ce/bleed/hot_tube_t", 100) -- hot air temperature in pipeline
createGlobalPropertyf("tu154ce/bleed/door_heat_tube_t", 80) -- door heating pipeline temperature
createGlobalPropertyf("tu154ce/bleed/cockpit_tube_t", 30) -- cockpit pipeline temperature
createGlobalPropertyf("tu154ce/bleed/cabin1_tube_t", 30) -- cabin 1 pipeline temperature
createGlobalPropertyf("tu154ce/bleed/cabin2_tube_t", 30) -- cabin 2 pipeline temperature
createGlobalPropertyf("tu154ce/bleed/cold_tube1_t", 30) -- pipeline 1 temperature
createGlobalPropertyf("tu154ce/bleed/cold_tube2_t", 30) -- pipeline 2 temperature
createGlobalPropertyf("tu154ce/bleed/cockpit_temp", 20) -- cockpit temperature
createGlobalPropertyf("tu154ce/bleed/cabin_1_temp", 20) -- cabin 1 temperature
createGlobalPropertyf("tu154ce/bleed/cabin_2_temp", 20) -- cabin 2 temperature
createGlobalPropertyf("tu154ce/start/starter_pressure", 0) -- pressure in the engine start system
createGlobalPropertyi("tu154ce/start/apd_working_1", 0) -- APD system working
createGlobalPropertyi("tu154ce/start/apd_working_2", 0) -- APD system working
createGlobalPropertyi("tu154ce/start/apd_working_3", 0) -- APD system working
createGlobalPropertyi("tu154ce/start/start_sys_work", 0) -- start system working
createGlobalPropertyi("tu154ce/start/fuel_in_1", 1) -- fuel supplied by start system
createGlobalPropertyi("tu154ce/start/fuel_in_2", 1) -- fuel supplied by start system
createGlobalPropertyi("tu154ce/start/fuel_in_3", 1) -- fuel supplied by start system
createGlobalPropertyf("tu154ce/trimmers/int_pitch_trim", 0) -- elevator trim position
createGlobalPropertyf("tu154ce/trimmers/int_roll_trim", 0) -- aileron trim position
createGlobalPropertyf("tu154ce/trimmers/int_yaw_trim", 0) -- rudder trim position
createGlobalPropertyf("tu154ce/controls/control_force_pos", 0) -- elevator force feel unit position. 0 - off, 1 - connected
createGlobalPropertyf("tu154ce/controls/control_force_pos_rud", 0) -- rudder force feel unit position. 0 - off, 1 - connected
createGlobalPropertyi("tu154ce/fire/ext_used_1", 0) -- fire extinguisher used
createGlobalPropertyi("tu154ce/fire/ext_used_2", 0) -- fire extinguisher used
createGlobalPropertyi("tu154ce/fire/ext_used_3", 0) -- fire extinguisher used
createGlobalPropertyi("tu154ce/fire/ng_used", 0) -- NG used
createGlobalPropertyi("tu154ce/fire/valve_open_1", 0) -- fire shutoff valve for engine 1
createGlobalPropertyi("tu154ce/fire/valve_open_2", 0) -- fire shutoff valve for engine 2
createGlobalPropertyi("tu154ce/fire/valve_open_3", 0) -- fire shutoff valve for engine 3
createGlobalPropertyi("tu154ce/fire/valve_open_4", 0) -- fire shutoff valve for APU
createGlobalPropertyi("tu154ce/fire/fire_siren", 0) -- fire alarm siren working
createGlobalPropertyi("tu154ce/fire/engine_fire_state_1", 0) -- engine state. 0 - normal, 1 - overheat, 2 - fire
createGlobalPropertyi("tu154ce/fire/engine_fire_state_2", 0) -- engine state. 0 - normal, 1 - overheat, 2 - fire
createGlobalPropertyi("tu154ce/fire/engine_fire_state_3", 0) -- engine state. 0 - normal, 1 - overheat, 2 - fire
createGlobalPropertyi("tu154ce/fire/engine_fire_state_4", 0) -- APU state. 0 - normal, 1 - overheat, 2 - fire
createGlobalPropertyi("tu154ce/fire/engine_fuel_cut_1", 0) -- fuel cut off
createGlobalPropertyi("tu154ce/fire/engine_fuel_cut_2", 0) -- fuel cut off
createGlobalPropertyi("tu154ce/fire/engine_fuel_cut_3", 0) -- fuel cut off
createGlobalPropertyi("tu154ce/fire/fire_detected", 0) -- fire detected
createGlobalPropertyf("tu154ce/fire/fire_sys_cc", 0) -- fire system current consumption
createGlobalPropertyf("tu154ce/antiice/wing_heat_t", 15) -- wing heating temperature
createGlobalPropertyf("tu154ce/antiice/stab_heat_t", 15) -- stabilizer heating temperature
createGlobalPropertyi("tu154ce/antiice/ice_detected", 0) -- ice detected
createGlobalPropertyi("tu154ce/antiice/ice_detect_ok", 0) -- SOI system operational
createGlobalPropertyi("tu154ce/antiice/wing_heating", 1) -- wing heating is working
createGlobalPropertyi("tu154ce/antiice/slat_heating", 1) -- slat heating is working
createGlobalPropertyf("tu154ce/antiice/ai_27_L_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/antiice/ai_27_R_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/antiice/ai_115_1_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/antiice/ai_115_2_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/antiice/ai_115_3_cc", 0) -- bus load
createGlobalPropertyi("tu154ce/antiice/eng_heat_open_1", 0) -- engine anti-ice valve open
createGlobalPropertyi("tu154ce/antiice/eng_heat_open_2", 0) -- engine anti-ice valve open
createGlobalPropertyi("tu154ce/antiice/eng_heat_open_3", 0) -- engine anti-ice valve open
createGlobalPropertyi("tu154ce/msrp/msrp_power", 1) -- MSRP power for clock indicator
createGlobalPropertyi("tu154ce/msrp/msrp_recording", 1) -- MSRP power for clock indicator
createGlobalPropertyf("tu154ce/msrp/msrp_27_L_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/msrp/msrp_27_R_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_27_L_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_27_R_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_115_1_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_115_2_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_115_3_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_36L_cc", 0) -- bus load
createGlobalPropertyf("tu154ce/control/ctr_36R_cc", 0) -- bus load
createGlobalPropertyi("tu154ce/auasp/alpha_critical", 0) -- signal from AUASP on critical AoA
createGlobalPropertyi("tu154ce/auasp/gforce_critical", 0) -- signal from AUASP on critical G-load
createGlobalPropertyf("tu154ce/gyro/mgv_contr_roll", 0) -- control gyro roll
createGlobalPropertyf("tu154ce/gyro/mgv_contr_pitch", 0) -- control gyro pitch
createGlobalPropertyi("tu154ce/gyro/mgv_contr_flag", 0) -- MGV control failure flag
createGlobalPropertyi("tu154ce/bkk/left_roll_big", 0) -- signal from BKK - large left roll
createGlobalPropertyi("tu154ce/bkk/right_roll_big", 0) -- signal from BKK - large right roll
createGlobalPropertyi("tu154ce/bkk/mgv_contr_fail", 0) -- signal from BKK - MGV control failure
createGlobalPropertyi("tu154ce/bkk/no_contr_ag", 0) -- signal from BKK - no AG control
createGlobalPropertyi("tu154ce/bkk/pkp_fail_left", 0) -- signal from BKK - left PKP failure
createGlobalPropertyi("tu154ce/bkk/pkp_fail_right", 0) -- signal from BKK - left PKP failure
createGlobalPropertyf("tu154ce/bkk/pkp_roll_left", 0) -- left MGV roll
createGlobalPropertyf("tu154ce/bkk/pkp_roll_right", 0) -- right MGV roll
createGlobalPropertyf("tu154ce/bkk/pkp_left_power_cc", 0) -- PKP current consumption
createGlobalPropertyf("tu154ce/bkk/pkp_right_power_cc", 0) -- PKP current consumption
createGlobalPropertyf("tu154ce/bkk/mgv_ctr_power_cc", 0) -- PKP current consumption
createGlobalPropertyf("tu154ce/gyro/ahz_pitch_int_L", 0) -- left gyro pitch
createGlobalPropertyf("tu154ce/gyro/ahz_pitch_int_R", 0) -- right gyro pitch
createGlobalPropertyi("tu154ce/tcas/range_set", 3) -- display range. 0 = 3, 1 = 5, 2 = 10, 3 = 15 nm
createGlobalPropertyi("tu154ce/tcas/mode_set", 4) -- TCAS mode. -1 = test, 0 - stby, 1 = alt off, 2 = alt on, 3 = TA, 4 = TARA
createGlobalPropertyi("tu154ce/tcas/screen_mode", 0) -- TCAS display mode. -1 = error, 0 = transponder code, 1 = above mode, 2 = FL mode, 3 = FLT ID, 4 = PLN BIT, 5 = test, 6 = range set, 11-14 = code set, 100 = no power
createGlobalPropertyi("tu154ce/tcas/level_mode", 0) -- 1 = above, 0 = normal, -1 = below
createGlobalPropertyi("tu154ce/tcas/fl_mode", 0) -- fl mode. 0 = absolute, 1 = relative
createGlobalPropertyi("tu154ce/tcas/flt_id", 0) -- flight ID. 0 = cover, 1 = show / change code
createGlobalPropertyi("tu154ce/tcas/ra_scale_set", 0) -- RA mode scale set. 0 = none.
createGlobalPropertyi("tu154ce/tcas/traffic_det", 0) -- appearance of yellow or red marks
createGlobalPropertyf("tu154ce/svs/altitude", 0) -- altitude from SVS
createGlobalPropertyf("tu154ce/svs/machno", 0) -- mach number from SVS
createGlobalPropertyf("tu154ce/svs/true_airspeed", 0) -- TAS from SVS
createGlobalPropertyf("tu154ce/svs/power_27cc", 0) -- current consumed by SVS
createGlobalPropertyf("tu154ce/svs/power_36cc", 0) -- current consumed by SVS
createGlobalPropertyf("tu154ce/svs/power_115cc", 0) -- current consumed by SVS
createGlobalPropertyf("tu154ce/elec/auasp_pow27_cc", 0) -- current consumed by AUASP
createGlobalPropertyf("tu154ce/elec/auasp_pow115_cc", 0) -- current consumed by AUASP
createGlobalPropertyf("tu154ce/elec/rv5_left_cc", 0) -- current consumed by RV-5
createGlobalPropertyf("tu154ce/elec/rv5_right_cc", 0) -- current consumed by RV-5
createGlobalPropertyf("tu154ce/misc/rv5_alt_left", 0) -- altitude on the left altimeter
createGlobalPropertyf("tu154ce/misc/rv5_alt_right", 0) -- altitude on the right altimeter
createGlobalPropertyi("tu154ce/misc/rv5_dh_signal_left", 0) -- DH signal
createGlobalPropertyi("tu154ce/misc/rv5_dh_signal_right", 0) -- DH signal
createGlobalPropertyi("tu154ce/taws/mode_set", 1) -- screen mode. 0 - off, 1 - terrain map, 2 - side view, 3 - clock, 4 - startup process
createGlobalPropertyi("tu154ce/taws/distance_set", 0) -- map drawing distance, km. 0 = 10, 1 = 20, 2 = 40, 3 = 80, 4 = 160, 5 = 320, 6 = 640
createGlobalPropertyf("tu154ce/taws/taws_cc", 0) -- current consumption by TAWS
createGlobalPropertyi("tu154ce/taws/taws_message", 0) -- TAWS messages. 0 - none, 1 - Pull UP, 2 - alt callout, 3 - Pull Up, 4 - Terrain, 5 - Terrain Ahead, 6 - Too low, Terrain, 7 - Alt callout, 8 - Too low, Gear, 9 - Too low, Flaps, 10 - Check altitude, 11 - Sink Rate, 12 - Don't sink, 13 - Glideslope
createGlobalPropertyi("tu154ce/taws/taws_english", 1) -- system language. 0 - Russian, 1 - English
createGlobalPropertyf("tu154ce/taws/gs_msg_int", 5) -- glideslope signal interval
createGlobalPropertyf("tu154ce/taws/gs_msg_vol", 1) -- glideslope signal volume
createGlobalPropertyi("tu154ce/taws/taws_alt_left", 0) -- compare altitude on the left altimeter
createGlobalPropertyi("tu154ce/taws/taws_alt_right", 0) -- compare altitude on the right altimeter
createGlobalPropertyf("tu154ce/tks/course_mk_1", 0) -- course to MK5
createGlobalPropertyf("tu154ce/tks/course_mk_2", 0) -- course to MK5
createGlobalPropertyf("tu154ce/tks/course_ga_1", 0) -- course to GA1
createGlobalPropertyf("tu154ce/tks/course_ga_2", 0) -- course to GA1
createGlobalPropertyf("tu154ce/tks/course_bgmk_1", 0) -- course to BGMK1
createGlobalPropertyf("tu154ce/tks/course_bgmk_2", 0) -- course to BGMK1
createGlobalPropertyf("tu154ce/tks/course_gpk", 0) -- resulting course TKS - GPK
createGlobalPropertyf("tu154ce/tks/course_gmk", 0) -- resulting course TKS - GMK
createGlobalPropertyi("tu154ce/tks/fail_left", 0) -- failure flag
createGlobalPropertyi("tu154ce/tks/fail_right", 0) -- failure flag
createGlobalPropertyf("tu154ce/nvu/diss_wind_course", 0) -- wind direction by DISS
createGlobalPropertyf("tu154ce/nvu/diss_wind_spd", 0) -- wind speed by DISS
createGlobalPropertyf("tu154ce/nvu/diss_groundspeed", 0) -- ground speed by DISS
createGlobalPropertyf("tu154ce/nvu/diss_slip_angle", 0) -- drift angle by DISS
createGlobalPropertyi("tu154ce/nvu/diss_mode", 1) -- DISS mode. 0 - off, 1 - working, 2 - memory
createGlobalPropertyf("tu154ce/rsbn/distance", 0) -- geometric distance from beacon
createGlobalPropertyf("tu154ce/rsbn/azimuth", 0) -- azimuth from beacon
createGlobalPropertyf("tu154ce/radio/adf_bear_1", 0) -- ADF beacon bearing
createGlobalPropertyf("tu154ce/radio/adf_bear_2", 0) -- ADF beacon bearing
createGlobalPropertyf("tu154ce/radio/vor_bear_1", 0) -- VOR beacon bearing
createGlobalPropertyf("tu154ce/radio/vor_bear_2", 0) -- VOR beacon bearing
createGlobalPropertyf("tu154ce/radio/vor_dme_1", 0) -- distance to VOR
createGlobalPropertyf("tu154ce/radio/vor_dme_2", 0) -- distance to VOR
createGlobalPropertyf("tu154ce/radio/nav1_cs", 0) -- deviation of the course bar
createGlobalPropertyf("tu154ce/radio/nav1_gs", 0) -- deviation of the glideslope bar
createGlobalPropertyf("tu154ce/radio/nav2_cs", 0) -- deviation of the course bar
createGlobalPropertyf("tu154ce/radio/nav2_gs", 0) -- deviation of the glideslope bar
createGlobalPropertyi("tu154ce/radio/nav1_cs_flag", 0) -- course flag
createGlobalPropertyi("tu154ce/radio/nav2_cs_flag", 0) -- course flag
createGlobalPropertyi("tu154ce/radio/nav1_gs_flag", 0) -- glideslope flag
createGlobalPropertyi("tu154ce/radio/nav2_gs_flag", 0) -- glideslope flag
createGlobalPropertyf("tu154ce/nvu/current_Z1", 0) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_S1", 0) -- S1
createGlobalPropertyf("tu154ce/nvu/next_Z1", 0) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_S1", 0) -- S1
createGlobalPropertyf("tu154ce/nvu/current_Z2", 0) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_S2", 0) -- S2
createGlobalPropertyf("tu154ce/nvu/next_Z2", 0) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_S2", 0) -- S2
createGlobalPropertyf("tu154ce/nvu/zpu1", 0) -- Z2
createGlobalPropertyf("tu154ce/nvu/zpu2", 0) -- S2
createGlobalPropertyi("tu154ce/nvu/nvu_mode", 1) -- NVU mode. 0 = off, 1 = ready, 2 = navigation, 3 = correction
createGlobalPropertyi("tu154ce/nvu/nvu_active", 1) -- active NVU set. 1 - 2
createGlobalPropertyf("tu154ce/nvu/nvu_res_course", 0) -- flight course by NVU
createGlobalPropertyf("tu154ce/nvu/nvu_res_z", 0) -- deviation from NVU flight course
createGlobalPropertyi("tu154ce/nvu/nvu_changing_ort", 0) -- change of ORT
createGlobalPropertyi("tu154ce/nvu/nvu_fail", 0) -- failure or not enough systems for NVU
createGlobalPropertyi("tu154ce/absu/roll_main_mode", 1) -- main ABZU roll mode. 0 - off, 1 - yoke, 2 - stabilizer
createGlobalPropertyi("tu154ce/absu/pitch_main_mode", 1) -- main ABZU pitch mode. 0 - off, 1 - yoke, 2 - stabilizer
createGlobalPropertyi("tu154ce/absu/roll_sub_mode", 0) -- ABZU roll mode. 0 - off, 1 - stabilizer, 2 - ZK, 3 - NVU, 4 - AZ1, 5 - AZ2, 6 - approach
createGlobalPropertyi("tu154ce/absu/pitch_sub_mode", 0) -- ABZU pitch mode. 0 - off, 1 - stabilizer, 2 - V, 3 - M, 4 - H, 5 - glideslope, 6 - go-around
createGlobalPropertyf("tu154ce/absu/contr_pitch", 0) -- RA56 actuator deflection in pitch
createGlobalPropertyf("tu154ce/absu/contr_roll", 0) -- RA56 actuator deflection in roll
createGlobalPropertyf("tu154ce/absu/contr_yaw", 0) -- RA56 actuator deflection in yaw
createGlobalPropertyf("tu154ce/bkk/bkk_pitch", 0) -- resulting pitch from BKK
createGlobalPropertyf("tu154ce/bkk/bkk_roll", 0) -- resulting roll from BKK
createGlobalPropertyi("tu154ce/absu/absu_pitch_trimm", 0) -- trim command from ABZU. +1 = up, -1 = down
createGlobalPropertyf("tu154ce/absu/rud_1_spd", 0) -- lever position change speed
createGlobalPropertyf("tu154ce/absu/rud_2_spd", 0) -- lever position change speed
createGlobalPropertyf("tu154ce/absu/rud_3_spd", 0) -- lever position change speed
createGlobalPropertyf("tu154ce/absu/absu_roll_ind", 0) -- roll director indication
createGlobalPropertyf("tu154ce/absu/absu_pitch_ind", 0) -- pitch director indication
createGlobalPropertyi("tu154ce/absu/absu_roll_flag", 1) -- roll director flag
createGlobalPropertyi("tu154ce/absu/absu_pitch_flag", 1) -- pitch director flag
createGlobalPropertyi("tu154ce/absu/absu_pnp_mode_1", 0) -- PNP indication mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
createGlobalPropertyi("tu154ce/absu/absu_pnp_mode_2", 0) -- PNP indication mode. 0 = off, 1 = NVU, 2 = VOR1, 3 = VOR2, 4 = PS
createGlobalPropertyi("tu154ce/absu/stu_mode", 0) -- autothrottle modes 0 - off, 1 - on, 2 - ready, 3 - stabilizer, 4 - go-around
createGlobalPropertyi("tu154ce/absu/toga_comm", 0) -- TOGA mode
createGlobalPropertyf("tu154ce/absu_at_dif_left", 0) -- speed difference for PKP indication
createGlobalPropertyf("tu154ce/absu_at_dif_right", 0) -- speed difference for PKP indication
createGlobalPropertyi("tu154ce/absu_course_out", 0) -- flying outside the course limits
createGlobalPropertyi("tu154ce/absu_gs_out", 0) -- flying outside the glideslope limits
createGlobalPropertyf("tu154ce/absu_power_cc", 0) -- current consumption by ABZU
createGlobalPropertyf("tu154ce/absu_at_power_cc", 0) -- current consumption by ABZU
createGlobalPropertyi("tu154ce/absu_use_second_nav", 0) -- ABZU switched to second KursMP
createGlobalPropertyi("tu154ce/absu/damp_roll_lamp", 0) -- lamp signal: roll damper failure
createGlobalPropertyi("tu154ce/absu/damp_pitch_lamp", 0) -- lamp signal: pitch damper failure
createGlobalPropertyi("tu154ce/absu/damp_yaw_lamp", 0) -- lamp signal: yaw damper failure
createGlobalPropertyi("tu154ce/absu/roll_contr_lamp", 0) -- lamp signal: roll control failure
createGlobalPropertyi("tu154ce/absu/pitch_contr_lamp", 0) -- lamp signal: pitch control failure
createGlobalPropertyi("tu154ce/absu/man_roll_lamp", 0) -- lamp signal: control roll manually
createGlobalPropertyi("tu154ce/absu/man_pitch_lamp", 0) -- lamp signal: control pitch manually
createGlobalPropertyi("tu154ce/absu/man_toga_lamp", 0) -- lamp signal: control go-around manually
createGlobalPropertyi("tu154ce/absu/triangle_lamp_signal", 0) -- lamp signal: triangle
createGlobalPropertyi("tu154ce/absu/absu_fail_signal", 0) -- siren signal
createGlobalPropertyf("tu154ce/kln90/kln_course", 0) -- LNAV course from KLN
createGlobalPropertyf("tu154ce/kln90/kln_dev", 0) -- LNAV course deviation, miles
createGlobalPropertyi("tu154ce/kln90/kln_flag", 0) -- KLN course flag. 0 = no flag, 1 = flag
createGlobalPropertyf("tu154ce/radio/vhf1_cc", 0) -- current consumption by radio
createGlobalPropertyf("tu154ce/radio/vhf2_cc", 0) -- current consumption by radio
createGlobalPropertyf("tu154ce/tks/km5_1_cc", 0) -- current consumption by KM5
createGlobalPropertyf("tu154ce/tks/km5_2_cc", 0) -- current consumption by KM5
createGlobalPropertyf("tu154ce/tks/ga_1_cc", 0) -- current consumption by GA
createGlobalPropertyf("tu154ce/tks/ga_2_cc", 0) -- current consumption by GA
createGlobalPropertyf("tu154ce/tks/ga_heat_cc", 0) -- current consumption by GA heating
createGlobalPropertyf("tu154ce/tks/bgmk_1_cc", 0) -- current consumption by BGMK
createGlobalPropertyf("tu154ce/tks/bgmk_2_cc", 0) -- current consumption by BGMK
createGlobalPropertyf("tu154ce/tks/ush_cc", 0) -- current consumption by USH
createGlobalPropertyf("tu154ce/ahz/agr_cc", 0) -- current consumption by AGR
createGlobalPropertyf("tu154ce/nvu/nvu_cc", 0) -- current consumption by NVU
createGlobalPropertyf("tu154ce/radio/ark15_L_cc", 0) -- current consumption by ARK
createGlobalPropertyf("tu154ce/radio/ark15_R_cc", 0) -- current consumption by ARK
createGlobalPropertyf("tu154ce/nvu/diss_cc", 0) -- current consumption by DISS
createGlobalPropertyf("tu154ce/radio/nav1_pow_cc", 0) -- current consumption by KursMP
createGlobalPropertyf("tu154ce/radio/nav2_pow_cc", 0) -- current consumption by KursMP
createGlobalPropertyf("tu154ce/radio/radar_cc", 0) -- current consumption by Groza radar
createGlobalPropertyf("tu154ce/radio/rsbn_cc", 0) -- current consumption by RSBN
createGlobalPropertyi("tu154ce/payload/crew_num", 3) -- crew in the cockpit
createGlobalPropertyi("tu154ce/payload/zone_1", 9) -- passengers
createGlobalPropertyi("tu154ce/payload/zone_2", 22) -- passengers
createGlobalPropertyi("tu154ce/payload/cabin_num", 4) -- cabin crew
createGlobalPropertyi("tu154ce/payload/zone_4", 24) -- passengers
createGlobalPropertyi("tu154ce/payload/zone_5", 21) -- passengers
createGlobalPropertyi("tu154ce/payload/zone_6", 7) -- passengers
createGlobalPropertyi("tu154ce/payload/cargo_1", 2500) -- baggage 1
createGlobalPropertyi("tu154ce/payload/cargo_2", 1200) -- baggage 2
createGlobalPropertyi("tu154ce/payload/kitchens", 300) -- galley load
createGlobalPropertyi("tu154ce/payload/various", 50) -- miscellaneous
createGlobalPropertyi("tu154ce/payload/main_dist", 1000) -- distance to main airport
createGlobalPropertyi("tu154ce/payload/alt_dist", 500) -- distance to alternate airport
createGlobalPropertyi("tu154ce/payload/main_fl", 380) -- flight level to main
createGlobalPropertyi("tu154ce/payload/alt_fl", 320) -- flight level to alternate
createGlobalPropertyi("tu154ce/payload/nav_fuel", 2500) -- navigation reserve
createGlobalPropertyi("tu154ce/payload/taxi_fuel", 100) -- taxi fuel
createGlobalPropertyi("tu154ce/payload/tank_1", 3300) -- fuel in tank
createGlobalPropertyi("tu154ce/payload/tank_4", 0) -- fuel in tank
createGlobalPropertyi("tu154ce/payload/tank_2L", 1500) -- fuel in tank
createGlobalPropertyi("tu154ce/payload/tank_2R", 1500) -- fuel in tank
createGlobalPropertyi("tu154ce/payload/tank_3L", 3225) -- fuel in tank
createGlobalPropertyi("tu154ce/payload/tank_3R", 3225) -- fuel in tank
createGlobalPropertyi("tu154ce/payload/load_fuel_btn", 0) -- fuel load button
createGlobalPropertyi("tu154ce/payload/load_fast_btn", 0) -- quick load button
createGlobalPropertyi("tu154ce/payload/load_slow_btn", 0) -- slow load button
createGlobalPropertyf("tu154ce/payload/paylod_set", 0) -- must load
createGlobalPropertyf("tu154ce/payload/cg_set", 0) -- must load
createGlobalPropertyi("tu154ce/sounds/taws_eng_phrase", 0) -- TAWS phrase number in English
createGlobalPropertyi("tu154ce/sounds/taws_rus_phrase", 0) -- TAWS phrase number in Russian
createGlobalPropertyi("tu154ce/sounds/enable_crew_vo", 1) -- crew voice phrases enabled
createGlobalPropertyi("tu154ce/alarm/main_gear_flaps", 0) -- flaps not in takeoff position or gear not extended
createGlobalPropertyi("tu154ce/alarm/main_pressure", 0) -- decompression or cabin overpressure
createGlobalPropertyi("tu154ce/alarm/speaker_auasp", 0) -- critical angle of attack or G load
createGlobalPropertyi("tu154ce/alarm/speaker_fuel", 0) -- remaining fuel 2500 in tank 1
createGlobalPropertyi("tu154ce/alarm/speaker_speed", 0) -- overspeed
createGlobalPropertyi("tu154ce/alarm/speaker_absu", 0) -- ABZU modes off or ABZU failures
createGlobalPropertyi("tu154ce/checklist/side", 0) -- which side to show. 0 - before takeoff, 1 - before approach
createGlobalPropertyi("tu154ce/checklist/fishka_1", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_2", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_3", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_4", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_5", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_6", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_7", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_8", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_9", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_10", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_11", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_12", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_13", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_14", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_15", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_16", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_17", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_18", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_19", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/checklist/fishka_20", 1) -- fishka position. 0 - left, 1 - right
createGlobalPropertyi("tu154ce/panels/show_load_panel", 0) -- show load panel
createGlobalPropertyi("tu154ce/panels/show_absu_panel", 0) -- show ABZU panel
createGlobalPropertyi("tu154ce/panels/show_ohvd_panel", 0) -- show overhead panel
createGlobalPropertyi("tu154ce/panels/show_nvu_panel", 0) -- show NVU panel
createGlobalPropertyi("tu154ce/panels/show_checklist_panel", 0) -- show checklist panel
createGlobalPropertyi("tu154ce/panels/show_ground_panel", 0) -- show ground handling panel
createGlobalPropertyi("tu154ce/panels/show_phone", 0) -- show phone panel
createGlobalPropertyi("tu154ce/panels/show_cam", 0) -- show camera panel
createGlobalPropertyi("tu154ce/panels/show_palette", 0) -- show palette
createGlobalPropertyi("tu154ce/panels/show_fail_panel", 0) -- show failure palette
createGlobalPropertyf("tu154ce/misc/cg_pos_actual", 0) -- actual CG position
createGlobalPropertyf("tu154ce/misc/weight_actual", 0) -- actual weight
createGlobalPropertyf("tu154ce/anim/rain_glass_1", 0) -- mask brightness with rain on glass
createGlobalPropertyf("tu154ce/anim/rain_glass_2", 0) -- mask brightness with rain on glass
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_1_L", 0) -- mask brightness with rain on left glass, sector 1
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_2_L", 0) -- mask brightness with rain on left glass, sector 2
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_3_L", 0) -- mask brightness with rain on left glass, sector 3
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_4_L", 0) -- mask brightness with rain on left glass, sector 4
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_5_L", 0) -- mask brightness with rain on left glass, sector 5
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_1_L", 0) -- mask brightness with rain on left glass, sector 1
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_2_L", 0) -- mask brightness with rain on left glass, sector 2
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_3_L", 0) -- mask brightness with rain on left glass, sector 3
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_4_L", 0) -- mask brightness with rain on left glass, sector 4
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_5_L", 0) -- mask brightness with rain on left glass, sector 5
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_1_R", 0) -- mask brightness with rain on right glass, sector 1
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_2_R", 0) -- mask brightness with rain on right glass, sector 2
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_3_R", 0) -- mask brightness with rain on right glass, sector 3
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_4_R", 0) -- mask brightness with rain on right glass, sector 4
createGlobalPropertyf("tu154ce/anim/rain_glass_1_w_5_R", 0) -- mask brightness with rain on right glass, sector 5
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_1_R", 0) -- mask brightness with rain on right glass, sector 1
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_2_R", 0) -- mask brightness with rain on right glass, sector 2
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_3_R", 0) -- mask brightness with rain on right glass, sector 3
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_4_R", 0) -- mask brightness with rain on right glass, sector 4
createGlobalPropertyf("tu154ce/anim/rain_glass_2_w_5_R", 0) -- mask brightness with rain on right glass, sector 5
createGlobalPropertyf("tu154ce/anim/net_rain_ratio", 0) -- actual amount of precipitation on the windows
createGlobalPropertyf("tu154ce/misc/water_level", 0) -- water level
createGlobalPropertyf("tu154ce/gauges/alt/vbe_flightlevel_left", 0) -- set altitude on VBE
createGlobalPropertyf("tu154ce/gauges/alt/vbe_flightlevel_right", 0) -- set altitude on VBE
createGlobalPropertyf("tu154ce/brakes/int_brakes_L", 0) -- actual brake position
createGlobalPropertyf("tu154ce/brakes/int_brakes_R", 0) -- actual brake position
createGlobalPropertyf("tu154ce/gauges/vvi_left", 0) -- variometer reading
createGlobalPropertyf("tu154ce/gauges/vvi_right", 0) -- variometer reading
createGlobalPropertyi("tu154ce/SC/control_thro_other", 0) -- another person is controlling the throttles
createGlobalPropertyf("tu154ce/SC/yoke_pitch_ratio", 0) -- pitch control
createGlobalPropertyf("tu154ce/SC/yoke_roll_ratio", 0) -- roll control
createGlobalPropertyf("tu154ce/SC/yoke_heading_ratio", 0) -- rudder pedal control
createGlobalPropertyf("tu154ce/SC/engine/ENGN_thro_0", 0) -- throttle control
createGlobalPropertyf("tu154ce/SC/engine/ENGN_thro_1", 0) -- throttle control
createGlobalPropertyf("tu154ce/SC/engine/ENGN_thro_2", 0) -- throttle control
createGlobalPropertyf("tu154ce/SC/engine/ENGN_propmode_0", 0) -- reverse control
createGlobalPropertyf("tu154ce/SC/engine/ENGN_propmode_2", 0) -- reverse control
createGlobalPropertyf("tu154ce/SC/gear/tire_steer_command_deg", 0) -- nose wheel steering
createGlobalPropertyf("tu154ce/SC/controls/l_brake_add", 0) -- brake control
createGlobalPropertyf("tu154ce/SC/controls/r_brake_add", 0) -- brake control
createGlobalPropertyf("tu154ce/SC/brakes/int_brakes_L", 0) -- brake control
createGlobalPropertyf("tu154ce/SC/brakes/int_brakes_R", 0) -- brake control
createGlobalPropertyf("tu154ce/SC/controls/parkbrake", 0) -- brake control
createGlobalPropertyi("tu154ce/speeds/v1_15", 0) -- V1 speed
createGlobalPropertyi("tu154ce/speeds/vr_15", 0) -- Vr speed
createGlobalPropertyi("tu154ce/speeds/v2_15", 0) -- V2 speed
createGlobalPropertyi("tu154ce/speeds/v1_28", 0) -- V1 speed
createGlobalPropertyi("tu154ce/speeds/vr_28", 0) -- Vr speed
createGlobalPropertyi("tu154ce/speeds/v2_28", 0) -- V2 speed
createGlobalPropertyi("tu154ce/checklist/checklist_selected", 0) -- checklist selection
createGlobalPropertyi("tu154ce/checklist/to_ready", 0) -- lamp is on
createGlobalPropertyi("tu154ce/sound/reset_crew", 0) -- reset crew phrases
createGlobalPropertyf("tu154ce/SC/GNS430_dtk", 0) -- course to GNS
createGlobalPropertyf("tu154ce/SC/GNS430_dev", 0) -- course deviation to GNS
createGlobalPropertyi("tu154ce/SC/GNS430_flag", 0) -- GNS flag
