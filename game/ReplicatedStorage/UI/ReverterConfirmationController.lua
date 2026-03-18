local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("GuiService")
local v_u_4 = game:GetService("UserInputService")
local v5 = v_u_2.LocalPlayer:WaitForChild("PlayerGui")
local v_u_6 = v1:WaitForChild("RemoteEvents"):WaitForChild("UseGear")
local v_u_7 = v5:WaitForChild("ReverterConfirmation")
local v8 = v_u_7:WaitForChild("Background")
local v_u_9 = v8:WaitForChild("PlantName")
local v_u_10 = v8:WaitForChild("Cancel")
local v11 = v8:WaitForChild("Confirm")
v_u_7.Enabled = false
local v_u_12 = require(v1.Plants.Definitions.PlantDataDefinitions)
local v_u_13 = require(v1.Plants.Definitions.TierHelper)
local v14 = {}
local v_u_15 = {
	["Rare"] = true,
	["Epic"] = true,
	["Legendary"] = true,
	["Mythical"] = true
}
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = 0
v11.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (ref) v_u_21, (ref) v_u_17, (ref) v_u_20, (ref) v_u_16, (ref) v_u_18, (ref) v_u_19, (copy) v_u_6
	v_u_7.Enabled = false
	v_u_3.SelectedObject = nil
	v_u_21 = tick()
	if v_u_17 and v_u_17.Parent then
		v_u_6:FireServer(v_u_18, {
			["PlantUuid"] = v_u_19
		})
		if v_u_16 then
			v_u_16()
		end
		if v_u_20 then
			local v22 = v_u_20
			v_u_20 = nil
			if coroutine.status(v22) ~= "running" then
				task.cancel(v22)
			end
		end
		v_u_16 = nil
		v_u_17 = nil
		v_u_18 = nil
		v_u_19 = nil
	else
		if v_u_20 then
			local v23 = v_u_20
			v_u_20 = nil
			if coroutine.status(v23) ~= "running" then
				task.cancel(v23)
			end
		end
		v_u_16 = nil
		v_u_17 = nil
		v_u_18 = nil
		v_u_19 = nil
	end
end)
v_u_10.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (ref) v_u_21, (ref) v_u_20, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19
	v_u_7.Enabled = false
	v_u_3.SelectedObject = nil
	v_u_21 = tick()
	if v_u_20 then
		local v24 = v_u_20
		v_u_20 = nil
		if coroutine.status(v24) ~= "running" then
			task.cancel(v24)
		end
	end
	v_u_16 = nil
	v_u_17 = nil
	v_u_18 = nil
	v_u_19 = nil
end)
function v14.Show(_, p25, p26, p27, p28)
	-- upvalues: (copy) v_u_12, (copy) v_u_15, (copy) v_u_6, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_16, (copy) v_u_7, (copy) v_u_9, (copy) v_u_4, (copy) v_u_3, (copy) v_u_10, (copy) v_u_13, (ref) v_u_20, (copy) v_u_2
	if not p25 then
		return false
	end
	if not p25:IsA("Model") then
		return false
	end
	local v29 = p25:GetAttribute("PlantType") or "Unknown"
	local v30 = v_u_12[v29]
	if v30 then
		v30 = v30.Rarity
	end
	local v31
	if v30 then
		v31 = v_u_15[v30]
	else
		v31 = v30
	end
	if not v31 then
		v_u_6:FireServer(p26, {
			["PlantUuid"] = p27
		})
		if p28 then
			p28()
		end
		return true
	end
	v_u_17 = p25
	v_u_18 = p26
	v_u_19 = p27
	v_u_16 = p28
	v_u_7.Enabled = true
	v_u_9.Text = v29
	if v_u_4.GamepadEnabled then
		v_u_3.SelectedObject = v_u_10
	end
	local v32
	if v30 then
		v32 = v_u_13:GetColor(v30)
	else
		v32 = v30
	end
	if v30 and v32 then
		v_u_9.TextColor3 = v32
		local v33 = v_u_9.UIStroke
		local v34, v35, v36 = v32:ToHSV()
		local v37 = v36 - 0.5
		local v38 = math.clamp(v37, 0, 1)
		v33.Color = Color3.fromHSV(v34, v35, v38)
	else
		v_u_9.TextColor3 = Color3.new(1, 1, 1)
		v_u_9.UIStroke.Color = Color3.new(0, 0, 0)
	end
	if v_u_20 then
		local v39 = v_u_20
		v_u_20 = nil
		if coroutine.status(v39) ~= "running" then
			task.cancel(v39)
		end
	end
	v_u_20 = task.spawn(function()
		-- upvalues: (ref) v_u_7, (ref) v_u_2, (ref) v_u_17, (ref) v_u_3, (ref) v_u_20, (ref) v_u_16, (ref) v_u_18, (ref) v_u_19
		while v_u_7.Enabled do
			local v40 = v_u_2.LocalPlayer
			if v40 then
				v40 = v40.Character
			end
			if v40 then
				v40 = v40:FindFirstChild("HumanoidRootPart")
			end
			if v40 then
				local v41
				if v_u_17 and v_u_17.Parent then
					local v42 = v_u_17.PrimaryPart or v_u_17:FindFirstChildWhichIsA("BasePart")
					if v42 then
						v41 = v42.Position
					else
						v41 = nil
					end
				else
					v41 = nil
				end
				if not v41 then
					v_u_7.Enabled = false
					v_u_3.SelectedObject = nil
					if v_u_20 then
						local v43 = v_u_20
						v_u_20 = nil
						if coroutine.status(v43) ~= "running" then
							task.cancel(v43)
						end
					end
					v_u_16 = nil
					v_u_17 = nil
					v_u_18 = nil
					v_u_19 = nil
					return
				end
				if (v40.Position - v41).Magnitude > 80 then
					v_u_7.Enabled = false
					v_u_3.SelectedObject = nil
					if v_u_20 then
						local v44 = v_u_20
						v_u_20 = nil
						if coroutine.status(v44) ~= "running" then
							task.cancel(v44)
						end
					end
					v_u_16 = nil
					v_u_17 = nil
					v_u_18 = nil
					v_u_19 = nil
					return
				end
				task.wait(0.2)
			else
				task.wait(0.2)
			end
		end
	end)
	return true
end
function v14.IsActive(_)
	-- upvalues: (copy) v_u_7, (ref) v_u_21
	return v_u_7.Enabled or tick() - v_u_21 < 0.2
end
return v14