local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = require(v2:WaitForChild("Weather"):WaitForChild("WeatherDataDefinitions"))
local v_u_5 = v1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("WeatherDisplay"):WaitForChild("WeatherContainer", 5)
local v_u_6
if v_u_5 then
	v_u_6 = v_u_5:WaitForChild("WeatherIcon", 5)
else
	v_u_6 = v_u_5
end
local v_u_7
if v_u_5 then
	v_u_7 = v_u_5:WaitForChild("WeatherInfo", 5)
else
	v_u_7 = v_u_5
end
local v_u_8
if v_u_7 then
	v_u_8 = v_u_7:WaitForChild("WeatherName", 5)
else
	v_u_8 = v_u_7
end
local v_u_9
if v_u_7 then
	v_u_9 = v_u_7:WaitForChild("WeatherDescription", 5)
else
	v_u_9 = v_u_7
end
if v_u_5 and v_u_6 then
	if v_u_9 then
		v_u_9.RichText = true
	end
	if v_u_8 then
		v_u_8.RichText = true
	end
	v_u_5.AnchorPoint = Vector2.new(0.5, 0.5)
	local v_u_10 = v_u_5.Position
	local v_u_11 = v_u_5.Size
	local v_u_12 = UDim2.new(v_u_11.X.Scale * 1.1, v_u_11.X.Offset, v_u_11.Y.Scale * 1.1, v_u_11.Y.Offset)
	local v_u_13 = UDim2.new(v_u_10.X.Scale, v_u_10.X.Offset, 1.2, 0)
	local v_u_14 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v_u_15 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	v_u_5.Position = v_u_13
	local v_u_16 = {}
	local function v_u_20(p17)
		-- upvalues: (copy) v_u_10, (copy) v_u_13, (copy) v_u_5, (copy) v_u_3, (copy) v_u_14, (copy) v_u_16, (copy) v_u_11
		local v18 = p17 and v_u_10 or v_u_13
		if p17 then
			v_u_5.Visible = true
		end
		local v19 = v_u_3:Create(v_u_5, v_u_14, {
			["Position"] = v18
		})
		v19:Play()
		if not p17 then
			v19.Completed:Connect(function()
				-- upvalues: (ref) v_u_16, (ref) v_u_5, (ref) v_u_11
				if not next(v_u_16) then
					v_u_5.Visible = false
					v_u_5.Size = v_u_11
				end
			end)
		end
	end
	v_u_5.MouseEnter:Connect(function()
		-- upvalues: (copy) v_u_16, (copy) v_u_3, (copy) v_u_5, (copy) v_u_15, (copy) v_u_12
		if next(v_u_16) then
			v_u_3:Create(v_u_5, v_u_15, {
				["Size"] = v_u_12
			}):Play()
		end
	end)
	v_u_5.MouseLeave:Connect(function()
		-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_15, (copy) v_u_11
		v_u_3:Create(v_u_5, v_u_15, {
			["Size"] = v_u_11
		}):Play()
	end)
	local function v_u_34(p_u_21)
		-- upvalues: (copy) v_u_16, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_20, (copy) v_u_4, (copy) v_u_6, (copy) v_u_5
		for _, v22 in pairs(v_u_16) do
			v22:Destroy()
		end
		table.clear(v_u_16)
		if p_u_21 == "Normal" or not p_u_21 then
			if v_u_7 and (v_u_8 and v_u_9) then
				v_u_7.Visible = false
			end
			local v23 = false
			for _ in pairs(v_u_16) do
				v23 = true
				break
			end
			v_u_20(v23)
			return
		else
			local v24 = v_u_4[p_u_21]
			if v24 then
				if v24.ShowIcon == false then
					local v25 = false
					for _ in pairs(v_u_16) do
						v25 = true
						break
					end
					v_u_20(v25)
				else
					local v26 = v_u_6:Clone()
					v26.Name = "ActiveWeatherIcon"
					v26.Image = v24.Icon
					v26.AnchorPoint = Vector2.new(0.5, 0.5)
					v26.Position = UDim2.fromScale(0.5, 0.5)
					v26.Size = UDim2.fromScale(0.78, 0.78)
					v26.Visible = true
					v26.Parent = v_u_5
					v26.MouseEnter:Connect(function()
						-- upvalues: (copy) p_u_21, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_4
						local v27 = p_u_21
						if v_u_7 and v_u_8 then
							if not v_u_9 then
								return
							end
							if v27 then
								local v28 = v_u_4[v27]
								if v28 then
									v_u_8.Text = v28.Name
									v_u_9.Text = v28.Description
									v_u_7.Visible = true
									return
								end
							else
								v_u_7.Visible = false
							end
						end
					end)
					v26.MouseLeave:Connect(function()
						-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_9
						if v_u_7 and v_u_8 then
							if not v_u_9 then
								return
							end
							v_u_7.Visible = false
						end
					end)
					v26.InputBegan:Connect(function(p29)
						-- upvalues: (copy) p_u_21, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_4
						if p29.UserInputType == Enum.UserInputType.Touch or p29.UserInputType == Enum.UserInputType.MouseButton1 then
							local v30 = p_u_21
							local v31 = not v_u_7.Visible
							if v_u_7 and v_u_8 then
								if not v_u_9 then
									return
								end
								if v31 and v30 then
									local v32 = v_u_4[v30]
									if v32 then
										v_u_8.Text = v32.Name
										v_u_9.Text = v32.Description
										v_u_7.Visible = true
										return
									end
								else
									v_u_7.Visible = false
								end
							end
						end
					end)
					v_u_16[p_u_21] = v26
					local v33 = false
					for _ in pairs(v_u_16) do
						v33 = true
						break
					end
					v_u_20(v33)
				end
			else
				return
			end
		end
	end
	local v35 = v2:WaitForChild("RemoteEvents", 10)
	if v35 then
		v35 = v35:WaitForChild("WeatherEvent", 10)
	end
	if v35 then
		v35.OnClientEvent:Connect(function(p36, p37)
			-- upvalues: (copy) v_u_34, (copy) v_u_16, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_20
			if p36 == "SyncWeather" or p36 == "WeatherStarted" then
				v_u_34(p37.Name)
			elseif p36 == "WeatherEnded" then
				local v38 = p37.Name
				if v_u_16[v38] then
					if v_u_7 and (v_u_8 and v_u_9) then
						v_u_7.Visible = false
					end
					v_u_16[v38]:Destroy()
					v_u_16[v38] = nil
					local v39 = false
					for _ in pairs(v_u_16) do
						v39 = true
						break
					end
					v_u_20(v39)
				end
			end
		end)
	end
	workspace:GetAttributeChangedSignal("CurrentWeather"):Connect(function()
		-- upvalues: (copy) v_u_34
		local v40 = workspace:GetAttribute("CurrentWeather")
		if v40 then
			v_u_34(v40)
		end
	end)
	local v41 = workspace:GetAttribute("CurrentWeather")
	if v41 then
		v_u_34(v41)
	end
	v_u_6.Visible = false
	(v_u_5:FindFirstChildOfClass("UIAspectRatioConstraint") or Instance.new("UIAspectRatioConstraint", v_u_5)).AspectRatio = 1
end