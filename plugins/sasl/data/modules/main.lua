print("This is Tu154M Community Edition, XP12 Alpha Custom")
size = {4096, 4096}
print("Lua version is", _VERSION)

-- SASL rendering and interactivity setup
sasl.options.set3DRendering(true)
sasl.options.setAircraftPanelRendering(true)
sasl.options.setInteractivity(true)
sasl.options.setRenderingMode2D(SASL_RENDER_2D_MULTIPASS)

-- Module search paths (KLN90, custom sounds, custom GUI)
addSearchPath(moduleDirectory .. "/Custom Module/KLN90/")
addSearchPath(moduleDirectory .. "/Custom Module/sounds")
addSearchPath(moduleDirectory .. "/Custom Module/gui")

-- Main DataRef creator logic
include("dataref_creator_4.lua")

sasl.gl.setRenderTextPixelAligned(true)

-- Panel fix for 3D panels
fixedPanelWidth = 4096
fixedPanelHeight = 4096

-- Randomize the seed for math.random
math.randomseed(os.time())

xplane_version = globalProperty("sim/version/xplane_internal_version")

-- === GLOBAL HELPERS ===

-- Interpolate a value using a lookup table (linear)
function interpolate(tbl, value)
    local lastActual = 0
    local lastReference = 0
    for _k, v in pairs(tbl) do
        if value == v[1] then
            return v[2]
        end
        if value < v[1] then
            local a = value - lastActual
            local m = v[2] - lastReference
            return lastReference + a / (v[1] - lastActual) * m
        end
        lastActual = v[1]
        lastReference = v[2]
    end
    return value - lastActual + lastReference
end

-- Returns sign as +1 or -1
function sign(x)
    return x >= 0 and 1 or -1
end

-- Converts boolean to integer (1/0)
function bool2int(var)
    return var and 1 or 0
end

-- Linear interpolation between two points for given x
function line(x, x1, y1, x2, y2)
    if x2 - x1 ~= 0 then
        return (x - x1) * (y2 - y1) / (x2 - x1) + y1
    else
        return 0
    end
end

-- Returns true if current freq is ILS
function isILS(freq)
    if (freq < 10810) or (freq > 11195) then
        return false
    end
    local v, f = math.modf(freq / 100)
    v = math.floor(f * 10 + 0.001)
    return (v % 2) == 1
end

--[[
-- Example for subpanel usage (disabled)
test_panel = subpanel {
    position = {50, 50, 1000, 500};
    noBackground = true;
    noClose = true;
    resizeProportional = true;
    savePosition = true;
    name = "test_panel";
    components = {
        rectangle {
            position = {0, 0, 1000, 500},
            color = {1, 1, 1, 1};
        },
        afl_ch {
            position = {0, 0, 1000, 500},
        },
    };
}
test_panel.visible = true
]]

-- === MAIN COMPONENTS ===
components = {
    -- Core logic
    -- dataref_creator_4 is already included above (comment/uncomment if using others)
    dataref_creator_1 {}, -- Main datarefs (controls and indications)
    dataref_creator_2 {}, -- Internal datarefs
    dataref_creator_3 {}, -- Failures datarefs
    -- dataref_creator_4 {}, -- Circuit breakers

    papers {},
    save_state {},         -- Manages current safe state
    time_logic {},
    flap_aero {},

    -- KLN90 GPS panel (if used)
    -- KLN90 {
    --     position = {1295, 582, 1770, 227},
    -- },

    -- Panels and subsystems
    main_panel { position = {0, 0, 2048, 2048}, },
    overhead {},
    animation {},
    electric_system {},
    lights_system {},
    apu_system {},
    asu {},
    engines_system {},
    fuel_system {},
    hydro_system {},
    kskv {},
    start_system {},
    controls {},
    fire_system {},
    antiice {},
    msrp {},
    brake_system {},
    sounds {},
    panels_2d {},
    smooth_anim {},
}
