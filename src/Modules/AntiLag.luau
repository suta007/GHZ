--!nocheck
local AntiLag = {}

local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain

local State = require(script.Parent.Parent.Core.State)

local SettingCache = {
	GlobalShadows = Lighting.GlobalShadows,
	FogEnd = Lighting.FogEnd,
	Brightness = Lighting.Brightness,
	EnvDiffuse = Lighting.EnvironmentDiffuseScale,
	EnvSpecular = Lighting.EnvironmentSpecularScale,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	WaterWaveSize = Terrain.WaterWaveSize,
	WaterWaveSpeed = Terrain.WaterWaveSpeed,
	WaterReflectance = Terrain.WaterReflectance,
	WaterTransparency = Terrain.WaterTransparency,
}
local AntiLagConnections = {}

local function ApplyToPart(v)
	local mapPhysical = workspace:FindFirstChild("MapPhysical")
	if mapPhysical then
		local shops = mapPhysical:FindFirstChild("Shops")
		if shops and v:IsDescendantOf(shops) then return end
	end

	if v:IsA("BasePart") then
		v.Material = Enum.Material.SmoothPlastic
		v.Reflectance = 0
	elseif v:IsA("ParticleEmitter") then
		v.Enabled = false
	elseif v:IsA("Decal") or v:IsA("Texture") then
		v.Transparency = 1
	end
end

local function RestorePart(v)
	local mapPhysical = workspace:FindFirstChild("MapPhysical")
	if mapPhysical then
		local shops = mapPhysical:FindFirstChild("Shops")
		if shops and v:IsDescendantOf(shops) then return end
	end

	if v:IsA("BasePart") then
		v.Material = Enum.Material.Plastic
		v.Reflectance = 0
	elseif v:IsA("ParticleEmitter") then
		v.Enabled = true
	elseif v:IsA("Decal") or v:IsA("Texture") then
		v.Transparency = 0
	end
end

function AntiLag.Apply()
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	Lighting.Brightness = 2
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0
	Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1

	local targetFolders = {
		workspace:FindFirstChild("ClientPlants"),
		workspace:FindFirstChild("MapPhysical"),
	}

	for _, folder in ipairs(targetFolders) do
		if folder then
			for i, v in ipairs(folder:GetDescendants()) do
				if i % 200 == 0 then task.wait() end
				ApplyToPart(v)
			end

			table.insert(
				AntiLagConnections,
				folder.DescendantAdded:Connect(function(v)
					if State.isAntiLag then ApplyToPart(v) end
				end)
			)
		end
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end

function AntiLag.Restore()
	for _, conn in ipairs(AntiLagConnections) do
		if conn then conn:Disconnect() end
	end
	table.clear(AntiLagConnections)

	Lighting.GlobalShadows = SettingCache.GlobalShadows
	Lighting.FogEnd = SettingCache.FogEnd
	Lighting.Brightness = SettingCache.Brightness
	Lighting.EnvironmentDiffuseScale = SettingCache.EnvDiffuse
	Lighting.EnvironmentSpecularScale = SettingCache.EnvSpecular
	Lighting.OutdoorAmbient = SettingCache.OutdoorAmbient

	Terrain.WaterWaveSize = SettingCache.WaterWaveSize
	Terrain.WaterWaveSpeed = SettingCache.WaterWaveSpeed
	Terrain.WaterReflectance = SettingCache.WaterReflectance
	Terrain.WaterTransparency = SettingCache.WaterTransparency

	local targetFolders = {
		workspace:FindFirstChild("ClientPlants"),
		workspace:FindFirstChild("MapPhysical"),
	}

	for _, folder in ipairs(targetFolders) do
		if folder then
			for i, v in ipairs(folder:GetDescendants()) do
				if i % 200 == 0 then task.wait() end
				RestorePart(v)
			end
		end
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end)
end

function AntiLag.SetVisibility(obj, isHidden)
	if obj:IsA("BasePart") or obj:IsA("Decal") or obj:IsA("Texture") then
		if isHidden then
			if not obj:GetAttribute("OriginalTrans") then obj:SetAttribute("OriginalTrans", obj.Transparency) end
			obj.Transparency = 1
		else
			local orig = obj:GetAttribute("OriginalTrans")
			if orig then obj.Transparency = orig end
		end
	elseif obj:IsA("ParticleEmitter") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Trail") then
		if isHidden then
			if obj:GetAttribute("OriginalEnabled") == nil then obj:SetAttribute("OriginalEnabled", obj.Enabled) end
			obj.Enabled = false
		else
			local orig = obj:GetAttribute("OriginalEnabled")
			if orig ~= nil then obj.Enabled = orig end
		end
	end
end

function AntiLag.UpdateVisibilityFromAnchor(anchorName, state, isPlantCheck)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	for _, obj in ipairs(ClientPlants:GetDescendants()) do
		if obj.Name == anchorName then
			local parent = obj.Parent
			if parent then
				if isPlantCheck and parent:FindFirstChild("FruitAnchor") then continue end
				for _, sibling in ipairs(parent:GetChildren()) do
					AntiLag.SetVisibility(sibling, state)
				end
			end
		end
	end
end

return AntiLag
