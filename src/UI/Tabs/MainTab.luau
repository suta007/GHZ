local MainTab = {}

local Interface
local Tabs
local Options
local QuickSave
local sData
local fVar
local Main
local actionQueue

function MainTab.Initialize(reg)
	Interface = reg.Interface
	Tabs = reg.Tabs
	Options = reg.Options
	QuickSave = reg.Window.QuickSave
	sData = reg.sData
	fVar = reg.fVar
	Main = reg.Main
	actionQueue = reg.fVar.actionQueue
	Tabs.Main = Interface:AddTab({ Title = "Main", Icon = "rbxassetid://10723345661" })
	local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
	Options.tgPlantsEnable = PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				Main.AutoPlantsSeeds()
			--[[ 				table.insert(actionQueue, {
					FuncName = Main.AutoPlantsSeeds,
				}) ]]
			else
				fVar.isPlanting = false
			end
			QuickSave()
		end,
	})
	PlantsSection:AddButton({
		Title = "Clear Selected Seeds",
		Callback = function()
			Options.ddPlantsSeeds:SetValue({})
		end,
	})
	Options.ddPlantsSeeds = PlantsSection:AddSearchableDropdown("ddPlantsSeeds", {
		Title = "Select Seeds",
		Values = sData.PlantDataTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	Options.ddPlantsPos = PlantsSection:AddDropdown("ddPlantsPos", {
		Title = "Select Plants Position",
		Values = { "Player", "Random", "Here" },
		Default = "Player",
		Callback = function(Value)
			QuickSave()
		end,
	})
end
return MainTab
