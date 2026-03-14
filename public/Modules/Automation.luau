local Services = require(script.Parent.Parent.Core.Services)
local State = require(script.Parent.Parent.Core.State)
local Constants = require(script.Parent.Parent.Core.Constants)
local Utils = require(script.Parent.Parent.Core.Utilities)

local Automation = {}

function Automation.GetHarvestConfig(Options)
	return {
		mode = "Harvest",
		wl = {
			crops = Utils.GetSelectedItems(Options.ddHarvestCrops.Value),
			mutants = Utils.GetSelectedItems(Options.ddHarvestMutants.Value),
			ripeness = Utils.GetSelectedItems(Options.ddRipeness.Value),
			ripenessMulti = tonumber(Options.ipRipenessMulti.Value) or 0,
			variant = Utils.GetSelectedItems(Options.ddVariant.Value),
			weightCondition = Options.ddWeight.Value,
			weightValue = tonumber(Options.ipWeight.Value) or 0,
			scaleCondition = "",
			scaleValue = 0,
		},
		bl = {
			crops = Utils.GetSelectedItems(Options.ddHarvestBlackCrops.Value),
			ripeness = Utils.GetSelectedItems(Options.ddBlackRipeness.Value),
			variant = Utils.GetSelectedItems(Options.ddBlackVariant.Value),
			mutants = Utils.GetSelectedItems(Options.ddHarvestBlackMutants.Value),
		},
	}
end

function Automation.CheckHarvestCrops(fruit, config)
	local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType")) or "Fruit"
	local fruitRipeness = fruit:GetAttribute("RipenessStage")
	local fruitVariant = fruit:GetAttribute("Variant")
	local CropsMutants = fruit:GetAttribute("Mutation")

	if not table.find(config.wl.crops, "ALL") and not table.find(config.wl.crops, fruitName) then return false end
	if fruit:GetAttribute("Favorited") == true then return false end
	if not table.find(config.wl.ripeness, "ALL") and not table.find(config.wl.ripeness, fruitRipeness) then return false end
	local fruitRipenessMulti = fruit:GetAttribute("RipenessMultiplier")
	if config.wl.ripenessMulti ~= 0 and (not fruitRipenessMulti or fruitRipenessMulti < config.wl.ripenessMulti) then return false end
	if not table.find(config.wl.variant, "ALL") and not table.find(config.wl.variant, fruitVariant) then return false end

	if not table.find(config.wl.mutants, "ALL") then
		if not CropsMutants or CropsMutants == "" then return false end
		local CropsMutantsTable = string.split(CropsMutants, ",")
		local isMutantMatch = false
		for _, mutation in ipairs(CropsMutantsTable) do
			if table.find(config.wl.mutants, mutation) then isMutantMatch = true end
		end
		if not isMutantMatch then return false end
	end

	local rawWeight = fruit:GetAttribute("FruitWeight") or fruit:GetAttribute("PlantWeight")
	if not rawWeight then
		if config.mode == "Harvest" then
			return false
		elseif config.mode == "Remove" then
			if config.wl.scaleValue ~= 0 then
				local rawScale = fruit:GetAttribute("HiddenNumber")
				if not rawScale then return false end
				local scale = tonumber(rawScale)
				if config.wl.scaleCondition == "Below" and scale >= config.wl.scaleValue then return false end
				if config.wl.scaleCondition == "Above" and scale <= config.wl.scaleValue then return false end
			end
		end
	else
		if config.wl.weightValue ~= 0 then
			local weight = tonumber(rawWeight)
			if config.wl.weightCondition == "Below" and weight >= config.wl.weightValue then return false end
			if config.wl.weightCondition == "Above" and weight <= config.wl.weightValue then return false end
		end
	end

	if not table.find(config.bl.crops, "NONE") and table.find(config.bl.crops, fruitName) then return false end
	if not table.find(config.bl.ripeness, "NONE") and table.find(config.bl.ripeness, fruitRipeness) then return false end
	if not table.find(config.bl.variant, "NONE") and table.find(config.bl.variant, fruitVariant) then return false end

	if not table.find(config.bl.mutants, "NONE") then
		if CropsMutants and CropsMutants ~= "" then
			local CropsMutantsTable = string.split(CropsMutants, ",")
			local isBlackMutantMatch = false
			for _, mutation in ipairs(CropsMutantsTable) do
				if table.find(config.bl.mutants, mutation) then isBlackMutantMatch = true end
			end
			if isBlackMutantMatch then return false end
		end
	end

	return true
