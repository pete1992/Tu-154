createGlobalPropertyi("tu154ce/save_state_enabled", 1) -- aircraft state saving enabled
createGlobalPropertyi("tu154ce/reset_state", 0) -- reset aircraft state
createGlobalPropertyi("tu154ce/save_state", 0) -- manual aircraft state save
createGlobalPropertyi("tu154ce/hardware_cockpit", 0) -- aircraft prepared for hardware cockpit
createGlobalPropertyf("tu154ce/time/frame_time", 0.1) -- frame time; never negative; if FPS < 10, fixed at 0.1 s
createGlobalPropertyf("tu154ce/anim/cargo_1", 0) -- cargo door 1 position: 0 closed, 1 open
createGlobalPropertyf("tu154ce/anim/cargo_2", 0) -- cargo door 2 position: 0 closed, 1 open
createGlobalPropertyf("tu154ce/anim/apu_doors", 0) -- APU doors position: 0 closed, 1 open
createGlobalPropertyf("tu154ce/anim/pax_door_1", 0) -- front passenger doors position
createGlobalPropertyf("tu154ce/anim/pax_door_2", 0) -- mid-cabin passenger doors position
createGlobalPropertyf("tu154ce/anim/pax_door_3", 0) -- right emergency doors position
createGlobalPropertyf("tu154ce/anim/lg/front_pos", 1) -- nose gear position
createGlobalPropertyf("tu154ce/anim/lg/front_defl", 0) -- nose-gear strut compression
createGlobalPropertyf("tu154ce/anim/lg/front_turn", 0) -- nose-gear steering angle
createGlobalPropertyf("tu154ce/anim/lg/main_pos_left", 1) -- left main gear position (0-1 deploy, >1 strut compression)
createGlobalPropertyf("tu154ce/anim/lg/main_rot_left", 0) -- left bogie rotation on ground
createGlobalPropertyf("tu154ce/anim/lg/main_pos_right", 1) -- right main gear position (0-1 deploy, >1 strut compression)
createGlobalPropertyf("tu154ce/anim/lg/main_rot_right", 0) -- right bogie rotation on ground
createGlobalPropertyf("tu154ce/anim/light_open_left", 0) -- left landing-light extension
createGlobalPropertyf("tu154ce/anim/light_open_right", 0) -- right landing-light extension
createGlobalPropertyf("tu154ce/anim/spd_brk_inn_left", 0) -- left inboard speed-brake position
createGlobalPropertyf("tu154ce/anim/spd_brk_inn_right", 0) -- right inboard speed-brake position
createGlobalPropertyf("tu154ce/anim/wing_flx_left", 0) -- left-wing flex angle (positive = up)
createGlobalPropertyf("tu154ce/anim/wing_flx_right", 0) -- right-wing flex angle (positive = up)
createGlobalPropertyf("tu154ce/anim/rudder_anim", 0) -- rudder angle for animation (reduced with reverse)
createGlobalPropertyf("tu154ce/anim/elev_anim_L", 0) -- elevator deflection angle (left)
createGlobalPropertyf("tu154ce/anim/elev_anim_R", 0) -- elevator deflection angle (right)
createGlobalPropertyf("tu154ce/anim/cockpit_door", 0) -- cockpit door opening
createGlobalPropertyf("tu154ce/anim/cockpit_table_1", 0) -- pilot seat table position
createGlobalPropertyf("tu154ce/anim/cockpit_table_2", 0) -- copilot seat table position
createGlobalPropertyf("tu154ce/anim/cockpit_vent_1", 0) -- cockpit vent fan angle
createGlobalPropertyf("tu154ce/anim/cockpit_vent_2", 0) -- cockpit vent fan angle
createGlobalPropertyf("tu154ce/anim/cockpit_vent_3", 0) -- cockpit vent fan angle
createGlobalPropertyf("tu154ce/anim/cockpit_window_left", 0) -- left cockpit window (slider) open
createGlobalPropertyf("tu154ce/anim/cockpit_window_right", 0) -- right cockpit window (slider) open
createGlobalPropertyi("tu154ce/anim/show_gns", 1) -- GNS430 installed instead of KLN
createGlobalPropertyi("tu154ce/anim/RXP", 0) -- RXP system installed
createGlobalPropertyi("tu154ce/anim/show_yokes", 1) -- yokes visible
createGlobalPropertyi("tu154ce/anim/show_chairs", 1) -- seats visible
createGlobalPropertyf("tu154ce/anim/rise_chair_arm_L", 0) -- raise left seat armrest
createGlobalPropertyf("tu154ce/anim/rise_chair_arm_R", 0) -- raise right seat armrest
createGlobalPropertyi("tu154ce/anim/table_up_L", 0) -- raise left tables
createGlobalPropertyi("tu154ce/anim/table_up_R", 0) -- raise right tables
createGlobalPropertyi("tu154ce/anim/gpu_present", 0) -- GPU unit present
createGlobalPropertyf("tu154ce/anim/gpu_work", 0) -- GPU running (exhaust cover open)
createGlobalPropertyf("tu154ce/anim/ground_stuff_angle", 0) -- pitch-correction angle for ground equipment
createGlobalPropertyf("tu154ce/anim/window_ice_1", 0) -- ice level on windows (zone 1)
createGlobalPropertyf("tu154ce/anim/window_ice_2", 0) -- ice level on windows (zone 2)
createGlobalPropertyf("tu154ce/anim/window_ice_3", 0) -- ice level on windows (zone 3)
createGlobalPropertyf("tu154ce/anim/window_ice_4", 0) -- ice level on remaining windows
createGlobalPropertyi("tu154ce/anim/gear_blocks", 0)      -- gear blocks installation
createGlobalPropertyi("tu154ce/anim/sensors_caps", 0)    -- sensor caps installation
createGlobalPropertyi("tu154ce/anim/engine_caps", 0)     -- engine caps installation
createGlobalPropertyf("tu154ce/anim/ladder_1", 500)      -- boarding stairs 1: 500 hidden; +50..0 approaching; 0 at door; 0..–50 departing
createGlobalPropertyf("tu154ce/anim/ladder_2", 500)      -- boarding stairs 2 (same behavior)
createGlobalPropertyf("tu154ce/anim/catering", 500)      -- catering truck: 500 hidden; +50..0 approaching; 0 at door; 0..–50 departing
createGlobalPropertyf("tu154ce/anim/fuel_tanker", 500)   -- fuel tanker: 500 hidden; +50..0 approaching; 0 at door; 0..–50 departing
createGlobalPropertyi("tu154ce/anim/ladder_1_call", 0)   -- call stairs 1: 1 deploy, 0 retract
createGlobalPropertyi("tu154ce/anim/ladder_2_call", 0)   -- call stairs 2: 1 deploy, 0 retract
createGlobalPropertyi("tu154ce/anim/catering_call", 0)   -- call catering truck: 1 deploy, 0 retract
createGlobalPropertyi("tu154ce/anim/fuel_tanker_call", 0) -- call fuel tanker: 1 deploy, 0 retract
createGlobalPropertyf("tu154ce/anim/reverse_mid", 0)     -- common reverse lever position
createGlobalPropertyi("tu154ce/buttons/clock_24_left", 0)  -- left 24-hour clock button: 0 released, 1 pressed
createGlobalPropertyi("tu154ce/buttons/clock_24_right", 0) -- right 24-hour clock button: 0 released, 1 pressed
createGlobalPropertyf("tu154ce/gauges/clock_24_hours", 0)  -- 24-hour clock hour hand angle
createGlobalPropertyf("tu154ce/gauges/clock_24_mins", 0)   -- 24-hour clock minute hand angle
createGlobalPropertyf("tu154ce/gauges/clock_24_red", 0)    -- 24-hour clock red hand angle
createGlobalPropertyi("tu154ce/switchers/spu_1_power", 1)  -- captain’s audio panel power switch: –1=bus2, 0=off, 1=bus1
createGlobalPropertyi("tu154ce/switchers/spu_1_mode", 0)   -- captain’s audio panel mode switch: 0=radio, 1=audio
createGlobalPropertyi("tu154ce/switchers/spu_1_source", 0) -- captain’s audio panel source switch
createGlobalPropertyi("tu154ce/switchers/spu_2_power", 1)  -- 2nd officer audio panel power switch
createGlobalPropertyi("tu154ce/switchers/spu_2_mode", 0)   -- 2nd officer audio panel mode switch
createGlobalPropertyi("tu154ce/switchers/spu_2_source", 0) -- 2nd officer audio panel source switch
createGlobalPropertyi("tu154ce/switchers/spu_3_power", 1)  -- flight engineer audio panel power switch
createGlobalPropertyi("tu154ce/switchers/spu_3_mode", 0)   -- flight engineer audio panel mode switch
createGlobalPropertyi("tu154ce/switchers/spu_3_source", 0) -- flight engineer audio panel source switch
createGlobalPropertyi("tu154ce/switchers/spu_4_power", 1)  -- 4th audio panel power switch
createGlobalPropertyi("tu154ce/switchers/spu_4_mode", 0)   -- 4th audio panel mode switch
createGlobalPropertyi("tu154ce/switchers/spu_4_source", 0) -- 4th audio panel source switch
createGlobalPropertyi("tu154ce/lights/mid_left_panel_int_set", 3)  -- front-left panel dimmer (1-3)
createGlobalPropertyi("tu154ce/lights/left_panel_int_set", 3)      -- left panel dimmer (1-3)
createGlobalPropertyi("tu154ce/lights/right_panel_int_set",3)      -- right panel dimmer (1-3)
createGlobalPropertyi("tu154ce/lights/mid_right_panel_int_set",3)  -- front-right panel dimmer (1-3)
createGlobalPropertyi("tu154ce/lights/ovhd_panel_int_set", 3)      -- overhead panel dimmer (1-3)
createGlobalPropertyf("tu154ce/lights/left_panel_flood_set", 0.3)  -- left panel flood light brightness (0-1)
createGlobalPropertyf("tu154ce/lights/right_panel_flood_set", 0.3)  -- right panel flood light brightness
createGlobalPropertyf("tu154ce/lights/mid_panel_flood_set", 0.3)   -- center panel flood light brightness
createGlobalPropertyf("tu154ce/lights/front_panel_flood_set", 0.3)  -- front panel flood light brightness
createGlobalPropertyf("tu154ce/lights/ovhd_front_panel_flood_set", 0.3) -- overhead front flood brightness
createGlobalPropertyf("tu154ce/lights/ovhd_back_panel_flood_set", 0.3)  -- overhead back flood brightness
createGlobalPropertyf("tu154ce/lights/eng_panel_flood_set", 0.3)  -- standby panel flood brightness
createGlobalPropertyi("tu154ce/lights/cabinl_flood_set", 0)       -- cabin flood light switch
createGlobalPropertyi("tu154ce/lights/azs_panel_flood_set", 0)    -- fuel panel flood light switch
createGlobalPropertyi("tu154ce/lights/day_night_set", 0)         -- day/night mode: 0=day,1=night (dims warning lights)
createGlobalPropertyi("tu154ce/lights/cargo_light_1_set", 0)     -- cargo hold light 1 switch
createGlobalPropertyi("tu154ce/lights/cargo_light_2_set", 0)     -- cargo hold light 2 switch
createGlobalPropertyi("tu154ce/lights/tech_light_set", 0)        -- tech compartment light switch
createGlobalPropertyi("tu154ce/lights/gear_nacelle_light_set", 0) -- landing gear nacelle light switch
createGlobalPropertyf("tu154ce/lights/cabin_2d_light", 0)        -- cabin 2D lighting brightness (0-1)
createGlobalPropertyi("tu154ce/lights/nav_lights_set", 1)        -- navigation lights switch
createGlobalPropertyi("tu154ce/lights/strobe_set", 1)           -- strobe lights switch
createGlobalPropertyi("tu154ce/lights/wing_light_left_set", 0)   -- left wing light master switch
createGlobalPropertyi("tu154ce/lights/wing_light_right_set", 0)   -- right wing light master switch
createGlobalPropertyi("tu154ce/lights/tail_light_set", 1)        -- tail light master switch
createGlobalPropertyi("tu154ce/lights/wing_light_left", 0)       -- left wing light external toggle
createGlobalPropertyi("tu154ce/lights/wing_light_right", 0)       -- right wing light external toggle
createGlobalPropertyi("tu154ce/lights/tail_light", 0)            -- tail light external toggle
createGlobalPropertyi("tu154ce/lights/landing_ext_set_L", 0)     -- left landing light extension switch
createGlobalPropertyi("tu154ce/lights/landing_ext_set_R", 0)     -- right landing light extension switch
createGlobalPropertyi("tu154ce/lights/landing_mode_set_L", 0)    -- left landing light mode: –1=taxi, 0=off,1=landing
createGlobalPropertyi("tu154ce/lights/landing_mode_set_R", 0)    -- right landing light mode
createGlobalPropertyi("tu154ce/lights/light_signal_set", 0)      -- in-flight light signal switch
createGlobalPropertyf("tu154ce/controlls/nosewheel_lever", 0)    -- nosewheel steering lever position
createGlobalPropertyf("tu154ce/controlls/yoke_pitch", 0)         -- yoke pitch control position
createGlobalPropertyf("tu154ce/controlls/yoke_roll", 0)          -- yoke roll control position
createGlobalPropertyf("tu154ce/controlls/pedals", 0)             -- pedal position
createGlobalPropertyf("tu154ce/controlls/brake_L", 0)            -- left toe brake input
createGlobalPropertyf("tu154ce/controlls/brake_R", 0)            -- right toe brake input
createGlobalPropertyf("tu154ce/controlls/brake_emerg", 0)        -- emergency brake input
createGlobalPropertyf("tu154ce/controlls/brake_emerg_L", 0)      -- left emergency brake input
createGlobalPropertyf("tu154ce/controlls/brake_emerg_R", 0)      -- right emergency brake input
createGlobalPropertyf("tu154ce/controlls/spoilers_lever", 0)     -- spoiler lever position
createGlobalPropertyf("tu154ce/controlls/throttle_1", 0)         -- throttle lever engine 1
createGlobalPropertyf("tu154ce/controlls/throttle_2", 0)         -- throttle lever engine 2
createGlobalPropertyf("tu154ce/controlls/throttle_3", 0)         -- throttle lever engine 3
createGlobalPropertyf("tu154ce/controlls/throttle_1_ENG", 0)     -- APU throttle lever
createGlobalPropertyf("tu154ce/controlls/throttle_2_ENG", 0)     -- standby engine throttle lever
createGlobalPropertyf("tu154ce/controlls/throttle_3_ENG", 0)     -- trim/thrust lever for emergency engine
createGlobalPropertyf("tu154ce/controlls/revers_L", 0)           -- left reverse lever position
createGlobalPropertyf("tu154ce/controlls/revers_R", 0)           -- right reverse lever position
createGlobalPropertyf("tu154ce/controlls/fuel_cutoff_1", 0)      -- engine 1 fire extinguisher lever
createGlobalPropertyf("tu154ce/controlls/fuel_cutoff_2", 0)      -- engine 2 fire extinguisher lever
createGlobalPropertyf("tu154ce/controlls/fuel_cutoff_3", 0)      -- engine 3 fire extinguisher lever
createGlobalPropertyf("tu154ce/controlls/throttle_lock", 0)      -- throttle lock lever
createGlobalPropertyi("tu154ce/controll/parking_brake", 0)       -- parking brake handle
createGlobalPropertyi("tu154ce/controll/emerg_gear_ext", 0)      -- emergency gear extension handle
createGlobalPropertyf("tu154ce/controll/flaps_lever", 0)         -- flap lever position (0-45°)
createGlobalPropertyi("tu154ce/controll/gear_lever", 0)         -- gear lever: –1 up, 0 neutral, +1 down
createGlobalPropertyi("tu154ce/controll/elev_trimm_switcher", 0) -- elevator trim switch: –1 nose-down, 0 neutral,+1 nose-up
createGlobalPropertyi("tu154ce/controll/stab_man_cap", 0)        -- stabilizer manual cap installed
createGlobalPropertyi("tu154ce/controll/stab_manual", 0)         -- manual stabilizer control: 0 neutral, +1 nose-up
createGlobalPropertyi("tu154ce/controll/stab_setting", 1)        -- stabilizer trim setting: 0=left,1=centre,2=right
createGlobalPropertyi("tu154ce/controll/ail_trimm_sw", 0)        -- aileron trim switch position
createGlobalPropertyi("tu154ce/controll/rudd_trimm_sw", 0)       -- rudder trim switch position
createGlobalPropertyi("tu154ce/controll/contr_force_cap", 0)     -- control force loader cap installed
createGlobalPropertyi("tu154ce/controll/contr_force_set", 0)     -- control force loader mode: –1 flight, 0 auto, +1 takeoff/landing
createGlobalPropertyi("tu154ce/switchers/nosewheel_turn_enable",1) -- yoke-driven nosewheel steering enable
createGlobalPropertyi("tu154ce/switchers/nosewheel_turn_sel", 0) -- nosewheel steering angle select: 0=10°,1=63°
createGlobalPropertyi("tu154ce/switchers/nosewheel_turn_cap", 0)  -- nosewheel turn selector cap installed
createGlobalPropertyi("tu154ce/switchers/slat_man", 0)           -- manual slat control: –1 up, 0 off,+1 down
createGlobalPropertyi("tu154ce/switchers/slat_man_cap", 0)       -- slat manual control cover installed
createGlobalPropertyi("tu154ce/switchers/flaps_sel", 0)         -- flaps mode selector: –1=off, 0=auto, +1=manual
createGlobalPropertyi("tu154ce/switchers/flaps_sel_cap", 0)     -- flaps mode selector cover installed
createGlobalPropertyi("tu154ce/switchers/gears_retr_lock", 0)   -- gear retraction lock enabled
createGlobalPropertyi("tu154ce/switchers/gears_retr_lock_cap", 0) -- gear retraction lock cover installed
createGlobalPropertyi("tu154ce/switchers/gears_ext_3GS", 0)     -- gear extension via 3GS system enabled
createGlobalPropertyi("tu154ce/switchers/gears_ext_3GS_cap", 0)  -- 3GS gear extension switch cover installed
createGlobalPropertyi("tu154ce/gauges/acs1/left_knob_press", 0)  -- ACS1 clock left knob pressed
createGlobalPropertyi("tu154ce/gauges/acs1/right_knob_press", 0)  -- ACS1 clock right knob pressed
createGlobalPropertyf("tu154ce/gauges/acs1/needle_hours", 0)    -- ACS1 clock hour hand angle
createGlobalPropertyf("tu154ce/gauges/acs1/needle_mins", 0)     -- ACS1 clock minute hand angle
createGlobalPropertyf("tu154ce/gauges/acs1/needle_secs", 0)     -- ACS1 clock second hand angle
createGlobalPropertyi("tu154ce/gauges/acs1/flag_pos", 0)        -- ACS1 red/white flag: –1=white, 0=white/red, +1=red
createGlobalPropertyf("tu154ce/gauges/acs1/flight_timer_hours", 0) -- ACS1 flight timer hour hand angle
createGlobalPropertyf("tu154ce/gauges/acs1/flight_timer_mins", 0)  -- ACS1 flight timer minute hand angle
createGlobalPropertyf("tu154ce/gauges/acs1/stopwatch_mins", 0)  -- ACS1 stopwatch minute hand angle
createGlobalPropertyi("tu154ce/gauges/acs2/left_knob_press", 0)  -- ACS2 clock left knob pressed
createGlobalPropertyi("tu154ce/gauges/acs2/right_knob_press", 0)  -- ACS2 clock right knob pressed
createGlobalPropertyf("tu154ce/gauges/acs2/needle_hours", 0)    -- ACS2 clock hour hand angle
createGlobalPropertyf("tu154ce/gauges/acs2/needle_mins", 0)     -- ACS2 clock minute hand angle
createGlobalPropertyf("tu154ce/gauges/acs2/needle_secs", 0)     -- ACS2 clock second hand angle
createGlobalPropertyi("tu154ce/gauges/acs2/flag_pos", 0)        -- ACS2 red/white flag position
createGlobalPropertyf("tu154ce/gauges/acs2/flight_timer_hours", 0) -- ACS2 flight timer hour hand angle
createGlobalPropertyf("tu154ce/gauges/acs2/flight_timer_mins", 0)  -- ACS2 flight timer minute hand angle
createGlobalPropertyf("tu154ce/gauges/acs2/stopwatch_mins", 0)  -- ACS2 stopwatch minute hand angle
createGlobalPropertyi("tu154ce/gauges/acs3/left_knob_press", 0)  -- ACS3 clock left knob pressed
createGlobalPropertyi("tu154ce/gauges/acs3/right_knob_press", 0)  -- ACS3 clock right knob pressed
createGlobalPropertyf("tu154ce/gauges/acs3/needle_hours", 0)    -- ACS3 clock hour hand angle
createGlobalPropertyf("tu154ce/gauges/acs3/needle_mins", 0)     -- ACS3 clock minute hand angle
createGlobalPropertyf("tu154ce/gauges/acs3/needle_secs", 0)     -- ACS3 clock second hand angle
createGlobalPropertyi("tu154ce/gauges/acs3/flag_pos", 0)        -- ACS3 red/white flag position
createGlobalPropertyf("tu154ce/gauges/acs3/flight_timer_hours", 0) -- ACS3 flight timer hour hand angle
createGlobalPropertyf("tu154ce/gauges/acs3/flight_timer_mins", 0)  -- ACS3 flight timer minute hand angle
createGlobalPropertyf("tu154ce/gauges/acs3/stopwatch_mins", 0)  -- ACS3 stopwatch minute hand angle
createGlobalPropertyf("tu154ce/gauges/speed/kus_ias_left", 0)   -- KUS-730 IAS indicator (captain)
createGlobalPropertyf("tu154ce/gauges/speed/kus_tas_left", 0)   -- KUS-730 TAS indicator (captain)
createGlobalPropertyf("tu154ce/gauges/speed/kus_ias_right", 0)   -- KUS-730 IAS indicator (first officer)
createGlobalPropertyf("tu154ce/gauges/speed/kus_tas_right", 0)   -- KUS-730 TAS indicator (first officer)
createGlobalPropertyf("tu154ce/gauges/speed/kus_ias_eng", 0)    -- KUS-730 IAS indicator (flight engineer)
createGlobalPropertyf("tu154ce/gauges/speed/kus_tas_eng", 0)    -- KUS-730 TAS indicator (flight engineer)
createGlobalPropertyf("tu154ce/gauges/speed/ias_left", 0)       -- captain’s airspeed indicator
createGlobalPropertyf("tu154ce/gauges/speed/ias_yellow_left", 0) -- IAS yellow marker (captain)
createGlobalPropertyf("tu154ce/gauges/speed/ias_right", 0)      -- first officer’s airspeed indicator
createGlobalPropertyf("tu154ce/gauges/speed/ias_yellow_right", 0) -- IAS yellow marker (first officer)
createGlobalPropertyf("tu154ce/gauges/speed/mach_left", 0)      -- captain’s Mach number indicator
createGlobalPropertyf("tu154ce/gauges/speed/mach_right", 0)     -- first officer’s Mach number indicator
createGlobalPropertyf("tu154ce/gauges/speed/speed_mid_needle", 0) -- center speed indicator needle angle
createGlobalPropertyi("tu154ce/gauges/speed/speed_mid_flag", 0)  -- center speed flag: 0=airspeed, 1=ground speed
createGlobalPropertyf("tu154ce/gauges/alt/var75", 0)            -- variometer 75 indicator (captain)
createGlobalPropertyf("tu154ce/gauges/alt/var30", 0)            -- variometer 30 indicator (flight engineer)
createGlobalPropertyf("tu154ce/gauges/alt/radioalt_needle_left", 0) -- radio altimeter needle (captain)
createGlobalPropertyf("tu154ce/gauges/alt/radioalt_dh_left", 0) -- radio altimeter decision height pointer (captain)
createGlobalPropertyf("tu154ce/gauges/alt/radioalt_flag_left", 0) -- radio altimeter flag (captain)
createGlobalPropertyi("tu154ce/gauges/alt/radioalt_button_left", 0) -- radio altimeter test button (captain)
createGlobalPropertyf("tu154ce/gauges/alt/radioalt_needle_right", 0)-- radio altimeter needle (first officer)
createGlobalPropertyf("tu154ce/gauges/alt/radioalt_dh_right", 0)  -- radio altimeter decision height pointer (first officer)
createGlobalPropertyf("tu154ce/gauges/alt/radioalt_flag_right", 0)-- radio altimeter flag (first officer)
createGlobalPropertyi("tu154ce/gauges/alt/radioalt_button_right", 0)-- radio altimeter test button (first officer)
createGlobalPropertyf("tu154ce/gauges/alt/uvid_needle_left", 0)  -- UVID altimeter needle (captain)
createGlobalPropertyf("tu154ce/gauges/alt/uvid_feet_counter", 0) -- UVID foot drum counter
createGlobalPropertyf("tu154ce/gauges/alt/uvid_hundreads_counter", 0) -- UVID hundreds-of-feet drum counter
createGlobalPropertyf("tu154ce/gauges/alt/uvid_thousands_counter", 0)-- UVID thousands-of-feet drum counter
createGlobalPropertyf("tu154ce/gauges/alt/uvid_tens_thousands_counter", 0)-- UVID ten-thousands-of-feet drum counter
createGlobalPropertyf("tu154ce/gauges/alt/uvid_pressure_knob",1013)-- UVID pressure setting knob (hPa)
createGlobalPropertyf("tu154ce/gauges/alt/uvid_pressure_one", 3)  -- UVID pressure dial units digit
createGlobalPropertyf("tu154ce/gauges/alt/uvid_pressure_ten",10)  -- UVID pressure dial tens digit
createGlobalPropertyf("tu154ce/gauges/alt/uvid_pressure_hund", 0)  -- UVID pressure dial hundreds digit
createGlobalPropertyf("tu154ce/gauges/alt/uvid_pressure_thous",1)-- UVID pressure dial thousands digit
createGlobalPropertyf("tu154ce/gauges/alt/vd15_alt_left", 0)     -- VD-15 altimeter reading (captain)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_tri_needle_left", 0)-- VD-15 correction pointer (captain)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_pressure_left",760)-- VD-15 pressure setting (captain)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_alt_right", 0)      -- VD-15 altimeter reading (first officer)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_tri_needle_right", 0)-- VD-15 correction pointer (first officer)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_pressure_right",760)-- VD-15 pressure setting (first officer)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_alt_eng", 0)        -- VD-15 altimeter reading (flight engineer)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_tri_needle_eng", 0) -- VD-15 correction pointer (flight engineer)
createGlobalPropertyf("tu154ce/gauges/alt/vd15_pressure_eng",760)-- VD-15 pressure setting (flight engineer)
createGlobalPropertyf("tu154ce/gauges/alt/vbe_alt_left", 0)        -- VBE altimeter reading (left)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_press_left",1013)   -- VBE altimeter pressure setting (left)
createGlobalPropertyf("tu154ce/gauges/alt/vbe_brt_left", 0.7)      -- VBE altimeter brightness (left)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_press_knob_left", 0)-- VBE pressure adjust knob (left)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_fl_knob_left", 0)   -- VBE flight-level adjust knob (left)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_mode_but_left", 0)   -- VBE mode select button (left)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_mode_left", 0)       -- VBE mode indicator (left)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_std_left", 0)        -- VBE standard pressure setting enable (left)
createGlobalPropertyf("tu154ce/gauges/alt/vbe_alt_right", 0)       -- VBE altimeter reading (right)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_press_right",1013)  -- VBE altimeter pressure setting (right)
createGlobalPropertyf("tu154ce/gauges/alt/vbe_brt_right", 0.7)     -- VBE altimeter brightness (right)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_press_knob_right", 0)-- VBE pressure adjust knob (right)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_fl_knob_right", 0)  -- VBE flight-level adjust knob (right)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_mode_but_right", 0)  -- VBE mode select button (right)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_mode_right", 0)      -- VBE mode indicator (right)
createGlobalPropertyi("tu154ce/gauges/alt/vbe_std_right", 0)       -- VBE standard pressure setting enable (right)
createGlobalPropertyf("tu154ce/gauges/vsi/vsi_brt_left", 0.7)      -- VSI display brightness (left)
createGlobalPropertyf("tu154ce/gauges/vsi/vsi_brt_right", 0.7)     -- VSI display brightness (right)
createGlobalPropertyf("tu154ce/gauges/compas/radiocomp_scale_left", 0)-- ADF NAV1 course scale (captain)
createGlobalPropertyf("tu154ce/gauges/compas/bearing_1_left", 0)   -- ADF needle 1 bearing (captain)
createGlobalPropertyf("tu154ce/gauges/compas/bearing_2_left", 0)   -- ADF needle 2 bearing (captain)
createGlobalPropertyi("tu154ce/gauges/compas/source_1_switch_left",1)-- NAV source switch 1 (captain): 0=none,1=ADF1,2=ADF2,3=VOR1,4=VOR2,5=RSBN
createGlobalPropertyi("tu154ce/gauges/compas/source_2_switch_left",2)-- NAV source switch 2 (captain): see above
createGlobalPropertyf("tu154ce/gauges/compas/radiocomp_scale_right", 0)   -- NAV1 course scale (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/bearing_1_right", 0)        -- ADF needle 1 bearing (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/bearing_2_right", 0)        -- ADF needle 2 bearing (first officer)
createGlobalPropertyi("tu154ce/gauges/compas/source_1_switch_right", 1)   -- NAV source switch 1 (first officer): 0=none,1=ADF1,2=ADF2,3=VOR1,4=VOR2,5=RSBN
createGlobalPropertyi("tu154ce/gauges/compas/source_2_switch_right", 2)   -- NAV source switch 2 (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/big_knob", 0)               -- large compass adjustment knob
createGlobalPropertyf("tu154ce/gauges/compas/big_course_needle", 0)      -- airplane symbol course needle
createGlobalPropertyf("tu154ce/gauges/compas/big_true_course_needle", 0) -- true course (“PU”) needle
createGlobalPropertyf("tu154ce/gauges/compas/big_tri_needle", 0)         -- triangular pointer
createGlobalPropertyf("tu154ce/gauges/compas/pkp_gyro_course_L", 0)      -- PKP gyro course (captain)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_L", 0)              -- PKP OBS course (captain)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_helper_course_L", 0)     -- PKP yellow pointer set course (captain)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_slip_angle_L", 0)       -- PKP slip angle indicator (captain)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_course_plank_L", 0)      -- PKP course bar + right deflection (captain)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_gs_plank_L", 0)         -- PKP glideslope bar + up deflection (captain)
createGlobalPropertyi("tu154ce/gauges/compas/pkp_course_flag_L", 0)      -- PKP course flag failure
createGlobalPropertyi("tu154ce/gauges/compas/pkp_gs_flag_L", 0)          -- PKP glideslope flag failure
createGlobalPropertyi("tu154ce/gauges/compas/pkp_main_flag_L", 0)        -- PKP main course failure flag
createGlobalPropertyi("tu154ce/gauges/compas/pkp_obs_flag_L", 0)         -- PKP OBS counter failure flag
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_one_L", 0)          -- PKP OBS counter units digit
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_ten_L", 0)          -- PKP OBS counter tens digit
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_hundr_L", 0)         -- PKP OBS counter hundreds digit
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_knob_L", 0)         -- PKP OBS setting knob
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_set_L", 0)          -- PKP OBS set course (captain)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_gyro_course_R", 0)      -- PKP gyro course (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_R", 0)              -- PKP OBS course (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_helper_course_R", 0)     -- PKP yellow pointer set course (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_slip_angle_R", 0)       -- PKP slip angle indicator (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_course_plank_R", 0)      -- PKP course bar + right deflection (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_gs_plank_R", 0)         -- PKP glideslope bar + up deflection (first officer)
createGlobalPropertyi("tu154ce/gauges/compas/pkp_course_flag_R", 0)      -- PKP course flag failure (first officer)
createGlobalPropertyi("tu154ce/gauges/compas/pkp_gs_flag_R", 0)          -- PKP glideslope flag failure (first officer)
createGlobalPropertyi("tu154ce/gauges/compas/pkp_main_flag_R", 0)        -- PKP main course failure flag (first officer)
createGlobalPropertyi("tu154ce/gauges/compas/pkp_obs_flag_R", 0)         -- PKP OBS counter failure flag (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_one_R", 0)          -- PKP OBS counter units digit (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_ten_R", 0)          -- PKP OBS counter tens digit (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_hundr_R", 0)         -- PKP OBS counter hundreds digit (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_knob_R", 0)         -- PKP OBS setting knob (first officer)
createGlobalPropertyf("tu154ce/gauges/compas/pkp_obs_set_R", 0)          -- PKP OBS set course (first officer)
createGlobalPropertyf("tu154ce/gauges/ahz/roll_L", 0)                    -- AHZ roll angle (captain; + right)
createGlobalPropertyf("tu154ce/gauges/ahz/pitch_L", 0)                   -- AHZ pitch angle (captain; + nose up)
createGlobalPropertyf("tu154ce/gauges/ahz/dir_roll_L", 0)                -- AHZ roll director (captain; + right)
createGlobalPropertyf("tu154ce/gauges/ahz/dir_pitch_L", 0)               -- AHZ pitch director (captain; + up)
createGlobalPropertyf("tu154ce/gauges/ahz/course_plank_L", 0)            -- AHZ course bar (captain; + right)
createGlobalPropertyf("tu154ce/gauges/ahz/gs_plank_L", 0)                -- AHZ glideslope bar (captain; + up)
createGlobalPropertyf("tu154ce/gauges/ahz/speed_plank_L", 0)             -- AHZ speed bar (captain; + up)
createGlobalPropertyf("tu154ce/gauges/ahz/pitch_corr_L", 0)              -- AHZ pitch correction (captain; + right)
createGlobalPropertyi("tu154ce/gauges/ahz/ahz_flag_L", 0)                -- AHZ failure flag (captain)
createGlobalPropertyi("tu154ce/gauges/ahz/dir_roll_flag_L", 0)           -- AHZ roll director failure flag (captain)
createGlobalPropertyi("tu154ce/gauges/ahz/dir_pitch_flag_L", 0)          -- AHZ pitch director failure flag (captain)
createGlobalPropertyf("tu154ce/gauges/ahz/roll_R", 0)                    -- AHZ roll angle (first officer; + right)
createGlobalPropertyf("tu154ce/gauges/ahz/pitch_R", 0)                   -- AHZ pitch angle (first officer; + nose up)
createGlobalPropertyf("tu154ce/gauges/ahz/dir_roll_R", 0)                -- AHZ roll director (first officer; + right)
createGlobalPropertyf("tu154ce/gauges/ahz/dir_pitch_R", 0)               -- AHZ pitch director (first officer; + up)
createGlobalPropertyf("tu154ce/gauges/ahz/course_plank_R", 0)            -- AHZ course bar (first officer; + right)
createGlobalPropertyf("tu154ce/gauges/ahz/gs_plank_R", 0)                -- AHZ glideslope bar (first officer; + up)
createGlobalPropertyf("tu154ce/gauges/ahz/speed_plank_R", 0)             -- AHZ speed bar (first officer; + up)
createGlobalPropertyf("tu154ce/gauges/ahz/pitch_corr_R", 0)              -- AHZ pitch correction (first officer; + right)
createGlobalPropertyi("tu154ce/gauges/ahz/ahz_flag_R", 0)                -- AHZ failure flag (first officer)
createGlobalPropertyi("tu154ce/gauges/ahz/dir_roll_flag_R", 0)           -- AHZ roll director failure flag (first officer)
createGlobalPropertyi("tu154ce/gauges/ahz/dir_pitch_flag_R", 0)          -- AHZ pitch director failure flag (first officer)
createGlobalPropertyf("tu154ce/gauges/ahz/roll_C", 0)                    -- AGR roll angle (+ right)
createGlobalPropertyf("tu154ce/gauges/ahz/pitch_C", 0)                   -- AGR pitch angle (+ up)
createGlobalPropertyf("tu154ce/gauges/ahz/pitch_corr_C", 0)              -- AGR pitch correction (+ right)
createGlobalPropertyi("tu154ce/gauges/ahz/ahz_flag_C", 0)                -- AGR failure flag
createGlobalPropertyf("tu154ce/gauges/misc/aoa_ind", 0)                  -- angle-of-attack indicator
createGlobalPropertyf("tu154ce/gauges/misc/aoa_sector", 0)               -- angle-of-attack sector indicator
createGlobalPropertyf("tu154ce/gauges/misc/gforce_ind", 0)               -- G-force indicator
createGlobalPropertyf("tu154ce/gauges/misc/gforce_max", 0)               -- maximum G-force memory indicator
createGlobalPropertyf("tu154ce/gauges/misc/gforce_min", 0)               -- minimum G-force memory indicator
createGlobalPropertyi("tu154ce/buttons/misc/gforce_reset", 0)           -- reset G-force memory button
createGlobalPropertyf("tu154ce/gauges/engine/rpm_low_1", 0)              -- N1 RPM indicator engine 1
createGlobalPropertyf("tu154ce/gauges/engine/rpm_low_2", 0)              -- N1 RPM indicator engine 2
createGlobalPropertyf("tu154ce/gauges/engine/rpm_low_3", 0)              -- N1 RPM indicator engine 3
createGlobalPropertyf("tu154ce/gauges/engine/rpm_high_1", 0)             -- N2 RPM indicator engine 1
createGlobalPropertyf("tu154ce/gauges/engine/rpm_high_2", 0)             -- N2 RPM indicator engine 2
createGlobalPropertyf("tu154ce/gauges/engine/rpm_high_3", 0)             -- N2 RPM indicator engine 3
createGlobalPropertyf("tu154ce/gauges/misc/stab_ind", 0)                -- stabilizer position indicator
createGlobalPropertyf("tu154ce/gauges/misc/elevator_ind", 0)            -- elevator position indicator
createGlobalPropertyf("tu154ce/gauges/misc/flap_left_ind", 0)           -- left flap position indicator
createGlobalPropertyf("tu154ce/gauges/misc/flap_right_ind", 0)          -- right flap position indicator
createGlobalPropertyi("tu154ce/switchers/ZK_select", 0)                 -- ZK input selector: 0=left, 1=right
createGlobalPropertyi("tu154ce/switchers/nav_select", 0)                -- NVU/SNS selector: 0=NVU, 1=GPS/INS
createGlobalPropertyi("tu154ce/switchers/vbe_select", 0)                -- VBE selector: 0=left, 1=right
createGlobalPropertyf("tu154ce/gauges/hydro/pressure_ind_1", 0)         -- hydraulic pressure indicator 1
createGlobalPropertyf("tu154ce/gauges/hydro/pressure_ind_2", 0)         -- hydraulic pressure indicator 2
createGlobalPropertyf("tu154ce/gauges/hydro/pressure_ind_3", 0)         -- hydraulic pressure indicator 3
createGlobalPropertyf("tu154ce/gauges/hydro/pressure_ind_emerg", 0)     -- emergency brake hydraulic pressure indicator
createGlobalPropertyf("tu154ce/gauges/misc/thermo_outside", 0)          -- outside air temperature indicator
createGlobalPropertyf("tu154ce/gauges/misc/turn_rate_ind", 0)           -- turn rate indicator
createGlobalPropertyf("tu154ce/gauges/misc/slip_rate_ind", 0)           -- slip/skid indicator
createGlobalPropertyf("tu154ce/gauges/misc/rudder_pos_ind", 0)         -- rudder position indicator
createGlobalPropertyf("tu154ce/gauges/misc/aileron_pos_ind", 0)        -- aileron position indicator
createGlobalPropertyf("tu154ce/gauges/misc/elevator_pos_ind", 0)       -- elevator position indicator
createGlobalPropertyf("tu154ce/gauges/misc/fuel_front_ind", 0)         -- fuel gauge front panel indicator
createGlobalPropertyi("tu154ce/buttons/misc/fuel_front_zero", 0)       -- fuel front panel zero set button
createGlobalPropertyi("tu154ce/buttons/misc/fuel_front_max", 0)        -- fuel front panel max set button
createGlobalPropertyf("tu154ce/gauges/misc/rsbn_azimuth_ind", 0)       -- RSBN azimuth indicator
createGlobalPropertyf("tu154ce/gauges/misc/rsbn_distance_km", 0)       -- RSBN distance (km)
createGlobalPropertyf("tu154ce/gauges/misc/rsbn_km_one", 0)            -- RSBN kilometers units drum counter
createGlobalPropertyf("tu154ce/gauges/misc/rsbn_km_ten", 0)  -- RSBN kilometers tens drum counter
createGlobalPropertyf("tu154ce/gauges/misc/rsbn_km_hun", 0)  -- RSBN kilometers hundreds drum counter
createGlobalPropertyf("tu154ce/gauges/misc/compas_big_needle", 0)  -- long needle on first officer’s compass
createGlobalPropertyf("tu154ce/gauges/misc/compas_small_needle", 0)  -- short needle on first officer’s compass
createGlobalPropertyf("tu154ce/gauges/misc/compas_knob", 0)  -- adjustment knob on first officer’s compass
createGlobalPropertyf("tu154ce/gauges/misc/diss_abs_angle_1",     1)  -- DISS absolute angle units digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_abs_angle_10",    2)  -- DISS absolute angle tens digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_abs_angle_100",   3)  -- DISS absolute angle hundreds digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_plus_angle_1", 0)  -- DISS plus angle units digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_plus_angle_10", 0)  -- DISS plus angle tens digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_minus_angle_1", 0)  -- DISS minus angle units digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_minus_angle_10",  0)  -- DISS minus angle tens digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_wind_spd_1", 0)  -- DISS wind speed units digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_wind_spd_10", 0)  -- DISS wind speed tens digit drum
createGlobalPropertyf("tu154ce/gauges/misc/diss_wind_spd_100", 0)  -- DISS wind speed hundreds digit drum
createGlobalPropertyi("tu154ce/switchers/ovhd/var_left",          1)  -- overhead VAR left selector
createGlobalPropertyi("tu154ce/switchers/ovhd/var_right",         1)  -- overhead VAR right selector
createGlobalPropertyi("tu154ce/switchers/ovhd/uvid_on",           1)  -- overhead UVID power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/auasp_on",          1)  -- overhead AUASP power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/auasp_contr",       0)  -- overhead AUASP control switch
createGlobalPropertyi("tu154ce/switchers/ovhd/eup_on",            1)  -- overhead EUP power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/agr_on",            1)  -- overhead AGR power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/bkk_contr_cap", 0)  -- overhead BKK control switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/bkk_contr", 0)  -- BKK control selector: –1=2, 0=off, +1=1
createGlobalPropertyi("tu154ce/switchers/ovhd/bkk_on_cap",       0)  -- overhead BKK power switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/bkk_on",           1)  -- overhead BKK power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sau_stu_on",       1)  -- overhead SAU/STU power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sau_stu_cap", 0)  -- overhead SAU/STU switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/pkp_left_cap", 0)  -- overhead PKP left switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/pkp_left_on",      1)  -- overhead PKP left power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/pkp_right_cap", 0)  -- overhead PKP right switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/pkp_right_on",     1)  -- overhead PKP right power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/mgv_contr_cap", 0)  -- overhead MGV control switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/mgv_contr",        1)  -- overhead MGV control switch
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_on_1",         1)  -- overhead TKS power switch 1
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_on_2",         1)  -- overhead TKS power switch 2
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_heat", 0)  -- overhead TKS heater switch
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_corr_1",       1)  -- overhead BGMK correction switch 1
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_corr_2",       1)  -- overhead BGMK correction switch 2
createGlobalPropertyi("tu154ce/switchers/ovhd/curs_pnp_mode_1",  1)  -- overhead PNP course mode 1: 0=GMK, 1=GPK
createGlobalPropertyi("tu154ce/switchers/ovhd/curs_pnp_mode_2",  1)  -- overhead PNP course mode 2: 0=GMK, 1=GPK
createGlobalPropertyi("tu154ce/buttons/ovhd/svs_contr", 0)  -- overhead SVS control button
createGlobalPropertyi("tu154ce/switchers/ovhd/svs_on",           1)  -- overhead SVS power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/svs_heat",         1)  -- overhead SVS heater switch
createGlobalPropertyi("tu154ce/switchers/ovhd/kln_on", 0)  -- overhead KLN power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/tcas_on",          1)  -- overhead TCAS power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/emerg_light_cap",  0)  -- overhead emergency light switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/emerg_light_on", 0)  -- overhead emergency lights switch
createGlobalPropertyi("tu154ce/switchers/ovhd/vbe_1_on",         1)  -- overhead VBE 1 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/vbe_2_on",         1)  -- overhead VBE 2 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/curs_np_on_1",     1)  -- overhead KursMP1 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/curs_np_on_2",     1)  -- overhead KursMP2 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/tra_67_on",        1)  -- overhead TRA67 power switch
createGlobalPropertyi("tu154ce/buttons/ovhd/tks_signal_off", 0)  -- overhead TKS signal inhibit button
createGlobalPropertyi("tu154ce/switchers/ovhd/rsbn_on",          1)  -- overhead RSBN power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/rsbn_recon",       1)  -- overhead RSBN identification switch
createGlobalPropertyi("tu154ce/switchers/ovhd/rv5_1_on",         1)  -- overhead RV5-1 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/rv5_2_on",         1)  -- overhead RV5-2 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/vhf_1_on",         1)  -- overhead VHF1 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/vhf_2_on",         1)  -- overhead VHF2 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/stabil_ga_main",   1)  -- overhead AGR main roll stabilization switch
createGlobalPropertyi("tu154ce/switchers/ovhd/stabil_ga_reserv", 1)  -- overhead AGR reserve stabilization switch
createGlobalPropertyi("tu154ce/switchers/ovhd/micron_1_on",      1)  -- overhead Micron 1 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/micron_2_on",      1)  -- overhead Micron 2 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/spu_on",           1)  -- overhead SPU power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sgs_on",           1)  -- overhead SGS power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sd75_1_on",        1)  -- overhead SD75-1 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sd75_2_on",        1)  -- overhead SD75-2 power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/mars_on",          1)  -- overhead MARS power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/diss_on",          1)  -- overhead DISS power switch
createGlobalPropertyi("tu154ce/switchers/ovhd/diss_mode",        1)  -- overhead DISS mode: 0=sea, 1=land
createGlobalPropertyi("tu154ce/switchers/ovhd/nvu_calc_set",     1)  -- overhead NVU compute mode: –1=DISS in flight, 0=NVU via SVS,1=NVU via DISS
createGlobalPropertyi("tu154ce/switchers/ovhd/vent_1", 0)  -- overhead captain’s vent fan switch
createGlobalPropertyi("tu154ce/switchers/ovhd/vent_2", 0)  -- overhead first officer’s vent fan switch
createGlobalPropertyi("tu154ce/switchers/ovhd/vent_3", 0)  -- overhead engineer’s vent fan switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sign_belts",       1)  -- overhead “Fasten Seat Belts” sign switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sign_nosmoke",     1)  -- overhead “No Smoking” sign switch
createGlobalPropertyi("tu154ce/switchers/ovhd/sign_exit", 0)  -- overhead “Exit” sign switch
createGlobalPropertyi("tu154ce/switchers/ovhd/window_heat_1",    -1)  -- overhead windshield heat: –1=low, 0=off,1=high (zone 1)
createGlobalPropertyi("tu154ce/switchers/ovhd/window_heat_2",    -1)  -- overhead windshield heat: –1=low, 0=off,1=high (zone 2)
createGlobalPropertyi("tu154ce/switchers/ovhd/window_heat_3",    -1)  -- overhead windshield heat: –1=low, 0=off,1=high (zone 3)
createGlobalPropertyi("tu154ce/switchers/ovhd/pitot_heat_1",      1)  -- overhead pitot heat left
createGlobalPropertyi("tu154ce/switchers/ovhd/pitot_heat_2",      1)  -- overhead pitot heat right
createGlobalPropertyi("tu154ce/switchers/ovhd/pitot_heat_3",      1)  -- overhead pitot heat ABSU
createGlobalPropertyi("tu154ce/switchers/ovhd/arm406",           1)  -- overhead ARM 406 switch
createGlobalPropertyi("tu154ce/switchers/ovhd/ushdb_mode_1", 0)  -- overhead USHDB/SPU1 mode: 0=ARK,1=VOR
createGlobalPropertyi("tu154ce/switchers/ovhd/ushdb_mode_2", 0)  -- overhead USHDB mode 2
createGlobalPropertyi("tu154ce/switchers/ovhd/egpws_alarm_1",     1)  -- overhead EGPWS global alarm switch 1
createGlobalPropertyi("tu154ce/switchers/ovhd/egpws_alarm_2",     1)  -- overhead EGPWS global alarm switch 2
createGlobalPropertyi("tu154ce/switchers/ovhd/egpws_alarm_1_cap", 0)  -- overhead EGPWS alarm 1 switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/egpws_alarm_2_cap", 0)  -- overhead EGPWS alarm 2 switch cover
createGlobalPropertyi("tu154ce/switchers/ovhd/egpws_relief",      1)  -- overhead terrain relief display switch
createGlobalPropertyi("tu154ce/switchers/ovhd/egpws_mode", 0)  -- overhead EGPWS mode switch: 0=QNH,1=QFE
createGlobalPropertyi("tu154ce/buttons/ovhd/egpws_control",       0)  -- overhead EGPWS control button
createGlobalPropertyi("tu154ce/buttons/ovhd/egpws_contr_gs", 0)  -- overhead EGPWS glideslope control button
createGlobalPropertyi("tu154ce/buttons/ovhd/rsbn_control_strobe", 0)  -- overhead RSBN strobe control button
createGlobalPropertyi("tu154ce/buttons/ovhd/rsbn_control_azimuth", 0)  -- overhead RSBN azimuth zero control button
createGlobalPropertyi("tu154ce/buttons/ovhd/rsbn_control_distance", 0)  -- overhead RSBN distance zero control button
createGlobalPropertyi("tu154ce/buttons/ovhd/rsbn_ch_ten", 0)  -- overhead RSBN channel tens setting knob
createGlobalPropertyi("tu154ce/buttons/ovhd/rsbn_ch_one", 0)  -- overhead RSBN channel units setting knob
createGlobalPropertyi("tu154ce/switchers/ovhd/transponder_mode", 0)  -- transponder mode: 0=off, 1=standby, 2=Rsp, 3=Uvd, 4=Uvd-M, 5=AS, 6=A  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_control", 0)  -- transponder control button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_sign", 0)  -- transponder ident (“✶”) button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_but_1", 0)  -- transponder digit “1” button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_but_2", 0)  -- transponder digit “2” button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_but_3", 0)  -- transponder digit “3” button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_but_4", 0)  -- transponder digit “4” button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_emerg", 0)  -- transponder emergency code (7700) button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/transponder_emerg_cap", 0)  -- emergency button cover installed  
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_mode",            1)  -- TKS mode: 0=MK, 1=GPK, 2=AK  
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_mode_left",       1)  -- left AHRS mode: 0=control, 1=main  
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_mode_right",      1)  -- right AHRS mode  
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_lat_mode",        1)  -- latitude setting mode: 0=auto, 1=manual  
createGlobalPropertyi("tu154ce/switchers/ovhd/tks_course_set", 0)  -- TKS course set button pressed  
createGlobalPropertyi("tu154ce/buttons/ovhd/tks_corrr_button", 0)  -- TKS sync/confirm button pressed  
createGlobalPropertyf("tu154ce/rotary/ovhd/tks_lat_set",           45)  -- TKS latitude setting knob (deg)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_mode",         1)  -- ARK-1 mode: 0=off,1=comparator,2=antenna,3=frame  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_channel",      1)  -- ARK-1 channel number  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_hundr_left",   1)  -- ARK-1 frequency hundreds digit (1–17)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_tens_left",    1)  -- ARK-1 frequency tens digit (0–10)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_ones_left", 0)  -- ARK-1 frequency units digit (0–9)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_hundr_right",  1)  -- ARK-1 frequency hundreds digit (right)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_tens_right",   1)  -- ARK-1 frequency tens digit (right)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_1_ones_right", 0)  -- ARK-1 frequency units digit (right)  
createGlobalPropertyi("tu154ce/buttons/ovhd/ark_1_ramka", 0)  -- ARK-1 radar range frame button pressed  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_mode",         1)  -- ARK-2 mode  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_channel",      1)  -- ARK-2 channel number  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_hundr_left",   1)  -- ARK-2 freq hundreds digit (1–17)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_tens_left",    1)  -- ARK-2 freq tens digit  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_ones_left", 0)  -- ARK-2 freq units digit  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_hundr_right",  1)  -- ARK-2 freq hundreds digit (right)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_tens_right",   1)  -- ARK-2 freq tens digit (right)  
createGlobalPropertyi("tu154ce/switchers/ovhd/ark_2_ones_right", 0)  -- ARK-2 freq units digit (right)  
createGlobalPropertyi("tu154ce/buttons/ovhd/ark_2_ramka", 0)  -- ARK-2 radar range frame button pressed  
createGlobalPropertyi("tu154ce/switchers/ovhd/sp50_mode", 0)  -- SP-50 mode: 0=ILS,1=Katet,2=SP-50  
createGlobalPropertyi("tu154ce/switchers/ovhd/sp50_nav_mode", 0)  -- SP-50 display: approach vs route  
createGlobalPropertyi("tu154ce/switchers/ovhd/sp50_night_day",    1)  -- SP-50 night/day mode  
createGlobalPropertyi("tu154ce/switchers/ovhd/sp50_dme_rsbn", 0)  -- SP-50 DME vs RSBN mode  
createGlobalPropertyi("tu154ce/rotary/ovhd/vhf_1_left", 0)  -- VHF-1 tuning knob (left)  
createGlobalPropertyi("tu154ce/rotary/ovhd/vhf_1_right", 0)  -- VHF-1 tuning knob (right)  
createGlobalPropertyi("tu154ce/rotary/ovhd/vhf_2_left", 0)  -- VHF-2 tuning knob (left)  
createGlobalPropertyi("tu154ce/rotary/ovhd/vhf_2_right", 0)  -- VHF-2 tuning knob (right)  
createGlobalPropertyi("tu154ce/switchers/nav_1_mode",            1)  -- NAV-1 mode: capture vs VOR-DME  
createGlobalPropertyi("tu154ce/switchers/nav_1_man_auto", 0)  -- NAV-1 manual/auto switch  
createGlobalPropertyi("tu154ce/switchers/nav_1_mile_km",         1)  -- NAV-1 miles/km switch  
createGlobalPropertyi("tu154ce/rotary/ovhd/nav_1_left", 0)  -- NAV-1 frequency tens knob (left)  
createGlobalPropertyi("tu154ce/rotary/ovhd/nav_1_right", 0)  -- NAV-1 frequency units knob (right)  
createGlobalPropertyi("tu154ce/buttons/ovhd/nav_1_but_1", 0)  -- NAV-1 preset button 1  
createGlobalPropertyi("tu154ce/buttons/ovhd/nav_1_but_2", 0)  -- NAV-1 preset button 2  
createGlobalPropertyi("tu154ce/buttons/ovhd/nav_1_but_3", 0)  -- NAV-1 preset button 3  
createGlobalPropertyi("tu154ce/switchers/nav_2_mode",            1)  -- NAV-2 mode: capture vs VOR-DME  
createGlobalPropertyi("tu154ce/switchers/nav_2_man_auto", 0)  -- NAV-2 manual/auto switch  
createGlobalPropertyi("tu154ce/switchers/nav_2_mile_km",         1)  -- NAV-2 miles/km switch  
createGlobalPropertyi("tu154ce/rotary/ovhd/nav_2_left", 0)  -- NAV-2 tens knob  
createGlobalPropertyi("tu154ce/rotary/ovhd/nav_2_right", 0)  -- NAV-2 units knob  
createGlobalPropertyi("tu154ce/buttons/ovhd/nav_2_but_1", 0)  -- NAV-2 preset button 1  
createGlobalPropertyi("tu154ce/buttons/ovhd/nav_2_but_2", 0)  -- NAV-2 preset button 2  
createGlobalPropertyi("tu154ce/buttons/ovhd/nav_2_but_3", 0)  -- NAV-2 preset button 3  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_temp_1",         20)  -- engine 1 fuel temperature (°C)  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_temp_2",         20)  -- engine 2 fuel temperature (°C)  
createGlobalPropertyf("tu154ce/gauges/eng/oil_qty_1",           1)  -- engine 1 oil quantity (% or units)  
createGlobalPropertyf("tu154ce/gauges/eng/oil_qty_2",           1)  -- engine 2 oil quantity  
createGlobalPropertyf("tu154ce/gauges/eng/oil_qty_3",           1)  -- engine 3 oil quantity  
createGlobalPropertyf("tu154ce/gauges/eng/km5_scale_1", 0)  -- KM-5 gyro scale rotation (deg)  
createGlobalPropertyf("tu154ce/gauges/eng/km5_needle_1", 0)  -- KM-5 gyro needle angle  
createGlobalPropertyf("tu154ce/gauges/eng/km5_knob_1", 0)  -- KM-5 adjustment knob  
createGlobalPropertyf("tu154ce/gauges/eng/km5_scale_2", 0)  -- KM-5 gyro scale rotation (right)  
createGlobalPropertyf("tu154ce/gauges/eng/km5_needle_2", 0)  -- KM-5 gyro needle angle (right)  
createGlobalPropertyf("tu154ce/gauges/eng/km5_knob_2", 0)  -- KM-5 adjustment knob (right)  
createGlobalPropertyi("tu154ce/buttons/lamp_test_front", 0)  -- front panel lamp test button pressed  
createGlobalPropertyi("tu154ce/buttons/lamp_test_upper_gear", 0)  -- upper gear panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_eng_up_1", 0)  -- engine drain panel lamp test button 1  
createGlobalPropertyi("tu154ce/buttons/lamp_test_eng_up_2", 0)  -- engine drain panel lamp test button 2  
createGlobalPropertyi("tu154ce/buttons/lamp_test_msrp", 0)  -- MSRP panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_pa56", 0)  -- PA-56 hydraulic panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_fire_panel", 0)  -- fire panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_apu", 0)  -- APU panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_engines", 0)  -- engine instruments lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_hydro", 0)  -- hydraulic system panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_srd", 0)  -- bleed air panel lamp test button  
createGlobalPropertyi("tu154ce/buttons/lamp_test_doors", 0)  -- doors and hatches panel lamp test button  
createGlobalPropertyi("tu154ce/switchers/eng/wing_light",       1)  -- wing navigation lights on ground switch  
createGlobalPropertyi("tu154ce/switchers/eng/door_heat", 0)  -- door heat switch  
createGlobalPropertyi("tu154ce/switchers/eng/gear_fan", 0)  -- landing gear bay ventilation fan switch  
createGlobalPropertyi("tu154ce/switchers/eng/galley_heat", 0)  -- galley drain heat switch  
createGlobalPropertyi("tu154ce/switchers/eng/lavatory_heat", 0)  -- lavatory drain heat switch  
createGlobalPropertyi("tu154ce/switchers/eng/water_meter", 0)  -- water tank level gauge switch  
createGlobalPropertyi("tu154ce/switchers/eng/water_compressor_1", 0)  -- water compressor 1 switch  
createGlobalPropertyi("tu154ce/switchers/eng/water_compressor_2", 0)  -- water compressor 2 switch  
createGlobalPropertyf("tu154ce/gauges/eng/water_pressure", 0)  -- water system pressure gauge angle  
createGlobalPropertyi("tu154ce/buttons/eng/tail_temp_signal_control_1", 0) -- tail compartment temp warning control 1  
createGlobalPropertyi("tu154ce/buttons/eng/tail_temp_signal_control_2", 0) -- tail compartment temp warning control 2  
createGlobalPropertyi("tu154ce/switchers/eng/tail_temp_signal",  0)  -- tail compartment temperature warning switch  
createGlobalPropertyi("tu154ce/switchers/eng/tail_temp_heat", 0)  -- tail compartment heater switch  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_date_ten", 0)  -- MSRP date tens digit selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_date_one", 0)  -- MSRP date units selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_month_ten", 0)  -- MSRP month tens selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_month_one", 0)  -- MSRP month units selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_year_ten", 0)  -- MSRP year tens selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_year_one", 0)  -- MSRP year units selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_route_hun", 0)  -- MSRP flight number hundreds selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_route_ten", 0)  -- MSRP flight number tens selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_route_one", 0)  -- MSRP flight number units selector  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_mlp_1",        1)  -- MSRP MLP primary switch  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_mlp_2",        1)  -- MSRP MLP secondary switch  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_night_day",    1)  -- MSRP night/day mode switch  
createGlobalPropertyi("tu154ce/switchers/eng/msrp_main_switch",  1)  -- MSRP master power switch  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_trimm_rud_1",  1)  -- hydraulic rudder trim switch 1  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_trimm_rud_2",  1)  -- hydraulic rudder trim switch 2  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_trimm_rud_1_cap", 0)  -- hydraulic rudder trim 1 cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_trimm_rud_2_cap", 0)  -- hydraulic rudder trim 2 cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_gen_on_1", 0)  -- emergency generator engage 1 switch  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_gen_on_2", 0)  -- emergency generator engage 2 switch  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_gen_on_3", 0)  -- emergency generator engage 3 switch  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_gen_on_1_cap", 0)  -- emergency gen 1 switch cover  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_gen_on_2_cap", 0)  -- emergency gen 2 switch cover  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_gen_on_3_cap", 0)  -- emergency gen 3 switch cover  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_rud_1",  1)  -- RA-56 rudder hydraulic pump 1 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_rud_2",  1)  -- RA-56 rudder hydraulic pump 2 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_rud_3",  1)  -- RA-56 rudder hydraulic pump 3 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_ail_1",  1)  -- RA-56 aileron hydraulic pump 1 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_ail_2",  1)  -- RA-56 aileron hydraulic pump 2 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_ail_3",  1)  -- RA-56 aileron hydraulic pump 3 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_elev_1", 1)  -- RA-56 elevator hydraulic pump 1 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_elev_2", 1)  -- RA-56 elevator hydraulic pump 2 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_ra56_elev_3", 1)  -- RA-56 elevator hydraulic pump 3 enable  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_circuit_auto_man", 0) -- hydraulic circuit auto/manual selector  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_long_control",1)  -- longitudinal control hydraulic switch  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_circuit_auto_man_cap", 0) -- hydraulic auto/manual cover  
createGlobalPropertyi("tu154ce/switchers/eng/hydro_long_control_cap", 0) -- longitudinal control cover  
createGlobalPropertyi("tu154ce/buttons/eng/fire_ext_1", 0)  -- engine 1 fire extinguisher discharge button  
createGlobalPropertyi("tu154ce/buttons/eng/fire_ext_2", 0)  -- engine 2 fire extinguisher discharge button  
createGlobalPropertyi("tu154ce/buttons/eng/fire_ext_3", 0)  -- engine 3 fire extinguisher discharge button  
createGlobalPropertyi("tu154ce/buttons/eng/cold_eng_1", 0)  -- engine 1 freeze extinguisher supply button  
createGlobalPropertyi("tu154ce/buttons/eng/cold_eng_2", 0)  -- engine 2 freeze extinguisher supply  
createGlobalPropertyi("tu154ce/buttons/eng/cold_eng_3", 0)  -- engine 3 freeze extinguisher supply  
createGlobalPropertyi("tu154ce/buttons/eng/cold_apu", 0)  -- APU freeze extinguisher supply  
createGlobalPropertyi("tu154ce/buttons/eng/neutral_gas", 0)  -- neutral gas release button  
createGlobalPropertyi("tu154ce/buttons/eng/smoke_test", 0)  -- smoke test button  
createGlobalPropertyi("tu154ce/buttons/eng/ext_test", 0)  -- exterior test button  
createGlobalPropertyi("tu154ce/switchers/eng/fire_sensor_sel",  0)  -- fire sensor group selector  
createGlobalPropertyi("tu154ce/switchers/eng/fire_place_sel", 0)  -- fire extinguisher discharge section selector  
createGlobalPropertyi("tu154ce/switchers/eng/fire_main_switch", 1)  -- main fire system master switch  
createGlobalPropertyi("tu154ce/switchers/eng/fire_buzzer",      1)  -- fire warning buzzer switch  
createGlobalPropertyi("tu154ce/switchers/eng/fire_buzzer_cap",  0)  -- fire buzzer cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/srd_buzzer",       1)  -- bleed air warning buzzer switch  
createGlobalPropertyi("tu154ce/switchers/eng/srd_buzzer_cap", 0)  -- bleed air buzzer cover installed  
createGlobalPropertyi("tu154ce/buttons/eng/srd_buzzer_test", 0)  -- bleed air buzzer test button  
createGlobalPropertyi("tu154ce/switchers/eng/fuel_buzzer",      1)  -- low fuel (2 500 kg) warning buzzer switch  
createGlobalPropertyi("tu154ce/switchers/eng/fuel_buzzer_cap",  0)  -- low fuel buzzer cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/soi21_on",         1)  -- SOI-21 system power switch  
createGlobalPropertyi("tu154ce/buttons/eng/soi21_test", 0)  -- SOI-21 test button  
createGlobalPropertyi("tu154ce/switchers/eng/antiice_slats", 0)  -- slat anti-ice switch  
createGlobalPropertyi("tu154ce/switchers/eng/antiice_eng_1", 0)  -- engine 1 anti-ice switch  
createGlobalPropertyi("tu154ce/switchers/eng/antiice_eng_2", 0)  -- engine 2 anti-ice switch  
createGlobalPropertyi("tu154ce/switchers/eng/antiice_eng_3", 0)  -- engine 3 anti-ice switch  
createGlobalPropertyi("tu154ce/switchers/eng/antiice_wing", 0)  -- wing anti-ice switch  
createGlobalPropertyf("tu154ce/gauges/eng/stab_temp",          20)  -- stabilizer temperature (°C)  
createGlobalPropertyf("tu154ce/gauges/eng/wing_temp",          20)  -- wing leading edge temperature (°C)  
createGlobalPropertyi("tu154ce/switchers/eng/sard_disable", 0)  -- SARD dump valve close switch  
createGlobalPropertyi("tu154ce/switchers/eng/sard_disable_cap", 0)  -- SARD valve cover installed  
createGlobalPropertyf("tu154ce/gauges/eng/bus115_freq", 0)  -- 115 V bus frequency gauge angle  
createGlobalPropertyf("tu154ce/gauges/eng/bus115_volt", 0)  -- 115 V bus voltage gauge angle  
createGlobalPropertyf("tu154ce/gauges/eng/bus115_amp", 0)  -- 115 V bus ammeter gauge angle  
createGlobalPropertyi("tu154ce/switchers/eng/gpu_on", 0)  -- GPU (external power unit) power switch  
createGlobalPropertyi("tu154ce/switchers/eng/apu_gen_on",       0)  -- APU generator master switch  
createGlobalPropertyi("tu154ce/switchers/eng/bus115_volt_sel",  0)  -- 115 V voltmeter source selector  
createGlobalPropertyi("tu154ce/switchers/eng/bus115_volt_phase_sel", 0) -- 115 V voltmeter phase selector  
createGlobalPropertyi("tu154ce/switchers/eng/bus115_amp_sel", 0)  -- 115 V ammeter source selector  
createGlobalPropertyi("tu154ce/switchers/eng/bus115_amp_phase_sel", 0) -- 115 V ammeter phase selector  
createGlobalPropertyi("tu154ce/switchers/eng/gen_1_on",         1)  -- engine generator 1 switch: –1=test, 0=off,1=on  
createGlobalPropertyi("tu154ce/switchers/eng/gen_2_on",         1)  -- engine generator 2 switch  
createGlobalPropertyi("tu154ce/switchers/eng/gen_3_on",         1)  -- engine generator 3 switch  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_inv115", 0)  -- emergency 115 V inverter switch  
createGlobalPropertyi("tu154ce/switchers/eng/emerg_inv115_cap", 0)  -- emergency inverter cover installed  
createGlobalPropertyf("tu154ce/gauges/eng/bus36_volt", 0)  -- 36 V bus voltage gauge angle  
createGlobalPropertyi("tu154ce/switchers/eng/bus36_volt_sel", 0)  -- 36 V voltmeter source selector  
createGlobalPropertyi("tu154ce/switchers/eng/pts250_sel", 0)  -- PTS-250 transformer selector: 0=unit1,1=unit2  
createGlobalPropertyi("tu154ce/switchers/eng/bus36_tr_left_to_right", 0) -- 36 V TR1→TR2 tie: 0=auto,1=manual  
createGlobalPropertyi("tu154ce/switchers/eng/bus36_tr_right_to_left", 0) -- 36 V TR2→TR1 tie: 0=auto,1=manual  
createGlobalPropertyi("tu154ce/switchers/eng/pts250_on",       0)  -- PTS-250 power switch  
createGlobalPropertyi("tu154ce/switchers/eng/pts250_mode", 0)  -- PTS-250 mode: auto/manual  
createGlobalPropertyi("tu154ce/switchers/eng/pts250_on_cap", 0)  -- PTS-250 switch cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/pts250_mode_cap", 0)  -- PTS-250 mode cover installed  
createGlobalPropertyf("tu154ce/gauges/eng/bus27_volt", 0)  -- 27 V bus voltage gauge angle  
createGlobalPropertyf("tu154ce/gauges/eng/bus27_amp1", 0)  -- 27 V bus ammeter 1 gauge angle  
createGlobalPropertyf("tu154ce/gauges/eng/bus27_amp2", 0)  -- 27 V bus ammeter 2 gauge angle  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_volt_sel", 0)  -- 27 V voltmeter source selector  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_amp1_sel", 0)  -- 27 V ammeter 1 source selector  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_amp2_sel", 0)  -- 27 V ammeter 2 source selector  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_connect", 0)  -- 27 V bus tie switch  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_connect_cap", 0)  -- 27 V bus tie cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_vu1",        1)  -- VU1 power switch: –1=reserve, 0=off,1=on  
createGlobalPropertyi("tu154ce/switchers/eng/bus27_vu2",        1)  -- VU2 power switch: –1=reserve, 0=off,1=on  
createGlobalPropertyi("tu154ce/switchers/eng/bat1_on",          1)  -- battery 1 switch  
createGlobalPropertyi("tu154ce/switchers/eng/bat2_on",          1)  -- battery 2 switch  
createGlobalPropertyi("tu154ce/switchers/eng/bat3_on",          1)  -- battery 3 switch  
createGlobalPropertyi("tu154ce/switchers/eng/bat4_on",          1)  -- battery 4 switch  
createGlobalPropertyi("tu154ce/switchers/eng/apu_main_switch",  0)  -- APU master switch  
createGlobalPropertyi("tu154ce/switchers/eng/apu_start_mode", 0)  -- APU start mode selector
createGlobalPropertyi("tu154ce/switchers/eng/apu_air_bleed", 0)  -- APU bleed air valve switch: -1=close, 0=neutral, +1=open  
createGlobalPropertyi("tu154ce/buttons/eng/apu_start", 0)  -- APU start button  
createGlobalPropertyi("tu154ce/buttons/eng/apu_stop", 0)  -- APU stop button  
createGlobalPropertyf("tu154ce/gauges/eng/apu_rpm",            0)  -- APU RPM gauge  
createGlobalPropertyf("tu154ce/gauges/eng/apu_egt",            0)  -- APU EGT gauge  
createGlobalPropertyf("tu154ce/gauges/eng/apu_oil_temp",       0)  -- APU oil temperature gauge  
createGlobalPropertyf("tu154ce/gauges/eng/egt_1",             20)  -- engine 1 EGT gauge  
createGlobalPropertyf("tu154ce/gauges/eng/egt_2",             20)  -- engine 2 EGT gauge  
createGlobalPropertyf("tu154ce/gauges/eng/egt_3",             20)  -- engine 3 EGT gauge  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_press_1",       0)  -- engine 1 fuel pressure gauge  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_press_2",       0)  -- engine 2 fuel pressure gauge  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_press_3",       0)  -- engine 3 fuel pressure gauge  
createGlobalPropertyf("tu154ce/gauges/eng/oil_press_1", 0)  -- engine 1 oil pressure gauge  
createGlobalPropertyf("tu154ce/gauges/eng/oil_press_2", 0)  -- engine 2 oil pressure gauge  
createGlobalPropertyf("tu154ce/gauges/eng/oil_press_3", 0)  -- engine 3 oil pressure gauge  
createGlobalPropertyf("tu154ce/gauges/eng/oil_temp_1", 0)  -- engine 1 oil temperature gauge  
createGlobalPropertyf("tu154ce/gauges/eng/oil_temp_2", 0)  -- engine 2 oil temperature gauge  
createGlobalPropertyf("tu154ce/gauges/eng/oil_temp_3", 0)  -- engine 3 oil temperature gauge  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_flow_1", 0)  -- engine 1 fuel flow gauge  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_flow_2", 0)  -- engine 2 fuel flow gauge  
createGlobalPropertyf("tu154ce/gauges/eng/fuel_flow_3", 0)  -- engine 3 fuel flow gauge  
createGlobalPropertyf("tu154ce/gauges/eng/vibra_1",            0)  -- engine 1 vibration gauge  
createGlobalPropertyf("tu154ce/gauges/eng/vibra_2",            0)  -- engine 2 vibration gauge  
createGlobalPropertyf("tu154ce/gauges/eng/vibra_3",            0)  -- engine 3 vibration gauge  
createGlobalPropertyi("tu154ce/buttons/eng/control_ut", 0)  -- UT control button  
createGlobalPropertyi("tu154ce/buttons/eng/control_vibro_1", 0)  -- vibration control button 1  
createGlobalPropertyi("tu154ce/buttons/eng/control_vibro_2", 0)  -- vibration control button 2  
createGlobalPropertyi("tu154ce/buttons/eng/control_vibro_3", 0)  -- vibration control button 3  
createGlobalPropertyi("tu154ce/switchers/eng/vibro_sel_1", 0)  -- vibration instrument selector 1  
createGlobalPropertyi("tu154ce/switchers/eng/vibro_sel_2", 0)  -- vibration instrument selector 2  
createGlobalPropertyi("tu154ce/switchers/eng/vibro_sel_3", 0)  -- vibration instrument selector 3  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_summ", 0)  -- total fuel mass gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_tank1", 0)  -- fuel mass in tank 1 gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_tank2_left", 0) -- fuel mass in tank 2 (left) gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_tank2_right", 0) -- fuel mass in tank 2 (right) gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_tank3_left", 0) -- fuel mass in tank 3 (left) gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_tank3_right", 0) -- fuel mass in tank 3 (right) gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_tank4", 0)  -- fuel mass in tank 4 gauge  
createGlobalPropertyf("tu154ce/gauges/fuel/fuel_meter_mech", 0)  -- mechanical fuel flowmeter gauge  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_summ_zero", 0) -- total fuel mass zero button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_summ_max",  0) -- total fuel mass P (peak) button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_tank2_zero", 0) -- tank 2 fuel meter zero button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_tank2_max",  0) -- tank 2 fuel meter P button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_tank3_zero", 0) -- tank 3 fuel meter zero button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_tank3_max",  0) -- tank 3 fuel meter P button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_tank4_zero", 0) -- tank 4 fuel meter zero button  
createGlobalPropertyi("tu154ce/buttons/fuel/fuel_meter_tank4_max",  0) -- tank 4 fuel meter P button  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank2_left",  1)  -- tank 2 left pump switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank2_right", 1)  -- tank 2 right pump switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank3_left",  1)  -- tank 3 left pump switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank3_right", 1)  -- tank 3 right pump switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank4",       1)  -- tank 4 pump switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank1_1",     1)  -- tank 1 pump 1 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank1_2",     1)  -- tank 1 pump 2 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank1_3",     1)  -- tank 1 pump 3 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/pump_tank1_4",     1)  -- tank 1 pump 4 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_trans",       0)  -- reserve transfer valve switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_trans_cap", 0)  -- reserve transfer cover installed  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_porc", 0)  -- forced jettison switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_porc_cap", 0)  -- forced jettison cover installed  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_level",       1)  -- automatic tank leveling switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_flow_mode",   1)  -- flowmeter mode: manual/auto  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_flow_on",     1)  -- flowmeter auto-enable switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_flow_on_cap", 0)  -- flowmeter switch cover  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_meter_on",    1)  -- fuel meter power switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fuel_meter_mech_on",1)  -- mechanical flowmeter power switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fire_valve_1",     1)  -- fire valve 1 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fire_valve_2",     1)  -- fire valve 2 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fire_valve_3",     1)  -- fire valve 3 switch  
createGlobalPropertyi("tu154ce/switchers/fuel/fire_valve_1_cap", 0)  -- fire valve 1 cover installed  
createGlobalPropertyi("tu154ce/switchers/fuel/fire_valve_2_cap", 0)  -- fire valve 2 cover installed  
createGlobalPropertyi("tu154ce/switchers/fuel/fire_valve_3_cap", 0)  -- fire valve 3 cover installed  
createGlobalPropertyf("tu154ce/gauges/hydro/qty_12",            0)  -- hydraulic reservoir 1/2 quantity gauge  
createGlobalPropertyf("tu154ce/gauges/hydro/qty_3", 0)  -- hydraulic reservoir 3 quantity gauge  
createGlobalPropertyi("tu154ce/switchers/hydro/connect2to1", 0)  -- connect hydraulic system 2→1 switch  
createGlobalPropertyi("tu154ce/switchers/hydro/connect2to1_cap", 0)  -- Δ2→1 cover installed  
createGlobalPropertyi("tu154ce/switchers/hydro/pump_2", 0)  -- hydraulic pump 2 switch  
createGlobalPropertyi("tu154ce/switchers/hydro/pump_3", 0)  -- hydraulic pump 3 switch  
createGlobalPropertyi("tu154ce/buttons/hydro/qty_test_12",       0)  -- hydraulic qty test 1/2 button  
createGlobalPropertyi("tu154ce/buttons/hydro/qty_test_3", 0)  -- hydraulic qty test 3 button  
createGlobalPropertyi("tu154ce/buttons/hydro/accum_fill", 0)  -- accumulator charge button  
createGlobalPropertyf("tu154ce/gauges/airbleed/cabin_alt",       0)  -- cabin altitude gauge  
createGlobalPropertyf("tu154ce/gauges/airbleed/cabin_diff", 0)  -- cabin differential pressure gauge  
createGlobalPropertyf("tu154ce/gauges/airbleed/cabin_vvi",       0)  -- cabin vertical speed indicator gauge  
createGlobalPropertyf("tu154ce/gauges/airbleed/cockpit_temp",    20)  -- cockpit temperature gauge  
createGlobalPropertyf("tu154ce/gauges/airbleed/cabin_temp",      20)  -- cabin temperature gauge  
createGlobalPropertyf("tu154ce/gauges/airbleed/system_temp",     20)  -- bleed air system temperature gauge  
createGlobalPropertyf("tu154ce/gauges/airbleed/air_flow_1", 0)  -- bleed air flow gauge 1  
createGlobalPropertyf("tu154ce/gauges/airbleed/air_flow_2", 0)  -- bleed air flow gauge 2  
createGlobalPropertyi("tu154ce/switchers/airbleed/cabin_sel", 0)  -- cabin zone selector  
createGlobalPropertyi("tu154ce/switchers/airbleed/cockpit_temp_set",20) -- cockpit temp set knob  
createGlobalPropertyi("tu154ce/switchers/airbleed/cabin1_temp_set",20) -- cabin 1 temp set knob  
createGlobalPropertyi("tu154ce/switchers/airbleed/cabin2_temp_set",20) -- cabin 2 temp set knob  
createGlobalPropertyi("tu154ce/switchers/airbleed/cockpit_mode_set",1)  -- cockpit heating mode: 0=neutral,1=auto,2=cold,3=hot  
createGlobalPropertyi("tu154ce/switchers/airbleed/cabin1_mode_set",1)  -- cabin 1 heating mode set  
createGlobalPropertyi("tu154ce/switchers/airbleed/cabin2_mode_set",1)  -- cabin 2 heating mode set  
createGlobalPropertyi("tu154ce/switchers/airbleed/heat_close", 0)  -- heating shutoff switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/heat_close_cap", 0)  -- heating shutoff cover installed  
createGlobalPropertyi("tu154ce/switchers/airbleed/left_sys_temp_set",22) -- left manifold temp set knob  
createGlobalPropertyi("tu154ce/switchers/airbleed/right_sys_temp_set",22) -- right manifold temp set knob  
createGlobalPropertyi("tu154ce/switchers/airbleed/left_sys_mode_set", 1) -- left manifold mode set  
createGlobalPropertyi("tu154ce/switchers/airbleed/right_sys_mode_set",1) -- right manifold mode set  
createGlobalPropertyi("tu154ce/switchers/airbleed/ground_cond_on", 0)  -- ground air conditioning switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/ground_cond_on_cap", 0)-- ground AC cover installed  
createGlobalPropertyi("tu154ce/switchers/airbleed/skv_faster_work", 0)  -- rapid heating/cooling switch: -1=cool, 0=off,+1=fast heat  
createGlobalPropertyi("tu154ce/switchers/airbleed/skv_faster_work_cap", 0)-- rapid mode cover installed  
createGlobalPropertyi("tu154ce/switchers/airbleed/sys_temp_select",1)   -- bleed system temp source selector: 0=door heat,1=cockpit,2=cabin1,3=cabin2,4=left manifold,5=right manifold  
createGlobalPropertyi("tu154ce/switchers/airbleed/psvp_left_on", 1)  -- PSVP left switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/psvp_right_on",1)  -- PSVP right switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/psvp_left_on_cap", 0)-- PSVP left cover installed  
createGlobalPropertyi("tu154ce/switchers/airbleed/psvp_right_on_cap", 0)-- PSVP right cover installed  
createGlobalPropertyi("tu154ce/switchers/airbleed/air_valve_left", 0)-- engine bleed air valve left: -1=close, 0=neutral,+1=open  
createGlobalPropertyi("tu154ce/switchers/airbleed/air_valve_right", 0)-- engine bleed air valve right  
createGlobalPropertyi("tu154ce/switchers/airbleed/air_valve_both", 0)-- both bleed valves: -1=close, 0=neutral,+1=open  
createGlobalPropertyi("tu154ce/switchers/airbleed/emerg_decompress", 0)-- emergency cabin decompression switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/emerg_decompress_cap", 0)-- decompression cover installed  
createGlobalPropertyi("tu154ce/switchers/airbleed/eng_valve_1", 1)  -- engine 1 bleed air selection switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/eng_valve_2", 1)  -- engine 2 bleed air selection switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/eng_valve_3", 1)  -- engine 3 bleed air selection switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/dubler_on", 0)  -- dubler (backup) switch  
createGlobalPropertyi("tu154ce/switchers/airbleed/dubler_on_cap", 0)  -- dubler cover installed  
createGlobalPropertyf("tu154ce/gauges/eng/starter_press", 0)  -- engine start system pressure gauge  
createGlobalPropertyi("tu154ce/switchers/eng/starter_cap", 0)  -- starter panel cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/starter_switch", 0)  -- starter master switch  
createGlobalPropertyi("tu154ce/switchers/eng/starter_eng_select", 0)  -- starter engine selector  
createGlobalPropertyi("tu154ce/switchers/eng/starter_mode", 0)  -- starter mode selector  
createGlobalPropertyi("tu154ce/buttons/eng/starter_start", 0)  -- starter start button  
createGlobalPropertyi("tu154ce/buttons/eng/starter_stop",       0)  -- starter stop button  
createGlobalPropertyi("tu154ce/buttons/eng/flight_start_1", 0)  -- in-flight start engine 1 button  
createGlobalPropertyi("tu154ce/buttons/eng/flight_start_2", 0)  -- in-flight start engine 2 button  
createGlobalPropertyi("tu154ce/buttons/eng/flight_start_3", 0)  -- in-flight start engine 3 button  
createGlobalPropertyi("tu154ce/switchers/eng/gauges_on_1",      1)  -- engine 1 instrument power switch  
createGlobalPropertyi("tu154ce/switchers/eng/gauges_on_2",      1)  -- engine 2 instrument power switch  
createGlobalPropertyi("tu154ce/switchers/eng/gauges_on_3",      1)  -- engine 3 instrument power switch  
createGlobalPropertyi("tu154ce/switchers/eng/gauges_on_1_cap",  0)  -- engine 1 instruments cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/gauges_on_2_cap",  0)  -- engine 2 instruments cover installed  
createGlobalPropertyi("tu154ce/switchers/eng/gauges_on_3_cap",  0)  -- engine 3 instruments cover installed  
createGlobalPropertyi("tu154ce/buttons/eng/reserv_pump_test", 0)  -- reserve pump test button  
createGlobalPropertyi("tu154ce/buttons/console/absu_zk", 0)  -- ABSU ZK button  
createGlobalPropertyi("tu154ce/buttons/console/absu_reset", 0)  -- ABSU program reset button  
createGlobalPropertyi("tu154ce/buttons/console/absu_nvu",       0)  -- ABSU NVU mode button  
createGlobalPropertyi("tu154ce/buttons/console/absu_az1",       0)  -- ABSU AZ1 button  
createGlobalPropertyi("tu154ce/buttons/console/absu_az2",       0)  -- ABSU AZ2 button  
createGlobalPropertyi("tu154ce/buttons/console/absu_app",       0)  -- ABSU approach mode button  
createGlobalPropertyi("tu154ce/buttons/console/absu_gs", 0)  -- ABSU glideslope button  
createGlobalPropertyi("tu154ce/buttons/console/absu_stab_m", 0)  -- ABSU “M” button  
createGlobalPropertyi("tu154ce/buttons/console/absu_stab_v", 0)  -- ABSU “V” button  
createGlobalPropertyi("tu154ce/buttons/console/absu_stab_h", 0)  -- ABSU “H” button  
createGlobalPropertyi("tu154ce/buttons/console/absu_stab", 0)  -- ABSU STAB button  
createGlobalPropertyi("tu154ce/buttons/console/absu_stab_speed", 0)  -- ABSU C (speed) button  
createGlobalPropertyi("tu154ce/buttons/console/absu_throt_off_1", 0)  -- ABSU throttle cutoff 1 button  
createGlobalPropertyi("tu154ce/buttons/console/absu_throt_off_2", 0)  -- ABSU throttle cutoff 2 button  
createGlobalPropertyi("tu154ce/buttons/console/absu_throt_off_3", 0)  -- ABSU throttle cutoff 3 button  
createGlobalPropertyi("tu154ce/gauges/console/absu_roll_mode",  0)  -- ABSU roll mode: 0=off,1=stick,2=stabilizer  
createGlobalPropertyi("tu154ce/gauges/console/absu_pitch_mode", 0)  -- ABSU pitch mode: 0=off,1=stick,2=stabilizer  
createGlobalPropertyf("tu154ce/gauges/console/gear_brake_press_L", 0)-- left gear brake pressure gauge  
createGlobalPropertyf("tu154ce/gauges/console/gear_brake_press_R", 0)-- right gear brake pressure gauge  
createGlobalPropertyf("tu154ce/gauges/console/map_angle",       0)  -- map display rotation angle  
createGlobalPropertyi("tu154ce/switchers/console/buster_on_1",   1)  -- booster pump 1 switch  
createGlobalPropertyi("tu154ce/switchers/console/buster_on_2",   1)  -- booster pump 2 switch  
createGlobalPropertyi("tu154ce/switchers/console/buster_on_3",   1)  -- booster pump 3 switch  
createGlobalPropertyi("tu154ce/switchers/console/busters_cap", 0)  -- booster switches cover installed  
createGlobalPropertyi("tu154ce/switchers/console/rls_on",        1)  -- radar (RLS) power switch  
createGlobalPropertyi("tu154ce/switchers/console/rls_mode", 0)  -- RLS mode: 0=ready,1=weather  
createGlobalPropertyi("tu154ce/switchers/console/rls_distance",  4)  -- RLS range selector  
createGlobalPropertyf("tu154ce/switchers/console/rls_brt",       1)  -- RLS brightness control  
createGlobalPropertyf("tu154ce/switchers/console/rls_contr",     1)  -- RLS contrast control  
createGlobalPropertyf("tu154ce/switchers/console/rls_signs",     1)  -- RLS target markers brightness  
createGlobalPropertyi("tu154ce/switchers/console/absu_zpu_sel",  0)  -- ZPU selector: left/right  
createGlobalPropertyi("tu154ce/switchers/console/absu_nav_on",   1)  -- ABSU NAV needles power switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_landing_on", 0)-- ABSU landing needles power switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_needles_on",1)-- ABSU needles power switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_mode", 0)-- ABSU speed mode: 0=off,1=NVU,2=AZ1,3=AZ2,4=approach  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_change", 0)-- ABSU speed change knob active  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_off", 0)-- ABSU speed channels cutoff switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_prepare",1)-- ABSU speed prepare switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_off_cap", 0)-- ABSU speed off cover installed  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_prepare_cap", 0)-- ABSU speed prepare cover installed  
createGlobalPropertyi("tu154ce/switchers/console/absu_speed_us_right_left",1)-- ABSU speed US right/left selector  
createGlobalPropertyi("tu154ce/buttons/console/absu_speed_test_1", 0)-- ABSU lower speed test button  
createGlobalPropertyi("tu154ce/buttons/console/absu_speed_test_2", 0)-- ABSU upper speed test button  
createGlobalPropertyi("tu154ce/switchers/console/absu_turn_handle", 0)-- ABSU turn handle switch  
createGlobalPropertyf("tu154ce/switchers/console/absu_pitch_wheel", 0)-- ABSU pitch trim wheel  
createGlobalPropertyi("tu154ce/switchers/console/absu_roll_ch_on",1)-- ABSU roll channel power switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_pitch_ch_on",1)-- ABSU pitch channel power switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_smooth_on", 0)-- ABSU turbulence mode switch  
createGlobalPropertyi("tu154ce/switchers/console/absu_smooth_on_cap", 0)-- turbulence mode cover installed  
createGlobalPropertyi("tu154ce/switchers/console/absu_pitch_wheel_dir", 0)-- pitch wheel direction selector  
createGlobalPropertyi("tu154ce/buttons/console/absu_arrest", 0)-- ABSU arrest button  
createGlobalPropertyi("tu154ce/buttons/console/absu_arrest_cap", 0)-- arrest button cover installed  
createGlobalPropertyi("tu154ce/switchers/console/nvu_param_sel", 0)-- NVU parameter selector knob  
createGlobalPropertyi("tu154ce/switchers/console/nvu_turn_sel", 0)-- NVU turn radius selector: -1=manual, 0=off,1=5,2=10,3=15,4=20,5=25  
createGlobalPropertyi("tu154ce/switchers/console/nvu_power_on", 1)-- NVU power switch  
createGlobalPropertyi("tu154ce/switchers/console/nvu_calc_on",  0)-- NVU compute switch  
createGlobalPropertyi("tu154ce/switchers/console/nvu_corr_on",  0)-- NVU correction switch
createGlobalPropertyf("tu154ce/nvu/current_Z1_1", 4) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_10", 3) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_100", 2) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_1000", 1) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_min_1", 4) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_min_10", 3) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_min_100", 2) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_Z1_min_1000", 1) -- Z1
createGlobalPropertyf("tu154ce/nvu/current_S1_1", 4) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_10", 3) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_100", 2) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_1000", 1) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_min_1", 4) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_min_10", 3) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_min_100", 2) -- S1
createGlobalPropertyf("tu154ce/nvu/current_S1_min_1000", 1) -- S1
createGlobalPropertyf("tu154ce/nvu/next_Z1_1", 4) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_10", 3) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_100", 2) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_1000", 1) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_min_1", 4) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_min_10", 3) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_min_100", 2) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_Z1_min_1000", 1) -- Z1
createGlobalPropertyf("tu154ce/nvu/next_S1_1", 4) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_10", 3) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_100", 2) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_1000", 1) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_min_1", 4) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_min_10", 3) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_min_100", 2) -- S1
createGlobalPropertyf("tu154ce/nvu/next_S1_min_1000", 1) -- S1
createGlobalPropertyf("tu154ce/nvu/current_Z2_1", 4) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_Z2_10", 3) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_Z2_100", 2) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_Z2_1000", 1) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_S2_1", 4) -- S2
createGlobalPropertyf("tu154ce/nvu/current_S2_10", 3) -- S2
createGlobalPropertyf("tu154ce/nvu/current_S2_100", 2) -- S2
createGlobalPropertyf("tu154ce/nvu/current_S2_1000", 1) -- S2
createGlobalPropertyf("tu154ce/nvu/next_Z2_1", 4) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_Z2_10", 3) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_Z2_100", 2) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_Z2_1000", 1) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_S2_1", 4) -- S2
createGlobalPropertyf("tu154ce/nvu/next_S2_10", 3) -- S2
createGlobalPropertyf("tu154ce/nvu/next_S2_100", 2) -- S2
createGlobalPropertyf("tu154ce/nvu/next_S2_1000", 1) -- S2
createGlobalPropertyf("tu154ce/nvu/current_Z2_min_1", 4) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_Z2_min_10", 3) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_Z2_min_100", 2) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_Z2_min_1000", 1) -- Z2
createGlobalPropertyf("tu154ce/nvu/current_S2_min_1", 4) -- S2
createGlobalPropertyf("tu154ce/nvu/current_S2_min_10", 3) -- S2
createGlobalPropertyf("tu154ce/nvu/current_S2_min_100", 2) -- S2
createGlobalPropertyf("tu154ce/nvu/current_S2_min_1000", 1) -- S2
createGlobalPropertyf("tu154ce/nvu/next_Z2_min_1", 4) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_Z2_min_10", 3) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_Z2_min_100", 2) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_Z2_min_1000", 1) -- Z2
createGlobalPropertyf("tu154ce/nvu/next_S2_min_1", 4) -- S2
createGlobalPropertyf("tu154ce/nvu/next_S2_min_10", 3) -- S2
createGlobalPropertyf("tu154ce/nvu/next_S2_min_100", 2) -- S2
createGlobalPropertyf("tu154ce/nvu/next_S2_min_1000", 1) -- S2
createGlobalPropertyf("tu154ce/nvu/zpu1_01", 5) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu1_1", 3) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu1_10", 2) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu1_100", 1) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu2_01", 5) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu2_1", 3) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu2_10", 2) -- ZPU
createGlobalPropertyf("tu154ce/nvu/zpu2_100", 1) -- ZPU
createGlobalPropertyf("tu154ce/nvu/z1_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z1_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s1_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s1_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z2_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z2_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s2_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s2_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z1_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z1_next_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s1_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s1_next_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z2_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/z2_next_plus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s2_next_minus_cap", 1) -- digits cap
createGlobalPropertyf("tu154ce/nvu/s2_next_plus_cap", 1) -- digits cap
createGlobalPropertyi("tu154ce/buttons/nvu/nvu_left_btn", 0)  -- NVU left button  
createGlobalPropertyi("tu154ce/buttons/nvu/nvu_ctr_btn", 0)  -- NVU center button  
createGlobalPropertyi("tu154ce/buttons/nvu/nvu_right_btn", 0)  -- NVU right button  
createGlobalPropertyi("tu154ce/buttons/nvu/zpu_1_left_btn", 0)  -- ZPU1 left button  
createGlobalPropertyi("tu154ce/buttons/nvu/zpu_1_ctr_btn", 0)  -- ZPU1 center button  
createGlobalPropertyi("tu154ce/buttons/nvu/zpu_1_right_btn",  0)  -- ZPU1 right button  
createGlobalPropertyi("tu154ce/buttons/nvu/zpu_2_left_btn", 0)  -- ZPU2 left button  
createGlobalPropertyi("tu154ce/buttons/nvu/zpu_2_ctr_btn", 0)  -- ZPU2 center button  
createGlobalPropertyi("tu154ce/buttons/nvu/zpu_2_right_btn",  0)  -- ZPU2 right button  
createGlobalPropertyi("tu154ce/rotary/console/nav_1_course",  0)  -- NAV1 course selector  
createGlobalPropertyf("tu154ce/rotary/console/nav_1_course_1", 0)  -- NAV1 course digit 1  
createGlobalPropertyf("tu154ce/rotary/console/nav_1_course_10", 0)  -- NAV1 course digit 10  
createGlobalPropertyf("tu154ce/rotary/console/nav_1_course_100", 0)  -- NAV1 course digit 100  
createGlobalPropertyi("tu154ce/rotary/console/nav_2_course",  0)  -- NAV2 course selector  
createGlobalPropertyf("tu154ce/rotary/console/nav_2_course_1", 0)  -- NAV2 course digit 1  
createGlobalPropertyf("tu154ce/rotary/console/nav_2_course_10", 0)  -- NAV2 course digit 10  
createGlobalPropertyf("tu154ce/rotary/console/nav_2_course_100", 0)  -- NAV2 course digit 100  
createGlobalPropertyf("tu154ce/rotary/console/wind_set", 0)  -- wind setting knob  
createGlobalPropertyi("tu154ce/button/console/wind_course_left",  0)  -- wind course left button  
createGlobalPropertyi("tu154ce/button/console/wind_course_ctr", 0)  -- wind course center button  
createGlobalPropertyi("tu154ce/button/console/wind_course_right", 0)  -- wind course right button  
createGlobalPropertyi("tu154ce/button/console/wind_spd_left", 0)  -- wind speed left button  
createGlobalPropertyi("tu154ce/button/console/wind_spd_ctr", 0)  -- wind speed center button  
createGlobalPropertyi("tu154ce/button/console/wind_spd_right", 0)  -- wind speed right button  
createGlobalPropertyi("tu154ce/switchers/console/emerg_elev_trimm", 0)  -- emergency elevator trim  
createGlobalPropertyi("tu154ce/switchers/console/emerg_elev_trimm_cap", 0)  -- emergency trim guard  
createGlobalPropertyi("tu154ce/buttons/console/radio",            0)  -- radio pedestal button  
createGlobalPropertyi("tu154ce/buttons/console/pdu406_control", 0)  -- PDU 406 control button  
createGlobalPropertyi("tu154ce/buttons/console/pdu406_sound_off",  0)  -- PDU 406 mute button  
createGlobalPropertyf("tu154ce/switchers/sard/sard_cabin_press_set",650) -- SARD cabin pressure set  
createGlobalPropertyf("tu154ce/switchers/sard/sard_abs_press_set",  1013) -- SARD absolute pressure set  
createGlobalPropertyf("tu154ce/switchers/sard/sard_diff_set",       0.6) -- SARD differential pressure set  
createGlobalPropertyf("tu154ce/switchers/sard/sard_spd_set", 0.5) -- SARD blower speed set  
createGlobalPropertyi("tu154ce/switchers/tcas/tcas_mode",           4)  -- TCAS mode (4=TARA)  
createGlobalPropertyi("tu154ce/switchers/tcas/tcas_rot_big", 0)  -- TCAS large knob  
createGlobalPropertyi("tu154ce/switchers/tcas/tcas_rot_small", 0)  -- TCAS small knob  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_ident_btn", 0)  -- TCAS IDENT button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_fcn_btn", 0)  -- TCAS FCN button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_left_btn", 0)  -- TCAS < button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_right_btn", 0)  -- TCAS > button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_ent_btn", 0)  -- TCAS ENT button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_atc_btn", 0)  -- TCAS ATC button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_alt_btn", 0)  -- TCAS ALT button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_rng_dn_btn",       0)  -- TCAS RNG DN button  
createGlobalPropertyi("tu154ce/buttons/tcas/tcas_rng_up_btn",       0)  -- TCAS RNG UP button  
createGlobalPropertyi("tu154ce/buttons/srpbz/but_view", 0)  -- EGPWS VIEW button  
createGlobalPropertyi("tu154ce/buttons/srpbz/but_empty",            0)  -- EGPWS empty button  
createGlobalPropertyi("tu154ce/buttons/srpbz/but_down", 0)  -- EGPWS zoom down button  
createGlobalPropertyi("tu154ce/buttons/srpbz/but_up", 0)  -- EGPWS zoom up button  
createGlobalPropertyf("tu154ce/rotary/srpbz/brightness", 0.7) -- EGPWS brightness knob  
createGlobalPropertyf("tu154ce/light/no_LIT",                       0)  -- disable LIT texture illumination  
createGlobalPropertyf("tu154ce/lights/exit_lamp", 0)  -- EXIT light  
createGlobalPropertyf("tu154ce/lights/fasten_seatbelts_lamp",       0)  -- FASTEN SEATBELTS light  
createGlobalPropertyf("tu154ce/lights/nosmoking_lamp", 0)  -- NO SMOKING light  
createGlobalPropertyf("tu154ce/lights/toilet_busy_lamp",            0)  -- TOILET BUSY light  
createGlobalPropertyf("tu154ce/lights/seats_leters_lamp", 0)  -- seat letters lamps  
createGlobalPropertyf("tu154ce/lights/mid_left_panel_int", 0)  -- pedestal left internal lighting  
createGlobalPropertyf("tu154ce/lights/left_panel_int", 0)  -- captain’s panel internal lighting  
createGlobalPropertyf("tu154ce/lights/right_panel_int", 0)  -- first officer’s panel internal lighting  
createGlobalPropertyf("tu154ce/lights/mid_right_panel_int", 0)  -- center front panel internal lighting  
createGlobalPropertyf("tu154ce/lights/ovhd_panel_int", 0)  -- overhead panel internal lighting  
createGlobalPropertyf("tu154ce/lights/left_panel_flood",            0)  -- left panel floodlight  
createGlobalPropertyf("tu154ce/lights/right_panel_flood", 0)  -- right panel floodlight  
createGlobalPropertyf("tu154ce/lights/mid_panel_flood", 0)  -- center panel floodlight  
createGlobalPropertyf("tu154ce/lights/front_panel_flood", 0)  -- front panel floodlight  
createGlobalPropertyf("tu154ce/lights/ovhd_front_panel_flood", 0)  -- overhead front floodlight  
createGlobalPropertyf("tu154ce/lights/ovhd_back_panel_flood",       0)  -- overhead back floodlight
createGlobalPropertyf("tu154ce/lights/eng_panel_flood", 0)  -- BI panel floodlight brightness  
createGlobalPropertyf("tu154ce/lights/azs_panel_flood", 0)  -- AZS panel lighting  
createGlobalPropertyf("tu154ce/lights/cargo_light_1",       0)  -- Cargo bay 1 lighting  
createGlobalPropertyf("tu154ce/lights/cargo_light_2",       0)  -- Cargo bay 2 lighting  
createGlobalPropertyf("tu154ce/lights/tech_light", 0)  -- Technical bay lighting  
createGlobalPropertyf("tu154ce/lights/gear_nacelle_light",  0)  -- Landing gear nacelle lighting  
createGlobalPropertyf("tu154ce/lights/left_spotlight_flood", 0)  -- Left spotlight brightness  
createGlobalPropertyf("tu154ce/lights/ark1_left_lit",       0)  -- ARC1 left illumination  
createGlobalPropertyf("tu154ce/lights/ark1_right_lit", 0)  -- ARC1 right illumination  
createGlobalPropertyf("tu154ce/lights/ark1_all_lit", 0)  -- ARC1 full illumination  
createGlobalPropertyf("tu154ce/lights/ark2_left_lit",       0)  -- ARC2 left illumination  
createGlobalPropertyf("tu154ce/lights/ark2_right_lit", 0)  -- ARC2 right illumination  
createGlobalPropertyf("tu154ce/lights/ark2_all_lit", 0)  -- ARC2 full illumination  
createGlobalPropertyf("tu154ce/lights/tks_mode_lit_mk", 0)  -- TKS mode lamp MK  
createGlobalPropertyf("tu154ce/lights/tks_mode_lit_ak", 0)  -- TKS mode lamp AK  
createGlobalPropertyf("tu154ce/lights/tks_mode_lit_gpk", 0)  -- TKS mode lamp GPK  
createGlobalPropertyf("tu154ce/lights/to_not_ready", 0)  -- NOT READY for takeoff lamp  
createGlobalPropertyf("tu154ce/lights/wrong_trimm", 0)  -- Incorrect trim lamp  
createGlobalPropertyf("tu154ce/lights/controll_roll",       0)  -- “Control Roll” lamp  
createGlobalPropertyf("tu154ce/lights/controll_pitch", 0)  -- “Control Pitch” lamp  
createGlobalPropertyf("tu154ce/lights/yoke_sign", 0)  -- Go-around warning (yoke mode)  
createGlobalPropertyf("tu154ce/lights/triangle",            0)  -- Integral warning triangle  
createGlobalPropertyf("tu154ce/lights/controll_thrust", 0)  -- “Control Thrust” lamp  
createGlobalPropertyf("tu154ce/lights/course_lim", 0)  -- Course limits exceeded lamp  
createGlobalPropertyf("tu154ce/lights/gs_lim", 0)  -- Glideslope limits exceeded lamp  
createGlobalPropertyf("tu154ce/lights/fire", 0)  -- FIRE warning lamp  
createGlobalPropertyf("tu154ce/lights/no_ag_controll", 0)  -- No AGR control lamp  
createGlobalPropertyf("tu154ce/lights/fuel_less_2500", 0)  -- Fuel <2500 kg warning  
createGlobalPropertyf("tu154ce/lights/sso_danger", 0)  -- EGPWS “Terrain Danger”  
createGlobalPropertyf("tu154ce/lights/sso_connect", 0)  -- EGPWS “Terrain Advisory”  
createGlobalPropertyf("tu154ce/lights/speed_high", 0)  -- Overspeed warning  
createGlobalPropertyf("tu154ce/lights/roll_left_high", 0)  -- Excessive left bank  
createGlobalPropertyf("tu154ce/lights/roll_right_high", 0)  -- Excessive right bank  
createGlobalPropertyf("tu154ce/lights/alpha_high", 0)  -- Stall warning (high AOA)  
createGlobalPropertyf("tu154ce/lights/g_force_high", 0)  -- G-load limit exceeded  
createGlobalPropertyf("tu154ce/lights/auasp_lamp", 0)  -- AUASP mode lamp  
createGlobalPropertyf("tu154ce/lights/toga", 0)  -- TOGA mode lamp  
createGlobalPropertyf("tu154ce/lights/decision_height", 0)  -- EGPWS decision height lamp  
createGlobalPropertyf("tu154ce/lights/course", 0)  -- COURSE display lamp  
createGlobalPropertyf("tu154ce/lights/glideslope", 0)  -- GLIDESLOPE display lamp  
createGlobalPropertyf("tu154ce/lights/zk_lamp", 0)  -- ZK (gyro) lamp  
createGlobalPropertyf("tu154ce/lights/thrust_automat", 0)  -- Autothrust engaged lamp  
createGlobalPropertyf("tu154ce/lights/stab_roll", 0)  -- Roll stabilization lamp  
createGlobalPropertyf("tu154ce/lights/stab_pitch", 0)  -- Pitch stabilization lamp  
createGlobalPropertyf("tu154ce/lights/nvu_lamp",            0)  -- NVU engaged lamp  
createGlobalPropertyf("tu154ce/lights/vor_lamp",            0)  -- VOR lamp  
createGlobalPropertyf("tu154ce/lights/stab_h", 0)  -- Stabilizer H lamp  
createGlobalPropertyf("tu154ce/lights/stab_v", 0)  -- Stabilizer V lamp  
createGlobalPropertyf("tu154ce/lights/stab_m", 0)  -- Stabilizer M lamp  
createGlobalPropertyf("tu154ce/lights/marker_1",            0)  -- Marker beacon 1 lamp  
createGlobalPropertyf("tu154ce/lights/marker_2",            0)  -- Marker beacon 2 lamp
createGlobalPropertyf("tu154ce/lights/marker_3", 0)  -- Marker beacon 3 lamp  
createGlobalPropertyf("tu154ce/lights/pull_up", 0)  -- “PULL UP” warning lamp  
createGlobalPropertyf("tu154ce/lights/check_alt_left",       0)  -- “CHECK ALT” left lamp  
createGlobalPropertyf("tu154ce/lights/check_alt_right", 0)  -- “CHECK ALT” right lamp  
createGlobalPropertyf("tu154ce/lights/sns_lamp", 0)  -- SNS (Sat-Nav) lamp  
createGlobalPropertyf("tu154ce/lights/fp_eng_fail_1", 0)  -- Engine 1 fault (front panel)  
createGlobalPropertyf("tu154ce/lights/fp_eng_fail_2", 0)  -- Engine 2 fault (front panel)  
createGlobalPropertyf("tu154ce/lights/fp_eng_fail_3", 0)  -- Engine 3 fault (front panel)  
createGlobalPropertyf("tu154ce/lights/fp_reverse_1", 0)  -- Thrust-reverser doors 1 (front panel)  
createGlobalPropertyf("tu154ce/lights/fp_reverse_3", 0)  -- Thrust-reverser doors 3 (front panel)  
createGlobalPropertyf("tu154ce/lights/stab_work",            0)  -- Stabilizer engaged lamp  
createGlobalPropertyf("tu154ce/lights/flaps_1_valve", 0)  -- Flaps channel 1 valve lamp  
createGlobalPropertyf("tu154ce/lights/flaps_2_valve", 0)  -- Flaps channel 2 valve lamp  
createGlobalPropertyf("tu154ce/lights/spoilers_mid_left", 0)  -- Mid spoilers L lamp  
createGlobalPropertyf("tu154ce/lights/spoilers_mid_right", 0)  -- Mid spoilers R lamp  
createGlobalPropertyf("tu154ce/lights/spoilers_inn_left", 0)  -- Inner spoilers L lamp  
createGlobalPropertyf("tu154ce/lights/spoilers_inn_right", 0)  -- Inner spoilers R lamp  
createGlobalPropertyf("tu154ce/lights/gears_not_ext", 0)  -- Landing gear NOT DOWN lamp  
createGlobalPropertyf("tu154ce/lights/gears_red_left",       0)  -- Gear red light L  
createGlobalPropertyf("tu154ce/lights/gears_red_front", 0)  -- Gear red light N  
createGlobalPropertyf("tu154ce/lights/gears_red_right", 0)  -- Gear red light R  
createGlobalPropertyf("tu154ce/lights/gears_green_left", 0)  -- Gear green light L  
createGlobalPropertyf("tu154ce/lights/gears_green_front", 0)  -- Gear green light N  
createGlobalPropertyf("tu154ce/lights/gears_green_right", 0)  -- Gear green light R  
createGlobalPropertyf("tu154ce/lights/gears_red_left_eng", 0)  -- Gear red light L (engine panel)  
createGlobalPropertyf("tu154ce/lights/gears_red_front_eng",  0)  -- Gear red light N (engine panel)  
createGlobalPropertyf("tu154ce/lights/gears_red_right_eng",  0)  -- Gear red light R (engine panel)  
createGlobalPropertyf("tu154ce/lights/gears_green_left_eng", 0)  -- Gear green light L (engine panel)  
createGlobalPropertyf("tu154ce/lights/gears_green_front_eng", 0)  -- Gear green light N (engine panel)  
createGlobalPropertyf("tu154ce/lights/gears_green_right_eng", 0)  -- Gear green light R (engine panel)  
createGlobalPropertyf("tu154ce/lights/flaps_unsync", 0)  -- Flaps asymmetry lamp  
createGlobalPropertyf("tu154ce/lights/slats_unsync", 0)  -- Slats asymmetry lamp  
createGlobalPropertyf("tu154ce/lights/slats_extended",       0)  -- Slats extended lamp  
createGlobalPropertyf("tu154ce/lights/to_rudder",            0)  -- TO/LDG rudder trim lamp  
createGlobalPropertyf("tu154ce/lights/to_elevator", 0)  -- TO/LDG elevator trim lamp  
createGlobalPropertyf("tu154ce/lights/trimm_zero_course", 0)  -- Trim neutral - yaw  
createGlobalPropertyf("tu154ce/lights/trimm_zero_roll", 0)  -- Trim neutral - roll  
createGlobalPropertyf("tu154ce/lights/trimm_zero_pitch", 0)  -- Trim neutral - pitch  
createGlobalPropertyf("tu154ce/lights/damper_course", 0)  -- Yaw damper lamp  
createGlobalPropertyf("tu154ce/lights/damper_roll", 0)  -- Roll damper lamp  
createGlobalPropertyf("tu154ce/lights/damper_pitch", 0)  -- Pitch damper lamp  
createGlobalPropertyf("tu154ce/lights/no_reserve_c", 0)  -- No reserve - C channel  
createGlobalPropertyf("tu154ce/lights/no_reserve_g", 0)  -- No reserve - G channel  
createGlobalPropertyf("tu154ce/lights/pitch_control_fail", 0)  -- Pitch control failure  
createGlobalPropertyf("tu154ce/lights/roll_control_fail", 0)  -- Roll control failure  
createGlobalPropertyf("tu154ce/lights/ga_main_fail", 0)  -- Main GA failure  
createGlobalPropertyf("tu154ce/lights/ga_reserve_fail", 0)  -- Stand-by GA failure  
createGlobalPropertyf("tu154ce/lights/msg_lamp", 0)  -- MSG annunciator  
createGlobalPropertyf("tu154ce/lights/wpt_lamp", 0)  -- WPT annunciator  
createGlobalPropertyf("tu154ce/lights/stuard_call", 0)  -- Cabin-crew call lamp  
createGlobalPropertyf("tu154ce/lights/mgv_control_fail", 0)  -- MGV control failure lamp
-- createGlobalPropertyf("tu154ce/lights/sns_lamp", 0)             -- GNSS annunciator
createGlobalPropertyf("tu154ce/lights/correct_on", 0)  -- NVU CORR engaged
createGlobalPropertyf("tu154ce/lights/change_ch_o", 0)  -- ORT-channel change
createGlobalPropertyf("tu154ce/lights/warning_terrain", 0)  -- TERRAIN AHEAD
createGlobalPropertyf("tu154ce/lights/gs_low", 0)  -- G/S BELOW
createGlobalPropertyf("tu154ce/lights/cockpit_p_low", 0)  -- CABIN ΔP LOW
createGlobalPropertyf("tu154ce/lights/nvu_fail", 0)  -- INS (NVU) FAIL
createGlobalPropertyf("tu154ce/lights/nvu_vor_automat", 0)  -- INS-VOR AUTO
createGlobalPropertyf("tu154ce/lights/dist_autonom",       0)  -- DIST AUTONOMOUS
createGlobalPropertyf("tu154ce/lights/diss_memory", 0)  -- DOPPLER MEM
createGlobalPropertyf("tu154ce/lights/azimuth_autonom", 0)  -- AZIMUTH AUTONOMOUS
createGlobalPropertyf("tu154ce/lights/srpbz_fail", 0)  -- EGPWS FAIL
createGlobalPropertyf("tu154ce/lights/tcas_ident", 0)  -- TCAS IDENT
createGlobalPropertyf("tu154ce/lights/other_hatches", 0)  -- MISC DOORS OPEN
createGlobalPropertyf("tu154ce/lights/left_front_pax_door", 0)  -- L FWD PAX DOOR OPEN
createGlobalPropertyf("tu154ce/lights/left_mid_pax_door",  0)  -- L MID PAX DOOR OPEN
createGlobalPropertyf("tu154ce/lights/right_mid_pax_door", 0)  -- R MID PAX DOOR OPEN
createGlobalPropertyf("tu154ce/lights/cargo_front_door", 0)  -- FWD CARGO DOOR OPEN
createGlobalPropertyf("tu154ce/lights/cargo_back_door", 0)  -- AFT CARGO DOOR OPEN
createGlobalPropertyf("tu154ce/lights/turn63_lamp", 0)  -- TURN 63°
createGlobalPropertyf("tu154ce/lights/nosewheel_turn_off", 0)  -- STEERING OFF
createGlobalPropertyf("tu154ce/lights/busters_off", 0)  -- BOOSTER OFF
createGlobalPropertyf("tu154ce/lights/water_level_1", 0)  -- POTABLE H₂O  1 full
createGlobalPropertyf("tu154ce/lights/water_level_12", 0)  -- POTABLE H₂O  ½
createGlobalPropertyf("tu154ce/lights/water_level_14", 0)  -- POTABLE H₂O  ¼
createGlobalPropertyf("tu154ce/lights/water_level_0", 0)  -- POTABLE H₂O EMPTY
createGlobalPropertyf("tu154ce/lights/ra56_roll_fail_1", 0)  -- RA-56 ROLL FAIL Chan 1
createGlobalPropertyf("tu154ce/lights/ra56_roll_fail_2", 0)  -- RA-56 ROLL FAIL Chan 2
createGlobalPropertyf("tu154ce/lights/ra56_roll_fail_3", 0)  -- RA-56 ROLL FAIL Chan 3
createGlobalPropertyf("tu154ce/lights/ra56_pitch_fail_1",  0)  -- RA-56 PITCH FAIL Chan 1
createGlobalPropertyf("tu154ce/lights/ra56_pitch_fail_2",  0)  -- RA-56 PITCH FAIL Chan 2
createGlobalPropertyf("tu154ce/lights/ra56_pitch_fail_3",  0)  -- RA-56 PITCH FAIL Chan 3
createGlobalPropertyf("tu154ce/lights/ra56_course_fail_1", 0)  -- RA-56 YAW FAIL Chan 1
createGlobalPropertyf("tu154ce/lights/ra56_course_fail_2", 0)  -- RA-56 YAW FAIL Chan 2
createGlobalPropertyf("tu154ce/lights/ra56_course_fail_3", 0)  -- RA-56 YAW FAIL Chan 3
createGlobalPropertyf("tu154ce/lights/nvu_no_reserve", 0)  -- NO INS RESERVE
createGlobalPropertyf("tu154ce/lights/absu_work", 0)  -- AUTOFLIGHT OK
createGlobalPropertyf("tu154ce/lights/fire/smoke_1", 0)  -- SMOKE ZONE 1
createGlobalPropertyf("tu154ce/lights/fire/smoke_2", 0)  -- SMOKE ZONE 2
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone2_left",  0)  -- SMOKE Zone 2 L
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone2_right", 0)  -- SMOKE Zone 2 R
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone3",       0)  -- SMOKE Zone 3
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone4",       0)  -- SMOKE Zone 4
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone5_left",  0)  -- SMOKE Zone 5 L
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone5_right", 0)  -- SMOKE Zone 5 R
createGlobalPropertyf("tu154ce/lights/fire/smoke_zone6",       0)  -- SMOKE Zone 6
createGlobalPropertyf("tu154ce/lights/fire/fire_eng_1", 0)  -- ENG 1 FIRE
createGlobalPropertyf("tu154ce/lights/fire/fire_eng_2", 0)  -- ENG 2 FIRE
createGlobalPropertyf("tu154ce/lights/fire/fire_eng_3", 0)  -- ENG 3 FIRE
createGlobalPropertyf("tu154ce/lights/fire/overheat_eng_1", 0)  -- ENG 1 OVHT
createGlobalPropertyf("tu154ce/lights/fire/overheat_eng_2", 0)  -- ENG 2 OVHT
createGlobalPropertyf("tu154ce/lights/fire/overheat_eng_3", 0)  -- ENG 3 OVHT
createGlobalPropertyf("tu154ce/lights/fire/fuel_off_eng_1", 0)  -- ENG 1 FUEL OFF
createGlobalPropertyf("tu154ce/lights/fire/fuel_off_eng_2", 0)  -- ENG 2 FUEL OFF
createGlobalPropertyf("tu154ce/lights/fire/fuel_off_eng_3", 0)  -- ENG 3 FUEL OFF
createGlobalPropertyf("tu154ce/lights/fire/check_overheat", 0)  -- CHECK OVHT/SMOKE
createGlobalPropertyf("tu154ce/lights/fire/fire_apu", 0)  -- APU FIRE
createGlobalPropertyf("tu154ce/lights/fire/turn_on_spz",       0)  -- ACTIVATE FES
createGlobalPropertyf("tu154ce/lights/apu/low_oil",            0)  -- APU OIL LOW QTY
createGlobalPropertyf("tu154ce/lights/apu/low_oil_press", 0)  -- APU OIL LOW P
createGlobalPropertyf("tu154ce/lights/apu/high_temp", 0)  -- APU HIGH TEMP
createGlobalPropertyf("tu154ce/lights/apu/high_rpm", 0)  -- APU OVERSPEED
createGlobalPropertyf("tu154ce/lights/apu/pta6_fail", 0)  -- PTA-6A FAIL
createGlobalPropertyf("tu154ce/lights/apu/doors_open", 0)  -- APU DOORS OPEN
createGlobalPropertyf("tu154ce/lights/apu/fuel_press", 0)  -- APU FUEL PRESS
createGlobalPropertyf("tu154ce/lights/apu/start_ready", 0)  -- APU READY
createGlobalPropertyf("tu154ce/lights/apu/work_mode", 0)  -- APU ON SPEED
createGlobalPropertyf("tu154ce/lights/apu/start_apu", 0)  -- START APU
createGlobalPropertyf("tu154ce/lights/engines/eng1_dangerous_vibro", 0) -- ENG 1 DANG VIB
createGlobalPropertyf("tu154ce/lights/engines/eng1_oil_level",       0) -- ENG 1 OIL QTY
createGlobalPropertyf("tu154ce/lights/engines/eng1_oil_p", 0) -- ENG 1 OIL PRESS
createGlobalPropertyf("tu154ce/lights/engines/eng1_bypass_valve", 0) -- ENG 1 BYPASS VLV
createGlobalPropertyf("tu154ce/lights/engines/eng1_vna33", 0) -- ENG 1 IGV 33°
createGlobalPropertyf("tu154ce/lights/engines/eng1_reverse_lock", 0) -- ENG 1 REV LOCK
createGlobalPropertyf("tu154ce/lights/engines/eng1_high_vibro", 0) -- ENG 1 HIGH VIB
createGlobalPropertyf("tu154ce/lights/engines/eng1_chips", 0) -- ENG 1 CHIP DET
createGlobalPropertyf("tu154ce/lights/engines/eng1_fuel_p", 0) -- ENG 1 FUEL PRESS
createGlobalPropertyf("tu154ce/lights/engines/eng1_filter_fail", 0) -- ENG 1 FLT CLOG
createGlobalPropertyf("tu154ce/lights/engines/eng1_vna0",            0) -- ENG 1 IGV 0°
createGlobalPropertyf("tu154ce/lights/engines/eng1_reverse_doors", 0) -- ENG 1 REV DOORS
createGlobalPropertyf("tu154ce/lights/engines/eng2_dangerous_vibro", 0) -- ENG 2 DANG VIB
createGlobalPropertyf("tu154ce/lights/engines/eng2_oil_level",       0) -- ENG 2 OIL QTY
createGlobalPropertyf("tu154ce/lights/engines/eng2_oil_p", 0) -- ENG 2 OIL PRESS
createGlobalPropertyf("tu154ce/lights/engines/eng2_bypass_valve", 0) -- ENG 2 BYPASS VLV
createGlobalPropertyf("tu154ce/lights/engines/eng2_vna33", 0) -- ENG 2 IGV 33°
createGlobalPropertyf("tu154ce/lights/engines/eng_at_on",            0) -- A/T ENGAGED
createGlobalPropertyf("tu154ce/lights/engines/eng2_high_vibro", 0) -- ENG 2 HIGH VIB
createGlobalPropertyf("tu154ce/lights/engines/eng2_chips", 0) -- ENG 2 CHIP DET
createGlobalPropertyf("tu154ce/lights/engines/eng2_fuel_p", 0) -- ENG 2 FUEL PRESS
createGlobalPropertyf("tu154ce/lights/engines/eng2_filter_fail", 0) -- ENG 2 FLT CLOG
createGlobalPropertyf("tu154ce/lights/engines/eng2_vna0",            0) -- ENG 2 IGV 0°
createGlobalPropertyf("tu154ce/lights/engines/eng_block",            0) -- THROTTLE BLOCKED
createGlobalPropertyf("tu154ce/lights/engines/eng3_dangerous_vibro", 0) -- ENG 3 DANG VIB
createGlobalPropertyf("tu154ce/lights/engines/eng3_oil_level",       0) -- ENG 3 OIL QTY
createGlobalPropertyf("tu154ce/lights/engines/eng3_oil_p", 0) -- ENG 3 OIL PRESS
createGlobalPropertyf("tu154ce/lights/engines/eng3_bypass_valve", 0) -- ENG 3 BYPASS VLV
createGlobalPropertyf("tu154ce/lights/engines/eng3_vna33", 0) -- ENG 3 IGV 33°
createGlobalPropertyf("tu154ce/lights/engines/eng3_reverse_lock", 0) -- ENG 3 REV LOCK
createGlobalPropertyf("tu154ce/lights/engines/eng3_high_vibro", 0) -- ENG 3 HIGH VIB
createGlobalPropertyf("tu154ce/lights/engines/eng3_chips", 0) -- ENG 3 CHIP DET
createGlobalPropertyf("tu154ce/lights/engines/eng3_fuel_p", 0) -- ENG 3 FUEL PRESS
createGlobalPropertyf("tu154ce/lights/engines/eng3_filter_fail", 0) -- ENG 3 FLT CLOG
createGlobalPropertyf("tu154ce/lights/engines/eng3_vna0",            0) -- ENG 3 IGV 0°
createGlobalPropertyf("tu154ce/lights/engines/eng3_reverse_doors", 0) -- ENG 3 REV DOORS
createGlobalPropertyf("tu154ce/lights/small/transponder1_fail", 0) -- XPDR 1 FAIL
createGlobalPropertyf("tu154ce/lights/small/transponder1_kd", 0) -- XPDR 1 KD
createGlobalPropertyf("tu154ce/lights/small/transponder1_kp", 0) -- XPDR 1 KP
createGlobalPropertyf("tu154ce/lights/small/leftside_yellow", 0) -- LEFT YELLOW ANN
createGlobalPropertyf("tu154ce/lights/small/turn_on_aux",            0) -- USE STANDBY
createGlobalPropertyf("tu154ce/lights/small/front_hydr_fail_1", 0) -- HYD 1 LOW P (FP)
createGlobalPropertyf("tu154ce/lights/small/front_hydr_fail_2", 0) -- HYD 2 LOW P (FP)
createGlobalPropertyf("tu154ce/lights/small/front_hydr_fail_3", 0) -- HYD 3 LOW P (FP)
createGlobalPropertyf("tu154ce/lights/small/front_hydr_fail_4", 0) -- HYD EMERG LOW P
createGlobalPropertyf("tu154ce/lights/small/rv5_left_dh",            0) -- DH set (RV-5 L)
createGlobalPropertyf("tu154ce/lights/small/rv5_right_dh", 0) -- DH set (RV-5 R)
createGlobalPropertyf("tu154ce/lights/small/vd15_lamp", 0) -- VD-15 ANN
createGlobalPropertyf("tu154ce/lights/small/bkk_ok", 0) -- BKK OK
createGlobalPropertyf("tu154ce/lights/small/heat_ok_1", 0) -- WINDOW HEAT OK 1
createGlobalPropertyf("tu154ce/lights/small/heat_ok_2", 0) -- WINDOW HEAT OK 2
createGlobalPropertyf("tu154ce/lights/small/heat_ok_3", 0) -- WINDOW HEAT OK 3
createGlobalPropertyf("tu154ce/lights/small/sp50_c1", 0) -- SP-50 COURSE 1
createGlobalPropertyf("tu154ce/lights/small/sp50_g1", 0) -- SP-50 G/S 1
createGlobalPropertyf("tu154ce/lights/small/sp50_c2", 0) -- SP-50 COURSE 2
createGlobalPropertyf("tu154ce/lights/small/sp50_g2", 0) -- SP-50 G/S 2
createGlobalPropertyf("tu154ce/lights/small/transponder_red", 0) -- XPDR RED
createGlobalPropertyf("tu154ce/lights/small/transponder_green", 0) -- XPDR GREEN
createGlobalPropertyf("tu154ce/lights/small/tks_main_fail", 0) -- GPK MAIN FAIL
createGlobalPropertyf("tu154ce/lights/small/tks_contr_fail", 0) -- GPK CTRL FAIL
createGlobalPropertyf("tu154ce/lights/small/rls_ready", 0) -- WX RADAR READY
createGlobalPropertyf("tu154ce/lights/small/rls_weather", 0) -- WX RADAR (WEATHER)  
createGlobalPropertyf("tu154ce/lights/small/stu_roll",            0) -- STU ROLL  
createGlobalPropertyf("tu154ce/lights/small/stu_pitch", 0) -- STU PITCH  
createGlobalPropertyf("tu154ce/lights/small/stu_toga",            0) -- GO-AROUND (TOGA)  
createGlobalPropertyf("tu154ce/lights/small/at_2", 0) -- A/T 2  
createGlobalPropertyf("tu154ce/lights/small/at_1", 0) -- A/T 1  
createGlobalPropertyf("tu154ce/lights/small/nvu_on", 0) -- NVU OK  
createGlobalPropertyf("tu154ce/lights/small/nvu_corr",            0) -- NVU CORR  
createGlobalPropertyf("tu154ce/lights/small/nav_1_to",            0) -- NAV-1 TO  
createGlobalPropertyf("tu154ce/lights/small/nav_1_from", 0) -- NAV-1 FROM  
createGlobalPropertyf("tu154ce/lights/small/nav_2_to",            0) -- NAV-2 TO  
createGlobalPropertyf("tu154ce/lights/small/nav_2_from", 0) -- NAV-2 FROM  
createGlobalPropertyf("tu154ce/lights/small/apu_gen_on", 0) -- GPU CONNECTED  
createGlobalPropertyf("tu154ce/lights/small/bus_npk_1", 0) -- LEFT NPK BUS→3  
createGlobalPropertyf("tu154ce/lights/small/bus_npk_2", 0) -- RIGHT NPK BUS→1  
createGlobalPropertyf("tu154ce/lights/small/emerg_inv_115",       0) -- EMER 115 V INVERTER  
createGlobalPropertyf("tu154ce/lights/small/gen_fail_1", 0) -- GEN-1 FAIL  
createGlobalPropertyf("tu154ce/lights/small/gen_fail_2", 0) -- GEN-2 FAIL  
createGlobalPropertyf("tu154ce/lights/small/gen_fail_3", 0) -- GEN-3 FAIL  
createGlobalPropertyf("tu154ce/lights/small/bus_connected",       0) -- BUS TIE CONNECTED  
createGlobalPropertyf("tu154ce/lights/small/left_bus_use_bat", 0) -- LEFT BUS ON BAT  
createGlobalPropertyf("tu154ce/lights/small/right_bus_use_bat", 0) -- RIGHT BUS ON BAT  
createGlobalPropertyf("tu154ce/lights/small/turn_off_bat_1", 0) -- TURN OFF BAT-1  
createGlobalPropertyf("tu154ce/lights/small/turn_off_bat_3", 0) -- TURN OFF BAT-3  
createGlobalPropertyf("tu154ce/lights/small/turn_off_bat_2", 0) -- TURN OFF BAT-2  
createGlobalPropertyf("tu154ce/lights/small/turn_off_bat_4", 0) -- TURN OFF BAT-4  
createGlobalPropertyf("tu154ce/lights/small/vu_on_1", 0) -- VU-1 ON  
createGlobalPropertyf("tu154ce/lights/small/vu_on_2", 0) -- VU-2 ON  
createGlobalPropertyf("tu154ce/lights/small/left_bus_on_tr2", 0) -- LEFT BUS ON TR-2  
createGlobalPropertyf("tu154ce/lights/small/right_bus_on_tr1", 0) -- RIGHT BUS ON TR-1  
createGlobalPropertyf("tu154ce/lights/small/pts250_n1", 0) -- PTS-250 INOP  
createGlobalPropertyf("tu154ce/lights/small/pts250_n2", 0) -- PTS-250 ON-LINE  
createGlobalPropertyf("tu154ce/lights/small/throttle_1_fire", 0) -- THROTTLE-1 FIRE  
createGlobalPropertyf("tu154ce/lights/small/throttle_2_fire", 0) -- THROTTLE-2 FIRE  
createGlobalPropertyf("tu154ce/lights/small/throttle_3_fire", 0) -- THROTTLE-3 FIRE  
createGlobalPropertyf("tu154ce/lights/small/oil_meter_1", 0) -- OIL LEVEL 1 OK  
createGlobalPropertyf("tu154ce/lights/small/oil_meter_2", 0) -- OIL LEVEL 2 OK  
createGlobalPropertyf("tu154ce/lights/small/oil_meter_3", 0) -- OIL LEVEL 3 OK  
createGlobalPropertyf("tu154ce/lights/small/starter_high_rpm_1",  0) -- STARTER-1 OVERSPEED  
createGlobalPropertyf("tu154ce/lights/small/starter_high_rpm_2",  0) -- STARTER-2 OVERSPEED  
createGlobalPropertyf("tu154ce/lights/small/starter_high_rpm_3",  0) -- STARTER-3 OVERSPEED  
createGlobalPropertyf("tu154ce/lights/small/fuel_2500", 0) -- FUEL ≤ 2500 kg  
createGlobalPropertyf("tu154ce/lights/small/fuel_tank1_used", 0) -- TANK-1 FEED  
createGlobalPropertyf("tu154ce/lights/small/fuel_tank3_left_fail", 0) -- TANK-3 L LOW  
createGlobalPropertyf("tu154ce/lights/small/fuel_tank2_left_fail", 0) -- TANK-2 L LOW  
createGlobalPropertyf("tu154ce/lights/small/fuel_tank2_right_fail", 0) -- TANK-2 R LOW  
createGlobalPropertyf("tu154ce/lights/small/fuel_tank3_right_fail", 0) -- TANK-3 R LOW  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_left_5", 0) -- PUMP T5 L  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_left_6", 0) -- PUMP T6 L  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_left_7", 0) -- PUMP T7 L  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_left_8", 0) -- PUMP T8 L  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_left_9", 0) -- PUMP T9 L  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_right_5", 0) -- PUMP T5 R  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_right_6", 0) -- PUMP T6 R  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_right_7", 0) -- PUMP T7 R  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_right_8", 0) -- PUMP T8 R  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_right_9", 0) -- PUMP T9 R  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_10", 0) -- PUMP T10  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_11", 0) -- PUMP T11  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_1", 0) -- PUMP T1  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_2", 0) -- PUMP T2  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_3", 0) -- PUMP T3  
createGlobalPropertyf("tu154ce/lights/small/fuel_pump_4", 0) -- PUMP T4  
createGlobalPropertyf("tu154ce/lights/small/fuel_cut_off_1", 0) -- FUEL CUTOFF 1  
createGlobalPropertyf("tu154ce/lights/small/fuel_cut_off_2", 0) -- FUEL CUTOFF 2  
createGlobalPropertyf("tu154ce/lights/small/fuel_cut_off_3", 0) -- FUEL CUTOFF 3  
createGlobalPropertyf("tu154ce/lights/small/fuel_flow_from_2", 0) -- FLOW FROM T2  
createGlobalPropertyf("tu154ce/lights/small/fuel_flow_from_3", 0) -- FLOW FROM T3  
createGlobalPropertyf("tu154ce/lights/small/fuel_flow_from_4", 0) -- FLOW FROM T4  
createGlobalPropertyf("tu154ce/lights/small/fuel_flow_auto_fail", 0) -- AUTO FLOW FAIL  
createGlobalPropertyf("tu154ce/lights/small/fuel_reserv_trans_left",  0) -- RES XFER L→T1  
createGlobalPropertyf("tu154ce/lights/small/fuel_reserv_trans_right", 0) -- RES XFER R→T1  
createGlobalPropertyf("tu154ce/lights/small/fuel_porc_reserv", 0) -- MAN PORC RES  
createGlobalPropertyf("tu154ce/lights/small/fuel_level_automat",  0) -- FUEL BAL AUTO  
createGlobalPropertyf("tu154ce/lights/small/skv_overheat", 0) -- PACK OVERHEAT  
createGlobalPropertyf("tu154ce/lights/small/skv_overpress_left",  0) -- PACK L OVERP  
createGlobalPropertyf("tu154ce/lights/small/skv_overpress_right", 0) -- PACK R OVERP  
createGlobalPropertyf("tu154ce/lights/small/skv_tail_temp",       0) -- TAIL-BAY HOT  
createGlobalPropertyf("tu154ce/lights/small/skv_bleed_fail_1", 0) -- BLEED FAIL 1  
createGlobalPropertyf("tu154ce/lights/small/skv_bleed_fail_2", 0) -- BLEED FAIL 2  
createGlobalPropertyf("tu154ce/lights/small/skv_bleed_fail_3", 0) -- BLEED FAIL 3  
createGlobalPropertyf("tu154ce/lights/small/skv_bleed_closed_1",  0) -- BLEED SHUT 1  
createGlobalPropertyf("tu154ce/lights/small/skv_bleed_closed_2",  0) -- BLEED SHUT 2  
createGlobalPropertyf("tu154ce/lights/small/skv_bleed_closed_3",  0) -- BLEED SHUT 3  
createGlobalPropertyf("tu154ce/lights/small/apd_work_1", 0) -- APD RUN 1  
createGlobalPropertyf("tu154ce/lights/small/apd_work_2", 0) -- APD RUN 2  
createGlobalPropertyf("tu154ce/lights/small/apd_work_3", 0) -- APD RUN 3  
createGlobalPropertyf("tu154ce/lights/small/eng_hydr_fail_1", 0) -- HYD 1 LOW P (BI)  
createGlobalPropertyf("tu154ce/lights/small/eng_hydr_fail_2", 0) -- HYD 2 LOW P (BI)  
createGlobalPropertyf("tu154ce/lights/small/eng_hydr_fail_3", 0) -- HYD 3 LOW P (BI)  
createGlobalPropertyf("tu154ce/lights/small/eng_hydr_fail_4", 0) -- HYD EMERG LOW P  
createGlobalPropertyf("tu154ce/lights/small/tail_temp_high", 0) -- TAIL-BAY HOT  
createGlobalPropertyf("tu154ce/lights/small/lavatory_heat",       0) -- LAV DRAIN HEAT  
createGlobalPropertyf("tu154ce/lights/small/galley_heat", 0) -- GALLEY DRAIN HEAT  
createGlobalPropertyf("tu154ce/lights/small/msrp_mlp_main",       0) -- MSRP MLP MAIN  
createGlobalPropertyf("tu154ce/lights/small/msrp_mlp_aux", 0) -- MSRP MLP AUX  
createGlobalPropertyf("tu154ce/lights/small/msrp_up2",            0) -- MSRP UP-2  
createGlobalPropertyf("tu154ce/lights/small/msrp_mars", 0) -- MSRP MARS  
createGlobalPropertyf("tu154ce/lights/small/srd_low_press",       0) -- CABIN PRESS LOW  
createGlobalPropertyf("tu154ce/lights/small/srd_overpress",       0) -- CABIN OVERPRESS
createGlobalPropertyf("tu154ce/lights/small/soi_work",            0) -- SOI OK (Ice-Detector Serviceable)
createGlobalPropertyf("tu154ce/lights/small/soi_ice_detected", 0) -- SOI ICE (Ice Detected)
createGlobalPropertyf("tu154ce/lights/small/antiice_slats",       0) -- SLATS ANTI-ICE
createGlobalPropertyf("tu154ce/lights/small/antiice_eng_1",       0) -- ENG-1 ANTI-ICE
createGlobalPropertyf("tu154ce/lights/small/antiice_eng_2",       0) -- ENG-2 ANTI-ICE
createGlobalPropertyf("tu154ce/lights/small/antiice_eng_3",       0) -- ENG-3 ANTI-ICE
createGlobalPropertyf("tu154ce/lights/small/antiice_wings",       0) -- WING ANTI-ICE
createGlobalPropertyf("tu154ce/lights/small/close_toilet", 0) -- LAV DOOR CLOSE
createGlobalPropertyf("tu154ce/lights/small/pnp_sp_left", 0) -- LOC (SP)  PNP-L
createGlobalPropertyf("tu154ce/lights/small/pnp_vor_left", 0) -- VOR       PNP-L
createGlobalPropertyf("tu154ce/lights/small/pnp_nv_left", 0) -- ADF (NV)  PNP-L
createGlobalPropertyf("tu154ce/lights/small/pnp_rsbn_left",       0) -- RSBN (TACAN) PNP-L
createGlobalPropertyf("tu154ce/lights/small/pnp_sp_right", 0) -- LOC (SP)  PNP-R
createGlobalPropertyf("tu154ce/lights/small/pnp_vor_right",       0) -- VOR       PNP-R
createGlobalPropertyf("tu154ce/lights/small/pnp_nv_right", 0) -- ADF (NV)  PNP-R
createGlobalPropertyf("tu154ce/lights/small/pnp_rsbn_right", 0) -- RSBN (TACAN) PNP-R
createGlobalPropertyf("tu154ce/lights/small/dme_mile_left",       0) -- DME MILE L
createGlobalPropertyf("tu154ce/lights/small/dme_km_left", 0) -- DME KM L
createGlobalPropertyf("tu154ce/lights/small/dme_mile_right", 0) -- DME MILE R
createGlobalPropertyf("tu154ce/lights/small/dme_km_right", 0) -- DME KM R
createGlobalPropertyf("tu154ce/lights/button/absu_zk",            0) -- ABS-U HDG
createGlobalPropertyf("tu154ce/lights/button/absu_reset", 0) -- ABS-U RESET
createGlobalPropertyf("tu154ce/lights/button/absu_nvu", 0) -- ABS-U NVU
createGlobalPropertyf("tu154ce/lights/button/absu_az1", 0) -- ABS-U AZ-1
createGlobalPropertyf("tu154ce/lights/button/absu_az2", 0) -- ABS-U AZ-2
createGlobalPropertyf("tu154ce/lights/button/absu_app", 0) -- ABS-U APP
createGlobalPropertyf("tu154ce/lights/button/absu_gz",            0) -- ABS-U GS
createGlobalPropertyf("tu154ce/lights/button/absu_stab_m", 0) -- ABS-U STAB-M
createGlobalPropertyf("tu154ce/lights/button/absu_stab_v", 0) -- ABS-U STAB-V
createGlobalPropertyf("tu154ce/lights/button/absu_stab_h", 0) -- ABS-U STAB-H
createGlobalPropertyf("tu154ce/lights/button/absu_stab", 0) -- ABS-U STAB
createGlobalPropertyf("tu154ce/lights/button/absu_stab_spd", 0) -- ABS-U STAB SPD
createGlobalPropertyf("tu154ce/lights/button/absu_thro1", 0) -- ABS-U THR-OFF 1
createGlobalPropertyf("tu154ce/lights/button/absu_thro2", 0) -- ABS-U THR-OFF 2
createGlobalPropertyf("tu154ce/lights/button/absu_thro3", 0) -- ABS-U THR-OFF 3
createGlobalPropertyf("tu154ce/lights/button/dejur_contr", 0) -- DUTY CHECK
createGlobalPropertyf("tu154ce/lights/button/sound_off", 0) -- AUDIO OFF
createGlobalPropertyf("tu154ce/lights/button/fire_eng_1", 0) -- EXT FIRE ENG-1
createGlobalPropertyf("tu154ce/lights/button/fire_eng_2", 0) -- EXT FIRE ENG-2
createGlobalPropertyf("tu154ce/lights/button/fire_eng_3", 0) -- EXT FIRE ENG-3
createGlobalPropertyf("tu154ce/lights/button/fire_apu", 0) -- EXT FIRE APU
createGlobalPropertyf("tu154ce/lights/button/fire_ng",            0) -- EXT FIRE NG
createGlobalPropertyf("tu154ce/lights/button/fire_turn_3", 0) -- FIRE BOTTLE 3
createGlobalPropertyf("tu154ce/lights/button/fire_turn_2", 0) -- FIRE BOTTLE 2
createGlobalPropertyf("tu154ce/lights/button/fire_turn_1", 0) -- FIRE BOTTLE 1
createGlobalPropertyi("tu154ce/lights/white_light_left",          1) -- NAV WHITE L
createGlobalPropertyi("tu154ce/lights/white_light_right",         1) -- NAV WHITE R
createGlobalPropertyi("tu154ce/lights/beacon_light_B",            1) -- BEACON BOT
createGlobalPropertyi("tu154ce/lights/beacon_light_T",            1) -- BEACON TOP
createGlobalPropertyf("tu154ce/lights/sard_panel_lit",            0) -- SARD PANEL LIT
createGlobalPropertyf("tu154ce/lights/nvu_1_active", 0) -- NVU-1 ACTIVE
createGlobalPropertyf("tu154ce/lights/nvu_2_active", 0) -- NVU-2 ACTIVE
createGlobalPropertyf("tu154ce/lights/oil_qty_work_1",            1) -- OIL QTY 1 LIT
createGlobalPropertyf("tu154ce/lights/oil_qty_work_2",            1) -- OIL QTY 2 LIT
createGlobalPropertyf("tu154ce/lights/oil_qty_work_3",            1) -- OIL QTY 3 LIT
createGlobalPropertyi("tu154ce/rotary/KLN90/3D_L_Angle", 0) -- KLN-90 LEFT BIG KNOB
createGlobalPropertyi("tu154ce/rotary/KLN90/3D_R_Angle", 0) -- KLN-90 RIGHT BIG KNOB
createGlobalPropertyi("tu154ce/rotary/KLN90/power_knob", 0) -- KLN-90 POWER KNOB PULL
createGlobalPropertyi("tu154ce/rotary/KLN90/power_knob_angle", 0) -- KLN-90 POWER KNOB ROTATE
createGlobalPropertyi("tu154ce/rotary/KLN90/scan_knob", 0) -- KLN-90 SCAN KNOB PULL
createGlobalPropertyi("tu154ce/switchers/wiper_left", 0) -- WIPER L (-SLOW 0-OFF +FAST)
createGlobalPropertyi("tu154ce/switchers/wiper_right",            0) -- WIPER R (-SLOW 0-OFF +FAST)
createGlobalPropertyf("tu154ce/anim/wiper_angle_left",            0) -- WIPER ANGLE L
createGlobalPropertyf("tu154ce/anim/wiper_angle_right", 0) -- WIPER ANGLE R
createGlobalPropertyi("tu154ce/switchers/kln_knob_out", 0) -- KLN KNOB PULL
createGlobalPropertyi("tu154ce/switchers/kln_power_knob", 0) -- KLN POWER KNOB PUSH
createGlobalPropertyi("tu154ce/lights/landing_light_off", 0) -- LDG LIGHTS OFF
createGlobalPropertyi("tu154ce/lights/landing_light_off_cap", 0) -- LDG LIGHTS CAP
createGlobalPropertyf("tu154ce/lights/gns430_lit",                1) -- GNS-430 PANEL LIT
createGlobalPropertyi("tu154ce/rotary/GNS430/LB_angle", 0) -- GNS-430 LEFT BIG
createGlobalPropertyi("tu154ce/rotary/GNS430/LS_angle", 0) -- GNS-430 LEFT SMALL
createGlobalPropertyi("tu154ce/rotary/GNS430/RB_angle", 0) -- GNS-430 RIGHT BIG
createGlobalPropertyi("tu154ce/rotary/GNS430/RS_angle", 0) -- GNS-430 RIGHT SMALL
createGlobalPropertyf("tu154ce/controll/stab_man_cap_anim",       0) -- STAB MAN CAP ANIM
createGlobalPropertyf("tu154ce/controll/contr_force_cap_anim", 0) -- Q-FEEL CAP ANIM
createGlobalPropertyf("tu154ce/switchers/nosewheel_turn_cap_anim", 0) -- NOSE TILLER CAP ANIM
createGlobalPropertyf("tu154ce/switchers/slat_man_cap_anim", 0) -- SLAT MAN CAP ANIM
createGlobalPropertyf("tu154ce/switchers/flaps_sel_cap_anim", 0) -- FLAP MODE CAP ANIM
createGlobalPropertyf("tu154ce/switchers/gears_retr_lock_cap_anim", 0) -- GEAR LOCK CAP ANIM
createGlobalPropertyf("tu154ce/switchers/gears_ext_3GS_cap_anim", 0) -- GEAR EXT 3GS CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/bkk_contr_cap_anim", 0) -- BKK CTRL CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/bkk_on_cap_anim", 0) -- BKK ON CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/sau_stu_cap_anim",  0) -- SAU/STU CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/pkp_left_cap_anim", 0) -- PKP-L CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/pkp_right_cap_anim", 0) -- PKP-R CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/mgv_contr_cap_anim", 0) -- MGV CTRL CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/emerg_light_cap_anim", 0)-- EMER LIGHT CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/egpws_alarm_1_cap_anim", 0)-- EGPWS ALARM-1 CAP ANIM
createGlobalPropertyf("tu154ce/switchers/ovhd/egpws_alarm_2_cap_anim", 0)-- EGPWS ALARM-2 CAP ANIM
createGlobalPropertyf("tu154ce/buttons/ovhd/transponder_emerg_cap_anim", 0)-- XPDR EMERG CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/hydro_trimm_rud_1_cap_anim", 0)-- HYD TRIM-1 CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/hydro_trimm_rud_2_cap_anim", 0)-- HYD TRIM-2 CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/emerg_gen_on_1_cap_anim", 0)-- EMER GEN-1 CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/emerg_gen_on_2_cap_anim", 0)-- EMER GEN-2 CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/emerg_gen_on_3_cap_anim", 0)-- EMER GEN-3 CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/hydro_circuit_auto_man_cap_anim", 0)-- HYD LOOP AUTO CAP ANIM
createGlobalPropertyf("tu154ce/switchers/eng/hydro_long_control_cap_anim", 0)-- LONG CTRL CAP ANIM
-- === Guards / Safety-covers (…_cap_anim)  -- Western-style captions ================

