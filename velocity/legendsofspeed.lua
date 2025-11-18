--[[
Byte Software - Velocity
---------------------------------
Credits:
  - Byt3c0de (www.byt3c0de.net | @byt3c0de.net)
  - Byte Software (www.bytesoftware.net | discord.gg/bytesoftware)
  - Everyone who has supported me on this journey

I’ve created these scripts and am sharing them openly so that others can learn, experiment, and build amazing projects. 
I hope my code inspires creativity and helps you on your own development journey!

Have fun coding!
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local placeId = game.PlaceId
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local Library = loadstring(game:HttpGet("https://bytesoftware.net/roblox/velocity/library.lua", true))()
local Window = Library:CreateWindow()

local UPDATE_INTERVAL = 0.5
local MAX_PING = 10000
local player = Players.LocalPlayer

local function getPlayerCount()
    return #Players:GetPlayers()
end

local function getPing()
    local ok, network = pcall(function() return Stats.Network end)
    if not ok or not network then return 0 end

    local success, item = pcall(function() return network.ServerStatsItem and network.ServerStatsItem["Data Ping"] end)
    if not success or not item or not item.GetValueString then return 0 end

    local s = ""
    local ok2, vs = pcall(function() return item:GetValueString() end)
    if ok2 and vs then s = vs end

    local n = s:match("%d+")
    return tonumber(n) or 0
end

local function clampPing(p)
    if math.clamp then
        return math.clamp(p, 0, MAX_PING)
    end
    if p < 0 then return 0 end
    if p > MAX_PING then return MAX_PING end
    return p
end

local function getServerList(url)
    local raw = game:HttpGet(url)
    return HttpService:JSONDecode(raw)
end

function LowestPlayer()
    local api = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local nextCursor, server
    repeat
        local servers = getServerList(api .. (nextCursor and "&cursor=" .. nextCursor or ""))
        server = servers.data[1]
        nextCursor = servers.nextPageCursor
    until server
    TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
end

function Rejoin()
    TeleportService:TeleportToPlaceInstance(placeId, game.JobId, player)
end

function Serverhop()
    local api = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
    local nextCursor, chosen
    repeat
        local servers = getServerList(api .. (nextCursor and "&cursor=" .. nextCursor or ""))
        for _, s in ipairs(servers.data) do
            if s.maxPlayers > s.playing then
                chosen = s
                break
            end
        end
        nextCursor = servers.nextPageCursor
    until chosen
    TeleportService:TeleportToPlaceInstance(placeId, chosen.id, player)
end

local function teleportTo(cframe)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
end

local Monitor = Window:CreateTab("89806884478792")
local Utilities = Window:CreateTab("111184411694819")
local Races = Window:CreateTab("120597583592174")
local Assistants = Window:CreateTab("102008408964707")
local Automation = Window:CreateTab("94348470126234")
local Rebirths = Window:CreateTab("108237910563314")
local Pets = Window:CreateTab("139641477320360")
local Trails = Window:CreateTab("136500962649657")
local Crystals = Window:CreateTab("139940719712739")
local Ultimates = Window:CreateTab("80583724503359")
local Teleports = Window:CreateTab("122310360922180")
local Experimental = Window:CreateTab("140421673042839")

Monitor:CreateSection("Server Stats")
Monitor.serverStats1 = Monitor:CreateLabel("Players: ")
Monitor.serverStats2 = Monitor:CreateLabel("Ping: ")
Monitor.serverStats3 = Monitor:CreateLabel("Job ID: ")

local function updateServerStats()
    local players = getPlayerCount()
    local ping = clampPing(getPing())
    local jobId = tostring(game.JobId or "N/A")

    Monitor.serverStats1.SetText(string.format("<b>Players: %d</b>", players))
    Monitor.serverStats2.SetText(string.format("<b>Ping: %dms</b>", ping))
    Monitor.serverStats3.SetText(string.format("<b>Job ID: %s</b>", jobId))
end

do
    local acc = 0
    RunService.Heartbeat:Connect(function(dt)
        acc = acc + dt
        if acc >= UPDATE_INTERVAL then
            acc = 0
            pcall(updateServerStats)
        end
    end)
end

Monitor:CreateButton("Copy Stats", function()
    local players = getPlayerCount()
    local ping = clampPing(getPing())
    local jobId = tostring(game.JobId or "N/A")

    local text = string.format("Players: %d\nPing: %dms\nJob ID: %s", players, ping, jobId)

    if type(setclipboard) == "function" then
        pcall(setclipboard, text)
    end
end)

pcall(updateServerStats)

Monitor:CreateSection("Player Stats")
Monitor.playerStats1 = Monitor:CreateLabel("Username: ")
Monitor.playerStats2 = Monitor:CreateLabel("Steps: ")
Monitor.playerStats3 = Monitor:CreateLabel("Rebirths: ")
Monitor.playerStats4 = Monitor:CreateLabel("Hoops: ")
Monitor.playerStats5 = Monitor:CreateLabel("Races: ")

local function getStat(leaderstats, name)
    local stat = leaderstats and leaderstats:FindFirstChild(name)
    return stat and stat.Value or 0
end

local function updatePlayerStats()
    local leaderstats = player:FindFirstChild("leaderstats")

    Monitor.playerStats1.SetText("Username: " .. player.Name)

    if leaderstats then
        Monitor.playerStats2.SetText("Steps: " .. getStat(leaderstats, "Steps"))
        Monitor.playerStats3.SetText("Rebirths: " .. getStat(leaderstats, "Rebirths"))
        Monitor.playerStats4.SetText("Hoops: " .. getStat(leaderstats, "Hoops"))
        Monitor.playerStats5.SetText("Races: " .. getStat(leaderstats, "Races"))
    else
        Monitor.playerStats2.SetText("Steps: N/A")
        Monitor.playerStats3.SetText("Rebirths: N/A")
        Monitor.playerStats4.SetText("Hoops: N/A")
        Monitor.playerStats5.SetText("Races: N/A")
    end
end


local function connectStatListeners()
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end

    for _, statName in ipairs({"Steps", "Rebirths", "Hoops", "Races"}) do
        local stat = leaderstats:FindFirstChild(statName)
        if stat then
            stat.Changed:Connect(function()
                updatePlayerStats()
            end)
        end
    end
end

player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        task.wait(0.2)
        connectStatListeners()
        updatePlayerStats()
    end
end)

RunService.Heartbeat:Connect(function()
    updatePlayerStats()
end)

Monitor:CreateButton("Copy Stats", function()
    local leaderstats = player:FindFirstChild("leaderstats")
    local steps = getStat(leaderstats, "Steps")
    local rebirths = getStat(leaderstats, "Rebirths")
    local hoops = getStat(leaderstats, "Hoops")
    local races = getStat(leaderstats, "Races")

    local text = string.format(
        "Username: %s\nSteps: %s\nRebirths: %s\nHoops: %s\nRaces: %s",
        player.Name, steps, rebirths, hoops, races
    )

    if typeof(setclipboard) == "function" then
        pcall(setclipboard, text)
    end
end)

updatePlayerStats()
connectStatListeners()

Monitor:CreateSection("Session Stats")
Monitor.sessionStats1 = Monitor:CreateLabel("Runtime: ")
Monitor.sessionStats2 = Monitor:CreateLabel("Steps: ")
Monitor.sessionStats3 = Monitor:CreateLabel("Rebirths: ")
Monitor.sessionStats4 = Monitor:CreateLabel("Hoops: ")
Monitor.sessionStats5 = Monitor:CreateLabel("Races: ")

local startTime = os.time()
local sessionStats = {
    Steps = 0,
    Rebirths = 0,
    Hoops = 0,
    Races = 0
}

local leaderstats = player:FindFirstChild("leaderstats")
local initialStats = {}
if leaderstats then
    for _, statName in ipairs({"Steps","Rebirths","Hoops","Races"}) do
        local stat = leaderstats:FindFirstChild(statName)
        initialStats[statName] = stat and stat.Value or 0
    end
end

local function updateSessionStats()
    local leaderstats = player:FindFirstChild("leaderstats")
    local currentTime = os.time()
    local runtimeSeconds = currentTime - startTime
    local hours = math.floor(runtimeSeconds / 3600)
    local minutes = math.floor((runtimeSeconds % 3600) / 60)
    local seconds = runtimeSeconds % 60
    Monitor.sessionStats1.SetText(string.format("Runtime: %02d:%02d:%02d", hours, minutes, seconds))

    if leaderstats then
        for _, statName in ipairs({"Steps","Rebirths","Hoops","Races"}) do
            local stat = leaderstats:FindFirstChild(statName)
            local initial = initialStats[statName] or 0
            local value = stat and stat.Value - initial or 0
            sessionStats[statName] = value
        end
    end

    Monitor.sessionStats2.SetText("Steps: " .. sessionStats.Steps)
    Monitor.sessionStats3.SetText("Rebirths: " .. sessionStats.Rebirths)
    Monitor.sessionStats4.SetText("Hoops: " .. sessionStats.Hoops)
    Monitor.sessionStats5.SetText("Races: " .. sessionStats.Races)
end

local function connectStatListeners()
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end

    for _, statName in ipairs({"Steps","Rebirths","Hoops","Races"}) do
        local stat = leaderstats:FindFirstChild(statName)
        if stat then
            stat.Changed:Connect(updateSessionStats)
        end
    end
end

player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        task.wait(0.2)
        connectStatListeners()
        updateSessionStats()
    end
end)