end

function Automation.ScanCrops(Options)
	if not Options.tgHarvestEnable.Value then return end
	table.clear(State.HarVestCropsList)
	local dynHarvestConfig = Automation.GetHarvestConfig(Options)
	for _, prompt in pairs(Services.CollectionService:GetTagged("HarvestPrompt")) do
		if prompt.Enabled then
			local fruit = prompt.Parent.Parent
			if Automation.CheckHarvestCrops(fruit, dynHarvestConfig) then table.insert(State.HarVestCropsList, fruit) end
		end
	end
	if #State.HarVestCropsList > 1 then
		table.sort(State.HarVestCropsList, function(a, b)
			local nameA = a:GetAttribute("PlantType") or (a.Parent and a.Parent:GetAttribute("PlantType")) or "Fruit"
			local nameB = b:GetAttribute("PlantType") or (b.Parent and b.Parent:GetAttribute("PlantType")) or "Fruit"
			return nameA < nameB
		end)
	end
end

function Automation.HarvestCrops(Options)
	if State.HarvestPause or State.isProcessing or State.isHarvesting or not Options.tgHarvestEnable.Value then return end
	if #State.HarVestCropsList > 0 then
		State.isHarvesting = true
		local fruit = table.remove(State.HarVestCropsList, 1)
		local prompt = fruit:FindFirstChild("HarvestPrompt", true)
		if not fruit or not fruit.Parent or not prompt or not prompt.Enabled then
			State.isHarvesting = false
			return
		end
		local targetCFrame = CFrame.new(fruit:GetPivot().Position + Vector3.new(3, 0, 0))
		Utils.TweenToTarget(targetCFrame, 100)
		task.wait(0.1)
		local gUuid, gindex = Utils.ParseFruitUuid(fruit:GetAttribute("Uuid"))
		local args = {}
		if gindex then
			args = { { { GrowthAnchorIndex = gindex, Uuid = gUuid } } }
		else
			args = { { { Uuid = gUuid } } }
		end
		Services.HarvestFruit:FireServer(unpack(args))
		task.wait(0.1)
	end
	State.isHarvesting = false
end

function Automation.AutoSellCrops(Options)
	if not (Options.tgSellCropsEnable.Value or Options.tgNewAutoSell) then return end
	Utils.SafeTeleport(Constants.Pos.Sell)
	task.wait(0.3)
	Services.SellItems:InvokeServer("SellAll")
	task.wait(1)
	Utils.SafeTeleport(State.MySpawnPoint)
	task.wait(0.3)
	State.HarvestPause = false
end

function Automation.AutoBuyItem(ShopType, Items, DropdownValue)
	if not Items then return end
	if ShopType == "SeedShop" then State.isBuyingSeed = true else State.isBuyingGear = true end
	local BuyList = Utils.GetSelectedItems(DropdownValue)
	Utils.SafeTeleport(Constants.Pos[ShopType])
	task.wait(0.5)
	for Name, itemData in pairs(Items) do
		if table.find(BuyList, "ALL") or table.find(BuyList, Name) then
			for i = 1, tonumber(itemData.Amount) do
				Services.PurchaseShopItem:InvokeServer(ShopType, Name)
				task.wait(0.2)
			end
		end
	end
	Utils.SafeTeleport(State.MySpawnPoint)
	task.wait(1)
	if ShopType == "SeedShop" then State.isBuyingSeed = false else State.isBuyingGear = false end
	State.HarvestPause = false
	task.wait(0.2)
end

function Automation.AutoBuySeed(Items, Options)
	if not Options.tgBuySeedEnable.Value then return end
	Automation.AutoBuyItem("SeedShop", Items, Options.ddBuySeeds.Value)
end

