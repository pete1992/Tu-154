-- flight_controls_panel.lua
-- Tu-154M Flight Controls Panel – switch, lamp, gauge, and status DataRefs

-- Batch‐define helper
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- All DataRef definitions in one go
defineProps({
    -- Controls
    {"stab_man_cap","tu154ce/controll/stab_man_cap",globalPropertyi},
    {"stab_manual","tu154ce/controll/stab_manual",globalPropertyi},
    {"stab_setting","tu154ce/controll/stab_setting",globalPropertyi},
    {"ail_trimm_sw","tu154ce/controll/ail_trimm_sw",globalPropertyi},
    {"rudd_trimm_sw","tu154ce/controll/rudd_trimm_sw",globalPropertyi},
    {"contr_force_cap","tu154ce/controll/contr_force_cap",globalPropertyi},
    {"contr_force_set","tu154ce/controll/contr_force_set",globalPropertyi},
    {"nosewheel_turn_enable","tu154ce/switchers/nosewheel_turn_enable",globalPropertyi},
    {"nosewheel_turn_sel","tu154ce/switchers/nosewheel_turn_sel",globalPropertyi},
    {"nosewheel_turn_cap","tu154ce/switchers/nosewheel_turn_cap",globalPropertyi},
    {"slat_man","tu154ce/switchers/slat_man",globalPropertyi},
    {"slat_man_cap","tu154ce/switchers/slat_man_cap",globalPropertyi},
    {"flaps_sel","tu154ce/switchers/flaps_sel",globalPropertyi},
    {"flaps_sel_cap","tu154ce/switchers/flaps_sel_cap",globalPropertyi},
    {"gears_retr_lock","tu154ce/switchers/gears_retr_lock",globalPropertyi},
    {"gears_retr_lock_cap","tu154ce/switchers/gears_retr_lock_cap",globalPropertyi},
    {"gears_ext_3GS","tu154ce/switchers/gears_ext_3GS",globalPropertyi},
    {"gears_ext_3GS_cap","tu154ce/switchers/gears_ext_3GS_cap",globalPropertyi},
    {"buster_on_1","tu154ce/switchers/console/buster_on_1",globalPropertyi},
    {"buster_on_2","tu154ce/switchers/console/buster_on_2",globalPropertyi},
    {"buster_on_3","tu154ce/switchers/console/buster_on_3",globalPropertyi},
    {"busters_cap","tu154ce/switchers/console/busters_cap",globalPropertyi},
    {"elev_trimm_switcher","tu154ce/controll/elev_trimm_switcher",globalPropertyi},
    {"emerg_elev_trimm","tu154ce/switchers/console/emerg_elev_trimm",globalPropertyi},
    {"emerg_elev_trimm_cap","tu154ce/switchers/console/emerg_elev_trimm_cap",globalPropertyi},
    {"lamp_test","tu154ce/buttons/lamp_test_front",globalPropertyi},
    {"lamp_test_eng","tu154ce/buttons/lamp_test_upper_gear",globalPropertyi},
    {"flaps_lever","tu154ce/controll/flaps_lever",globalPropertyf},
    {"gear_lever","tu154ce/controll/gear_lever",globalPropertyi},
    -- Animations
    {"anim_rud1","tu154ce/controlls/throttle_1",globalPropertyf},
    {"anim_rud2","tu154ce/controlls/throttle_2",globalPropertyf},
    {"anim_rud3","tu154ce/controlls/throttle_3",globalPropertyf},
    -- Indicators
    {"stab_ind","tu154ce/gauges/misc/stab_ind",globalPropertyf},
    {"elevator_ind","tu154ce/gauges/misc/elevator_ind",globalPropertyf},
    {"flap_left_ind","tu154ce/gauges/misc/flap_left_ind",globalPropertyf},
    {"flap_right_ind","tu154ce/gauges/misc/flap_right_ind",globalPropertyf},
    {"stab_work","tu154ce/lights/stab_work",globalPropertyf},
    {"flaps_1_valve","tu154ce/lights/flaps_1_valve",globalPropertyf},
    {"slats_extended","tu154ce/lights/slats_extended",globalPropertyf},
    {"flaps_unsync","tu154ce/lights/flaps_unsync",globalPropertyf},
    {"slats_unsync","tu154ce/lights/slats_unsync",globalPropertyf},
    {"to_rudder","tu154ce/lights/to_rudder",globalPropertyf},
    {"to_elevator","tu154ce/lights/to_elevator",globalPropertyf},
    {"trimm_zero_course","tu154ce/lights/trimm_zero_course",globalPropertyf},
    {"trimm_zero_roll","tu154ce/lights/trimm_zero_roll",globalPropertyf},
    {"trimm_zero_pitch","tu154ce/lights/trimm_zero_pitch",globalPropertyf},
    {"gears_not_ext","tu154ce/lights/gears_not_ext",globalPropertyf},
    {"gears_red_left","tu154ce/lights/gears_red_left",globalPropertyf},
    {"gears_red_front","tu154ce/lights/gears_red_front",globalPropertyf},
    {"gears_red_right","tu154ce/lights/gears_red_right",globalPropertyf},
    {"gears_green_left","tu154ce/lights/gears_green_left",globalPropertyf},
    {"gears_green_front","tu154ce/lights/gears_green_front",globalPropertyf},
    {"gears_green_right","tu154ce/lights/gears_green_right",globalPropertyf},
    {"gears_red_left_eng","tu154ce/lights/gears_red_left_eng",globalPropertyf},
    {"gears_red_front_eng","tu154ce/lights/gears_red_front_eng",globalPropertyf},
    {"gears_red_right_eng","tu154ce/lights/gears_red_right_eng",globalPropertyf},
    {"gears_green_left_eng","tu154ce/lights/gears_green_left_eng",globalPropertyf},
    {"gears_green_front_eng","tu154ce/lights/gears_green_front_eng",globalPropertyf},
    {"gears_green_right_eng","tu154ce/lights/gears_green_right_eng",globalPropertyf},
    {"main_gear_flaps","tu154ce/alarm/main_gear_flaps",globalPropertyi},
    -- Surfaces
    {"elevator_L","sim/flightmodel/controls/hstab1_elv1def",globalPropertyf},
    {"elevator_R","sim/flightmodel/controls/hstab2_elv1def",globalPropertyf},
    {"stab_pos","sim/flightmodel2/controls/elevator_trim",globalPropertyf},
    {"flap_inn_L","sim/flightmodel/controls/wing1l_fla1def",globalPropertyf},
    {"flap_inn_R","sim/flightmodel/controls/wing1r_fla1def",globalPropertyf},
    {"slats","sim/flightmodel2/controls/slat1_deploy_ratio",globalPropertyf},
    -- Power & time
    {"bus27_volt_left","tu154ce/elec/bus27_volt_left",globalPropertyf},
    {"bus27_volt_right","tu154ce/elec/bus27_volt_right",globalPropertyf},
    {"bus115_1_volt","tu154ce/elec/bus115_1_volt",globalPropertyf},
    {"bus36_volt_left","tu154ce/elec/bus36_volt_left",globalPropertyf},
    {"bus36_volt_right","tu154ce/elec/bus36_volt_right",globalPropertyf},
    {"indicated_airspeed","sim/flightmodel/position/indicated_airspeed",globalPropertyf},
    {"machno","sim/flightmodel/position/machno",globalPropertyf},
    {"frame_time","tu154ce/time/frame_time",globalPropertyf},
    -- SmartCopilot
    {"ismaster","scp/api/ismaster",globalPropertyf},
    {"hascontrol_1","scp/api/hascontrol_1",globalPropertyf},
})
include("smooth_light.lua")