RunService.Heartbeat:Connect(updateSessionStats)

Monitor:CreateButton("Copy Stats", function()
    local currentTime = os.time()
    local runtimeSeconds = currentTime - startTime
    local hours = math.floor(runtimeSeconds / 3600)
    local minutes = math.floor((runtimeSeconds % 3600) / 60)
    local seconds = runtimeSeconds % 60

    local text = string.format(
        "Runtime: %02d:%02d:%02d\nSteps: %d\nRebirths: %d\nHoops: %d\nRaces: %d",
        hours, minutes, seconds,
        sessionStats.Steps, sessionStats.Rebirths, sessionStats.Hoops, sessionStats.Races
    )

    if typeof(setclipboard) == "function" then
        pcall(setclipboard, text)
    end
end)

connectStatListeners()
updateSessionStats()

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

Monitor:CreateSection("Pets Stats")
Monitor.petsStats1 = Monitor:CreateLabel("Equipped: N/A")
Monitor.petsStats2 = Monitor:CreateLabel("Total Steps: N/A")
Monitor.petsStats3 = Monitor:CreateLabel("Total Gems: N/A")

Monitor:CreateButton("Copy Stats", function()
    local function getLabelNumber(label)
        if label and label.Text then
            local num = label.Text:match("%d+")
            num = num or 0
            return num
        end
        return 0
    end

    local equipped = Monitor._equippedCount or 0
    local steps = Monitor._totalSteps or 0
    local gems = Monitor._totalGems or 0

    local text = string.format(
        "Equipped Pets: %s\nTotal Steps: %s\nTotal Gems: %s",
        equipped,
        steps,
        gems
    )

    if typeof(setclipboard) == "function" then
        pcall(setclipboard, text)
    end
end)

repeat task.wait() until player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("gameGui")
local petMenu = player.PlayerGui.gameGui:FindFirstChild("petsMenu")
local petInfoMenu = petMenu and petMenu:FindFirstChild("petInfoMenu")

local equippedPetsLabel = petInfoMenu and petInfoMenu:FindFirstChild("petsLabel")
local petStepsLabel = petInfoMenu and petInfoMenu:FindFirstChild("totalStepsLabel") and petInfoMenu.totalStepsLabel:FindFirstChild("stepsLabel")
local petGemsLabel = petInfoMenu and petInfoMenu:FindFirstChild("totalGemsLabel") and petInfoMenu.totalGemsLabel:FindFirstChild("gemsLabel")

local function convertFormattedNumber(text)
    if not text then return 0 end
    local num, suffix = text:match("([%d%.]+)([KMBT]?)")
    if not num then return 0 end
    num = tonumber(num) or 0
    local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
    local multiplier = multipliers[suffix] or 1
    return math.floor(num * multiplier)
end

local function updatePetStats()
    if equippedPetsLabel then
        local num = convertFormattedNumber(equippedPetsLabel.Text)
        Monitor._equippedCount = num
        Monitor.petsStats1.SetText("Equipped: " .. tostring(num))
    end
    if petStepsLabel then
        local num = convertFormattedNumber(petStepsLabel.Text)
        Monitor._totalSteps = num
        Monitor.petsStats2.SetText("Total Steps: " .. tostring(num))
    end
    if petGemsLabel then
        local num = convertFormattedNumber(petGemsLabel.Text)
        Monitor._totalGems = num
        Monitor.petsStats3.SetText("Total Gems: " .. tostring(num))
    end
end

if equippedPetsLabel then
    equippedPetsLabel:GetPropertyChangedSignal("Text"):Connect(updatePetStats)
end
if petStepsLabel then
    petStepsLabel:GetPropertyChangedSignal("Text"):Connect(updatePetStats)
end
if petGemsLabel then
    petGemsLabel:GetPropertyChangedSignal("Text"):Connect(updatePetStats)
end

RunService.Heartbeat:Connect(updatePetStats)

updatePetStats()

local selectedPlayer = nil

local function getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        table.insert(names, p.Name)
    end
    return names
end

local selectedPlayer = nil

Monitor:CreateSection("Spy Stats")

Monitor:CreateBox("Enter Player Name", function(input)
    local player = Players:FindFirstChild(input)
    if player then
        selectedPlayer = player
    else
        selectedPlayer = nil
    end
end)

Monitor.spyStats1 = Monitor:CreateLabel("Steps: N/A")
Monitor.spyStats2 = Monitor:CreateLabel("Rebirths: N/A")
Monitor.spyStats3 = Monitor:CreateLabel("Hoops: N/A")
Monitor.spyStats4 = Monitor:CreateLabel("Races: N/A")

local function getStat(leaderstats, name)
    local stat = leaderstats and leaderstats:FindFirstChild(name)
    return stat and stat.Value or 0
end

local function updateSpyStats()
    if selectedPlayer then
        local leaderstats = selectedPlayer:FindFirstChild("leaderstats")
        Monitor.spyStats1.SetText("Steps: " .. getStat(leaderstats, "Steps"))
        Monitor.spyStats2.SetText("Rebirths: " .. getStat(leaderstats, "Rebirths"))
        Monitor.spyStats3.SetText("Hoops: " .. getStat(leaderstats, "Hoops"))
        Monitor.spyStats4.SetText("Races: " .. getStat(leaderstats, "Races"))
    else
        Monitor.spyStats1.SetText("Steps: N/A")
        Monitor.spyStats2.SetText("Rebirths: N/A")
        Monitor.spyStats3.SetText("Hoops: N/A")
        Monitor.spyStats4.SetText("Races: N/A")
    end
end

RunService.Heartbeat:Connect(updateSpyStats)

Monitor:CreateButton("Copy Stats", function()
    if not selectedPlayer then return end
    local leaderstats = selectedPlayer:FindFirstChild("leaderstats")

    local text = string.format(
        "Player: %s\nSteps: %d\nRebirths: %d\nHoops: %d\nRaces: %d",
        selectedPlayer.Name,
        getStat(leaderstats, "Steps"),
        getStat(leaderstats, "Rebirths"),
        getStat(leaderstats, "Hoops"),
        getStat(leaderstats, "Races")
    )

    if typeof(setclipboard) == "function" then
        pcall(setclipboard, text)
    end
end)

local utilities = {
    selectedOverlay = nil,
    enhanceConnection = false
}

local pingLimits = { min = 450, max = 1450 }

Utilities:CreateSection("Performance Settings")

local fpsvar = 0
local frameCount, lastTime = 0, tick()
RunService.RenderStepped:Connect(function()
	frameCount += 1
	local now = tick()
	if now - lastTime >= 1 then
		fpsvar = frameCount
		frameCount = 0
		lastTime = now
		Utilities.fpsLabel.SetText("Current FPS: " .. fpsvar)
	end
end)
Utilities.fpsLabel = Utilities:CreateLabel("Current FPS: " .. fpsvar)
Utilities:CreateBox("FPS Cap", function(v)
    RunService:Set3dRenderingEnabled(true)
    setfpscap(tonumber(v) or 60)
end)


Utilities:CreateToggle("Connection Enhancer", function(state)
    utilities.enhanceConnection = state
    if state then
        spawn(function()
            while utilities.enhanceConnection do
                local networkClient = game:GetService("NetworkClient")
                networkClient:SetOutgoingKBPSLimit(800000)
                networkClient:SetIncomingKBPSLimit(800000)
                wait(5)
            end
        end)
    end
end)
Utilities:CreateToggle("Ping Stabilizer", function(state)
    pingMonitorActive = state
    if state then
        spawn(function()
            while pingMonitorActive do
                local ping = getPing()
                if ping and ping > pingLimits.max then
                    repeat
                        wait(1)
                        ping = getPing()
                    until not pingMonitorActive or (ping and ping < pingLimits.min)
                end
                wait(0.5)
            end
        end)
    end
end)
Utilities:CreateToggle("Anti-Idle Protection", function(state)
    if state then
        antiKickConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
    elseif antiKickConnection then
        antiKickConnection:Disconnect()
        antiKickConnection = nil
    end
end)

