-- ext_anim.lua
-- Tu-154M external animation logic for X-Plane 12 / SASL 3.19+
-- Batch DataRef handling, safe array access, full compatibility
-- All array DataRefs accessed via helper functions

---------------------------------------------------------------------------
-- Utility: Clamp and Lerp
local function clamp(v, a, b) return v < a and a or v > b and b or v end
local function lerp(cur, tgt, rate, dt) return cur + (tgt - cur) * rate * dt end

-- Array DataRef safe access (SASL 3+, arrays must use helper!)
local function getArr(dref, idx)
    local v = get(dref)
    if type(v) == "table" then return v[idx+1] or 0 else return 0 end
end
local function setArr(dref, idx, value)
    local v = get(dref)
    if type(v) == "table" then v[idx+1] = value; set(dref, v) end
end

---------------------------------------------------------------------------
-- Batch DataRef definitions
local props = {
    -- Time, replay
    {"frame_time",     "tu154ce/time/frame_time",                 globalPropertyf},
    {"replay_mode",    "sim/operation/prefs/replay_mode",         globalPropertyi},
    -- Thrust reverser, gear, animation
    {"revers_L",       "tu154ce/controlls/revers_L",              globalPropertyf},
    {"revers_R",       "tu154ce/controlls/revers_R",              globalPropertyf},
    {"reverse_mid",    "tu154ce/anim/reverse_mid",                globalPropertyf},
    -- Gear anim
    {"front_pos",      "tu154ce/anim/lg/front_pos",               globalPropertyf},
    {"front_defl",     "tu154ce/anim/lg/front_defl",              globalPropertyf},
    {"front_turn",     "tu154ce/anim/lg/front_turn",              globalPropertyf},
    {"main_pos_left",  "tu154ce/anim/lg/main_pos_left",           globalPropertyf},
    {"main_rot_left",  "tu154ce/anim/lg/main_rot_left",           globalPropertyf},
    {"main_pos_right", "tu154ce/anim/lg/main_pos_right",          globalPropertyf},
    {"main_rot_right", "tu154ce/anim/lg/main_rot_right",          globalPropertyf},
    -- Eagle claw
    {"EC_L",           "sim/flightmodel2/gear/eagle_claw_angle_deg", globalPropertyf},
    {"EC_R",           "sim/flightmodel2/gear/eagle_claw_angle_deg", globalPropertyf},
    -- Deploy ratios (array)
    {"deploy_ratio_arr",   "sim/flightmodel2/gear/deploy_ratio",        globalPropertyf},
    -- Tire deflections (array)
    {"deflection_mtr_arr", "sim/flightmodel2/gear/tire_vertical_deflection_mtr", globalPropertyf},
    {"tire_steer_actual_arr", "sim/flightmodel2/gear/tire_steer_actual_deg", globalPropertyf},
    -- Control surface animation & flex
    {"rudder_anim",    "tu154ce/anim/rudder_anim",                 globalPropertyf},
    {"rudder_deflect", "sim/flightmodel/controls/vstab2_rud1def",  globalPropertyf},
    {"elev_anim_L",    "tu154ce/anim/elev_anim_L",                 globalPropertyf},
    {"elev_anim_R",    "tu154ce/anim/elev_anim_R",                 globalPropertyf},
    {"elevator_L",     "sim/flightmodel/controls/hstab1_elv1def",  globalPropertyf},
    {"elevator_R",     "sim/flightmodel/controls/hstab2_elv1def",  globalPropertyf},
    {"wing_flx_left",  "tu154ce/anim/wing_flx_left",               globalPropertyf},
    {"wing_flx_right", "tu154ce/anim/wing_flx_right",              globalPropertyf},
    {"wing_tip_defl_arr", "sim/flightmodel2/wing/wing_tip_deflection_deg", globalPropertyf},
    {"gforce",         "sim/flightmodel2/misc/gforce_normal",      globalPropertyf},
    {"m_fuel_arr",     "sim/flightmodel/weight/m_fuel",            globalPropertyf},
    {"ail_L",          "sim/flightmodel/controls/wing3l_ail1def",  globalPropertyf},
    {"ail_R",          "sim/flightmodel/controls/wing3r_ail1def",  globalPropertyf},
    -- Sliders (array)
    {"custom_slider_on_arr", "sim/cockpit2/switches/custom_slider_on", globalPropertyi},
    -- Doors/windows
    {"cockpit_window_left",  "tu154ce/anim/cockpit_window_left",   globalPropertyf},
    {"cockpit_window_right", "tu154ce/anim/cockpit_window_right",  globalPropertyf},
    {"cargo_1",        "tu154ce/anim/cargo_1",                     globalPropertyf},
    {"cargo_2",        "tu154ce/anim/cargo_2",                     globalPropertyf},
    {"pax_door_1",     "tu154ce/anim/pax_door_1",                  globalPropertyf},
    {"pax_door_2",     "tu154ce/anim/pax_door_2",                  globalPropertyf},
    {"pax_door_3",     "tu154ce/anim/pax_door_3",                  globalPropertyf},
    {"cockpit_door",   "tu154ce/anim/cockpit_door",                globalPropertyf},
    {"table_up_L",     "tu154ce/anim/table_up_L",                  globalPropertyf},
    {"table_up_R",     "tu154ce/anim/table_up_R",                  globalPropertyf},
    -- Wipers & electrical
    {"wiper_left",      "tu154ce/switchers/wiper_left",            globalPropertyi},
    {"wiper_right",     "tu154ce/switchers/wiper_right",           globalPropertyi},
    {"wiper_angle_left","tu154ce/anim/wiper_angle_left",           globalPropertyf},
    {"wiper_angle_right","tu154ce/anim/wiper_angle_right",         globalPropertyf},
    {"bus27_volt_left", "tu154ce/elec/bus27_volt_left",            globalPropertyf},
    {"bus27_volt_right","tu154ce/elec/bus27_volt_right",           globalPropertyf},
    {"bus115_1_volt",   "tu154ce/elec/bus115_1_volt",              globalPropertyf},
    {"bus115_3_volt",   "tu154ce/elec/bus115_3_volt",              globalPropertyf},
}

