-- eng_fails.lua
-- Engine failure and wear simulation for Tu-154M
-- Utility functions ------------------------------------------------------
local function clamp(x, minv, maxv)
    if x < minv then return minv end
    if x > maxv then return maxv end
    return x
end
local function bool2int(b) return b and 1 or 0 end
local function interpolate(tbl, val)
    for i = 2, #tbl do
        if val < tbl[i][1] then
            local x1,y1 = tbl[i-1][1], tbl[i-1][2]
            local x2,y2 = tbl[i][1],   tbl[i][2]
            return y1 + (val - x1)*(y2 - y1)/(x2 - x1)
        end
    end
    return tbl[#tbl][2]
end
-- Batch DataRef definitions
-- Batch DataRef definitions ---------------------------------------------
local props = {
    -- Engine runtimes & oil quantities
    { "engine_runtime_1",      "tu154ce/failures/engine_runtime_1",      "f" },
    { "engine_runtime_2",      "tu154ce/failures/engine_runtime_2",      "f" },
    { "engine_runtime_3",      "tu154ce/failures/engine_runtime_3",      "f" },
    { "engn_oil_qty_1",        "tu154ce/failures/engn_oil_qty_1",        "f" },
    { "engn_oil_qty_2",        "tu154ce/failures/engn_oil_qty_2",        "f" },
    { "engn_oil_qty_3",        "tu154ce/failures/engn_oil_qty_3",        "f" },
    -- Binary failures
    { "engn_oil_leak_1",       "tu154ce/failures/engn_oil_leak_1",       "i" },
    { "engn_oil_leak_2",       "tu154ce/failures/engn_oil_leak_2",       "i" },
    { "engn_oil_leak_3",       "tu154ce/failures/engn_oil_leak_3",       "i" },
    { "oil_pump_fail_1",       "sim/operation/failures/rel_oilpmp0",     "i" },
    { "oil_pump_fail_2",       "sim/operation/failures/rel_oilpmp1",     "i" },
    { "oil_pump_fail_3",       "sim/operation/failures/rel_oilpmp2",     "i" },
    { "fuel_flowmeter_1_fail", "tu154ce/failures/fuel_flowmeter_1_fail", "i" },
    { "fuel_flowmeter_2_fail", "tu154ce/failures/fuel_flowmeter_2_fail", "i" },
    { "fuel_flowmeter_3_fail", "tu154ce/failures/fuel_flowmeter_3_fail", "i" },
    { "eng_fail_1",            "sim/operation/failures/rel_engfai0",     "i" },
    { "eng_fail_2",            "sim/operation/failures/rel_engfai1",     "i" },
    { "eng_fail_3",            "sim/operation/failures/rel_engfai2",     "i" },
    { "eng_fire_1",            "sim/operation/failures/rel_engfir0",     "i" },
    { "eng_fire_2",            "sim/operation/failures/rel_engfir1",     "i" },
    { "eng_fire_3",            "sim/operation/failures/rel_engfir2",     "i" },
    { "eng_flame_1",           "sim/operation/failures/rel_engfla0",     "i" },
    { "eng_flame_2",           "sim/operation/failures/rel_engfla1",     "i" },
    { "eng_flame_3",           "sim/operation/failures/rel_engfla2",     "i" },
    { "eng_stall_1",           "sim/operation/failures/rel_comsta0",     "i" },
    { "eng_stall_2",           "sim/operation/failures/rel_comsta1",     "i" },
    { "eng_stall_3",           "sim/operation/failures/rel_comsta2",     "i" },
    { "eng_fuel_pmp_fail_1",   "tu154ce/failures/eng_fuel_pmp_fail_1",   "i" },
    { "eng_fuel_pmp_fail_2",   "tu154ce/failures/eng_fuel_pmp_fail_2",   "i" },
    { "eng_fuel_pmp_fail_3",   "tu154ce/failures/eng_fuel_pmp_fail_3",   "i" },
    { "eng_filter_1",          "sim/operation/failures/rel_eng_lo0",     "i" },
    { "eng_filter_2",          "sim/operation/failures/rel_eng_lo1",     "i" },
    { "eng_filter_3",          "sim/operation/failures/rel_eng_lo2",     "i" },
    { "eng_start_1",           "sim/operation/failures/rel_startr0",     "i" },
    { "eng_start_2",           "sim/operation/failures/rel_startr1",     "i" },
    { "eng_start_3",           "sim/operation/failures/rel_startr2",     "i" },
    { "eng_ign_1",             "sim/operation/failures/rel_ignitr0",     "i" },
    { "eng_ign_2",             "sim/operation/failures/rel_ignitr1",     "i" },
    { "eng_ign_3",             "sim/operation/failures/rel_ignitr2",     "i" },
    { "eng_revrs_1",           "sim/operation/failures/rel_revers0",     "i" },
    { "eng_revrs_3",           "sim/operation/failures/rel_revers2",     "i" },
    -- Sim oil quantity indicators
    { "ENGN_oil_q_1",          "sim/flightmodel/engine/ENGN_oil_quan[0]","f" },
    { "ENGN_oil_q_2",          "sim/flightmodel/engine/ENGN_oil_quan[1]","f" },
    { "ENGN_oil_q_3",          "sim/flightmodel/engine/ENGN_oil_quan[2]","f" },
    -- Engine parameters
    { "sim_egt_1",             "sim/cockpit2/engine/indicators/EGT_deg_C[0]","f" },
    { "sim_egt_2",             "sim/cockpit2/engine/indicators/EGT_deg_C[1]","f" },
    { "sim_egt_3",             "sim/cockpit2/engine/indicators/EGT_deg_C[2]","f" },
    { "rpm_high_1",            "tu154ce/gauges/engine/rpm_high_1",       "f" },
    { "rpm_high_2",            "tu154ce/gauges/engine/rpm_high_2",       "f" },
    { "rpm_high_3",            "tu154ce/gauges/engine/rpm_high_3",       "f" },
    { "eng_work_1",            "sim/flightmodel2/engines/engine_is_burning_fuel[0]","f" },
    { "eng_work_2",            "sim/flightmodel2/engines/engine_is_burning_fuel[1]","f" },
    { "eng_work_3",            "sim/flightmodel2/engines/engine_is_burning_fuel[2]","f" },
    -- Flight environment & control
    { "alpha",                 "sim/flightmodel2/misc/AoA_angle_degrees","f" },
    { "msl_alt",               "sim/flightmodel/position/elevation",    "f" },
    { "msl_press",             "sim/weather/barometer_sealevel_inhg",   "f" },
    { "pressure",              "tu154ce/gauges/alt/vbe_press_left",     "f" },
    { "failures_enabled",      "tu154ce/failures/failures_enabled",     "i" },
    { "frame_time",            "tu154ce/time/frame_time",               "f" },
    -- SmartCopilot
    { "ismaster",              "scp/api/ismaster",                      "f" },
}
for _, p in ipairs(props) do
    if p[3] == "f" then
        defineProperty(p[1], globalPropertyf(p[2]))
    else
        defineProperty(p[1], globalPropertyi(p[2]))
    end
end
-- Pre-flight: Runtime und Ölmenge initialisieren
local last_time         = get(frame_time)
local minusTimer1, minusTimer2, minusTimer3 = 0, 0, 0
local oilLeak = {math.random(20,100), math.random(20,100), math.random(20,100)}
local fail_counter, stall_counter = 0, 0
local check_time = math.random(15,30)
local stall_time = math.random()
-- Failure pattern definition
local failPatterns = {
    {fmt="engn_oil_leak_%d",       multi=1, engines={1,2,3}},
    {fmt="oil_pump_fail_%d",       multi=6, engines={1,2,3}},
    {fmt="fuel_flowmeter_%d_fail", multi=1, engines={1,2,3}},
    {fmt="eng_fail_%d",            multi=6, engines={1,2,3}},
    {fmt="eng_fire_%d",            multi=6, engines={1,2,3}},
    {fmt="eng_flame_%d",           multi=6, engines={1,2,3}},
    {fmt="eng_stall_%d",           multi=6, engines={1,2,3}},
    {fmt="eng_fuel_pmp_fail_%d",   multi=1, engines={1,2,3}},
    {fmt="eng_filter_%d",          multi=6, engines={1,2,3}},
    {fmt="eng_start_%d",           multi=6, engines={1,2,3}},
    {fmt="eng_ign_%d",             multi=6, engines={1,2,3}},
    {fmt="eng_revrs_%d",           multi=6, engines={1,3}},
}
function onAvionicsDone()
    for _, pat in ipairs(failPatterns) do
        for _, i in ipairs(pat.engines) do
            set(string.format(pat.fmt, i), 0)
        end
    end
    print("engine failures reset")
end
function update()
    local now    = get(frame_time)
    local passed = now - last_time
    last_time    = now
    local sc     = get(ismaster)
    local MASTER = (sc == 2) or (sc == 0)
    if MASTER then
        local FAIL = get(failures_enabled)
        FAIL = FAIL * 0.05 * (4 ^ (FAIL * 0.5))
        -- Stall checks
        stall_counter = (stall_counter or 0) + passed
        if stall_counter > stall_time then
            stall_counter = 0
            stall_time    = math.random()
            local aoa      = math.max(0, math.abs(get(alpha)-2) - 10)
            local AOA_coef = math.min(1, math.tan(math.rad(aoa)) / 5.671)
            local alt_ft   = get(msl_alt)*3.28083 +
                             (get(pressure)*0.02953 - get(msl_press))*1000
            local alt_m    = alt_ft * 0.3048
            local ALT_coef = math.max(0, alt_m - 8000) / 10000
            for i=1,3 do
                if get("eng_work_"..i) == 1 then
                    local rpm_coef = math.max(0, get("rpm_high_"..i)*0.01 - 0.7)*3
                    local p = bool2int(math.random() < AOA_coef*ALT_coef*rpm_coef*FAIL)
                    set("eng_stall_"..i, p*6)
                end
            end
        end
        -- Random failures
        fail_counter = (fail_counter or 0) + passed
        if fail_counter > check_time then
            fail_counter = 0
            check_time   = math.random(15,30)
            for _, pat in ipairs(failPatterns) do
                local prob = 0.00001 * FAIL * 0.3
                for _, i in ipairs(pat.engines) do
                    local dr = string.format(pat.fmt, i)
                    if get(dr) == 0 and math.random() < prob then
                        set(dr, pat.multi)
                    end
                end
            end
        end
        -- Oil usage, leaks, and sync to sim
        for i=1,3 do
            local qty = get("engn_oil_qty_"..i)
            qty = qty - get("rpm_high_"..i)*0.01*passed/3600
            qty = qty - get("engn_oil_leak_"..i)*passed/3600*oilLeak[i]
            set("engn_oil_qty_"..i, math.max(0, qty))
            -- Fail oil pump if oil too low and engine running
            if qty < 4 and get("rpm_high_"..i) > 20 then
                set("oil_pump_fail_"..i, 6)
            end
            -- Sync to sim dataref
            set("ENGN_oil_q_"..i, clamp((qty-4)/23, 0, 1))
        end
        -- Engine runtime decrement
        for i=1,3 do
            local dec = interpolate({{-1000,0},{0,0.5},{30,1},{90,1},{100,2},{1000,10}}, get("rpm_high_"..i))
            if i==1 then
                minusTimer1 = minusTimer1 + dec*passed
                if minusTimer1 >= 1 then
                    minusTimer1 = minusTimer1 - 1
                    set("engine_runtime_1", math.max(0, get("engine_runtime_1")-1))
                end
            elseif i==2 then
                minusTimer2 = minusTimer2 + dec*passed
                if minusTimer2 >= 1 then
                    minusTimer2 = minusTimer2 - 1
                    set("engine_runtime_2", math.max(0, get("engine_runtime_2")-1))
                end
            else
                minusTimer3 = minusTimer3 + dec*passed
                if minusTimer3 >= 1 then
                    minusTimer3 = minusTimer3 - 1
                    set("engine_runtime_3", math.max(0, get("engine_runtime_3")-1))
                end
            end
        end
    else
        -- Slave: avoid runaway counters
        fail_counter, stall_counter = 0, 0
    end
end
