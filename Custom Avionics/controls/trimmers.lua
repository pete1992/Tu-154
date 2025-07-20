-- trimmers.lua

-- Batch‐define helper
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
		{"external_view", "sim/graphics/view/view_is_external", globalPropertyi},
		{"warning_volume_ratio", "sim/operation/sound/warning_volume_ratio", globalPropertyf},
		{"pilot_Z", "sim/aircraft/view/acf_peZ", globalPropertyf},
		{"elev_trimm_1_pk", "tu154ce/b2/elev_trimm_1_pk", globalPropertyi},
		{"elev_trimm_2_pk", "tu154ce/b2/elev_trimm_2_pk", globalPropertyi},
		{"pedal_left_sw", "tu154ce/other/pedal_left_sw", globalPropertyi},
		{"pedal_right_sw", "tu154ce/other/pedal_right_sw", globalPropertyi},
		{"pedal_left_pos", "tu154ce/other/pedal_left_pos", globalPropertyf},
		{"pedal_right_pos", "tu154ce/other/pedal_right_pos", globalPropertyf},
		{"elev_trimm_sw", "tu154ce/controll/elev_trimm_switcher", globalPropertyi},
		{"ail_trimm_sw", "tu154ce/controll/ail_trimm_sw", globalPropertyi},
		{"rudd_trimm_sw", "tu154ce/controll/rudd_trimm_sw", globalPropertyi},
		{"emerg_elev_trimm", "tu154ce/switchers/console/emerg_elev_trimm", globalPropertyi},
		{"absu_pitch_trimm", "tu154ce/absu/absu_pitch_trimm", globalPropertyi},
		{"int_pitch_trim", "tu154ce/trimmers/int_pitch_trim", globalPropertyf},
		{"int_roll_trim", "tu154ce/trimmers/int_roll_trim", globalPropertyf},
		{"int_yaw_trim", "tu154ce/trimmers/int_yaw_trim", globalPropertyf},
		{"absu_roll_mode", "tu154ce/gauges/console/absu_roll_mode", globalPropertyi},
		{"absu_pitch_mode", "tu154ce/gauges/console/absu_pitch_mode", globalPropertyi},
		{"bus27_volt_left", "tu154ce/elec/bus27_volt_left", globalPropertyf},
		{"bus27_volt_right", "tu154ce/elec/bus27_volt_right", globalPropertyf},
		{"bus115_1_volt", "tu154ce/elec/bus115_1_volt", globalPropertyf},
		{"bus115_3_volt", "tu154ce/elec/bus115_3_volt", globalPropertyf},
		{"bus36_volt_left", "tu154ce/elec/bus36_volt_left", globalPropertyf},
		{"bus36_volt_right", "tu154ce/elec/bus36_volt_right", globalPropertyf},
		{"bus36_volt_pts250_1", "tu154ce/elec/bus36_volt_pts250_1", globalPropertyf},
		{"bus36_volt_pts250_2", "tu154ce/elec/bus36_volt_pts250_2", globalPropertyf},
		{"frame_time", "tu154ce/time/frame_time", globalPropertyf},
		{"ctr_27_L_cc", "tu154ce/control/ctr_27_L_cc", globalPropertyf},
		{"ctr_27_R_cc", "tu154ce/control/ctr_27_R_cc", globalPropertyf},
		{"ctr_36L_cc", "tu154ce/control/ctr_36L_cc", globalPropertyf},
		{"ctr_36R_cc", "tu154ce/control/ctr_36R_cc", globalPropertyf},
		{"ismaster", "scp/api/ismaster", globalPropertyf},
		{"hascontrol_1", "scp/api/hascontrol_1", globalPropertyf},
		{"rel_trim_rud", "sim/operation/failures/rel_trim_rud", globalPropertyi},
		{"rel_trim_ail", "sim/operation/failures/rel_trim_ail", globalPropertyi},
		{"rel_trim_elv", "sim/operation/failures/rel_trim_elv", globalPropertyi},
		{"trim_emerg_elv_fail", "tu154ce/failures/trim_emerg_elv_fail", globalPropertyi},
})


local trimm_up = loadSample('Custom Sounds/trimm_up.wav')
local trimm_down = loadSample('Custom Sounds/trimm_down.wav')
local trimm_ctr = loadSample('Custom Sounds/trimm_ctr.wav')
local trimm_sound = loadSample('Custom Sounds/new_snds/trimm.wav') 
local pitch_trim_power = true
local roll_trim_power = true
local yaw_trim_power = true
local trimm_pitch_last = 0
local trimm_roll_last = 0
local trimm_yaw_last = 0
local external = get(external_view)
local warn_vl = get(warning_volume_ratio)


