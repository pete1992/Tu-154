-- pnp.lua
-- Landing course indicator (PKP) logic for Tu-154M, SASL 3.x compatible
-- SmartCopilot & optional RXP plugin support
-- RXP removed for now

-- Helpers ---------------------------------------------------------------
local function clamp(x, minv, maxv)
    if x < minv then return minv end
    if x > maxv then return maxv end
    return x
end
local function bool2int(b) return b and 1 or 0 end

-- Batch DataRef definition ----------------------------------------------
local props = {
    -- instrument & timing
    { "gauge_num",    0 }, -- variable, not a DataRef
    { "frame_time",   globalPropertyf("tu154ce/time/frame_time") },
    -- switches & control
    { "absu_zpu_sel", globalPropertyi("tu154ce/switchers/console/absu_zpu_sel") },
    { "pnp_mode",     globalPropertyi("tu154ce/switchers/ovhd/curs_pnp_mode_1") },
    { "nav_select",   globalPropertyi("tu154ce/switchers/nav_select") },
    { "tks_on",       globalPropertyi("tu154ce/switchers/ovhd/tks_on_1") },
    -- courses & deviations
    { "course_ga",        globalPropertyf("tu154ce/tks/course_ga_1") },
    { "course_bgmk",      globalPropertyf("tu154ce/tks/course_bgmk_1") },
    { "diss_slip_angle",  globalPropertyf("tu154ce/nvu/diss_slip_angle") },
    { "nav_cs_1",         globalPropertyf("tu154ce/radio/nav1_cs") },
    { "nav_gs_1",         globalPropertyf("tu154ce/radio/nav1_gs") },
    { "nav_cs_flag_1",    globalPropertyi("tu154ce/radio/nav1_cs_flag") },
    { "nav_gs_flag_1",    globalPropertyi("tu154ce/radio/nav1_gs_flag") },
    { "nav_cs_2",         globalPropertyf("tu154ce/radio/nav2_cs") },
    { "nav_gs_2",         globalPropertyf("tu154ce/radio/nav2_gs") },
    { "nav_cs_flag_2",    globalPropertyi("tu154ce/radio/nav2_cs_flag") },
    { "nav_gs_flag_2",    globalPropertyi("tu154ce/radio/nav2_gs_flag") },
    { "obs",              globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_L") },
    { "obs_side",         globalPropertyf("tu154ce/gauges/compas/pkp_obs_set_R") },
    -- NVU & KLN
    { "nvu_res_course",   globalPropertyf("tu154ce/nvu/nvu_res_course") },
    { "nvu_res_z",        globalPropertyf("tu154ce/nvu/nvu_res_z") },
    { "kln_course",       globalPropertyf("tu154ce/kln90/kln_course") },
    { "kln_dev",          globalPropertyf("tu154ce/kln90/kln_dev") },
    { "kln_flag",         globalPropertyi("tu154ce/kln90/kln_flag") },
    -- GNS
    { "GNS430_dtk",       globalPropertyf("tu154ce/SC/GNS430_dtk") },
    { "GNS430_dev",       globalPropertyf("tu154ce/SC/GNS430_dev") },
    { "GNS430_flag",      globalPropertyi("tu154ce/SC/GNS430_flag") },
    { "gps_power",        globalPropertyi("sim/cockpit2/radios/actuators/gps_power") },
    -- flags & failures
    { "gyro_fail",        globalPropertyi("tu154ce/tks/fail_left") },
    { "fail_ga",          globalPropertyi("sim/operation/failures/rel_ss_dgy") },
    -- ABSU modes
    { "absu_pnp_mode",    globalPropertyi("tu154ce/absu/absu_pnp_mode_1") },
    { "absu_pnp_mode_2",  globalPropertyi("tu154ce/absu/absu_pnp_mode_2") },
    -- results (PKP gauges)
    { "pkp_gyro_course",  globalPropertyf("tu154ce/gauges/compas/pkp_gyro_course_L") },
    { "pkp_obs",          globalPropertyf("tu154ce/gauges/compas/pkp_obs_L") },
    { "pkp_helper_course",globalPropertyf("tu154ce/gauges/compas/pkp_helper_course_L") },
    { "pkp_slip_angle",   globalPropertyf("tu154ce/gauges/compas/pkp_slip_angle_L") },
    { "pkp_course_plank", globalPropertyf("tu154ce/gauges/compas/pkp_course_plank_L") },
    { "pkp_gs_plank",     globalPropertyf("tu154ce/gauges/compas/pkp_gs_plank_L") },
    { "pkp_gs_flag",      globalPropertyi("tu154ce/gauges/compas/pkp_gs_flag_L") },
    { "pkp_course_flag",  globalPropertyi("tu154ce/gauges/compas/pkp_course_flag_L") },
    { "pkp_obs_flag",     globalPropertyi("tu154ce/gauges/compas/pkp_obs_flag_L") },
    { "pkp_obs_one",      globalPropertyf("tu154ce/gauges/compas/pkp_obs_one_L") },
    { "pkp_obs_ten",      globalPropertyf("tu154ce/gauges/compas/pkp_obs_ten_L") },
    { "pkp_obs_hundr",    globalPropertyf("tu154ce/gauges/compas/pkp_obs_hundr_L") },
    { "pnp_sp_lamp",      globalPropertyf("tu154ce/lights/small/pnp_sp_left") },
    { "pnp_vor_lamp",     globalPropertyf("tu154ce/lights/small/pnp_vor_left") },
    { "pnp_nv_lamp",      globalPropertyf("tu154ce/lights/small/pnp_nv_left") },
    -- SmartCopilot
    { "ismaster",         globalPropertyf("scp/api/ismaster") },
    { "hascontrol_1",     globalPropertyf("scp/api/hascontrol_1") },
    -- power
    { "bus27_volt_left",  globalPropertyf("tu154ce/elec/bus27_volt_left") },
    { "bus36_volt_pts250_2", globalPropertyf("tu154ce/elec/bus36_volt_pts250_2") },
    -- lamps
    { "show_gns",         globalPropertyi("tu154ce/anim/show_gns") },
   -- { "show_RXP",         globalPropertyi("tu154ce/anim/RXP") },
    -- knob
    { "pkp_obs_knob_L",   globalPropertyf("tu154ce/gauges/compas/pkp_obs_knob_L") },
    { "absu_use_second_nav", globalPropertyi("tu154ce/absu_use_second_nav") },
}

for _, p in ipairs(props) do
    _G[p[1]] = p[2]
end
--[[
-- Always declare RXP properties (SASL 3), use with pcall at runtime
RXP_course = globalPropertyf("RXP/radios/gps_course_degtm")
RXP_dev    = globalPropertyf("RXP/radios/indicators/gps_cross_track_nm")
RXP_flag   = globalPropertyf("RXP/radios/indicators/hsi_flag_from_to_pilot")
]]
-- State vars
local last_time = get(frame_time)
local main_scale = get(pkp_gyro_course)
local slip_ang   = get(pkp_slip_angle)
local v_plank, h_plank = 0, 0
local obs_act    = get(pkp_obs)
local latch_flags = {0,0,0}

function update()
    local now = get(frame_time)
    local dt  = now - last_time
    last_time = now

    local MASTER = get(ismaster) ~= 1
    local power = get(bus27_volt_left) > 13
               and get(bus36_volt_pts250_2) > 30
               and get(tks_on) == 1
               and get(fail_ga) < 6

    -- Main PKP gyro needle logic
    if power then
        local target_course = (get(pnp_mode) == 0) and get(course_bgmk) or get(course_ga)
        local delta = main_scale - target_course
        if delta > 180 then delta = delta - 360 elseif delta < -180 then delta = delta + 360 end
        if     delta > 1  then main_scale = main_scale - dt * 30
        elseif delta < -1 then main_scale = main_scale + dt * 30
        else   main_scale = main_scale - delta * dt * 20 end

        slip_ang = slip_ang + (get(diss_slip_angle) - slip_ang) * dt * 10
        slip_ang = clamp(slip_ang, -30, 30)
    end

    if main_scale > 180 then main_scale = main_scale - 360
    elseif main_scale < -180 then main_scale = main_scale + 360 end
    if MASTER then set(pkp_gyro_course, main_scale) end
    set(pkp_slip_angle, clamp(slip_ang, -20, 20))

    -- Mode logic
    local mode    = get(absu_pnp_mode)
    local nav_sel = get(nav_select)
    local course_pl, glidesl_pl, obs_target, cs_flag, gs_flag = 0, 0, get(obs), 1, 1

    if     power and mode == 2 then -- VOR1
        course_pl  = clamp(get(nav_cs_1), -1.3, 1.3)
        obs_target = get(obs)
        cs_flag    = get(nav_cs_flag_1)
        gs_flag    = 1

    elseif power and mode == 3 then -- VOR2
        course_pl  = clamp(get(nav_cs_2), -1.3, 1.3)
        obs_target = get(obs)
        cs_flag    = get(nav_cs_flag_2)
        gs_flag    = 1

    elseif power and mode == 4 then -- APP
        if get(absu_use_second_nav) == 1 then
            course_pl  = clamp(get(nav_cs_2), -1.3, 1.3)
            glidesl_pl = -get(nav_gs_2)
            cs_flag    = get(nav_cs_flag_2)
            gs_flag    = get(nav_gs_flag_2)
        else
            course_pl  = clamp(get(nav_cs_1), -1.3, 1.3)
            glidesl_pl = -get(nav_gs_1)
            cs_flag    = get(nav_cs_flag_1)
            gs_flag    = get(nav_gs_flag_1)
        end
        obs_target = get(obs)

    elseif power and mode == 1 and nav_sel == 0 then -- NVU
        obs_target = get(nvu_res_course)
        course_pl  = -get(nvu_res_z) * 0.1
        cs_flag    = 0
        gs_flag    = 1

    elseif power and mode == 1 and nav_sel == 1 then -- KLN/GNS/RXP
        if get(show_gns) == 1 and get(show_RXP) == 0 then
            obs_target = get(GNS430_dtk)
            course_pl  = get(GNS430_dev) * 0.1852 * 2.1
            cs_flag    = get(GNS430_flag)
        elseif get(show_gns) == 1 and get(show_RXP) == 1 then
            -- pcall prevents error if RXP plugin not loaded
            local ok, rxp_course = pcall(get, RXP_course)
            if ok and rxp_course then
                obs_target = rxp_course
                local rxp_dev = pcall(get, RXP_dev) and get(RXP_dev) or 0
                course_pl  = rxp_dev * 1.852 * 0.5
                local rxp_flag = pcall(get, RXP_flag) and get(RXP_flag) or 0
                cs_flag    = bool2int(rxp_flag == 0)
            else
                obs_target = get(kln_course)
                course_pl  = get(kln_dev) * 0.1852
                cs_flag    = bool2int(get(kln_flag) == 0)
            end
        else
            obs_target = get(kln_course)
            course_pl  = get(kln_dev) * 0.1852
            cs_flag    = bool2int(get(kln_flag) == 0)
        end
        gs_flag = 1
    end

    -- PKP planks and flags
    v_plank = v_plank + (course_pl - v_plank) * dt * 5
    h_plank = h_plank + (glidesl_pl - h_plank) * dt * 5
    set(pkp_course_plank, clamp(v_plank, -1.1, 1.1))
    set(pkp_gs_plank,     clamp(h_plank, -1.1, 1.1))
    set(pkp_course_flag,  cs_flag)
    set(pkp_gs_flag,      gs_flag)

    -- OBS logic
    local diff = obs_act - obs_target
    if diff > 180 then diff = diff - 360 elseif diff < -180 then diff = diff + 360 end
    if power then
        if     diff > 2  then obs_act = obs_act - dt * 30
        elseif diff < -2 then obs_act = obs_act + dt * 30
        else   obs_act = obs_act - diff * dt * 15 end
    end
    obs_act = (obs_act % 360 + 360) % 360
    set(pkp_obs, obs_act)

    -- Digit wheels
    local o = obs_act
    set(pkp_obs_one,   math.floor(o % 10 + 0.4))
    set(pkp_obs_ten,   math.floor((o % 100) / 10 + 0.4))
    set(pkp_obs_hundr, math.floor((o % 1000) / 100 + 0.4))

    -- Lamps (mode indicators)
    local flags = {
        bool2int(power and mode == 4),
        bool2int(power and (mode == 2 or mode == 3)),
        bool2int(power and mode == 1)
    }
    if MASTER then
        set(pnp_sp_lamp,  flags[1])
        set(pnp_vor_lamp, flags[2])
        set(pnp_nv_lamp,  flags[3])
    end
    latch_flags = flags
end

function onAvionicsDone()
    set(pkp_gyro_course, main_scale)
    set(pkp_slip_angle, 0)
    set(pkp_course_plank, 0)
    set(pkp_gs_plank, 0)
    set(pkp_obs, obs_act)
    set(pkp_obs_hundr, math.floor(obs_act / 100) % 10)
    set(pkp_obs_ten,   math.floor(obs_act / 10) % 10)
    set(pkp_obs_one,   obs_act % 10)
    print("PNP safe state reset")
end
