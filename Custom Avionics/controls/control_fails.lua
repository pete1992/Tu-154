-- control_fails.lua

-- Smartcopilot
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))

-- Batch DataRef registration
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
		{"failures_enabled", "sim/custom/failures/failures_enabled", globalPropertyi},
		{"frame_time", "sim/custom/time/frame_time", globalPropertyf},
		{"flap_fail_left", "sim/custom/failures/flap_fail_left", globalPropertyi},
		{"flap_fail_right", "sim/custom/failures/flap_fail_right", globalPropertyi},
		{"stab_eng_fail", "sim/custom/failures/stab_eng_fail", globalPropertyi},
		{"stab_automatic_fail", "sim/custom/failures/stab_automatic_fail", globalPropertyi},
		{"slats_fail", "sim/custom/failures/slats_fail", globalPropertyi},
		{"ail_fail_left", "sim/custom/failures/ail_fail_left", globalPropertyi},
		{"ail_fail_right", "sim/custom/failures/ail_fail_right", globalPropertyi},
		{"fail_spoil_inn_left", "sim/custom/failures/fail_spoil_inn_left", globalPropertyi},
		{"fail_spoil_inn_right", "sim/custom/failures/fail_spoil_inn_right",    globalPropertyi},
		{"fail_spoil_mid_left", "sim/custom/failures/fail_spoil_mid_left", globalPropertyi},
		{"fail_spoil_mid_right", "sim/custom/failures/fail_spoil_mid_right",    globalPropertyi},
		{"fail_spoil_out_left", "sim/custom/failures/fail_spoil_out_left", globalPropertyi},
		{"fail_spoil_out_right", "sim/custom/failures/fail_spoil_out_right",    globalPropertyi},
		{"rudder_fail", "sim/custom/failures/rudder_fail", globalPropertyi},
		{"elev_fail_left", "sim/custom/failures/elev_fail_left", globalPropertyi},
		{"elev_fail_right", "sim/custom/failures/elev_fail_right", globalPropertyi},
		{"retract1_fail", "sim/operation/failures/rel_lagear1", globalPropertyi},
		{"retract2_fail", "sim/operation/failures/rel_lagear2", globalPropertyi},
		{"retract3_fail", "sim/operation/failures/rel_lagear3", globalPropertyi},
		{"actuator_fail", "sim/operation/failures/rel_gear_act", globalPropertyi},
		{"rel_collapse1", "sim/operation/failures/rel_collapse1", globalPropertyi},
		{"rel_collapse2", "sim/operation/failures/rel_collapse2", globalPropertyi},
		{"rel_collapse3", "sim/operation/failures/rel_collapse3", globalPropertyi},
		{"rel_trim_rud", "sim/operation/failures/rel_trim_rud", globalPropertyi},
		{"rel_trim_ail", "sim/operation/failures/rel_trim_ail", globalPropertyi},
		{"rel_trim_elv", "sim/operation/failures/rel_trim_elv", globalPropertyi},
		{"trim_emerg_elv_fail", "sim/custom/failures/trim_emerg_elv_fail", globalPropertyi},
		{"rel_tire1", "sim/operation/failures/rel_tire1", globalPropertyi},
		{"rel_tire2", "sim/operation/failures/rel_tire2", globalPropertyi},
		{"rel_tire3", "sim/operation/failures/rel_tire3", globalPropertyi},
		{"rel_tire4", "sim/operation/failures/rel_tire4", globalPropertyi},
		{"rel_tire5", "sim/operation/failures/rel_tire5", globalPropertyi},
		{"ias", "sim/flightmodel/position/indicated_airspeed", globalPropertyf},
		{"flap_inn_L", "sim/flightmodel/controls/wing1l_fla1def", globalPropertyf},
		{"flap_inn_R", "sim/flightmodel/controls/wing1r_fla1def", globalPropertyf},
		{"slats", "sim/flightmodel2/controls/slat1_deploy_ratio",globalPropertyf},
		{"stab_ratio", "sim/cockpit2/controls/elevator_trim", globalPropertyf},
		{"gear1_deploy", "sim/aircraft/parts/acf_gear_deploy[0]", globalPropertyf},
		{"gear2_deploy", "sim/aircraft/parts/acf_gear_deploy[1]", globalPropertyf},
		{"gear3_deploy", "sim/aircraft/parts/acf_gear_deploy[2]", globalPropertyf},
})

