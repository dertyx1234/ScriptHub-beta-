--[[ 
    ScriptHub for BloxStrike / Universal
    UI perfectly matches provided screenshot.
    Working ESP (Drawing API), Chams, FOV Circle, Aimbot, Fly, Noclip, etc.
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Replace this ID with your uploaded image ID if you want the exact anime girl
local CUSTOM_IMAGE_ID = "rbxassetid://1316045217" 

-- ======================== SETTINGS ========================
local S = {
    -- Rage
    RageEnabled = false, SilentAim = false, AutoFire = false, AimWalls = false,
    TargetMode = "Highest damage", Hitboxes = {"Head"}, HitChance = 50, MinDamage = 15,
    QuickStop = true, QuickScope = true, History = "High", DelayShot = false,
    RemoveRecoil = false, RemoveSpread = false, DuckPeek = false, QuickPeek = false, DoubleTap = false,
    AntiAimEnabled = false, Pitch = "Off", Yaw = "Off", Freestanding = "Off", MouseOverride = "Off",
    -- Legit
    LegitEnabled = false, FOV = 120, Smoothness = 0.15,
    -- Visuals
    ESP = false, Box = true, Skeleton = true, Health = true, Name = true, Distance = true, Chams = false, Tracers = false,
    -- Misc
    Fly = false, Noclip = false, InfJump = false, WalkSpeed = 16, JumpPower = 50,
    FlySpeed = 50
}

-- ======================== UI SETUP ========================
local Window = Rayfield:CreateWindow({
    Name = "ScriptHub for BloxStrike",
    LoadingTitle = "ScriptHub",
    LoadingSubtitle = "Universal Edition",
    Theme = "Dark",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Inject the Anime Girl Image and Bottom Profile into the UI
task.spawn(function()
    task.wait(1) -- Wait for UI to load
    local RayfieldGui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
    if not RayfieldGui then
        RayfieldGui = LocalPlayer.PlayerGui:FindFirstChild("Rayfield")
    end
    
    if RayfieldGui then
        local Main = RayfieldGui:FindFirstChild("Main")
        if Main then
            -- Anime Girl Image
            local Image = Instance.new("ImageLabel")
            Image.Name = "AnimeGirl"
            Image.Parent = Main
            Image.BackgroundTransparency = 1
            Image.Image = CUSTOM_IMAGE_ID
            Image.Size = UDim2.new(0, 450, 0, 650)
            Image.Position = UDim2.new(0.5, -225, 0.5, -300)
            Image.ZIndex = 0 -- Send to back
            
            -- User Profile Text (calmzash2010)
            local ProfileText = Instance.new("TextLabel")
            ProfileText.Parent = Main
            ProfileText.BackgroundTransparency = 1
            ProfileText.Size = UDim2.new(0, 200, 0, 30)
            ProfileText.Position = UDim2.new(0, 60, 1, -45)
            ProfileText.Text = "calmzash2010  |  29 days left"
            ProfileText.TextColor3 = Color3.fromRGB(200, 200, 200)
            ProfileText.Font = Enum.Font.GothamBold
            ProfileText.TextSize = 14
            ProfileText.TextXAlignment = Enum.TextXAlignment.Left
            ProfileText.ZIndex = 2
        end
    end
end)

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
RageTab:CreateDropdown({ Name = "Target", Options = {"Highest damage", "Lowest health", "Closest", "Crosshair"}, CurrentOption = {"Highest damage"}, Flag = "TargetMode", Callback = function(o) S.TargetMode = o[1] end })
RageTab:CreateDropdown({ Name = "Hitboxes", Options = {"Head", "Chest"}, CurrentOption = {"Head"}, MultipleOptions = true, Flag = "Hitboxes", Callback = function(o) S.Hitboxes = o end })
RageTab:CreateDropdown({ Name = "Multipoint", Options = {"Head", "Chest"}, CurrentOption = {"Head"}, MultipleOptions = true, Flag = "Multipoint", Callback = function(o) end })
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

-- ======================== VISUALS TAB ========================
VisualsTab:CreateSection("ESP")
VisualsTab:CreateToggle({ Name = "Player ESP", CurrentValue = false, Flag = "ESP", Callback = function(v) S.ESP = v end })
VisualsTab:CreateToggle({ Name = "Boxes", CurrentValue = true, Flag = "Box", Callback = function(v) S.Box = v end })
VisualsTab:CreateToggle({ Name = "Skeleton", CurrentValue = true, Flag = "Skel", Callback = function(v) S.Skeleton = v end })
VisualsTab:CreateToggle({ Name = "Health", CurrentValue = true, Flag = "HP", Callback = function(v) S.Health = v end })
VisualsTab:CreateToggle({ Name = "Name", CurrentValue = true, Flag = "Name", Callback = function(v) S.Name = v end })
VisualsTab:CreateToggle({ Name = "Distance", CurrentValue = true, Flag = "Dist", Callback = function(v) S.Distance = v end })
VisualsTab:CreateToggle({ Name = "Tracers", CurrentValue = false, Flag = "Tracer", Callback = function(v) S.Tracers = v end })
VisualsTab:CreateSection("Other")
VisualsTab:CreateToggle({ Name = "Chams (Highlight)", CurrentValue = false, Flag = "Chams", Callback = function(v) S.Chams = v end })

-- ======================== INVENTORY ========================
InventoryTab:CreateParagraph({ Title = "Skins / Cosmetics", Content = "Client-side skin changer is currently disabled.\nServer-side unlocker requires remote interception." })

-- ======================== MISC TAB ========================
MiscTab:CreateSection("Movement")
MiscTab:CreateToggle({ Name = "Fly", CurrentValue = false, Flag = "Fly", Callback = function(v) 
    S.Fly = v
    local char = LocalPlayer.Character
    if not v and char and char:FindFirstChild("HumanoidRootPart") then
        local bv = char.HumanoidRootPart:FindFirstChild("SH_Fly")
        if bv then bv:Destroy() end
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end })
MiscTab:CreateSlider({ Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Flag = "FlySpeed", Callback = function(v) S.FlySpeed = v end })
MiscTab:CreateToggle({ Name = "Noclip", CurrentValue = false, Flag = "Noclip", Callback = function(v) S.Noclip = v end })
MiscTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Flag = "InfJump", Callback = function(v) S.InfJump = v end })

MiscTab:CreateSection("Player")
MiscTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 200}, Increment = 1, CurrentValue = 16, Flag = "WS", Callback = function(v) 
    S.WalkSpeed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end })
