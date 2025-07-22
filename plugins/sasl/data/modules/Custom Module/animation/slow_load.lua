-- slow_load.lua

-- Helper to register DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

-- Register DataRefs
defineProps({
    {"frame_time", 			"tu154ce/time/frame_time",                 			globalPropertyf},
    {"tank_1_pr", 				"tu154ce/payload/tank_1",                  		globalPropertyi},
    {"tank_4_pr", 			"tu154ce/payload/tank_4",                 			globalPropertyi},
    {"tank_2L_pr", 			"tu154ce/payload/tank_2L",                 			globalPropertyi},
    {"tank_2R_pr",       	"tu154ce/payload/tank_2R",                			globalPropertyi},
    {"tank_3L_pr", 			"tu154ce/payload/tank_3L",                 			globalPropertyi},
    {"tank_3R_pr",       	"tu154ce/payload/tank_3R",                 			globalPropertyi},
    {"fuel_tanker_call",  	"tu154ce/anim/fuel_tanker_call",           			globalPropertyi},
    {"gear_blocks",       	"tu154ce/anim/gear_blocks",                			globalPropertyi},
    {"fuel_tanker",       	"tu154ce/anim/fuel_tanker",                			globalPropertyf},
    {"payload",           		"sim/flightmodel/weight/m_fixed",             	globalPropertyf},
    {"CG_load",           		"sim/flightmodel/misc/cgz_ref_to_default",		globalPropertyf},
    {"paylod_set",        		"tu154ce/payload/paylod_set",              		globalPropertyf},
    {"cg_set",            		"tu154ce/payload/cg_set",                  		globalPropertyf},
    {"load_slow_btn",     	"tu154ce/payload/load_slow_btn",           			globalPropertyi},
})

defineProperty("slider_5", globalProperty("sim/cockpit2/switches/custom_slider_on[4]"))
defineProperty("fuel_q_1", globalProperty("sim/flightmodel/weight/m_fuel[0]")) -- fuel quantity for tank 1
defineProperty("fuel_q_4", globalProperty("sim/flightmodel/weight/m_fuel[1]")) -- fuel quantity for tank 4
defineProperty("fuel_q_2R", globalProperty("sim/flightmodel/weight/m_fuel[2]")) -- fuel quantity for tank 2R
defineProperty("fuel_q_2L", globalProperty("sim/flightmodel/weight/m_fuel[3]")) -- fuel quantity for tank 2L
defineProperty("fuel_q_3R", globalProperty("sim/flightmodel/weight/m_fuel[4]")) -- fuel quantity for tank 3R
defineProperty("fuel_q_3L", globalProperty("sim/flightmodel/weight/m_fuel[5]")) -- fuel quantity for tank 3L

-- Convert boolean to integer
local function bool2int(b) return b and 1 or 0 end

-- Local state
local load_started = false
local fuel_load    = true
local cg_read      = false
local CG_old       = get(CG_load)
local CG_need      = get(cg_set)
local load_timer   = 0

