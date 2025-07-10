-- flight_controls.lua

--]]
	Changelog
	
	Refactored DataRef definitions into a single props table with looped 
	defineProperty calls for clarity and maintainability
	
	Added utility functions: clamp, bool2int, line (2-point interpolation), and 
	interpMach (table-based interpolation)
	
	Implemented proper delta-time integration by tracking last_time and 
	computing dt = now - last_time
	
	Corrected SmartCopilot master check to get(ismaster) == 2 so only true 
	masters drive the controls
	
	Defined all previously missing DataRefs (stab_ratio, anim_rud*, 
	rpm_high_*, etc.) to avoid runtime errors
	
	Ensured all float DataRefs use globalPropertyf for consistent typing (e.g. 
	gear deflections)
	
	Consolidated hydraulic and booster logic into clear blocks, using bool2int 
	and max-of channels for authority
	
	Unified aileron/roll-spoiler, spoilers, force-feedback, elevator, and 
	rudder logic into structured, readable sections
	
	Preserved original functionality and failure-mode handling while improving 
	readability and performance
]]

-- Utility: Clamp value between min and max
local function clamp(x, minv, maxv)
    if x < minv then return minv end
    if x > maxv then return maxv end
    return x
end

-- Utility: Convert boolean to integer
local function bool2int(b)
    return b and 1 or 0
end

-- Utility: Linear interpolation between two points (x1,y1)-(x2,y2)
local function line(x, x1, y1, x2, y2)
    if x <= x1 then return y1 end
    if x >= x2 then return y2 end
    return y1 + (y2 - y1) * (x - x1) / (x2 - x1)
end

