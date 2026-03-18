local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Lighting")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("SoundService")
local v_u_6 = game:GetService("Players")
local v_u_7 = v_u_5:WaitForChild("SFX"):WaitForChild("Weather")
require(v_u_1:WaitForChild("Weather"):WaitForChild("WeatherDataDefinitions"))
local v_u_8 = v_u_1:WaitForChild("Weather"):FindFirstChild("Behaviors")
local v_u_9 = {
	["_activeParticles"] = {},
	["_activeSky"] = nil,
	["_activeAtmosphere"] = nil,
	["_activeClouds"] = nil,
	["_connections"] = {},
	["_defaultLighting"] = {},
	["_transitionTime"] = 2,
	["_activeWeatherSound"] = nil,
	["_connectionCounter"] = 0,
	["_activeBehavior"] = nil,
	["_weatherVersion"] = 0
}
local v_u_16 = {
	["Linear"] = function(p10)
		return p10
	end,
	["QuadIn"] = function(p11)
		return p11 * p11
	end,
	["QuadOut"] = function(p12)
		return p12 * (2 - p12)
	end,
	["QuadInOut"] = function(p13)
		return p13 < 0.5 and 2 * p13 * p13 or -1 + (4 - 2 * p13) * p13
	end,
	["CubicIn"] = function(p14)
		return p14 * p14 * p14
	end,
	["CubicOut"] = function(p15)
		return 1 - (1 - p15) ^ 3
	end
}
local function v_u_18()
	-- upvalues: (copy) v_u_9, (copy) v_u_2
	v_u_9._defaultLighting = {
		["Brightness"] = v_u_2.Brightness,
		["Ambient"] = v_u_2.Ambient,
		["OutdoorAmbient"] = v_u_2.OutdoorAmbient,
		["ClockTime"] = v_u_2.ClockTime
	}
	local v17 = v_u_2:FindFirstChildOfClass("Atmosphere")
	if v17 then
		v_u_9._defaultLighting.Atmosphere = {
			["Density"] = v17.Density,
			["Offset"] = v17.Offset,
			["Color"] = v17.Color,
			["Decay"] = v17.Decay,
			["Glare"] = v17.Glare,
			["Haze"] = v17.Haze
		}
	end
end
local function v_u_22(p19, p20)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_9
	local v21 = {}
	if p19 then
		v21.Brightness = p19
	end
	if p20 then
		v21.Ambient = p20
		v21.OutdoorAmbient = p20
	end
	if next(v21) then
		return v_u_3:Create(v_u_2, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), v21)
	else
		return nil
	end
end
local function v_u_26(p23)
	-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_3
	local v24 = v_u_2:FindFirstChildOfClass("Atmosphere")
	if v24 then
		v_u_9._activeAtmosphere = v24
		return v_u_3:Create(v24, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			["Density"] = p23.Density,
			["Offset"] = p23.Offset,
			["Color"] = p23.Color,
			["Decay"] = p23.Decay,
			["Glare"] = p23.Glare,
			["Haze"] = p23.Haze
		})
	end
	local v25 = Instance.new("Atmosphere")
	v25.Density = p23.Density
	v25.Offset = p23.Offset
	v25.Color = p23.Color
	v25.Decay = p23.Decay
	v25.Glare = p23.Glare
	v25.Haze = p23.Haze
	v25.Parent = v_u_2
	v_u_9._activeAtmosphere = v25
	return nil
end
local function v_u_31()
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_4
	local v_u_27 = v_u_9._activeParticles
	v_u_9._activeParticles = {}
	if #v_u_27 ~= 0 then
		for _, v28 in ipairs(v_u_27) do
			if v28.Part and v28.Part.Parent then
				for _, v29 in ipairs(v28.Part:GetDescendants()) do
					if v29:IsA("ParticleEmitter") then
						v_u_3:Create(v29, TweenInfo.new(v_u_9._transitionTime / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							["Rate"] = 0
						}):Play()
					end
				end
			end
		end
		task.delay(v_u_9._transitionTime / 2 + 0.5, function()
			-- upvalues: (copy) v_u_27, (ref) v_u_4
			for _, v30 in ipairs(v_u_27) do
				if v30.ConnectionName then
					v_u_4:UnbindFromRenderStep(v30.ConnectionName)
				end
				if v30.Part and v30.Part.Parent then
					v30.Part:Destroy()
				end
			end
		end)
	end
