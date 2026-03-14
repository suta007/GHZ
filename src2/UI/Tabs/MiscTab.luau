--!nocheck
local MiscTab = {}

function MiscTab.Setup(tab, Options, SaveManager, Registry)
	local UIData = Registry.UIData
	local State = Registry.State
	local AntiLag = Registry.AntiLag
	local ESP = Registry.ESP

	-- 1. Misc Section
	local MiscSection = tab:AddCollapsibleSection("Misc", false)
	MiscSection:AddButton({
		Title = "Reset Control Variable",
		Callback = function()
			State:ResetControlVariable()
		end,
	})

	-- 2. Anti-Lag Section
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
					if State.isAntiLag then AntiLag.Restore() end
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
			Registry.Utils.HideFruit(Value)
			SaveManager:Save("Horizons")
		end,
	})
	AntiLagSection:AddToggle("tgHidePlant", {
		Title = "Hide Plant",
		Default = false,
		Callback = function(Value)
			Registry.Utils.HidePlant(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- 3. New Player Section
	local NewPlayerSection = tab:AddCollapsibleSection("New Player", false)
	NewPlayerSection:AddInput("ipNewDelay", {
		Title = "Delay timmes (Minute)",
		Default = 5,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	NewPlayerSection:AddToggle("tgNewAutoSell", {
		Title = "Auto Sell",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- 4. ESP Section
	local espSection = tab:AddCollapsibleSection("ESP", false)
	espSection:AddToggle("tgPlantsESP", {
		Title = "ESP Plants",
		Default = false,
		Callback = function(Value)
			ESP.TogglePlants(Value)
			SaveManager:Save("Horizons")
		end,
	})
	espSection:AddButton({
		Title = "Clear Selected Plants",
		Callback = function()
			Options.ddPlantsESP:SetValue({ NONE = true })
		end,
	})
	espSection:AddDropdown("ddPlantsESP", {
		Title = "Select Plants",
		Values = UIData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	espSection:AddDivider()
	espSection:AddToggle("tgFruitESP", {
		Title = "ESP Fruit",
		Default = false,
		Callback = function(Value)
			ESP.ToggleFruit(Value)
			SaveManager:Save("Horizons")
		end,
	})
	espSection:AddButton({
		Title = "Clear Selected Fruit",
		Callback = function()
			Options.ddFruitESP:SetValue({ NONE = true })
		end,
	})
	espSection:AddDropdown("ddFruitESP", {
		Title = "Select Fruit",
		Values = UIData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
end

return MiscTab
