--!nocheck
local Main = {}

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local function LoadModules()
	local Registry = {}
	
	-- 1. Core
	Registry.State = GHZ_REMOTE("Core/State")
	Registry.Constants = GHZ_REMOTE("Core/Constants")
	Registry.Utils = GHZ_REMOTE("Core/Utils")
	Registry.Network = GHZ_REMOTE("Core/Network")

	-- 2. Functional Modules
	Registry.Harvest = GHZ_REMOTE("Modules/Harvest")
	Registry.Planting = GHZ_REMOTE("Modules/Planting")
	Registry.Trading = GHZ_REMOTE("Modules/Trading")
	Registry.ESP = GHZ_REMOTE("Modules/ESP")
	Registry.AntiLag = GHZ_REMOTE("Modules/AntiLag")
	Registry.Quest = GHZ_REMOTE("Modules/Quest")
	Registry.MannyMishap = GHZ_REMOTE("Modules/Events/MannyMishap")

	-- 3. UI Modules
	Registry.Window = GHZ_REMOTE("UI/Window")
	Registry.MainTab = GHZ_REMOTE("UI/Tabs/MainTab")
	Registry.ShopTab = GHZ_REMOTE("UI/Tabs/ShopTab")
	Registry.EventTab = GHZ_REMOTE("UI/Tabs/EventTab")
	Registry.AutoTab = GHZ_REMOTE("UI/Tabs/AutoTab")
	Registry.MiscTab = GHZ_REMOTE("UI/Tabs/MiscTab")

	return Registry
end

function Main.Initialize()
	-- 0. Load All Modules into Registry
	local Registry = LoadModules()
	local State = Registry.State
	local Utils = Registry.Utils
	local Constants = Registry.Constants
	local Network = Registry.Network
	
	-- 1. Initialize Functional Modules with Registry
	Registry.Harvest.Initialize(Registry)
	Registry.Planting.Initialize(Registry)
	Registry.Trading.Initialize(Registry)
	Registry.ESP.Initialize(Registry)
	Registry.AntiLag.Initialize(Registry)
	Registry.Quest.Initialize(Registry)
	Registry.MannyMishap.Initialize(Registry)

	-- 2. Initialize Plot Data
	Utils.InitializePlotData()

	-- 3. Setup UI
	local _, Tabs, Fluent, SaveManager, InterfaceManager = Registry.Window.Initialize(Registry)
	local Options = Fluent.Options

	-- 4. Setup Tabs
	Registry.MainTab.Setup(Tabs.Main, Options, SaveManager, Registry)
	Registry.ShopTab.Setup(Tabs.Shop, Options, SaveManager, Registry)
	Registry.EventTab.Setup(Tabs.Event, Options, SaveManager, Registry)
	Registry.AutoTab.Setup(Tabs.Auto, Options, SaveManager, Registry)
	Registry.MiscTab.Setup(Tabs.Misc, Options, SaveManager, Registry)
	
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
					Registry.Harvest.Scan()
				elseif not (State.HarvestPause or State.isProcessing or State.isHarvesting) then
					Registry.Harvest.Run()
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
					task.spawn(Registry.MannyMishap.Run)
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
						FuncName = Registry.Quest.AutoClaim,
						args = args[1],
					})
				elseif RemoteName == "MannyMishapScoreUpdate" then
					Registry.MannyMishap.HandleScoreUpdate(args)
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
