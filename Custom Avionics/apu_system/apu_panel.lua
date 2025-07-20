-- apu_panel.lua

-- Helper to batch-register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register all panel DataRefs
defineProps({
    {"apu_main_switch",        "tu154ce/switchers/eng/apu_main_switch",       globalPropertyi},
    {"apu_start_mode",         "tu154ce/switchers/eng/apu_start_mode",        globalPropertyi},
    {"apu_air_bleed",          "tu154ce/switchers/eng/apu_air_bleed",         globalPropertyi},
    {"apu_start",              "tu154ce/buttons/eng/apu_start",               globalPropertyi},
    {"apu_stop",               "tu154ce/buttons/eng/apu_stop",                globalPropertyi},
    {"apu_rpm",                "tu154ce/gauges/eng/apu_rpm",                  globalPropertyf},
    {"apu_egt_gau",            "tu154ce/gauges/eng/apu_egt",                  globalPropertyf},
    {"apu_oil_temp",           "tu154ce/gauges/eng/apu_oil_temp",             globalPropertyf},
    {"low_oil",                "tu154ce/lights/apu/low_oil",                  globalPropertyf},
    {"low_oil_press",          "tu154ce/lights/apu/low_oil_press",            globalPropertyf},
    {"high_temp",              "tu154ce/lights/apu/high_temp",                globalPropertyf},
    {"high_rpm",               "tu154ce/lights/apu/high_rpm",                 globalPropertyf},
    {"pta6_fail",              "tu154ce/lights/apu/pta6_fail",                globalPropertyf},
    {"doors_open",             "tu154ce/lights/apu/doors_open",               globalPropertyf},
    {"fuel_press",             "tu154ce/lights/apu/fuel_press",               globalPropertyf},
    {"start_ready",            "tu154ce/lights/apu/start_ready",              globalPropertyf},
    {"work_mode",              "tu154ce/lights/apu/work_mode",                globalPropertyf},
    {"start_apu",              "tu154ce/lights/apu/start_apu",                globalPropertyf},
    {"apu_n1",                 "tu154ce/eng/apu_n1",                          globalPropertyf},
    {"apu_oil_t",              "tu154ce/eng/apu_oil_t",                       globalPropertyf},
    {"apu_oil_q",              "tu154ce/eng/apu_oil_q",                       globalPropertyf},
    {"apu_oil_p",              "tu154ce/eng/apu_oil_p",                       globalPropertyf},
    {"apu_egt",                "tu154ce/eng/apu_egt",                         globalPropertyf},
    {"apu_air_press",          "tu154ce/eng/apu_air_press",                   globalPropertyf},
    {"apu_air_doors",          "tu154ce/eng/apu_air_doors",                   globalPropertyf},
    {"apu_fuel_p",             "tu154ce/eng/apu_fuel_p",                      globalPropertyf},
    {"apu_start_bus",          "tu154ce/elec/apu_start_bus",                  globalPropertyf},
    {"apu_start_cc",           "tu154ce/elec/apu_start_cc",                   globalPropertyf},
    {"apu_start_seq",          "tu154ce/elec/apu_start_seq",                  globalPropertyi},
    {"apu_doors",              "tu154ce/anim/apu_doors",                      globalPropertyf},
    {"cockpit_window_left",    "tu154ce/anim/cockpit_window_left",            globalPropertyf},
    {"cockpit_window_right",   "tu154ce/anim/cockpit_window_right",           globalPropertyf},
    {"bus27_volt_left",        "tu154ce/elec/bus27_volt_left",                globalPropertyf},
    {"bus27_volt_right",       "tu154ce/elec/bus27_volt_right",               globalPropertyf},
    {"outside_air_temp",       "sim/cockpit2/temperature/outside_air_temp_degc", globalPropertyf},
    {"test_lamps",             "tu154ce/buttons/lamp_test_apu",               globalPropertyi},
    {"day_night_set",          "tu154ce/lights/day_night_set",                globalPropertyf},
    {"gear_vent_set",          "tu154ce/switchers/eng/gear_fan",              globalPropertyi},
    {"external_view",          "sim/graphics/view/view_is_external",             globalPropertyi},
    {"frame_time",             "tu154ce/time/frame_time",                     globalPropertyf},
    {"APU_generator_on",       "sim/cockpit2/electrical/APU_generator_on",       globalPropertyi},
    {"APU_starter_switch",     "sim/cockpit2/electrical/APU_starter_switch",     globalPropertyi},
    {"APU_N1_percent",         "sim/cockpit2/electrical/APU_N1_percent",         globalPropertyi},
    {"APU_running",            "sim/cockpit2/electrical/APU_running",            globalPropertyi},
    {"acf_has_APU_switch",     "sim/aircraft/overflow/acf_has_APU_switch",       globalPropertyi},
    {"rel_APU_press",          "sim/operation/failures/rel_APU_press",           globalPropertyi},
    {"bleed_air_mode",         "sim/cockpit2/pressurization/actuators/bleed_air_mode", globalPropertyi},
    {"local_x",                "sim/flightmodel/position/local_x",               globalPropertyf},
    {"local_y",                "sim/flightmodel/position/local_y",               globalPropertyf},
    {"local_z",                "sim/flightmodel/position/local_z",               globalPropertyf},
    {"view_x",                 "sim/graphics/view/view_x",                       globalPropertyf},
    {"view_y",                 "sim/graphics/view/view_y",                       globalPropertyf},
    {"view_z",                 "sim/graphics/view/view_z",                       globalPropertyf},
    {"apu_start_fail",         "tu154ce/failures/apu_start_fail",             globalPropertyi},
    {"apu_gen_fail",           "tu154ce/failures/apu_gen_fail",               globalPropertyi},
    {"apu_fail_oilt",          "tu154ce/failures/apu_fail_oilt",              globalPropertyi},
    {"apu_fail_egt",           "tu154ce/failures/apu_fail_egt",               globalPropertyi},
    {"apu_fail_fuel_left",     "tu154ce/failures/apu_fail_fuel_left",         globalPropertyi},
    {"apu_fail",               "tu154ce/failures/apu_fail",                   globalPropertyi},
    {"apu_press_fail",         "tu154ce/failures/apu_press_fail",             globalPropertyi},
})

