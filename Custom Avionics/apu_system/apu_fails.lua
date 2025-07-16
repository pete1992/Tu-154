defineProperty("failures_enabled", globalPropertyi("sim/custom/failures/failures_enabled"))
defineProperty("frame_time", globalPropertyf("sim/custom/time/frame_time")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("apu_start_fail",globalPropertyi("sim/custom/failures/apu_start_fail")) 
defineProperty("apu_gen_fail",globalPropertyi("sim/custom/failures/apu_gen_fail")) 
defineProperty("apu_fail_oilt",globalPropertyi("sim/custom/failures/apu_fail_oilt")) 
defineProperty("apu_fail_egt",globalPropertyi("sim/custom/failures/apu_fail_egt")) 
defineProperty("apu_fail_fuel_left",globalPropertyi("sim/custom/failures/apu_fail_fuel_left")) 
defineProperty("apu_fail",globalPropertyi("sim/custom/failures/apu_fail")) 
defineProperty("apu_press_fail", globalPropertyi("sim/custom/failures/apu_press_fail")) 
local fail_counter = 0
local check_time = math.random(15, 30)
function update()
	local passed = get(frame_time)
if get(ismaster) ~= 1 then
	local FAIL = get(failures_enabled)
	FAIL = FAIL * 0.05 * 4 ^ (FAIL * 0.5)
	if FAIL > 0 then
		fail_counter = fail_counter + passed
		if fail_counter > check_time then
			fail_counter = 0
			check_time = math.random(15, 30)
			if get(apu_start_fail) ~= 1 then set(apu_start_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(apu_gen_fail) ~= 1 then set(apu_gen_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(apu_fail) ~= 1 then set(apu_fail, bool2int(math.random() < 0.00001 * FAIL * 0.3) * 1) end
			if get(apu_runtime) == 0 then
				if get(apu_fail) ~= 1 then set(apu_fail, bool2int(math.random() < 0.01 * FAIL * 0.3) * 1) end
			end
		end
	else
		fail_counter = 0
		set(apu_start_fail, 0)
		set(apu_gen_fail, 0)
		set(apu_fail_oilt, 0)
		set(apu_fail_egt, 0)
		set(apu_fail_fuel_left, 0)
		set(apu_fail, 0)
		set(apu_press_fail, 0)
	end
end
end