createGlobalPropertyf("tu154ce/switchers/eng/fire_buzzer_cap_anim", 0) -- FIRE BUZZER - guard  
createGlobalPropertyf("tu154ce/switchers/eng/srd_buzzer_cap_anim",       0) -- CAB-PRESS (SRD) BUZZER - guard  
createGlobalPropertyf("tu154ce/switchers/eng/fuel_buzzer_cap_anim", 0) -- LOW-FUEL 2500 kg BUZZER - guard  

createGlobalPropertyf("tu154ce/switchers/eng/sard_disable_cap_anim", 0) -- SARD AIR-DUMP VALVE - guard  
createGlobalPropertyf("tu154ce/switchers/eng/emerg_inv115_cap_anim", 0) -- EMER 115 V INVERTER - guard  

createGlobalPropertyf("tu154ce/switchers/eng/pts250_on_cap_anim", 0) -- TRU PTS-250 POWER - guard  
createGlobalPropertyf("tu154ce/switchers/eng/pts250_mode_cap_anim", 0) -- TRU PTS-250 MODE (AUTO/MAN) - guard  

createGlobalPropertyf("tu154ce/switchers/eng/bus27_connect_cap_anim", 0) -- 27 V BUS-TIE - guard  

-- Fuel system
createGlobalPropertyf("tu154ce/switchers/fuel/fuel_trans_cap_anim", 0) -- RESERVE XFER VALVES - guard  
createGlobalPropertyf("tu154ce/switchers/fuel/fuel_porc_cap_anim",       0) -- FORCED PORCING (manual transfer) - guard  
createGlobalPropertyf("tu154ce/switchers/fuel/fuel_flow_on_cap_anim", 0) -- FUEL-FLOW AUTO - guard  
createGlobalPropertyf("tu154ce/switchers/fuel/fire_valve_1_cap_anim", 0) -- ENG-1 FIRE SHUTOFF-VALVE - guard  
createGlobalPropertyf("tu154ce/switchers/fuel/fire_valve_2_cap_anim", 0) -- ENG-2 FIRE SHUTOFF-VALVE - guard  
createGlobalPropertyf("tu154ce/switchers/fuel/fire_valve_3_cap_anim", 0) -- ENG-3 FIRE SHUTOFF-VALVE - guard  

