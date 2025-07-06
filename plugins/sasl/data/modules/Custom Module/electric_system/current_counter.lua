-- this is power counters logic
-- 27V electrical system current draw 
defineProperty("bus27_amp_left", globalPropertyf("tu154ce/elec/bus27_amp_left"))   -- current in left 27V bus 
defineProperty("bus27_amp_right", globalPropertyf("tu154ce/elec/bus27_amp_right"))  -- current in right 27V bus

-- 36V electrical system current draw 
defineProperty("bus36_amp_left", globalPropertyf("tu154ce/elec/bus36_amp_left"))   -- current in left 36V bus 
defineProperty("bus36_amp_right", globalPropertyf("tu154ce/elec/bus36_amp_right"))  -- current in right 36V bus

-- 36V PTS-250 converter unit current draw 
defineProperty("bus36_amp_pts250_1", globalPropertyf("tu154ce/elec/bus36_amp_pts250_1")) -- current from PTS-250 unit 1 
defineProperty("bus36_amp_pts250_2", globalPropertyf("tu154ce/elec/bus36_amp_pts250_2")) -- current from PTS-250 unit 2

-- 115V electrical system current draw 
defineProperty("bus115_1_amp", globalPropertyf("tu154ce/elec/bus115_1_amp")) 
defineProperty("bus115_2_amp", globalPropertyf("tu154ce/elec/bus115_2_amp")) 
defineProperty("bus115_3_amp", globalPropertyf("tu154ce/elec/bus115_3_amp"))
defineProperty("bus115_em_1_amp", globalPropertyf("tu154ce/elec/bus115_em_1_amp")) 
defineProperty("bus115_em_2_amp", globalPropertyf("tu154ce/elec/bus115_em_2_amp"))

-- power sources / loads on 27V bus 
defineProperty("bat_amp_cc_1", globalPropertyf("tu154ce/elec/bat_cc_1"))       -- battery 1 charge current 
defineProperty("bat_amp_cc_2", globalPropertyf("tu154ce/elec/bat_cc_2"))       -- battery 2 charge current 
defineProperty("bat_amp_cc_3", globalPropertyf("tu154ce/elec/bat_cc_3"))       -- battery 3 charge current 
defineProperty("bat_amp_cc_4", globalPropertyf("tu154ce/elec/bat_cc_4"))       -- battery 4 charge current 
defineProperty("cockpit_light_cc_left", globalPropertyf("tu154ce/elec/cockpit_light_cc_left"))   -- cockpit lighting on left bus 
defineProperty("cockpit_light_cc_right", globalPropertyf("tu154ce/elec/cockpit_light_cc_right"))  -- cockpit lighting on right bus 
defineProperty("ext_light_cc_left", globalPropertyf("tu154ce/elec/ext_light_cc_left"))         -- external lighting on left bus 
defineProperty("ext_light_cc_right", globalPropertyf("tu154ce/elec/ext_light_cc_right"))        -- external lighting on right bus 
defineProperty("apu_start_cc", globalPropertyf("tu154ce/elec/apu_start_cc"))     -- APU starter current draw 
defineProperty("fuel_pumps_27_cc", globalPropertyf("tu154ce/elec/fuel_pumps_27_cc")) -- fuel pumps on 27V bus
defineProperty("ai_27_L_cc", globalPropertyf("tu154ce/antiice/ai_27_L_cc"))       -- anti‑ice on left bus 
defineProperty("ai_27_R_cc", globalPropertyf("tu154ce/antiice/ai_27_R_cc"))       -- anti‑ice on right bus
defineProperty("ctr_27_L_cc", globalPropertyf("tu154ce/control/ctr_27_L_cc"))     -- flight controls on left bus 
defineProperty("ctr_27_R_cc", globalPropertyf("tu154ce/control/ctr_27_R_cc"))     -- flight controls on right bus
defineProperty("msrp_27_L_cc", globalPropertyf("tu154ce/msrp/msrp_27_L_cc"))     -- MSRP system on left bus 
defineProperty("msrp_27_R_cc", globalPropertyf("tu154ce/msrp/msrp_27_R_cc"))     -- MSRP system on right bus
defineProperty("svs27_cc", globalPropertyf("tu154ce/svs/power_27cc"))        -- SVS system draw 
defineProperty("auasp_pow27_cc", globalPropertyf("tu154ce/elec/auasp_pow27_cc"))   -- AUASP system draw
defineProperty("rv_cc_1", globalPropertyf("tu154ce/elec/rv5_left_cc"))      -- RV5 left draw 
defineProperty("rv_cc_2", globalPropertyf("tu154ce/elec/rv5_right_cc"))     -- RV5 right draw
defineProperty("taws_cc", globalPropertyf("tu154ce/taws/taws_cc"))          -- TAWS draw 
defineProperty("fire_sys_cc", globalPropertyf("tu154ce/fire/fire_sys_cc"))      -- fire protection draw
defineProperty("vhf1_cc", globalPropertyf("tu154ce/radio/vhf1_cc"))         -- VHF1 draw 
defineProperty("vhf2_cc", globalPropertyf("tu154ce/radio/vhf2_cc"))         -- VHF2 draw
defineProperty("km5_1_cc", globalPropertyf("tu154ce/tks/km5_1_cc"))         -- KM‑5 unit 1 draw 
defineProperty("km5_2_cc", globalPropertyf("tu154ce/tks/km5_1_cc"))         -- KM‑5 unit 2 draw
defineProperty("ga_1_cc", globalPropertyf("tu154ce/tks/ga_1_cc")) -- GA pump main draw 
defineProperty("ga_2_cc", globalPropertyf("tu154ce/tks/ga_2_cc"))           -- GA pump backup draw 
defineProperty("ga_heat_cc", globalPropertyf("tu154ce/tks/ga_heat_cc"))        -- GA heater draw 
defineProperty("bgmk_1_cc", globalPropertyf("tu154ce/tks/bgmk_1_cc"))        -- BGMK unit 1 draw 
defineProperty("bgmk_2_cc", globalPropertyf("tu154ce/tks/bgmk_2_cc"))        -- BGMK unit 2 draw
defineProperty("ush_cc", globalPropertyf("tu154ce/tks/ush_cc"))           -- USH system draw 
defineProperty("agr_cc", globalPropertyf("tu154ce/ahz/agr_cc"))           -- AGR unit draw 
defineProperty("ark15_L_cc", globalPropertyf("tu154ce/radio/ark15_L_cc"))     -- ARK‑15 left draw 
defineProperty("ark15_R_cc", globalPropertyf("tu154ce/radio/ark15_R_cc"))     -- ARK‑15 right draw
defineProperty("diss_cc", globalPropertyf("tu154ce/nvu/diss_cc"))           -- DISS draw 
defineProperty("radar_cc", globalPropertyf("tu154ce/radio/radar_cc"))       -- Groza radar draw 
defineProperty("rsbn_cc", globalPropertyf("tu154ce/radio/rsbn_cc"))        -- RSBN draw 
defineProperty("kln_cc", globalPropertyf("tu154ce/KLN90/power_draw"))      -- KLN90B draw

