local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1:WaitForChild("Dialogue"):WaitForChild("DialogueController"))
require(v1:WaitForChild("Economy"):WaitForChild("Formatter"):WaitForChild("NumberFormatter"))
local v_u_3 = require(v1:WaitForChild("Shop"):WaitForChild("GearShopController"))
local v_u_4 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GearShop")
local v5 = workspace:WaitForChild("MapPhysical"):WaitForChild("Shops"):WaitForChild("Gear Shop"):WaitForChild("GearNPC")
local v6 = v5:WaitForChild("Model", 15)
if v6 then
	v6 = v6:WaitForChild("Parts", 15)
end
if v6 then
	v6 = v6:WaitForChild("Flames", 15)
end
if v6 then
	local v_u_7 = v6:GetDescendants()
	local v8 = {
		["Idle"] = v5:WaitForChild("Idle", 15),
		["Greeting"] = v5:WaitForChild("Greeting", 15),
		["ShopOpenIdle"] = v5:WaitForChild("ShopOpenIdle", 15),
		["Goodbye"] = v5:WaitForChild("Goodbye", 15)
	}
	if v8.Idle and (v8.Greeting and (v8.ShopOpenIdle and v8.Goodbye)) then
		local v9 = v5:WaitForChild("Humanoid", 15)
		if v9 then
			local v10 = v9:WaitForChild("Animator", 15)
			if v10 then
				local v_u_11 = {
					["Idle"] = v10:LoadAnimation(v8.Idle),
					["Greeting"] = v10:LoadAnimation(v8.Greeting),
					["ShopOpenIdle"] = v10:LoadAnimation(v8.ShopOpenIdle),
					["Goodbye"] = v10:LoadAnimation(v8.Goodbye)
				}
				v_u_11.Idle.Looped = true
				local v_u_12 = nil
				if v_u_12 then
					v_u_12:Stop()
				end
				local v13 = v_u_11.Idle
				if v13 then
					v_u_12 = v13
					v13:Play(0.1)
				end
				local function v_u_16(p14)
					-- upvalues: (copy) v_u_7
					for _, v15 in pairs(v_u_7) do
						if v15:IsA("ParticleEmitter") then
							v15.Enabled = p14
						end
					end
				end
				local v_u_19 = v2.new({
					["NPC"] = v5,
					["Name"] = "Molly",
					["NametagBackgroundColor"] = Color3.fromRGB(50, 9, 0),
					["NametagTextColor"] = Color3.fromRGB(255, 215, 180),
					["NametagStrokeColor"] = Color3.fromRGB(58, 18, 0),
					["ProximityPrompt"] = v5:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt"),
					["HighlightColor"] = Color3.fromRGB(255, 163, 58),
					["RandomLine"] = true,
					["DialogueDisplayTime"] = 1,
					["DisplayTimePerCharacter"] = 0,
					["Dialogue"] = {
						"Hey! Need some gear?",
						"Hiya! What can I help with?",
						"Hey! Need equipment?",
						"Perfect timing, new stock just came in!",
						"Darn.. someone stole a screwdriver last night..",
						"Let me show you what I\'ve got!",
						"Everything\'s freshly tuned up!",
						"Ready to check out some gear?",
						"Got some cool stuff today!",
						"Looking for anything specific?",
						"Let\'s get you geared up!",
						"Take a look around!",
						"Just finished some modifications!"
					},
					["OnDialogueStart"] = function()
						-- upvalues: (ref) v_u_12, (copy) v_u_11, (copy) v_u_16
						if v_u_12 then
							v_u_12:Stop()
						end
						local v17 = v_u_11.Greeting
						if v17 then
							v_u_12 = v17
							v17:Play(0.1)
						end
						v_u_16(false)
					end,
					["OnDialogueEnd"] = function()
						-- upvalues: (ref) v_u_12, (copy) v_u_11, (copy) v_u_3, (copy) v_u_4
						if v_u_12 then
							v_u_12:Stop()
						end
						local v18 = v_u_11.ShopOpenIdle
						if v18 then
							v_u_12 = v18
							v18:Play(0.1)
						end
						v_u_3.Open()
						while v_u_4.Enabled do
							task.wait()
						end
						task.wait(0.5)
					end
				})
				local v_u_20 = {
					"See ya! Take care of that gear!",
					"Bye! Come back if you need anything!",
					"Later! Good luck out there!",
					"See you around! Stay safe!",
					"Bye bye! Let me know how it works!",
					"Catch ya later! Have fun!",
					"Take care! Don\'t break it, okay?",
					"See ya! Enjoy!",
					"Bye! If anything breaks, bring it back!",
					"Later! Happy adventuring!",
					"See you soon! Be careful out there!",
					"Bye! Come back anytime!"
				}
				v_u_4:GetPropertyChangedSignal("Enabled"):Connect(function()
					-- upvalues: (copy) v_u_4, (copy) v_u_20, (copy) v_u_19, (ref) v_u_12, (copy) v_u_11, (copy) v_u_16
					if not v_u_4.Enabled then
						local v21 = v_u_20[math.random(1, #v_u_20)]
						v_u_19:DisplayNPCText(v21, (utf8.len(v21) or #v21) * v_u_19.TypewriterDelay + 2)
						if v_u_12 then
							v_u_12:Stop()
						end
						local v22 = v_u_11.Goodbye
						if v22 then
							v_u_12 = v22
							v22:Play(0.1)
						end
						v_u_11.Goodbye.Stopped:Connect(function()
							-- upvalues: (ref) v_u_16, (ref) v_u_12, (ref) v_u_11
							v_u_16(true)
							if v_u_12 then
								v_u_12:Stop()
							end
							local v23 = v_u_11.Idle
							if v23 then
								v_u_12 = v23
								v23:Play(0.1)
							end
						end)
					end
				end)
			else
				warn("[GearNPC] Animator not found after timeout")
			end
		else
			warn("[GearNPC] Humanoid not found after timeout")
			return
		end
	else
		warn("[GearNPC] Animation instances not found after timeout")
		return
	end
else
	warn("[GearNPC] Flames VFX not found after timeout")
	return
end