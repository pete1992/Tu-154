-- rain_mask.lua (optimized)
-- Manages rain/snow accumulation and wipes on cockpit glass sectors

-- DataRefs
defineProperty("wiper_angle_left",   globalPropertyf("tu154ce/anim/wiper_angle_left"))
defineProperty("wiper_angle_right",  globalPropertyf("tu154ce/anim/wiper_angle_right"))
defineProperty("actual_rain",        globalPropertyf("sim/weather/precipitation_on_aircraft_ratio"))
defineProperty("net_rain_ratio",     globalPropertyf("tu154ce/anim/net_rain_ratio"))
defineProperty("indicated_airspeed", globalPropertyf("sim/flightmodel/position/indicated_airspeed"))
defineProperty("frame_time",         globalPropertyf("tu154ce/time/frame_time"))
defineProperty("thermo",             globalPropertyf("sim/cockpit2/temperature/outside_air_temp_degc"))
-- Smart Copilot
defineProperty("ismaster",           globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1",       globalPropertyf("scp/api/hascontrol_1"))

-- Create main masks
local mask = {
    globalPropertyf("tu154ce/anim/rain_glass_1"),
    globalPropertyf("tu154ce/anim/rain_glass_2")
}
-- Create sector masks per side and mask index
local sectors = { L={}, R={} }
for i=1,2 do
    sectors.L[i] = {}
    sectors.R[i] = {}
    for y=1,5 do
        sectors.L[i][y] = globalPropertyf(string.format("tu154ce/anim/rain_glass_%d_w_%d_L", i, y))
        sectors.R[i][y] = globalPropertyf(string.format("tu154ce/anim/rain_glass_%d_w_%d_R", i, y))
    end
end

-- State tables
local mask_val = {0,0}
local sector_val = { L={ {0,0,0,0,0}, {0,0,0,0,0} }, R={ {0,0,0,0,0}, {0,0,0,0,0} } }
local wiper_last = { L=get(wiper_angle_left), R=get(wiper_angle_right) }

-- Config
local function clamp(v,a,b) return v<a and a or v>b and b or v end
local APPEAR_BASE = 0.05
local IAS_FACTOR  = 0.0005
local MAX_SLIDE   = 0.5

-- Calculates appearance speed for rain(1)/snow(2)
local function compute_speed(precip, ias, temp, idx)
    local base = math.min(APPEAR_BASE + math.abs(ias)*IAS_FACTOR, MAX_SLIDE)
    local sign = (precip - base)
    if idx==1 and temp<0 then -- rain freezes => hide
        sign = -math.min(0.01 + math.abs(ias)*IAS_FACTOR, MAX_SLIDE)
    elseif idx==2 and temp>0 then -- snow melts => hide
        sign = -math.min(0.01 + math.abs(ias)*IAS_FACTOR, MAX_SLIDE)*0.5
    end
    -- scale factors: rain=0.3, snow=0.1
    return sign * (idx==1 and 0.3 or 0.1)
end

function update()
    local dt     = get(frame_time)
    local precip = get(net_rain_ratio)
    local ias    = get(indicated_airspeed)
    local temp   = get(thermo)
    -- Update networked rain if master
    if get(ismaster)~=1 then
        set(net_rain_ratio, get(actual_rain))
    end

    -- Wiper angles
    local wL, wR = get(wiper_angle_left), get(wiper_angle_right)

    for i=1,2 do
        -- appearance speed per mask
        local spd = compute_speed(precip, ias, temp, i)
        -- update main mask
        mask_val[i] = clamp(mask_val[i] + dt*spd, 0, 1)
        set(mask[i], mask_val[i])

        -- update each sector
        for y=1,5 do
            -- appear/disappear
            sector_val.L[i][y] = clamp(sector_val.L[i][y] + dt*spd, 0, 1)
            sector_val.R[i][y] = clamp(sector_val.R[i][y] + dt*spd, 0, 1)
            -- wipe sweep: clear when wiper crosses sector band
            local function wipe_clear(cur, last, tbl)
                local low = 2 + (y*12 - 12)
                local high = 12*y
                if (cur~=last) and ( (cur>low and cur<high) or (last>low and last<high) ) then
                    tbl[i][y] = 0
                end
            end
            wipe_clear(wL, wiper_last.L, sector_val.L)
            wipe_clear(wR, wiper_last.R, sector_val.R)
            -- commit values
            set(sectors.L[i][y], sector_val.L[i][y])
            set(sectors.R[i][y], sector_val.R[i][y])
        end
    end

    -- store last wiper positions
    wiper_last.L = wL
    wiper_last.R = wR
end




--[[
tu154ce/anim/rain_glass_1
tu154ce/anim/rain_glass_2
tu154ce/anim/rain_glass_1_w_1_L
tu154ce/anim/rain_glass_1_w_2_L
tu154ce/anim/rain_glass_1_w_3_L
tu154ce/anim/rain_glass_1_w_4_L
tu154ce/anim/rain_glass_1_w_5_L
tu154ce/anim/rain_glass_2_w_1_L
tu154ce/anim/rain_glass_2_w_2_L
tu154ce/anim/rain_glass_2_w_3_L
tu154ce/anim/rain_glass_2_w_4_L
tu154ce/anim/rain_glass_2_w_5_L
tu154ce/anim/rain_glass_1_w_1_R
tu154ce/anim/rain_glass_1_w_2_R
tu154ce/anim/rain_glass_1_w_3_R
tu154ce/anim/rain_glass_1_w_4_R
tu154ce/anim/rain_glass_1_w_5_R

tu154ce/anim/rain_glass_2_w_1_R
tu154ce/anim/rain_glass_2_w_2_R
tu154ce/anim/rain_glass_2_w_3_R
tu154ce/anim/rain_glass_2_w_4_R
tu154ce/anim/rain_glass_2_w_5_R
--]]
