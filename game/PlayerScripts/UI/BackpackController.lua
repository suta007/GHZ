local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("GamepadService")
game:GetService("GuiService")
game:GetService("UserInputService")
local v3 = v1.LocalPlayer
local v4 = v3:WaitForChild("PlayerGui")
local v_u_5 = require(v2:WaitForChild("Backpack"))
while v4:FindFirstChild("LoadingScreenGui") do
	task.wait(0.2)
end
local v6 = v4:WaitForChild("PlotSelector", 10)
if v6 then
	while not v6:GetAttribute("FlowComplete") do
		task.wait(0.2)
	end
end
v_u_5:SetBackpackEnabled(true)
print("[BackpackController]: Loaded")
v3.Backpack.ChildAdded:Connect(function(p7)
	-- upvalues: (copy) v_u_5
	if p7:IsA("Tool") and p7:GetAttribute("Type") then
		v_u_5:SetToolGroup(p7, p7:GetAttribute("Type"))
	end
end)