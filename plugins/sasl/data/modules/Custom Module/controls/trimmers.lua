-- trimmers.lua
-- Pitch, roll and yaw trimmer logic for Tu-154M

-- Utility functions ------------------------------------------------------
local function clamp(x, minv, maxv)
    if x < minv then return minv end
    if x > maxv then return maxv end
    return x
end
local function bool2int(b) return b and 1 or 0 end

-- Batch DataRef definitions ---------------------------------------------
local props = {
    -- Trim switches
    {"elev_trimm_sw",       "tu154ce/controll/elev_trimm_switcher",   "i"},
    {"ail_trimm_sw",        "tu154ce/controll/ail_trimm_sw",          "i"},
    {"rudd_trimm_sw",       "tu154ce/controll/rudd_trimm_sw",         "i"},
    {"emerg_elev_trimm",    "tu154ce/switchers/console/emerg_elev_trimm","i"},
    {"absu_pitch_trimm",    "tu154ce/absu/absu_pitch_trimm",          "i"},
    -- Trim positions
    {"int_pitch_trim",      "tu154ce/trimmers/int_pitch_trim",        "f"},
    {"int_roll_trim",       "tu154ce/trimmers/int_roll_trim",         "f"},
    {"int_yaw_trim",        "tu154ce/trimmers/int_yaw_trim",          "f"},
    -- ABSU modes
    {"absu_roll_mode",      "tu154ce/gauges/console/absu_roll_mode",  "i"},
    {"absu_pitch_mode",     "tu154ce/gauges/console/absu_pitch_mode", "i"},
    -- Electrical power
    {"bus27_volt_left",     "tu154ce/elec/bus27_volt_left",           "f"},
    {"bus27_volt_right",    "tu154ce/elec/bus27_volt_right",          "f"},
    {"bus36_volt_left",     "tu154ce/elec/bus36_volt_left",           "f"},
    {"bus36_volt_right",    "tu154ce/elec/bus36_volt_right",          "f"},
    {"frame_time",          "tu154ce/time/frame_time",                "f"},
    -- Control-load indicators
    {"ctr_27_L_cc",         "tu154ce/control/ctr_27_L_cc",            "f"},
    {"ctr_27_R_cc",         "tu154ce/control/ctr_27_R_cc",            "f"},
    {"ctr_36L_cc",          "tu154ce/control/ctr_36L_cc",             "f"},
    {"ctr_36R_cc",          "tu154ce/control/ctr_36R_cc",             "f"},
    -- SmartCopilot
    {"ismaster",            "scp/api/ismaster",                       "f"},
    {"hascontrol_1",        "scp/api/hascontrol_1",                   "f"},
    -- Trim failures
    {"rel_trim_rud",        "sim/operation/failures/rel_trim_rud",    "i"},
    {"rel_trim_ail",        "sim/operation/failures/rel_trim_ail",    "i"},
    {"rel_trim_elv",        "sim/operation/failures/rel_trim_elv",    "i"},
    {"trim_emerg_elv_fail","tu154ce/failures/trim_emerg_elv_fail",   "i"},
}

for _, p in ipairs(props) do
    if p[3] == "f" then
        defineProperty(p[1], globalPropertyf(p[2]))
    else
        defineProperty(p[1], globalPropertyi(p[2]))
    end
end

-- Sound samples ----------------------------------------------------------
local snd_up    = loadSample('Custom Sounds/trimm_up.wav')
local snd_down  = loadSample('Custom Sounds/trimm_down.wav')
local snd_ctr   = loadSample('Custom Sounds/trimm_ctr.wav')

-- Command bindings -------------------------------------------------------
local cmd_pitch_up     = findCommand("sim/flight_controls/pitch_trim_up")
local cmd_pitch_down   = findCommand("sim/flight_controls/pitch_trim_down")
local cmd_pitch_center = findCommand("sim/flight_controls/pitch_trim_takeoff")
local cmd_roll_left    = findCommand("sim/flight_controls/aileron_trim_left")
local cmd_roll_right   = findCommand("sim/flight_controls/aileron_trim_right")
local cmd_roll_center  = findCommand("sim/flight_controls/aileron_trim_center")
local cmd_yaw_left     = findCommand("sim/flight_controls/rudder_trim_left")
local cmd_yaw_right    = findCommand("sim/flight_controls/rudder_trim_right")
local cmd_yaw_center   = findCommand("sim/flight_controls/rudder_trim_center")

-- State variables --------------------------------------------------------
local last_time       = get(frame_time)
local last_pitch_pos  = get(int_pitch_trim)
local last_roll_pos   = get(int_roll_trim)
local last_yaw_pos    = get(int_yaw_trim)

