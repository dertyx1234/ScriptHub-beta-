-- ScriptHub UI | Roblox LocalScript
-- Tabs: Rage, Main, Visuals, World, Settings
-- PC + Mobile | Draggable | Toggle open/close

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===================== SETTINGS STATE =====================
local Settings = {
    Rage = {
        Enabled = false,
        SilentAim = false,
        AutoFire = false,
        AimThroughWalls = false,
        Target = "Highest Damage",
        Hitboxes = {Head = true, Chest = true},
        Multipoint = {Head = true, Chest = false},
        HitChance = 50,
        MinDamage = 15,
        QuickStop = true,
        QuickScope = true,
    },
    Other = {
        History = "High",
        DelayShot = false,
        RemoveRecoil = false,
        RemoveSpread = false,
        DuckPeekAssist = false,
        QuickPeekAssist = false,
        DoubleTap = false,
    },
    AntiAim = {
        Enabled = false,
        Pitch = "Off",
        Yaw = "Off",
        Freestanding = "Off",
        MouseOverride = "Off",
    },
    Visuals = {
        ESP = false,
        Chams = false,
        Skeleton = false,
        HealthBar = false,
        NameTag = false,
        BoxESP = false,
        TracerLines = false,
        FillColor = false,
    },
    World = {
        NoFog = false,
        FullBright = false,
        TimeOfDay = "12",
        Gravity = 196,
        WalkSpeed = 16,
        JumpPower = 50,
        InfiniteJump = false,
        NoClip = false,
    },
    Config = {
        UIScale = 1,
        Theme = "Dark",
        Notifications = true,
        KeybindOpen = "RightShift",
    },
}

-- ===================== COLORS =====================
local C = {
    BG         = Color3.fromRGB(15, 17, 22),
    Sidebar    = Color3.fromRGB(20, 23, 30),
    Panel      = Color3.fromRGB(24, 27, 36),
    Header     = Color3.fromRGB(18, 21, 28),
    Accent     = Color3.fromRGB(30, 120, 255),
    AccentDim  = Color3.fromRGB(20, 80, 180),
    Text       = Color3.fromRGB(220, 225, 235),
    TextDim    = Color3.fromRGB(130, 140, 160),
    Toggle_ON  = Color3.fromRGB(30, 120, 255),
    Toggle_OFF = Color3.fromRGB(45, 50, 65),
    Slider     = Color3.fromRGB(30, 120, 255),
    SliderBG   = Color3.fromRGB(40, 45, 60),
    Divider    = Color3.fromRGB(35, 40, 55),
    TabActive  = Color3.fromRGB(30, 120, 255),
    TabInact   = Color3.fromRGB(20, 23, 30),
    Dropdown   = Color3.fromRGB(28, 32, 44),
    DropHover  = Color3.fromRGB(35, 40, 58),
    White      = Color3.fromRGB(255, 255, 255),
}

-- ===================== SCREEN GUI =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Open/Close toggle button (always visible)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 44, 0, 44)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -22)
ToggleBtn.BackgroundColor3 = C.Accent
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "SH"
ToggleBtn.TextColor3 = C.White
ToggleBtn.TextScaled = true
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.ZIndex = 100
ToggleBtn.Parent = ScreenGui
local TBCorner = Instance.new("UICorner", ToggleBtn)
TBCorner.CornerRadius = UDim.new(0, 8)

-- ===================== MAIN WINDOW =====================
local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, 860, 0, 540)
Window.Position = UDim2.new(0.5, -430, 0.5, -270)
Window.BackgroundColor3 = C.BG
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.ZIndex = 10
Window.Parent = ScreenGui
local WCorner = Instance.new("UICorner", Window)
WCorner.CornerRadius = UDim.new(0, 10)
local WShadow = Instance.new("UIStroke", Window)
WShadow.Color = C.Accent
WShadow.Thickness = 1.2
WShadow.Transparency = 0.6

-- ===================== SIDEBAR =====================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 80, 1, 0)
Sidebar.Position = UDim2.new(0, 0, 0, 0)
Sidebar.BackgroundColor3 = C.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = Window