-- bus 36V 
defineProperty("ctr_36L_cc", globalPropertyf("tu154ce/control/ctr_36L_cc"))    -- flight controls left 36V 
defineProperty("ctr_36R_cc", globalPropertyf("tu154ce/control/ctr_36R_cc"))    -- flight controls right 36V 
defineProperty("svs36_cc", globalPropertyf("tu154ce/svs/power_36cc"))         -- SVS draw on 36V 
defineProperty("absu_power_cc", globalPropertyf("tu154ce/absu_power_cc"))         -- ABSU draw on 36V 
defineProperty("pkp_left_power_cc", globalPropertyf("tu154ce/bkk/pkp_left_power_cc"))  -- PKP left draw 
defineProperty("pkp_right_power_cc", globalPropertyf("tu154ce/bkk/pkp_right_power_cc")) -- PKP right draw 
defineProperty("mgv_ctr_power_cc", globalPropertyf("tu154ce/bkk/mgv_ctr_power_cc"))   -- MGV draw 
defineProperty("absu_at_power_cc", globalPropertyf("tu154ce/absu_at_power_cc"))       -- ABSU autothrust draw 
defineProperty("nvu_cc", globalPropertyf("tu154ce/nvu/nvu_cc"))             -- NVU draw 
defineProperty("nav1_pow_cc", globalPropertyf("tu154ce/radio/nav1_pow_cc"))      -- NAV1 amplifier draw 
defineProperty("nav2_pow_cc", globalPropertyf("tu154ce/radio/nav2_pow_cc"))      -- NAV2 amplifier draw

-- bus 115V loads 
defineProperty("vu1_amp", globalPropertyf("tu154ce/elec/vu1_amp"))             -- VU1 generator draw 
defineProperty("vu2_amp", globalPropertyf("tu154ce/elec/vu2_amp"))             -- VU2 generator draw 
defineProperty("vu3_amp", globalPropertyf("tu154ce/elec/vu_res_amp"))         -- reserve VU draw 
defineProperty("cockpit_light_cc_115", globalPropertyf("tu154ce/elec/cockpit_light_cc_115")) -- cockpit light on 115V 
defineProperty("fuel_pumps_115_1_cc", globalPropertyf("tu154ce/elec/fuel_pumps_115_1_cc")) -- fuel pumps on 115V bus 1 
defineProperty("fuel_pumps_115_3_cc", globalPropertyf("tu154ce/elec/fuel_pumps_115_3_cc")) -- fuel pumps on 115V bus 3 
defineProperty("gs_pump_2_cc", globalPropertyf("tu154ce/hydro/gs_pump_2_cc"))       -- hydraulic pump 2 draw 
defineProperty("gs_pump_3_cc", globalPropertyf("tu154ce/hydro/gs_pump_3_cc"))       -- hydraulic pump 3 draw 
defineProperty("ai_115_1_cc", globalPropertyf("tu154ce/antiice/ai_115_1_cc"))    -- anti‑ice on 115V 1 
defineProperty("ai_115_2_cc", globalPropertyf("tu154ce/antiice/ai_115_2_cc"))    -- anti‑ice on 115V 2 
defineProperty("ai_115_3_cc", globalPropertyf("tu154ce/antiice/ai_115_3_cc"))    -- anti‑ice on 115V 3 
defineProperty("ctr_115_1_cc", globalPropertyf("tu154ce/control/ctr_115_1_cc"))   -- flight controls on 115V 1 
defineProperty("ctr_115_3_cc", globalPropertyf("tu154ce/control/ctr_115_3_cc"))   -- flight controls on 115V 3 
defineProperty("svs115_cc", globalPropertyf("tu154ce/svs/power_115cc"))        -- SVS on 115V 
defineProperty("auasp_pow115_cc", globalPropertyf("tu154ce/elec/auasp_pow115_cc"))   -- AUASP on 115V