Utilities:CreateSection("Small Optimizations")
Utilities:CreateDropdown("Select Overlay", {"Black Screen", "White Screen"}, function(selected)
	utilities.selectedOverlay = selected
end)

Utilities:CreateButton("Apply Overlay", function()
	if not utilities.selectedOverlay then return end

	local existing = game.CoreGui:FindFirstChild("OverlayGUI")
	if existing then
		existing:Destroy()
	end

	local overlayGui = Instance.new("ScreenGui")
	overlayGui.Name = "OverlayGUI"
	overlayGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	overlayGui.ResetOnSpawn = false
	overlayGui.IgnoreGuiInset = true
	overlayGui.DisplayOrder = 99999
	overlayGui.Parent = game.CoreGui

	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.Position = UDim2.new(0, 0, 0, 0)
	overlay.BackgroundColor3 = utilities.selectedOverlay == "Black Screen"
		and Color3.new(0, 0, 0)
		or Color3.new(1, 1, 1)
	overlay.BackgroundTransparency = 0
	overlay.ZIndex = 10
	overlay.Parent = overlayGui

	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0, 60, 0, 60)
	closeButton.AnchorPoint = Vector2.new(0.5, 0.5)
	closeButton.Position = UDim2.new(0.5, 0, 0.5, 0)
	closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	closeButton.Text = "X"
	closeButton.TextScaled = true
	closeButton.TextColor3 = Color3.new(1, 1, 1)
	closeButton.ZIndex = 20
	closeButton.Parent = overlay

	closeButton.MouseButton1Click:Connect(function()
		overlayGui:Destroy()
	end)
end)

local function cleanHoops()
    local player = game.Players.LocalPlayer
    local hoopGui = player:FindFirstChild("PlayerGui"):FindFirstChild("hoopGui")
    if hoopGui then
        local gradient = hoopGui:FindFirstChild("screenGradient")
        if gradient then gradient:Destroy() end
    end

    local hoopsFolder = workspace:FindFirstChild("Hoops")
    if hoopsFolder then
        for _, hoop in ipairs(hoopsFolder:GetChildren()) do
            for _, childName in ipairs({"hoopParticle", "hoopSound", "playerParticle"}) do
                local part = hoop:FindFirstChild(childName)
                if part then part:Destroy() end
            end
        end
    end
end

Utilities:CreateSection("Smart Tweaks")
Utilities:CreateLabel("These tweaks reset when you die or respawn.")
Utilities:CreateButton("Remove Level Popups", function()

    local playerLevel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.levelUpImage
    local trailLevel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.gameGuiScript.trailNotificationLabel
    local maxLevel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.maxLevelImage
    local rebirthPopup = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.rebirthImage
	if playerLevel then
		playerLevel:Destroy()
	end
    if trailLevel then
		trailLevel:Destroy()
	end
    if maxLevel then
		maxLevel:Destroy()
	end
    if rebirthPopup then
		rebirthPopup:Destroy()
	end
end)
Utilities:CreateButton("Remove Orb Popups", function()
    local orbPopup = game:GetService("Players").LocalPlayer.PlayerGui.orbGui.orbList

    if orbPopup then
		orbPopup:Destroy()
	end
end)
Utilities:CreateButton("Remove Group Popups", function()
    local groupMenu = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.notInGroupMenu
    if groupMenu then
		groupMenu:Destroy()
	end
end)
Utilities:CreateButton("Remove Quest Popups", function()
    local questFrame = game:GetService("Players").LocalPlayer.PlayerGui.questsGui.questsScript.questFrame
    if questFrame then
		questFrame:Destroy()
	end
end)
Utilities:CreateButton("Remove Race Popups", function()
    local raceWinners = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.winnersFolder.winnersFrame
    local raceButtons = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.raceJoinLabel
    local race1 = game:GetService("Players").LocalPlayer.PlayerGui.gameGui["1stPlaceImage"]
    local race2 = game:GetService("Players").LocalPlayer.PlayerGui.gameGui["2ndPlaceImage"]
    local race3 = game:GetService("Players").LocalPlayer.PlayerGui.gameGui["3rdPlaceImage"]
    local countDownLabel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.countdownLabels

    if raceWinners then
		raceWinners:Destroy()
	end
    if raceButtons then
		raceButtons:Destroy()
	end
    if race1 then
		race1:Destroy()
	end
    if race2 then
		race2:Destroy()
	end
    if race3 then
		race3:Destroy()
	end
    if countDownLabel then
		countDownLabel:Destroy()
	end
end)

Utilities:CreateButton("Remove Hoop Animations", cleanHoops)

Utilities:CreateButton("Remove All", function()
    local playerLevel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.levelUpImage
    local trailLevel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.gameGuiScript.trailNotificationLabel
    local maxLevel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.maxLevelImage
    local rebirthPopup = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.rebirthImage
    local orbPopup = game:GetService("Players").LocalPlayer.PlayerGui.orbGui.orbList
    local groupMenu = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.notInGroupMenu
    local questFrame = game:GetService("Players").LocalPlayer.PlayerGui.questsGui.questsScript.questFrame
    local raceWinners = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.winnersFolder.winnersFrame
    local raceButtons = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.raceJoinLabel
    local race1 = game:GetService("Players").LocalPlayer.PlayerGui.gameGui["1stPlaceImage"]
    local race2 = game:GetService("Players").LocalPlayer.PlayerGui.gameGui["2ndPlaceImage"]
    local race3 = game:GetService("Players").LocalPlayer.PlayerGui.gameGui["3rdPlaceImage"]
    local countDownLabel = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.countdownLabels

    if playerLevel then
		playerLevel:Destroy()
	end
    if trailLevel then
		trailLevel:Destroy()
	end
    if maxLevel then
		maxLevel:Destroy()
	end
    if rebirthPopup then
		rebirthPopup:Destroy()
	end
    if orbPopup then
		orbPopup:Destroy()
	end
    if groupMenu then
		groupMenu:Destroy()
	end
    if questFrame then
		questFrame:Destroy()
	end
    if raceWinners then
		raceWinners:Destroy()
	end
    if raceButtons then
		raceButtons:Destroy()
	end
    if race1 then
		race1:Destroy()
	end
    if race2 then
		race2:Destroy()
	end
    if race3 then
		race3:Destroy()
	end
    if countDownLabel then
		countDownLabel:Destroy()
	end

    cleanHoops()
end)

local races = {
    type = nil,
    raceTarget = nil,
    racing = false,
    smoothRacing = false,
    fillRace = false,
    minimumPlayerCount = nil,
    autoHop = false
}

ReplicatedStorage.raceInProgress.Changed:Connect(function()
    if races.smoothRacing and ReplicatedStorage.raceInProgress.Value then
        ReplicatedStorage.rEvents.raceEvent:FireServer("joinRace")
    end
end)

ReplicatedStorage.raceStarted.Changed:Connect(function()
    if races.smoothRacing and ReplicatedStorage.raceStarted.Value then
        for _, v in ipairs(workspace.raceMaps:GetChildren()) do
            local oldCFrame = v.finishPart.CFrame
            v.finishPart.CFrame = player.Character.HumanoidRootPart.CFrame
            wait()
            v.finishPart.CFrame = oldCFrame
        end
        wait(2)
    end
end)

local function updateRaceTargetLabel()
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        Races.target1.SetText("Races Before Target: N/A")
        return
    end

    local racesStat = leaderstats:FindFirstChild("Races")
    local currentRaces = racesStat and racesStat.Value or 0

    if not races.raceTarget or races.raceTarget <= 0 then
        Races.target1.SetText("Races Before Target: N/A")
        return
    end

    local diff = races.raceTarget - currentRaces
    if diff <= 0 then
        if currentRaces == races.raceTarget then
            Races.target1.SetText("Races Before Target: Reached")
            races.racing = false
        else
            Races.target1.SetText("Races Before Target: Exceeded")
            races.racing = false
        end
    else
        Races.target1.SetText("Races Before Target: " .. tostring(diff))
    end
end

