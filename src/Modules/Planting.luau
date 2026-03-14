--!nocheck
local Planting = {}
local Registry = nil
local State = nil
local Utils = nil
local Network = nil

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Options = {}

function Planting.Initialize(reg)
	Registry = reg
	State = reg.State
	Utils = reg.Utils
	Network = reg.Network
end

function Planting.SetOptions(opts)
	Options = opts
end

function Planting.Run(seedUuid)
	if not State.MyPlot then Utils.InitializePlotData() end
	if not State.MyPlot then return end

	State.isPlanting = true
	local pos = Utils.GetRandomPlantPosition()
	if pos then
		Utils.SafeTeleport(pos)
		task.wait(0.2)
		Network.Events.PlantSeed:FireServer(seedUuid, pos)
		task.wait(0.5)
	end
	State.isPlanting = false
end

return Planting