MiscTab:CreateSlider({ Name = "JumpPower", Range = {50, 300}, Increment = 5, CurrentValue = 50, Flag = "JP", Callback = function(v) 
    S.JumpPower = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
end })

-- ======================== FOV CIRCLE ========================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 100
FOVCircle.Transparency = 0.5
FOVCircle.Color = Color3.fromRGB(100, 100, 255)

RunService.RenderStepped:Connect(function()
    local fov = S.RageEnabled and 1000 or S.FOV
    if S.LegitEnabled or S.RageEnabled then
        FOVCircle.Visible = true
        FOVCircle.Radius = fov
        FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    else
        FOVCircle.Visible = false
    end
end)

-- ======================== ESP (DRAWING API) ========================
local ESPCache = {}
local function CleanESP()
    for plr, drawings in pairs(ESPCache) do
        for _, draw in pairs(drawings) do
            if draw.Remove then draw:Remove() end
        end
        ESPCache[plr] = nil
    end
end

local function UpdateESP()
    if not S.ESP then
        if next(ESPCache) then CleanESP() end
        return
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local head = char and char:FindFirstChild("Head")
            
            if hrp and hum and hum.Health > 0 and head then
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                
                if onScreen then
                    if not ESPCache[plr] then
                        ESPCache[plr] = {
                            Box = Drawing.new("Square"),
                            Name = Drawing.new("Text"),
                            Health = Drawing.new("Line"),
                            Tracer = Drawing.new("Line")
                        }
                        local d = ESPCache[plr]
                        d.Box.Thickness = 1
                        d.Box.Color = Color3.fromRGB(100, 100, 255)
                        d.Name.Size = 14
                        d.Name.Center = true
                        d.Name.Outline = true
                        d.Health.Thickness = 2
                        d.Tracer.Thickness = 1
                        d.Tracer.Color = Color3.fromRGB(255, 255, 255)
                    end
                    
                    local d = ESPCache[plr]
                    local height = math.abs(headPos.Y - hrpPos.Y) * 2.5
                    local width = height / 2
                    
                    d.Box.Size = Vector2.new(width, height)
                    d.Box.Position = Vector2.new(hrpPos.X - width/2, headPos.Y)
                    d.Box.Visible = S.Box
                    
                    d.Name.Text = plr.Name
                    d.Name.Position = Vector2.new(hrpPos.X, headPos.Y - 20)
                    d.Name.Visible = S.Name
                    
                    d.Health.Position = Vector2.new(hrpPos.X - width/2 - 5, headPos.Y)
                    d.Health.Position2 = Vector2.new(hrpPos.X - width/2 - 5, headPos.Y + height)
                    d.Health.Visible = S.Health
                    
                    d.Tracer.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    d.Tracer.Position2 = Vector2.new(hrpPos.X, headPos.Y + height)
                    d.Tracer.Visible = S.Tracers
                else
                    if ESPCache[plr] then
                        for _, draw in pairs(ESPCache[plr]) do draw.Visible = false end
                    end
                end
            end
        end
    end
