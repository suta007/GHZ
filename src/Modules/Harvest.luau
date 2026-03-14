--!nocheck
local Harvest = {}

local CollectionService = game:GetService("CollectionService")
local State = require(script.Parent.Parent.Core.State)
local Utils = require(script.Parent.Parent.Core.Utils)
local Network = require(script.Parent.Parent.Core.Network)

-- Options should be passed from the UI layer or a central config
local Options = {} 

function Harvest.SetOptions(opts)
	Options = opts
end

local function GetSelectedItems(DropdownValue)
	local Items = {}
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then table.insert(Items, Value) end
		end
	end
	return Items
end

function Harvest.GetConfig()
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

function Harvest.CheckCrops(fruit, config)
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
	if rawWeight then
		local weight = tonumber(rawWeight)
		if config.wl.weightCondition == "Below" and weight >= config.wl.weightValue then return false end
		if config.wl.weightCondition == "Above" and weight <= config.wl.weightValue then return false end
	else
		if config.mode == "Harvest" then return false end
	end

	if not table.find(config.bl.crops, "NONE") and table.find(config.bl.crops, fruitName) then return false end
	if not table.find(config.bl.ripeness, "NONE") and table.find(config.bl.ripeness, fruitRipeness) then return false end
	if not table.find(config.bl.variant, "NONE") and table.find(config.bl.variant, fruitVariant) then return false end

	if not table.find(config.bl.mutants, "NONE") and CropsMutants and CropsMutants ~= "" then
		local CropsMutantsTable = string.split(CropsMutants, ",")
		for _, mutation in ipairs(CropsMutantsTable) do
			if table.find(config.bl.mutants, mutation) then return false end
		end
	end

	return true
end

function Harvest.Scan()
	if not Options.tgHarvestEnable.Value then return end
	table.clear(State.HarVestCropsList)

	local dynHarvestConfig = Harvest.GetConfig()
	for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
		if prompt.Enabled then
			local fruit = prompt.Parent.Parent
			if Harvest.CheckCrops(fruit, dynHarvestConfig) then 
				table.insert(State.HarVestCropsList, fruit) 
			end
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

function Harvest.Run()
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
		local args = (gindex) and {{ {GrowthAnchorIndex = gindex, Uuid = gUuid} }} or {{ {Uuid = gUuid} }}
		
		Network.Events.HarvestFruit:FireServer(unpack(args))
		task.wait(0.1)
	end
	State.isHarvesting = false
end

return Harvest