end
local function v_u_51(p32)
	-- upvalues: (copy) v_u_6, (copy) v_u_3, (copy) v_u_9, (copy) v_u_4
	local v_u_33 = workspace.CurrentCamera
	if v_u_33 then
		local v34 = v_u_6.LocalPlayer.CameraMaxZoomDistance * 2 + 50
		local v35 = Vector3.new(v34, 1, v34)
		local v36 = (1 / 0)
		for _, v37 in ipairs(p32) do
			if v37.Position.Y < v36 then
				v36 = v37.Position.Y
			end
		end
		for _, v_u_38 in ipairs(p32) do
			local v_u_39 = v_u_38.Position.Y - v36
			local v40 = v_u_38.Size.X * v_u_38.Size.Z
			local v41 = v35.X * v35.Z / v40
			v_u_38.Size = v35
			v_u_38.Anchored = true
			v_u_38.CanCollide = false
			v_u_38.CanQuery = false
			v_u_38.CanTouch = false
			v_u_38.Transparency = 1
			v_u_38.Parent = v_u_33
			for _, v42 in ipairs(v_u_38:GetDescendants()) do
				if v42:IsA("ParticleEmitter") then
					local v43 = v42.Rate * v41
					v42.Rate = 0
					v_u_3:Create(v42, TweenInfo.new(v_u_9._transitionTime / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Rate"] = v43
					}):Play()
				end
			end
			local v44 = v_u_9
			v44._connectionCounter = v44._connectionCounter + 1
			local v45 = "WeatherFollow_" .. v_u_9._connectionCounter
			v_u_4:BindToRenderStep(v45, Enum.RenderPriority.Camera.Value + 1, function()
				-- upvalues: (copy) v_u_33, (copy) v_u_38, (copy) v_u_39
				if v_u_33 and v_u_38.Parent then
					local v46 = v_u_33.CFrame.Position
					local v47 = v_u_38
					local v48 = CFrame.new
					local v49 = 30 + v_u_39
					v47.CFrame = v48(v46 + Vector3.new(0, v49, 0))
				end
			end)
			local v50 = v_u_9._activeParticles
			table.insert(v50, {
				["Part"] = v_u_38,
				["ConnectionName"] = v45
			})
		end
	end
end
local function v_u_55(p52)
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_5, (copy) v_u_1, (copy) v_u_7
	if v_u_9._activeWeatherSound then
		local v_u_53 = v_u_9._activeWeatherSound
		if v_u_53.Name == p52 then
			return
		end
		v_u_3:Create(v_u_53, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Volume"] = 0
		}):Play()
		task.delay(v_u_9._transitionTime, function()
			-- upvalues: (copy) v_u_53
			if v_u_53 and v_u_53.IsPlaying then
				v_u_53:Stop()
			end
		end)
		v_u_9._activeWeatherSound = nil
	end
	if p52 and (p52 ~= "" and p52 ~= "Normal") then
		local v54 = v_u_7:FindFirstChild(p52)
		if v54 and v54:IsA("Sound") then
			v_u_1:SetAttribute("WeatherMusicPlaying", true)
			v54.Looped = true
			v54.Volume = 0
			v54:Play()
			v_u_3:Create(v54, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["Volume"] = 1
			}):Play()
			v_u_9._activeWeatherSound = v54
		else
			if not v_u_5:FindFirstChild("EventSFX") then
				v_u_1:SetAttribute("WeatherMusicPlaying", false)
			end
			warn("[WeatherController] Could not find a pre-loaded sound named:", p52)
		end
	else
		if not v_u_5:FindFirstChild("EventSFX") then
			v_u_1:SetAttribute("WeatherMusicPlaying", false)
		end
		return
	end
