-- absu_controls.lua

--------------------------------------------------------------------------------
-- State & constants
--------------------------------------------------------------------------------
local pitch_act, roll_act, yaw_act = 0, 0, 0

-- Manual limits
local elev_lim, ail_lim = 0.4, 0.4

-- PID tables
local roll_ail_tbl = {
    {0, 1}, {0.2, 1}, {0.3, 0.5}, {0.4, -0.1},
    {0.6, -0.2}, {0.8, -0.4}, {1, -0.6}
}
local pitch_elev_tbl = {
    {0, 0.5}, {0.2, 0.5}, {0.3, 0.3}, {0.4, 0.2},
    {0.6, 0}, {0.8, -0.1}, {1, -0.2}
}
local flaps_tbl = {
    {0, 0}, {15, 5}, {28, 7}, {36, 8},
    {45, 10}, {50, 10}
}

-- Helpers
local function sign(x) return x > 0 and 1 or x < 0 and -1 or 0 end
local function line(x, x0, y0, x1, y1)
    return y0 + (y1 - y0) * ((x - x0) / (x1 - x0))
end
local function interpolate(tbl, x)
    for i = 1, #tbl - 1 do
        local x0, y0 = tbl[i][1], tbl[i][2]
        local x1, y1 = tbl[i + 1][1], tbl[i + 1][2]
        if x >= x0 and x <= x1 then
            return y0 + (y1 - y0) * (x - x0) / (x1 - x0)
        end
    end
    return tbl[#tbl][2]
end

-- Persistent PID state
local pitch_whl_last = 0
local PU_pitch
do
    PU_pitch = get(bkk_pitch)
end

local V_stab, V_smth, V_last, I_V
do
    local v0 = get(ias) * 1.852
    V_stab, V_smth, V_last, I_V = v0, v0, v0, 0
end

local M_stab, M_smth, M_last, I_M
do
    local m0 = get(mach_svs)
    M_stab, M_smth, M_last, I_M = m0, m0, m0, 0
end

local H_stab, H_last, I_H
do
    local h0 = get(alt_svs)
    H_stab, H_last, I_H = h0, h0, 0
end

local GS_smth, GS_last, GS_est = 0, 0, 0
local toga_alt = get(alt_svs)

local yaw_I, yaw_P_last = 0, 0

--------------------------------------------------------------------------------
-- Core update loop
--------------------------------------------------------------------------------
function update()
    local dt = get(frame_time)
    local MASTER = get(ismaster) ~= 1

    -- Inputs
    local pitch_now = get(bkk_pitch)
    local roll_now  = get(bkk_roll)
    local mach      = get(mach_svs)
    local airspeed  = get(ias) * 1.852
    local alt       = get(alt_svs)
    local gs_dev    = get(absu_use_second_nav) == 1 and get(nav_gs_2) * 10 or get(nav_gs_1) * 10
    -- Use the array-based gear logic (for Tu-154: gear 0,1,2)
    local gear_down = get(gear_deploy_arr, 0) + get(gear_deploy_arr, 1) + get(gear_deploy_arr, 2) > 0.05
    local flaps     = (get(flap_inn_L) + get(flap_inn_R)) / 2

    local pitch_mode = get(pitch_main_mode)
    local pitch_sub  = get(pitch_sub_mode)
    local roll_mode  = get(roll_main_mode)
    local roll_sub   = get(roll_sub_mode)
    local absu_smooth = get(absu_smooth_on)

    --------------------------------------------------------------------------------
    -- PITCH CONTROL
    --------------------------------------------------------------------------------
    if pitch_mode >= 1 then
        if pitch_sub == 1 or pitch_sub == 10 then
            -- Pitch Wheel (PU) mode
            local wheel = get(absu_pitch_wheel)
            local diff = wheel - pitch_whl_last
            while diff > 1 do diff = diff - 20 end
            while diff < -1 do diff = diff + 20 end
            pitch_whl_last = wheel
            PU_pitch = math.max(-17, math.min(17, PU_pitch + diff * 0.2))
        elseif pitch_sub == 2 then
            -- V hold mode
            V_smth = V_smth + (airspeed - V_smth) * dt
            local P = V_smth - V_stab
            I_V = I_V + P * dt * 0.005 - sign(I_V) * dt * 0.02
            I_V = math.max(-1, math.min(1, I_V))
            local D = (V_smth - V_last) / math.max(dt, 1e-6)
            local Kd = 2 * (1 - absu_smooth) * 0.5
            local pid = P * 0.5 + D * Kd + I_V
            PU_pitch = PU_pitch + (pitch_now - PU_pitch) * dt * 0.3
            pitch_need = math.max(-8.5, math.min(17, pid + PU_pitch))
        else
            -- Other pitch modes (M, H, GS, TOGA) use same pattern...
            PU_pitch = pitch_now
        end

        -- Manual vs auto elevator
        local elev_cmd
        if pitch_mode == 1 then
            local coef = mach < 1 and interpolate(pitch_elev_tbl, mach) or -0.2
            elev_cmd = get(joy_pitch) * coef - get(pitch_rate) * 0.15
        else
            elev_cmd = pitch_holder(PU_pitch)
        end

        -- Apply elevator actuator
        set(absu_contr_pitch,
            get(absu_contr_pitch)
            + (elev_cmd - get(absu_contr_pitch)) * dt * 10
        )
    else
        set(absu_contr_pitch, 0)
    end

    --------------------------------------------------------------------------------
    -- ROLL CONTROL (analogous to pitch)
    --------------------------------------------------------------------------------
    if roll_mode >= 1 then
        -- ... compute roll_need based on roll_sub, courses, NVU, VOR, etc.
        local ail_cmd
        if roll_mode == 1 then
            local coef = mach < 1 and interpolate(roll_ail_tbl, mach) or -0.8
            ail_cmd = get(joy_roll) * coef - get(roll_rate) * 0.08
        else
            ail_cmd = roll_holder(roll_need)
        end
        set(absu_contr_roll,
            get(absu_contr_roll)
            + (ail_cmd - get(absu_contr_roll)) * dt * 10
        )
    else
        set(absu_contr_roll, 0)
    end

    --------------------------------------------------------------------------------
    -- YAW CONTROL
    --------------------------------------------------------------------------------
    local yaw_cmd = (roll_mode >= 1) and yaw_holder() or 0
    -- Suppress yaw if nose gear is compressed/deflected (array index 0 = nose gear)
    if get(gear_deflect_arr, 0) > 0.01 then yaw_cmd = 0 end
    set(absu_contr_yaw,
        get(absu_contr_yaw)
        + (yaw_cmd - get(absu_contr_yaw)) * dt * 10
    )
end

--------------------------------------------------------------------------------
-- Helper control functions
--------------------------------------------------------------------------------

function pitch_holder(target)
    local now = get(bkk_pitch)
    local P = target - now
    local D = get(pitch_rate) * (1 - get(absu_damp_pitch_fail))
    local pid = P * 0.1 - D * 0.15
    -- Roll cross-coupling
    local roll = get(bkk_roll)
    -- Use the gear_down logic with arrays!
    local gear_down = get(gear_deploy_arr, 0) + get(gear_deploy_arr, 1) + get(gear_deploy_arr, 2) > 0.05
    local coef = gear_down and 0.00425 * 2 or 0.00175 * 2
    local roll_part = math.abs(roll) * coef * line(get(mach_svs), 0.4, 1.3, 0.8, 0.8)
    local cmd = math.max(-elev_lim, math.min(elev_lim, pid + roll_part))
    pitch_act = pitch_act + (cmd - pitch_act) * get(frame_time) * 5
    -- Trimmer
    if pitch_act > 0.01 then set(absu_pitch_trimm, 1)
    elseif pitch_act < -0.01 then set(absu_pitch_trimm, -1)
    else set(absu_pitch_trimm, 0) end
    return pitch_act
end

function roll_holder(target)
    local now = get(bkk_roll)
    local P = target - now
    local W = get(roll_rate)
    local A = get(roll_acc)
    if get(absu_damp_roll_fail) == 1 then W, A = 0, 0 end
    local stab = (get(mach_svs) < 0.5)
        and line(get(mach_svs), 0.5, 0.1, 0, 0.2) or 0.1
    local pid = P * stab - W * 0.08 * (0.5 + 0.01 * math.abs(A) / (0.01 * math.abs(A) + 1))
    roll_act = roll_act + (pid - roll_act) * get(frame_time) * 5
    roll_act = math.max(-ail_lim, math.min(ail_lim, roll_act))
    return roll_act
end

function yaw_holder()
    local P = get(slip) * (1 - get(absu_damp_yaw_fail))
    yaw_I = yaw_I + P * get(frame_time) * 0
    yaw_I = yaw_I - sign(yaw_I) * get(frame_time) * 0.1
    yaw_I = math.max(-0.1, math.min(0.1, yaw_I))
    local D = (P - yaw_P_last) / math.max(get(frame_time), 1e-6)
    yaw_P_last = P
    local pid = P * 0.01 + yaw_I + D * 0.01
    yaw_act = yaw_act + (pid - yaw_act) * get(frame_time) * 5
    yaw_act = math.max(-0.4, math.min(0.4, yaw_act))
    return yaw_act
end
