local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v2:WaitForChild("RemoteEvents"):WaitForChild("UnseatPlayer")
local v_u_4 = v1.LocalPlayer
local v5 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("Hud_UI"):WaitForChild("TopButtons")
local v_u_6 = workspace:WaitForChild("MapPhysical")
local v_u_7 = workspace:WaitForChild("Plots")
v_u_6:WaitForChild("Teleports")
local v_u_8 = require(v2:WaitForChild("PlotStreaming"):WaitForChild("PlotStreamingSignals"))
local v_u_9 = RaycastParams.new()
v_u_9.FilterType = Enum.RaycastFilterType.Exclude
local v_u_10 = 0
local v_u_11 = false
v_u_4.CharacterAdded:Connect(function(p12)
	-- upvalues: (ref) v_u_10, (ref) v_u_11
	v_u_10 = v_u_10 + 1
	v_u_11 = false
	local v13 = p12:FindFirstChild("HumanoidRootPart")
	if v13 and v13.Anchored then
		v13.Anchored = false
	end
end)
local function v_u_20(p14)
	-- upvalues: (copy) v_u_3
	if p14 and p14.Sit then
		local v15 = p14.SeatPart
		v_u_3:FireServer()
		local v16 = 0
		while p14.Sit and v16 < 3 do
			v16 = v16 + task.wait()
		end
		local v17 = v15 and v15:FindFirstChild("SeatWeld")
		if v17 then
			v17:Destroy()
		end
		local v18 = p14.SeatPart
		local v19 = v18 and v18:FindFirstChild("SeatWeld")
		if v19 then
			v19:Destroy()
		end
		p14.Sit = false
		p14:ChangeState(Enum.HumanoidStateType.GettingUp)
		task.wait(0.2)
	end
end
local function v_u_26(p21, p22)
	-- upvalues: (copy) v_u_9
	v_u_9.FilterDescendantsInstances = { p22 }
	local v23 = p21 + Vector3.new(0, 2, 0)
	local v24 = 0
	while v24 < 3 do
		local v25 = workspace:Raycast(v23, Vector3.new(0, -7, 0), v_u_9)
		if v25 then
			return v25.Position
		end
		v24 = v24 + task.wait()
	end
	return nil
end
local function v_u_30(p_u_27)
	-- upvalues: (copy) v_u_4
	local v_u_28 = false
	task.spawn(function()
		-- upvalues: (ref) v_u_4, (copy) p_u_27, (ref) v_u_28
		pcall(function()
			-- upvalues: (ref) v_u_4, (ref) p_u_27
			v_u_4:RequestStreamAroundAsync(p_u_27)
		end)
		v_u_28 = true
	end)
	local v29 = 0
	while not v_u_28 and v29 < 5 do
		v29 = v29 + task.wait()
	end
end
local function v_u_35(p31)
	-- upvalues: (ref) v_u_10, (copy) v_u_4, (ref) v_u_11
	if not p31 or p31 == v_u_10 then
		local v32 = v_u_4.Character
		if v32 then
			local v33 = v32:FindFirstChild("HumanoidRootPart")
			if v33 then
				if v33.Anchored then
					v33.Anchored = false
				end
				v33.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end
			local v34 = v32:FindFirstChildOfClass("Humanoid")
			if v34 then
				v34:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
			end
		end
		v_u_11 = false
	end
end
local function v_u_49(p_u_36, p_u_37)
	-- upvalues: (ref) v_u_11, (copy) v_u_4, (ref) v_u_10, (copy) v_u_35, (copy) v_u_20, (copy) v_u_30, (copy) v_u_26, (copy) v_u_3
	if v_u_11 then
		return
	else
		local v38 = v_u_4.Character
		if v38 then
			v38 = v38:FindFirstChildOfClass("Humanoid")
		end
		if v38 then
			v38 = v38:GetAttribute("IsRagdolled") == true
		end
		if v38 then
			return
		else
			local v_u_39 = v_u_4.Character
			local v_u_40
			if v_u_39 then
				v_u_40 = v_u_39:FindFirstChildOfClass("Humanoid")
			else
				v_u_40 = v_u_39
			end
			local v_u_41
			if v_u_39 then
				v_u_41 = v_u_39:FindFirstChild("HumanoidRootPart")
			else
				v_u_41 = v_u_39
			end
			if v_u_41 and p_u_36 then
				v_u_11 = true
				v_u_10 = v_u_10 + 1
				local v_u_42 = v_u_10
				task.delay(8, function()
					-- upvalues: (ref) v_u_10, (copy) v_u_42, (ref) v_u_11, (ref) v_u_35
					if v_u_10 == v_u_42 and v_u_11 then
						warn("[TeleportController] Teleport hard ceiling reached, forcing cleanup")
						v_u_35(v_u_42)
					end
				end)
				local v47, v48 = pcall(function()
					-- upvalues: (copy) v_u_40, (ref) v_u_20, (copy) v_u_42, (ref) v_u_10, (copy) v_u_41, (ref) v_u_30, (copy) p_u_36, (copy) p_u_37, (ref) v_u_26, (copy) v_u_39, (ref) v_u_3
					v_u_40:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
					v_u_20(v_u_40)
					if v_u_42 == v_u_10 then
						v_u_41.Anchored = true
						v_u_30(p_u_36.Position)
						if v_u_42 == v_u_10 then
							v_u_41.CFrame = p_u_36.CFrame * CFrame.new(0, p_u_37, 0)
							v_u_41.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							local v43 = v_u_26(p_u_36.Position, v_u_39)
							if v_u_42 == v_u_10 then
								if v43 then
									local v44 = p_u_37
									v_u_41.CFrame = CFrame.new(v43 + Vector3.new(0, v44, 0)) * v_u_41.CFrame.Rotation
								end
								v_u_41.Anchored = false
								v_u_41.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								if v_u_40.Sit or v_u_40.SeatPart then
									local v45 = v_u_40.SeatPart
									local v46 = v45 and v45:FindFirstChild("SeatWeld")
									if v46 then
										v46:Destroy()
									end
									v_u_3:FireServer()
									v_u_40.Sit = false
									v_u_40:ChangeState(Enum.HumanoidStateType.GettingUp)
								end
								task.wait(0.5)
								v_u_40:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
							end
						else
							return
						end
					else
						return
					end
				end)
				if not v47 then
					warn("[TeleportController] teleportTo failed: " .. tostring(v48))
				end
				v_u_35(v_u_42)
			end
		end
	end
