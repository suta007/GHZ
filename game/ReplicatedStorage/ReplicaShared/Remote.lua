local v1 = game:GetService("RunService")
local v_u_2 = game:GetService("ReplicatedStorage")
v1:IsStudio()
local v_u_3 = v1:IsServer()
local v_u_4 = {}
local v_u_5 = nil
local v_u_6
if v_u_3 == true then
	v_u_6 = v_u_2:FindFirstChild("RemoteEvents")
	if v_u_6 == nil then
		v_u_6 = Instance.new("Folder")
		v_u_6.Name = "RemoteEvents"
		v_u_6.Parent = v_u_2
	end
else
	v_u_6 = v_u_2:FindFirstChild("RemoteEvents")
	if v_u_6 == nil then
		local v_u_7 = Instance.new("BindableEvent")
		task.spawn(function()
			-- upvalues: (ref) v_u_6, (copy) v_u_2, (ref) v_u_7
			while task.wait() do
				v_u_6 = v_u_2:FindFirstChild("RemoteEvents")
				if v_u_6 ~= nil then
					v_u_7:Fire()
					return
				end
			end
		end)
		v_u_5 = v_u_7
	end
end
local v_u_8 = {}
v_u_8.__index = v_u_8
function v_u_8.New(p9)
	-- upvalues: (copy) v_u_8
	local v10 = v_u_8
	return setmetatable({
		["fn"] = p9,
		["is_disconnected"] = false,
		["real_connection"] = nil
	}, v10)
end
function v_u_8.Disconnect(p11)
	p11.is_disconnected = true
	if p11.real_connection ~= nil then
		p11.real_connection:Disconnect()
	end
end
local v_u_12 = {}
v_u_12.__index = v_u_12
function v_u_12.New(p_u_13, p14)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (ref) v_u_6, (copy) v_u_8, (copy) v_u_12, (ref) v_u_5
	if type(p_u_13) ~= "string" then
		error((("[%*]: name must be a string"):format(script.Name)))
	end
	if v_u_3 == true then
		if v_u_4[p_u_13] ~= nil then
			error((("[%*]: RemoteEvent %* was already defined"):format(script.Name, p_u_13)))
		end
		v_u_4[p_u_13] = true
		local v15 = Instance.new(p14 == true and "UnreliableRemoteEvent" or "RemoteEvent")
		v15.Name = p_u_13
		v15.Parent = v_u_6
		return v15
	end
	local v_u_16 = v_u_6
	if v_u_16 then
		v_u_16 = v_u_6:FindFirstChild(p_u_13)
	end
	if v_u_16 ~= nil then
		return v_u_16
	end
	local v_u_17 = {}
	local v21 = {
		["OnClientEvent"] = {
			["Connect"] = function(_, p18)
				-- upvalues: (ref) v_u_16, (ref) v_u_8, (ref) v_u_17
				if v_u_16 ~= nil then
					return v_u_16.OnClientEvent:Connect(p18)
				end
				local v19 = v_u_8.New(p18)
				local v20 = v_u_17
				table.insert(v20, v19)
				return v19
			end
		},
		["OnServerEvent"] = {
			["Connect"] = function()
				error((("[%*]: Can\'t connect to \"OnServerEvent\" client-side"):format(script.Name)))
			end
		},
		["RemoteEvent"] = nil
	}
	local v22 = v_u_12
	local v_u_23 = setmetatable(v21, v22)
	local function v_u_26()
		-- upvalues: (ref) v_u_16, (ref) v_u_6, (copy) p_u_13, (ref) v_u_17, (copy) v_u_23
		local v24 = os.clock()
		while true do
			v_u_16 = v_u_6:FindFirstChild(p_u_13)
			if v_u_16 ~= nil then
				break
			end
			if v24 ~= nil and os.clock() - v24 > 20 then
				warn((("[%*]: RemoteEvent \"%*\" hasn\'t been defined server-side"):format(script.Name, p_u_13)))
				v24 = nil
			end
			task.wait()
		end
		for _, v25 in ipairs(v_u_17) do
			if v25.is_disconnected == false then
				v25.real_connection = v_u_16.OnClientEvent:Connect(v25.fn)
			end
		end
		v_u_23.RemoteEvent = v_u_16
		v_u_17 = nil
	end
	if v_u_6 == nil then
		local v_u_27 = nil
		v_u_27 = v_u_5.Event:Connect(function()
			-- upvalues: (ref) v_u_27, (copy) v_u_26
			v_u_27:Disconnect()
			v_u_26()
		end)
	else
		task.spawn(v_u_26)
	end
	return v_u_23
end
function v_u_12.FireServer(p28, ...)
	if p28.RemoteEvent ~= nil then
		p28.RemoteEvent:FireServer(...)
	end
end
function v_u_12.FireClient(_)
	error((("[%*]: Can\'t use \"FireClient\" client-side"):format(script.Name)))
end
function v_u_12.FireAllClients(_)
	error((("[%*]: Can\'t use \"FireAllClients\" client-side"):format(script.Name)))
end
return v_u_12