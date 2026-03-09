-- ==========================================
-- 🛠️ ตั้งค่าระบบพื้นฐาน
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LogService = game:GetService("LogService")

local guiName = "EfCustomSpyUI"
if CoreGui:FindFirstChild(guiName) then CoreGui[guiName]:Destroy() end

local IsPaused = false
local MaxLines = 150
local LogHistory = {}
local DisplayLogLabels = {} -- เปลี่ยนมาเก็บเป็น Object ของแต่ละบรรทัดแทน

-- ==========================================
-- 🎨 สร้าง UI Components
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
local success = pcall(function()
	ScreenGui.Parent = gethui and gethui() or CoreGui
end)
if not success then ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🔍 EfHub Custom Spy"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 14
TitleText.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 0)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = TitleBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -30)
ContentFrame.Position = UDim2.new(0, 0, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ✨ โครงสร้าง ScrollFrame แบบใหม่
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollFrame.Position = UDim2.new(0, 10, 0, 10)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y -- ให้มันจัดการความสูงเองเลย
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = ContentFrame

-- ✨ ใช้ UIListLayout เพื่อจัดเรียงบรรทัดอัตโนมัติ (ไม่พัง 100%)
local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 2)
ListLayout.Parent = ScrollFrame

-- ✨ Auto-Scroll ทำงานทุกครั้งที่ความสูงรวมของบรรทัดเปลี่ยนไป
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	if not IsPaused then ScrollFrame.CanvasPosition = Vector2.new(0, ListLayout.AbsoluteContentSize.Y) end
end)

local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -20, 0, 30)
ButtonContainer.Position = UDim2.new(0, 10, 1, -40)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = ContentFrame

local function CreateButton(text, posX, parent)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.32, 0, 1, 0)
	btn.Position = UDim2.new(posX, 0, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.Parent = parent
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = btn
	return btn
end

local PauseBtn = CreateButton("⏸️ Pause", 0, ButtonContainer)
local ClearBtn = CreateButton("🗑️ Clear", 0.34, ButtonContainer)
local CopyBtn = CreateButton("📋 Copy All", 0.68, ButtonContainer)

local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Size = UDim2.new(0, 15, 0, 15)
ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
ResizeHandle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ResizeHandle.BackgroundTransparency = 0.5
ResizeHandle.Text = "↘"
ResizeHandle.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeHandle.TextSize = 10
ResizeHandle.BorderSizePixel = 0
ResizeHandle.ZIndex = 10
ResizeHandle.Parent = ContentFrame

-- ==========================================
-- 🕹️ ระบบการทำงานของ UI (Drag, Resize, Buttons)
-- ==========================================
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

local resizing, resizeStart, startSize
local minSize = Vector2.new(350, 200)
ResizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		startSize = MainFrame.AbsoluteSize
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then resizing = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragging then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		elseif resizing then
			local delta = input.Position - resizeStart
			local newWidth = math.max(minSize.X, startSize.X + delta.X)
			local newHeight = math.max(minSize.Y, startSize.Y + delta.Y)
			MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
		end
	end
end)

local isMinimized = false
local previousSize = MainFrame.Size
MinimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	ContentFrame.Visible = not isMinimized
	if isMinimized then
		previousSize = MainFrame.Size
		MainFrame.Size = UDim2.new(0, previousSize.X.Offset, 0, 30)
		MinimizeBtn.Text = "+"
	else
		MainFrame.Size = previousSize
		MinimizeBtn.Text = "-"
	end
end)

PauseBtn.MouseButton1Click:Connect(function()
	IsPaused = not IsPaused
	if IsPaused then
		PauseBtn.Text = "▶️ Resume"
		PauseBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
	else
		PauseBtn.Text = "⏸️ Pause"
		PauseBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		ScrollFrame.CanvasPosition = Vector2.new(0, ListLayout.AbsoluteContentSize.Y)
	end
end)

ClearBtn.MouseButton1Click:Connect(function()
	-- ทำลายกล่องข้อความทิ้งให้หมดเพื่อเคลียร์หน้าจอ
	for _, lbl in ipairs(DisplayLogLabels) do
		if lbl then lbl:Destroy() end
	end
	table.clear(DisplayLogLabels)
	table.clear(LogHistory)
end)

CopyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(table.concat(LogHistory, "\n"))
		CopyBtn.Text = "✅ Copied!"
		task.delay(1.5, function()
			CopyBtn.Text = "📋 Copy All"
		end)
	end
end)

