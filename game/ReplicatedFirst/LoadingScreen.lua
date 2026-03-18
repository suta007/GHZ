local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedFirst")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("UserInputService")
local v7 = game:GetService("Lighting")
local v_u_8 = v1.LocalPlayer:WaitForChild("PlayerGui")
local v_u_9 = workspace.CurrentCamera
local v10 = v6.TouchEnabled
local v_u_11 = script:WaitForChild("LoadingScreenGui")
v_u_11.IgnoreGuiInset = true
v_u_11.DisplayOrder = 999
v_u_11.Enabled = true
v_u_11.Parent = v_u_8
v2:RemoveDefaultLoadingScreen()
local v_u_12 = {}
local v_u_13 = nil
local function v15()
	-- upvalues: (ref) v_u_13, (ref) v_u_12
	if v_u_13 then
		v_u_13:Disconnect()
		v_u_13 = nil
	end
	for v14, _ in pairs(v_u_12) do
		if v14.Parent then
			v14.Enabled = true
		end
	end
	v_u_12 = {}
end
(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (ref) v_u_12
	for _, v16 in ipairs(v_u_8:GetChildren()) do
		if v16:IsA("ScreenGui") and (v16 ~= v_u_11 and v16.Enabled) then
			v_u_12[v16] = true
			v16.Enabled = false
		end
	end
end)()
v_u_13 = v_u_8.ChildAdded:Connect(function(p17)
	-- upvalues: (copy) v_u_11, (ref) v_u_12
	if p17:IsA("ScreenGui") and (p17 ~= v_u_11 and p17.Enabled) then
		v_u_12[p17] = true
		p17.Enabled = false
	end
end)
local v18 = v_u_11:WaitForChild("Frame")
local v19 = v18:WaitForChild("Quote")
local v_u_20 = v18:WaitForChild("LoadingAssets")
local v21 = v18:WaitForChild("SkipLoading")
local v_u_22 = v18:WaitForChild("LoadAmount")
local v_u_23 = script:FindFirstChild("LoadingCamera")
local v_u_24 = 0
local v_u_25 = 0
if v_u_23 then
	v_u_9.CameraType = Enum.CameraType.Scriptable
	v_u_9.CFrame = v_u_23.CFrame
