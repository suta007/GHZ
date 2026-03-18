local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("SoundService")
local v_u_5 = require(v1:WaitForChild("Dialogue"):WaitForChild("DialogueController"))
local v_u_6 = v2.LocalPlayer:WaitForChild("PlayerGui")
local v7 = v1:WaitForChild("RemoteEvents")
local v8 = v7:WaitForChild("MannyMishapScoreUpdate")
local v_u_9 = v7:WaitForChild("MannyMishapTurnIn")
local v_u_10 = 0
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = Instance.new("NumberValue")
v_u_15.Value = 0
local v_u_16 = Instance.new("Sound")
v_u_16.SoundId = "rbxassetid://7772692875"
v_u_16.Volume = 1
v_u_16.RollOffMaxDistance = 0
v_u_16.Parent = v4
local function v_u_23()
	-- upvalues: (ref) v_u_11, (copy) v_u_6, (copy) v_u_15, (ref) v_u_10, (ref) v_u_13
	if v_u_11 then
		return
	else
		v_u_11 = v_u_6:WaitForChild("MannyMishapScore", 10)
		if v_u_11 then
			local v_u_17 = v_u_11.ScoreFrame:FindFirstChild("Counter")
			if v_u_17 then
				v_u_15.Value = v_u_10
				local v18 = v_u_10
				local v19 = math.floor(v18)
				v_u_17.Text = tostring(v19)
				v_u_13 = v_u_15:GetPropertyChangedSignal("Value"):Connect(function()
					-- upvalues: (copy) v_u_17, (ref) v_u_15
					local v20 = v_u_17
					local v21 = v_u_15.Value
					local v22 = math.floor(v21)
					v20.Text = tostring(v22)
				end)
			end
			v_u_11.Enabled = true
		else
			warn("MannyMishapScore GUI not found")
		end
	end
end
local function v_u_25(p24)
	-- upvalues: (ref) v_u_11, (ref) v_u_14, (copy) v_u_3, (copy) v_u_15
	if v_u_11 then
		if v_u_14 then
			v_u_14:Cancel()
			v_u_14 = nil
		end
		v_u_14 = v_u_3:Create(v_u_15, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Value"] = p24
		})
		v_u_14:Play()
	end
