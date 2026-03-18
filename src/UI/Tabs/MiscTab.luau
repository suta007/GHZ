local MiscTab = {}
local reg

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
	local Misc = Registry.Misc
	local sData = Registry.sData

	local AutoSellTask

	Tabs.MiscTab = Interface:AddTab({ Title = "Misc", Icon = "flower" })
	local MiscSection = Tabs.MiscTab:AddCollapsibleSection("Misc", false)
	MiscSection:AddButton({
		Title = "Reset Control Var",
		Callback = function()
			reg.fVar.ResetControlVar()
		end,
	})
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
			if Value then Misc.AntiLag() end
			QuickSave()
		end,
	})

	AntiLagSection:AddToggle("tgHideFruits", {
		Title = "Hide Fruits",
		Default = false,
		Callback = function(Value)
			if Value then
				Misc.HideFruit(true)
			else
				Misc.HideFruit(false)
			end
			QuickSave()
		end,
	})

	AntiLagSection:AddToggle("tgHidePlants", {
		Title = "Hide Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				Misc.HidePlant(true)
			else
				Misc.HidePlant(false)
			end
			QuickSave()
		end,
	})

	local EspSection = Tabs.MiscTab:AddCollapsibleSection("Esp", false)
	EspSection:AddToggle("tgEspCrops", {
		Title = "Esp Crops",
		Default = false,
		Callback = function(Value)
			Misc.EspCrops(Value)
			QuickSave()
		end,
	})
	EspSection:AddButton({
		Title = "Clear Selected Crops",
		Callback = function()
			Options.ddEspCrops:SetValue({ NONE = true })
		end,
	})
	EspSection:AddDropdown("ddEspCrops", {
		Title = "Select Crops",
		Values = sData.PlantDataBlackTable,
		Default = { "NONE" },
		Multi = true,
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	EspSection:AddToggle("tgEspPlants", {
		Title = "Esp Plants",
		Default = false,
		Callback = function(Value)
			Misc.EspPlants(Value)
			QuickSave()
		end,
	})
	EspSection:AddButton({
		Title = "Clear Selected Plants",
		Callback = function()
			Options.ddEspPlants:SetValue({ NONE = true })
		end,
	})
	EspSection:AddDropdown("ddEspPlants", {
		Title = "Select Plants",
		Values = sData.PlantDataBlackTable,
		Default = { "NONE" },
		Multi = true,
		Searchable = true,
		Callback = function(Value)
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
