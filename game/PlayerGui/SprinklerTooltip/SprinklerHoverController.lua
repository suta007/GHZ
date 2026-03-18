local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("CollectionService")
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = v1.LocalPlayer
local v_u_7 = workspace.CurrentCamera
local v_u_8 = require(v5:WaitForChild("Gears"):WaitForChild("Definitions"):WaitForChild("SprinklerDefinitions"))
local v_u_9 = v5:WaitForChild("Gears"):WaitForChild("Models"):WaitForChild("Sprinklers")
local v10 = script.Parent
if v10 then
	local v_u_11 = v10:WaitForChild("TooltipFrame", 10)
	if v_u_11 then
		local v_u_12 = v_u_11:WaitForChild("SprinklerName", 5)
		local v_u_13 = v_u_11:WaitForChild("SprinklerTimer", 5)
		if v_u_12 and v_u_13 then
			v_u_12.RichText = true
			v_u_12.TextXAlignment = Enum.TextXAlignment.Center
			v_u_13.RichText = true
			v_u_13.TextXAlignment = Enum.TextXAlignment.Center
			v10.DisplayOrder = -1
			local v_u_14 = {
				["Common"] = "#FFFFFF",
				["Uncommon"] = "#1EFF00",
				["Rare"] = "#0070DD",
				["Epic"] = "#A335EE",
				["Legendary"] = "#FF8000"
			}
			local v_u_15 = nil
			local v_u_16 = {}
			local function v_u_18(p17)
				-- upvalues: (copy) v_u_4
				if not p17 then
					return nil
				end
				while p17 and p17 ~= workspace do
					if v_u_4:HasTag(p17, "Sprinkler") then
						return p17
					end
					p17 = p17.Parent
				end
				return nil
			end
			local function v_u_28(p19)
				if p19 <= 0 then
					return "Expired"
				elseif p19 < 60 then
					return string.format("%ds", (math.floor(p19)))
				elseif p19 < 3600 then
					local v20 = p19 / 60
					local v21 = math.floor(v20)
					local v22 = p19 % 60
					local v23 = math.floor(v22)
					return string.format("%dm %ds", v21, v23)
				else
					local v24 = p19 / 3600
					local v25 = math.floor(v24)
					local v26 = p19 % 3600 / 60
					local v27 = math.floor(v26)
					return string.format("%dh %dm", v25, v27)
				end
			end
			local function v_u_30()
				-- upvalues: (copy) v_u_16, (ref) v_u_15
				for _, v29 in v_u_16 do
					if v29 and v29.Parent then
						v29:Destroy()
					end
				end
				table.clear(v_u_16)
				v_u_15 = nil
			end
			local function v_u_44(p31)
				-- upvalues: (copy) v_u_9, (copy) v_u_16
				local v32 = p31:GetAttribute("SprinklerType")
				if v32 then
					local v33 = v_u_9:FindFirstChild(v32)
					if v33 then
						local v34 = Instance.new("Highlight")
						v34.FillColor = Color3.new(1, 1, 1)
						v34.FillTransparency = 0.75
						v34.OutlineColor = Color3.new(1, 1, 1)
						v34.OutlineTransparency = 0
						v34.Parent = p31
						local v35 = v_u_16
						table.insert(v35, v34)
						local v36 = v33:FindFirstChild("GroundAnchor")
						if v36 then
							local v37 = p31:FindFirstChild("GroundAnchor")
							if v37 then
								for _, v38 in v36:GetChildren() do
									if v38:IsA("Attachment") and v38.Name == "PreviewOutline" then
										local v39 = v38:Clone()
										v39.Parent = v37
										local v40 = v_u_16
										table.insert(v40, v39)
										for _, v41 in v39:GetDescendants() do
											if v41:IsA("ParticleEmitter") then
												local v42 = v41.Rate * v41.Lifetime.Max
												local v43 = math.ceil(v42)
												if v43 > 0 then
													v41:Emit(v43)
												end
											end
										end
									end
								end
							end
						else
							return
						end
					else
						return
					end
				else
					return
				end
			end
			local function v69()
				-- upvalues: (copy) v_u_6, (copy) v_u_11, (ref) v_u_15, (copy) v_u_30, (ref) v_u_7, (copy) v_u_3, (copy) v_u_18, (copy) v_u_8, (copy) v_u_14, (copy) v_u_12, (copy) v_u_28, (copy) v_u_13, (copy) v_u_44
				if v_u_6.Character then
					if workspace.CurrentCamera then
						v_u_7 = workspace.CurrentCamera
					end
					local v45 = v_u_3:GetMouseLocation()
					local v46 = v_u_7:ViewportPointToRay(v45.X, v45.Y)
					local v47 = RaycastParams.new()
					v47.FilterType = Enum.RaycastFilterType.Exclude
					v47.FilterDescendantsInstances = { v_u_6.Character }
					local v48 = workspace:Raycast(v46.Origin, v46.Direction * 100, v47)
					local v49
					if v48 and v48.Instance then
						v49 = v_u_18(v48.Instance)
					else
						v49 = nil
					end
					if v49 then
						local v50 = v49:GetAttribute("SprinklerType")
						if not v50 then
							v_u_11.Visible = false
							if v_u_15 then
								v_u_30()
							end
							return
						end
						local v51 = v50:gsub("(%l)(%u)", "%1 %2")
						local v52 = v_u_8[v50]
						if v52 then
							local v53 = v_u_14[v52.Rarity or "Common"] or "#FFFFFF"
							v51 = string.format("<font color=\'%s\'>%s</font>", v53, v51)
						end
						v_u_12.Text = v51
						local v54 = v49:GetAttribute("GrowthHealth")
						local v55 = v49:GetAttribute("GrowthMaxHealth")
						local v56 = v49:GetAttribute("GrowthSaveTime")
						if v56 and v55 then
							local v57 = workspace:GetServerTimeNow()
							local v58 = v55 - ((v54 or 0) + (math.floor(v57) - v56))
							local v59 = v_u_28(v58)
							local v60 = v58 / v55
							if v60 <= 0.1 then
								v_u_13.Text = string.format("<font color=\'#FF4444\'>%s</font>", v59)
							elseif v60 <= 0.2 then
								v_u_13.Text = string.format("<font color=\'#FFAA00\'>%s</font>", v59)
							else
								v_u_13.Text = v59
							end
							v_u_13.Visible = true
						else
							v_u_13.Visible = false
						end
						local v61 = v_u_7.ViewportSize
						local v62 = v_u_11.AbsoluteSize
						local v63 = v45.X + 15
						local v64 = v45.Y + 15
						if v63 + v62.X > v61.X then
							v63 = v45.X - v62.X - 15
						end
						if v64 + v62.Y > v61.Y then
							v64 = v45.Y - v62.Y - 15
						end
						local v65 = v61.X - v62.X
						local v66 = math.clamp(v63, 0, v65)
						local v67 = v61.Y - v62.Y
						local v68 = math.clamp(v64, 0, v67)
						v_u_11.Position = UDim2.fromOffset(v66, v68)
						v_u_11.Visible = true
						if v49 ~= v_u_15 then
							v_u_30()
							v_u_15 = v49
							v_u_44(v49)
							return
						end
					else
						v_u_11.Visible = false
						if v_u_15 then
							v_u_30()
						end
					end
				else
					v_u_11.Visible = false
					if v_u_15 then
						v_u_30()
					end
				end
			end
			v2.Heartbeat:Connect(v69)
		else
			warn("[SprinklerHoverController] Missing tooltip elements - tooltip disabled")
		end
	else
		warn("[SprinklerHoverController] TooltipFrame not found - tooltip disabled")
		return
	end
else
	return
end