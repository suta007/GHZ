local Misc = {}
local reg
local fVar
local isAntiLag = false

local AntiLagConnections = {}
local Terrain = workspace.Terrain
local Lighting = game:GetService("Lighting")

local PlantsESPFolderName = "PlantsESP"
local FruitESPFolderName = "FruitESP"
local ESPFruitConnection
local bGuiSession = {}
local CollectionService = game:GetService("CollectionService")
local CoreGui = game:GetService("CoreGui")
local GetSelectedItems

function Misc.Initialize(Registry)
	reg = Registry
	fVar = reg.fVar
	GetSelectedItems = reg.Utils.GetSelectedItems
	Misc.SetupTracker()
end

function Misc.AntiLag()
	-- Lighting
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	Lighting.Brightness = 2
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0
	Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

	-- Terrain Water
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1

	-- Workspace optimize: Targeted Folders Only
	local targetFolders = {
		workspace:FindFirstChild("ClientPlants"),
		workspace:FindFirstChild("MapPhysical"),
		workspace:FindFirstChild("Plots"),
	}

	local function ApplyToPart(v)
		-- ยกเว้นโฟลเดอร์ Shops
		--[[ 		local mapPhysical = workspace:FindFirstChild("MapPhysical")
		if mapPhysical then
			local shops = mapPhysical:FindFirstChild("Shops")
			if shops and v:IsDescendantOf(shops) then return end
		end ]]

		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") then
			v.Enabled = false
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		end
	end

	for _, folder in ipairs(targetFolders) do
		if folder then
			-- Scan current
			for i, v in ipairs(folder:GetDescendants()) do
				if i % 200 == 0 then task.wait() end
				ApplyToPart(v)
			end

			-- Hook for new elements
			table.insert(
				AntiLagConnections,
				folder.DescendantAdded:Connect(function(v)
					if isAntiLag then ApplyToPart(v) end
				end)
			)
		end
	end

	-- Rendering quality (safe)
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end

local function SetVisibility(obj, isHidden)
	if obj:IsA("BasePart") or obj:IsA("Decal") or obj:IsA("Texture") then
		if isHidden then
			if not obj:GetAttribute("OriginalTrans") then obj:SetAttribute("OriginalTrans", obj.Transparency) end
			obj.Transparency = 1

			if obj:IsA("BasePart") then
				if obj:GetAttribute("OriginalCollide") == nil then obj:SetAttribute("OriginalCollide", obj.CanCollide) end
				obj.CanCollide = false
			end
		else
			local origTrans = obj:GetAttribute("OriginalTrans")
			if origTrans then obj.Transparency = origTrans end

			if obj:IsA("BasePart") then
				local origCollide = obj:GetAttribute("OriginalCollide")
				if origCollide ~= nil then obj.CanCollide = origCollide end
			end
		end
	elseif obj:IsA("ParticleEmitter") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Trail") then
		if isHidden then
			if obj:GetAttribute("OriginalEnabled") == nil then obj:SetAttribute("OriginalEnabled", obj.Enabled) end
			obj.Enabled = false
		else
			local origEnabled = obj:GetAttribute("OriginalEnabled")
			if origEnabled ~= nil then obj.Enabled = origEnabled end
		end
	end
end

local function UpdateVisibilityFromAnchor(anchorName, state, isPlantCheck)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	for _, obj in ipairs(ClientPlants:GetDescendants()) do
		if obj.Name == anchorName then
			local parent = obj.Parent
			if parent then
				if isPlantCheck and parent:FindFirstChild("FruitAnchor") then continue end
				for _, sibling in ipairs(parent:GetChildren()) do
					SetVisibility(sibling, state)
				end
			end
		end
	end
end

function Misc.HidePlant(state)
	UpdateVisibilityFromAnchor("PlantAnchor", state, true)
end

function Misc.HideFruit(state)
	UpdateVisibilityFromAnchor("FruitAnchor", state, false)
end

local function CreatESP(espfolder, obj, uuid, txt1, txt2, arg)
	if not (espfolder and obj and uuid and txt1) then return end
	local priority = arg or 0
	if bGuiSession[uuid] then
		bGuiSession[uuid]:Destroy()
		bGuiSession[uuid] = nil
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
	if txt2 and txt2 ~= "" then
		textLabel.Text = string.format("%s\n%s", tostring(txt1), tostring(txt2))
	else
		textLabel.Text = tostring(txt1)
	end

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
	bGuiSession[uuid] = bgui
end

function Misc.SetEspPlant(obj)
	local Options = reg.Options
	if not Options.tgEspPlants.Value then return end

	local plant = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model")
	if not plant then return end
	local plantName = plant:GetAttribute("PlantType")
	if not plantName then return end

	local TargetFolder = gethui and gethui() or CoreGui
	local ESPFolder = TargetFolder:FindFirstChild(PlantsESPFolderName)
	local espPlantsList = GetSelectedItems(Options.ddEspPlants.Value)

	if table.find(espPlantsList, "NONE") then return end

	if table.find(espPlantsList, plantName) then
		local uuid = plant:GetAttribute("Uuid") or plant.Name
		local scale = plant:GetAttribute("HiddenNumber") or 0
		local Weight = plant:GetAttribute("PlantWeight") or 0
		local arg = 0
		if scale >= 2 then
			arg = 3
		elseif scale >= 1.5 then
			arg = 2
		elseif scale >= 1 then
			arg = 1
		end
		if Weight > 0 then
			CreatESP(ESPFolder, plant, uuid, "🌱 " .. plantName, string.format("Weight : %.2f kg", Weight), arg)
		else
			CreatESP(ESPFolder, plant, uuid, "🌱 " .. plantName, string.format("Scale : %.2f", scale), arg)
		end
	end
