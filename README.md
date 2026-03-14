# 🌿 Garden Horizons Modular (GHZ)

ระบบสคริปต์แบบ Modular สถาปัตยกรรมระดับมืออาชีพสำหรับ Garden Horizons ออกแบบมาเพื่อความยืดหยุ่น ประสิทธิภาพ และการพัฒนาต่อยอดที่ง่ายดาย

## 🚀 จุดเด่นของระบบ (Key Features)

- **One-Time Remote Loading**: โหลดไฟล์จาก GitHub เพียงครั้งเดียวและเก็บไว้ในหน่วยความจำ ลดการเชื่อมต่อ Internet ซ้ำซ้อน
- **Dependency Injection (Registry)**: ใช้ระบบ Registry ในการส่งต่อ Module ต่างๆ ทำให้โค้ดสะอาดและไม่มี Global Variable ที่รก
- **Stealth & Safety (getgenv)**: ใช้ `getgenv()` แทน `_G` เพื่อซ่อนตัวตนสคริปต์จากการตรวจจับของ Anti-Cheat ในระดับปกติ
- **Layered Architecture**: แยกส่วนการทำงานออกเป็น Core, Modules, และ UI อย่างชัดเจน
- **Action Queue System**: มีระบบคิวงาน ป้องกันการทำงานทับซ้อนกันของระบบ Auto ต่างๆ

---

## 🏗️ โครงสร้างไฟล์ (Project Structure)

```text
src/
├── Core/               # หัวใจหลักของระบบ
│   ├── Constants.luau # เก็บค่าคงที่, ตำแหน่ง (POS)
│   ├── Network.luau   # ตัวกลางจัดการ RemoteEvents
│   ├── State.luau     # เก็บสถานะการทำงาน (flags, queues)
│   ├── Utils.luau     # ฟังก์ชันอำนวยความสะดวกทั่วไป
│   └── RemoteLoader.luau # ระบบโหลดไฟล์จาก GitHub
├── Modules/            # ฟีเจอร์หลัก (Game Logic)
│   ├── Harvest.luau   # ระบบเกี่ยวกับการเก็บเกี่ยว
│   ├── Planting.luau  # ระบบเกี่ยวกับการปลูก
│   ├── Trading.luau   # ระบบซื้อขาย
│   ├── ESP.luau       # ระบบแสดงผลนิมิต (ESP)
│   └── Events/        # เก็บ Event พิเศษต่างๆ
│       └── MannyMishap.luau
├── UI/                 # การแสดงผล
│   ├── Window.luau    # ตัวสร้างหน้าต่างหลัก (Fluent)
│   └── Tabs/          # แยกไฟล์ตามหน้า tab ต่างๆ
│       ├── MainTab.luau
│       ├── ShopTab.luau
│       └── ...
└── Main.luau           # จุดเริ่มต้นและจุดรวม Module ทั้งหมด
```

---

## 🛠️ วิธีการพัฒนาต่อ (Development Guide)

### 1. การเพิ่ม Module ใหม่ (Add New Module)
สร้างไฟล์ใหม่ใน `src/Modules/` และใช้โครงสร้างนี้:
```lua
local MyModule = {}
local Registry = nil

function MyModule.Initialize(reg)
    Registry = reg -- รับ Registry เพื่อใช้ Module อื่นๆ
end

function MyModule.DoSomething()
    local State = Registry.State
    -- เขียน Logic ของคุณที่นี่
end

return MyModule
```

### 2. การเพิ่ม Tab ใน UI (Add New Tab)
สร้างไฟล์ใน `src/UI/Tabs/` และเตรียมฟังก์ชัน `Setup`:
```lua
```lua
local MyTab = {}

function MyTab.Setup(tab, Options, SaveManager, Registry)
    local MyModule = Registry.MyModule
    
    local Section = tab:AddCollapsibleSection("My Section", true)
    Section:AddToggle("tgMyToggle", {
        Title = "Enable Feature",
        Callback = function(Value)
            -- Call module function
        end
    })
end

return MyTab
```

### 3. การจดทะเบียน Tab และ Module (Integration Steps)
เมื่อสร้างไฟล์เสร็จแล้ว ต้องทำ 3 ขั้นตอนเพื่อให้ระบบมองเห็น:

**ก. เพิ่มการ Load ใน `src/Main.luau`:**
```lua
-- ในฟังก์ชัน LoadModules()
Registry.MyTab = GHZ_REMOTE("UI/Tabs/MyTab")
```

**ข. สร้างหน้า Tab ใน `src/UI/Window.luau`:**
```lua
-- ในฟังก์ชัน Window.Initialize() ตรงตาราง Tabs
Tabs.MyTab = interface:AddTab({ Title = "My Tab", Icon = "rbxassetid://..." })
```

**ค. เรียก Setup ใน `src/Main.luau`:**
```lua
-- ในฟังก์ชัน Main.Initialize() (Step 4. Setup Tabs)
Registry.MyTab.Setup(Tabs.MyTab, Options, SaveManager, Registry)
```

---

## 📡 ระบบการโหลดไฟล์ (Loading Mechanism)

ระบบใช้ไฟล์ `src/loader.luau` ในการเริ่มต้น โดยจะดึงไฟล์ `Main.luau` จาก GitHub และสร้างฟังก์ชัน `getgenv().GHZ_REMOTE` ไว้ให้ Module อื่นๆ เรียกใช้ (ซึ่งสคริปต์ปกติของเกมจะเข้าถึงไม่ได้ เพื่อความปลอดภัย)

**Path พื้นฐาน:** `https://raw.githubusercontent.com/suta007/GHZ/refs/heads/master/src/`

---

## ⚠️ ข้อควรระวัง
- ทุกครั้งที่แก้ไขโค้ดในเครื่อง ต้องทำการ **git push** ขึ้น GitHub เสมอ เพื่อให้ตัว Loader ดึงเวอร์ชันใหม่ไปใช้งานได้
- ระบบนี้เน้นการใช้ `Registry` มากกว่าการใช้ `require` ภายใน Module เพื่อหลีกเลี่ยงการโหลดซ้ำซ้อน
- **ความปลอดภัย**: เราใช้ `getgenv()` เพราะมันเร็วกว่าและปลอดภัยกว่า `_G` เนื่องจากสคริปต์ทั่วไปของ Roblox ไม่สามารถเข้าถึง Environment ระดับ Executor นี้ได้ง่ายๆ

---
*Created with ❤️ by Antigravity AI for mr.suta*