end
v8.OnClientEvent:Connect(function(p26)
	-- upvalues: (ref) v_u_10, (copy) v_u_25, (copy) v_u_16
	if typeof(p26) == "number" then
		local v27 = v_u_10 < p26
		v_u_10 = p26
		v_u_25(p26)
		if v27 then
			v_u_16:Play()
		end
	end
end)
local function v_u_55()
	-- upvalues: (ref) v_u_10, (copy) v_u_15, (copy) v_u_23, (ref) v_u_14, (ref) v_u_13, (ref) v_u_11, (copy) v_u_9, (copy) v_u_6, (copy) v_u_5, (ref) v_u_12
	v_u_10 = 0
	v_u_15.Value = 0
	v_u_23()
	local v28 = workspace:WaitForChild("MannyMishapScene", 15)
	if v28 then
		local v29 = v28:WaitForChild("MannyNPC", 5)
		if v29 then
			local v30 = {
				["Idle1"] = v29:WaitForChild("MannyIdle1", 15),
				["Idle2"] = v29:WaitForChild("MannyIdle2", 15),
				["Greeting"] = v29:WaitForChild("MannyGreeting", 15),
				["TurnIn"] = v29:WaitForChild("MannyTurnIn", 15),
				["End"] = v29:WaitForChild("MannyEnd", 15)
			}
			if v30.Idle1 and (v30.Idle2 and (v30.Greeting and (v30.TurnIn and v30.End))) then
				local v31 = v29:WaitForChild("Humanoid", 15)
				if v31 then
					local v32 = v31:WaitForChild("Animator", 15)
					if v32 then
						local v_u_33 = {
							["Idle1"] = v32:LoadAnimation(v30.Idle1),
							["Idle2"] = v32:LoadAnimation(v30.Idle2),
							["Greeting"] = v32:LoadAnimation(v30.Greeting),
							["TurnIn"] = v32:LoadAnimation(v30.TurnIn),
							["End"] = v32:LoadAnimation(v30.End)
						}
						v_u_33.Idle1.Looped = true
						v_u_33.Idle2.Looped = true
						v_u_33.Greeting.Looped = false
						v_u_33.TurnIn.Looped = false
						v_u_33.End.Looped = false
						local v_u_34 = nil
						v_u_33.Greeting.Stopped:Once(function()
							-- upvalues: (ref) v_u_34, (copy) v_u_33
							if v_u_34 then
								v_u_34:Stop()
							end
							local v35 = v_u_33.Idle1
							if v35 then
								v_u_34 = v35
								v35:Play(0.1)
							end
						end)
						v_u_33.TurnIn.Stopped:Once(function()
							-- upvalues: (ref) v_u_34, (copy) v_u_33
							if v_u_34 then
								v_u_34:Stop()
							end
							local v36 = v_u_33.Idle1
							if v36 then
								v_u_34 = v36
								v36:Play(0.1)
							end
						end)
						if v_u_34 then
							v_u_34:Stop()
						end
						local v37 = v_u_33.Idle1
						if v37 then
							v_u_34 = v37
							v37:Play(0.1)
						end
						local v_u_38 = false
						local v48 = {
							{
								["Text"] = "Who are you?",
								["Run"] = function(_, p39)
									-- upvalues: (ref) v_u_38
									p39:DisplayNPCText("I\'m Manny. My cart flipped and my fruit went everywhere.", 3)
									task.wait(3)
									if v_u_38 then
										p39:DisplayPlayerText("Are you able to collect them for me?", 3)
										task.wait(3)
									end
								end
							},
							{
								["Text"] = "Turn in fruits!",
								["Run"] = function(_, p40)
									-- upvalues: (ref) v_u_34, (copy) v_u_33, (ref) v_u_38, (ref) v_u_9
									p40:DisplayNPCText("Let me see...", 1.5)
									if v_u_34 then
										v_u_34:Stop()
									end
									local v41 = v_u_33.TurnIn
									if v41 then
										v_u_34 = v41
										v41:Play(0.1)
									end
									v_u_33.TurnIn.Stopped:Once(function()
										-- upvalues: (ref) v_u_34, (ref) v_u_33
										if v_u_34 then
											v_u_34:Stop()
										end
										local v42 = v_u_33.Idle1
										if v42 then
											v_u_34 = v42
											v42:Play(0.1)
										end
									end)
									task.wait(1)
									if v_u_38 then
										local v43 = v_u_9:InvokeServer()
										if v_u_38 then
											if v43 and v43 ~= "" then
												p40:DisplayNPCText(v43, 3)
												task.wait(3)
											end
										end
									else
										return
									end
								end
							},
							{
								["Text"] = "Show me the rewards!",
								["Run"] = function(_, p44)
									-- upvalues: (ref) v_u_38, (ref) v_u_6, (ref) v_u_11
									p44:DisplayNPCText("Take a look!", 1.5)
									if v_u_38 then
										local v_u_45 = v_u_6:FindFirstChild("MannyMishapRewards")
										if v_u_45 then
											if v_u_11 then
												v_u_11.Enabled = false
											end
											v_u_45.Enabled = true
											v_u_45:GetPropertyChangedSignal("Enabled"):Once(function()
												-- upvalues: (copy) v_u_45, (ref) v_u_11
												if not v_u_45.Enabled and v_u_11 then
													v_u_11.Enabled = true
												end
											end)
										end
									end
								end
							},
							{
								["Text"] = "Goodbye.",
								["Run"] = function(_, p46)
									-- upvalues: (ref) v_u_34, (copy) v_u_33
									p46:DisplayNPCText("Later.", 1.5)
									if v_u_34 then
										v_u_34:Stop()
									end
									local v47 = v_u_33.End
									if v47 then
										v_u_34 = v47
										v47:Play(0.1)
									end
								end
							}
						}
						local v49 = v_u_5.new
						local v53 = {
							["NPC"] = v29,
							["Name"] = "Manny",
							["NametagBackgroundColor"] = Color3.fromRGB(41, 11, 0),
							["NametagTextColor"] = Color3.fromRGB(255, 226, 200),
							["NametagStrokeColor"] = Color3.fromRGB(44, 12, 0),
							["ProximityPrompt"] = v29:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt"),
							["HighlightColor"] = Color3.fromRGB(255, 160, 50),
							["RandomLine"] = true,
							["Dialogue"] = {
								{
									["Text"] = "Cart\'s busted. What?",
									["Choices"] = v48
								},
								{
									["Text"] = "Fruit everywhere! Yeah?",
									["Choices"] = v48
								},
								{
									["Text"] = "Oh hey. What?",
									["Choices"] = v48
								},
								{
									["Text"] = "Watch your head! Yeah?",
									["Choices"] = v48
								}
							},
							["OnDialogueStart"] = function()
								-- upvalues: (ref) v_u_38, (ref) v_u_34, (copy) v_u_33
								v_u_38 = true
								if v_u_34 then
									v_u_34:Stop()
								end
								local v50 = v_u_33.Greeting
								if v50 then
									v_u_34 = v50
									v50:Play(0.1)
								end
								v_u_33.Greeting.Stopped:Once(function()
									-- upvalues: (ref) v_u_34, (ref) v_u_33
									if v_u_34 then
										v_u_34:Stop()
									end
									local v51 = v_u_33.Idle1
									if v51 then
										v_u_34 = v51
										v51:Play(0.1)
									end
								end)
							end,
							["OnDialogueEnd"] = function()
								-- upvalues: (ref) v_u_38, (ref) v_u_34, (copy) v_u_33
								v_u_38 = false
								if v_u_34 then
									v_u_34:Stop()
								end
								local v52 = v_u_33.Idle1
								if v52 then
									v_u_34 = v52
									v52:Play(0.1)
								end
							end
						}
						local v_u_54 = v49(v53)
						v_u_12 = v_u_54
						v28.Destroying:Connect(function()
							-- upvalues: (copy) v_u_54, (ref) v_u_12, (ref) v_u_14, (ref) v_u_13, (ref) v_u_11, (ref) v_u_10, (ref) v_u_15
							v_u_54:Destroy()
							v_u_12 = nil
							if v_u_14 then
								v_u_14:Cancel()
								v_u_14 = nil
							end
							if v_u_13 then
								v_u_13:Disconnect()
								v_u_13 = nil
							end
							if v_u_11 then
								v_u_11.Enabled = false
								v_u_11 = nil
							end
							v_u_10 = 0
							v_u_15.Value = 0
						end)
					else
						warn("[MannyNPC] Animator not found after timeout")
						if v_u_14 then
							v_u_14:Cancel()
							v_u_14 = nil
						end
						if v_u_13 then
							v_u_13:Disconnect()
							v_u_13 = nil
						end
						if v_u_11 then
							v_u_11.Enabled = false
							v_u_11 = nil
						end
					end
				else
					warn("[MannyNPC] Humanoid not found after timeout")
					if v_u_14 then
						v_u_14:Cancel()
						v_u_14 = nil
					end
					if v_u_13 then
						v_u_13:Disconnect()
						v_u_13 = nil
					end
					if v_u_11 then
						v_u_11.Enabled = false
						v_u_11 = nil
					end
					return
				end
			else
				warn("[MannyNPC] Animation instances not found after timeout")
				if v_u_14 then
					v_u_14:Cancel()
					v_u_14 = nil
				end
				if v_u_13 then
					v_u_13:Disconnect()
					v_u_13 = nil
				end
				if v_u_11 then
					v_u_11.Enabled = false
					v_u_11 = nil
				end
				return
			end
		else
			if v_u_14 then
				v_u_14:Cancel()
				v_u_14 = nil
			end
			if v_u_13 then
				v_u_13:Disconnect()
				v_u_13 = nil
			end
			if v_u_11 then
				v_u_11.Enabled = false
				v_u_11 = nil
			end
			return
		end
	else
		if v_u_14 then
			v_u_14:Cancel()
			v_u_14 = nil
		end
		if v_u_13 then
			v_u_13:Disconnect()
			v_u_13 = nil
		end
		if v_u_11 then
			v_u_11.Enabled = false
			v_u_11 = nil
		end
		return
	end
end
local v_u_56 = false
workspace:GetAttributeChangedSignal("CurrentWeather"):Connect(function()
	-- upvalues: (ref) v_u_56, (copy) v_u_55
	local v57 = workspace:GetAttribute("CurrentWeather")
	if v57 == "MannyMishap" and not v_u_56 then
		v_u_56 = true
		task.spawn(v_u_55)
	elseif v57 ~= "MannyMishap" then
		v_u_56 = false
	end
end)
task.spawn(function()
	-- upvalues: (ref) v_u_56, (copy) v_u_55
	local v58 = workspace:GetAttribute("CurrentWeather")
	if v58 == nil then
		workspace:GetAttributeChangedSignal("CurrentWeather"):Wait()
		v58 = workspace:GetAttribute("CurrentWeather")
	end
	if v58 == "MannyMishap" and not v_u_56 then
		v_u_56 = true
		v_u_55()
	end
end)