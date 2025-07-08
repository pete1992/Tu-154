-- apu_panel.lua (optimized)
-- Manages APU panel controls, gauges, and indicator lamps

-- Batch define properties helper
local function defineProps(defs)
    for _, d in ipairs(defs) do defineProperty(d[1], d[3](d[2])) end
end

-- Property definitions
defineProps({
    -- Controls
    {"apu_main_switch","tu154ce/switchers/eng/apu_main_switch",globalPropertyi},
    {"apu_start_mode","tu154ce/switchers/eng/apu_start_mode",globalPropertyi},
    {"apu_air_bleed","tu154ce/switchers/eng/apu_air_bleed",globalPropertyi},
    {"apu_start","tu154ce/buttons/eng/apu_start",globalPropertyi},
    {"apu_stop","tu154ce/buttons/eng/apu_stop",globalPropertyi},
    -- Panel gauges
    {"apu_rpm","tu154ce/gauges/eng/apu_rpm",globalPropertyf},
    {"apu_egt_gau","tu154ce/gauges/eng/apu_egt",globalPropertyf},
    {"apu_oil_temp","tu154ce/gauges/eng/apu_oil_temp",globalPropertyf},
    -- Lamps
    {"low_oil","tu154ce/lights/apu/low_oil",globalPropertyf},
    {"low_oil_press","tu154ce/lights/apu/low_oil_press",globalPropertyf},
    {"high_temp","tu154ce/lights/apu/high_temp",globalPropertyf},
    {"high_rpm","tu154ce/lights/apu/high_rpm",globalPropertyf},
    {"pta6_fail","tu154ce/lights/apu/pta6_fail",globalPropertyf},
    {"doors_open","tu154ce/lights/apu/doors_open",globalPropertyf},
    {"fuel_press","tu154ce/lights/apu/fuel_press",globalPropertyf},
    {"start_ready","tu154ce/lights/apu/start_ready",globalPropertyf},
    {"work_mode","tu154ce/lights/apu/work_mode",globalPropertyf},
    {"start_apu","tu154ce/lights/apu/start_apu",globalPropertyf},
    -- Internal state
    {"apu_n1","tu154ce/eng/apu_n1",globalPropertyf},
    {"apu_egt","tu154ce/eng/apu_egt",globalPropertyf},
    {"apu_oil_q","tu154ce/eng/apu_oil_q",globalPropertyf},
    {"apu_oil_p","tu154ce/eng/apu_oil_p",globalPropertyf},
    {"apu_air_press","tu154ce/eng/apu_air_press",globalPropertyf},
    {"apu_air_doors","tu154ce/eng/apu_air_doors",globalPropertyf},
    {"apu_fuel_p","tu154ce/eng/apu_fuel_p",globalPropertyf},
    {"apu_start_bus","tu154ce/elec/apu_start_bus",globalPropertyf},
    {"apu_start_cc","tu154ce/elec/apu_start_cc",globalPropertyf},
    {"apu_start_seq","tu154ce/elec/apu_start_seq",globalPropertyi},
    {"apu_doors","tu154ce/anim/apu_doors",globalPropertyf},
    -- Simulation defaults
    {"APU_generator_on","sim/cockpit2/electrical/APU_generator_on",globalPropertyi},
    {"APU_starter_switch","sim/cockpit2/electrical/APU_starter_switch",globalPropertyi},
    {"APU_N1_percent","sim/cockpit2/electrical/APU_N1_percent",globalPropertyf},
    {"APU_running","sim/cockpit2/electrical/APU_running",globalPropertyi},
    -- Lamps test & dimming
    {"test_lamps","tu154ce/buttons/lamp_test_apu",globalPropertyi},
    {"day_night_set","tu154ce/lights/day_night_set",globalPropertyf},
    {"gear_vent_set","tu154ce/switchers/eng/gear_fan",globalPropertyi},
    -- Electr. sources
    {"bus27_L","tu154ce/elec/bus27_volt_left",globalPropertyf},
    {"bus27_R","tu154ce/elec/bus27_volt_right",globalPropertyf},
    -- Environment
    {"outside_temp","sim/cockpit2/temperature/outside_air_temp_degc",globalPropertyf},
    {"frame_time","tu154ce/time/frame_time",globalPropertyf}
})

