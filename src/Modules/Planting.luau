--!nocheck
local Planting = {}
local Registry = nil
local State = nil
local Utils = nil
local Network = nil

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Options = nil

function Planting.Initialize(reg)
	Registry = reg
	State = reg.State
	Utils = reg.Utils
	Network = reg.Network
end

function Planting.SetOptions(opts)
	Options = opts
end

function Planting.AutoPlantsSeeds()
	if State.HarvestPause or State.isProcessing or State.isPlanting or not Options.tgPlantsEnable.Value then return end

	local character = LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local backpack = LocalPlayer:FindFirstChild("Backpack")
	if not backpack then return end

	pcall(function() humanoid:UnequipTools() end)
	
	local selectedSeeds = Utils.GetSelectedItems(Options.ddPlantsSeeds.Value)
	if #selectedSeeds == 0 then return end

	for _, item in ipairs(backpack:GetChildren()) do
		if not Options.tgPlantsEnable.Value then break end
		
		local pType = item:GetAttribute("Type")
		local plantType = item:GetAttribute("PlantType")
		
		if pType == "Seeds" and (table.find(selectedSeeds, "ALL") or table.find(selectedSeeds, plantType)) then
			State.isPlanting = true
			pcall(function() humanoid:EquipTool(item) end)
			
			local itemCount = item:GetAttribute("ItemCount") or 1
			for i = 1, itemCount do
				if not Options.tgPlantsEnable.Value then break end
				
				local pos = nil
				if Options.ddPlantsPos.Value == "Player" then
					pos = character:GetPivot()
				else
					pos = Utils.GetRandomPlantPosition()
					if pos then
						Utils.TweenToTarget(CFrame.new(pos.Position + Vector3.new(3, 0, 0)), 100)
					end
				end

				if pos then
					task.wait(0.2)
					Network.Functions.PlantSeed:InvokeServer(plantType, pos.Position)
					task.wait(0.3)
				end
			end
			
			pcall(function() humanoid:UnequipTools() end)
		end
	end

	State.isPlanting = false
end

function Planting.Run(seedUuid)
	-- Legacy run for specific uuid if needed
	if not State.MyPlot then Utils.InitializePlotData() end
	if not State.MyPlot then return end

	State.isPlanting = true
	local pos = Utils.GetRandomPlantPosition()
	if pos then
		Utils.SafeTeleport(pos)
		task.wait(0.2)
		Network.Events.PlantSeed:FireServer(seedUuid, pos)
		task.wait(0.5)
	end
	State.isPlanting = false
end

return Planting