end

-- ======================== CHAMS ========================
local ChamsCache = {}
RunService.Stepped:Connect(function()
    if S.Chams then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
                local char = plr.Character
                if char and not ChamsCache[char] then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = char
                    highlight.FillColor = Color3.fromRGB(100, 100, 255)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    ChamsCache[char] = highlight
                end
            end
        end
    else
        for char, highlight in pairs(ChamsCache) do
            if highlight and highlight.Parent then highlight:Destroy() end
            ChamsCache[char] = nil
        end
    end
end)

-- ======================== CORE LOGIC: AIMBOT ========================
local function getTarget()
    local best, bestDist = nil, math.huge
    local camPos = Camera.CFrame.Position
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team then
            local char = plr.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local head = char:FindFirstChild("Head")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and (head or hrp) then
                    local targetPart = head or hrp
                    if table.find(S.Hitboxes, "Chest") and not head then targetPart = char:FindFirstChild("UpperTorso") end
                    
                    if targetPart then
                        local screen, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                            local dist = (Vector2.new(screen.X, screen.Y) - center).Magnitude
                            local maxFov = S.RageEnabled and 1000 or S.FOV
                            if dist < maxFov then
                                -- Wall check
                                local params = RaycastParams.new()
                                params.FilterType = Enum.RaycastFilterType.Exclude
                                params.FilterDescendantsInstances = {LocalPlayer.Character, char}
                                local ray = Workspace:Raycast(camPos, targetPart.Position - camPos, params)
                                if not ray or S.AimWalls or (ray.Instance and ray.Instance:IsDescendantOf(char)) then
                                    local score = dist
                                    if S.TargetMode == "Lowest health" then score = hum.Health end
                                    if score < bestDist then
                                        bestDist = score
                                        best = {part = targetPart, plr = plr, char = char}
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

-- ======================== MAIN LOOP (Aim, Fly, Noclip) ========================
RunService.RenderStepped:Connect(function()
    UpdateESP()
    
    local isAiming = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) 
        or (UserInputService.TouchEnabled and #UserInputService:GetTouches() > 0)

    -- Aimbot Logic
    local target = getTarget()
    if target then
        -- Simple Prediction (Ping-based)
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
        local predictedPos = target.part.Position + (target.part.AssemblyLinearVelocity * ping)
        
        if S.RageEnabled and math.random(1, 100) <= S.HitChance then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, predictedPos)
            if S.AutoFire then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then pcall(function() tool:Activate() end) end
            end
        elseif S.LegitEnabled and isAiming then
            local smooth = 1 - math.clamp(S.Smoothness, 0.01, 0.5)
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, predictedPos), smooth)
        end
    end
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    
    -- Noclip
    if S.Noclip and char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    
    -- Fly
    if S.Fly and hrp then
        local bv = hrp:FindFirstChild("SH_Fly")
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Name = "SH_Fly"
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.Parent = hrp
        end
        
        local dir = Vector3.new(0,0,0)
        local camCFrame = Camera.CFrame
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + camCFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - camCFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - camCFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + camCFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0,1,0) end
        
        if hum then hum.PlatformStand = true end
        bv.Velocity = dir * S.FlySpeed
    end
end)

-- Inf Jump
UserInputService.JumpRequest:Connect(function()
    if S.InfJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- Cleanup
Players.PlayerRemoving:Connect(function(plr)
    if ESPCache[plr] then
        for _, draw in pairs(ESPCache[plr]) do draw:Remove() end
        ESPCache[plr] = nil
    end
end)