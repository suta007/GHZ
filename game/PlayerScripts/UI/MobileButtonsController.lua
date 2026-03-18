local v1 = game:GetService("Players")
if game:GetService("UserInputService").TouchEnabled then
	local v_u_2 = UDim2.new(0, -100, 0.3, 0)
	local v3 = v1.LocalPlayer:WaitForChild("PlayerGui")
	local v_u_4 = nil
	local v_u_5 = nil
	local v_u_6 = nil
	local function v_u_10()
		local v7 = workspace.CurrentCamera.ViewportSize
		local v8 = v7.X
		local v9 = v7.Y
		if math.min(v8, v9) <= 500 then
			return UDim2.new(1, -95, 0.92, -90)
		else
			return UDim2.new(1, -150, 0.92, -120)
		end
	end
	local function v_u_13(p_u_11)
		-- upvalues: (ref) v_u_4, (ref) v_u_6, (copy) v_u_10
		if v_u_4 then
			v_u_4:Disconnect()
		end
		v_u_6 = p_u_11
		p_u_11.Position = v_u_10()
		v_u_4 = p_u_11:GetPropertyChangedSignal("Position"):Connect(function()
			-- upvalues: (ref) v_u_10, (copy) p_u_11
			local v12 = v_u_10()
			if p_u_11.Position ~= v12 then
				p_u_11.Position = v12
			end
		end)
	end
	local function v_u_18(p14)
		-- upvalues: (copy) v_u_13, (ref) v_u_5, (copy) v_u_2
		local v15 = p14:FindFirstChild("JumpButton")
		if v15 then
			v_u_13(v15)
		end
		local v_u_16 = p14:FindFirstChild("DynamicThumbstickFrame")
		if v_u_16 then
			if v_u_5 then
				v_u_5:Disconnect()
			end
			v_u_16.Position = v_u_2
			v_u_5 = v_u_16:GetPropertyChangedSignal("Position"):Connect(function()
				-- upvalues: (copy) v_u_16, (ref) v_u_2
				if v_u_16.Position ~= v_u_2 then
					v_u_16.Position = v_u_2
				end
			end)
		end
		p14.ChildAdded:Connect(function(p_u_17)
			-- upvalues: (ref) v_u_13, (ref) v_u_5, (ref) v_u_2
			if p_u_17.Name == "JumpButton" then
				v_u_13(p_u_17)
			elseif p_u_17.Name == "DynamicThumbstickFrame" then
				if v_u_5 then
					v_u_5:Disconnect()
				end
				p_u_17.Position = v_u_2
				v_u_5 = p_u_17:GetPropertyChangedSignal("Position"):Connect(function()
					-- upvalues: (copy) p_u_17, (ref) v_u_2
					if p_u_17.Position ~= v_u_2 then
						p_u_17.Position = v_u_2
					end
				end)
			end
		end)
	end
	local v19 = v3:FindFirstChild("TouchGui")
	if v19 then
		local v20 = v19:FindFirstChild("TouchControlFrame")
		if v20 then
			v_u_18(v20)
		end
		v19.ChildAdded:Connect(function(p21)
			-- upvalues: (copy) v_u_18
			if p21.Name == "TouchControlFrame" then
				v_u_18(p21)
			end
		end)
	end
	v3.ChildAdded:Connect(function(p22)
		-- upvalues: (copy) v_u_18
		if p22.Name == "TouchGui" then
			local v23 = p22:FindFirstChild("TouchControlFrame")
			if v23 then
				v_u_18(v23)
			end
			p22.ChildAdded:Connect(function(p24)
				-- upvalues: (ref) v_u_18
				if p24.Name == "TouchControlFrame" then
					v_u_18(p24)
				end
			end)
		end
	end)
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		-- upvalues: (ref) v_u_6, (copy) v_u_10
		if v_u_6 and v_u_6.Parent then
			v_u_6.Position = v_u_10()
		end
	end)
end