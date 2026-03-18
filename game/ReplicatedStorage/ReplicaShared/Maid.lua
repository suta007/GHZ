local v_u_1 = nil
local function v_u_4(p2, ...)
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...)
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local function v_u_10(p6, ...)
	local v7 = typeof(p6)
	if v7 == "function" then
		p6(...)
		return
	elseif v7 == "RBXScriptConnection" then
		p6:Disconnect()
		return
	elseif v7 == "Instance" then
		p6:Destroy()
	elseif v7 == "table" then
		local v8 = p6.Destroy
		if type(v8) == "function" then
			p6:Destroy()
			return
		end
		local v9 = p6.Disconnect
		if type(v9) == "function" then
			p6:Disconnect()
		end
	end
end
local function v_u_12(...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5, (copy) v_u_10
	if not v_u_1 then
		v_u_1 = coroutine.create(v_u_5)
	end
	local v11 = v_u_1
	task.spawn(assert(v11), v_u_10, ...)
end
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13.New(p14, p15)
	-- upvalues: (copy) v_u_13
	local v16 = {
		["maid"] = p14,
		["object"] = p15
	}
	local v17 = v_u_13
	setmetatable(v16, v17)
	return v16
end
function v_u_13.Destroy(p18)
	p18.maid.tokens[p18] = nil
end
function v_u_13.Cleanup(p19, ...)
	-- upvalues: (copy) v_u_12
	if p19.object ~= nil then
		p19.maid.tokens[p19] = nil
		v_u_12(p19.object, ...)
		p19.object = nil
	end
end
local v_u_20 = {}
v_u_20.__index = v_u_20
function v_u_20.New(p21)
	-- upvalues: (copy) v_u_20
	local v22 = {
		["tokens"] = {},
		["is_cleaned"] = false,
		["key"] = p21
	}
	local v23 = v_u_20
	setmetatable(v22, v23)
	return v22
end
function v_u_20.IsActive(p24)
	return not p24.is_cleaned
end
function v_u_20.Add(p25, p26)
	-- upvalues: (copy) v_u_12, (copy) v_u_13
	if p25.is_cleaned == true then
		v_u_12(p26)
	end
	local v27 = typeof(p26)
	if v27 == "table" then
		local v28 = p26.Destroy
		if type(v28) ~= "function" then
			local v29 = p26.Disconnect
			if type(v29) ~= "function" then
				error((("[%*]: Received table as cleanup object, but couldn\'t detect a :Destroy() or :Disconnect() method"):format(script.Name)))
			end
		end
	elseif v27 ~= "function" and (v27 ~= "RBXScriptConnection" and v27 ~= "Instance") then
		error((("[%*]: Cleanup of type \"%*\" not supported"):format(script.Name, v27)))
	end
	local v30 = v_u_13.New(p25, p26)
	p25.tokens[v30] = true
	return v30
end
function v_u_20.Cleanup(p31, ...)
	if p31.key ~= nil then
		error((("[%*]: \"Cleanup()\" is locked for this Maid"):format(script.Name)))
	end
	p31.is_cleaned = true
	for v32 in pairs(p31.tokens) do
		v32:Cleanup(...)
	end
end
function v_u_20.Unlock(p33, p34)
	if p33.key ~= nil and p33.key ~= p34 then
		error((("[%*]: Invalid lock key"):format(script.Name)))
	end
	p33.key = nil
end
return v_u_20