-- ground panel.lua
size = {655, 880}

-- Helper to define multiple datarefs at once
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    {"save_state",           "tu154ce/save_state",               globalPropertyi},
    {"frame_time",           "tu154ce/time/frame_time",          globalPropertyf},
    {"show_ground_panel",    "tu154ce/panels/show_ground_panel", globalPropertyi},
    {"reset_crew",           "tu154ce/sound/reset_crew",         globalPropertyi},
    {"failures_enabled",     "tu154ce/failures/failures_enabled",globalPropertyi},
    {"have_pedals",          "tu154ce/have_pedals",              globalPropertyi},
    {"reset_state",          "tu154ce/reset_state",              globalPropertyi},
    {"hide_rus_objects",     "tu154ce/lang/hide_rus_objects",    globalPropertyi},
    {"hide_eng_objects",     "tu154ce/lang/hide_eng_objects",    globalPropertyi},
    {"sounds_volume",        "tu154ce/sounds_volume",            globalPropertyi},
    {"slider_1",             "sim/cockpit2/switches/custom_slider_on[0]", globalPropertyi},
    {"slider_2",             "sim/cockpit2/switches/custom_slider_on[1]", globalPropertyi},
    {"slider_3",             "sim/cockpit2/switches/custom_slider_on[2]", globalPropertyi},
    {"slider_4",             "sim/cockpit2/switches/custom_slider_on[3]", globalPropertyi},
    {"slider_5",             "sim/cockpit2/switches/custom_slider_on[4]", globalPropertyi},
    {"slider_6",             "sim/cockpit2/switches/custom_slider_on[5]", globalPropertyi},
    {"slider_7",             "sim/cockpit2/switches/custom_slider_on[6]", globalPropertyi},
    {"slider_8",             "sim/cockpit2/switches/custom_slider_on[7]", globalPropertyi},
    {"slider_9",             "sim/cockpit2/switches/custom_slider_on[8]", globalPropertyi},
    {"slider_10",            "sim/cockpit2/switches/custom_slider_on[9]", globalPropertyi},
    {"slider_11",            "sim/cockpit2/switches/custom_slider_on[10]",globalPropertyi},
    {"slider_12",            "sim/cockpit2/switches/custom_slider_on[11]",globalPropertyi},
    {"gear_blocks",          "tu154ce/anim/gear_blocks",         globalPropertyi},
    {"sensors_caps",         "tu154ce/anim/sensors_caps",        globalPropertyi},
    {"engine_caps",          "tu154ce/anim/engine_caps",         globalPropertyi},
    {"gpu_present",          "tu154ce/anim/gpu_present",         globalPropertyi},
    {"ladder_1_call",        "tu154ce/anim/ladder_1_call",       globalPropertyi},
    {"ladder_2_call",        "tu154ce/anim/ladder_2_call",       globalPropertyi},
    {"catering_call",        "tu154ce/anim/catering_call",       globalPropertyi},
    {"fuel_tanker_call",     "tu154ce/anim/fuel_tanker_call",    globalPropertyi},
    {"ladder_1",             "tu154ce/anim/ladder_1",            globalPropertyf},
    {"ladder_2",             "tu154ce/anim/ladder_2",            globalPropertyf},
    {"catering",             "tu154ce/anim/catering",            globalPropertyf},
    {"fuel_tanker",          "tu154ce/anim/fuel_tanker",         globalPropertyf},
    {"ground_speed",         "sim/flightmodel/position/groundspeed",globalPropertyf},
    {"eng_rpm1",             "sim/flightmodel/engine/ENGN_N2_[0]",  globalPropertyf},
    {"eng_rpm2",             "sim/flightmodel/engine/ENGN_N2_[1]",  globalPropertyf},
    {"eng_rpm3",             "sim/flightmodel/engine/ENGN_N2_[2]",  globalPropertyf},
    {"zone_1_pr",            "tu154ce/payload/zone_1",           globalPropertyi},
    {"zone_2_pr",            "tu154ce/payload/zone_2",           globalPropertyi},
    {"zone_4_pr",            "tu154ce/payload/zone_4",           globalPropertyi},
    {"zone_5_pr",            "tu154ce/payload/zone_5",           globalPropertyi},
    {"zone_6_pr",            "tu154ce/payload/zone_6",           globalPropertyi},
    {"cargo_1_pr",           "tu154ce/payload/cargo_1",          globalPropertyi},
    {"cargo_2_pr",           "tu154ce/payload/cargo_2",          globalPropertyi},
    {"kitchens_pr",          "tu154ce/payload/kitchens",         globalPropertyi},
    {"rel_static_fail_L",    "tu154ce/failures/static1",         globalPropertyi},
    {"rel_static_fail_R",    "tu154ce/failures/static2",         globalPropertyi},
    {"pitot_fail1",          "tu154ce/failures/pitot1",          globalPropertyi},
    {"pitot_fail2",          "tu154ce/failures/pitot2",          globalPropertyi},
    {"uap_fail",             "tu154ce/failures/AOA",             globalPropertyi},
    {"rel_pitot",            "sim/operation/failures/rel_pitot",    globalPropertyi},
    {"rel_pitot2",           "sim/operation/failures/rel_pitot2",   globalPropertyi},
    {"alpha_fail",           "sim/operation/failures/rel_AOA",      globalPropertyi},
    {"deflection_mtr_1",     "sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]", globalPropertyf},
    {"deflection_mtr_2",     "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]", globalPropertyf},
    {"deflection_mtr_3",     "sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]", globalPropertyf},
    {"enable_crew_vo",       "tu154ce/sounds/enable_crew_vo",    globalPropertyi},
    {"show_fail_panel",      "tu154ce/panels/show_fail_panel",   globalPropertyi},
    {"show_gns",             "tu154ce/anim/show_gns",            globalPropertyi},
    {"show_RXP",             "tu154ce/anim/RXP",                 globalPropertyi},
    {"starter_torq",         "sim/aircraft/engine/acf_starter_torque_ratio", globalPropertyf},
})