-- Lookup tables for gauge interpolation
local n1_table_start = {
    {-5000,   0},
    {    0,   0},
    {    8,   0},
    {   12,  15},
    {   14,   5},
    {   16,  18},
    {   18,  15},
    {   20,  20},
    {  110, 110},
    { 1000, 110},
}
local n1_table_off = {
    {-5000,   0},
    {    0,   0},
    {  110, 110},
    { 1000, 110},
}

-- Linear interpolation helper
local function interpolate(tbl, x)
    for i = 1, #tbl - 1 do
        local x1,y1 = tbl[i][1], tbl[i][2]
        local x2,y2 = tbl[i+1][1], tbl[i+1][2]
        if x >= x1 and x <= x2 then
            return y1 + (y2 - y1) * (x - x1) / (x2 - x1)
        end
    end
    return tbl[#tbl][2]
end

-- Preload sounds
local switcher_sound = loadSample('Custom Sounds/metal_switch.wav')
local button_sound   = loadSample('Custom Sounds/plastic_btn.wav')

-- State for gauges and controls
local n1_actual, EGT_actual, oil_t_actual = 0, 0, -60
local lastStates = {
    apu_main_switch = get(apu_main_switch),
    apu_start_mode  = get(apu_start_mode),
    apu_air_bleed   = get(apu_air_bleed),
    apu_start       = get(apu_start),
    apu_stop        = get(apu_stop),
    test_lamps      = get(test_lamps),
}

-- Default panel behavior
local function default_APU()
    set(rel_APU_press,     0)
    set(acf_has_APU_switch,1)
    set(APU_generator_on,  1)
    set(bleed_air_mode,    4)
    local vL, vR = get(bus27_volt_left), get(bus27_volt_right)
    if (get(APU_running)~=1 or get(APU_N1_percent)<50) and (vL>10 or vR>10) then
        set(APU_starter_switch,2)
    elseif vL>10 or vR>10 then
        set(APU_starter_switch,1)
    else
        set(APU_starter_switch,0)
    end
end

-- Update gauge needles smoothly
local function gauges(passed)
    local n1 = get(apu_n1)
    local n1_angle = n1_actual < n1 and interpolate(n1_table_start, n1)
                                         or interpolate(n1_table_off, n1)
    local EGT = math.max(get(apu_egt), -10)
    local oil_t = get(bus27_volt_right)>13 and get(apu_oil_t) or -75

    n1_actual  = n1_actual  + (n1_angle   - n1_actual)  * passed * 5
    EGT_actual = EGT_actual + (EGT        - EGT_actual) * passed * 3
    oil_t_actual = oil_t_actual + (oil_t - oil_t_actual) * passed * 3

    set(apu_rpm,      n1_actual)
    set(apu_egt_gau,  EGT_actual)
    set(apu_oil_temp, oil_t_actual)
end

-- Play click sounds on controls
local function check_controls()
    local sumChange = 0
    for prop, last in pairs(lastStates) do
        local cur = get(_G[prop])
        sumChange = sumChange + (cur - last)
        lastStates[prop] = cur
    end
    if sumChange ~= 0 then playSample(switcher_sound, 0) end
    local curTest = get(test_lamps)
    if curTest ~= lastStates.test_lamps then
        playSample(button_sound, 0)
        lastStates.test_lamps = curTest
    end
end

-- Update lamp brightness
local function lamps(passed)
    local test = get(test_lamps) * math.max((get(bus27_volt_right)-10)/18.5,0)
    local night = 1 - get(day_night_set)*0.25
    local brt = math.max((math.max(get(bus27_volt_left),get(bus27_volt_right))-10)/18.5,0) * night

    -- low oil
    local lowOil = math.max((get(apu_oil_q)<0.4 and 1 or 0) * brt, test)
    set(low_oil, lowOil)

    -- other warnings
    local seq    = get(apu_start_seq)==1
    local thermo = get(apu_egt)
    local rpm    = get(apu_n1)
    local mainOn = get(apu_main_switch)==1
    local failP  = get(apu_press_fail)==0

    set(low_oil_press, math.max((get(apu_oil_p)<1 and 1 or 0)*brt, test))
    set(high_temp,     math.max(((seq and thermo>700) or (not seq and thermo>570)) and brt or 0, test))
    set(high_rpm,      math.max((rpm>105 and 1 or 0)*brt, test))
    set(pta6_fail,     test)
    set(doors_open,    math.max((get(apu_doors)>0.9 and brt or 0), test))
    set(fuel_press,    math.max((get(apu_fuel_p)>0.8 and brt or 0), test))

    local ready = ((get(apu_air_doors)==0 and get(apu_doors)==1) and 1 or 0) * brt
    set(start_ready, math.max(ready, test))

    local work = (rpm>92 and mainOn and brt or 0)
    set(work_mode, math.max(work, test))

    local startLit = ((rpm<92 and get(gear_vent_set)==1) and brt or 0)
    set(start_apu, math.max(startLit, test))
end

function update()
    local passed = get(frame_time)
    default_APU()
    check_controls()
    lamps(passed)
    gauges(passed)
end