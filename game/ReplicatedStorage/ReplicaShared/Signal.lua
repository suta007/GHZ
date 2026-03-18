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
local v_u_6 = {}
v_u_6.__index = v_u_6
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_6.Disconnect(p8)
	if p8.IsConnected == false then
		return
	else
		local v9 = p8.signal
		p8.IsConnected = false
		if v9.head == p8 then
			v9.head = p8.next
		else
			local v10 = v9.head
			while v10 ~= nil and v10.next ~= p8 do
				v10 = v10.next
			end
			if v10 ~= nil then
				v10.next = p8.next
			end
		end
	end
end
function v_u_7.New()
	-- upvalues: (copy) v_u_7
	local v11 = {
		["head"] = nil
	}
	local v12 = v_u_7
	setmetatable(v11, v12)
	return v11
end
function v_u_7.Connect(p13, p14)
	-- upvalues: (copy) v_u_6
	if type(p14) ~= "function" then
		error((("[%*]: \"listener\" must be a function; Received %*"):format(script.Name, (typeof(p14)))))
	end
	local v15 = {
		["listener"] = p14,
		["signal"] = p13,
		["next"] = p13.head,
		["IsConnected"] = true
	}
	local v16 = v_u_6
	setmetatable(v15, v16)
	p13.head = v15
	return v15
end
function v_u_7.Fire(p17, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v18 = p17.head
	while v18 ~= nil do
		if v18.IsConnected == true then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
			end
			task.spawn(v_u_1, v18.listener, ...)
		end
		v18 = v18.next
	end
end
function v_u_7.Wait(p19)
	local v_u_20 = coroutine.running()
	local v_u_21 = nil
	v_u_21 = p19:Connect(function(...)
		-- upvalues: (ref) v_u_21, (copy) v_u_20
		v_u_21:Disconnect()
		task.spawn(v_u_20, ...)
	end)
	return coroutine.yield()
end
function v_u_7.FireUntil(p22, p_u_23, ...)
	if type(p_u_23) ~= "function" then
		error((("[%*]: \"continue_callback\" must be a function; Received %*"):format(script.Name, (typeof(p_u_23)))))
	end
	local v_u_24 = table.pack(...)
	local v25 = p22.head
	local v_u_26 = {}
	while v25 ~= nil do
		table.insert(v_u_26, v25)
		v25 = v25.next
	end
	task.spawn(function()
		-- upvalues: (copy) v_u_26, (copy) v_u_24, (copy) p_u_23
		for _, v27 in ipairs(v_u_26) do
			if v27.IsConnected == true then
				local v28 = v_u_24
				v27.listener(table.unpack(v28))
				if p_u_23() ~= true then
					return
				end
			end
		end
	end)
end
return table.freeze({
	["New"] = v_u_7.New
})