end
local function v_u_73()
	-- upvalues: (copy) v_u_1, (copy) v_u_26, (copy) v_u_9, (copy) v_u_22, (copy) v_u_3, (copy) v_u_2, (copy) v_u_31, (copy) v_u_51
	local v56 = v_u_1:FindFirstChild("ActiveWeatherContent")
	local v_u_57 = {
		["sky"] = nil,
		["atmosphere"] = nil,
		["brightness"] = nil,
		["ambientColor"] = nil,
		["particles"] = {},
		["clouds"] = nil,
		["clockTime"] = nil
	}
	if v56 then
		for _, v58 in ipairs(v56:GetChildren()) do
			if v58:IsA("Sky") then
				v_u_57.sky = v58:Clone()
			elseif v58:IsA("Atmosphere") then
				v_u_57.atmosphere = v58:Clone()
			elseif v58:IsA("Clouds") then
				v_u_57.clouds = v58:Clone()
			elseif v58:IsA("NumberValue") then
				if v58.Name == "Brightness" or v58.Name == "LightValue" then
					v_u_57.brightness = v58.Value
				elseif v58.Name == "ClockTime" then
					v_u_57.clockTime = v58.Value
				end
			elseif v58:IsA("Vector3Value") then
				if v58.Name == "AllLightingColors" then
					v_u_57.ambientColor = Color3.fromRGB(v58.Value.X, v58.Value.Y, v58.Value.Z)
				end
			elseif v58:IsA("BasePart") then
				local v59 = v_u_57.particles
				table.insert(v59, v58:Clone())
			end
		end
	end
	local v60 = {}
	if v_u_57.atmosphere then
		local v61 = v_u_26(v_u_57.atmosphere)
		if v61 then
			table.insert(v60, v61)
		end
		v_u_57.atmosphere:Destroy()
	else
		local v62 = v_u_9._defaultLighting.Atmosphere and v_u_26(v_u_9._defaultLighting.Atmosphere)
		if v62 then
			table.insert(v60, v62)
		end
	end
	local v63 = v_u_22(v_u_57.brightness or (v_u_9._defaultLighting.Brightness or 2), v_u_57.ambientColor or (v_u_9._defaultLighting.Ambient or Color3.fromRGB(127, 127, 127)))
	if v63 then
		table.insert(v60, v63)
	end
	local v64 = v_u_57.clockTime or (v_u_9._defaultLighting.ClockTime or 15)
	local v65 = v_u_3:Create(v_u_2, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		["ClockTime"] = v64
	})
	table.insert(v60, v65)
	if v_u_57.clouds then
		local v66 = v_u_2:FindFirstChildOfClass("Clouds")
		if not v66 then
			v66 = Instance.new("Clouds")
			v66.Cover = 0
			v66.Parent = v_u_2
		end
		v_u_9._activeClouds = v66
		local v67 = v_u_3:Create(v66, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			["Cover"] = v_u_57.clouds.Cover,
			["Density"] = v_u_57.clouds.Density,
			["Color"] = v_u_57.clouds.Color
		})
		table.insert(v60, v67)
		v_u_57.clouds:Destroy()
	elseif v_u_9._activeClouds then
		local v68 = v_u_3:Create(v_u_9._activeClouds, TweenInfo.new(v_u_9._transitionTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			["Cover"] = 0
		})
		table.insert(v60, v68)
		local v_u_69 = v_u_9._activeClouds
		v_u_9._activeClouds = nil
		task.delay(v_u_9._transitionTime + 0.5, function()
			-- upvalues: (copy) v_u_69
			if v_u_69 and v_u_69.Parent then
				v_u_69:Destroy()
			end
		end)
	end
	v_u_31()
	for _, v70 in ipairs(v60) do
		v70:Play()
	end
	task.delay(v_u_9._transitionTime * 0.3, function()
		-- upvalues: (copy) v_u_57, (ref) v_u_9, (ref) v_u_2
		local v71 = v_u_57.sky
		local v72 = v_u_9._activeSky
		if v71 then
			v71.Parent = v_u_2
			v_u_9._activeSky = v71
		end
		if v72 then
			v72:Destroy()
		end
		if not v71 then
			v_u_9._activeSky = nil
		end
	end)
	v_u_51(v_u_57.particles)
