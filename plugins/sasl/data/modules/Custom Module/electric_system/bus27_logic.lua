--==============================================================================
-- 27 V Bus Logic 
--==============================================================================

-- Helpers ----------------------------------------------------------------------
local function bool2int(v) return v and 1 or 0 end

-- Sum a list of numbers
local function sum(t)
  local s = 0
  for _, v in ipairs(t) do s = s + v end
  return s
end

-- Distribute `total` among weights[], preserving their ratio
local function distributeLoad(total, weights)
  local s = sum(weights)
  if s == 0 then return {} end
  local out = {}
  for i,w in ipairs(weights) do
    out[i] = total * w / s
  end
  return out
end


-- DataRef mappings ------------------------------------------------------------

-- Frame timing
local frame_time    = globalPropertyf("tu154ce/time/frame_time")

-- Bus‐tie switch and APU start flags
local bus27_connect = globalPropertyi("tu154ce/switchers/eng/bus27_connect")
local apu_start_seq = globalPropertyi("tu154ce/elec/apu_start_seq")
local apu_system_on = globalPropertyi("tu154ce/eng/apu_system_on")

-- Gear deflection (for ground APU-start battery logic)
local gear_defl     = globalProperty("sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]")

-- Left/right 27 V bus loads
local bus27_amp_L   = globalPropertyf("tu154ce/elec/bus27_amp_left")
local bus27_amp_R   = globalPropertyf("tu154ce/elec/bus27_amp_right")

-- Outputs: voltages, sources, tie-flag
local bus27_volt_L  = globalPropertyf("tu154ce/elec/bus27_volt_left")
local bus27_volt_R  = globalPropertyf("tu154ce/elec/bus27_volt_right")
local bus27_src_L   = globalPropertyi("tu154ce/elec/bus27_source_left")
local bus27_src_R   = globalPropertyi("tu154ce/elec/bus27_source_right")
local buses_tied    = globalPropertyi("tu154ce/elec/bus_connected")
local apu_bus_volt  = globalPropertyf("tu154ce/elec/apu_start_bus")
local vu_res_to_L   = globalPropertyi("tu154ce/elec/vu_res_to_L")
local vu_res_to_R   = globalPropertyi("tu154ce/elec/vu_res_to_R")

-- IDGs (VU) switches, volt/current refs & failure flags
local idgs = {
  { sw = globalPropertyi("tu154ce/switchers/eng/bus27_vu1"),
    volt = globalPropertyf("tu154ce/elec/vu1_volt"),
    amp  = globalPropertyf("tu154ce/elec/vu1_amp"),
    fail = globalPropertyi("tu154ce/failures/vu1_fail") },

  { sw = globalPropertyi("tu154ce/switchers/eng/bus27_vu2"),
    volt = globalPropertyf("tu154ce/elec/vu2_volt"),
    amp  = globalPropertyf("tu154ce/elec/vu2_amp"),
    fail = globalPropertyi("tu154ce/failures/vu2_fail") },

  { -- reserve IDG
    sw = nil,  -- we’ll detect via sw of VU1 or VU2 == -1
    volt = globalPropertyf("tu154ce/elec/vu_res_volt"),
    amp  = globalPropertyf("tu154ce/elec/vu_res_amp"),
    fail = globalPropertyi("tu154ce/failures/vu3_fail") },
}

-- Batteries: switch, volt, amp, thermal runaway flag, failure flag, source flag
local bats = {}
for i=1,4 do
  bats[i] = {
    on    = globalPropertyi("tu154ce/switchers/eng/bat"..i.."_on"),
    volt  = globalPropertyf("tu154ce/elec/bat_volt_"..i),
    amp   = globalPropertyf("tu154ce/elec/bat_amp_"..i),
    kz    = globalPropertyi("tu154ce/failures/bat_"..i.."_kz"),
    fail  = globalPropertyi("tu154ce/failures/bat_"..i.."_fail"),
    src   = globalPropertyi("tu154ce/elec/bat_is_source_"..i),
  }
end


