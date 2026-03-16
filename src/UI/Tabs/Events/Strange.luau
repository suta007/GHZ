local Strange = {}
local reg
local EventsTab
local StrangeTask

local IGMATurnIn = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("IGMATurnIn") :: RemoteFunction

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

function Strange.Initialize(registry, tab)
	reg = registry
	EventsTab = tab
	local Options = reg.Options --ใช้ใน UI
	local QuickSave = reg.Window.QuickSave

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
				if StrangeTask then
					task.cancel(StrangeTask)
					StrangeTask = nil
				end
			end
			QuickSave()
		end,
	})
end

local isLaunched = false

function Strange.doEvent()
	local fVar = reg.fVar
	local Pos = fVar.Pos.Strange
	local Options = reg.Options
	local Utils = reg.Utils

	-- 🌟 ปรับเป็น Table รองรับอนาคตตามที่พี่เอฟต้องการค่ะ
	local TargetMutants = { "Strange" }

	local EventCropList = {}
	local TweenToTarget = reg.Utils.TweenToTarget
	local ParseFruitUuid = reg.Utils.ParseFruitUuid
	local SafeTeleport = reg.Utils.SafeTeleport
	local HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit")

	if not Options.tgStrangeEnable.Value then return end

	local currentMin = os.date("*t").min

	if (currentMin >= 11 and currentMin < 15) or (currentMin >= 41 and currentMin < 45) then
		if not isLaunched then
			isLaunched = true
			reg.MiscTab.NewPlayerAutoSell()
			task.wait(0.2)
			fVar.LockDownControlVar()

			local centerPos = Utils.GetCenterPlots()
			for _, cpos in centerPos do
				Utils.SafeTeleport(cpos)
				task.wait(5)

				local ClientPlants = workspace:FindFirstChild("ClientPlants")
				if ClientPlants then
					for _, plant in ClientPlants:GetChildren() do
						local PlantType = plant:GetAttribute("PlantType")
						if PlantType then
							local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
							for _, crop in CropsTable do
								local cropMutants = crop:GetAttribute("Mutation")
								if cropMutants and crop:GetAttribute("Favorited") ~= true then
									-- 🌟 วนลูปเช็คว่ามีคำที่ตรงกับใน Table TargetMutants ไหม
									local isTargetMutant = false
									for _, mutantName in ipairs(TargetMutants) do
										if string.find(cropMutants, mutantName) then
											isTargetMutant = true
											break -- ถ้าเจอแล้วก็หยุดค้นหาในชื่ออื่นต่อได้เลย ประหยัดเวลาค่ะ
										end
									end

									-- ถ้าตรงเงื่อนไขและยังไม่เคยเก็บลง List ก็จัดการเพิ่มเข้าไป
									if isTargetMutant and not table.find(EventCropList, crop) then table.insert(EventCropList, crop) end
								end
							end
						end
					end
				end
			end

			-- เริ่มเก็บเกี่ยวผลไม้ที่เจอ
			if #EventCropList > 0 then
				for _, fruit in EventCropList do
					local prompt = fruit:FindFirstChild("HarvestPrompt", true)
					if prompt then
						local targetCFrame = CFrame.new(fruit:GetPivot().Position + Vector3.new(3, 0, 0))

						TweenToTarget(targetCFrame, 100)
						task.wait(0.1)

						local gUuid, gindex = ParseFruitUuid(fruit:GetAttribute("Uuid"))
						local args = {}
						if gindex then
							args = { { { GrowthAnchorIndex = gindex, Uuid = gUuid } } }
						else
							args = { { { Uuid = gUuid } } }
						end

						HarvestFruit:FireServer(table.unpack(args))
						task.wait(0.1)
					end
				end
			end

			-- ส่งเควสและกลับจุดเซฟ
			if #EventCropList > 0 then
				SafeTeleport(Pos)
				task.wait(0.2)
				IGMATurnIn:InvokeServer("TurnInAll")
				task.wait(1)
				SafeTeleport(reg.MySpawnPoint)
				task.wait(0.2)
			end

			fVar.ResetControlVar()
		end
	elseif isLaunched then
		isLaunched = false
	end
end

return Strange