end
local function v_u_78(p_u_74)
	local v_u_75 = p_u_74:GetAttribute("EmitCount")
	local v76 = p_u_74:GetAttribute("EmitDelay") or 0
	local v_u_77 = p_u_74:GetAttribute("EmitDuration")
	task.delay(v76, function()
		-- upvalues: (copy) v_u_75, (copy) p_u_74, (copy) v_u_77
		if v_u_75 and v_u_75 > 0 then
			p_u_74:Emit(v_u_75)
		elseif v_u_77 ~= nil then
			p_u_74.Enabled = true
			if v_u_77 > 0 then
				task.delay(v_u_77, function()
					-- upvalues: (ref) p_u_74
					p_u_74.Enabled = false
				end)
			end
		end
	end)
end
local function v_u_85(p79, p80)
	-- upvalues: (copy) v_u_7
	if p79.WeatherName then
		local v81 = v_u_7:FindFirstChild("Special")
		if v81 then
			if p79.SoundName then
				local v82 = v81:FindFirstChild(p79.SoundName)
				if v82 then
					local v_u_83 = Instance.new("Part")
					v_u_83.Size = Vector3.new(1, 1, 1)
					v_u_83.Transparency = 1
					v_u_83.Anchored = true
					v_u_83.CanCollide = false
					v_u_83.CanQuery = false
					v_u_83.CanTouch = false
					v_u_83.Position = p80
					v_u_83.Parent = workspace
					local v84 = v82:Clone()
					v84.Parent = v_u_83
					if not v84.IsLoaded then
						v84.Loaded:Wait()
					end
					v84:Play()
					v84.Ended:Once(function()
						-- upvalues: (copy) v_u_83
						v_u_83:Destroy()
					end)
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_136(p_u_86)
	-- upvalues: (copy) v_u_1, (copy) v_u_16, (copy) v_u_7, (copy) v_u_4, (copy) v_u_85, (copy) v_u_78
	local v87 = v_u_1:FindFirstChild("ActiveWeatherContent")
	local v88
	if v87 then
		v88 = v87:FindFirstChild("VisualEffectModel")
		if not (v88 and v88:IsA("Model")) then
			v88 = nil
		end
	else
		v88 = nil
	end
	if v88 then
		local v_u_89 = v88:Clone()
		v_u_89.Parent = workspace
		local v_u_90 = p_u_86.SpawnPosition
		local v_u_91 = p_u_86.TargetPosition
		local v_u_92 = p_u_86.TravelTime or 1
		local v93 = p_u_86.Easing or "Linear"
		local v_u_94 = p_u_86.HideOnImpact or false
		local v_u_95 = p_u_86.StopEmittersOnImpact or false
		local v_u_96 = p_u_86.CleanupDelay or 2
		local v_u_97 = p_u_86.ImpactParts or {}
		local v_u_98 = p_u_86.WaveMotion
		local v_u_99 = v_u_16[v93] or v_u_16.Linear
		local v_u_100 = CFrame.identity
		if p_u_86.Rotation then
			v_u_100 = CFrame.Angles(p_u_86.Rotation.X, p_u_86.Rotation.Y, p_u_86.Rotation.Z)
		end
		local function v_u_102()
			-- upvalues: (copy) v_u_89
			for _, v101 in ipairs(v_u_89:GetDescendants()) do
				if v101:IsA("BasePart") and v101:GetAttribute("FlatOnImpact") then
					v101.CFrame = CFrame.new(v101.Position)
				end
			end
		end
		local function v_u_112(p103)
			-- upvalues: (copy) v_u_98, (copy) v_u_90, (copy) v_u_91
			if not (v_u_98 and v_u_98.Enabled) then
				return v_u_90.Y + (v_u_91.Y - v_u_90.Y) * p103
			end
			local v104 = v_u_98.GroundY
			local v105 = v_u_98.PeakY
			local v106 = v_u_98.RiseEnd or 0.2
			local v107 = v_u_98.DescendStart or 0.8
			if p103 <= v106 then
				local v108 = p103 / v106
				local v109 = 1 - (1 - v108) * (1 - v108)
				return v104 + (v105 - v104) * v109
			end
			if v107 > p103 then
				return v105
			end
			local v110 = (p103 - v107) / (1 - v107)
			local v111 = v110 * v110
			return v105 + (v104 - v105) * v111
		end
		v_u_89:PivotTo(CFrame.new(v_u_90) * v_u_100)
		v_u_102()
		local v_u_113 = nil
		if p_u_86.MovingSoundName then
			local v114 = v_u_7:FindFirstChild("Special")
			if v114 then
				local v115 = v114:FindFirstChild(p_u_86.MovingSoundName)
				if v115 then
					local v116 = Instance.new("Part")
					v116.Size = Vector3.new(1, 1, 1)
					v116.Transparency = 1
					v116.Anchored = true
					v116.CanCollide = false
					v116.CanQuery = false
					v116.CanTouch = false
					v116.Position = v_u_90
					v116.Parent = v_u_89
					local v117 = v115:Clone()
					v117.Looped = true
					v117.Parent = v116
					v117:Play()
					v_u_113 = {
						["Part"] = v116,
						["Sound"] = v117
					}
				end
			end
		end
		local v_u_118 = 0
		local v_u_119 = nil
		v_u_119 = v_u_4.RenderStepped:Connect(function(p120)
			-- upvalues: (ref) v_u_118, (copy) v_u_92, (copy) v_u_99, (copy) v_u_90, (copy) v_u_91, (copy) v_u_112, (ref) v_u_100, (copy) v_u_89, (copy) v_u_102, (ref) v_u_113, (ref) v_u_119, (ref) v_u_85, (copy) p_u_86, (copy) v_u_97, (ref) v_u_78, (copy) v_u_95, (copy) v_u_94, (copy) v_u_96
			v_u_118 = v_u_118 + p120
			local v121 = v_u_118 / v_u_92
			local v122 = math.min(v121, 1)
			local v123 = v_u_99(v122)
			local v124 = v_u_90.X + (v_u_91.X - v_u_90.X) * v123
			local v125 = v_u_90.Z + (v_u_91.Z - v_u_90.Z) * v123
			local v126 = v_u_112(v122)
			local v127 = Vector3.new(v124, v126, v125)
			v_u_89:PivotTo(CFrame.new(v127) * v_u_100)
			v_u_102()
			if v_u_113 and v_u_113.Part then
				v_u_113.Part.Position = v127
			end
			if v122 >= 1 then
				v_u_119:Disconnect()
				if v_u_113 then
					if v_u_113.Sound then
						v_u_113.Sound:Stop()
					end
					if v_u_113.Part then
						v_u_113.Part:Destroy()
					end
					v_u_113 = nil
				end
				task.spawn(v_u_85, p_u_86, v_u_91)
				local v128 = {}
				for _, v129 in ipairs(v_u_97) do
					local v130 = v_u_89:FindFirstChild(v129, true)
					if v130 then
						v128[v130] = true
						for _, v131 in ipairs(v130:GetDescendants()) do
							if v131:IsA("ParticleEmitter") then
								v_u_78(v131)
							end
						end
					end
				end
				if v_u_95 then
					for _, v132 in ipairs(v_u_89:GetDescendants()) do
						local v133 = false
						for v134 in pairs(v128) do
							if v132:IsDescendantOf(v134) then
								v133 = true
								break
							end
						end
						if not v133 then
							if v132:IsA("ParticleEmitter") then
								v132.Enabled = false
								v132:Clear()
							elseif v132:IsA("Beam") then
								v132.Enabled = false
							elseif v132:IsA("Trail") then
								v132.Enabled = false
							end
						end
					end
				end
				if v_u_94 then
					for _, v135 in ipairs(v_u_89:GetDescendants()) do
						if v135:IsA("BasePart") then
							v135.Transparency = 1
						end
					end
				end
				task.delay(v_u_96, function()
					-- upvalues: (ref) v_u_89
					if v_u_89 and v_u_89.Parent then
						v_u_89:Destroy()
					end
				end)
			end
		end)
	else
		warn("[WeatherController] No VisualEffectModel found in ActiveWeatherContent")
	end
