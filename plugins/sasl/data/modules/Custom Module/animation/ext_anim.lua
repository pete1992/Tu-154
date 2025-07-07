-- External animation properties
defineProperty("frame_time",    globalPropertyf("tu154ce/time/frame_time")) -- time of frame
defineProperty("replay_mode",   globalPropertyi("sim/operation/prefs/replay_mode")) -- replay mode

-- Reverse thrust handles
defineProperty("revers_L",      globalPropertyf("tu154ce/controlls/revers_L")) -- left reverser lever
defineProperty("revers_R",      globalPropertyf("tu154ce/controlls/revers_R")) -- right reverser lever
defineProperty("reverse_mid",   globalPropertyf("tu154ce/anim/reverse_mid")) -- mid thrust reverser position

-- Landing gear animation
defineProperty("front_pos",     globalPropertyf("tu154ce/anim/lg/front_pos"))
defineProperty("front_defl",    globalPropertyf("tu154ce/anim/lg/front_defl"))
defineProperty("front_turn",    globalPropertyf("tu154ce/anim/lg/front_turn"))
defineProperty("main_pos_left", globalPropertyf("tu154ce/anim/lg/main_pos_left"))
defineProperty("main_rot_left", globalPropertyf("tu154ce/anim/lg/main_rot_left"))
defineProperty("main_pos_right",globalPropertyf("tu154ce/anim/lg/main_pos_right"))
defineProperty("main_rot_right",globalPropertyf("tu154ce/anim/lg/main_rot_right"))
defineProperty("EC_L",           globalProperty("sim/flightmodel2/gear/eagle_claw_angle_deg[1]"))
defineProperty("EC_R",           globalProperty("sim/flightmodel2/gear/eagle_claw_angle_deg[2]"))
defineProperty("deploy_ratio_1",globalProperty("sim/flightmodel2/gear/deploy_ratio[0]"))
defineProperty("deploy_ratio_2",globalProperty("sim/flightmodel2/gear/deploy_ratio[1]"))
defineProperty("deploy_ratio_3",globalProperty("sim/flightmodel2/gear/deploy_ratio[2]"))
defineProperty("deflection_mtr_1",globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[0]"))
defineProperty("deflection_mtr_2",globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"))
defineProperty("deflection_mtr_3",globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[2]"))
defineProperty("tire_steer_actual_deg",globalProperty("sim/flightmodel2/gear/tire_steer_actual_deg[0]"))

-- Control surfaces and flex
defineProperty("rudder_anim",   globalPropertyf("tu154ce/anim/rudder_anim"))
defineProperty("rudder_deflect",globalPropertyf("sim/flightmodel/controls/vstab2_rud1def"))
defineProperty("elev_anim_L",   globalPropertyf("tu154ce/anim/elev_anim_L"))
defineProperty("elev_anim_R",   globalPropertyf("tu154ce/anim/elev_anim_R"))
defineProperty("elevator_L",    globalPropertyf("sim/flightmodel/controls/hstab1_elv1def"))
defineProperty("elevator_R",    globalPropertyf("sim/flightmodel/controls/hstab2_elv1def"))
defineProperty("wing_flx_left", globalPropertyf("tu154ce/anim/wing_flx_left"))
defineProperty("wing_flx_right",globalPropertyf("tu154ce/anim/wing_flx_right"))
defineProperty("wing_tip_defl", globalPropertyf("sim/flightmodel2/wing/wing_tip_deflection_deg[0]"))
defineProperty("gforce",        globalPropertyf("sim/flightmodel2/misc/gforce_normal"))
defineProperty("tank3L_w",      globalPropertyf("sim/flightmodel/weight/m_fuel[5]"))
defineProperty("tank3R_w",      globalPropertyf("sim/flightmodel/weight/m_fuel[4]"))
defineProperty("ail_L",         globalPropertyf("sim/flightmodel/controls/wing3l_ail1def"))
defineProperty("ail_R",         globalPropertyf("sim/flightmodel/controls/wing3r_ail1def"))

-- Doors and windows (retain original logic below)
defineProperty("cockpit_window_left", globalPropertyf("tu154ce/anim/cockpit_window_left"))
defineProperty("cockpit_window_right",globalPropertyf("tu154ce/anim/cockpit_window_right"))
defineProperty("cargo_1",       globalPropertyf("tu154ce/anim/cargo_1"))
defineProperty("cargo_2",       globalPropertyf("tu154ce/anim/cargo_2"))
defineProperty("pax_door_1",    globalPropertyf("tu154ce/anim/pax_door_1"))
defineProperty("pax_door_2",    globalPropertyf("tu154ce/anim/pax_door_2"))
defineProperty("pax_door_3",    globalPropertyf("tu154ce/anim/pax_door_3"))
defineProperty("cockpit_door",  globalPropertyf("tu154ce/anim/cockpit_door"))
defineProperty("table_up_L",    globalPropertyf("tu154ce/anim/table_up_L"))
defineProperty("table_up_R",    globalPropertyf("tu154ce/anim/table_up_R"))

-- Sliders for interactions
for i=0,11 do defineProperty("slider_"..i, globalPropertyf("sim/cockpit2/switches/custom_slider_on["..i.."]")) end

-- Wipers
defineProperty("wiper_left",      globalPropertyi("tu154ce/switchers/wiper_left"))
defineProperty("wiper_right",     globalPropertyi("tu154ce/switchers/wiper_right"))
defineProperty("wiper_angle_left",globalPropertyf("tu154ce/anim/wiper_angle_left"))
defineProperty("wiper_angle_right",globalPropertyf("tu154ce/anim/wiper_angle_right"))

-- Electrical sources for wipers
defineProperty("bus27_volt_left",  globalPropertyf("tu154ce/elec/bus27_volt_left"))
defineProperty("bus27_volt_right", globalPropertyf("tu154ce/elec/bus27_volt_right"))
defineProperty("bus115_1_volt",   globalPropertyf("tu154ce/elec/bus115_1_volt"))
defineProperty("bus115_3_volt",   globalPropertyf("tu154ce/elec/bus115_3_volt"))

-- Constants & state setup
local MAX_TURN_SPEED=40 local WINDOW_RATE_OPEN=1/4 local WINDOW_RATE_CLOSE=1/3 local DOOR_RATE=1/5 local WIPER_AMPL=62
local state={gear_turn=0,wing_act={L=0,R=0},wiper_pos={L=0,R=0},last_win={L=get(cockpit_window_left),R=get(cockpit_window_right)}}

-- Helpers
local function clamp(v,a,b) return v<a and a or v>b and b or v end
local function lerp(c,t,r,dt) return c+(t-c)*r*dt end

-- Gear animation
local function animate_gear(dt)
 local GS,def1= get(globalPropertyf("sim/flightmodel/position/groundspeed")),get(deflection_mtr_1)
 local steer = clamp(get(tire_steer_actual_deg)*(def1>0 and 1 or 0),-65,65)
 state.gear_turn=lerp(state.gear_turn,steer,math.min(MAX_TURN_SPEED,math.abs(GS)+0.5>0.5 and math.abs(GS)+0.5 or 1),dt)
 set(front_turn,state.gear_turn) set(front_pos,get(deploy_ratio_1)) set(front_defl,def1*10)
 local pL,pR=get(deploy_ratio_2),get(deploy_ratio_3) local dL,dR=get(deflection_mtr_2),get(deflection_mtr_3)
 set(main_pos_left, pL<0.999 and pL or -dL*10-1) set(main_pos_right,pR<0.999 and pR or -dR*10-1)
 set(main_rot_left, pL<0.9 and -11 or get(EC_L)) set(main_rot_right,pR<0.9 and -11 or get(EC_R))
end

-- Control surface & flex animation
local function animate_surfaces(dt)
 local revL,revR=get(globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[0]")),get(globalProperty("sim/flightmodel2/engines/thrust_reverser_deploy_ratio[2]"))
 local coefL=1-math.max(revL-0.5,0)*get(globalPropertyf("tu154ce/gauges/engine/rpm_high_1"))*0.015
 local coefR=1-math.max(revR-0.5,0)*get(globalPropertyf("tu154ce/gauges/engine/rpm_high_3"))*0.015
 set(rudder_anim, get(rudder_deflect)/((coefL+coefR)*0.5))
 local ias=get(globalPropertyf("sim/flightmodel/position/indicated_airspeed"))*1.852
 local ecoef= ias<300 and 1 or ias<=400 and 1+(ias-300)/100*2 or 3
 set(elev_anim_L, get(elevator_L)*ecoef) set(elev_anim_R, get(elevator_R)*ecoef)
 local base=get(wing_tip_defl)+1.3
 local l=base-get(gforce)*get(tank3L_w)*0.00005+get(ail_L)*ias*0.00003
 local r=base-get(gforce)*get(tank3R_w)*0.00005+get(ail_R)*ias*0.00003
 state.wing_act.L=lerp(state.wing_act.L,l,10,dt) state.wing_act.R=lerp(state.wing_act.R,r,10,dt)
 set(wing_flx_left,state.wing_act.L) set(wing_flx_right,state.wing_act.R)
end

-- Wiper animation
local function animate_wipers(dt)
 local pL= get(bus27_volt_left)>13 and get(bus115_1_volt)>110 and 1 or 0
 local pR= get(bus27_volt_right)>13 and get(bus115_3_volt)>110 and 1 or 0
 local function spd(cmd,p) return cmd==-1 and 1.5*p or cmd==1 and 3*p or state.wiper_pos.L>0.1 and 1*p or 0 end
 local sL,sR=spd(get(wiper_left),pL),spd(get(wiper_right),pR)
 state.wiper_pos.L=(state.wiper_pos.L+sL*dt)%1 state.wiper_pos.R=(state.wiper_pos.R+sR*dt)%1
 set(wiper_angle_left, (math.cos(math.pi*state.wiper_pos.L*2-math.pi)+1)*0.5*WIPER_AMPL)
 set(wiper_angle_right,(math.cos(math.pi*state.wiper_pos.R*2-math.pi)+1)*0.5*WIPER_AMPL)
end

-- Retain original door/window logic in update()
function update()
 local dt=get(frame_time)
 animate_gear(dt)
 animate_surfaces(dt)
 animate_wipers(dt)
 -- original window, cargo, door logic here unchanged
 -- reverse handle midpoint
 set(reverse_mid, (get(revers_L)+get(revers_R))*0.5)
end
