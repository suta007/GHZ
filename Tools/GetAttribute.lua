local function InspectObject(obj)
	-- ตรวจสอบก่อนว่าค่าที่ส่งมาเป็น Object (Instance) จริงๆ ไหม
	if typeof(obj) ~= "Instance" then
		warn("สิ่งที่ส่งมาไม่ใช่ Object ของ Roblox ค่ะ!")
		return
	end

	print("=======================================")
	print("🔍 ข้อมูลของ Object: " .. obj.Name)
	print("🏷️ ประเภท (Class): " .. obj.ClassName)
	print("=======================================")

	-- 1. ตรวจสอบ Attributes
	print("\n--- 🟢 Attributes ---")
	local attributes = obj:GetAttributes()
	local hasAttributes = false

	for attrName, attrValue in pairs(attributes) do
		print(attrName .. " = " .. tostring(attrValue) .. " (" .. typeof(attrValue) .. ")")
		hasAttributes = true
	end

	if not hasAttributes then print("ไม่มี Attributes ค่ะ") end

	-- 2. ตรวจสอบ Properties (ใช้ความสามารถของ Executor)
	print("\n--- 🔵 Properties ---")

	-- เช็คก่อนว่า Delta ที่รันอยู่รองรับคำสั่งนี้ไหม (กันสคริปต์พัง)
	if type(getproperties) == "function" then
		local success, props = pcall(function()
			return getproperties(obj)
		end)

		if success and type(props) == "table" then
			for propName, propValue in pairs(props) do
				-- ใช้ tostring ป้องกัน Error เวลาพยายาม print ข้อมูลประเภท CFrame หรือ Color3
				print(propName .. " = " .. tostring(propValue))
			end
		else
			warn("ไม่สามารถดึง Properties ได้ อาจจะติดระบบป้องกันของเกมค่ะ")
		end
	else
		print("คำสั่ง getproperties() ไม่รองรับใน Executor นี้ค่ะ")
	end

	print("=======================================\n")
end

-- ==========================================
-- วิธีเรียกใช้งาน
-- ==========================================

-- ตัวอย่างที่ 1: ตรวจสอบตัวละครของเราเอง (ดูว่ามี ค่าสถานะอะไรซ่อนอยู่ไหม)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
InspectObject(character)

-- ตัวอย่างที่ 2: ตรวจสอบ Part หรือร้านค้าในเกม (สมมติว่าเราหา Object ร้าน SeedShop เจอ)
-- InspectObject(workspace.Shops.SeedShop)
