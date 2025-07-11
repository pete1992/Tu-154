-- radar.lua
-- sim/cockpit2/EFIS/EFIS_page	int[6]	y	boolean	An array of EFIS 
-- page switches for selecting which EFIS page is visible.
-- sim/flightmodel/engine/ENGN_N1_	float[16]	y	percent	N1 speed 
-- as percent of max (per engine)

-- Weather radar logic for Tu-154M | X-Plane 12 | SASL 3.19+
-- Batch DataRef definition, safe array access, and full Tu-154 integration.

-- Utility functions -----------------------------------------------------
local function clamp(x, minv, maxv) return math.max(minv, math.min(x, maxv)) end
local function bool2int(b) return b and 1 or 0 end

-- Helper for array DataRef reads/writes (SASL3 globalPropertyf/i with index)
local function getArr(dref, idx)
    local v = get(dref)
    if type(v) == "table" then
        return v[idx+1] or 0 -- X-Plane arrays are 0-based for properties
    else
        return 0
    end
end

local function setArr(dref, idx, value)
    local v = get(dref)
    if type(v) == "table" then
        v[idx+1] = value
        set(dref, v)
    end
end

-- Batch DataRef definitions ---------------------------------------------
local props = {
    -- timing & attitude
    { "frame_time",          "tu154ce/time/frame_time",                     "f" },
    { "deg1",                "sim/flightmodel/position/psi",                "f" },
    { "deg2",                "sim/flightmodel/position/hpath",              "f" },

    -- radar controls & lamps
    { "rls_on",              "tu154ce/switchers/console/rls_on",            "i" },
    { "rls_mode",            "tu154ce/switchers/console/rls_mode",          "i" },
    { "rls_distance",        "tu154ce/switchers/console/rls_distance",      "i" },
    { "rls_brt",             "tu154ce/switchers/console/rls_brt",           "f" },
    { "rls_contr",           "tu154ce/switchers/console/rls_contr",         "f" },
    { "rls_signs",           "tu154ce/switchers/console/rls_signs",         "f" },
    { "rls_ready",           "tu154ce/lights/small/rls_ready",              "f" },
    { "rls_weather",         "tu154ce/lights/small/rls_weather",            "f" },
    { "radar_cc",            "tu154ce/radio/radar_cc",                      "f" },
    { "radar_fail",          "tu154ce/failures/radar_fail",                 "i" },
    -- electrical
    { "bus27_volt_right",    "tu154ce/elec/bus27_volt_right",               "f" },
    { "bus36_volt_pts250_1", "tu154ce/elec/bus36_volt_pts250_1",            "f" },
    { "bus115_3_volt",       "tu154ce/elec/bus115_3_volt",                  "f" },
    -- EFIS controls & pages (arrays)
    { "map_mode",            "sim/cockpit2/EFIS/map_mode",                  "i" },
    { "map_mode_is_HSI",     "sim/cockpit2/EFIS/map_mode_is_HSI",           "i" },
    { "map_range",           "sim/cockpit/switches/EFIS_map_range_selector","i" },
    { "EFIS_weather_on",     "sim/cockpit2/EFIS/EFIS_weather_on",           "i" },
    { "EFIS_tcas_on",        "sim/cockpit2/EFIS/EFIS_tcas_on",              "i" },
    { "EFIS_airport_on",     "sim/cockpit2/EFIS/EFIS_airport_on",           "i" },
    { "EFIS_vor_on",         "sim/cockpit2/EFIS/EFIS_vor_on",               "i" },
    { "EFIS_ndb_on",         "sim/cockpit2/EFIS/EFIS_ndb_on",               "i" },
    { "EFIS_fix_on",         "sim/cockpit2/EFIS/EFIS_fix_on",               "i" },
    { "EFIS_page_arr",       "sim/cockpit2/EFIS/EFIS_page",                 "i" }, -- Array [6]

    -- engine N1 (array)
    { "eng_N1_arr",          "sim/flightmodel/engine/ENGN_N1_",             "f" }, -- Array [16]

    -- X-Plane version
    { "xplane_version",      "sim/aircraft/view/acf_version",                "f" },
}

for _, p in ipairs(props) do
    if p[3] == "f" then
        defineProperty(p[1], globalPropertyf(p[2]))
    else
        defineProperty(p[1], globalPropertyi(p[2]))
    end
end

-- Images -----------------------------------------------------------------
defineProperty("mask1",   loadImage("radar_mask1.png", 0,   0,   256, 256))
defineProperty("mask2",   loadImage("radar_mask2.png", 0,   0,   256, 256))
defineProperty("scale",   loadImage("radar_scale.png",   0, 170,   512, 345))
defineProperty("scale_3", loadImage("radar_scale_marks.png",144,365, 250, 156))
defineProperty("scale_4", loadImage("radar_scale_marks.png",0,  59,  250, 156))
defineProperty("scale_5", loadImage("radar_scale_marks.png",0, 217,  250, 156))
defineProperty("scale_6", loadImage("radar_scale_marks.png",251,217, 250, 156))

-- Sounds & UI state ------------------------------------------------------
local rotary_sound_pl = loadSample('Custom Sounds/rot_click.wav')