Races:CreateSection("Race Tweaks")
Races:CreateBox("Race Target", function(raceInput)
    local target = tonumber(raceInput)
    if target and target > 0 then
        races.raceTarget = target
    else
        races.raceTarget = nil
    end
    updateRaceTargetLabel()
end)
Races:CreateToggle("Fill Race Queue", function(state)
    races.fillRace = state
    if state then
        spawn(function()
            while races.fillRace do
                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer("joinRace")
                wait()
            end
        end)
    end
end)
Races:CreateSection("Race Automation")
Races:CreateDropdown("Method", {"Teleport", "Smooth"}, function(selected)
    races.type = selected
end)
Races:CreateToggle("Enable Race Automation", function(state)
    races.racing = state

    if not state then
        races.racing = false
        races.smoothRacing = false
        return
    end

    if not races.type then
        warn("[RaceAutomation] No method selected (Teleport/Smooth)")
        races.racing = false
        return
    end

    local leaderstats = player:FindFirstChild("leaderstats")
    local racesStat = leaderstats and leaderstats:FindFirstChild("Races")
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

    local function shouldStop()
        if races.raceTarget and racesStat and racesStat.Value >= races.raceTarget then
            races.racing = false
            races.smoothRacing = false
            return true
        end
        return false
    end

    if races.type == "Teleport" then
        spawn(function()
            local racePoints = {
                Vector3.new(48.31, 36.31, -8680.45),
                Vector3.new(1686.07, 36.31, -5946.63),
                Vector3.new(1001.33, 36.31, -10986.22)
            }

            while races.racing do
                if shouldStop() then break end

                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer("joinRace")
                if hrp and races.type == "Teleport" then
                    for _, pos in ipairs(racePoints) do
                        if shouldStop() then break end
                        hrp.CFrame = CFrame.new(pos)
                        task.wait(0.4)
                    end
                end

                task.wait()
            end
        end)

    elseif races.type == "Smooth" then
        races.smoothRacing = true
        spawn(function()
            while races.smoothRacing do
                if shouldStop() then break end
                task.wait(1)
            end
        end)
    end
end)


Races.target1 = Races:CreateLabel("Races Before Target: N/A")

player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        task.wait(0.2)
        local racesStat = child:FindFirstChild("Races")
        if racesStat then
            racesStat.Changed:Connect(updateRaceTargetLabel)
            updateRaceTargetLabel()
        end
    end
end)

if player:FindFirstChild("leaderstats") then
    local racesStat = player.leaderstats:FindFirstChild("Races")
    if racesStat then
        racesStat.Changed:Connect(updateRaceTargetLabel)
    end
end

updateRaceTargetLabel()

local function getServerList(url)
    local raw = game:HttpGet(url)
    return HttpService:JSONDecode(raw)
end

function LowestPlayer()
    local api = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local nextCursor, server
    repeat
        local servers = getServerList(api .. (nextCursor and "&cursor=" .. nextCursor or ""))
        server = servers.data[1]
        nextCursor = servers.nextPageCursor
    until server
    TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
end

function Rejoin()
    TeleportService:TeleportToPlaceInstance(placeId, game.JobId, player)
end

function Serverhop()
    local api = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
    local nextCursor, chosen
    repeat
        local servers = getServerList(api .. (nextCursor and "&cursor=" .. nextCursor or ""))
        for _, s in ipairs(servers.data) do
            if s.maxPlayers > s.playing then
                chosen = s
                break
            end
        end
        nextCursor = servers.nextPageCursor
    until chosen
    TeleportService:TeleportToPlaceInstance(placeId, chosen.id, player)
end

Races:CreateSection("Race Hopping")

Races:CreateBox("Minimum Player Count", function(playerCount)
    local num = tonumber(playerCount)
    if num and num > 0 then
        races.minimumPlayerCount = num
    else
        races.minimumPlayerCount = nil
    end
end)

Races:CreateToggle("Automatic Server Hop", function(state)
    races.autoHop = state

    if state then
        spawn(function()
            while races.autoHop do
                local currentCount = getPlayerCount()
                local minCount = races.minimumPlayerCount

                if minCount and currentCount < minCount then
                    Serverhop()
                    break
                end
                task.wait(5)
            end
        end)
    end
end)

local assistants = {
    spinWheel = false,
    chests = false,
    gifts = false,
    usernameTrade = nil
}

Assistants:CreateSection("Quick Automations")
Assistants:CreateToggle("Spin Fortune Wheel", function(state)
    assistants.spinWheel = state
    if state then
        spawn(function()
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local rEvents = replicatedStorage:WaitForChild("rEvents")
            local wheelRemote = rEvents:WaitForChild("openFortuneWheelRemote")
            local wheelChance = replicatedStorage:WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")

            while assistants.spinWheel do
                wheelRemote:InvokeServer("openFortuneWheel", wheelChance)
                wait(0.5)
            end
        end)
    end
end)
Assistants:CreateToggle("Claim Chests", function(state)
    assistants.chests = state
    if state then
        spawn(function()
            while assistants.chests do
                local rEvents = game:GetService("ReplicatedStorage"):WaitForChild("rEvents")

                rEvents:WaitForChild("groupRemote"):InvokeServer("groupRewards")

                local checkChestRemote = rEvents:WaitForChild("checkChestRemote")
                local chests = { "Magma Chest", "Enchanted Chest", "Golden Chest" }

                for _, chestName in ipairs(chests) do
                    checkChestRemote:InvokeServer(chestName)
                end

                wait(0.5)
            end
        end)
    end
end)
Assistants:CreateToggle("Claim Gifts", function(state)
    assistants.gifts = state
    if state then
        spawn(function()
            while assistants.gifts do
                for i = 1, 8 do
                    local remote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("freeGiftClaimRemote")
                    remote:InvokeServer("claimGift", i)
                end
                wait(0.5)
            end
        end)
    end
end)

Assistants:CreateButton("Unlock Codes", function()
    local codes = {
        "Launch200",
        "sparkles300",
        "legends500",
        "hyper250",
        "SPRINT250",
        "racer300",
        "speedchampion000",
        "swiftjungle1000"
    }

    local codeRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("codeRemote")
    for _, code in ipairs(codes) do
        codeRemote:InvokeServer(code)
    end
end)

Assistants:CreateSection("Player Tweaks")
Assistants:CreateToggle("Freeze Character", function(state)
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    hrp.Anchored = state
end)
Assistants:CreateToggle("Enable Bull Character", function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CustomPhysicalProperties = state and PhysicalProperties.new(30, 0.3, 0.5) or nil
        end
    end
end)

Assistants:CreateSection("Player Settings")
Assistants:CreateBox("Set Walk Speed", function(input)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
end)
Assistants:CreateBox("Set Jump Power", function(input)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input)
end)
Assistants:CreateBox("Set Hip Height", function(input)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(input)
end)
Assistants:CreateBox("Set Gravity", function(input)
    workspace.Gravity = tonumber(input)
end)

Assistants:CreateSection("Trading")
Assistants:CreateToggle("Enable Trading", function(state)
    local action = state and "enableTrading" or "disableTrading"
    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("tradingEvent"):FireServer(action)
end)
Assistants:CreateBox("Trade Target Username", function(input)
    assistants.usernameTrade = input
end)
Assistants:CreateButton("Send Trade Request", function()
    if assistants.usernameTrade and assistants.usernameTrade ~= "" then
        local targetPlayer = Players:FindFirstChild(assistants.usernameTrade)
        if targetPlayer then
            game:GetService("ReplicatedStorage").rEvents.tradingEvent:FireServer("sendTradeRequest", targetPlayer)
        end
    end
end)
Assistants:CreateButton("Remove Trade Popup", function()
    local tradeUnlocked = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.tradeUnlockedImage
    local tradePopup = game:GetService("Players").LocalPlayer.PlayerGui.gameGui.gameGuiScript.playerTradeFrame
    if tradeUnlocked then
		tradeUnlockedds:Destroy()
	end
	if tradePopup then
		tradePopup:Destroy()
	end
end)

local validOrbs = {
    "Yellow Orb",
    "Orange Orb",
    "Blue Orb",
    "Red Orb",
    "Ethereal Orb",
    "Gem",
    "Infernal Gem"
}

local validCities = {
    "City",
    "Snow City",
    "Magma City",
    "Legends Highway",
    "Speed Jungle",
    "Space",
    "Desert"
}

