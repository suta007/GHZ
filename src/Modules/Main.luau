local Main = {}
local reg
local Options
local fVar
local GetSelectedItems
local TweenToTarget
local SafeTeleport

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local PlantSeed = RemoteEvents:WaitForChild("PlantSeed")

function Main.Initialize(Registry)
	reg = Registry
	Options = Registry.Options
	fVar = Registry.fVar
	GetSelectedItems = Registry.Utils.GetSelectedItems
	GetRandomPlantPosition = Registry.Utils.GetRandomPlantPosition
	TweenToTarget = Registry.Utils.TweenToTarget
	SafeTeleport = Registry.Utils.SafeTeleport
end

function Main.AutoPlantsSeeds()
	if not Options.tgPlantsEnable.Value or fVar.isPlanting then return end

	pcall(function()
		Humanoid:UnequipTools()
	end)
	local ddPlantsPos = Options.ddPlantsPos.Value
	local PlantPos
	local HerePos = nil
	local Backpack = LocalPlayer.Backpack
	local SeedList = GetSelectedItems(Options.ddPlantsSeeds.Value)

	if Backpack then
		for _index, item in pairs(Backpack:GetChildren()) do
			if not Options.tgPlantsEnable.Value then break end
			if item:GetAttribute("Type") == "Seeds" and (table.find(SeedList, "ALL") or table.find(SeedList, item:GetAttribute("PlantType"))) then
				fVar.isPlanting = true
				pcall(function()
					Humanoid:EquipTool(item)
				end)
				local ItemCount = item:GetAttribute("ItemCount") or 0
				for i = 1, ItemCount do
					if not Options.tgPlantsEnable.Value then
						fVar.isPlanting = false
						break
					end
					if ddPlantsPos == "Player" then
						PlantPos = Character:GetPivot()
					else
						if ddPlantsPos == "Random" then
							PlantPos = GetRandomPlantPosition()
						elseif ddPlantsPos == "Here" then
							if not HerePos then HerePos = Character:GetPivot() end
							PlantPos = HerePos
						end
						TweenToTarget(CFrame.new(PlantPos.X + 3, PlantPos.Y, PlantPos.Z), 100)
					end
					local args = {
						item:GetAttribute("PlantType"),
						PlantPos.Position,
					}
					PlantSeed:InvokeServer(unpack(args))
					task.wait(0.3)
				end
				pcall(function()
					Humanoid:UnequipTools()
				end)
			end
		end
		fVar.isPlanting = false
	end
end

return Main
