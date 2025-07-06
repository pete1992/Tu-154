createGlobalPropertyf("tu154ce/KLN90/power_draw", 0.0) -- KLN90B power draw
createGlobalPropertyf("tu154ce/rotary/console/rls_tilt", 0.0)    -- WXR tilt
createGlobalPropertyf("tu154ce/switchers/console/rls_stab", 0.0) -- WXR stabilization
createGlobalPropertyi("tu154ce/switchers/cb/ap_3", 1) -- AP Channel 3



--THERMAL_source tu154ce/antiice/window_windshield_temp
--tu154ce/antiice/window_windshield_act
--THERMAL_source tu154ce/antiice/window_left_temp
--tu154ce/antiice/window_left_act
--THERMAL_source tu154ce/antiice/window_right_temp
--tu154ce/antiice/window_right_act



-- Windshield heating temperature
createGlobalPropertyf("tu154ce/antiice/window_windshield_temp", 0)
-- Left window heating temperature
createGlobalPropertyf("tu154ce/antiice/window_left_temp", 0)
-- Right window heating temperature
createGlobalPropertyf("tu154ce/antiice/window_right_temp", 0)
-- Windshield heating active
createGlobalPropertyi("tu154ce/antiice/window_windshield_act", 0)
-- Left window heating active
createGlobalPropertyi("tu154ce/antiice/window_left_act", 0)
-- Right window heating active
createGlobalPropertyi("tu154ce/antiice/window_right_act", 0)


-- PPN-13 ACK button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_ack_anim", 0)
-- PPN-13 FLT button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_flt_anim", 0)
-- PPN-13 LOOKUP button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_lookup_anim", 0)
-- PPN-13 POWEROFF button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_poweroff_anim", 0)
-- PPN-13 SNP button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_snp_anim", 0)
-- PPN-13 T1 button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_t1_anim", 0)
-- PPN-13 T2 button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_t2_anim", 0)
-- PPN-13 T3 button animation state
createGlobalPropertyf("tu154ce/manipulators/buttons/absu/ppn13_t3_anim", 0)
-- PPN-13 ABSU test switch animation state
createGlobalPropertyf("tu154ce/manipulators/switches/absu/ppn13_test_absu_anim", 0)
-- PPN-13 SVK test switch animation state
createGlobalPropertyf("tu154ce/manipulators/switches/absu/ppn13_test_svk_anim", 0)
-- PPN-13 lid cap animation state
createGlobalPropertyf("tu154ce/manipulators/caps/ppn13_lid", 0)

-- PPN-13 ACK button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_ack", 0)
-- PPN-13 FLT button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_flt", 0)
-- PPN-13 LOOKUP button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_lookup", 0)
-- PPN-13 POWEROFF button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_poweroff", 0)
-- PPN-13 SNP button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_snp", 0)
-- PPN-13 T1 button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_t1", 0)
-- PPN-13 T2 button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_t2", 0)
-- PPN-13 T3 button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_t3", 0)
-- PPN-13 ABSU test button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_test_absu", 0)
-- PPN-13 SVK test button pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_test_svk", 0)
-- PPN-13 lid cap pressed state
createGlobalPropertyi("tu154ce/manipulators/buttons/absu/ppn13_lid", 0)

