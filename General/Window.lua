local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function e(component, props, children)
	local element = Instance.new(component)
	for key, value in pairs(props) do
		element[key] = value
	end
	if children ~= nil then
		for key, child in pairs(children) do
			child.Name = key
			child.Parent = element
		end
	end
	return element
end

local Label = {}
Label.__index = Label

function Label.new(theme, text)
	local self = setmetatable({}, Label)
	self.Instance = e("Frame", {
		Name = text,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 2,
	}, {
		Title = e("TextLabel", {
			Font = Enum.Font.Gotham,
			Text = text,
			TextColor3 = theme.TextColor,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}),

		Container = e("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromOffset(150, 22),
			ZIndex = 2,
		}),
	})
	self.TextLabel = self.Instance.Title

	return self
end

function Label:SetText(text)
	self.TextLabel.Text = text
end

function Label:GetText()
	return self.TextLabel.Text
end

local Button = {}
Button.__index = Button

function Button.new(theme, text, buttonText)
	local self = setmetatable({}, Button)
	text = text
	buttonText = buttonText or "Button"

	self.Instance = e("Frame", {
		Name = text,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 2,
	}, {
		Title = e("TextLabel", {
			Font = Enum.Font.Gotham,
			Text = text,
			TextColor3 = theme.TextColor,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}),

		Container = e("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromOffset(150, 22),
			ZIndex = 2,
		}, {
			Background = e("ImageLabel", {
				Image = "rbxassetid://3570695787",
				ImageColor3 = theme.ButtonBackground,
				ImageTransparency = 0.5,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.02,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}),

			Button = e("TextButton", {
				Text = buttonText,
				Font = Enum.Font.Gotham,
				TextColor3 = theme.TextColor,
				TextSize = 13,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}),
		}),
	})
	self.TextLabel = self.Instance.Title
	self.TextButton = self.Instance.Container.Button
	self.Background = self.Instance.Container.Background

	self.Activated = self.TextButton.MouseButton1Up

	self.TextButton.MouseEnter:Connect(function()
		TweenService:Create(self.Background, TweenInfo.new(0.2), { ImageColor3 = theme.ButtonBackgroundHover }):Play()
	end)
	self.TextButton.MouseLeave:Connect(function()
		TweenService:Create(self.Background, TweenInfo.new(0.2), { ImageColor3 = theme.ButtonBackground }):Play()
	end)
	self.TextButton.MouseButton1Down:Connect(function()
		TweenService:Create(self.Background, TweenInfo.new(0.2), { ImageColor3 = theme.ButtonBackgroundDown }):Play()
	end)
	self.TextButton.MouseButton1Up:Connect(function()
		TweenService:Create(self.Background, TweenInfo.new(0.2), { ImageColor3 = theme.ButtonBackground }):Play()
	end)

	return self
end

function Button:SetText(text)
	self.TextLabel.Text = text
end

function Button:SetButtonText(buttonText)
	self.TextButton.Text = buttonText
end

function Button:GetText()
	return self.TextLabel.Text
end

function Button:GetButtonText()
	return self.TextButton.Text
end

local TextBox = {}
TextBox.__index = TextBox

function TextBox.new(theme, text, placeholderText, initialState)
	local self = setmetatable({}, TextBox)
	self.Value = initialState or ""

	self.Instance = e("Frame", {
		Name = text,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 2,
	}, {
		Title = e("TextLabel", {
			Font = Enum.Font.Gotham,
			Text = text,
			TextColor3 = theme.TextColor,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}),

		Container = e("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromOffset(150, 22),
			ZIndex = 2,
		}, {
			Background = e("ImageLabel", {
				Image = "rbxassetid://3570695787",
				ImageColor3 = theme.TextboxBackground,
				ImageTransparency = 0.5,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.02,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}),

			Textbox = e("TextBox", {
				ClearTextOnFocus = false,
				Font = Enum.Font.Gotham,
				PlaceholderText = placeholderText or "Text",
				Text = self.Value,
				TextColor3 = theme.TextboxText,
				PlaceholderColor3 = theme.TextboxPlaceholder,
				TextSize = 13,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}),
		}),
	})

	self.TextLabel = self.Instance.Title
	self.Background = self.Instance.Container.Background
	self.Textbox = self.Instance.Container.Textbox

	self.Background.MouseEnter:Connect(function()
		TweenService:Create(self.Textbox, TweenInfo.new(0.1), { TextColor3 = theme.TextboxTextHover }):Play()
	end)
	self.Background.MouseLeave:Connect(function()
		TweenService:Create(self.Textbox, TweenInfo.new(0.1), { TextColor3 = theme.TextboxText }):Play()
	end)
	self.Textbox.Focused:Connect(function()
		TweenService:Create(self.Background, TweenInfo.new(0.2), { ImageColor3 = theme.TextboxBackgroundHover }):Play()
	end)
	self.Textbox.FocusLost:Connect(function()
		TweenService:Create(self.Background, TweenInfo.new(0.2), { ImageColor3 = theme.TextboxBackground }):Play()
		TweenService:Create(self.Textbox, TweenInfo.new(0.1), { TextColor3 = theme.TextboxText }):Play()

		self.Value = self.Textbox.Text
	end)

	self.FocusLost = self.Textbox.FocusLost

	return self
