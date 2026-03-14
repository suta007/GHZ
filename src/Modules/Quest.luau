--!nocheck
local Quest = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

local State = require(script.Parent.Parent.Core.State)

local Options = {}

function Quest.SetOptions(opts)
	Options = opts
end

function Quest.AutoClaim(QuestData)
	if not Options.tgQuestEnable.Value or State.isQuestClaiming or not QuestData then return end

	State.isQuestClaiming = true
	
	local function claim(tab, name)
		local active = tab.Active
		if active then
			for index, q in pairs(active) do
				if q.CompletedAt and not q.Claimed then 
					RemoteEvents:WaitForChild("ClaimQuest"):FireServer(name, index) 
				end
			end
		end
	end

	claim(QuestData.Daily, "Daily")
	claim(QuestData.Weekly, "Weekly")
	
	State.isQuestClaiming = false
end

return Quest