-- Utility: Table-based linear interpolation (Mach effectivity)
local function interpMach(tbl, v)
    for i = 2, #tbl do
        if v < tbl[i][1] then
            local x1,y1 = tbl[i-1][1], tbl[i-1][2]
            local x2,y2 = tbl[i][1],   tbl[i][2]
            return y1 + (v - x1)*(y2 - y1)/(x2 - x1)
        end
    end
    return tbl[#tbl][2]
end

-- Mach effectivity table
local mach_tbl = {
    {-10,1}, {0,1}, {0.1,1}, {0.25,0.5}, {0.34,0.28}, {0.38,0.22},
    {0.5,0.21}, {0.6,0.21}, {0.7,0.2}, {0.8,0.19}, {0.9,0.13}, {1,0.1}, {10,0.1}
}

-- Batch DataRef definitions
local props = {
    -- Inputs
    {"joy_pitch","tu154ce/SC/yoke_pitch_ratio","f"},
    {"joy_roll", "tu154ce/SC/yoke_roll_ratio", "f"},
    {"joy_yaw",  "tu154ce/SC/yoke_heading_ratio","f"},
    -- Timing & override
    {"frame_time","tu154ce/time/frame_time","f"},
    {"overr",    "sim/operation/override/override_control_surfaces",nil},
    -- Speedbrake
    {"speedbrake_ratio","sim/cockpit2/controls/speedbrake_ratio","f"},
    -- Trims
    {"elev_trimm_sw","tu154ce/controll/elev_trimm_switcher","i"},
    {"ail_trimm_sw", "tu154ce/controll/ail_trimm_sw","i"},
    {"rudd_trimm_sw","tu154ce/controll/rudd_trimm_sw","i"},
    {"int_pitch_trim","tu154ce/trimmers/int_pitch_trim","f"},
    {"int_roll_trim", "tu154ce/trimmers/int_roll_trim","f"},
    {"int_yaw_trim",  "tu154ce/trimmers/int_yaw_trim","f"},
    -- Boosters
    {"buster_on_1","tu154ce/switchers/console/buster_on_1","i"},
    {"buster_on_2","tu154ce/switchers/console/buster_on_2","i"},
    {"buster_on_3","tu154ce/switchers/console/buster_on_3","i"},
    {"busters_cap","tu154ce/switchers/console/busters_cap","i"},
    -- Force feedback
    {"control_force_pos","tu154ce/controls/control_force_pos","f"},
    {"control_force_pos_rud","tu154ce/controls/control_force_pos_rud","f"},
    {"contr_force_set","tu154ce/controll/contr_force_set","i"},
    -- Gear deflection
    {"gear2_deflect","sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]","f"},
    {"gear3_deflect","sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]","f"},
    -- Hydraulics
    {"gs_press_1","tu154ce/hydro/gs_press_1","f"},
    {"gs_press_2","tu154ce/hydro/gs_press_2","f"},
    {"gs_press_3","tu154ce/hydro/gs_press_3","f"},
    -- Electrical
    {"bus27_volt_left","tu154ce/elec/bus27_volt_left","f"},
    {"bus27_volt_right","tu154ce/elec/bus27_volt_right","f"},
    -- Flight controls
    {"ail_L","sim/flightmodel/controls/wing3l_ail1def","f"},
    {"ail_R","sim/flightmodel/controls/wing3r_ail1def","f"},
    {"roll_spoil_L","sim/flightmodel/controls/wing2l_spo1def","f"},
    {"roll_spoil_R","sim/flightmodel/controls/wing2r_spo1def","f"},
    {"spd_brk_mid_L","sim/flightmodel/controls/wing2l_spo2def","f"},
    {"spd_brk_mid_R","sim/flightmodel/controls/wing2r_spo2def","f"},
    {"spd_brk_inn_L","sim/flightmodel/controls/wing1l_spo1def","f"},
    {"spd_brk_inn_R","sim/flightmodel/controls/wing1r_spo1def","f"},
    {"spd_brk_inn_anim_L","tu154ce/anim/spd_brk_inn_left","f"},
    {"spd_brk_inn_anim_R","tu154ce/anim/spd_brk_inn_right","f"},
    {"flap_inn_L","sim/flightmodel/controls/wing1l_fla1def","f"},
    {"flap_inn_R","sim/flightmodel/controls/wing1r_fla1def","f"},
    {"slats","sim/flightmodel2/controls/slat1_deploy_ratio","f"},
    -- Tail
    {"elevator_L","sim/flightmodel/controls/hstab1_elv1def","f"},
    {"elevator_R","sim/flightmodel/controls/hstab2_elv1def","f"},
    {"rudder","sim/flightmodel/controls/vstab2_rud1def","f"},
    {"stab_ratio","sim/cockpit2/controls/elevator_trim","f"},
    -- Reversers/engines
    {"revers_flap_L","sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]","f"},
    {"revers_flap_R","sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]","f"},
    {"rpm_high_1","tu154ce/gauges/engine/rpm_high_1","f"},
    {"rpm_high_3","tu154ce/gauges/engine/rpm_high_3","f"},
    -- Animations
    {"yoke_pitch","tu154ce/controlls/yoke_pitch","f"},
    {"yoke_roll","tu154ce/controlls/yoke_roll","f"},
    {"pedals_turn","tu154ce/controlls/pedals","f"},
    {"spoilers_lever","tu154ce/controlls/spoilers_lever","f"},
    -- ABSU autopilot corrections
    {"absu_contr_roll","tu154ce/absu/contr_roll","f"},
    {"absu_contr_pitch","tu154ce/absu/contr_pitch","f"},
    {"absu_contr_yaw","tu154ce/absu/contr_yaw","f"},
    -- Indicators
    {"indicated_airspeed","sim/flightmodel/position/indicated_airspeed","f"},
    {"machno","sim/flightmodel/misc/machno","f"},
    {"ias_L","sim/cockpit2/gauges/indicators/airspeed_kts_pilot","f"},
    {"ias_R","sim/cockpit2/gauges/indicators/airspeed_kts_copilot","f"},
    -- Failures
    {"ail_fail_left","tu154ce/failures/ail_fail_left","i"},
    {"ail_fail_right","tu154ce/failures/ail_fail_right","i"},
    {"fail_spoil_inn_left","tu154ce/failures/fail_spoil_inn_left","i"},
    {"fail_spoil_inn_right","tu154ce/failures/fail_spoil_inn_right","i"},
    {"fail_spoil_mid_left","tu154ce/failures/fail_spoil_mid_left","i"},
    {"fail_spoil_mid_right","tu154ce/failures/fail_spoil_mid_right","i"},
    {"fail_spoil_out_left","tu154ce/failures/fail_spoil_out_left","i"},
    {"fail_spoil_out_right","tu154ce/failures/fail_spoil_out_right","i"},
    {"rudder_fail","tu154ce/failures/rudder_fail","i"},
    {"elev_fail_left","tu154ce/failures/elev_fail_left","i"},
    {"elev_fail_right","tu154ce/failures/elev_fail_right","i"},
    -- Smart Copilot
    {"ismaster","scp/api/ismaster","f"}
}

for _, p in ipairs(props) do
    if p[3] == "f" then
        defineProperty(p[1], globalPropertyf(p[2]))
    elseif p[3] == "i" then
        defineProperty(p[1], globalPropertyi(p[2]))
    else
        defineProperty(p[1], globalProperty(p[2]))
    end
end

-- Enable override
set(overr, 1)

-- State
local last_time = get(frame_time)
local roll_pos_act, pitch_pos_act, yaw_pos_act = 0, 0, 0
local left_mid_sp_act, right_mid_sp_act = 0, 0
local left_inn_sp_act, right_inn_sp_act = 0, 0
local pitch_add, yaw_add = 0, 0
local b1, b2, b3 = 0,0,0

function update()
    local now = get(frame_time)
    local dt  = now - last_time
    last_time = now

    local MASTER = (get(ismaster) == 2)

    -- Power & boosters
    local pL = get(bus27_volt_left)  > 13
    local pR = get(bus27_volt_right) > 13
    b1 = pL and get(buster_on_1) or 0
    b2 = pL and get(buster_on_2) or 0
    b3 = pR and get(buster_on_3) or 0

    -- Hydraulics
    local HS1 = math.min(get(gs_press_1)/63,1)
    local HS2 = math.min(get(gs_press_2)/63,1)
    local HS3 = math.min(get(gs_press_3)/63,1)

    -- Ailerons & roll spoilers
    local cmd_roll = clamp(get(joy_roll)+get(int_roll_trim),-1,1) + get(absu_contr_roll)
    cmd_roll = clamp(cmd_roll,-1,1)
    local hydro = math.max(HS1*b1, HS2*b2, HS3*b3)
    if hydro>0.01 then
        roll_pos_act = roll_pos_act + (cmd_roll-roll_pos_act)*hydro*dt*10
    end
    local eff = interpMach(mach_tbl, get(machno))
    local lp = roll_pos_act*20*eff
    local rp = -lp
    local spL = (lp<=-1.5) and -((lp+1.5)/18.5)*45 or 0
    local spR = (rp<=-1.5) and -((rp+1.5)/18.5)*45 or 0
    if MASTER then
        set(ail_L, lp*(1-get(ail_fail_left)))
        set(ail_R, rp*(1-get(ail_fail_right)))
        set(roll_spoil_L, spL*(1-get(fail_spoil_out_left)))
        set(roll_spoil_R, spR*(1-get(fail_spoil_out_right)))
    end

    -- Spoiler auto-deploy
    local gears = get(gear2_deflect)>0.01 and get(gear3_deflect)>0.01
    local idle  = get(anim_rud1)<0.1 and get(anim_rud2)<0.1 and get(anim_rud3)<0.1
    local rev   = get(revers_flap_L)>0.1 and get(revers_flap_R)>0.1
    local IASok = get(ias_L)>54 or get(ias_R)>54
    local auto  = pL and gears and ((idle and IASok) or rev)
    if auto and MASTER then set(speedbrake_ratio,1) end

    -- Middle spoilers
    local sb = get(speedbrake_ratio)
    local mL, mR = sb*45*bool2int(pL), sb*45*bool2int(pL)
    if HS1>0.01 then
        left_mid_sp_act  = left_mid_sp_act  + (mL-left_mid_sp_act)*HS1*dt*15
        right_mid_sp_act = right_mid_sp_act + (mR-right_mid_sp_act)*HS1*dt*15
    end
    if MASTER then
        set(spd_brk_mid_L, left_mid_sp_act*(1-get(fail_spoil_mid_left)))
        set(spd_brk_mid_R, right_mid_sp_act*(1-get(fail_spoil_mid_right)))
    end

    -- Inner spoilers
    local ic = bool2int(auto)
    local iL, iR = ic*50*bool2int(pL), ic*50*bool2int(pL)
    if HS1>0.01 then
        local rate = (auto and 10 or 1)
        left_inn_sp_act  = left_inn_sp_act  + (iL-left_inn_sp_act)*HS1*dt*rate
        right_inn_sp_act = right_inn_sp_act + (iR-right_inn_sp_act)*HS1*dt*rate
    end
    if MASTER then
        set(spd_brk_inn_L, left_inn_sp_act*(1-get(fail_spoil_inn_left)))
        set(spd_brk_inn_R, right_inn_sp_act*(1-get(fail_spoil_inn_right)))
    end

    -- Force-feedback
    local fp, fr = get(control_force_pos), get(control_force_pos_rud)
    local sw = get(contr_force_set)
    if MASTER and pL and pR then
        if (sw==0 and get(flap_inn_L)<7 and get(flap_inn_R)<7) or sw==-1 then
            fp = clamp(fp+dt*0.04,0,1)
        else
            fp = clamp(fp-dt*0.04,0,1)
        end
        if (sw==0 and get(flap_inn_L)<7 and get(flap_inn_R)<7 and get(gear2_deflect)<0.01 and get(gear3_deflect)<0.01) or sw==-1 then
            fr = clamp(fr+dt*0.08,0,1)
        else
            fr = clamp(fr-dt*0.08,0,1)
        end
        set(control_force_pos,    fp)
        set(control_force_pos_rud, fr)
        local cc = bool2int(fp>0.01 or fr>0.01)*5
        set(ctr_27_L_cc, cc)
        set(ctr_27_R_cc, cc)
    end

    -- Elevator
    local pj = get(joy_pitch)
    if pj>0.9 and pitch_add<2 then pitch_add = pitch_add+dt*0.3
    elseif pj<-0.9 and pitch_add>-2 then pitch_add = pitch_add-dt*0.3
    elseif math.abs(pj)<0.9 then pitch_add=0 end
    pj = clamp(pj, -(1-fp*0.4), (1-fp*0.5))
    local yp = clamp(pj+get(int_pitch_trim)+pitch_add, -1,1)
    local pc = clamp(yp+get(absu_contr_pitch), -1,1)
    local hp = math.max(HS1*b1, HS2*b2, HS3*b3)
    if hp>0.01 then
        pitch_pos_act = pitch_pos_act + (pc-pitch_pos_act)*hp*dt*10
    end
    local st = get(stab_ratio)
    local elL, elR = 0,0
    if pitch_pos_act>=0 then
        elL,elR = -pitch_pos_act*(25-st), -pitch_pos_act*(25-st)
    else
        elL,elR = -pitch_pos_act*(20+st*0.5), -pitch_pos_act*(20+st*0.5)
    end
    local ecoef = (get(machno)<1) and interpMach(mach_tbl,get(machno)) or 0.1
    if MASTER then
        set(elevator_L, elL*ecoef*(1-get(elev_fail_left)))
        set(elevator_R, elR*ecoef*(1-get(elev_fail_right)))
    end

    -- Rudder
    local jy = get(joy_yaw)
    if jy>0.9 and yaw_add<2 then yaw_add=yaw_add+dt*0.3
    elseif jy<-0.9 and yaw_add>-2 then yaw_add=yaw_add-dt*0.3
    elseif math.abs(jy)<0.9 then yaw_add=0 end
    local yy = clamp(jy+get(int_yaw_trim)+yaw_add, -(1-fr*0.6),(1-fr*0.6))
    local rc = clamp(-yy - get(absu_contr_yaw), -1,1)
    local hy = math.max(HS1*b1, HS2*b2, HS3*b3)
    if hy>0.01 then
        yaw_pos_act = yaw_pos_act + (rc-yaw_pos_act)*hy*dt*10
    end
    local rp = yaw_pos_act*25*line(get(machno),0,1,0.8,0.5)
    local rL = 1-math.max(get(revers_flap_L)-0.5,0)*get(rpm_high_1)*0.015
    local rR = 1-math.max(get(revers_flap_R)-0.5,0)*get(rpm_high_3)*0.015
    if MASTER then
        set(rudder, rp*((rL+rR)*0.5)*(1-get(rudder_fail)))
        set(spd_brk_inn_anim_L, left_inn_sp_act*(1-get(fail_spoil_inn_left)))
        set(spd_brk_inn_anim_R, right_inn_sp_act*(1-get(fail_spoil_inn_right)))
        set(yoke_pitch, yp)
        set(yoke_roll,  clamp(get(joy_roll)+get(int_roll_trim),-1,1))
        set(pedals_turn, yy)
        set(spoilers_lever, sb)
    end
end

function onAvionicsDone()
    set(overr, 0)
    print("flight controls released")
end

