--!nocheck
local Removal = {}
local _Registry = nil
local State = nil
local Utils = nil
local Network = nil

local CollectionService = game:GetService("CollectionService")

local Options = nil

function Removal.Initialize(reg)
	Registry = reg
	State = reg.State
	Utils = reg.Utils
	Network = reg.Network
end

function Removal.SetOptions(opts)
	Options = opts
end

function Removal.GetConfig()
	return {
		mode = "Removal",
		wl = {
			plants = Utils.GetSelectedItems(Options.ddRemovePlants.Value),
			plantsScaleCondition = Options.ddRemovePlantsScale.Value,
			plantsScaleValue = tonumber(Options.ipRemovePlantsScale.Value) or 0,
			
			crops = Utils.GetSelectedItems(Options.ddRemoveCrops.Value),
			mutants = Utils.GetSelectedItems(Options.ddRemoveMutants.Value),
			ripeness = Utils.GetSelectedItems(Options.ddRemoveRipeness.Value),
			ripenessMulti = tonumber(Options.ipRemoveRipenessMulti.Value) or 0,
			variant = Utils.GetSelectedItems(Options.ddRemoveVariant.Value),
			weightCondition = Options.ddRemoveWeight.Value,
			weightValue = tonumber(Options.ipRemoveWeight.Value) or 0,
			scaleCondition = Options.ddRemoveScale.Value,
			scaleValue = tonumber(Options.ipRemoveScale.Value) or 0,
		},
		bl = {
			crops = Utils.GetSelectedItems(Options.ddRemoveBlackCrops.Value),
			ripeness = Utils.GetSelectedItems(Options.ddRemoveBlackRipeness.Value),
			variant = Utils.GetSelectedItems(Options.ddRemoveBlackVariant.Value),
			mutants = Utils.GetSelectedItems(Options.ddRemoveBlackMutants.Value),
		},
	}
end

function Removal.CheckPlants(plant, config)
	if not table.find(config.wl.plants, "ALL") and not table.find(config.wl.plants, plant.Name) then return false end
	
	local rawScale = plant:GetAttribute("Scale")
	if rawScale and config.wl.plantsScaleValue ~= 0 then
		local scale = tonumber(rawScale)
		if config.wl.plantsScaleCondition == "Below" and scale >= config.wl.plantsScaleValue then return false end
		if config.wl.plantsScaleCondition == "Above" and scale <= config.wl.plantsScaleValue then return false end
	end
	
	return true
end

function Removal.CheckCrops(fruit, config)
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
		if config.wl.scaleValue ~= 0 then
			local rawScale = fruit:GetAttribute("HiddenNumber")
			if not rawScale then return false end
			local scale = tonumber(rawScale)
			if config.wl.scaleCondition == "Below" and scale >= config.wl.scaleValue then return false end
			if config.wl.scaleCondition == "Above" and scale <= config.wl.scaleValue then return false end
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

function Removal.Run()
	if State.HarvestPause or State.isProcessing or not (Options.tgRemovePlantsEnable.Value or Options.tgRemoveFruitEnable.Value) then return end
	
	local config = Removal.GetConfig()
	
	-- 1. Remove Plants
	if Options.tgRemovePlantsEnable.Value then
		for _, anchor in ipairs(CollectionService:GetTagged("PlantAnchor")) do
			local plant = anchor.Parent
			if plant and Removal.CheckPlants(plant, config) then
				Network.Events.RemovePlant:FireServer(plant)
				task.wait(0.1)
			end
		end
	end
	
	-- 2. Remove Fruit
	if Options.tgRemoveFruitEnable.Value then
		for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
			if prompt.Enabled then
				local fruit = prompt.Parent.Parent
				if fruit and Removal.CheckCrops(fruit, config) then
					local gUuid, gindex = Utils.ParseFruitUuid(fruit:GetAttribute("Uuid"))
					local args = {}
					if gindex then
						args = { { { GrowthAnchorIndex = gindex, Uuid = gUuid } } }
					else
						args = { { { Uuid = gUuid } } }
					end
					Network.Events.RemovePlant:FireServer(unpack(args))
					task.wait(0.1)
				end
			end
		end
	end
end

return Removal
