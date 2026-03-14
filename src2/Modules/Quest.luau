--!nocheck
local Quest = {}
local Options = nil
local Network = nil

function Quest.Initialize(reg)
	local _Registry = reg
	local _State = reg.State
	Network = reg.Network
end

function Quest.SetOptions(opts)
	Options = opts
end

function Quest.AutoClaim(questData)
	if not Options.tgQuestEnable.Value or not questData then return end
	
	-- Daily
	if questData.Daily and questData.Daily.Active then
		for index, q in pairs(questData.Daily.Active) do
			if q.CompletedAt and not q.Claimed then
				Network.Events.ClaimQuest:FireServer("Daily", index)
				task.wait(0.5)
			end
		end
	end

	-- Weekly
	if questData.Weekly and questData.Weekly.Active then
		for index, q in pairs(questData.Weekly.Active) do
			if q.CompletedAt and not q.Claimed then
				Network.Events.ClaimQuest:FireServer("Weekly", index)
				task.wait(0.5)
			end
		end
	end
end

return Quest
