defineProperty("gpu_present", globalPropertyi("tu154ce/anim/gpu_present")) 
defineProperty("gpu_work_anim", globalPropertyf("tu154ce/anim/gpu_work")) 
defineProperty("gpu_volt", globalPropertyf("tu154ce/elec/gpu_volt"))
defineProperty("gpu_amp", globalPropertyf("tu154ce/elec/gpu_amp"))
defineProperty("gpu_overload", globalPropertyi("tu154ce/elec/gpu_overload"))
defineProperty("gpu_on", globalPropertyi("tu154ce/switchers/eng/gpu_on")) 
defineProperty("gpu_work_bus", globalPropertyi("tu154ce/elec/gpu_work"))
defineProperty("DC_27_volt1", globalPropertyf("tu154ce/elec/bus27_volt_left")) 
defineProperty("DC_27_volt2", globalPropertyf("tu154ce/elec/bus27_volt_right")) 
defineProperty("GS", globalPropertyf("sim/flightmodel/position/groundspeed"))  
defineProperty("frame_time", globalPropertyf("tu154ce/time/frame_time")) 
defineProperty("external_view", globalPropertyi("sim/graphics/view/view_is_external"))
defineProperty("local_x", globalPropertyf("sim/flightmodel/position/local_x")) 
defineProperty("local_y", globalPropertyf("sim/flightmodel/position/local_y")) 
defineProperty("local_z", globalPropertyf("sim/flightmodel/position/local_z")) 
defineProperty("view_x", globalPropertyf("sim/graphics/view/view_x")) 
defineProperty("view_y", globalPropertyf("sim/graphics/view/view_y")) 
defineProperty("view_z", globalPropertyf("sim/graphics/view/view_z")) 
defineProperty("ismaster", globalPropertyf("scp/api/ismaster")) 
defineProperty("hascontrol_1", globalPropertyf("scp/api/hascontrol_1")) 
local gpu_start_out = loadSample('Custom Sounds/gpu_start_out.wav')
local gpu_run_out = loadSample('Custom Sounds/gpu_run_out.wav')
local gpu_stop_out = loadSample('Custom Sounds/gpu_stop_out.wav')
local gpu_start_inn = loadSample('Custom Sounds/gpu_start_inn.wav')
local gpu_run_inn = loadSample('Custom Sounds/gpu_run_inn.wav')
local gpu_stop_inn = loadSample('Custom Sounds/gpu_stop_inn.wav')
local work_timer = 0
local last_dist = 0
local gpu_connect_timer = 0
local gpuSoundsLoaded = true
local gpu_eject_timer = 0
local function loadSounds()
	gpu_start_out = loadSample('Custom Sounds/gpu_start_out.wav')
	gpu_run_out = loadSample('Custom Sounds/gpu_run_out.wav')
	gpu_stop_out = loadSample('Custom Sounds/gpu_stop_out.wav')
	gpu_start_inn = loadSample('Custom Sounds/gpu_start_inn.wav')
	gpu_run_inn = loadSample('Custom Sounds/gpu_run_inn.wav')
	gpu_stop_inn = loadSample('Custom Sounds/gpu_stop_inn.wav')
	gpuSoundsLoaded = true
end
local function unloadSounds()
	unloadSample(gpu_start_out)
	unloadSample(gpu_run_out)
	unloadSample(gpu_stop_out)
	unloadSample(gpu_start_inn)
	unloadSample(gpu_run_inn)
	unloadSample(gpu_stop_inn)
	gpuSoundsLoaded = false
