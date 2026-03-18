game:GetService("UserInputService")
local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("StarterGui")
task.spawn(function()
	-- upvalues: (copy) v_u_5
	while not pcall(function()
		-- upvalues: (ref) v_u_5
		v_u_5:SetCore("ResetButtonCallback", false)
	end) do
		task.wait(1)
	end
end)
local v_u_6 = v3.LocalPlayer
local v_u_7 = v_u_6:WaitForChild("PlayerGui")
local v_u_8 = v2:WaitForChild("RemoteEvents"):WaitForChild("UpdateSettings")
local v9 = v2:WaitForChild("RemoteEvents"):WaitForChild("DataService")
local v_u_10 = require(v2:WaitForChild("Player"):WaitForChild("SettingsManager")).GetDefinitions()
local v11 = require(v2:WaitForChild("UI"):WaitForChild("SettingsHandler"))
local v_u_12 = v_u_7:WaitForChild("Settings")
local v13
if v_u_12 then
	v13 = v_u_12:FindFirstChild("ScrollingFrame", true)
else
	v13 = v_u_12
end
if v13 then
	v13.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v13.CanvasSize = UDim2.new(0, 0, 0, 0)
end
local v_u_14
if v13 then
	v_u_14 = v13:FindFirstChild("CodesSetting", true)
else
	v_u_14 = v13
end
local v15
if v_u_14 then
	v15 = v_u_14:FindFirstChild("Submit", true)
else
	v15 = v_u_14
end
if v_u_14 then
	v_u_14 = v_u_14:FindFirstChild("TextBox", true)
