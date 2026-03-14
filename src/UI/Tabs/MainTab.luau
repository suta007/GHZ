local MainTab = {}

function MainTab.Initialize(reg)
	local Interface = reg.Interface
	local Tabs = reg.Tabs
	local Options = reg.Options
	Tabs.Main = Interface:AddTab({ Title = "Main", Icon = "house" })
	local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
	PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		--[[ 	Callback = function(Value)
		if Value then
			table.insert(actionQueue, {
				FuncName = AutoPlantsSeeds,
			})
		else
			isPlanting = false
		end
		if QuickSave then QuickSave() end
	end, ]]
	})
end
return MainTab
