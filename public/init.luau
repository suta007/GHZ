--!nocheck
-- ==========================================
-- Garden Horizons Modular Script
-- Refactored by Antigravity
-- ==========================================

local Services = require(script.Core.Services)
local State = require(script.Core.State)
local Constants = require(script.Core.Constants)
local Utils = require(script.Core.Utilities)

local ESP = require(script.Modules.ESP)
local Automation = require(script.Modules.Automation)
local Remove = require(script.Modules.Remove)

-- Load Fluent and Addons
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

-- Initialize Plot
Utils.InitializePlotData()

-- UI Implementation (to be moved to public/UI/Interface.luau)
-- For now, let's keep the UI in init.luau or a dedicated file.
-- I'll create a dedicated UI file and require it.
local UI = require(script.UI.Interface)
local Options = UI.Init(Fluent, SaveManager, InterfaceManager, {
    State = State,
    Constants = Constants,
    Utils = Utils,
    ESP = ESP,
    Automation = Automation,
    Remove = Remove
})

-- Hooks and Events
local function hookIncoming(remote)
	if remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(...)
			local RemoteName = remote.Name
			local args = { ... }
			if RemoteName == "ReplicaSet" then
				Automation.RemoteReplicaSet(args, Options)
			elseif RemoteName == "Notification" then
				Automation.RemoteNotification(args, Options)
			elseif RemoteName == "UpdateQuests" then
				table.insert(State.actionQueue, {
					FuncName = Automation.AutoClaimQuest,
					args = args[1],
                    Options = Options
				})
			elseif RemoteName == "MannyMishapScoreUpdate" then
				if tonumber(args[1]) >= 300 then
					State.MannyMishapEnable = false
					State:ResetControlVariable()
					State.actionQueue = table.clone(State.backupQueue)
					Utils.SafeTeleport(State.MySpawnPoint)
					task.wait(1)
				end
			end
		end)
	end
end

for _, obj in ipairs(game:GetDescendants()) do hookIncoming(obj) end
game.DescendantAdded:Connect(hookIncoming)

-- Setup Tracker
local function SetupTracker()
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	ClientPlants.DescendantAdded:Connect(function(newPlant)
		task.wait(0.5)
		for _, obj in ipairs(newPlant:GetDescendants()) do
			if obj.Name == "PlantAnchor" then
				local parent = obj.Parent
				if Options.tgPlantsESP.Value then
					if parent:GetAttribute("HarvestablePlant") then ESP.SetespFruit(obj, Options, Utils) else ESP.SetespPlant(obj, Options, Utils) end
				end
				if parent:GetAttribute("HarvestablePlant") then
					if Options.tgHideFruit.Value then for _, sibling in ipairs(obj.Parent:GetChildren()) do Utils.SetVisibility(sibling, true) end end
				else
					if Options.tgHidePlant.Value then for _, sibling in ipairs(parent:GetChildren()) do Utils.SetVisibility(sibling, true) end end
				end
			elseif obj.Name == "FruitAnchor" then
				if Options.tgFruitESP.Value then ESP.SetespFruit(obj, Options, Utils) end
				if Options.tgHideFruit.Value then for _, sibling in ipairs(obj.Parent:GetChildren()) do Utils.SetVisibility(sibling, true) end end
			end
		end
	end)
end
SetupTracker()

-- Main Loops
task.spawn(function()
	local lastNewPlayerTrigger = -1
	local lastWalkDog = tick()
	while true do
		local clock = tick()
		task.wait(0.2)
		local ipNewDelay = tonumber(Options.ipNewDelay.Value) or 5
		local delaySeconds = ipNewDelay * 60
		if delaySeconds > 0 and (clock - lastNewPlayerTrigger) >= delaySeconds then
			lastNewPlayerTrigger = clock
			if Options.tgNewAutoSell.Value then
				State.HarvestPause = true
				table.clear(State.HarVestCropsList)
				table.insert(State.actionQueue, { FuncName = Automation.AutoSellCrops, Options = Options })
			end
			if Options.tgPlantsEnable.Value then table.insert(State.actionQueue, { FuncName = Automation.AutoPlantsSeeds, Options = Options }) end
		end
		if Options.tgHarvestEnable.Value then
			if #State.HarVestCropsList == 0 then Automation.ScanCrops(Options)
			elseif not (State.HarvestPause or State.isProcessing or State.isHarvesting) then Automation.HarvestCrops(Options) end
		end
		if #State.actionQueue > 0 and not State.isProcessing then Automation.ProcessQueue() end
		local inQueueRemoveCrops, inQueueRemovePlants = false, false
		for _, action in ipairs(State.actionQueue) do
			if action.FuncName == Remove.RemoveCrops then inQueueRemoveCrops = true end
			if action.FuncName == Remove.RemovePlants then inQueueRemovePlants = true end
		end
		if Options.tgRemoveFruitEnable.Value and not inQueueRemoveCrops and not State.isRemoveCrops then table.insert(State.actionQueue, { FuncName = Remove.RemoveCrops, Options = Options }) end
		if Options.tgRemovePlantsEnable.Value and not inQueueRemovePlants and not State.isRemovePlants then table.insert(State.actionQueue, { FuncName = Remove.RemovePlants, Options = Options }) end
		if clock - lastWalkDog >= 3600 then
			lastWalkDog = clock
			if Options.tgPlantsESP and Options.tgPlantsESP.Value == true then Options.tgPlantsESP:SetValue(false) end
			if Options.tgFruitESP and Options.tgFruitESP.Value == true then Options.tgFruitESP:SetValue(false) end
			State:ResetControlVariable()
		end
	end
end)

-- Anti-AFK
Services.LocalPlayer.Idled:Connect(function()
	Services.VirtualUser:CaptureController()
	Services.VirtualUser:ClickButton2(Vector2.new())
end)

-- Manny Mishap Loop
local function MannyMishapCollect()
	if not Options.tgMannyMishapEnable.Value then return end
	local folder = workspace:WaitForChild("MannyMishapCollectibles")
	while State.MannyMishapEnable and Options.tgMannyMishapEnable.Value do
		local fruits = folder:GetChildren()
		if #fruits > 0 then
			for _, model in ipairs(fruits) do
				if not State.MannyMishapEnable or not Options.tgMannyMishapEnable.Value then return end
				local anchor = model:FindFirstChild("Anchor") or model.PrimaryPart
				if anchor and model.Parent then
					Utils.SafeTeleport(anchor.CFrame)
					task.wait(1)
				end
			end
		else
			task.wait(2)
		end
	end
end

task.spawn(function()
	while true do
		local currentMin = os.date("*t").min
		if currentMin >= 0 and currentMin < 5 then
			if Options.tgMannyMishapEnable.Value and not State.MannyMishapEnable then
				State:LockDownControlVariable()
				task.wait(1)
				State.MannyMishapEnable = true
				task.spawn(MannyMishapCollect)
			elseif not Options.tgMannyMishapEnable.Value and State.MannyMishapEnable then
				State.MannyMishapEnable = false
				State:ResetControlVariable()
				State.actionQueue = table.clone(State.backupQueue)
				Utils.SafeTeleport(State.MySpawnPoint)
				task.wait(1)
			end
		else
			if State.MannyMishapEnable then
				State.MannyMishapEnable = false
				State:ResetControlVariable()
				State.actionQueue = table.clone(State.backupQueue)
				Utils.SafeTeleport(State.MySpawnPoint)
				task.wait(1)
			end
		end
		task.wait(5)
	end
end)

print("Garden Horizons Modular Script Loaded!")
