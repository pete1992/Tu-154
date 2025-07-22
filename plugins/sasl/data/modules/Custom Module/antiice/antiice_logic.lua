-- antiice_logic.lua

-- Smartcopilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

-- Helper to register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register all other DataRefs
defineProps({
    {"AOA_heat_on", "sim/cockpit2/ice/ice_AOA_heat_on", globalPropertyi},
    {"AOA_heat_on_copilot", "sim/cockpit2/ice/ice_AOA_heat_on_copilot", globalPropertyi},
    {"IAS", "sim/flightmodel/position/indicated_airspeed", globalPropertyf},
    {"ai_115_1_cc", "tu154ce/antiice/ai_115_1_cc", globalPropertyf},
    {"ai_115_2_cc", "tu154ce/antiice/ai_115_2_cc", globalPropertyf},
    {"ai_115_3_cc", "tu154ce/antiice/ai_115_3_cc", globalPropertyf},
    {"ai_27_L_cc", "tu154ce/antiice/ai_27_L_cc", globalPropertyf},
    {"ai_27_R_cc", "tu154ce/antiice/ai_27_R_cc", globalPropertyf},
    {"antiice_eng_1", "tu154ce/switchers/eng/antiice_eng_1", globalPropertyi},
    {"antiice_eng_2", "tu154ce/switchers/eng/antiice_eng_2", globalPropertyi},
    {"antiice_eng_3", "tu154ce/switchers/eng/antiice_eng_3", globalPropertyi},
    {"antiice_slats", "tu154ce/switchers/eng/antiice_slats", globalPropertyi},
    {"antiice_wing", "tu154ce/switchers/eng/antiice_wing", globalPropertyi},
    {"bus115_1_volt", "tu154ce/elec/bus115_1_volt", globalPropertyf},
    {"bus115_2_volt", "tu154ce/elec/bus115_2_volt", globalPropertyf},
    {"bus115_3_volt", "tu154ce/elec/bus115_3_volt", globalPropertyf},
    {"bus27_volt_left", "tu154ce/elec/bus27_volt_left", globalPropertyf},
    {"bus27_volt_right", "tu154ce/elec/bus27_volt_right", globalPropertyf},
    {"deflection_mtr_2", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalProperty},
    {"deflection_mtr_3", "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalProperty},
    {"eng_heat_open_1", "tu154ce/antiice/eng_heat_open_1", globalPropertyi},
    {"eng_heat_open_2", "tu154ce/antiice/eng_heat_open_2", globalPropertyi},
    {"eng_heat_open_3", "tu154ce/antiice/eng_heat_open_3", globalPropertyi},
    {"frame_time", "tu154ce/time/frame_time", globalPropertyf},
    {"frm_ice", "sim/flightmodel/failures/frm_ice", globalPropertyf},
    {"frm_ice2", "sim/flightmodel/failures/frm_ice2", globalPropertyf},
    {"ice_detect_ok", "tu154ce/antiice/ice_detect_ok", globalPropertyi},
    {"ice_detected", "tu154ce/antiice/ice_detected", globalPropertyi},
    {"ice_window_heat_on", "sim/cockpit2/ice/ice_window_heat_on", globalPropertyi},
    {"inlet_heat_1", "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[0]", globalProperty},
    {"inlet_heat_2", "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[1]", globalProperty},
    {"inlet_heat_3", "sim/cockpit2/ice/ice_inlet_heat_on_per_engine[2]", globalProperty},
    {"pitot_heat_1", "tu154ce/switchers/ovhd/pitot_heat_1", globalPropertyi},
    {"pitot_heat_2", "tu154ce/switchers/ovhd/pitot_heat_2", globalPropertyi},
    {"pitot_heat_3", "tu154ce/switchers/ovhd/pitot_heat_3", globalPropertyi},
    {"ppd_3_heat_fail", "tu154ce/antiice/ppd_3_heat_fail", globalPropertyi},
    {"rel_ice_inlet_heat1", "sim/operation/failures/rel_ice_inlet_heat", globalPropertyi},
    {"rel_ice_inlet_heat2", "sim/operation/failures/rel_ice_inlet_heat2", globalPropertyi},
    {"rel_ice_inlet_heat3", "sim/operation/failures/rel_ice_inlet_heat3", globalPropertyi},
    {"rel_ice_pitot_heat1", "sim/operation/failures/rel_ice_pitot_heat1", globalPropertyi},
    {"rel_ice_pitot_heat2", "sim/operation/failures/rel_ice_pitot_heat2", globalPropertyi},
    {"rel_ice_surf_heat", "sim/operation/failures/rel_ice_surf_heat", globalPropertyi},
    {"rel_ice_surf_heat2", "sim/operation/failures/rel_ice_surf_heat2", globalPropertyi},
    {"rio_fail", "tu154ce/failures/rio_fail", globalPropertyi},
    {"rpm_high_1", "tu154ce/gauges/engine/rpm_high_1", globalPropertyf},
    {"rpm_high_2", "tu154ce/gauges/engine/rpm_high_2", globalPropertyf},
    {"rpm_high_3", "tu154ce/gauges/engine/rpm_high_3", globalPropertyf},
    {"sim_pitot_heat_1", "sim/cockpit2/ice/ice_pitot_heat_on_pilot", globalPropertyi},
    {"sim_pitot_heat_2", "sim/cockpit2/ice/ice_pitot_heat_on_copilot", globalPropertyi},
    {"slat_heating", "tu154ce/antiice/slat_heating", globalPropertyi},
    {"soi21_on", "tu154ce/switchers/eng/soi21_on", globalPropertyi},
    {"soi21_test", "tu154ce/buttons/eng/soi21_test", globalPropertyi},
    {"stab_heat_t", "tu154ce/antiice/stab_heat_t", globalPropertyf},
    {"termo", "sim/weather/temperature_ambient_c", globalPropertyf},
    {"window_heat_1", "tu154ce/switchers/ovhd/window_heat_1", globalPropertyi},
    {"window_heat_2", "tu154ce/switchers/ovhd/window_heat_2", globalPropertyi},
    {"window_heat_3", "tu154ce/switchers/ovhd/window_heat_3", globalPropertyi},
    {"window_heat_fail_1", "tu154ce/failures/window_heat_fail_1", globalPropertyi},
    {"window_heat_fail_2", "tu154ce/failures/window_heat_fail_2", globalPropertyi},
    {"window_heat_fail_3", "tu154ce/failures/window_heat_fail_3", globalPropertyi},
    {"window_ice", "sim/flightmodel/failures/window_ice", globalPropertyf},
    {"window_ice_1", "tu154ce/anim/window_ice_1", globalPropertyf},
    {"window_ice_2", "tu154ce/anim/window_ice_2", globalPropertyf},
    {"window_ice_3", "tu154ce/anim/window_ice_3", globalPropertyf},
    {"window_ice_4", "tu154ce/anim/window_ice_4", globalPropertyf},
    {"wing_heat_t", "tu154ce/antiice/wing_heat_t", globalPropertyf},
    {"wing_heating", "tu154ce/antiice/wing_heating", globalPropertyi},
    {"wings_heat_on", "sim/cockpit2/ice/ice_surfce_heat_on", globalPropertyi},
})

-- Window heat properties
local window_windshield_temp = globalPropertyf("tu154ce/antiice/window_windshield_temp")
local window_left_temp = globalPropertyf("tu154ce/antiice/window_left_temp")
local window_right_temp = globalPropertyf("tu154ce/antiice/window_right_temp")
local window_windshield_act = globalPropertyi("tu154ce/antiice/window_windshield_act")
local window_left_act = globalPropertyi("tu154ce/antiice/window_left_act")
local window_right_act = globalPropertyi("tu154ce/antiice/window_right_act")
local xplane_version = globalPropertyi("sim/version/xplane_internal_version")

-- Local state variables
local ice_reseted = false
local ice_ratio_last = get(window_ice)
local ice_speed = 0

local ice_timer = 20
local ice_work_timer = 150

local ice_on_wings_L = 0
local ice_on_wings_R = 0
local ice_on_slats_L = 0
local ice_on_slats_R = 0

-- Constants for anti-ice system behavior
local WIN_HEAT_HIGH = 0.02      -- Heating rate at high setting
local WIN_HEAT_LOW = 0.015      -- Heating rate at low setting
local WIN_HEAT_FAIL = 1         -- Window heat fail flag value
local WINDOW_HEAT_SCALE = 250   -- Scaling for ai_115_x_cc values

function bool2int(val)
    return val and 1 or 0
end

function update()
    local MASTER = get(ismaster) ~= 1
    local passed = get(frame_time)

    local power27_L = get(bus27_volt_left) > 13
    local power27_R = get(bus27_volt_right) > 13
    local power115_1 = get(bus115_1_volt) > 110
    local power115_2 = get(bus115_2_volt) > 110
    local power115_3 = get(bus115_3_volt) > 110

    local out_term = get(termo)
    local ice_ratio = get(window_ice)

    if MASTER then
        -- Reset ice simulation if out of bounds
        if ice_ratio > 0.9 or ice_ratio < 0.1 then
            ice_ratio = 0.5
            set(window_ice, 0.5)
            ice_reseted = true
        else
            ice_reseted = false
        end

        -- Calculate current icing speed
        if passed ~= 0 and not ice_reseted then
            if math.abs(ice_ratio - ice_ratio_last) > 0.01 then
                ice_speed = 0
            else
                ice_speed = (ice_ratio - ice_ratio_last) * 2 / passed
            end
        end
        ice_ratio_last = ice_ratio

        -- SOI anti-ice system logic
        ice_timer = ice_timer + passed
        local ice_test = get(soi21_test) == 1
        if power27_L and power27_R and get(soi21_on) == 1 then
            if (ice_speed > 0 or ice_test) and get(rio_fail) ~= 1 then
                ice_timer = 0
            end

            -- Test mode
            if ice_test then
                ice_work_timer = 0
            else
                ice_work_timer = ice_work_timer + passed
            end

            set(ice_detect_ok, bool2int(ice_work_timer > 30 and ice_work_timer < 55 and get(rio_fail) ~= 1))

            if ice_timer < 8 then
                set(ice_detected, 1)
            else
                set(ice_detected, 0)
            end
        else
            ice_work_timer = 150
            ice_timer = 20
            set(ice_detect_ok, 0)
            set(ice_detected, 0)
        end

        local win_heat_sw_1 = get(window_heat_1)
        local win_heat_sw_2 = get(window_heat_2)
        local win_heat_sw_3 = get(window_heat_3)

        if get(xplane_version) < 120000 then
            -- XP11: Simulate ice and window heating with variable heating rates and failures
            local window_heat_spd_1 = 0
            if win_heat_sw_1 == 1 and power27_L and power115_1 then
                window_heat_spd_1 = WIN_HEAT_HIGH * (1 - get(window_heat_fail_1))
            elseif win_heat_sw_1 == -1 and power27_L and power115_1 then
                window_heat_spd_1 = WIN_HEAT_LOW * (1 - get(window_heat_fail_1))
            end

            local window_heat_spd_2 = 0
            if win_heat_sw_2 == 1 and power27_R and power115_3 then
                window_heat_spd_2 = WIN_HEAT_HIGH * (1 - get(window_heat_fail_2))
            elseif win_heat_sw_2 == -1 and power27_R and power115_3 then
                window_heat_spd_2 = WIN_HEAT_LOW * (1 - get(window_heat_fail_2))
            end

            local window_heat_spd_3 = 0
            if win_heat_sw_3 == 1 and power27_R and power115_3 then
                window_heat_spd_3 = WIN_HEAT_HIGH * (1 - get(window_heat_fail_3))
            elseif win_heat_sw_3 == -1 and power27_R and power115_3 then
                window_heat_spd_3 = WIN_HEAT_LOW * (1 - get(window_heat_fail_3))
            end

            local win_ice_1 = get(window_ice_1) + ((ice_speed - window_heat_spd_1) - math.max(out_term * 1, 0)) * passed
            if win_ice_1 < 0 then win_ice_1 = 0 elseif win_ice_1 > 1 then win_ice_1 = 1 end
            set(window_ice_1, win_ice_1)

            local win_ice_2 = get(window_ice_2) + ((ice_speed - window_heat_spd_2) - math.max(out_term * 1, 0)) * passed
            if win_ice_2 < 0 then win_ice_2 = 0 elseif win_ice_2 > 1 then win_ice_2 = 1 end
            set(window_ice_2, win_ice_2)

            local win_ice_3 = get(window_ice_3) + ((ice_speed - window_heat_spd_3) - math.max(out_term * 1, 0)) * passed
            if win_ice_3 < 0 then win_ice_3 = 0 elseif win_ice_3 > 1 then win_ice_3 = 1 end
            set(window_ice_3, win_ice_3)

            local win_ice_4 = get(window_ice_4) + (ice_speed - math.max(out_term * 1, 0)) * passed
            if win_ice_4 < 0 then win_ice_4 = 0 elseif win_ice_4 > 1 then win_ice_4 = 1 end
            set(window_ice_4, win_ice_4)

            set(ai_115_1_cc, window_heat_spd_1 * WINDOW_HEAT_SCALE)
            set(ai_115_3_cc, (window_heat_spd_2 + window_heat_spd_3) * WINDOW_HEAT_SCALE)
        elseif get(xplane_version) >= 120000 then
            -- XP12: Use act/temp properties instead of simulated ice
            if (win_heat_sw_1 == 1 or win_heat_sw_1 == -1) and power27_L and power115_1 then
                set(window_windshield_act, 1)
            else
                set(window_windshield_act, 0)
            end
            if (win_heat_sw_2 == 1 or win_heat_sw_2 == -1) and power27_L and power115_3 then
                set(window_left_act, 1)
            else
                set(window_left_act, 0)
            end
            if (win_heat_sw_3 == 1 or win_heat_sw_3 == -1) and power27_L and power115_3 then
                set(window_right_act, 1)
            else
                set(window_right_act, 0)
            end

            if win_heat_sw_1 == 1 then
                set(window_windshield_temp, 10)
            elseif win_heat_sw_1 == -1 then
                set(window_windshield_temp, 20)
            else
                set(window_windshield_temp, 0)
            end

            if win_heat_sw_2 == 1 then
                set(window_left_temp, 10)
            elseif win_heat_sw_2 == -1 then
                set(window_left_temp, 20)
            else
                set(window_left_temp, 0)
            end

            if win_heat_sw_3 == 1 then
                set(window_right_temp, 10)
            elseif win_heat_sw_3 == -1 then
                set(window_right_temp, 20)
            else
                set(window_right_temp, 0)
            end

            set(ai_115_1_cc, get(window_windshield_temp) * 0.1)
            set(ai_115_3_cc, get(window_right_temp) * 2 * 0.1)
        end
    end

    -- Pitot and AOA heating
    local pitot_sw_1 = math.max(get(pitot_heat_1) * bool2int(get(rel_ice_pitot_heat1) ~= 6), 0)
    local pitot_sw_2 = math.max(get(pitot_heat_2) * bool2int(get(rel_ice_pitot_heat2) ~= 6), 0)
    local pitot_sw_3 = math.max(get(pitot_heat_3) * bool2int(get(ppd_3_heat_fail) ~= 1), 0)

    if power27_L then
        set(sim_pitot_heat_1, pitot_sw_1)
        set(AOA_heat_on, pitot_sw_1)
        set(AOA_heat_on_copilot, pitot_sw_1)
        set(ai_27_L_cc, 10 * pitot_sw_1)
    else
        set(sim_pitot_heat_1, 0)
        set(AOA_heat_on, 0)
        set(AOA_heat_on_copilot, 0)
        set(ai_27_L_cc, 0)
    end

    if power27_R then
        set(sim_pitot_heat_2, pitot_sw_2)
        set(ai_27_R_cc, 7 * pitot_sw_2 + 7 * pitot_sw_3)
    else
        set(sim_pitot_heat_2, 0)
        set(ai_27_R_cc, 0)
    end

    -- Engine anti-ice
    local rpm_1 = get(rpm_high_1) > 50
    set(inlet_heat_1, bool2int(get(rel_ice_inlet_heat1) ~= 6 and rpm_1 and power27_L) * get(antiice_eng_1))
    set(eng_heat_open_1, bool2int(get(rel_ice_inlet_heat1) ~= 6 and power27_L) * get(antiice_eng_1))

    local rpm_2 = get(rpm_high_2) > 50
    set(inlet_heat_2, bool2int(rpm_2 and power27_R) * get(antiice_eng_2) * bool2int(get(rel_ice_inlet_heat2) ~= 6))
    set(eng_heat_open_2, bool2int(get(rel_ice_inlet_heat2) ~= 6 and power27_R) * get(antiice_eng_2))

    local rpm_3 = get(rpm_high_3) > 50
    set(inlet_heat_3, bool2int(rpm_3 and power27_R) * get(antiice_eng_3) * bool2int(get(rel_ice_inlet_heat3) ~= 6))
    set(eng_heat_open_3, bool2int(get(rel_ice_inlet_heat3) ~= 6 and power27_R) * get(antiice_eng_3))

    -- Wing and slat anti-ice
    set(wings_heat_on, bool2int((rpm_1 or rpm_2 or rpm_3) and (power27_L or power27_R)) * get(antiice_wing))

    local wing_heat = bool2int((rpm_1 or rpm_2 or rpm_3) and (power27_L or power27_R) and get(rel_ice_surf_heat) < 6) * get(antiice_wing)
    local slat_heat = bool2int(get(bus115_2_volt) > 110 and (power27_L or power27_R) and get(rel_ice_surf_heat2) < 6 and get(deflection_mtr_2) < 0.1 and get(deflection_mtr_3) < 0.1) * get(antiice_slats)

    set(wing_heating, wing_heat)
    set(slat_heating, slat_heat)
    set(ai_115_2_cc, slat_heat * 70)

    -- Wing and stab heat tubes
    local wing_tube = get(wing_heat_t)
    wing_tube = wing_tube + (out_term - wing_tube) * passed * 0.1 * (1 + get(IAS) / 200)
    wing_tube = wing_tube + (wing_heat * 300 - wing_tube) * passed * 0.1
    set(wing_heat_t, wing_tube)

    local stab_tube = get(stab_heat_t)
    stab_tube = stab_tube + (out_term - stab_tube) * passed * 0.1 * (1 + get(IAS) / 300)
    stab_tube = stab_tube + (wing_heat * 300 - stab_tube) * passed * 0.1
    set(stab_heat_t, stab_tube)

    -- Ice simulation for wings and slats
    ice_on_wings_L = ice_on_wings_L + (ice_speed * math.random() * 2 - math.max(0, wing_tube) * 0.0005) * passed
    ice_on_slats_L = ice_on_slats_L + (ice_speed * math.random() * 2 - slat_heat * 0.02) * passed
    if ice_on_wings_L < 0 then ice_on_wings_L = 0 end
    if ice_on_slats_L < 0 then ice_on_slats_L = 0 end

    ice_on_wings_R = ice_on_wings_R + (ice_speed * math.random() * 2 - math.max(0, wing_tube) * 0.0005) * passed
    ice_on_slats_R = ice_on_slats_R + (ice_speed * math.random() * 2 - slat_heat * 0.02) * passed
    if ice_on_wings_R < 0 then ice_on_wings_R = 0 end
    if ice_on_slats_R < 0 then ice_on_slats_R = 0 end

    if ice_on_slats_L > 0.2 then ice_on_slats_L = 0.2 end
    if ice_on_slats_R > 0.2 then ice_on_slats_R = 0.2 end

    if MASTER then
        set(frm_ice, ice_on_wings_L * 0.8 + ice_on_slats_L * 0.2)
        set(frm_ice2, ice_on_wings_R * 0.8 + ice_on_slats_R * 0.2)
    end

    set(ice_window_heat_on, 0)
end
