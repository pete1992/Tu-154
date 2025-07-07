-- antiice_panel.lua (optimized)
-- Panel logic for anti-ice controls, lamps, and gauges

-- Helper: define multiple props in batches
definePropertyBatch = function(names, getter)
    for _, name in ipairs(names) do defineProperty(name, getter(name)) end
end

-- Controls
local ctrl_defs = {
    {"soi21_on","tu154ce/switchers/eng/soi21_on",globalPropertyi},
    {"soi21_test","tu154ce/buttons/eng/soi21_test",globalPropertyi},
    {"antiice_slats","tu154ce/switchers/eng/antiice_slats",globalPropertyi},
    {"antiice_eng_1","tu154ce/switchers/eng/antiice_eng_1",globalPropertyi},
    {"antiice_eng_2","tu154ce/switchers/eng/antiice_eng_2",globalPropertyi},
    {"antiice_eng_3","tu154ce/switchers/eng/antiice_eng_3",globalPropertyi},
    {"antiice_wing","tu154ce/switchers/eng/antiice_wing",globalPropertyi},
    {"window_heat_1","tu154ce/switchers/ovhd/window_heat_1",globalPropertyi},
    {"window_heat_2","tu154ce/switchers/ovhd/window_heat_2",globalPropertyi},
    {"window_heat_3","tu154ce/switchers/ovhd/window_heat_3",globalPropertyi},
    {"pitot_heat_1","tu154ce/switchers/ovhd/pitot_heat_1",globalPropertyi},
    {"pitot_heat_2","tu154ce/switchers/ovhd/pitot_heat_2",globalPropertyi},
    {"pitot_heat_3","tu154ce/switchers/ovhd/pitot_heat_3",globalPropertyi}
}
for _, d in ipairs(ctrl_defs) do defineProperty(d[1], d[3](d[2])) end

-- Lamps
local lamp_defs = {
    {"heat_ok_1","tu154ce/lights/small/heat_ok_1"},
    {"heat_ok_2","tu154ce/lights/small/heat_ok_2"},
    {"heat_ok_3","tu154ce/lights/small/heat_ok_3"},
    {"soi_work","tu154ce/lights/small/soi_work"},
    {"soi_ice_detected","tu154ce/lights/small/soi_ice_detected"},
    {"antiice_slats_lamp","tu154ce/lights/small/antiice_slats"},
    {"antiice_eng_1_lamp","tu154ce/lights/small/antiice_eng_1"},
    {"antiice_eng_2_lamp","tu154ce/lights/small/antiice_eng_2"},
    {"antiice_eng_3_lamp","tu154ce/lights/small/antiice_eng_3"},
    {"antiice_wings_lamp","tu154ce/lights/small/antiice_wings"}
}
for _, l in ipairs(lamp_defs) do defineProperty(l[1], globalPropertyf(l[2])) end

