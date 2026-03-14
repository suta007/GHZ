local Services = require(script.Parent.Parent.Core.Services)
local State = require(script.Parent.Parent.Core.State)
local Utils = require(script.Parent.Parent.Core.Utilities)
local Automation = require(script.Parent.Automation)

local Remove = {}

function Remove.GetRemoveConfig(Options)
	return {
		mode = "Remove",
		wl = {
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

function Remove.ProcessRemove(isFruit, Options)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end
	local Backpack = Services.LocalPlayer.Backpack
	local Shovel = Backpack:FindFirstChild("Shovel", true) or Services.LocalPlayer.Character:FindFirstChild("Shovel", true)
	if not Shovel then return end
	
	local RemoveList = isFruit and Utils.GetSelectedItems(Options.ddRemoveCrops.Value) or Utils.GetSelectedItems(Options.ddRemovePlants.Value)
	local dynRemoveConfig = isFruit and Remove.GetRemoveConfig(Options) or nil
	local RemovePlantsScaleValue = 0
	local RemovePlantsScale = ""
	if not isFruit then
		RemovePlantsScale = Options.ddRemovePlantsScale.Value
		RemovePlantsScaleValue = tonumber(Options.ipRemovePlantsScale.Value) or 0
	end

	local function CheckPlantsScale(cPlant)
		if RemovePlantsScaleValue == 0 then return true end
		local rawScale = cPlant:GetAttribute("HiddenNumber")
		if not rawScale then return false end
		local scale = tonumber(rawScale)
		if RemovePlantsScale == "Below" then return scale < RemovePlantsScaleValue
		elseif RemovePlantsScale == "Above" then return scale > RemovePlantsScaleValue end
		return false
	end

	local function PerformDig(obj)
		local humanoid = Services.LocalPlayer.Character:FindFirstChild("Humanoid")
		pcall(function() humanoid:UnequipTools() end)
		task.wait()
		humanoid:EquipTool(Shovel)
		task.wait()
		Utils.TweenToTarget(CFrame.new(obj:GetPivot().Position + Vector3.new(3, 0, 4)), 100)
		local gUuid, gindex = Utils.ParseFruitUuid(obj:GetAttribute("Uuid"))
		if isFruit then
			if gindex then Services.RemovePlant:FireServer(gUuid, gindex) else Services.RemovePlant:FireServer(gUuid) end
		else
			Services.RemovePlant:FireServer(gUuid)
		end
		task.wait()
	end

	for _, plant in pairs(ClientPlants:GetChildren()) do
		local enableOpt = isFruit and Options.tgRemoveFruitEnable.Value or Options.tgRemovePlantsEnable.Value
		if not enableOpt then return false end
		local PlantType = plant:GetAttribute("PlantType")
		if PlantType and (table.find(RemoveList, "ALL") or table.find(RemoveList, PlantType)) then
			if isFruit then
				local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
				for _, crop in pairs(CropsTable) do
					if not Options.tgRemoveFruitEnable.Value then return false end
					if crop:IsA("Model") and Automation.CheckHarvestCrops(crop, dynRemoveConfig) then PerformDig(crop) end
				end
			else
				if CheckPlantsScale(plant) then PerformDig(plant) end
			end
		end
	end
	return true
end

function Remove.RemovePlants(Options)
	if not Options.tgRemovePlantsEnable.Value or State.isRemovePlants then return end
	State.isRemovePlants = true
	Remove.ProcessRemove(false, Options)
	State.isRemovePlants = false
end

function Remove.RemoveCrops(Options)
	if not Options.tgRemoveFruitEnable.Value or State.isRemoveCrops then return end
	State.isRemoveCrops = true
	Remove.ProcessRemove(true, Options)
	State.isRemoveCrops = false
end

return Remove
