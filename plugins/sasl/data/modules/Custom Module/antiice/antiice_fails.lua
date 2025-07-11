-- failures_logic_antiice.lua (optimized)
-- Handles random & dependent failures for anti-ice and heating systems

defineProperty("failures_enabled", globalPropertyi("tu154ce/failures/failures_enabled"))
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time"))
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))

-- Failures
defineProperty("ppd_3_heat_fail", globalPropertyi("tu154ce/antiice/ppd_3_heat_fail"))
defineProperty("rel_ice_inlet_heat1", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat"))
defineProperty("rel_ice_inlet_heat2", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat2"))
defineProperty("rel_ice_inlet_heat3", globalPropertyi("sim/operation/failures/rel_ice_inlet_heat3"))
defineProperty("rel_ice_pitot_heat1", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat1"))
defineProperty("rel_ice_pitot_heat2", globalPropertyi("sim/operation/failures/rel_ice_pitot_heat2"))
defineProperty("rel_ice_surf_heat", globalPropertyi("sim/operation/failures/rel_ice_surf_heat"))
defineProperty("rel_ice_surf_heat2", globalPropertyi("sim/operation/failures/rel_ice_surf_heat2"))
defineProperty("rio_fail", globalPropertyi("tu154ce/failures/rio_fail"))
defineProperty("window_heat_fail_1", globalPropertyi("tu154ce/failures/window_heat_fail_1"))
defineProperty("window_heat_fail_2", globalPropertyi("tu154ce/failures/window_heat_fail_2"))
defineProperty("window_heat_fail_3", globalPropertyi("tu154ce/failures/window_heat_fail_3"))

defineProperty("deflection_mtr_2", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("deflection_mtr_3", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))

-- Helper: boolean to integer
local function bool2int(val) return val and 1 or 0 end

local fail_counter = 0
local check_time = math.random(15, 30)
local ppd1_counter, ppd2_counter, ppd3_counter = 0, 0, 0
local wing_counter, stab_counter = 0, 0

function update()
    local passed = get(frame_time)
    if get(ismaster) ~= 1 then
        local FAIL = get(failures_enabled)
        FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
        if FAIL > 0 then
            fail_counter = fail_counter + passed
            if fail_counter > check_time then
                fail_counter = 0
                check_time = math.random(15, 30)
                -- Basic random failures
                if get(rel_ice_inlet_heat1) ~= 6 then set(rel_ice_inlet_heat1, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_ice_inlet_heat2) ~= 6 then set(rel_ice_inlet_heat2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_ice_inlet_heat3) ~= 6 then set(rel_ice_inlet_heat3, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_ice_pitot_heat1) ~= 6 then set(rel_ice_pitot_heat1, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_ice_pitot_heat2) ~= 6 then set(rel_ice_pitot_heat2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(ppd_3_heat_fail) ~= 6 then set(ppd_3_heat_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_ice_surf_heat) ~= 6 then set(rel_ice_surf_heat, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rel_ice_surf_heat2) ~= 6 then set(rel_ice_surf_heat2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 6) end
                if get(rio_fail) ~= 1 then set(rio_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
                if get(window_heat_fail_1) ~= 1 then set(window_heat_fail_1, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
                if get(window_heat_fail_2) ~= 1 then set(window_heat_fail_2, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
                if get(window_heat_fail_3) ~= 1 then set(window_heat_fail_3, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
                -- Dependent failures ("overheat"/"wear")
                if ppd1_counter > 1200 and get(rel_ice_pitot_heat1) ~= 6 then set(rel_ice_pitot_heat1, bool2int(math.random() < 0.1 * FAIL * 0.3) * 6) end
                if ppd2_counter > 1200 and get(rel_ice_pitot_heat2) ~= 6 then set(rel_ice_pitot_heat2, bool2int(math.random() < 0.1 * FAIL * 0.3) * 6) end
                if ppd3_counter > 1200 and get(ppd_3_heat_fail) ~= 6 then set(ppd_3_heat_fail, bool2int(math.random() < 0.1 * FAIL * 0.3) * 6) end
                if wing_counter > 90 and get(rel_ice_surf_heat) ~= 6 then set(rel_ice_surf_heat, bool2int(math.random() < 0.3 * FAIL * 0.3) * 6) end
                if stab_counter > 90 and get(rel_ice_surf_heat2) ~= 6 then set(rel_ice_surf_heat2, bool2int(math.random() < 0.3 * FAIL * 0.3) * 6) end
            end
            -- Counters increment while on ground (gear compressed)
            if get(deflection_mtr_2) + get(deflection_mtr_3) < 0.02 then
                ppd1_counter = ppd1_counter + passed
                ppd2_counter = ppd2_counter + passed
                ppd3_counter = ppd3_counter + passed
                wing_counter = wing_counter + passed
                stab_counter = stab_counter + passed
            else
                ppd1_counter, ppd2_counter, ppd3_counter = 0, 0, 0
                wing_counter, stab_counter = 0, 0
            end
        else
            fail_counter = 0
            -- Reset all failures when not enabled
            set(ppd_3_heat_fail, 0)
            set(rel_ice_inlet_heat1, 0)
            set(rel_ice_inlet_heat2, 0)
            set(rel_ice_inlet_heat3, 0)
            set(rel_ice_pitot_heat1, 0)
            set(rel_ice_pitot_heat2, 0)
            set(rel_ice_surf_heat, 0)
            set(rel_ice_surf_heat2, 0)
            set(rio_fail, 0)
            set(window_heat_fail_1, 0)
            set(window_heat_fail_2, 0)
            set(window_heat_fail_3, 0)
            -- Reset all counters
            ppd1_counter, ppd2_counter, ppd3_counter = 0, 0, 0
            wing_counter, stab_counter = 0, 0
        end
    end
end
