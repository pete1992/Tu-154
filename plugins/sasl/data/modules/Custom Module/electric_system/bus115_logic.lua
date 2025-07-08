-- this is logic of 115/200v buses

-- system has 3 separate buses and 2 emergency buses
-- buses powered by generators of engines, APU, GPU

-- normal currents on busses are
-- bus 1 - 70
-- bus 2 - 0. if AI works - +130
-- bus 3 - 45. if galley and lights works - +60

-- 3 generators works - 3 main buses powered each by its own gen

-- 1 gen fail
-- gen 1 fail
-- bus 1 powered by gen 2. if AI is ON, by gen 3
-- bus 2 powered by gen 2
-- bus 3 powered by gen 3

-- gen 2 fail
-- bus 1 powered by gen 3
-- bus 2 powered by gen 1. if AI is ON, by gen 3
-- bus 3 powered by gen 3

-- gen 3 fail
-- bus 1 powered by gen 1
-- bus 2 powered by gen 2
-- bus 3 powered by gen 2. if AI is ON, by gen 1

-- 2 gens fail. galley and lights not work
-- remaining gen powers buses 1 and 3. bus 2 powered by APU.

-- 3 gens fail. galley and lights not work
-- buses 1 and 3 powered by APU.

-- EGT gauges can be powered from 115v or POS125
-- this logic better make insode EGT gauges
-- like:  (bus24_volt > 13 and pos125_on) or bus115_volt > 110



-- this is logic of 115/200 V buses

-- bus_logic.lua (optimized)
-- Handles 115 V and emergency buses and distributes currents to generators

-- Batch define DataRefs
local function defineProps(defs)
    for _, d in ipairs(defs) do
        defineProperty(d[1], d[3](d[2]))
    end
end

defineProps({
    -- generator voltages
    {"gen1_volt_bus",  "tu154ce/elec/gen1_volt",        globalPropertyf},
    {"gen2_volt_bus",  "tu154ce/elec/gen2_volt",        globalPropertyf},
    {"gen3_volt_bus",  "tu154ce/elec/gen3_volt",        globalPropertyf},
    {"gen4_volt_bus",  "tu154ce/elec/gen4_volt",        globalPropertyf},
    {"gpu_volt_bus",   "tu154ce/elec/gpu_volt",         globalPropertyf},
    -- generator online flags
    {"gen1_work_bus",  "tu154ce/elec/gen1_work",        globalPropertyi},
    {"gen2_work_bus",  "tu154ce/elec/gen2_work",        globalPropertyi},
    {"gen3_work_bus",  "tu154ce/elec/gen3_work",        globalPropertyi},
    {"gen4_work_bus",  "tu154ce/elec/gen4_work",        globalPropertyi},
    {"gpu_work_bus",   "tu154ce/elec/gpu_work",         globalPropertyi},
    -- bus voltages
    {"bus115_1_volt",  "tu154ce/elec/bus115_1_volt",    globalPropertyf},
    {"bus115_2_volt",  "tu154ce/elec/bus115_2_volt",    globalPropertyf},
    {"bus115_3_volt",  "tu154ce/elec/bus115_3_volt",    globalPropertyf},
    {"bus115_em_1_volt","tu154ce/elec/bus115_em_1_volt",globalPropertyf},
    {"bus115_em_2_volt","tu154ce/elec/bus115_em_2_volt",globalPropertyf},
    -- bus currents
    {"bus115_1_amp",   "tu154ce/elec/bus115_1_amp",      globalPropertyf},
    {"bus115_2_amp",   "tu154ce/elec/bus115_2_amp",      globalPropertyf},
    {"bus115_3_amp",   "tu154ce/elec/bus115_3_amp",      globalPropertyf},
    {"bus115_em_1_amp","tu154ce/elec/bus115_em_1_amp",  globalPropertyf},
    {"bus115_em_2_amp","tu154ce/elec/bus115_em_2_amp",  globalPropertyf},
    -- generator loads
    {"gen1_amp",       "tu154ce/elec/gen1_amp",         globalPropertyf},
    {"gen2_amp",       "tu154ce/elec/gen2_amp",         globalPropertyf},
    {"gen3_amp",       "tu154ce/elec/gen3_amp",         globalPropertyf},
    {"gen4_amp",       "tu154ce/elec/gen4_amp",         globalPropertyf},
    {"gpu_amp",        "tu154ce/elec/gpu_amp",          globalPropertyf},
    -- timing & control
    {"frame_time",     "tu154ce/time/frame_time",       globalPropertyf},
    {"ismaster",       "scp/api/ismaster",              globalPropertyf},
})

-- Map each generator to its DataRefs
local gens = {
    gen1 = { work="gen1_work_bus", volt="gen1_volt_bus", amp="gen1_amp" },
    gen2 = { work="gen2_work_bus", volt="gen2_volt_bus", amp="gen2_amp" },
    gen3 = { work="gen3_work_bus", volt="gen3_volt_bus", amp="gen3_amp" },
    apu  = { work="gen4_work_bus", volt="gen4_volt_bus", amp="gen4_amp" },
    gpu  = { work="gpu_work_bus",  volt="gpu_volt_bus",  amp="gpu_amp" },
}

-- Define main buses with their priority order and emergency branches
local busDefs = {
    {
        volt   = "bus115_1_volt", amp   = "bus115_1_amp",
        emVolt = "bus115_em_1_volt", emAmp = "bus115_em_1_amp",
        order  = {"gen1","gen2","gen3","apu","gpu"},
    },
    {
        volt   = "bus115_2_volt", amp   = "bus115_2_amp",
        emVolt = "bus115_em_2_volt", emAmp = "bus115_em_2_amp",
        order  = {"gen2","gen1","gen3","apu","gpu"},
    },
    {
        volt   = "bus115_3_volt", amp   = "bus115_3_amp",
        emVolt = nil,            emAmp = nil,
        order  = {"gen3","gen2","gen1","apu","gpu"},
    },
}

-- Locals for performance
local get, set = get, set
local ipairs, pairs = ipairs, pairs

-- Pick the first online generator in priority list
local function pickSource(order)
    for _, name in ipairs(order) do
        if get(gens[name].work) == 1 then
            return get(gens[name].volt), name
        end
    end
    return 0, nil
end

function update()
    -- Only master updates
    if get(ismaster) ~= 1 then return end
    if get(frame_time) <= 0 then return end

    -- Reset generator loads
    for _, g in pairs(gens) do
        set(g.amp, 0)
    end

    -- Distribute bus currents to active generators
    for _, bus in ipairs(busDefs) do
        local voltage, src = pickSource(bus.order)
        set(bus.volt, voltage)
        if bus.emVolt then set(bus.emVolt, voltage) end

        local mainLoad = get(bus.amp)
        local emLoad   = bus.emAmp and get(bus.emAmp) or 0
        local total    = mainLoad + emLoad

        if src then
            set(gens[src].amp, get(gens[src].amp) + total)
        end
    end
end
