--[[ SCRIPT HUB · RIVALS (DELTA MOBILE + PC)
     Delta-specific fixes: gethui fallback for mobile button, touch input for aiming ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ======================== MOBILE BUTTON (DELTA SAFE) ========================
local function createMobileToggle(Window)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ScriptHubMobile"
    ScreenGui.ResetOnSpawn = false
    
    -- Delta safe parent
    local success, parent = pcall(function() return gethui() end)
    if not success or not parent then
        parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    ScreenGui.Parent = parent

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 50, 0, 50)
    Btn.Position = UDim2.new(0, 20, 0.5, -25)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    Btn.BorderSizePixel = 0
    Btn.Text = "SH"
    Btn.TextColor3 = Color3.fromRGB(100, 100, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 20
    Btn.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Btn
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(100, 100, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = Btn

    local isOpen = true
    Btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            Window:Show()
        else
            Window:Hide()
        end
    end)
    
    Btn.Draggable = true
end

-- ======================== SETTINGS ========================
local S = {
    RageEnabled = false,
    SilentAim = false,
    AutoFire = false,
    AimWalls = false,
    TargetMode = "Highest damage",
    Hitboxes = {"Head", "Chest"},
    HitChance = 50,
    MinDamage = 15,
    QuickStop = true,
    QuickScope = true,
    History = "High",
    DelayShot = false,
    RemoveRecoil = false,
    RemoveSpread = false,
    DuckPeek = false,
    QuickPeek = false,
    DoubleTap = false,
    AntiAimEnabled = false,
    Pitch = "Off",
    Yaw = "Off",
    Freestanding = "Off",
    MouseOverride = "Off",
    
    -- Legit
    LegitEnabled = false,
    FOV = 120,
    Smoothness = 0.15,
}

-- ======================== UI SETUP ========================
local Window = Rayfield:CreateWindow({
    Name = "ScriptHub for BloxStrike",
    LoadingTitle = "ScriptHub",
    LoadingSubtitle = "for BloxStrike/Rivals",
    Theme = "Dark",
    ConfigurationSaving = { Enabled = true, FolderName = "ScriptHub", FileName = "Rivals" },
    KeySystem = false
})

createMobileToggle(Window)

local RageTab = Window:CreateTab("Rage", 4483362458)
local LegitTab = Window:CreateTab("Legit", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
local InventoryTab = Window:CreateTab("Inventory", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- ======================== RAGE TAB ========================
RageTab:CreateSection("Main")
RageTab:CreateToggle({ Name = "Enabled", CurrentValue = false, Flag = "RageEnabled", Callback = function(v) S.RageEnabled = v end })
RageTab:CreateToggle({ Name = "Silent aim", CurrentValue = false, Flag = "Silent", Callback = function(v) S.SilentAim = v end })
RageTab:CreateToggle({ Name = "Automatic fire", CurrentValue = false, Flag = "AutoFire", Callback = function(v) S.AutoFire = v end })
RageTab:CreateToggle({ Name = "Aim through walls", CurrentValue = false, Flag = "AimWalls", Callback = function(v) S.AimWalls = v end })

RageTab:CreateSection("Selection")
RageTab:CreateDropdown({ Name = "Target", Options = {"Highest damage", "Lowest health", "Closest"}, CurrentOption = {"Highest damage"}, Flag = "TargetMode", Callback = function(o) S.TargetMode = o[1] end })
RageTab:CreateDropdown({ Name = "Hitboxes", Options = {"Head", "Chest"}, CurrentOption = {"Head", "Chest"}, MultipleOptions = true, Flag = "Hitboxes", Callback = function(o) S.Hitboxes = o end })
RageTab:CreateDropdown({ Name = "Multipoint", Options = {"Head", "Chest"}, CurrentOption = {"Head", "Chest"}, MultipleOptions = true, Flag = "Multipoint", Callback = function(o) end })
RageTab:CreateSlider({ Name = "Hit chance", Range = {0, 100}, Increment = 1, Suffix = "%", CurrentValue = 50, Flag = "HitChance", Callback = function(v) S.HitChance = v end })
RageTab:CreateSlider({ Name = "Minimum damage", Range = {0, 100}, Increment = 1, CurrentValue = 15, Flag = "MinDamage", Callback = function(v) S.MinDamage = v end })
RageTab:CreateToggle({ Name = "Quick stop", CurrentValue = true, Flag = "QuickStop", Callback = function(v) S.QuickStop = v end })
RageTab:CreateToggle({ Name = "Quick scope", CurrentValue = true, Flag = "QuickScope", Callback = function(v) S.QuickScope = v end })

RageTab:CreateSection("Other")
RageTab:CreateDropdown({ Name = "History", Options = {"High", "Medium", "Low"}, CurrentOption = {"High"}, Flag = "History", Callback = function(o) S.History = o[1] end })
RageTab:CreateToggle({ Name = "Delay shot", CurrentValue = false, Flag = "DelayShot", Callback = function(v) S.DelayShot = v end })
RageTab:CreateToggle({ Name = "Remove recoil", CurrentValue = false, Flag = "RemoveRecoil", Callback = function(v) S.RemoveRecoil = v end })
RageTab:CreateToggle({ Name = "Remove spread", CurrentValue = false, Flag = "RemoveSpread", Callback = function(v) S.RemoveSpread = v end })
RageTab:CreateToggle({ Name = "Duck peek assist", CurrentValue = false, Flag = "DuckPeek", Callback = function(v) S.DuckPeek = v end })
RageTab:CreateToggle({ Name = "Quick peek assist", CurrentValue = false, Flag = "QuickPeek", Callback = function(v) S.QuickPeek = v end })
RageTab:CreateToggle({ Name = "Double tap", CurrentValue = false, Flag = "DoubleTap", Callback = function(v) S.DoubleTap = v end })

RageTab:CreateSection("Anti-aim")
RageTab:CreateToggle({ Name = "Enabled", CurrentValue = false, Flag = "AntiAim", Callback = function(v) S.AntiAimEnabled = v end })
RageTab:CreateDropdown({ Name = "Pitch", Options = {"Off", "Up", "Down"}, CurrentOption = {"Off"}, Flag = "Pitch", Callback = function(o) S.Pitch = o[1] end })
RageTab:CreateDropdown({ Name = "Yaw", Options = {"Off", "Left", "Right"}, CurrentOption = {"Off"}, Flag = "Yaw", Callback = function(o) S.Yaw = o[1] end })
RageTab:CreateDropdown({ Name = "Freestanding", Options = {"Off", "Auto"}, CurrentOption = {"Off"}, Flag = "Free", Callback = function(o) S.Freestanding = o[1] end })
RageTab:CreateDropdown({ Name = "Mouse override", Options = {"Off", "On"}, CurrentOption = {"Off"}, Flag = "Mouse", Callback = function(o) S.MouseOverride = o[1] end })

-- ======================== LEGIT TAB ========================
LegitTab:CreateSection("Main")
LegitTab:CreateToggle({ Name = "Enabled", CurrentValue = false, Flag = "LegitEnabled", Callback = function(v) S.LegitEnabled = v end })
LegitTab:CreateSlider({ Name = "FOV", Range = {10, 400}, Increment = 5, CurrentValue = 120, Flag = "FOV", Callback = function(v) S.FOV = v end })
LegitTab:CreateSlider({ Name = "Smoothness", Range = {0.01, 0.50}, Increment = 0.01, CurrentValue = 0.15, Flag = "Smooth", Callback = function(v) S.Smoothness = v end })

-- ======================== VISUALS ========================
VisualsTab:CreateToggle({ Name = "Player ESP", CurrentValue = true, Flag = "ESP", Callback = function(v) end })
VisualsTab:CreateToggle({ Name = "Boxes", CurrentValue = true, Flag = "Box", Callback = function(v) end })
VisualsTab:CreateToggle({ Name = "Skeleton", CurrentValue = true, Flag = "Skel", Callback = function(v) end })
VisualsTab:CreateToggle({ Name = "Health", CurrentValue = true, Flag = "HP", Callback = function(v) end })
VisualsTab:CreateToggle({ Name = "Name", CurrentValue = true, Flag = "Name", Callback = function(v) end })
VisualsTab:CreateToggle({ Name = "Distance", CurrentValue = true, Flag = "Dist", Callback = function(v) end })

-- ======================== INVENTORY ========================
InventoryTab:CreateParagraph({ Title = "Skins / Cosmetics", Content = "Client-side skin changer is currently disabled.\nServer-side unlocker requires remote interception." })

-- ======================== MISC ========================
MiscTab:CreateToggle({ Name = "Fly", CurrentValue = false, Flag = "Fly", Callback = function(v) end })
MiscTab:CreateToggle({ Name = "Noclip", CurrentValue = false, Flag = "Noclip", Callback = function(v) end })
MiscTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Flag = "InfJump", Callback = function(v) end })

-- ======================== CORE LOGIC ========================
local function getTarget()
    local best, bestScore = nil, math.huge
    local camPos = Camera.CFrame.Position
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local head = char:FindFirstChild("Head")
                if hum and hrp and hum.Health > 0 then
                    local targetPart = head or hrp
                    if table.find(S.Hitboxes, "Chest") and not head then targetPart = char:FindFirstChild("UpperTorso") end
                    
                    if targetPart then
                        local screen, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local dist = (Vector2.new(screen.X, screen.Y) - center).Magnitude
                            if dist < S.FOV then
                                -- Wall check
                                local params = RaycastParams.new()
                                params.FilterType = Enum.RaycastFilterType.Exclude
                                params.FilterDescendantsInstances = {LocalPlayer.Character, char}
                                local ray = Workspace:Raycast(camPos, targetPart.Position - camPos, params)
                                if not ray or S.AimWalls then
                                    local score = 0
                                    if S.TargetMode == "Highest damage" then score = dist
                                    elseif S.TargetMode == "Lowest health" then score = hum.Health
                                    elseif S.TargetMode == "Closest" then score = (hrp.Position - camPos).Magnitude end
                                    
                                    if score < bestScore then
                                        bestScore = score
                                        best = {part = targetPart, pos = targetPart.Position}
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

RunService.RenderStepped:Connect(function()
    -- Delta Touch Support check (Aim on screen tap)
    local isAiming = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) or (UserInputService.TouchEnabled and #UserInputService:GetTouches() > 0)

    -- Rage
    if S.RageEnabled then
        local target = getTarget()
        if target then
            local chance = math.random(1, 100)
            if chance <= S.HitChance then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.pos)
                if S.SilentAim then
                    -- Silent aim logic (hooks metatable / remotes here)
                end
            end
        end
    end
    
    -- Legit
    if S.LegitEnabled and isAiming then
        local target = getTarget()
        if target then
            local smooth = 1 - math.clamp(S.Smoothness, 0.01, 0.5)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.pos), smooth)
        end
    end
end)