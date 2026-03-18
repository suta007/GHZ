local v1 = game:GetService("Players")
local v2 = game:GetService("CollectionService")
local v_u_3 = v1.LocalPlayer
local v_u_4 = {}
local function v_u_9(p5)
	if not p5.Parent then
		return nil
	end
	local v6 = p5.Parent
	local v7 = 0
	while v6 and (v6 ~= workspace and v7 < 10) do
		local v8 = v6:GetAttribute("OwnerUserId")
		if v8 then
			return v8
		end
		v6 = v6.Parent
		v7 = v7 + 1
	end
	return nil
end
local function v31(p_u_10)
	-- upvalues: (copy) v_u_4, (copy) v_u_9, (copy) v_u_3
	if p_u_10:IsA("ProximityPrompt") then
		local v11 = v_u_4[p_u_10]
		if v11 then
			for _, v12 in v11 do
				v12:Disconnect()
			end
			v_u_4[p_u_10] = nil
		end
		local v13 = {}
		v_u_4[p_u_10] = v13
		if p_u_10.Parent then
			local v14 = v_u_9(p_u_10)
			if v14 and v14 ~= v_u_3.UserId then
				p_u_10.Enabled = false
				p_u_10.MaxActivationDistance = 0
			else
				local v15 = p_u_10:GetAttribute("DefaultDistance") or p_u_10.MaxActivationDistance
				p_u_10.MaxActivationDistance = v15 <= 0 and 10 or v15
				p_u_10.Enabled = true
			end
		end
		local v16 = p_u_10.Parent
		local v17 = 0
		while v16 and (v16 ~= workspace and v17 < 10) do
			local v18 = v16:GetAttributeChangedSignal("OwnerUserId")
			local function v22()
				-- upvalues: (copy) p_u_10, (ref) v_u_9, (ref) v_u_3
				local v19 = p_u_10
				if v19.Parent then
					local v20 = v_u_9(v19)
					if v20 and v20 ~= v_u_3.UserId then
						v19.Enabled = false
						v19.MaxActivationDistance = 0
					else
						local v21 = v19:GetAttribute("DefaultDistance") or v19.MaxActivationDistance
						v19.MaxActivationDistance = v21 <= 0 and 10 or v21
						v19.Enabled = true
					end
				else
					return
				end
			end
			table.insert(v13, v18:Connect(v22))
			v16 = v16.Parent
			v17 = v17 + 1
		end
		if p_u_10.Parent then
			local v23 = p_u_10.Parent.AncestryChanged
			local function v30()
				-- upvalues: (copy) p_u_10, (ref) v_u_4, (ref) v_u_9, (ref) v_u_3
				if p_u_10:IsDescendantOf(workspace) then
					local v24 = p_u_10
					if v24.Parent then
						local v25 = v_u_9(v24)
						if v25 and v25 ~= v_u_3.UserId then
							v24.Enabled = false
							v24.MaxActivationDistance = 0
						else
							local v26 = v24:GetAttribute("DefaultDistance") or v24.MaxActivationDistance
							v24.MaxActivationDistance = v26 <= 0 and 10 or v26
							v24.Enabled = true
						end
					else
						return
					end
				else
					local v27 = p_u_10
					local v28 = v_u_4[v27]
					if v28 then
						for _, v29 in v28 do
							v29:Disconnect()
						end
						v_u_4[v27] = nil
					end
				end
			end
			table.insert(v13, v23:Connect(v30))
		end
	end
end
v2:GetInstanceAddedSignal("HarvestPrompt"):Connect(v31)
v2:GetInstanceRemovedSignal("HarvestPrompt"):Connect(function(p32)
	-- upvalues: (copy) v_u_4
	local v33 = v_u_4[p32]
	if v33 then
		for _, v34 in v33 do
			v34:Disconnect()
		end
		v_u_4[p32] = nil
	end
end)
for _, v35 in v2:GetTagged("HarvestPrompt") do
	v31(v35)
end