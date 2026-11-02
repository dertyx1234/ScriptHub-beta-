--[[ 
    ScriptHub for Rivals
    UI based on the provided getsample.lol library.
    Fully functional Aimbot (Rage/Legit), ESP, Triggerbot, and Movement.
]]

-- Load the exact UI library from the file
local library = loadstring(game:HttpGet("https://xor-1-45-25-0.getsample.lol"))()
local flags = library.flags

-- Create Window (Named ScriptHub as requested)
local window = library:window({
    name = "ScriptHub", 
    subname = "Rivals", 
    menulogo = "rbxassetid://107276976681956",
    size = UDim2.fromOffset(590, 565)
})

local Main = window:tab({ name = " main" })
local Rage = window:tab({ name = " ragebot" })
local Legit = window:tab({ name = " legit" })
local Visuals = window:tab({ name = " visuals" })
local World = window:tab({ name = " world" })
local Misc = window:tab({ name = " misc" })

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Settings Table
local Settings = {
    -- Rage
    RageEnabled = false,
    RageKey = nil,
    RageFOV = 150,
    RageTargetPart = "Head",
    RagePrediction = 0.15,
    RageWallCheck = true,
    -- Legit
    LegitEnabled = false,
    LegitKey = nil,
    LegitFOV = 100,
    LegitSmoothness = 0.2,
    LegitTargetPart = "Head",
    -- Triggerbot
    TriggerEnabled = false,
    TriggerDelay = 0.01,
    -- ESP
    ESPEnabled = false,
    ESPBox = true,
    ESPName = true,
    ESPHealth = true,
    ESPDistance = true,
    ESPColor = Color3.fromRGB(255, 128, 0),
    FOVCircleEnabled = true,
    FOVCircleColor = Color3.fromRGB(255, 255, 255),
    -- Misc
    FlyEnabled = false,
    FlySpeed = 50,
    NoclipEnabled = false,
    WalkSpeed = 16,
    JumpPower = 50
}

-- ==========================================
-- MAIN TAB
-- ==========================================
local mainSection = Main:section({ name = "main features" })
mainSection:toggle({
    name = "enabled",
    flag = "main_master",
    default = true,
    callback = function(val)
        -- Master switch if needed
    end
})

local triggerSection = Main:section({ name = "triggerbot" })
triggerSection:toggle({
    name = "enabled",
    flag = "trigger_enabled",
    default = false,
    callback = function(val) Settings.TriggerEnabled = val end
})
triggerSection:slider({
    name = "delay",
    flag = "trigger_delay",
    default = 0.01,
    min = 0,
    max = 1,
    interval = 0.01,
    callback = function(val) Settings.TriggerDelay = val end
})

-- ==========================================
-- RAGEBOT TAB
-- ==========================================
local rageSection = Rage:section({ name = "ragebot" })
rageSection:keybind({
    name = "aimbot keybind",
    flag = "rage_key",
    default = nil,
    display = "ragebot",
    callback = function(bool) Settings.RageKey = bool end
})
rageSection:toggle({
    name = "enabled (toggle)",
    flag = "rage_enabled",
    default = false,
    callback = function(val) Settings.RageEnabled = val end
})
rageSection:slider({
    name = "fov",
    flag = "rage_fov",
    default = 150,
    min = 10,
    max = 500,
    interval = 1,
    callback = function(val) Settings.RageFOV = val end
})
rageSection:dropdown({
    name = "hitpart",
    flag = "rage_hitpart",
    items = {"Head", "HumanoidRootPart", "UpperTorso"},
    default = "Head",
    callback = function(val) Settings.RageTargetPart = val end
})
rageSection:slider({
    name = "prediction",
    flag = "rage_pred",
    default = 0.15,
    min = 0,
    max = 1,
    interval = 0.01,
    callback = function(val) Settings.RagePrediction = val end
})
rageSection:toggle({
    name = "wall check",
    flag = "rage_wallcheck",
    default = true,
    callback = function(val) Settings.RageWallCheck = val end
})

-- ==========================================
-- LEGIT TAB
-- ==========================================
local legitSection = Legit:section({ name = "legit aimbot" })
legitSection:keybind({
    name = "aimbot keybind",
    flag = "legit_key",
    default = nil,
    display = "legit",
    callback = function(bool) Settings.LegitKey = bool end
})
legitSection:toggle({
    name = "enabled (toggle)",
    flag = "legit_enabled",
    default = false,
    callback = function(val) Settings.LegitEnabled = val end
})
legitSection:slider({
    name = "fov",
    flag = "legit_fov",
    default = 100,
    min = 10,
    max = 500,
    interval = 1,
    callback = function(val) Settings.LegitFOV = val end
})
legitSection:slider({
    name = "smoothness",
    flag = "legit_smooth",
    default = 0.2,
    min = 0.01,
    max = 1,
    interval = 0.01,
    callback = function(val) Settings.LegitSmoothness = val end
})

