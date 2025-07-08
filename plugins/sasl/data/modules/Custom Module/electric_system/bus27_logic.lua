-- bus27_logic.lua (optimized)
-- 27 V bus logic with IDGs and batteries

-- Helpers
local function bool2int(v)             return v and 1 or 0 end
local function sum(t)                  local s=0 for _,v in ipairs(t) do s=s+v end return s end
local function distributeLoad(total,w) local s=sum(w) if s==0 then return {} end
                                    local out={} for i,v in ipairs(w) do out[i]=total*v/s end
                                    return out end

-- Batch-define DataRefs
local function defineProps(defs)
  for _,d in ipairs(defs) do defineProperty(d[1], d[2](d[3])) end
end

defineProps({
  -- timing & mode
  {"frame_time",      globalPropertyf, "tu154ce/time/frame_time"},
  {"bus27_connect",   globalPropertyi, "tu154ce/switchers/eng/bus27_connect"},
  {"apu_start_seq",   globalPropertyi, "tu154ce/elec/apu_start_seq"},
  {"apu_system_on",   globalPropertyi, "tu154ce/eng/apu_system_on"},
  -- gear deflection
  {"gear_defl",       globalPropertyf, "sim/flightmodel2/gear/tire_vertical_deflection_mtr[1]"},
  -- loads
  {"bus27_amp_L",     globalPropertyf, "tu154ce/elec/bus27_amp_left"},
  {"bus27_amp_R",     globalPropertyf, "tu154ce/elec/bus27_amp_right"},
  {"apu_start_cc",    globalPropertyf, "tu154ce/elec/apu_start_cc"},
  -- outputs
  {"bus27_volt_L",    globalPropertyf, "tu154ce/elec/bus27_volt_left"},
  {"bus27_volt_R",    globalPropertyf, "tu154ce/elec/bus27_volt_right"},
  {"bus27_src_L",     globalPropertyi, "tu154ce/elec/bus27_source_left"},
  {"bus27_src_R",     globalPropertyi, "tu154ce/elec/bus27_source_right"},
  {"buses_tied",      globalPropertyi, "tu154ce/elec/bus_connected"},
  {"apu_bus_volt",    globalPropertyf, "tu154ce/elec/apu_start_bus"},
  {"vu_res_to_L",     globalPropertyi, "tu154ce/elec/vu_res_to_L"},
  {"vu_res_to_R",     globalPropertyi, "tu154ce/elec/vu_res_to_R"},
})

-- IDGs (VU1, VU2, reserve)
local idgs = {
  {
    sw   = globalPropertyi("tu154ce/switchers/eng/bus27_vu1"),
    volt = globalPropertyf("tu154ce/elec/vu1_volt"),
    amp  = globalPropertyf("tu154ce/elec/vu1_amp"),
    fail = globalPropertyi("tu154ce/failures/vu1_fail"),
  },
  {
    sw   = globalPropertyi("tu154ce/switchers/eng/bus27_vu2"),
    volt = globalPropertyf("tu154ce/elec/vu2_volt"),
    amp  = globalPropertyf("tu154ce/elec/vu2_amp"),
    fail = globalPropertyi("tu154ce/failures/vu2_fail"),
  },
  {
    sw   = nil,  -- reserve: detected when VU1 or VU2 switch == -1
    volt = globalPropertyf("tu154ce/elec/vu_res_volt"),
    amp  = globalPropertyf("tu154ce/elec/vu_res_amp"),
    fail = globalPropertyi("tu154ce/failures/vu3_fail"),
  }
}

-- Batteries 1–4
local bats = {}
for i=1,4 do
  bats[i] = {
    on   = globalPropertyi("tu154ce/switchers/eng/bat"..i.."_on"),
    volt = globalPropertyf("tu154ce/elec/bat_volt_"..i),
    amp  = globalPropertyf("tu154ce/elec/bat_amp_"..i),
    kz   = globalPropertyi("tu154ce/failures/bat_"..i.."_kz"),
    fail = globalPropertyi("tu154ce/failures/bat_"..i.."_fail"),
    src  = globalPropertyi("tu154ce/elec/bat_is_source_"..i),
  }
end

-- Locals
local get, set = get, set
local ipairs, pairs = ipairs, pairs

