--!nocheck
local MiscTab = {}

function MiscTab.Setup(tab, Options, SaveManager, Registry)
	local State = Registry.State
	local AntiLag = Registry.AntiLag
	local ESP = Registry.ESP

	-- Anti-Lag Section
	local AntiLagSection = tab:AddCollapsibleSection("Anti-Lag", false)
	AntiLagSection:AddToggle("tgAntiLag", {
		Title = "Anti-Lag",
		Default = false,
		Callback = function(Value)
			if Value then AntiLag.Apply() else AntiLag.Restore() end
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
