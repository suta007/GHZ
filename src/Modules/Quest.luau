--!nocheck
local Quest = {}
local Registry = nil
local State = nil

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Quest.Initialize(reg)
	Registry = reg
	State = reg.State
end

function Quest.SetOptions(opts)
	-- No options for quest yet
end

function Quest.AutoClaim(questData)
	if not questData then return end
	for uuid, data in pairs(questData) do
		if data.Status == "Claimable" then
			Registry.Network.Events.ClaimQuest:FireServer(uuid)
			task.wait(0.5)
		end
	end
end

return Quest
