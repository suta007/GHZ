local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RequestSpin = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("RequestSpin")

-- ฟังก์ชันสำหรับ "ปิดการทำงาน" ของแอนิเมชันทุกรูปแบบ
local function disableAnimations()
	-- ค้นหา Module ในหน่วยความจำ (GC)
	for _, v in pairs(getgc(true)) do
		if type(v) == "table" then
			-- 1. ปิดแอนิเมชันการหมุนและโชว์ของ (ใน RNGPackManager)
			if rawget(v, "RunSpinAnimation") then
				v.RunSpinAnimation = function()
					return
				end
				v.ShowcaseRewards = function()
					return
				end
				v.Initiate = function()
					return
				end -- ปิดการทำงานเดิมของปุ่มกดด้วย
			end

			-- 2. ปิดฉาก Cutscene สำหรับของแรร์ (ใน CutsceneManager)
			if rawget(v, "Play") and rawget(v, "Preload") then
				v.Play = function()
					return
				end
				print("✅ ปิด Cutscene เรียบร้อย")
			end
		end
	end

	-- 3. จัดการ UI ที่อาจจะค้างอยู่
	local lp = game:GetService("Players").LocalPlayer
	local pgui = lp:FindFirstChild("PlayerGui")
	if pgui then
		-- รายชื่อ UI ที่ระบุในโค้ด RNGPackManager ว่าจะถูกปิด/เปิด
		local uiToForceEnable = { "BackpackGui", "Hud_UI", "ShillingsCurrency" }
		for _, name in ipairs(uiToForceEnable) do
			local ui = pgui:FindFirstChild(name)
			if ui then ui.Enabled = true end
		end
	end
end

-- รันการปิดแอนิเมชันก่อน
disableAnimations()

-- ฟังก์ชันสั่งเปิดซองแบบรวดเร็ว
local function instantOpen()
	local success, result = pcall(function()
		-- เรียก Server ตรงๆ เพื่อเอาของเข้าตัว
		return RequestSpin:InvokeServer()
	end)

	if success and result and result.RewardId then
		print("🌱 ได้รับไอเทมแล้ว: " .. tostring(result.RewardId))
	else
		print("❌ เปิดไม่สำเร็จ (อาจจะไม่มีซองในมือ หรือติด Cooldown)")
	end
end

-- เรียกใช้งาน
instantOpen()

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
local oldFunc = nil -- ตัวแปรไว้เก็บของเดิม

for _, v in pairs(getgc(true)) do
	if type(v) == "table" and rawget(v, "RunSpinAnimation") then
		-- 1. Backup: ฝากฟังก์ชันเดิมไว้ที่ oldFunc
		oldFunc = v.RunSpinAnimation

		-- 2. Overwrite: เขียนทับด้วยฟังก์ชันว่างเปล่า
		v.RunSpinAnimation = function()
			print("ตอนนี้แอนิเมชันถูกปิดอยู่นะคะพี่เอฟ")
		end

		print("✅ Backup และปิดแอนิเมชันเรียบร้อย")

		-- สมมติว่าผ่านไป 10 วินาที อยากให้กลับมาเป็นเหมือนเดิม
		task.delay(10, function()
			if oldFunc then
				v.RunSpinAnimation = oldFunc -- 3. Restore: คืนค่าเดิมกลับไป
				print("⏪ คืนค่าแอนิเมชันเดิมให้แล้วค่ะ!")
			end
		end)
	end
end
