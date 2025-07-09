-- control_fails.lua
-- sim/operation/failures/rel_tire1	int	y	failure_enum	Landing gear 1 tire blowout
-- sim/operation/failures/rel_tire2	int	y	failure_enum	Landing gear 2 tire blowout
-- sim/operation/failures/rel_tire3	int	y	failure_enum	Landing gear 3 tire blowout
-- sim/operation/failures/rel_tire4	int	y	failure_enum	Landing gear 4 tire blowout
-- sim/operation/failures/rel_tire5	int	y	failure_enum	Landing gear 5 tire blowout
-- source
--defineProperty("gear1_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))  -- vertical deflection of front gear
--defineProperty("gear2_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))  -- vertical deflection of left gear
--defineProperty("gear3_deflect", globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))  -- vertical deflection of right gear
--if get(rel_collapse1) ~= 1 then set(rel_collapse1, bool2int(math.random() < 0.00001) * 1) end
--if get(rel_collapse2) ~= 1 then set(rel_collapse2, bool2int(math.random() < 0.00001) * 1) end
--if get(rel_collapse3) ~= 1 then set(rel_collapse3, bool2int(math.random() < 0.00001) * 1) end
--if get(gear1_deflect) > 0.7 then set(rel_collapse1, 6) end
--if get(gear2_deflect) > 0.6 then set(rel_collapse2, 6) end
--if get(gear3_deflect) > 0.6 then set(rel_collapse3, 6) end
-- failures logic
-- Random and conditional control surface and landing gear failure simulation for Tu-154M
-- Aliases and helpers
local get, set = get, set
local random, pow = math.random, math.pow
local function bool2int(v) return v and 1 or 0 end

-- Core DataRefs: failure activation and runtime state
defineProperty("failures_enabled",    globalPropertyi("tu154ce/failures/failures_enabled"))
defineProperty("frame_time",          globalPropertyf("tu154ce/time/frame_time"))
defineProperty("ismaster",            globalPropertyf("scp/api/ismaster"))
defineProperty("ias",                 globalPropertyf("sim/flightmodel/position/indicated_airspeed"))

-- Failure DataRefs (all grouped)
local fails = {
    flap_left      = globalPropertyi("tu154ce/failures/flap_fail_left"),
    flap_right     = globalPropertyi("tu154ce/failures/flap_fail_right"),
    stab_eng       = globalPropertyi("tu154ce/failures/stab_eng_fail"),
    stab_auto      = globalPropertyi("tu154ce/failures/stab_automatic_fail"),
    slats          = globalPropertyi("tu154ce/failures/slats_fail"),
    ail_left       = globalPropertyi("tu154ce/failures/ail_fail_left"),
    ail_right      = globalPropertyi("tu154ce/failures/ail_fail_right"),
    spoil_inn_l    = globalPropertyi("tu154ce/failures/fail_spoil_inn_left"),
    spoil_inn_r    = globalPropertyi("tu154ce/failures/fail_spoil_inn_right"),
    spoil_mid_l    = globalPropertyi("tu154ce/failures/fail_spoil_mid_left"),
    spoil_mid_r    = globalPropertyi("tu154ce/failures/fail_spoil_mid_right"),
    spoil_out_l    = globalPropertyi("tu154ce/failures/fail_spoil_out_left"),
    spoil_out_r    = globalPropertyi("tu154ce/failures/fail_spoil_out_right"),
    rudder         = globalPropertyi("tu154ce/failures/rudder_fail"),
    elev_left      = globalPropertyi("tu154ce/failures/elev_fail_left"),
    elev_right     = globalPropertyi("tu154ce/failures/elev_fail_right"),
    retract1       = globalPropertyi("sim/operation/failures/rel_lagear1"),
    retract2       = globalPropertyi("sim/operation/failures/rel_lagear2"),
    retract3       = globalPropertyi("sim/operation/failures/rel_lagear3"),
    actuator       = globalPropertyi("sim/operation/failures/rel_gear_act"),
    trim_rud       = globalPropertyi("sim/operation/failures/rel_trim_rud"),
    trim_ail       = globalPropertyi("sim/operation/failures/rel_trim_ail"),
    trim_elv       = globalPropertyi("sim/operation/failures/rel_trim_elv"),
    emerg_trim_elv = globalPropertyi("tu154ce/failures/trim_emerg_elv_fail"),
}

-- Control surface and gear position inputs
local flapL     = globalPropertyf("sim/flightmodel/controls/wing1l_fla1def")
local flapR     = globalPropertyf("sim/flightmodel/controls/wing1r_fla1def")
local slats     = globalPropertyf("sim/flightmodel2/controls/slat1_deploy_ratio")
local trim      = globalPropertyf("sim/cockpit2/controls/elevator_trim")
local gearDep   = {
    globalProperty("sim/aircraft/parts/acf_gear_deploy[0]"),
    globalProperty("sim/aircraft/parts/acf_gear_deploy[1]"),
    globalProperty("sim/aircraft/parts/acf_gear_deploy[2]"),
}

-- Flap speed limit table (IAS in km/h)
local flap_lim = {
    {-100, 1e6}, {0,1e6}, {1,600}, {15,420},
    {28,360}, {36,330}, {45,300}, {100,300},
}

local function interp(tbl, x)
    for i=2,#tbl do
        local x0,y0 = tbl[i-1][1],tbl[i-1][2]
        local x1,y1 = tbl[i][1],tbl[i][2]
        if x<=x1 then
            local t=(x-x0)/(x1-x0)
            return y0+(y1-y0)*t
        end
    end
    return tbl[#tbl][2]
end

-- Internal state for timers and last positions
local fail_ctr, chk_time = 0, random(15,30)
local slat_ctr, trim_ctr = 1,1
local last_slats, last_trim = get(slats), get(trim)
local last_gear = {get(gearDep[1]), get(gearDep[2]), get(gearDep[3])}

function update()
    local dt = get(frame_time)
    -- Only run failure logic on master or offline
    if get(ismaster)==1 or dt<=0 then return end

    local FAIL = get(failures_enabled)
    FAIL = FAIL * 0.05 * pow(4, FAIL*0.5)

    if FAIL>0 then
        -- Random interval for random failures
        fail_ctr = fail_ctr + dt
        if fail_ctr>chk_time then
            fail_ctr, chk_time = 0, random(15,30)
            -- Helper to set a flag only if not already failed
            local function rndFail(ref, mult)
                if get(ref)~=1 then
                    set(ref, bool2int(random()<1e-5 * FAIL * 0.3 * (mult or 1)))
                end
            end
            rndFail(fails.flap_left); rndFail(fails.flap_right)
            rndFail(fails.stab_auto)
            -- Slats as two-stage
            local s = get(fails.slats); local s1,s2 = bool2int(s>=1), bool2int(s==2)
            if s1~=1 then s1= bool2int(random()<1e-5*FAIL*0.3*slat_ctr)
            elseif s2~=1 then s2= bool2int(random()<1e-5*FAIL*0.3*slat_ctr) end
            set(fails.slats, s1+s2)
            -- Surfaces and trim failures
            rndFail(fails.ail_left); rndFail(fails.ail_right)
            rndFail(fails.rudder); rndFail(fails.elev_left); rndFail(fails.elev_right)
            -- Gear/trim failures (6 means fail in X-Plane)
            for _, key in ipairs({"retract1","retract2","retract3","actuator","trim_rud","trim_ail","trim_elv"}) do
                local ref = fails[key]
                if get(ref)~=6 then set(ref, bool2int(random()<1e-5*FAIL*0.3)*6) end
            end
            rndFail(fails.emerg_trim_elv)
        end

        -- Condition-based (overspeed, rapid trim, etc.)
        local speed = get(ias)*1.852
        -- Flap overspeed
        local limitL = interp(flap_lim, get(flapL)) + (3-FAIL)*20
        if speed>limitL then set(fails.flap_left, bool2int(random()<0.1*FAIL*0.3)) end
        local limitR = interp(flap_lim, get(flapR)) + (3-FAIL)*20
        if speed>limitR then set(fails.flap_right, bool2int(random()<0.1*FAIL*0.3)) end

        -- Slat overspeed
        local s = get(fails.slats); local s1,s2 = bool2int(s>=1), bool2int(s==2)
        if speed>430+(3-FAIL)*20 and get(slats)>0.5 then
            if s1~=1 then s1=bool2int(random()<0.1*FAIL*0.3)
            elseif s2~=1 then s2=bool2int(random()<0.1*FAIL*0.3) end
            set(fails.slats, s1+s2)
        end

        -- Update activity counters for increased failure risk with use
        slat_ctr = math.max(1, slat_ctr + (bool2int(last_slats~=get(slats))*FAIL*0.5 - 0.7)*dt*0.2)
        last_slats = get(slats)
        trim_ctr = math.max(1, trim_ctr + (bool2int(last_trim~=get(trim))*FAIL*0.5 - 0.7)*dt*0.2)
        last_trim = get(trim)

        -- Gear overspeed/unsafe retraction
        for i=1,3 do
            local dep = get(gearDep[i])
            if speed> (450 + (3-FAIL)*20 + 10*(i-1)) and dep< last_gear[i] then
                local ref = fails["retract"..i]
                if get(ref)~=6 then set(ref, bool2int(random()<0.1*FAIL*0.3)*6) end
            end
            last_gear[i] = dep
        end

    else
        -- Reset all if failures disabled or on slave
        fail_ctr, slat_ctr, trim_ctr = 0,1,1
        for _, ref in pairs(fails) do set(ref,0) end
    end

    -- Always reset tires (failures are set elsewhere)
    for i=1,5 do set(globalPropertyi("sim/operation/failures/rel_tire"..i),0) end
end
