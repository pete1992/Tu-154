function interpolate(tbl, value)
    local lastActual = 0
    local lastReference = 0
    for _k, v in pairs(tbl) do
        if value == v[1] then
            return v[2]
        end
        if value < v[1] then
            local a = value - lastActual
            local m = v[2] - lastReference
            return lastReference + a / (v[1] - lastActual) * m
        end
        lastActual = v[1]
        lastReference = v[2]
    end
    return value - lastActual + lastReference
end
function sign(x)
	if x >= 0 then return 1 else return -1 end
end
function bool2int(var)
	if var then return 1
	else return 0 end
end
function line(x, x1, y1, x2, y2)  
	if x2 - x1 ~= 0 then 
		return (x - x1)*(y2 - y1)/(x2 - x1) + y1
	else return 0 
	end
end
function map(value, x1, x2, y1, y2)
	return line (value, x1, y1, x2, y2)
end
function isILS(freq)
    if (10810 > freq) or (11195 < freq) then
        return false
    end
    local v, f = math.modf(freq / 100)
	v = math.floor(f * 10 + 0.001)
    return 1 == (v % 2)
end
function rotaryDigits(procNum, digitsNum, signed, negSHift, INT)
	if signed == nil then signed = false end
	if negSHift == nil then negSHift = -1 end
	if INT == nil then INT = false end
	local digitTable = {}
	if signed then 
		if procNum < 0 then digitTable[digitsNum+1] = negSHift else digitTable[digitsNum+1] = 0 end
	end
	procNum = math.abs(procNum)
	for i = 1, digitsNum do
		if i == 1 then 
			digitTable[i] = procNum % 10
			digitTable[i] = math.floor(digitTable[i] * 100) / 100
		else
			digitTable[i] = math.floor(procNum % 10^i / (10^(i-1))) 
			if digitTable[i-1] > 9 and digitTable[i-1] < 9.9999999 and not INT then 
				digitTable[i] = digitTable[i] + (digitTable[i-1] - 9)
			end
		end
	end
	return digitTable
end
function rotaryDigits2(procNum, digitsNum, signed, negSHift, INT)
	if signed == nil then signed = false end
	if negSHift == nil then negSHift = -1 end
	if INT == nil then INT = false end
	local digitTable = {}
	if signed then 
		if procNum < 0 then digitTable[digitsNum+1] = negSHift else digitTable[digitsNum+1] = 0 end
		procNum = math.abs(procNum)
	end
	for i = 1, digitsNum do
		if i == 1 then 
			digitTable[i] = procNum
			digitTable[i] = math.floor(digitTable[i] * 100) / 100
		else
			digitTable[i] = math.floor(procNum / (10^(i-1))) 
			if digitTable[i-1] > 9 and digitTable[i-1] < 9.9999999 and not INT then 
				digitTable[i] = digitTable[i] + (digitTable[i-1] - 9) 
			end
		end
	end
	return digitTable
end
function limit(value, vmin, vmax)
	if not vmin then vmin = 0 end
	if not vmax then vmax = 1 end
	local lim = value
	if lim < vmin then lim = vmin 
	elseif lim > vmax then lim = vmax end
	return lim
end
function mapLim(value, x1, x2, y1, y2)
	local limMin, limMax = y1, y2
	if limMin > limMax then limMin, limMax = limMax, limMin end
	return limit(map(value, x1, x2, y1, y2), limMin, limMax)
end
function tabMax(tab, num)
	if #tab == 0 then return nil, nil end
	if num == nil then num = #tab end
	local result = tab[1]
	local id = 1
	for i = 1, num do
		if result < tab[i] then result = tab[i] id = i end
	end
	return result, id
end
function tabMin(tab, num)
	if #tab == 0 then return nil, nil end
	if num == nil then num = #tab end
	local result = tab[1]
	local id = 1
	for i = 1, num do
		if result > tab[i] then result = tab[i] id = i end
	end
	return result, id
end
function tabMean(tab, num)
	if #tab == 0 then return nil, nil end
	if num == nil then num = #tab end
	local result = tab[1]
	for i = 2, num do
		result = result + tab[i]
	end
	result = result / num
	return result
end
function tabSumm(tab)
	if #tab == 0 then return nil end
	local summ = 0
	for i, v in pairs(tab) do
		summ = summ + v
	end
	return summ 
end
function tabShuffle(tab)
	if #tab == 0 or tab == nil then return false end
	for i = #tab, 2, -1 do
	  local j = math.random(i)
	  tab[i], tab[j] = tab[j], tab[i]
	end
	return true
end
function tabPrint(tab)
	if #tab == 0 or tab == nil then return false end
	for i = 1, #tab do
		print(tab[i])
	end
	return true
end
function tabPrintRow(tab)
	if #tab == 0 or tab == nil then return false end
	local output = ""
	for i = 1, #tab do
		output = output .. tostring(tab[i]) .. "  "
	end
	print(output)
	return true
end
function around(value, minVal, maxVal, round)
	if not round then round = maxVal - minVal end
	while value < minVal do
		value = value + round
	end
	while value > maxVal do
		value = value - round
	end
	return value
end
