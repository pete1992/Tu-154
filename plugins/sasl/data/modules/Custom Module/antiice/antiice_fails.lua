-- antiice_fails.lua

-- Smartcopilot
defineProperty("ismaster",    globalPropertyf("scp/api/ismaster"))

-- Helper to register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register all other DataRefs
defineProps({
    {"failures_enabled",    "tu154ce/failures/failures_enabled",  globalPropertyi},
    {"frame_time",          "tu154ce/time/frame_time",            globalPropertyf},
    {"ppd_3_heat_fail",     "tu154ce/antiice/ppd_3_heat_fail",    globalPropertyi},
    {"rel_ice_inlet_heat1", "sim/operation/failures/rel_ice_inlet_heat",  globalPropertyi},
    {"rel_ice_inlet_heat2", "sim/operation/failures/rel_ice_inlet_heat2", globalPropertyi},
    {"rel_ice_inlet_heat3", "sim/operation/failures/rel_ice_inlet_heat3", globalPropertyi},
    {"rel_ice_pitot_heat1", "sim/operation/failures/rel_ice_pitot_heat1", globalPropertyi},
    {"rel_ice_pitot_heat2", "sim/operation/failures/rel_ice_pitot_heat2", globalPropertyi},
    {"rel_ice_surf_heat",   "sim/operation/failures/rel_ice_surf_heat",   globalPropertyi},
    {"rel_ice_surf_heat2",  "sim/operation/failures/rel_ice_surf_heat2",  globalPropertyi},
    {"rio_fail",            "tu154ce/failures/rio_fail",           globalPropertyi},
    {"window_heat_fail_1",  "tu154ce/failures/window_heat_fail_1", globalPropertyi},
    {"window_heat_fail_2",  "tu154ce/failures/window_heat_fail_2", globalPropertyi},
    {"window_heat_fail_3",  "tu154ce/failures/window_heat_fail_3", globalPropertyi},
})

local tireDeflection = globalPropertyfa("sim/flightmodel2/gear/tire_vertical_deflection_mtr")

-- Convert boolean to integer
local function bool2int(b) return b and 1 or 0 end

-- Internal state
local fail_counter  = 0
local check_time    = math.random(15, 30)
local ppd_counters  = {pitot1 = 0, pitot2 = 0, ppd3 = 0}
local surf_counters = {wing = 0, stab = 0}

function update()
    local dt = get(frame_time)

    -- Only run on non-master instances
    if get(ismaster) == 1 then
        -- Reset if master
        fail_counter = 0
        ppd_counters = {pitot1 = 0, pitot2 = 0, ppd3 = 0}
        surf_counters = {wing = 0, stab = 0}
        return
    end

    local F    = get(failures_enabled)
    local prob = F * 0.05 * 4^(F * 0.5)

    if prob > 0 then
        -- Periodic random failure checks
        fail_counter = fail_counter + dt
        if fail_counter > check_time then
            fail_counter = 0
            check_time = math.random(15, 30)
            local function tryFail(ref, scale, duration)
                if get(ref) ~= 1 and math.random() < 1e-5 * prob * scale then
                    set(ref, duration)
                end
            end
            tryFail(rel_ice_inlet_heat1, 0.3, 6)
            tryFail(rel_ice_inlet_heat2, 0.3, 6)
            tryFail(rel_ice_inlet_heat3, 0.3, 6)
            tryFail(rel_ice_pitot_heat1, 0.3, 6)
            tryFail(rel_ice_pitot_heat2, 0.3, 6)
            tryFail(ppd_3_heat_fail,    0.3, 1)
            tryFail(rel_ice_surf_heat,  0.3, 6)
            tryFail(rel_ice_surf_heat2, 0.3, 6)
            tryFail(rio_fail,           0.3, 1)
            tryFail(window_heat_fail_1, 0.3, 1)
            tryFail(window_heat_fail_2, 0.3, 1)
            tryFail(window_heat_fail_3, 0.3, 1)
        end

        -- Track how long the aircraft is stationary on tires 2 & 3
		local tireDefl2 = tonumber(get(tireDeflection, 1)) or 0
		local tireDefl3 = tonumber(get(tireDeflection, 2)) or 0
        if tireDefl2 + tireDefl3 < 0.02 then
            ppd_counters.pitot1 = ppd_counters.pitot1 + dt
            ppd_counters.pitot2 = ppd_counters.pitot2 + dt
            ppd_counters.ppd3   = ppd_counters.ppd3   + dt
            surf_counters.wing  = surf_counters.wing  + dt
            surf_counters.stab  = surf_counters.stab  + dt
        else
            -- Reset counters when moving
            ppd_counters = {pitot1 = 0, pitot2 = 0, ppd3 = 0}
            surf_counters = {wing = 0, stab = 0}
        end

        -- Long-duration failure conditions
        if ppd_counters.pitot1 > 1200 and get(rel_ice_pitot_heat1) ~= 6 then
            set(rel_ice_pitot_heat1, bool2int(math.random() < 0.1 * prob * 0.3) * 6)
        end
        if ppd_counters.pitot2 > 1200 and get(rel_ice_pitot_heat2) ~= 6 then
            set(rel_ice_pitot_heat2, bool2int(math.random() < 0.1 * prob * 0.3) * 6)
        end
		if ppd_counters.ppd3 > 1200 and get(ppd_3_heat_fail) ~= 6 then
			set(ppd_3_heat_fail, bool2int(math.random() < 0.1 * prob * 0.3) * 6)
		end
        if surf_counters.wing > 90 and get(rel_ice_surf_heat) ~= 6 then
            set(rel_ice_surf_heat, bool2int(math.random() < 0.3 * prob * 0.3) * 6)
        end
        if surf_counters.stab > 90 and get(rel_ice_surf_heat2) ~= 6 then
            set(rel_ice_surf_heat2, bool2int(math.random() < 0.3 * prob * 0.3) * 6)
        end

    else
        -- Failures disabled: reset everything
        fail_counter = 0
        ppd_counters = {pitot1 = 0, pitot2 = 0, ppd3 = 0}
        surf_counters = {wing = 0, stab = 0}
        for _, ref in ipairs({
            ppd_3_heat_fail,
            rel_ice_inlet_heat1, rel_ice_inlet_heat2, rel_ice_inlet_heat3,
            rel_ice_pitot_heat1, rel_ice_pitot_heat2,
            rel_ice_surf_heat, rel_ice_surf_heat2,
            rio_fail,
            window_heat_fail_1, window_heat_fail_2, window_heat_fail_3
        }) do
            set(ref, 0)
        end
    end
end