end
local v26 = task.spawn(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_23
	while task.wait(2) do
		if v_u_9.CameraType ~= Enum.CameraType.Scriptable and v_u_23 then
			v_u_9.CameraType = Enum.CameraType.Scriptable
			v_u_9.CFrame = v_u_23.CFrame
		end
	end
end)
local v_u_27 = Vector3.new(0, 0, 0)
local v_u_28 = nil
local v_u_29 = nil
task.spawn(function()
	-- upvalues: (copy) v_u_3, (ref) v_u_29, (copy) v_u_9, (ref) v_u_27, (ref) v_u_28, (copy) v_u_5
	local v30 = v_u_3:WaitForChild("RemoteEvents", 10)
	if v30 then
		v_u_29 = v30:WaitForChild("SetStreamingFocus", 10)
		if v_u_29 then
			local v31 = v_u_9.CFrame.Position
			v_u_27 = v31
			v_u_29:FireServer("start", v31)
			v_u_28 = v_u_5.Heartbeat:Connect(function()
				-- upvalues: (ref) v_u_9, (ref) v_u_27, (ref) v_u_29
				local v32 = v_u_9.CFrame.Position
				if (v32 - v_u_27).Magnitude ^ 2 >= 256 then
					v_u_27 = v32
					v_u_29:FireServer("update", v32)
				end
			end)
		end
	else
		return
	end
end)
local v33 = Instance.new("BlurEffect")
v33.Size = v10 and 8 or 24
v33.Parent = v7
local v34 = {
	"pomaganit",
	"Your plants grow offline!",
	"Use sprinklers to buff your plant growth!",
	"The fountain holds a tremendous force...",
	"Wait for your crops to ripen for a price buff!",
	"The island holds many mysteries..",
	"Your garden is your own personal utopia!",
	"A thriving garden starts with a single seed.",
	"A well-watered plant is a happy plant!"
}
v19.Text = v34[math.random(1, #v34)]
local v_u_35 = false
v21.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_11, (ref) v_u_35
	v_u_11:SetAttribute("Skipped", true)
	v_u_35 = true
end)
local v41 = v_u_5.RenderStepped:Connect(function()
	-- upvalues: (ref) v_u_25, (ref) v_u_24, (copy) v_u_11, (copy) v_u_22, (copy) v_u_20
	local v36 = v_u_25 - v_u_24
	if math.abs(v36) < 0.5 then
		v_u_24 = v_u_25
	else
		v_u_24 = v_u_24 + v36 * 0.2
	end
	local v37 = v_u_11:GetAttribute("TotalAssets") or 0
	local v38 = v_u_24
	local v39 = math.floor(v38)
	local v40 = (v37 > 0 and (v_u_24 / v37 or 0) or 0) * 100
	v_u_22.Text = math.floor(v40) .. "%"
	v_u_20.Text = "Loading Assets: " .. v39 .. " / " .. v37
end)
local v42 = v_u_11.AttributeChanged:Connect(function()
	-- upvalues: (copy) v_u_11, (ref) v_u_25
	v_u_25 = v_u_11:GetAttribute("LoadedCount") or 0
end)
local v43 = v_u_11:GetAttribute("LoadedCount") or 0
local v44 = v_u_29
local v45 = v_u_28
local v46 = v43
local v47 = 0
while true do
	v47 = v47 + task.wait(0.2)
	local v48 = v_u_11:GetAttribute("LoadingComplete") == true
	local v49 = v_u_11:GetAttribute("Skipped") == true
	if v47 >= 30 and not v49 then
		v_u_11:SetAttribute("Skipped", true)
		v_u_35 = true
		v49 = true
	end
	if v48 or v49 and game:IsLoaded() then
		local _ = v46
		if v42 then
			v42:Disconnect()
		end
		if v41 then
			v41:Disconnect()
		end
		local v50 = v_u_11:GetAttribute("TotalAssets") or 0
		v_u_22.Text = "100%"
		v_u_20.Text = "Loading Assets: " .. v50 .. " / " .. v50
		task.wait(0.2)
		v21.Visible = false
		v_u_20.Text = v10 and "Tap to Begin" or "Press Any Key to Begin"
		v_u_20.TextColor3 = Color3.fromRGB(245, 255, 60)
		local v_u_51 = nil
		v_u_51 = v6.InputBegan:Connect(function(p52, p53)
			-- upvalues: (ref) v_u_35, (ref) v_u_51
			if not p53 or p52.UserInputType == Enum.UserInputType.Gamepad1 then
				local v54 = {
					Enum.UserInputType.Keyboard,
					Enum.UserInputType.MouseButton1,
					Enum.UserInputType.Touch,
					Enum.UserInputType.Gamepad1
				}
				if table.find(v54, p52.UserInputType) then
					v_u_35 = true
					v_u_51:Disconnect()
				end
			end
		end)
		repeat
			task.wait(0.1)
		until v_u_35
		if v26 then
			task.cancel(v26)
		end
		if v45 then
			v45:Disconnect()
			v_u_28 = nil
		end
		if v44 then
			v44:FireServer("stop")
		end
		local v_u_55 = TweenInfo.new(1, Enum.EasingStyle.Linear)
		local function v_u_59(p56)
			-- upvalues: (copy) v_u_4, (copy) v_u_55, (copy) v_u_59
			if p56:IsA("GuiObject") then
				local v57 = {
					["BackgroundTransparency"] = 1
				}
				if p56:IsA("TextLabel") or p56:IsA("TextButton") then
					v57.TextTransparency = 1
					v57.TextStrokeTransparency = 1
				elseif p56:IsA("ImageLabel") or p56:IsA("ImageButton") then
					v57.ImageTransparency = 1
				end
				v_u_4:Create(p56, v_u_55, v57):Play()
			elseif p56:IsA("UIStroke") then
				v_u_4:Create(p56, v_u_55, {
					["Transparency"] = 1
				}):Play()
			end
			for _, v58 in ipairs(p56:GetChildren()) do
				v_u_59(v58)
			end
		end
		v_u_59(v18)
		v_u_4:Create(v33, v_u_55, {
			["Size"] = 0
		}):Play()
		task.wait(1.1)
		v15()
		v_u_8:SetAttribute("UIReady", true)
		v33:Destroy()
		v_u_11:Destroy()
		return
	end
end