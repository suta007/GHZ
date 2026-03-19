local Main = {}
local reg

local fVar
local GetSelectedItems
local TweenToTarget
local SafeTeleport
local HarVestCropsList = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local PlantSeed = RemoteEvents:WaitForChild("PlantSeed") :: RemoteFunction
local HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit") :: RemoteEvent
local SellItems = RemoteEvents:WaitForChild("SellItems") :: RemoteFunction

local CollectionService = game:GetService("CollectionService")

function Main.Initialize(Registry)
	reg = Registry
	fVar = Registry.fVar
	GetSelectedItems = Registry.Utils.GetSelectedItems
	GetRandomPlantPosition = Registry.Utils.GetRandomPlantPosition
	TweenToTarget = Registry.Utils.TweenToTarget
	SafeTeleport = Registry.Utils.SafeTeleport

	reg.HarVestCropsList = HarVestCropsList
end

function Main.AutoPlantsSeeds()
	local Options = reg.Options
	if not Options.tgPlantsEnable.Value or fVar.isPlanting or fVar.IsBuying() then return end

	pcall(function()
		Humanoid:UnequipTools()
	end)
	local ddPlantsPos = Options.ddPlantsPos.Value
	local PlantPos
	local HerePos = nil
	local Backpack = LocalPlayer.Backpack
	local SeedList = GetSelectedItems(Options.ddPlantsSeeds.Value)

	if Backpack then
		for _index, item in pairs(Backpack:GetChildren()) do
			if not Options.tgPlantsEnable.Value or fVar.IsBuying() then break end
			if item:GetAttribute("Type") == "Seeds" and (table.find(SeedList, "ALL") or table.find(SeedList, item:GetAttribute("PlantType"))) then
				fVar.isPlanting = true

				local ItemCount = item:GetAttribute("ItemCount") or 0
				for i = 1, ItemCount do
					if not Options.tgPlantsEnable.Value or fVar.IsBuying() then
						fVar.isPlanting = false
						break
					end

					if ddPlantsPos == "Player" then
						PlantPos = Character:GetPivot()
					else
						if ddPlantsPos == "Random" then
							PlantPos = GetRandomPlantPosition()
						elseif ddPlantsPos == "Here" then
							if not HerePos then HerePos = Character:GetPivot() end
							PlantPos = HerePos
						end
						TweenToTarget(CFrame.new(PlantPos.X + 3, PlantPos.Y, PlantPos.Z), 100)
					end
					pcall(function()
						Humanoid:EquipTool(item)
					end)
					local args = {
						item:GetAttribute("PlantType"),
						PlantPos.Position,
					}
					PlantSeed:InvokeServer(unpack(args))
					task.wait(0.3)
					pcall(function()
						Humanoid:UnequipTools()
					end)
				end
				pcall(function()
					Humanoid:UnequipTools()
				end)
			end
		end
		fVar.isPlanting = false
	end
end

local function GetHarvestConfig()
	local Options = reg.Options
	return {
		mode = "Harvest",
		wl = {
			crops = GetSelectedItems(Options.ddHarvestCrops.Value),
			mutants = GetSelectedItems(Options.ddHarvestMutants.Value),
			ripeness = GetSelectedItems(Options.ddRipeness.Value),
			ripenessMulti = tonumber(Options.ipRipenessMulti.Value) or 0,
			variant = GetSelectedItems(Options.ddVariant.Value),
			weightCondition = Options.ddWeight.Value,
			weightValue = tonumber(Options.ipWeight.Value) or 0,
			scaleCondition = "",
			scaleValue = 0,
		},
		bl = {
			crops = GetSelectedItems(Options.ddHarvestBlackCrops.Value),
			ripeness = GetSelectedItems(Options.ddBlackRipeness.Value),
			variant = GetSelectedItems(Options.ddBlackVariant.Value),
			mutants = GetSelectedItems(Options.ddHarvestBlackMutants.Value),
		},
	}
end

function Main.CheckCrops(fruit, config)
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

