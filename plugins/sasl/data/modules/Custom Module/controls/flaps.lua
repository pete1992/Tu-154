-- flaps.lua (Tu-154M) - SASL 3.19, X-Plane 12
-- Batch DataRef declaration, flap/slat/stab logic, optimized

-- Batch-define DataRefs
-- Helper function for batch property creation
local function defineProps(list)
    for _, entry in ipairs(list) do
        defineProperty(entry[1], entry[3](entry[2]))
    end
end

defineProps({
    -- Environment & version
    {"external_view",    "sim/graphics/view/view_is_external",      globalPropertyi},
    {"xplane_version",   "sim/aircraft/view/acf_version",           globalPropertyf},
    -- Flap & slat positions (FM)
    {"flap_inn_L",       "sim/flightmodel/controls/wing1l_fla1def", globalPropertyf},
    {"flap_inn_R",       "sim/flightmodel/controls/wing1r_fla1def", globalPropertyf},
    {"flap_mid_L",       "sim/flightmodel/controls/wing2l_fla2def", globalPropertyf},
    {"flap_mid_R",       "sim/flightmodel/controls/wing2r_fla2def", globalPropertyf},
    {"slats",            "sim/flightmodel2/controls/slat1_deploy_ratio", globalPropertyf},
    {"stab_ratio",       "sim/cockpit2/controls/elevator_trim",     globalPropertyf},
    -- Controls & switches
    {"sim_flap_ratio",   "sim/cockpit2/controls/flap_ratio",        globalPropertyf},
    {"flaps_lever",      "tu154ce/controll/flaps_laver",            globalPropertyf}, -- intentional typo in DataRef name!
    {"flaps_sel",        "tu154ce/switchers/flaps_sel",             globalPropertyi},
    {"slat_man",         "tu154ce/switchers/slat_man",              globalPropertyi},
    {"slat_man_cap",     "tu154ce/switchers/slat_man_cap",          globalPropertyi},
    {"stab_man_cap",     "tu154ce/controll/stab_man_cap",           globalPropertyi},
    {"stab_manual",      "tu154ce/controll/stab_manual",            globalPropertyi},
    {"stab_setting",     "tu154ce/controll/stab_setting",           globalPropertyi},
    -- Hydraulics & time
    {"gs_press_1",       "tu154ce/hydro/gs_press_1",                globalPropertyf},
    {"gs_press_2",       "tu154ce/hydro/gs_press_2",                globalPropertyf},
    {"frame_time",       "tu154ce/time/frame_time",                 globalPropertyf},
    -- Electrical power
    {"bus27_volt_left",  "tu154ce/elec/bus27_volt_left",            globalPropertyf},
    {"bus27_volt_right", "tu154ce/elec/bus27_volt_right",           globalPropertyf},
    {"bus36_volt_left",  "tu154ce/elec/bus36_volt_left",            globalPropertyf},
    {"bus36_volt_right", "tu154ce/elec/bus36_volt_right",           globalPropertyf},
    {"bus115_1_volt",    "tu154ce/elec/bus115_1_volt",              globalPropertyf},
    {"bus115_3_volt",    "tu154ce/elec/bus115_3_volt",              globalPropertyf},
    {"ctr_115_1_cc",     "tu154ce/control/ctr_115_1_cc",            globalPropertyf},
    {"ctr_115_3_cc",     "tu154ce/control/ctr_115_3_cc",            globalPropertyf},
    -- Smart Copilot
    {"ismaster",         "scp/api/ismaster",                        globalPropertyf},
    {"hascontrol_1",     "scp/api/hascontrol_1",                    globalPropertyf},
    -- Failures
    {"flap_fail_left",     "tu154ce/failures/flap_fail_left",        globalPropertyi},
    {"flap_fail_right",    "tu154ce/failures/flap_fail_right",       globalPropertyi},
    {"stab_eng_fail",      "tu154ce/failures/stab_eng_fail",         globalPropertyi},
    {"stab_automatic_fail","tu154ce/failures/stab_automatic_fail",   globalPropertyi},
    {"slats_fail",         "tu154ce/failures/slats_fail",            globalPropertyi}
})


