local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
Pos = Character:GetPivot()
print(string.format("➡️ CFrame.new(%.2f, %.2f, %.2f)", Pos.Position.X, Pos.Position.Y, Pos.Position.Z))





", Pos.Position.X,Pos.Position.Y,Pos.Position.Z))




print(string.format("➡️ CFrame.new(%s,%s,%s)", Pos.Position.X,Pos.Position.Y,Pos.Position.Z))
--[[]]
Character:PivotTo(CFrame.new(211.63800048828125,205.46646118164062, 608.1752319335938))
Pos = Character:GetPivot()
print("➡️",Pos.Position.X,Pos.Position.Y,Pos.Position.Z)
➡️ 211.63800048828125 205.46646118164062 608.1752319335938

print("➡️",Pos.Position.X,Pos.Position.Y,Pos.Position.Z)