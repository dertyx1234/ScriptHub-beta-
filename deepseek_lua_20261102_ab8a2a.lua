--[[ 
    ScriptHub UI Wrapper for Nebula Counter
    Original Logic: Nebula Counter
    UI: Rayfield (Blue Theme + Anime Background)
]]

-- ======================== NEBULA COUNTER LOGIC (UNCHANGED) ========================
local DEFAULTS = {
	CtrOn = false,
	CtrMode = "ue counter", -- "ue counter" | "Kicia counter" | "Solix counter"
	CtrHud = true,
	-- Kicia / Solix
	CtrKiciaCycleMs = 50,
	CtrKiciaFlyMs = 25,
	CtrKiciaBoost = 100000,
	CtrKiciaBoostMs = 600,
	CtrKiciaFlySpeed = 15000,
	CtrKiciaZigAmp = 400,
	CtrKiciaZigFreq = 8,
	CtrKiciaDepth = 6,
	CtrKiciaRadius = 30,
	-- UE counter
	CtrVoidSpeed = 3000,
	CtrLegits = true,
	CtrBots = true,
	CtrMaxLegits = 1,
	CtrLegitDelay = 3,
	CtrLegitStay = 35, CtrLegitGap = 50, CtrLegitLead = 6,
	CtrBotStay = 35, CtrBotGap = 50, CtrBotLead = 6,
}
local function cfg(key, default)
	return DEFAULTS[key] ~= nil and DEFAULTS[key] or default
end

local MODE_UE, MODE_KICIA, MODE_SOLIX = "ue counter", "Kicia counter", "Solix counter"

local function hudTitle(mode)
	local tag = (mode == MODE_KICIA and "KICIA") or (mode == MODE_SOLIX and "SOLIX")
	return ("NEBULA COUNTER [%s]"):format(tag or "UE")
end

local K = {
	t0 = 0, boostAt = 0,
	fly = Vector3.zero,
	stop = nil,
	stopIdx = -1,
	spawn = nil,
	list = {}, last = nil
}

local function cycleTimes()
	local cycle = math.max(cfg("CtrKiciaCycleMs", 50), 5) / 1000
	local flyWindow = math.min(cfg("CtrKiciaFlyMs", 25) / 1000, cycle * 0.95)
	return cycle, flyWindow
end

