local Misc = {}
local reg
local fVar
local isAntiLag = false

local AntiLagConnections = {}
local Terrain = workspace.Terrain
local Lighting = game:GetService("Lighting")

function Misc.Initialize(Registry)
	reg = Registry
	fVar = reg.fVar
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

return Misc
