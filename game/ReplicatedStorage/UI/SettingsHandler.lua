local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("SoundService")
local v_u_4 = game:GetService("TweenService")
local v5 = game:GetService("ReplicatedStorage")
local v6 = game:GetService("Players")
game:GetService("GamepadService")
game:GetService("ContextActionService")
local v_u_7 = v6.LocalPlayer
local v_u_8 = v5.RemoteEvents:WaitForChild("UpdateSettings", 10)
local v9 = {}
local v_u_11 = {
	["MusicVolume"] = function()
		-- upvalues: (copy) v_u_3
		return v_u_3:WaitForChild("Music", 10)
	end,
	["SFXVolume"] = function()
		-- upvalues: (copy) v_u_3
		return v_u_3:WaitForChild("SFX", 10)
	end,
	["WeatherVolume"] = function()
		-- upvalues: (copy) v_u_3
		local v10 = v_u_3:WaitForChild("SFX", 10)
		if v10 then
			v10 = v10:WaitForChild("Weather", 10)
		end
		return v10
	end
}
local v_u_12 = {
	["MUTE"] = {
		["DEFAULT"] = "rbxassetid://95832014889312",
		["HOVER"] = "rbxassetid://99258013724953",
		["CLICK"] = "rbxassetid://94211245013693"
	},
	["MED"] = {
		["DEFAULT"] = "rbxassetid://139818440825776",
		["HOVER"] = "rbxassetid://135473717993137",
		["CLICK"] = "rbxassetid://86189162497916"
	},
	["MAX"] = {
		["DEFAULT"] = "rbxassetid://89171511642552",
		["HOVER"] = "rbxassetid://92244792464617",
		["CLICK"] = "rbxassetid://133981353731793"
	}
}
local v_u_13 = UDim2.new(0.236, 0, 3.474, 0)
local v_u_14 = UDim2.new(0.28, 0, 4.136, 0)
local v_u_15 = UDim2.new(0.202, 0, 2.978, 0)
local v_u_16 = {
	["ON"] = {
		["Default"] = "rbxassetid://108848771526475",
		["Hover"] = "rbxassetid://126968796502460",
		["Click"] = "rbxassetid://132963089358749"
	},
	["OFF"] = {
		["Default"] = "rbxassetid://113047310841968",
		["Hover"] = "rbxassetid://94695361613245",
		["Click"] = "rbxassetid://138931890205721"
	}
}
local v_u_17 = {
	["ON"] = {
		["Fill"] = Color3.fromHex("39B25C"),
		["Stroke"] = Color3.fromHex("1F6445")
	},
	["OFF"] = {
		["Fill"] = Color3.fromHex("C72E2D"),
		["Stroke"] = Color3.fromHex("A91530")
	}
}
local v_u_18 = UDim2.new(0.747, 0, 3.056, 0)
local v_u_19 = UDim2.new(0.972, 0, 3.979, 0)
local v_u_20 = UDim2.new(0.648, 0, 2.652, 0)
function v9.InitVolume(p_u_21, p_u_22)
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_4, (copy) v_u_12, (copy) v_u_1, (copy) v_u_14, (copy) v_u_13, (copy) v_u_15, (copy) v_u_2, (copy) v_u_7
	local v_u_23 = p_u_21:WaitForChild("Fill", 5)
	local v_u_24 = p_u_21:WaitForChild("Handle", 5)
	if v_u_23 and v_u_24 then
		if v_u_8 then
			local v_u_25 = v_u_11[p_u_22]
			if v_u_25 then
				v_u_25 = v_u_25()
			end
			local v_u_26 = false
			local v_u_27 = false
			local function v_u_29(p28)
				-- upvalues: (ref) v_u_4, (copy) v_u_24
				v_u_4:Create(v_u_24, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					["Size"] = p28
				}):Play()
			end
			local function v_u_37(p30)
				-- upvalues: (ref) v_u_1, (copy) p_u_21, (copy) v_u_24, (copy) v_u_23, (copy) v_u_25, (ref) v_u_12, (ref) v_u_26, (ref) v_u_27
				if not p30 then
					local v31 = v_u_1:GetMouseLocation().X
					local v32 = p_u_21.AbsolutePosition.X
					local v33 = p_u_21.AbsoluteSize.X
					local v34 = (v31 - v32) / v33
					p30 = math.clamp(v34, 0, 1)
				end
				v_u_24.Position = UDim2.new(p30, 0, 0.5, 0)
				v_u_23.Size = UDim2.new(p30, 0, 1, 0)
				if v_u_25 then
					v_u_25.Volume = p30
				end
				local v35 = v_u_25 and v_u_25.Volume or 0
				local v36
				if v35 <= 0.2 then
					v36 = v_u_12.MUTE
				elseif v35 >= 0.8 then
					v36 = v_u_12.MAX
				else
					v36 = v_u_12.MED
				end
				v_u_24.Image = v_u_26 and v36.CLICK or (v_u_27 and v36.HOVER or v36.DEFAULT)
			end
			v_u_24.MouseEnter:Connect(function()
				-- upvalues: (ref) v_u_27, (copy) v_u_25, (ref) v_u_12, (copy) v_u_24, (ref) v_u_26, (copy) v_u_29, (ref) v_u_14
				v_u_27 = true
				local v38 = v_u_25 and v_u_25.Volume or 0
				local v39
				if v38 <= 0.2 then
					v39 = v_u_12.MUTE
				elseif v38 >= 0.8 then
					v39 = v_u_12.MAX
				else
					v39 = v_u_12.MED
				end
				v_u_24.Image = v_u_26 and v39.CLICK or (v_u_27 and v39.HOVER or v39.DEFAULT)
				if not v_u_26 then
					v_u_29(v_u_14)
				end
			end)
			v_u_24.MouseLeave:Connect(function()
				-- upvalues: (ref) v_u_27, (copy) v_u_25, (ref) v_u_12, (copy) v_u_24, (ref) v_u_26, (copy) v_u_29, (ref) v_u_13
				v_u_27 = false
				local v40 = v_u_25 and v_u_25.Volume or 0
				local v41
				if v40 <= 0.2 then
					v41 = v_u_12.MUTE
				elseif v40 >= 0.8 then
					v41 = v_u_12.MAX
				else
					v41 = v_u_12.MED
				end
				v_u_24.Image = v_u_26 and v41.CLICK or (v_u_27 and v41.HOVER or v41.DEFAULT)
				if not v_u_26 then
					v_u_29(v_u_13)
				end
			end)
			v_u_24.InputBegan:Connect(function(p42)
				-- upvalues: (ref) v_u_26, (copy) v_u_25, (ref) v_u_12, (copy) v_u_24, (ref) v_u_27, (copy) v_u_29, (ref) v_u_15
				if p42.UserInputType == Enum.UserInputType.MouseButton1 or (p42.UserInputType == Enum.UserInputType.Touch or p42.UserInputType == Enum.UserInputType.Gamepad1) then
					v_u_26 = true
					local v43 = v_u_25 and v_u_25.Volume or 0
					local v44
					if v43 <= 0.2 then
						v44 = v_u_12.MUTE
					elseif v43 >= 0.8 then
						v44 = v_u_12.MAX
					else
						v44 = v_u_12.MED
					end
					v_u_24.Image = v_u_26 and v44.CLICK or (v_u_27 and v44.HOVER or v44.DEFAULT)
					v_u_29(v_u_15)
				end
			end)
			v_u_1.InputEnded:Connect(function(p45)
				-- upvalues: (ref) v_u_26, (copy) v_u_25, (ref) v_u_12, (copy) v_u_24, (ref) v_u_27, (ref) v_u_8, (copy) p_u_22, (copy) v_u_29, (ref) v_u_14, (ref) v_u_13
				if (p45.UserInputType == Enum.UserInputType.MouseButton1 or (p45.UserInputType == Enum.UserInputType.Touch or p45.UserInputType == Enum.UserInputType.Gamepad1)) and v_u_26 then
					v_u_26 = false
					local v46 = v_u_25 and v_u_25.Volume or 0
					local v47
					if v46 <= 0.2 then
						v47 = v_u_12.MUTE
					elseif v46 >= 0.8 then
						v47 = v_u_12.MAX
					else
						v47 = v_u_12.MED
					end
					v_u_24.Image = v_u_26 and v47.CLICK or (v_u_27 and v47.HOVER or v47.DEFAULT)
					if v_u_25 then
						v_u_8:FireServer(p_u_22, v_u_25.Volume)
					end
					v_u_29(v_u_27 and v_u_14 or v_u_13)
				end
			end)
			v_u_2.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_26, (copy) v_u_37
				if v_u_26 then
					v_u_37()
				end
			end)
			task.spawn(function()
				-- upvalues: (ref) v_u_7, (copy) p_u_22, (copy) v_u_37
				local v48 = v_u_7:GetAttribute(p_u_22)
				local v49 = tick()
				while v48 == nil and tick() - v49 < 5 do
					task.wait()
					v48 = v_u_7:GetAttribute(p_u_22)
				end
				v_u_37(v48 or 0.5)
			end)
		else
			warn("[SettingsHandler] UpdateSettings remote not found")
		end
	else
		warn("[SettingsHandler] Missing Fill or Handle for " .. p_u_22)
		return
	end