function update()
    -- Determine if this is not the master instance 
    local MASTER = get(ismaster) ~= 1

    -- Delta time (time passed since last frame)
    local passed = get(frame_time)

    -- Bus power logic (27V, 36V)
    local power_27_L = bool2int(get(bus27_volt_left) > 13)
    local power_27_R = bool2int(get(bus27_volt_right) > 13)
    local power36_L = bool2int(get(bus36_volt_left) > 30)
    local power36_R = bool2int(get(bus36_volt_right) > 30)

    -- Control circuit currents
    local CC_27L = get(ctr_27_L_cc)
    local CC_27R = get(ctr_27_R_cc)

    -- Elevator trim switch states
    local elev_tr_sw = get(elev_trimm_sw)
    local emer_tr_sw = get(emerg_elev_trimm)
    local absu_tr_pt = get(absu_pitch_trimm)

    -- Disable manual elevator trim in ABSU pitch mode 2 l
    if get(absu_pitch_mode) == 2 then
        elev_tr_sw = 0
        emer_tr_sw = 0
    end

    -- Pitch trim calculation
    local pitch_trim_eng = 2  -- Engineering scaling factor for trim motor
    local pitch_trim_pos = get(int_pitch_trim)
    -- Only allow trim movement if not failed and both PK switches are off
    local pitch_trimm_work = bool2int(get(rel_trim_elv) ~= 6 and get(elev_trimm_1_pk) + get(elev_trimm_2_pk) < 2)

    if pitch_trim_pos >= 0 then
        -- Normal direction
        pitch_trim_pos = pitch_trim_pos +
            elev_tr_sw * passed * power_27_L * power_27_R * (power36_L + power36_R) * pitch_trim_eng * 0.015 * pitch_trimm_work
        pitch_trim_pos = pitch_trim_pos +
            absu_tr_pt * passed * power_27_L * power_27_R * (power36_L + power36_R) * pitch_trim_eng * 0.005 * pitch_trimm_work
        pitch_trim_pos = pitch_trim_pos +
            emer_tr_sw * passed * power_27_L * power36_L * 0.03 * (1 - get(trim_emerg_elv_fail))
    else
        -- Negative range is slightly faster (1.25x)
        pitch_trim_pos = pitch_trim_pos +
            elev_tr_sw * passed * power_27_L * power_27_R * (power36_L + power36_R) * pitch_trim_eng * 0.015 * 1.25 * pitch_trimm_work
        pitch_trim_pos = pitch_trim_pos +
            absu_tr_pt * passed * power_27_L * power_27_R * (power36_L + power36_R) * pitch_trim_eng * 0.005 * 1.25 * pitch_trimm_work
        pitch_trim_pos = pitch_trim_pos +
            emer_tr_sw * passed * power_27_L * power36_L * 0.03 * 1.25 * (1 - get(trim_emerg_elv_fail))
    end

    -- Clamp pitch trim range to physical stop
    if pitch_trim_pos > 0.60 then
        pitch_trim_pos = 0.60
    elseif pitch_trim_pos < -0.60 then
        pitch_trim_pos = -0.60
    end

    -- Write value if this instance is "master"
    if MASTER then
        set(int_pitch_trim, pitch_trim_pos)
    end

    -- Apply control circuit loading if the trim position changes
    if pitch_trim_pos ~= trimm_pitch_last then
        set(ctr_36L_cc, power36_L)
        set(ctr_36R_cc, power36_R)
    else
        set(ctr_36L_cc, 0)
        set(ctr_36R_cc, 0)
    end

    -- Store last pitch trim position for next frame
    trimm_pitch_last = pitch_trim_pos

	
-- Roll trim calculation and clamping
local roll_trim_pos = get(int_roll_trim) + get(ail_trimm_sw) * passed * power_27_L * 0.02 * bool2int(get(rel_trim_ail) ~= 6)
if roll_trim_pos > 0.24 then
    roll_trim_pos = 0.24
elseif roll_trim_pos < -0.24 then
    roll_trim_pos = -0.24
end

-- Set trim sound sample parameters (volume and position)
local dist = -get(pilot_Z) + 9
setSampleGain(trimm_sound, 5 * math.max(dist * 3 - 25, 0))
setSamplePosition(trimm_sound, 0.00515, -2.3967, -21.3144)
setSampleMaxDistance(trimm_sound, 0.001)

-- Set new roll trim value if master
if MASTER then
    set(int_roll_trim, roll_trim_pos)
end

-- Energize aileron trim contactor if roll trim has changed
if roll_trim_pos ~= trimm_roll_last then
    set(ctr_27_L_cc, CC_27L + 3)
end

trimm_roll_last = roll_trim_pos

-- Yaw trim calculation and clamping
local yaw_trim_pos = get(int_yaw_trim) + get(rudd_trimm_sw) * passed * power_27_R * 0.02 * bool2int(get(rel_trim_rud) ~= 6)
if yaw_trim_pos > 0.2 then
    yaw_trim_pos = 0.2
