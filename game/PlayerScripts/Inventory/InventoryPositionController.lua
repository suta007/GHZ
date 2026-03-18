local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v1.LocalPlayer:WaitForChild("Backpack")
task.wait(4)
local v_u_4 = require(v2:WaitForChild("Backpack"))
local v_u_5 = v2:WaitForChild("RemoteEvents"):WaitForChild("UpdateInventoryPosition")
local v_u_6 = {}
local v_u_7 = false
local function v_u_14(p8)
	if p8 then
		local v9 = p8:GetAttribute("BaseName") or p8.Name
		local v10 = p8:GetAttribute("HarvestedFrom")
		local v11 = p8:GetAttribute("FruitValue")
		local v12 = p8:GetAttribute("Mutation")
		local v13 = p8:GetAttribute("Variant")
		if v10 and v11 then
			return v9 .. "_" .. v10 .. "_" .. tostring(v11) .. (v12 and "_" .. v12 or "") .. (v13 and "_" .. v13 or "")
		else
			return v9
		end
	else
		return nil
	end
end
local function v_u_23()
	-- upvalues: (copy) v_u_4, (copy) v_u_14, (copy) v_u_6, (copy) v_u_5
	local v15, v16 = pcall(function()
		-- upvalues: (ref) v_u_4
		return v_u_4:GetAllSlots()
	end)
	if v15 and v16 then
		local v17 = {}
		for _, v18 in ipairs(v16) do
			local v19 = v18.Tool
			if v19 then
				local v20 = v_u_14(v19)
				if v20 then
					local v21 = v18.SlotNumber
					v17[v20] = true
					if v_u_6[v20] ~= v21 then
						v_u_5:FireServer(v20, v21)
						v_u_6[v20] = v21
					end
				end
			end
		end
		for v22 in pairs(v_u_6) do
			if not v17[v22] then
				v_u_6[v22] = nil
			end
		end
	end
end
v_u_4.StateChanged.Event:Connect(function(p24)
	-- upvalues: (copy) v_u_23
	if not p24 then
		task.delay(0.2, v_u_23)
	end
end)
v3.ChildAdded:Connect(function(p25)
	-- upvalues: (ref) v_u_7, (copy) v_u_23
	if p25:IsA("Tool") then
		if v_u_7 then
			return
		end
		v_u_7 = true
		task.delay(1, function()
			-- upvalues: (ref) v_u_7, (ref) v_u_23
			v_u_7 = false
			v_u_23()
		end)
	end
end)
v3.ChildRemoved:Connect(function(p26)
	-- upvalues: (ref) v_u_7, (copy) v_u_23
	if p26:IsA("Tool") then
		if v_u_7 then
			return
		end
		v_u_7 = true
		task.delay(1, function()
			-- upvalues: (ref) v_u_7, (ref) v_u_23
			v_u_7 = false
			v_u_23()
		end)
	end
end)
print("[InventoryPositionController] Initialized")