-- Utility: boolean to integer
local function bool2int(v) return v and 1 or 0 end

-- Flap limit table & interpolation helper
local flap_lim_tbl = {
    {-100, 1e6}, {0, 1e6}, {1, 600},
    {15, 420},  {28, 360}, {36, 330},
    {45, 300},  {100,300},
}

local function interpolate(tbl, x)
    if x <= tbl[1][1] then return tbl[1][2] end
    for i = 1, #tbl-1 do
        local x0,y0 = tbl[i][1], tbl[i][2]
        local x1,y1 = tbl[i+1][1], tbl[i+1][2]
        if x <= x1 then
            local t = (x - x0) / (x1 - x0)
            return y0 + (y1 - y0) * t
        end
    end
    return tbl[#tbl][2]
end

-- Initial failure state
local fail_counter = 0
local check_time   = math.random(15, 30)

-- Counters & last-values
local stab_counter = 1
local slat_counter = 1
local stab_last    = get(stab_ratio)
local slat_last    = get(slats)
local gear_last_1  = get(gear1_deploy)
local gear_last_2  = get(gear2_deploy)
local gear_last_3  = get(gear3_deploy)

-- Main update loop
function update()
    local passed = get(frame_time)

    -- Only run failures if this is not the Smartcopilot master
    if get(ismaster) ~= 1 then
        local FAIL = get(failures_enabled)
        FAIL = FAIL * 0.05 * 4^(FAIL * 0.5)

        if FAIL > 0 then
            -- --- Periodic random failures for control surfaces ---
            fail_counter = fail_counter + passed
            if fail_counter > check_time then
                fail_counter = 0
                check_time   = math.random(15, 30)

                -- Flap failures (left/right)
                if get(flap_fail_left)  ~= 1 then
                    set(flap_fail_left,  bool2int(math.random() < 1e-5 * FAIL * 0.3))
                end
                if get(flap_fail_right) ~= 1 then
                    set(flap_fail_right, bool2int(math.random() < 1e-5 * FAIL * 0.3))
                end

                -- Stabilizer engine failure (level 1 or 2)
                local s1 = bool2int(get(stab_eng_fail) >= 1)
                local s2 = bool2int(get(stab_eng_fail) == 2)
                if s1 ~= 1 then s1 = bool2int(math.random() < 1e-5 * FAIL * 0.3 * stab_counter) end
                if s2 ~= 1 then s2 = bool2int(math.random() < 1e-5 * FAIL * 0.3 * stab_counter) end
                set(stab_eng_fail, s1 + s2)

                -- Automatic stabilizer failure
                if get(stab_automatic_fail) ~= 1 then
                    set(stab_automatic_fail, bool2int(math.random() < 1e-5 * FAIL * 0.3))
                end

                -- Slat failures (level 1 or 2)
                local l1 = bool2int(get(slats_fail) >= 1)
                local l2 = bool2int(get(slats_fail) == 2)
                if l1 ~= 1 then l1 = bool2int(math.random() < 1e-5 * FAIL * 0.3 * slat_counter) end
                if l2 ~= 1 then l2 = bool2int(math.random() < 1e-5 * FAIL * 0.3 * slat_counter) end
                set(slats_fail, l1 + l2)

                -- Control surface random failures
                local ctrlFails = {
                    "ail_fail_left","ail_fail_right",
                    "fail_spoil_inn_left","fail_spoil_inn_right",
                    "fail_spoil_mid_left","fail_spoil_mid_right",
                    "fail_spoil_out_left","fail_spoil_out_right",
                    "rudder_fail","elev_fail_left","elev_fail_right"
                }
                for _, prop in ipairs(ctrlFails) do
                    if get(_G[prop]) ~= 1 then
                        set(_G[prop], bool2int(math.random() < 1e-5 * FAIL * 0.3))
                    end
                end

                -- Gear and trim failures
                local gearActors = {"retract1_fail","retract2_fail","retract3_fail","actuator_fail"}
                for _, prop in ipairs(gearActors) do
                    if get(_G[prop]) ~= 6 then
                        set(_G[prop], bool2int(math.random() < 1e-5 * FAIL * 0.3) * 6)
                    end
                end
                local trimActors = {"rel_trim_rud","rel_trim_ail","rel_trim_elv"}
                for _, prop in ipairs(trimActors) do
                    if get(_G[prop]) ~= 6 then
                        set(_G[prop], bool2int(math.random() < 1e-5 * FAIL * 0.3) * 6)
                    end
                end
                if get(trim_emerg_elv_fail) ~= 1 then
                    set(trim_emerg_elv_fail, bool2int(math.random() < 1e-5 * FAIL * 0.3))
                end
            end

            -- --- Overspeed logic for control surfaces (per frame) ---
            local airspeed = get(ias) * 1.852

            -- Flap overspeed check
            for _, side in ipairs({"flap_inn_L","flap_inn_R"}) do
                local def = get(_G[side])
                local lim = interpolate(flap_lim_tbl, def) + (3 - FAIL) * 20
                local prop = (side == "flap_inn_L" and flap_fail_left or flap_fail_right)
                if airspeed > lim and get(prop) ~= 1 then
                    set(prop, bool2int(math.random() < 0.1 * FAIL * 0.3))
                end
            end

            -- Slats overspeed check
            local l1 = bool2int(get(slats_fail) >= 1)
            local l2 = bool2int(get(slats_fail) == 2)
            if airspeed > 430 + (3 - FAIL) * 20 and get(slats) > 0.5 then
                if l1 ~= 1 then l1 = bool2int(math.random() < 0.1 * FAIL * 0.3) end
                if l2 ~= 1 then l2 = bool2int(math.random() < 0.1 * FAIL * 0.3) end
                set(slats_fail, l1 + l2)
            end

            -- Counter update based on movement
            slat_counter = math.max(1, slat_counter + ((slat_last ~= get(slats) and FAIL * 0.5 or 0) - 0.7) * passed * 0.2)
            slat_last    = get(slats)
            stab_counter = math.max(1, stab_counter + ((stab_last ~= get(stab_ratio) and FAIL * 0.5 or 0) - 0.7) * passed * 0.2)
            stab_last    = get(stab_ratio)

            -- Gear collapse overspeed check
            for idx, g in ipairs({"gear1_deploy","gear2_deploy","gear3_deploy"}) do
                local last = (idx == 1 and gear_last_1) or (idx == 2 and gear_last_2) or gear_last_3
                local prop = (idx == 1 and retract1_fail) or (idx == 2 and retract2_fail) or retract3_fail
                local thresh = 450 + (3 - FAIL) * 20 + (idx - 1) * 10
                if airspeed > thresh and get(_G[g]) < last and get(prop) ~= 6 then
                    set(prop, bool2int(math.random() < 0.1 * FAIL * 0.3) * 6)
                end
            end
            gear_last_1 = get(gear1_deploy)
            gear_last_2 = get(gear2_deploy)
            gear_last_3 = get(gear3_deploy)
        else
            -- --- Reset all failures if disabled ---
            fail_counter, slat_counter, stab_counter = 0, 1, 1
            local allFails = {
                "flap_fail_left","flap_fail_right","stab_eng_fail","stab_automatic_fail",
                "slats_fail","ail_fail_left","ail_fail_right","fail_spoil_inn_left",
                "fail_spoil_inn_right","fail_spoil_mid_left","fail_spoil_mid_right",
                "fail_spoil_out_left","fail_spoil_out_right","rudder_fail","elev_fail_left",
                "elev_fail_right","retract1_fail","retract2_fail","retract3_fail",
                "actuator_fail","rel_collapse1","rel_collapse2","rel_collapse3",
                "rel_trim_rud","rel_trim_ail","rel_trim_elv","trim_emerg_elv_fail",
                "rel_tire1","rel_tire2","rel_tire3","rel_tire4","rel_tire5"
            }
            for _, prop in ipairs(allFails) do
                set(_G[prop], 0)
            end
        end
    end
end
