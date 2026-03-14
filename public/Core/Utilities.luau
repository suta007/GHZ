local Services = require(script.Parent.Services)
local State = require(script.Parent.State)
local Constants = require(script.Parent.Constants)

local Utils = {}
local RNG = Random.new()
local AntiLagConnections = {}
local SettingCache = {}
local noclipConnection = nil

function Utils.ShowData(tbl, indent)
	local lclIndent = indent or 0
	local spacing = string.rep("  ", lclIndent)
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			if type(v) == "table" then
				print(spacing .. "[" .. tostring(k) .. "] : (Table)")
				Utils.ShowData(v, lclIndent + 1)
			else
				print(spacing .. "[" .. tostring(k) .. "] : " .. tostring(v))
			end
		end
	else
		print(spacing .. tostring(tbl))
	end
end

function Utils.InitializePlotData()
	local PlotsFolder = workspace:FindFirstChild("Plots")
	if not PlotsFolder then return false end
	for _, plot in ipairs(PlotsFolder:GetChildren()) do
		local ownerVal = plot:FindFirstChild("Owner")
		if ownerVal and ownerVal.Value == Services.LocalPlayer.Name then
			local plantableArea = plot:FindFirstChild("PlantableArea")
			State.MyPlot = plot
			State.MySpawn = State.MyPlot.Spawn
			State.MySpawnPoint = State.MySpawn:GetPivot()
			if plantableArea then
				table.clear(State.MyPlantableParts)
				for _, part in ipairs(plantableArea:GetChildren()) do
					if part:IsA("BasePart") then table.insert(State.MyPlantableParts, part) end
				end
				return true
			end
		end
	end
	return false
end

function Utils.CaptureSettings()
	SettingCache = {
		GlobalShadows = Services.Lighting.GlobalShadows,
		FogEnd = Services.Lighting.FogEnd,
		Brightness = Services.Lighting.Brightness,
		EnvDiffuse = Services.Lighting.EnvironmentDiffuseScale,
		EnvSpecular = Services.Lighting.EnvironmentSpecularScale,
		OutdoorAmbient = Services.Lighting.OutdoorAmbient,
		WaterWaveSize = Services.Terrain.WaterWaveSize,
		WaterWaveSpeed = Services.Terrain.WaterWaveSpeed,
		WaterReflectance = Services.Terrain.WaterReflectance,
		WaterTransparency = Services.Terrain.WaterTransparency,
	}
end

function Utils.ApplyAntiLag()
	Utils.CaptureSettings()
	Services.Lighting.GlobalShadows = false
	Services.Lighting.FogEnd = 9e9
	Services.Lighting.Brightness = 2
	Services.Lighting.EnvironmentDiffuseScale = 0
	Services.Lighting.EnvironmentSpecularScale = 0
	Services.Lighting.OutdoorAmbient = Color3.new(0, 0, 0)
	Services.Terrain.WaterWaveSize = 0
	Services.Terrain.WaterWaveSpeed = 0
	Services.Terrain.WaterReflectance = 0
	Services.Terrain.WaterTransparency = 1

	local targetFolders = {
		workspace:FindFirstChild("ClientPlants"),
		workspace:FindFirstChild("MapPhysical"),
	}

	local function ApplyToPart(v)
		local mapPhysical = workspace:FindFirstChild("MapPhysical")
		if mapPhysical then
			local shops = mapPhysical:FindFirstChild("Shops")
			if shops and v:IsDescendantOf(shops) then return end
		end

		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") then
			v.Enabled = false
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		end
	end

	for _, folder in ipairs(targetFolders) do
		if folder then
			for i, v in ipairs(folder:GetDescendants()) do
				if i % 200 == 0 then task.wait() end
				ApplyToPart(v)
			end
			table.insert(
				AntiLagConnections,
				folder.DescendantAdded:Connect(function(v)
					if State.isAntiLag then ApplyToPart(v) end
				end)
			)
		end
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end

function Utils.RestoreAntiLag()
	for _, conn in ipairs(AntiLagConnections) do
		if conn then conn:Disconnect() end
	end
	table.clear(AntiLagConnections)

	if SettingCache.GlobalShadows ~= nil then
		Services.Lighting.GlobalShadows = SettingCache.GlobalShadows
		Services.Lighting.FogEnd = SettingCache.FogEnd
		Services.Lighting.Brightness = SettingCache.Brightness
		Services.Lighting.EnvironmentDiffuseScale = SettingCache.EnvDiffuse
		Services.Lighting.EnvironmentSpecularScale = SettingCache.EnvSpecular
		Services.Lighting.OutdoorAmbient = SettingCache.OutdoorAmbient
		Services.Terrain.WaterWaveSize = SettingCache.WaterWaveSize
		Services.Terrain.WaterWaveSpeed = SettingCache.WaterWaveSpeed
		Services.Terrain.WaterReflectance = SettingCache.WaterReflectance
		Services.Terrain.WaterTransparency = SettingCache.WaterTransparency
	end

	local targetFolders = {
		workspace:FindFirstChild("ClientPlants"),
		workspace:FindFirstChild("MapPhysical"),
	}

	local function RestorePart(v)
		local mapPhysical = workspace:FindFirstChild("MapPhysical")
		if mapPhysical then
			local shops = mapPhysical:FindFirstChild("Shops")
			if shops and v:IsDescendantOf(shops) then return end
		end

		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") then
			v.Enabled = true
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 0
		end
	end

	for _, folder in ipairs(targetFolders) do
		if folder then
			for i, v in ipairs(folder:GetDescendants()) do
				if i % 200 == 0 then task.wait() end
				RestorePart(v)
			end
		end
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end)
end

