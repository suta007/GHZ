local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("StarterGui")
local v4 = game:GetService("Workspace")
local v5 = game:GetService("UserInputService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = v1.LocalPlayer
local v_u_9 = v_u_8:WaitForChild("PlayerGui")
local v_u_10 = v4.CurrentCamera
local v11 = v2:WaitForChild("RemoteEvents")
local v_u_12 = v11:WaitForChild("ClaimSelectedPlot")
local v13 = v11:WaitForChild("PlotAvailabilityUpdate")
local v_u_14 = v11:WaitForChild("GetAvailablePlots")
local v_u_15 = v11:WaitForChild("SetStreamingFocus")
local v_u_16 = require(v2:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_17 = {
	"GearShop",
	"FloraBook",
	"RobuxShop",
	"Settings",
	"SeedShop",
	"GiftModal",
	"Quests"
}
local v_u_18 = v_u_9:FindFirstChild("PlotSelector")
if v_u_18 then
	v_u_18.ResetOnSpawn = false
else
	local v19 = v3:FindFirstChild("PlotSelector")
	if v19 then
		v_u_18 = v19:Clone()
		v_u_18.ResetOnSpawn = false
		v_u_18.Parent = v_u_9
	end
end
if v_u_18 then
	v_u_18.Enabled = false
	local v_u_20 = v_u_18:FindFirstChild("Frame")
	if v_u_20 then
		local v_u_21 = v_u_20:FindFirstChild("LeftSelect")
		local v_u_22 = v_u_20:FindFirstChild("RightSelect")
		local v23 = v_u_20:FindFirstChild("MiddleBit")
		local v_u_24 = nil
		local v25, v_u_26
		if v23 then
			v25 = v23:FindFirstChild("Confirm")
			v_u_26 = v23:FindFirstChild("PlotText")
			if v_u_26 then
				v_u_24 = v_u_26:FindFirstChild("PlotTextShadow")
			end
		else
			v25 = nil
			v_u_26 = nil
		end
		if v_u_21 and v_u_22 then
			if v25 then
				local v_u_27 = {}
				local v_u_28 = 1
				local v_u_29 = false
				local v_u_30 = false
				local v_u_31 = {}
				local v_u_32 = nil
				local v_u_33 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
				local v_u_34 = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
				local v_u_35 = Vector3.new(0, 0, 0)
				local v_u_36 = nil
				local function v_u_38()
					-- upvalues: (copy) v_u_9, (ref) v_u_18, (ref) v_u_31
					for _, v37 in ipairs(v_u_9:GetChildren()) do
						if v37:IsA("ScreenGui") and (v37 ~= v_u_18 and v37.Enabled) then
							v_u_31[v37] = true
							v37.Enabled = false
						end
					end
				end
				local function v_u_42()
					-- upvalues: (ref) v_u_31, (copy) v_u_17, (copy) v_u_9
					for v39, _ in pairs(v_u_31) do
						if v39.Parent then
							v39.Enabled = true
						end
					end
					v_u_31 = {}
					for _, v40 in ipairs(v_u_17) do
						local v41 = v_u_9:FindFirstChild(v40)
						if v41 and v41:IsA("ScreenGui") then
							v41.Enabled = false
						end
					end
				end
				local function v_u_44(p43)
					-- upvalues: (ref) v_u_32, (copy) v_u_10, (copy) v_u_6, (copy) v_u_33
					if p43 then
						if typeof(p43) == "CFrame" then
							if v_u_32 then
								v_u_32:Cancel()
								v_u_32 = nil
							end
							v_u_10.CameraType = Enum.CameraType.Scriptable
							v_u_32 = v_u_6:Create(v_u_10, v_u_33, {
								["CFrame"] = p43
							})
							v_u_32:Play()
						end
					else
						return
					end
				end
				local function v_u_50(p_u_45)
					-- upvalues: (copy) v_u_8, (copy) v_u_10, (ref) v_u_32, (copy) v_u_7, (copy) v_u_6, (copy) v_u_34
					local v46 = v_u_8.Character
					if v46 then
						local v_u_47 = v46:FindFirstChild("Humanoid")
						if v_u_47 then
							if v_u_32 then
								v_u_32:Cancel()
								v_u_32 = nil
							end
							local v48 = v_u_10.CFrame
							v_u_10.CameraSubject = v_u_47
							v_u_10.CameraType = Enum.CameraType.Custom
							v_u_7.RenderStepped:Wait()
							local v49 = v_u_10.CFrame
							v_u_10.CameraType = Enum.CameraType.Scriptable
							v_u_10.CFrame = v48
							v_u_32 = v_u_6:Create(v_u_10, v_u_34, {
								["CFrame"] = v49
							})
							v_u_32:Play()
							v_u_32.Completed:Connect(function()
								-- upvalues: (ref) v_u_32, (ref) v_u_10, (copy) v_u_47, (copy) p_u_45
								v_u_32 = nil
								v_u_10.CameraSubject = v_u_47
								v_u_10.CameraType = Enum.CameraType.Custom
								if p_u_45 then
									p_u_45()
								end
							end)
						else
							v_u_10.CameraType = Enum.CameraType.Custom
							if p_u_45 then
								p_u_45()
							end
						end
					else
						v_u_10.CameraType = Enum.CameraType.Custom
						if p_u_45 then
							p_u_45()
						end
						return
					end
				end
				local function v_u_58(p51)
					-- upvalues: (ref) v_u_27, (copy) v_u_20, (ref) v_u_18, (ref) v_u_29, (ref) v_u_30, (ref) v_u_36, (copy) v_u_15, (ref) v_u_35, (copy) v_u_42, (ref) v_u_32, (copy) v_u_10, (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (copy) v_u_44
					v_u_27 = p51 or {}
					if #v_u_27 == 0 then
						v_u_20.Visible = false
						v_u_18.Enabled = false
						v_u_29 = false
						v_u_30 = false
						if v_u_36 then
							v_u_36:Disconnect()
							v_u_36 = nil
						end
						v_u_15:FireServer("stop")
						v_u_35 = Vector3.new(0, 0, 0)
						v_u_42()
						if v_u_32 then
							v_u_32:Cancel()
							v_u_32 = nil
						end
						v_u_10.CameraType = Enum.CameraType.Custom
						return
					else
						local v52 = v_u_28
						local v53 = #v_u_27
						v_u_28 = math.clamp(v52, 1, v53)
						if #v_u_27 == 0 then
							return
						else
							local v54 = v_u_27[v_u_28]
							if v54 then
								local v55 = v54.PlotNumber
								local v56 = "Plot " .. tostring(v55)
								if v_u_26 then
									v_u_26.Text = v56
								end
								if v_u_24 then
									v_u_24.Text = v56
								end
								if v54.CameraCFrame then
									local v57 = v54.CameraCFrame
									if typeof(v57) == "CFrame" then
										v_u_44(v54.CameraCFrame)
									end
								end
							end
						end
					end
				end
				local function v_u_67(p59)
					-- upvalues: (ref) v_u_29, (copy) v_u_9, (ref) v_u_28, (ref) v_u_27, (ref) v_u_30, (copy) v_u_38, (copy) v_u_20, (copy) v_u_21, (copy) v_u_22, (ref) v_u_18, (copy) v_u_10, (ref) v_u_35, (copy) v_u_15, (ref) v_u_36, (copy) v_u_7, (ref) v_u_26, (ref) v_u_24, (copy) v_u_44
					if v_u_29 then
						return
					elseif p59 and #p59 ~= 0 then
						while v_u_9:FindFirstChild("LoadingScreenGui") do
							task.wait(0.1)
						end
						v_u_28 = 1
						v_u_27 = p59
						v_u_30 = false
						v_u_38()
						v_u_20.Visible = true
						v_u_21.Visible = true
						v_u_22.Visible = true
						v_u_18.Enabled = true
						v_u_29 = true
						v_u_10.CameraType = Enum.CameraType.Scriptable
						v_u_35 = v_u_10.CFrame.Position
						v_u_15:FireServer("start", v_u_35)
						v_u_36 = v_u_7.Heartbeat:Connect(function()
							-- upvalues: (ref) v_u_10, (ref) v_u_35, (ref) v_u_15
							local v60 = v_u_10.CFrame.Position
							if (v60 - v_u_35).Magnitude ^ 2 >= 256 then
								v_u_35 = v60
								v_u_15:FireServer("update", v60)
							end
						end)
						local v61 = v_u_27[v_u_28]
						if v61 and v61.CameraCFrame then
							local v62 = v61.CameraCFrame
							if typeof(v62) == "CFrame" then
								v_u_10.CFrame = v61.CameraCFrame
							end
						end
						task.wait(0.1)
						if #v_u_27 == 0 then
							return
						else
							local v63 = v_u_27[v_u_28]
							if v63 then
								local v64 = v63.PlotNumber
								local v65 = "Plot " .. tostring(v64)
								if v_u_26 then
									v_u_26.Text = v65
								end
								if v_u_24 then
									v_u_24.Text = v65
								end
								if v63.CameraCFrame then
									local v66 = v63.CameraCFrame
									if typeof(v66) == "CFrame" then
										v_u_44(v63.CameraCFrame)
									end
								end
							end
						end
					else
						warn("PlotSelectorController: No available plots")
						return
					end
				end
				local function v_u_70()
					-- upvalues: (ref) v_u_36, (copy) v_u_15, (ref) v_u_35, (ref) v_u_30, (ref) v_u_32, (copy) v_u_10, (copy) v_u_8, (copy) v_u_42, (copy) v_u_16, (ref) v_u_18
					if v_u_36 then
						v_u_36:Disconnect()
						v_u_36 = nil
					end
					v_u_15:FireServer("stop")
					v_u_35 = Vector3.new(0, 0, 0)
					v_u_30 = false
					if v_u_32 then
						v_u_32:Cancel()
						v_u_32 = nil
					end
					v_u_10.CameraType = Enum.CameraType.Custom
					local v68 = v_u_8.Character
					local v69 = v68 and v68:FindFirstChild("Humanoid")
					if v69 then
						v_u_10.CameraSubject = v69
					end
					v_u_42()
					v_u_16.SetReady()
					v_u_18:SetAttribute("FlowComplete", true)
				end
				local function v_u_72()
					-- upvalues: (ref) v_u_29, (ref) v_u_30, (ref) v_u_27, (ref) v_u_28, (copy) v_u_12, (copy) v_u_20, (ref) v_u_18, (copy) v_u_70
					if v_u_29 then
						if v_u_30 then
							return
						elseif #v_u_27 == 0 then
							return
						else
							local v71 = v_u_27[v_u_28]
							if v71 then
								v_u_30 = true
								v_u_12:FireServer(v71.PlotName)
								v_u_20.Visible = false
								v_u_18.Enabled = false
								v_u_29 = false
								task.delay(10, function()
									-- upvalues: (ref) v_u_30, (ref) v_u_70
									if v_u_30 then
										warn("PlotSelectorController: Claim timed out, recovering")
										v_u_70()
									end
								end)
							end
						end
					else
						return
					end
				end
				v13.OnClientEvent:Connect(function(p73, p74)
					-- upvalues: (copy) v_u_67, (ref) v_u_30, (ref) v_u_29, (copy) v_u_58, (ref) v_u_36, (copy) v_u_15, (ref) v_u_35, (copy) v_u_50, (copy) v_u_42, (copy) v_u_16, (ref) v_u_18
					if p74 == "open" then
						v_u_67(p73)
						return
					elseif p74 == "claim_failed" then
						v_u_30 = false
						v_u_67(p73)
					elseif p74 == "update" then
						if v_u_29 then
							v_u_58(p73)
							return
						end
					elseif p74 == "teleported" then
						if v_u_36 then
							v_u_36:Disconnect()
							v_u_36 = nil
						end
						v_u_15:FireServer("stop")
						v_u_35 = Vector3.new(0, 0, 0)
						v_u_30 = false
						v_u_50(function()
							-- upvalues: (ref) v_u_42, (ref) v_u_16, (ref) v_u_18
							v_u_42()
							v_u_16.SetReady()
							v_u_18:SetAttribute("FlowComplete", true)
						end)
					end
				end)
				v_u_21.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_29, (ref) v_u_27, (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (copy) v_u_44
					if v_u_29 then
						if #v_u_27 == 0 then
							return
						else
							v_u_28 = v_u_28 + -1
							if v_u_28 < 1 then
								v_u_28 = #v_u_27
							elseif v_u_28 > #v_u_27 then
								v_u_28 = 1
							end
							if #v_u_27 == 0 then
								return
							else
								local v75 = v_u_27[v_u_28]
								if v75 then
									local v76 = v75.PlotNumber
									local v77 = "Plot " .. tostring(v76)
									if v_u_26 then
										v_u_26.Text = v77
									end
									if v_u_24 then
										v_u_24.Text = v77
									end
									if v75.CameraCFrame then
										local v78 = v75.CameraCFrame
										if typeof(v78) == "CFrame" then
											v_u_44(v75.CameraCFrame)
										end
									end
								end
							end
						end
					else
						return
					end
				end)
				v_u_22.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_29, (ref) v_u_27, (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (copy) v_u_44
					if v_u_29 then
						if #v_u_27 == 0 then
							return
						else
							v_u_28 = v_u_28 + 1
							if v_u_28 < 1 then
								v_u_28 = #v_u_27
							elseif v_u_28 > #v_u_27 then
								v_u_28 = 1
							end
							if #v_u_27 == 0 then
								return
							else
								local v79 = v_u_27[v_u_28]
								if v79 then
									local v80 = v79.PlotNumber
									local v81 = "Plot " .. tostring(v80)
									if v_u_26 then
										v_u_26.Text = v81
									end
									if v_u_24 then
										v_u_24.Text = v81
									end
									if v79.CameraCFrame then
										local v82 = v79.CameraCFrame
										if typeof(v82) == "CFrame" then
											v_u_44(v79.CameraCFrame)
										end
									end
								end
							end
						end
					else
						return
					end
				end)
				v25.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_72
					v_u_72()
				end)
				v5.InputBegan:Connect(function(p83, p84)
					-- upvalues: (ref) v_u_29, (ref) v_u_27, (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (copy) v_u_44, (copy) v_u_72
					if p84 then
						return
					elseif v_u_29 then
						if p83.KeyCode == Enum.KeyCode.Left or (p83.KeyCode == Enum.KeyCode.A or p83.KeyCode == Enum.KeyCode.DPadLeft) then
							if not v_u_29 then
								return
							end
							if #v_u_27 == 0 then
								return
							end
							v_u_28 = v_u_28 + -1
							if v_u_28 < 1 then
								v_u_28 = #v_u_27
							elseif v_u_28 > #v_u_27 then
								v_u_28 = 1
							end
							if #v_u_27 == 0 then
								return
							end
							local v85 = v_u_27[v_u_28]
							if not v85 then
								return
							end
							local v86 = v85.PlotNumber
							local v87 = "Plot " .. tostring(v86)
							if v_u_26 then
								v_u_26.Text = v87
							end
							if v_u_24 then
								v_u_24.Text = v87
							end
							if v85.CameraCFrame then
								local v88 = v85.CameraCFrame
								if typeof(v88) == "CFrame" then
									v_u_44(v85.CameraCFrame)
									return
								end
							end
						elseif p83.KeyCode == Enum.KeyCode.Right or (p83.KeyCode == Enum.KeyCode.D or p83.KeyCode == Enum.KeyCode.DPadRight) then
							if not v_u_29 then
								return
							end
							if #v_u_27 == 0 then
								return
							end
							v_u_28 = v_u_28 + 1
							if v_u_28 < 1 then
								v_u_28 = #v_u_27
							elseif v_u_28 > #v_u_27 then
								v_u_28 = 1
							end
							if #v_u_27 == 0 then
								return
							end
							local v89 = v_u_27[v_u_28]
							if not v89 then
								return
							end
							local v90 = v89.PlotNumber
							local v91 = "Plot " .. tostring(v90)
							if v_u_26 then
								v_u_26.Text = v91
							end
							if v_u_24 then
								v_u_24.Text = v91
							end
							if v89.CameraCFrame then
								local v92 = v89.CameraCFrame
								if typeof(v92) == "CFrame" then
									v_u_44(v89.CameraCFrame)
									return
								end
							end
						elseif p83.KeyCode == Enum.KeyCode.Return or (p83.KeyCode == Enum.KeyCode.Space or p83.KeyCode == Enum.KeyCode.ButtonA) then
							v_u_72()
						end
					end
				end)
				local v_u_93 = false
				v5.InputChanged:Connect(function(p94, p95)
					-- upvalues: (ref) v_u_29, (ref) v_u_93, (ref) v_u_27, (ref) v_u_28, (ref) v_u_26, (ref) v_u_24, (copy) v_u_44
					if p95 then
						return
					elseif v_u_29 then
						if p94.KeyCode == Enum.KeyCode.Thumbstick1 then
							local v96 = p94.Position.X
							if math.abs(v96) < 0.5 then
								v_u_93 = false
								return
							elseif not v_u_93 then
								v_u_93 = true
								if v96 < -0.5 then
									if not v_u_29 then
										return
									end
									if #v_u_27 == 0 then
										return
									end
									v_u_28 = v_u_28 + -1
									if v_u_28 < 1 then
										v_u_28 = #v_u_27
									elseif v_u_28 > #v_u_27 then
										v_u_28 = 1
									end
									if #v_u_27 == 0 then
										return
									end
									local v97 = v_u_27[v_u_28]
									if not v97 then
										return
									end
									local v98 = v97.PlotNumber
									local v99 = "Plot " .. tostring(v98)
									if v_u_26 then
										v_u_26.Text = v99
									end
									if v_u_24 then
										v_u_24.Text = v99
									end
									if v97.CameraCFrame then
										local v100 = v97.CameraCFrame
										if typeof(v100) == "CFrame" then
											v_u_44(v97.CameraCFrame)
											return
										end
									end
								elseif v96 > 0.5 then
									if not v_u_29 then
										return
									end
									if #v_u_27 == 0 then
										return
									end
									v_u_28 = v_u_28 + 1
									if v_u_28 < 1 then
										v_u_28 = #v_u_27
									elseif v_u_28 > #v_u_27 then
										v_u_28 = 1
									end
									if #v_u_27 == 0 then
										return
									end
									local v101 = v_u_27[v_u_28]
									if not v101 then
										return
									end
									local v102 = v101.PlotNumber
									local v103 = "Plot " .. tostring(v102)
									if v_u_26 then
										v_u_26.Text = v103
									end
									if v_u_24 then
										v_u_24.Text = v103
									end
									if v101.CameraCFrame then
										local v104 = v101.CameraCFrame
										if typeof(v104) == "CFrame" then
											v_u_44(v101.CameraCFrame)
										end
									end
								end
							end
						else
							return
						end
					else
						return
					end
				end)
				v_u_20.Visible = false
				task.spawn(function()
					-- upvalues: (copy) v_u_9, (copy) v_u_14, (copy) v_u_67, (copy) v_u_10, (copy) v_u_8, (ref) v_u_18
					while v_u_9:FindFirstChild("LoadingScreenGui") do
						task.wait(0.1)
					end
					local v105 = nil
					for v_u_106 = 1, 5 do
						local v_u_107 = false
						local v_u_108 = false
						local v_u_109 = nil
						task.spawn(function()
							-- upvalues: (ref) v_u_14, (ref) v_u_109, (ref) v_u_108, (copy) v_u_106, (ref) v_u_107
							local v110, v111 = pcall(function()
								-- upvalues: (ref) v_u_14
								return v_u_14:InvokeServer()
							end)
							if v110 and v111 then
								v_u_109 = v111
								v_u_108 = true
							elseif v110 then
								warn("[PlotSelectorController] InvokeServer returned nil (attempt " .. v_u_106 .. ")")
							else
								warn("[PlotSelectorController] InvokeServer error (attempt " .. v_u_106 .. "):", v111)
							end
							v_u_107 = true
						end)
						local v112 = v_u_109
						local v113 = v_u_108
						local v114 = 0
						while not v_u_107 and v114 < 10 do
							v114 = v114 + task.wait(0.2)
						end
						if v113 then
							v105 = v112
							break
						end
						if not v_u_107 then
							warn("[PlotSelectorController] GetAvailablePlots timed out (attempt " .. v_u_106 .. ")")
						end
						if v_u_106 < 5 then
							task.wait(1)
						end
					end
					if v105 and #v105 > 0 then
						v_u_67(v105)
					else
						warn("[PlotSelectorController] No plots available or all attempts failed, recovering camera")
						v_u_10.CameraType = Enum.CameraType.Custom
						local v115 = v_u_8.Character
						local v116 = v115 and v115:FindFirstChild("Humanoid")
						if v116 then
							v_u_10.CameraSubject = v116
						end
						v_u_18:SetAttribute("FlowComplete", true)
					end
				end)
			else
				warn("PlotSelectorController: Confirm button not found in MiddleBit")
			end
		else
			warn("PlotSelectorController: Missing navigation buttons")
			return
		end
	else
		warn("PlotSelectorController: Frame not found")
		return
	end
else
	warn("PlotSelectorController: PlotSelector GUI not found")
	return
end