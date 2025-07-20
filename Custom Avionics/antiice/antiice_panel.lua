-- antiice_panel.lua

-- Helper to register DataRefs in batch
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register all panel DataRefs
defineProps({
    {"soi21_on",             "tu154ce/switchers/eng/soi21_on",                        globalPropertyi},
    {"soi21_test",           "tu154ce/buttons/eng/soi21_test",                         globalPropertyi},
    {"antiice_slats",        "tu154ce/switchers/eng/antiice_slats",                   globalPropertyi},
    {"antiice_eng_1",        "tu154ce/switchers/eng/antiice_eng_1",                   globalPropertyi},
    {"antiice_eng_2",        "tu154ce/switchers/eng/antiice_eng_2",                   globalPropertyi},
    {"antiice_eng_3",        "tu154ce/switchers/eng/antiice_eng_3",                   globalPropertyi},
    {"antiice_wing",         "tu154ce/switchers/eng/antiice_wing",                    globalPropertyi},
    {"window_heat_1",        "tu154ce/switchers/ovhd/window_heat_1",                  globalPropertyi},
    {"window_heat_2",        "tu154ce/switchers/ovhd/window_heat_2",                  globalPropertyi},
    {"window_heat_3",        "tu154ce/switchers/ovhd/window_heat_3",                  globalPropertyi},
    {"pitot_heat_1",         "tu154ce/switchers/ovhd/pitot_heat_1",                   globalPropertyi},
    {"pitot_heat_2",         "tu154ce/switchers/ovhd/pitot_heat_2",                   globalPropertyi},
    {"pitot_heat_3",         "tu154ce/switchers/ovhd/pitot_heat_3",                   globalPropertyi},
    {"heat_ok_1",            "tu154ce/lights/small/heat_ok_1",                        globalPropertyf},
    {"heat_ok_2",            "tu154ce/lights/small/heat_ok_2",                        globalPropertyf},
    {"heat_ok_3",            "tu154ce/lights/small/heat_ok_3",                        globalPropertyf},
    {"soi_work",             "tu154ce/lights/small/soi_work",                         globalPropertyf},
    {"soi_ice_detected",     "tu154ce/lights/small/soi_ice_detected",                 globalPropertyf},
    {"antiice_slats_lamp",   "tu154ce/lights/small/antiice_slats",                    globalPropertyf},
    {"antiice_eng_1_lamp",   "tu154ce/lights/small/antiice_eng_1",                    globalPropertyf},
    {"antiice_eng_2_lamp",   "tu154ce/lights/small/antiice_eng_2",                    globalPropertyf},
    {"antiice_eng_3_lamp",   "tu154ce/lights/small/antiice_eng_3",                    globalPropertyf},
    {"antiice_wings_lamp",   "tu154ce/lights/small/antiice_wings",                    globalPropertyf},
    {"stab_temp",            "tu154ce/gauges/eng/stab_temp",                          globalPropertyf},
    {"wing_temp",            "tu154ce/gauges/eng/wing_temp",                          globalPropertyf},
    {"wing_heat_t",          "tu154ce/antiice/wing_heat_t",                           globalPropertyf},
    {"stab_heat_t",          "tu154ce/antiice/stab_heat_t",                           globalPropertyf},
    {"bus27_volt_left",      "tu154ce/elec/bus27_volt_left",                          globalPropertyf},
    {"bus27_volt_right",     "tu154ce/elec/bus27_volt_right",                         globalPropertyf},
    {"ice_inlet_heat_1",     "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]",         globalPropertyi},
    {"ice_inlet_heat_2",     "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[1]",         globalPropertyi},
    {"ice_inlet_heat_3",     "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[2]",         globalPropertyi},
    {"eng_heat_open_1",      "tu154ce/antiice/eng_heat_open_1",                       globalPropertyi},
    {"eng_heat_open_2",      "tu154ce/antiice/eng_heat_open_2",                       globalPropertyi},
    {"eng_heat_open_3",      "tu154ce/antiice/eng_heat_open_3",                       globalPropertyi},
    {"ice_surfce_heat_on",   "sim/cockpit2/ice/ice_surfce_heat_on",                      globalPropertyi},
    {"ice_detected",         "tu154ce/antiice/ice_detected",                          globalPropertyi},
    {"ice_detect_ok",        "tu154ce/antiice/ice_detect_ok",                         globalPropertyi},
    {"ppd_3_heat_fail",      "tu154ce/antiice/ppd_3_heat_fail",                       globalPropertyi},
    {"rel_ice_window_heat",  "sim/operation/failures/rel_ice_window_heat",               globalPropertyi},
    {"rel_ice_inlet_heat1",  "sim/operation/failures/rel_ice_inlet_heat",               globalPropertyi},
    {"rel_ice_inlet_heat2",  "sim/operation/failures/rel_ice_inlet_heat2",              globalPropertyi},
    {"rel_ice_inlet_heat3",  "sim/operation/failures/rel_ice_inlet_heat3",              globalPropertyi},
    {"rel_ice_pitot_heat1",  "sim/operation/failures/rel_ice_pitot_heat1",              globalPropertyi},
    {"rel_ice_pitot_heat2",  "sim/operation/failures/rel_ice_pitot_heat2",              globalPropertyi},
    {"rel_ice_surf_heat",    "sim/operation/failures/rel_ice_surf_heat",                globalPropertyi},
    {"rel_ice_surf_heat2",   "sim/operation/failures/rel_ice_surf_heat2",               globalPropertyi},
    {"wing_heating",         "tu154ce/antiice/wing_heating",                         globalPropertyi},
    {"slat_heating",         "tu154ce/antiice/slat_heating",                         globalPropertyi},
    {"eng1_N1",              "sim/flightmodel/engine/ENGN_N1_[0]",                      globalPropertyf},
    {"eng2_N1",              "sim/flightmodel/engine/ENGN_N1_[1]",                      globalPropertyf},
    {"eng3_N1",              "sim/flightmodel/engine/ENGN_N1_[2]",                      globalPropertyf},
    {"frame_time",           "tu154ce/time/frame_time",                              globalPropertyf},
})