end
local v_u_16 = v2:WaitForChild("RemoteEvents"):WaitForChild("RedeemCode")
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = {
	["Grass"] = {},
	["Tulips"] = {},
	["Trees"] = {}
}
local v_u_20 = nil
local function v_u_111(p_u_21)
	-- upvalues: (copy) v_u_19, (copy) v_u_4, (ref) v_u_20
	local v22 = workspace:FindFirstChild("MapPhysical")
	if v22 then
		local v_u_23 = v22:FindFirstChild("Grass")
		if v_u_23 then
			if p_u_21 then
				local v_u_24 = {}
				for _, v25 in ipairs(v_u_23:GetChildren()) do
					if v25.Name == "Grass" then
						table.insert(v_u_24, v25)
					end
				end
				local function v_u_28(p26)
					-- upvalues: (ref) v_u_19
					local v27 = v_u_19.Grass
					table.insert(v27, p26)
					p26.Parent = nil
				end
				local v_u_29 = 1
				local v_u_30 = nil
				local v_u_31 = nil
				v_u_30 = v_u_4.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_29, (copy) v_u_24, (copy) v_u_28, (ref) v_u_30, (copy) v_u_31
					local v32 = v_u_29 + 10 - 1
					local v33 = #v_u_24
					local v34 = math.min(v32, v33)
					for v35 = v_u_29, v34 do
						v_u_28(v_u_24[v35])
					end
					v_u_29 = v34 + 1
					if v_u_29 > #v_u_24 then
						v_u_30:Disconnect()
						if v_u_31 then
							v_u_31()
						end
					end
				end)
			else
				local v_u_36 = v_u_19.Grass
				v_u_19.Grass = {}
				local function v_u_38(p37)
					-- upvalues: (copy) v_u_23
					p37.Parent = v_u_23
				end
				local v_u_39 = 1
				local v_u_40 = nil
				local v_u_41 = nil
				v_u_40 = v_u_4.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_39, (copy) v_u_36, (copy) v_u_38, (ref) v_u_40, (copy) v_u_41
					local v42 = v_u_39 + 10 - 1
					local v43 = #v_u_36
					local v44 = math.min(v42, v43)
					for v45 = v_u_39, v44 do
						v_u_38(v_u_36[v45])
					end
					v_u_39 = v44 + 1
					if v_u_39 > #v_u_36 then
						v_u_40:Disconnect()
						if v_u_41 then
							v_u_41()
						end
					end
				end)
			end
		end
		local v_u_46 = v22:FindFirstChild("Tulips")
		if v_u_46 then
			if p_u_21 then
				local v_u_47 = {}
				for _, v48 in ipairs(v_u_46:GetChildren()) do
					if v48.Name == "Tulip" then
						table.insert(v_u_47, v48)
					end
				end
				local function v_u_51(p49)
					-- upvalues: (ref) v_u_19
					local v50 = v_u_19.Tulips
					table.insert(v50, p49)
					p49.Parent = nil
				end
				local v_u_52 = 1
				local v_u_53 = nil
				local v_u_54 = nil
				v_u_53 = v_u_4.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_52, (copy) v_u_47, (copy) v_u_51, (ref) v_u_53, (copy) v_u_54
					local v55 = v_u_52 + 10 - 1
					local v56 = #v_u_47
					local v57 = math.min(v55, v56)
					for v58 = v_u_52, v57 do
						v_u_51(v_u_47[v58])
					end
					v_u_52 = v57 + 1
					if v_u_52 > #v_u_47 then
						v_u_53:Disconnect()
						if v_u_54 then
							v_u_54()
						end
					end
				end)
			else
				local v_u_59 = v_u_19.Tulips
				v_u_19.Tulips = {}
				local function v_u_61(p60)
					-- upvalues: (copy) v_u_46
					p60.Parent = v_u_46
				end
				local v_u_62 = 1
				local v_u_63 = nil
				local v_u_64 = nil
				v_u_63 = v_u_4.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_62, (copy) v_u_59, (copy) v_u_61, (ref) v_u_63, (copy) v_u_64
					local v65 = v_u_62 + 10 - 1
					local v66 = #v_u_59
					local v67 = math.min(v65, v66)
					for v68 = v_u_62, v67 do
						v_u_61(v_u_59[v68])
					end
					v_u_62 = v67 + 1
					if v_u_62 > #v_u_59 then
						v_u_63:Disconnect()
						if v_u_64 then
							v_u_64()
						end
					end
				end)
			end
		end
		local v_u_69 = v22:FindFirstChild("Tree")
		if v_u_69 then
			if p_u_21 then
				if v_u_20 == nil then
					v_u_20 = {}
					local v70 = {}
					for _, v71 in ipairs(v_u_69:GetChildren()) do
						if v71.Name == "Tree" and v71:IsA("Model") then
							table.insert(v70, v71)
						end
					end
					local v72 = #v70
					for v73 = 1, math.floor(v72) do
						local v74 = v_u_20
						local v75 = v70[v73]
						table.insert(v74, v75)
					end
				end
				local v_u_76 = v_u_20
				local function v_u_79(p77)
					-- upvalues: (ref) v_u_19
					local v78 = v_u_19.Trees
					table.insert(v78, p77)
					p77.Parent = nil
				end
				local v_u_80 = 1
				local v_u_81 = nil
				local v_u_82 = nil
				v_u_81 = v_u_4.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_80, (copy) v_u_76, (copy) v_u_79, (ref) v_u_81, (copy) v_u_82
					local v83 = v_u_80 + 10 - 1
					local v84 = #v_u_76
					local v85 = math.min(v83, v84)
					for v86 = v_u_80, v85 do
						v_u_79(v_u_76[v86])
					end
					v_u_80 = v85 + 1
					if v_u_80 > #v_u_76 then
						v_u_81:Disconnect()
						if v_u_82 then
							v_u_82()
						end
					end
				end)
			else
				local v_u_87 = v_u_19.Trees
				v_u_19.Trees = {}
				local function v_u_89(p88)
					-- upvalues: (copy) v_u_69
					p88.Parent = v_u_69
				end
				local v_u_90 = 1
				local v_u_91 = nil
				local v_u_92 = nil
				v_u_91 = v_u_4.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_90, (copy) v_u_87, (copy) v_u_89, (ref) v_u_91, (copy) v_u_92
					local v93 = v_u_90 + 10 - 1
					local v94 = #v_u_87
					local v95 = math.min(v93, v94)
					for v96 = v_u_90, v95 do
						v_u_89(v_u_87[v96])
					end
					v_u_90 = v95 + 1
					if v_u_90 > #v_u_87 then
						v_u_91:Disconnect()
						if v_u_92 then
							v_u_92()
						end
					end
				end)
			end
		end
		local v97 = v22:FindFirstChild("Houses")
		if v97 then
			local v_u_98 = {}
			for _, v99 in ipairs(v97:GetChildren()) do
				if v99.Name == "House" then
					local v100 = v99:FindFirstChild("Chimney")
					if v100 then
						for _, v101 in ipairs(v100:GetDescendants()) do
							if v101:IsA("ParticleEmitter") then
								table.insert(v_u_98, v101)
							end
						end
					end
				end
			end
			local function v_u_103(p102)
				-- upvalues: (copy) p_u_21
				p102.Enabled = not p_u_21
			end
			local v_u_104 = 1
			local v_u_105 = nil
			local v_u_106 = nil
			v_u_105 = v_u_4.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_104, (copy) v_u_98, (copy) v_u_103, (ref) v_u_105, (copy) v_u_106
				local v107 = v_u_104 + 10 - 1
				local v108 = #v_u_98
				local v109 = math.min(v107, v108)
				for v110 = v_u_104, v109 do
					v_u_103(v_u_98[v110])
				end
				v_u_104 = v109 + 1
				if v_u_104 > #v_u_98 then
					v_u_105:Disconnect()
					if v_u_106 then
						v_u_106()
					end
				end
			end)
		end
	else
		warn("[LDM] Could not find folder!MapPhysical")
	end
end
v_u_6:GetAttributeChangedSignal("LowDetail"):Connect(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_111
	v_u_111((v_u_6:GetAttribute("LowDetail")))
end)
if v_u_6:GetAttribute("LowDetail") == true then
	v_u_111(true)
