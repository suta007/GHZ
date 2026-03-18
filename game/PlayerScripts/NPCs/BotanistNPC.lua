local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("SoundService")
local v3 = game:GetService("Players")
local v4 = require(v1:WaitForChild("Dialogue"):WaitForChild("DialogueController"))
local v_u_5 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("MutationDataDefinitions"))
require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("BotanistDefinitions"))
local v_u_6 = require(v1:WaitForChild("Economy"):WaitForChild("Formatter"):WaitForChild("NumberFormatter"))
local v_u_7 = v3.LocalPlayer
local v8 = workspace:WaitForChild("MapPhysical"):WaitForChild("Botanist"):WaitForChild("Botanist")
local v_u_9 = v1:WaitForChild("RemoteEvents"):WaitForChild("BotanistRequest")
local v_u_10 = v2:WaitForChild("SFX"):WaitForChild("UI"):WaitForChild("Buying")
local v11 = {
	["Idle1"] = v8:WaitForChild("Idle1"),
	["Idle2"] = v8:WaitForChild("Idle2"),
	["Greeting"] = v8:WaitForChild("Greeting"),
	["Fail"] = v8:WaitForChild("Fail"),
	["Success"] = v8:WaitForChild("Success")
}
local v12 = v8:WaitForChild("Humanoid"):WaitForChild("Animator")
local v_u_13 = {
	["Idle1"] = v12:LoadAnimation(v11.Idle1),
	["Idle2"] = v12:LoadAnimation(v11.Idle2),
	["Greeting"] = v12:LoadAnimation(v11.Greeting),
	["Success"] = v12:LoadAnimation(v11.Success),
	["Fail"] = v12:LoadAnimation(v11.Fail)
}
v_u_13.Idle1.Looped = true
v_u_13.Idle2.Looped = true
local v_u_14 = nil
if v_u_14 then
	v_u_14:Stop()
end
local v15 = v_u_13.Idle1
if v15 then
	v_u_14 = v15
	v15:Play(0.1)
