--!nocheck
local AntiLag = {}
local Registry = nil
local State = nil

local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain

function AntiLag.Initialize(reg)
	Registry = reg
	State = reg.State
end

function AntiLag.Apply()
	pcall(function()
		settings().Rendering.QualityLevel = "Level01"
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		Terrain.WaterWaveSize = 0
		Terrain.WaterWaveSpeed = 0
		Terrain.WaterReflectance = 0
		Terrain.WaterTransparency = 0

		for _, v in ipairs(game:GetDescendants()) do
			if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
				v.Material = Enum.Material.Plastic
				v.Reflectance = 0
			elseif v:IsA("Decal") or v:IsA("Texture") then
				v.Transparency = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Enabled = false
			elseif v:IsA("Explosion") then
				v.BlastPressure = 0
				v.BlastRadius = 0
			end
		end
	end)
end

function AntiLag.Restore()
	-- Simple restore by resetting quality level (may not fully revert all material changes)
	pcall(function()
		settings().Rendering.QualityLevel = "Automatic"
		Lighting.GlobalShadows = true
	end)
end

return AntiLag
