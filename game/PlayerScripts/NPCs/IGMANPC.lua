local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1:WaitForChild("Dialogue"):WaitForChild("DialogueController"))
local v_u_3 = require(v1:WaitForChild("IGMA"):WaitForChild("IGMARewardDefinitions"))
local v_u_4 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions"))
local v_u_5 = require(v1:WaitForChild("Gears"):WaitForChild("Definitions"):WaitForChild("GearDefinitions"))
local v_u_6 = require(v1:WaitForChild("RNGPacks"):WaitForChild("SeedPackDefinitions"))
local v7 = workspace:WaitForChild("IGMA")
local v8 = v7:WaitForChild("Main")
v7:WaitForChild("Helicopter")
local v_u_9 = game.Players.LocalPlayer
local v10 = v1:WaitForChild("RemoteEvents")
local v_u_11 = v10:WaitForChild("IGMATurnIn")
v10:WaitForChild("ClaimIGMAReward")
local v_u_12 = v10:WaitForChild("GetIGMAData")
local v_u_13 = v10:WaitForChild("RestartIGMA")
local v_u_14 = v_u_9:WaitForChild("PlayerGui"):WaitForChild("IGMARewardUI")
local v15 = nil
local v_u_16 = false
local v_u_17 = v_u_12:InvokeServer() or v15
local v18 = v8:WaitForChild("Humanoid", 15)
if v18 then
	local v19 = v18:WaitForChild("Animator", 15)
	if v19 then
		local v_u_20 = {}
		local v_u_21 = nil
		for _, v22 in {
			"Idle",
			"Greeting",
			"Goodbye",
			"TurnInReward",
			"WhoAreYou"
		} do
			local v23 = v8:FindFirstChild(v22)
			if v23 then
				v_u_20[v22] = v19:LoadAnimation(v23)
			end
		end
		if v_u_20.Idle then
			v_u_20.Idle.Looped = true
		end
		if v_u_20.Greeting then
			v_u_20.Greeting.Looped = false
		end
		if v_u_20.Goodbye then
			v_u_20.Goodbye.Looped = false
		end
		if v_u_20.TurnInReward then
			v_u_20.TurnInReward.Looped = false
		end
		if v_u_20.WhoAreYou then
			v_u_20.WhoAreYou.Looped = false
		end
		if v_u_21 then
			v_u_21:Stop()
		end
		local v24 = v_u_20.Idle
		if v24 then
			v_u_21 = v24
			v24:Play(0.1)
		end
		local v_u_25 = {
			"You\'re late, where have you been?",
			"You\'re cutting into my schedule...",
			"Who are you again? Oh right.",
			"I have a report to write, what is it?",
			"I don\'t have all day."
		}
		local v_u_26 = { "You again? You\'ve done your part already.", "Mission\'s over. Unless you want to go again.", "Back for more? It\'ll cost you." }
		local v_u_27 = { "So, you\'re sure about this? 100,000,000 shillings. All progress wiped. Last chance." }
		local v_u_28 = { "The name\'s Rosalind. I\'m the head of the IGMA field team, here to collect samples of Strange plants for further study back at HQ." }
		local v_u_29 = {
			"Hm, not a bad sample.",
			"This will do perfectly fine.",
			"What a high quality sample, good job.",
			"Half baked. But it will do."
		}
		local v_u_30 = { "You\'re wasting my time. Bring me something.", "Empty handed? Come back with a sample.", "I don\'t see anything. Hold a crop." }
		local v_u_31 = { "I need Strange specimens. This is useless to me.", "Wrong mutation. I only take Strange samples.", "This isn\'t what I asked for. Strange plants only." }
		local v_u_32 = { "This has no mutations. Worthless for my research.", "I need Strange samples, not ordinary crops.", "No mutations detected. Don\'t waste my time." }
		local v_u_33 = {
			"I don\'t pay you to stand around.",
			"Back to work.",
			"We need more samples.",
			"Come back when you\'re of use."
		}
		local v_u_34 = { "You\'ve earned your keep. For now.", "Don\'t let the door hit you.", "Come back if you change your mind about restarting." }
		local v_u_35 = { "You\'re not holding anything.", "Show me a crop first.", "What am I appraising, thin air?" }
		local v_u_36 = { "That crop is worth %d %s." }
		local v_u_37 = { "That\'ll be 100,000,000 shillings. All your progress and claimed rewards will be wiped. Talk to me again if you\'re sure." }
		local v_u_38 = { "Done. Clock\'s reset. Don\'t waste my time this round.", "Fresh start. Try not to disappoint me." }
		local v_u_39 = { "Smart. That\'s a lot of money to throw around.", "Changed your mind? Fine by me." }
		local v_u_40 = { "You can\'t afford that. Come back when you have 100,000,000 shillings." }
		local function v_u_58()
			-- upvalues: (copy) v_u_12, (ref) v_u_17, (copy) v_u_14, (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
			local v41 = v_u_12:InvokeServer()
			if v41 then
				v_u_17 = v41
			end
			local v42 = v_u_17
			if not v42 then
				return
			end
			local v43 = v_u_14.Background.ScrollingFrame
			local v44 = v43:FindFirstChild("Template")
			if not v44 then
				return
			end
			for _, v45 in v43:GetChildren() do
				if v45:IsA("Frame") and v45 ~= v44 then
					v45:Destroy()
				end
			end
			for v46, v47 in v_u_3.Rewards do
				local v48 = v44:Clone()
				v48.Name = "Reward_" .. v46
				v48.Visible = true
				local v49 = v48:FindFirstChild("Points")
				if v49 then
					v49.Text = v47.Points .. " pts"
				end
				local v50 = v48:FindFirstChild("Item")
				if v50 then
					if v47.Type == "Seed" then
						local v51 = v_u_4[v47.Item]
						if v51 and v51.SeedAssetId then
							v50.Image = v51.SeedAssetId
						end
					elseif v47.Type == "Gear" then
						local v52 = v_u_5.Gears[v47.Item]
						if v52 and v52.IconAssetId then
							v50.Image = v52.IconAssetId
						end
					elseif v47.Type == "SeedPack" then
						local v53 = v_u_6[v47.Item]
						if v53 and v53.Image then
							v50.Image = v53.Image
						end
					end
				end
				local v54 = v48:FindFirstChild("Quantity")
				if v54 then
					if v47.Amount > 1 then
						v54.Text = "x" .. v47.Amount
						v54.Visible = true
					else
						v54.Visible = false
					end
				end
				local v55 = false
				for _, v56 in v42.ClaimedRewards do
					if v56 == v46 then
						v55 = true
						break
					end
				end
				local v57 = v42.Points >= v47.Points
				if v55 then
					if v50 then
						v50.ImageTransparency = 0.5
					end
					v48.BackgroundTransparency = 0.7
				elseif not v57 and v50 then
					v50.ImageTransparency = 0.3
				end
				v48.Parent = v43
			end
			v_u_14.Enabled = true
		end
		local v_u_87 = {
			{
				["Text"] = "Who are you?",
				["Run"] = function(_, p59)
					-- upvalues: (ref) v_u_21, (copy) v_u_20, (copy) v_u_28
					if v_u_21 then
						v_u_21:Stop()
					end
					local v60 = v_u_20.WhoAreYou
					if v60 then
						v_u_21 = v60
						v60:Play(0.1)
					end
					if v_u_20.WhoAreYou then
						v_u_20.WhoAreYou.Stopped:Once(function()
							-- upvalues: (ref) v_u_21, (ref) v_u_20
							if v_u_21 then
								v_u_21:Stop()
							end
							local v61 = v_u_20.Idle
							if v61 then
								v_u_21 = v61
								v61:Play(0.1)
							end
						end)
					end
					p59:DisplayNPCText(v_u_28[1], 5)
					task.wait(5)
				end
			},
			{
				["Text"] = "Turn in Strange Plants",
				["Run"] = function(_, p62)
					-- upvalues: (copy) v_u_9, (copy) v_u_30, (copy) v_u_11, (copy) v_u_32, (copy) v_u_31, (ref) v_u_17, (ref) v_u_21, (copy) v_u_20, (copy) v_u_29
					local v63 = v_u_9.Character
					if v63 then
						v63 = v63:FindFirstChildOfClass("Tool")
					end
					if v63 and v63:GetAttribute("IsHarvested") then
						p62:DisplayNPCText("Let me inspect this...", 1.5)
						task.wait(1.5)
						local v64 = v_u_11:InvokeServer("TurnIn")
						if v64 and v64.Status ~= "error" then
							if v64.Status == "completed" then
								p62:DisplayNPCText("You\'ve already reached the maximum. There\'s nothing left to turn in.", 3)
								task.wait(3)
								return
							elseif v64.Status == "no_tool" then
								local v65 = v_u_30
								p62:DisplayNPCText(v65[math.random(1, #v65)], 2.5)
								task.wait(2.5)
								return
							elseif v64.Status == "not_harvested" then
								p62:DisplayNPCText("That isn\'t harvested. Bring me a proper sample.", 2.5)
								task.wait(2.5)
								return
							elseif v64.Status == "no_mutation" or v64.Status == "wrong_mutation" then
								local v66 = v64.Status == "no_mutation" and v_u_32 or v_u_31
								p62:DisplayNPCText(v66[math.random(1, #v66)], 3)
								task.wait(3)
								return
							elseif v64.Status == "success" then
								v_u_17.Points = v64.TotalPoints
								if v64.Completed then
									v_u_17.Completed = true
								end
								if v_u_21 then
									v_u_21:Stop()
								end
								local v67 = v_u_20.TurnInReward
								if v67 then
									v_u_21 = v67
									v67:Play(0.1)
								end
								if v_u_20.TurnInReward then
									v_u_20.TurnInReward.Stopped:Once(function()
										-- upvalues: (ref) v_u_21, (ref) v_u_20
										if v_u_21 then
											v_u_21:Stop()
										end
										local v68 = v_u_20.Idle
										if v68 then
											v_u_21 = v68
											v68:Play(0.1)
										end
									end)
								end
								local v69 = v_u_29
								p62:DisplayNPCText(v69[math.random(1, #v69)] .. " +" .. (v64.Points == 1 and "1 point" or v64.Points .. " points") .. ". Total: " .. v64.TotalPoints .. ".", 3.5)
								task.wait(3.5)
							else
								p62:DisplayNPCText("Something went wrong. Try again.", 2.5)
								task.wait(2.5)
							end
						else
							p62:DisplayNPCText("Something went wrong. Try again.", 2.5)
							task.wait(2.5)
							return
						end
					else
						local v70 = v_u_30
						p62:DisplayNPCText(v70[math.random(1, #v70)], 2.5)
						task.wait(2.5)
						return
					end
				end
			},
			{
				["Text"] = "Submit all Strange Plants",
				["Run"] = function(_, p71)
					-- upvalues: (copy) v_u_11, (ref) v_u_17, (ref) v_u_21, (copy) v_u_20
					p71:DisplayNPCText("Let me check your inventory...", 1.5)
					task.wait(1.5)
					local v72 = v_u_11:InvokeServer("TurnInAll")
					if v72 and v72.Status ~= "error" then
						if v72.Status == "completed" then
							p71:DisplayNPCText("You\'ve already reached the maximum. There\'s nothing left to turn in.", 3)
							task.wait(3)
							return
						elseif v72.Status == "none_found" then
							p71:DisplayNPCText("No Strange samples in your inventory.", 2.5)
							task.wait(2.5)
							return
						elseif v72.Status == "success" then
							v_u_17.Points = v72.TotalPoints
							if v72.Completed then
								v_u_17.Completed = true
							end
							if v_u_21 then
								v_u_21:Stop()
							end
							local v73 = v_u_20.TurnInReward
							if v73 then
								v_u_21 = v73
								v73:Play(0.1)
							end
							if v_u_20.TurnInReward then
								v_u_20.TurnInReward.Stopped:Once(function()
									-- upvalues: (ref) v_u_21, (ref) v_u_20
									if v_u_21 then
										v_u_21:Stop()
									end
									local v74 = v_u_20.Idle
									if v74 then
										v_u_21 = v74
										v74:Play(0.1)
									end
								end)
							end
							local v75 = v72.Points == 1 and "1 point" or v72.Points .. " points"
							p71:DisplayNPCText(v72.Count .. " samples collected. +" .. v75 .. ". Total: " .. v72.TotalPoints .. ".", 4)
							task.wait(4)
						else
							p71:DisplayNPCText("Something went wrong. Try again.", 2.5)
							task.wait(2.5)
						end
					else
						p71:DisplayNPCText("Something went wrong. Try again.", 2.5)
						task.wait(2.5)
						return
					end
				end
			},
			{
				["Text"] = "How much is this worth?",
				["Run"] = function(_, p76)
					-- upvalues: (copy) v_u_9, (copy) v_u_35, (copy) v_u_11, (copy) v_u_36
					local v77 = v_u_9.Character
					if v77 then
						v77 = v77:FindFirstChildOfClass("Tool")
					end
					if v77 and v77:GetAttribute("IsHarvested") then
						local v78 = v_u_11:InvokeServer("Appraise")
						if v78 and v78.Status ~= "error" then
							if v78.Status == "completed" then
								p76:DisplayNPCText("Doesn\'t matter. You\'ve hit the cap.", 2.5)
								task.wait(2.5)
								return
							elseif v78.Status == "no_tool" then
								local v79 = v_u_35
								p76:DisplayNPCText(v79[math.random(1, #v79)], 2.5)
								task.wait(2.5)
								return
							elseif v78.Status == "no_mutation" or (v78.Status == "wrong_mutation" or v78.Status == "not_harvested") then
								p76:DisplayNPCText("That\'s worthless to me. I only take Strange samples.", 3)
								task.wait(3)
								return
							elseif v78.Status == "appraise" then
								local v80 = v78.Points == 1 and "point" or "points"
								local v81 = v_u_36
								p76:DisplayNPCText(string.format(v81[math.random(1, #v81)], v78.Points, v80), 3.5)
								task.wait(3.5)
							else
								p76:DisplayNPCText("Something went wrong. Try again.", 2.5)
								task.wait(2.5)
							end
						else
							p76:DisplayNPCText("Something went wrong. Try again.", 2.5)
							task.wait(2.5)
							return
						end
					else
						local v82 = v_u_35
						p76:DisplayNPCText(v82[math.random(1, #v82)], 2.5)
						task.wait(2.5)
						return
					end
				end
			},
			{
				["Text"] = "See Rewards",
				["Run"] = function(_, _)
					-- upvalues: (copy) v_u_58
					v_u_58()
				end
			},
			{
				["Text"] = "Goodbye.",
				["Run"] = function(_, p83)
					-- upvalues: (copy) v_u_33, (ref) v_u_21, (copy) v_u_20
					local v84 = v_u_33
					p83:DisplayNPCText(v84[math.random(1, #v84)], 2)
					if v_u_21 then
						v_u_21:Stop()
					end
					local v85 = v_u_20.Goodbye
					if v85 then
						v_u_21 = v85
						v85:Play(0.1)
					end
					if v_u_20.Goodbye then
						v_u_20.Goodbye.Stopped:Once(function()
							-- upvalues: (ref) v_u_21, (ref) v_u_20
							if v_u_21 then
								v_u_21:Stop()
							end
							local v86 = v_u_20.Idle
							if v86 then
								v_u_21 = v86
								v86:Play(0.1)
							end
						end)
					end
					task.wait(2)
				end
			}
		}
		local v_u_97 = {
			{
				["Text"] = "Who are you?",
				["Run"] = function(_, p88)
					-- upvalues: (ref) v_u_21, (copy) v_u_20, (copy) v_u_28
					if v_u_21 then
						v_u_21:Stop()
					end
					local v89 = v_u_20.WhoAreYou
					if v89 then
						v_u_21 = v89
						v89:Play(0.1)
					end
					if v_u_20.WhoAreYou then
						v_u_20.WhoAreYou.Stopped:Once(function()
							-- upvalues: (ref) v_u_21, (ref) v_u_20
							if v_u_21 then
								v_u_21:Stop()
							end
							local v90 = v_u_20.Idle
							if v90 then
								v_u_21 = v90
								v90:Play(0.1)
							end
						end)
					end
					p88:DisplayNPCText(v_u_28[1], 5)
					task.wait(5)
				end
			},
			{
				["Text"] = "Restart Mission (100,000,000 Shillings)",
				["Run"] = function(_, p91)
					-- upvalues: (ref) v_u_16, (copy) v_u_37
					v_u_16 = true
					local v92 = v_u_37
					p91:DisplayNPCText(v92[math.random(1, #v92)], 4)
					task.wait(4)
				end
			},
			{
				["Text"] = "See Rewards",
				["Run"] = function(_, _)
					-- upvalues: (copy) v_u_58
					v_u_58()
				end
			},
			{
				["Text"] = "Goodbye.",
				["Run"] = function(_, p93)
					-- upvalues: (copy) v_u_34, (ref) v_u_21, (copy) v_u_20
					local v94 = v_u_34
					p93:DisplayNPCText(v94[math.random(1, #v94)], 2)
					if v_u_21 then
						v_u_21:Stop()
					end
					local v95 = v_u_20.Goodbye
					if v95 then
						v_u_21 = v95
						v95:Play(0.1)
					end
					if v_u_20.Goodbye then
						v_u_20.Goodbye.Stopped:Once(function()
							-- upvalues: (ref) v_u_21, (ref) v_u_20
							if v_u_21 then
								v_u_21:Stop()
							end
							local v96 = v_u_20.Idle
							if v96 then
								v_u_21 = v96
								v96:Play(0.1)
							end
						end)
					end
					task.wait(2)
				end
			}
		}
		local v_u_104 = {
			{
				["Text"] = "Yes, restart.",
				["Run"] = function(_, p98)
					-- upvalues: (copy) v_u_13, (ref) v_u_16, (copy) v_u_40, (ref) v_u_17, (copy) v_u_38
					p98:DisplayNPCText("Processing...", 1)
					task.wait(1)
					local v99 = v_u_13:InvokeServer()
					v_u_16 = false
					if v99 and v99.Status ~= "error" then
						if v99.Status == "insufficient_funds" then
							local v100 = v_u_40
							p98:DisplayNPCText(v100[math.random(1, #v100)], 3)
							task.wait(3)
							return
						elseif v99.Status == "not_completed" then
							p98:DisplayNPCText("There\'s nothing to restart.", 2.5)
							task.wait(2.5)
							return
						elseif v99.Status == "success" then
							v_u_17 = {
								["Points"] = 0,
								["ClaimedRewards"] = {},
								["Completed"] = false
							}
							local v101 = v_u_38
							p98:DisplayNPCText(v101[math.random(1, #v101)], 3)
							task.wait(3)
						else
							p98:DisplayNPCText("Something went wrong. Try again.", 2.5)
							task.wait(2.5)
						end
					else
						p98:DisplayNPCText("Something went wrong. Try again.", 2.5)
						task.wait(2.5)
						return
					end
				end
			},
			{
				["Text"] = "No, nevermind.",
				["Run"] = function(_, p102)
					-- upvalues: (ref) v_u_16, (copy) v_u_39
					v_u_16 = false
					local v103 = v_u_39
					p102:DisplayNPCText(v103[math.random(1, #v103)], 2.5)
					task.wait(2.5)
				end
			}
		}
		local function v_u_110()
			-- upvalues: (ref) v_u_17, (copy) v_u_12, (ref) v_u_16, (copy) v_u_104, (copy) v_u_97, (copy) v_u_87, (copy) v_u_27, (copy) v_u_26, (copy) v_u_25
			if not v_u_17 then
				local v105 = v_u_12:InvokeServer()
				if v105 then
					v_u_17 = v105
				end
				v_u_17 = v_u_17
			end
			local v106
			if v_u_17 and v_u_17.Completed then
				if v_u_16 then
					v106 = v_u_104
				else
					v106 = v_u_97
				end
			else
				v106 = v_u_87
			end
			local v107
			if v106 == v_u_104 then
				v107 = v_u_27
			elseif v106 == v_u_97 then
				v107 = v_u_26
			else
				v107 = v_u_25
			end
			local v108 = {}
			for _, v109 in v107 do
				table.insert(v108, {
					["Text"] = v109,
					["Choices"] = v106
				})
			end
			return v108
		end
		local v_u_111 = nil
		v_u_111 = v2.new({
			["NPC"] = v8,
			["Name"] = "Rosalind",
			["NametagBackgroundColor"] = Color3.fromRGB(25, 0, 41),
			["NametagTextColor"] = Color3.fromRGB(230, 210, 255),
			["NametagStrokeColor"] = Color3.fromRGB(30, 0, 44),
			["ProximityPrompt"] = v8:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt"),
			["HighlightColor"] = Color3.fromRGB(160, 80, 255),
			["RandomLine"] = true,
			["Dialogue"] = v_u_110(),
			["OnDialogueStart"] = function()
				-- upvalues: (ref) v_u_111, (copy) v_u_110, (ref) v_u_21, (copy) v_u_20
				v_u_111.Dialogue = v_u_110()
				if v_u_21 then
					v_u_21:Stop()
				end
				local v112 = v_u_20.Greeting
				if v112 then
					v_u_21 = v112
					v112:Play(0.1)
				end
				if v_u_20.Greeting then
					v_u_20.Greeting.Stopped:Once(function()
						-- upvalues: (ref) v_u_21, (ref) v_u_20
						if v_u_21 then
							v_u_21:Stop()
						end
						local v113 = v_u_20.Idle
						if v113 then
							v_u_21 = v113
							v113:Play(0.1)
						end
					end)
				end
			end,
			["OnDialogueEnd"] = function()
				-- upvalues: (ref) v_u_21, (copy) v_u_20
				if v_u_21 then
					v_u_21:Stop()
				end
				local v114 = v_u_20.Idle
				if v114 then
					v_u_21 = v114
					v114:Play(0.1)
				end
			end
		})
	else
		warn("[IGMANPC] Animator not found after timeout")
	end
else
	warn("[IGMANPC] Humanoid not found after timeout")
	return
end