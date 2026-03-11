-- ==========================================
-- Standalone: Manny Mishap Auto Collect (Queue System)
-- ==========================================
local player = game:GetService("Players").LocalPlayer

-- ป้องกันการรันซ้ำ
if getgenv().MannyQueueConnection then getgenv().MannyQueueConnection:Disconnect() end
getgenv().IsMannyFarming = true

local fruitQueue = {} -- สร้างตารางคิวว่างๆ
local COOLDOWN = 0.45 -- หน่วงเวลา 0.45 วิ (เกมเช็ก 0.4 วิ เผื่อค่าปิงไว้นิดนึงค่ะ)

-- ฟังก์ชันเช็กว่าเป็นผลไม้ของอีเวนต์หรือไม่
local function isFruit(obj)
	return obj:IsA("Model") and string.find(obj.Name, "_Collectible")
end

print("🔄 กำลังเตรียมระบบ Queue...")

-- [ส่วนที่ 1] กวาดผลไม้ที่ค้างอยู่ในแมพเข้าคิวเป็นชุดแรก
for _, obj in ipairs(workspace:GetDescendants()) do
	if isFruit(obj) then table.insert(fruitQueue, obj) end
end
print("📥 เก็บผลไม้เก่าเข้าคิวจำนวน: " .. #fruitQueue .. " ลูก")

-- [ส่วนที่ 2] Event ดักจับผลไม้เกิดใหม่ แล้วจับต่อท้ายคิว
getgenv().MannyQueueConnection = workspace.DescendantAdded:Connect(function(obj)
	if not getgenv().IsMannyFarming then return end
	if isFruit(obj) then table.insert(fruitQueue, obj) 		-- print("➕ ของใหม่เข้าคิว! คิวปัจจุบัน: " .. #fruitQueue)
end
end)

print("✅ เริ่มประมวลผลคิว...")

-- [ส่วนที่ 3] Loop ประมวลผลคิว (ทำหน้าที่ทยอยเก็บทีละลูก)
task.spawn(function()
	while getgenv().IsMannyFarming do
		if #fruitQueue > 0 then
			-- หยิบผลไม้คิวที่ 1 มาจัดการ
			local targetFruit = fruitQueue[1]

			-- เช็กว่าผลไม้ยังอยู่ในแมพไหม (เผื่อคนอื่นเก็บไปก่อน หรือเกมลบทิ้ง)
			if targetFruit and targetFruit.Parent then
				local anchor = targetFruit:FindFirstChild("Anchor")
				local character = player.Character

				if anchor and character and character:FindFirstChild("HumanoidRootPart") then
					local rootPart = character.HumanoidRootPart

					if firetouchinterest then
						firetouchinterest(rootPart, anchor, 0)
						task.wait(0.01)
						firetouchinterest(rootPart, anchor, 1)
					end

					-- เก็บสำเร็จ รอ Cooldown ก่อนหยิบคิวต่อไป
					task.wait(COOLDOWN)
				else
					task.wait(0.05)
				end
			end

			-- เอาคิวที่ 1 ออกจากตาราง (เลื่อนคิวถัดไปขึ้นมา)
			table.remove(fruitQueue, 1)
		else
			-- ถ้าคิวว่าง ให้พักรอเบาๆ
			task.wait(0.1)
		end
	end

	-- เคลียร์ Event เมื่อสั่งหยุด
	if getgenv().MannyQueueConnection then getgenv().MannyQueueConnection:Disconnect() end
end)

-- ฟังก์ชันหยุด
getgenv().StopMannyQueue = function()
	getgenv().IsMannyFarming = false
	print("🛑 ปิดระบบ Queue แล้ว")
end