-- Hydraulics
createGlobalPropertyf("tu154ce/switchers/hydro/connect2to1_cap_anim", 0) -- HYD SYS-2 ⇒ SYS-1 X-TIE - guard  

-- Air-conditioning / Pressurisation
createGlobalPropertyf("tu154ce/switchers/airbleed/heat_close_cap_anim", 0) -- HEAT OFF - guard  
createGlobalPropertyf("tu154ce/switchers/airbleed/ground_cond_on_cap_anim",  0) -- GROUND A/C - guard  
createGlobalPropertyf("tu154ce/switchers/airbleed/skv_faster_work_cap_anim", 0) -- PACK FAST-MODE - guard  
createGlobalPropertyf("tu154ce/switchers/airbleed/psvp_left_on_cap_anim", 0) -- PSVP LEFT (safety-valve) - guard  
createGlobalPropertyf("tu154ce/switchers/airbleed/psvp_right_on_cap_anim", 0) -- PSVP RIGHT - guard  
createGlobalPropertyf("tu154ce/switchers/airbleed/emerg_decompress_cap_anim", 0) -- EMER DEPRESS - guard  
createGlobalPropertyf("tu154ce/switchers/airbleed/dubler_on_cap_anim",       0) -- PACK STANDBY (“DUBLER”) - guard  