end
local v_u_16 = {
	"Hmm... completely standard genome. Sorry.",
	"This is just... normal. Genetically speaking.",
	"No mutations detected. Just a regular specimen.",
	"Wild-type phenotype. Nothing unusual here.",
	"Baseline genetics. No anomalies to report.",
	"Sorry, this one\'s boring. Scientifically boring, I mean.",
	"Standard genetic markers across the board. Sorry!",
	"No interesting variations, unfortunately.",
	"Just a control sample, basically. Sorry!",
	"Textbook specimen. Which is... fine, I guess."
}
local v_u_17 = {
	"Good luck with your crops!",
	"Let me know if you find anything else unusual!",
	"Keep bringing me samples, please!",
	"This was great data. Thank you!",
	"See you soon! Probably!",
	"Happy farming! Or... growing. Whatever you call it.",
	"I\'ll be here if you need more analysis!",
	"Don\'t forget to document your findings!",
	"May your crops have optimal genetic expression!"
}
local v18 = {
	"Oh! Hi! Need a genetic analysis?",
	"Perfect timing, I was just calibrating the sequencer.",
	"Welcome to the lab! Well, field lab. Temporary field lab.",
	"Another sample? Excellent!",
	"Oh hey! Got anything interesting for me today?",
	"Please tell me you found something with unusual phenotypic expression.",
	"Hi! Sorry, I\'m in the middle of - actually, never mind, what do you have??",
	"You again! Did you bring more samples?",
	"Oh good, I need more data points.",
	"Welcome! Fair warning, the PCR machine is being temperamental today."
}
local v_u_19 = {
	"Let me run this through the scanner real quick...",
	"Ooh, let\'s see what we\'ve got here.",
	"Just need to check the chlorophyll markers...",
	"Running a genetic profile now...",
	"Hmm, interesting cell structure...",
	"Give me a sec, extracting DNA samples...",
	"Let\'s get this under the microscope...",
	"Checking for allelic variations...",
	"One moment, scanning for mutations...",
	"Okay okay, let me sequence this..."
}
local v_u_20 = {
	"Okay so, full genetic sequencing is $%s. Sound good?",
	"Analysis fee is $%s. Lab equipment isn\'t cheap, unfortunately.",
	"I\'ll need $%s for the analysis. Gotta pay for reagents somehow!",
	"So the scan costs $%s. I know, I know, but the equipment...",
	"$%s for a complete genetic workup. Fair?",
	"This\'ll run you $%s. Worth it for the data though!",
	"Analysis is $%s. My grant only covers so much...",
	"I can do this for $%s. That work for you?",
	"The going rate is $%s. Covers materials and sequencing time.",
	"$%s and I\'ll tell you everything about this specimen\'s genetics."
}
local v_u_21 = {
	"No worries! Come back when you\'re ready.",
	"That\'s okay! The offer stands whenever.",
	"Totally understand. I\'ll be here!",
	"No problem! Save up and come back later.",
	"Fair enough. Door\'s always open!",
	"All good! Let me know if you change your mind.",
	"Sure thing. Come back anytime!",
	"I get it, funds are tight. See you around!",
	"No pressure! I\'ll be here running samples.",
	"Understood! Good luck out there!"
}
local v_u_22 = {
	"Oh, looks like you\'re a bit short on funds. No worries, come back later!",
	"Hmm, seems like you don\'t have enough right now. That\'s okay!",
	"Ah, you need %s total. Come back when you\'ve got it!",
	"Looks like you\'re short on cash. I\'ll be here when you\'re ready!",
	"Not quite enough there. No rush, take your time!",
	"You\'ll need a bit more money for this. See you soon!"
}
local v_u_23 = {
	"Wait wait wait... you\'ve got a <font color=\"%s\">%s</font> mutation here!",
	"Oh WOW. This has <font color=\"%s\">%s</font> expression!",
	"Okay this is actually really cool - <font color=\"%s\">%s</font> mutation detected!",
	"Holy crap, a <font color=\"%s\">%s</font> mutation?! Amazing!",
	"This is... this is a <font color=\"%s\">%s</font> variant! Publishable!",
	"I need to document this <font color=\"%s\">%s</font> mutation immediately!",
	"The <font color=\"%s\">%s</font> allele frequency here is OFF THE CHARTS!",
	"Fascinating! A <font color=\"%s\">%s</font> mutation! Absolutely fascinating!",
	"I\'ve never seen <font color=\"%s\">%s</font> expression patterns like this!",
	"THIS is why I got into genetics! <font color=\"%s\">%s</font> mutation!",
	"You\'ve got <font color=\"%s\">%s</font> genetic markers here. Incredible!",
	"A <font color=\"%s\">%s</font> phenotype! Do you know how rare this is?!"
}
local v_u_24 = {
	"I\'m Maya! Geneticist and field researcher. Temporary resident.",
	"Maya! Field researcher with IGMA. Stationed here for fieldwork.",
	"Oh, I\'m Maya. Geneticist with IGMA. Flew me out here.",
	"Name\'s Maya! Field geneticist. IGMA sent me here.",
	"I\'m Maya! Botanist, geneticist, chloroplast enthusiast."
}
local v_u_25 = {
	"Studying genetic diversity. Mutation rates here are off the charts.",
	"Cataloguing every mutation I can find. Unprecedented stuff.",
	"The mutations here are unlike anything on record. So here I am!",
	"The soil here produces extraordinary variance. Figuring out why.",
	"Document, analyse, report. The mutations here are wild. Scientifically wild."
}
local v50 = {
	{
		["Text"] = "Who are you?",
		["Run"] = function(_, p26)
			-- upvalues: (copy) v_u_24, (copy) v_u_25
			local v27 = v_u_24
			p26:DisplayNPCText(v27[math.random(1, #v27)], 3.5)
			task.wait(3.5)
			local v28 = v_u_25
			p26:DisplayNPCText(v28[math.random(1, #v28)], 4.5)
			task.wait(4.5)
		end
	},
	{
		["Text"] = "Can you appraise this crop?",
		["Run"] = function(p29, p30)
			-- upvalues: (copy) v_u_7, (copy) v_u_20, (copy) v_u_6, (copy) v_u_21, (copy) v_u_10, (copy) v_u_19, (copy) v_u_9, (copy) v_u_22, (copy) v_u_5, (ref) v_u_14, (copy) v_u_13, (copy) v_u_23, (copy) v_u_16
			local v31 = v_u_7.Character
			if v31 then
				v31 = v31:FindFirstChildOfClass("Tool")
			end
			if v31 and v31:GetAttribute("IsHarvested") then
				local v32 = (v31:GetAttribute("FruitValue") or 0) * 0.325
				local v33 = math.floor(v32)
				local v34 = v_u_20
				p30:DisplayNPCText(string.format(v34[math.random(1, #v34)], v_u_6:FormatFull(v33)))
				task.wait(0.5)
				local v35 = p30:DisplayPlayerChoices(p29, {
					{
						["Text"] = "Go ahead."
					},
					{
						["Text"] = "On second thought, nevermind."
					}
				})
				if v35 and v35.Text ~= "On second thought, nevermind." then
					v_u_10:Play()
					local v36 = v_u_19
					p30:DisplayNPCText(v36[math.random(1, #v36)], 2.6)
					local v37 = v_u_9:InvokeServer()
					if v37 and v37.Status ~= "error" then
						if v37.Status == "no_tool" then
							p30:DisplayNPCText("Hey, where\'d your crop go?", 3)
							task.wait(3)
							return
						elseif v37.Status == "insufficient_funds" then
							local v38 = v_u_22
							p30:DisplayNPCText(string.format(v38[math.random(1, #v38)], v_u_6:FormatFull(v37.Cost)), 3)
							task.wait(3)
							return
						elseif v37.Status == "success" then
							local v39 = v_u_5[v37.Mutation]
							local v40 = v39 and v39.color or "#FFFFFF"
							if v_u_14 then
								v_u_14:Stop()
							end
							local v41 = v_u_13.Success
							if v41 then
								v_u_14 = v41
								v41:Play(0.1)
							end
							v_u_13.Success.Stopped:Once(function()
								-- upvalues: (ref) v_u_14, (ref) v_u_13
								if v_u_14 then
									v_u_14:Stop()
								end
								local v42 = v_u_13.Idle1
								if v42 then
									v_u_14 = v42
									v42:Play(0.1)
								end
							end)
							task.wait(3.39)
							local v43 = v_u_23
							p30:DisplayNPCText(string.format(v43[math.random(1, #v43)], v40, v37.Mutation), 5)
							task.wait(5)
						else
							if v_u_14 then
								v_u_14:Stop()
							end
							local v44 = v_u_13.Fail
							if v44 then
								v_u_14 = v44
								v44:Play(0.1)
							end
							v_u_13.Fail.Stopped:Once(function()
								-- upvalues: (ref) v_u_14, (ref) v_u_13
								if v_u_14 then
									v_u_14:Stop()
								end
								local v45 = v_u_13.Idle1
								if v45 then
									v_u_14 = v45
									v45:Play(0.1)
								end
							end)
							task.wait(3.39)
							local v46 = v_u_16
							p30:DisplayNPCText(v46[math.random(1, #v46)], 2)
							task.wait(2)
						end
					else
						p30:DisplayNPCText("Uh oh. That\'s not good. Something went wrong! Try again later.", 3)
						task.wait(3)
						return
					end
				else
					local v47 = v_u_21
					p30:DisplayNPCText(v47[math.random(1, #v47)], 3)
					return
				end
			else
				p30:DisplayNPCText("Uh you need to be holding a crop for me to appraise!", 2)
				task.wait(2)
				return
			end
		end
	},
	{
		["Text"] = "Nevermind.",
		["Run"] = function(_, p48)
			-- upvalues: (copy) v_u_17
			local v49 = v_u_17
			p48:DisplayNPCText(v49[math.random(1, #v49)], 2)
			task.wait(2)
		end
	}
}
local v51 = v4.new
local v55 = {
	["NPC"] = v8,
	["Name"] = "Maya",
	["NametagBackgroundColor"] = Color3.fromRGB(0, 32, 29),
	["NametagTextColor"] = Color3.fromRGB(211, 255, 217),
	["NametagStrokeColor"] = Color3.fromRGB(0, 40, 44),
	["ProximityPrompt"] = v8:WaitForChild("HumanoidRootPart"):WaitForChild("ProximityPrompt"),
	["HighlightColor"] = Color3.fromRGB(255, 255, 255),
	["TypewriterDelay"] = 0.05,
	["RandomLine"] = true,
	["Dialogue"] = {
		{
			["Text"] = v18[math.random(1, #v18)],
			["Choices"] = v50
		}
	},
	["OnDialogueStart"] = function()
		-- upvalues: (ref) v_u_14, (copy) v_u_13
		if v_u_14 then
			v_u_14:Stop()
		end
		local v52 = v_u_13.Greeting
		if v52 then
			v_u_14 = v52
			v52:Play(0.1)
		end
		v_u_13.Greeting.Stopped:Once(function()
			-- upvalues: (ref) v_u_14, (ref) v_u_13
			if v_u_14 then
				v_u_14:Stop()
			end
			local v53 = v_u_13.Idle2
			if v53 then
				v_u_14 = v53
				v53:Play(0.1)
			end
		end)
	end,
	["OnDialogueEnd"] = function()
		-- upvalues: (ref) v_u_14, (copy) v_u_13
		if v_u_14 then
			v_u_14:Stop()
		end
		local v54 = v_u_13.Idle1
		if v54 then
			v_u_14 = v54
			v54:Play(0.1)
		end
	end
}
v51(v55)