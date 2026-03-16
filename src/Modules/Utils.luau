local Utils = {}
local reg = nil
local MyPlantableParts = {}
local RNG = Random.new()
local fVar

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
--local Humanoid = Character:WaitForChild("Humanoid")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local noclipConnection = nil

local function InitializePlotData()
	local PlotsFolder = workspace:FindFirstChild("Plots")
	if not PlotsFolder then return false end
	for _, plot in ipairs(PlotsFolder:GetChildren()) do
		local ownerVal = plot:FindFirstChild("Owner")
		if ownerVal and ownerVal.Value == LocalPlayer.Name then
			local plantableArea = plot:FindFirstChild("PlantableArea")
			reg.MyPlot = plot
			reg.MySpawn = reg.MyPlot.Spawn
			reg.MySpawnPoint = reg.MySpawn:GetPivot()
			if plantableArea then
				table.clear(MyPlantableParts)
				for _, part in ipairs(plantableArea:GetChildren()) do
					if part:IsA("BasePart") then table.insert(MyPlantableParts, part) end
				end
				return true
			end
		end
	end
	return false
end

function Utils.Initialize(Registry)
	reg = Registry
	fVar = Registry.fVar

	InitializePlotData()
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

function Utils.GetRandomPlantPosition()
	if #MyPlantableParts == 0 then
		if not InitializePlotData() then return nil end
	end
	local targetPart = MyPlantableParts[math.random(1, #MyPlantableParts)]
	local size = targetPart.Size
	local cframe = targetPart.CFrame

	local randomY = RNG:NextNumber(-size.Y / 2, size.Y / 2)
	local randomZ = RNG:NextNumber(-size.Z / 2, size.Z / 2)

	local floatDistance = 5

	local localOffset = CFrame.new(floatDistance, randomY, randomZ)
	local worldCFrame = cframe * localOffset

	local finalX = worldCFrame.Position.X
	local finalY = cframe.Position.Y
	local finalZ = worldCFrame.Position.Z

	return CFrame.new(finalX, finalY, finalZ)
end

function Utils.GetCenterPlots()
	if #MyPlantableParts < 2 then
		if not InitializePlotData() then return nil, nil end
	end

	local part1 = MyPlantableParts[1]
	local part2 = MyPlantableParts[2]

	local center1 = CFrame.new(part1.Position.X, part1.Position.Y, part1.Position.Z)

	local center2 = CFrame.new(part2.Position.X, part2.Position.Y, part2.Position.Z)

	return { center1, center2 }
end

function Utils.SafeTeleport(targetCFrame)
	local humanoid = Character:FindFirstChild("Humanoid")
	local rootPart = Character:FindFirstChild("HumanoidRootPart")

	if humanoid then
		if humanoid.Sit then humanoid.Sit = false end
		humanoid.Jump = true
		task.wait(0.05)
		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	if rootPart then
		rootPart.AssemblyLinearVelocity = Vector3.zero
		rootPart.AssemblyAngularVelocity = Vector3.zero
	end
	rootPart.Anchored = false
	Character:PivotTo(targetCFrame)

	task.wait(0.1)
end

function Utils.SetNoClip(state)
	if state then
		if not noclipConnection then
			noclipConnection = RunService.Stepped:Connect(function()
				if Character then
					for _, part in ipairs(Character:GetDescendants()) do
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
	local rootPart = Character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return false end

	local currentDistance = (rootPart.Position - targetCFrame.Position).Magnitude
	if currentDistance <= fVar.SutaDistLimit then return true end

	local walkSpeed = speed or 50
	local height = fVar.SutaYoffset or 3
	local targetPos = targetCFrame.Position
	local spawnY = (reg.MySpawnPoint and reg.MySpawnPoint.Position.Y or 0)

	local groundPoint = Vector3.new(targetPos.X, spawnY, targetPos.Z)
	local distanceFromGround = (targetPos - groundPoint).Magnitude

	local finalY
	if distanceFromGround > fVar.SutaDistLimit then
		finalY = targetPos.Y + height
	else
		finalY = spawnY + height
	end

	finalY = math.max(finalY, spawnY + height)

	local finalCFrame = CFrame.new(Vector3.new(targetPos.X, finalY, targetPos.Z))

	rootPart.Anchored = false
	Utils.SetNoClip(true)

	local tweenTime = (rootPart.Position - finalCFrame.Position).Magnitude / walkSpeed
	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = finalCFrame })

	tween:Play()

	-- Timeout Protection (Max 5 Sec)
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

function Utils.ParseFruitUuid(rawUuid)
	local baseUuid = string.split(rawUuid, ":")[1]
	local numberSuffixStr = string.match(rawUuid, ":(%d+)$")
	local finalNumber = nil
	if numberSuffixStr then finalNumber = tonumber(numberSuffixStr) end
	return baseUuid, finalNumber
end

function Utils.EquipItem(item)
	local humanoid = Character:FindFirstChild("Humanoid")
	if humanoid and item then pcall(function()
		humanoid:EquipTool(item)
	end) end
end

function Utils.UnequipTools()
	local humanoid = Character:FindFirstChild("Humanoid")
	if humanoid then pcall(function()
		humanoid:UnequipTools()
	end) end
end

return Utils
