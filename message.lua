-- [[ ScriptHub UI Framework - Comprehensive Unified Luau Script ]]
-- Target Environment: Roblox CoreGui / PlayerGui (Executor Environment)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Safe GUI Parent container initialization
local parentContainer = CoreGui
pcall(function()
	if syn and syn.protect_gui then
		local s = Instance.new("ScreenGui")
		syn.protect_gui(s)
		s.Parent = CoreGui
		s.Name = "ScriptHubProtected"
		parentContainer = s
	elseif gethui then
		local s = Instance.new("ScreenGui")
		s.Parent = gethui()
		s.Name = "ScriptHubHui"
		parentContainer = s
	else
		local s = Instance.new("ScreenGui")
		s.Parent = PlayerGui
		s.Name = "ScriptHubPlayerGui"
		parentContainer = s
	end
end)

-- Theme Configuration (Neon Purple & Deep Dark Theme)
local Theme = {
	Background = Color3.fromRGB(8, 10, 16),
	Sidebar = Color3.fromRGB(5, 7, 12),
	CardBg = Color3.fromRGB(13, 17, 26),
	Accent = Color3.fromRGB(160, 60, 240), -- Neon Purple
	AccentHover = Color3.fromRGB(185, 95, 255),
	Text = Color3.fromRGB(240, 245, 255),
	SubText = Color3.fromRGB(140, 150, 170),
	Outline = Color3.fromRGB(30, 40, 60),
	ToggleOff = Color3.fromRGB(40, 50, 70),
	ToggleOn = Color3.fromRGB(160, 60, 240),
}

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptHubMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentContainer

-- Main Application Window Frame (Expanded Large & Wide: 820x600)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 820, 0, 600)
MainFrame.Position = UDim2.new(0.5, -410, 0.5, -300)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Outline
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Background Image Overlay (Asset ID: 10110319532 - Transparent Anime Girl)
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Name = "BackgroundImageOverlay"
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://10110319532"
BackgroundImage.ImageTransparency = 0.18
BackgroundImage.ScaleType = Enum.ScaleType.Fit
BackgroundImage.ZIndex = 1
BackgroundImage.Parent = MainFrame

-- Left Navigation Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 2
Sidebar.Parent = MainFrame

local SidebarDivider = Instance.new("Frame")
SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
SidebarDivider.Position = UDim2.new(1, 0, 0, 0)
SidebarDivider.BackgroundColor3 = Theme.Outline
SidebarDivider.BorderSizePixel = 0
SidebarDivider.ZIndex = 3
SidebarDivider.Parent = Sidebar

-- Brand / Logo Header on Sidebar
local BrandContainer = Instance.new("Frame")
BrandContainer.Size = UDim2.new(1, 0, 0, 75)
BrandContainer.BackgroundTransparency = 1
BrandContainer.ZIndex = 3
BrandContainer.Parent = Sidebar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 30)
LogoText.Position = UDim2.new(0, 0, 0, 15)
LogoText.BackgroundTransparency = 1
LogoText.Font = Enum.Font.GothamBold
LogoText.Text = "SH"
LogoText.TextColor3 = Theme.Accent
LogoText.TextSize = 28
LogoText.ZIndex = 3
LogoText.Parent = BrandContainer

local SubLogoText = Instance.new("TextLabel")
SubLogoText.Size = UDim2.new(1, 0, 0, 15)
SubLogoText.Position = UDim2.new(0, 0, 0, 48)
SubLogoText.BackgroundTransparency = 1
SubLogoText.Font = Enum.Font.Gotham
SubLogoText.Text = "SCRIPTHUB"
SubLogoText.TextColor3 = Theme.SubText
SubLogoText.TextSize = 10
SubLogoText.ZIndex = 3
SubLogoText.Parent = BrandContainer

-- Main Content Area Container
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -160, 1, 0)
ContentArea.Position = UDim2.new(0, 160, 0, 0)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 2
ContentArea.Parent = MainFrame