local orbFarms = {
    primary = {
        active = false,
        settings = { orb = "", city = "", speed = 400, cooldown = 0.4 }
    },
    secondary = {
        active = false,
        settings = { orb = "", city = "", speed = 400, cooldown = 0.4 }
    },
    third = {
        active = false,
        settings = { orb = "", city = "", speed = 400, cooldown = 0.4 }
    },
    fourth = {
        active = false,
        settings = { orb = "", city = "", speed = 400, cooldown = 0.4 }
    }
}

local function getPing()
    local pingString = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    return tonumber(pingString:match("%d+"))
end

local function startOrbFarm(stateRef, settings)
    if settings.orb == "" or settings.city == "" or settings.speed <= 0 then
        return
    end

    while stateRef.active do
        if pingMonitorActive then
            local ping = getPing()
            if ping and ping > pingLimits.max then
                repeat wait(1)
                    ping = getPing()
                until not stateRef.active or (ping and ping < pingLimits.min)
                if not stateRef.active then break end
            end
        end

        local batchSize = math.ceil(settings.speed / 5)
        local remaining = settings.speed

        while remaining > 0 and stateRef.active do
            local thisBatch = math.min(batchSize, remaining)
            for _ = 1, thisBatch do
                game:GetService('ReplicatedStorage').rEvents.orbEvent:FireServer("collectOrb", settings.orb, settings.city)
            end
            remaining -= thisBatch
            wait(0.11)
        end

        wait(settings.cooldown)
    end
end

Automation:CreateSection("Primary Orb Automation")

Automation:CreateDropdown("Select Orb", validOrbs, function(selected)
    orbFarms.primary.settings.orb = selected
end)

Automation:CreateDropdown("Select City", validCities, function(selected)
    orbFarms.primary.settings.city = selected
end)

Automation:CreateBox("Set Orb Collection Rate", function(input)
    local number = tonumber(input)
    if number then
        orbFarms.primary.settings.speed = number
    end
end)

Automation:CreateBox("Orb Cooldown", function(input)
    local inputNumber = tonumber(input)
    if inputNumber and inputNumber > 0 then
        orbFarms.primary.settings.cooldown = inputNumber / 1000
    else
        orbFarms.primary.settings.cooldown = 0.4
    end
end)

Automation:CreateToggle("Enable Orb Automation", function(state)
    orbFarms.primary.active = state
    if state then
        spawn(function()
            startOrbFarm(orbFarms.primary, orbFarms.primary.settings)
        end)
    end
end)


Automation:CreateSection("Secondary Orb Automation")

Automation:CreateDropdown("Select Orb", validOrbs, function(selected)
    orbFarms.secondary.settings.orb = selected
end)

Automation:CreateDropdown("Select City", validCities, function(selected)
    orbFarms.secondary.settings.city = selected
end)

Automation:CreateBox("Set Orb Collection Rate", function(input)
    local number = tonumber(input)
    if number then
        orbFarms.secondary.settings.speed = number
    end
end)

Automation:CreateBox("Orb Cooldown", function(input)
    local inputNumber = tonumber(input)
    if inputNumber and inputNumber > 0 then
        orbFarms.secondary.settings.cooldown = inputNumber / 1000
    else
        orbFarms.secondary.settings.cooldown = 0.4
    end
end)

Automation:CreateToggle("Enable Orb Automation", function(state)
    orbFarms.secondary.active = state
    if state then
        spawn(function()
            startOrbFarm(orbFarms.secondary, orbFarms.secondary.settings)
        end)
    end
end)


Automation:CreateSection("Tertiary Orb Automation")

Automation:CreateDropdown("Select Type", validOrbs, function(selected)
    orbFarms.third.settings.orb = selected
end)

Automation:CreateDropdown("Select City", validCities, function(selected)
    orbFarms.third.settings.city = selected
end)

Automation:CreateBox("Set Orb Collection Rate", function(input)
    local number = tonumber(input)
    if number then
        orbFarms.third.settings.speed = number
    end
end)

Automation:CreateBox("Orb Cooldown", function(input)
    local inputNumber = tonumber(input)
    if inputNumber and inputNumber > 0 then
        orbFarms.third.settings.cooldown = inputNumber / 1000
    else
        orbFarms.third.settings.cooldown = 0.4
    end
end)

Automation:CreateToggle("Enable Orb Automation", function(state)
    orbFarms.third.active = state
    if state then
        spawn(function()
            startOrbFarm(orbFarms.third, orbFarms.third.settings)
        end)
    end
end)

Automation:CreateSection("Quaternary Orb Automation")

Automation:CreateDropdown("Select Type", validOrbs, function(selected)
    orbFarms.fourth.settings.orb = selected
end)

Automation:CreateDropdown("Select City", validCities, function(selected)
    orbFarms.fourth.settings.city = selected
end)

Automation:CreateBox("Set Orb Collection Rate", function(input)
    local number = tonumber(input)
    if number then
        orbFarms.fourth.settings.speed = number
    end
end)

Automation:CreateBox("Orb Cooldown", function(input)
    local inputNumber = tonumber(input)
    if inputNumber and inputNumber > 0 then
        orbFarms.fourth.settings.cooldown = inputNumber / 1000
    else
        orbFarms.fourth.settings.cooldown = 0.4
    end
end)

Automation:CreateToggle("Enable Orb Automation", function(state)
    orbFarms.fourth.active = state
    if state then
        spawn(function()
            startOrbFarm(orbFarms.fourth, orbFarms.fourth.settings)
        end)
    end
end)

local rebirthTable = {
    rebirth = false,
    rebirthTarget = false,
    instantRebirthAmount = 0,
    rebirthCooldown = 0.2,
    rebirthTargetAmount = 0,
    rebirthTargetCooldown = 0.5
}

local function updateRebirthTargetLabel()
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        Rebirths.target1.SetText("Rebirths Before Target: N/A")
        return
    end

    local rebirthStat = leaderstats:FindFirstChild("Rebirths")
    local currentRebirths = rebirthStat and rebirthStat.Value or 0

    if not rebirthTable.rebirthTargetAmount or rebirthTable.rebirthTargetAmount <= 0 then
        Rebirths.target1.SetText("Rebirths Before Target: N/A")
        return
    end

    local diff = rebirthTable.rebirthTargetAmount - currentRebirths
    if diff <= 0 then
        if currentRebirths == rebirthTable.rebirthTargetAmount then
            Rebirths.target1.SetText("Rebirths Before Target: Reached")
            rebirthTable.rebirthTarget = false
        else
            Rebirths.target1.SetText("Rebirths Before Target: Exceeded")
            rebirthTable.rebirthTarget = false
        end
    else
        Rebirths.target1.SetText("Rebirths Before Target: " .. tostring(diff))
    end
end

Rebirths:CreateSection("Rebirth Automation")

Rebirths:CreateBox("Set Rebirthing Cooldown", function(input)
    rebirthTable.rebirthCooldown = tonumber(input) or 0.2
end)

Rebirths:CreateToggle("Enable Rebirth Automation", function(state)
    rebirthTable.rebirth = state
    if state then
        spawn(function()
            while rebirthTable.rebirth do
                ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                wait(rebirthTable.rebirthCooldown)
            end
        end)
    end
end)

Rebirths:CreateSection("Targeted Rebirthing")

local target = tonumber(raceInput)
    if target and target > 0 then
        races.raceTarget = target
    else
        races.raceTarget = nil
    end

Rebirths:CreateBox("Set Rebirth Target Amount", function(input)
    local rebtarget = tonumber(input)
    if rebtarget and rebtarget > 0 then
        rebirthTable.rebirthTargetAmount = rebtarget
    else
        rebirthTable.rebirthTargetAmount = nil
    end
    updateRebirthTargetLabel()
end)

Rebirths:CreateBox("Set Rebirthing Cooldown", function(input)
    rebirthTable.rebirthTargetCooldown = tonumber(input) or 0.5
end)

Rebirths:CreateToggle("Enable Rebirth Automation", function(state)
    rebirthTable.rebirthTarget = state
    if state then
        spawn(function()
            while rebirthTable.rebirthTarget do
                local success = pcall(function()
                    local leaderstats = player:FindFirstChild("leaderstats")
                    local rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths")
                    if not rebirths then return end

                    local before = rebirths.Value
                    ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                    wait(rebirthTable.rebirthTargetCooldown)
                    local after = rebirths.Value

                    if after >= rebirthTable.rebirthTargetAmount then
                        DesyncedLibrary:createNotification("Successfully reached rebirth target!")
                        rebirthTable.rebirthTarget = false
                        orbFarms.primary.active = false
                        orbFarms.secondary.active = false
                        orbFarms.third.active = false
                        orbFarms.fourth.active = false
                    end
                end)

                if not success then
                    rebirthTable.rebirthTarget = false
                    orbFarms.primary.active = false
                    orbFarms.secondary.active = false
                    orbFarms.fourth.active = false
                end
            end
        end)
    else
        rebirthTable.rebirthTarget = false
        orbFarms.primary.active = false
        orbFarms.secondary.active = false
        orbFarms.fourth.active = false
    end
end)

