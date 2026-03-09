local LocalPlayer = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- สร้างโฟลเดอร์สำหรับเก็บ ESP (ถ้ารันซ้ำจะได้ลบของเก่าทิ้งได้)
local PlantsEspFolderName = "EfHub_PlantsESP"
if CoreGui:FindFirstChild(PlantsEspFolderName) then CoreGui[PlantsEspFolderName]:Destroy() end

local PlantsESPFolder = Instance.new("Folder")
PlantsESPFolder.Name = PlantsEspFolderName
PlantsESPFolder.Parent = gethui and gethui() or CoreGui

local function CreatPlantESP(Plant)
	-- สร้าง BillboardGui (โค้ดส่วน UI เหมือนเดิม)
	local uuid = Plant:GetAttribute("Uuid")
	--print(uuid)
	if not uuid then return end

	local PlantType = Plant:GetAttribute("PlantType")
	local Scale = Plant:GetAttribute("HiddenNumber") or 0

	local bgui = Instance.new("BillboardGui")
	bgui.Name = "ESP_" .. uuid
	bgui.Adornee = Plant
	bgui.Size = UDim2.new(0, 150, 0, 60)
	bgui.StudsOffset = Vector3.new(0, 3.5, 0)
	bgui.AlwaysOnTop = true
	bgui.LightInfluence = 0
	bgui.Parent = PlantsESPFolder

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = bgui
	textLabel.Size = UDim2.new(1, 0, 0, 0)
	textLabel.AutomaticSize = Enum.AutomaticSize.XY
	textLabel.BackgroundTransparency = 1

	textLabel.Text = string.format("🌱 %s\n⚖️ %.2f", tostring(PlantType), tonumber(Scale) :: number)

	-- ไฮไลท์สีตามน้ำหนักคาดการณ์ (ถ้าฟักออกมาเกิน 2.0 ให้เป็นสีแรร์)
	if Scale >= 2 then
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 10)
	elseif Scale >= 1.5 then
		textLabel.TextColor3 = Color3.fromRGB(200, 50, 10)
	elseif Scale >= 1 then
		textLabel.TextColor3 = Color3.fromRGB(10, 200, 10)
	else
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	end

	textLabel.TextStrokeTransparency = 0
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.RobotoMono
end

local function CreatESP(espfolder, obj, uuid, txt1, txt2, arg)
	-- เช็คเฉพาะตัวที่ "ขาดไม่ได้" จริงๆ (txt2 ไม่ต้องเช็คเพื่อให้ใส่หรือไม่ใส่ก็ได้)
	if not (espfolder and obj and uuid and txt1) then return end

	local priority = arg or 0

	local bgui = Instance.new("BillboardGui")
	bgui.Name = "ESP_" .. uuid
	bgui.Adornee = obj
	-- ปรับความกว้างเพิ่มเป็น 200 เพื่อรองรับ AutomaticSize ด้านกว้างได้ดีขึ้น
	bgui.Size = UDim2.new(0, 200, 0, 80)
	bgui.StudsOffset = Vector3.new(0, 3.5, 0)
	bgui.AlwaysOnTop = true
	bgui.LightInfluence = 0
	bgui.Parent = espfolder

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = bgui
	-- ใช้ความกว้างเต็ม แต่ความสูงยืดตามจริง
	textLabel.Size = UDim2.new(1, 0, 0, 0)
	textLabel.AutomaticSize = Enum.AutomaticSize.XY
	textLabel.BackgroundTransparency = 1
	textLabel.TextWrapped = false -- ปิดไว้เพื่อให้มันยืดออกด้านข้างตาม AutomaticSize X

	-- จัดรูปแบบข้อความ (ถ้าไม่มี txt2 ให้โชว์แค่ txt1 บรรทัดเดียว)
	if txt2 and txt2 ~= "" then
		textLabel.Text = string.format("%s\n%s", tostring(txt1), tostring(txt2))
	else
		textLabel.Text = tostring(txt1)
	end

	-- การจัดการสีตาม Priority (เหมือนเดิมของพี่เอฟเลยค่ะ)
	if priority == 3 then
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 10) -- ทอง/เหลือง (แรร์มาก)
	elseif priority == 2 then
		textLabel.TextColor3 = Color3.fromRGB(200, 50, 10) -- ส้ม/แดง (สำคัญ)
	elseif priority == 1 then
		textLabel.TextColor3 = Color3.fromRGB(10, 200, 10) -- เขียว (ปกติ)
	else
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- เทา (ทั่วไป)
	end

	textLabel.TextStrokeTransparency = 0
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.FredokaOne

	-- แถม: จัดให้ข้อความลอยอยู่ตรงกลางกรอบพอดี
	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
end

local ClientPlants = workspace.ClientPlants

for _, plant in pairs(ClientPlants:GetChildren()) do
	if plant:GetAttribute("PlantType") and plant:GetAttribute("PlantType") == "Beetroot" then CreatPlantESP(plant) end
end