function Main.ScanCrops()
	local Options = reg.Options
	if not Options.tgHarvestEnable.Value then return end
	table.clear(HarVestCropsList)

	-- 1. ค้นหาผ่าน Tag ที่ปุ่มกด
	local dynHarvestConfig = GetHarvestConfig()
	for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
		if prompt.Enabled then
			local fruit = prompt.Parent.Parent -- ย้อนกลับไปหา Model หลัก

			if Main.CheckCrops(fruit, dynHarvestConfig) then table.insert(HarVestCropsList, fruit) end
		end
	end

	-- 2. เรียงลำดับตามชื่อผลไม้ (PlantType) เพื่อให้เก็บเป็นโซนๆ ไป
	if #HarVestCropsList > 1 then
		table.sort(HarVestCropsList, function(a, b)
			local nameA = a:GetAttribute("PlantType") or (a.Parent and a.Parent:GetAttribute("PlantType")) or "Fruit"
			local nameB = b:GetAttribute("PlantType") or (b.Parent and b.Parent:GetAttribute("PlantType")) or "Fruit"
			return nameA < nameB
		end)
	end
	reg.HarVestCropsList = HarVestCropsList
end
function Main.ScanCrops2()
	local Options = reg.Options
	if fVar.isPlanting or fVar.IsBuying() or fVar.isProcessing or fVar.HarvestPause then return end
	if fVar.isHarvesting or not Options.tgHarvestEnable.Value then return end

	table.clear(HarVestCropsList)

	local TargetPos = reg.Utils.GetCenterPlots()
	table.insert(TargetPos, reg.MySpawnPoint)
	for _, cpos in TargetPos do
		if fVar.isPlanting or fVar.IsBuying() or fVar.isProcessing or fVar.HarvestPause then return end
		SafeTeleport(cpos)
		task.wait(3)
		local ClientPlants = workspace:FindFirstChild("ClientPlants")
		if ClientPlants then
			for _, plant in ClientPlants:GetChildren() do
				if fVar.isPlanting or fVar.IsBuying() or fVar.isProcessing or fVar.HarvestPause then return end
				local dynHarvestConfig = GetHarvestConfig()
				local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
				for _, fruit in ipairs(CropsTable) do
					local FullyGrown = fruit:GetAttribute("FullyGrown")
					if FullyGrown then
						if Main.CheckCrops(fruit, dynHarvestConfig) then table.insert(HarVestCropsList, fruit) end
					end
				end
			end
		end
	end
end

function Main.HarvestCrops()
	local Options = reg.Options
	local fVar = reg.fVar
	local ParseFruitUuid = reg.Utils.ParseFruitUuid
	local TweenToTarget = reg.Utils.TweenToTarget
	HarVestCropsList = reg.HarVestCropsList
	if fVar.isPlanting or fVar.IsBuying() then return end
	if fVar.HarvestPause or fVar.isProcessing or fVar.isHarvesting or not Options.tgHarvestEnable.Value then return end

	if #HarVestCropsList > 0 then
		fVar.isHarvesting = true
		local fruit = table.remove(HarVestCropsList, 1)

		local prompt = fruit:FindFirstChild("HarvestPrompt", true)
		if not fruit or not fruit.Parent or not prompt or not prompt.Enabled then
			fVar.isHarvesting = false
			return
		end

		local targetCFrame = CFrame.new(fruit:GetPivot().Position + Vector3.new(3, 0, 0))

		TweenToTarget(targetCFrame, 100)
		task.wait(0.1)
		local gUuid, gindex = ParseFruitUuid(fruit:GetAttribute("Uuid"))
		local args = {}
		if gindex then
			args = {
				{
					{
						GrowthAnchorIndex = gindex,
						Uuid = gUuid,
					},
				},
			}
		else
			args = {
				{
					{
						Uuid = gUuid,
					},
				},
			}
		end
		pcall(function()
			HarvestFruit:FireServer(unpack(args))
		end)
		task.wait(0.1)
	end
	fVar.isHarvesting = false
end

local function GetSellConfig()
	local Options = reg.Options
	return {
		mode = "Sell",
		wl = {
			crops = GetSelectedItems(Options.ddSellCrops.Value),
			ripeness = GetSelectedItems(Options.ddSellRipeness.Value),
			mutants = GetSelectedItems(Options.ddSellMutants.Value),
			weightCondition = Options.ddSellWeight.Value,
			weightValue = tonumber(Options.ipSellWeight.Value) or 0,
			valueCondition = Options.ddSellValue.Value,
			valueValue = tonumber(Options.ipSellValue.Value) or 0,
		},
		bl = {
			crops = GetSelectedItems(Options.ddSellBlackCrops.Value),
			ripeness = GetSelectedItems(Options.ddSellBlackRipeness.Value),
			mutants = GetSelectedItems(Options.ddSellBlackMutants.Value),
		},
	}
