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

return Misc
