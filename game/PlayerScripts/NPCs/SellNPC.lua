local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SoundService")
local v_u_3 = game:GetService("Debris")
local v4 = require(v1:WaitForChild("Dialogue"):WaitForChild("DialogueController"))
local v_u_5 = require(v1:WaitForChild("Economy"):WaitForChild("Formatter"):WaitForChild("NumberFormatter"))
local v_u_6 = require(v1:WaitForChild("Economy"):WaitForChild("FruitValueCalculator"))
local v_u_7 = v1:WaitForChild("RemoteEvents"):WaitForChild("SellItems")
local v_u_8 = v1:WaitForChild("RemoteEvents"):WaitForChild("ClaimSoftlockCash")
local v9 = workspace:WaitForChild("MapPhysical"):WaitForChild("Shops"):WaitForChild("Sell Stand"):WaitForChild("Steve")
local v10 = {
	["Idle"] = v9:WaitForChild("Idle", 15),
	["Greeting"] = v9:WaitForChild("Greeting", 15),
	["PriceCheck"] = v9:WaitForChild("PriceCheck", 15),
	["Sold"] = v9:WaitForChild("Sold", 15)
}
if v10.Idle and (v10.Greeting and (v10.PriceCheck and v10.Sold)) then
	local v11 = v9:WaitForChild("Humanoid", 15)
	if v11 then
		local v12 = v11:WaitForChild("Animator", 15)
		if v12 then
			local v_u_13 = {
				["Idle"] = v12:LoadAnimation(v10.Idle),
				["Greeting"] = v12:LoadAnimation(v10.Greeting),
				["PriceCheck"] = v12:LoadAnimation(v10.PriceCheck),
				["Sold"] = v12:LoadAnimation(v10.Sold)
			}
			v_u_13.Greeting.Looped = false
			v_u_13.PriceCheck.Looped = false
			v_u_13.Sold.Looped = false
			v_u_13.Idle.Looped = true
			local v_u_14 = nil
			v_u_13.Greeting.Stopped:Connect(function()
				-- upvalues: (ref) v_u_14, (copy) v_u_13
				if v_u_14 then
					v_u_14:Stop()
				end
				local v15 = v_u_13.Idle
				if v15 then
					v_u_14 = v15
					v15:Play(0.1)
				end
			end)
			v_u_13.PriceCheck.Stopped:Connect(function()
				-- upvalues: (ref) v_u_14, (copy) v_u_13
				if v_u_14 then
					v_u_14:Stop()
				end
				local v16 = v_u_13.Idle
				if v16 then
					v_u_14 = v16
					v16:Play(0.1)
				end
			end)
			v_u_13.Sold.Stopped:Connect(function()
				-- upvalues: (ref) v_u_14, (copy) v_u_13
				if v_u_14 then
					v_u_14:Stop()
				end
				local v17 = v_u_13.Idle
				if v17 then
					v_u_14 = v17
					v17:Play(0.1)
				end
			end)
			if v_u_14 then
				v_u_14:Stop()
			end
			local v18 = v_u_13.Idle
			if v18 then
				v_u_14 = v18
				v18:Play(0.1)
			end
			local function v_u_23()
				-- upvalues: (copy) v_u_2, (copy) v_u_3
				local v19 = game.Players.LocalPlayer.Character
				if v19 then
					local v20 = v19:FindFirstChild("Head")
					if v20 then
						local v21 = v_u_2:FindFirstChild("SFX", true) and v_u_2.SFX:FindFirstChild("UI", true)
						if v21 then
							v21 = v_u_2.SFX.UI:FindFirstChild("Selling")
						end
						if v21 then
							local v22 = v21:Clone()
							v22.PlaybackSpeed = math.random(95, 115) / 100
							v22.Parent = v20
							v22:Play()
							v_u_3:AddItem(v22, v22.TimeLength)
						end
					else
						return
					end
				else
					return
				end
			end
			local v_u_24 = {
				"Well what am I supposed to do with this?",
				"I ain\'t got a clue what that is.",
				"Are you wasting my time?",
				"Get outta here with that junk.",
				"What the hell is this supposed to be?",
				"Nice try, pal. Next.",
				"I can\'t sell what I can\'t identify, capisce?",
				"Look, I don\'t got time for this.",
				"Seriously? You brought me THIS?",
				"Is this some kinda joke to you?",
				"Listen pal, I got standards.",
				"I\'ve been in this business 20 years. Never seen nothin\' like that.",
				"Look man, I don\'t take this sorta stuff no more.",
				"That ain\'t worth nothin\' to me.",
				"Where\'d you even find this garbage?",
				"That\'s a new one. And not in a good way.",
				"Whaddaya expect me to do with this?"
			}
			local v_u_25 = {
				"Big spender comin\' through!",
				"Look at you, clearin\' out the inventory!",
				"Alright, let\'s count \'em up.",
				"This is gonna take a minute...",
				"We got mister moneybags over here, huh?",
				"Let\'s take a look here, shall we?",
				"Let\'s see what you got."
			}
			local v_u_26 = {
				"Hmm... not bad, not bad at all.",
				"Ehhh, seen better, seen worse.",
				"Where\'d ya find somethin\' like that?",
				"Keep bringin\' me stuff like this and we\'ll get along just fine.",
				"Not too shabby.",
				"Yeah, I can work with this.",
				"Yeah, this is decent stuff.",
				"That\'ll fetch a decent price.",
				"Solid. Real solid.",
				"This one\'s got some value to it.",
				"You know what you\'re doin\', kid.",
				"You got an eye for quality, I\'ll give ya that."
			}
			local v_u_27 = {
				"Here, take it. Don\'t say I never helped.",
				"Fine, fine. Here\'s a few shillings.",
				"You\'re killin\' me. Here.",
				"Alright, alright. On the house."
			}
			local v_u_28 = {
				"I already helped ya. Beat it.",
				"What am I, a charity? Come back later.",
				"You just asked me that. Scram.",
				"I ain\'t made of money, pal."
			}
			local v_u_29 = {
				"You just got here, kid. Go plant somethin\'.",
				"Relax, you just walked in. Give it time.",
				"You ain\'t even tried yet. Get to work.",
				"Slow down, pal. You just showed up."
			}
			local v_u_30 = false
			local v59 = {
				{
					["Text"] = "How much is this worth?",
					["Run"] = function(p31, p32)
						-- upvalues: (ref) v_u_14, (copy) v_u_13, (ref) v_u_30, (copy) v_u_6, (copy) v_u_24, (copy) v_u_26, (copy) v_u_5
						p32:DisplayNPCText("Let me take a look.", 2)
						if v_u_14 then
							v_u_14:Stop()
						end
						local v33 = v_u_13.PriceCheck
						if v33 then
							v_u_14 = v33
							v33:Play(0.1)
						end
						task.wait(1)
						if v_u_30 then
							local v34 = game.Players.LocalPlayer.Character
							if v34 then
								v34 = v34:FindFirstChildWhichIsA("Tool")
							end
							if v34 then
								local v35 = v_u_6.GetValue(v34)
								if v35 and v35 > 0 then
									local v36 = v_u_6.GetValue(v34) * (1 + (p31:GetAttribute("FriendBoostCount") or 0) * 0.05)
									local v37 = math.floor(v36)
									if v37 >= 1000000 then
										p32:DisplayNPCText("Now that\'s what I\'m talkin\' about!", 2)
									else
										local v38 = v_u_26
										p32:DisplayNPCText(v38[math.random(1, #v38)], 2)
									end
									task.wait(1.5)
									if v_u_30 then
										p32:DisplayNPCText("That right there is worth $" .. v_u_5:FormatFull(v37) .. "!", 2)
										task.wait(2)
									end
								else
									local v39 = v_u_24
									p32:DisplayNPCText(v39[math.random(1, #v39)], 2)
									task.wait(2)
									return
								end
							else
								p32:DisplayNPCText("You ain\'t holdin nothin\' right now.", 2)
								task.wait(2)
								return
							end
						else
							return
						end
					end
				},
				{
					["Text"] = "I want to sell this.",
					["Run"] = function(_, p40)
						-- upvalues: (ref) v_u_30, (copy) v_u_6, (copy) v_u_24, (copy) v_u_7, (ref) v_u_14, (copy) v_u_13, (copy) v_u_23
						p40:DisplayNPCText("Let\'s see what I can do.", 2)
						task.wait(1)
						if v_u_30 then
							local v41 = game.Players.LocalPlayer.Character
							if v41 then
								v41 = v41:FindFirstChildWhichIsA("Tool")
							end
							if v41 then
								local v42 = v_u_6.GetValue(v41)
								if v42 and v42 > 0 then
									if v_u_30 then
										local v43 = v_u_7:InvokeServer("SellSingle")
										if v_u_30 then
											if v43 and v43:match("^Here\'s") then
												if v_u_14 then
													v_u_14:Stop()
												end
												local v44 = v_u_13.Sold
												if v44 then
													v_u_14 = v44
													v44:Play(0.1)
												end
												task.wait(0.32)
												v_u_23()
											end
											p40:DisplayNPCText(v43, 2)
											task.wait(2)
										end
									else
										return
									end
								elseif v_u_30 then
									local v45 = v_u_24
									p40:DisplayNPCText(v45[math.random(1, #v45)], 2)
									task.wait(2)
								end
							elseif v_u_30 then
								p40:DisplayNPCText("You ain\'t holdin nothin\' right now.", 2)
								task.wait(2)
							end
						else
							return
						end
					end
				},
				{
					["Text"] = "I want to sell everything.",
					["Run"] = function(_, p46)
						-- upvalues: (copy) v_u_25, (ref) v_u_30, (copy) v_u_7, (ref) v_u_14, (copy) v_u_13, (copy) v_u_23
						local v47 = v_u_25
						p46:DisplayNPCText(v47[math.random(1, #v47)], 2)
						task.wait(1.5)
						if v_u_30 then
							local v48 = v_u_7:InvokeServer("SellAll")
							if v_u_30 then
								if v48 and v48:match("^Here\'s") then
									if v_u_14 then
										v_u_14:Stop()
									end
									local v49 = v_u_13.Sold
									if v49 then
										v_u_14 = v49
										v49:Play(0.1)
									end
									task.wait(0.32)
									v_u_23()
								end
								p46:DisplayNPCText(v48, 2)
								task.wait(2)
							end
						else
							return
						end
					end
				},
				{
					["Text"] = "Spare some change?",
					["Run"] = function(_, p50)
						-- upvalues: (copy) v_u_8, (ref) v_u_30, (copy) v_u_27, (copy) v_u_29, (copy) v_u_28
						local v51 = v_u_8:InvokeServer()
						if v_u_30 then
							if v51 and v51.state then
								if v51.state == "eligible" then
									local v52 = v_u_27
									p50:DisplayNPCText(v52[math.random(1, #v52)], 2)
									task.wait(2)
									return
								elseif v51.state == "new_player" then
									local v53 = v_u_29
									p50:DisplayNPCText(v53[math.random(1, #v53)], 2)
									task.wait(2)
								elseif v51.state == "cooldown" then
									local v54 = (v51.remaining or 0) / 60
									local v55 = math.ceil(v54)
									local v56 = v55 .. (v55 == 1 and " minute" or " minutes")
									local v57 = v_u_28
									p50:DisplayNPCText(v57[math.random(1, #v57)] .. " " .. v56 .. ".", 2)
									task.wait(2)
								end
							else
								return
							end
						else
							return
						end
					end
				},
				{
					["Text"] = "Nevermind.",
					["Run"] = function(_, p58)
						p58:DisplayNPCText("See ya!", 2)
					end
				}
			}
			local v60 = v4.new
			local v62 = {
				["NPC"] = v9,
				["Name"] = "Steve",
				["NametagBackgroundColor"] = Color3.fromRGB(0, 32, 29),
				["NametagTextColor"] = Color3.fromRGB(211, 255, 217),
				["NametagStrokeColor"] = Color3.fromRGB(0, 40, 44),
				["ProximityPrompt"] = v9:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt"),
				["HighlightColor"] = Color3.fromRGB(7, 255, 160),
				["TypewriterDelay"] = 0.1,
				["RandomLine"] = true,
				["Dialogue"] = {
					{
						["Text"] = "Fuhgettaboutit.",
						["Choices"] = v59
					},
					{
						["Text"] = "What can I do for ya today?",
						["Choices"] = v59
					},
					{
						["Text"] = "Back so soon eh?",
						["Choices"] = v59
					},
					{
						["Text"] = "What can I do for you?",
						["Choices"] = v59
					},
					{
						["Text"] = "Speak up, I ain\'t got all day.",
						["Choices"] = v59
					},
					{
						["Text"] = "What\'s the word, pal?",
						["Choices"] = v59
					},
					{
						["Text"] = "Let\'s make this quick, yeah?",
						["Choices"] = v59
					},
					{
						["Text"] = "Ayy, look who it is!",
						["Choices"] = v59
					},
					{
						["Text"] = "Well well well, whatcha got for me?",
						["Choices"] = v59
					}
				},
				["OnDialogueStart"] = function()
					-- upvalues: (ref) v_u_30, (ref) v_u_14, (copy) v_u_13
					v_u_30 = true
					if v_u_14 then
						v_u_14:Stop()
					end
					local v61 = v_u_13.Greeting
					if v61 then
						v_u_14 = v61
						v61:Play(0.1)
					end
				end,
				["OnDialogueEnd"] = function()
					-- upvalues: (ref) v_u_30
					v_u_30 = false
				end
			}
			v60(v62)
		else
			warn("[SellNPC] Animator not found after timeout")
		end
	else
		warn("[SellNPC] Humanoid not found after timeout")
		return
	end
else
	warn("[SellNPC] Animation instances not found after timeout")
	return
end