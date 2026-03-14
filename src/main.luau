--!nocheck
local Main = {}

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- Core
local _State = require(script.Core.State)
local _Constants = require(script.Core.Constants)
local Utils = require(script.Core.Utils)
local _Network = require(script.Core.Network)

-- Modules
local Harvest = require(script.Modules.Harvest)
local Planting = require(script.Modules.Planting)
local Trading = require(script.Modules.Trading)
local ESP = require(script.Modules.ESP)
local _AntiLag = require(script.Modules.AntiLag)
local _Quest = require(script.Parent.Parent.Parent.Modules.Quest)
local MannyMishap = require(script.Modules.Events.MannyMishap)

-- UI
local Window = require(script.UI.Window)
local MainTab = require(script.UI.Tabs.MainTab)
local ShopTab = require(script.UI.Tabs.ShopTab)
local EventTab = require(script.UI.Tabs.EventTab)
local AutoTab = require(script.UI.Tabs.AutoTab)
local MiscTab = require(script.UI.Tabs.MiscTab)

function Main.Initialize()
	-- 1. Initialize State & Plot
	Utils.InitializePlotData()

	-- 2. Setup UI
	local _, Tabs, Fluent, SaveManager, InterfaceManager = Window.Initialize()
	local Options = Fluent.Options

	-- 3. Link Options to Modules
	Harvest.SetOptions(Options)
	Planting.SetOptions(Options)
	Trading.SetOptions(Options)
	ESP.SetOptions(Options)
	Quest.SetOptions(Options)
	MannyMishap.SetOptions(Options)

	-- 4. Setup Tabs
	MainTab.Setup(Tabs.Main, Options, SaveManager)
	ShopTab.Setup(Tabs.Shop, Options, SaveManager)
	EventTab.Setup(Tabs.Event, Options, SaveManager)
	AutoTab.Setup(Tabs.Auto, Options, SaveManager)
	MiscTab.Setup(Tabs.Misc, Options, SaveManager)
	
	InterfaceManager:BuildInterfaceSection(Tabs.Settings)
	SaveManager:BuildConfigSection(Tabs.Settings)

	-- 5. Anti-AFK
	LocalPlayer.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)

	-- 6. Main Loops
	task.spawn(function()
		local _lastNewPlayerTrigger = -1
		local lastWalkDog = tick()

		while true do
			local clock = tick()
			task.wait(0.2)

			-- Auto Harvest
			if Options.tgHarvestEnable.Value then
				if #State.HarVestCropsList == 0 then
					Harvest.Scan()
				elseif not (State.HarvestPause or State.isProcessing or State.isHarvesting) then
					Harvest.Run()
				end
			end

			-- Action Queue
			if #State.actionQueue > 0 and not State.isProcessing then
				State.isProcessing = true
				State.HarvestPause = true
				task.wait(0.2)
				while #State.actionQueue > 0 do
					local taskData = table.remove(State.actionQueue, 1)
					pcall(function()
						if taskData.args then taskData.FuncName(taskData.args) else taskData.FuncName() end
					end)
				end
				State.isProcessing = false
				State.HarvestPause = false
			end

			-- 3. Manny Mishap Loop
			local currentMin = os.date("*t").min
			if currentMin >= 0 and currentMin < 5 then
				if Options.tgMannyMishapEnable.Value and not State.MannyMishapEnable then
					State:LockDownControlVariable()
					task.wait(1)
					State.MannyMishapEnable = true
					task.spawn(MannyMishap.Run)
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

			-- Dog Watch
			if clock - lastWalkDog >= 3600 then
				lastWalkDog = clock
				State:ResetControlVariable()
			end
		end
	end)

	-- 8. Hook Incoming Remotes
	local _ReplicatedStorage = game:GetService("ReplicatedStorage")
	local function hookIncoming(remote)
		if remote:IsA("RemoteEvent") then
			remote.OnClientEvent:Connect(function(...)
				local RemoteName = remote.Name
				local args = { ... }
				if RemoteName == "UpdateQuests" then
					table.insert(State.actionQueue, {
						FuncName = Quest.AutoClaim,
						args = args[1],
					})
				elseif RemoteName == "MannyMishapScoreUpdate" then
					MannyMishap.HandleScoreUpdate(args)
				end
			end)
		end
	end

	for _, obj in ipairs(game:GetDescendants()) do hookIncoming(obj) end
	game.DescendantAdded:Connect(hookIncoming)

	-- 9. Load Settings
	task.spawn(function()
		while not SaveManager.Options.SaveManager_ConfigList do task.wait() end
		SaveManager.Options.SaveManager_ConfigList:SetValue("Horizons")
		SaveManager:Load("Horizons")
		State.IsLoading = false
	end)

	print("Garden Horizons Modular Initialized!")
end

return Main
