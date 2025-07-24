-- generators.lua
-- Simple generator logic for Tu-154M (engines & APU)

-- Bulk DataRef registration (excluding Smartcopilot)
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    -- Generator voltages
    {"gen1_volt_bus", "tu154ce/elec/gen1_volt", globalPropertyf},
    {"gen2_volt_bus", "tu154ce/elec/gen2_volt", globalPropertyf},
    {"gen3_volt_bus", "tu154ce/elec/gen3_volt", globalPropertyf},
    {"gen4_volt_bus", "tu154ce/elec/gen4_volt", globalPropertyf},
    {"gpu_volt_bus", "tu154ce/elec/gpu_volt", globalPropertyf},
    -- Generator currents
    {"gen1_amp_bus", "tu154ce/elec/gen1_amp", globalPropertyf},
    {"gen2_amp_bus", "tu154ce/elec/gen2_amp", globalPropertyf},
    {"gen3_amp_bus", "tu154ce/elec/gen3_amp", globalPropertyf},
    {"gen4_amp_bus", "tu154ce/elec/gen4_amp", globalPropertyf},
    {"gpu_amp", "tu154ce/elec/gpu_amp", globalPropertyf},
    -- Overload flags
    {"gen1_overload", "tu154ce/elec/gen1_overload", globalPropertyf},
    {"gen2_overload", "tu154ce/elec/gen2_overload", globalPropertyf},
    {"gen3_overload", "tu154ce/elec/gen3_overload", globalPropertyf},
    {"gen4_overload", "tu154ce/elec/gen4_overload", globalPropertyf},
    {"gpu_overload", "tu154ce/elec/gpu_overload", globalPropertyi},
    -- Controls
    {"gen_1_on", "tu154ce/switchers/eng/gen_1_on", globalPropertyi},
    {"gen_2_on", "tu154ce/switchers/eng/gen_2_on", globalPropertyi},
    {"gen_3_on", "tu154ce/switchers/eng/gen_3_on", globalPropertyi},
    {"apu_gen_on", "tu154ce/switchers/eng/apu_gen_on", globalPropertyi},
    {"gpu_on_sw", "tu154ce/switchers/eng/gpu_on", globalPropertyi},
    {"gen1_work", "tu154ce/elec/gen1_work", globalPropertyf},
    {"gen2_work", "tu154ce/elec/gen2_work", globalPropertyf},
    {"gen3_work", "tu154ce/elec/gen3_work", globalPropertyf},
    {"gen4_work", "tu154ce/elec/gen4_work", globalPropertyf},
    {"gpu_work_bus", "tu154ce/elec/gpu_work", globalPropertyi},
    -- Bus 27V
    {"DC_27_volt1", "tu154ce/elec/bus27_volt_left", globalPropertyf},
    {"DC_27_volt2", "tu154ce/elec/bus27_volt_right", globalPropertyf},
    -- Engine N1
    {"eng1_N1", "sim/flightmodel/engine/ENGN_N1_[0]", globalProperty},
    {"eng2_N1", "sim/flightmodel/engine/ENGN_N1_[1]", globalProperty},
    {"eng3_N1", "sim/flightmodel/engine/ENGN_N1_[2]", globalProperty},
    {"eng4_N1", "tu154ce/eng/apu_n1", globalPropertyf},
    -- Sim variables
    {"sim_gen1_on", "sim/cockpit/electrical/generator_on[0]", globalProperty},
    {"sim_gen2_on", "sim/cockpit/electrical/generator_on[1]", globalProperty},
    {"sim_gen3_on", "sim/cockpit/electrical/generator_on[2]", globalProperty},
    {"sim_gen4_on", "sim/cockpit2/electrical/APU_generator_on", globalPropertyi},
    -- Sim failures
    {"sim_gen1_fail", "sim/operation/failures/rel_genera0", globalPropertyi},
    {"sim_gen2_fail", "sim/operation/failures/rel_genera1", globalPropertyi},
    {"sim_gen3_fail", "sim/operation/failures/rel_genera2", globalPropertyi},
    {"apu_gen_fail", "tu154ce/failures/apu_gen_fail", globalPropertyi},
    -- Time
    {"frame_time", "tu154ce/time/frame_time", globalPropertyf}
})