function Utils.SetVisibility(obj, isHidden)
	if obj:IsA("BasePart") or obj:IsA("Decal") or obj:IsA("Texture") then
		if isHidden then
			if not obj:GetAttribute("OriginalTrans") then obj:SetAttribute("OriginalTrans", obj.Transparency) end
			obj.Transparency = 1
		else
			local orig = obj:GetAttribute("OriginalTrans")
			if orig then obj.Transparency = orig end
		end
	elseif obj:IsA("ParticleEmitter") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Trail") then
		if isHidden then
			if obj:GetAttribute("OriginalEnabled") == nil then obj:SetAttribute("OriginalEnabled", obj.Enabled) end
			obj.Enabled = false
		else
			local orig = obj:GetAttribute("OriginalEnabled")
			if orig ~= nil then obj.Enabled = orig end
		end
	end
end

function Utils.UpdateVisibilityFromAnchor(anchorName, state, isPlantCheck)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	for _, obj in ipairs(ClientPlants:GetDescendants()) do
		if obj.Name == anchorName then
			local parent = obj.Parent
			if parent then
				if isPlantCheck and parent:FindFirstChild("FruitAnchor") then continue end
				for _, sibling in ipairs(parent:GetChildren()) do
					Utils.SetVisibility(sibling, state)
				end
			end
		end
	end
end

function Utils.GetRandomPlantPosition()
	if #State.MyPlantableParts == 0 then
		if not Utils.InitializePlotData() then return nil end
	end
	local targetPart = State.MyPlantableParts[math.random(1, #State.MyPlantableParts)]
	local size = targetPart.Size
	local cframe = targetPart.CFrame
	local randomY = RNG:NextNumber(-size.Y / 2, size.Y / 2)
	local randomZ = RNG:NextNumber(-size.Z / 2, size.Z / 2)
	local floatDistance = 5
	local localOffset = CFrame.new(floatDistance, randomY, randomZ)
	local worldCFrame = cframe * localOffset
	return CFrame.new(worldCFrame.Position.X, cframe.Position.Y, worldCFrame.Position.Z)
end

function Utils.SetNoClip(state)
	if state then
		if not noclipConnection then
			noclipConnection = Services.RunService.Stepped:Connect(function()
				local char = Services.LocalPlayer.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
					end
				end
			end)
		end
	else
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end
	end
end

function Utils.TweenToTarget(targetCFrame, speed)
	local character = Services.LocalPlayer.Character or Services.LocalPlayer.CharacterAdded:Wait()
	if not character then return false end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return false end

	local currentDistance = (rootPart.Position - targetCFrame.Position).Magnitude
	if currentDistance <= Constants.DistLimit then return true end

	local walkSpeed = speed or 50
	local height = Constants.YOffset or 3
	local targetPos = targetCFrame.Position
	local spawnY = (State.MySpawnPoint and State.MySpawnPoint.Position.Y or 0)
	local groundPoint = Vector3.new(targetPos.X, spawnY, targetPos.Z)
	local distanceFromGround = (targetPos - groundPoint).Magnitude
	local finalY = (distanceFromGround > Constants.DistLimit) and (targetPos.Y + height) or (spawnY + height)
	finalY = math.max(finalY, spawnY + height)
	local finalCFrame = CFrame.new(Vector3.new(targetPos.X, finalY, targetPos.Z))

	rootPart.Anchored = false
	Utils.SetNoClip(true)
	local tweenTime = (rootPart.Position - finalCFrame.Position).Magnitude / walkSpeed
	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
	local tween = Services.TweenService:Create(rootPart, tweenInfo, { CFrame = finalCFrame })
	tween:Play()

	local timeout = false
	task.delay(math.min(tweenTime + 2, 5), function()
		if tween.PlaybackState == Enum.PlaybackState.Playing then
			tween:Cancel()
			timeout = true
		end
	end)

	tween.Completed:Wait()
	rootPart.Anchored = true
	Utils.SetNoClip(false)
	if timeout then
		Utils.SafeTeleport(finalCFrame)
		task.wait(0.2)
	end
	return true
end

function Utils.SafeTeleport(targetCFrame)
	local character = Services.LocalPlayer.Character
	if not character then return end
	local humanoid = character:FindFirstChild("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if humanoid then
		if humanoid.Sit then humanoid.Sit = false end
		humanoid.Jump = true
		task.wait(0.05)
		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end
	if rootPart then
		rootPart.AssemblyLinearVelocity = Vector3.zero
		rootPart.AssemblyAngularVelocity = Vector3.zero
		rootPart.Anchored = false
	end
	character:PivotTo(targetCFrame)
	task.wait(0.1)
end

function Utils.ParseFruitUuid(rawUuid)
	local baseUuid = string.split(rawUuid, ":")[1]
	local numberSuffixStr = string.match(rawUuid, ":(%d+)$")
	return baseUuid, tonumber(numberSuffixStr)
end

function Utils.GetSelectedItems(DropdownValue)
	local Items = {}
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then table.insert(Items, Value) end
		end
	end
	return Items
end

return Utils