-- ==========================================
-- VISUALS TAB
-- ==========================================
local espSection = Visuals:section({ name = "esp" })
espSection:toggle({
    name = "enabled",
    flag = "esp_enabled",
    default = false,
    callback = function(val) Settings.ESPEnabled = val end
})
espSection:toggle({
    name = "boxes",
    flag = "esp_box",
    default = true,
    callback = function(val) Settings.ESPBox = val end
})
espSection:toggle({
    name = "names",
    flag = "esp_name",
    default = true,
    callback = function(val) Settings.ESPName = val end
})
espSection:toggle({
    name = "health",
    flag = "esp_health",
    default = true,
    callback = function(val) Settings.ESPHealth = val end
})
espSection:toggle({
    name = "distance",
    flag = "esp_dist",
    default = true,
    callback = function(val) Settings.ESPDistance = val end
})
espSection:colorpicker({
    flag = "esp_color",
    color = Color3.fromRGB(255, 128, 0),
    callback = function(val) Settings.ESPColor = val end
})

local fovSection = Visuals:section({ name = "fov circle" })
fovSection:toggle({
    name = "show fov",
    flag = "fov_show",
    default = true,
    callback = function(val) Settings.FOVCircleEnabled = val end
})
fovSection:colorpicker({
    flag = "fov_color",
    color = Color3.fromRGB(255, 255, 255),
    callback = function(val) Settings.FOVCircleColor = val end
})

-- ==========================================
-- MISC TAB
-- ==========================================
local moveSection = Misc:section({ name = "movement" })
moveSection:toggle({
    name = "fly",
    flag = "fly_enabled",
    default = false,
    callback = function(val) Settings.FlyEnabled = val end
})
moveSection:slider({
    name = "fly speed",
    flag = "fly_speed",
    default = 50,
    min = 10,
    max = 200,
    interval = 1,
    callback = function(val) Settings.FlySpeed = val end
})
moveSection:toggle({
    name = "noclip",
    flag = "noclip_enabled",
    default = false,
    callback = function(val) Settings.NoclipEnabled = val end
})
moveSection:slider({
    name = "walkspeed",
    flag = "speed_val",
    default = 16,
    min = 16,
    max = 200,
    interval = 1,
    callback = function(val) 
        Settings.WalkSpeed = val
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end
})

-- ==========================================
-- CORE LOGIC: DRAWING API (ESP)
-- ==========================================
local ESP = { Drawings = {}, Connections = {} }
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 60
FOVCircle.Transparency = 1
FOVCircle.Filled = false

local function CreateESP(player)
    local Box = Drawing.new("Square")
    Box.Thickness = 1
    Box.Filled = false
    Box.Color = Settings.ESPColor
    
    local Name = Drawing.new("Text")
    Name.Size = 14
    Name.Center = true
    Name.Outline = true
    Name.Color = Color3.new(1,1,1)
    
    local HealthBar = Drawing.new("Square")
    HealthBar.Thickness = 1
    HealthBar.Filled = true
    HealthBar.Color = Color3.new(0, 255, 0)

    local Distance = Drawing.new("Text")
    Distance.Size = 14
    Distance.Center = true
    Distance.Outline = true
    Distance.Color = Color3.new(1,1,1)

    ESP.Drawings[player] = {Box = Box, Name = Name, Health = HealthBar, Distance = Distance}
end

local function RemoveESP(player)
    if ESP.Drawings[player] then
        for _, draw in pairs(ESP.Drawings[player]) do
            draw:Remove()
        end
        ESP.Drawings[player] = nil
    end
end

