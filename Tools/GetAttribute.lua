local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Fluent:CreateWindow({
	Title = "Console Log",
	SubTitle = "by EfHub",
	TabWidth = 100,
	Size = UDim2.fromOffset(1200, 768),
	Resize = true,
	-- MinSize = Vector2.new(470, 380),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local Tabs = {
	Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
	Event = Window:AddTab({ Title = "Event", Icon = "calendar" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local MaxFullHistory = 10000 -- จำนวนบรรทัดสูงสุดของประวัติทั้งหมด
local DisplayTable = {} -- ตารางเก็บข้อความโชว์
local FullHistoryTable = {} -- ตารางเก็บประวัติทั้งหมด
local IsPaused = false

-- [สำคัญ] ประกาศตัวแปร LogDisplay ไว้ก่อน เพื่อให้ปุ่มรู้จักตัวแปรนี้
local LogDisplay = nil

------------------------------------------------------
-- 2. สร้างปุ่มควบคุม (อยู่ด้านบน)
------------------------------------------------------

-- ปุ่มหยุด (Pause)
Tabs.Main:AddToggle("PauseSwitch", {
	Title = "Pause Logging",
	Default = false,
	Callback = function(Value)
		IsPaused = Value
	end,
})

-- ปุ่ม Copy All
Tabs.Main:AddButton({
	Title = "Copy All Logs",
	--Description = "คัดลอกประวัติทั้งหมดลง Clipboard",
	Callback = function()
		if setclipboard then
			setclipboard(table.concat(FullHistoryTable, "\n"))
			Fluent:Notify({ Title = "Success", Content = "Copied all logs!", Duration = 2 })
		else
			Fluent:Notify({ Title = "Error", Content = "Executor not supported", Duration = 2 })
		end
	end,
})

-- ปุ่ม Clear
Tabs.Main:AddButton({
	Title = "Clear Logs",
	Callback = function()
		DisplayTable = {}
		FullHistoryTable = {}
		if LogDisplay then
			LogDisplay:SetValue("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
		end
	end,
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph("LogDisplay", {
	Title = "Recent Logs",
	Content = "System initialized...",
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------
local function AddLog(message)
	if IsPaused then return end
	local entry = message
	-- เก็บลงประวัติทั้งหมด
	table.insert(FullHistoryTable, entry)
	if #FullHistoryTable > MaxFullHistory then table.remove(FullHistoryTable, 1) end

	-- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
	table.insert(DisplayTable, entry)
	if #DisplayTable > MaxLines then table.remove(DisplayTable, 1) end

	-- อัปเดตหน้าจอ
	if LogDisplay then
		local TempText = ""
		TempText = table.concat(DisplayTable, "\n")
		LogDisplay:SetValue(TempText)
	end
end
------------------------------------------------------
-- 5. [NEW] ฟังก์ชันเสริม (Wrapper Functions) ที่พี่เอฟต้องการ
------------------------------------------------------
local function InfoLog(message)
	AddLog("📋 " .. message)
end

local function WarnLog(message)
	AddLog("⚠️ " .. message)
end

local function ErrorLog(message)
	AddLog("❌ " .. message)
end

local function SuccessLog(message)
	AddLog("✅ " .. message)
end

local function TimeLog(message)
	local timestamp = os.date("%X")
	local entry = string.format("[%s] %s", timestamp, message)
	AddLog(entry)
end
------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)

local function InspectObject(obj)
	-- ตรวจสอบก่อนว่าค่าที่ส่งมาเป็น Object (Instance) จริงๆ ไหม
	if typeof(obj) ~= "Instance" then
		WarnLog("สิ่งที่ส่งมาไม่ใช่ Object ของ Roblox ค่ะ!")
		return
	end

	AddLog("=======================================")
	AddLog("🔍 ข้อมูลของ Object: " .. obj.Name)
	AddLog("🏷️ ประเภท (Class): " .. obj.ClassName)
	AddLog("=======================================")

	-- 1. ตรวจสอบ Attributes
	AddLog("\n--- 🟢 Attributes ---")
	local attributes = obj:GetAttributes()
	local hasAttributes = false
	if attributes["BaseName"] == "Carrot" then
		for attrName, attrValue in pairs(attributes) do
			AddLog(attrName .. " = " .. tostring(attrValue) .. " (" .. typeof(attrValue) .. ")")
			hasAttributes = true
		end
	end

	if not hasAttributes then AddLog("ไม่มี Attributes ค่ะ") end

	-- 2. ตรวจสอบ Properties (ใช้ความสามารถของ Executor)
	AddLog("\n--- 🔵 Properties ---")

	-- เช็คก่อนว่า Delta ที่รันอยู่รองรับคำสั่งนี้ไหม (กันสคริปต์พัง)
	--[[ 	if type(getproperties) == "function" then
		local success, props = pcall(function()
			return getproperties(obj)
		end)

		if success and type(props) == "table" then
			for propName, propValue in pairs(props) do
				-- ใช้ tostring ป้องกัน Error เวลาพยายาม print ข้อมูลประเภท CFrame หรือ Color3
				AddLog(propName .. " = " .. tostring(propValue))
			end
		else
			WarnLog("ไม่สามารถดึง Properties ได้ อาจจะติดระบบป้องกันของเกมค่ะ")
		end
	else
		AddLog("คำสั่ง getproperties() ไม่รองรับใน Executor นี้ค่ะ")
	end ]]

	AddLog("=======================================\n")
end

-- ==========================================
-- วิธีเรียกใช้งาน
-- ==========================================

-- ตัวอย่างที่ 1: ตรวจสอบตัวละครของเราเอง (ดูว่ามี ค่าสถานะอะไรซ่อนอยู่ไหม)
--local player = game.Players.LocalPlayer
--local character = player.Character or player.CharacterAdded:Wait()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--local myName = Players.LocalPlayer.Name

-- 1. ค้นหา Model ตัวละครของเราใน workspace ตามชื่อ
local Backpack = LocalPlayer.Backpack
---local myCharacter = workspace:FindFirstChild(myName)

for _, item in ipairs(Backpack:GetChildren()) do
	InspectObject(item)
end

--InspectObject(character)

-- ตัวอย่างที่ 2: ตรวจสอบ Part หรือร้านค้าในเกม (สมมติว่าเราหา Object ร้าน SeedShop เจอ)
-- InspectObject(workspace.Shops.SeedShop)