-- ==========================================
-- 📡 ระบบดักฟังและสร้างบรรทัด (แบบใหม่)
-- ==========================================
local function AddLogToUI(message)
	if IsPaused then return end
	table.insert(LogHistory, message)

	-- ✨ สร้างบรรทัดใหม่แทนการจับมัดรวมกัน
	local newLine = Instance.new("TextLabel")
	newLine.Size = UDim2.new(1, -10, 0, 0)
	newLine.AutomaticSize = Enum.AutomaticSize.Y
	newLine.BackgroundTransparency = 1
	newLine.Text = message

	-- เปลี่ยนสีให้ดูง่ายขึ้น 🚀 ขาออกสีเหลือง 📥 ขาเข้าสีเขียว
	if string.find(message, "🚀") then
		newLine.TextColor3 = Color3.fromRGB(255, 200, 100)
	elseif string.find(message, "📥") then
		newLine.TextColor3 = Color3.fromRGB(100, 255, 100)
	else
		newLine.TextColor3 = Color3.fromRGB(200, 200, 200)
	end

	newLine.TextXAlignment = Enum.TextXAlignment.Left
	newLine.TextYAlignment = Enum.TextYAlignment.Top
	newLine.Font = Enum.Font.Code
	newLine.TextSize = 12
	newLine.TextWrapped = true
	newLine.Parent = ScrollFrame

	-- เก็บเข้าตารางเพื่อนับจำนวน
	table.insert(DisplayLogLabels, newLine)

	-- ถ้าเกิน MaxLines ให้ลบบรรทัดบนสุดทิ้ง
	if #DisplayLogLabels > MaxLines then
		local oldestLine = table.remove(DisplayLogLabels, 1)
		if oldestLine then oldestLine:Destroy() end
	end
end

LogService.MessageOut:Connect(function(message)
	if string.find(message, "🚀") or string.find(message, "➡️") or string.find(message, "📥") then AddLogToUI(message) end
	--AddLogToUI(message)
end)

print("✅ Custom UI เริ่มทำงานแล้ว!")

-- ==========================================
-- 🕵️ ระบบ Spy (ต่อด้านล่างได้เลยค่ะ)
-- ==========================================

local function ShowData(data, indentLevel)
	local indent = string.rep("  ", indentLevel)
	if type(data) == "table" then
		--print(string.format("   %s-> [Table]:", indent))
		for k, v in pairs(data) do
			if type(v) == "table" then
				print(string.format("%s➡️[%s]:", indent, tostring(k)))
				ShowData(v, indentLevel + 1)
			else
				print(string.format("%s➡️[%s] : %s (%s)", indent, tostring(k), tostring(v), typeof(v)))
			end
		end
	else
		print(string.format("%➡️%s (%s)", indent, tostring(data), typeof(data)))
	end
end

-- ขาออก
local oldNamecall
oldNamecall = hookmetamethod(
	game,
	"__namecall",
	newcclosure(function(self, ...)
		local method = getnamecallmethod()
		local args = { ... }

		if not checkcaller() then
			if method == "FireServer" or method == "InvokeServer" then
				task.spawn(function()
					pcall(function()
						local remoteName = tostring(self.Name)
						print(string.format("🚀 [ส่งออก] Remote: %s.%s", remoteName, method))
						for i, v in ipairs(args) do
							if type(v) == "table" then
								print(string.format("➡️[%d] : ", i))
								ShowData(v, 1)
							else
								print(string.format("➡️[%d] : %s", i, v))
							end
						end
					end)
				end)
			end
		end

		return oldNamecall(self, ...)
	end)
)

-- ขาเข้า
local BacklistRemote = { "WeatherEvent", "GrowthUpdate", "CellDataUpdate", "MutationNotification", "WeatherController", "UpdateInventoryPosition" }

local function hookIncoming(remote)
	if remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(...)
			if table.find(BacklistRemote, remote.Name) then return end

			local args = { ... }
			if type(args[2]) == "table" and args[2][1] == "FloraBook" then return end

			print(string.format("📥 [รับจาก Server] Remote: %s", tostring(remote.Name)))
			for i, v in ipairs(args) do
				if type(v) == "table" then
					print(string.format("➡️[%d] : ", i))
					ShowData(v, 1)
				else
					print(string.format("➡️[%d] : %s", i, v))
				end
			end
		end)
	end
end

for _, obj in ipairs(game:GetDescendants()) do
	hookIncoming(obj)
end

game.DescendantAdded:Connect(function(obj)
	hookIncoming(obj)
end)