local function buildSpawnList(spawn, rageBlockers, rageSpotSafe)
	K.spawn = spawn
	K.list = {}
	local blockers = rageBlockers and rageBlockers()
	local params = blockers and blockers.params
	if not params then return end

	local depth = cfg("CtrKiciaDepth", 6)
	local radius = cfg("CtrKiciaRadius", 30)
	local rng = Random.new()

	for _ = 1, 60 do
		if #K.list >= 16 then break end
		local angle = rng:NextNumber(0, math.pi * 2)
		local dist = rng:NextNumber(4, math.max(radius, 5))
		local origin = spawn + Vector3.new(math.cos(angle) * dist, 8, math.sin(angle) * dist)
		local ok, hit = pcall(function()
			return workspace:Raycast(origin, Vector3.new(0, -30, 0), params)
		end)
		if ok and hit and hit.Normal.Y > 0.7 then
			local spot = hit.Position - Vector3.new(0, depth, 0)
			if not rageSpotSafe or rageSpotSafe(spot) then
				K.list[#K.list + 1] = spot
			end
		end
	end
end

local function resolveStopPos(mode, spawn, rageBlockers, rageSpotSafe)
	local fallback = spawn - Vector3.new(0, cfg("CtrKiciaDepth", 6), 0)
	if mode ~= MODE_SOLIX then return fallback end

	if K.spawn ~= spawn then buildSpawnList(spawn, rageBlockers, rageSpotSafe) end
	local n = #K.list
	if n == 0 then return fallback end

	local idx = math.random(1, n)
	if n > 1 and idx == K.last then idx = idx % n + 1 end
	K.last = idx
	return K.list[idx]
end

local function kiciaSolixStep(mode, root, dt, rageBlockers, rageSpotSafe)
	local now = os.clock()
	local t = now - K.t0
	local cycle, flyWindow = cycleTimes()
	local flying = (t % cycle) < flyWindow

	if now >= K.boostAt then
		if flying then
			K.fly += Vector3.new(0, cfg("CtrKiciaBoost", 100000), 0)
		end
		K.boostAt = now + cfg("CtrKiciaBoostMs", 600) / 1000
	end

	if not flying then
		local idx = math.floor(t / cycle)
		if idx ~= K.stopIdx or not K.stop then
			K.stopIdx = idx
			K.stop = resolveStopPos(mode, K.spawn, rageBlockers, rageSpotSafe)
		end
		root.CFrame = CFrame.new(K.stop) * CFrame.Angles(math.pi / 2, 0, 0)
	else
		local zig = math.cos(t * cfg("CtrKiciaZigFreq", 8)) * cfg("CtrKiciaZigAmp", 400) * dt
		K.fly += Vector3.new(zig, cfg("CtrKiciaFlySpeed", 15000) * dt, 0)
		root.CFrame = CFrame.new(K.fly) * CFrame.Angles(-math.pi / 2, 0, 0)
	end
	root.AssemblyLinearVelocity = Vector3.zero
end

local function kiciaSolixInit(root, now)
	K.t0 = now
	K.boostAt = now
	K.spawn = root.Position
	K.fly = root.Position
	K.stop, K.stopIdx = nil, -1
end

local UE = {
	legit = { last = 0, inPos = false },
	bot   = { last = 0, inPos = false },
	voidState = 2, voidT = 0, lastRandTp = 0,
}

local function ueCounterStep(now, dt, target, isLegit, helpers, setStatus)
	local char = helpers.getCharacter()
	local root = helpers.getRoot()
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not (root and hum) then return end

	helpers.prepCharacter(char)
	pcall(function()
		hum.PlatformStand = true
		hum.WalkSpeed = 0
	end)

	if target then
		local tRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
		if tRoot then
			local P = isLegit and "Legit" or "Bot"
			local stay = cfg("Ctr" .. P .. "Stay", 35) / 100
			local gap = cfg("Ctr" .. P .. "Gap", 50) / 100
			local lead = cfg("Ctr" .. P .. "Lead", 6)
			local slot = isLegit and UE.legit or UE.bot

			if not slot.inPos then
				if now - slot.last >= gap then slot.inPos, slot.last = true, now end
			elseif now - slot.last >= stay then
				pcall(helpers.sendToVoid, root)
				slot.inPos, slot.last = false, now
			end

			if slot.inPos then
				local pos = tRoot.Position
				local vel = tRoot.AssemblyLinearVelocity
				if vel.Magnitude > 0.5 then pos += vel.Unit * lead end

				if helpers.isUnderMap(pos) then
					pcall(helpers.sendToVoid, root)
					setStatus("target went under the map")
					return
				end
				pcall(function()
					root.CFrame = CFrame.new(pos + Vector3.new(0, 0, 1), pos + tRoot.CFrame.LookVector)
						* CFrame.Angles(-math.pi / 2, 0, 0)
					root.AssemblyLinearVelocity = Vector3.zero
				end)
				setStatus(("on %s"):format(target.Name:sub(1, 14)))
				return
			end

			pcall(helpers.sendToVoid, root)
			setStatus(("waiting on %s"):format(target.Name:sub(1, 14)))
			return
		end
	end

	local elapsed = now - UE.voidT
	if UE.voidState == 1 then
		if elapsed >= 15 then
			UE.voidState, UE.voidT = 2, now
		else
			pcall(function()
				root.AssemblyLinearVelocity = Vector3.new(0, cfg("CtrVoidSpeed", 3000), 0)
			end)
			if now - UE.lastRandTp >= 10 then
				UE.lastRandTp = now
				pcall(function()
					root.CFrame = CFrame.new(root.Position + Vector3.new(
						math.random(-2500, 2500), math.random(500, 1200), math.random(-2500, 2500)
					)) * CFrame.Angles(-math.pi / 2, 0, 0)
				end)
			end
		end
	else
		local y = root.Position.Y
		local floorY = helpers.mapCentreY and helpers.mapCentreY() or (y - 1000)
		pcall(function()
			root.CFrame = CFrame.new(root.Position.X, y - (y - floorY) * 0.5, root.Position.Z)
				* CFrame.Angles(-math.pi / 2, 0, 0)
		end)
		UE.voidState, UE.voidT, UE.lastRandTp = 1, now, now
	end
	setStatus("in the void")
end

local S = { started = false, mode = nil, status = "off" }

local function counterTick(now, dt, env)
	local on = cfg("CtrOn", false)
	local rageOn = env.rageActive or (env.rageWanted and env.rageWanted())

	if on and rageOn then
		if S.started then env.stop(true) end
		S.status = "paused - ragebot is on"
		env.say(S.status)
		return
	end
	if not on then
		if S.started then env.stop() end
		env.say("off")
		return
	end

	local mode = cfg("CtrMode", MODE_UE)
	if S.started and S.mode and mode ~= S.mode then
		S.status = ("restart to switch to %s"):format(mode)
		env.say(S.status)
		mode = S.mode
	end

	local root = env.getRoot()
	if not root then env.say("no character") return end

	if not S.started then
		S.started, S.mode = true, mode
		if mode == MODE_KICIA or mode == MODE_SOLIX then kiciaSolixInit(root, now) end
		if mode == MODE_UE then pcall(env.ueInit, root) end
	end

	if mode == MODE_KICIA or mode == MODE_SOLIX then
		pcall(kiciaSolixStep, mode, root, dt, env.rageBlockers, env.rageSpotSafe)
	else
		local delay = cfg("CtrLegitDelay", 3)
		local armed = delay <= 0 or now - env.lastArmTime >= delay
		local target, isLegit = nil, false

		if cfg("CtrLegits", true) and armed then
			local legit, legitCount = env.findLegit()
			if legit then
				target, isLegit = legit, true
			elseif legitCount > math.floor(cfg("CtrMaxLegits", 1)) then
				S.status = ("%d legits, over the cap"):format(legitCount)
			end
		end
		if not target and cfg("CtrBots", true) and #env.bots > 0 then
			target, isLegit = env.bots[1], false
		end

		pcall(ueCounterStep, now, dt, target, isLegit, env.helpers, function(s) S.status = s end)

		if not armed and S.status == "in the void" then
			S.status = ("legits arm in %.1fs"):format(delay - (now - env.lastArmTime))
		end
		if env.playerCount == 0 then S.status = "nobody in the server" end
	end

	env.say(("%s - %s"):format(S.mode or "?", S.status))
end


-- ======================== UI SETUP (RAYFIELD) ========================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Change Theme to Blue
local blueTheme = {
    TextColor = Color3.fromRGB(240, 240, 240),
    Background = Color3.fromRGB(20, 20, 30),
    Topbar = Color3.fromRGB(15, 15, 25),
    Tab = Color3.fromRGB(25, 25, 35),
    TabActive = Color3.fromRGB(0, 100, 255), -- Blue accent
    Toggle = Color3.fromRGB(0, 120, 255),    -- Blue toggle
    Slider = Color3.fromRGB(0, 100, 255),
    Dropdown = Color3.fromRGB(30, 30, 40),
    Section = Color3.fromRGB(40, 40, 55),
}

local Window = Rayfield:CreateWindow({
    Name = "ScriptHub",
    LoadingTitle = "ScriptHub",
    LoadingSubtitle = "Nebula Counter Edition",
    Theme = "Dark",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Inject Anime Background & Watermark
task.spawn(function()
    task.wait(0.5)
    local Gui = game:GetService("CoreGui"):FindFirstChild("Rayfield") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("Rayfield")
    if Gui and Gui:FindFirstChild("Main") then
        -- Anime Girl Image
        local Image = Instance.new("ImageLabel")
        Image.Parent = Gui.Main
        Image.BackgroundTransparency = 1
        Image.Image = "rbxassetid://1316045217" -- Anime Girl Background
        Image.Size = UDim2.new(0, 450, 0, 650)
        Image.Position = UDim2.new(0.5, -225, 0.5, -300)
        Image.ZIndex = 0 
        
        -- Bottom Watermark
        local Watermark = Instance.new("TextLabel")
        Watermark.Parent = Gui.Main
        Watermark.BackgroundTransparency = 1
        Watermark.Size = UDim2.new(0, 200, 0, 30)
        Watermark.Position = UDim2.new(0, 20, 1, -40)
        Watermark.Text = "calmzash2010 | 29 days left"
        Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
        Watermark.Font = Enum.Font.GothamBold
        Watermark.TextSize = 14
        Watermark.TextXAlignment = Enum.TextXAlignment.Left
        Watermark.ZIndex = 2
    end
end)

-- Apply Blue Theme
Rayfield:SetTheme(blueTheme)

-- ======================== TABS ========================
local MainTab = Window:CreateTab("Main", 4483362458)
local RageTab = Window:CreateTab("Rage", 4483362458) -- Matches your screenshot
local LegitTab = Window:CreateTab("Legit", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- ======================== MAIN TAB ========================
MainTab:CreateSection("Nebula Counter")
MainTab:CreateToggle({ Name = "Master Enabled", CurrentValue = DEFAULTS.CtrOn, Flag = "CtrOn", Callback = function(v) DEFAULTS.CtrOn = v end })
MainTab:CreateDropdown({ 
    Name = "Counter Mode", 
    Options = {"ue counter", "Kicia counter", "Solix counter"}, 
    CurrentOption = {DEFAULTS.CtrMode}, 
    Flag = "CtrMode", 
    Callback = function(o) DEFAULTS.CtrMode = o[1] end 
})

-- ======================== RAGE TAB (Matching UI Layout) ========================
RageTab:CreateSection("Main")
RageTab:CreateToggle({ Name = "Enabled", CurrentValue = false, Flag = "RageEnabled", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Silent aim", CurrentValue = false, Flag = "SilentAim", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Automatic fire", CurrentValue = false, Flag = "AutoFire", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Aim through walls", CurrentValue = false, Flag = "AimWalls", Callback = function(v) end })

RageTab:CreateSection("Selection")
RageTab:CreateDropdown({ Name = "Target", Options = {"Highest damage", "Lowest health", "Closest"}, CurrentOption = {"Highest damage"}, Flag = "TargetMode", Callback = function(o) end })
RageTab:CreateDropdown({ Name = "Hitboxes", Options = {"Head", "Chest"}, CurrentOption = {"Head", "Chest"}, MultipleOptions = true, Flag = "Hitboxes", Callback = function(o) end })
RageTab:CreateDropdown({ Name = "Multipoint", Options = {"Head", "Chest"}, CurrentOption = {"Head", "Chest"}, MultipleOptions = true, Flag = "Multipoint", Callback = function(o) end })
RageTab:CreateSlider({ Name = "Hit chance", Range = {0, 100}, Increment = 1, Suffix = "%", CurrentValue = 50, Flag = "HitChance", Callback = function(v) end })
RageTab:CreateSlider({ Name = "Minimum damage", Range = {0, 100}, Increment = 1, CurrentValue = 15, Flag = "MinDamage", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Quick stop", CurrentValue = true, Flag = "QuickStop", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Quick scope", CurrentValue = true, Flag = "QuickScope", Callback = function(v) end })

RageTab:CreateSection("Other")
RageTab:CreateDropdown({ Name = "History", Options = {"High", "Medium", "Low"}, CurrentOption = {"High"}, Flag = "History", Callback = function(o) end })
RageTab:CreateToggle({ Name = "Delay shot", CurrentValue = false, Flag = "DelayShot", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Remove recoil", CurrentValue = false, Flag = "RemoveRecoil", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Remove spread", CurrentValue = false, Flag = "RemoveSpread", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Duck peek assist", CurrentValue = false, Flag = "DuckPeek", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Quick peek assist", CurrentValue = false, Flag = "QuickPeek", Callback = function(v) end })
RageTab:CreateToggle({ Name = "Double tap", CurrentValue = false, Flag = "DoubleTap", Callback = function(v) end })

RageTab:CreateSection("Anti-aim")
RageTab:CreateToggle({ Name = "Enabled", CurrentValue = false, Flag = "AntiAim", Callback = function(v) end })
RageTab:CreateDropdown({ Name = "Pitch", Options = {"Off", "Up", "Down"}, CurrentOption = {"Off"}, Flag = "Pitch", Callback = function(o) end })
RageTab:CreateDropdown({ Name = "Yaw", Options = {"Off", "Left", "Right"}, CurrentOption = {"Off"}, Flag = "Yaw", Callback = function(o) end })
RageTab:CreateDropdown({ Name = "Freestanding", Options = {"Off", "Auto"}, CurrentOption = {"Off"}, Flag = "Free", Callback = function(o) end })
RageTab:CreateDropdown({ Name = "Mouse override", Options = {"Off", "On"}, CurrentOption = {"Off"}, Flag = "Mouse", Callback = function(o) end })

-- ======================== LEGIT TAB ========================
LegitTab:CreateSection("Legit Counter Settings (UE)")
LegitTab:CreateToggle({ Name = "Use Legits", CurrentValue = DEFAULTS.CtrLegits, Flag = "CtrLegits", Callback = function(v) DEFAULTS.CtrLegits = v end })
LegitTab:CreateSlider({ Name = "Max Legits", Range = {1, 10}, Increment = 1, CurrentValue = DEFAULTS.CtrMaxLegits, Flag = "CtrMaxLegits", Callback = function(v) DEFAULTS.CtrMaxLegits = v end })
LegitTab:CreateSlider({ Name = "Legit Delay (s)", Range = {0, 10}, Increment = 1, CurrentValue = DEFAULTS.CtrLegitDelay, Flag = "CtrLegitDelay", Callback = function(v) DEFAULTS.CtrLegitDelay = v end })

-- ======================== VISUALS TAB ========================
VisualsTab:CreateSection("Interface")
VisualsTab:CreateToggle({ Name = "HUD Enabled", CurrentValue = DEFAULTS.CtrHud, Flag = "CtrHud", Callback = function(v) DEFAULTS.CtrHud = v end })

-- ======================== MISC TAB ========================
MiscTab:CreateSection("Kicia / Solix Settings")
MiscTab:CreateSlider({ Name = "Cycle (ms)", Range = {5, 100}, Increment = 1, CurrentValue = DEFAULTS.CtrKiciaCycleMs, Flag = "CtrKiciaCycleMs", Callback = function(v) DEFAULTS.CtrKiciaCycleMs = v end })
MiscTab:CreateSlider({ Name = "Fly Time (ms)", Range = {5, 50}, Increment = 1, CurrentValue = DEFAULTS.CtrKiciaFlyMs, Flag = "CtrKiciaFlyMs", Callback = function(v) DEFAULTS.CtrKiciaFlyMs = v end })
MiscTab:CreateSlider({ Name = "Boost Power", Range = {1000, 200000}, Increment = 1000, CurrentValue = DEFAULTS.CtrKiciaBoost, Flag = "CtrKiciaBoost", Callback = function(v) DEFAULTS.CtrKiciaBoost = v end })
MiscTab:CreateSlider({ Name = "Fly Speed", Range = {1000, 30000}, Increment = 1000, CurrentValue = DEFAULTS.CtrKiciaFlySpeed, Flag = "CtrKiciaFlySpeed", Callback = function(v) DEFAULTS.CtrKiciaFlySpeed = v end })

MiscTab:CreateSection("UE Settings")
MiscTab:CreateToggle({ Name = "Use Bots", CurrentValue = DEFAULTS.CtrBots, Flag = "CtrBots", Callback = function(v) DEFAULTS.CtrBots = v end })
MiscTab:CreateSlider({ Name = "Void Speed", Range = {500, 10000}, Increment = 100, CurrentValue = DEFAULTS.CtrVoidSpeed, Flag = "CtrVoidSpeed", Callback = function(v) DEFAULTS.CtrVoidSpeed = v end })

-- ======================== ENVIRONMENT & RUN LOOP ========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local lastArmTime = tick()

-- Dummy helpers to prevent the script from breaking (since we didn't change logic)
local env = {
    getRoot = function()
        local char = LocalPlayer.Character
        return char and char:FindFirstChild("HumanoidRootPart")
    end,
    say = function(msg)
        if DEFAULTS.CtrHud then
            -- Optional: print to console or update a Rayfield notification
            -- print("Counter: " .. msg)
        end
    end,
    rageActive = false,
    rageWanted = function() return false end,
    findLegit = function() return nil, 0 end,
    bots = {},
    playerCount = #Players:GetPlayers(),
    lastArmTime = lastArmTime,
    ueInit = function() end,
    stop = function() end,
    rageBlockers = function() 
        return { params = RaycastParams.new() } 
    end,
    rageSpotSafe = function() return true end,
    helpers = {
        getCharacter = function() return LocalPlayer.Character end,
        getRoot = function() 
            local char = LocalPlayer.Character
            return char and char:FindFirstChild("HumanoidRootPart")
        end,
        prepCharacter = function(char)
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end,
        sendToVoid = function(root)
            root.CFrame = CFrame.new(0, -5000, 0)
        end,
        isUnderMap = function(pos) return false end,
        mapCentreY = function() 
            local root = env.getRoot()
            return root and root.Position.Y - 1000 or 0 
        end
    }
}

-- Main Execution Loop
RunService.Heartbeat:Connect(function(dt)
    local now = tick()
    env.playerCount = #Players:GetPlayers()
    env.lastArmTime = lastArmTime
    pcall(function()
        counterTick(now, dt, env)
    end)
end)

-- Open Main Tab by default
MainTab:Select()