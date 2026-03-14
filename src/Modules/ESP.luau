--!nocheck
local ESP = {}
local _Registry = nil
local State = nil
local Constants = nil

local CoreGui = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")

local Options = nil

function ESP.Initialize(reg)
	local _Registry = reg
	State = reg.State
	local _Constants = reg.Constants
	Utils = reg.Utils
	local _Network = reg.Network
end

function ESP.SetOptions(opts)
	Options = opts
end

function CreateBGui(parent, name, uuid, color, secondaryText, priority)
	pcall(function()
		if State.bGuiSession[uuid] then
			State.bGuiSession[uuid]:Destroy()
		end

		local billboard = Instance.new("BillboardGui")
		billboard.Name = "ESP_" .. uuid
		billboard.Adornee = parent
		billboard.Size = UDim2.new(0, 200, 0, 80)
		billboard.StudsOffset = Vector3.new(0, 3.5, 0)
		billboard.AlwaysOnTop = true
		billboard.LightInfluence = 0

		local textLabel = Instance.new("TextLabel")
		textLabel.Parent = billboard
		textLabel.Size = UDim2.new(1, 0, 0, 0)
		textLabel.AutomaticSize = Enum.AutomaticSize.XY
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.FredokaOne
		textLabel.TextSize = 16
		textLabel.TextStrokeTransparency = 0
		textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)

		if priority == 3 then
			textLabel.TextColor3 = Color3.fromRGB(200, 200, 10)
		elseif priority == 2 then
			textLabel.TextColor3 = Color3.fromRGB(200, 50, 10)
		elseif priority == 1 then
			textLabel.TextColor3 = Color3.fromRGB(10, 200, 10)
		else
			textLabel.TextColor3 = color or Color3.fromRGB(200, 200, 200)
		end

		billboard.Parent = game:GetService("CoreGui")
		State.bGuiSession[uuid] = billboard
		
		return billboard, textLabel
	end)
end

function ESP.TogglePlants(state)
	if not state then
		for uuid, gui in pairs(State.bGuiSession) do
			if tostring(uuid):find("^Plants_") or tostring(uuid):find("^ESP_") then
				gui:Destroy()
				State.bGuiSession[uuid] = nil
			end
		end
	end
end

function ESP.ToggleFruit(state)
	if not state then
		for uuid, gui in pairs(State.bGuiSession) do
			if tostring(uuid):find("^Fruit_") or tostring(uuid):find("^ESP_") then
				gui:Destroy()
				State.bGuiSession[uuid] = nil
			end
		end
	end
end

function ESP.Update()
	local lp = game.Players.LocalPlayer
	local char = lp.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end
	local rootPos = char.HumanoidRootPart.Position

	-- 1. Scan Plants
	if Options.tgPlantsESP.Value then
		local selected = Utils.GetSelectedItems(Options.ddPlantsESP.Value)
		if not table.find(selected, "NONE") then
			for _, anchor in ipairs(CollectionService:GetTagged("PlantAnchor")) do
				local plant = anchor.Parent
				if plant then
					local name = plant:GetAttribute("PlantType") or plant.Name
					if table.find(selected, "ALL") or table.find(selected, name) then
						local uuid = plant:GetAttribute("Uuid") or plant.Name
						if not State.bGuiSession[uuid] then
							local scale = plant:GetAttribute("HiddenNumber") or 0
							local weight = plant:GetAttribute("PlantWeight") or 0
							local priority = 0
							if scale >= 2 then priority = 3
							elseif scale >= 1.5 then priority = 2
							elseif scale >= 1 then priority = 1 end
							
							local secondary = weight > 0 and string.format("Weight : %.2f kg", weight) or string.format("Scale : %.2f", scale)
							CreateBGui(plant, "🌱 " .. name, uuid, Color3.fromRGB(0, 255, 0), secondary, priority)
						end
					end
				end
			end
		end
	end

	-- 2. Scan Fruit
	if Options.tgFruitESP.Value then
		local selected = Utils.GetSelectedItems(Options.ddFruitESP.Value)
		if not table.find(selected, "NONE") then
			for _, prompt in ipairs(CollectionService:GetTagged("HarvestPrompt")) do
				if prompt.Enabled then
					local fruit = prompt.Parent.Parent
					if fruit then
						local name = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType")) or "Fruit"
						if table.find(selected, "ALL") or table.find(selected, name) then
							local uuid = fruit:GetAttribute("Uuid") or name
							if not State.bGuiSession[uuid] then
								local weight = fruit:GetAttribute("FruitWeight") or fruit:GetAttribute("PlantWeight") or 0
								local scale = fruit:GetAttribute("HiddenNumber") or 0
								CreateBGui(fruit, "🍎 " .. name, uuid, Color3.fromRGB(255, 255, 0), string.format("Weight : %.2f kg", weight), 0)
							end
						end
					end
				end
			end
		end
	end

	-- 3. Update Distances and Cleanup
	for uuid, gui in pairs(State.bGuiSession) do
		if gui.Adornee and gui.Adornee.Parent then
			local dist = math.floor((gui.Adornee:GetPivot().Position - rootPos).Magnitude)
			local label = gui:FindFirstChildOfClass("TextLabel")
			if label then
				local baseText = label.Text:split("\n")[1]
				label.Text = string.format("%s\nDist: %d", baseText, dist)
			end
		else
			gui:Destroy()
			State.bGuiSession[uuid] = nil
		end
	end
end

return ESP
