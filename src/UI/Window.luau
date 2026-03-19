--!nocheck
local Window = {}
local reg = nil

local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
--local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
--local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/GHZ/refs/heads/master/src/Addons/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

function Window.Initialize(Registry)
	reg = Registry
	Registry.IsLoading = true
	--local Constants = reg.Constants

	Registry.Interface = Fluent:CreateWindow({
		Title = "Garden Horizons",
		SubTitle = "2569.03.19-08.00",
		TabWidth = 100,
		Size = UDim2.fromOffset(600, 340),
		Resize = false,
		MinSize = Vector2.new(580, 400),
		Acrylic = true,
		Theme = "Darker",
		MinimizeKey = Enum.KeyCode.RightControl,
	})

	SaveManager:SetLibrary(Fluent)
	InterfaceManager:SetLibrary(Fluent)
	InterfaceManager:SetFolder("EfHub")
	SaveManager:SetFolder("EfHub/GHZs")

	Registry.Tabs = {}
	Registry.Fluent = Fluent
	Registry.SaveManager = SaveManager
	Registry.InterfaceManager = InterfaceManager
	Registry.Options = Fluent.Options

	------------------------------------------------------
	-- ระบบปุ่มลอย (Floating Button) - ฉบับแก้ไข
	------------------------------------------------------
	local ToggleGui = Instance.new("ScreenGui")
	local ToggleButton = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")

	ToggleGui.Name = "Ef_Toggle"
	ToggleGui.Parent = game:GetService("CoreGui")
	ToggleGui.ResetOnSpawn = false

	ToggleButton.Name = "ToggleButton"
	ToggleButton.Parent = ToggleGui
	ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 100)
	ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
	ToggleButton.Size = UDim2.new(0, 50, 0, 50)
	ToggleButton.Text = "EF"
	ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleButton.Draggable = true -- สำหรับ Delta Executor ตัวนี้ยังใช้ได้ดีค่ะ
	ToggleButton.Active = true

	UICorner.CornerRadius = UDim.new(0, 25)
	UICorner.Parent = ToggleButton

	-- ฟังก์ชันคลิกที่แยกออกมาให้ชัดเจน
	ToggleButton.MouseButton1Click:Connect(function()
		local UI = Registry.Interface
		if UI then
			-- เช็ค Instance (หน้าต่างหลัก)
			if UI.Instance then
				UI.Instance.Enabled = not UI.Instance.Enabled
			-- เช็ค Root (เผื่อบางเวอร์ชันของ Fluent ใช้ตัวแปรนี้)
			elseif UI.Root then
				UI.Root.Visible = not UI.Root.Visible
			end
		end
	end)
end

function Window.Finalize()
	reg.Tabs.Settings = reg.Interface:AddTab({ Title = "Settings", Icon = "settings" })
	reg.InterfaceManager:BuildInterfaceSection(reg.Tabs.Settings)
	reg.SaveManager:BuildConfigSection(reg.Tabs.Settings)

	reg.Interface:SelectTab(1)

	task.spawn(function()
		while not reg.SaveManager.Options.SaveManager_ConfigList do
			task.wait()
		end
		reg.SaveManager.Options.SaveManager_ConfigList:SetValue("Horizons")
		reg.SaveManager:Load("Horizons")
		reg.IsLoading = false
		reg.Fluent:Notify({
			Title = "EfHub",
			Content = "Settings loaded automatically",
			Duration = 3,
		})
	end)
end

function Window.QuickSave()
	if not reg.IsLoading then reg.SaveManager:Save("Horizons") end
end

return Window
