local v1 = game:GetService("Players")
local v_u_2 = game:GetService("TweenService")
local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = {
	["FloraBook"] = true,
	["GearShop"] = true,
	["Quests"] = true,
	["RobuxShop"] = true,
	["SeedShop"] = true,
	["Settings"] = true,
	["GiftModal"] = true,
	["QA"] = true,
	["LoginStreak"] = true
}
local v_u_5 = {
	["TweenTime"] = 0.5,
	["EasingStyle"] = Enum.EasingStyle.Cubic,
	["EasingDirection"] = Enum.EasingDirection.Out
}
local function v9(p_u_6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_2
	if v_u_4[p_u_6.Name] then
		local v_u_7 = p_u_6:FindFirstChildWhichIsA("GuiObject")
		if v_u_7 then
			v_u_7.AnchorPoint = Vector2.new(0.5, 0.5)
			local v_u_8 = TweenInfo.new(v_u_5.TweenTime, v_u_5.EasingStyle, v_u_5.EasingDirection)
			p_u_6:GetPropertyChangedSignal("Enabled"):Connect(function()
				-- upvalues: (copy) p_u_6, (copy) v_u_7, (ref) v_u_2, (copy) v_u_8
				if p_u_6.Enabled then
					v_u_7.Position = UDim2.fromScale(0.5, 1.5)
					v_u_2:Create(v_u_7, v_u_8, {
						["Position"] = UDim2.fromScale(0.5, 0.5)
					}):Play()
				end
			end)
		end
	else
		return
	end
end
if not v3:GetAttribute("UIReady") then
	v3:GetAttributeChangedSignal("UIReady"):Wait()
end
for _, v10 in ipairs(v3:GetChildren()) do
	v9(v10)
end
v3.ChildAdded:Connect(v9)