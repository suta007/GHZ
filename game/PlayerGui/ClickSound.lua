local v_u_1 = game:GetService("SoundService")
local v_u_2 = v_u_1:WaitForChild("SFX"):WaitForChild("UI"):WaitForChild("Click")
for _, v_u_3 in pairs(script.Parent:GetDescendants()) do
	if v_u_3:IsA("GuiButton") then
		v_u_3.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_1
			if not v_u_3:GetAttribute("SkipClickSound") and v_u_3.Name ~= "JumpButton" then
				local v_u_4 = v_u_2:Clone()
				v_u_4.PlaybackSpeed = 0.95 + (math.random() * 2 - 1) * 0.05
				v_u_4.Parent = v_u_1
				v_u_4:Play()
				v_u_4.Ended:Once(function()
					-- upvalues: (copy) v_u_4
					v_u_4:Destroy()
				end)
			end
		end)
	end
end