local v_u_1 = game:GetService("InsertService")
game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Debris")
local v_u_4 = game:GetService("RunService")
local v_u_36 = {
	["spawnPart"] = function(p5)
		local v6 = Instance.new("Part")
		v6.Name = "NewPart"
		v6.Anchored = true
		v6.Size = Vector3.new(4, 1, 4)
		v6.Material = Enum.Material.Plastic
		if p5 then
			for v7, v8 in pairs(p5) do
				v6[v7] = v8
			end
		end
		v6.Parent = p5 and p5.Parent or workspace
		return v6
	end,
	["spawnModel"] = function(p_u_9, p10)
		-- upvalues: (copy) v_u_4, (copy) v_u_1
		if not v_u_4:IsServer() then
			warn("[AssetLibrary] spawnModel can only be called from the server due to InsertService restrictions.")
			return nil
		end
		local v11, v12 = pcall(function()
			-- upvalues: (ref) v_u_1, (copy) p_u_9
			return v_u_1:LoadAsset(p_u_9)
		end)
		if v11 and v12 then
			local v13 = v12:GetChildren()[1]
			if v13 then
				v13.Parent = p10 or workspace
				v12:Destroy()
				return v13
			end
		else
			warn("[AssetLibrary] Failed to load model:", p_u_9)
		end
		return nil
	end,
	["createExplosionEffect"] = function(p14, p15)
		-- upvalues: (copy) v_u_3
		local v16 = Instance.new("Part")
		v16.Name = "EffectPart"
		v16.Transparency = 1
		v16.CanCollide = false
		v16.Anchored = true
		v16.Position = p14
		v16.Parent = workspace
		v_u_3:AddItem(v16, 2)
		local v17 = Instance.new("Attachment", v16)
		local v18 = Instance.new("ParticleEmitter")
		v18.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		v18.Color = ColorSequence.new(p15 or Color3.fromRGB(255, 170, 0))
		v18.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
		v18.Lifetime = NumberRange.new(0.5, 1)
		v18.Rate = 0
		v18.Speed = NumberRange.new(10, 20)
		v18.SpreadAngle = Vector2.new(360, 360)
		v18.Parent = v17
		v18:Emit(50)
		return v16
	end,
	["createFloatingText"] = function(p19, p20, p21)
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		local v22 = Instance.new("Part")
		v22.Name = "FloatingText"
		v22.Transparency = 1
		v22.CanCollide = false
		v22.Anchored = true
		v22.Position = p19
		v22.Parent = workspace
		v_u_3:AddItem(v22, 3)
		local v23 = Instance.new("BillboardGui")
		v23.Size = UDim2.fromScale(4, 1)
		v23.AlwaysOnTop = true
		v23.Parent = v22
		local v_u_24 = Instance.new("TextLabel")
		v_u_24.Size = UDim2.fromScale(1, 1)
		v_u_24.BackgroundTransparency = 1
		v_u_24.Text = p20
		v_u_24.TextColor3 = p21 or Color3.new(1, 1, 1)
		v_u_24.TextScaled = true
		v_u_24.Font = Enum.Font.GothamBlack
		v_u_24.TextStrokeTransparency = 0
		v_u_24.Parent = v23
		v_u_2:Create(v22, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["Position"] = p19 + Vector3.new(0, 5, 0)
		}):Play()
		task.delay(1, function()
			-- upvalues: (ref) v_u_2, (copy) v_u_24
			v_u_2:Create(v_u_24, TweenInfo.new(1), {
				["TextTransparency"] = 1,
				["TextStrokeTransparency"] = 1
			}):Play()
		end)
		return v22
	end,
	["createZone"] = function(p25, p26)
		local v27 = Instance.new("Part")
		v27.Name = "Zone"
		v27.Anchored = true
		v27.CanCollide = false
		v27.Transparency = 0.8
		v27.Material = Enum.Material.ForceField
		v27.Color = Color3.fromRGB(0, 255, 100)
		v27.Size = p26
		v27.CFrame = p25
		v27.Parent = workspace
		return v27
	end,
	["spawnSpotlight"] = function(p28, p29)
		-- upvalues: (copy) v_u_36
		local v30 = v_u_36.spawnPart({
			["Position"] = p28,
			["Anchored"] = true,
			["Transparency"] = 1,
			["CanCollide"] = false,
			["Name"] = "SpotlightSource"
		})
		local v31 = Instance.new("SpotLight")
		v31.Brightness = 2
		v31.Range = 20
		v31.Color = p29 or Color3.fromRGB(255, 255, 255)
		v31.Face = Enum.NormalId.Bottom
		v31.Parent = v30
		return v30
	end,
	["playSound"] = function(p32, p33)
		-- upvalues: (copy) v_u_3
		local v34 = Instance.new("Sound")
		v34.SoundId = p32
		v34.Parent = p33 or workspace
		v34.PlayOnRemove = true
		v34:Destroy()
		local v35 = Instance.new("Sound")
		v35.SoundId = p32
		v35.Parent = p33 or workspace
		v35:Play()
		v_u_3:AddItem(v35, 10)
		return v35
	end
}
return v_u_36