-- Flap commands and sample
local flaps_cmd_up   = findCommand("sim/flight_controls/flaps_up")
local flaps_cmd_down = findCommand("sim/flight_controls/flaps_down")
local flaps_sound    = loadSample('Custom Sounds/flaps_hnd.wav')

-- Utility: bool->int, clamp, interpolate
local function bool2int(b) return b and 1 or 0 end
local function clamp(v, minv, maxv) return math.max(minv, math.min(maxv, v)) end
local function interpolate(tbl, x)
    for i = 2, #tbl do
        local x1, y1 = tbl[i-1][1], tbl[i-1][2]
        local x2, y2 = tbl[i][1],   tbl[i][2]
        if x <= x2 then
            local f = (x - x1) / (x2 - x1)
            return y1 + (y2 - y1) * f
        end
    end
    return tbl[#tbl][2]
end

-- Interpolation tables for flap lever/mid flap logic
local flap_lever_tbl = {
    {-50000,0}, {0,0}, {0.20,15}, {0.25,15}, {0.30,15},
    {0.45,28}, {0.50,28}, {0.55,28}, {0.70,36}, {0.75,36},
    {0.80,36}, {0.95,45}, {1.00,45}, {10000,45}
}
local mid_flap_tbl = {
    {0,0}, {15,13}, {28,25}, {36,32}, {45,40}
}

-- Internal state
local flaps_pos_L_cmd = get(flap_inn_L)
local flaps_pos_R_cmd = get(flap_inn_R)
local flaps_dir_L, flaps_dir_R = 0, 0
local flap_speed = 1.8
local last_flap_pos_L, last_flap_pos_R = flaps_pos_L_cmd, flaps_pos_R_cmd
local slats_pos_cmd = get(slats)
local slats_dir, slats_speed = 0, 0.1
local stab_pos_now = get(stab_ratio) * 5.5
local stab_pos_cmd, stab_dir = stab_pos_now, 0
local last_lever = get(flaps_lever)
local lever_dir, need_stab_adjust = -1, false

-- Flap detent sound in cockpit view
local function handle_flap_sound(phase)
    if phase == 0 and get(external_view) == 0 and get(xplane_version) < 120000 then
        playSample(flaps_sound, false)
    end
    return 0
end
registerCommandHandler(flaps_cmd_up,   0, handle_flap_sound)
registerCommandHandler(flaps_cmd_down, 0, handle_flap_sound)

function update()
    -- Only run if SCP master and has control
    if get(ismaster) ~= 2 or get(hascontrol_1) ~= 2 then return end
    local dt = get(frame_time)
    -- Power availability
    local p27L = bool2int(get(bus27_volt_left)  > 13)
    local p27R = bool2int(get(bus27_volt_right) > 13)
    local p36L = bool2int(get(bus36_volt_left)  > 30)
    local p36R = bool2int(get(bus36_volt_right) > 30)
    local p115_1 = bool2int(get(bus115_1_volt) > 110)
    local p115_3 = bool2int(get(bus115_3_volt) > 110)
    -- Failures
    local fail_L = get(flap_fail_left)
    local fail_R = get(flap_fail_right)
    -- Flap lever (detent) logic
    local lever_pos = interpolate(flap_lever_tbl, get(sim_flap_ratio))
    set(flaps_lever, lever_pos)
    flaps_pos_L_cmd, flaps_pos_R_cmd = lever_pos, lever_pos
    -- Flap direction (auto/manual)
    local mode = get(flaps_sel)
    local cur_L, cur_R = get(flap_inn_L), get(flap_inn_R)
    if mode == 0 then
        flaps_dir_L = (cur_L < flaps_pos_L_cmd - 0.1 and 1) or (cur_L > flaps_pos_L_cmd and -1) or 0
        flaps_dir_R = (cur_R < flaps_pos_R_cmd - 0.1 and 1) or (cur_R > flaps_pos_R_cmd and -1) or 0
    else
        if lever_pos > 40 then flaps_dir_L, flaps_dir_R = 1, 1
        elseif lever_pos < 5 then flaps_dir_L, flaps_dir_R = -1, -1
        else flaps_dir_L, flaps_dir_R = 0, 0 end
    end
    -- Apply power/failure factors
    local hydro = math.max(get(gs_press_1), get(gs_press_2)) * 0.15
    flaps_dir_L = flaps_dir_L * p36L * p36R * (1 - fail_L)
    flaps_dir_R = flaps_dir_R * p36L * p36R * (1 - fail_R)
    -- Move & clamp
    local new_L = clamp(cur_L + flaps_dir_L * dt * hydro * flap_speed, 0, 45)
    local new_R = clamp(cur_R + flaps_dir_R * dt * hydro * flap_speed, 0, 45)
    -- Synchronize sides if nearly matched
    if math.abs(new_L - new_R) < 3 then
        last_flap_pos_L, last_flap_pos_R = new_L, new_R
    end
    -- Flap detent sound (cockpit only)
    if last_lever ~= lever_pos and (lever_pos == 0 or lever_pos == 15 or lever_pos == 28 or lever_pos == 36 or lever_pos == 45) then
        if get(xplane_version) < 120000 then playSample(flaps_sound, false) end
    end
    last_lever = lever_pos
    -- Write flap/midflap results
    set(flap_inn_L, last_flap_pos_L)
    set(flap_inn_R, last_flap_pos_R)
    set(flap_mid_L, interpolate(mid_flap_tbl, last_flap_pos_L))
    set(flap_mid_R, interpolate(mid_flap_tbl, last_flap_pos_R)
    )
    -- Slats logic (auto/manual)
    local slat_state = 2 - get(slats_fail)
    if get(slat_man_cap) == 0 then
        slats_pos_cmd = (lever_pos >= 5 and 1) or ((last_flap_pos_L <= 14 and last_flap_pos_R <= 14) and 0) or slats_pos_cmd
        slats_dir = (get(slats) < slats_pos_cmd - 0.01 and 1) or (get(slats) > slats_pos_cmd and -1) or 0
    else
        slats_dir, slats_pos_cmd = get(slat_man), get(slats)
    end
    slats_dir = slats_dir * p36L * p36R
    local sl = clamp(get(slats) + slats_dir * dt * slats_speed * (
        bool2int(slat_state > 1) * p115_1 * p27L +
        bool2int(slat_state > 0) * p115_3 * p27R
    ), 0, 1)
    set(slats, sl)
    -- Stabilizer logic (auto/manual)
    local stab_state = 2 - get(stab_eng_fail)
    if get(stab_man_cap) == 0 and get(stab_automatic_fail) == 0 then
        if lever_pos > last_flap_pos_L + 0.1 then lever_dir, need_stab_adjust = 1, true
        elseif lever_pos < last_flap_pos_L - 0.1 then lever_dir, need_stab_adjust = -1, true
        else lever_dir, need_stab_adjust = 0, false end
        if need_stab_adjust then
            local set_idx = get(stab_setting)
            if lever_dir == 1 then
                if lever_pos <= 28 then stab_pos_cmd = (set_idx == 2 and 3) or (set_idx == 1 and 1.5) or 0
                elseif lever_pos >= 36 then stab_pos_cmd = (set_idx == 2 and 5.5) or (set_idx == 1 and 3) or 0 end
            elseif lever_dir == -1 and lever_pos <= 28 then
                stab_pos_cmd = (set_idx == 2 and 3) or (set_idx == 1 and 1.5) or 0
            end
        end
        if lever_pos < 5 and last_flap_pos_L < 25 then stab_pos_cmd = 0 end
        stab_dir = (stab_pos_now < stab_pos_cmd - 0.01 and 1) or (stab_pos_now > stab_pos_cmd and -1) or 0
    else
        stab_dir, stab_pos_cmd = get(stab_manual), stab_pos_now
    end
    stab_pos_now = clamp(stab_pos_now + stab_dir * dt * ((bool2int(stab_state>1)*p115_1) + (bool2int(stab_state>0)*p115_3)) * 0.11, 0, 5.5)
    set(stab_ratio, stab_pos_now / 5.5)
    set(ctr_115_1_cc, bool2int(stab_dir~=0 and stab_state>1) * 6.5)
    set(ctr_115_3_cc, bool2int(stab_dir~=0 and stab_state>0) * 6.5)
end