function Automation.AutoBuyGear(Items, Options)
	if not Options.tgBuyGearEnable.Value then return end
	Automation.AutoBuyItem("GearShop", Items, Options.ddBuyGear.Value)
end

function Automation.AutoPlantsSeeds(Options)
	if not Options.tgPlantsEnable.Value or State.isPlanting then return end
	local character = Services.LocalPlayer.Character
	local humanoid = character:FindFirstChild("Humanoid")
	pcall(function() humanoid:UnequipTools() end)
	local ddPlantsPos = Options.ddPlantsPos.Value
	local SeedList = Utils.GetSelectedItems(Options.ddPlantsSeeds.Value)
	local Backpack = Services.LocalPlayer.Backpack
	if Backpack then
		for _, item in pairs(Backpack:GetChildren()) do
			if not Options.tgPlantsEnable.Value then break end
			if item:GetAttribute("Type") == "Seeds" and (table.find(SeedList, "ALL") or table.find(SeedList, item:GetAttribute("PlantType"))) then
				State.isPlanting = true
				pcall(function() humanoid:EquipTool(item) end)
				local ItemCount = item:GetAttribute("ItemCount") or 0
				for i = 1, ItemCount do
					if not Options.tgPlantsEnable.Value then State.isPlanting = false break end
					local PlantPos
					if ddPlantsPos == "Player" then
						PlantPos = character:GetPivot()
					elseif ddPlantsPos == "Random" then
						PlantPos = Utils.GetRandomPlantPosition()
						Utils.TweenToTarget(CFrame.new(PlantPos.X + 3, PlantPos.Y, PlantPos.Z), 100)
					end
					Services.PlantSeed:InvokeServer(item:GetAttribute("PlantType"), PlantPos.Position)
					task.wait(0.3)
				end
				pcall(function() humanoid:UnequipTools() end)
			end
		end
		State.isPlanting = false
	end
end

function Automation.AutoClaimQuest(QuestData, Options)
	if not Options.tgQuestEnable.Value or State.isQuestClaiming or not QuestData then return end
	State.isQuestClaiming = true
	local Daily = QuestData.Daily and QuestData.Daily.Active
	if Daily then
		for index, qDaily in pairs(Daily) do
			if qDaily.CompletedAt and not qDaily.Claimed then
				Services.RemoteEvents:WaitForChild("ClaimQuest"):FireServer("Daily", index)
			end
		end
	end
	local Weekly = QuestData.Weekly and QuestData.Weekly.Active
	if Weekly then
		for index, qWeekly in pairs(Weekly) do
			if qWeekly.CompletedAt and not qWeekly.Claimed then
				Services.RemoteEvents:WaitForChild("ClaimQuest"):FireServer("Weekly", index)
			end
		end
	end
	State.isQuestClaiming = false
end

function Automation.ProcessQueue()
	if State.isProcessing then return end
	State.isProcessing = true
	State.HarvestPause = true
	task.wait(0.2)
	while #State.actionQueue > 0 do
		local taskData = table.remove(State.actionQueue, 1)
		pcall(function()
			if taskData.args ~= nil then
				taskData.FuncName(taskData.args, taskData.Options)
			else
				taskData.FuncName(taskData.Options)
			end
		end)
	end
	State.isProcessing = false
	State.HarvestPause = false
	task.wait(0.5)
end

function Automation.RemoteReplicaSet(args, Options)
	if type(args[2]) ~= "table" then return end
	local fType = args[2][1]
	local fData = args[3]
	if fType == "SeedShop" and not State.isBuyingSeed then
		table.insert(State.actionQueue, { FuncName = Automation.AutoBuySeed, args = fData.Items, Options = Options })
	elseif fType == "GearShop" and not State.isBuyingGear then
		table.insert(State.actionQueue, { FuncName = Automation.AutoBuyGear, args = fData.Items, Options = Options })
	end
end

function Automation.RemoteNotification(args, Options)
	if args[1] and type(args[1]) == "string" then
		if string.find(args[1], "inventory is full!") then
			State.HarvestPause = true
			table.clear(State.HarVestCropsList)
			table.insert(State.actionQueue, { FuncName = Automation.AutoSellCrops, Options = Options })
		end
	end
end

return Automation
