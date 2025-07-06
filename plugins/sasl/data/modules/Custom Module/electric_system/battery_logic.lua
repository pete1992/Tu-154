-- Battery logic: voltage, current and temperature simulation

-- DataRef-Definitionen
defineProperty("bat_on_bus", globalPropertyi("tu154ce/switchers/eng/bat1_on"))          -- battery connected to bus
defineProperty("bat_source", globalPropertyi("tu154ce/elec/bat_is_source_1"))           -- battery is power source
defineProperty("bat_amp_bus", globalPropertyf("tu154ce/elec/bat_amp_1"))                -- battery load (A)
defineProperty("bat_amp_cc",  globalPropertyf("tu154ce/elec/bat_cc_1"))                 -- battery charge current (A)
defineProperty("bat_volt_bus",globalPropertyf("tu154ce/elec/bat_volt_1"))               -- battery voltage (V)
defineProperty("bat_thermo",  globalPropertyf("tu154ce/elec/bat_therm_1"))              -- battery temperature (°C)

defineProperty("bat_fail",    globalPropertyi("tu154ce/failures/bat_1_fail"))           -- battery failure flag
defineProperty("bat_kz",      globalPropertyi("tu154ce/failures/bat_1_kz"))             -- thermal runaway flag

defineProperty("bus_volt",    globalPropertyf("tu154ce/elec/bus27_volt_left"))          -- bus voltage (V)
defineProperty("cockpit_temp",globalPropertyf("tu154ce/thermo/cockpit_temp"))           -- cockpit temperature (°C)

-- Other DataRefs
defineProperty("frame_time",  globalPropertyf("tu154ce/time/frame_time"))               -- frame time (s)
defineProperty("sim_bat_on",  globalProperty("sim/cockpit2/electrical/battery_on[0]"))  -- X-Plane battery switch

-- Smart Copilot
defineProperty("ismaster",    globalPropertyf("scp/api/ismaster"))                     -- master/slave flag
defineProperty("hascontrol_1",globalPropertyf("scp/api/hascontrol_1"))                 -- control grant flag

-- Helper: linear interpolation over a table of {x, y} pairs
local function interpolate(tbl, x)
  for i = 1, #tbl - 1 do
    local x0, y0 = tbl[i][1], tbl[i][2]
    local x1, y1 = tbl[i+1][1], tbl[i+1][2]
    if x >= x0 and x <= x1 then
      local t = (x - x0) / (x1 - x0)
      return y0 + t * (y1 - y0)
    end
  end
  return tbl[#tbl][2]
end

-- Charge‐current lookup table: {battery charge current [A], lookup value}
local current_table = {
  { -5000,   0},   -- bugs workaround
  {     0,   0},
  {   600, 100},
  {  1200, 500},
  {  1800,1000},
  { 20000,1000}    -- bugs workaround
}

-- Initial states and constants
local bat_capacity    = 25 - math.random() * 1.5  -- A·h
local BAT_CURRENT_COEF=  2                       -- A per A·h to charge
local kz_timer        =  0                       -- thermal‐runaway accumulation
local KZ_TIMER_COEF   =  1                       -- runaway speed
local thermo          = 20                       -- battery temperature

function update()
  local MASTER = get(ismaster) ~= 1
  local passed = get(frame_time)
  if not MASTER or passed <= 0 then return end

  -- Temperature‐dependent max capacity [A·h]
  local max_cap = 45 + get(cockpit_temp)
  max_cap = math.min(25, math.max(0, max_cap))
  bat_capacity = math.min(bat_capacity, max_cap)

  -- Read inputs
  local bat_on  = get(bat_on_bus)
  local bus_amp = get(bat_amp_bus)
  local fail    = get(bat_fail) == 1
  local runaway = get(bat_kz)   == 1
  set(sim_bat_on, bat_on)

  -- Base voltage model
  local bat_volt = 17 + ((bat_capacity - kz_timer) / 2.5) - 1.5 * bus_amp / 100

  if bat_on == 1 then
    if get(bat_source) == 1 then
      -- Discharge mode
      bat_capacity = bat_capacity - bus_amp * passed / 3600
      bat_volt = 17 + ((bat_capacity - kz_timer) / 2.5) - 1.5 * bus_amp / 100
      if bat_capacity < 2 then bat_volt = 3 end
      set(bat_amp_cc, 0)

    else
      -- Charge mode
      if fail then
        bat_capacity = 0
        bat_volt     = 3
        max_cap      = 0
      end
      bat_volt = math.max(bat_volt, get(bus_volt))
      bat_capacity = bat_capacity + passed * 0.01
      local charge_current = (max_cap - bat_capacity) * BAT_CURRENT_COEF
                             + interpolate(current_table, kz_timer)
      set(bat_amp_cc, charge_current)
    end

    -- Thermal‐runaway accumulation
    if runaway and kz_timer < 1800 then
      kz_timer = kz_timer + passed * KZ_TIMER_COEF
    end
    max_cap = max_cap - kz_timer

    -- Clamp capacity
    bat_capacity = math.max(0, math.min(bat_capacity, max_cap))

    -- Apply voltage and temperature
    set(bat_volt_bus, bat_volt)
    thermo = 20 + get(bat_amp_cc) * 0.3
    set(bat_thermo, thermo)

  else
    -- Batteries off: show failures and cooldown
    if fail then
      bat_capacity = 0
      bat_volt     = 3
      max_cap      = 0
    end
    set(bat_amp_cc, 0)
    set(bat_volt_bus, bat_volt)
    if thermo > 20 then thermo = thermo - passed * 0.5 end
    set(bat_thermo, thermo)
  end
end
