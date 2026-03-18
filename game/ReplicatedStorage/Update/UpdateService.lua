local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ServerStorage")
local v_u_4 = v2:IsServer()
local _ = v_u_4 and v3:WaitForChild("UpdateContent")
local v_u_5 = v1:WaitForChild("Update"):WaitForChild("GlobalUpdateTime").Value
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
for _, v10 in v_u_6 do
	v_u_7[v10.Name] = v10
	if not v_u_8[v10.Type] then
		v_u_8[v10.Type] = {}
	end
	local v11 = v_u_8[v10.Type]
	table.insert(v11, v10)
end
function v_u_9.GetCurrentTime(_)
	-- upvalues: (copy) v_u_4
	if v_u_4 then
		return os.time()
	end
	local v12 = workspace:GetServerTimeNow()
	return math.floor(v12)
end
function v_u_9.GetUpdateTime(_)
	-- upvalues: (copy) v_u_5
	return v_u_5
end
function v_u_9.IsUpdateLive(p13)
	return p13:GetCurrentTime() >= p13:GetUpdateTime()
end
function v_u_9.GetTimeUntilUpdate(p14)
	local v15 = p14:GetUpdateTime() - p14:GetCurrentTime()
	return math.max(0, v15)
end
function v_u_9.IsFeatureVisible(p16, p17)
	-- upvalues: (copy) v_u_7
	local v18 = v_u_7[p17]
	if v18 then
		if v18.ShouldKeep then
			return p16:IsUpdateLive()
		else
			return not p16:IsUpdateLive()
		end
	else
		return false
	end
end
function v_u_9.GetFeaturesByType(_, p19)
	-- upvalues: (copy) v_u_8
	return v_u_8[p19] or {}
end
function v_u_9.GetVisibleFeaturesByType(p20, p21)
	local v22 = {}
	for _, v23 in p20:GetFeaturesByType(p21) do
		if p20:IsFeatureVisible(v23.Name) then
			table.insert(v22, v23)
		end
	end
	return v22
end
local v_u_24 = false
function v_u_9.DeployUpdateContent(_)
	-- upvalues: (copy) v_u_4, (ref) v_u_24, (copy) v_u_6
	local v25 = v_u_4
	assert(v25, "[UpdateService] DeployUpdateContent must be called on the server!")
	if v_u_24 then
		warn("[UpdateService] Update content has already been deployed.")
	else
		v_u_24 = true
		print("[UpdateService] Deploying update content...")
		for _, v26 in v_u_6 do
			if v26.Instance then
				if v26.ShouldKeep and v26.DeployTo then
					v26.Instance.Parent = v26.DeployTo
					local v27 = print
					local v28 = v26.Name
					local v29 = v26.DeployTo
					v27(("[UpdateService]   Deployed \'%s\' -> %s"):format(v28, (tostring(v29))))
				elseif not v26.ShouldKeep then
					v26.Instance:Destroy()
					print(("[UpdateService]   Removed \'%s\'"):format(v26.Name))
				end
			end
			if v26.OnDeploy then
				task.spawn(v26.OnDeploy, v26.Instance)
			end
		end
		print("[UpdateService] Deploy complete.")
	end
end
local v_u_30 = Instance.new("BindableEvent")
v_u_9.OnUpdate = v_u_30.Event
if v_u_4 then
	task.spawn(function()
		-- upvalues: (copy) v_u_9, (copy) v_u_30
		while true do
			local v31 = v_u_9:GetTimeUntilUpdate()
			if v31 <= 0 then
				break
			end
			task.wait((math.min(v31, 30)))
		end
		print("[UpdateService] Update is now live!")
		v_u_9:DeployUpdateContent()
		v_u_30:Fire()
	end)
else
	task.spawn(function()
		-- upvalues: (copy) v_u_9, (copy) v_u_6, (copy) v_u_30
		while v_u_9:GetTimeUntilUpdate() > 0 do
			task.wait(1)
		end
		print("[UpdateService] Update is now live!")
		for _, v32 in v_u_6 do
			if v32.OnDeploy then
				task.spawn(v32.OnDeploy, v32.Instance)
			end
		end
		v_u_30:Fire()
	end)
end
return v_u_9