local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("ContentProvider")
game:GetService("Workspace")
local v4 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = {
	v2:WaitForChild("Plants"):WaitForChild("Definitions"),
	v2:WaitForChild("Gears"):WaitForChild("Definitions"),
	v2:WaitForChild("Shop"):WaitForChild("Definitions"),
	v2:WaitForChild("Weather"),
	v2:WaitForChild("Quests"),
	v2:WaitForChild("RNGPacks")
}
local v_u_6 = {
	["ImageLabel"] = "Image",
	["ImageButton"] = "Image",
	["Decal"] = "Texture",
	["Texture"] = "Texture",
	["ParticleEmitter"] = "Texture",
	["Beam"] = "Texture",
	["Trail"] = "Texture"
}
local v_u_7 = { v2, game:GetService("StarterGui"), game:GetService("StarterPack") }
local function v_u_12(p8, p9)
	-- upvalues: (copy) v_u_12
	for _, v10 in pairs(p8) do
		local v11 = typeof(v10)
		if v11 == "string" and string.match(v10, "^rbxassetid://%d+$") then
			p9[v10] = true
		elseif v11 == "table" then
			v_u_12(v10, p9)
		end
	end
end
local function v_u_19(p13)
	-- upvalues: (copy) v_u_7, (copy) v_u_6
	for _, v14 in ipairs(v_u_7) do
		for _, v_u_15 in ipairs(v14:GetDescendants()) do
			local v_u_16 = v_u_6[v_u_15.ClassName]
			if v_u_16 then
				local v17, v18 = pcall(function()
					-- upvalues: (copy) v_u_15, (copy) v_u_16
					return v_u_15[v_u_16]
				end)
				if v17 and (typeof(v18) == "string" and string.match(v18, "^rbxassetid://%d+$")) then
					p13[v18] = true
				end
			end
		end
	end
end
local function v25()
	-- upvalues: (copy) v_u_5, (copy) v_u_12, (copy) v_u_19
	local v20 = {}
	for _, v21 in ipairs(v_u_5) do
		for _, v22 in ipairs(v21:GetDescendants()) do
			if v22:IsA("ModuleScript") then
				local v23, v24 = pcall(require, v22)
				if v23 then
					if typeof(v24) == "table" then
						v_u_12(v24, v20)
					end
				else
					warn("[PreloadController] Failed to require:", v22.Name, v24)
				end
			end
		end
	end
	v_u_19(v20)
	return v20
end
local v26 = v4:WaitForChild("LoadingScreenGui", 10)
if not v26 then
	warn("[PreloadController] LoadingScreenGui not found, aborting preload")
	return
end
print("[PreloadController] Starting preload...")
local v27 = Instance.new("ScreenGui")
v27.Name = "PreloadContainerGui"
v27.DisplayOrder = -100
v27.Parent = v4
local v28 = v25()
local v29 = {}
for v30 in pairs(v28) do
	local v31 = Instance.new("ImageLabel")
	v31.Size = UDim2.new(0, 1, 0, 1)
	v31.BackgroundTransparency = 1
	v31.ImageTransparency = 1
	v31.Image = v30
	v31.Parent = v27
	table.insert(v29, v31)
end
print("[PreloadController] Created " .. #v29 .. " ImageLabels for preloading")
local v32 = #v29
print("[PreloadController] Total assets to preload: " .. v32)
v26:SetAttribute("TotalAssets", v32)
v26:SetAttribute("LoadedCount", 0)
local v33 = {}
local v34 = 0
for _, v35 in ipairs(v29) do
	if v26:GetAttribute("Skipped") then
		break
	end
	table.insert(v33, v35)
	if #v33 >= 50 then
		v3:PreloadAsync(v33)
		v34 = v34 + #v33
		v26:SetAttribute("LoadedCount", v34)
		task.wait()
		v33 = {}
	end
end
if #v33 > 0 and not v26:GetAttribute("Skipped") then
	v3:PreloadAsync(v33)
	v34 = v34 + #v33
	v26:SetAttribute("LoadedCount", v34)
end
if v26:GetAttribute("Skipped") then
	print("[PreloadController] Skipped by user")
end
v26:SetAttribute("LoadingComplete", true)
print("[PreloadController] Preload complete! Loaded " .. v34 .. " assets")
v27.Enabled = false