local text_font = loadFont('basic_font.fnt')
defineProperty("bg_img",      loadImage("ground_tex.png"))
defineProperty("bg_img_rus",  loadImage("ground_tex_RUS.png"))
defineProperty("green_lamp",  loadImage("overhead_tex.png", 1825, 299, 19, 19))
defineProperty("yellow_lamp", loadImage("overhead_tex.png", 1825, 333, 19, 19))
defineProperty("lev_img",     loadImage("absu_ess.png", 432, 160, 30, 29))
yokes_cmd = findCommand("sim/operation/toggle_yoke")

-- Helper functions
local function clamp(val, minv, maxv)
    if val < minv then return minv elseif val > maxv then return maxv else return val end
end

local function approach(cur, target, rate, dt)
    if cur < target then
        return clamp(cur + rate * dt, cur, target)
    elseif cur > target then
        return clamp(cur - rate * dt, target, cur)
    else
        return cur
    end
end

-- Yoke axle switch handler
function yokes_hnd(phase)
    if phase == 0 then
        set(slider_9, 1 - get(slider_9))
    end
    return 0
end
registerCommandHandler(yokes_cmd, 0, yokes_hnd)

-- Initial states
local ladder_1_pos, ladder_2_pos = get(ladder_1), get(ladder_2)
local catering_pos, fuel_tanker_pos = get(catering), get(fuel_tanker)
local notLoaded = true
local failPanelShow = false
local reset_click = false

-- Cold & Dark reset
local function coldDarkReset()
    if get(eng_rpm1) < 10 and get(eng_rpm2) < 10 and get(eng_rpm3) < 10 then
        set(gear_blocks, 1); set(sensors_caps, 1); set(engine_caps, 1)
        set(zone_1_pr, 0); set(zone_2_pr, 0); set(zone_4_pr, 0)
        set(zone_5_pr, 0); set(zone_6_pr, 0)
        set(cargo_1_pr, 0); set(cargo_2_pr, 0); set(kitchens_pr, 20)
    end
    notLoaded = false
    return true
end

local load_counter = 0