end
function v_u_9.StartBehavior(p137, p138)
	-- upvalues: (copy) v_u_8
	p137:StopBehavior()
	if v_u_8 then
		local v139 = v_u_8:FindFirstChild(p138)
		if v139 and v139:IsA("ModuleScript") then
			local v140, v_u_141 = pcall(require, v139)
			if v140 then
				p137._activeBehavior = v_u_141
				local v142, v143 = pcall(function()
					-- upvalues: (copy) v_u_141
					v_u_141:Start()
				end)
				if not v142 then
					warn((("[WeatherController] Failed to start client behavior for %*: %*"):format(p138, v143)))
					p137._activeBehavior = nil
				end
			else
				warn((("[WeatherController] Failed to load client behavior for %*: %*"):format(p138, v_u_141)))
			end
		else
			return
		end
	else
		return
	end
end
function v_u_9.StopBehavior(p_u_144)
	if p_u_144._activeBehavior then
		pcall(function()
			-- upvalues: (copy) p_u_144
			p_u_144._activeBehavior:Stop()
		end)
		p_u_144._activeBehavior = nil
	end
end
function v_u_9.StartWeather(p145, p146)
	-- upvalues: (copy) v_u_55, (copy) v_u_73
	print((("[WeatherController] Starting weather: %*"):format(p146)))
	v_u_55(p146)
	v_u_73()
	p145:StartBehavior(p146)
