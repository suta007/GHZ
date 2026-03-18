local v_u_1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = nil
local v_u_5 = nil
local v_u_6 = false
local v_u_40 = {
	["_exclusiveUIs"] = {
		"GearShop",
		"FloraBook",
		"RobuxShop",
		"Settings",
		"SeedShop",
		"GiftModal",
		"Quests",
		"LoginStreak"
	},
	["CloseAllExclusive"] = function(p7, p8)
		-- upvalues: (copy) v_u_1
		local v9 = v_u_1.LocalPlayer
		if v9 then
			local v10 = v9:FindFirstChild("PlayerGui")
			if v10 then
				for _, v11 in ipairs(p7._exclusiveUIs) do
					if v11 ~= p8 then
						local v12 = v10:FindFirstChild(v11)
						if v12 and v12:IsA("ScreenGui") then
							v12.Enabled = false
						end
					end
				end
				p7:_updateHUDVisibility()
			end
		else
			return
		end
	end,
	["OpenUI"] = function(p13, p14)
		-- upvalues: (copy) v_u_1
		local v15 = v_u_1.LocalPlayer
		if v15 then
			local v16 = v15:FindFirstChild("PlayerGui")
			if v16 then
				p13:CloseAllExclusive(p14)
				local v17 = v16:FindFirstChild(p14)
				if v17 and v17:IsA("ScreenGui") then
					v17.Enabled = true
				end
			end
		else
			return
		end
	end,
	["CloseUI"] = function(_, p18)
		-- upvalues: (copy) v_u_1
		local v19 = v_u_1.LocalPlayer
		if v19 then
			local v20 = v19:FindFirstChild("PlayerGui")
			if v20 then
				local v21 = v20:FindFirstChild(p18)
				if v21 and v21:IsA("ScreenGui") then
					v21.Enabled = false
				end
			end
		else
			return
		end
	end,
	["ToggleUI"] = function(p22, p23)
		-- upvalues: (copy) v_u_1
		local v24 = v_u_1.LocalPlayer
		if v24 then
			local v25 = v24:FindFirstChild("PlayerGui")
			if v25 then
				local v26 = v25:FindFirstChild(p23)
				if v26 and v26:IsA("ScreenGui") then
					if v26.Enabled then
						v26.Enabled = false
						return
					end
					p22:CloseAllExclusive(p23)
					v26.Enabled = true
				end
			end
		else
			return
		end
	end,
	["_updateHUDVisibility"] = function(p27)
		-- upvalues: (ref) v_u_6, (copy) v_u_1, (copy) v_u_3, (ref) v_u_4, (ref) v_u_5
		if not v_u_6 then
			return
		end
		local v28 = v_u_1.LocalPlayer
		if not v28 then
			return
		end
		local v29 = v28:FindFirstChild("PlayerGui")
		if not v29 then
			return
		end
		local v30 = false
		for _, v31 in ipairs(p27._exclusiveUIs) do
			local v32 = v29:FindFirstChild(v31)
			if v32 and (v32:IsA("ScreenGui") and v32.Enabled) then
				v30 = true
				break
			end
		end
		v_u_3:Create(workspace.CurrentCamera, TweenInfo.new(0.5), {
			["FieldOfView"] = v30 and 60 or 70
		}):Play()
		local v33
		if v_u_4 then
			::l18::
			v33 = v_u_4
			goto l21
		else
			local v34 = v_u_1.LocalPlayer
			if v34 then
				local v35 = v34:FindFirstChild("PlayerGui")
				if v35 then
					v_u_4 = v35:FindFirstChild("BackpackGui")
					goto l18
				end
				v33 = nil
			else
				v33 = nil
			end
			::l21::
			local v36
			if v_u_5 then
				::l25::
				v36 = v_u_5
				goto l28
			else
				local v37 = v_u_1.LocalPlayer
				if v37 then
					local v38 = v37:FindFirstChild("PlayerGui")
					if v38 then
						local v39 = v38:FindFirstChild("Hud_UI")
						if v39 then
							v_u_5 = v39:FindFirstChild("TopButtons")
							goto l25
						end
						v36 = nil
					else
						v36 = nil
					end
				else
					v36 = nil
				end
				::l28::
				if v33 then
					v33.Enabled = not v30
				end
				if v36 then
					v36.Visible = not v30
				end
				return
			end
		end
	end
}
local function v53(p41, p42)
	-- upvalues: (ref) v_u_6, (copy) v_u_1, (copy) v_u_40
	if not v_u_6 then
		return
	end
	if p42 then
		return
	end
	if p41.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end
	local v43 = v_u_1.LocalPlayer
	if not v43 then
		return
	end
	local v44 = v43:FindFirstChild("PlayerGui")
	if not v44 then
		return
	end
	local v45 = p41.Position
	local v46 = false
	for _, v47 in ipairs(v_u_40._exclusiveUIs) do
		local v48 = v44:FindFirstChild(v47)
		if v48 and (v48:IsA("ScreenGui") and v48.Enabled) then
			for _, v49 in v48:GetDescendants() do
				if v49:IsA("GuiObject") and v49.Visible then
					local v50 = v49.AbsolutePosition
					local v51 = v49.AbsoluteSize
					local v52
					if v45.X >= v50.X and (v45.X <= v50.X + v51.X and v45.Y >= v50.Y) then
						v52 = v45.Y <= v50.Y + v51.Y
					else
						v52 = false
					end
					if v52 then
						v46 = true
						break
					end
				end
			end
			if v46 then
				break
			end
		end
	end
	if not v46 then
		v_u_40:CloseAllExclusive()
	end
end
v2.InputBegan:Connect(v53)
task.spawn(function()
	-- upvalues: (copy) v_u_1, (ref) v_u_6, (copy) v_u_40
	local v_u_54 = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
	if not v_u_54:GetAttribute("UIReady") then
		v_u_54:GetAttributeChangedSignal("UIReady"):Wait()
	end
	v_u_6 = true
	for _, v_u_55 in ipairs(v_u_40._exclusiveUIs) do
		task.spawn(function()
			-- upvalues: (copy) v_u_54, (copy) v_u_55, (ref) v_u_40
			local v56 = v_u_54:WaitForChild(v_u_55, 10)
			if v56 and v56:IsA("ScreenGui") then
				v56:GetPropertyChangedSignal("Enabled"):Connect(function()
					-- upvalues: (ref) v_u_40
					v_u_40:_updateHUDVisibility()
				end)
			end
		end)
	end
end)
return v_u_40