-- Logo
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 0, 70)
Logo.Position = UDim2.new(0, 0, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "SH"
Logo.TextColor3 = C.Accent
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 26
Logo.ZIndex = 12
Logo.Parent = Sidebar

-- Sidebar tab list
local TabList = Instance.new("Frame")
TabList.Size = UDim2.new(1, 0, 1, -70)
TabList.Position = UDim2.new(0, 0, 0, 70)
TabList.BackgroundTransparency = 1
TabList.ZIndex = 12
TabList.Parent = Sidebar
local TabListLayout = Instance.new("UIListLayout", TabList)
TabListLayout.FillDirection = Enum.FillDirection.Vertical
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Padding = UDim.new(0, 4)

-- ===================== HEADER =====================
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, -80, 0, 54)
Header.Position = UDim2.new(0, 80, 0, 0)
Header.BackgroundColor3 = C.Header
Header.BorderSizePixel = 0
Header.ZIndex = 11
Header.Parent = Window

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0.5, 0, 1, 0)
HeaderTitle.Position = UDim2.new(0, 16, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "Aimbot  Rage"
HeaderTitle.TextColor3 = C.Text
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 18
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.ZIndex = 12
HeaderTitle.Parent = Header

-- Close button in header
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = C.White
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 15
CloseBtn.Parent = Header
local CBCorner = Instance.new("UICorner", CloseBtn)
CBCorner.CornerRadius = UDim.new(0, 6)

-- ===================== CONTENT AREA =====================
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -80, 1, -54)
Content.Position = UDim2.new(0, 80, 0, 54)
Content.BackgroundColor3 = C.Panel
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.ZIndex = 11
Content.Parent = Window

-- ===================== UTILITY FUNCTIONS =====================
local function makeDivider(parent, y)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(1, -20, 0, 1)
    d.Position = UDim2.new(0, 10, 0, y)
    d.BackgroundColor3 = C.Divider
    d.BorderSizePixel = 0
    d.ZIndex = 13
    d.Parent = parent
    return d
end

local function makeLabel(parent, text, x, y, w, h, size, color, bold)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0, w, 0, h)
    l.Position = UDim2.new(0, x, 0, y)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.Text
    l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize = size or 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 13
    l.Parent = parent
    return l
end

local function makeToggle(parent, x, y, key, tbl, onChange)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 38, 0, 20)
    bg.Position = UDim2.new(0, x, 0, y)
    bg.BackgroundColor3 = tbl[key] and C.Toggle_ON or C.Toggle_OFF
    bg.BorderSizePixel = 0
    bg.ZIndex = 13
    bg.Parent = parent
    local bgC = Instance.new("UICorner", bg)
    bgC.CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = tbl[key] and UDim2.new(0, 20, 0, 2) or UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = C.White
    knob.BorderSizePixel = 0
    knob.ZIndex = 14
    knob.Parent = bg
    local kC = Instance.new("UICorner", knob)
    kC.CornerRadius = UDim.new(1, 0)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 15
    btn.Parent = bg

    local tw = TweenService:Create
    btn.MouseButton1Click:Connect(function()
        tbl[key] = not tbl[key]
        local on = tbl[key]
        tw(bg, TweenInfo.new(0.15), {BackgroundColor3 = on and C.Toggle_ON or C.Toggle_OFF}):Play()
        tw(knob, TweenInfo.new(0.15), {Position = on and UDim2.new(0,20,0,2) or UDim2.new(0,2,0,2)}):Play()
        if onChange then onChange(on) end
    end)
    return bg
end

