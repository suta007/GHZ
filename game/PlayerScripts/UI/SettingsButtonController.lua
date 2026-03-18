local v1 = game:GetService("ReplicatedStorage"):WaitForChild("TopbarPlusReference")
local v2
if v1 then
	v2 = require(v1.Value)
else
	v2 = nil
end
if v2 then
	local v_u_3 = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Settings")
	local v_u_4 = v2.new()
	v_u_4:setImage("rbxassetid://132848201849699")
	v_u_4:setName("Settings")
	v_u_4:setCaption("Open Settings")
	v_u_4:setImageScale(0.8)
	v_u_4:autoDeselect(false)
	v_u_4.toggled:Connect(function(p5, _)
		-- upvalues: (copy) v_u_3
		v_u_3.Enabled = p5
	end)
	v_u_3:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (copy) v_u_3, (copy) v_u_4
		if not v_u_3.Enabled then
			v_u_4:deselect()
		end
	end)
end