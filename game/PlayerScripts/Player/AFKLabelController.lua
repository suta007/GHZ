local v1 = game:GetService("UserInputService")
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v4 = v2.LocalPlayer
local v_u_5 = v3:WaitForChild("RemoteEvents"):WaitForChild("AFK")
v1.WindowFocused:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:FireServer(false)
end)
v1.WindowFocusReleased:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:FireServer(true)
end)
v4.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_5
	v_u_5:FireServer(false)
end)