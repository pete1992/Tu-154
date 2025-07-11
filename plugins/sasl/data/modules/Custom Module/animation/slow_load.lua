-- slow_load.lua (optimized)
-- Handles slow load animation for fuel and payload

-- Properties
defineProperty("frame_time",         globalPropertyf("tu154ce/time/frame_time"))
defineProperty("load_slow_btn",      globalPropertyi("tu154ce/payload/load_slow_btn"))

defineProperty("tank_pr",            globalPropertyi("tu154ce/payload/tank_1"))
-- payload tanks 1,4,2L,2R,3L,3R
for i,ref in ipairs({"tank_1_pr","tank_4_pr","tank_2L_pr","tank_2R_pr","tank_3L_pr","tank_3R_pr"}) do
    defineProperty(ref, globalPropertyi("tu154ce/payload/"..ref))
end

defineProperty("gear_blocks",        globalPropertyi("tu154ce/anim/gear_blocks"))
defineProperty("fuel_tanker_call",   globalPropertyi("tu154ce/anim/fuel_tanker_call"))
defineProperty("fuel_tanker",        globalPropertyf("tu154ce/anim/fuel_tanker"))

defineProperty("payload_wt",         globalPropertyf("sim/flightmodel/weight/m_fixed"))
defineProperty("cg_load",            globalPropertyf("sim/flightmodel/misc/cgz_ref_to_default"))
defineProperty("cg_set",             globalPropertyf("tu154ce/payload/cg_set"))

defineProperty("fuel_q",             globalPropertyf("sim/flightmodel/weight/m_fuel[0]"))
-- fuel quantities for tanks 1-5
for i=1,6 do
    defineProperty("fuel_q_"..i, globalPropertyf("sim/flightmodel/weight/m_fuel["..(i-1).."]"))
end

defineProperty("payload_set",        globalPropertyf("tu154ce/payload/paylod_set"))

defineProperty("slider_5",           globalProperty("sim/cockpit2/switches/custom_slider_on[4]")) -- pax door slider

-- Constants for load rates
local FUEL_RATE = 64          -- kg/s per pump
local CARGO_RATE = 33.3333    -- kg/s

-- State
local load_started = false
local cg_recorded  = false
local cg_old, cg_target
local timer = 0

-- Helpers
local function sum_props(props)
    local sum = 0
    for _, p in ipairs(props) do sum = sum + get(p) end
    return sum
end

local function clamp(v, minv, maxv)
    return v < minv and minv or v > maxv and maxv or v
end

-- Determine if any tank requires loading
local function check_fuel_needed()
    local pr_refs = {"tank_1_pr","tank_4_pr","tank_2L_pr","tank_2R_pr","tank_3L_pr","tank_3R_pr"}
    local q_refs  = {"fuel_q","fuel_q_4","fuel_q_2R","fuel_q_2L","fuel_q_3R","fuel_q_3L"}
    return sum_props(pr_refs) > sum_props(q_refs)
end

-- Fuel loading stages definition
local stages = {
    -- {predicate, volume_limit}
    { {"tank_1_pr"}, 3300 },
    { {"tank_3L_pr","tank_3R_pr"}, 1725 },
    { {"tank_3L_pr","tank_3R_pr","tank_2L_pr","tank_2R_pr"}, 5405 },
    { {"tank_2L_pr","tank_2R_pr"}, 3700 },
    { {"tank_2L_pr","tank_2R_pr"}, 9500 },
    { {"tank_4_pr"}, 6598 }
}

-- Perform fuel load by stage
local function load_fuel(dt)
    if get(fuel_tanker) ~= 0 then return end
    for _, stage in ipairs(stages) do
        local preds, limit = stage[1], stage[2]
        -- identify tanks needing this stage
        local tanks = {}
        for _, ref in ipairs(preds) do
            if get(ref) > get("fuel_"..string.sub(ref,6)) and get("fuel_"..string.sub(ref,6)) < limit then
                table.insert(tanks, ref)
            end
        end
        local cnt = #tanks
        if cnt > 0 then
            local vol = dt * FUEL_RATE / cnt
            for _, ref in ipairs(tanks) do
                local q_ref = "fuel_"..string.sub(ref,6)
                local newq = clamp(get(q_ref) + vol, 0, limit)
                set(q_ref, newq)
            end
            break
        end
    end
end

-- Payload & CG loading
local function load_payload(dt)
    local total_set = get(payload_set)
    local load_time = 600 * total_set / 20000
    if load_time <= 0 then return true end

    set(slider_5, 1)
    timer = timer + dt
    -- cargo
    local new_payload = clamp(get(payload_wt) + dt*CARGO_RATE, 0, total_set)
    set(payload_wt, new_payload)
    -- CG
    if not cg_recorded then
        cg_old = get(cg_load)
        cg_target = get(cg_set)
        cg_recorded = true
    end
    local speed = (cg_target - cg_old) / load_time
    set(cg_load, get(cg_load) + dt * speed)

    if timer >= load_time then
        set(cg_load, cg_target)
        set(slider_5, 0)
        return true
    end
    return false
end

-- Main update loop
function update()
    local dt = get(frame_time)
    -- start loading when slider pressed and gear blocks installed
    if get(load_slow_btn) == 1 and not load_started and get(gear_blocks) == 1 then
        load_started = true; cg_recorded = false; timer = 0
    end
    if load_started then
        -- ensure gear blocks remain
        set(gear_blocks, 1)
        -- fuel tanker call
        local fuel_needed = check_fuel_needed()
        set(fuel_tanker_call, fuel_needed and 1 or 0)
        -- load fuel
        load_fuel(dt)
        -- load payload
        if not fuel_needed then
            if load_payload(dt) then load_started = false end
        end
    end
end
