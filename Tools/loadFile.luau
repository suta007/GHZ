local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- กำหนดเป้าหมายทั้งหมดที่ต้องการดึงข้อมูล
local targets = {
	ReplicatedStorage = game:GetService("ReplicatedStorage"),
	ReplicatedFirst = game:GetService("ReplicatedFirst"),
	PlayerScripts = LocalPlayer:WaitForChild("PlayerScripts"),
	PlayerGui = LocalPlayer:WaitForChild("PlayerGui"),
	Workspace = game:GetService("Workspace"),
}

local baseFolderName = "GardenHorizons"

-- สร้างโฟลเดอร์หลัก
if not isfolder(baseFolderName) then makefolder(baseFolderName) end

print("🚀 กำลังเริ่มดึงข้อมูลทั้งหมด... อาจใช้เวลานานและเกมอาจจะหน่วงนิดหน่อยนะคะ")

-- ฟังก์ชันหลักสำหรับดึงข้อมูลและ Decompile
local function dumpHierarchy(obj, currentPath)
	for _, child in ipairs(obj:GetChildren()) do
		-- ใส่ task.wait() ป้องกัน Delta Executor ค้างเมื่อเจอไฟล์เยอะๆ (โดยเฉพาะใน Workspace)
		if #obj:GetChildren() > 50 then task.wait() end

		local safeName = child.Name:gsub("[^%w%-%_ ]", "")
		if safeName == "" then safeName = "UnknownItem" end

		local newPath = currentPath .. "/" .. safeName

		-- ตรวจสอบประเภทที่ควรสร้างเป็นโฟลเดอร์ย่อย
		if child:IsA("Folder") or child:IsA("Model") or child:IsA("ScreenGui") or child:IsA("Configuration") then
			if not isfolder(newPath) then makefolder(newPath) end
			dumpHierarchy(child, newPath)

		-- ตรวจสอบและ Decompile Script
		elseif child:IsA("ModuleScript") or child:IsA("LocalScript") then
			local success, sourceCode = pcall(function()
				return decompile(child)
			end)

			if success and type(sourceCode) == "string" and sourceCode ~= "" then
				writefile(newPath .. ".lua", sourceCode)
			else
				writefile(newPath .. "_Error.txt", "-- แกะโค้ดไม่ได้ (อาจเข้ารหัส หรือเป็น Server Script ที่ Client เข้าไม่ถึง)")
			end

		-- ตรวจสอบจุดเชื่อมต่อข้อมูล (Events/Functions)
		elseif child:IsA("RemoteEvent") or child:IsA("RemoteFunction") or child:IsA("BindableEvent") or child:IsA("BindableFunction") then
			writefile(newPath .. "_" .. child.ClassName .. ".txt", "Path: " .. child:GetFullName())
		end
	end
end

-- วนลูปทำงานตามเป้าหมายที่ตั้งไว้
for name, obj in pairs(targets) do
	local targetPath = baseFolderName .. "/" .. name
	if not isfolder(targetPath) then makefolder(targetPath) end

	print("⏳ กำลังสแกนและแกะโค้ดในโซน: " .. name)
	local success, err = pcall(function()
		dumpHierarchy(obj, targetPath)
	end)

	if success then
		print("✅ โซน " .. name .. " เสร็จสมบูรณ์!")
	else
		print("❌ ข้อผิดพลาดที่ " .. name .. ": " .. tostring(err))
	end
end

print("🎉 ดึงข้อมูลทุกส่วนเสร็จเรียบร้อย! พี่เอฟเปิดโฟลเดอร์ดูใน VS Code ได้เลยค่ะ")
