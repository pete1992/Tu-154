-- apu_logic.lua
-- APU calculations and system simulation for Tu-154M
-- apu fails included 

local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    {"apu_main_switch", "tu154ce/switchers/eng/apu_main_switch", globalPropertyi},
    {"apu_start_mode", "tu154ce/switchers/eng/apu_start_mode", globalPropertyi},
    {"apu_air_bleed", "tu154ce/switchers/eng/apu_air_bleed", globalPropertyi},
    {"apu_start", "tu154ce/buttons/eng/apu_start", globalPropertyi},
    {"apu_stop", "tu154ce/buttons/eng/apu_stop", globalPropertyi},
    {"apu_n1", "tu154ce/gauges/eng/apu_rpm", globalPropertyf},
    {"apu_oil_t", "tu154ce/gauges/eng/apu_oil_temp", globalPropertyf},
    {"apu_oil_q", "tu154ce/eng/apu_oil_q", globalPropertyf},
    {"apu_oil_p", "tu154ce/eng/apu_oil_p", globalPropertyf},
    {"apu_egt", "tu154ce/gauges/eng/apu_egt", globalPropertyf},
    {"bus27_volt_left", "tu154ce/elec/bus27_volt_left", globalPropertyf},
    {"bus27_volt_right", "tu154ce/elec/bus27_volt_right", globalPropertyf},
    {"gen4_amp_bus", "tu154ce/elec/gen4_amp", globalPropertyf},
    {"apu_system_on", "tu154ce/eng/apu_system_on", globalPropertyi},
    {"apu_fuel_last", "tu154ce/eng/apu_fuel_last", globalPropertyf},
    {"tank1_w", "sim/flightmodel/weight/m_fuel[0]", globalProperty},
    {"apu_air_press", "tu154ce/eng/apu_air_press", globalPropertyf},
    {"apu_air_doors", "tu154ce/eng/apu_air_doors", globalPropertyf},
    {"apu_fuel_p", "tu154ce/eng/apu_fuel_p", globalPropertyf},
    {"apu_start_bus", "tu154ce/elec/apu_start_bus", globalPropertyf},
    {"apu_start_cc", "tu154ce/elec/apu_start_cc", globalPropertyf},
    {"apu_start_seq", "tu154ce/elec/apu_start_seq", globalPropertyi},
    {"fuel_pumps_27_cc", "tu154ce/elec/fuel_pumps_27_cc", globalPropertyf},
    {"apu_doors", "tu154ce/anim/apu_doors", globalPropertyf},
    {"apu_burn_fuel", "tu154ce/elec/apu_burning_fuel", globalPropertyf},
    {"eng_airvalve_2", "tu154ce/bleed/eng_airvalve_2", globalPropertyf},
    {"rpm_high_2", "tu154ce/gauges/engine/rpm_high_2", globalPropertyf},
    {"frame_time", "tu154ce/time/frame_time", globalPropertyf},
    {"outside_air_temp", "sim/cockpit2/temperature/outside_air_temp_degc", globalPropertyf},
    {"msl_alt", "sim/flightmodel/position/elevation", globalPropertyf},
    {"baro_press", "sim/weather/barometer_sealevel_inhg", globalPropertyf},
    {"reset_state", "tu154ce/reset_state", globalPropertyi},
    {"apu_start_fail", "tu154ce/failures/apu_start_fail", globalPropertyi},
    {"apu_gen_fail", "tu154ce/failures/apu_gen_fail", globalPropertyi},
    {"apu_runtime", "tu154ce/failures/apu_runtime", globalPropertyf},
    {"apu_fail_oilt", "tu154ce/failures/apu_fail_oilt", globalPropertyi},
    {"apu_fail_egt", "tu154ce/failures/apu_fail_egt", globalPropertyi},
    {"apu_fail_fuel_left", "tu154ce/failures/apu_fail_fuel_left", globalPropertyi},
    {"apu_fail", "tu154ce/failures/apu_fail", globalPropertyi},
    {"apu_press_fail", "tu154ce/failures/apu_press_fail", globalPropertyi},
    {"failures_enabled", "tu154ce/failures/failures_enabled", globalPropertyi}
})

defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

