local EventDrive = {}
local reg

function EventDrive.Initialize(Registry)
	reg = Registry

	-- Connect event first to avoid missing any newly added remotes
	game.DescendantAdded:Connect(function(obj)
		EventDrive.hookIncoming(obj)
	end)

	-- Hook existing remotes
	for _, obj in ipairs(game:GetDescendants()) do
		EventDrive.hookIncoming(obj)
	end
end

local function RemoteReplicaSet(args)
	local fVar = reg.fVar

	local actionQueue = fVar.actionQueue
	local AutoBuySeed = reg.Shop.AutoBuySeed
	local AutoBuyGear = reg.Shop.AutoBuyGear

	if type(args[2]) ~= "table" then return end
	local fType = args[2][1]
	local fData = args[3]
	if fType == "SeedShop" and not fVar.isBuyingSeed then
		print("In seed shop")
		table.insert(actionQueue, {
			FuncName = AutoBuySeed,
			args = fData.Items,
		})
	elseif fType == "GearShop" and not fVar.isBuyingGear then
		print("in gear shop")
		table.insert(actionQueue, {
			FuncName = AutoBuyGear,
			args = fData.Items,
		})
	elseif fType == "Money" then
	end
end

local function RemoteNotification(args)
	local fVar = reg.fVar
	local actionQueue = fVar.actionQueue -- Fixed: actionQueue is in fVar
	if args[1] and type(args[1]) == "string" then
		local message = string.lower(args[1])
		if string.find(message, "inventory is full!") then
			fVar.HarvestPause = true
			if reg.HarVestCropsList then
				table.clear(reg.HarVestCropsList) -- Fixed: HarVestCropsList is in reg
			end
			table.insert(actionQueue, {
				FuncName = reg.Main.AutoSellCrops,
			})
		end
	end
end

local function AutoClaimQuest(QuestData)
	local fVar = reg.fVar
	if fVar.isQuestClaiming or not QuestData then return end

	fVar.isQuestClaiming = true
	local Daily = QuestData.Daily.Active
	for index, qDaily in pairs(Daily) do
		if qDaily.CompletedAt and not qDaily.Claimed then game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClaimQuest"):FireServer("Daily", index) end
	end

	local Weekly = QuestData.Weekly.Active
	for index, qWeekly in pairs(Weekly) do
		if qWeekly.CompletedAt and not qWeekly.Claimed then game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClaimQuest"):FireServer("Weekly", index) end
	end
	fVar.isQuestClaiming = false
end

function EventDrive.hookIncoming(remote)
	local actionQueue = reg.fVar.actionQueue
	if remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(...)
			local RemoteName = remote.Name
			local args = { ... }
			if RemoteName == "ReplicaSet" then
				RemoteReplicaSet(args)
			elseif RemoteName == "Notification" then
				RemoteNotification(args)
			elseif RemoteName == "UpdateQuests" then
				table.insert(actionQueue, {
					FuncName = AutoClaimQuest,
					args = args[1],
				})
				--[[ elseif RemoteName == "MannyMishapScoreUpdate" then
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
