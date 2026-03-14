--!nocheck
local MannyMishap = {}
local Registry = nil
local State = nil
local Utils = nil

local Options = {}

function MannyMishap.Initialize(reg)
	Registry = reg
	State = reg.State
	Utils = reg.Utils
end

function MannyMishap.SetOptions(opts)
	Options = opts
end

function MannyMishap.Run()
	if not Options.tgMannyMishapEnable.Value then return end
	
	local folder = workspace:WaitForChild("MannyMishapCollectibles")
	while State.MannyMishapEnable and Options.tgMannyMishapEnable.Value do
		local fruits = folder:GetChildren()
		if #fruits > 0 then
			for _, model in ipairs(fruits) do
				if not State.MannyMishapEnable or not Options.tgMannyMishapEnable.Value then return end
				local anchor = model:FindFirstChild("Anchor") or model.PrimaryPart

				if anchor and model.Parent then
					Utils.SafeTeleport(anchor.CFrame)
					task.wait(1)
				end
			end
		else
			task.wait(2)
		end
	end
end

function MannyMishap.HandleScoreUpdate(args)
	if tonumber(args[1]) >= 300 then
		State.MannyMishapEnable = false
		State:ResetControlVariable()
		State.actionQueue = table.clone(State.backupQueue)
		Utils.SafeTeleport(State.MySpawnPoint)
		task.wait(1)
	end
end

return MannyMishap
