--!nocheck
local Utils = {}
local State = nil
local Constants = nil

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local noclipConnection = nil
local RNG = Random.new()

function Utils.Initialize(reg)
	State = reg.State
	Constants = reg.Constants
end

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
		if ownerVal and ownerVal.Value == LocalPlayer.Name then
			local plantableArea = plot:FindFirstChild("PlantableArea")
			State.MyPlot = plot
			State.MySpawn = plot.Spawn
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

function Utils.SetNoClip(state)
	if state then
		if not noclipConnection then
			noclipConnection = RunService.Stepped:Connect(function()
				local char = LocalPlayer.Character
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

function Utils.SafeTeleport(targetCFrame)
	local character = LocalPlayer.Character
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
		character:PivotTo(targetCFrame)
	end

	task.wait(0.1)
end

function Utils.TweenToTarget(targetCFrame, speed)
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	if not character then return false end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return false end

	local currentDistance = (rootPart.Position - targetCFrame.Position).Magnitude
	if currentDistance <= Constants.SutaDistLimit then return true end

	local walkSpeed = speed or 50
	local height = Constants.SutaYoffset or 3
	local targetPos = targetCFrame.Position
	local spawnY = (State.MySpawnPoint and State.MySpawnPoint.Position.Y or 0)

	local groundPoint = Vector3.new(targetPos.X, spawnY, targetPos.Z)
	local distanceFromGround = (targetPos - groundPoint).Magnitude

	local finalY = (distanceFromGround > Constants.SutaDistLimit) and (targetPos.Y + height) or (spawnY + height)
	finalY = math.max(finalY, spawnY + height)

	local finalCFrame = CFrame.new(Vector3.new(targetPos.X, finalY, targetPos.Z))

	rootPart.Anchored = false
	Utils.SetNoClip(true)

	local tweenTime = (rootPart.Position - finalCFrame.Position).Magnitude / walkSpeed
	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = finalCFrame })

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

function Utils.ParseFruitUuid(rawUuid)
	local parts = string.split(rawUuid, ":")
	local baseUuid = parts[1]
	local numberSuffixStr = parts[2]
	local finalNumber = numberSuffixStr and tonumber(numberSuffixStr)
	return baseUuid, finalNumber
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

return Utils