-- Locals for speed
local get, set = get, set
local smooth, abs, max, min = smooth_light, math.abs, math.max, math.min
local play = playSample
local rnd = math.random
-- Preload sounds
local cap_snd   = loadSample('Custom Sounds/cap.wav')
local switch_snd= loadSample('Custom Sounds/metal_switch.wav')
local test_snd  = loadSample('Custom Sounds/plastic_switch.wav')

-- Helper: Brightness base (bus27 + dim + test + day/night)
local function baseBrt(test_btn)
    local dim = max((max(get("bus27_volt_left"),get("bus27_volt_right"))-10)/18.5,0)
    local dn  = 1 - get("day_night_set")*0.8
    return dim*dn + (get(test_btn) and dim or 0)
end
-- State tables
local switchCaps = {
    "stab_man_cap","contr_force_cap","nosewheel_turn_cap","slat_man_cap",
    "gears_retr_lock_cap","gears_ext_3GS_cap","busters_cap",
    "flaps_sel_cap","emerg_elev_trimm_cap"
}
local switchers = {
    "stab_manual","stab_setting","ail_trimm_sw","rudd_trimm_sw",
    "contr_force_set","nosewheel_turn_enable","nosewheel_turn_sel",
    "slat_man","flaps_sel","gears_retr_lock","gears_ext_3GS",
    "buster_on_1","buster_on_2","buster_on_3","emerg_elev_trimm"
}
local lastCap, lastSwitch = {}, {}
for _, k in ipairs(switchCaps) do lastCap[k]=get(k) end
for _, k in ipairs(switchers ) do lastSwitch[k]=get(k) end

