--!nocheck
--!native
--!optimize 2

local GHZ_REMOTE = GHZ_REMOTE or getgenv().GHZ_REMOTE
local EfHub = {}

local function LoadModules()
	local Registry = {}
	local isDev = getgenv().DEV_MODE
	if isDev then
		-- 1. Core
		Registry.sData = GHZ_REMOTE("Core/sData")
		Registry.fVar = GHZ_REMOTE("Core/fVar")

		-- 2. Functional Modules
		Registry.Utils = GHZ_REMOTE("Modules/Utils")
		Registry.Misc = GHZ_REMOTE("Modules/Misc")
		Registry.Main = GHZ_REMOTE("Modules/Main")
		Registry.Shop = GHZ_REMOTE("Modules/Shop")
		Registry.Process = GHZ_REMOTE("Modules/Process")
		Registry.Auto = GHZ_REMOTE("Modules/Auto")
		Registry.EventDrive = GHZ_REMOTE("Modules/EventDrive")

		-- 3. UI Modules
		Registry.Window = GHZ_REMOTE("UI/Window")
		Registry.MainTab = GHZ_REMOTE("UI/Tabs/MainTab")
		Registry.ShopTab = GHZ_REMOTE("UI/Tabs/ShopTab")
		Registry.MiscTab = GHZ_REMOTE("UI/Tabs/MiscTab")
		Registry.EventsTab = GHZ_REMOTE("UI/Tabs/EventsTab")
		Registry.AutoTab = GHZ_REMOTE("UI/Tabs/AutoTab")
		Registry.LogTab = GHZ_REMOTE("UI/Tabs/LogTab")
	else
		-- 1. Core
		Registry.sData = require("./Core/sData.luau")
		Registry.fVar = require("./Core/fVar.luau")

		-- 2. Functional Modules
		Registry.Utils = require("./Modules/Utils.luau")
		Registry.Misc = require("./Modules/Misc.luau")
		Registry.Main = require("./Modules/Main.luau")
		Registry.Shop = require("./Modules/Shop.luau")
		Registry.Process = require("./Modules/Process.luau")
		Registry.Auto = require("./Modules/Auto.luau")
		Registry.EventDrive = require("./Modules/EventDrive.luau")

		-- 3. UI Modules
		Registry.Window = require("./UI/Window.luau")
		Registry.MainTab = require("./UI/Tabs/MainTab.luau")
		Registry.ShopTab = require("./UI/Tabs/ShopTab.luau")
		Registry.MiscTab = require("./UI/Tabs/MiscTab.luau")
		Registry.EventsTab = require("./UI/Tabs/EventsTab.luau")
		Registry.AutoTab = require("./UI/Tabs/AutoTab.luau")
		Registry.LogTab = require("./UI/Tabs/LogTab.luau")
	end

	return Registry
end

function EfHub.Initialize()
	local Registry = LoadModules()
	-- Initialize UI (ต้องทำก่อน เพราะ Window สร้าง Registry.Options = Fluent.Options)
	Registry.Window.Initialize(Registry)

	-- Initialize Modules (ตอนนี้ Registry.Options มีค่าแล้ว)
	Registry.Utils.Initialize(Registry)
	Registry.Misc.Initialize(Registry)
	Registry.Main.Initialize(Registry)
	Registry.Shop.Initialize(Registry)
	Registry.Process.Initialize(Registry)
	Registry.Auto.Initialize(Registry)
	Registry.EventDrive.Initialize(Registry)

	Registry.MainTab.Initialize(Registry)
	Registry.ShopTab.Initialize(Registry)
	Registry.AutoTab.Initialize(Registry)
	Registry.EventsTab.Initialize(Registry)
	Registry.MiscTab.Initialize(Registry)
	Registry.LogTab.Initialize(Registry)

	Registry.Window.Finalize()
	return Registry
end

function EfHub.RunTask(Registry)
	local fVar = Registry.fVar
	local Process = Registry.Process
	task.spawn(function()
		while task.wait(0.1) do
			if #fVar.actionQueue > 0 and not fVar.isProcessing then Process.processQueue() end
		end
	end)
end

return EfHub