end
function v9.InitToggle(p50, p_u_51)
	-- upvalues: (copy) v_u_8, (copy) v_u_16, (copy) v_u_17, (copy) v_u_20, (copy) v_u_19, (copy) v_u_18, (copy) v_u_4, (copy) v_u_7
	local v_u_52 = p50:WaitForChild("Fill", 5)
	local v_u_53 = p50:WaitForChild("Handle", 5)
	if v_u_52 and v_u_53 then
		local v_u_54 = v_u_52:WaitForChild("UIStroke", 5)
		if v_u_54 then
			if v_u_8 then
				local v_u_55 = false
				local v_u_56 = false
				local v_u_57 = false
				local function v_u_63(p58)
					-- upvalues: (ref) v_u_55, (ref) v_u_16, (ref) v_u_17, (copy) v_u_53, (ref) v_u_57, (ref) v_u_56, (ref) v_u_20, (ref) v_u_19, (ref) v_u_18, (copy) v_u_52, (copy) v_u_54, (ref) v_u_4
					local v59 = v_u_55 and v_u_16.ON or v_u_16.OFF
					local v60 = v_u_55 and v_u_17.ON or v_u_17.OFF
					v_u_53.Image = v_u_57 and v59.Click or (v_u_56 and v59.Hover or v59.Default)
					local v61 = v_u_55 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
					local v62 = v_u_57 and v_u_20 or (v_u_56 and v_u_19 or v_u_18)
					if p58 then
						v_u_53.Position = v61
						v_u_53.Size = v62
						v_u_52.BackgroundColor3 = v60.Fill
						v_u_54.Color = v60.Stroke
					else
						v_u_4:Create(v_u_53, TweenInfo.new(0.25, Enum.EasingStyle.Back), {
							["Position"] = v61,
							["Size"] = v62
						}):Play()
						v_u_4:Create(v_u_52, TweenInfo.new(0.2), {
							["BackgroundColor3"] = v60.Fill
						}):Play()
						v_u_4:Create(v_u_54, TweenInfo.new(0.2), {
							["Color"] = v60.Stroke
						}):Play()
					end
				end
				v_u_53.MouseEnter:Connect(function()
					-- upvalues: (ref) v_u_56, (copy) v_u_63
					v_u_56 = true
					v_u_63(false)
				end)
				v_u_53.MouseLeave:Connect(function()
					-- upvalues: (ref) v_u_56, (ref) v_u_57, (copy) v_u_63
					v_u_56 = false
					v_u_57 = false
					v_u_63(false)
				end)
				v_u_53.MouseButton1Down:Connect(function()
					-- upvalues: (ref) v_u_57, (copy) v_u_63
					v_u_57 = true
					v_u_63(false)
				end)
				v_u_53.MouseButton1Up:Connect(function()
					-- upvalues: (ref) v_u_57, (ref) v_u_55, (copy) v_u_63, (ref) v_u_8, (copy) p_u_51
					if v_u_57 then
						v_u_55 = not v_u_55
						v_u_57 = false
						v_u_63(false)
						v_u_8:FireServer(p_u_51, v_u_55)
					end
				end)
				task.spawn(function()
					-- upvalues: (ref) v_u_7, (copy) p_u_51, (ref) v_u_55, (ref) v_u_16, (ref) v_u_17, (copy) v_u_53, (ref) v_u_57, (ref) v_u_56, (ref) v_u_20, (ref) v_u_19, (ref) v_u_18, (copy) v_u_52, (copy) v_u_54
					local v64 = v_u_7:GetAttribute(p_u_51)
					local v65 = tick()
					while v64 == nil and tick() - v65 < 5 do
						task.wait()
						v64 = v_u_7:GetAttribute(p_u_51)
					end
					if v64 == nil then
						v64 = false
					end
					v_u_55 = v64
					local v66 = v_u_55 and v_u_16.ON or v_u_16.OFF
					local v67 = v_u_55 and v_u_17.ON or v_u_17.OFF
					v_u_53.Image = v_u_57 and v66.Click or (v_u_56 and v66.Hover or v66.Default)
					local v68 = v_u_57 and v_u_20 or (v_u_56 and v_u_19 or v_u_18)
					v_u_53.Position = v_u_55 and UDim2.new(1, 0, 0.5, 0) or UDim2.new(0, 0, 0.5, 0)
					v_u_53.Size = v68
					v_u_52.BackgroundColor3 = v67.Fill
					v_u_54.Color = v67.Stroke
				end)
			else
				warn("[SettingsHandler] UpdateSettings remote not found")
			end
		else
			warn("[SettingsHandler] Missing UIStroke for " .. p_u_51)
			return
		end
	else
		warn("[SettingsHandler] Missing Fill or Handle for " .. p_u_51)
		return
	end
end
return v9