-- Main update loop
function update()
    local dt = get(frame_time)
    load_counter = load_counter + dt
    if notLoaded and load_counter > 3 then coldDarkReset() end

    setMasterGain(get(sounds_volume))

    -- Animate services
    ladder_1_pos     = approach(ladder_1_pos,     get(ladder_1_call)==1 and 0   or -50, 2.7, dt)
    ladder_2_pos     = approach(ladder_2_pos,     get(ladder_2_call)==1 and 0   or -50, 2.7, dt)
    catering_pos     = approach(catering_pos,     get(catering_call)==1 and 0   or -50, 2.7, dt)
    fuel_tanker_pos  = approach(fuel_tanker_pos,  get(fuel_tanker_call)==1 and 0 or -50, 2.7, dt)

    -- Auto-retract if moving or gear compressed
    if math.abs(get(ground_speed))>1
       or get(gear_blocks)<1
       or get(deflection_mtr_1)<0.001
       or get(deflection_mtr_2)<0.001
       or get(deflection_mtr_3)<0.001 then

        ladder_1_pos, ladder_2_pos = 500, 500
        catering_pos, fuel_tanker_pos = 500, 500
        set(ladder_1_call, 0); set(ladder_2_call, 0)
        set(catering_call, 0); set(fuel_tanker_call, 0)
    end

    -- Release gear blocks if taxiing
    if math.abs(get(ground_speed))>2
       or get(deflection_mtr_1)<0.001
       or get(deflection_mtr_2)<0.001
       or get(deflection_mtr_3)<0.001 then
        set(gear_blocks, 0)
    end

    set(ladder_1, ladder_1_pos)
    set(ladder_2, ladder_2_pos)
    set(catering, catering_pos)
    set(fuel_tanker, fuel_tanker_pos)

    -- Service caps failure logic
    if get(sensors_caps)==1 then
        set(rel_static_fail_L, 6); set(rel_static_fail_R, 6)
        set(rel_pitot, 6); set(rel_pitot2, 6); set(alpha_fail, 6)
    else
        set(rel_static_fail_L, get(rel_static_fail_L)*6)
        set(rel_static_fail_R, get(rel_static_fail_R)*6)
        set(rel_pitot, get(pitot_fail1)*6)
        set(rel_pitot2, get(pitot_fail2)*6)
        set(alpha_fail, get(uap_fail)*6)
    end

    -- Failure panel visibility
    local canShow = math.abs(get(ground_speed))<=1
                    and get(deflection_mtr_1)>=0.001
                    and get(deflection_mtr_2)>=0.001
                    and get(deflection_mtr_3)>=0.001

    failPanelShow = canShow
    set(show_fail_panel, canShow and 1 or 0)
end