-- Engine-start & gauges
createGlobalPropertyf("tu154ce/switchers/eng/starter_cap_anim", 0) -- ENGINE START PANEL - guard  
createGlobalPropertyf("tu154ce/switchers/eng/gauges_on_1_cap_anim", 0) -- ENG-1 GAUGES POWER - guard  
createGlobalPropertyf("tu154ce/switchers/eng/gauges_on_2_cap_anim", 0) -- ENG-2 GAUGES POWER - guard  
createGlobalPropertyf("tu154ce/switchers/eng/gauges_on_3_cap_anim", 0) -- ENG-3 GAUGES POWER - guard  

-- Flight-controls / boosters
createGlobalPropertyf("tu154ce/switchers/console/busters_cap_anim", 0) -- HYD BOOSTERS SWITCHES - guard  
createGlobalPropertyf("tu154ce/switchers/console/absu_speed_off_cap_anim", 0) -- ABSU STU OFF (Ch 1&2) - guard  
createGlobalPropertyf("tu154ce/switchers/console/absu_speed_prepare_cap_anim", 0) -- ABSU STU PREP - guard  
createGlobalPropertyf("tu154ce/switchers/console/absu_smooth_on_cap_anim", 0) -- ABSU “TURB SMOOTHING” - guard  
createGlobalPropertyf("tu154ce/buttons/console/absu_arrest_cap_anim", 0) -- ABSU ARREST (“Override”) - guard  
createGlobalPropertyf("tu154ce/switchers/console/emerg_elev_trimm_cap_anim", 0) -- EMER ELEV TRIM - guard  

-- Misc 
createGlobalPropertyf("tu154ce/lights/landing_light_off_cap_anim",       0) -- LANDING-LIGHTS SWITCH - guard