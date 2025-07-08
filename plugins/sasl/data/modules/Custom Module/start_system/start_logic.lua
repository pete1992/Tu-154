-- start_panel.lua (optimized)
-- Engine start panel: controls, sounds, lamps, and gauge smoothing

-- Batch-define DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[2](d[3]))
    end
end

defineProps({
    -- Controls & buttons
    {"starter_cap",         globalPropertyi, "tu154ce/switchers/eng/starter_cap"},
    {"starter_switch",      globalPropertyi, "tu154ce/switchers/eng/starter_switch"},
    {"starter_eng_select",  globalPropertyi, "tu154ce/switchers/eng/starter_eng_select"},
    {"starter_mode",        globalPropertyi, "tu154ce/switchers/eng/starter_mode"},
    {"starter_start",       globalPropertyi, "tu154ce/buttons/eng/starter_start"},
    {"starter_stop",        globalPropertyi, "tu154ce/buttons/eng/starter_stop"},
    {"flight_start_1",      globalPropertyi, "tu154ce/buttons/eng/flight_start_1"},
    {"flight_start_2",      globalPropertyi, "tu154ce/buttons/eng/flight_start_2"},
    {"flight_start_3",      globalPropertyi, "tu154ce/buttons/eng/flight_start_3"},
    {"reserv_pump_test",    globalPropertyi, "tu154ce/buttons/eng/reserv_pump_test"},
    -- Lamps
    {"apd_work_1",          globalPropertyf, "tu154ce/lights/small/apd_work_1"},
    {"apd_work_2",          globalPropertyf, "tu154ce/lights/small/apd_work_2"},
    {"apd_work_3",          globalPropertyf, "tu154ce/lights/small/apd_work_3"},
    -- Gauges & sources
    {"starter_press",       globalPropertyf, "tu154ce/gauges/eng/starter_press"},
    {"starter_pressure",    globalPropertyf, "tu154ce/start/starter_pressure"},
    {"bus27_L",             globalPropertyf, "tu154ce/elec/bus27_volt_left"},
    {"bus27_R",             globalPropertyf, "tu154ce/elec/bus27_volt_right"},
    {"bus36_L",             globalPropertyf, "tu154ce/elec/bus36_volt_left"},
    {"bus36_R",             globalPropertyf, "tu154ce/elec/bus36_volt_right"},
    {"frame_time",          globalPropertyf, "tu154ce/time/frame_time"},
    {"apd_working_1",       globalPropertyf, "tu154ce/start/apd_working_1"},
    {"apd_working_2",       globalPropertyf, "tu154ce/start/apd_working_2"},
    {"apd_working_3",       globalPropertyf, "tu154ce/start/apd_working_3"},
})

include("smooth_light.lua")

-- Load sounds
local cap_sound      = loadSample('Custom Sounds/cap.wav')
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound   = loadSample('Custom Sounds/plastic_btn.wav')

-- Cache previous states
local prev = {}
for _, name in ipairs({
    "starter_cap","starter_switch","starter_eng_select","starter_mode",
    "starter_start","starter_stop","flight_start_1","flight_start_2","flight_start_3","reserv_pump_test"
}) do
    prev[name] = get(_G[name])
end

-- Clamp helper
local clamp = function(v,a,b) return v<a and a or v>b and b or v end

-- Handle control changes and play sounds
local function handle_controls()
    local change_sum = 0
    for _, name in ipairs({
        "starter_cap","starter_switch","starter_eng_select","starter_mode"
    }) do
        local cur = get(_G[name])
        if cur ~= prev[name] then
            if name == "starter_cap" then
                playSample(cap_sound,false)
                if cur == 0 then
                    set(starter_switch,0)
                    set(starter_eng_select,0)
                end
            else
                change_sum = change_sum + math.abs(cur - prev[name])
            end
        end
        prev[name] = cur
    end
    if change_sum > 0 then playSample(switcher_sound,false) end

    change_sum = 0
    for _, name in ipairs({
        "starter_start","starter_stop","flight_start_1","flight_start_2","flight_start_3","reserv_pump_test"
    }) do
        local cur = get(_G[name])
        if cur ~= prev[name] then change_sum = change_sum + 1 end
        prev[name] = cur
    end
    if change_sum > 0 then playSample(button_sound,false) end
end

-- Update APD indicator lamps
local function update_lamps()
    local dim = clamp((math.max(get(bus27_L),get(bus27_R)) - 10)/18.5,0,1)
    set(apd_work_1, smooth_light(get(apd_working_1)*dim, get(apd_work_1)))
    set(apd_work_2, smooth_light(get(apd_working_2)*dim, get(apd_work_2)))
    set(apd_work_3, smooth_light(get(apd_working_3)*dim, get(apd_work_3)))
end

-- Smooth gauge needle
local gauge_act = 0

local function update_gauge(dt)
    local target = 0
    if get(bus36_L)>30 and get(bus36_R)>30 then
        target = get(starter_pressure)
    end
    gauge_act = gauge_act + (target - gauge_act)*dt*2
    set(starter_press, gauge_act)
end

-- Main update
function update()
    local dt = get(frame_time)
    handle_controls()
    update_lamps()
    update_gauge(dt)
end