local function interpolate(tbl, x)
    for i = 1, #tbl - 1 do
        local x1, y1 = tbl[i][1], tbl[i][2]
        local x2, y2 = tbl[i+1][1], tbl[i+1][2]
        if x >= x1 and x <= x2 then
            return y1 + (y2 - y1) * (x - x1) / (x2 - x1)
        end
    end
    return tbl[#tbl][2]
end

local function clamp(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

local OIL_TEMP_FAIL_LIMIT = 115
local EGT_FAIL_LIMIT = 150
local N1_STOP_RPM = 45
local SYSTEM_ON_BUS_VOLT = 13
local DOORS_SPEED_FACTOR = 27 * 3
local BLEED_RPM_LIMIT = 92
local FUEL_PRESS_MIN = 0.5

local eng2_run_temp_corr = 0
local oil_temp_counter = 0

local off_tbl = {
    {-500, 30}, {-10, 30}, {0, 0}, {3, -5}, {4, -0.18},
    {5, -0.18}, {10, -0.25}, {20, -2}, {30, -3},
    {40, -5}, {55, -7}, {60, -20}, {100, -20},
    {120, -50}, {1000, -100}
}
local starter_tbl = {
    {-500, 20}, {0, 10}, {3, 8}, {15, 4}, {20, 5},
    {23, 2.5}, {30, 0}, {1000, 0}
}
local fuel_tbl = {
    {-500, 0}, {0,0}, {15,0}, {20,1}, {30,5},
    {55,10}, {60,30}, {98,30}, {102,0}, {1000,0}
}
local oil_temp_tbl = {
    {-500,10}, {-50,1.6}, {-30,1.4}, {-25,1.25},
    {30,1}, {150,0.9}, {1000,0.7}
}

set(apu_runtime, math.random(280,320) * 3600)

local RPM = 0
local oil_q = 1
--set(apu_oil_q, 1)
local apu_burning_fuel = false
local apd_work_time = 100
local apu_doors_pos = get(apu_doors)
local bleed_doors_pos = get(apu_air_doors)
local apu_burning_fuel_val = 0
local apu_starter = 0
local starter_work = 1
local starter_worked = false
local apu_emerg_off = 0
local apu_fail_last_fuel = 1
local apu_fail_EGT = 1
local apu_fail_OIL_T = 1
local starter_RPM_check = false
local egt_current = get(outside_air_temp)
local apu_temp = get(outside_air_temp)
local oil_temp = get(outside_air_temp)
local fuel_last = get(apu_fuel_last)
local minusTimer = 0
local false_bleed = 0

function update()
    local passed = get(frame_time)
    -- Reset oil quantity when reset_state is triggered
    if get(reset_state) == 1 then
        set(apu_oil_q, 1)
    end

    RPM = get(apu_n1)
    oil_q = get(apu_oil_q)
    oil_temp = get(apu_oil_t)
    apu_doors_pos = get(apu_doors)
    bleed_doors_pos = get(apu_air_doors)
    apu_burning_fuel_val = get(apu_burn_fuel)
    egt_current = get(apu_egt)
    local MASTER = get(ismaster) ~= 1

    if MASTER then
        apu_fail_last_fuel = 1 - get(apu_fail_fuel_left)
        apu_fail_EGT = 1 - get(apu_fail_egt)
        apu_fail_OIL_T = 1 - get(apu_fail_oilt)
        local mode_sw = get(apu_start_mode)
        local main_sw = get(apu_main_switch)
        local power_apu = get(apu_start_bus)
        local bus_L = get(bus27_volt_left)
        local bus_R = get(bus27_volt_right)

        local system_on = 0
        if bus_R > SYSTEM_ON_BUS_VOLT and main_sw == 1 then system_on = 1 end

        apu_doors_pos = apu_doors_pos + bus_L * (system_on * 2 - 1) * passed / DOORS_SPEED_FACTOR
        if apu_doors_pos > 1 then apu_doors_pos = 1 elseif apu_doors_pos < 0 then apu_doors_pos = 0 end

        if bus_R > SYSTEM_ON_BUS_VOLT and RPM > BLEED_RPM_LIMIT and get(apu_press_fail) == 0 then
            bleed_doors_pos = bleed_doors_pos + get(apu_air_bleed) * passed * 0.2
        elseif bus_R > SYSTEM_ON_BUS_VOLT then
            bleed_doors_pos = bleed_doors_pos - passed * 0.2
        end
        if bleed_doors_pos > 1 then bleed_doors_pos = 1 elseif bleed_doors_pos < 0 then bleed_doors_pos = 0 end

        local fuel_press = get(apu_fuel_p)
        local fuel_current = 0
        if mode_sw * system_on == 1 and power_apu > SYSTEM_ON_BUS_VOLT and get(tank1_w) > 150 then
            fuel_press = fuel_press + passed * 1
            fuel_current = 15
        else
            fuel_press = fuel_press - passed * 1
            fuel_current = 0
        end
        if fuel_press > 1 then fuel_press = 1 elseif fuel_press < 0 then fuel_press = 0 end

        apd_work_time = apd_work_time + passed
        if (apd_work_time > 32 or RPM > 45) and not starter_worked then
            apu_starter = 0
            starter_worked = true
        elseif apd_work_time < 32 and apd_work_time > 1 and not starter_worked then
            apu_starter = 1
        end
        if RPM > 92 then
            apu_starter = 0
            apd_work_time = 100
        end
        if RPM > 92 or apd_work_time > 32 then
            starter_worked = false
        end

        if RPM > 21 and apd_work_time < 32 and fuel_press > 0.8 and apu_starter == 1 then
            if fuel_last > 0.1 and apu_burning_fuel_val == 0 then
                local rand = math.random(100 - fuel_last * 80)
                if rand < 20 then
                    apu_fail_last_fuel = 0
                    set(apu_fail_fuel_left, 1)
                end
            end
            if egt_current > EGT_FAIL_LIMIT and apu_burning_fuel_val == 0 then
                local rand = math.random(350 - egt_current)
                if rand < 50 then
                    apu_fail_EGT = 0
                    set(apu_fail_egt, 1)
                end
            end
            apu_burning_fuel_val = 1
        elseif fuel_press < FUEL_PRESS_MIN then
            apu_burning_fuel_val = 0
        end
        if egt_current < EGT_FAIL_LIMIT then set(apu_fail_egt, 0) end

        if get(apu_stop) == 1 or (apd_work_time > 32 and RPM < N1_STOP_RPM) or power_apu < 5 then
            apu_burning_fuel_val = 0
            apd_work_time = 100
            apu_starter = 0
        end

        if power_apu > SYSTEM_ON_BUS_VOLT and system_on == 1 and get(apu_start) == 1 and apd_work_time > 35 and apu_doors_pos > 0.9 then
            apd_work_time = 0
            starter_RPM_check = false
        end

        if apd_work_time < 35 and starter_work * apu_starter == 1 then
            set(apu_start_seq, 1)
        else
            set(apu_start_seq, 0)
        end

        if apd_work_time < 2 and apu_starter == 1 and RPM > 20 and starter_work == 1 and not starter_RPM_check then
            local rand = math.random(50 - RPM)
            if rand < 5 then
                starter_work = 0
            end
            starter_RPM_check = true
        end

        local t_stop_coef = interpolate(oil_temp_tbl, oil_temp)

        if apu_burning_fuel_val == 1 and apu_fail_last_fuel == 1 then fuel_last = 1.2 end
        fuel_last = fuel_last - (math.abs(RPM * 0.01) ^ 0.7) * 0.12 * passed
        fuel_last = fuel_last - apu_burning_fuel_val * 0.1 * passed
        if fuel_last < 0 then
            fuel_last = 0
            if apu_fail_last_fuel == 0 then
                apu_burning_fuel_val = 0
            end
        end

        local real_alt = get(msl_alt) + (29.92 - get(baro_press)) * 304.800919279572547
        if real_alt > 4500 and apu_burning_fuel_val == 1 then
            apu_burning_fuel_val = 0
            fuel_last = fuel_last + 0.5
        end
        set(apu_fuel_last, fuel_last)

        -- Bleedtemp correction for oil temp
        if get(rpm_high_2) * get(eng_airvalve_2) > 40 and get(apu_oil_t) < 40 + (get(rpm_high_2) * 0.1) then
            eng2_run_temp_corr = eng2_run_temp_corr + 0.001 * get(rpm_high_2) * passed
        else
            if eng2_run_temp_corr > 0.5 then
                eng2_run_temp_corr = eng2_run_temp_corr - 0.06 - (math.abs(get(apu_oil_t)) * 0.005) * passed
            else
                eng2_run_temp_corr = 0
            end
        end

        -- Smooth oil overheat fail
        if oil_temp > 135 then
            oil_q = oil_q - passed * 0.0002
            oil_temp_counter = oil_temp_counter + passed
            if oil_temp_counter > 10 and apu_fail_OIL_T == 1 then
                local rand = math.random(255 - oil_temp)
                if rand < 5 then
                    apu_fail_OIL_T = 0
                    set(apu_fail_oilt, 1)
                end
                oil_temp_counter = 0
            end
        end

        -- Bleed/engine bleed simulation
        local bleed_eng = get(eng_airvalve_2) * get(rpm_high_2) * bleed_doors_pos * (math.random(0, 100) - 51) * 0.00004
        false_bleed = false_bleed + (bleed_eng - false_bleed) * passed * 0.5

        -- RPM simulation
        RPM = RPM + interpolate(off_tbl, RPM) * t_stop_coef * (2 - apu_fail_last_fuel) * (2 - apu_fail_EGT) * (3 - apu_fail_OIL_T * 2) * passed
        RPM = RPM + interpolate(starter_tbl, RPM) * apu_starter * starter_work * apu_fail_EGT * apu_fail_OIL_T * (1 - get(apu_start_fail)) * (1 - get(apu_fail)) * passed
        RPM = RPM + interpolate(fuel_tbl, RPM) * apu_burning_fuel_val * (1 - apu_emerg_off) * apu_fail_last_fuel * apu_fail_EGT * apu_fail_OIL_T * (1 - get(apu_fail)) * passed
        RPM = RPM * (false_bleed + 1)

        -- Starter current simulation
        local start_current = apu_starter * 600 / (1 + math.max(RPM - 10, 0) / 5)
        if starter_work == 0 then start_current = apu_starter * 200 end

        -- EGT calculation
        local out_temp = get(outside_air_temp)
        local egt_heat_spd = (1000 - egt_current) * 0.1 * apu_burning_fuel_val * (bleed_doors_pos * 0.25 + 1) * (get(gen4_amp_bus) * 0.0012 + 1) * (3 - apu_fail_last_fuel * 2)
        egt_heat_spd = egt_heat_spd - false_bleed * 2000
        local egt_cool_spd = (egt_current - apu_temp) * (0.5 + ((RPM * 0.01)^1.05) * 1.5) * 0.09
        egt_current = egt_current + (egt_heat_spd - egt_cool_spd) * passed
-- APU temperature calculation
        local apu_heat_spd = (egt_current * 0.5 - apu_temp) * 0.005 * (2 - math.abs(RPM) * 0.01)
        local apu_cool_spd = (apu_temp - out_temp) * (0.05 + 1.95 * (math.abs(RPM) * 0.01)^0.5) * 0.001
        apu_temp = apu_temp + (apu_heat_spd - apu_cool_spd) * passed

        -- Oil temperature calculation, includes bleed-air induced correction
        local oil_heat_spd = (apu_temp - oil_temp) * 0.55 * (1.2 - oil_q * 0.2) ^ 3 + eng2_run_temp_corr
        local oil_cool_spd = (oil_temp - out_temp) * 0.6
        oil_temp = oil_temp + (oil_heat_spd - oil_cool_spd) * passed

        -- Emergency shutdown logic (red limit triggers)
        local start_seq = get(apu_start_seq) == 1
        if (start_seq and egt_current > 700) or (not start_seq and egt_current > 570) then
            apu_emerg_off = 1
        end
        if RPM > 105 then
            apu_emerg_off = 1
        end
        if system_on == 0 then
            apu_emerg_off = 0
        end

		local oil_press_sim = 0
		if apu_starter == 1 or RPM > 0 then
			oil_press_sim = clamp(((math.max(RPM, 8) / 100) * 4), 0, 4) * oil_q
		else
			oil_press_sim = 0
		end

        -- Failure timer and runtime decrement
        if get(failures_enabled) > 0 then
            minusTimer = minusTimer + passed * RPM * 0.01
            if minusTimer >= 1 then
                minusTimer = 0
                set(apu_runtime, math.max(0, get(apu_runtime) - 1))
            end
        else
            set(apu_runtime, 300 * 3600)
            set(apu_fail_fuel_left, 0)
            set(apu_fail_egt, 0)
            set(apu_fail_oilt, 0)
            set(apu_start_fail, 0)
        end

        -- Write all computed values to DataRefs
        set(apu_system_on, system_on)
        set(apu_n1, RPM)
        set(apu_air_doors, bleed_doors_pos)
        set(apu_doors, apu_doors_pos)
        set(apu_oil_t, oil_temp)
        set(apu_oil_q, oil_q)
		set(apu_oil_p, oil_press_sim)
        set(apu_egt, egt_current)
        set(apu_fuel_p, fuel_press)
        set(apu_start_cc, start_current)
        set(fuel_pumps_27_cc, fuel_current)
        set(apu_burn_fuel, apu_burning_fuel_val)
    end
end
        