-- Gauges & sources
defineProperty("stab_temp",     globalPropertyf("tu154ce/gauges/eng/stab_temp"))
defineProperty("wing_temp",     globalPropertyf("tu154ce/gauges/eng/wing_temp"))
defineProperty("wing_heat_t",   globalPropertyf("tu154ce/antiice/wing_heat_t"))
defineProperty("stab_heat_t",   globalPropertyf("tu154ce/antiice/stab_heat_t"))
-- Power and detection
defineProperty("bus27_L",       globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_R",       globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("ice_inlet_1",   globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]"))
defineProperty("ice_inlet_2",   globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[1]"))
defineProperty("ice_inlet_3",   globalProperty("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[2]"))
defineProperty("eng_heat_open_1",globalPropertyi("tu154ce/antiice/eng_heat_open_1"))
defineProperty("eng_heat_open_2",globalPropertyi("tu154ce/antiice/eng_heat_open_2"))
defineProperty("eng_heat_open_3",globalPropertyi("tu154ce/antiice/eng_heat_open_3"))
defineProperty("ice_surf_heat_on",globalPropertyi("sim/cockpit2/ice/ice_surfce_heat_on"))
defineProperty("ice_detected",   globalPropertyi("tu154ce/antiice/ice_detected"))
defineProperty("ice_detect_ok",  globalPropertyi("tu154ce/antiice/ice_detect_ok"))
defineProperty("ppd_fail3",     globalPropertyi("tu154ce/antiice/ppd_3_heat_fail"))
defineProperty("fail_pitot1",   globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1"))
defineProperty("fail_pitot2",   globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2"))
defineProperty("eng1_N1",       globalProperty("sim/flightmodel/engine/ENGN_N1_[0]"))
defineProperty("eng2_N1",       globalProperty("sim/flightmodel/engine/ENGN_N1_[1]"))
defineProperty("eng3_N1",       globalProperty("sim/flightmodel/engine/ENGN_N1_[2]"))
defineProperty("frame_time",    globalPropertyf("tu154ce/time/frame_time"))

include("smooth_light.lua")
local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')

-- State snapshot for controls and sims
local prev = {}
for _, d in ipairs(ctrl_defs) do prev[d[1]] = get(_G[d[1]]) end
local sim_start_t = 0

-- Clamp and smooth alias
local clamp = function(v,a,b) return v<a and a or v>b and b or v end

-- Reset switches on cold & dark\local function reset_switchers()
    for _, d in ipairs(ctrl_defs) do set(_G[d[1]], 0) end
end

-- Update gauge needles with smoothing
local function update_gauges(dt)
    local stab_t = get(stab_heat_t)
    local wing_t = get(wing_heat_t)
    local s = get(stab_temp); set(stab_temp, s + (stab_t - s)*dt*5)
    local w = get(wing_temp); set(wing_temp, w + (wing_t - w)*dt*5)
end

-- Play switch/button sounds on change
local function handle_sounds()
    for _, d in ipairs(ctrl_defs) do
        local cur = get(_G[d[1]]);
        if cur ~= prev[d[1]] then playSample(switch_sound, false) end
        prev[d[1]] = cur
    end
    local test_cur = get(soi21_test)
    if test_cur ~= prev.soi21_test then playSample(button_sound, false) end
    prev.soi21_test = test_cur
end

-- Update indicator lamps
local function update_lamps(dt)
    local bus_brt = clamp((math.max(get(bus27_L),get(bus27_R))-10)/18.5,0,1)
    -- pitot heat OK lamps
    local ok1 = (get(fail_pitot1)==0 and get(pitot_heat_1)==-1) and bus_brt or 0
    set(heat_ok_1, smooth_light(ok1, get(heat_ok_1)))
    local ok2 = (get(fail_pitot2)==0 and get(pitot_heat_2)==-1) and bus_brt or 0
    set(heat_ok_2, smooth_light(ok2, get(heat_ok_2)))
    local ok3 = (get(ppd_fail3)==0 and get(pitot_heat_3)==-1) and bus_brt or 0
    set(heat_ok_3, smooth_light(ok3, get(heat_ok_3)))
    -- soi status lamps
    set(soi_work, smooth_light(get(ice_detect_ok)*bus_brt, get(soi_work)))
    set(soi_ice_detected, smooth_light(get(ice_detected)*bus_brt, get(soi_ice_detected)))
    -- anti-ice switches lamps
    set(antiice_slats_lamp, smooth_light(get(slat_heating)*bus_brt, get(antiice_slats_lamp)))
    set(antiice_eng_1_lamp, smooth_light(get(eng_heat_open_1)==1 and bus_brt or 0, get(antiice_eng_1_lamp)))
    set(antiice_eng_2_lamp, smooth_light(get(eng_heat_open_2)==1 and bus_brt or 0, get(antiice_eng_2_lamp)))
    set(antiice_eng_3_lamp, smooth_light(get(eng_heat_open_3)==1 and bus_brt or 0, get(antiice_eng_3_lamp)))
    set(antiice_wings_lamp, smooth_light(get(wing_heating)*bus_brt, get(antiice_wings_lamp)))
end

-- Main update\ nfunction update()
    local dt = get(frame_time)
    sim_start_t = sim_start_t + dt
    if sim_start_t>0.3 then reset_switchers() end
    handle_sounds()
    update_gauges(dt)
    update_lamps(dt)
end