include("smooth_light.lua")
local switch_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound = loadSample('Custom Sounds/plastic_btn.wav')

-- State
local state = { n1_act = 0, egt_act = 0, oil_act = 0, prev = {} }
for _, key in ipairs({"apu_main_switch","apu_start_mode","apu_air_bleed","apu_start","apu_stop","test_lamps"}) do
    state.prev[key] = get(_G[key])
end

-- Helpers
local clamp = function(v,a,b) return v < a and a or (v > b and b or v) end
local lerp  = function(c,t,rate,dt) return c+(t-c)*rate*dt end

-- Default X-Plane APU auto-control
local function default_APU()
    set(APU_generator_on, 1)
    set(APU_starter_switch, get(apu_main_switch) == 1 and 2 or 0)
    -- set(bleed_air_mode, 4)         -- <-- Only if defined!
    -- set(rel_APU_press, 0)          -- <-- Only if defined!
end

-- Update gauge needles smoothly
local function update_gauges(dt)
    local n1 = get(apu_n1)
    local egt= get(apu_egt)
    local oil= get(apu_oil_t)
    state.n1_act = lerp(state.n1_act, n1, 5, dt)
    state.egt_act= lerp(state.egt_act, egt, 3, dt)
    state.oil_act= lerp(state.oil_act, oil, 3, dt)
    set(apu_rpm, state.n1_act)
    set(apu_egt_gau, state.egt_act)
    set(apu_oil_temp, state.oil_act)
end

-- Handle switch/button sounds
local function handle_sounds()
    for _, key in ipairs({"apu_main_switch","apu_start_mode","apu_air_bleed"}) do
        local cur = get(_G[key])
        if cur ~= state.prev[key] then playSample(switch_sound, false) end
        state.prev[key] = cur
    end
    local tb = get(test_lamps)
    if tb ~= state.prev.test_lamps then playSample(button_sound, false) end
    state.prev.test_lamps = tb
end

-- Update indicator lamps
local function update_lamps(dt)
    local dim = clamp((math.max(get(bus27_L), get(bus27_R)) - 10) / 18.5, 0, 1)
    local test = get(test_lamps) * dim
    local day = 1 - get(day_night_set) * 0.8
    local brt = dim * day + test
    local rpm = get(apu_n1)
    local seq = get(apu_start_seq) == 1
    local temp = get(apu_egt)
    -- low oil
    local lo = clamp((get(apu_oil_q) < 0.4 and 1 or 0) * brt, 0, 1)
    set(low_oil, smooth_light(lo, get(low_oil)))
    -- low oil press
    local lop = clamp((get(apu_oil_p) < 1 and 1 or 0) * brt, 0, 1)
    set(low_oil_press, smooth_light(lop, get(low_oil_press)))
    -- overtemp & overspeed
    local ht = clamp(((seq and temp > 700 or not seq and temp > 570) and 1 or 0) * brt, 0, 1)
    set(high_temp, smooth_light(ht, get(high_temp)))
    local hr = clamp((rpm > 105 and 1 or 0) * brt, 0, 1)
    set(high_rpm, smooth_light(hr, get(high_rpm)))
    -- doors
    local doo = clamp((get(apu_doors) > 0.9 and 1 or 0) * brt, 0, 1)
    set(doors_open, smooth_light(doo, get(doors_open)))
    -- fuel press
    local fp = clamp((get(apu_fuel_p) > 0.8 and 1 or 0) * brt, 0, 1)
    set(fuel_press, smooth_light(fp, get(fuel_press)))
    -- start ready & work mode
    local sr = clamp(((get(apu_air_doors) == 0 and get(apu_doors) == 1) and 1 or 0) * brt, 0, 1)
    set(start_ready, smooth_light(sr, get(start_ready)))
    local wm = clamp((rpm > 92 and get(apu_main_switch) == 1 and 1 or 0) * brt, 0, 1)
    set(work_mode, smooth_light(wm, get(work_mode)))
    -- start_apu lamp: RPM<92 & gear fan
    local sap = clamp((rpm < 92 and get(gear_vent_set) == 1 and 1 or 0) * brt, 0, 1)
    set(start_apu, smooth_light(sap, get(start_apu)))
end

-- Main update loop
function update()
    local dt = get(frame_time)
    default_APU()
    handle_sounds()
    update_gauges(dt)
    update_lamps(dt)
end