local function UpdateESP()
    if not Settings.ESPEnabled then
        for _, v in pairs(ESP.Drawings) do
            for _, d in pairs(v) do d.Visible = false end
        end
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            local head = char and char:FindFirstChild("Head")

            if hrp and hum and head and hum.Health > 0 then
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                
                if not ESP.Drawings[player] then CreateESP(player) end
                local d = ESP.Drawings[player]

                if onScreen then
                    local height = math.abs(headPos.Y - hrpPos.Y) * 2.5
                    local width = height / 2

                    d.Box.Size = Vector2.new(width, height)
                    d.Box.Position = Vector2.new(hrpPos.X - width/2, headPos.Y)
                    d.Box.Color = Settings.ESPColor
                    d.Box.Visible = Settings.ESPBox

                    d.Name.Text = player.Name
                    d.Name.Position = Vector2.new(hrpPos.X, headPos.Y - 18)
                    d.Name.Visible = Settings.ESPName

                    local hpPerc = hum.Health / hum.MaxHealth
                    d.Health.Size = Vector2.new(2, height * hpPerc)
                    d.Health.Position = Vector2.new(hrpPos.X - width/2 - 5, headPos.Y + (height - (height * hpPerc)))
                    d.Health.Color = Color3.fromRGB(255 * (1 - hpPerc), 255 * hpPerc, 0)
                    d.Health.Visible = Settings.ESPHealth

                    local dist = math.floor((hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
                    d.Distance.Text = tostring(dist) .. " studs"
                    d.Distance.Position = Vector2.new(hrpPos.X, headPos.Y + height + 2)
                    d.Distance.Visible = Settings.ESPDistance
                else
                    for _, draw in pairs(d) do draw.Visible = false end
                end
            else
                if ESP.Drawings[player] then
                    for _, draw in pairs(ESP.Drawings[player]) do draw.Visible = false end
                end
            end
        end
    end
end

-- ==========================================
-- CORE LOGIC: AIMBOT & TRIGGERBOT
-- ==========================================
local function GetClosestTarget(fov, targetPart)
    local closest = nil
    local distance = fov
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character then
            local part = player.Character:FindFirstChild(targetPart)
            local hum = player.Character:FindFirstChild("Humanoid")
            
            if part and hum and hum.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local distFromMouse = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if distFromMouse < distance then
                        -- Wall Check
                        if Settings.RageWallCheck then
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {LocalPlayer.Character, player.Character}
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude
                            local ray = Workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, rayParams)
                            if ray then continue end -- Wall in the way
                        end
                        
                        distance = distFromMouse
                        closest = part
                    end
                end
            end
        end
    end
    return closest
end

-- ==========================================
-- CORE LOGIC: MAIN RENDER LOOP
-- ==========================================
RunService.RenderStepped:Connect(function()
    UpdateESP()

    -- FOV Circle
    if Settings.FOVCircleEnabled then
        FOVCircle.Visible = true
        FOVCircle.Position = UserInputService:GetMouseLocation()
        FOVCircle.Radius = Settings.RageEnabled or Settings.RageKey and Settings.RageFOV or Settings.LegitFOV
        FOVCircle.Color = Settings.FOVCircleColor
    else
        FOVCircle.Visible = false
    end

    -- Ragebot Logic
    if Settings.RageEnabled or Settings.RageKey then
        local target = GetClosestTarget(Settings.RageFOV, Settings.RageTargetPart)
        if target then
            local targetPos = target.Position
            
            -- Simple Prediction
            if Settings.RagePrediction > 0 and target.Parent:FindFirstChild("HumanoidRootPart") then
                targetPos = targetPos + (target.Parent.HumanoidRootPart.Velocity * Settings.RagePrediction)
            end
            
            -- Snap Camera
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
        end
    end

    -- Legit Aimbot Logic
    if (Settings.LegitEnabled or Settings.LegitKey) and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestTarget(Settings.LegitFOV, Settings.LegitTargetPart)
        if target then
            local targetPos = target.Position
            local currentCFrame = Camera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
            
            Camera.CFrame = currentCFrame:Lerp(targetCFrame, Settings.LegitSmoothness)
        end
    end
end)

-- ==========================================
-- CORE LOGIC: TRIGGERBOT
-- ==========================================
RunService.Heartbeat:Connect(function()
    if Settings.TriggerEnabled then
        local mouse = LocalPlayer:GetMouse()
        if mouse.Target and mouse.Target.Parent then
            local char = mouse.Target.Parent
            local hum = char:FindFirstChild("Humanoid")
            local player = Players:GetPlayerFromCharacter(char)
            
            if player and player ~= LocalPlayer and hum and hum.Health > 0 then
                local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                if tool then
                    task.wait(Settings.TriggerDelay)
                    tool:Activate()
                end
            end
        end
    end
end)

-- ==========================================
-- CORE LOGIC: FLY & NOCLIP
-- ==========================================
local FlyBV = nil
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    
    -- Noclip
    if Settings.NoclipEnabled then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    
    -- Fly
    if Settings.FlyEnabled and hrp and hum then
        if not FlyBV then
            FlyBV = Instance.new("BodyVelocity")
            FlyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            FlyBV.Velocity = Vector3.new(0,0,0)
            FlyBV.Parent = hrp
        end
        
        local moveDir = hum.MoveDirection
        local vertical = 0
        
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vertical = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vertical = -1 end
        
        local finalVel = (Camera.CFrame.LookVector * moveDir.Z + Camera.CFrame.RightVector * moveDir.X) * Settings.FlySpeed
        FlyBV.Velocity = finalVel + Vector3.new(0, vertical * Settings.FlySpeed, 0)
    else
        if FlyBV then
            FlyBV:Destroy()
            FlyBV = nil
        end
    end
end)

-- Cleanup
Players.PlayerRemoving:Connect(RemoveESP)

-- Open Main Tab by default
Main.open_tab()