for _,p in ipairs(props) do defineProperty(p[1], p[3](p[2])) end

---------------------------------------------------------------------------
-- Constants
local MAX_TURN_SPEED = 40
local WIPER_AMPL = 62

local state = {
    gear_turn = 0,
    wing_act = {L = 0, R = 0},
    wiper_pos = {L = 0, R = 0},
    last_win = {L = get(cockpit_window_left), R = get(cockpit_window_right)},
}

---------------------------------------------------------------------------
-- GEAR ANIMATION LOGIC
local function animate_gear(dt)
    local GS = get(globalPropertyf("sim/flightmodel/position/groundspeed"))
    local def1 = getArr(deflection_mtr_arr, 0)
    local steer = clamp(getArr(tire_steer_actual_arr, 0) * (def1 > 0 and 1 or 0), -65, 65)
    state.gear_turn = lerp(state.gear_turn, steer, math.min(MAX_TURN_SPEED, math.abs(GS)+0.5 > 0.5 and math.abs(GS)+0.5 or 1), dt)
    set(front_turn, state.gear_turn)
    set(front_pos, getArr(deploy_ratio_arr, 0))
    set(front_defl, def1 * 10)
    local pL = getArr(deploy_ratio_arr, 1)
    local pR = getArr(deploy_ratio_arr, 2)
    local dL = getArr(deflection_mtr_arr, 1)
    local dR = getArr(deflection_mtr_arr, 2)
    set(main_pos_left, pL < 0.999 and pL or -dL*10-1)
    set(main_pos_right, pR < 0.999 and pR or -dR*10-1)
    set(main_rot_left, pL < 0.9 and -11 or getArr(EC_L, 1)) -- EC_L[1] = left
    set(main_rot_right, pR < 0.9 and -11 or getArr(EC_R, 2)) -- EC_R[2] = right
end

---------------------------------------------------------------------------
-- CONTROL SURFACE AND FLEX ANIMATION
local function animate_surfaces(dt)
    -- Reverser effect (legacy)
    local revL = get(globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]"))
    local revR = get(globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]"))
    local coefL = 1 - math.max(revL - 0.5, 0) * get(globalPropertyf("tu154ce/gauges/engine/rpm_high_1")) * 0.015
    local coefR = 1 - math.max(revR - 0.5, 0) * get(globalPropertyf("tu154ce/gauges/engine/rpm_high_3")) * 0.015
    set(rudder_anim, get(rudder_deflect) / ((coefL + coefR) * 0.5))
    local ias = get(globalPropertyf("sim/flightmodel/position/indicated_airspeed")) * 1.852
    local ecoef = ias < 300 and 1 or (ias <= 400 and 1 + (ias-300)/100*2 or 3)
    set(elev_anim_L, get(elevator_L) * ecoef)
    set(elev_anim_R, get(elevator_R) * ecoef)

    -- Wing flex calculation
    local base = getArr(wing_tip_defl_arr, 0) + 1.3
    local l = base - get(gforce) * getArr(m_fuel_arr, 5) * 0.00005 + get(ail_L) * ias * 0.00003
    local r = base - get(gforce) * getArr(m_fuel_arr, 4) * 0.00005 + get(ail_R) * ias * 0.00003
    state.wing_act.L = lerp(state.wing_act.L, l, 10, dt)
    state.wing_act.R = lerp(state.wing_act.R, r, 10, dt)
    set(wing_flx_left, state.wing_act.L)
    set(wing_flx_right, state.wing_act.R)
end

---------------------------------------------------------------------------
-- WIPER ANIMATION
local function animate_wipers(dt)
    local pL = get(bus27_volt_left) > 13 and get(bus115_1_volt) > 110 and 1 or 0
    local pR = get(bus27_volt_right) > 13 and get(bus115_3_volt) > 110 and 1 or 0
    local function spd(cmd, p)
        return cmd == -1 and 1.5*p or cmd == 1 and 3*p or state.wiper_pos.L > 0.1 and 1*p or 0
    end
    local sL = spd(get(wiper_left), pL)
    local sR = spd(get(wiper_right), pR)
    state.wiper_pos.L = (state.wiper_pos.L + sL * dt) % 1
    state.wiper_pos.R = (state.wiper_pos.R + sR * dt) % 1
    set(wiper_angle_left, (math.cos(math.pi * state.wiper_pos.L * 2 - math.pi) + 1) * 0.5 * WIPER_AMPL)
    set(wiper_angle_right, (math.cos(math.pi * state.wiper_pos.R * 2 - math.pi) + 1) * 0.5 * WIPER_AMPL)
end

---------------------------------------------------------------------------
-- MAIN UPDATE
function update()
    local dt = get(frame_time)
    animate_gear(dt)
    animate_surfaces(dt)
    animate_wipers(dt)
    -- reverse handle midpoint
    set(reverse_mid, (get(revers_L) + get(revers_R)) * 0.5)
    -- TODO: If you need to animate windows, doors, sliders, etc., use getArr for all arrays!
end