-- Update loop -----------------------------------------------------------------
function update()
  if get(frame_time) <= 0 then return end
  local passed  = get(frame_time)
  local loadL   = get(bus27_amp_L)
  local loadR   = get(bus27_amp_R)
  local apuLoad = get(globalPropertyf("tu154ce/elec/apu_start_cc"))

  -- Determine IDG availability & set voltages
  local vuWeights, vuCount = {}, 0
  for idx, idg in ipairs(idgs) do
    local swPos = idg.sw and get(idg.sw) or nil
    local canRun = (idx<3 and swPos==1) or
                   (idx==3 and ((get(idgs[1].sw)==-1) or (get(idgs[2].sw)==-1)))
    canRun = canRun and get(idg.fail)==0 and get(globalPropertyf("tu154ce/elec/bus115_1_volt"))>=115
    vuWeights[idx] = bool2int(canRun)
    vuCount = vuCount + vuWeights[idx]
    set(idg.volt, canRun and 28.5 or 0)
    if not canRun then set(idg.amp, 0) end
  end

  -- Determine battery availability & set source flags
  local batWeights, batTotal = {}, 0
  for i,b in ipairs(bats) do
    local works = get(b.on)==1 and get(b.kz)==0 and get(b.fail)==0
    set(b.src, bool2int(works))
    batWeights[i] = bool2int(works)
    batTotal = batTotal + batWeights[i]
  end
  set(globalPropertyi("tu154ce/elec/bat_connected"), batTotal>0 and 1 or 0)

  -- Modes
  local modeStart = get(apu_start_seq)==1
  local modeTie   = (get(bus27_connect)==1 or get(apu_system_on)==1) and not modeStart

  local VbusL, VbusR, Vapu = 0, 0, get(apu_bus_volt)

  if modeStart or modeTie then
    set(buses_tied, 1)

    if vuCount>0 then
      -- all IDGs share (L+R+APU) load
      local loads = distributeLoad(loadL+loadR+apuLoad, vuWeights)
      for i,idg in ipairs(idgs) do set(idg.amp, loads[i]) end
      for _,b in ipairs(bats) do set(b.amp, 0) end
      VbusL, VbusR, Vapu = 28.5, 28.5, 28.5

    elseif batTotal>0 then
      -- bats share
      local totalLoad = modeStart and (loadL+loadR+apuLoad) or (loadL+loadR)
      local dist = distributeLoad(totalLoad, batWeights)
      for i,b in ipairs(bats) do set(b.amp, dist[i]) end
      for _,idg in ipairs(idgs) do set(idg.amp, 0) end
      -- composite battery voltage
      local sumV, sumW = 0, 0
      for i,b in ipairs(bats) do
        sumV = sumV + get(b.volt)*batWeights[i]
        sumW = sumW + batWeights[i]
      end
      if sumW>0 then
        VbusL = sumV/sumW
        VbusR = VbusL
        Vapu  = VbusL
      end
    end

  else
    set(buses_tied, 0)

    -- Left bus
    if vuWeights[1]==1 then
      VbusL = 28.5; set(idgs[1].amp, loadL)
    elseif vuWeights[3]==1 then
      VbusL = 28.5; set(idgs[3].amp, loadL)
    else
      local w1,w3 = batWeights[1], batWeights[3]
      if w1+w3>0 then
        set(bats[1].amp, loadL*w1/(w1+w3))
        set(bats[3].amp, loadL*w3/(w1+w3))
        VbusL = (get(bats[1].volt)*w1 + get(bats[3].volt)*w3)/(w1+w3)
      end
      set(idgs[1].amp,0); set(idgs[3].amp,0)
    end

    -- Right bus
    if vuWeights[2]==1 then
      VbusR = 28.5; set(idgs[2].amp, loadR)
    elseif vuWeights[3]==1 then
      VbusR = 28.5; set(idgs[3].amp, get(idgs[3].amp) + loadR)
    else
      local w2,w4 = batWeights[2], batWeights[4]
      if w2+w4>0 then
        set(bats[2].amp, loadR*w2/(w2+w4))
        set(bats[4].amp, loadR*w4/(w2+w4))
        VbusR = (get(bats[2].volt)*w2 + get(bats[4].volt)*w4)/(w2+w4)
      end
      set(idgs[2].amp,0)
    end
  end

  -- Write-backs ---------------------------------------------------------------
  set(bus27_volt_L, VbusL)
  set(bus27_volt_R, VbusR)
  set(apu_bus_volt, Vapu)
end