components = {
    -- Background panels
    textureLit {
        position = {0, 0, size[1], size[2]},
        image   = get(bg_img),
        visible = function() return get(hide_eng_objects) == 0 end,
    },
    textureLit {
        position = {0, 0, size[1], size[2]},
        image   = get(bg_img_rus),
        visible = function() return get(hide_eng_objects) == 1 end,
    },

    -- Top row sliders/status lamps
    textureLit { position = {232, 787, 22,22}, image = get(green_lamp), visible = function() return get(slider_1) == 0 end },
    textureLit { position = {232, 744, 22,22}, image = get(green_lamp), visible = function() return get(slider_5) == 0 end },
    textureLit { position = {232, 658, 22,22}, image = get(green_lamp), visible = function() return get(sensors_caps) == 0 end },
    textureLit { position = {232, 613, 22,22}, image = get(green_lamp), visible = function() return get(slider_6) == 0 end },
    textureLit { position = {232, 392, 22,22}, image = get(green_lamp), visible = function() return get(gear_blocks) == 0 end },
    textureLit { position = {232, 333, 22,22}, image = get(green_lamp), visible = function() return get(engine_caps) == 0 end },

    textureLit { position = {396, 788, 22,22}, image = get(green_lamp), visible = function() return get(slider_2) == 0 end },
    textureLit { position = {396, 720, 22,22}, image = get(green_lamp), visible = function() return get(gpu_present) == 0 end },
    textureLit { position = {396, 720, 22,22}, image = get(yellow_lamp),visible = function() return get(gpu_present) == 1 end },
    textureLit { position = {396, 665, 22,22}, image = get(green_lamp), visible = function() return get(slider_3) == 0 end },
    textureLit { position = {396, 619, 22,22}, image = get(green_lamp), visible = function() return get(slider_7) == 0 end },
    textureLit { position = {396, 392, 22,22}, image = get(green_lamp), visible = function() return get(slider_4) == 0 end },

    -- Service calls lamps
    textureLit { position = {232, 702, 22,22}, image = get(yellow_lamp), visible = function() return get(ladder_1_call) == 1 end },
    textureLit { position = {232, 702, 22,22}, image = get(green_lamp),  visible = function() return get(ladder_1_call) == 0 end },
    textureLit { position = {232, 571, 22,22}, image = get(yellow_lamp), visible = function() return get(ladder_2_call) == 1 end },
    textureLit { position = {232, 571, 22,22}, image = get(green_lamp),  visible = function() return get(ladder_2_call) == 0 end },
    textureLit { position = {396, 576, 22,22}, image = get(yellow_lamp), visible = function() return get(catering_call)==1 end },
    textureLit { position = {396, 576, 22,22}, image = get(green_lamp),  visible = function() return get(catering_call)==0 end },
    textureLit { position = {396, 531, 22,22}, image = get(yellow_lamp), visible = function() return get(fuel_tanker_call)==1 end },
    textureLit { position = {396, 531, 22,22}, image = get(green_lamp),  visible = function() return get(fuel_tanker_call)==0 end },

    -- Clickable regions
    clickable {
        position = {6, 824, 275, 45},
        onMouseDown = function()
            set(hide_rus_objects, 1 - get(hide_rus_objects))
            set(hide_eng_objects, 1 - get(hide_rus_objects))
            set(save_state, 1)
            return true
        end,
    },
    clickable {
        position = {366, 824, 275, 45},
        onMouseDown = function() set(slider_9, 1 - get(slider_9)); return true end,
    },
    clickable {
        position = {23, 782, 200, 35},
        onMouseDown = function() set(slider_1, 1 - get(slider_1)); return true end,
    },
    clickable {
        position = {23, 737, 200, 35},
        onMouseDown = function() set(slider_5, 1 - get(slider_5)); return true end,
    },
    clickable {
        position = {23, 650, 200, 35},
        onMouseDown = function()
            if get(ground_speed) <= 0.1 then set(sensors_caps, 1 - get(sensors_caps)) end
            return true
        end,
    },
    clickable {
        position = {23, 607, 200, 35},
        onMouseDown = function() set(slider_6, 1 - get(slider_6)); return true end,
    },
    clickable {
        position = {23, 385, 200, 35},
        onMouseDown = function()
            if get(gear_blocks) ~= 1 and get(ground_speed) < 0.1 then set(gear_blocks, 1) else set(gear_blocks, 0) end
            return true
        end,
    },
    clickable {
        position = {23, 325, 200, 35},
        onMouseDown = function()
            set(engine_caps, 1 - get(engine_caps))
            if get(eng_rpm1)>5 or get(eng_rpm2)>5 or get(eng_rpm3)>5 then set(engine_caps, 0) end
            return true
        end,
    },
    clickable {
        position = {424, 782, 200, 35},
        onMouseDown = function() set(slider_2, 1 - get(slider_2)); return true end,
    },
    clickable {
        position = {424, 715, 200, 35},
        onMouseDown = function() set(gpu_present, 1 - get(gpu_present)); return true end,
    },
    clickable {
        position = {424, 660, 200, 35},
        onMouseDown = function() set(slider_3, 1 - get(slider_3)); return true end,
    },
    clickable {
        position = {424, 613, 200, 35},
        onMouseDown = function() set(slider_7, 1 - get(slider_7)); return true end,
    },
    clickable {
        position = {424, 386, 200, 35},
        onMouseDown = function() set(slider_4, 1 - get(slider_4)); return true end,
    },
    clickable {
        position = {23, 695, 200, 35},
        onMouseDown = function() set(ladder_1_call, 1 - get(ladder_1_call)); return true end,
    },
    clickable {
        position = {23, 565, 200, 35},
        onMouseDown = function() set(ladder_2_call, 1 - get(ladder_2_call)); return true end,
    },
    clickable {
        position = {424, 570, 200, 35},
        onMouseDown = function() set(catering_call, 1 - get(catering_call)); return true end,
    },
    clickable {
        position = {424, 526, 200, 35},
        onMouseDown = function() set(fuel_tanker_call, 1 - get(fuel_tanker_call)); return true end,
    },
    clickable {
        position = {424, 230, 200, 35},
        onMouseDown = function()
            if failPanelShow then set(show_fail_panel, 1 - get(show_fail_panel))
            else set(show_fail_panel, 0) end
            return true
        end,
    },
    clickable {
        position = {23, 230, 200, 35},
        onMouseClick = function()
            if reset_click then set(reset_crew, 0) end
            if not reset_click then set(reset_crew, 1); reset_click = true end
            return true
        end,
        onMouseUp = function()
            reset_click = false; set(reset_crew, 0); return true
        end,
    },

    -- Volume lever
    lever_hor {
        position  = {456, 125, 139, 29},
        value     = sounds_volume,
        lever_img = get(lev_img),
        minimum   = 0,
        maximum   = 1000,
        addFunc   = function() set(save_state, 1); return true end,
    },
    clickable {
        position    = {426, 125, 30, 29},
        onMouseClick=function()
            set(sounds_volume, clamp(get(sounds_volume)-100, 0, 1000))
            set(save_state, 1)
            return true
        end,
    },
    clickable {
        position    = {595, 125, 30, 29},
        onMouseClick=function()
            set(sounds_volume, clamp(get(sounds_volume)+100, 0, 1000))
            set(save_state, 1)
            return true
        end,
    },

    -- Crew VO toggle
    text_draw {
        position = {32, 200, 55, 60},
        text     = function() return get(enable_crew_vo)==1 and "CREW VO ENABLED" or "CREW VO DISABLED" end,
        font     = text_font, color = {0,0,0,1},
    },
    clickable {
        position = {23, 190, 200, 35},
        onMouseDown = function() set(enable_crew_vo, 1 - get(enable_crew_vo)); set(save_state, 1); return true end,
    },

    -- Failures level
    text_draw {
        position = {32, 158, 55, 60},
        text     = function()
            local f = get(failures_enabled)
            return ({ "FAILURES OFF", "FAILURES LOW", "FAILURES MEDIUM", "FAILURES HIGH" })[f+1]
        end,
        font = text_font, color = {0,0,0,1},
    },
    clickable {
        position = {23, 148, 200, 35},
        onMouseDown = function()
            local f = (get(failures_enabled) + 1) % 4
            set(failures_enabled, f); set(save_state, 1); return true
        end,
    },

    -- Nosewheel mode text
    text_draw {
        position = {32, 78, 55, 60},
        text     = "NW uses YAW",
        font     = text_font, color = {0,0,0,1},
        visible  = function() return get(have_pedals)==0 end,
    },
    text_draw {
        position = {32, 78, 55, 60},
        text     = "NW uses Tiller",
        font     = text_font, color = {0,0,0,1},
        visible  = function() return get(have_pedals)==1 end,
    },

    -- Joystick reset prompt
    text_draw { position = {32, 50, 55, 60}, text = "WARNING, HOLD FOR 5 SEC", font = text_font, color = {0,0,0,1} },
    text_draw { position = {32, 30, 55, 60}, text = "TO RESET ALL JOYSTICKS", font = text_font, color = {0,0,0,1} },
    clickable {
        position = {23, 70, 200, 35},
        onMouseDown = function() set(have_pedals, 1-get(have_pedals)); set(save_state,1); return true end,
        onMouseUp   = function() return true end,
    },

    -- GPS selector
    text_draw {
        position = {32, 120, 55, 60},
        text     = function()
            local g, r = get(show_gns), get(show_RXP)
            return g==1 and (r==1 and "RXP INSTALLED" or "GNS430 INSTALLED") or "KLN90 INSTALLED"
        end,
        font = text_font, color = {0,0,0,1},
    },
    clickable {
        position = {23, 110, 200, 35},
        onMouseDown = function()
            local a = (get(show_gns) + get(show_RXP) + 1) % 3
            if a==0 then set(show_gns,0); set(show_RXP,0)
            elseif a==1 then set(show_gns,1); set(show_RXP,0)
            else set(show_gns,1); set(show_RXP,1) end
            set(save_state,1); return true
        end,
    },

    -- Starter torque adjust
    text_draw {
        position = {507, 52, 55, 60},
        text     = function() return math.floor(get(starter_torq)*100 + 0.5)/100 end,
        font = text_font, color = {0,0,0,1},
    },
    clickable {
        position    = {426, 47, 30, 29},
        onMouseClick=function()
            set(starter_torq, clamp(get(starter_torq)-0.01, 0.1, 1))
            set(save_state,1); return true
        end,
    },
    clickable {
        position    = {595, 47, 30, 29},
        onMouseClick=function()
            set(starter_torq, clamp(get(starter_torq)+0.01, 0.1, 1))
            set(save_state,1); return true
        end,
    },
    clickable {
        position    = {476, 12, 100, 29},
        onMouseClick=function() set(starter_torq, 0.2); set(save_state,1); return true end,
    },

    -- Close panel
    clickable {
        position    = {size[1]-15, size[2]-15, 15, 15},
        onMouseClick=function() set(show_ground_panel, 0); return true end,
    },
}
