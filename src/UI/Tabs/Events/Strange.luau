local Strange = {}
local reg
local EventsTab
local StrangeTask
local Pos
local isLaunched = false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GetIGMAData = RemoteEvents:WaitForChild("GetIGMAData") :: RemoteFunction
local IGMATurnIn = RemoteEvents:WaitForChild("IGMATurnIn") :: RemoteFunction
local RestartIGMA = RemoteEvents:WaitForChild("RestartIGMA") :: RemoteFunction
local ClaimIGMAReward = RemoteEvents:WaitForChild("ClaimIGMAReward") :: RemoteFunction
local RewardDefs = require(ReplicatedStorage:WaitForChild("IGMA"):WaitForChild("IGMARewardDefinitions"))

local PlotPos = {
	CFrame.new(426, 213, 405),
	CFrame.new(465, 213, 405),
	CFrame.new(465, 213, 345),
	CFrame.new(426, 213, 345),
}

function Strange.Initialize(registry, tab)
	reg = registry
	EventsTab = tab
	local Options = reg.Options --ใช้ใน UI
	local QuickSave = reg.Window.QuickSave
	local sData = reg.sData
	local SafeTeleport = reg.Utils.SafeTeleport
	Pos = reg.fVar.Pos.Strange
	local fVar = reg.fVar

	local StrangeSection = EventsTab:AddCollapsibleSection("Strange", false)
	StrangeSection:AddToggle("tgStrangeEnable", {
		Title = "Event Enable",
		Default = false,
		Callback = function(Value)
			if Value then
				StrangeTask = task.spawn(function()
					while true do
						Strange.doEvent()
						task.wait(30)
					end
				end)
			else
				isLaunched = false -- Reset status when disabled
				if StrangeTask then
					task.cancel(StrangeTask)
					StrangeTask = nil
				end
			end
			QuickSave()
		end,
	})
	StrangeSection:AddButton({
		Title = "Clear Selected Plants",
		Callback = function()
			Options.ddStrangeBlackList:SetValue({ "NONE" }) -- Use SetValue for UI update
		end,
	})
	StrangeSection:AddDropdown("ddStrangeBlackList", {
		Title = "Blacklist Plants",
		Values = sData.PlantDataBlackTable,
		Default = { "NONE" },
		Multi = true,
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	StrangeSection:AddButton({
		Title = "Turn In Now!",
		Callback = function()
			fVar.LockDownControlVar()
			task.wait(1)
			SafeTeleport(Pos)
			task.wait(1)
			IGMATurnIn:InvokeServer("TurnInAll")
			task.wait(1)
			SafeTeleport(reg.MySpawnPoint)
			task.wait(1)
			fVar.ResetControlVar()
		end,
	})
	StrangeSection:AddToggle("tgStrangeAutoReset", {
		Title = "Auto Reset",
		Default = false,
		Callback = function(Value)
			QuickSave()
		end,
	})

	local function CheckIGMAStatus()
		fLog("📡 กำลังดึงข้อมูล IGMA จาก Server...")

		-- ใช้ pcall ป้องกันสคริปต์หยุดทำงาน
		local success, data = pcall(function()
			return GetIGMAData:InvokeServer()
		end)

		if success and type(data) == "table" then
			fLog("✅ ข้อมูล IGMA | แต้ม: " .. tostring(data.Points) .. "/" .. tostring(RewardDefs.MAX_POINTS) .. " | เต็ม: " .. tostring(data.Completed))

			if data.ClaimedRewards and type(data.ClaimedRewards) == "table" then
				local count = 0
				for _, rewardIndex in pairs(data.ClaimedRewards) do
					-- ใช้ฟังก์ชัน GetRewardByIndex ดึงข้อมูลไอเทม
					local rewardInfo = RewardDefs.GetRewardByIndex(rewardIndex)

					if rewardInfo then
						local itemName = tostring(rewardInfo.Item)
						local amount = tostring(rewardInfo.Amount)
						local reqPoints = tostring(rewardInfo.Points)

						fLog("🎁 รับแล้ว: ขั้น " .. reqPoints .. " แต้ม -> " .. itemName .. " (x" .. amount .. ")")
					else
						fLog("🎁 รับแล้ว: ID ลำดับที่ " .. tostring(rewardIndex) .. " (ไม่พบข้อมูลในระบบ)")
					end
					count = count + 1
				end

				if count == 0 then fLog("ℹ️ ยังไม่มีประวัติการรับของรางวัลค่ะ") end
			end
		else
			fLog("❌ ดึงข้อมูลไม่สำเร็จ Server ไม่ได้ตอบกลับมาเป็น Table ค่ะ")
		end
	end

	StrangeSection:AddButton({
		Title = "Check Info",
		Callback = function()
			CheckIGMAStatus()
		end,
	})
end

local function SafeResetIGMAQuest()
	fLog("📡 ตรวจสอบสถานะเควสก่อนทำการรีเซ็ต...")

	local successData, data = pcall(function()
		return GetIGMAData:InvokeServer()
	end)

	if successData and type(data) == "table" then
		if data.Completed then
			fLog("⚠️ เควสตันแล้ว! กำลังดำเนินการรีเซ็ต (หัก 100M Shillings)...")

			local successReset, result = pcall(function()
				return RestartIGMA:InvokeServer()
			end)

			if successReset and type(result) == "table" then
				if result.Status == "success" then
					fLog("✅ รีเซ็ตเควสสำเร็จ! ระบบพร้อมเริ่มรอบใหม่แล้วค่ะ")
				elseif result.Status == "insufficient_funds" then
					fLog("❌ รีเซ็ตระงับ: พี่เอฟมีเงินไม่ถึง 100,000,000 Shillings ค่ะ")
				else
					fLog("❌ รีเซ็ตเกิดข้อผิดพลาด: " .. tostring(result.Status))
				end
			else
				fLog("❌ ส่งคำสั่งรีเซ็ตไม่สำเร็จ Server ไม่ตอบสนองค่ะ")
			end
		else
			fLog("ℹ️ เควสยังไม่ตันค่ะ (แต้ม: " .. tostring(data.Points) .. ") ข้ามการรีเซ็ต")
		end
	else
		fLog("❌ ดึงข้อมูลสถานะไม่สำเร็จ ไม่สามารถตรวจสอบได้ค่ะ")
	end
end

local function AutoClaimMissingRewards()
	fLog("🔍 กำลังตรวจสอบของรางวัลที่อาจตกหล่น...")

	local success, data = pcall(function()
		return GetIGMAData:InvokeServer()
	end)

	if success and type(data) == "table" then
		local currentPoints = data.Points
		local claimedList = data.ClaimedRewards or {}
		local hasMissing = false

		local claimedDict = {}
		for _, id in pairs(claimedList) do
			claimedDict[id] = true
		end

		for index, reward in ipairs(RewardDefs.Rewards) do
			if currentPoints >= reward.Points and not claimedDict[index] then
				hasMissing = true
				fLog("🎁 พบของตกหล่น! ขั้น " .. tostring(reward.Points) .. " แต้ม (" .. tostring(reward.Item) .. ")")

				local claimSuccess, claimResult = pcall(function()
					return ClaimIGMAReward:InvokeServer(index)
				end)

				if claimSuccess and claimResult then
					fLog("✅ เก็บตกสำเร็จ: ได้รับ " .. tostring(reward.Item) .. " (x" .. tostring(reward.Amount) .. ")")
				else
					fLog("❌ เก็บตกไม่สำเร็จสำหรับลำดับที่ " .. tostring(index))
				end

				task.wait(0.5)
			end
		end

		if not hasMissing then fLog("ℹ️ ตรวจสอบเรียบร้อย: รับของรางวัลครบตามแต้มแล้วค่ะ") end
	else
		fLog("❌ ดึงข้อมูลไม่สำเร็จ ไม่สามารถตรวจสอบรางวัลตกหล่นได้ค่ะ")
	end
end

function Strange.doEvent()
	local fVar = reg.fVar
	local Options = reg.Options
	local Utils = reg.Utils
	local GetSelectedItems = Utils.GetSelectedItems
	local SafeTeleport = Utils.SafeTeleport
	local TweenToTarget = Utils.TweenToTarget
	local ParseFruitUuid = Utils.ParseFruitUuid
	local HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit")

	local TargetMutants = { "Strange" }
	local EventCropList = {}

	if not Options.tgStrangeEnable.Value then return end

	local currentMin = os.date("*t").min

	if (currentMin >= 6 and currentMin < 15) or (currentMin >= 36 and currentMin < 45) then
		if not isLaunched then
			isLaunched = true

			local success, err = pcall(function()
				fVar.LockDownControlVar()
				task.wait(2)
				reg.MiscTab.NewPlayerAutoSell()
				fVar.LockDownControlVar()
				task.wait(3)
				local BlackList = GetSelectedItems(Options.ddStrangeBlackList.Value)
				task.wait(0.2)
				local TargetPos = reg.Utils.GetCenterPlots()
				table.insert(TargetPos, reg.MySpawnPoint)
				for _, cpos in TargetPos do
					SafeTeleport(cpos)
					task.wait(5)

					local ClientPlants = workspace:FindFirstChild("ClientPlants")
					if ClientPlants then
						for _, plant in ClientPlants:GetChildren() do
							local PlantType = plant:GetAttribute("PlantType")
							if PlantType and (table.find(BlackList, "NONE") or not table.find(BlackList, PlantType)) then
								local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
								for _, crop in CropsTable do
									local cropMutants = crop:GetAttribute("Mutation")
									local FullyGrown = crop:GetAttribute("FullyGrown")
									if FullyGrown and cropMutants and crop:GetAttribute("Favorited") ~= true then
										local isTargetMutant = false
										for _, mutantName in ipairs(TargetMutants) do
											if string.find(cropMutants, mutantName) then
												isTargetMutant = true
												break
											end
										end

										if isTargetMutant and not table.find(EventCropList, crop) then table.insert(EventCropList, crop) end
									end
								end
							end
						end
					end
				end

				if #EventCropList > 0 then
					for _, fruit in EventCropList do
						local prompt = fruit:FindFirstChild("HarvestPrompt", true)
						if prompt then
							local targetCFrame = CFrame.new(fruit:GetPivot().Position + Vector3.new(3, 0, 0))
							TweenToTarget(targetCFrame, 100)
							task.wait(0.1)

							local gUuid, gindex = ParseFruitUuid(fruit:GetAttribute("Uuid"))
							local args = gindex and { { { GrowthAnchorIndex = gindex, Uuid = gUuid } } } or { { { Uuid = gUuid } } }

							HarvestFruit:FireServer(table.unpack(args))
							task.wait(0.1)
						end
					end
				end

				if #EventCropList > 0 then
					fVar.LockDownControlVar()
					task.wait(1)
					SafeTeleport(Pos)
					task.wait(1)
					IGMATurnIn:InvokeServer("TurnInAll")
					task.wait(1)
					AutoClaimMissingRewards()
					task.wait(1)
					if Options.tgStrangeAutoReset.Value then SafeResetIGMAQuest() end
					task.wait(1)
					SafeTeleport(reg.MySpawnPoint)
					task.wait(0.2)
				end
			end)

			fVar.ResetControlVar() -- Ensure reset
			if not success then fLog("⚠️ Strange Event Error: " .. tostring(err)) end
		end
	elseif isLaunched then
		isLaunched = false
	end
end

return Strange