-- Reset under switch caps once on ground
local loaded, timer = false, 0
local function tryReset(dt)
    if not loaded then
        timer = timer + dt
        if timer>0.3 and get("eng1_N1")<5 and get("eng2_N1")<5 and get("eng3_N1")<5 then
            set("buster_on_1",0); set("buster_on_2",0); set("buster_on_3",0)
            set("busters_cap",1)
            set("nosewheel_turn_sel",1); set("nosewheel_turn_cap",1)
            loaded=true
        end
    end
end
-- Sound on cap/switch toggle
local function checkCaps()
    for _, k in ipairs(switchCaps) do
        local cur=get(k)
        if cur~=lastCap[k] then play(cap_snd,false) end
        lastCap[k]=cur
    end
end
local function checkSwitches()
    for _, k in ipairs(switchers) do
        local cur=get(k)
        if cur~=lastSwitch[k] then play(switch_snd,false) end
        lastSwitch[k]=cur
    end
end
-- Lamp definitions for Tu-154M control panel
local lampDefs = {
    -- Stab/Flap/Slat indicators
    { out="stab_work",        test="lamp_test",     cond=function(dt) return math.abs(get("stab_pos") - prev.stab_pos) > dt*0.01 end },
    { out="flaps_1_valve",    test="lamp_test",     cond=function()   return get("flap_inn_L") ~= prev.flap_inn_L end },
    { out="flaps_2_valve",    test="lamp_test",     cond=function()   return get("flap_inn_R") ~= prev.flap_inn_R end },
    { out="flaps_unsync",     test="lamp_test",     cond=function()   return math.abs(get("flap_inn_L") - get("flap_inn_R")) >= 3 end },
    { out="slats_unsync",     test="lamp_test",     cond=function()   return false end }, -- Placeholder, customize as needed
    { out="slats_extended",   test="lamp_test",     cond=function()   return get("slats") > 0.1 end },
    -- Spoiler lamps (on if >0 deflection)
    { out="spoilers_mid_left",  test="lamp_test",   cond=function()   return get("spd_brk_mid_L") > 0 end },
    { out="spoilers_mid_right", test="lamp_test",   cond=function()   return get("spd_brk_mid_R") > 0 end },
    { out="spoilers_inn_left",  test="lamp_test",   cond=function()   return get("spd_brk_inn_L") > 0 end },
    { out="spoilers_inn_right", test="lamp_test",   cond=function()   return get("spd_brk_inn_R") > 0 end },
    -- Gear and sync lamps (cockpit & engine panel)
    { out="gears_not_ext",     test="lamp_test_eng", cond=function()
        local F,L,R = get("gear1_deploy"), get("gear2_deploy"), get("gear3_deploy")
        local ia = get("indicated_airspeed")*1.852
        return (F<.99 or L<.99 or R<.99) and ia<325 end },
    { out="gears_red_left",    test="lamp_test",   cond=function() local L=get("gear2_deploy") return L<.99 and L>.01 end },
    { out="gears_red_front",   test="lamp_test",   cond=function() local F=get("gear1_deploy") return F<.99 and F>.01 end },
    { out="gears_red_right",   test="lamp_test",   cond=function() local R=get("gear3_deploy") return R<.99 and R>.01 end },
    { out="gears_green_left",  test="lamp_test",   cond=function() return get("gear2_deploy") >= .99 end },
    { out="gears_green_front", test="lamp_test",   cond=function() return get("gear1_deploy") >= .99 end },
    { out="gears_green_right", test="lamp_test",   cond=function() return get("gear3_deploy") >= .99 end },
    { out="gears_red_left_eng",  test="lamp_test_eng", cond=function() local L=get("gear2_deploy") return L<.99 and L>.01 end },
    { out="gears_red_front_eng", test="lamp_test_eng", cond=function() local F=get("gear1_deploy") return F<.99 and F>.01 end },
    { out="gears_red_right_eng", test="lamp_test_eng", cond=function() local R=get("gear3_deploy") return R<.99 and R>.01 end },
    { out="gears_green_left_eng",test="lamp_test_eng", cond=function() return get("gear2_deploy") >= .99 end },
    { out="gears_green_front_eng",test="lamp_test_eng",cond=function() return get("gear1_deploy") >= .99 end },
    { out="gears_green_right_eng",test="lamp_test_eng",cond=function() return get("gear3_deploy") >= .99 end },
    -- Takeoff/trim indicators
    { out="to_rudder",         test="lamp_test",   cond=function() local p=get("control_force_pos_rud") return p>0 and p<1 end },
    { out="to_elevator",       test="lamp_test",   cond=function() local p=get("control_force_pos")     return p>0 and p<1 end },
    { out="trimm_zero_course", test="lamp_test",   cond=function() return math.abs(get("int_yaw_trim"))   < 0.002 end },
    { out="trimm_zero_roll",   test="lamp_test",   cond=function() return math.abs(get("int_roll_trim"))  < 0.002 end },
    { out="trimm_zero_pitch",  test="lamp_test",   cond=function() return math.abs(get("int_pitch_trim")) < 0.004 end },
    -- Main gear/flap warning lamp (alarm)
    { out="main_gear_flaps",   test="lamp_test_eng", cond=function()
        local F,L,R = get("gear1_deploy"),get("gear2_deploy"),get("gear3_deploy")
        local ia = get("indicated_airspeed")*1.852
        local th = math.max(get("anim_rud1"),get("anim_rud2"),get("anim_rud3"))
        local def = math.max(get("deflection_mtr_2"),get("deflection_mtr_3"))
        return (F<14 or L<14 or R<14) and th>.7 and def>.05 end },
}
-- Blink state
local blinkTimers, blinkStates = {}, {}
for _, d in ipairs(lampDefs) do
    blinkTimers[d.out] = 0
    blinkStates[d.out] = false
