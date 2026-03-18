local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = require(v2:WaitForChild("Event"):WaitForChild("MannyMishapRewards"))
local v_u_5 = require(v2:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions"))
local v_u_6 = require(v2:WaitForChild("RNGPacks"):WaitForChild("SeedPackDefinitions"))
local v_u_7 = require(v2:WaitForChild("Gears"):WaitForChild("Definitions"):WaitForChild("GearDefinitions"))
local v8 = v1.LocalPlayer
if not v8.Character then
	v8.CharacterAdded:Wait()
end
local v_u_9 = v8:WaitForChild("PlayerGui"):WaitForChild("MannyMishapRewards")
local v_u_10 = v_u_9:WaitForChild("Background")
local v_u_11 = v_u_10:WaitForChild("ScrollingFrame")
local v_u_12 = v_u_11:WaitForChild("Template")
local v13 = v_u_10:WaitForChild("Close")
local v_u_14 = v_u_10:WaitForChild("Tooltip")
local v_u_15 = v_u_14:WaitForChild("ItemName")
local v_u_16 = v4.SEED_PACKS
local v_u_17 = v4.GEARS
local v_u_18 = v4.SEEDS
local v_u_19 = v8:GetMouse()
local v_u_20 = nil
local function v65()
	-- upvalues: (copy) v_u_11, (copy) v_u_12, (copy) v_u_16, (copy) v_u_17, (copy) v_u_18, (copy) v_u_6, (copy) v_u_5, (copy) v_u_7, (copy) v_u_15, (copy) v_u_14, (ref) v_u_20, (copy) v_u_3, (copy) v_u_10, (copy) v_u_19
	for _, v21 in ipairs(v_u_11:GetChildren()) do
		if v21 ~= v_u_12 and (v21:IsA("GuiObject") and not (v21:IsA("UIGridLayout") or (v21:IsA("UIPadding") or v21:IsA("UIStroke")))) then
			v21:Destroy()
		end
	end
	local v22 = v_u_16
	local v23 = 0
	for _, v24 in ipairs(v22) do
		v23 = v23 + v24.Weight
	end
	local v25 = v_u_17
	local v26 = 0
	for _, v27 in ipairs(v25) do
		v26 = v26 + v27.Weight
	end
	local v28 = v23 + v26
	local v29 = v_u_18
	local v30 = 0
	for _, v31 in ipairs(v29) do
		v30 = v30 + v31.Weight
	end
	local v32 = v28 + v30
	local v33 = {}
	for _, v34 in ipairs(v_u_16) do
		local v35 = {
			["Name"] = v34.Name
		}
		local v36 = v34.Name
		local v37 = v_u_6[v36]
		local v38
		if v37 then
			v38 = v37.Image or ""
		else
			local v39 = v36:match("^(.+) Seed$")
			local v40 = v39 and v_u_5[v39]
			if v40 then
				v38 = v40.SeedAssetId or ""
			else
				local v41 = v_u_7.Gears[v36]
				if v41 then
					v38 = v41.IconAssetId or ""
				else
					warn("[MannyMishapUIController] No image found for: " .. v36)
					v38 = ""
				end
			end
		end
		v35.Image = v38
		v35.Chance = v34.Weight / v32
		table.insert(v33, v35)
	end
	for _, v42 in ipairs(v_u_17) do
		local v43 = {
			["Name"] = v42.Name
		}
		local v44 = v42.Name
		local v45 = v_u_6[v44]
		local v46
		if v45 then
			v46 = v45.Image or ""
		else
			local v47 = v44:match("^(.+) Seed$")
			local v48 = v47 and v_u_5[v47]
			if v48 then
				v46 = v48.SeedAssetId or ""
			else
				local v49 = v_u_7.Gears[v44]
				if v49 then
					v46 = v49.IconAssetId or ""
				else
					warn("[MannyMishapUIController] No image found for: " .. v44)
					v46 = ""
				end
			end
		end
		v43.Image = v46
		v43.Chance = v42.Weight / v32
		table.insert(v33, v43)
	end
	for _, v50 in ipairs(v_u_18) do
		local v51 = {
			["Name"] = v50.Name
		}
		local v52 = v50.Name
		local v53 = v_u_6[v52]
		local v54
		if v53 then
			v54 = v53.Image or ""
		else
			local v55 = v52:match("^(.+) Seed$")
			local v56 = v55 and v_u_5[v55]
			if v56 then
				v54 = v56.SeedAssetId or ""
			else
				local v57 = v_u_7.Gears[v52]
				if v57 then
					v54 = v57.IconAssetId or ""
				else
					warn("[MannyMishapUIController] No image found for: " .. v52)
					v54 = ""
				end
			end
		end
		v51.Image = v54
		v51.Chance = v50.Weight / v32
		table.insert(v33, v51)
	end
	table.sort(v33, function(p58, p59)
		return p58.Chance > p59.Chance
	end)
	for _, v_u_60 in ipairs(v33) do
		local v61 = v_u_12:Clone()
		v61.Name = v_u_60.Name
		v61.Visible = true
		local v62 = string.format("%.2f%%", v_u_60.Chance * 100)
		v61:FindFirstChild("Item").Image = v_u_60.Image
		v61:FindFirstChild("Chance").Text = v62
		local v63 = v61:FindFirstChild("Item")
		v63.MouseEnter:Connect(function()
			-- upvalues: (copy) v_u_60, (ref) v_u_15, (ref) v_u_14, (ref) v_u_20, (ref) v_u_3, (ref) v_u_10, (ref) v_u_19
			v_u_15.Text = v_u_60.Name
			v_u_14.Visible = true
			if v_u_20 then
				v_u_20:Disconnect()
			end
			v_u_20 = v_u_3.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_14, (ref) v_u_20, (ref) v_u_10, (ref) v_u_19
				if v_u_14 and v_u_14.Parent then
					local v64 = v_u_10.AbsolutePosition
					v_u_14.Position = UDim2.fromOffset(v_u_19.X - v64.X + 12, v_u_19.Y - v64.Y + 12)
				elseif v_u_20 then
					v_u_20:Disconnect()
					v_u_20 = nil
				end
			end)
		end)
		v63.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_14, (ref) v_u_20
			v_u_14.Visible = false
			if v_u_20 then
				v_u_20:Disconnect()
				v_u_20 = nil
			end
		end)
		v61.Parent = v_u_11
	end
end
v_u_12.Visible = false
v65()
v13.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_14, (ref) v_u_20
	v_u_9.Enabled = false
	v_u_14.Visible = false
	if v_u_20 then
		v_u_20:Disconnect()
		v_u_20 = nil
	end
end)