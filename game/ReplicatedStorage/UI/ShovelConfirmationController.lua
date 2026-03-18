local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v3 = v_u_2.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = v1:WaitForChild("RemoteEvents"):WaitForChild("RemovePlant")
local v_u_5 = v3:WaitForChild("ShovelConfirmation")
local v6 = v_u_5:WaitForChild("Background")
local v_u_7 = v6:WaitForChild("PlantName")
local v8 = v6:WaitForChild("Cancel")
local v9 = v6:WaitForChild("Confirm")
v_u_5.Enabled = false
local v_u_10 = require(v1.Plants.Definitions.PlantDataDefinitions)
local v_u_11 = require(v1.Plants.Definitions.TierHelper)
local v_u_12 = require(v1:WaitForChild("Player"):WaitForChild("NotificationService"))
local v13 = {}
local v_u_14 = {
	["Rare"] = true,
	["Epic"] = true,
	["Legendary"] = true,
	["Mythical"] = true
}
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = 0
local function v_u_25()
	-- upvalues: (ref) v_u_16, (ref) v_u_17
	if v_u_16 and v_u_16.Parent then
		if v_u_17 == "Fruit" then
			local v22 = v_u_16.Parent
			local v23 = v22 and v22:IsA("Model") and (v22.PrimaryPart or v22:FindFirstChildWhichIsA("BasePart"))
			if v23 then
				return v23.Position
			end
		end
		local v24 = v_u_16.PrimaryPart or v_u_16:FindFirstChildWhichIsA("BasePart")
		if v24 then
			return v24.Position
		else
			return nil
		end
	else
		return nil
	end
end
local function v_u_30(p26, p27)
	if p27 == "Plant" then
		local v28 = p26:GetAttribute("Favorited") == true
		if not v28 then
			for _, v29 in p26:GetChildren() do
				if v29:IsA("Model") and v29:GetAttribute("Favorited") then
					return true
				end
			end
		end
		return v28
	elseif p27 == "Fruit" then
		return p26:GetAttribute("Favorited") == true
	else
		return false
	end
end
v9.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_21, (ref) v_u_16, (ref) v_u_20, (ref) v_u_15, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (copy) v_u_30, (copy) v_u_12, (copy) v_u_4
	v_u_5.Enabled = false
	v_u_21 = tick()
	if v_u_16 and v_u_16.Parent then
		if v_u_30(v_u_16, v_u_17) then
			local v31 = v_u_17 == "Plant" and "This plant has favorited fruit and cannot be removed" or "This fruit is favorited and cannot be removed"
			v_u_12.Notify(v31, 4, Color3.fromRGB(255, 100, 100))
			if v_u_20 then
				local v32 = v_u_20
				v_u_20 = nil
				if coroutine.status(v32) ~= "running" then
					task.cancel(v32)
				end
			end
			v_u_15 = nil
			v_u_16 = nil
			v_u_17 = nil
			v_u_18 = nil
			v_u_19 = nil
		else
			v_u_4:FireServer(v_u_18, v_u_19)
			if v_u_15 then
				v_u_15()
			end
			if v_u_20 then
				local v33 = v_u_20
				v_u_20 = nil
				if coroutine.status(v33) ~= "running" then
					task.cancel(v33)
				end
			end
			v_u_15 = nil
			v_u_16 = nil
			v_u_17 = nil
			v_u_18 = nil
			v_u_19 = nil
		end
	else
		if v_u_20 then
			local v34 = v_u_20
			v_u_20 = nil
			if coroutine.status(v34) ~= "running" then
				task.cancel(v34)
			end
		end
		v_u_15 = nil
		v_u_16 = nil
		v_u_17 = nil
		v_u_18 = nil
		v_u_19 = nil
		return
	end
end)
v8.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_5, (ref) v_u_21, (ref) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19
	v_u_5.Enabled = false
	v_u_21 = tick()
	if v_u_20 then
		local v35 = v_u_20
		v_u_20 = nil
		if coroutine.status(v35) ~= "running" then
			task.cancel(v35)
		end
	end
	v_u_15 = nil
	v_u_16 = nil
	v_u_17 = nil
	v_u_18 = nil
	v_u_19 = nil