-- Main update function ---------------------------------------------------
function update()
    -- Delta-time
    local now = get(frame_time)
    local dt  = now - last_time
    last_time = now
    if dt <= 0 then return end

    -- SmartCopilot master or absent → allow writes
    local sc     = get(ismaster)
    local MASTER = (sc == 2) or (sc == 0)

    -- Cache power and switches
    local p27L       = bool2int(get(bus27_volt_left)  > 13)
    local p27R       = bool2int(get(bus27_volt_right) > 13)
    local p36L       = bool2int(get(bus36_volt_left)  > 30)
    local p36R       = bool2int(get(bus36_volt_right) > 30)
    local sw_el      = get(elev_trimm_sw)
    local sw_ail     = get(ail_trimm_sw)
    local sw_rud     = get(rudd_trimm_sw)
    local sw_em      = get(emerg_elev_trimm)
    local absu_p     = get(absu_pitch_trimm)
    local absu_pmode = get(absu_pitch_mode)
    local absu_rmode = get(absu_roll_mode)
    local trimOK_el  = bool2int(get(rel_trim_elv) ~= 6)
    local trimOK_ail = bool2int(get(rel_trim_ail) ~= 6)
    local trimOK_rud = bool2int(get(rel_trim_rud) ~= 6)

    -- Reset CC indicators
    set(ctr_36L_cc, 0); set(ctr_36R_cc, 0)
    set(ctr_27_L_cc, 0); set(ctr_27_R_cc, 0)

    -- Pitch trimmer -------------------------------------------------------
    if absu_pmode == 2 then sw_el, sw_em = 0, 0 end  -- ABSU stab mode disables manual trim
    local base  = p27L * p27R * (p36L + p36R)
    local pos   = get(int_pitch_trim)
    local rate  = 2 * 0.015 * (pos < 0 and 1.25 or 1)
    local delta = (sw_el + absu_p * 0.333 + sw_em * 2) * rate * base * dt * trimOK_el
    pos = clamp(pos + delta, -0.6, 0.6)
    if MASTER then set(int_pitch_trim, pos) end
    if pos ~= last_pitch_pos then
        set(ctr_36L_cc, p36L); set(ctr_36R_cc, p36R)
        playSample(delta > 0 and snd_up or snd_down, false)
    end
    last_pitch_pos = pos

    -- Roll trimmer --------------------------------------------------------
    if absu_rmode == 2 then sw_ail = 0 end  -- ABSU roll mode disables manual trim
    local pos_r  = get(int_roll_trim)
    local delta_r= sw_ail * 0.02 * p27L * trimOK_ail * dt
    pos_r = clamp(pos_r + delta_r, -0.24, 0.24)
    if MASTER then set(int_roll_trim, pos_r) end
    if pos_r ~= last_roll_pos then
        set(ctr_27_L_cc, 3)
        playSample(delta_r > 0 and snd_up or snd_down, false)
    end
    last_roll_pos = pos_r

    -- Yaw trimmer ---------------------------------------------------------
    local pos_y  = get(int_yaw_trim)
    local delta_y= sw_rud * 0.02 * p27R * trimOK_rud * dt
    pos_y = clamp(pos_y + delta_y, -0.2, 0.2)
    if MASTER then set(int_yaw_trim, pos_y) end
    if pos_y ~= last_yaw_pos then
        set(ctr_27_R_cc, 3)
        playSample(delta_y > 0 and snd_up or snd_down, false)
    end
    last_yaw_pos = pos_y
end

-- Command handlers -------------------------------------------------------
local function pitch_up_handler(phase)
    if phase < 2 then
        set(elev_trimm_sw,  1)
        if phase == 0 then playSample(snd_up, false) end
    else
        set(elev_trimm_sw,  0)
        playSample(snd_ctr, false)
    end
    return 0
end
local function pitch_down_handler(phase)
    if phase < 2 then
        set(elev_trimm_sw, -1)
        if phase == 0 then playSample(snd_down, false) end
    else
        set(elev_trimm_sw,  0)
        playSample(snd_ctr, false)
    end
    return 0
end
local function pitch_center_handler(phase)
    if phase < 2 then set(int_pitch_trim, 0) end
    return 0
end

local function roll_left_handler(phase)
    set(ail_trimm_sw, phase < 2 and -1 or 0)
    if phase == 0 then playSample(snd_down, false) end
    return 0
end
local function roll_right_handler(phase)
    set(ail_trimm_sw, phase < 2 and  1 or 0)
    if phase == 0 then playSample(snd_up, false) end
    return 0
end
local function roll_center_handler(phase)
    if phase < 2 then set(int_roll_trim, 0); playSample(snd_ctr, false) end
    return 0
end

local function yaw_left_handler(phase)
    set(rudd_trimm_sw, phase < 2 and -1 or 0)
    if phase == 0 then playSample(snd_down, false) end
    return 0
end
local function yaw_right_handler(phase)
    set(rudd_trimm_sw, phase < 2 and  1 or 0)
    if phase == 0 then playSample(snd_up, false) end
    return 0
end
local function yaw_center_handler(phase)
    if phase < 2 then set(int_yaw_trim, 0); playSample(snd_ctr, false) end
    return 0
end

-- Register command handlers -----------------------------------------------
registerCommandHandler(cmd_pitch_up,     0, pitch_up_handler)
registerCommandHandler(cmd_pitch_down,   0, pitch_down_handler)
registerCommandHandler(cmd_pitch_center, 0, pitch_center_handler)
registerCommandHandler(cmd_roll_left,    0, roll_left_handler)
registerCommandHandler(cmd_roll_right,   0, roll_right_handler)
registerCommandHandler(cmd_roll_center,  0, roll_center_handler)
registerCommandHandler(cmd_yaw_left,     0, yaw_left_handler)
registerCommandHandler(cmd_yaw_right,    0, yaw_right_handler)
registerCommandHandler(cmd_yaw_center,   0, yaw_center_handler)