end
local function v_u_51()
	-- upvalues: (copy) v_u_7, (copy) v_u_4
	for _, v50 in v_u_7:GetChildren() do
		if v50:GetAttribute("Owner") == v_u_4.UserId then
			return v50
		end
	end
	return nil
end
v5:WaitForChild("Seeds").MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_49, (copy) v_u_6
	v_u_49(v_u_6.Teleports:FindFirstChild("SeedsTeleport"), 3)
end)
v5:WaitForChild("Sell").MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_49, (copy) v_u_6
	v_u_49(v_u_6.Teleports:FindFirstChild("SellTeleport"), 3)
end)
v5:WaitForChild("YourGarden").MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_11, (copy) v_u_4, (copy) v_u_51, (ref) v_u_10, (copy) v_u_35, (copy) v_u_8, (copy) v_u_20, (copy) v_u_30, (copy) v_u_26, (copy) v_u_3
	if v_u_11 then
		return
	else
		local v52 = v_u_4.Character
		if v52 then
			v52 = v52:FindFirstChildOfClass("Humanoid")
		end
		if v52 then
			v52 = v52:GetAttribute("IsRagdolled") == true
		end
		if v52 then
			return
		else
			local v_u_53 = v_u_51()
			if v_u_53 then
				local v_u_54 = v_u_53:FindFirstChild("Spawn")
				if v_u_54 then
					v_u_54 = v_u_54:FindFirstChild("Spawn")
				end
				local v_u_55 = v_u_4.Character
				local v_u_56
				if v_u_55 then
					v_u_56 = v_u_55:FindFirstChildOfClass("Humanoid")
				else
					v_u_56 = v_u_55
				end
				local v_u_57
				if v_u_55 then
					v_u_57 = v_u_55:FindFirstChild("HumanoidRootPart")
				else
					v_u_57 = v_u_55
				end
				if v_u_57 and v_u_54 then
					v_u_11 = true
					v_u_10 = v_u_10 + 1
					local v_u_58 = v_u_10
					task.delay(8, function()
						-- upvalues: (ref) v_u_10, (copy) v_u_58, (ref) v_u_11, (ref) v_u_35
						if v_u_10 == v_u_58 and v_u_11 then
							warn("[TeleportController] YourGarden teleport hard ceiling reached, forcing cleanup")
							v_u_35(v_u_58)
						end
					end)
					local v62, v63 = pcall(function()
						-- upvalues: (copy) v_u_56, (ref) v_u_8, (copy) v_u_53, (ref) v_u_20, (copy) v_u_58, (ref) v_u_10, (copy) v_u_57, (ref) v_u_30, (copy) v_u_54, (ref) v_u_26, (copy) v_u_55, (ref) v_u_3
						v_u_56:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
						v_u_8.FirePreloadPlot(v_u_53)
						v_u_20(v_u_56)
						if v_u_58 == v_u_10 then
							v_u_57.Anchored = true
							v_u_30(v_u_54.Position)
							if v_u_58 == v_u_10 then
								v_u_57.CFrame = v_u_54.CFrame * CFrame.new(0, 3.5, 0)
								v_u_57.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
								local v59 = v_u_26(v_u_54.Position, v_u_55)
								if v_u_58 == v_u_10 then
									if v59 then
										v_u_57.CFrame = CFrame.new(v59 + Vector3.new(0, 3.5, 0)) * v_u_57.CFrame.Rotation
									end
									v_u_57.Anchored = false
									v_u_57.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
									if v_u_56.Sit or v_u_56.SeatPart then
										local v60 = v_u_56.SeatPart
										local v61 = v60 and v60:FindFirstChild("SeatWeld")
										if v61 then
											v61:Destroy()
										end
										v_u_3:FireServer()
										v_u_56.Sit = false
										v_u_56:ChangeState(Enum.HumanoidStateType.GettingUp)
									end
									task.wait(0.5)
									v_u_56:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
								end
							else
								return
							end
						else
							return
						end
					end)
					if not v62 then
						warn("[TeleportController] YourGarden teleport failed: " .. tostring(v63))
					end
					v_u_35(v_u_58)
				end
			else
				warn("No plot found! Please be patient.")
				return
			end
		end
	end
end)