-- Smart Copilot 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) -- plugin master flag

-- update loop: sum all loads onto each bus 
function update() if get(ismaster) == 1 then

	local bus27_L = get(bat_amp_cc_1) + get(bat_amp_cc_3) + get(cockpit_light_cc_left) + get(ext_light_cc_left) + get(fuel_pumps_27_cc) * 0.5 + get(ai_27_L_cc) + get(ctr_27_L_cc) + get(msrp_27_L_cc) bus27_L = bus27_L + get(svs27_cc) + get(kln_cc) + get(rv_cc_1) + get(taws_cc) + get(vhf1_cc) + get(km5_1_cc) * 2 + get(ga_1_cc) * 0.5 + get(ga_2_cc) * 0.5 + get(ga_heat_cc) + get(bgmk_1_cc) + get(agr_cc) bus27_L = bus27_L + get(nvu_cc) * 10 + get(ark15_L_cc) + get(diss_cc) + get(rsbn_cc) * 5 

	local bus27_R = get(bat_amp_cc_2) + get(bat_amp_cc_4) + get(cockpit_light_cc_right) + get(ext_light_cc_right) + get(fuel_pumps_27_cc) * 0.5 + get(ai_27_R_cc) + get(ctr_27_R_cc) + get(msrp_27_R_cc) bus27_R = bus27_R + get(auasp_pow27_cc) + get(rv_cc_2) + get(fire_sys_cc) + get(vhf2_cc) + get(km5_2_cc) * 2 + get(bgmk_2_cc) + get(ush_cc) + get(ark15_R_cc) + get(radar_cc) * 3 set(bus27_amp_left,  bus27_L) set(bus27_amp_right, bus27_R)

	local bus36_L = get(ctr_36L_cc) + get(svs36_cc) + get(absu_power_cc) * 3 + get(pkp_left_power_cc) + get(absu_at_power_cc) + get(nvu_cc) * 7 + get(ark15_L_cc) + get(diss_cc)

	local bus36_R = get(ctr_36R_cc) + get(absu_power_cc) * 3 + get(pkp_right_power_cc)
  + get(km5_2_cc) * 3 + get(ga_2_cc) * 2 + get(bgmk_2_cc) + get(ark15_R_cc) + get(nav2_pow_cc)

	local bus36_pts_1 = get(absu_power_cc) * 3 + get(mgv_ctr_power_cc) + get(agr_cc) + get(radar_cc)

	local bus36_pts_2 = get(km5_1_cc) * 3 + get(ga_1_cc) * 2 + get(bgmk_1_cc) + get(nav1_pow_cc)

set(bus36_amp_left,       bus36_L)
set(bus36_amp_right,      bus36_R)
set(bus36_amp_pts250_1,   bus36_pts_1)
set(bus36_amp_pts250_2,   bus36_pts_2)

	local bus115_1 = get(vu1_amp) * 0.25 + get(vu3_amp) * 0.125 + get(cockpit_light_cc_115) * 0.5 + get(fuel_pumps_115_1_cc) + get(gs_pump_2_cc) + get(ai_115_1_cc) + get(ctr_115_1_cc)

	bus115_1 = bus115_1 + get(svs115_cc) + get(rv_cc_1) + get(taws_cc) * 0.2 + get(absu_at_power_cc) + get(nvu_cc) + get(diss_cc) * 3 + get(nav1_pow_cc) * get(rsbn_cc) * 5

	local bus115_2 = get(ai_115_2_cc)

	local bus115_3 = get(vu2_amp) * 0.25 + get(vu3_amp) * 0.125 + get(cockpit_light_cc_115) * 0.5 + get(fuel_pumps_115_3_cc) + get(gs_pump_3_cc) + get(ai_115_3_cc) + get(ctr_115_3_cc)

	bus115_3 = bus115_3 + get(auasp_pow115_cc) + get(rv_cc_2) + get(absu_power_cc) + get(nav2_pow_cc) + get(radar_cc) * 3

set(bus115_1_amp, bus115_1)
set(bus115_2_amp, bus115_2)
set(bus115_3_amp, bus115_3)

	end 
end

