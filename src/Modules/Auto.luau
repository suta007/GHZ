local Auto = {}
local reg

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local ClaimQuest = RemoteEvents:WaitForChild("ClaimQuest") :: RemoteEvent
local RemovePlant = RemoteEvents:WaitForChild("RemovePlant") :: RemoteEvent

function Auto.Initialize(registry)
	reg = registry
end

local function GetRemoveConfig()
	local Options = reg.Options
	local Utils = reg.Utils
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

function Auto.AutoClaimQuest(QuestData)
	local Options = reg.Options
	local fVar = reg.fVar
	if not Options.tgQuestEnable.Value or fVar.isQuestClaiming or not QuestData then return end

	fVar.isQuestClaiming = true
	local Daily = QuestData.Daily.Active
	for index, qDaily in pairs(Daily) do
		if qDaily.CompletedAt and not qDaily.Claimed then
			ClaimQuest:FireServer("Daily", index)
		end
	end

	local Weekly = QuestData.Weekly.Active
	for index, qWeekly in pairs(Weekly) do
		if qWeekly.CompletedAt and not qWeekly.Claimed then
			ClaimQuest:FireServer("Weekly", index)
		end
	end
	fVar.isQuestClaiming = false
end

local function ProcessRemove(isFruit)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	local Options = reg.Options
	local Utils = reg.Utils

	local Main = reg.Main

	local Backpack = LocalPlayer.Backpack
	local Shovel = Backpack:FindFirstChild("Shovel", true) or Character:FindFirstChild("Shovel", true)
	if not Shovel then return end

	local RemoveList = isFruit and Utils.GetSelectedItems(Options.ddRemoveCrops.Value) or Utils.GetSelectedItems(Options.ddRemovePlants.Value)
	local dynRemoveConfig = isFruit and GetRemoveConfig() or nil

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
		if RemovePlantsScale == "Below" then
			return scale < RemovePlantsScaleValue
		elseif RemovePlantsScale == "Above" then
			return scale > RemovePlantsScaleValue
		end
		return false
	end

	local function PerformDig(obj)
		Utils.UnequipTools()
		task.wait()
		Utils.EquipItem(Shovel)
		task.wait()
		local targetCFrame = CFrame.new(obj:GetPivot().Position + Vector3.new(3, 0, 4))
		Utils.TweenToTarget(targetCFrame, 100)

		local gUuid, gindex = Utils.ParseFruitUuid(obj:GetAttribute("Uuid"))
		if isFruit then
			if gindex then
				RemovePlant:FireServer(gUuid, gindex)
			else
				RemovePlant:FireServer(gUuid)
			end
		else
			RemovePlant:FireServer(gUuid)
		end
		task.wait()
	end

	for _, plant in pairs(ClientPlants:GetChildren()) do
		local enableOpt = isFruit and Options.tgRemoveFruitEnable.Value or Options.tgRemovePlantsEnable.Value
		if not enableOpt then break end

		local PlantType = plant:GetAttribute("PlantType")
		if PlantType and (table.find(RemoveList, "ALL") or table.find(RemoveList, PlantType)) then
			if isFruit then
				local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
				for _, crop in pairs(CropsTable) do
					if not Options.tgRemoveFruitEnable.Value then break end
					if crop:IsA("Model") and Main.CheckCrops(crop, dynRemoveConfig) then
						PerformDig(crop)
					end
				end
			else
				if CheckPlantsScale(plant) then
					PerformDig(plant)
				end
			end
		end
	end
end

function Auto.RemovePlants()
	local Options = reg.Options
	local fVar = reg.fVar
	if not Options.tgRemovePlantsEnable.Value or fVar.isRemovePlants then return end
	fVar.isRemovePlants = true
	ProcessRemove(false)
	fVar.isRemovePlants = false
end

function Auto.RemoveCrops()
	local Options = reg.Options
	local fVar = reg.fVar
	if not Options.tgRemoveFruitEnable.Value or fVar.isRemoveCrops then return end
	fVar.isRemoveCrops = true
	ProcessRemove(true)
	fVar.isRemoveCrops = false
end

return Auto