local function makeSlider(parent, x, y, w, key, tbl, minV, maxV, suffix)
    local val = tbl[key]
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, w, 0, 6)
    track.Position = UDim2.new(0, x, 0, y+7)
    track.BackgroundColor3 = C.SliderBG
    track.BorderSizePixel = 0
    track.ZIndex = 13
    track.Parent = parent
    local tC = Instance.new("UICorner", track)
    tC.CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((val-minV)/(maxV-minV), 0, 1, 0)
    fill.BackgroundColor3 = C.Slider
    fill.BorderSizePixel = 0
    fill.ZIndex = 14
    fill.Parent = track
    local fC = Instance.new("UICorner", fill)
    fC.CornerRadius = UDim.new(1, 0)

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 12, 0, 12)
    thumb.Position = UDim2.new((val-minV)/(maxV-minV), -6, 0.5, -6)
    thumb.BackgroundColor3 = C.White
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 15
    thumb.Parent = track
    local thC = Instance.new("UICorner", thumb)
    thC.CornerRadius = UDim.new(1, 0)

    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0, 40, 0, 20)
    valLabel.Position = UDim2.new(0, x+w+8, 0, y)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = tostring(val)..(suffix or "")
    valLabel.TextColor3 = C.TextDim
    valLabel.Font = Enum.Font.Gotham
    valLabel.TextSize = 12
    valLabel.ZIndex = 13
    valLabel.Parent = parent

    local dragging = false
    local function update(inputX)
        local abs = track.AbsolutePosition.X
        local sz  = track.AbsoluteSize.X
        local rel = math.clamp((inputX - abs)/sz, 0, 1)
        local v   = math.floor(minV + rel*(maxV-minV))
        tbl[key] = v
        fill.Size = UDim2.new(rel, 0, 1, 0)
        thumb.Position = UDim2.new(rel, -6, 0.5, -6)
        valLabel.Text = tostring(v)..(suffix or "")
    end

    local trackBtn = Instance.new("TextButton")
    trackBtn.Size = UDim2.new(1, 0, 3, -10)
    trackBtn.Position = UDim2.new(0, 0, 0, -8)
    trackBtn.BackgroundTransparency = 1
    trackBtn.Text = ""
    trackBtn.ZIndex = 16
    trackBtn.Parent = track

    trackBtn.MouseButton1Down:Connect(function(x2,_) dragging=true update(x2) end)
    trackBtn.TouchLongPress:Connect(function(t) if t[1] then dragging=true update(t[1].Position.X) end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            update(i.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)
    return track
end

local function makeDropdown(parent, x, y, w, options, current, onChange)
    local selectedVal = current
    local open = false

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, w, 0, 26)
    bg.Position = UDim2.new(0, x, 0, y)
    bg.BackgroundColor3 = C.Dropdown
    bg.BorderSizePixel = 0
    bg.ClipsDescendants = false
    bg.ZIndex = 20
    bg.Parent = parent
    local bgC = Instance.new("UICorner", bg)
    bgC.CornerRadius = UDim.new(0, 5)

    local selLabel = Instance.new("TextLabel")
    selLabel.Size = UDim2.new(1,-24,1,0)
    selLabel.Position = UDim2.new(0,8,0,0)
    selLabel.BackgroundTransparency = 1
    selLabel.Text = selectedVal
    selLabel.TextColor3 = C.Text
    selLabel.Font = Enum.Font.Gotham
    selLabel.TextSize = 12
    selLabel.TextXAlignment = Enum.TextXAlignment.Left
    selLabel.ZIndex = 21
    selLabel.Parent = bg

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0,20,1,0)
    arrow.Position = UDim2.new(1,-22,0,0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▾"
    arrow.TextColor3 = C.TextDim
    arrow.Font = Enum.Font.Gotham
    arrow.TextSize = 12
    arrow.ZIndex = 21
    arrow.Parent = bg

    local dropFrame = Instance.new("Frame")
    dropFrame.Size = UDim2.new(1, 0, 0, #options*26)
    dropFrame.Position = UDim2.new(0, 0, 1, 2)
    dropFrame.BackgroundColor3 = C.Dropdown
    dropFrame.BorderSizePixel = 0
    dropFrame.Visible = false
    dropFrame.ZIndex = 30
    dropFrame.Parent = bg
    local dfC = Instance.new("UICorner", dropFrame)
    dfC.CornerRadius = UDim.new(0, 5)
    local dfLayout = Instance.new("UIListLayout", dropFrame)
    dfLayout.FillDirection = Enum.FillDirection.Vertical

    for _, opt in ipairs(options) do
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 26)
        item.BackgroundColor3 = C.Dropdown
        item.BorderSizePixel = 0
        item.Text = opt
        item.TextColor3 = C.Text
        item.Font = Enum.Font.Gotham
        item.TextSize = 12
        item.ZIndex = 31
        item.Parent = dropFrame
        item.MouseEnter:Connect(function() item.BackgroundColor3 = C.DropHover end)
        item.MouseLeave:Connect(function() item.BackgroundColor3 = C.Dropdown end)
        item.MouseButton1Click:Connect(function()
            selectedVal = opt
            selLabel.Text = opt
            open = false
            dropFrame.Visible = false
            if onChange then onChange(opt) end
        end)
    end

    local openBtn = Instance.new("TextButton")
    openBtn.Size = UDim2.new(1,0,1,0)
    openBtn.BackgroundTransparency = 1
    openBtn.Text = ""
    openBtn.ZIndex = 22
    openBtn.Parent = bg
    openBtn.MouseButton1Click:Connect(function()
        open = not open
        dropFrame.Visible = open
    end)

    return bg
end

-- ===================== SCROLL FRAME HELPER =====================
local function makeScroll(parent)
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.BorderSizePixel = 0
    sf.ScrollBarThickness = 3
    sf.ScrollBarImageColor3 = C.Accent
    sf.CanvasSize = UDim2.new(0, 0, 0, 0)
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.ZIndex = 12
    sf.Parent = parent
    return sf
end

-- ===================== TAB SYSTEM =====================
local tabPages = {}
local tabButtons = {}
local activeTab = nil

local tabDefs = {
    {name="Rage",    icon="⊕"},
    {name="Main",    icon="☰"},
    {name="Visuals", icon="◎"},
    {name="World",   icon="⊞"},
    {name="Settings",icon="≡"},
}

local function switchTab(name)
    for n, page in pairs(tabPages) do
        page.Visible = (n == name)
    end
    for n, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = (n==name) and C.TabActive or C.TabInact
        btn.TextColor3 = (n==name) and C.White or C.TextDim
    end
    activeTab = name
    -- Update header
    local titles = {Rage="Aimbot  Rage", Main="Main", Visuals="Visuals", World="World", Settings="Settings"}
    HeaderTitle.Text = titles[name] or name
end

for _, td in ipairs(tabDefs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 64)
    btn.BackgroundColor3 = C.TabInact
    btn.BorderSizePixel = 0
    btn.Text = td.icon.."\n"..td.name
    btn.TextColor3 = C.TextDim
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.ZIndex = 13
    btn.Parent = TabList
    tabButtons[td.name] = btn

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ZIndex = 12
    page.Parent = Content
    tabPages[td.name] = page

    btn.MouseButton1Click:Connect(function() switchTab(td.name) end)
end

-- ===================== RAGE TAB =====================
do
    local page = tabPages["Rage"]
    local scroll = makeScroll(page)

    -- Two columns
    local leftCol = Instance.new("Frame")
    leftCol.Size = UDim2.new(0.5, -10, 1, 0)
    leftCol.Position = UDim2.new(0, 10, 0, 0)
    leftCol.BackgroundTransparency = 1
    leftCol.ZIndex = 13
    leftCol.Parent = scroll

    local rightCol = Instance.new("Frame")
    rightCol.Size = UDim2.new(0.5, -20, 1, 0)
    rightCol.Position = UDim2.new(0.5, 10, 0, 0)
    rightCol.BackgroundTransparency = 1
    rightCol.ZIndex = 13
    rightCol.Parent = scroll

    -- LEFT: Main section
    makeLabel(leftCol,"Main", 0, 10, 120, 20, 14, C.Text, true)
    makeDivider(leftCol, 34)

    local rows = {
        {label="Enabled",          key="Enabled",         y=45},
        {label="Silent aim",       key="SilentAim",       y=78},
        {label="Automatic fire",   key="AutoFire",        y=111},
        {label="Aim through walls",key="AimThroughWalls", y=144},
    }
    for _, r in ipairs(rows) do
        makeLabel(leftCol, r.label, 0, r.y+2, 200, 18, 13, C.Text)
        makeToggle(leftCol, 310, r.y, r.key, Settings.Rage)
    end

    -- Selection
    makeLabel(leftCol,"Selection", 0, 178, 120, 20, 13, C.Text, true)
    makeDivider(leftCol, 200)

    makeLabel(leftCol,"Target", 0, 210, 100, 18, 13, C.Text)
    makeDropdown(leftCol, 160, 208, 190, {"Highest Damage","Closest","Lowest HP","Random"}, Settings.Rage.Target, function(v) Settings.Rage.Target=v end)

    makeLabel(leftCol,"Hitboxes", 0, 248, 100, 18, 13, C.Text)
    makeDropdown(leftCol, 160, 246, 190, {"Head","Chest","Stomach","Legs"}, "Head", nil)

    makeLabel(leftCol,"Multipoint", 0, 284, 100, 18, 13, C.Text)
    makeDropdown(leftCol, 160, 282, 190, {"Head","Chest","Stomach","Legs"}, "Head", nil)

    makeLabel(leftCol,"Hit chance", 0, 322, 100, 18, 13, C.Text)
    makeSlider(leftCol, 160, 320, 140, "HitChance", Settings.Rage, 0, 100, "%")

    makeLabel(leftCol,"Minimum damage", 0, 360, 130, 18, 13, C.Text)
    makeSlider(leftCol, 160, 358, 140, "MinDamage", Settings.Rage, 0, 100, "")

    makeLabel(leftCol,"Quick stop", 0, 398, 120, 18, 13, C.Text)
    makeToggle(leftCol, 310, 396, "QuickStop", Settings.Rage)

    makeLabel(leftCol,"Quick scope", 0, 432, 120, 18, 13, C.Text)
    makeToggle(leftCol, 310, 430, "QuickScope", Settings.Rage)

    -- RIGHT: Other section
    makeLabel(rightCol,"Other", 0, 10, 120, 20, 14, C.Text, true)
    makeDivider(rightCol, 34)

    makeLabel(rightCol,"History", 0, 47, 100, 18, 13, C.Text)
    makeDropdown(rightCol, 160, 45, 140, {"High","Medium","Low"}, Settings.Other.History, function(v) Settings.Other.History=v end)

    local otherRows = {
        {label="Delay shot",       key="DelayShot",       y=82},
        {label="Remove recoil",    key="RemoveRecoil",    y=115},
        {label="Remove spread",    key="RemoveSpread",    y=148},
        {label="Duck peek assist", key="DuckPeekAssist",  y=181},
        {label="Quick peek assist",key="QuickPeekAssist", y=214},
        {label="Double tap",       key="DoubleTap",       y=247},
    }
    for _, r in ipairs(otherRows) do
        makeLabel(rightCol, r.label, 0, r.y+2, 160, 18, 13, C.Text)
        makeToggle(rightCol, 270, r.y, r.key, Settings.Other)
    end

    -- Anti-aim
    makeLabel(rightCol,"Anti-aim", 0, 288, 120, 20, 13, C.Text, true)
    makeDivider(rightCol, 310)

    makeLabel(rightCol,"Enabled", 0, 322, 100, 18, 13, C.Text)
    makeToggle(rightCol, 270, 320, "Enabled", Settings.AntiAim)

    local aaDrops = {
        {label="Pitch",          key="Pitch",         y=354},
        {label="Yaw",            key="Yaw",           y=388},
        {label="Freestanding",   key="Freestanding",  y=422},
        {label="Mouse override", key="MouseOverride",  y=456},
    }
    for _, r in ipairs(aaDrops) do
        makeLabel(rightCol, r.label, 0, r.y+2, 120, 18, 13, C.TextDim)
        makeDropdown(rightCol, 160, r.y, 140, {"Off","On","Jitter","Spin"}, Settings.AntiAim[r.key], function(v) Settings.AntiAim[r.key]=v end)
    end
end

-- ===================== MAIN TAB =====================
do
    local page = tabPages["Main"]
    local scroll = makeScroll(page)

    makeLabel(scroll,"Player", 10, 10, 200, 20, 14, C.Text, true)
    makeDivider(scroll, 34)

    makeLabel(scroll,"Walk Speed", 10, 47, 120, 18, 13, C.Text)
    makeSlider(scroll, 160, 45, 200, "WalkSpeed", Settings.World, 8, 100, "")

    makeLabel(scroll,"Jump Power", 10, 82, 120, 18, 13, C.Text)
    makeSlider(scroll, 160, 80, 200, "JumpPower", Settings.World, 0, 200, "")

    makeLabel(scroll,"Infinite Jump", 10, 117, 120, 18, 13, C.Text)
    makeToggle(scroll, 360, 115, "InfiniteJump", Settings.World, function(v)
        if v then
            UserInputService.JumpRequest:Connect(function()
                if Settings.World.InfiniteJump then
                    LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)

    makeLabel(scroll,"NoClip", 10, 152, 120, 18, 13, C.Text)
    makeToggle(scroll, 360, 150, "NoClip", Settings.World, function(v)
        if v then
            RunService.Stepped:Connect(function()
                if Settings.World.NoClip and LocalPlayer.Character then
                    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
                        if p:IsA("BasePart") then p.CanCollide = false end
                    end
                end
            end)
        end
    end)

    makeLabel(scroll,"Gravity", 10, 10+180, 120, 18, 13, C.Text, true)
    makeDivider(scroll, 34+180)
    makeLabel(scroll,"Gravity Value", 10, 47+180, 120, 18, 13, C.Text)
    makeSlider(scroll, 160, 45+180, 200, "Gravity", Settings.World, 0, 400, "")
end

-- ===================== VISUALS TAB =====================
do
    local page = tabPages["Visuals"]
    local scroll = makeScroll(page)

    makeLabel(scroll,"ESP", 10, 10, 200, 20, 14, C.Text, true)
    makeDivider(scroll, 34)

    local espToggles = {
        {label="ESP Enabled",  key="ESP",         y=45},
        {label="Chams",        key="Chams",        y=78},
        {label="Skeleton",     key="Skeleton",     y=111},
        {label="Health Bar",   key="HealthBar",    y=144},
        {label="Name Tag",     key="NameTag",      y=177},
        {label="Box ESP",      key="BoxESP",       y=210},
        {label="Tracer Lines", key="TracerLines",  y=243},
        {label="Fill Color",   key="FillColor",    y=276},
    }
    for _, r in ipairs(espToggles) do
        makeLabel(scroll, r.label, 10, r.y+2, 200, 18, 13, C.Text)
        makeToggle(scroll, 360, r.y, r.key, Settings.Visuals)
    end
end

-- ===================== WORLD TAB =====================
do
    local page = tabPages["World"]
    local scroll = makeScroll(page)

    makeLabel(scroll,"Environment", 10, 10, 200, 20, 14, C.Text, true)
    makeDivider(scroll, 34)

    makeLabel(scroll,"No Fog", 10, 47, 120, 18, 13, C.Text)
    makeToggle(scroll, 360, 45, "NoFog", Settings.World, function(v)
        local lighting = game:GetService("Lighting")
        if v then
            lighting.FogEnd = 1e6
            lighting.FogStart = 1e6
        else
            lighting.FogEnd = 100000
            lighting.FogStart = 0
        end
    end)

    makeLabel(scroll,"Full Bright", 10, 82, 120, 18, 13, C.Text)
    makeToggle(scroll, 360, 80, "FullBright", Settings.World, function(v)
        local lighting = game:GetService("Lighting")
        lighting.Brightness = v and 10 or 1
        lighting.Ambient = v and Color3.new(1,1,1) or Color3.new(0,0,0)
        lighting.OutdoorAmbient = v and Color3.new(1,1,1) or Color3.fromRGB(128,128,128)
    end)

    makeLabel(scroll,"Time of Day", 10, 118, 120, 18, 13, C.Text)
    makeDropdown(scroll, 160, 116, 200, {"00:00","06:00","09:00","12:00","15:00","18:00","21:00"}, "12:00", function(v)
        game:GetService("Lighting").TimeOfDay = v
    end)
end

-- ===================== SETTINGS TAB =====================
do
    local page = tabPages["Settings"]
    local scroll = makeScroll(page)

    makeLabel(scroll,"Interface", 10, 10, 200, 20, 14, C.Text, true)
    makeDivider(scroll, 34)

    makeLabel(scroll,"Notifications", 10, 47, 160, 18, 13, C.Text)
    makeToggle(scroll, 360, 45, "Notifications", Settings.Config)

    makeLabel(scroll,"Theme", 10, 82, 100, 18, 13, C.Text)
    makeDropdown(scroll, 160, 80, 200, {"Dark","Darker","Blue Accent"}, Settings.Config.Theme, function(v)
        Settings.Config.Theme = v
    end)

    makeLabel(scroll,"Keybinds", 10, 128, 200, 20, 14, C.Text, true)
    makeDivider(scroll, 150)

    makeLabel(scroll,"Open/Close UI", 10, 163, 160, 18, 13, C.Text)
    makeLabel(scroll,"[ Right Shift ]", 180, 163, 160, 18, 13, C.Accent)

    makeLabel(scroll,"Credits", 10, 210, 200, 20, 14, C.Text, true)
    makeDivider(scroll, 232)
    makeLabel(scroll,"ScriptHub UI — made for Roblox", 10, 246, 400, 18, 13, C.TextDim)
end

-- ===================== FOOTER =====================
local Footer = Instance.new("Frame")
Footer.Size = UDim2.new(1, -80, 0, 32)
Footer.Position = UDim2.new(0, 80, 1, -32)
Footer.BackgroundColor3 = C.Header
Footer.BorderSizePixel = 0
Footer.ZIndex = 12
Footer.Parent = Window

local FooterLeft = Instance.new("TextLabel")
FooterLeft.Size = UDim2.new(0.5, 0, 1, 0)
FooterLeft.Position = UDim2.new(0, 10, 0, 0)
FooterLeft.BackgroundTransparency = 1
FooterLeft.Text = "👤  "..LocalPlayer.Name.."   |   ScriptHub"
FooterLeft.TextColor3 = C.TextDim
FooterLeft.Font = Enum.Font.Gotham
FooterLeft.TextSize = 11
FooterLeft.TextXAlignment = Enum.TextXAlignment.Left
FooterLeft.ZIndex = 13
FooterLeft.Parent = Footer

local FooterRight = Instance.new("TextLabel")
FooterRight.Size = UDim2.new(0.5, -10, 1, 0)
FooterRight.Position = UDim2.new(0.5, 0, 0, 0)
FooterRight.BackgroundTransparency = 1
FooterRight.Text = "ScriptHub for Roblox"
FooterRight.TextColor3 = C.TextDim
FooterRight.Font = Enum.Font.Gotham
FooterRight.TextSize = 11
FooterRight.TextXAlignment = Enum.TextXAlignment.Right
FooterRight.ZIndex = 13
FooterRight.Parent = Footer

-- ===================== DRAGGING =====================
local dragging = false
local dragStart, startPos

local function beginDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = Window.Position
end
local function updateDrag(input)
    if not dragging then return end
    local delta = input.Position - dragStart
    Window.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        beginDrag(input)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ===================== OPEN / CLOSE =====================
local uiVisible = true
local function setVisible(v)
    uiVisible = v
    Window.Visible = v
    ToggleBtn.Text = v and "✕" or "SH"
    ToggleBtn.BackgroundColor3 = v and Color3.fromRGB(200,50,50) or C.Accent
end

CloseBtn.MouseButton1Click:Connect(function() setVisible(false) end)
ToggleBtn.MouseButton1Click:Connect(function() setVisible(not uiVisible) end)

-- Keyboard toggle (Right Shift)
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        setVisible(not uiVisible)
    end
end)

-- ===================== INIT =====================
switchTab("Rage")
setVisible(true)

print("[ScriptHub] Loaded. Press RightShift to toggle.")
