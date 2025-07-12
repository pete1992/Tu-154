-- absu.lua
-- duplicates removed, batch definition, correct array handling
-- 
local props = {
		-- Indicated Airspeed
		{ "ias_left", "tu154ce/gauges/speed/ias_left", "f" },
		{ "ias_right","tu154ce/gauges/speed/ias_right","f" },
		-- ABSU Controls
		{ "absu_speed_change","tu154ce/switchers/console/absu_speed_change", "i" },
		{ "absu_speed_off", "tu154ce/switchers/console/absu_speed_off","i" },
		{ "absu_speed_prepare", "tu154ce/switchers/console/absu_speed_prepare","i" },
		{ "absu_speed_us_right_left", "tu154ce/switchers/console/absu_speed_us_right_left","i" },
		-- ABSU Panel Buttons
		{ "absu_stab_speed","tu154ce/buttons/console/absu_stab_speed", "i" },
		{ "absu_throt_off_1", "tu154ce/buttons/console/absu_throt_off_1","i" },
		{ "absu_throt_off_2", "tu154ce/buttons/console/absu_throt_off_2","i" },
		{ "absu_throt_off_3", "tu154ce/buttons/console/absu_throt_off_3","i" },
		{ "absu_zk","tu154ce/buttons/console/absu_zk", "i" },
		{ "absu_reset", "tu154ce/buttons/console/absu_reset","i" },
		{ "absu_nvu", "tu154ce/buttons/console/absu_nvu","i" },
		{ "absu_app", "tu154ce/buttons/console/absu_app","i" },
		{ "absu_gs","tu154ce/buttons/console/absu_gs", "i" },
		{ "absu_stab_m","tu154ce/buttons/console/absu_stab_m", "i" },
		{ "absu_stab_v","tu154ce/buttons/console/absu_stab_v", "i" },
		{ "absu_stab_h","tu154ce/buttons/console/absu_stab_h", "i" },
		{ "absu_stab","tu154ce/buttons/console/absu_stab", "i" },
		{ "absu_arrest","tu154ce/buttons/console/absu_arrest", "i" },
		{ "absu_speed_test_1","tu154ce/buttons/console/absu_speed_test_1", "i" },
		{ "absu_speed_test_2","tu154ce/buttons/console/absu_speed_test_2", "i" },
		-- Throttle Animation & Smart Copilot Throttle
		{ "anim_rud1","tu154ce/controlls/throttle_1","f" },
		{ "anim_rud2","tu154ce/controlls/throttle_2","f" },
		{ "anim_rud3","tu154ce/controlls/throttle_3","f" },
		{ "tro_comm_1", "tu154ce/SC/engine/ENGN_thro_0", "f" },
		{ "tro_comm_2", "tu154ce/SC/engine/ENGN_thro_1", "f" },
		{ "tro_comm_3", "tu154ce/SC/engine/ENGN_thro_2", "f" },
		-- ABSU Panel Switches
		{ "absu_nav_on","tu154ce/switchers/console/absu_nav_on", "i" },
		{ "absu_landing_on","tu154ce/switchers/console/absu_landing_on", "i" },
		{ "absu_needles_on","tu154ce/switchers/console/absu_needles_on", "i" },
		{ "absu_turn_handle", "tu154ce/switchers/console/absu_turn_handle","i" },
		{ "absu_pitch_wheel", "tu154ce/switchers/console/absu_pitch_wheel","f" },
		{ "absu_pitch_wheel_dir", "tu154ce/switchers/console/absu_pitch_wheel_dir","i" },
		{ "absu_smooth_on", "tu154ce/switchers/console/absu_smooth_on","i" },
		-- ABSU Modes
		{ "roll_main_mode", "tu154ce/absu/roll_main_mode", "i" },
		{ "pitch_main_mode","tu154ce/absu/pitch_main_mode","i" },
		{ "roll_sub_mode","tu154ce/absu/roll_sub_mode","i" },
		{ "pitch_sub_mode", "tu154ce/absu/pitch_sub_mode", "i" },
		-- Power Busses
		{ "bus27_volt_left","tu154ce/elec/bus27_volt_left","f" },
		{ "bus27_volt_right", "tu154ce/elec/bus27_volt_right", "f" },
		{ "bus36_volt_left","tu154ce/elec/bus36_volt_left","f" },
		{ "bus115_1_volt","tu154ce/elec/bus115_1_volt","f" },
		-- Frame/Timing
		{ "frame_time", "tu154ce/time/frame_time", "f" },
		-- Airspeed Markers & ABSU AT indicators
		{ "ias_yellow_left","tu154ce/gauges/speed/ias_yellow_left","f" },
		{ "ias_yellow_right", "tu154ce/gauges/speed/ias_yellow_right", "f" },
		{ "absu_at_dif_left", "tu154ce/absu_at_dif_left","f" },
		{ "absu_at_dif_right","tu154ce/absu_at_dif_right", "f" },
		{ "absu_at_power_cc", "tu154ce/absu_at_power_cc","f" },
		-- Throttle Movement Speeds
		{ "rud_1_spd","tu154ce/absu/rud_1_spd","f" },
		{ "rud_2_spd","tu154ce/absu/rud_2_spd","f" },
		{ "rud_3_spd","tu154ce/absu/rud_3_spd","f" },
		-- Auto-Throttle Mode
		{ "stu_mode", "tu154ce/absu/stu_mode", "i" },
		{ "toga_command", "tu154ce/absu/toga_comm","i" },
		-- Failures
		{ "absu_at1_fail","tu154ce/failures/absu_at1_fail","i" },
		{ "absu_at2_fail","tu154ce/failures/absu_at2_fail","i" },
		{ "absu_ra56_roll_fail","tu154ce/failures/absu_ra56_roll_fail","i" },
		{ "absu_ra56_pitch_fail", "tu154ce/failures/absu_ra56_pitch_fail", "i" },
		{ "absu_ra56_yaw_fail", "tu154ce/failures/absu_ra56_yaw_fail", "i" },
		{ "absu_damp_roll_fail","tu154ce/failures/absu_damp_roll_fail","i" },
		{ "absu_damp_pitch_fail", "tu154ce/failures/absu_damp_pitch_fail", "i" },
		{ "absu_damp_yaw_fail", "tu154ce/failures/absu_damp_yaw_fail", "i" },
		{ "absu_contr_roll_fail", "tu154ce/failures/absu_contr_roll_fail", "i" },
		{ "absu_contr_pitch_fail","tu154ce/failures/absu_contr_pitch_fail","i" },
		{ "absu_calc_toga_fail","tu154ce/failures/absu_calc_toga_fail","i" },
		{ "absu_calc_roll_fail","tu154ce/failures/absu_calc_roll_fail","i" },
		{ "absu_calc_pitch_fail", "tu154ce/failures/absu_calc_pitch_fail", "i" },
		-- X-Plane Version
		{ "sim_vers", "sim/version/xplane_internal_version", "i" },
		-- Yoke/Joystick
		{ "joy_pitch","tu154ce/SC/yoke_pitch_ratio", "f" },
		{ "joy_roll", "tu154ce/SC/yoke_roll_ratio","f" },
		{ "joy_yaw","tu154ce/SC/yoke_heading_ratio", "f" },
		-- Hydraulics RA-56
		{ "hydro_ra56_rud_1", "tu154ce/switchers/eng/hydro_ra56_rud_1","i" },
		{ "hydro_ra56_rud_2", "tu154ce/switchers/eng/hydro_ra56_rud_2","i" },
		{ "hydro_ra56_rud_3", "tu154ce/switchers/eng/hydro_ra56_rud_3","i" },
		{ "hydro_ra56_ail_1", "tu154ce/switchers/eng/hydro_ra56_ail_1","i" },
		{ "hydro_ra56_ail_2", "tu154ce/switchers/eng/hydro_ra56_ail_2","i" },
		{ "hydro_ra56_ail_3", "tu154ce/switchers/eng/hydro_ra56_ail_3","i" },
		{ "hydro_ra56_elev_1","tu154ce/switchers/eng/hydro_ra56_elev_1", "i" },
		{ "hydro_ra56_elev_2","tu154ce/switchers/eng/hydro_ra56_elev_2", "i" },
		{ "hydro_ra56_elev_3","tu154ce/switchers/eng/hydro_ra56_elev_3", "i" },
		-- SVS
		{ "mach_svs", "tu154ce/svs/machno","f" },
		{ "alt_svs","tu154ce/svs/altitude","f" },
		{ "tas_svs","tu154ce/svs/true_airspeed", "f" },
		-- NVU
		{ "nvu_res_course", "tu154ce/nvu/nvu_res_course","f" },
		{ "nvu_res_z","tu154ce/nvu/nvu_res_z", "f" },
		-- PKP / PNP
		{ "pkp_course_L", "tu154ce/gauges/compas/pkp_helper_course_L", "f" },
		{ "pkp_course_R", "tu154ce/gauges/compas/pkp_helper_course_R", "f" },
		{ "pkp_gyro_course_L","tu154ce/gauges/compas/pkp_gyro_course_L", "f" },
		{ "pkp_gyro_course_R","tu154ce/gauges/compas/pkp_gyro_course_R", "f" },
		{ "pkp_obs_1","tu154ce/gauges/compas/pkp_obs_L", "f" },
		{ "pkp_obs_2","tu154ce/gauges/compas/pkp_obs_R", "f" },
		-- Angular Rates & Accelerations
		{ "roll_rate","sim/flightmodel/position/P","f" },
		{ "pitch_rate", "sim/flightmodel/position/Q","f" },
		{ "yaw_rate", "sim/flightmodel/position/R","f" },
		{ "roll_acc", "sim/flightmodel/position/P_dot","f" },
		{ "pitch_acc","sim/flightmodel/position/Q_dot","f" },
		{ "yaw_acc","sim/flightmodel/position/R_dot","f" },
		-- Sideslip
		{ "slip", "sim/cockpit2/gauges/indicators/sideslip_degrees", "f" },
		-- Course MP (OBS/Nav1+2)
		{ "obs_1","sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot","f" },
		{ "obs_2","sim/cockpit2/radios/actuators/nav2_obs_deg_mag_pilot","f" },
		{ "nav_cs_1", "tu154ce/radio/nav1_cs", "f" },
		{ "nav_gs_1", "tu154ce/radio/nav1_gs", "f" },
		{ "nav_cs_2", "tu154ce/radio/nav2_cs", "f" },
		{ "nav_gs_2", "tu154ce/radio/nav2_gs", "f" },
		{ "nav_cs_flag_1","tu154ce/radio/nav1_cs_flag","i" },
		{ "nav_gs_flag_1","tu154ce/radio/nav1_gs_flag","i" },
		{ "nav_cs_flag_2","tu154ce/radio/nav2_cs_flag","i" },
		{ "nav_gs_flag_2","tu154ce/radio/nav2_gs_flag","i" },
		{ "cr_flag_1","sim/cockpit2/radios/indicators/nav1_flag_from_to_pilot", "f" },
		{ "cr_flag_2","sim/cockpit2/radios/indicators/nav2_flag_from_to_pilot", "f" },
		-- KLN90
		{ "kln_course", "tu154ce/kln90/kln_course","f" },
		{ "kln_dev","tu154ce/kln90/kln_dev", "f" },
		-- GNS430
		{ "show_gns", "tu154ce/anim/show_gns", "i" },
		{ "GNS430_dtk", "tu154ce/SC/GNS430_dtk", "f" },
		{ "GNS430_dev", "tu154ce/SC/GNS430_dev", "f" },
		-- Radio Altimeter (RV)
		{ "rv5_alt","tu154ce/misc/rv5_alt_left", "f" },
		{ "dh_set", "tu154ce/gauges/alt/radioalt_dh_left", "f" },
		{ "rv_angle", "tu154ce/gauges/alt/radioalt_needle_left", "f" },
		-- Flaps
		{ "flap_inn_L", "sim/flightmodel/controls/wing1l_fla1def", "f" },
		{ "flap_inn_R", "sim/flightmodel/controls/wing1r_fla1def", "f" },
		-- ABSU Director Indicators
		{ "absu_roll_ind","tu154ce/absu/absu_roll_ind","f" },
		{ "absu_pitch_ind", "tu154ce/absu/absu_pitch_ind", "f" },
		{ "absu_roll_flag", "tu154ce/absu/absu_roll_flag", "i" },
		{ "absu_pitch_flag","tu154ce/absu/absu_pitch_flag","i" },
		-- ABSU Control Rod Positions
		{ "absu_contr_pitch", "tu154ce/absu/contr_pitch","f" },
		{ "absu_contr_roll","tu154ce/absu/contr_roll", "f" },
		{ "absu_contr_yaw", "tu154ce/absu/contr_yaw","f" },
		{ "absu_pitch_trimm", "tu154ce/absu/absu_pitch_trimm", "i" },
		-- ABSU Out-of-limits Flags
		{ "absu_course_out","tu154ce/absu_course_out", "i" },
		{ "absu_gs_out","tu154ce/absu_gs_out", "i" },
		-- Pitch Trim
		{ "int_pitch_trim", "tu154ce/trimmers/int_pitch_trim", "f" },
		-- Nose Gear Deflection
		{ "gear1_deflect","sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]", "f" },
		-- Control Surface Positions
		{ "rudder_pos_ind", "tu154ce/gauges/misc/rudder_pos_ind","f" },
		{ "aileron_pos_ind","tu154ce/gauges/misc/aileron_pos_ind", "f" },
		{ "elevator_pos_ind", "tu154ce/gauges/misc/elevator_pos_ind","f" },
		-- Forward Panel Lamps
		{ "wrong_trimm","tu154ce/lights/wrong_trimm","f" },
		{ "controll_roll","tu154ce/lights/controll_roll","f" },
		{ "controll_pitch", "tu154ce/lights/controll_pitch", "f" },
		{ "yoke_sign","tu154ce/lights/yoke_sign","f" },
		{ "triangle", "tu154ce/lights/triangle", "f" },
		{ "controll_thrust","tu154ce/lights/controll_thrust","f" },
		{ "toga", "tu154ce/lights/toga", "f" },
		{ "course", "tu154ce/lights/course", "f" },
		{ "glideslope", "tu154ce/lights/glideslope", "f" },
		{ "zk_lamp","tu154ce/lights/zk_lamp","f" },
		{ "thrust_automat", "tu154ce/lights/thrust_automat", "f" },
		{ "stab_roll","tu154ce/lights/stab_roll","f" },
		{ "stab_pitch", "tu154ce/lights/stab_pitch", "f" },
		{ "stab_h", "tu154ce/lights/stab_h", "f" },
		{ "stab_v", "tu154ce/lights/stab_v", "f" },
		{ "stab_m", "tu154ce/lights/stab_m", "f" },
		{ "pitch_control_fail", "tu154ce/lights/pitch_control_fail", "f" },
		{ "roll_control_fail","tu154ce/lights/roll_control_fail","f" },
		{ "absu_work","tu154ce/lights/absu_work","f" },
		{ "sns_lamp", "tu154ce/lights/sns_lamp", "f" },
		-- Engine Panel Lamps RA-56
		{ "ra56_roll_fail_1", "tu154ce/lights/ra56_roll_fail_1", "f" },
		{ "ra56_roll_fail_2", "tu154ce/lights/ra56_roll_fail_2", "f" },
		{ "ra56_roll_fail_3", "tu154ce/lights/ra56_roll_fail_3", "f" },
		{ "ra56_pitch_fail_1","tu154ce/lights/ra56_pitch_fail_1","f" },
		{ "ra56_pitch_fail_2","tu154ce/lights/ra56_pitch_fail_2","f" },
		{ "ra56_pitch_fail_3","tu154ce/lights/ra56_pitch_fail_3","f" },
		{ "ra56_course_fail_1", "tu154ce/lights/ra56_course_fail_1", "f" },
		{ "ra56_course_fail_2", "tu154ce/lights/ra56_course_fail_2", "f" },
		{ "ra56_course_fail_3", "tu154ce/lights/ra56_course_fail_3", "f" },
		{ "eng_at_on_lamp", "tu154ce/lights/engines/eng_at_on","f" },
		-- Lamp Test & Lighting Control
		{ "lamp_test","tu154ce/buttons/lamp_test_front", "i" },
		{ "lamp_test_eng","tu154ce/buttons/lamp_test_pa56","i" },
		{ "day_night_set","tu154ce/lights/day_night_set","f" },
		-- TKS Failures
		{ "tks_fail_left","tu154ce/tks/fail_left", "i" },
		{ "tks_fail_right", "tu154ce/tks/fail_right","i" },
		-- Hydro System Pressures
		{ "gs_press_1", "tu154ce/hydro/gs_press_1","f" },
		{ "gs_press_2", "tu154ce/hydro/gs_press_2","f" },
		{ "gs_press_3", "tu154ce/hydro/gs_press_3","f" },
		{ "gs_press_4", "tu154ce/hydro/gs_press_4","f" },
		-- Smart Copilot (Failure Signals)
		{ "test_lights","tu154ce/buttons/lamp_test_pa56","i" },
		-- PPN13 Manipulator Animations (float)
		{ "ack_anim", "tu154ce/manipulators/buttons/absu/ppn13_ack_anim","f" },
		{ "flt_anim", "tu154ce/manipulators/buttons/absu/ppn13_flt_anim","f" },
		{ "lookup_anim","tu154ce/manipulators/buttons/absu/ppn13_lookup_anim", "f" },
		{ "poweroff_anim","tu154ce/manipulators/buttons/absu/ppn13_poweroff_anim", "f" },
		{ "snp_anim", "tu154ce/manipulators/buttons/absu/ppn13_snp_anim","f" },
		{ "t1_anim","tu154ce/manipulators/buttons/absu/ppn13_t1_anim", "f" },
		{ "t2_anim","tu154ce/manipulators/buttons/absu/ppn13_t2_anim", "f" },
		{ "t3_anim","tu154ce/manipulators/buttons/absu/ppn13_t3_anim", "f" },
		{ "test_absu_anim", "tu154ce/manipulators/switches/absu/ppn13_test_absu_anim","f" },
		{ "test_svk_anim","tu154ce/manipulators/switches/absu/ppn13_test_svk_anim","f" },
		{ "lid_anim", "tu154ce/manipulators/caps/ppn13_lid", "f" },
		-- PPN13 Buttons (int)
		{ "ack","tu154ce/manipulators/buttons/absu/ppn13_ack", "i" },
		{ "flt","tu154ce/manipulators/buttons/absu/ppn13_flt", "i" },
		{ "lookup", "tu154ce/manipulators/buttons/absu/ppn13_lookup","i" },
		{ "poweroff", "tu154ce/manipulators/buttons/absu/ppn13_poweroff","i" },
		{ "snp","tu154ce/manipulators/buttons/absu/ppn13_snp", "i" },
		{ "t1", "tu154ce/manipulators/buttons/absu/ppn13_t1","i" },
		{ "t2", "tu154ce/manipulators/buttons/absu/ppn13_t2","i" },
		{ "t3", "tu154ce/manipulators/buttons/absu/ppn13_t3","i" },
		{ "test_absu","tu154ce/manipulators/buttons/absu/ppn13_test_absu", "i" },
		{ "test_svk", "tu154ce/manipulators/buttons/absu/ppn13_test_svk","i" },
		{ "lid","tu154ce/manipulators/buttons/absu/ppn13_lid", "i" },
		-- PPN13 System Outputs (float)
		{ "servo_pitch_lt", "tu154ce/systems/absu/ppn13/servo_pitch_lt","f" },
		{ "servo_roll_lt","tu154ce/systems/absu/ppn13/servo_roll_lt", "f" },
		{ "servo_yaw_lt", "tu154ce/systems/absu/ppn13/servo_yaw_lt","f" },
		{ "bdg_pitch_lt", "tu154ce/systems/absu/ppn13/bdg_pitch_lt","f" },
		{ "bdg_roll_lt","tu154ce/systems/absu/ppn13/bdg_roll_lt", "f" },
		{ "bdg_yaw_lt", "tu154ce/systems/absu/ppn13/bdg_yaw_lt","f" },
		{ "cws1_lt","tu154ce/systems/absu/ppn13/cws1_lt", "f" },
		{ "cws2_lt","tu154ce/systems/absu/ppn13/cws2_lt", "f" },
		{ "bns_p_lt", "tu154ce/systems/absu/ppn13/bns_p_lt","f" },
		{ "bap_p_lt", "tu154ce/systems/absu/ppn13/bap_p_lt","f" },
		{ "bap_r_lt", "tu154ce/systems/absu/ppn13/bap_r_lt","f" },
		{ "vkv_lt", "tu154ce/systems/absu/ppn13/vkv_lt","f" },
		{ "vu_lt","tu154ce/systems/absu/ppn13/vu_lt", "f" },
		{ "ute_lt", "tu154ce/systems/absu/ppn13/ute_lt","f" },
		{ "stu_p_lt", "tu154ce/systems/absu/ppn13/stu_p_lt","f" },
		{ "stu_r_lt", "tu154ce/systems/absu/ppn13/stu_r_lt","f" },
		{ "at_lt","tu154ce/systems/absu/ppn13/at_lt", "f" },
		{ "bsn_lt", "tu154ce/systems/absu/ppn13/bsn_lt","f" },
		{ "mgv_p_stu_lt", "tu154ce/systems/absu/ppn13/mgv_p_stu_lt","f" },
		{ "mgv_r_stu_lt", "tu154ce/systems/absu/ppn13/mgv_r_stu_lt","f" },
		{ "mgv_p_sau_lt", "tu154ce/systems/absu/ppn13/mgv_p_sau_lt","f" },
		{ "mgv_r_sau_lt", "tu154ce/systems/absu/ppn13/mgv_r_sau_lt","f" },
		{ "ks_lt","tu154ce/systems/absu/ppn13/ks_lt", "f" },
		{ "bns_r_lt", "tu154ce/systems/absu/ppn13/bns_r_lt","f" },
		{ "ch1_lt", "tu154ce/systems/absu/ppn13/ch1_lt","f" },
		{ "ch2_lt", "tu154ce/systems/absu/ppn13/ch2_lt","f" },
		{ "ch3_lt", "tu154ce/systems/absu/ppn13/ch3_lt","f" },
		{ "ch4_lt", "tu154ce/systems/absu/ppn13/ch4_lt","f" },
		{ "absu_ready_lt","tu154ce/systems/absu/ppn13/absu_ready_lt", "f" },
		-- PPN13 Test Signals (int array)
		{ "servo_pitch_test_signal","tu154ce/systems/absu/ppn13/servo_pitch_test_signal", "ia" },
		{ "servo_roll_test_signal", "tu154ce/systems/absu/ppn13/servo_roll_test_signal","ia" },
		{ "servo_yaw_test_signal","tu154ce/systems/absu/ppn13/servo_yaw_test_signal", "ia" },
		{ "bdg_pitch_test_signal","tu154ce/systems/absu/ppn13/bdg_pitch_test_signal", "ia" },
		{ "bdg_roll_test_signal", "tu154ce/systems/absu/ppn13/bdg_roll_test_signal","ia" },
		{ "bdg_yaw_test_signal","tu154ce/systems/absu/ppn13/bdg_yaw_test_signal", "ia" },
		{ "cws1_test_signal", "tu154ce/systems/absu/ppn13/cws1_test_signal","ia" },
		{ "cws2_test_signal", "tu154ce/systems/absu/ppn13/cws2_test_signal","ia" },
		{ "bns_p_test_signal","tu154ce/systems/absu/ppn13/bns_p_test_signal", "ia" },
		{ "bap_p_test_signal","tu154ce/systems/absu/ppn13/bap_p_test_signal", "ia" },
		{ "bap_r_test_signal","tu154ce/systems/absu/ppn13/bap_r_test_signal", "ia" },
		{ "vkv_test_signal","tu154ce/systems/absu/ppn13/vkv_test_signal", "ia" },
		{ "vu_test_signal", "tu154ce/systems/absu/ppn13/vu_test_signal","ia" },
		{ "ute_test_signal","tu154ce/systems/absu/ppn13/ute_test_signal", "ia" },
		{ "stu_p_test_signal","tu154ce/systems/absu/ppn13/stu_p_test_signal", "ia" },
		{ "stu_r_test_signal","tu154ce/systems/absu/ppn13/stu_r_test_signal", "ia" },
		{ "at_test_signal", "tu154ce/systems/absu/ppn13/at_test_signal","ia" },
		{ "bsn_test_signal","tu154ce/systems/absu/ppn13/bsn_test_signal", "ia" },
		{ "mgv_p_stu_test_signal","tu154ce/systems/absu/ppn13/mgv_p_stu_test_signal", "ia" },
		{ "mgv_r_stu_test_signal","tu154ce/systems/absu/ppn13/mgv_r_stu_test_signal", "ia" },
		{ "mgv_p_sau_test_signal","tu154ce/systems/absu/ppn13/mgv_p_sau_test_signal", "ia" },
		{ "mgv_r_sau_test_signal","tu154ce/systems/absu/ppn13/mgv_r_sau_test_signal", "ia" },
		{ "ks_test_signal", "tu154ce/systems/absu/ppn13/ks_test_signal","ia" },
		{ "bns_r_test_signal","tu154ce/systems/absu/ppn13/bns_r_test_signal", "ia" },
			{ "bus36_volt_right", "tu154ce/elec/bus36_volt_right","f" },
		{ "bus36_volt_pts250_1","tu154ce/elec/bus36_volt_pts250_1", "f" },
		{ "bus36_volt_pts250_2","tu154ce/elec/bus36_volt_pts250_2", "f" },
		{ "bus115_3_volt","tu154ce/elec/bus115_3_volt", "f" },
		{ "absu_power_cc","tu154ce/absu_power_cc","f" },
		{ "hydro_circuit_auto_man", "tu154ce/switchers/eng/hydro_circuit_auto_man", "i" },
		{ "hydro_long_control", "tu154ce/switchers/eng/hydro_long_control", "i" },
		{ "hydro_circuit_auto_man_cap", "tu154ce/switchers/eng/hydro_circuit_auto_man_cap", "i" },
		{ "hydro_long_control_cap", "tu154ce/switchers/eng/hydro_long_control_cap", "i" },
		{ "vbe_select", "tu154ce/switchers/vbe_select", "i" },
		{ "elev_trimm_switcher","tu154ce/controll/elev_trimm_switcher", "i" },
		{ "emerg_elev_trimm", "tu154ce/switchers/console/emerg_elev_trimm", "i" },

}
-- define props
defineProps(props)


-- Smart Copilot
ismaster =globalPropertyf("scp/api/ismaster") -- Master. 0 = plugin not found, 1 = slave 2 = master
hascontrol_1 =globalPropertyf("scp/api/hascontrol_1") -- Have control. 0 = plugin not found, 1 = no control 2 = has control
-- float arrays 
gear_deploy_arr = globalPropertyfa("sim/aircraft/parts/acf_gear_deploy") -- landing gear deploy array
gear_deflect_arr = globalPropertyfa("sim/flightmodel2/gear/tire_vertical_deflection_mtr") -- gear deflection array


-- show_RXP = globalPropertyi("tu154ce/anim/RXP")
-- RXP 
-- local function defineOptProp(var, ref)
-- if pcall(function() return globalPropertyf(ref) end) then
-- return defineProperty(var, globalPropertyf(ref))
-- end
-- return nil
-- end
-- local rxp_course= defineOptProp("RXP_course", rxp_course_ref)
-- local rxp_dev = defineOptProp("RXP_dev", rxp_dev_ref)
-- GNS


components = {
	absu_commands {},
	absu_panel {},
	absu_ppn13 {},
	absu_mode {},
	absu_controls {},
	absu_at {},
	absu_indicator {},
	absu_fails {},
}
