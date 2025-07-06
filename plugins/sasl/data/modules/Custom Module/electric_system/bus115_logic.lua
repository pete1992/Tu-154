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

-- Generator outputs (voltage datarefs)
defineProperty("gen1_volt_bus",  globalPropertyf("tu154ce/elec/gen1_volt"))  -- Generator 1 voltage (nominal 28.5 V)
defineProperty("gen2_volt_bus",  globalPropertyf("tu154ce/elec/gen2_volt"))  -- Generator 2 voltage
defineProperty("gen3_volt_bus",  globalPropertyf("tu154ce/elec/gen3_volt"))  -- Generator 3 voltage
defineProperty("gen4_volt_bus",  globalPropertyf("tu154ce/elec/gen4_volt"))  -- APU generator voltage
defineProperty("gpu_volt_bus",   globalPropertyf("tu154ce/elec/gpu_volt"))   -- GPU generator voltage

-- Generator online flags (1 if supplying bus)
defineProperty("gen1_work_bus",  globalPropertyi("tu154ce/elec/gen1_work"))  -- Gen 1 on bus
defineProperty("gen2_work_bus",  globalPropertyi("tu154ce/elec/gen2_work"))  -- Gen 2 on bus
defineProperty("gen3_work_bus",  globalPropertyi("tu154ce/elec/gen3_work"))  -- Gen 3 on bus
defineProperty("gen4_work_bus",  globalPropertyi("tu154ce/elec/gen4_work"))  -- APU gen on bus
defineProperty("gpu_work_bus",   globalPropertyi("tu154ce/elec/gpu_work"))   -- GPU on bus

-- Bus voltage sensors
defineProperty("bus115_1_volt",  globalPropertyf("tu154ce/elec/bus115_1_volt"))   -- Bus 1 voltage
defineProperty("bus115_2_volt",  globalPropertyf("tu154ce/elec/bus115_2_volt"))   -- Bus 2 voltage
defineProperty("bus115_3_volt",  globalPropertyf("tu154ce/elec/bus115_3_volt"))   -- Bus 3 voltage

-- Emergency bus voltages mirror main buses
defineProperty("bus115_em_1_volt", globalPropertyf("tu154ce/elec/bus115_em_1_volt")) -- Emergency Bus 1
defineProperty("bus115_em_2_volt", globalPropertyf("tu154ce/elec/bus115_em_2_volt")) -- Emergency Bus 2

-- Bus current draws (from devices)
defineProperty("bus115_1_amp",   globalPropertyf("tu154ce/elec/bus115_1_amp"))     -- Bus 1 current draw
defineProperty("bus115_2_amp",   globalPropertyf("tu154ce/elec/bus115_2_amp"))     -- Bus 2 current draw
defineProperty("bus115_3_amp",   globalPropertyf("tu154ce/elec/bus115_3_amp"))     -- Bus 3 current draw
defineProperty("bus115_em_1_amp", globalPropertyf("tu154ce/elec/bus115_em_1_amp")) -- Emerg Bus 1 draw
defineProperty("bus115_em_2_amp", globalPropertyf("tu154ce/elec/bus115_em_2_amp")) -- Emerg Bus 2 draw

-- Generator load outputs (amperage)
defineProperty("gen1_amp",       globalPropertyf("tu154ce/elec/gen1_amp"))       -- Gen 1 load
defineProperty("gen2_amp",       globalPropertyf("tu154ce/elec/gen2_amp"))       -- Gen 2 load
defineProperty("gen3_amp",       globalPropertyf("tu154ce/elec/gen3_amp"))       -- Gen 3 load
defineProperty("gen4_amp",       globalPropertyf("tu154ce/elec/gen4_amp"))       -- APU gen load
defineProperty("gpu_amp",        globalPropertyf("tu154ce/elec/gpu_amp"))        -- GPU load

-- Flight loop timing
defineProperty("frame_time",     globalPropertyf("tu154ce/time/frame_time"))     -- Flight frame time

-- Smart Copilot
defineProperty("ismaster",       globalPropertyf("scp/api/ismaster"))            -- Master flag: 0=none,1=slave,2=master


-- map generators to their DataRefs
local gens = {
  gen1 = { work="gen1_work_bus", volt="gen1_volt_bus", amp="gen1_amp" },
  gen2 = { work="gen2_work_bus", volt="gen2_volt_bus", amp="gen2_amp" },
  gen3 = { work="gen3_work_bus", volt="gen3_volt_bus", amp="gen3_amp" },
  apu  = { work="gen4_work_bus", volt="gen4_volt_bus", amp="gen4_amp" },
  gpu  = { work="gpu_work_bus",  volt="gpu_volt_bus",  amp="gpu_amp" },
}

-- define main buses and their source priority + emergency-amp DataRefs
local busDefs = {
  {
    volt  = "bus115_1_volt", amp   = "bus115_1_amp",
    emVolt= "bus115_em_1_volt", emAmp = "bus115_em_1_amp",
    order = {"gen1","gen2","gen3","apu","gpu"}
  },
  {
    volt  = "bus115_2_volt", amp   = "bus115_2_amp",
    emVolt= "bus115_em_2_volt", emAmp = "bus115_em_2_amp",
    order = {"gen2","gen1","gen3","apu","gpu"}
  },
  {
    volt  = "bus115_3_volt", amp   = "bus115_3_amp",
    emVolt= nil,             emAmp = nil,
    order = {"gen3","gen2","gen1","apu","gpu"}
  },
}

-- cache locals
local get, set = get, set
local ipairs, pairs = ipairs, pairs

-- pick the first available source from a priority list
local function pickSource(order)
  for _, name in ipairs(order) do
    if get(gens[name].work) == 1 then
      return get(gens[name].volt), name
    end
  end
  return 0, nil
end

function update()
  -- only master calculation 
  if get(ismaster) ~= 1 then return end
  if get(frame_time) <= 0 then return end


  for _, g in pairs(gens) do
    set(g.amp, 0)
  end

  for _, bus in ipairs(busDefs) do
    local v, src = pickSource(bus.order)
    set(bus.volt, v)
    if bus.emVolt then set(bus.emVolt, v) end

    local load_main = get(bus.amp)
    local load_em   = bus.emAmp and get(bus.emAmp) or 0
    local totalLoad = load_main + load_em

    if src then
      set(gens[src].amp,
          get(gens[src].amp) + totalLoad
      )
    end
  end
end


