-- rain_mask.lua

-- Smartcopilot
defineProperty("ismaster",    globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

-- Helper to register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register static DataRefs (excluding Smartcopilot ones)
defineProps({
    {"wiper_angle_left",   "sim/custom/anim/wiper_angle_left",           globalPropertyf},
    {"wiper_angle_right",  "sim/custom/anim/wiper_angle_right",          globalPropertyf},
    {"actual_rain",        "sim/weather/precipitation_on_aircraft_ratio", globalPropertyf},
    {"net_rain_ratio",     "sim/custom/anim/net_rain_ratio",             globalPropertyf},
    {"indicated_airspeed", "sim/flightmodel/position/indicated_airspeed", globalPropertyf},
    {"frame_time",         "sim/custom/time/frame_time",                 globalPropertyf},
    {"thermo",             "sim/cockpit2/temperature/outside_air_temp_degc", globalPropertyf},
})

-- Dynamic rain‐mask properties per windshield
local mask = {}
for i = 1, 2 do
    mask[i] = globalPropertyf(("sim/custom/anim/rain_glass_%d"):format(i))
end

-- Dynamic wiper‐segment masks [windshield][segment][side]
local wiper_mask_L = { {}, {} }
local wiper_mask_R = { {}, {} }
for i = 1, 2 do
    for y = 1, 5 do
        wiper_mask_L[i][y] = globalPropertyf(("sim/custom/anim/rain_glass_%d_w_%d_L"):format(i, y))
        wiper_mask_R[i][y] = globalPropertyf(("sim/custom/anim/rain_glass_%d_w_%d_R"):format(i, y))
    end
end

-- Internal state
local mask_tbl        = { 0, 0 }
local wiper_mask_tbl_L = { {0,0,0,0,0}, {0,0,0,0,0} }
local wiper_mask_tbl_R = { {0,0,0,0,0}, {0,0,0,0,0} }
local appear_spd      = { 0, 0 }
local wiper_L_last    = get(wiper_angle_left)
local wiper_R_last    = get(wiper_angle_right)

function update()
    local passed = get(frame_time)
    local MASTER = get(ismaster) ~= 1

    if MASTER then
        set(net_rain_ratio, get(actual_rain))
    end

    local precip_lvl  = get(net_rain_ratio)
    local IAS         = get(indicated_airspeed)
    local temperature = get(thermo)

    -- Compute appearance speed per windshield
    local speed_red = math.min(0.05 + math.abs(IAS) * 0.0005, 0.5)
    appear_spd[1] = (precip_lvl - speed_red) * 0.3
    if temperature < 0 then
        appear_spd[1] = -math.min(0.01 + math.abs(IAS) * 0.0005, 0.5)
    end
    appear_spd[2] = (precip_lvl - speed_red) * 0.1
    if temperature > 0 then
        appear_spd[2] = -math.min(0.01 + math.abs(IAS) * 0.0005, 0.5) * 0.5
    end

    -- Current wiper angles
    local wiper_L = get(wiper_angle_left)
    local wiper_R = get(wiper_angle_right)

    for i = 1, 2 do
        -- Update overall rain mask
        mask_tbl[i] = mask_tbl[i] + passed * appear_spd[i]
        mask_tbl[i] = math.max(0, math.min(1, mask_tbl[i]))
        set(mask[i], mask_tbl[i])

        for y = 1, 5 do
            -- Segment sweep limits
            local seg_min = 2 + (y - 1) * 12
            local seg_max = y * 12

            -- Left wiper segment
            wiper_mask_tbl_L[i][y] = wiper_mask_tbl_L[i][y] + passed * appear_spd[i]
            wiper_mask_tbl_L[i][y] = math.max(0, math.min(1, wiper_mask_tbl_L[i][y]))
            if wiper_L ~= wiper_L_last then
                if (wiper_L < seg_max and wiper_L > seg_min)
                or (wiper_L_last < seg_max and wiper_L_last > seg_min)
                or (wiper_L > wiper_L_last and wiper_L > seg_max and wiper_L_last < seg_min)
                or (wiper_L < wiper_L_last and wiper_L_last > seg_max and wiper_L < seg_min) then
                    wiper_mask_tbl_L[i][y] = 0
                end
            end
            set(wiper_mask_L[i][y], wiper_mask_tbl_L[i][y])

            -- Right wiper segment
            wiper_mask_tbl_R[i][y] = wiper_mask_tbl_R[i][y] + passed * appear_spd[i]
            wiper_mask_tbl_R[i][y] = math.max(0, math.min(1, wiper_mask_tbl_R[i][y]))
            if wiper_R ~= wiper_R_last then
                if (wiper_R < seg_max and wiper_R > seg_min)
                or (wiper_R_last < seg_max and wiper_R_last > seg_min)
                or (wiper_R > wiper_R_last and wiper_R > seg_max and wiper_R_last < seg_min)
                or (wiper_R < wiper_R_last and wiper_R_last > seg_max and wiper_R < seg_min) then
                    wiper_mask_tbl_R[i][y] = 0
                end
            end
            set(wiper_mask_R[i][y], wiper_mask_tbl_R[i][y])
        end
    end

    -- Store last wiper positions
    wiper_L_last = wiper_L
    wiper_R_last = wiper_R
end