end

function TextBox:GetValue()
	return self.Value
end

function TextBox:GetText()
	return self.TextLabel.Text
end

function TextBox:SetText(text)
	self.TextLabel.Text = text
end

function TextBox:SetValue(text)
	self.Value = text
	self.Instance.Textbox.Text = self.Value
end

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(theme, text, initialState)
	local self = setmetatable({}, Toggle)
	self.State = initialState or false
	self.Theme = theme

	self.Instance = e("Frame", {
		Name = text,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 2,
	}, {
		Toggled = e("BindableEvent", {}),

		Title = e("TextLabel", {
			Font = Enum.Font.Gotham,
			Text = text,
			TextColor3 = theme.TextColor,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		}),

		Container = e("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromOffset(150, 22),
			ZIndex = 2,
		}, {
			Outer = e("ImageLabel", {
				Image = "rbxassetid://3570695787",
				ImageColor3 = theme.ToggleOuter,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.06,
				AnchorPoint = Vector2.new(1, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(1, 0.5),
				Size = UDim2.fromOffset(20, 20),
				ZIndex = 2,
			}, {
				ToggleButton = e("ImageButton", {
					Image = "rbxassetid://3570695787",
					ImageColor3 = theme.ToggleInner,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(100, 100, 100, 100),
					SliceScale = 0.04,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(14, 14),
					ZIndex = 2,
				}),
			}),
		}),
	})

	self.TextLabel = self.Instance.Title
	self.Outer = self.Instance.Container.Outer
	self.Toggle = self.Outer.ToggleButton

	self.ToggledInstance = self.Instance.Toggled
	self.Toggled = self.ToggledInstance.Event

	if self.State then
		TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = theme.checkbox_checked }):Play()
		TweenService:Create(self.Toggle, TweenInfo.new(0.2), { ImageColor3 = theme.checkbox_checked }):Play()
	end

	self.Toggle.MouseEnter:Connect(function()
		local lighterTheme = Color3.fromRGB(
			(theme.ToggleOuter.R * 255) + 20,
			(theme.ToggleOuter.G * 255) + 20,
			(theme.ToggleOuter.B * 255) + 20
		)
		TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = lighterTheme }):Play()
	end)
	self.Toggle.MouseLeave:Connect(function()
		if not self.State then
			TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleOuter }):Play()
		else
			TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleToggled }):Play()
		end
	end)
	self.Toggle.MouseButton1Down:Connect(function()
		if self.State then
			TweenService:Create(self.Toggle, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleOuter }):Play()
		else
			TweenService:Create(self.Toggle, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleToggled }):Play()
		end
	end)
	self.Toggle.MouseButton1Up:Connect(function()
		self.State = not self.State
		self.ToggledInstance:Fire(self.State)

		if self.State then
			TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleToggled }):Play()
		else
			TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleOuter }):Play()
			TweenService:Create(self.Toggle, TweenInfo.new(0.2), { ImageColor3 = theme.ToggleInner }):Play()
		end
	end)

	return self
end

function Toggle:GetState()
	return self.State
end

function Toggle:GetText()
	return self.TextLabel.Text
end

function Toggle:SetState(state)
	self.State = state
	self.ToggledInstance:Fire(self.State)

	if self.State then
		TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = self.Theme.ToggleOuter }):Play()
		TweenService:Create(self.Toggle, TweenInfo.new(0.2), { ImageColor3 = self.Theme.ToggleInner }):Play()
	else
		TweenService:Create(self.Outer, TweenInfo.new(0.2), { ImageColor3 = self.Theme.ToggleToggled }):Play()
		TweenService:Create(self.Toggle, TweenInfo.new(0.2), { ImageColor3 = self.Theme.ToggleToggled }):Play()
	end