Rebirths.target1 = Rebirths:CreateLabel("Rebirths Before Target: N/A")

player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        task.wait(0.2)
        local rebirthStat = child:FindFirstChild("Rebirths")
        if rebirthStat then
            rebirthStat.Changed:Connect(updateRebirthTargetLabel)
            updateRebirthTargetLabel()
        end
    end
end)

if player:FindFirstChild("leaderstats") then
    local racesStat = player.leaderstats:FindFirstChild("Rebirths")
    if racesStat then
        racesStat.Changed:Connect(updateRebirthTargetLabel)
    end
end

updateRebirthTargetLabel()

Rebirths:CreateSection("Instant Rebirths")

Rebirths:CreateBox("Set Amount", function(input)
    rebirthTable.instantRebirthAmount = tonumber(input) or 0
end)

Rebirths:CreateButton("Execute Rebirths", function()
    for i = 1, rebirthTable.instantRebirthAmount do
        ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
    end
end)

Rebirths:CreateSection("Rebirth Calculator Options")

local MAX_REBIRTH = 250000

local Base_PetType_XP_Threshold = {
    Basic = 1000,
    Advanced = 2000,
    Rare = 3000,
    Epic = 4000,
    Unique = 5000,
    Omega = 10000,
}

local Base_Stats_Per_Add = {
    Basic = 1,
    Advanced = 3,
    Rare = 4,
    Epic = 5,
    Unique = 6,
    Omega = 7,
}

local stepBooster = {
    Yellow_City = 15,
    Yellow_SnowCity = 30,
    Yellow_MagmaCity = 45,
    Yellow_LegendsHighway = 60,
    Yellow_SpeedJungle = 75,
    Red_City = 30,
    Red_SnowCity = 60,
    Red_MagmaCity = 90,
    Red_LegendsHighway = 120,
    Red_SpeedJungle = 150,
    Ethereal_City = 300,
    Ethereal_SnowCity = 600,
    Ethereal_MagmaCity = 900,
    Ethereal_LegendsHighway = 1200,
    Ethereal_SpeedJungle = 1500,
}

local NoStepBooster = {
    Yellow_City = 15,
    Yellow_SnowCity = 30,
    Yellow_MagmaCity = 45,
    Yellow_LegendsHighway = 60,
    Yellow_SpeedJungle = 75,
    Red_MagmaCity = 60,
    Ethereal_MagmaCity = 600,
}

local rebirthValue = 0
local hasStepBoosters = false
local hasPremium = false

Rebirths:CreateBox("Rebirth Count", function(input)
    rebirthValue = tonumber(input)
end)

Rebirths:CreateToggle("Step Boosters", function(state)
    hasStepBoosters = state
end)

Rebirths:CreateToggle("Roblox Premium", function(state)
    hasPremium = state
end)

local outputText
local orbLabel
local cityLabel
local speedLabel
local petLabel

Rebirths:CreateButton("Calculate Glitch", function()
    local boosterTable = hasStepBoosters and stepBooster or NoStepBooster

    local function check_glitch(target_rebirth)
        local filtered_map = {}
        for k, v in pairs(boosterTable) do
            filtered_map[k] = v
        end

        if target_rebirth < 1 then
            for k in pairs(filtered_map) do
                if string.find(k, "SpeedJungle") or string.find(k, "LegendsHighway") or string.find(k, "MagmaCity") then
                    filtered_map[k] = nil
                end
            end
        elseif target_rebirth < 10 then
            for k in pairs(filtered_map) do
                if string.find(k, "SpeedJungle") or string.find(k, "LegendsHighway") then
                    filtered_map[k] = nil
                end
            end
        elseif target_rebirth < 50 then
            for k in pairs(filtered_map) do
                if string.find(k, "SpeedJungle") then
                    filtered_map[k] = nil
                end
            end
        end

        local results = {}

        for location, multiplier in pairs(filtered_map) do
            local xp = (target_rebirth + 1) * multiplier
            if hasPremium and not string.find(string.lower(location), "yellow") then
                xp = xp * 2
            end

            local orbType, loc = string.match(location, "^(%w+)_(.+)$")
            orbType = orbType or "Unknown"
            loc = loc or location

            for petType, threshold in pairs(Base_PetType_XP_Threshold) do
                local petXP = xp
                local level = 1

                while level <= 48 do
                    petXP = petXP - (threshold * level)
                    if petXP == 0 then
                        local stats = Base_Stats_Per_Add[petType] * level
                        table.insert(results, {
                            orb = orbType,
                            city = loc,
                            pet = petType,
                            speed = stats,
                        })
                        break
                    elseif petXP < 0 then
                        break
                    end
                    level = level + 1
                end
            end
        end

        return results
    end

    if not rebirthValue or rebirthValue < 0 then
        outputText.SetText("Invalid Rebirth Count")
        orbLabel.SetText("Orb: -")
        cityLabel.SetText("City: -")
        speedLabel.SetText("Speed: -")
        petLabel.SetText("Pet: -")
        return
    end

    local results = check_glitch(rebirthValue)

    if #results > 0 then
        table.sort(results, function(a, b)
            return a.speed > b.speed
        end)

        local best = results[1]
        outputText.SetText("Glitch Found")
        orbLabel.SetText("Orb: " .. best.orb)
        cityLabel.SetText("City: " .. best.city)
        speedLabel.SetText("Speed: +" .. best.speed)
        petLabel.SetText("Pet: " .. best.pet)

    else
        outputText.SetText("No Glitch Found")
        orbLabel.SetText("Orb: -")
        cityLabel.SetText("City: -")
        speedLabel.SetText("Speed: -")
        petLabel.SetText("Pet: -")

    end
end)

Rebirths:CreateButton("Clear Results", function()
    outputText.SetText("Calculate Glitch")
    orbLabel.SetText("Orb: -")
    cityLabel.SetText("City: -")
    speedLabel.SetText("Speed: -")
    petLabel.SetText("Pet: -")
end)

Rebirths:CreateSection("Calculation Results")

outputText = Rebirths:CreateLabel("Calculate Glitch")
orbLabel = Rebirths:CreateLabel("Orb: -")
cityLabel = Rebirths:CreateLabel("City: -")
speedLabel = Rebirths:CreateLabel("Speed: -")
petLabel = Rebirths:CreateLabel("Pet: -")


Pets:CreateSection("Pet Hatching")