end

function Misc.EspPlants(State)
	local Options = reg.Options

	local TargetFolder = gethui and gethui() or CoreGui

	local oldFolder = TargetFolder:FindFirstChild(PlantsESPFolderName)
	if oldFolder then oldFolder:Destroy() end

	if State ~= true then return end
	local espPlantsList = GetSelectedItems(Options.ddEspPlants.Value)
	if table.find(espPlantsList, "NONE") then return end

	local ESPFolder = Instance.new("Folder")
	ESPFolder.Name = PlantsESPFolderName
	ESPFolder.Parent = TargetFolder

	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if ClientPlants then
		for _, plant in pairs(ClientPlants:GetChildren()) do
			Misc.SetEspPlant(plant)
		end
	end
end

function Misc.SetEspCrops(obj)
	local Options = reg.Options
	if not Options.tgEspCrops.Value then return end

	local fruit = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model")
	if not fruit then return end

	local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType"))
	if not fruitName then return end

	local TargetFolder = gethui and gethui() or CoreGui
	local ESPFolder = TargetFolder:FindFirstChild(FruitESPFolderName)
	local espFruitList = GetSelectedItems(Options.ddEspCrops.Value)

	if table.find(espFruitList, "NONE") then return end

	if table.find(espFruitList, fruitName) then
		local uuid = fruit:GetAttribute("Uuid") or fruitName
		local Weight = 0
		for i = 1, 3 do
			Weight = fruit:GetAttribute("FruitWeight") or fruit:GetAttribute("PlantWeight") or 0

			if Weight > 0 then break end

			task.wait(1)
		end

		local scale = fruit:GetAttribute("HiddenNumber") or 0
		local arg = 0
		if scale >= 2 then
			arg = 3
		elseif scale >= 1.5 then
			arg = 2
		elseif scale >= 1 then
			arg = 1
		end
		if Weight > 0 then
			CreatESP(ESPFolder, fruit, uuid, "🍎" .. fruitName, string.format("Weight : %.2f kg, Scale : %.2f", Weight, scale), arg)
		else
			CreatESP(ESPFolder, fruit, uuid, "🍎" .. fruitName, string.format("Scale : %.2f", scale), arg)
		end
	end
end

function Misc.EspCrops(State)
	local Options = reg.Options

	local TargetFolder = gethui and gethui() or CoreGui

	local oldFolder = TargetFolder:FindFirstChild(FruitESPFolderName)
	if oldFolder then oldFolder:Destroy() end
	if ESPFruitConnection then
		ESPFruitConnection:Disconnect()
		ESPFruitConnection = nil
	end
	if State ~= true then return end

	local espFruitList = GetSelectedItems(Options.ddEspCrops.Value)
	if table.find(espFruitList, "NONE") then return end

	local ESPFolder = Instance.new("Folder")
	ESPFolder.Name = FruitESPFolderName
	ESPFolder.Parent = TargetFolder

	for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
		--if prompt.Enabled then Misc.SetEspCrops(prompt) end
		Misc.SetEspCrops(prompt)
	end
	ESPFruitConnection = CollectionService:GetInstanceAddedSignal("HarvestPrompt"):Connect(function(obj)
		Misc.SetEspCrops(obj)
	end)
end

function Misc.SetupTracker()
	local ClientPlants = workspace:FindFirstChild("ClientPlants")

	if not ClientPlants then return end

	ClientPlants.DescendantAdded:Connect(function(newPlant)
		local Options = reg.Options
		task.wait(0.5)

		for _, obj in ipairs(newPlant:GetDescendants()) do
			if obj.Name == "PlantAnchor" then
				local parent = obj.Parent

				if Options.tgEspPlants.Value then
					if parent:GetAttribute("HarvestablePlant") then
						Misc.SetEspCrops(obj)
					else
						Misc.SetEspPlant(obj)
					end
				end

				if parent:GetAttribute("HarvestablePlant") then
					if Options.tgHideFruits.Value then
						for _, sibling in ipairs(obj.Parent:GetChildren()) do
							SetVisibility(sibling, true)
						end
					end
				else
					if Options.tgHidePlants.Value then
						for _, sibling in ipairs(parent:GetChildren()) do
							SetVisibility(sibling, true)
						end
					end
				end
			elseif obj.Name == "FruitAnchor" then
				local parent = obj.Parent
				if Options.tgEspCrops.Value then Misc.SetEspCrops(obj) end
				if Options.tgHideFruits.Value then
					for _, sibling in ipairs(parent:GetChildren()) do
						SetVisibility(sibling, true)
					end
				end
			end
		end
	end)
end

return Misc
