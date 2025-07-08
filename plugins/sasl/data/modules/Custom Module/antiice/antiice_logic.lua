-- antiice_logic.lua Bug fixed
-- Handles ice detection, window/pitot/engine/wing anti-ice logic

-- Controls and DataRefs
defineProperty("soi21_on",       globalPropertyi("tu154ce/switchers/eng/soi21_on"))
defineProperty("soi21_test",     globalPropertyi("tu154ce/buttons/eng/soi21_test"))
defineProperty("antiice_slats",  globalPropertyi("tu154ce/switchers/eng/antiice_slats"))
defineProperty("antiice_eng",    globalPropertyi("tu154ce/switchers/eng/antiice_eng_1")) -- unified engine anti-ice
defineProperty("antiice_wing",   globalPropertyi("tu154ce/switchers/eng/antiice_wing"))
defineProperty("window_heat_sw", globalPropertyi("tu154ce/switchers/ovhd/window_heat_1")) -- unified window heat
defineProperty("pitot_heat_1",   globalPropertyi("tu154ce/switchers/ovhd/pitot_heat_1")) -- pitot heat switch 1
defineProperty("rel_ice_inlet_heat1", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat1")) -- failure for inlet heat
defineProperty("ai_27_L_cc",     globalPropertyf("tu154ce/antiice/ai_27_L_cc")) -- current draw
-- Power busses
defineProperty("bus27_L",       globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_R",       globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("bus115_1",      globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("bus115_2",      globalPropertyf("tu154ce/elec/bus115_2_volt"))
defineProperty("bus115_3",      globalPropertyf("tu154ce/elec/bus115_3_volt"))
-- Environmental & sensors
defineProperty("window_ice",    globalPropertyf("sim/flightmodel/failures/window_ice"))
defineProperty("out_temp",      globalPropertyf("sim/weather/temperature_ambient_c"))
defineProperty("ias",           globalPropertyf("sim/flightmodel/position/indicated_airspeed"))
defineProperty("frame_time",    globalPropertyf("tu154ce/time/frame_time"))
defineProperty("rpm",           globalPropertyf("tu154ce/gauges/engine/rpm_high_1"))
defineProperty("rio_fail",      globalPropertyi("tu154ce/failures/rio_fail"))
-- Failures
defineProperty("fail_window1",  globalPropertyi("tu154ce/failures/window_heat_fail_1"))
defineProperty("fail_pitot3",   globalPropertyi("tu154ce/antiice/ppd_3_heat_fail"))
-- Detection & result props
defineProperty("ice_detected",  globalPropertyi("tu154ce/antiice/ice_detected"))
defineProperty("ice_ok",        globalPropertyi("tu154ce/antiice/ice_detect_ok"))
defineProperty("ice_win_heat",  globalPropertyi("sim/cockpit2/ice/ice_window_heat_on"))
defineProperty("win_ice_anim",  globalPropertyf("tu154ce/anim/window_ice_1"))
defineProperty("inlet_heat",    globalPropertyi("sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]"))
defineProperty("pitot_heat",    globalPropertyi("sim/cockpit2/ice/ice_pitot_heat_on_pilot"))
defineProperty("AOA_heat",      globalPropertyi("sim/cockpit2/ice/ice_AOA_heat_on"))
defineProperty("surf_heat",     globalPropertyi("sim/cockpit2/ice/ice_surfce_heat_on"))
defineProperty("wing_heat_cc",  globalPropertyf("tu154ce/antiice/ai_115_2_cc"))
defineProperty("wing_t",        globalPropertyf("tu154ce/antiice/wing_heat_t"))
defineProperty("stab_t",        globalPropertyf("tu154ce/antiice/stab_heat_t"))
defineProperty("frm_ice_L",     globalPropertyf("sim/flightmodel/failures/frm_ice"))
defineProperty("frm_ice_R",     globalPropertyf("sim/flightmodel/failures/frm_ice2"))

-- Helpers
local function bool(v) return v and 1 or 0 end
local function clamp(v,a,b) return v<a and a or v>b and b or v end

-- State
local last_ice = get(window_ice)
local ice_speed = 0
local timer_detect = 0
local timer_ok     = 150

function update()
    local dt = get(frame_time)
    local master = get(globalPropertyf("scp/api/ismaster"))~=1
    -- Sync ice in multiplayer (slave)
    if master then set(window_ice, get(globalPropertyf("sim/weather/precipitation_on_aircraft_ratio"))) end
    local ice = get(window_ice)
    ice_speed = master and (ice - last_ice) / dt * 0.5 or ice_speed
    last_ice = ice

    -- SOI21 (ice detection and test)
    if get(soi21_on) == 1 and get(bus27_L) > 13 and get(bus27_R) > 13 and get(rio_fail) ~= 1 then
        if ice_speed > 0 or get(soi21_test) == 1 then timer_detect = 0 else timer_detect = timer_detect + dt end
        if get(soi21_test) == 1 then timer_ok = 0 else timer_ok = timer_ok + dt end
        set(ice_ok, bool(timer_ok > 30 and timer_ok < 55))
        set(ice_detected, bool(timer_detect < 8))
    else
        timer_detect = 20; timer_ok = 150
        set(ice_ok, 0); set(ice_detected, 0)
    end

    -- Window heat logic
    local w_sw = get(window_heat_sw)
    local spd = 0
    if w_sw ~= 0 and get(bus27_L) > 13 and get(bus115_1) > 110 then
        spd = (w_sw == 1 and 0.02 or 0.015) * (1 - get(fail_window1))
    end
    local anim = clamp(get(win_ice_anim) + (ice_speed - spd - math.max(get(out_temp), 0)) * dt, 0, 1)
    set(win_ice_anim, anim)
    set(ice_win_heat, bool(spd > 0))

    -- Pitot and AOA heat
    local p1 = clamp(get(pitot_heat_1) * bool(get(globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1")) ~= 6), 0, 1)
    set(pitot_heat, p1)
    set(AOA_heat, p1)
    set(ai_27_L_cc, 10 * p1)

    -- Inlet heat logic
    local eng1 = bool(get(rel_ice_inlet_heat1) ~= 6 and get(rpm) > 50 and get(antiice_eng) == 1)
    set(inlet_heat, eng1)
    set(globalPropertyi("tu154ce/antiice/eng_heat_open_1"), eng1)

    -- Wing & slat heating
    local wh = bool((get(rpm) > 50) and (get(bus27_L) > 13 or get(bus27_R) > 13)) * get(antiice_wing)
    local sh = bool(get(bus115_2) > 110 and wh and get(antiice_slats) == 1)
    set(surf_heat, wh)
    set(globalPropertyi("tu154ce/antiice/slat_heating"), sh)
    set(wing_heat_cc, sh * 70)

    -- Wing/stab temperatures
    local ot, as = get(out_temp), get(ias)
    local wt = get(wing_t) + (ot - get(wing_t)) * dt * 0.1 * (1 + as / 200) + (wh * 300 - get(wing_t)) * dt * 0.1
    local st = get(stab_t) + (ot - get(stab_t)) * dt * 0.1 * (1 + as / 300) + (wh * 300 - get(stab_t)) * dt * 0.1
    set(wing_t, wt)
    set(stab_t, st)

    -- Frame ice accumulation
    local accum = (ice_speed * math.random() * 2 - wt * 0.0005) * dt
    local accumR = (ice_speed * math.random() * 2 - sh * 0.02) * dt
    set(frm_ice_L, clamp(get(frm_ice_L) + accum, 0, 1))
    set(frm_ice_R, clamp(get(frm_ice_R) + accumR, 0, 1))
end
