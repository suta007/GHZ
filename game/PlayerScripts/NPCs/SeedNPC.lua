local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1:WaitForChild("Dialogue"):WaitForChild("DialogueController"))
require(v1:WaitForChild("Economy"):WaitForChild("Formatter"):WaitForChild("NumberFormatter"))
local v_u_3 = require(v1:WaitForChild("Shop"):WaitForChild("SeedShopController"))
local v_u_4 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("SeedShop")
local v5 = workspace:WaitForChild("MapPhysical"):WaitForChild("Shops"):WaitForChild("Seed Shop"):WaitForChild("SeedNPC")
local v6 = {
	["Idle"] = v5:WaitForChild("Idle", 15),
	["Greeting"] = v5:WaitForChild("Greeting", 15),
	["Goodbye"] = v5:WaitForChild("Goodbye", 15)
}
if v6.Idle and (v6.Greeting and v6.Goodbye) then
	local v7 = v5:WaitForChild("Humanoid", 15)
	if v7 then
		local v8 = v7:WaitForChild("Animator", 15)
		if v8 then
			local v_u_9 = {
				["Idle"] = v8:LoadAnimation(v6.Idle),
				["Greeting"] = v8:LoadAnimation(v6.Greeting),
				["Goodbye"] = v8:LoadAnimation(v6.Goodbye)
			}
			v_u_9.Greeting.Looped = false
			v_u_9.Idle.Looped = true
			v_u_9.Goodbye.Looped = false
			local v_u_10 = nil
			if v_u_10 then
				v_u_10:Stop()
			end
			local v11 = v_u_9.Idle
			if v11 then
				v_u_10 = v11
				v11:Play(0.1)
			end
			local v_u_14 = v2.new({
				["NPC"] = v5,
				["Name"] = "Bill",
				["NametagBackgroundColor"] = Color3.fromRGB(0, 11, 41),
				["NametagTextColor"] = Color3.fromRGB(226, 235, 255),
				["NametagStrokeColor"] = Color3.fromRGB(0, 12, 44),
				["ProximityPrompt"] = v5:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt"),
				["HighlightColor"] = Color3.fromRGB(75, 132, 255),
				["DialogueDisplayTime"] = 1,
				["DisplayTimePerCharacter"] = 0,
				["RandomLine"] = true,
				["Dialogue"] = {
					"More seeds, partner?",
					"Here\'s what I got.",
					"Howdy!",
					"Ooh, did admin restock?",
					"Seeds! I got \'em!",
					"Oh right, seeds. Yeah, got those.",
					"Where do seeds even come from? ...Anyway.",
					"Nice day for plantin\'!",
					"I forgot what half of these do!",
					"Wait, what\'d you want again?"
				},
				["OnDialogueStart"] = function()
					-- upvalues: (ref) v_u_10, (copy) v_u_9
					if v_u_10 then
						v_u_10:Stop()
					end
					local v12 = v_u_9.Greeting
					if v12 then
						v_u_10 = v12
						v12:Play(0.1)
					end
					v_u_9.Greeting.Stopped:Connect(function()
						-- upvalues: (ref) v_u_10, (ref) v_u_9
						if v_u_10 then
							v_u_10:Stop()
						end
						local v13 = v_u_9.Idle
						if v13 then
							v_u_10 = v13
							v13:Play(0.1)
						end
					end)
				end,
				["OnDialogueEnd"] = function()
					-- upvalues: (copy) v_u_3, (copy) v_u_4
					v_u_3.Open()
					while v_u_4.Enabled do
						task.wait()
					end
					task.wait(0.5)
				end
			})
			local v_u_15 = {
				"Y\'all come back now!",
				"Back home in Kansas we\'d plant these all the time. Or was it corn?",
				"Sure is a nice day for plantin\', ain\'t it?",
				"Happy planting, partner!",
				"See ya around!",
				"Come back anytime!",
				"Good luck with those seeds, partner!",
				"Bye! ...Wait, did you buy anything?",
				"Appreciate the business, partner!",
				"Don\'t plant them upside down! ...Can you do that?",
				"If you need me I\'ll be right here. Not moving. At all.",
				"I\'m gonna reorganize these seeds. Or not. We\'ll see.",
				"Same spot as always. ...I think.",
				"See you tomorrow?"
			}
			v_u_4:GetPropertyChangedSignal("Enabled"):Connect(function()
				-- upvalues: (copy) v_u_4, (copy) v_u_15, (copy) v_u_14, (ref) v_u_10, (copy) v_u_9
				if not v_u_4.Enabled then
					local v16 = v_u_15[math.random(1, #v_u_15)]
					v_u_14:DisplayNPCText(v16, (utf8.len(v16) or #v16) * v_u_14.TypewriterDelay + 2)
					if v_u_10 then
						v_u_10:Stop()
					end
					local v17 = v_u_9.Goodbye
					if v17 then
						v_u_10 = v17
						v17:Play(0.1)
					end
					v_u_9.Goodbye.Stopped:Connect(function()
						-- upvalues: (ref) v_u_10, (ref) v_u_9
						if v_u_10 then
							v_u_10:Stop()
						end
						local v18 = v_u_9.Idle
						if v18 then
							v_u_10 = v18
							v18:Play(0.1)
						end
					end)
				end
			end)
		else
			warn("[SeedNPC] Animator not found after timeout")
		end
	else
		warn("[SeedNPC] Humanoid not found after timeout")
		return
	end
else
	warn("[SeedNPC] Animation instances not found after timeout")
	return
end