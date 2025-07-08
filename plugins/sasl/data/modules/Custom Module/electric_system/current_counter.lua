-- power_counters_logic.lua -- sums current draws per bus

-- Helper function to sum current values in a table
local function sum(t)
    local s = 0
    for _, v in ipairs(t) do s = s + v end
    return s
end

-- Define DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do defineProperty(d[1], d[2](d[3])) end
end

defineProps({
    -- 27V, 36V, and 115V main bus currents
    {"bus27_amp_left",   globalPropertyf, "tu154ce/elec/bus27_amp_left"},
    {"bus27_amp_right",  globalPropertyf, "tu154ce/elec/bus27_amp_right"},
    {"bus36_amp_left",   globalPropertyf, "tu154ce/elec/bus36_amp_left"},
    {"bus36_amp_right",  globalPropertyf, "tu154ce/elec/bus36_amp_right"},
    {"bus36_amp_pts250_1", globalPropertyf, "tu154ce/elec/bus36_amp_pts250_1"},
    {"bus36_amp_pts250_2", globalPropertyf, "tu154ce/elec/bus36_amp_pts250_2"},
    {"bus115_1_amp",     globalPropertyf, "tu154ce/elec/bus115_1_amp"},
    {"bus115_2_amp",     globalPropertyf, "tu154ce/elec/bus115_2_amp"},
    {"bus115_3_amp",     globalPropertyf, "tu154ce/elec/bus115_3_amp"},
    {"bus115_em_1_amp",  globalPropertyf, "tu154ce/elec/bus115_em_1_amp"},
    {"bus115_em_2_amp",  globalPropertyf, "tu154ce/elec/bus115_em_2_amp"},

    -- Main and sub-system current draws
    {"bat_cc_1",         globalPropertyf, "tu154ce/elec/bat_cc_1"},
    {"bat_cc_2",         globalPropertyf, "tu154ce/elec/bat_cc_2"},
    {"bat_cc_3",         globalPropertyf, "tu154ce/elec/bat_cc_3"},
    {"bat_cc_4",         globalPropertyf, "tu154ce/elec/bat_cc_4"},
    {"cockpit_light_cc_left",  globalPropertyf, "tu154ce/elec/cockpit_light_cc_left"},
    {"cockpit_light_cc_right", globalPropertyf, "tu154ce/elec/cockpit_light_cc_right"},
    {"ext_light_cc_left",      globalPropertyf, "tu154ce/elec/ext_light_cc_left"},
    {"ext_light_cc_right",     globalPropertyf, "tu154ce/elec/ext_light_cc_right"},
    {"apu_start_cc",     globalPropertyf, "tu154ce/elec/apu_start_cc"},
    {"fuel_pumps_27_cc", globalPropertyf, "tu154ce/elec/fuel_pumps_27_cc"},
    {"ai_27_L_cc",       globalPropertyf, "tu154ce/antiice/ai_27_L_cc"},
    {"ai_27_R_cc",       globalPropertyf, "tu154ce/antiice/ai_27_R_cc"},
    {"ctr_27_L_cc",      globalPropertyf, "tu154ce/control/ctr_27_L_cc"},
    {"ctr_27_R_cc",      globalPropertyf, "tu154ce/control/ctr_27_R_cc"},
    {"msrp_27_L_cc",     globalPropertyf, "tu154ce/msrp/msrp_27_L_cc"},
    {"msrp_27_R_cc",     globalPropertyf, "tu154ce/msrp/msrp_27_R_cc"},
    {"svs27_cc",         globalPropertyf, "tu154ce/svs/power_27cc"},
    {"auasp_pow27_cc",   globalPropertyf, "tu154ce/elec/auasp_pow27_cc"},
    {"rv_cc_1",          globalPropertyf, "tu154ce/elec/rv5_left_cc"},
    {"rv_cc_2",          globalPropertyf, "tu154ce/elec/rv5_right_cc"},
    {"taws_cc",          globalPropertyf, "tu154ce/taws/taws_cc"},
    {"fire_sys_cc",      globalPropertyf, "tu154ce/fire/fire_sys_cc"},
    {"vhf1_cc",          globalPropertyf, "tu154ce/radio/vhf1_cc"},
    {"vhf2_cc",          globalPropertyf, "tu154ce/radio/vhf2_cc"},
    {"km5_1_cc",         globalPropertyf, "tu154ce/tks/km5_1_cc"},
    {"km5_2_cc",         globalPropertyf, "tu154ce/tks/km5_2_cc"}, -- corrected mapping
    {"ga_1_cc",          globalPropertyf, "tu154ce/tks/ga_1_cc"},
    {"ga_2_cc",          globalPropertyf, "tu154ce/tks/ga_2_cc"},
    {"ga_heat_cc",       globalPropertyf, "tu154ce/tks/ga_heat_cc"},
    {"bgmk_1_cc",        globalPropertyf, "tu154ce/tks/bgmk_1_cc"},
    {"bgmk_2_cc",        globalPropertyf, "tu154ce/tks/bgmk_2_cc"},
    {"ush_cc",           globalPropertyf, "tu154ce/tks/ush_cc"},
    {"agr_cc",           globalPropertyf, "tu154ce/ahz/agr_cc"},
    {"ark15_L_cc",       globalPropertyf, "tu154ce/radio/ark15_L_cc"},
    {"ark15_R_cc",       globalPropertyf, "tu154ce/radio/ark15_R_cc"},
    {"diss_cc",          globalPropertyf, "tu154ce/nvu/diss_cc"},
    {"radar_cc",         globalPropertyf, "tu154ce/radio/radar_cc"},
    {"rsbn_cc",          globalPropertyf, "tu154ce/radio/rsbn_cc"},
    {"kln_cc",           globalPropertyf, "tu154ce/KLN90/power_draw"},

    -- 36V loads
    {"ctr_36L_cc",       globalPropertyf, "tu154ce/control/ctr_36L_cc"},
    {"ctr_36R_cc",       globalPropertyf, "tu154ce/control/ctr_36R_cc"},
    {"svs36_cc",         globalPropertyf, "tu154ce/svs/power_36cc"},
    {"absu_power_cc",    globalPropertyf, "tu154ce/absu_power_cc"},
    {"pkp_left_power_cc", globalPropertyf, "tu154ce/bkk/pkp_left_power_cc"},
    {"pkp_right_power_cc",globalPropertyf, "tu154ce/bkk/pkp_right_power_cc"},
    {"mgv_ctr_power_cc", globalPropertyf, "tu154ce/bkk/mgv_ctr_power_cc"},
    {"absu_at_power_cc", globalPropertyf, "tu154ce/absu_at_power_cc"},
    {"nvu_cc",           globalPropertyf, "tu154ce/nvu/nvu_cc"},
    {"nav1_pow_cc",      globalPropertyf, "tu154ce/radio/nav1_pow_cc"},
    {"nav2_pow_cc",      globalPropertyf, "tu154ce/radio/nav2_pow_cc"},

    -- 115V loads
    {"vu1_amp",          globalPropertyf, "tu154ce/elec/vu1_amp"},
    {"vu2_amp",          globalPropertyf, "tu154ce/elec/vu2_amp"},
    {"vu3_amp",          globalPropertyf, "tu154ce/elec/vu_res_amp"},
    {"cockpit_light_cc_115", globalPropertyf, "tu154ce/elec/cockpit_light_cc_115"},
    {"fuel_pumps_115_1_cc",  globalPropertyf, "tu154ce/elec/fuel_pumps_115_1_cc"},
    {"fuel_pumps_115_3_cc",  globalPropertyf, "tu154ce/elec/fuel_pumps_115_3_cc"},
    {"gs_pump_2_cc",     globalPropertyf, "tu154ce/hydro/gs_pump_2_cc"},
    {"gs_pump_3_cc",     globalPropertyf, "tu154ce/hydro/gs_pump_3_cc"},
    {"ai_115_1_cc",      globalPropertyf, "tu154ce/antiice/ai_115_1_cc"},
    {"ai_115_2_cc",      globalPropertyf, "tu154ce/antiice/ai_115_2_cc"},
    {"ai_115_3_cc",      globalPropertyf, "tu154ce/antiice/ai_115_3_cc"},
    {"ctr_115_1_cc",     globalPropertyf, "tu154ce/control/ctr_115_1_cc"},
    {"ctr_115_3_cc",     globalPropertyf, "tu154ce/control/ctr_115_3_cc"},
    {"svs115_cc",        globalPropertyf, "tu154ce/svs/power_115cc"},
    {"auasp_pow115_cc",  globalPropertyf, "tu154ce/elec/auasp_pow115_cc"},
})

defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))

function update()
    if get(ismaster) == 1 then return end

    -- Calculate total 27V current draw for left bus
    local bus27_L = sum{
        get(bat_cc_1), get(bat_cc_3), get(cockpit_light_cc_left),
        get(ext_light_cc_left), get(fuel_pumps_27_cc)*0.5,
        get(ai_27_L_cc), get(ctr_27_L_cc), get(msrp_27_L_cc),
        get(svs27_cc), get(kln_cc), get(rv_cc_1), get(taws_cc),
        get(vhf1_cc), get(km5_1_cc)*2, get(ga_1_cc)*0.5,
        get(ga_2_cc)*0.5, get(ga_heat_cc), get(bgmk_1_cc),
        get(agr_cc), get(nvu_cc)*10, get(ark15_L_cc),
        get(diss_cc), get(rsbn_cc)*5
    }

    -- Calculate total 27V current draw for right bus
    local bus27_R = sum{
        get(bat_cc_2), get(bat_cc_4), get(cockpit_light_cc_right),
        get(ext_light_cc_right), get(fuel_pumps_27_cc)*0.5,
        get(ai_27_R_cc), get(ctr_27_R_cc), get(msrp_27_R_cc),
        get(auasp_pow27_cc), get(rv_cc_2), get(fire_sys_cc),
        get(vhf2_cc), get(km5_2_cc)*2, get(bgmk_2_cc),
        get(ush_cc), get(ark15_R_cc), get(radar_cc)*3
    }
    set(bus27_amp_left,  bus27_L)
    set(bus27_amp_right, bus27_R)

    -- Calculate total 36V current draw for left and right buses
    set(bus36_amp_left,  sum{
        get(ctr_36L_cc), get(svs36_cc), get(absu_power_cc)*3,
        get(pkp_left_power_cc), get(absu_at_power_cc), get(nvu_cc)*7,
        get(ark15_L_cc), get(diss_cc)
    })
    set(bus36_amp_right, sum{
        get(ctr_36R_cc), get(absu_power_cc)*3,
        get(pkp_right_power_cc), get(km5_2_cc)*3,
        get(ga_2_cc)*2, get(bgmk_2_cc), get(ark15_R_cc),
        get(nav2_pow_cc)
    })

    -- Current from PTS-250 unit 1 and 2
    set(bus36_amp_pts250_1, sum{
        get(absu_power_cc)*3, get(mgv_ctr_power_cc), get(agr_cc), get(radar_cc)
    })
    set(bus36_amp_pts250_2, sum{
        get(km5_1_cc)*3, get(ga_1_cc)*2, get(bgmk_1_cc), get(nav1_pow_cc)
    })

    -- Calculate total 115V current draw for each bus (addition, not multiplication)
    set(bus115_1_amp, sum{
        get(vu1_amp)*0.25, get(vu3_amp)*0.125,
        get(cockpit_light_cc_115)*0.5, get(fuel_pumps_115_1_cc),
        get(gs_pump_2_cc), get(ai_115_1_cc), get(ctr_115_1_cc),
        get(svs115_cc), get(rv_cc_1), get(taws_cc)*0.2,
        get(absu_at_power_cc), get(nvu_cc), get(diss_cc)*3,
        get(nav1_pow_cc), get(rsbn_cc)   -- now using addition
    })
    set(bus115_2_amp, get(ai_115_2_cc))  -- only anti-ice on 115V2
    set(bus115_3_amp, sum{
        get(vu2_amp)*0.25, get(vu3_amp)*0.125,
        get(cockpit_light_cc_115)*0.5, get(fuel_pumps_115_3_cc),
        get(gs_pump_3_cc), get(ai_115_3_cc), get(ctr_115_3_cc),
        get(auasp_pow115_cc), get(rv_cc_2), get(absu_power_cc),
        get(nav2_pow_cc), get(radar_cc)*3
    })
end
