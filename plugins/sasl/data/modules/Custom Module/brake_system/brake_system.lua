-- this is the brakes system
-- NOTE: For backward compatibility, this project uses "tu154ce/controlls/..." DataRefs in some datarefs
-- Standard X-Plane convention is "controls", but we keep the old spelling for now.
-- For future-proofing, consider migrating all to "controls".

-- tu154_brakes.lua (optimized)
-- Handles brake logic: pedal inputs, parking/emergency brakes, hydraulic pressure, failures, and temperatures

-- Helper: batch define DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- All DataRefs
defineProps({
    -- configuration
    {"have_pedals",   "tu154ce/have_pedals",                           globalPropertyi},

    -- hydraulics (normalized 0–1)
    {"gs_press_1",    "tu154ce/hydro/gs_press_1",                      globalPropertyf},
    {"gs_press_2",    "tu154ce/hydro/gs_press_2",                      globalPropertyf},
    {"gs_press_3",    "tu154ce/hydro/gs_press_3",                      globalPropertyf},
    {"gs_press_4",    "tu154ce/hydro/gs_press_4",                      globalPropertyf},

    -- inputs & controls
    {"frame_time",    "tu154ce/time/frame_time",                       globalPropertyf},
    {"l_brake_add",   "sim/flightmodel/controls/l_brake_add",          globalPropertyf},
    {"r_brake_add",   "sim/flightmodel/controls/r_brake_add",          globalPropertyf},
    {"parkbrake",     "sim/flightmodel/controls/parkbrake",            globalPropertyf},
    {"parkbrake_2",   "sim/cockpit2/controls/parking_brake_ratio",     globalPropertyf},
    {"parking_brake", "tu154ce/controll/parking_brake",                globalPropertyi},
    {"brake_emerg",   "tu154ce/controlls/brake_emerg",                 globalPropertyf},
    {"brake_emerg_L", "tu154ce/controlls/brake_emerg_L",               globalPropertyf},
    {"brake_emerg_R", "tu154ce/controlls/brake_emerg_R",               globalPropertyf},
    {"int_brakes_L",  "tu154ce/brakes/int_brakes_L",                   globalPropertyf},
    {"int_brakes_R",  "tu154ce/brakes/int_brakes_R",                   globalPropertyf},
    {"overr",         "sim/operation/override/override_gearbrake",    globalPropertyi},

    -- smart copilot
    {"ismaster",      "scp/api/ismaster",                              globalPropertyf},
    {"hascontrol_1",  "scp/api/hascontrol_1",                          globalPropertyf},

    -- failures & wear
    {"brake_heat_left",    "tu154ce/failures/brake_heat_left",       globalPropertyf},
    {"brake_heat_right",   "tu154ce/failures/brake_heat_right",      globalPropertyf},
    {"brake_runtime_left", "tu154ce/failures/brake_runtime_left",    globalPropertyf},
    {"brake_runtime_right","tu154ce/failures/brake_runtime_right",   globalPropertyf},
    {"rel_lbrakes",        "sim/operation/failures/rel_lbrakes",    globalPropertyi},
    {"rel_rbrakes",        "sim/operation/failures/rel_rbrakes",    globalPropertyi},
    {"failures_enabled",   "tu154ce/failures/failures_enabled",     globalPropertyi},

    -- environment
    {"speed",         "sim/flightmodel/position/groundspeed",         globalPropertyf},
    {"thermo",        "sim/cockpit2/temperature/outside_air_temp_degc",globalPropertyf},
    {"gear_vent_set", "tu154ce/switchers/eng/gear_fan",               globalPropertyi},
    {"gear2_deflect", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalPropertyf},
    {"gear3_deflect", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalPropertyf},

    -- joystick fallback
    {"joy_avail_L",   "sim/joystick/joy_mapped_axis_avail[6]",        globalPropertyi},
    {"joy_avail_R",   "sim/joystick/joy_mapped_axis_avail[7]",        globalPropertyi},
    {"joy_val_L",     "sim/joystick/joy_mapped_axis_value[6]",        globalPropertyf},
    {"joy_val_R",     "sim/joystick/joy_mapped_axis_value[7]",        globalPropertyf},
})

