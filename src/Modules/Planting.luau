--!nocheck
local Planting = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local State = require(script.Parent.Parent.Core.State)
local Utils = require(script.Parent.Parent.Core.Utils)
local Network = require(script.Parent.Parent.Core.Network)

local Options = {}

function Planting.SetOptions(opts)
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

function Planting.Run()
	if not Options.tgPlantsEnable.Value or State.isPlanting then return end

	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChild("Humanoid")
	if not humanoid then return end

	pcall(function() humanoid:UnequipTools() end)
	
	local ddPlantsPos = Options.ddPlantsPos.Value
	local Backpack = LocalPlayer.Backpack
	local SeedList = GetSelectedItems(Options.ddPlantsSeeds.Value)

	if Backpack then
		for _, item in pairs(Backpack:GetChildren()) do
			if not Options.tgPlantsEnable.Value then break end
			
			local itemType = item:GetAttribute("Type")
			local plantType = item:GetAttribute("PlantType")
			
			if itemType == "Seeds" and (table.find(SeedList, "ALL") or table.find(SeedList, plantType)) then
				State.isPlanting = true
				pcall(function() humanoid:EquipTool(item) end)
				
				local itemCount = item:GetAttribute("ItemCount") or 0
				for i = 1, itemCount do
					if not Options.tgPlantsEnable.Value then
						State.isPlanting = false
						break
					end
					
					local plantPosCFrame
					if ddPlantsPos == "Player" then
						plantPosCFrame = character:GetPivot()
					elseif ddPlantsPos == "Random" then
						local randPos = Utils.GetRandomPlantPosition()
						if randPos then
							plantPosCFrame = randPos
							Utils.TweenToTarget(CFrame.new(randPos.X + 3, randPos.Y, randPos.Z), 100)
						end
					end
					
					if plantPosCFrame then
						Network.Events.PlantSeed:InvokeServer(plantType, plantPosCFrame.Position)
						task.wait(0.3)
					end
				end
				pcall(function() humanoid:UnequipTools() end)
			end
		end
		State.isPlanting = false
	end
end

return Planting