end

function Toggle:SetText(text)
	self.TextLabel.Text = text
end

local Section = {}
Section.__index = Section

function Section.new(theme, sectionName)
	local self = setmetatable({}, Section)
	self.Theme = theme
	self.SectionName = sectionName
	self.Elements = 1

	self.Instance = e("Frame", {
		Name = sectionName,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 25),
		ZIndex = 2,
	}, {
		Container = e("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 22),
			Size = UDim2.new(1, 0, 0, 50),
			ZIndex = 2,
		}, {
			UIListLayout = e("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}),

		Title = e("TextLabel", {
			Font = Enum.Font.GothamMedium,
			Text = self.SectionName,
			TextColor3 = Color3.fromRGB(206, 206, 206),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -5, 0, 25),
			ZIndex = 2,
		}),
	})

	self.Content = self.Instance.Container
	self.Title = self.Instance.Title

	return self
end

function Section:SetName(sectionName)
	self.SectionName = sectionName
	self.Title = self.SectionName
end

function Section:RecalculateSize()
	self.Instance.Size = UDim2.new(1, 0, 0, self.Elements * 25)
end

function Section:CreateLabel(text)
	local object = Label.new(self.Theme, text)
	object.Instance.Parent = self.Content

	self.Elements += 1
	self:RecalculateSize()
	return object
end

function Section:CreateButton(text, buttonText)
	local object = Button.new(self.Theme, text, buttonText)
	object.Instance.Parent = self.Content

	self.Elements += 1
	self:RecalculateSize()
	return object
end

function Section:CreateTextbox(text, placeholderText, initialState)
	local object = TextBox.new(self.Theme, text, placeholderText, initialState)
	object.Instance.Parent = self.Content

	self.Elements += 1
	self:RecalculateSize()
	return object
end

function Section:CreateToggle(text, initialState)
	local object = Toggle.new(self.Theme, text, initialState)
	object.Instance.Parent = self.Content

	self.Elements += 1
	self:RecalculateSize()
	return object
end

--[[
function Section:CreateSlider() end

function Section:CreateDropdown() end

function Section:CreateKeybind() end
]]

function Section:Mount(parent)
	self.Instance.Parent = parent
end

local Category = {}
Category.__index = Category