function update()
    local dt = get(frame_time)

    -- Begin slow load when button pressed and gear blocks are locked
    if get(load_slow_btn) == 1 and not load_started and get(gear_blocks) == 1 then
        load_started = true
        cg_read      = false
        load_timer   = 0
    end

    if load_started then
        -- Keep gear blocks engaged
        set(gear_blocks, 1)

        -- Determine if requested fuel exceeds actual
        local req_sum = get(tank_1_pr) + get(tank_4_pr)
                      + get(tank_2L_pr) + get(tank_2R_pr)
                      + get(tank_3L_pr) + get(tank_3R_pr)
        local act_sum = get(fuel_q_1) + get(fuel_q_4)
                      + get(fuel_q_2R) + get(fuel_q_2L)
                      + get(fuel_q_3R) + get(fuel_q_3L)
        fuel_load = (req_sum <= act_sum)

        -- Request tanker if needed
        set(fuel_tanker_call, (get(fuel_tanker) ~= 0 and not fuel_load) and 1 or 0)

        -- Perform fuel transfer if tanker not in use
        if get(fuel_tanker) == 0 then
            -- Tank 1
            local t1 = get(tank_1_pr) > get(fuel_q_1) and get(fuel_q_1) < 3300
            if t1 then
                set(fuel_q_1, math.min(get(fuel_q_1) + dt * 64, 3300))
            end
            -- Tanks 3 stage 1
            local t3L1 = get(tank_3L_pr) > get(fuel_q_3L) and get(fuel_q_3L) < 1725 and not t1
            local t3R1 = get(tank_3R_pr) > get(fuel_q_3R) and get(fuel_q_3R) < 1725 and not t1
            if t3L1 or t3R1 then
                local share = dt * 64 / (bool2int(t3L1) + bool2int(t3R1))
                if t3L1 then set(fuel_q_3L, get(fuel_q_3L) + share) end
                if t3R1 then set(fuel_q_3R, get(fuel_q_3R) + share) end
            end
            -- Tanks 3 & 2 stage 2
            do
                local t3L2 = get(tank_3L_pr) > get(fuel_q_3L) and get(fuel_q_3L) < 5405 and not t3L1 and not t1
                local t3R2 = get(tank_3R_pr) > get(fuel_q_3R) and get(fuel_q_3R) < 5405 and not t3R1 and not t1
                local t2L2 = get(tank_2L_pr) > get(fuel_q_2L) and get(fuel_q_2L) < 3700 and not t3L1 and not t1
                local t2R2 = get(tank_2R_pr) > get(fuel_q_2R) and get(fuel_q_2R) < 3700 and not t3R1 and not t1
                local cnt = bool2int(t3L2) + bool2int(t3R2) + bool2int(t2L2) + bool2int(t2R2)
                if cnt > 0 then
                    if t3L2 then set(fuel_q_3L, math.min(get(fuel_q_3L) + dt * 64 / cnt, 5405)) end
                    if t3R2 then set(fuel_q_3R, math.min(get(fuel_q_3R) + dt * 64 / cnt, 5405)) end
                    if t2L2 then set(fuel_q_2L, math.min(get(fuel_q_2L) + dt * 64 / cnt, 3700)) end
                    if t2R2 then set(fuel_q_2R, math.min(get(fuel_q_2R) + dt * 64 / cnt, 3700)) end
                end
            end
			-- Tanks 2 stage 3
			do
				local t2L3 = get(tank_2L_pr) > get(fuel_q_2L) and get(fuel_q_2L) < 9500 and not t2L2 and not t1
				local t2R3 = get(tank_2R_pr) > get(fuel_q_2R) and get(fuel_q_2R) < 9500 and not t2R2 and not t1
				local cnt = bool2int(t2L3) + bool2int(t2R3)
				if cnt > 0 then
					if t2L3 then set(fuel_q_2L, math.min(get(fuel_q_2L) + dt * 64 / cnt, 9500)) end
					if t2R3 then set(fuel_q_2R, math.min(get(fuel_q_2R) + dt * 64 / cnt, 9500)) end
				end
			end
            -- Tank 4
            local t4 = get(tank_4_pr) > get(fuel_q_4) and get(fuel_q_4) < 6598
            if t4 then
                set(fuel_q_4, math.min(get(fuel_q_4) + dt * 64, 6598))
            end
        end
        -- Calculate total load duration
        local load_time = 600 * get(paylod_set) / 20000
        if load_time == 0 and get(fuel_tanker_call) == 0 and fuel_load then
            load_started = false
        elseif get(fuel_tanker_call) == 0 and fuel_load and load_timer < load_time then
            -- Animate slider
            set(slider_5, 1)
            load_timer = load_timer + dt
            -- Increment payload
            set(payload, math.min(get(payload) + dt * 33.333333, get(paylod_set)))
            -- Capture CG targets once
            if not cg_read then
                cg_read = true
                CG_old  = get(CG_load)
                CG_need = get(cg_set)
            end
            -- Smoothly adjust CG
            local CG_spd = load_time > 0 and ((CG_need - CG_old) / load_time) or 0
            set(CG_load, get(CG_load) + dt * CG_spd)
            -- Finish loading
            if load_timer >= load_time then
                set(CG_load, CG_need)
                set(slider_5, 0)
                load_started = false
            end
        end
    end
end