-- Smartcopilot DataRefs (must not be in bulk)
defineProperty("ismaster", globalPropertyf("scp/api/ismaster"))
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1"))

-- Constants
local OVERLOAD_LIMIT = 200         -- New overload limit for all generators (A)
local OVERLOAD_TIME = 5            -- Seconds above limit before overload
local GEN_ON_THRESHOLD = 1
local MIN_GEN1_N1 = 25
local MIN_GEN2_N1 = 25
local MIN_GEN3_N1 = 25
local MIN_GEN4_N1 = 92
local VOLT_ON_BUS = 13

-- State variables
local apu_gen_counter = 0
local gen_1_counter = 1
local gen_2_counter = 1
local gen_3_counter = 1
local gpu_counter = 0
local gen_on_1_last = get(gen_1_on)
local gen_on_2_last = get(gen_2_on)
local gen_on_3_last = get(gen_3_on)
local ovrld_count_1 = 0
local ovrld_count_2 = 0
local ovrld_count_3 = 0
local ovrld_count_4 = 0

function update()
    local passed = get(frame_time)
    local MASTER = get(ismaster) ~= 1

    if passed > 0 and MASTER then
        local eng_rpm1 = get(eng1_N1)
        local eng_rpm2 = get(eng2_N1)
        local eng_rpm3 = get(eng3_N1)
        local eng_rpm4 = get(eng4_N1)
        local eng1_work = 0
        local eng2_work = 0
        local eng3_work = 0
        local eng4_work = 0

        local gen1_amp = get(gen1_amp_bus)
        local gen2_amp = get(gen2_amp_bus)
        local gen3_amp = get(gen3_amp_bus)
        local gen4_amp = get(gen4_amp_bus)
        local DC = 0
        if get(DC_27_volt1) > VOLT_ON_BUS or get(DC_27_volt2) > VOLT_ON_BUS then
            DC = 1
        end

        local gen_on1 = get(gen_1_on)
        local gen_on2 = get(gen_2_on)
        local gen_on3 = get(gen_3_on)
        local gen_on4 = 0

        if gen_on1 ~= gen_on_1_last then gen_on1 = 0 end
        if gen_on2 ~= gen_on_2_last then gen_on2 = 0 end
        if gen_on3 ~= gen_on_3_last then gen_on3 = 0 end

        gen_on_1_last = get(gen_1_on)
        gen_on_2_last = get(gen_2_on)
        gen_on_3_last = get(gen_3_on)

        -- Engine running checks
        if eng_rpm1 > MIN_GEN1_N1 then eng1_work = 1 end
        if eng_rpm2 > MIN_GEN2_N1 then eng2_work = 1 end
        if eng_rpm3 > MIN_GEN3_N1 then eng3_work = 1 end
        if eng_rpm4 > MIN_GEN4_N1 then eng4_work = 1 end

        -- Sim generator failures
        local gen1_fail = get(sim_gen1_fail) == 6 or get(gen1_overload) == 1
        local gen2_fail = get(sim_gen2_fail) == 6 or get(gen2_overload) == 1
        local gen3_fail = get(sim_gen3_fail) == 6 or get(gen3_overload) == 1
        local gen4_fail = get(gen4_overload) == 1 or get(apu_gen_fail) == 1

        -- Generator 1 logic
        local gen_work_1 = 0
        if math.abs(gen_on1) * DC * eng1_work == 1 then gen_1_counter = gen_1_counter + passed * 0.5
        else gen_1_counter = 0 end
        if gen_1_counter > 1 then gen_1_counter = 1 gen_work_1 = 1 end
        local gen1_volt = (122 - gen1_amp / 500) * math.abs(gen_on1) * gen_work_1
        if gen1_fail then gen1_volt = 0 end
        set(gen1_volt_bus, gen1_volt)
        if gen1_volt > 110 and gen_on1 == 1 then set(gen1_work, 1) else set(gen1_work, 0) end

        -- Generator 2 logic
        local gen_work_2 = 0
        if math.abs(gen_on2) * DC * eng2_work == 1 then gen_2_counter = gen_2_counter + passed * 0.5
        else gen_2_counter = 0 end
        if gen_2_counter > 1 then gen_2_counter = 1 gen_work_2 = 1 end
        local gen2_volt = (122 - gen2_amp / 500) * math.abs(gen_on2) * gen_work_2
        if gen2_fail then gen2_volt = 0 end
        set(gen2_volt_bus, gen2_volt)
        if gen2_volt > 110 and gen_on2 == 1 then set(gen2_work, 1) else set(gen2_work, 0) end

        -- Generator 3 logic
        local gen_work_3 = 0
        if math.abs(gen_on3) * DC * eng3_work == 1 then gen_3_counter = gen_3_counter + passed * 0.5
        else gen_3_counter = 0 end
        if gen_3_counter > 1 then gen_3_counter = 1 gen_work_3 = 1 end
        local gen3_volt = (122 - gen3_amp / 500) * math.abs(gen_on3) * gen_work_3
        if gen3_fail then gen3_volt = 0 end
        set(gen3_volt_bus, gen3_volt)
        if gen3_volt > 110 and gen_on3 == 1 then set(gen3_work, 1) else set(gen3_work, 0) end

        -- Generator 4 (APU) logic
        if get(apu_gen_on) * DC * eng4_work == 1 then apu_gen_counter = apu_gen_counter + passed * 0.5
        else apu_gen_counter = 0 end
        if apu_gen_counter > 1 then apu_gen_counter = 1 gen_on4 = 1 end
        local gen4_volt = (122 - gen4_amp / 500) * gen_on4
        if gen4_fail then gen4_volt = 0 end
        set(gen4_volt_bus, gen4_volt)
        if gen4_volt > 110 and gen_on4 == 1 then set(gen4_work, 1) else set(gen4_work, 0) end

        -- Overload logic (new threshold 200A, still 5s)
        if gen1_amp > OVERLOAD_LIMIT then ovrld_count_1 = ovrld_count_1 + passed else ovrld_count_1 = 0 end
        if ovrld_count_1 > OVERLOAD_TIME then set(gen1_overload, 1) elseif gen_on1 == 0 then set(gen1_overload, 0) end

        if gen2_amp > OVERLOAD_LIMIT then ovrld_count_2 = ovrld_count_2 + passed else ovrld_count_2 = 0 end
        if ovrld_count_2 > OVERLOAD_TIME then set(gen2_overload, 1) elseif gen_on2 == 0 then set(gen2_overload, 0) end

        if gen3_amp > OVERLOAD_LIMIT then ovrld_count_3 = ovrld_count_3 + passed else ovrld_count_3 = 0 end
        if ovrld_count_3 > OVERLOAD_TIME then set(gen3_overload, 1) elseif gen_on3 == 0 then set(gen3_overload, 0) end

        if gen4_amp > OVERLOAD_LIMIT then ovrld_count_4 = ovrld_count_4 + passed else ovrld_count_4 = 0 end
        if ovrld_count_4 > OVERLOAD_TIME then set(gen4_overload, 1) elseif gen_on4 == 0 then set(gen4_overload, 0) end

        -- Sync to X-Plane sim's generators
        if gen1_volt * gen_on1 > 0 then set(sim_gen1_on, 1) else set(sim_gen1_on, 0) end
        if gen2_volt * gen_on2 > 0 then set(sim_gen2_on, 1) else set(sim_gen2_on, 0) end
        if gen3_volt * gen_on3 > 0 then set(sim_gen3_on, 1) else set(sim_gen3_on, 0) end
        if gen4_volt * gen_on4 > 0 then set(sim_gen4_on, 1) else set(sim_gen4_on, 0) end
    end
end
