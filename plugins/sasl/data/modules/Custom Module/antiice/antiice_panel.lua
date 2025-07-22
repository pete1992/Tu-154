-- antiice_panel.lua
-- Anti-ice system panel logic for Tu-154M

-- Bulk DataRef registration
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    -- Switches and buttons
    {"soi21_on", "tu154ce/switchers/eng/soi21_on", globalPropertyi},
    {"soi21_test", "tu154ce/buttons/eng/soi21_test", globalPropertyi},
    {"antiice_slats", "tu154ce/switchers/eng/antiice_slats", globalPropertyi},
    {"antiice_eng_1", "tu154ce/switchers/eng/antiice_eng_1", globalPropertyi},
    {"antiice_eng_2", "tu154ce/switchers/eng/antiice_eng_2", globalPropertyi},
    {"antiice_eng_3", "tu154ce/switchers/eng/antiice_eng_3", globalPropertyi},
    {"antiice_wing", "tu154ce/switchers/eng/antiice_wing", globalPropertyi},
    {"window_heat_1", "tu154ce/switchers/ovhd/window_heat_1", globalPropertyi},
    {"window_heat_2", "tu154ce/switchers/ovhd/window_heat_2", globalPropertyi},
    {"window_heat_3", "tu154ce/switchers/ovhd/window_heat_3", globalPropertyi},
    {"pitot_heat_1", "tu154ce/switchers/ovhd/pitot_heat_1", globalPropertyi},
    {"pitot_heat_2", "tu154ce/switchers/ovhd/pitot_heat_2", globalPropertyi},
    {"pitot_heat_3", "tu154ce/switchers/ovhd/pitot_heat_3", globalPropertyi},
    -- Lamps
    {"heat_ok_1", "tu154ce/lights/small/heat_ok_1", globalPropertyf},
    {"heat_ok_2", "tu154ce/lights/small/heat_ok_2", globalPropertyf},
    {"heat_ok_3", "tu154ce/lights/small/heat_ok_3", globalPropertyf},
    {"soi_work", "tu154ce/lights/small/soi_work", globalPropertyf},
    {"soi_ice_detected", "tu154ce/lights/small/soi_ice_detected", globalPropertyf},
    {"antiice_slats_lamp", "tu154ce/lights/small/antiice_slats", globalPropertyf},
    {"antiice_eng_1_lamp", "tu154ce/lights/small/antiice_eng_1", globalPropertyf},
    {"antiice_eng_2_lamp", "tu154ce/lights/small/antiice_eng_2", globalPropertyf},
    {"antiice_eng_3_lamp", "tu154ce/lights/small/antiice_eng_3", globalPropertyf},
    {"antiice_wings_lamp", "tu154ce/lights/small/antiice_wings", globalPropertyf},
    -- Gauges
    {"stab_temp", "tu154ce/gauges/eng/stab_temp", globalPropertyf},
    {"wing_temp", "tu154ce/gauges/eng/wing_temp", globalPropertyf},
    -- Source signals
    {"wing_heat_t", "tu154ce/antiice/wing_heat_t", globalPropertyf},
    {"stab_heat_t", "tu154ce/antiice/stab_heat_t", globalPropertyf},
    {"bus27_volt_left", "tu154ce/elec/bus27_volt_left", globalPropertyf},
    {"bus27_volt_right", "tu154ce/elec/bus27_volt_right", globalPropertyf},
    {"ice_inlet_heat_1", "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]", globalProperty},
    {"ice_inlet_heat_2", "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[1]", globalProperty},
    {"ice_inlet_heat_3", "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[2]", globalProperty},
    {"eng_heat_open_1", "tu154ce/antiice/eng_heat_open_1", globalPropertyi},
    {"eng_heat_open_2", "tu154ce/antiice/eng_heat_open_2", globalPropertyi},
    {"eng_heat_open_3", "tu154ce/antiice/eng_heat_open_3", globalPropertyi},
    {"ice_surfce_heat_on", "sim/cockpit2/ice/ice_surfce_heat_on", globalPropertyi},
    {"ice_detected", "tu154ce/antiice/ice_detected", globalPropertyi},
    {"ice_detect_ok", "tu154ce/antiice/ice_detect_ok", globalPropertyi},
    -- Failure states
    {"ppd_3_heat_fail", "tu154ce/antiice/ppd_3_heat_fail", globalPropertyi},
    {"rel_ice_window_heat", "sim/operation/failures/rel_ice_window_heat", globalPropertyi},
    {"rel_ice_inlet_heat1", "sim/operation/failures/rel_ice_inlet_heat", globalPropertyi},
    {"rel_ice_inlet_heat2", "sim/operation/failures/rel_ice_inlet_heat2", globalPropertyi},
    {"rel_ice_inlet_heat3", "sim/operation/failures/rel_ice_inlet_heat3", globalPropertyi},
    {"rel_ice_pitot_heat1", "sim/operation/failures/rel_ice_pitot_heat1", globalPropertyi},
    {"rel_ice_pitot_heat2", "sim/operation/failures/rel_ice_pitot_heat2", globalPropertyi},
    {"rel_ice_surf_heat", "sim/operation/failures/rel_ice_surf_heat", globalPropertyi},
    {"rel_ice_surf_heat2", "sim/operation/failures/rel_ice_surf_heat2", globalPropertyi},
    {"wing_heating", "tu154ce/antiice/wing_heating", globalPropertyi},
    {"slat_heating", "tu154ce/antiice/slat_heating", globalPropertyi},
    -- Engines
    {"eng1_N1", "sim/flightmodel/engine/ENGN_N1_[0]", globalProperty},
    {"eng2_N1", "sim/flightmodel/engine/ENGN_N1_[1]", globalProperty},
    {"eng3_N1", "sim/flightmodel/engine/ENGN_N1_[2]", globalProperty},
    -- Time
    {"frame_time", "tu154ce/time/frame_time", globalPropertyf},
})