function Category.new(window, name)
	local self = setmetatable({}, Category)
	self.Window = window
	self.Name = name
	self.Theme = window:GetTheme()

	self.Button = e("TextButton", {
		Name = name,
		Text = name,
		Font = Enum.Font.GothamMedium,
		TextColor3 = self.Theme.TextColor,
		TextSize = 14,
		AutoButtonColor = false,
		BackgroundColor3 = self.Theme.CategoryButtonBackground,
		BackgroundTransparency = 1,
		BorderColor3 = self.Theme.CategoryButtonBorder,
		BorderMode = Enum.BorderMode.Inset,
		Size = UDim2.new(1, -4, 0, 25),
		ZIndex = 2,
	})

	self.Instance = e("ScrollingFrame", {
		Name = self.Name,
		ScrollBarImageColor3 = self.Theme.ScrollbarColor,
		TopImage = "rbxassetid://967852042",
		MidImage = "rbxassetid://967852042",
		BottomImage = "rbxassetid://967852042",
		CanvasSize = UDim2.fromOffset(0, 255),
		ScrollBarThickness = 4,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Visible = true,
		ZIndex = 2,
	}, {
		Container = e("Frame", {
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 3),
			Size = UDim2.new(1, -20, 1, -3),
			ZIndex = 2,
		}, {
			UIListLayout = e("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		}),

		Hider = e("Frame", {
			BackgroundColor3 = Color3.fromRGB(32, 32, 33),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 5,
		}),
	})
	self.Content = self.Instance.Container
	self.Hider = self.Instance.Hider

	self.Button.MouseEnter:Connect(function()
		TweenService:Create(self.Button, TweenInfo.new(0.2), { BackgroundTransparency = 0.5 }):Play()
	end)

	self.Button.MouseLeave:Connect(function()
		TweenService:Create(self.Button, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
	end)

	self.Button.MouseButton1Down:Connect(function()
		TweenService:Create(self.Button, TweenInfo.new(0.2), { BackgroundTransparency = 0.2 }):Play()
		TweenService:Create(self.Hider, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
		TweenService:Create(self.Instance, TweenInfo.new(0.3), { ScrollBarImageTransparency = 0 }):Play()

		self.Window:SelectCategory(self.Name)
	end)

	self.Button.MouseButton1Up:Connect(function()
		TweenService:Create(self.Button, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
	end)

	return self
end

function Category:SetName(name)
	self.Name = name
	self.Instance.Name = self.Name
end

function Category:CreateSection(sectionName)
	local section = Section.new(self.Theme, sectionName)
	section:Mount(self.Content)
	return section
end

function Category:Mount(parent, buttonParent)
	self.Instance.Parent = parent
	self.Button.Parent = buttonParent
end

local Window = {}
Window.__index = Window
Window.LIGHT = {
	Size = UDim2.fromOffset(500, 500),
	TextColor = Color3.fromRGB(96, 96, 96),

	MainContainer = Color3.fromRGB(249, 249, 255),
	Separator = Color3.fromRGB(223, 219, 228),

	CategoryButtonBackground = Color3.fromRGB(223, 219, 228),
	CategoryButtonBorder = Color3.fromRGB(200, 196, 204),

	ToggleToggled = Color3.fromRGB(114, 214, 112),
	ToggleOuter = Color3.fromRGB(198, 189, 202),
	ToggleInner = Color3.fromRGB(249, 239, 255),

	SliderColor = Color3.fromRGB(114, 214, 112),
	SliderColorSliding = Color3.fromRGB(114, 214, 112),
	SliderBackground = Color3.fromRGB(198, 188, 202),
	SliderText = Color3.fromRGB(112, 112, 112),

	TextboxBackground = Color3.fromRGB(198, 189, 202),
	TextboxBackgroundHover = Color3.fromRGB(215, 206, 227),
	TextboxText = Color3.fromRGB(112, 112, 112),
	TextboxTextHover = Color3.fromRGB(50, 50, 50),
	TextboxPlaceholder = Color3.fromRGB(178, 178, 178),

	DropdownBackground = Color3.fromRGB(198, 189, 202),
	DropdownText = Color3.fromRGB(112, 112, 112),
	DropdownTextHover = Color3.fromRGB(50, 50, 50),
	DropdownScrollbarColor = Color3.fromRGB(198, 189, 202),

	ButtonText = Color3.fromRGB(112, 112, 112),
	ButtonBackground = Color3.fromRGB(198, 189, 202),
	ButtonBackgroundHover = Color3.fromRGB(215, 206, 227),
	ButtonBackgroundDown = Color3.fromRGB(178, 169, 182),

	ScrollbarColor = Color3.fromRGB(198, 189, 202),
}
Window.DARK = {
	Size = UDim2.fromOffset(500, 500),
	TextColor = Color3.fromRGB(206, 206, 206),

	MainContainer = Color3.fromRGB(32, 32, 33),
	Separator = Color3.fromRGB(63, 63, 65),

	CategoryButtonBackground = Color3.fromRGB(63, 62, 65),
	CategoryButtonBorder = Color3.fromRGB(72, 71, 74),

	ToggleToggled = Color3.fromRGB(132, 255, 130),
	ToggleOuter = Color3.fromRGB(84, 81, 86),
	ToggleInner = Color3.fromRGB(132, 132, 136),

	SliderColor = Color3.fromRGB(177, 177, 177),
	SliderColorSliding = Color3.fromRGB(132, 255, 130),
	SliderBackground = Color3.fromRGB(88, 84, 90),
	SliderText = Color3.fromRGB(177, 177, 177),

	TextboxBackground = Color3.fromRGB(103, 103, 106),
	TextboxBackgroundHover = Color3.fromRGB(137, 137, 141),
	TextboxText = Color3.fromRGB(195, 195, 195),
	TextboxTextHover = Color3.fromRGB(232, 232, 232),
	TextboxPlaceholder = Color3.fromRGB(135, 135, 138),

	DropdownBackground = Color3.fromRGB(88, 88, 91),
	DropdownText = Color3.fromRGB(195, 195, 195),
	DropdownTextHover = Color3.fromRGB(232, 232, 232),
	DropdownScrollbarColor = Color3.fromRGB(118, 118, 121),

	ButtonText = Color3.fromRGB(195, 195, 195),
	ButtonBackground = Color3.fromRGB(103, 103, 106),
	ButtonBackgroundHover = Color3.fromRGB(137, 137, 141),
	ButtonBackgroundDown = Color3.fromRGB(70, 70, 81),

	ScrollbarColor = Color3.fromRGB(118, 118, 121),
}

function Window.new(title, theme, toggleKey)
	local self = setmetatable({}, Window)
	self.Title = title
	self.Theme = theme
	self.ToggleKey = toggleKey
	self.FirstCategory = nil

	self.ScreenGui = e("ScreenGui", {
		Name = title,
		Enabled = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	}, {
		Window = e("ImageLabel", {
			Size = self.Theme.Size,
			BackgroundColor3 = self.Theme.MainContainer,
			ImageTransparency = 1,
			Active = true,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			ZIndex = 2,
		}, {
			ContentFrame = e("Frame", {
				AnchorPoint = Vector2.new(1, 0),
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				Position = UDim2.new(1, 0, 0, 30),
				Size = UDim2.new(1, -120, 1, -30),
				ZIndex = 2,
			}, {
				UIPageLayout = e("UIPageLayout", {
					EasingDirection = Enum.EasingDirection.InOut,
					EasingStyle = Enum.EasingStyle.Quad,
					Padding = UDim.new(0, 10),
					TweenTime = 0.7,
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			}),

			Sidebar = e("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(0, 30),
				Size = UDim2.new(0, 120, 1, -30),
				ZIndex = 2,
			}, {
				UIPadding = e("UIPadding", {
					PaddingLeft = UDim.new(0, 2),
					PaddingTop = UDim.new(0, 3),
				}),

				UIListLayout = e("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
			}),

			Topbar = e("Frame", {
				BackgroundTransparency = 2,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
			}, {
				TitleLabel = e("TextLabel", {
					Font = Enum.Font.GothamMedium,
					Text = title,
					TextColor3 = self.Theme.TextColor,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(30, 0),
					Size = UDim2.new(1, -30, 0, 30),
					ZIndex = 2,
				}),
			}),

			Shadow = e("ImageLabel", {
				Image = "rbxassetid://1316045217",
				ImageColor3 = Color3.fromRGB(35, 35, 35),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(10, 10, 118, 118),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 4),
				Size = UDim2.new(1, 6, 1, 6),
			}),

			SideSeparator = e("Frame", {
				BackgroundColor3 = self.Theme.Separator,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(118, 30),
				Size = UDim2.new(0, 1, 1, -30),
				ZIndex = 6,
			}),

			TopSeparator = e("Frame", {
				BackgroundColor3 = self.Theme.Separator,
				BorderSizePixel = 0,
				Position = UDim2.fromOffset(0, 30),
				Size = UDim2.new(1, 0, 0, 1),
				ZIndex = 6,
			}),
		}),
	})

	self.Window = self.ScreenGui.Window
	self.Content = self.Window.ContentFrame
	self.Sidebar = self.Window.Sidebar
	self.PageLayout = self.Content.UIPageLayout

	self.Visible = true

	UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
		if gameProcessedEvent then
			return
		end

		if input.KeyCode == self.ToggleKey then
			self:SetVisible(not self.Visible)
		end
	end)

	return self
end

function Window:GetTheme()
	return self.Theme
end

function Window:SetVisible(visible)
	self.Visible = visible

	if self.Visible then
		self.Window:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Sine", 0.5, true)
	else
		self.Window:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Sine", 0.5, true)
	end
end

function Window:CreateCategory(categoryName)
	local category = Category.new(self, categoryName)
	if self.FirstCategory == nil then
		self.FirstCategory = categoryName
	end

	category:Mount(self.Content, self.Sidebar)
	return category
end

function Window:SelectCategory(categoryName)
	local content = self.Content
	local thisCategory = content[categoryName]

	for _, category in ipairs(content:GetChildren()) do
		if category:IsA("ScrollingFrame") and category ~= thisCategory then
			TweenService:Create(category.Hider, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()
			TweenService:Create(category, TweenInfo.new(0.3), { ScrollBarImageTransparency = 1 }):Play()
		end
	end

	self.PageLayout:JumpTo(thisCategory)
end

function Window:Mount(parent)
	if parent == nil then
		parent = game:GetService("RunService"):IsStudio() and game:GetService("Players").LocalPlayer.PlayerGui
			or CoreGui
	end

	self:SelectCategory(self.FirstCategory)
	self.FirstCategory = nil
	self.ScreenGui.Parent = parent
end

function Window:Destroy()
	self.Instance:Destroy()
end

return Window