end
if v13 then
	for _, v112 in ipairs(v13:GetDescendants()) do
		local v113 = v112:GetAttribute("SettingName")
		local v114 = v112:GetAttribute("SliderType")
		if v113 and v114 then
			if v114 == "Volume" then
				v11.InitVolume(v112, v113)
			elseif v114 == "Toggle" then
				v11.InitToggle(v112, v113)
			end
		end
	end
end
v9.OnClientEvent:Connect(function(p115)
	-- upvalues: (copy) v_u_10, (copy) v_u_6, (copy) v_u_8
	if p115 == "DataLoaded" then
		for v_u_116, _ in pairs(v_u_10) do
			v_u_6:GetAttributeChangedSignal(v_u_116):Connect(function()
				-- upvalues: (ref) v_u_6, (copy) v_u_116, (ref) v_u_8
				v_u_8:FireServer(v_u_116, (v_u_6:GetAttribute(v_u_116)))
			end)
		end
	end
end)
local function v125(p_u_117, p_u_118)
	-- upvalues: (copy) v_u_1
	if p_u_117 then
		local v_u_119 = p_u_117.Size
		local v_u_120 = UDim2.new(v_u_119.X.Scale * 1.05, v_u_119.X.Offset, v_u_119.Y.Scale * 1.05, v_u_119.Y.Offset)
		local v_u_121 = UDim2.new(v_u_119.X.Scale * 0.95, v_u_119.X.Offset, v_u_119.Y.Scale * 0.95, v_u_119.Y.Offset)
		p_u_117.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_1, (copy) p_u_117, (copy) v_u_120
			local v122 = {
				["Size"] = v_u_120
			}
			v_u_1:Create(p_u_117, TweenInfo.new(0.1), v122):Play()
		end)
		p_u_117.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_1, (copy) p_u_117, (copy) v_u_119
			local v123 = {
				["Size"] = v_u_119
			}
			v_u_1:Create(p_u_117, TweenInfo.new(0.1), v123):Play()
		end)
		p_u_117.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_1, (copy) p_u_117, (copy) v_u_121
			local v124 = {
				["Size"] = v_u_121
			}
			v_u_1:Create(p_u_117, TweenInfo.new(0.1), v124):Play()
		end)
		p_u_117.MouseButton1Click:Connect(function()
			-- upvalues: (copy) p_u_118
			if p_u_118 then
				p_u_118()
			end
		end)
	end
end
if v15 and v_u_14 then
	local v_u_126 = false
	local v_u_127 = false
	local function v_u_131()
		-- upvalues: (ref) v_u_126, (copy) v_u_14, (copy) v_u_16, (ref) v_u_127
		if v_u_126 then
			return
		else
			local v_u_128 = v_u_14.Text
			if v_u_128 ~= "" and v_u_128 ~= "Text..." then
				v_u_126 = true
				v_u_14.Text = "Redeeming..."
				v_u_14:ReleaseFocus()
				local v129, v130 = pcall(function()
					-- upvalues: (ref) v_u_16, (copy) v_u_128
					return v_u_16:InvokeServer(v_u_128)
				end)
				v_u_126 = false
				v_u_127 = true
				v_u_14.Text = v129 and v130
				task.delay(5, function()
					-- upvalues: (ref) v_u_127, (ref) v_u_14
					if v_u_127 then
						v_u_14.Text = ""
						v_u_127 = false
					end
				end)
			end
		end
	end
	v125(v15, v_u_131)
	v_u_14.FocusLost:Connect(function(p132)
		-- upvalues: (copy) v_u_131
		if p132 then
			v_u_131()
		end
	end)
	v_u_14.Focused:Connect(function()
		-- upvalues: (ref) v_u_127, (copy) v_u_14
		if v_u_127 then
			v_u_14.Text = ""
			v_u_127 = false
		end
	end)
	v_u_14:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) v_u_14, (copy) v_u_131
		if string.find(v_u_14.Text, "\n") then
			v_u_14.Text = string.gsub(v_u_14.Text, "\n", "")
			v_u_131()
		end
	end)
end
if v_u_12 then
	v_u_12:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (copy) v_u_12, (ref) v_u_17, (copy) v_u_7, (ref) v_u_18
		if v_u_12.Enabled then
			if not v_u_17 then
				v_u_17 = v_u_7:FindFirstChild("BackpackGui")
			end
			if v_u_17 then
				v_u_17.Enabled = false
			end
			local v133 = not v_u_18 and v_u_7:FindFirstChild("Hud_UI")
			if v133 then
				v_u_18 = v133:FindFirstChild("TopButtons")
			end
			if v_u_18 then
				v_u_18.Visible = false
				return
			end
		else
			if v_u_17 then
				v_u_17.Enabled = true
			end
			if v_u_18 then
				v_u_18.Visible = true
			end
		end
	end)
end