-- Helper: boolean → integer
local function bool2int(v) return v and 1 or 0 end

-- Frame timer & master flag
local frame_time = globalPropertyf("tu154ce/time/frame_time")
local ismaster   = globalPropertyf("scp/api/ismaster")

-- Transformer ratio (115 V → 36 V)
local TR_RATIO = 3.27

-- Transformer definitions (tr1 drives left, tr2 drives right)
local transformers = {
  { -- TR1 (primary for left bus)
    sw    = globalPropertyi("tu154ce/switchers/eng/bus36_tr_left_to_right"),
    fail  = globalPropertyi("tu154ce/failures/tr1_fail"),
    work  = globalPropertyi("tu154ce/elec/bus36_tr1_work"),
    in115 = globalPropertyf("tu154ce/elec/bus115_1_volt"),
    volt36= globalPropertyf("tu154ce/elec/bus36_volt_left"),
  },
  { -- TR2 (primary for right bus)
    sw    = globalPropertyi("tu154ce/switchers/eng/bus36_tr_right_to_left"),
    fail  = globalPropertyi("tu154ce/failures/tr2_fail"),
    work  = globalPropertyi("tu154ce/elec/bus36_tr2_work"),
    in115 = globalPropertyf("tu154ce/elec/bus115_3_volt"),
    volt36= globalPropertyf("tu154ce/elec/bus36_volt_right"),
  },
}

-- PTS250 frequency converters
local pts250 = {
  { -- PTS1 drives 36 V bus #3 from 27 V right
    on    = globalPropertyi("tu154ce/switchers/eng/pts250_on"),
    mode  = globalPropertyi("tu154ce/switchers/eng/pts250_mode"),
    fail  = globalPropertyi("tu154ce/failures/pts250_1_fail"),
    work  = globalPropertyi("tu154ce/elec/bus36_pts1_work"),
    volt36= globalPropertyf("tu154ce/elec/bus36_volt_pts250_1"),
    bus27 = globalPropertyf("tu154ce/elec/bus27_volt_right"),
    amp36 = globalPropertyf("tu154ce/elec/bus36_amp_pts250_1"),
  },
  { -- PTS2 drives 36 V bus #4 from 27 V left
    on    = globalPropertyi("tu154ce/switchers/eng/pts250_on"),
    mode  = globalPropertyi("tu154ce/switchers/eng/pts250_mode"),
    fail  = globalPropertyi("tu154ce/failures/pts250_2_fail"),
    work  = globalPropertyi("tu154ce/elec/bus36_pts2_work"),
    volt36= globalPropertyf("tu154ce/elec/bus36_volt_pts250_2"),
    bus27 = globalPropertyf("tu154ce/elec/bus27_volt_left"),
    amp36 = globalPropertyf("tu154ce/elec/bus36_amp_pts250_2"),
  },
}

-- APU/AGR override for PTS1
local agr_on      = globalPropertyi("tu154ce/switchers/ovhd/agr_on")

-- Outputs back to your datarefs
local srcL_ref    = globalPropertyi("tu154ce/elec/bus36_src_L")
local srcR_ref    = globalPropertyi("tu154ce/elec/bus36_src_R")
local pts1_amp    = pts250[1].amp36
local pts2_amp    = pts250[2].amp36

-- Also need to bump the 115/27 V feeders
local bus115_1_amp = globalPropertyf("tu154ce/elec/bus115_1_amp")
local bus115_3_amp = globalPropertyf("tu154ce/elec/bus115_3_amp")
local bus27_L_amp  = globalPropertyf("tu154ce/elec/bus27_amp_left")
local bus27_R_amp  = globalPropertyf("tu154ce/elec/bus27_amp_right")

function update()
  if get(frame_time) <= 0 or get(ismaster)==1 then return end
  -- 1. Compute each TR’s available 36 V
  local trVolt = {}
  for i,tr in ipairs(transformers) do
    local inV = get(tr.in115)
    local good = inV>0 and get(tr.fail)==0
    local v36  = good and (inV / TR_RATIO) or 0
    set(tr.work, bool2int(v36>30))
    trVolt[i] = v36
  end

  -- 2. Pick left 36 V: auto or manual
  local swL = get(transformers[1].sw)
  local leftSrc = (swL==0 and trVolt[1]>30) and 1 or 2
  set(srcL_ref, leftSrc==1 and 0 or 1)  -- 0=TR1,1=TR2
  set(transformers[leftSrc].volt36, trVolt[leftSrc])

  -- 3. Pick right 36 V
  local swR = get(transformers[2].sw)
  local rightSrc = (swR==0 and trVolt[2]>30) and 0 or 1
  set(srcR_ref, rightSrc==1 and 0 or 1) -- 0=TR2,1=TR1
  set(transformers[3-rightSrc].volt36, trVolt[3-rightSrc])

  -- 4. PTS250 converters
  for i,pts in ipairs(pts250) do
    local bus27V = get(pts.bus27)
    local canRun = bus27V>13 and (get(pts.on)==1 or get(agr_on)==1) and get(pts.fail)==0
    if canRun then
      set(pts.work, 1)
      set(pts.volt36, 36)
    else
      set(pts.work, 0)
      set(pts.volt36, 0)
    end
  end

  -- 5. Distribute those loads back into the 115 and 27 V systems...
  --    PTS1 feeds bus36#3 → if pts250[1].volt36>0, that current 
  --    must come from bus27_R and from bus36_R at the transformer’s 1/3.27 ratio
  local pts1_load = get(pts1_amp)
  if get(pts250[1].work)==1 then
    set(bus27_R_amp, bus27_R_amp + pts1_load * 1.4)
  else
    set(bus115_3_amp, bus115_3_amp + pts1_load * 1.05)
  end

  local pts2_load = get(pts2_amp)
  if get(pts250[2].work)==1 then
    set(bus27_L_amp, bus27_L_amp + pts2_load * 1.4)
  else
    set(bus115_1_amp, bus115_1_amp + pts2_load * 1.05)
  end
end
