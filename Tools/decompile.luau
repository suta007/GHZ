-- ระบุ Path ไปยังไฟล์ที่พี่เอฟอยากรู้โค้ดข้างใน
local targetScript = game:GetService("ReplicatedStorage").Modules.PlantConfig

-- ใช้คำสั่ง decompile ของ Executor ดึงโค้ดออกมา
local success, sourceCode = pcall(function()
	return decompile(targetScript)
end)

if success and sourceCode then
	-- เซฟเป็นไฟล์ .lua เพื่อเอาไปเปิดอ่านใน VS Code
	writefile("PlantConfig_Source.lua", sourceCode)
	print("Decompile และเซฟไฟล์สำเร็จ!")
else
	print("ไม่สามารถ Decompile ไฟล์นี้ได้")
end