elseif yaw_trim_pos < -0.2 then
    yaw_trim_pos = -0.2
end

-- Play trim sound in cockpit if one of the trim conditions is true
if external == 0
    and (
        (get(ail_trimm_sw) ~= 0 and get(bus27_volt_left) > 13 and roll_trim_pos > -0.24 and roll_trim_pos < 0.24)
        or (get(rudd_trimm_sw) ~= 0 and get(bus27_volt_right) > 13 and yaw_trim_pos > -0.2 and yaw_trim_pos < 0.2)
        or (get(pedal_right_sw) ~= 0 and get(bus36_volt_right) > 5 and get(pedal_right_pos) < 1 and get(pedal_right_pos) > 0)
        or (get(pedal_left_sw) ~= 0 and get(bus36_volt_left) > 15 and get(pedal_left_pos) < 1 and get(pedal_left_pos) > 0)
    ) then
    if not isSamplePlaying(trimm_sound) then playSample(trimm_sound, 0) end
else
    stopSample(trimm_sound)
end

-- Set new yaw trim value if master
if MASTER then
    set(int_yaw_trim, yaw_trim_pos)
end

-- Energize rudder trim contactor if yaw trim has changed
if yaw_trim_pos ~= trimm_yaw_last then
    set(ctr_27_R_cc, CC_27R + 3)
end

trimm_yaw_last = yaw_trim_pos
end

pitch_UP_comm = findCommand("sim/flight_controls/pitch_trim_up")
function pitch_UP_hnd(phase)  
	if (1 == phase or 0 == phase) then
		set(elev_trimm_sw, 1)
		if 0 == phase then playSample(trimm_up, 0) end
	else
		set(elev_trimm_sw, 0)
		playSample(trimm_ctr, 0)
    end
return 0
end
registerCommandHandler(pitch_UP_comm, 0, pitch_UP_hnd)

pitch_DOWN_comm = findCommand("sim/flight_controls/pitch_trim_down")

function pitch_DOWN_hnd(phase)  
	if (1 == phase or 0 == phase) then
		set(elev_trimm_sw, -1)
		if 0 == phase then playSample(trimm_down, 0) end
	else
		set(elev_trimm_sw, 0)
		playSample(trimm_ctr, 0)
    end
return 0
end
registerCommandHandler(pitch_DOWN_comm, 0, pitch_DOWN_hnd)
pitch_TO_comm = findCommand("sim/flight_controls/pitch_trim_takeoff")

function pitch_TO_hnd(phase)  
	if (1 == phase or 0 == phase) then
		if pitch_trim_power then set(int_pitch_trim, 0)  end
    end
return 0
end
registerCommandHandler(pitch_TO_comm, 0, pitch_TO_hnd)
roll_LEFT_comm = findCommand("sim/flight_controls/aileron_trim_left")

function roll_LEFT_hnd(phase)  
	if (1 == phase or 0 == phase) then
		set(ail_trimm_sw, -1)
	else
		set(ail_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(roll_LEFT_comm, 0, roll_LEFT_hnd)
roll_RIGHT_comm = findCommand("sim/flight_controls/aileron_trim_right")

function roll_RIGHT_hnd(phase)  
	if (1 == phase or 0 == phase) then
		set(ail_trimm_sw, 1)
	else
		set(ail_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(roll_RIGHT_comm, 0, roll_RIGHT_hnd)
roll_CTR_comm = findCommand("sim/flight_controls/aileron_trim_center")

function roll_CTR_hnd(phase)  
	if (1 == phase or 0 == phase) then
		if roll_trim_power then set(int_roll_trim, 0) end
    end
return 0
end
registerCommandHandler(roll_CTR_comm, 0, roll_CTR_hnd)
yaw_LEFT_comm = findCommand("sim/flight_controls/rudder_trim_left")

function yaw_LEFT_hnd(phase)  
	if (1 == phase or 0 == phase) then
		set(rudd_trimm_sw, -1)
	else
		set(rudd_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(yaw_LEFT_comm, 0, yaw_LEFT_hnd)
yaw_RIGHT_comm = findCommand("sim/flight_controls/rudder_trim_right")

function yaw_RIGHT_hnd(phase)  
	if (1 == phase or 0 == phase) then
		set(rudd_trimm_sw, 1)
	else
		set(rudd_trimm_sw, 0)
    end
return 0
end
registerCommandHandler(yaw_RIGHT_comm, 0, yaw_RIGHT_hnd)
yaw_CTR_comm = findCommand("sim/flight_controls/rudder_trim_center")

function yaw_CTR_hnd(phase)  
	if (1 == phase or 0 == phase) then
		if yaw_trim_power then set(int_yaw_trim, 0) end
    end
return 0
end
registerCommandHandler(yaw_CTR_comm, 0, yaw_CTR_hnd)