end
-- Previous values for change detection
local prev = {
    stab_pos    = get("stab_pos"),
    flap_inn_L  = get("flap_inn_L"),
    flap_inn_R  = get("flap_inn_R")
}
-- Update lamps each frame
local function updateLamps(dt)
    -- brightness and test multipliers
    local dim = math.max((math.max(get("bus27_volt_left"), get("bus27_volt_right")) - 10)/18.5, 0)
    local dn  = 1 - get("day_night_set") * 0.8
    local lamps_brt = dim * dn
    local test_brt = get("lamp_test") * lamps_brt
    local test_eng = get("lamp_test_eng") * lamps_brt

    for _, d in ipairs(lampDefs) do
        -- blink logic
        if d.cond(dt) then
            blinkTimers[d.out] = blinkTimers[d.out] + dt
            if blinkTimers[d.out] > 0.5 then
                blinkTimers[d.out] = 0
                blinkStates[d.out] = not blinkStates[d.out]
            end
        else
            blinkTimers[d.out] = 0
            blinkStates[d.out] = false
        end
        -- choose test brightness
        local btn = (d.test == "lamp_test_eng") and test_eng or test_brt
        -- target brightness
        local tgt = (blinkStates[d.out] and 1 or 0) * btn
        -- set smoothed light
        set(d.out, smooth_light(tgt, get(d.out)))
    end
    -- save previous for next frame
    prev.stab_pos   = get("stab_pos")
    prev.flap_inn_L = get("flap_inn_L")
    prev.flap_inn_R = get("flap_inn_R")
end
-- Gauge smoothing
local gaugeTbl = {
    {out="stab_ind", expr=function() return get("stab_pos")*5.5 end},
    {out="elevator_ind", expr=function() return -get("elevator_L") end},
    {out="flap_left_ind", expr=function() return get("flap_inn_L") end},
    {out="flap_right_ind",expr=function() return get("flap_inn_R") end},
}
local gaugeState = {}
for _, g in ipairs(gaugeTbl) do gaugeState[g.out]=0 end

local machTbl = {
    {-10,1},{0,1},{0.1,1},{0.25,0.5},{0.34,0.28},{0.38,0.22},
    {0.5,0.21},{0.6,0.21},{0.7,0.2},{0.8,0.19},{0.9,0.13},{1,0.1},{10,0.1}
}
local function interp(tbl,x)
    for i=2,#tbl do local x0,y0=tbl[i-1][1],tbl[i-1][2]; local x1,y1=tbl[i][1],tbl[i][2]
        if x<=x1 then local t=(x-x0)/(x1-x0); return y0+(y1-y0)*t end
    end
    return tbl[#tbl][2]
end
local function updateGauges(dt)
    local ia=get("indicated_airspeed")*1.852
    local mach=get("machno")
    local coef = 1/(mach<1 and interp(machTbl,mach) or 0.1)
    for _, g in ipairs(gaugeTbl) do
        local val = g.expr()
        if g.out=="elevator_ind" then val=val*coef end
        gaugeState[g.out] = gaugeState[g.out] + (val - gaugeState[g.out]) * dt * 10
        set(g.out, gaugeState[g.out])
    end
end
-- Main update
function update()
    local dt = get("frame_time")
    -- early exit
    if dt<=0 then return end

    tryReset(dt)
    checkCaps()
    checkSwitches()
    updateLamps(dt)
    updateGauges(dt)
end