-- Load click and switch sounds
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound   = loadSample('Custom Sounds/plastic_btn.wav')

-- Local state
local notLoaded       = true
local sim_start_timer = 0
local stab_temp_act, wing_temp_act = 0, 0

-- Cache last switch positions
local lastStates = {
    soi21_on        = get(soi21_on),
    soi21_test      = get(soi21_test),
    antiice_slats   = get(antiice_slats),
    antiice_eng_1   = get(antiice_eng_1),
    antiice_eng_2   = get(antiice_eng_2),
    antiice_eng_3   = get(antiice_eng_3),
    antiice_wing    = get(antiice_wing),
    window_heat_1   = get(window_heat_1),
    window_heat_2   = get(window_heat_2),
    window_heat_3   = get(window_heat_3),
    pitot_heat_1    = get(pitot_heat_1),
    pitot_heat_2    = get(pitot_heat_2),
    pitot_heat_3    = get(pitot_heat_3),
}

-- Reset all switches when engines are off
local function resetSwitchers()
    if get(eng1_N1) < 5 and get(eng2_N1) < 5 and get(eng3_N1) < 5 then
        for prop, _ in pairs(lastStates) do
            set(_G[prop], 0)
        end
        notLoaded = false
    end
end

-- Smoothly interpolate gauge temperatures
local function updateGauges(passed)
    local targetStab = get(stab_heat_t)
    local targetWing = get(wing_heat_t)
    stab_temp_act = stab_temp_act + (targetStab - stab_temp_act) * passed * 5
    wing_temp_act = wing_temp_act + (targetWing - wing_temp_act) * passed * 5
    set(stab_temp, stab_temp_act)
    set(wing_temp, wing_temp_act)
end

-- Play sounds on control changes
local function checkControls()
    local totalChange = 0
    for prop, last in pairs(lastStates) do
        local cur = get(_G[prop])
        totalChange = totalChange + (cur - last)
        lastStates[prop] = cur
    end
    if totalChange ~= 0 then playSample(switcher_sound, 0) end
    local curTest = get(soi21_test)
    if curTest ~= lastStates.soi21_test then
        playSample(button_sound, 0)
        lastStates.soi21_test = curTest
    end
end

-- Update lamp brightness based on bus voltage and status
local function updateLamps()
    local volt = math.max(get(bus27_volt_left), get(bus27_volt_right))
    local brt  = math.max((volt - 10) / 18.5, 0)
    set(heat_ok_1, (get(rel_ice_pitot_heat1) < 6 and get(pitot_heat_1) == -1) and brt or 0)
    set(heat_ok_2, (get(rel_ice_pitot_heat2) < 6 and get(pitot_heat_2) == -1) and brt or 0)
    set(heat_ok_3, (get(ppd_3_heat_fail) == 0 and get(pitot_heat_3) == -1) and brt or 0)
    set(soi_work,         get(ice_detect_ok) * brt)
    set(soi_ice_detected, get(ice_detected) * brt)
    set(antiice_slats_lamp, get(slat_heating) * brt)
    set(antiice_eng_1_lamp, get(eng_heat_open_1) == 1 and brt or 0)
    set(antiice_eng_2_lamp, get(eng_heat_open_2) == 1 and brt or 0)
    set(antiice_eng_3_lamp, get(eng_heat_open_3) == 1 and brt or 0)
    set(antiice_wings_lamp, get(wing_heating) * brt)
end

function update()
    local passed = get(frame_time)
    sim_start_timer = sim_start_timer + passed

    if sim_start_timer > 0.3 then
        if notLoaded then resetSwitchers() end
        checkControls()
    end

    updateGauges(passed)
    updateLamps()
end