-- Include smoothing for lamp brightness
include("smooth_light.lua")

-- Sounds
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')
local long_sirena = loadSample('Custom Sounds/long_siren.wav')

-- Magic numbers as local constants for clarity
local LAMP_VOLT_MIN = 10           -- Minimum bus voltage for lamp brightness
local LAMP_VOLT_RANGE = 18.5       -- Voltage span for full brightness
local GAUGE_FILTER_FACTOR = 5      -- Factor for smooth temperature movement
local RESET_N1_THRESHOLD = 5       -- Engine N1 for switcher reset
local SIM_START_DELAY = 0.3        -- Startup delay (s) for switcher reset

-- State variables for cold & dark reset
local notLoaded = true
local sim_start_timer = 0

local function reset_switchers()
    -- Reset all switches to OFF if engines are shut down (cold & dark)
    if get(eng1_N1) < RESET_N1_THRESHOLD and get(eng2_N1) < RESET_N1_THRESHOLD and get(eng3_N1) < RESET_N1_THRESHOLD then
        set(soi21_on, 0)
        set(antiice_slats, 0)
        set(antiice_eng_1, 0)
        set(antiice_eng_2, 0)
        set(antiice_eng_3, 0)
        set(antiice_wing, 0)
        set(window_heat_1, 0)
        set(window_heat_2, 0)
        set(window_heat_3, 0)
        set(pitot_heat_1, 0)
        set(pitot_heat_2, 0)
        set(pitot_heat_3, 0)
    end
    notLoaded = false
end

-- Smoothed values for temperature gauge animations
local stab_temp_act = 0
local wing_tem_act = 0

local function gauges()
    -- Smooth needle movement for anti-ice temperature gauges
    local passed = get(frame_time)
    local stab_t = get(stab_heat_t)
    local wing_t = get(wing_heat_t)

    stab_temp_act = stab_temp_act + (stab_t - stab_temp_act) * passed * GAUGE_FILTER_FACTOR
    wing_tem_act = wing_tem_act + (wing_t - wing_tem_act) * passed * GAUGE_FILTER_FACTOR

    set(stab_temp, stab_temp_act)
    set(wing_temp, wing_tem_act)
end

-- Track previous values for switchers and buttons to detect changes (for sound triggers etc.)
local soi21_on_last = get(soi21_on)
local antiice_slats_last = get(antiice_slats)
local antiice_eng_1_last = get(antiice_eng_1)
local antiice_eng_2_last = get(antiice_eng_2)
local antiice_eng_3_last = get(antiice_eng_3)
local antiice_wing_last = get(antiice_wing)
local window_heat_1_last = get(window_heat_1)
local window_heat_2_last = get(window_heat_2)
local window_heat_3_last = get(window_heat_3)
local pitot_heat_1_last = get(pitot_heat_1)
local pitot_heat_2_last = get(pitot_heat_2)
local pitot_heat_3_last = get(pitot_heat_3)
local soi21_test_last = get(soi21_test)

