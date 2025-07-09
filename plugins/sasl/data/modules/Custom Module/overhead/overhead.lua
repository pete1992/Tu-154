-- overhead_panel.lua – Tu-154M Overhead Panel Logic (SASL 3.19)
-- Handles all overhead switches, caps, buttons, state resets, and sound feedback

-- Helper functions
local function bool2int(v) return v and 1 or 0 end
local function defineProps(defs)
    for _, d in ipairs(defs) do defineProperty(d[1], d[3](d[2])) end
end
local function table_keys(tbl)
    local keys = {}
    for k, _ in pairs(tbl) do table.insert(keys, k) end
    return keys
end

-- Batch DataRef definitions (all overhead panel switches, caps, buttons)
defineProps({
    -- Switches
    {"var_left",        globalPropertyi, "tu154ce/switchers/ovhd/var_left"},
    {"var_right",       globalPropertyi, "tu154ce/switchers/ovhd/var_right"},
    {"auasp_on",        globalPropertyi, "tu154ce/switchers/ovhd/auasp_on"},
    {"auasp_contr",     globalPropertyi, "tu154ce/switchers/ovhd/auasp_contr"},
    {"eup_on",          globalPropertyi, "tu154ce/switchers/ovhd/eup_on"},
    {"agr_on",          globalPropertyi, "tu154ce/switchers/ovhd/agr_on"},
    {"bkk_contr",       globalPropertyi, "tu154ce/switchers/ovhd/bkk_contr"},
    {"bkk_on",          globalPropertyi, "tu154ce/switchers/ovhd/bkk_on"},
    {"sau_stu_on",      globalPropertyi, "tu154ce/switchers/ovhd/sau_stu_on"},
    {"pkp_left_on",     globalPropertyi, "tu154ce/switchers/ovhd/pkp_left_on"},
    {"pkp_right_on",    globalPropertyi, "tu154ce/switchers/ovhd/pkp_right_on"},
    {"mgv_contr",       globalPropertyi, "tu154ce/switchers/ovhd/mgv_contr"},
    {"tks_on_1",        globalPropertyi, "tu154ce/switchers/ovhd/tks_on_1"},
    {"tks_on_2",        globalPropertyi, "tu154ce/switchers/ovhd/tks_on_2"},
    {"tks_heat",        globalPropertyi, "tu154ce/switchers/ovhd/tks_heat"},
    {"tks_corr_1",      globalPropertyi, "tu154ce/switchers/ovhd/tks_corr_1"},
    {"tks_corr_2",      globalPropertyi, "tu154ce/switchers/ovhd/tks_corr_2"},
    {"curs_pnp_mode_1", globalPropertyi, "tu154ce/switchers/ovhd/curs_pnp_mode_1"},
    {"curs_pnp_mode_2", globalPropertyi, "tu154ce/switchers/ovhd/curs_pnp_mode_2"},
    {"svs_on",          globalPropertyi, "tu154ce/switchers/ovhd/svs_on"},
    {"svs_heat",        globalPropertyi, "tu154ce/switchers/ovhd/svs_heat"},
    {"kln_on",          globalPropertyi, "tu154ce/switchers/ovhd/kln_on"},
    {"tcas_on",         globalPropertyi, "tu154ce/switchers/ovhd/tcas_on"},
    {"emerg_light_on",  globalPropertyi, "tu154ce/switchers/ovhd/emerg_light_on"},
    {"curs_np_on_1",    globalPropertyi, "tu154ce/switchers/ovhd/curs_np_on_1"},
    {"curs_np_on_2",    globalPropertyi, "tu154ce/switchers/ovhd/curs_np_on_2"},
    {"tra_67_on",       globalPropertyi, "tu154ce/switchers/ovhd/tra_67_on"},
    {"rsbn_on",         globalPropertyi, "tu154ce/switchers/ovhd/rsbn_on"},
    {"rsbn_recon",      globalPropertyi, "tu154ce/switchers/ovhd/rsbn_recon"},
    {"rv5_1_on",        globalPropertyi, "tu154ce/switchers/ovhd/rv5_1_on"},
    {"rv5_2_on",        globalPropertyi, "tu154ce/switchers/ovhd/rv5_2_on"},
    {"vhf_1_on",        globalPropertyi, "tu154ce/switchers/ovhd/vhf_1_on"},
    {"vhf_2_on",        globalPropertyi, "tu154ce/switchers/ovhd/vhf_2_on"},
    {"stabil_ga_main",  globalPropertyi, "tu154ce/switchers/ovhd/stabil_ga_main"},
    {"stabil_ga_reserv",globalPropertyi, "tu154ce/switchers/ovhd/stabil_ga_reserv"},
    {"micron_1_on",     globalPropertyi, "tu154ce/switchers/ovhd/micron_1_on"},
    {"micron_2_on",     globalPropertyi, "tu154ce/switchers/ovhd/micron_2_on"},
    {"spu_on",          globalPropertyi, "tu154ce/switchers/ovhd/spu_on"},
    {"sgs_on",          globalPropertyi, "tu154ce/switchers/ovhd/sgs_on"},
    {"sd75_1_on",       globalPropertyi, "tu154ce/switchers/ovhd/sd75_1_on"},
    {"sd75_2_on",       globalPropertyi, "tu154ce/switchers/ovhd/sd75_2_on"},
    {"uvid_on",         globalPropertyi, "tu154ce/switchers/ovhd/uvid_on"},
    {"vbe_1_on",        globalPropertyi, "tu154ce/switchers/ovhd/vbe_1_on"},
    {"vbe_2_on",        globalPropertyi, "tu154ce/switchers/ovhd/vbe_2_on"},
    {"mars_on",         globalPropertyi, "tu154ce/switchers/ovhd/mars_on"},
    {"vent_1",          globalPropertyi, "tu154ce/switchers/ovhd/vent_1"},
    {"vent_2",          globalPropertyi, "tu154ce/switchers/ovhd/vent_2"},
    {"vent_3",          globalPropertyi, "tu154ce/switchers/ovhd/vent_3"},
    {"arm406",          globalPropertyi, "tu154ce/switchers/ovhd/arm406"},
    {"ushdb_mode_1",    globalPropertyi, "tu154ce/switchers/ovhd/ushdb_mode_1"},
    {"ushdb_mode_2",    globalPropertyi, "tu154ce/switchers/ovhd/ushdb_mode_2"},
    -- Buttons & caps
    {"tks_signal_off",  globalPropertyi, "tu154ce/buttons/ovhd/tks_signal_off"},
    {"svs_contr",       globalPropertyi, "tu154ce/buttons/ovhd/svs_contr"},
    {"bkk_contr_cap",   globalPropertyi, "tu154ce/switchers/ovhd/bkk_contr_cap"},
    {"bkk_on_cap",      globalPropertyi, "tu154ce/switchers/ovhd/bkk_on_cap"},
    {"sau_stu_cap",     globalPropertyi, "tu154ce/switchers/ovhd/sau_stu_cap"},
    {"pkp_left_cap",    globalPropertyi, "tu154ce/switchers/ovhd/pkp_left_cap"},
    {"pkp_right_cap",   globalPropertyi, "tu154ce/switchers/ovhd/pkp_right_cap"},
    {"mgv_contr_cap",   globalPropertyi, "tu154ce/switchers/ovhd/mgv_contr_cap"},
    {"emerg_light_cap", globalPropertyi, "tu154ce/switchers/ovhd/emerg_light_cap"},
    -- Misc & status
    {"frame_time",      globalPropertyf, "tu154ce/time/frame_time"},
    {"eng1_N1",         globalPropertyf, "sim/flightmodel/engine/ENGN_N1_[0]"},
    {"eng2_N1",         globalPropertyf, "sim/flightmodel/engine/ENGN_N1_[1]"},
    {"eng3_N1",         globalPropertyf, "sim/flightmodel/engine/ENGN_N1_[2]"},
})

