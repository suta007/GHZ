--!nocheck
local ESP = {}
local Registry = nil
local State = nil
local Constants = nil

local CoreGui = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")

local Options = {}
local ESPFruitConnection = nil
local ESPPlantsConnection = nil

function ESP.Initialize(reg)
	Registry = reg
	State = reg.State
	Constants = reg.Constants
end

function ESP.SetOptions(opts)
	Options = opts
end

local function CreateHighlight(parent, name, color)
	local highlight = Instance.new("Highlight")
	highlight.Name = name
	highlight.FillColor = color or Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = 0.5
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.OutlineTransparency = 0
	highlight.Parent = parent
	return highlight
end

function ESP.TogglePlants(state)
	if state then
		ESPPlantsConnection = CollectionService:GetInstanceAddedSignal("PlantAnchor"):Connect(function(anchor)
			local plant = anchor.Parent
			if plant and not plant:FindFirstChild(Constants.PlantsESPFolderName) then
				CreateHighlight(plant, Constants.PlantsESPFolderName, Color3.fromRGB(0, 255, 0))
			end
		end)
		for _, anchor in ipairs(CollectionService:GetTagged("PlantAnchor")) do
			local plant = anchor.Parent
			if plant and not plant:FindFirstChild(Constants.PlantsESPFolderName) then
				CreateHighlight(plant, Constants.PlantsESPFolderName, Color3.fromRGB(0, 255, 0))
			end
		end
	else
		if ESPPlantsConnection then
			ESPPlantsConnection:Disconnect()
			ESPPlantsConnection = nil
		end
		for _, anchor in ipairs(CollectionService:GetTagged("PlantAnchor")) do
			local plant = anchor.Parent
			local esp = plant and plant:FindFirstChild(Constants.PlantsESPFolderName)
			if esp then esp:Destroy() end
		end
	end
end

function ESP.ToggleFruit(state)
	-- Similar logic for Fruit ESP
end

return ESP
