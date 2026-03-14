--!nocheck
local Interface = {}

function Interface.Init(Fluent, SaveManager, InterfaceManager, Modules)
    local State = Modules.State
    local Constants = Modules.Constants
    local Utils = Modules.Utils
    local ESP = Modules.ESP
    local Automation = Modules.Automation
    local Remove = Modules.Remove
    
    local Services = require(script.Parent.Parent.Core.Services)

    local Window = Fluent:CreateWindow({
        Title = "Garden Horizons",
        SubTitle = "by EfHub Modular v " .. Constants.Version,
        TabWidth = 100,
        Size = UDim2.fromOffset(1400, 800),
        Resize = true,
        MinSize = Vector2.new(580, 460),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.RightControl,
    })

    local Tabs = {
        Main = Window:AddTab({ Title = "Main", Icon = "house" }),
        Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
        Auto = Window:AddTab({ Title = "Automatic", Icon = "bot" }),
        Event = Window:AddTab({ Title = "Event", Icon = "calendar" }),
        Misc = Window:AddTab({ Title = "Misc", Icon = "component" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    }
    Window:SelectTab(1)

    local Options = Fluent.Options
    local FruitConnectionRef = { Value = nil }

    local function getShopData(path)
        local names = { "ALL" }
        for _, item in pairs(require(Services.ShopData[path]).ShopData) do
            table.insert(names, item.Name)
        end
        return names
    end

    local SeedShopTable = getShopData("SeedShopData")
    local GearShopTable = getShopData("GearShopData")

    local PlantDataTable = { "ALL" }
    local SeedDataTable = { "ALL" }
    for PlantName, _ in pairs(require(Services.PlantData)) do
        table.insert(PlantDataTable, PlantName)
        table.insert(SeedDataTable, PlantName .. " Seed")
    end
    local MutationDataTable = { "ALL" }
    for MutationName, _ in pairs(require(Services.MutationData)) do
        table.insert(MutationDataTable, MutationName)
    end

    local PlantDataBlackTable = table.clone(PlantDataTable)
    PlantDataBlackTable[1] = "NONE"
    local MutationDataBlackTable = table.clone(MutationDataTable)
    MutationDataBlackTable[1] = "NONE"

    -- Floating Button for Android
    local function createFloatingButton()
        local ToggleGui = Instance.new("ScreenGui")
        local ToggleButton = Instance.new("TextButton")
        ToggleGui.Name = "EfHub_Toggle"
        ToggleGui.Parent = game:GetService("CoreGui")
        ToggleGui.ResetOnSpawn = false
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Parent = ToggleGui
        ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 100)
        ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
        ToggleButton.Size = UDim2.new(0, 50, 0, 50)
        ToggleButton.Text = "EfHub"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.Draggable = true
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 25)
        UICorner.Parent = ToggleButton
        ToggleButton.MouseButton1Click:Connect(function()
            pcall(function()
                if Window.GUI then Window.GUI.Enabled = not Window.GUI.Enabled
                elseif Window.Instance then Window.Instance.Enabled = not Window.Instance.Enabled
                elseif Window.Root then Window.Root.Visible = not Window.Root.Visible end
            end)
        end)
    end
    createFloatingButton()

    -- QuickSave function helper
    local function QuickSave()
        if not State.IsLoading then SaveManager:Save("Horizons") end
    end

    -- Main Tab
    local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
    PlantsSection:AddToggle("tgPlantsEnable", {
        Title = "Auto Plants", Default = false,
        Callback = function(Value)
            if Value then table.insert(State.actionQueue, { FuncName = Automation.AutoPlantsSeeds, Options = Options }) else State.isPlanting = false end
            QuickSave()
        end,
    })
    PlantsSection:AddButton({ Title = "Clear Selected Seeds", Callback = function() Options.ddPlantsSeeds:SetValue({}) end })
    PlantsSection:AddDropdown("ddPlantsSeeds", { Title = "Select Seeds", Values = PlantDataTable, Multi = true, Default = {}, Searchable = true, Callback = QuickSave })
    PlantsSection:AddDropdown("ddPlantsPos", { Title = "Select Plants Position", Values = { "Player", "Random" }, Default = "Player", Callback = QuickSave })

    local HarvestSection = Tabs.Main:AddCollapsibleSection("Harvest", false)
    HarvestSection:AddToggle("tgHarvestEnable", {
        Title = "Auto Harvest", Default = false,
        Callback = function(Value)
            QuickSave()
            table.clear(State.HarVestCropsList)
            if not Value then State.isHarvesting = false end
        end,
    })
    HarvestSection:AddDivider()
    HarvestSection:AddButton({ Title = "Clear Selected Crops", Callback = function() Options.ddHarvestCrops:SetValue({ ALL = true }) end })
    HarvestSection:AddDropdown("ddHarvestCrops", { Title = "Select Crops", Values = PlantDataTable, Multi = true, Default = { "ALL" }, Searchable = true, Callback = QuickSave })
    HarvestSection:AddButton({ Title = "Clear Backlist Crops", Callback = function() Options.ddHarvestBlackCrops:SetValue({ NONE = true }) end })
    HarvestSection:AddDropdown("ddHarvestBlackCrops", { Title = "Blacklist Crops", Values = PlantDataBlackTable, Multi = true, Default = { "NONE" }, Searchable = true, Callback = QuickSave })
    HarvestSection:AddDivider()
    HarvestSection:AddButton({ Title = "Clear Selected Mutant", Callback = function() Options.ddHarvestMutants:SetValue({ ALL = true }) end })
    HarvestSection:AddDropdown("ddHarvestMutants", { Title = "Select Mutants", Values = MutationDataTable, Multi = true, Default = { "ALL" }, Searchable = true, Callback = QuickSave })
    HarvestSection:AddButton({ Title = "Clear Backlist Mutant", Callback = function() Options.ddHarvestBlackMutants:SetValue({ NONE = true }) end })
    HarvestSection:AddDropdown("ddHarvestBlackMutants", { Title = "Blacklist Mutants", Values = MutationDataBlackTable, Multi = true, Default = { "NONE" }, Searchable = true, Callback = QuickSave })
    HarvestSection:AddDivider()
    HarvestSection:AddDropdown("ddRipeness", { Title = "Ripeness Stage", Values = { "ALL", "Unripe", "Ripened", "Lush" }, Default = { "Lush" }, Multi = true, Callback = QuickSave })
    HarvestSection:AddInput("ipRipenessMulti", { Title = "Ripeness Multiplier", Default = 3, Numeric = false, Finished = false, Callback = QuickSave })
    HarvestSection:AddDropdown("ddBlackRipeness", { Title = "Backlist Ripeness Stage", Values = { "NONE", "Unripe", "Ripened", "Lush" }, Default = { "NONE" }, Multi = true, Callback = QuickSave })
    HarvestSection:AddDivider()
    HarvestSection:AddDropdown("ddVariant", { Title = "Variant", Values = { "ALL", "Silver", "Gold" }, Default = { "ALL" }, Multi = true, Callback = QuickSave })
    HarvestSection:AddDropdown("ddBlackVariant", { Title = "Backlist Variant", Values = { "NONE", "Silver", "Gold" }, Default = { "NONE" }, Multi = true, Callback = QuickSave })
    HarvestSection:AddDivider()
    HarvestSection:AddDropdown("ddWeight", { Title = "Weight", Values = { "Below", "Above" }, Default = "Below", Multi = false, Callback = QuickSave })
    HarvestSection:AddInput("ipWeight", { Title = "Weight Value", Default = 0, Numeric = true, Finished = true, Callback = QuickSave })

    local SellSection = Tabs.Main:AddCollapsibleSection("Sell", false)
    SellSection:AddToggle("tgSellCropsEnable", { Title = "Sell Enabled", Default = false, Callback = QuickSave })

    -- Shop Tab
    local BuySeedSection = Tabs.Shop:AddCollapsibleSection("Buy Seed", false)
    BuySeedSection:AddToggle("tgBuySeedEnable", {
        Title = "Auto Buy Seed", Default = false,
        Callback = function(Value)
            if Value then
                local SeedShop = Services.GetShopData:InvokeServer("SeedShop")
                if SeedShop then table.insert(State.actionQueue, { FuncName = Automation.AutoBuySeed, args = SeedShop.Items, Options = Options }) end
            end
            QuickSave()
        end,
    })
    BuySeedSection:AddButton({ Title = "Clear Selected Seeds", Callback = function() Options.ddBuySeeds:SetValue({}) end })
    BuySeedSection:AddDropdown("ddBuySeeds", { Title = "Select Seeds", Values = SeedShopTable, Multi = true, Default = {}, Searchable = true, Callback = QuickSave })

    local BuyGearSection = Tabs.Shop:AddCollapsibleSection("Buy Gear", false)
    BuyGearSection:AddToggle("tgBuyGearEnable", {
        Title = "Auto Buy Gear", Default = false,
        Callback = function(Value)
            if Value then
                local GearShop = Services.GetShopData:InvokeServer("GearShop")
                if GearShop then table.insert(State.actionQueue, { FuncName = Automation.AutoBuyGear, args = GearShop.Items, Options = Options }) end
            end
            QuickSave()
        end,
    })
    BuyGearSection:AddButton({ Title = "Clear Selected Gears", Callback = function() Options.ddBuyGear:SetValue({}) end })
    BuyGearSection:AddDropdown("ddBuyGear", { Title = "Select Gears", Values = GearShopTable, Multi = true, Default = {}, Searchable = true, Callback = QuickSave })

    -- Automatic Tab
    local QuestSection = Tabs.Auto:AddCollapsibleSection("Quest", false)
    QuestSection:AddToggle("tgQuestEnable", {
        Title = "Auto Claim Quest", Default = false,
        Callback = function(Value)
            if Value then Services.RemoteEvents:WaitForChild("RequestQuests"):FireServer() end
            QuickSave()
        end,
    })

    local RemoveSection = Tabs.Auto:AddCollapsibleSection("Remove Plants", false)
    RemoveSection:AddToggle("tgRemovePlantsEnable", { Title = "Auto Remove Plants", Default = false, Callback = QuickSave })
    RemoveSection:AddButton({ Title = "Clear Selected Plants", Callback = function() Options.ddRemovePlants:SetValue({}) end })
    RemoveSection:AddDropdown("ddRemovePlants", { Title = "Select Remove Plants", Values = PlantDataTable, Default = {}, Multi = true, Searchable = true, Callback = QuickSave })
    RemoveSection:AddDropdown("ddRemovePlantsScale", { Title = "Plants Scale Threshold", Values = { "Below", "Above" }, Default = "Below", Multi = false, Callback = QuickSave })
    RemoveSection:AddInput("ipRemovePlantsScale", { Title = "Plants Scale Value", Default = 0, Numeric = true, Finished = false, Callback = QuickSave })

    local RemoveFruitSection = Tabs.Auto:AddCollapsibleSection("Remove Fruit", false)
    RemoveFruitSection:AddToggle("tgRemoveFruitEnable", { Title = "Auto Remove Fruit", Default = false, Callback = QuickSave })
    RemoveFruitSection:AddDivider()
    RemoveFruitSection:AddButton({ Title = "Clear Selected Remove Crops", Callback = function() Options.ddRemoveCrops:SetValue({ ALL = true }) end })
    RemoveFruitSection:AddDropdown("ddRemoveCrops", { Title = "Select Remove Crops", Values = PlantDataTable, Multi = true, Default = { "ALL" }, Searchable = true, Callback = QuickSave })
    RemoveFruitSection:AddButton({ Title = "Clear Blacklist Remove Crops", Callback = function() Options.ddRemoveBlackCrops:SetValue({ NONE = true }) end })
    RemoveFruitSection:AddDropdown("ddRemoveBlackCrops", { Title = "Blacklist Remove Crops", Values = PlantDataBlackTable, Multi = true, Default = { "NONE" }, Searchable = true, Callback = QuickSave })
    RemoveFruitSection:AddDivider()
    RemoveFruitSection:AddButton({ Title = "Clear Selected Mutant", Callback = function() Options.ddRemoveMutants:SetValue({ ALL = true }) end })
    RemoveFruitSection:AddDropdown("ddRemoveMutants", { Title = "Select Mutants", Values = MutationDataTable, Multi = true, Default = { "ALL" }, Searchable = true, Callback = QuickSave })
    RemoveFruitSection:AddButton({ Title = "Clear Blacklist Mutant", Callback = function() Options.ddRemoveBlackMutants:SetValue({ NONE = true }) end })
    RemoveFruitSection:AddDropdown("ddRemoveBlackMutants", { Title = "Blacklist Mutants", Values = MutationDataBlackTable, Multi = true, Default = { "NONE" }, Searchable = true, Callback = QuickSave })
    RemoveFruitSection:AddDivider()
    RemoveFruitSection:AddDropdown("ddRemoveRipeness", { Title = "Ripeness Stage", Values = { "ALL", "Unripe", "Ripened", "Lush" }, Default = { "ALL" }, Multi = true, Callback = QuickSave })
    RemoveFruitSection:AddInput("ipRemoveRipenessMulti", { Title = "Ripeness Multiplier", Default = 0, Numeric = false, Finished = false, Callback = QuickSave })
    RemoveFruitSection:AddDropdown("ddRemoveBlackRipeness", { Title = "Blacklist Ripeness Stage", Values = { "NONE", "Unripe", "Ripened", "Lush" }, Default = { "NONE" }, Multi = true, Callback = QuickSave })
    RemoveFruitSection:AddDivider()
    RemoveFruitSection:AddDropdown("ddRemoveVariant", { Title = "Variant", Values = { "ALL", "Silver", "Gold" }, Default = { "ALL" }, Multi = true, Callback = QuickSave })
    RemoveFruitSection:AddDropdown("ddRemoveBlackVariant", { Title = "Blacklist Variant", Values = { "NONE", "Silver", "Gold" }, Default = { "NONE" }, Multi = true, Callback = QuickSave })
    RemoveFruitSection:AddDivider()
    RemoveFruitSection:AddDropdown("ddRemoveWeight", { Title = "Weight Threshold", Values = { "Below", "Above" }, Default = "Below", Multi = false, Callback = QuickSave })
    RemoveFruitSection:AddInput("ipRemoveWeight", { Title = "Weight Value", Default = 0, Numeric = true, Finished = true, Callback = QuickSave })
    RemoveFruitSection:AddDivider()
    RemoveFruitSection:AddDropdown("ddRemoveScale", { Title = "Scale Threshold", Values = { "Below", "Above" }, Default = "Below", Multi = false, Callback = QuickSave })
    RemoveFruitSection:AddInput("ipRemoveScale", { Title = "Scale Value", Default = 0, Numeric = true, Finished = true, Callback = QuickSave })

    -- Event Tab
    local MannySection = Tabs.Event:AddCollapsibleSection("Manny Mishap", false)
    MannySection:AddToggle("tgMannyMishapEnable", { Title = "Auto Manny Mishap Collect", Default = false, Callback = QuickSave })

    -- Misc Tab
    local MiscSection = Tabs.Misc:AddCollapsibleSection("Misc", false)
    MiscSection:AddButton({ Title = "Reset Control Variable", Callback = function() State:ResetControlVariable() end })
    
    local AntiLagSection = Tabs.Misc:AddCollapsibleSection("Anti-Lag", false)
    AntiLagSection:AddToggle("tgAntiLag", {
        Title = "Anti-Lag", Default = false,
        Callback = function(Value)
            pcall(function() if Value then Utils.ApplyAntiLag() State.isAntiLag = true else if State.isAntiLag then Utils.RestoreAntiLag() end State.isAntiLag = false end end)
            QuickSave()
        end,
    })
    AntiLagSection:AddToggle("tgHideFruit", { Title = "Hide Fruit", Default = false, Callback = function(Value) Utils.UpdateVisibilityFromAnchor("FruitAnchor", Value, false) QuickSave() end })
    AntiLagSection:AddToggle("tgHidePlant", { Title = "Hide Plant", Default = false, Callback = function(Value) Utils.UpdateVisibilityFromAnchor("PlantAnchor", Value, true) QuickSave() end })

    local NewPlayerSection = Tabs.Misc:AddCollapsibleSection("New Player", false)
    NewPlayerSection:AddInput("ipNewDelay", { Title = "Delay times (Minute)", Default = 5, Numeric = true, Finished = true, Callback = QuickSave })
    NewPlayerSection:AddToggle("tgNewAutoSell", { Title = "Auto Sell", Default = false, Callback = QuickSave })

    local espSection = Tabs.Misc:AddCollapsibleSection("ESP", false)
    espSection:AddToggle("tgPlantsESP", { Title = "ESP Plants", Default = false, Callback = function(Value) ESP.espPlants(Value, Options, Utils) QuickSave() end })
    espSection:AddButton({ Title = "Clear Selected Plants", Callback = function() Options.ddPlantsESP:SetValue({ NONE = true }) end })
    espSection:AddDropdown("ddPlantsESP", { Title = "Select Plants", Values = PlantDataBlackTable, Multi = true, Default = { "NONE" }, Searchable = true, Callback = QuickSave })
    espSection:AddDivider()
    espSection:AddToggle("tgFruitESP", { Title = "ESP Fruit", Default = false, Callback = function(Value) ESP.espFruit(Value, Options, Utils, FruitConnectionRef) QuickSave() end })
    espSection:AddButton({ Title = "Clear Selected Fruit", Callback = function() Options.ddFruitESP:SetValue({ NONE = true }) end })
    espSection:AddDropdown("ddFruitESP", { Title = "Select Fruit", Values = PlantDataBlackTable, Multi = true, Default = { "NONE" }, Searchable = true, Callback = QuickSave })

    -- Settings
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    InterfaceManager:SetFolder("EfHub")
    SaveManager:SetFolder("EfHub/HRZ")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    task.spawn(function()
        while not SaveManager.Options.SaveManager_ConfigList do task.wait() end
        SaveManager.Options.SaveManager_ConfigList:SetValue("Horizons")
        SaveManager:Load("Horizons")
        task.wait(1)
        State.IsLoading = false
        Fluent:Notify({ Title = "EfHub", Content = "Settings loaded automatically", Duration = 3 })
    end)

    return Options
end

return Interface
