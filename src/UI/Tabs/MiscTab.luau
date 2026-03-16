local MiscTab = {}
local reg
local HideFruitsTask
local HidePlantsTask
local AntiLagTask

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local SellItems = RemoteEvents:WaitForChild("SellItems") :: RemoteFunction

function MiscTab.Initialize(Registry)
	reg = Registry
	local Options = Registry.Options
	local Interface = Registry.Interface
	local Tabs = Registry.Tabs
	local QuickSave = Registry.Window.QuickSave
	local actionQueue = Registry.fVar.actionQueue

	local AutoSellTask

	Tabs.MiscTab = Interface:AddTab({ Title = "Misc", Icon = "flower" })
	local NewPlayerSection = Tabs.MiscTab:AddCollapsibleSection("New Player", false)
	NewPlayerSection:AddToggle("tgNewPlayerSell", {
		Title = "New Playe Auto Sell",
		Default = false,
		Callback = function(Value)
			if Value then
				AutoSellTask = task.spawn(function()
					while true do
						table.insert(actionQueue, { FuncName = MiscTab.NewPlayerAutoSell, Args = {} })
						local delayTime = (tonumber(Options.ipNewPlayerSell.Value) or 5) * 60
						task.wait(delayTime)
					end
				end)
			else
				if AutoSellTask then
					task.cancel(AutoSellTask)
					AutoSellTask = nil
				end
			end
			--QuickSave()
		end,
	})
	NewPlayerSection:AddInput("ipNewPlayerSell", {
		Title = "Auto Sell Delay (Minutes)",
		Default = 5,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	local AntiLagSection = Tabs.MiscTab:AddCollapsibleSection("AntiLag", false)
	AntiLagSection:AddToggle("tgAntiLag", {
		Title = "AntiLag",
		Default = false,
		Callback = function(Value)
			if Value then
				AntiLagTask = task.spawn(function()
					while true do
						task.wait(1)
					end
				end)
			else
				if AntiLagTask then
					task.cancel(AntiLagTask)
					AntiLagTask = nil
				end
			end
			QuickSave()
		end,
	})

	--hide fruits toggle
	local HideFruitsSection = Tabs.MiscTab:AddCollapsibleSection("Hide Fruits", false)
	HideFruitsSection:AddToggle("tgHideFruits", {
		Title = "Hide Fruits",
		Default = false,
		Callback = function(Value)
			if Value then
				HideFruitsTask = task.spawn(function()
					while true do
						task.wait(1)
					end
				end)
			else
				if HideFruitsTask then
					task.cancel(HideFruitsTask)
					HideFruitsTask = nil
				end
			end
			QuickSave()
		end,
	})

	--hide plants toggle
	local HidePlantsSection = Tabs.MiscTab:AddCollapsibleSection("Hide Plants", false)
	HidePlantsSection:AddToggle("tgHidePlants", {
		Title = "Hide Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				HidePlantsTask = task.spawn(function()
					while true do
						task.wait(1)
					end
				end)
			else
				if HidePlantsTask then
					task.cancel(HidePlantsTask)
					HidePlantsTask = nil
				end
			end
			QuickSave()
		end,
	})
end

function MiscTab.NewPlayerAutoSell()
	local fVar = reg.fVar
	local SafeTeleport = reg.Utils.SafeTeleport
	local UnequipTools = reg.Utils.UnequipTools

	fVar.isSelling = true
	fVar.HarvestPause = true
	fVar.isPlanting = true
	UnequipTools() -- Call once before teleporting

	SafeTeleport(fVar.Pos.Sell)
	task.wait(0.5)

	SellItems:InvokeServer("SellAll")
	task.wait(2)
	SafeTeleport(reg.MySpawnPoint)
	task.wait(0.3)
	fVar.isSelling = false
	fVar.HarvestPause = false
	fVar.isPlanting = false
end

return MiscTab