end

function Main.CheckSellItem(item, config)
	local itemName = item:GetAttribute("BaseName") or item.Name
	local itemRipeness = item:GetAttribute("RipenessStage")
	local itemMutants = item:GetAttribute("Mutation")
	local itemWeight = tonumber(item:GetAttribute("FruitWeight")) or 0
	local itemValue = tonumber(item:GetAttribute("FruitValue")) or 0

	-- 1. Crops (Names)
	if not table.find(config.bl.crops, "NONE") and table.find(config.bl.crops, itemName) then return false end

	-- 2. Ripeness
	if not table.find(config.wl.ripeness, "ALL") and not table.find(config.wl.ripeness, itemRipeness) then return false end
	if not table.find(config.bl.ripeness, "NONE") and table.find(config.bl.ripeness, itemRipeness) then return false end

	-- 3. Mutants
	if not table.find(config.wl.mutants, "ALL") then
		if not itemMutants or itemMutants == "" then return false end
		local mutantsTable = string.split(itemMutants, ",")
		local isMutantMatch = false
		for _, mutation in ipairs(mutantsTable) do
			if table.find(config.wl.mutants, mutation) then isMutantMatch = true end
		end
		if not isMutantMatch then return false end
	end
	if not table.find(config.bl.mutants, "NONE") then
		if itemMutants and itemMutants ~= "" then
			local mutantsTable = string.split(itemMutants, ",")
			local isBlackMutantMatch = false
			for _, mutation in ipairs(mutantsTable) do
				if table.find(config.bl.mutants, mutation) then isBlackMutantMatch = true end
			end
			if isBlackMutantMatch then return false end
		end
	end

	-- 4. Weight
	if config.wl.weightValue ~= 0 then
		if config.wl.weightCondition == "Below" and itemWeight >= config.wl.weightValue then return false end
		if config.wl.weightCondition == "Above" and itemWeight <= config.wl.weightValue then return false end
	end

	-- 5. Value (Price)
	if config.wl.valueValue ~= 0 then
		if config.wl.valueCondition == "Below" and itemValue >= config.wl.valueValue then return false end
		if config.wl.valueCondition == "Above" and itemValue <= config.wl.valueValue then return false end
	end

	return true
end

function Main.AutoSellCrops()
	local Options = reg.Options
	local EquipItem = reg.Utils.EquipItem
	local UnequipTools = reg.Utils.UnequipTools
	if not Options.tgSellCropsEnable.Value or fVar.isSelling then return end

	local Backpack = LocalPlayer.Backpack
	if not Backpack then return end

	local itemsToSell = {}
	local config = GetSellConfig()

	-- 1. Scan for items first to avoid empty teleports
	if not Options.tgSellAllCropsEnable.Value then
		for _, item in ipairs(Backpack:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsHarvested") then
				if Main.CheckSellItem(item, config) then table.insert(itemsToSell, item) end
			end
		end
	else
		for _, item in ipairs(Backpack:GetChildren()) do
			if item:IsA("Tool") and item:GetAttribute("IsHarvested") then
				table.insert(itemsToSell, item)
				break -- Found at least one item
			end
		end
	end

	-- 2. Process selling if items were found
	if #itemsToSell > 0 then
		fVar.isSelling = true
		fVar.HarvestPause = true
		UnequipTools() -- Call once before teleporting

		SafeTeleport(fVar.Pos.Sell)
		task.wait(0.5)

		if not Options.tgSellAllCropsEnable.Value then
			-- Sell filtered items individually
			for _, item in ipairs(itemsToSell) do
				if item and item.Parent == Backpack then
					EquipItem(item)
					task.wait(0.1)
					SellItems:InvokeServer("SellSingle")
					task.wait(0.1)
				end
			end
		else
			-- Sell everything at once
			SellItems:InvokeServer("SellAll")
		end

		-- Teleport back
		task.wait(2)
		SafeTeleport(reg.MySpawnPoint)
		task.wait(0.3)
		fVar.isSelling = false
		fVar.HarvestPause = false
	end
end

return Main