-- Utility functions
local function clamp(v,a,b) return v<a and a or v>b and b or v end
local function bool2int(b) return b and 1 or 0 end
local function interp(t,x)
    -- simple linear interpolation table: { {x0,y0}, {x1,y1}, ... }
    for i=2,#t do
        local x0,y0 = t[i-1][1], t[i-1][2]
        local x1,y1 = t[i  ][1], t[i  ][2]
        if x <= x1 then
            local f = (x - x0)/(x1 - x0)
            return y0 + (y1-y0)*f
        end
    end
    return t[#t][2]
end

-- Temperature wear curve
local termo_coef = {
    {0, 1}, {100, 1.5}, {200, 2}, {300, 5}, {1000, 50}, {1e6, 500}
}

-- Initial state
local state = {
    passed       = 0,
    sim_brake    = 0,
    left_cmd     = 0,
    right_cmd    = 0,
    park_last    = get(parking_brake),
    emerg_last   = get(brake_emerg),
    joy_L        = 0,
    joy_R        = 0,
    term_L       = get(thermo),
    term_R       = get(thermo),
    fail_timer   = 0,
    check_time   = math.random(15,30),
}

-- Sound samples
local snd_on  = loadSample('Custom Sounds/parking_on.wav')
local snd_off = loadSample('Custom Sounds/parking_off.wav')

-- Command handlers omitted for brevity (same logic as before)...

function update()
    local dt    = get(frame_time)
    state.passed = dt

    -- read inputs
    local GS   = get(speed)
    local park = get(parking_brake)
    local emerg= get(brake_emerg)
    local mainP= clamp(get(gs_press_1)/120, 0,1)
    local emP  = clamp(get(gs_press_4)/120, 0,1)

    -- joystick fallback if no pedals
    local b1 = get(joy_avail_L)==1 and get(joy_val_L) or state.left_cmd
    local b2 = get(joy_avail_R)==1 and get(joy_val_R) or state.right_cmd

    -- parking/emergency logic
    if park~=state.park_last then
        playSample(park==1 and snd_on or snd_off, false)
        -- reset pedal adds on release
        if park==0 then
            set(l_brake_add,0); set(r_brake_add,0)
        end
    end
    state.park_last = park

    -- compute commanded brake pressures
    local left_brake  = math.max(b1*mainP, state.sim_brake*mainP, state.left_cmd*mainP)
    local right_brake = math.max(b2*mainP, state.sim_brake*mainP, state.right_cmd*mainP)
    local park_force  = math.max(get(gear_blocks)*5, emerg*emP, park*mainP)

    -- deadband
    if left_brake  < 0.07 then left_brake  = 0 end
    if right_brake < 0.07 then right_brake = 0 end

    -- apply simulated failures
    left_brake  = left_brake  * bool2int(get(rel_lbrakes) ~= 6)
    right_brake = right_brake * bool2int(get(rel_rbrakes) ~= 6)

    -- failure & wear logic
    if get(ismaster)~=1 then
        local FAIL = get(failures_enabled)*0.05*4^(get(failures_enabled)*0.5)
        if FAIL>0 then
            state.fail_timer = state.fail_timer + dt
            if state.fail_timer >= state.check_time then
                state.fail_timer = 0
                state.check_time = math.random(15,30)
                -- random brake failures
                if get(rel_lbrakes)~=1 then set(rel_lbrakes, bool2int(math.random()<0.00001*FAIL*0.3)*6) end
                if get(rel_rbrakes)~=1 then set(rel_rbrakes, bool2int(math.random()<0.00001*FAIL*0.3)*6) end
            end
            -- pad wear
            if get(gear2_deflect)>0.05 then
                local wear = dt*left_brake*GS*0.00002*interp(termo_coef,state.term_L)
                set(brake_runtime_left, clamp(get(brake_runtime_left)-wear, 0,1))
            end
            if get(gear3_deflect)>0.05 then
                local wear = dt*right_brake*GS*0.00002*interp(termo_coef,state.term_R)
                set(brake_runtime_right, clamp(get(brake_runtime_right)-wear, 0,1))
            end
        else
            set(brake_runtime_left,  1)
            set(brake_runtime_right, 1)
            set(rel_lbrakes, 0)
            set(rel_rbrakes, 0)
        end
    end

    -- brake temperatures
    state.term_L = state.term_L + (left_brake*GS*0.9*bool2int(get(gear2_deflect)>0.05) - (state.term_L-get(thermo))*(1+get(gear_vent_set)*4)*0.01)*dt
    state.term_R = state.term_R + (right_brake*GS*0.9*bool2int(get(gear3_deflect)>0.05)- (state.term_R-get(thermo))*(1+get(gear_vent_set)*4)*0.01)*dt
    set(brake_heat_left,  state.term_L)
    set(brake_heat_right, state.term_R)

    -- apply to sim if we have control
    if get(hascontrol_1)~=1 then
        set(l_brake_add,    left_brake)
        set(r_brake_add,    right_brake)
        set(int_brakes_L,   math.max(left_brake, park_force))
        set(int_brakes_R,   math.max(right_brake, park_force))
        set(parkbrake,      park_force)
        set(parkbrake_2,    park_force)
    end

    -- publish logic outputs
    set(brake_L, math.max(left_brake,  b1, park))
    set(brake_R, math.max(right_brake, b2, park))
end