-- Top Header Breadcrumbs & Search
local TopHeader = Instance.new("Frame")
TopHeader.Size = UDim2.new(1, 0, 0, 75)
TopHeader.BackgroundTransparency = 1
TopHeader.ZIndex = 3
TopHeader.Parent = ContentArea

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0, 350, 0, 24)
HeaderTitle.Position = UDim2.new(0, 24, 0, 15)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.Text = "Combat"
HeaderTitle.TextColor3 = Theme.Text
HeaderTitle.TextSize = 20
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.ZIndex = 3
HeaderTitle.Parent = TopHeader

local HeaderDesc = Instance.new("TextLabel")
HeaderDesc.Size = UDim2.new(0, 480, 0, 16)
HeaderDesc.Position = UDim2.new(0, 24, 0, 44)
HeaderDesc.BackgroundTransparency = 1
HeaderDesc.Font = Enum.Font.Gotham
HeaderDesc.Text = "Aim assistance, fire control, weapon handling, feedback, and ragebot."
HeaderDesc.TextColor3 = Theme.SubText
HeaderDesc.TextSize = 11
HeaderDesc.TextXAlignment = Enum.TextXAlignment.Left
HeaderDesc.ZIndex = 3
HeaderDesc.Parent = TopHeader

-- Search Bar Input
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0, 140, 0, 32)
SearchBox.Position = UDim2.new(1, -164, 0, 20)
SearchBox.BackgroundColor3 = Theme.CardBg
SearchBox.BorderColor3 = Theme.Outline
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "Ctrl+F Search..."
SearchBox.Text = ""
SearchBox.TextColor3 = Theme.Text
SearchBox.TextSize = 12
SearchBox.ZIndex = 3
SearchBox.Parent = TopHeader

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

-- Active Pages Container
local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(1, -48, 1, -140)
PagesContainer.Position = UDim2.new(0, 24, 0, 130)
PagesContainer.BackgroundTransparency = 1
PagesContainer.ZIndex = 3
PagesContainer.Parent = ContentArea

-- Helper Function: Create Group Box Card Container
local function createGroupBox(parent, titleText, size, position)
	local box = Instance.new("Frame")
	box.Name = titleText .. "Box"
	box.Size = size
	box.Position = position
	box.BackgroundColor3 = Theme.CardBg
	box.BackgroundTransparency = 0.15
	box.BorderColor3 = Theme.Outline
	box.ZIndex = 3
	box.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = box

	local stroke = Instance.new("UIStroke")
	stroke.Color = Theme.Outline
	stroke.Thickness = 1
	stroke.Parent = box

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -24, 0, 30)
	title.Position = UDim2.new(0, 12, 0, 8)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamBold
	title.Text = titleText
	title.TextColor3 = Theme.Text
	title.TextSize = 13
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.ZIndex = 4
	title.Parent = box

	local container = Instance.new("ScrollingFrame")
	container.Name = "ItemsContainer"
	container.Size = UDim2.new(1, -16, 1, -45)
	container.Position = UDim2.new(0, 8, 0, 38)
	container.BackgroundTransparency = 1
	container.BorderSizePixel = 0
	container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
	container.ScrollBarThickness = 3
	container.ScrollBarImageColor3 = Theme.Accent
	container.ZIndex = 4
	container.Parent = box

	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutIndex
	layout.Padding = UDim.new(0, 10)
	layout.Parent = container

	return box, container
end

-- Sidebar Categories Definition
local categories = {
	{ Name = "Combat", Icon = "rbxassetid://6023426915", Desc = "Aim assistance, fire control, weapon handling, feedback, and ragebot." },
	{ Name = "Visuals", Icon = "rbxassetid://6034818372", Desc = "Player information, crosshair, weapon, camera, and sound visuals." },
	{ Name = "Player", Icon = "rbxassetid://6034509993", Desc = "Movement, character appearance, and identity." },
	{ Name = "Automation", Icon = "rbxassetid://6035047409", Desc = "Match flow, loadouts, in-match automation, and detection." },
	{ Name = "World", Icon = "rbxassetid://6034509993", Desc = "Lighting, post-processing, sky, and ambient sound." },
	{ Name = "Settings", Icon = "rbxassetid://6031265976", Desc = "Menu preferences, config management, and theme customization." },
}