local function check_controls()
    -- Check for changes in switch states (expand for sound, click etc.)
    local soi21_on_sw = get(soi21_on)
    local antiice_slats_sw = get(antiice_slats)
    local antiice_eng_1_sw = get(antiice_eng_1)
    local antiice_eng_2_sw = get(antiice_eng_2)
    local antiice_eng_3_sw = get(antiice_eng_3)
    local antiice_wing_sw = get(antiice_wing)
    local window_heat_1_sw = get(window_heat_1)
    local window_heat_2_sw = get(window_heat_2)
    local window_heat_3_sw = get(window_heat_3)
    local pitot_heat_1_sw = get(pitot_heat_1)
    local pitot_heat_2_sw = get(pitot_heat_2)
    local pitot_heat_3_sw = get(pitot_heat_3)
    local changes = soi21_on_sw + antiice_slats_sw + antiice_eng_1_sw + antiice_eng_2_sw + antiice_eng_3_sw + antiice_wing_sw
    changes = changes + window_heat_1_sw + window_heat_2_sw + window_heat_3_sw + pitot_heat_1_sw + pitot_heat_2_sw + pitot_heat_3_sw
    changes = changes - soi21_on_last - antiice_slats_last - antiice_eng_1_last - antiice_eng_2_last - antiice_eng_3_last - antiice_wing_last
    changes = changes - window_heat_1_last - window_heat_2_last - window_heat_3_last - pitot_heat_1_last - pitot_heat_2_last - pitot_heat_3_last

    -- Place for switch change sound/logic if needed
    if changes ~= 0 then end

    local soi21_test_sw = get(soi21_test)
    -- Place for test button sound/logic if needed
    if soi21_test_sw ~= soi21_test_last then end

    -- Update last values for next cycle
    soi21_on_last = soi21_on_sw
    antiice_slats_last = antiice_slats_sw
    antiice_eng_1_last = antiice_eng_1_sw
    antiice_eng_2_last = antiice_eng_2_sw
    antiice_eng_3_last = antiice_eng_3_sw
    antiice_wing_last = antiice_wing_sw
    window_heat_1_last = window_heat_1_sw
    window_heat_2_last = window_heat_2_sw
    window_heat_3_last = window_heat_3_sw
    pitot_heat_1_last = pitot_heat_1_sw
    pitot_heat_2_last = pitot_heat_2_sw
    pitot_heat_3_last = pitot_heat_3_sw
    soi21_test_last = soi21_test_sw
end

local function lamps()
    -- Calculate common lamp brightness scale based on DC bus voltage
    local lamps_brt = math.max((math.max(get(bus27_volt_left), get(bus27_volt_right)) - LAMP_VOLT_MIN) / LAMP_VOLT_RANGE, 0)

    -- Pitot heat lamps
    local heat_ok_1_brt = 0
    if get(rel_ice_pitot_heat1) < 6 and get(pitot_heat_1) == -1 then heat_ok_1_brt = lamps_brt end
    set(heat_ok_1, smooth_light(heat_ok_1_brt, get(heat_ok_1)))

    local heat_ok_2_brt = 0
    if get(rel_ice_pitot_heat2) < 6 and get(pitot_heat_2) == -1 then heat_ok_2_brt = lamps_brt end
    set(heat_ok_2, smooth_light(heat_ok_2_brt, get(heat_ok_2)))

    local heat_ok_3_brt = 0
    if get(ppd_3_heat_fail) == 0 and get(pitot_heat_3) == -1 then heat_ok_3_brt = lamps_brt end
    set(heat_ok_3, smooth_light(heat_ok_3_brt, get(heat_ok_3)))

    -- SOI work and ice detected lamps
    local soi_work_brt = get(ice_detect_ok) * lamps_brt
    set(soi_work, smooth_light(soi_work_brt, get(soi_work)))

    local soi_ice_detected_brt = get(ice_detected) * lamps_brt
    set(soi_ice_detected, smooth_light(soi_ice_detected_brt, get(soi_ice_detected))) -- Bugfix: correct brightness variable
	
	if get(ice_detected) == 1 then
		if not isSamplePlaying(long_sirena) then
			playSample(long_sirena, true)
		end
	else
		stopSample(long_sirena)
	end

    -- Slat and engine anti-ice lamps
    local antiice_slats_brt = get(slat_heating) * lamps_brt
    set(antiice_slats_lamp, smooth_light(antiice_slats_brt, get(antiice_slats_lamp)))

    local antiice_eng_1_brt = 0
    if get(eng_heat_open_1) == 1 then antiice_eng_1_brt = lamps_brt end
    set(antiice_eng_1_lamp, smooth_light(antiice_eng_1_brt, get(antiice_eng_1_lamp)))

    local antiice_eng_2_brt = 0
    if get(eng_heat_open_2) == 1 then antiice_eng_2_brt = lamps_brt end
    set(antiice_eng_2_lamp, smooth_light(antiice_eng_2_brt, get(antiice_eng_2_lamp)))

    local antiice_eng_3_brt = 0
    if get(eng_heat_open_3) == 1 then antiice_eng_3_brt = lamps_brt end
    set(antiice_eng_3_lamp, smooth_light(antiice_eng_3_brt, get(antiice_eng_3_lamp)))

    local antiice_wings_brt = get(wing_heating) * lamps_brt
    set(antiice_wings_lamp, smooth_light(antiice_wings_brt, get(antiice_wings_lamp)))
end

function update()
    -- Update simulation time delta
    local passed = get(frame_time)

    -- Cold & dark reset of switches after sim start delay
    sim_start_timer = sim_start_timer + passed
    if sim_start_timer > SIM_START_DELAY then
        if notLoaded then reset_switchers() end
        check_controls()
    end
    gauges()
    lamps()
end