local function createPetHatchSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateLabel(sectionName)

    _G[selectionVarName] = petList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown("Select Pet", petList, function(input)
        _G[selectionVarName] = input
    end)

    tab:CreateToggle("Enable Pet Hatching", function(state)
        _G[toggleVarName] = state
        if state then
            spawn(function()
                while _G[toggleVarName] do
                    local pet = _G[selectionVarName]
                    if pet then
                        local args = {
                            game:GetService("ReplicatedStorage"):WaitForChild("cPetShopFolder"):WaitForChild(pet)
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("cPetShopRemote"):InvokeServer(unpack(args))
                    end
                    wait()
                end
            end)
        end
    end)
end

createPetHatchSection(Pets, "Hatch Basic Pets", {
    "Red Bunny", "Red Kitty", "Blue Bunny", "Silver Dog", "Yellow Squeak"
}, "selectedbasicpettohatch", "hatchBasicPets")

createPetHatchSection(Pets, "Hatch Advanced Pets", {
    "Green Vampy", "Dark Golem", "Pink Butterfly", "Yellow Butterfly", "Green Golem"
}, "selectedadvancedpettohatch", "hatchAdvancedPets")

createPetHatchSection(Pets, "Hatch Rare Pets", {
    "Purple Pegasus", "Golden Angel", "Orange Pegasus", "Orange Falcon", "Blue Firecaster",
    "White Phoenix", "Red Phoenix", "Red Firecaster"
}, "selectedrarepettohatch", "hatchRarePets")

createPetHatchSection(Pets, "Hatch Epic Pets", {
    "Golden Phoenix", "Green Firecaster", "Voltaic Falcon", "Blue Phoenix", "Divine Pegasus"
}, "selectedepicpettohatch", "hatchEpicPets")

createPetHatchSection(Pets, "Hatch Unique Pets", {
    "Flaming Hedgehog", "Electro Golem", "Voltaic Falcon", "Void Dragon", "Ultra Birdie",
    "Quantum Dragon", "Tundra Dragon", "Magic Butterfly", "Maestro Dog", "Golden Viking", "Speedy Sensei"
}, "selecteduniquepettohatch", "hatchUniquePets")

createPetHatchSection(Pets, "Hatch Omega Pets", {
    "Soul Fusion Dog", "Hypersonic Pegasus", "Dark Soul Birdie", "Eternal Nebula Dragon",
    "Shadows Edge Kitty", "Ultimate Overdrive Bunny", "Swift Samurai"
}, "selectedomegapettohatch", "hatchOmegaPets")


Pets:CreateSection("Pet Evolving")

local function createPetEvolveSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateLabel(sectionName)

    _G[selectionVarName] = petList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown("Select Pet", petList, function(input)
        _G[selectionVarName] = input
    end)

    tab:CreateToggle("Enable Pet Evolving", function(state)
        _G[toggleVarName] = state
        if state then
            spawn(function()
                while _G[toggleVarName] do
                    local pet = _G[selectionVarName]
                    if pet then
                        local args = {
                            "evolvePet",
                            pet
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("petEvolveEvent"):FireServer(unpack(args))
                    end
                    wait()
                end
            end)
        end
    end)
end

createPetEvolveSection(Pets, "Evolve Basic Pets", {
    "Red Bunny", "Red Kitty", "Blue Bunny", "Silver Dog", "Yellow Squeak"
}, "selectedbasicpettoevolve", "evolveBasicPets")

createPetEvolveSection(Pets, "Evolve Advanced Pets", {
    "Green Vampy", "Dark Golem", "Pink Butterfly", "Yellow Butterfly", "Green Golem"
}, "selectedadvancedpettoevolve", "evolveAdvancedPets")

createPetEvolveSection(Pets, "Evolve Rare Pets", {
    "Purple Pegasus", "Golden Angel", "Orange Pegasus", "Orange Falcon", "Blue Firecaster",
    "White Phoenix", "Red Phoenix", "Red Firecaster"
}, "selectedrarepettoevolve", "evolveRarePets")

createPetEvolveSection(Pets, "Evolve Epic Pets", {
    "Golden Phoenix", "Green Firecaster", "Voltaic Falcon", "Blue Phoenix", "Divine Pegasus"
}, "selectedepicpettoevolve", "evolveEpicPets")

createPetEvolveSection(Pets, "Evolve Unique Pets", {
    "Flaming Hedgehog", "Electro Golem", "Voltaic Falcon", "Void Dragon", "Ultra Birdie",
    "Quantum Dragon", "Tundra Dragon", "Magic Butterfly", "Maestro Dog", "Golden Viking", "Speedy Sensei"
}, "selecteduniquepettoevolve", "evolveUniquePets")

createPetEvolveSection(Pets, "Evolve Omega Pets", {
    "Soul Fusion Dog", "Hypersonic Pegasus", "Dark Soul Birdie", "Eternal Nebula Dragon",
    "Shadows Edge Kitty", "Ultimate Overdrive Bunny", "Swift Samurai"
}, "selectedomegapettoevolve", "evolveOmegaPets")

Trails:CreateSection("Hatch Trails")

local function createTrailSection(tab, label, trailList)
    tab:CreateLabel(label)

    local selected = "_G.selectedTrail_" .. label
    local toggle = "_G.trailToggle_" .. label

    _G[selected] = trailList[1]
    _G[toggle] = false

    tab:CreateDropdown("Select Trail", trailList, function(choice)
        _G[selected] = choice
    end)

    tab:CreateToggle("Enable Trail Hatching", function(state)
        _G[toggle] = state
        if state then
            spawn(function()
                while _G[toggle] do
                    wait()
                    local chosen = _G[selected]
                    if chosen then
                        local args = {
                            game:GetService("ReplicatedStorage"):WaitForChild("cPetShopFolder"):WaitForChild(chosen)
                        }
                        game:GetService("ReplicatedStorage"):WaitForChild("cPetShopRemote"):InvokeServer(unpack(args))
                    end
                end
            end)
        end
    end)
end

createTrailSection(Trails, "1-5 Trails", {
    "1st Trail", "2nd Trail", "Third Trail", "Fourth Trail", "Fifth Trail"
})

createTrailSection(Trails, "B Trails", {
    "BG Speed", "Blue & Green", "Blue Coin", "Blue Gem", "Blue Lightning", "Blue Snow",
    "Blue Soul", "Blue Sparks", "Blue Storm", "Blue Trail"
})

createTrailSection(Trails, "D Trails", { "Dragonfire" })

createTrailSection(Trails, "G Trails", {
    "Golden Lightning", "Green & Orange", "Green Coin", "Green Gem", "Green Lightning",
    "Green Snow", "Green Soul", "Green Sparks", "Green Storm", "Green Trail"
})

createTrailSection(Trails, "H Trails", { "Hyperblast" })

createTrailSection(Trails, "O Trails", {
    "OG Speed", "Orange Coin", "Orange Gem", "Orange Lightning", "Orange Snow",
    "Orange Soul", "Orange Sparks", "Orange Storm", "Orange Trail"
})

createTrailSection(Trails, "P Trails", {
    "PP Speed", "Pink Gem", "Pink Lightning", "Pink Snow", "Pink Soul", "Pink Sparks",
    "Pink Storm", "Pink Trail", "Purple & Pink", "Purple Coin", "Purple Gem",
    "Purple Lightning", "Purple Soul", "Purple Sparks", "Purple Storm", "Purple Trail"
})

createTrailSection(Trails, "R Trails", {
    "RB Speed", "Rainbow Lightning", "Rainbow Soul", "Rainbow Sparks", "Rainbow Speed",
    "Rainbow Steps", "Rainbow Storm", "Rainbow Trail", "Red & Blue", "Red Coin", "Red Gem",
    "Red Lightning", "Red Snow", "Red Soul", "Red Sparks", "Red Storm", "Red Trail"
})

createTrailSection(Trails, "W Trails", { "White Snow" })

createTrailSection(Trails, "Y Trails", {
    "YB Speed", "Yellow & Blue", "Yellow Soul", "Yellow Sparks", "Yellow Trail"
})

Crystals:CreateSection("Open Crystals")

local function createCrystalSection(tab, sectionName, crystalList, selectionVarName, toggleVarName)
    tab:CreateLabel(sectionName)

    _G[selectionVarName] = crystalList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown("Select Crystal", crystalList, function(input)
        _G[selectionVarName] = input
    end)

    tab:CreateToggle("Enable Crystal Opening", function(state)
        _G[toggleVarName] = state
        if state then
            spawn(function()
                while _G[toggleVarName] do
                    local crystal = _G[selectionVarName]
                    if crystal then
                        local args = { [1] = "openCrystal", [2] = crystal }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("rEvents")
                            :WaitForChild("openCrystalRemote")
                            :InvokeServer(unpack(args))
                    end
                    wait()
                end
            end)
        end
    end)
end

local cityCrystals = {
    "Red Crystal", "Lightning Crystal", "Yellow Crystal", "Purple Crystal", "Blue Crystal",
    "Snow Crystal", "Lava Crystal", "Inferno Crystal", "Electro Legends Crystal", "Jungle Crystal"
}

local spaceCrystals = {
    "Space Crystal", "Alien Crystal"
}

local desertCrystals = {
    "Desert Crystal", "Electro Crystal"
}

createCrystalSection(Crystals, "City Crystals", cityCrystals, "selectedCityCrystal", "autoOpenCityCrystal")
createCrystalSection(Crystals, "Space Crystals", spaceCrystals, "selectedSpaceCrystal", "autoOpenSpaceCrystal")
createCrystalSection(Crystals, "Desert Crystals", desertCrystals, "selectedDesertCrystal", "autoOpenDesertCrystal")

Ultimates:CreateSection("Unlock Ultimates")
Ultimates:CreateLabel("Unlocking ultimates will cost you rebirths")
Ultimates:CreateLabel("Full ultimates cost list coming soon")
Ultimates:CreateSection("Rebirth Pets")
Ultimates:CreateButton("Magzor", function()
    local args = { "upgradeUltimate", "Magzor" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Crowd Surfer", function()
    local args = { "upgradeUltimate", "Crowd Surfer" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Sorenzo", function()
    local args = { "upgradeUltimate", "Sorenzo" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateSection("Game Upgrades")
Ultimates:CreateButton("x2 Trail Boosts", function()
    local args = { "upgradeUltimate", "x2 Trail Boosts" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("+1 Pet Slot", function()
    local args = { "upgradeUltimate", "+1 Pet Slot" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("+10 Item Capacity", function()
    local args = { "upgradeUltimate", "+10 Item Capacity" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("+1 Daily Spin", function()
    local args = { "upgradeUltimate", "+1 Daily Spin" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("x2 Chest Rewards", function()
    local args = { "upgradeUltimate", "x2 Chest Rewards" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("x2 Quest Rewards", function()
    local args = { "upgradeUltimate", "x2 Quest Rewards" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateSection("Enhancements")
Ultimates:CreateButton("Gem Booster", function()
    local args = { "upgradeUltimate", "Gem Booster" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Step Booster", function()
    local args = { "upgradeUltimate", "Step Booster" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Infernal Gems", function()
    local args = { "upgradeUltimate", "Infernal Gems" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Ethereal Orbs", function()
    local args = { "upgradeUltimate", "Ethereal Orbs" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Demon Hoops", function()
    local args = { "upgradeUltimate", "Demon Hoops" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Ultimates:CreateButton("Divine Rebirth", function()
    local args = { "upgradeUltimate", "Divine Rebirth" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)

local function getTableKeys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

Teleports:CreateSection("City Teleports")
local mainLocations = {
    ["City"] = CFrame.new(-9682.98828, 74.8522873, 3099.03394, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381),
    ["Snow City"] = CFrame.new(-9676.13867, 74.8522873, 3782.69385),
    ["Magma City"] = CFrame.new(-11054.9688, 232.791656, 4898.62842),
    ["Legends Highway"] = CFrame.new(-13098.8711, 232.791656, 5907.62793),
    ["Speed Jungle"] = CFrame.new(-15274, 399, 5576)
}
local mainOrder = { "City", "Snow City", "Magma City", "Legends Highway", "Speed Jungle" }

local selectedMainLocation = mainOrder[1]
Teleports:CreateDropdown("Select Location", mainOrder, function(loc)
    selectedMainLocation = loc
end)
Teleports:CreateButton("Teleport", function()
    teleportTo(mainLocations[selectedMainLocation])
end)

Teleports:CreateSection("Race & Other Teleports")
local otherLocations = {
    ["Desert Race"] = CFrame.new(48.3109131, 36.3147125, -8680.45312),
    ["Grassland Race"] = CFrame.new(1686.07495, 36.3147125, -5946.63428),
    ["Magma Race"] = CFrame.new(1001.33118, 36.3147125, -10986.2178),
    ["Space World"] = CFrame.new(-331.764069, 5.45415115, 585.201721),
    ["Desert World"] = CFrame.new(2519.90063, 15.7072296, 4355.74072)
}
local otherOrder = { "Desert Race", "Grassland Race", "Magma Race", "Space World", "Desert World" }

local selectedOtherLocation = otherOrder[1]
Teleports:CreateDropdown("Select Location", otherOrder, function(loc)
    selectedOtherLocation = loc
end)
Teleports:CreateButton("Teleport", function()
    teleportTo(otherLocations[selectedOtherLocation])
end)

Teleports:CreateSection("Space Teleports")
local spaceLocations = {
    ["+1000 Hoop"] = CFrame.new(-477, 156, 755),
    ["Starway Race"] = CFrame.new(-5018, 29, -4779)
}
local spaceOrder = { "+1000 Hoop", "Starway Race" }

local selectedSpaceLocation = spaceOrder[1]
Teleports:CreateDropdown("Select Location", spaceOrder, function(loc)
    selectedSpaceLocation = loc
end)
Teleports:CreateButton("Teleport", function()
    teleportTo(spaceLocations[selectedSpaceLocation])
end)

Teleports:CreateSection("Desert Teleports")
local desertLocations = {
    ["+8000 Hoop"] = CFrame.new(-3386, 259, 16916),
    ["Speedway Race"] = CFrame.new(663, 28, 9767),
    ["Second Island"] = CFrame.new(-10517, 621, -5)
}
local desertOrder = { "+8000 Hoop", "Speedway Race", "Second Island" }

local selectedDesertLocation = desertOrder[1]
Teleports:CreateDropdown("Select Location", desertOrder, function(loc)
    selectedDesertLocation = loc
end)
Teleports:CreateButton("Teleport", function()
    teleportTo(desertLocations[selectedDesertLocation])
end)

Teleports:CreateSection("World Teleports")
local teleportService = game:GetService("TeleportService")
local worldTeleports = {
    ["City"] = 3101667897,
    ["Outer Space"] = 3232996272,
    ["Speed Desert"] = 3276265788
}
local worldOrder = { "City", "Outer Space", "Speed Desert" }

local selectedWorld = worldOrder[1]
Teleports:CreateDropdown("Select Location", worldOrder, function(world)
    selectedWorld = world
end)
Teleports:CreateButton("Teleport", function()
    teleportService:Teleport(worldTeleports[selectedWorld])
end)

Teleports:CreateSection("Server Teleports")
local serverOptions = {
    ["Lowest Player Count"] = LowestPlayer,
    ["Server Hop"] = Serverhop,
    ["Rejoin"] = Rejoin
}
local serverOrder = { "Lowest Player Count", "Server Hop", "Rejoin" }

local selectedServerOption = serverOrder[1]
Teleports:CreateDropdown("Server Options", serverOrder, function(choice)
    selectedServerOption = choice
end)
Teleports:CreateButton("Teleport", function()
    serverOptions[selectedServerOption]()
end)

Experimental:CreateSection("Experimental Features")
Experimental:CreateLabel("These features are experimental and may contain bugs")
Experimental:CreateLabel("If you find anything, report it in our community server")

Experimental:CreateSection("Pet Glitch Control")
Experimental:CreateLabel("Auto-stop pet glitch at a set limit")

local glitchLimit = 0
local glitchEnabled = false

local function convertFormattedNumber(text)
    if not text then return 0 end
    local num, suffix = text:match("([%d%.]+)([KMBT]?)")
    if not num then return 0 end
    num = tonumber(num) or 0
    local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
    local multiplier = multipliers[suffix] or 1
    return math.floor(num * multiplier)
end

Experimental:CreateBox("Set Glitch Limit", function(input)
    glitchLimit = convertFormattedNumber(input)
end)

Experimental:CreateToggle("Enable Glitch Limit", function(state)
    glitchEnabled = state
end)

Experimental.petGlitchTargetLabel = Experimental:CreateLabel("Pet Steps Before Limit: N/A")
Experimental:CreateLabel("Use literal format only (e.g., 148.2K, 65.0M, 2.1B)")

repeat task.wait() until player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("gameGui")
local petMenu = player.PlayerGui.gameGui:FindFirstChild("petsMenu")
local petInfoMenu = petMenu and petMenu:FindFirstChild("petInfoMenu")
local petStepsLabel = petInfoMenu and petInfoMenu:FindFirstChild("totalStepsLabel") and petInfoMenu.totalStepsLabel:FindFirstChild("stepsLabel")

local function checkPetGlitchLimit()
    if glitchEnabled and petStepsLabel and glitchLimit > 0 then
        local steps = convertFormattedNumber(petStepsLabel.Text)
        if steps >= glitchLimit then
            orbFarms.primary.active = false
            orbFarms.secondary.active = false
            orbFarms.third.active = false
            orbFarms.fourth.active = false
        end
    end
end

local function updatePetGlitchTargetLabel()
    if not petStepsLabel then
        Experimental.petGlitchTargetLabel.SetText("Pet Steps Before Limit: N/A")
        return
    end

    local currentSteps = convertFormattedNumber(petStepsLabel.Text)
    if glitchLimit <= 0 then
        Experimental.petGlitchTargetLabel.SetText("Pet Steps Before Limit: N/A")
        return
    end

    local diff = glitchLimit - currentSteps
    if diff <= 0 then
        Experimental.petGlitchTargetLabel.SetText("Pet Steps Before Limit: Reached")
    else
        Experimental.petGlitchTargetLabel.SetText("Pet Steps Before Limit: " .. tostring(diff))
    end
end

if petStepsLabel then
    petStepsLabel:GetPropertyChangedSignal("Text"):Connect(function()
        checkPetGlitchLimit()
        updatePetGlitchTargetLabel()
    end)
end

RunService.Heartbeat:Connect(function()
    checkPetGlitchLimit()
    updatePetGlitchTargetLabel()
end)

checkPetGlitchLimit()
updatePetGlitchTargetLabel()