-- Switches, caps, buttons lists for unified logic
local switches = {
    "var_left","var_right","auasp_on","auasp_contr","eup_on","agr_on","bkk_contr","bkk_on",
    "sau_stu_on","pkp_left_on","pkp_right_on","mgv_contr","tks_on_1","tks_on_2","tks_heat",
    "tks_corr_1","tks_corr_2","curs_pnp_mode_1","curs_pnp_mode_2","svs_on","svs_heat",
    "kln_on","tcas_on","emerg_light_on","curs_np_on_1","curs_np_on_2","tra_67_on","rsbn_on",
    "rsbn_recon","rv5_1_on","rv5_2_on","vhf_1_on","vhf_2_on","stabil_ga_main","stabil_ga_reserv",
    "micron_1_on","micron_2_on","spu_on","sgs_on","sd75_1_on","sd75_2_on","vent_1","vent_2",
    "vent_3","arm406","ushdb_mode_1","ushdb_mode_2"
}
local caps = {
    bkk_contr_cap="bkk_contr", bkk_on_cap="bkk_on", sau_stu_cap="sau_stu_on",
    pkp_left_cap="pkp_left_on", pkp_right_cap="pkp_right_on",
    mgv_contr_cap="mgv_contr", emerg_light_cap="emerg_light_on"
}
local btns = {"tks_signal_off","svs_contr"}

-- Previous state caches
local last = {}
for _,k in ipairs(switches) do last[k]=get(_G[k]) end
for _,k in ipairs(btns)    do last[k]=get(_G[k]) end
for cap,_ in pairs(caps)   do last[cap]=get(_G[cap]) end

-- Sounds
local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local cap_sound    = loadSample('Custom Sounds/cap.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')

-- Initialization
local init = true
local timer = 0

-- Reset all switches/caps on cold & dark engines
local function reset_all()
    if get(eng1_N1)<5 and get(eng2_N1)<5 and get(eng3_N1)<5 then
        for _,k in ipairs(switches) do set(_G[k],0) end
        for cap,_ in pairs(caps) do set(_G[cap],1) end
    end
    init = false
end

-- Sound handling for changes
local function handle_changes(list, sound)
    for _,k in ipairs(list) do
        local cur = get(_G[k])
        if cur~=last[k] then playSample(sound,false) end
        last[k]=cur
    end
end

-- Main update loop
function update()
    local dt = get(frame_time)
    timer = timer + dt
    -- Reset after loading if cold & dark
    if init and timer>0.3 then reset_all() end

    handle_changes(switches, switch_sound)
    handle_changes(btns, button_sound)
    handle_changes(table_keys(caps), cap_sound)

    -- Cap action: close = set switch off (except emerg light: ON when cap down)
    for cap,sw in pairs(caps) do
        if get(_G[cap])==0 then set(_G[sw], bool2int(cap=="emerg_light_cap")) end
    end
end

