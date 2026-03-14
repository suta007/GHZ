local MainTab = {}

function MainTab.Initialize(reg)
	local Interface = reg.Interface
	local Tabs = reg.Tabs
	local Options = reg.Options
	local QuickSave = reg.Window.QuickSave
	Tabs.Main = Interface:AddTab({ Title = "Main", Icon = "rbxassetid://10723345661" })
	local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
	PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		Callback = function(Value)
			--[[ 		if Value then
			table.insert(actionQueue, {
				FuncName = AutoPlantsSeeds,
			})
		else
			isPlanting = false
		end ]]
			QuickSave()
		end,
	})
	PlantsSection:AddButton({
		Title = "Clear Selected Seeds",
		Callback = function()
			Options.ddPlantsSeeds:SetValue({})
		end,
	})
	PlantsSection:AddDropdown("ddPlantsSeeds", {
		Title = "Select Seeds",
		Values = { "1", "2", "3" }, -- PlantDataTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	PlantsSection:AddDropdown("ddPlantsPos", {
		Title = "Select Plants Position",
		Values = { "Player", "Random" },
		Default = "Player",
		Callback = function(Value)
			QuickSave()
		end,
	})
end
return MainTab
