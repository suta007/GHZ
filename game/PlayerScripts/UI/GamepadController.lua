local v_u_1 = game:GetService("GamepadService")
local v_u_2 = game:GetService("GuiService")
local v_u_3 = game:GetService("UserInputService")
local v4 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v_u_5 = {
	["FloraBook"] = {
		["mode"] = "virtual",
		["target"] = nil
	},
	["SeedShop"] = {
		["mode"] = "virtual",
		["target"] = nil
	},
	["GearShop"] = {
		["mode"] = "virtual",
		["target"] = nil
	},
	["RobuxShop"] = {
		["mode"] = "virtual",
		["target"] = nil
	},
	["Quests"] = {
		["mode"] = "virtual",
		["target"] = nil
	},
	["Settings"] = {
		["mode"] = "virtual",
		["target"] = "Background"
	},
	["GiftModal"] = {
		["mode"] = "virtual",
		["target"] = "Background"
	},
	["ShovelConfirmation"] = {
		["mode"] = "selection",
		["target"] = "Background.Cancel"
	},
	["ReverterConfirmation"] = {
		["mode"] = "selection",
		["target"] = "Background.Cancel"
	},
	["PlotSelector"] = {
		["mode"] = "selection",
		["target"] = "Frame.MiddleBit.Confirm"
	}
}
local function v_u_9(p6, p7)
	if p7 == nil then
		return nil
	end
	for v8 in p7:gmatch("[^%.]+") do
		p6 = p6:FindFirstChild(v8)
		if not p6 then
			return nil
		end
	end
	return p6
end
local v_u_10 = nil
local function v_u_15(p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (ref) v_u_10, (copy) v_u_9, (copy) v_u_2, (copy) v_u_1
	local v12 = v_u_3.GamepadEnabled
	if v12 then
		v12 = v_u_3:GetLastInputType() == Enum.UserInputType.Gamepad1
	end
	if v12 then
		local v13 = v_u_5[p11.Name]
		if v13 then
			v_u_10 = p11.Name
			local v_u_14 = v_u_9(p11, v13.target)
			if v13.mode == "virtual" then
				v_u_2.AutoSelectGuiEnabled = false
				v_u_2.SelectedObject = nil
				pcall(function()
					-- upvalues: (ref) v_u_1, (copy) v_u_14
					v_u_1:EnableGamepadCursor(v_u_14)
				end)
			elseif v13.mode == "selection" then
				pcall(function()
					-- upvalues: (ref) v_u_1
					v_u_1:DisableGamepadCursor()
				end)
				v_u_2.AutoSelectGuiEnabled = false
				if v_u_14 then
					v_u_2.SelectedObject = v_u_14
				end
			end
		else
			return
		end
	else
		return
	end
end
local v_u_16 = v_u_10
for _, v_u_17 in ipairs(v4:GetChildren()) do
	if v_u_17:IsA("ScreenGui") and v_u_5[v_u_17.Name] then
		v_u_17:GetPropertyChangedSignal("Enabled"):Connect(function()
			-- upvalues: (copy) v_u_17, (copy) v_u_15, (ref) v_u_16, (copy) v_u_1, (copy) v_u_2
			if v_u_17.Enabled then
				v_u_15(v_u_17)
				return
			elseif v_u_16 == v_u_17.Name then
				v_u_16 = nil
				pcall(function()
					-- upvalues: (ref) v_u_1
					v_u_1:DisableGamepadCursor()
				end)
				v_u_2.SelectedObject = nil
				v_u_2.AutoSelectGuiEnabled = true
			end
		end)
	end
end
v4.ChildAdded:Connect(function(p_u_18)
	-- upvalues: (copy) v_u_5, (copy) v_u_15, (ref) v_u_16, (copy) v_u_1, (copy) v_u_2
	if p_u_18:IsA("ScreenGui") and v_u_5[p_u_18.Name] then
		p_u_18:GetPropertyChangedSignal("Enabled"):Connect(function()
			-- upvalues: (copy) p_u_18, (ref) v_u_15, (ref) v_u_16, (ref) v_u_1, (ref) v_u_2
			if p_u_18.Enabled then
				v_u_15(p_u_18)
				return
			elseif v_u_16 == p_u_18.Name then
				v_u_16 = nil
				pcall(function()
					-- upvalues: (ref) v_u_1
					v_u_1:DisableGamepadCursor()
				end)
				v_u_2.SelectedObject = nil
				v_u_2.AutoSelectGuiEnabled = true
			end
		end)
	end
end)