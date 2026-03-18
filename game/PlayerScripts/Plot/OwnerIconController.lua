local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Workspace")
local v_u_4 = v_u_1.LocalPlayer
local v_u_5 = v2:WaitForChild("Plot"):WaitForChild("OwnerIcon")
local v6 = v_u_3:WaitForChild("Plots")
local v_u_7 = {}
local v_u_8 = {}
local function v_u_18(p9, p10)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v11 = p9.Name
	local v12 = p10 == nil and true or p10 == ""
	local v13 = not v12
	if v13 then
		v13 = p10 == v_u_4.Name
	end
	local v14 = v_u_3:FindFirstChild(v11 .. "_OwnerIcon")
	if v14 then
		local v15 = v14:FindFirstChild("BillboardGui", true)
		if v15 then
			if v12 then
				v15.Enabled = false
			else
				v15.Enabled = true
				local v16 = v15:FindFirstChild("Title", true)
				if v16 then
					if v13 then
						v16.Text = "Your Garden"
					else
						v16.Text = p10 .. "\'s Garden"
					end
				end
				local v17 = v15:FindFirstChild("Headshot", true)
				if v17 then
					v17.Visible = true
					v17.Image = ""
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_26(p19, p20)
	-- upvalues: (copy) v_u_4
	if p20 then
		if p20 == "" then
			p20 = false
		else
			p20 = p20 == v_u_4.Name
		end
	end
	if p20 then
		local v21 = p19:FindFirstChild("PlayerSign")
		if v21 then
			local v22 = v21:FindFirstChild("Main")
			if v22 then
				local v23 = v22:FindFirstChild("SurfaceGui")
				if v23 then
					local v24 = v23:FindFirstChild("GardenInfo")
					if v24 then
						local v25 = v24:FindFirstChild("Username")
						if v25 then
							v25.Text = "Your"
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_37(p27, p_u_28)
	-- upvalues: (copy) v_u_1, (copy) v_u_7, (copy) v_u_3
	local v29 = p27.Name
	if p_u_28 and p_u_28 ~= "" then
		local v30, v_u_31 = pcall(function()
			-- upvalues: (ref) v_u_1, (copy) p_u_28
			return v_u_1:GetUserIdFromNameAsync(p_u_28)
		end)
		if v30 and v_u_31 then
			local v32
			if v_u_7[v_u_31] then
				v32 = v_u_7[v_u_31]
			else
				local v33
				v33, v32 = pcall(function()
					-- upvalues: (ref) v_u_1, (copy) v_u_31
					return v_u_1:GetUserThumbnailAsync(v_u_31, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				end)
				if v33 then
					v_u_7[v_u_31] = v32
				else
					v32 = ""
				end
			end
			local v34 = p27:FindFirstChild("Owner")
			if v34 and v34.Value == p_u_28 then
				local v35 = v_u_3:FindFirstChild(v29 .. "_OwnerIcon")
				if v35 then
					local v36 = v35:FindFirstChild("Headshot", true)
					if v36 then
						v36.Image = v32
					end
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v49(p_u_38)
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_5, (copy) v_u_18, (copy) v_u_26, (copy) v_u_37
	if p_u_38:IsA("Model") then
		local v39 = p_u_38.Name
		if v_u_8[v39] then
			v_u_8[v39]:Disconnect()
			v_u_8[v39] = nil
		end
		local v_u_40 = p_u_38:WaitForChild("Owner")
		if v_u_40 then
			local v41 = v39:match("%d+")
			if v41 then
				local v42 = p_u_38:FindFirstChild("Owner_Tag" .. v41)
				if v42 then
					if v42:IsA("Model") then
						local v43 = v_u_3:FindFirstChild(v39 .. "_OwnerIcon")
						if v43 then
							v43:Destroy()
						end
						local v44 = v_u_5:Clone()
						v44.Name = v39 .. "_OwnerIcon"
						for _, v45 in v44:GetDescendants() do
							if v45:IsA("BasePart") then
								v45.Transparency = 1
								v45.CanCollide = false
							end
						end
						v44.Parent = v_u_3
						v44:PivotTo(v42:GetPivot() * CFrame.new(Vector3.new(0, 103, 0)))
						local v46 = v_u_40.Value
						v_u_18(p_u_38, v46)
						v_u_26(p_u_38, v46)
						task.spawn(v_u_37, p_u_38, v46)
						v_u_8[v39] = v_u_40:GetPropertyChangedSignal("Value"):Connect(function()
							-- upvalues: (copy) p_u_38, (copy) v_u_40, (ref) v_u_18, (ref) v_u_26, (ref) v_u_37
							local v47 = p_u_38
							local v48 = v_u_40.Value
							v_u_18(v47, v48)
							v_u_26(v47, v48)
							task.spawn(v_u_37, v47, v48)
						end)
					else
						warn("Owner_Tag" .. v41 .. " is not a Model!")
					end
				else
					warn("Could not find Owner_Tag" .. v41 .. " in " .. v39)
					return
				end
			else
				warn("Could not extract plot number from: " .. v39)
				return
			end
		else
			return
		end
	else
		return
	end
end
for _, v50 in v6:GetChildren() do
	task.spawn(v49, v50)
end
v6.ChildAdded:Connect(v49)