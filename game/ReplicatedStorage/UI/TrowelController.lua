game:GetService("ReplicatedStorage")
game:GetService("Players")
local v1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Trowel")
local v3 = v_u_2:WaitForChild("Container")
local v4 = v3:WaitForChild("ButtonContainer"):WaitForChild("RotateRight")
local v5 = v3:WaitForChild("ButtonContainer"):WaitForChild("RotateLeft")
local v6 = v3:WaitForChild("ButtonContainer"):WaitForChild("Confirm")
local v7 = {}
local v8 = {
	["Desktop"] = {
		["Image"] = "rbxassetid://121406376316928",
		["Hover"] = "rbxassetid://107558539165976",
		["Pressed"] = "rbxassetid://82745173586191"
	},
	["Mobile"] = {
		["Image"] = "rbxassetid://78507116368731",
		["Hover"] = "rbxassetid://92672334298423",
		["Pressed"] = "rbxassetid://129160235484095"
	},
	["Console"] = {
		["Hover"] = "rbxassetid://76250706544012",
		["Image"] = "rbxassetid://84135366341457",
		["Pressed"] = "rbxassetid://71325012203260"
	}
}
if v1.TouchEnabled and not v1.KeyboardEnabled then
	v4.Image = v8.Mobile.Image
	v4.HoverImage = v8.Mobile.Hover
	v4.PressedImage = v8.Mobile.Pressed
	v5.Image = v8.Mobile.Image
	v5.HoverImage = v8.Mobile.Hover
	v5.PressedImage = v8.Mobile.Pressed
	v6.Visible = true
	v6.Image = "rbxassetid://140666230518825"
	v6.HoverImage = "rbxassetid://72163449548372"
	v6.PressedImage = "rbxassetid://106341157392002"
	v4:WaitForChild("Keycode").Visible = false
	v5:WaitForChild("Keycode").Visible = false
	v3.Size = UDim2.new(0.5, 0, 0.38, 0)
	v3.Position = UDim2.new(0.5, 0, 0.4, 0)
elseif v1.GamepadEnabled then
	v4.Image = v8.Console.Image
	v4.HoverImage = v8.Console.Hover
	v4.PressedImage = v8.Console.Pressed
	v5.Image = v8.Console.Image
	v5.HoverImage = v8.Console.Hover
	v5.PressedImage = v8.Console.Pressed
	v6.Visible = false
	v4:WaitForChild("Keycode").Visible = false
	v5:WaitForChild("Keycode").Visible = false
	v3.Size = UDim2.new(0, 655, 0, 200)
	v3.Position = UDim2.new(0.5, 0, 1, -300)
else
	v4.Image = v8.Desktop.Image
	v4.HoverImage = v8.Desktop.Hover
	v4.PressedImage = v8.Desktop.Pressed
	v5.Image = v8.Desktop.Image
	v5.HoverImage = v8.Desktop.Hover
	v5.PressedImage = v8.Desktop.Pressed
	v6.Visible = false
	v3.Size = UDim2.new(0, 655, 0, 200)
	v3.Position = UDim2.new(0.5, 0, 1, -285)
end
v_u_2.Enabled = false
v7.RotateRight = v4
v7.RotateLeft = v5
v7.Confirm = v6
function v7.Open()
	-- upvalues: (copy) v_u_2
	v_u_2.Enabled = true
end
function v7.Close()
	-- upvalues: (copy) v_u_2
	v_u_2.Enabled = false
end
return v7