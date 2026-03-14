--!nocheck
local MiscTab = {}

local State = require(script.Parent.Parent.Parent.Core.State)
local AntiLag = require(script.Parent.Parent.Parent.Modules.AntiLag)
local ESP = require(script.Parent.Parent.Parent.Modules.ESP)

function MiscTab.Setup(tab, Options, SaveManager)
	-- Anti-Lag Section
	local AntiLagSection = tab:AddCollapsibleSection("Anti-Lag", false)
	AntiLagSection:AddToggle("tgAntiLag", {
		Title = "Anti-Lag",
		Default = false,
		Callback = function(Value)
			pcall(function()
				if Value then 
					AntiLag.Apply() 
					State.isAntiLag = true 
				else 
					AntiLag.Restore() 
					State.isAntiLag = false 
				end
			end)
			SaveManager:Save("Horizons")
		end,
	})

	AntiLagSection:AddToggle("tgHideFruit", {
		Title = "Hide Fruit",
		Default = false,
		Callback = function(Value)
			AntiLag.UpdateVisibilityFromAnchor("FruitAnchor", Value, false)
			SaveManager:Save("Horizons")
		end,
	})

	AntiLagSection:AddToggle("tgHidePlant", {
		Title = "Hide Plant",
		Default = false,
		Callback = function(Value)
			AntiLag.UpdateVisibilityFromAnchor("PlantAnchor", Value, true)
			SaveManager:Save("Horizons")
		end,
	})

	-- ESP Section
	local espSection = tab:AddCollapsibleSection("ESP", false)
	espSection:AddToggle("tgPlantsESP", {
		Title = "ESP Plants",
		Default = false,
		Callback = function(Value)
			ESP.TogglePlants(Value)
			SaveManager:Save("Horizons")
		end,
	})
  
	espSection:AddToggle("tgFruitESP", {
		Title = "ESP Fruit",
		Default = false,
		Callback = function(Value)
			ESP.ToggleFruit(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- Misc Section
	local MiscSection = tab:AddCollapsibleSection("Misc", false)
	MiscSection:AddButton({
		Title = "Reset Control Variable",
		Callback = function()
			State:ResetControlVariable()
		end,
	})
end

return MiscTab
