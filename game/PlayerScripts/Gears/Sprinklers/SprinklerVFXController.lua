local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("SoundService")
local v_u_3 = game:GetService("RunService")
local v4 = {}
local v_u_5 = nil
local v_u_6 = {}
local v7 = v2:WaitForChild("SFX"):WaitForChild("Gears"):WaitForChild("Sprinklers")
local v_u_8 = v7:WaitForChild("SprinklerStart")
local v_u_9 = v7:WaitForChild("SprinklerMain")
local function v_u_12(p10)
	if p10.PrimaryPart then
		return p10.PrimaryPart
	end
	for _, v11 in p10:GetDescendants() do
		if v11:IsA("BasePart") then
			return v11
		end
	end
	return nil
end
local function v_u_17(p13)
	local v14 = {}
	local v15 = p13:FindFirstChild("GroundAnchor")
	if not v15 then
		return v14
	end
	for _, v16 in v15:GetChildren() do
		if v16:IsA("Attachment") and v16.Name == "PreviewOutline" then
			table.insert(v14, v16)
		end
	end
	return v14
end
local function v_u_21(p18)
	-- upvalues: (copy) v_u_17
	for _, v19 in v_u_17(p18) do
		for _, v20 in v19:GetDescendants() do
			if v20:IsA("ParticleEmitter") then
				v20.Enabled = false
			end
		end
	end
end
local function v_u_35(p_u_22)
	-- upvalues: (copy) v_u_17
	local v23 = v_u_17(p_u_22)
	if #v23 == 0 then
		return
	else
		local v_u_24 = {}
		local v_u_25 = {}
		for _, v26 in v23 do
			for _, v27 in v26:GetDescendants() do
				if v27:IsA("ParticleEmitter") then
					v27.Enabled = false
					v_u_24[v27] = v27.Transparency
					v27.Transparency = NumberSequence.new(0.999)
					table.insert(v_u_25, v27)
				end
			end
		end
		if #v_u_25 ~= 0 then
			p_u_22:GetAttributeChangedSignal("ValidPlacement"):Connect(function()
				-- upvalues: (copy) p_u_22, (copy) v_u_25, (copy) v_u_24
				local v28 = p_u_22:GetAttribute("ValidPlacement") == true
				for _, v29 in v_u_25 do
					if v29 and v29.Parent then
						local v30
						if v28 then
							v30 = v_u_24[v29]
						else
							v30 = NumberSequence.new(0.999)
						end
						v29.Transparency = v30
					end
				end
			end)
			for _, v_u_31 in v_u_25 do
				task.spawn(function()
					-- upvalues: (copy) v_u_31, (copy) p_u_22
					local v32 = v_u_31.Lifetime.Max
					local v33 = v_u_31.Rate * v32
					local v34 = math.ceil(v33)
					if v32 > 0 and v34 > 0 then
						while p_u_22 and (p_u_22.Parent and (v_u_31 and v_u_31.Parent)) do
							v_u_31:Emit(v34)
							task.wait(v32)
						end
					end
				end)
			end
		end
	end
end
local function v_u_43(p36)
	-- upvalues: (copy) v_u_17, (copy) v_u_35
	local v37 = v_u_17(p36)
	for _, v38 in p36:GetDescendants() do
		if v38:IsA("BasePart") then
			v38.Transparency = 0.5
			v38.CanCollide = false
			v38.Anchored = true
			v38.CastShadow = false
		end
	end
	::l6::
	for _, v39 in p36:GetDescendants() do
		if v39:IsA("ParticleEmitter") then
			if #v37 ~= 0 then
				for _, v40 in v37 do
					if v39:IsDescendantOf(v40) then
						v41 = true
						::l13::
						if not v41 then
							goto l9
						end
						goto l6
					end
				end
				local v41 = false
				goto l13
			end
			::l9::
			v39.Enabled = false
		end
		::l6::
	end
	local v42 = p36:FindFirstChild("GroundAnchor")
	if v42 and v42:IsA("BasePart") then
		v42.Transparency = 1
	end
	v_u_35(p36)
end
local function v_u_48(p44)
	-- upvalues: (copy) v_u_12, (copy) v_u_8, (copy) v_u_9, (copy) v_u_6
	local v45 = v_u_12(p44)
	if v45 then
		local v46 = v_u_8:Clone()
		v46.Parent = v45
		local v_u_47 = v_u_9:Clone()
		v_u_47.Looped = true
		v_u_47.Parent = v45
		v_u_6[p44] = {
			["Start"] = v46,
			["Main"] = v_u_47
		}
		v46.Ended:Once(function()
			-- upvalues: (copy) v_u_47
			if v_u_47 and v_u_47.Parent then
				v_u_47:Play()
			end
		end)
		v46:Play()
	end
end
local function v_u_51(p49)
	-- upvalues: (copy) v_u_6
	local v50 = v_u_6[p49]
	if v50 then
		if v50.Start and v50.Start.Parent then
			v50.Start:Stop()
			v50.Start:Destroy()
		end
		if v50.Main and v50.Main.Parent then
			v50.Main:Stop()
			v50.Main:Destroy()
		end
		v_u_6[p49] = nil
	end
end
local function v_u_53(p52)
	-- upvalues: (copy) v_u_21, (copy) v_u_48
	v_u_21(p52)
	v_u_48(p52)
end
local function v_u_61(p54)
	-- upvalues: (copy) v_u_1
	for _, v55 in v_u_1:GetTagged("Sprinkler") do
		if v55:IsA("Model") then
			local v56 = v55:FindFirstChild("Head")
			if v56 and v56:IsA("Model") then
				local v57 = v56.PrimaryPart
				if v57 then
					local v58 = 1.5707963267948966 * (1 + (v55:GetAttribute("Duration") or 300) / 1000)
					local v59 = CFrame.new(v57.Position)
					local v60 = v59:Inverse() * v56:GetPivot()
					v56:PivotTo(v59 * CFrame.Angles(0, v58 * p54, 0) * v60)
				end
			end
		end
	end
end
function v4.Init()
	-- upvalues: (ref) v_u_5, (copy) v_u_3, (copy) v_u_61, (copy) v_u_1, (copy) v_u_21, (copy) v_u_48, (copy) v_u_53, (copy) v_u_51, (copy) v_u_43
	if not v_u_5 then
		v_u_5 = v_u_3.RenderStepped:Connect(v_u_61)
		for _, v62 in v_u_1:GetTagged("Sprinkler") do
			v_u_21(v62)
			v_u_48(v62)
		end
		v_u_1:GetInstanceAddedSignal("Sprinkler"):Connect(v_u_53)
		v_u_1:GetInstanceRemovedSignal("Sprinkler"):Connect(v_u_51)
		v_u_1:GetInstanceAddedSignal("SprinklerPreview"):Connect(v_u_43)
	end
end
return v4