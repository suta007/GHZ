local Auto = {}
local reg
local GetSelectedItems

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local ClaimQuest = RemoteEvents:WaitForChild("ClaimQuest") :: RemoteEvent
local RemovePlant = RemoteEvents:WaitForChild("RemovePlant") :: RemoteEvent

local modulePath = ReplicatedStorage:WaitForChild("RNGPacks"):WaitForChild("RNGPackManager")
require(modulePath)

local RequestSpin = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestSpin")

function Auto.Initialize(registry)
	reg = registry
	GetSelectedItems = registry.Utils.GetSelectedItems
end

local function GetRemoveConfig()
	local Options = reg.Options
	return {
		mode = "Remove",
		wl = {
			crops = GetSelectedItems(Options.ddRemoveCrops.Value),
			mutants = GetSelectedItems(Options.ddRemoveMutants.Value),
			ripeness = GetSelectedItems(Options.ddRemoveRipeness.Value),
			ripenessMulti = tonumber(Options.ipRemoveRipenessMulti.Value) or 0,
			variant = GetSelectedItems(Options.ddRemoveVariant.Value),
			weightCondition = Options.ddRemoveWeight.Value,
			weightValue = tonumber(Options.ipRemoveWeight.Value) or 0,
			scaleCondition = Options.ddRemoveScale.Value,
			scaleValue = tonumber(Options.ipRemoveScale.Value) or 0,
		},
		bl = {
			crops = GetSelectedItems(Options.ddRemoveBlackCrops.Value),
			ripeness = GetSelectedItems(Options.ddRemoveBlackRipeness.Value),
			variant = GetSelectedItems(Options.ddRemoveBlackVariant.Value),
			mutants = GetSelectedItems(Options.ddRemoveBlackMutants.Value),
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
		if qDaily.CompletedAt and not qDaily.Claimed then ClaimQuest:FireServer("Daily", index) end
	end

	local Weekly = QuestData.Weekly.Active
	for index, qWeekly in pairs(Weekly) do
		if qWeekly.CompletedAt and not qWeekly.Claimed then ClaimQuest:FireServer("Weekly", index) end
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
					if crop:IsA("Model") and Main.CheckCrops(crop, dynRemoveConfig) then PerformDig(crop) end
				end
			else
				if CheckPlantsScale(plant) then PerformDig(plant) end
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

-- สร้างที่เก็บ Backup ไว้ด้านบนของสคริปต์
Auto.BackupFuncs = Auto.BackupFuncs or {
	RNGManager = nil,
	CutsceneManager = nil,
	Originals = {},
}

function Auto.disablePackAnimations()
	-- วนลูปหาแค่ครั้งเดียวแล้วเก็บ Backup
	if not Auto.BackupFuncs.RNGManager then
		for _, v in pairs(getgc(true)) do
			if type(v) == "table" then
				if rawget(v, "RunSpinAnimation") then
					Auto.BackupFuncs.RNGManager = v
					Auto.BackupFuncs.Originals["RunSpinAnimation"] = v.RunSpinAnimation
					Auto.BackupFuncs.Originals["ShowcaseRewards"] = v.ShowcaseRewards
					Auto.BackupFuncs.Originals["Initiate"] = v.Initiate
				end
				if rawget(v, "Play") and rawget(v, "Preload") then
					Auto.BackupFuncs.CutsceneManager = v
					Auto.BackupFuncs.Originals["Play"] = v.Play
				end
			end
		end
	end

	-- ปิดการทำงาน (Overwrite)
	local rng = Auto.BackupFuncs.RNGManager
	if rng then
		rng.RunSpinAnimation = function()
			return
		end
		rng.ShowcaseRewards = function()
			return
		end
		rng.Initiate = function()
			return
		end
	end

	local cut = Auto.BackupFuncs.CutsceneManager
	if cut then cut.Play = function()
		return
	end end

	fLog("🚫 ปิดแอนิเมชันแล้ว")

	-- ส่วนของการ Force เปิด UI ที่พี่เอฟเขียนไว้ คงไว้เหมือนเดิมได้เลยค่ะ
end

function Auto.enablePackAnimations()
	-- คืนค่าจากที่ Backup ไว้
	if Auto.BackupFuncs.RNGManager then
		local rng = Auto.BackupFuncs.RNGManager
		local orig = Auto.BackupFuncs.Originals

		if rng and orig["RunSpinAnimation"] then
			rng.RunSpinAnimation = orig["RunSpinAnimation"]
			rng.ShowcaseRewards = orig["ShowcaseRewards"]
			rng.Initiate = orig["Initiate"]
		end

		local cut = Auto.BackupFuncs.CutsceneManager
		if cut and orig["Play"] then cut.Play = orig["Play"] end

		fLog("🎬 เปิดแอนิเมชันกลับมาเหมือนเดิมแล้ว")
	end
end

function Auto.OpenPack()
	local Options = reg.Options
	local sData = reg.sData
	local Utils = reg.Utils

	if not Options.tgOpenPackEnable.Value then return end
	local PackList = GetSelectedItems(Options.ddOpenPackSelect.Value)
	if table.find(PackList, "ALL") then PackList = sData.SeedPackTable end
	Utils.UnequipTools()
	task.wait()
	local Backpack = LocalPlayer.Backpack
	if not Backpack then fLog("No Backpack") end
	for _index, item in pairs(Backpack:GetChildren()) do
		if not Options.tgOpenPackEnable.Value then return end
		local ItemName = item:GetAttribute("BaseName")
		if table.find(PackList, ItemName) then
			local ItemCount = item:GetAttribute("ItemCount") or 0
			for i = 1, ItemCount do
				if not Options.tgOpenPackEnable.Value then return end
				Utils.EquipItem(item)
				task.wait()
				local success, result = pcall(function()
					return RequestSpin:InvokeServer()
				end)

				if success and result and result.RewardId then
					fLog("🌱 ได้รับไอเทมแล้ว: " .. tostring(result.RewardId))
				else
					fLog("❌ เปิดไม่สำเร็จ (อาจจะไม่มีซองในมือ หรือติด Cooldown)")
				end
				task.wait(0.5)
			end
		end
	end
	if Options.tgOpenPackEnable.Value then
		Options.tgOpenPackEnable:SetValue(false) -- สั่งให้สวิตช์ใน Fluent UI เด้งกลับไปสถานะปิด
		fLog("✅ เปิดซองทั้งหมดเรียบร้อยแล้ว ระบบพักการทำงาน")
	end
end

return Auto