end
function v_u_9.StopWeather(p147, p148)
	-- upvalues: (copy) v_u_55, (copy) v_u_31
	print((("[WeatherController] Stopping weather: %*"):format(p148)))
	p147:StopBehavior()
	v_u_55(nil)
	v_u_31()
end
function v_u_9.Init(p_u_149)
	-- upvalues: (copy) v_u_18, (copy) v_u_1, (copy) v_u_73, (copy) v_u_6, (copy) v_u_136, (copy) v_u_55
	v_u_18()
	v_u_1:WaitForChild("RemoteEvents"):WaitForChild("WeatherEvent").OnClientEvent:Connect(function(p150, p151)
		-- upvalues: (copy) p_u_149, (ref) v_u_73, (ref) v_u_6, (ref) v_u_136
		if p150 == "WeatherStarted" then
			local v152 = p_u_149
			v152._weatherVersion = v152._weatherVersion + 1
			p_u_149:StartWeather(p151.Name)
		elseif p150 == "WeatherEnded" then
			local v153 = p_u_149._weatherVersion
			p_u_149:StopWeather(p151.Name)
			task.wait(1)
			if p_u_149._weatherVersion == v153 then
				v_u_73()
				return
			end
		else
			if p150 == "SyncWeather" then
				p_u_149:StartWeather(p151.Name)
				return
			end
			if p150 == "ForceEmote" then
				if p151 and p151.Emote then
					local v154 = v_u_6.LocalPlayer
					if v154 and v154.Character then
						local v155 = v154.Character:FindFirstChild("Animate")
						local v156 = v155 and v155:FindFirstChild("PlayEmote")
						if v156 then
							pcall(v156.Invoke, v156, p151.Emote)
							return
						end
					end
				end
			elseif p150 == "VisualEffect" then
				v_u_136(p151)
			end
		end
	end)
	local v157 = workspace:GetAttribute("CurrentWeather")
	if v157 and v157 ~= "" then
		task.wait(0.5)
		v_u_55(v157)
		v_u_73()
		p_u_149:StartBehavior(v157)
	end
	print("[WeatherController] Initialized")
end
v_u_9:Init()
return v_u_9