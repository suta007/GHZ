-- [[ EfHub Addon: Searchable Dropdown (EfDropdown) ]] --
-- Replicated from Fluent Original Dropdown.luau
return function(FluentLibrary)
	local AddonName = "AddEfDropdown"
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local Camera = workspace.CurrentCamera
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

	local function CreateEfDropdown(self, ID, Config)
		local Dropdown = {
			Values = Config.Values or {},
			Value = Config.Default,
			Multi = Config.Multi or false,
			Searchable = Config.Searchable or false,
			Opened = false,
			Callback = Config.Callback or function() end,
		}

		local ParentTab = self
		local Container = ParentTab.Container

		-- [ 1. สร้างกรอบหลัก (Element Frame) ]
		local ElementFrame = Instance.new("Frame")
		ElementFrame.Size = UDim2.new(1, 0, 0, 42)
		ElementFrame.BackgroundTransparency = 1
		ElementFrame.Parent = Container

		local TitleLabel = Instance.new("TextLabel")
		TitleLabel.Text = Config.Title or "Dropdown"
		TitleLabel.Font = Enum.Font.Gotham
		TitleLabel.TextSize = 14
		TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.Size = UDim2.new(1, -170, 0, 14)
		TitleLabel.Position = UDim2.new(0, 10, 0.5, 0)
		TitleLabel.AnchorPoint = Vector2.new(0, 0.5)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Parent = ElementFrame

		-- [ 2. สร้างปุ่ม DropdownInner ]
		local DropdownInner = Instance.new("TextButton")
		DropdownInner.Size = UDim2.fromOffset(160, 30)
		DropdownInner.Position = UDim2.new(1, -10, 0.5, 0)
		DropdownInner.AnchorPoint = Vector2.new(1, 0.5)
		DropdownInner.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- สีเดียวกับ DropdownFrame
		DropdownInner.BackgroundTransparency = 0.5
		DropdownInner.Text = ""
		DropdownInner.AutoButtonColor = false
		DropdownInner.Parent = ElementFrame

		Instance.new("UICorner", DropdownInner).CornerRadius = UDim.new(0, 5)
		local InnerStroke = Instance.new("UIStroke", DropdownInner)
		InnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		InnerStroke.Color = Color3.fromRGB(255, 255, 255)
		InnerStroke.Transparency = 0.8

		local DropdownDisplay = Instance.new("TextLabel")
		DropdownDisplay.Font = Enum.Font.Gotham
		DropdownDisplay.TextSize = 13
		DropdownDisplay.TextColor3 = Color3.fromRGB(240, 240, 240)
		DropdownDisplay.TextXAlignment = Enum.TextXAlignment.Left
		DropdownDisplay.Size = UDim2.new(1, -30, 0, 14)
		DropdownDisplay.Position = UDim2.new(0, 8, 0.5, 0)
		DropdownDisplay.AnchorPoint = Vector2.new(0, 0.5)
		DropdownDisplay.BackgroundTransparency = 1
		DropdownDisplay.TextTruncate = Enum.TextTruncate.AtEnd
		DropdownDisplay.Parent = DropdownInner

		local DropdownIco = Instance.new("ImageLabel")
		DropdownIco.Image = "rbxassetid://10709790948"
		DropdownIco.Size = UDim2.fromOffset(16, 16)
		DropdownIco.AnchorPoint = Vector2.new(1, 0.5)
		DropdownIco.Position = UDim2.new(1, -8, 0.5, 0)
		DropdownIco.BackgroundTransparency = 1
		DropdownIco.ImageColor3 = Color3.fromRGB(200, 200, 200)
		DropdownIco.Parent = DropdownInner

		-- [ 3. สร้างหน้าต่าง Popup (เอาไว้ใน Layer สูงสุด) ]
		local DropdownHolderCanvas = Instance.new("Frame")
		DropdownHolderCanvas.BackgroundTransparency = 1
		DropdownHolderCanvas.Size = UDim2.fromOffset(170, 250)
		DropdownHolderCanvas.Visible = false
		-- สำคัญ: ดึงเอาไปไว้ที่ GUI หลักของ Fluent เพื่อให้ทับทุกอย่าง
		DropdownHolderCanvas.Parent = FluentLibrary.GUI or Container.Parent.Parent.Parent

		local DropdownHolderFrame = Instance.new("Frame")
		DropdownHolderFrame.Size = UDim2.fromScale(1, 0)
		DropdownHolderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		DropdownHolderFrame.ClipsDescendants = true
		DropdownHolderFrame.Parent = DropdownHolderCanvas

		Instance.new("UICorner", DropdownHolderFrame).CornerRadius = UDim.new(0, 7)
		local HolderStroke = Instance.new("UIStroke", DropdownHolderFrame)
		HolderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		HolderStroke.Color = Color3.fromRGB(60, 60, 60)

		-- [ 4. สร้างกล่อง Search (ถ้าเปิดใช้) ]
		local SearchBox = Instance.new("TextBox")
		SearchBox.Visible = Dropdown.Searchable
		SearchBox.Size = UDim2.new(1, -10, 0, 30)
		SearchBox.Position = UDim2.new(0.5, 0, 0, 5)
		SearchBox.AnchorPoint = Vector2.new(0.5, 0)
		SearchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		SearchBox.TextColor3 = Color3.fromRGB(240, 240, 240)
		SearchBox.Font = Enum.Font.Gotham
		SearchBox.TextSize = 13
		SearchBox.PlaceholderText = "Search..."
		SearchBox.Text = ""
		SearchBox.Parent = DropdownHolderFrame
		Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 5)

		-- [ 5. สร้าง ScrollFrame สำหรับรายการ ]
		local DropdownScrollFrame = Instance.new("ScrollingFrame")
		DropdownScrollFrame.Size = UDim2.new(1, -5, 1, Dropdown.Searchable and -40 or -10)
		DropdownScrollFrame.Position = UDim2.fromOffset(5, Dropdown.Searchable and 40 or 5)
		DropdownScrollFrame.BackgroundTransparency = 1
		DropdownScrollFrame.ScrollBarThickness = 4
		DropdownScrollFrame.BorderSizePixel = 0
		DropdownScrollFrame.Parent = DropdownHolderFrame

		local DropdownListLayout = Instance.new("UIListLayout")
		DropdownListLayout.Padding = UDim.new(0, 3)
		DropdownListLayout.Parent = DropdownScrollFrame

		-- [ 6. ระบบอัปเดต UI ]
		local function UpdateDisplay()
			if Dropdown.Multi then
				local str = ""
				for k, v in pairs(Dropdown.Value or {}) do
					if v then str = str .. k .. ", " end
				end
				DropdownDisplay.Text = str == "" and "--" or string.sub(str, 1, -3)
			else
				DropdownDisplay.Text = Dropdown.Value or "--"
			end
		end

		local function BuildList(FilterText)
			for _, child in ipairs(DropdownScrollFrame:GetChildren()) do
				if child:IsA("TextButton") then child:Destroy() end
			end

			FilterText = FilterText and string.lower(FilterText) or ""
			local YSize = 0

			for _, val in ipairs(Dropdown.Values) do
				if FilterText == "" or string.find(string.lower(tostring(val)), FilterText) then
					local Btn = Instance.new("TextButton")
					Btn.Size = UDim2.new(1, -5, 0, 32)
					Btn.BackgroundTransparency = 1
					Btn.Text = ""
					Btn.Parent = DropdownScrollFrame

					local Label = Instance.new("TextLabel")
					Label.Text = tostring(val)
					Label.Font = Enum.Font.Gotham
					Label.TextSize = 13
					Label.TextColor3 = Color3.fromRGB(200, 200, 200)
					Label.Size = UDim2.fromScale(1, 1)
					Label.Position = UDim2.fromOffset(20, 0)
					Label.BackgroundTransparency = 1
					Label.TextXAlignment = Enum.TextXAlignment.Left
					Label.Parent = Btn

					local Selector = Instance.new("Frame")
					Selector.Size = UDim2.fromOffset(4, 14)
					Selector.Position = UDim2.fromOffset(-1, 16)
					Selector.AnchorPoint = Vector2.new(0, 0.5)
					Selector.BackgroundColor3 = Color3.fromRGB(76, 194, 255)
					Selector.BackgroundTransparency = 1
					Selector.Parent = Btn
					Instance.new("UICorner", Selector).CornerRadius = UDim.new(0, 2)

					-- เช็คสถานะการเลือก
					local isSelected = false
					if Dropdown.Multi and type(Dropdown.Value) == "table" then
						isSelected = Dropdown.Value[val]
					else
						isSelected = (Dropdown.Value == val)
					end

					if isSelected then
						Selector.BackgroundTransparency = 0
						Label.TextColor3 = Color3.fromRGB(255, 255, 255)
					end

					Btn.MouseButton1Click:Connect(function()
						if Dropdown.Multi then
							if not Dropdown.Value then Dropdown.Value = {} end
							Dropdown.Value[val] = not Dropdown.Value[val]
						else
							Dropdown.Value = val
							Dropdown.Opened = false
							TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.fromScale(1, 0) }):Play()
							task.wait(0.2)
							DropdownHolderCanvas.Visible = false
						end

						if FluentLibrary.Options then FluentLibrary.Options[ID] = { Value = Dropdown.Value } end

						Dropdown.Callback(Dropdown.Value)
						UpdateDisplay()
						BuildList(SearchBox.Text) -- รีเฟรชลิสต์เพื่ออัปเดตแทบสีฟ้า
					end)

					YSize = YSize + 35
				end
			end
			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, YSize)
		end

		SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			BuildList(SearchBox.Text)
		end)

		-- [ 7. เปิด / ปิด Popup ]
		DropdownInner.MouseButton1Click:Connect(function()
			Dropdown.Opened = not Dropdown.Opened
			if Dropdown.Opened then
				-- อัปเดตตำแหน่งให้อยู่ใต้ปุ่มพอดี
				local AbsPos = DropdownInner.AbsolutePosition
				DropdownHolderCanvas.Position = UDim2.fromOffset(AbsPos.X - 10, AbsPos.Y + 35)
				DropdownHolderCanvas.Visible = true
				BuildList()
				UpdateDisplay()

				-- แอนิเมชันเปิดหน้าต่าง
				TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.fromScale(1, 1) }):Play()
			else
				TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.fromScale(1, 0) }):Play()
				task.wait(0.2)
				DropdownHolderCanvas.Visible = false
			end
		end)

		-- ปิดเมื่อคลิกที่อื่น
		UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Dropdown.Opened then
					local AbsPos, AbsSize = DropdownHolderCanvas.AbsolutePosition, DropdownHolderCanvas.AbsoluteSize
					if Mouse.X < AbsPos.X or Mouse.X > AbsPos.X + AbsSize.X or Mouse.Y < AbsPos.Y - 40 or Mouse.Y > AbsPos.Y + AbsSize.Y then
						Dropdown.Opened = false
						TweenService:Create(DropdownHolderFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.fromScale(1, 0) }):Play()
						task.wait(0.2)
						DropdownHolderCanvas.Visible = false
					end
				end
			end
		end)

		if Config.Default then UpdateDisplay() end
		return Dropdown
	end

	-- Hook Addon เข้ากับ Fluent
	local OldCreateWindow = FluentLibrary.CreateWindow
	FluentLibrary.CreateWindow = function(self, Config)
		local Window = OldCreateWindow(self, Config)
		local OldAddTab = Window.AddTab
		Window.AddTab = function(self, TabConfig)
			local Tab = OldAddTab(self, TabConfig)
			Tab[AddonName] = CreateEfDropdown
			return Tab
		end
		return Window
	end
end