local notLoaded    = true
local start_timer  = 0
local mask_angle   = -25
local first_mask   = false
local range_last   = get(map_range)
local power_counter= 0

-- Helper to reset panel at cold start ------------------------------------
local function sw_reset()
    -- Engines < 5% N1: cold and dark state
    if getArr(eng_N1_arr,0) < 5 and getArr(eng_N1_arr,1) < 5 and getArr(eng_N1_arr,2) < 5 then
        set(rls_on, 0)
        set(rls_distance, 4)
    end
    notLoaded = false
end

-- Main update loop -------------------------------------------------------
function update()
    local now = get(frame_time)
    local dt  = now - (update._last or now)
    update._last = now

    -- initial cold-start reset
    start_timer = start_timer + dt
    if notLoaded and start_timer > 0.3 then sw_reset() end

    -- Electrical/logic
    local pL       = get(bus27_volt_right) > 13
    local p3       = get(bus36_volt_pts250_1) > 30 or get(bus115_3_volt) > 110
    local okEFIS   = get(radar_fail) == 0
    local power_el = pL and p3 and okEFIS
    local on       = get(rls_on) == 1
    local mode     = get(rls_mode)
    local range    = get(map_range)

    -- Click on range change
    if range ~= range_last then
        if get(xplane_version) < 120000 then playSample(rotary_sound_pl,false) end
    end
    range_last = range

    -- Power-up timing
    if on and mode == 0 and power_el then
        power_counter = power_counter + dt * 10
    elseif (not on or not power_el) and power_counter > 0 then
        power_counter = math.max(0, power_counter - dt)
    end
    local powered = power_counter > 180

    -- Rotate sweep mask (weather mode)
    if powered and mode == 1 then
        mask_angle = mask_angle + dt * 70
        if mask_angle > 245 then
            mask_angle = -25
            first_mask = not first_mask
        end
    else
        mask_angle = -25
        first_mask = false
    end

    -- Force EFIS config: both captain and copilot EFIS_page[0] = 0
    setArr(EFIS_page_arr, 0, 0) -- captain
    setArr(EFIS_page_arr, 1, 0) -- copilot
    set(map_mode, 1)
    set(map_mode_is_HSI, 0)
    set(map_range, range)
    set(EFIS_weather_on, 1)
    set(EFIS_tcas_on, 0)
    set(EFIS_airport_on, 0)
    set(EFIS_vor_on, 0)
    set(EFIS_ndb_on, 0)
    set(EFIS_fix_on, 0)

    -- Lamps
    set(rls_ready,  bool2int(powered and mode == 0))
    set(rls_weather,bool2int(powered and mode == 1))

    -- Panel current consumption indicator
    set(radar_cc,
        bool2int(power_el)   * 0.2 +
        bool2int(powered)    * 0.1 +
        bool2int(mode > 0)   * 0.7
    )
end
-- Component definitions (UI layout) --------------------------------------
components = {
    -- signs background brightness
    rectangle_ctr {
        position = {69, 1534, 484, 345},
        R = 0, G = 0, B = 0,
        A = function() return 1 - get(rls_signs) + 0.35 end,
    },

    -- range scales
    textureLit {
        position = {52, 1523, 510, 330},
        image   = get(scale_3), visible = function() return get(map_range)==3 end,
    },
    textureLit {
        position = {62, 1527, 500, 320},
        image   = get(scale_4), visible = function() return get(map_range)==4 end,
    },
    textureLit {
        position = {62, 1527, 500, 320},
        image   = get(scale_5), visible = function() return get(map_range)==5 end,
    },
    textureLit {
        position = {48, 1523, 510, 330},
        image   = get(scale_6), visible = function() return get(map_range)==6 end,
    },

    -- sweep mask (weather radar)
    needleLit {
        position = {32, 1320, 560, 560},
        image   = get(mask1),
        angle   = function() return -mask_angle + 90 end,
        visible = function() return first_mask end,
    },
    needleLit {
        position = {32, 1320, 560, 560},
        image   = get(mask2),
        angle   = function() return mask_angle - 90 end,
        visible = function() return not first_mask end,
    },

    -- blank-out when not in weather mode
    rectangle {
        position = {69, 1534, 484, 345},
        color   = {0,0,0,1},
        visible = function() return not (get(rls_on)==1 and get(bus27_volt_right)>13 and get(radar_fail)==0 and get(rls_mode)==1) end,
    },

    -- contrast overlay
    rectangle_ctr {
        position = {69, 1532, 485, 347},
        R = 0, G = 0.2, B = 0,
        A = function()
            return math.max((0.5 + get(rls_brt)/2 - get(rls_contr)*2)/2, 0.1*bool2int(get(rls_on)==1))
        end,
    },

    -- raw scale beneath glass
    textureLit {
        position = {69, 1532, 485, 347},
        image   = get(scale),
        visible = function() return get(rls_on)==1 and get(bus27_volt_right)>13 and get(radar_fail)==0 end,
    },
    rectangle_ctr {
        position = {69, 1532, 485, 347},
        R = 0, G = 0, B = 0,
        A = function() return 1 - get(rls_brt) end,
    },
    texture {
        position = {69, 1532, 485, 347},
        image   = get(scale),
    },
}