function update()
  local dt = get(frame_time)
  if dt <= 0 then return end

  local loadL   = get(bus27_amp_L)
  local loadR   = get(bus27_amp_R)
  local apuLoad = get(apu_start_cc)

  -- Determine IDG availability and clear loads
  local vuW, vuCount = {}, 0
  for i,idg in ipairs(idgs) do
    local swPos = idg.sw and get(idg.sw) or ((get(idgs[1].sw)==-1) or (get(idgs[2].sw)==-1))
    local canRun = swPos==1 and get(idg.fail)==0 and get("tu154ce/elec/bus115_1_volt")>=115
    vuW[i] = bool2int(canRun)
    vuCount = vuCount + vuW[i]
    set(idg.volt, canRun and 28.5 or 0)
    if not canRun then set(idg.amp, 0) end
  end

  -- Determine battery availability
  local batW, batTotal = {}, 0
  for i,b in ipairs(bats) do
    local works = get(b.on)==1 and get(b.kz)==0 and get(b.fail)==0
    batW[i] = bool2int(works)
    batTotal = batTotal + batW[i]
    set(b.src, batW[i])
  end
  set(globalPropertyi("tu154ce/elec/bat_connected"), batTotal>0 and 1 or 0)

  -- Modes
  local modeStart = get(apu_start_seq)==1
  local modeTie   = (get(bus27_connect)==1 or get(apu_system_on)==1) and not modeStart

  local VbusL, VbusR, Vapu = 0, 0, get(apu_bus_volt)

  if modeStart or modeTie then
    set(buses_tied, 1)

    if vuCount>0 then
      -- IDGs share total load
      local total = loadL + loadR + apuLoad
      local loads = distributeLoad(total, vuW)
      for i,idg in ipairs(idgs) do set(idg.amp, loads[i] or 0) end
      for _,b in ipairs(bats) do set(b.amp, 0) end
      VbusL, VbusR, Vapu = 28.5, 28.5, 28.5

    elseif batTotal>0 then
      -- Batteries share load
      local total = modeStart and (loadL+loadR+apuLoad) or (loadL+loadR)
      local loads = distributeLoad(total, batW)
      for i,b in ipairs(bats) do set(b.amp, loads[i] or 0) end
      for _,idg in ipairs(idgs) do set(idg.amp, 0) end
      local sumV,sumW = 0,0
      for i,b in ipairs(bats) do
        sumV = sumV + get(b.volt)*batW[i]
        sumW = sumW + batW[i]
      end
      if sumW>0 then
        VbusL = sumV/sumW
        VbusR = VbusL
        Vapu  = VbusL
      end
    end

  else
    set(buses_tied, 0)

    -- Left bus: prefer VU1, then reserve, else batteries 1 & 3
    if vuW[1]==1 then
      VbusL = 28.5; set(idgs[1].amp, loadL)
    elseif vuW[3]==1 then
      VbusL = 28.5; set(idgs[3].amp, loadL)
    else
      local w1,w3 = batW[1],batW[3]
      if w1+w3>0 then
        set(bats[1].amp, loadL*w1/(w1+w3))
        set(bats[3].amp, loadL*w3/(w1+w3))
        VbusL = (get(bats[1].volt)*w1 + get(bats[3].volt)*w3)/(w1+w3)
      end
      set(idgs[1].amp,0); set(idgs[3].amp,0)
    end

    -- Right bus: prefer VU2, then reserve, else batteries 2 & 4
    if vuW[2]==1 then
      VbusR = 28.5; set(idgs[2].amp, loadR)
    elseif vuW[3]==1 then
      VbusR = 28.5; set(idgs[3].amp, get(idgs[3].amp)+loadR)
    else
      local w2,w4 = batW[2],batW[4]
      if w2+w4>0 then
        set(bats[2].amp, loadR*w2/(w2+w4))
        set(bats[4].amp, loadR*w4/(w2+w4))
        VbusR = (get(bats[2].volt)*w2 + get(bats[4].volt)*w4)/(w2+w4)
      end
      set(idgs[2].amp,0)
    end
  end

  -- Write back voltages
  set(bus27_volt_L, VbusL)
  set(bus27_volt_R, VbusR)
  set(apu_bus_volt, Vapu)
end
