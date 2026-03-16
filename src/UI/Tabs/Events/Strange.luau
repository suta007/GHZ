local Strange = {}
local reg
local EventsTab
local StrangeTask

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

function Strange.Initialize(registry, tab)
	reg = registry
	EventsTab = tab
	local Options = reg.Options
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
					StrangeTask:Cancel()
					StrangeTask = nil
				end
			end
			QuickSave()
		end,
	})
end

function Strange.doEvent()
	local fVar = reg.fVar
	local Pos = fVar.Pos.Strange
	local Options = reg.Options
	local isLaunched = false
	local Utils = reg.Utils
	local TargetMutants = "Strange"
	local EventCropList = {}
	local TweenToTarget = reg.Utils.TweenToTarget
	local ParseFruitUuid = reg.Utils.ParseFruitUuid
	local SafeTeleport = reg.Utils.SafeTeleport
	local HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit")

	if not Options.tgStrangeEnable.Value then return end
	table.clear(EventCropList)
	local currentMin = os.date("*t").min
	if currentMin >= 15 and currentMin <= 20 then
		if not isLaunched then
			isLaunched = true
			fVar.LockDownControlVar()

			local centerPos = Utils.GetCenterPlots()
			for _, pos in centerPos do
				Utils.SafeTeleport(pos)
				task.wait(0.2)
				local ClientPlants = workspace:FindFirstChild("ClientPlants")
				if ClientPlants then
					for _, plant in ClientPlants:GetChildren() do
						local PlantType = plant:GetAttribute("PlantType")
						if PlantType then
							local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
							for _, crop in CropsTable do
								local cropMutants = crop:GetAttribute("Mutation")
								local cropMutantsTable = string.split(cropMutants, ",")
								if table.find(cropMutantsTable, TargetMutants) and not table.find(EventCropList, crop) then table.insert(EventCropList, crop) end
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
						HarvestFruit:FireServer(unpack(args))
						task.wait(0.1)
					end
				end
			end
			if #EventCropList > 0 then
				table.clear(EventCropList)
				SafeTeleport(Pos)
				task.wait(0.2)
				game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("IGMATurnIn"):InvokeServer("TurnInAll")
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
