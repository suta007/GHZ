local v1 = script.Parent:WaitForChild("HumanoidRootPart")
local v2 = game:GetService("ReplicatedStorage"):WaitForChild("Dialogue"):WaitForChild("DialogueTemplates"):WaitForChild("Billboard"):Clone()
v2.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
v2.Adornee = v1