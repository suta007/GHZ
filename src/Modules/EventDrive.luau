local EventDrive = {}
local reg

function EventDrive.Initialize(Registry)
	reg = Registry
	for _, obj in ipairs(game:GetDescendants()) do
		EventDrive.hookIncoming(obj)
	end

	game.DescendantAdded:Connect(function(obj)
		EventDrive.hookIncoming(obj)
	end)
end

local function RemoteReplicaSet(args)
	--[[ 	if type(args[2]) ~= "table" then return end
	local fType = args[2][1]
	local fData = args[3]
	if fType == "SeedShop" and not isBuyingSeed then
		table.insert(actionQueue, {
			FuncName = AutoBuySeed,
			args = fData.Items,
		})
	elseif fType == "GearShop" and not isBuyingGear then
		table.insert(actionQueue, {
			FuncName = AutoBuyGear,
			args = fData.Items,
		})
	elseif fType == "Money" then
	end ]]
end

local function RemoteNotification(args)
	local fVar = reg.fVar
	local actionQueue = reg.actionQueue
	if args[1] and type(args[1]) == "string" then
		if string.find(args[1], "inventory is full!") then
			fVar.HarvestPause = true
			table.clear(fVar.HarVestCropsList)
			table.insert(actionQueue, {
				FuncName = reg.Main.AutoSellCrops,
			})
		end
	end
end

function EventDrive.hookIncoming(remote)
	if remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(...)
			local RemoteName = remote.Name
			local args = { ... }
			if RemoteName == "ReplicaSet" then
				RemoteReplicaSet(args)
			elseif RemoteName == "Notification" then
				RemoteNotification(args)
				--[[	elseif RemoteName == "UpdateQuests" then
				table.insert(actionQueue, {
					FuncName = AutoClaimQuest,
					args = args[1],
				})
				 elseif RemoteName == "MannyMishapScoreUpdate" then
				if tonumber(args[1]) >= 300 then
					MannyMishapEnable = false
					ResetControlVariable()
					actionQueue = table.clone(backupQueue)
					SafeTeleport(MySpawnPoint)
					FinishEvent = true
					task.wait(1)
				end ]]
			end
		end)
	end
end

return EventDrive
