--!nocheck
local ESP = {}

local CoreGui = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")

local State = require(script.Parent.Parent.Core.State)
local Constants = require(script.Parent.Parent.Core.Constants)

local Options = {}
local ESPFruitConnection = nil

function ESP.SetOptions(opts)
	Options = opts
end

local function GetSelectedItems(DropdownValue)
	local Items = {}
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then table.insert(Items, Value) end
		end
	end
	return Items
end

function ESP.Create(espfolder, obj, uuid, txt1, txt2, arg)
	if not (espfolder and obj and uuid and txt1) then return end
	local priority = arg or 0
	
	if State.bGuiSession[uuid] then
		State.bGuiSession[uuid]:Destroy()
		State.bGuiSession[uuid] = nil
	end

	local bgui = Instance.new("BillboardGui")
	bgui.Name = "ESP_" .. uuid
	bgui.Adornee = obj
	bgui.Size = UDim2.new(0, 200, 0, 80)
	bgui.StudsOffset = Vector3.new(0, 3.5, 0)
	bgui.AlwaysOnTop = true
	bgui.LightInfluence = 0
	bgui.Parent = espfolder

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = bgui
	textLabel.Size = UDim2.new(1, 0, 0, 0)
	textLabel.AutomaticSize = Enum.AutomaticSize.XY
	textLabel.BackgroundTransparency = 1
	textLabel.TextWrapped = false
	textLabel.Text = (txt2 and txt2 ~= "") and string.format("%s\n%s", tostring(txt1), tostring(txt2)) or tostring(txt1)

	if priority == 3 then
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 10)
	elseif priority == 2 then
		textLabel.TextColor3 = Color3.fromRGB(200, 50, 10)
	elseif priority == 1 then
		textLabel.TextColor3 = Color3.fromRGB(10, 200, 10)
	else
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	end

	textLabel.TextStrokeTransparency = 0
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.FredokaOne
	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	
	State.bGuiSession[uuid] = bgui
end

function ESP.SetPlant(obj)
	if not Options.tgPlantsESP.Value then return end
	local plant = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model")
	if not plant then return end
	local plantName = plant:GetAttribute("PlantType")
	if not plantName then return end

	local TargetFolder = (gethui and gethui()) or CoreGui
	local ESPFolder = TargetFolder:FindFirstChild(Constants.PlantsESPFolderName)
	local espPlantsList = GetSelectedItems(Options.ddPlantsESP.Value)

	if table.find(espPlantsList, "NONE") then return end

	if table.find(espPlantsList, plantName) then
		local uuid = plant:GetAttribute("Uuid") or plant.Name
		local scale = plant:GetAttribute("HiddenNumber") or 0
		local Weight = plant:GetAttribute("PlantWeight") or 0
		local arg = 0
		if scale >= 2 then arg = 3 elseif scale >= 1.5 then arg = 2 elseif scale >= 1 then arg = 1 end
		
		if Weight > 0 then
			ESP.Create(ESPFolder, plant, uuid, "🌱 " .. plantName, string.format("Weight : %.2f kg", Weight), arg)
		else
			ESP.Create(ESPFolder, plant, uuid, "🌱 " .. plantName, string.format("Scale : %.2f", scale), arg)
		end
	end
end

function ESP.TogglePlants(StateVal)
	local TargetFolder = (gethui and gethui()) or CoreGui
	local oldFolder = TargetFolder:FindFirstChild(Constants.PlantsESPFolderName)
	if oldFolder then oldFolder:Destroy() end

	if StateVal ~= true then return end
	local espPlantsList = GetSelectedItems(Options.ddPlantsESP.Value)
	if table.find(espPlantsList, "NONE") then return end

	local ESPFolder = Instance.new("Folder")
	ESPFolder.Name = Constants.PlantsESPFolderName
	ESPFolder.Parent = TargetFolder

	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if ClientPlants then
		for _, plant in pairs(ClientPlants:GetChildren()) do
			ESP.SetPlant(plant)
		end
	end
end

function ESP.SetFruit(obj)
	if not Options.tgFruitESP.Value then return end

	local fruit = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model")
	if not fruit then return end

	local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType"))
	if not fruitName then return end

	local TargetFolder = (gethui and gethui()) or CoreGui
	local ESPFolder = TargetFolder:FindFirstChild(Constants.FruitESPFolderName)
	local espFruitList = GetSelectedItems(Options.ddFruitESP.Value)

	if table.find(espFruitList, "NONE") then return end

	if table.find(espFruitList, fruitName) then
		local uuid = fruit:GetAttribute("Uuid") or fruitName
		local Weight = 0
		
		-- Wait for attributes to load
		task.spawn(function()
			for i = 1, 3 do
				Weight = fruit:GetAttribute("FruitWeight") or fruit:GetAttribute("PlantWeight") or 0
				if Weight > 0 then break end
				task.wait(1)
			end

			local scale = fruit:GetAttribute("HiddenNumber") or 0
			local arg = 0
			if scale >= 2 then arg = 3 elseif scale >= 1.5 then arg = 2 elseif scale >= 1 then arg = 1 end
			
			if Weight > 0 then
				ESP.Create(ESPFolder, fruit, uuid, "🍎" .. fruitName, string.format("Weight : %.2f kg", Weight), arg)
			else
				ESP.Create(ESPFolder, fruit, uuid, "🍎" .. fruitName, string.format("Scale : %.2f", scale), arg)
			end
		end)
	end
end

function ESP.ToggleFruit(StateVal)
	local TargetFolder = (gethui and gethui()) or CoreGui
	local oldFolder = TargetFolder:FindFirstChild(Constants.FruitESPFolderName)
	if oldFolder then oldFolder:Destroy() end
	
	if ESPFruitConnection then
		ESPFruitConnection:Disconnect()
		ESPFruitConnection = nil
	end
	
	if StateVal ~= true then return end

	local espFruitList = GetSelectedItems(Options.ddFruitESP.Value)
	if table.find(espFruitList, "NONE") then return end

	local ESPFolder = Instance.new("Folder")
	ESPFolder.Name = Constants.FruitESPFolderName
	ESPFolder.Parent = TargetFolder

	for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
		ESP.SetFruit(prompt)
	end
	ESPFruitConnection = CollectionService:GetInstanceAddedSignal("HarvestPrompt"):Connect(ESP.SetFruit)
end

return ESP
