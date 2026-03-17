local BlackList = { "NONE" }
local TargetMutants = { "Strange" }
local EventCropList = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local RemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")
local HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit")
local PlotPos = {
	CFrame.new(426, 213, 405),
	CFrame.new(465, 213, 405),
	CFrame.new(465, 213, 345),
	CFrame.new(426, 213, 345),
}

local function ParseFruitUuid(rawUuid)
	local baseUuid = string.split(rawUuid, ":")[1]
	local numberSuffixStr = string.match(rawUuid, ":(%d+)$")
	local finalNumber = nil
	if numberSuffixStr then finalNumber = tonumber(numberSuffixStr) end
	return baseUuid, finalNumber
end
for _, cpos in PlotPos do
	Character:PivotTo(cpos)
	task.wait(5)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if ClientPlants then
		for _, plant in ClientPlants:GetChildren() do
			local PlantType = plant:GetAttribute("PlantType")
			if PlantType and (table.find(BlackList, "NONE") or not table.find(BlackList, PlantType)) then
				local CropsTable = plant:GetAttribute("HarvestablePlant") and { plant } or plant:GetChildren()
				for _, crop in CropsTable do
					local cropMutants = crop:GetAttribute("Mutation")
					if cropMutants and crop:GetAttribute("Favorited") ~= true then
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
			Character:PivotTo(targetCFrame)
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

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local IGMATurnIn = RemoteEvents:WaitForChild("IGMATurnIn") :: RemoteFunction
IGMATurnIn:InvokeServer("TurnInAll")