local activeCategory = "Combat"
local categoryButtons = {}
local categoryPages = {}

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.SortOrder = Enum.SortOrder.LayoutIndex
sidebarLayout.Padding = UDim.new(0, 6)
sidebarLayout.Parent = Sidebar

local sidebarPadding = Instance.new("UIPadding")
sidebarPadding.PaddingTop = UDim.new(0, 85)
sidebarPadding.PaddingLeft = UDim.new(0, 12)
sidebarPadding.PaddingRight = UDim.new(0, 12)
sidebarPadding.Parent = Sidebar

for _, cat in ipairs(categories) do
	local btn = Instance.new("TextButton")
	btn.Name = cat.Name .. "Btn"
	btn.Size = UDim2.new(1, 0, 0, 52)
	btn.BackgroundColor3 = (cat.Name == activeCategory) and Theme.CardBg or Color3.fromRGB(0,0,0)
	btn.BackgroundTransparency = (cat.Name == activeCategory) and 0 or 1
	btn.AutoButtonColor = false
	btn.Font = Enum.Font.GothamMedium
	btn.Text = cat.Name
	btn.TextColor3 = (cat.Name == activeCategory) and Theme.Accent or Theme.SubText
	btn.TextSize = 12
	btn.TextYAlignment = Enum.TextYAlignment.Bottom
	btn.ZIndex = 3

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn

	local iconImg = Instance.new("ImageLabel")
	iconImg.Size = UDim2.new(0, 20, 0, 20)
	iconImg.Position = UDim2.new(0.5, -10, 0, 8)
	iconImg.BackgroundTransparency = 1
	iconImg.Image = cat.Icon
	iconImg.ImageColor3 = (cat.Name == activeCategory) and Theme.Accent or Theme.SubText
	iconImg.ZIndex = 3
	iconImg.Parent = btn

	btn.Parent = Sidebar
	categoryButtons[cat.Name] = btn

	-- Category Page
	local page = Instance.new("Frame")
	page.Name = cat.Name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.Visible = (cat.Name == activeCategory)
	page.ZIndex = 3
	page.Parent = PagesContainer

	categoryPages[cat.Name] = page

	btn.MouseButton1Click:Connect(function()
		for _, b in pairs(categoryButtons) do
			b.BackgroundColor3 = Color3.fromRGB(0,0,0)
			b.BackgroundTransparency = 1
			b.TextColor3 = Theme.SubText
			for _, child in pairs(b:GetChildren()) do
				if child:IsA("ImageLabel") then
					child.ImageColor3 = Theme.SubText
				end
			end
		end
		for _, p in pairs(categoryPages) do
			p.Visible = false
		end
		btn.BackgroundColor3 = Theme.CardBg
		btn.BackgroundTransparency = 0
		btn.TextColor3 = Theme.Accent
		iconImg.ImageColor3 = Theme.Accent
		page.Visible = true
		HeaderTitle.Text = cat.Name
		HeaderDesc.Text = cat.Desc
	end)
end

-- ==================== COMBAT TAB SUB-PAGES ====================
local combatPage = categoryPages["Combat"]
local combatSubTabs = {"Aimbot", "Silent Aim", "Ragebot", "Fire Assist", "Weapon Handling", "Hit Feedback"}
local combatSubPages = {}

local combatSubBar = Instance.new("ScrollingFrame")
combatSubBar.Size = UDim2.new(1, 0, 0, 36)
combatSubBar.Position = UDim2.new(0, 0, 0, 0)
combatSubBar.BackgroundTransparency = 1
combatSubBar.CanvasSize = UDim2.new(0, 500, 0, 36)
combatSubBar.ScrollBarThickness = 0
combatSubBar.ZIndex = 3
combatSubBar.Parent = combatPage

