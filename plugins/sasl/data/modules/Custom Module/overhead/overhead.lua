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
    {"var_left",        "tu154ce/switchers/ovhd/var_left",        globalPropertyi},
    {"var_right",       "tu154ce/switchers/ovhd/var_right",       globalPropertyi},
    {"auasp_on",        "tu154ce/switchers/ovhd/auasp_on",        globalPropertyi},
    {"auasp_contr",     "tu154ce/switchers/ovhd/auasp_contr",     globalPropertyi},
    {"eup_on",          "tu154ce/switchers/ovhd/eup_on",          globalPropertyi},
    {"agr_on",          "tu154ce/switchers/ovhd/agr_on",          globalPropertyi},
    {"bkk_contr",       "tu154ce/switchers/ovhd/bkk_contr",       globalPropertyi},
    {"bkk_on",          "tu154ce/switchers/ovhd/bkk_on",          globalPropertyi},
    {"sau_stu_on",      "tu154ce/switchers/ovhd/sau_stu_on",      globalPropertyi},
    {"pkp_left_on",     "tu154ce/switchers/ovhd/pkp_left_on",     globalPropertyi},
    {"pkp_right_on",    "tu154ce/switchers/ovhd/pkp_right_on",    globalPropertyi},
    {"mgv_contr",       "tu154ce/switchers/ovhd/mgv_contr",       globalPropertyi},
    {"tks_on_1",        "tu154ce/switchers/ovhd/tks_on_1",        globalPropertyi},
    {"tks_on_2",        "tu154ce/switchers/ovhd/tks_on_2",        globalPropertyi},
    {"tks_heat",        "tu154ce/switchers/ovhd/tks_heat",        globalPropertyi},
    {"tks_corr_1",      "tu154ce/switchers/ovhd/tks_corr_1",      globalPropertyi},
    {"tks_corr_2",      "tu154ce/switchers/ovhd/tks_corr_2",      globalPropertyi},
    {"curs_pnp_mode_1", "tu154ce/switchers/ovhd/curs_pnp_mode_1", globalPropertyi},
    {"curs_pnp_mode_2", "tu154ce/switchers/ovhd/curs_pnp_mode_2", globalPropertyi},
    {"svs_on",          "tu154ce/switchers/ovhd/svs_on",          globalPropertyi},
    {"svs_heat",        "tu154ce/switchers/ovhd/svs_heat",        globalPropertyi},
    {"kln_on",          "tu154ce/switchers/ovhd/kln_on",          globalPropertyi},
    {"tcas_on",         "tu154ce/switchers/ovhd/tcas_on",         globalPropertyi},
    {"emerg_light_on",  "tu154ce/switchers/ovhd/emerg_light_on",  globalPropertyi},
    {"curs_np_on_1",    "tu154ce/switchers/ovhd/curs_np_on_1",    globalPropertyi},
    {"curs_np_on_2",    "tu154ce/switchers/ovhd/curs_np_on_2",    globalPropertyi},
    {"tra_67_on",       "tu154ce/switchers/ovhd/tra_67_on",       globalPropertyi},
    {"rsbn_on",         "tu154ce/switchers/ovhd/rsbn_on",         globalPropertyi},
    {"rsbn_recon",      "tu154ce/switchers/ovhd/rsbn_recon",      globalPropertyi},
    {"rv5_1_on",        "tu154ce/switchers/ovhd/rv5_1_on",        globalPropertyi},
    {"rv5_2_on",        "tu154ce/switchers/ovhd/rv5_2_on",        globalPropertyi},
    {"vhf_1_on",        "tu154ce/switchers/ovhd/vhf_1_on",        globalPropertyi},
    {"vhf_2_on",        "tu154ce/switchers/ovhd/vhf_2_on",        globalPropertyi},
    {"stabil_ga_main",  "tu154ce/switchers/ovhd/stabil_ga_main",  globalPropertyi},
    {"stabil_ga_reserv","tu154ce/switchers/ovhd/stabil_ga_reserv",globalPropertyi},
    {"micron_1_on",     "tu154ce/switchers/ovhd/micron_1_on",     globalPropertyi},
    {"micron_2_on",     "tu154ce/switchers/ovhd/micron_2_on",     globalPropertyi},
    {"spu_on",          "tu154ce/switchers/ovhd/spu_on",          globalPropertyi},
    {"sgs_on",          "tu154ce/switchers/ovhd/sgs_on",          globalPropertyi},
    {"sd75_1_on",       "tu154ce/switchers/ovhd/sd75_1_on",       globalPropertyi},
    {"sd75_2_on",       "tu154ce/switchers/ovhd/sd75_2_on",       globalPropertyi},
    {"uvid_on",         "tu154ce/switchers/ovhd/uvid_on",         globalPropertyi},
    {"vbe_1_on",        "tu154ce/switchers/ovhd/vbe_1_on",        globalPropertyi},
    {"vbe_2_on",        "tu154ce/switchers/ovhd/vbe_2_on",        globalPropertyi},
    {"mars_on",         "tu154ce/switchers/ovhd/mars_on",         globalPropertyi},
    {"vent_1",          "tu154ce/switchers/ovhd/vent_1",          globalPropertyi},
    {"vent_2",          "tu154ce/switchers/ovhd/vent_2",          globalPropertyi},
    {"vent_3",          "tu154ce/switchers/ovhd/vent_3",          globalPropertyi},
    {"arm406",          "tu154ce/switchers/ovhd/arm406",          globalPropertyi},
    {"ushdb_mode_1",    "tu154ce/switchers/ovhd/ushdb_mode_1",    globalPropertyi},
    {"ushdb_mode_2",    "tu154ce/switchers/ovhd/ushdb_mode_2",    globalPropertyi},
    -- Buttons & caps
    {"tks_signal_off",  "tu154ce/buttons/ovhd/tks_signal_off",    globalPropertyi},
    {"svs_contr",       "tu154ce/buttons/ovhd/svs_contr",         globalPropertyi},
    {"bkk_contr_cap",   "tu154ce/switchers/ovhd/bkk_contr_cap",   globalPropertyi},
    {"bkk_on_cap",      "tu154ce/switchers/ovhd/bkk_on_cap",      globalPropertyi},
    {"sau_stu_cap",     "tu154ce/switchers/ovhd/sau_stu_cap",     globalPropertyi},
    {"pkp_left_cap",    "tu154ce/switchers/ovhd/pkp_left_cap",    globalPropertyi},
    {"pkp_right_cap",   "tu154ce/switchers/ovhd/pkp_right_cap",   globalPropertyi},
    {"mgv_contr_cap",   "tu154ce/switchers/ovhd/mgv_contr_cap",   globalPropertyi},
    {"emerg_light_cap", "tu154ce/switchers/ovhd/emerg_light_cap", globalPropertyi},
    -- Misc & status
    {"frame_time",      "tu154ce/time/frame_time",                globalPropertyf},
    {"eng1_N1",         "sim/flightmodel/engine/ENGN_N1_[0]",     globalPropertyf},
    {"eng2_N1",         "sim/flightmodel/engine/ENGN_N1_[1]",     globalPropertyf},
    {"eng3_N1",         "sim/flightmodel/engine/ENGN_N1_[2]",     globalPropertyf},
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