end)
function v13.Show(_, p36, p37, p38, p39, p40)
	-- upvalues: (copy) v_u_10, (copy) v_u_14, (copy) v_u_30, (copy) v_u_12, (copy) v_u_4, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (copy) v_u_5, (copy) v_u_7, (copy) v_u_11, (ref) v_u_15, (ref) v_u_20, (copy) v_u_2, (copy) v_u_25
	if p36 then
		if p36:IsA("Model") then
			local v41
			if p37 == "Fruit" then
				local v42 = p36.Parent
				v41 = v42 and v42:GetAttribute("PlantType") or "Unknown"
			else
				v41 = p36:GetAttribute("PlantType") or "Unknown"
			end
			local v43 = v_u_10[v41]
			if v43 then
				v43 = v43.Rarity
			end
			local v44
			if v43 then
				v44 = v_u_14[v43]
			else
				v44 = v43
			end
			if v_u_30(p36, p37) then
				local v45 = p37 == "Plant" and "This plant has favorited fruit and cannot be removed" or "This fruit is favorited and cannot be removed"
				v_u_12.Notify(v45, 4, Color3.fromRGB(255, 100, 100))
				return
			elseif v44 then
				v_u_16 = p36
				v_u_17 = p37
				v_u_18 = p38
				v_u_19 = p39
				v_u_5.Enabled = true
				local v46
				if p37 == "Fruit" then
					v46 = v41 .. " (Fruit)"
				else
					v46 = v41 .. " (Plant)"
				end
				v_u_7.Text = v46
				local v47
				if v43 then
					v47 = v_u_11:GetColor(v43)
				else
					v47 = v43
				end
				if v43 and v47 then
					v_u_7.TextColor3 = v47
					local v48 = v_u_7.UIStroke
					local v49, v50, v51 = v47:ToHSV()
					local v52 = v51 - 0.5
					local v53 = math.clamp(v52, 0, 1)
					v48.Color = Color3.fromHSV(v49, v50, v53)
				else
					v_u_7.TextColor3 = Color3.new(1, 1, 1)
					v_u_7.UIStroke.Color = Color3.new(0, 0, 0)
				end
				v_u_15 = p40
				if v_u_20 then
					local v54 = v_u_20
					v_u_20 = nil
					if coroutine.status(v54) ~= "running" then
						task.cancel(v54)
					end
				end
				v_u_20 = task.spawn(function()
					-- upvalues: (ref) v_u_5, (ref) v_u_2, (ref) v_u_25, (ref) v_u_20, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19
					while v_u_5.Enabled do
						local v55 = v_u_2.LocalPlayer
						if v55 then
							v55 = v55.Character
						end
						if v55 then
							v55 = v55:FindFirstChild("HumanoidRootPart")
						end
						if v55 then
							local v56 = v_u_25()
							if not v56 then
								v_u_5.Enabled = false
								if v_u_20 then
									local v57 = v_u_20
									v_u_20 = nil
									if coroutine.status(v57) ~= "running" then
										task.cancel(v57)
									end
								end
								v_u_15 = nil
								v_u_16 = nil
								v_u_17 = nil
								v_u_18 = nil
								v_u_19 = nil
								return
							end
							if (v55.Position - v56).Magnitude > 80 then
								v_u_5.Enabled = false
								if v_u_20 then
									local v58 = v_u_20
									v_u_20 = nil
									if coroutine.status(v58) ~= "running" then
										task.cancel(v58)
									end
								end
								v_u_15 = nil
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
			else
				v_u_4:FireServer(p38, p39)
				if p40 then
					p40()
				end
			end
		else
			return
		end
	else
		return
	end
end
function v13.IsActive(_)
	-- upvalues: (copy) v_u_5, (ref) v_u_21
	return v_u_5.Enabled or tick() - v_u_21 < 0.2
end
return v13