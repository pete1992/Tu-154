-- bus36_logic.lua (optimized)
-- Handles 36 V distribution from 115 V transformers and PTS250 converters (for Tu-154M SASL 3.19+)

-- Helper: boolean → integer
local function bool2int(v) return v and 1 or 0 end

-- Frame timer & master flag
local frame_time = globalPropertyf("tu154ce/time/frame_time")
local ismaster   = globalPropertyf("scp/api/ismaster")

-- Transformer ratio (115 V → 36 V)
local TR_RATIO = 3.27

-- Transformer definitions (TR1=links, TR2=rechts)
local transformers = {
  { sw = globalPropertyi("tu154ce/switchers/eng/bus36_tr_left_to_right"),
    fail = globalPropertyi("tu154ce/failures/tr1_fail"),
    work = globalPropertyi("tu154ce/elec/bus36_tr1_work"),
    in115 = globalPropertyf("tu154ce/elec/bus115_1_volt"),
    volt36 = globalPropertyf("tu154ce/elec/bus36_volt_left"),
  },
  { sw = globalPropertyi("tu154ce/switchers/eng/bus36_tr_right_to_left"),
    fail = globalPropertyi("tu154ce/failures/tr2_fail"),
    work = globalPropertyi("tu154ce/elec/bus36_tr2_work"),
    in115 = globalPropertyf("tu154ce/elec/bus115_3_volt"),
    volt36 = globalPropertyf("tu154ce/elec/bus36_volt_right"),
  },
}

-- PTS250 frequency converters
local pts250 = {
  { on = globalPropertyi("tu154ce/switchers/eng/pts250_on"),
    mode = globalPropertyi("tu154ce/switchers/eng/pts250_mode"),
    fail = globalPropertyi("tu154ce/failures/pts250_1_fail"),
    work = globalPropertyi("tu154ce/elec/bus36_pts1_work"),
    volt36 = globalPropertyf("tu154ce/elec/bus36_volt_pts250_1"),
    bus27 = globalPropertyf("tu154ce/elec/bus27_volt_right"),
    amp36 = globalPropertyf("tu154ce/elec/bus36_amp_pts250_1"),
  },
  { on = globalPropertyi("tu154ce/switchers/eng/pts250_on"),
    mode = globalPropertyi("tu154ce/switchers/eng/pts250_mode"),
    fail = globalPropertyi("tu154ce/failures/pts250_2_fail"),
    work = globalPropertyi("tu154ce/elec/bus36_pts2_work"),
    volt36 = globalPropertyf("tu154ce/elec/bus36_volt_pts250_2"),
    bus27 = globalPropertyf("tu154ce/elec/bus27_volt_left"),
    amp36 = globalPropertyf("tu154ce/elec/bus36_amp_pts250_2"),
  },
}

-- APU/AGR override for PTS1
local agr_on = globalPropertyi("tu154ce/switchers/ovhd/agr_on")

-- Output DataRefs
local srcL_ref = globalPropertyi("tu154ce/elec/bus36_src_L")
local srcR_ref = globalPropertyi("tu154ce/elec/bus36_src_R")
local pts1_amp = pts250[1].amp36
local pts2_amp = pts250[2].amp36

-- 115/27 V feeder backwrites
local bus115_1_amp = globalPropertyf("tu154ce/elec/bus115_1_amp")
local bus115_3_amp = globalPropertyf("tu154ce/elec/bus115_3_amp")
local bus27_L_amp  = globalPropertyf("tu154ce/elec/bus27_amp_left")
local bus27_R_amp  = globalPropertyf("tu154ce/elec/bus27_amp_right")

function update()
  if get(frame_time) <= 0 or get(ismaster) ~= 1 then return end -- only on master

  -- 1. Compute transformer output (if not failed)
  local trVolt = {}
  for i, tr in ipairs(transformers) do
    local inV = get(tr.in115)
    local good = inV > 0 and get(tr.fail) == 0
    local v36 = good and (inV / TR_RATIO) or 0
    set(tr.work, bool2int(v36 > 30))
    trVolt[i] = v36
  end

  -- 2. Left/Right 36 V Bus Source Selection
  -- LEFT: prefer TR1, else TR2
  local swL = get(transformers[1].sw)
  local useTR1 = (swL == 0 and trVolt[1] > 30)
  set(srcL_ref, useTR1 and 0 or 1) -- 0=TR1, 1=TR2
  set(transformers[useTR1 and 1 or 2].volt36, trVolt[useTR1 and 1 or 2])

  -- RIGHT: prefer TR2, else TR1
  local swR = get(transformers[2].sw)
  local useTR2 = (swR == 0 and trVolt[2] > 30)
  set(srcR_ref, useTR2 and 0 or 1) -- 0=TR2, 1=TR1
  set(transformers[useTR2 and 2 or 1].volt36, trVolt[useTR2 and 2 or 1])

  -- 3. PTS250 operation
  for i, pts in ipairs(pts250) do
    local bus27V = get(pts.bus27)
    local canRun = bus27V > 13 and (get(pts.on) == 1 or get(agr_on) == 1) and get(pts.fail) == 0
    if canRun then
      set(pts.work, 1)
      set(pts.volt36, 36)
    else
      set(pts.work, 0)
      set(pts.volt36, 0)
    end
  end

  -- 4. PTS250 Loads zurückverteilen
  local pts1_load = get(pts1_amp)
  if get(pts250[1].work) == 1 then
    set(bus27_R_amp, get(bus27_R_amp) + pts1_load * 1.4)
  else
    set(bus115_3_amp, get(bus115_3_amp) + pts1_load * 1.05)
  end

  local pts2_load = get(pts2_amp)
  if get(pts250[2].work) == 1 then
    set(bus27_L_amp, get(bus27_L_amp) + pts2_load * 1.4)
  else
    set(bus115_1_amp, get(bus115_1_amp) + pts2_load * 1.05)
  end
end