end
function update()
	local passed = get(frame_time)
	local external = get(external_view) 
	local present = get(gpu_present)
	if math.abs(get(GS)) > 0.1 then
		gpu_eject_timer = gpu_eject_timer + passed
	else
		gpu_eject_timer = 0
	end
	if gpu_eject_timer < 1 then
		if present == 1 then 
			work_timer = work_timer + passed * 0.25 
		else 
			work_timer = work_timer - passed * 0.1 
			set(gpu_overload, 0) 
		end
		if work_timer > 1 then 
			work_timer = 1
			if get(DC_27_volt1) > 13 or get(DC_27_volt2) > 13 then 
				set(gpu_volt, 115 * (1 - get(gpu_overload)))
			else
				set(gpu_volt, 0)
			end
		elseif work_timer < 0 then 
			work_timer = 0
			set(gpu_volt, 0)
		elseif work_timer < 0.9 then 
			set(gpu_volt, 0)
		end
		set(gpu_work_anim, work_timer) 
		if get(gpu_on) == 1 then 
			gpu_connect_timer = gpu_connect_timer + passed
			if gpu_connect_timer >= 1 then
				if work_timer == 1 and get(gpu_overload) ~= 1 then set(gpu_work_bus, 1) 
				else set(gpu_work_bus, 0) end
				gpu_connect_timer = 1
			else
				set(gpu_work_bus, 0) 
			end
		else 
			set(gpu_work_bus, 0) 
			gpu_connect_timer = 0
		end
		if get(gpu_amp) > 500 then set(gpu_overload, 1)
		elseif get(gpu_on) == 0 then set(gpu_overload, 0) end
		if work_timer > 0 and work_timer < 1 and not isSamplePlaying(gpu_start_out) and present == 1 then
			playSample(gpu_start_out, 0)
			playSample(gpu_start_inn, 0)
			stopSample(gpu_run_out)
			stopSample(gpu_run_inn)
		elseif work_timer == 1 and not isSamplePlaying(gpu_run_out) then
			playSample(gpu_run_out, 1)
			playSample(gpu_run_inn, 1)
		elseif work_timer > 0 and work_timer < 1 and not isSamplePlaying(gpu_stop_out) and present == 0 then
			playSample(gpu_stop_out, 0)
			playSample(gpu_stop_inn, 0)
			stopSample(gpu_start_out)
			stopSample(gpu_run_out)
			stopSample(gpu_start_inn)
			stopSample(gpu_run_inn)
		elseif work_timer == 0 then
			stopSample(gpu_start_out)
			stopSample(gpu_start_inn)
			stopSample(gpu_run_out)
			stopSample(gpu_run_inn)
		end
		local camera_distance = math.sqrt(((get(view_x)-get(local_x))^2)+((get(view_y)-get(local_y))^2)+((get(view_z)-get(local_z))^2)) 
		if camera_distance < 1 then camera_distance = 1 end 
		local dist_coef = 300 / camera_distance ^ 1.7
		if dist_coef > 1 then dist_coef = 1 end
		local spd_time = math.min(0.0001, passed)
		local camera_spd = -(camera_distance - last_dist) / spd_time
		last_dist = camera_distance
		local dopp_coef = camera_spd * 0.02
		if dopp_coef > 400 then dopp_coef = 300
		elseif dopp_coef < -300 then dopp_coef = -300 end
		local window_open = 0 
		setSampleGain(gpu_start_out, 1000 * (external + window_open * (1 - external)) * dist_coef)
		setSampleGain(gpu_run_out, 1000 * (external + window_open * (1 - external)) * dist_coef)
		setSampleGain(gpu_stop_out, 1000 * (external + window_open * (1 - external)) * dist_coef)
		setSampleGain(gpu_start_inn, 2000 * (1 - external))
		setSampleGain(gpu_run_inn, 2000 * (1 - external))
		setSampleGain(gpu_stop_inn, 2000 * (1 - external))
	else
		work_timer = 0
		set(gpu_work_anim, 0)
		set(gpu_present, 0)
		set(gpu_volt, 0)
		set(gpu_overload, 0)
		set(gpu_work_bus, 0)
		stopSample(gpu_run_out)
		stopSample(gpu_start_out)
		stopSample(gpu_stop_out)
	end
end