local combatSubLayout = Instance.new("UIListLayout")
combatSubLayout.FillDirection = Enum.FillDirection.Horizontal
combatSubLayout.SortOrder = Enum.SortOrder.LayoutIndex
combatSubLayout.Padding = UDim.new(0, 8)
combatSubLayout.Parent = combatSubBar

local combatPagesParent = Instance.new("Frame")
combatPagesParent.Size = UDim2.new(1, 0, 1, -44)
combatPagesParent.Position = UDim2.new(0, 0, 0, 44)
combatPagesParent.BackgroundTransparency = 1
combatPagesParent.ZIndex = 3
combatPagesParent.Parent = combatPage

for i, subName in ipairs(combatSubTabs) do
	local subBtn = Instance.new("TextButton")
	subBtn.Size = UDim2.new(0, 100, 0, 32)
	subBtn.BackgroundColor3 = (i == 1) and Theme.CardBg or Color3.fromRGB(0,0,0)
	subBtn.BackgroundTransparency = (i == 1) and 0 or 1
	subBtn.Font = Enum.Font.GothamMedium
	subBtn.Text = subName
	subBtn.TextColor3 = (i == 1) and Theme.Accent or Theme.SubText
	subBtn.TextSize = 12
	subBtn.ZIndex = 4
	subBtn.Parent = combatSubBar

	local subCorner = Instance.new("UICorner")
	subCorner.CornerRadius = UDim.new(0, 6)
	subCorner.Parent = subBtn

	local subPage = Instance.new("Frame")
	subPage.Size = UDim2.new(1, 0, 1, 0)
	subPage.BackgroundTransparency = 1
	subPage.Visible = (i == 1)
	subPage.ZIndex = 3
	subPage.Parent = combatPagesParent
	combatSubPages[subName] = subPage

	subBtn.MouseButton1Click:Connect(function()
		for _, b in pairs(combatSubBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(0,0,0)
				b.BackgroundTransparency = 1
				b.TextColor3 = Theme.SubText
			end
		end
		for _, p in pairs(combatSubPages) do
			p.Visible = false
		end
		subBtn.BackgroundColor3 = Theme.CardBg
		subBtn.BackgroundTransparency = 0
		subBtn.TextColor3 = Theme.Accent
		subPage.Visible = true
	end)

	-- Populate Combat Sub-Tabs with Group Boxes
	if subName == "Aimbot" then
		createGroupBox(subPage, "Targeting", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Targeting FOV", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Silent Aim" then
		createGroupBox(subPage, "Manipulate", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Hit Correction", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Ragebot" then
		createGroupBox(subPage, "Activation", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Evasion", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Fire Assist" then
		createGroupBox(subPage, "Triggerbot", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Flickbot", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Weapon Handling" then
		createGroupBox(subPage, "Aim & Fire", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Melee & Grenades", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Hit Feedback" then
		createGroupBox(subPage, "Hit Feedback", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Elimination Feedback", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	end
end

-- ==================== VISUALS TAB SUB-PAGES ====================
local visualsPage = categoryPages["Visuals"]
local visualsSubTabs = {"Player ESP", "Crosshair", "Weapon Visuals", "Camera & Screen", "Sound ESP"}
local visualsSubPages = {}

local visualsSubBar = Instance.new("ScrollingFrame")
visualsSubBar.Size = UDim2.new(1, 0, 0, 36)
visualsSubBar.Position = UDim2.new(0, 0, 0, 0)
visualsSubBar.BackgroundTransparency = 1
visualsSubBar.CanvasSize = UDim2.new(0, 500, 0, 36)
visualsSubBar.ScrollBarThickness = 0
visualsSubBar.ZIndex = 3
visualsSubBar.Parent = visualsPage

local visualsSubLayout = Instance.new("UIListLayout")
visualsSubLayout.FillDirection = Enum.FillDirection.Horizontal
visualsSubLayout.SortOrder = Enum.SortOrder.LayoutIndex
visualsSubLayout.Padding = UDim.new(0, 8)
visualsSubLayout.Parent = visualsSubBar

local visualsPagesParent = Instance.new("Frame")
visualsPagesParent.Size = UDim2.new(1, 0, 1, -44)
visualsPagesParent.Position = UDim2.new(0, 0, 0, 44)
visualsPagesParent.BackgroundTransparency = 1
visualsPagesParent.ZIndex = 3
visualsPagesParent.Parent = visualsPage

for i, subName in ipairs(visualsSubTabs) do
	local subBtn = Instance.new("TextButton")
	subBtn.Size = UDim2.new(0, 110, 0, 32)
	subBtn.BackgroundColor3 = (i == 1) and Theme.CardBg or Color3.fromRGB(0,0,0)
	subBtn.BackgroundTransparency = (i == 1) and 0 or 1
	subBtn.Font = Enum.Font.GothamMedium
	subBtn.Text = subName
	subBtn.TextColor3 = (i == 1) and Theme.Accent or Theme.SubText
	subBtn.TextSize = 12
	subBtn.ZIndex = 4
	subBtn.Parent = visualsSubBar

	local subCorner = Instance.new("UICorner")
	subCorner.CornerRadius = UDim.new(0, 6)
	subCorner.Parent = subBtn

	local subPage = Instance.new("Frame")
	subPage.Size = UDim2.new(1, 0, 1, 0)
	subPage.BackgroundTransparency = 1
	subPage.Visible = (i == 1)
	subPage.ZIndex = 3
	subPage.Parent = visualsPagesParent
	visualsSubPages[subName] = subPage

	subBtn.MouseButton1Click:Connect(function()
		for _, b in pairs(visualsSubBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(0,0,0)
				b.BackgroundTransparency = 1
				b.TextColor3 = Theme.SubText
			end
		end
		for _, p in pairs(visualsSubPages) do
			p.Visible = false
		end
		subBtn.BackgroundColor3 = Theme.CardBg
		subBtn.BackgroundTransparency = 0
		subBtn.TextColor3 = Theme.Accent
		subPage.Visible = true
	end)

	if subName == "Player ESP" then
		createGroupBox(subPage, "Player ESP", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Text & Flags", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Crosshair" then
		createGroupBox(subPage, "Crosshair", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Motion & Effects", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Weapon Visuals" then
		createGroupBox(subPage, "Viewmodel Position", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Arms & Chams", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Camera & Screen" then
		createGroupBox(subPage, "Third Person", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Gameplay Overlays", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Sound ESP" then
		createGroupBox(subPage, "Activation & Filtering", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Footsteps", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	end
end

-- ==================== PLAYER TAB SUB-PAGES ====================
local playerPage = categoryPages["Player"]
local playerSubTabs = {"Movement", "Movement Recorder", "Character", "Identity Spoofing"}
local playerSubPages = {}

local playerSubBar = Instance.new("ScrollingFrame")
playerSubBar.Size = UDim2.new(1, 0, 0, 36)
playerSubBar.Position = UDim2.new(0, 0, 0, 0)
playerSubBar.BackgroundTransparency = 1
playerSubBar.CanvasSize = UDim2.new(0, 500, 0, 36)
playerSubBar.ScrollBarThickness = 0
playerSubBar.ZIndex = 3
playerSubBar.Parent = playerPage

local playerSubLayout = Instance.new("UIListLayout")
playerSubLayout.FillDirection = Enum.FillDirection.Horizontal
playerSubLayout.SortOrder = Enum.SortOrder.LayoutIndex
playerSubLayout.Padding = UDim.new(0, 8)
playerSubLayout.Parent = playerSubBar

local playerPagesParent = Instance.new("Frame")
playerPagesParent.Size = UDim2.new(1, 0, 1, -44)
playerPagesParent.Position = UDim2.new(0, 0, 0, 44)
playerPagesParent.BackgroundTransparency = 1
playerPagesParent.ZIndex = 3
playerPagesParent.Parent = playerPage

for i, subName in ipairs(playerSubTabs) do
	local subBtn = Instance.new("TextButton")
	subBtn.Size = UDim2.new(0, 120, 0, 32)
	subBtn.BackgroundColor3 = (i == 1) and Theme.CardBg or Color3.fromRGB(0,0,0)
	subBtn.BackgroundTransparency = (i == 1) and 0 or 1
	subBtn.Font = Enum.Font.GothamMedium
	subBtn.Text = subName
	subBtn.TextColor3 = (i == 1) and Theme.Accent or Theme.SubText
	subBtn.TextSize = 12
	subBtn.ZIndex = 4
	subBtn.Parent = playerSubBar

	local subCorner = Instance.new("UICorner")
	subCorner.CornerRadius = UDim.new(0, 6)
	subCorner.Parent = subBtn

	local subPage = Instance.new("Frame")
	subPage.Size = UDim2.new(1, 0, 1, 0)
	subPage.BackgroundTransparency = 1
	subPage.Visible = (i == 1)
	subPage.ZIndex = 3
	subPage.Parent = playerPagesParent
	playerSubPages[subName] = subPage

	subBtn.MouseButton1Click:Connect(function()
		for _, b in pairs(playerSubBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(0,0,0)
				b.BackgroundTransparency = 1
				b.TextColor3 = Theme.SubText
			end
		end
		for _, p in pairs(playerSubPages) do
			p.Visible = false
		end
		subBtn.BackgroundColor3 = Theme.CardBg
		subBtn.BackgroundTransparency = 0
		subBtn.TextColor3 = Theme.Accent
		subPage.Visible = true
	end)

	if subName == "Movement" then
		createGroupBox(subPage, "Ground", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Air", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Movement Recorder" then
		createGroupBox(subPage, "Recorder", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Playback Alignment", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Character" then
		createGroupBox(subPage, "Animation Player", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Character Appearance", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Identity Spoofing" then
		createGroupBox(subPage, "Device Spoof", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Local Player", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	end
end

-- ==================== AUTOMATION TAB SUB-PAGES ====================
local autoPage = categoryPages["Automation"]
local autoSubTabs = {"Match Flow", "Auto Loadout", "In-Match Automation", "Detection"}
local autoSubPages = {}

local autoSubBar = Instance.new("ScrollingFrame")
autoSubBar.Size = UDim2.new(1, 0, 0, 36)
autoSubBar.Position = UDim2.new(0, 0, 0, 0)
autoSubBar.BackgroundTransparency = 1
autoSubBar.CanvasSize = UDim2.new(0, 500, 0, 36)
autoSubBar.ScrollBarThickness = 0
autoSubBar.ZIndex = 3
autoSubBar.Parent = autoPage

local autoSubLayout = Instance.new("UIListLayout")
autoSubLayout.FillDirection = Enum.FillDirection.Horizontal
autoSubLayout.SortOrder = Enum.SortOrder.LayoutIndex
autoSubLayout.Padding = UDim.new(0, 8)
autoSubLayout.Parent = autoSubBar

local autoPagesParent = Instance.new("Frame")
autoPagesParent.Size = UDim2.new(1, 0, 1, -44)
autoPagesParent.Position = UDim2.new(0, 0, 0, 44)
autoPagesParent.BackgroundTransparency = 1
autoPagesParent.ZIndex = 3
autoPagesParent.Parent = autoPage

for i, subName in ipairs(autoSubTabs) do
	local subBtn = Instance.new("TextButton")
	subBtn.Size = UDim2.new(0, 130, 0, 32)
	subBtn.BackgroundColor3 = (i == 1) and Theme.CardBg or Color3.fromRGB(0,0,0)
	subBtn.BackgroundTransparency = (i == 1) and 0 or 1
	subBtn.Font = Enum.Font.GothamMedium
	subBtn.Text = subName
	subBtn.TextColor3 = (i == 1) and Theme.Accent or Theme.SubText
	subBtn.TextSize = 12
	subBtn.ZIndex = 4
	subBtn.Parent = autoSubBar

	local subCorner = Instance.new("UICorner")
	subCorner.CornerRadius = UDim.new(0, 6)
	subCorner.Parent = subBtn

	local subPage = Instance.new("Frame")
	subPage.Size = UDim2.new(1, 0, 1, 0)
	subPage.BackgroundTransparency = 1
	subPage.Visible = (i == 1)
	subPage.ZIndex = 3
	subPage.Parent = autoPagesParent
	autoSubPages[subName] = subPage

	subBtn.MouseButton1Click:Connect(function()
		for _, b in pairs(autoSubBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(0,0,0)
				b.BackgroundTransparency = 1
				b.TextColor3 = Theme.SubText
			end
		end
		for _, p in pairs(autoSubPages) do
			p.Visible = false
		end
		subBtn.BackgroundColor3 = Theme.CardBg
		subBtn.BackgroundTransparency = 0
		subBtn.TextColor3 = Theme.Accent
		subPage.Visible = true
	end)

	if subName == "Match Flow" then
		createGroupBox(subPage, "Auto Queue & Maps", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Auto Weapon Ban & Respawn", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Auto Loadout" then
		createGroupBox(subPage, "Setup", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Slot Editor", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "In-Match Automation" then
		createGroupBox(subPage, "Auto Pickup & Anti Katana", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Subspace Tripmines", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Detection" then
		createGroupBox(subPage, "Hacker Detector", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Moderator Detector", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	end
end

-- ==================== WORLD TAB SUB-PAGES ====================
local worldPage = categoryPages["World"]
local worldSubTabs = {"Lighting", "Post Processing", "Sky & Weather"}
local worldSubPages = {}

local worldSubBar = Instance.new("ScrollingFrame")
worldSubBar.Size = UDim2.new(1, 0, 0, 36)
worldSubBar.Position = UDim2.new(0, 0, 0, 0)
worldSubBar.BackgroundTransparency = 1
worldSubBar.CanvasSize = UDim2.new(0, 400, 0, 36)
worldSubBar.ScrollBarThickness = 0
worldSubBar.ZIndex = 3
worldSubBar.Parent = worldPage

local worldSubLayout = Instance.new("UIListLayout")
worldSubLayout.FillDirection = Enum.FillDirection.Horizontal
worldSubLayout.SortOrder = Enum.SortOrder.LayoutIndex
worldSubLayout.Padding = UDim.new(0, 8)
worldSubLayout.Parent = worldSubBar

local worldPagesParent = Instance.new("Frame")
worldPagesParent.Size = UDim2.new(1, 0, 1, -44)
worldPagesParent.Position = UDim2.new(0, 0, 0, 44)
worldPagesParent.BackgroundTransparency = 1
worldPagesParent.ZIndex = 3
worldPagesParent.Parent = worldPage

for i, subName in ipairs(worldSubTabs) do
	local subBtn = Instance.new("TextButton")
	subBtn.Size = UDim2.new(0, 130, 0, 32)
	subBtn.BackgroundColor3 = (i == 1) and Theme.CardBg or Color3.fromRGB(0,0,0)
	subBtn.BackgroundTransparency = (i == 1) and 0 or 1
	subBtn.Font = Enum.Font.GothamMedium
	subBtn.Text = subName
	subBtn.TextColor3 = (i == 1) and Theme.Accent or Theme.SubText
	subBtn.TextSize = 12
	subBtn.ZIndex = 4
	subBtn.Parent = worldSubBar

	local subCorner = Instance.new("UICorner")
	subCorner.CornerRadius = UDim.new(0, 6)
	subCorner.Parent = subBtn

	local subPage = Instance.new("Frame")
	subPage.Size = UDim2.new(1, 0, 1, 0)
	subPage.BackgroundTransparency = 1
	subPage.Visible = (i == 1)
	subPage.ZIndex = 3
	subPage.Parent = worldPagesParent
	worldSubPages[subName] = subPage

	subBtn.MouseButton1Click:Connect(function()
		for _, b in pairs(worldSubBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(0,0,0)
				b.BackgroundTransparency = 1
				b.TextColor3 = Theme.SubText
			end
		end
		for _, p in pairs(worldSubPages) do
			p.Visible = false
		end
		subBtn.BackgroundColor3 = Theme.CardBg
		subBtn.BackgroundTransparency = 0
		subBtn.TextColor3 = Theme.Accent
		subPage.Visible = true
	end)

	if subName == "Lighting" then
		createGroupBox(subPage, "Lighting & Time", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Ambient Colors & Fog", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Post Processing" then
		createGroupBox(subPage, "Tone & Color", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Light Effects & Motion", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Sky & Weather" then
		createGroupBox(subPage, "Skybox & Sound", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Weather & Lightning", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	end
end

-- ==================== SETTINGS TAB SUB-PAGES ====================
local settingsPage = categoryPages["Settings"]
local settingsSubTabs = {"General", "Config Profiles", "Theme"}
local settingsSubPages = {}

local settingsSubBar = Instance.new("ScrollingFrame")
settingsSubBar.Size = UDim2.new(1, 0, 0, 36)
settingsSubBar.Position = UDim2.new(0, 0, 0, 0)
settingsSubBar.BackgroundTransparency = 1
settingsSubBar.CanvasSize = UDim2.new(0, 400, 0, 36)
settingsSubBar.ScrollBarThickness = 0
settingsSubBar.ZIndex = 3
settingsSubBar.Parent = settingsPage

local settingsSubLayout = Instance.new("UIListLayout")
settingsSubLayout.FillDirection = Enum.FillDirection.Horizontal
settingsSubLayout.SortOrder = Enum.SortOrder.LayoutIndex
settingsSubLayout.Padding = UDim.new(0, 8)
settingsSubLayout.Parent = settingsSubBar

local settingsPagesParent = Instance.new("Frame")
settingsPagesParent.Size = UDim2.new(1, 0, 1, -44)
settingsPagesParent.Position = UDim2.new(0, 0, 0, 44)
settingsPagesParent.BackgroundTransparency = 1
settingsPagesParent.ZIndex = 3
settingsPagesParent.Parent = settingsPage

for i, subName in ipairs(settingsSubTabs) do
	local subBtn = Instance.new("TextButton")
	subBtn.Size = UDim2.new(0, 130, 0, 32)
	subBtn.BackgroundColor3 = (i == 1) and Theme.CardBg or Color3.fromRGB(0,0,0)
	subBtn.BackgroundTransparency = (i == 1) and 0 or 1
	subBtn.Font = Enum.Font.GothamMedium
	subBtn.Text = subName
	subBtn.TextColor3 = (i == 1) and Theme.Accent or Theme.SubText
	subBtn.TextSize = 12
	subBtn.ZIndex = 4
	subBtn.Parent = settingsSubBar

	local subCorner = Instance.new("UICorner")
	subCorner.CornerRadius = UDim.new(0, 6)
	subCorner.Parent = subBtn

	local subPage = Instance.new("Frame")
	subPage.Size = UDim2.new(1, 0, 1, 0)
	subPage.BackgroundTransparency = 1
	subPage.Visible = (i == 1)
	subPage.ZIndex = 3
	subPage.Parent = settingsPagesParent
	settingsSubPages[subName] = subPage

	subBtn.MouseButton1Click:Connect(function()
		for _, b in pairs(settingsSubBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(0,0,0)
				b.BackgroundTransparency = 1
				b.TextColor3 = Theme.SubText
			end
		end
		for _, p in pairs(settingsSubPages) do
			p.Visible = false
		end
		subBtn.BackgroundColor3 = Theme.CardBg
		subBtn.BackgroundTransparency = 0
		subBtn.TextColor3 = Theme.Accent
		subPage.Visible = true
	end)

	if subName == "General" then
		createGroupBox(subPage, "Menu & Startup", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Notifications", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Config Profiles" then
		createGroupBox(subPage, "Whole-Menu Profiles", UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0))
		createGroupBox(subPage, "Transfer & Automation", UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0))
	elseif subName == "Theme" then
		createGroupBox(subPage, "Theme Colors", UDim2.new(0.98, 0, 1, 0), UDim2.new(0, 0, 0, 0))
	end
end

-- Menu Toggle Keybind (Insert key)
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

print("ScriptHub Unified UI Framework Loaded Successfully.")