-- Pitch servo light (main pitch servo channel active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/servo_pitch_lt", 0)
-- Roll servo light (main roll servo channel active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/servo_roll_lt", 0)
-- Yaw servo light (main yaw servo channel active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/servo_yaw_lt", 0)

-- BDG pitch light (backup pitch channel active – БДГ = резерв)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bdg_pitch_lt", 0)
-- BDG roll light (backup roll channel active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bdg_roll_lt", 0)
-- BDG yaw light (backup yaw channel active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bdg_yaw_lt", 0)

-- CWS1 light (Control Wheel Steering 1 mode engaged – manual override mode)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/cws1_lt", 0)
-- CWS2 light (Control Wheel Steering 2 mode engaged – alternate override)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/cws2_lt", 0)

-- BNS pitch light (БНС = Main vertical pitch stabilization channel)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bns_p_lt", 0)
-- BAP pitch light (БАП = automatic pitch hold mode engaged)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bap_p_lt", 0)
-- BAP roll light (БАП = automatic roll hold mode engaged)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bap_r_lt", 0)

-- VKV light (ВКВ = lateral guidance mode from navigation source active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/vkv_lt", 0)
-- VU light (ВУ = vertical guidance mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/vu_lt", 0)
-- UTE light (УТЭ = approach mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/ute_lt", 0)

-- STU pitch light (СТУ = pitch stabilizer engaged)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/stu_p_lt", 0)
-- STU roll light (СТУ = roll stabilizer engaged)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/stu_r_lt", 0)

-- AT light (АТ = automatic throttle engaged)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/at_lt", 0)
-- BSN light (БСН = final approach pitch mode – likely flare/landing logic)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bsn_lt", 0)

-- MGV pitch STU light (МГВ = electric trim pitch in STU mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/mgv_p_stu_lt", 0)
-- MGV roll STU light (electric trim roll in STU mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/mgv_r_stu_lt", 0)
-- MGV pitch SAU light (electric trim pitch in SAU mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/mgv_p_sau_lt", 0)
-- MGV roll SAU light (electric trim roll in SAU mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/mgv_r_sau_lt", 0)

-- KS light (КС = course stabilization mode active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/ks_lt", 0)
-- BNS roll light (БНС roll stabilization channel active)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/bns_r_lt", 0)


-- Test signal for pitch servo
createGlobalPropertyia("tu154ce/systems/absu/ppn13/servo_pitch_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for roll servo
createGlobalPropertyia("tu154ce/systems/absu/ppn13/servo_roll_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for yaw servo
createGlobalPropertyia("tu154ce/systems/absu/ppn13/servo_yaw_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for backup pitch channel (BDG)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bdg_pitch_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for backup roll channel (BDG)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bdg_roll_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for backup yaw channel (BDG)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bdg_yaw_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for CWS1 mode (manual override 1)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/cws1_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for CWS2 mode (manual override 2)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/cws2_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for main pitch stabilization channel (BNS)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bns_p_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for automatic pitch hold (BAP)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bap_p_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for automatic roll hold (BAP)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bap_r_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for lateral navigation guidance (VKV)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/vkv_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for vertical navigation guidance (VU)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/vu_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for approach mode (UTE)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/ute_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for pitch stabilization (STU)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/stu_p_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for roll stabilization (STU)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/stu_r_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for auto throttle mode (AT)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/at_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for landing logic / flare mode (BSN)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bsn_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for pitch trim in STU mode
createGlobalPropertyia("tu154ce/systems/absu/ppn13/mgv_p_stu_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for roll trim in STU mode
createGlobalPropertyia("tu154ce/systems/absu/ppn13/mgv_r_stu_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for pitch trim in SAU mode
createGlobalPropertyia("tu154ce/systems/absu/ppn13/mgv_p_sau_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for roll trim in SAU mode
createGlobalPropertyia("tu154ce/systems/absu/ppn13/mgv_r_sau_test_signal", { 0, 0, 0, 0, 0, 0 })

-- Test signal for course stabilization mode (KS)
createGlobalPropertyia("tu154ce/systems/absu/ppn13/ks_test_signal", { 0, 0, 0, 0, 0, 0 })
-- Test signal for roll channel of BNS
createGlobalPropertyia("tu154ce/systems/absu/ppn13/bns_r_test_signal", { 0, 0, 0, 0, 0, 0 })

-- ABSU channel 1 indicator light
createGlobalPropertyf("tu154ce/systems/absu/ppn13/ch1_lt", 0)
-- ABSU channel 2 indicator light
createGlobalPropertyf("tu154ce/systems/absu/ppn13/ch2_lt", 0)
-- ABSU channel 3 indicator light
createGlobalPropertyf("tu154ce/systems/absu/ppn13/ch3_lt", 0)
-- ABSU channel 4 indicator light
createGlobalPropertyf("tu154ce/systems/absu/ppn13/ch4_lt", 0)

-- ABSU ready light (system operational)
createGlobalPropertyf("tu154ce/systems/absu/ppn13/absu_ready_lt", 0)

-- ASU (Auxiliary Power Unit) RPM
createGlobalPropertyf("tu154ce/asu/rpm", 0.0)
-- ASU pressure output
createGlobalPropertyf("tu154ce/asu/press", 0.0)
-- ASU operation flag (1 = running)
createGlobalPropertyi("tu154ce/asu/work", 0)
-- ASU animation state
createGlobalPropertyf("tu154ce/anim/asu_show", 0.0)
-- GPU (Ground Power Unit) sound active
createGlobalPropertyi("tu154ce/anim/gpu_sound", 0)

-- ABSU alarm
alarm_absu = createGlobalPropertyi("tu154ce/sound/absu_alarm", 0) 
-- Flaps alarm
alarm_flaps = createGlobalPropertyi("tu154ce/sound/flaps",0)
 -- SRD alarm
alarm_srd = createGlobalPropertyi("tu154ce/sound/srd",0)
-- AUASP alarm
alarm_auasp = createGlobalPropertyi("tu154ce/sound/auasp",0)
-- Marker beacon alarm
alarm_marker = createGlobalPropertyi("tu154ce/sound/marker_beacon", 0)
-- Overspeed alarm
alarm_ospeed = createGlobalPropertyi("tu154ce/sound/overspeed", 0)
-- Radio altimeter alarm
alarm_rad_alt = createGlobalPropertyi("tu154ce/sound/rad_alt", 0)
-- VBE alarm
alarm_vbe = createGlobalPropertyi("tu154ce/sound/vbe", 0)
-- Fire alarm
alarm_fire = createGlobalPropertyi("tu154ce/sound/fire", 0) 

