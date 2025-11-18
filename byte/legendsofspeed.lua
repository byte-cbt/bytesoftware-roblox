--[[
Byte Software - Byte
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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local placeId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local byte = {
    race = "",
    gifts = false,
    chest = false,
    spinWheel = false,
    raceTarget = nil,
    racing = false,
    smoothRacing = false,
    fillRace = false,
    hoop = false,
    rebirth = false,
    rebirthTarget = false,
    enhanceConnection = false,
    instantRebirthAmount = 0,
    rebirthCooldown = 0.2,
    rebirthTargetAmount = 0,
    rebirthTargetCooldown = 0.5
}

local pingLimits = {min = 450, max = 1450}

ReplicatedStorage.raceInProgress.Changed:Connect(
    function()
        if byte.smoothRacing and ReplicatedStorage.raceInProgress.Value then
            ReplicatedStorage.rEvents.raceEvent:FireServer("joinRace")
        end
    end
)

ReplicatedStorage.raceStarted.Changed:Connect(
    function()
        if byte.smoothRacing and ReplicatedStorage.raceStarted.Value then
            for _, v in ipairs(workspace.raceMaps:GetChildren()) do
                local oldCFrame = v.finishPart.CFrame
                v.finishPart.CFrame = player.Character.HumanoidRootPart.CFrame
                wait()
                v.finishPart.CFrame = oldCFrame
            end
            wait(2)
        end
    end
)

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
        settings = {orb = "", city = "", speed = 400, cooldown = 0.4}
    },
    secondary = {
        active = false,
        settings = {orb = "", city = "", speed = 400, cooldown = 0.4}
    },
    third = {
        active = false,
        settings = {orb = "", city = "", speed = 400, cooldown = 0.4}
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
                repeat
                    wait(1)
                    ping = getPing()
                until not stateRef.active or (ping and ping < pingLimits.min)
                if not stateRef.active then
                    break
                end
            end
        end

        local batchSize = math.ceil(settings.speed / 5)
        local remaining = settings.speed

        while remaining > 0 and stateRef.active do
            local thisBatch = math.min(batchSize, remaining)
            for _ = 1, thisBatch do
                game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(
                    "collectOrb",
                    settings.orb,
                    settings.city
                )
            end
            remaining = remaining - thisBatch
            wait(0.11)
        end

        wait(settings.cooldown)
    end
end

local function cleanHoops()
    local player = game.Players.LocalPlayer
    local hoopGui = player:FindFirstChild("PlayerGui"):FindFirstChild("hoopGui")
    if hoopGui then
        local gradient = hoopGui:FindFirstChild("screenGradient")
        if gradient then
            gradient:Destroy()
        end
    end

    local hoopsFolder = workspace:FindFirstChild("Hoops")
    if hoopsFolder then
        for _, hoop in ipairs(hoopsFolder:GetChildren()) do
            for _, childName in ipairs({"hoopParticle", "hoopSound", "playerParticle"}) do
                local part = hoop:FindFirstChild(childName)
                if part then
                    part:Destroy()
                end
            end
        end
    end
end

local function collectHoopsLoop()
    local hrp =
        game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return
    end

    while byte.hoop do
        for _, hoop in ipairs(workspace:FindFirstChild("Hoops"):GetChildren()) do
            firetouchinterest(hoop, hrp, 0)
            wait()
            firetouchinterest(hoop, hrp, 1)
        end
        wait()
    end
end

local function teleportTo(cframe)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
end

local Library = loadstring(game:HttpGet("https://bytesoftware.net/roblox/byte/library.lua", true))()
local Window = Library:CreateWindow("Byte")

local Tab1 = Window:CreateTabs("Information")
local Tab2 = Window:CreateTabs("Utilities")
local Tab3 = Window:CreateTabs("Farming")
local Tab4 = Window:CreateTabs("Rebirths")
local Tab5 = Window:CreateTabs("Calculator")
local Tab6 = Window:CreateTabs("Spy")
local Tab7 = Window:CreateTabs("Pets")
local Tab8 = Window:CreateTabs("Trails")
local Tab9 = Window:CreateTabs("Crystals")
local Tab10 = Window:CreateTabs("Ultimates")
local Tab11 = Window:CreateTabs("Teleports")
local Tab12 = Window:CreateTabs("Settings")

Tab1:CreateSection("Byte")
Tab1:CreateLabel("Thank you for choosing Byte!")
Tab1:CreateLabel("Join our Discord for support")
Tab1:CreateLabel("Developed by Byte (@byt3c0de.net)")

Tab1:CreateSection("Resources")
Tab1:CreateButton(
    "Discord",
    function()
        setclipboard("https://discord.gg/CC4Tgft5w7")
    end
)

Tab1:CreateButton(
    "Website",
    function()
        setclipboard("https://bytesoftware.net/")
    end
)

local fpsvar = 0
local pingvar = 0
local runtimevar = 0
local startTime = tick()

Tab1:CreateSection("Client")

local fpsLabel = Tab1:CreateLabel("FPS: " .. fpsvar)
local pingLabel = Tab1:CreateLabel("Ping: " .. pingvar)
local runtimeLabel = Tab1:CreateLabel("Runtime: " .. runtimevar)

local frameCount, lastTime = 0, tick()
RunService.RenderStepped:Connect(
    function()
        frameCount = frameCount + 1
        local now = tick()
        if now - lastTime >= 1 then
            fpsvar = frameCount
            frameCount = 0
            lastTime = now
            fpsLabel.SetText("FPS: " .. fpsvar)
        end
    end
)

RunService.Heartbeat:Connect(
    function()
        local pingStat = Stats.Network.ServerStatsItem["Data Ping"]
        if pingStat then
            pingvar = math.floor(pingStat:GetValue())
            pingLabel.SetText("Ping: " .. pingvar .. "ms")
        end
    end
)

RunService.Heartbeat:Connect(
    function()
        local elapsed = tick() - startTime
        local minutes = math.floor(elapsed / 60)
        local seconds = math.floor(elapsed % 60)
        runtimeLabel.SetText(string.format("Runtime: %02d:%02d", minutes, seconds))
    end
)

Tab1:CreateSection("Player")

Tab1.statsLabel1 = Tab1:CreateLabel("Steps: ")
Tab1.statsLabel5 = Tab1:CreateLabel("Gems: ")
Tab1.statsLabel2 = Tab1:CreateLabel("Rebirths: ")
Tab1.statsLabel3 = Tab1:CreateLabel("Hoops: ")
Tab1.statsLabel4 = Tab1:CreateLabel("Races: ")

Tab1:CreateSection("Pets")

Tab1.petsLabel1 = Tab1:CreateLabel("Equipped: ")
Tab1.petsLabel2 = Tab1:CreateLabel("Total Steps: ")
Tab1.petsLabel3 = Tab1:CreateLabel("Total Gems: ")

local function updateStats()
    local player = game.Players.LocalPlayer
    local leaderstats = player:FindFirstChild("leaderstats")

    repeat
        wait()
    until player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("gameGui")

    local petMenu = player.PlayerGui.gameGui:FindFirstChild("petsMenu")
    if not petMenu then
        return
    end

    local petInfoMenu = petMenu:FindFirstChild("petInfoMenu")
    if not petInfoMenu then
        return
    end

    local gemMenu = player.PlayerGui.currencyFrameGui:FindFirstChild("currencyFrame")
    if not gemMenu then
        return
    end

    local gemInfoMenu = gemMenu:FindFirstChild("gemsFrame")
    if not gemInfoMenu then
        return
    end

    local equippedPetsLabel = petInfoMenu:FindFirstChild("petsLabel")
    local petStepsLabel =
        petInfoMenu:FindFirstChild("totalStepsLabel") and petInfoMenu.totalStepsLabel:FindFirstChild("stepsLabel")
    local petGemsLabel =
        petInfoMenu:FindFirstChild("totalGemsLabel") and petInfoMenu.totalGemsLabel:FindFirstChild("gemsLabel")
    local gemsLabel = gemInfoMenu:FindFirstChild("amountLabel")

    local function convertFormattedNumber(text)
        if not text then
            return "0"
        end

        local num, suffix = text:match("([%d%.]+)([KMBT]?)")
        if not num then
            return "0"
        end

        num = tonumber(num) or 0

        local multipliers = {K = 1e3, M = 1e6, B = 1e9, T = 1e12}
        local multiplier = multipliers[suffix] or 1
        return tostring(math.floor(num * multiplier))
    end

    local function onStatChanged()
        if leaderstats then
            if leaderstats:FindFirstChild("Steps") then
                Tab1.statsLabel1.SetText("Steps: " .. leaderstats.Steps.Value)
            end
            if leaderstats:FindFirstChild("Rebirths") then
                Tab1.statsLabel2.SetText("Rebirths: " .. leaderstats.Rebirths.Value)
            end
            if leaderstats:FindFirstChild("Hoops") then
                Tab1.statsLabel3.SetText("Hoops: " .. leaderstats.Hoops.Value)
            end
            if leaderstats:FindFirstChild("Races") then
                Tab1.statsLabel4.SetText("Races: " .. leaderstats.Races.Value)
            end
        end

        if gemsLabel then
            local gemCount = convertFormattedNumber(gemsLabel.Text)
            Tab1.statsLabel5.SetText("Gems: " .. gemCount)
        end

        if equippedPetsLabel then
            local petCount = convertFormattedNumber(equippedPetsLabel.Text)
            Tab1.petsLabel1.SetText("Equipped: " .. petCount)
        end
        if petStepsLabel then
            local stepsCount = convertFormattedNumber(petStepsLabel.Text)
            Tab1.petsLabel2.SetText("Total Steps: " .. stepsCount)
        end
        if petGemsLabel then
            local gemsCount = convertFormattedNumber(petGemsLabel.Text)
            Tab1.petsLabel3.SetText("Total Gems: " .. gemsCount)
        end
    end

    if leaderstats then
        for _, stat in ipairs(leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                stat.Changed:Connect(onStatChanged)
            end
        end
    end

    if gemsLabel then
        gemsLabel:GetPropertyChangedSignal("Text"):Connect(onStatChanged)
    end

    if equippedPetsLabel then
        equippedPetsLabel:GetPropertyChangedSignal("Text"):Connect(onStatChanged)
    end
    if petStepsLabel then
        petStepsLabel:GetPropertyChangedSignal("Text"):Connect(onStatChanged)
    end
    if petGemsLabel then
        petGemsLabel:GetPropertyChangedSignal("Text"):Connect(onStatChanged)
    end
    onStatChanged()
end
updateStats()

Tab2:CreateSection("Performance")
Tab2:CreateBox(
    "Set FPS Cap",
    function(v)
        RunService:Set3dRenderingEnabled(true)
        setfpscap(tonumber(v) or 60)
    end
)
Tab2:CreateToggle(
    "Enable Ping Stabilizer",
    function(state)
        pingMonitorActive = state
        if state then
            spawn(
                function()
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
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Connection Enhancer",
    function(state)
        byte.enhanceConnection = state
        if state then
            spawn(
                function()
                    while byte.enhanceConnection do
                        local networkClient = game:GetService("NetworkClient")
                        networkClient:SetOutgoingKBPSLimit(800000)
                        networkClient:SetIncomingKBPSLimit(800000)
                        wait(5)
                    end
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Anti-Idle Protection",
    function(state)
        if state then
            antiKickConnection =
                game:GetService("Players").LocalPlayer.Idled:Connect(
                function()
                    local vu = game:GetService("VirtualUser")
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
                end
            )
        elseif antiKickConnection then
            antiKickConnection:Disconnect()
            antiKickConnection = nil
        end
    end
)

Tab2:CreateSection("Automation")
Tab2:CreateLabel("Races")

Tab2:CreateDropdown(
    "Racing Method",
    {"Teleport", "Smooth"},
    function(selected)
        byte.race = selected
    end
)
Tab2:CreateBox(
    "Set Race Target",
    function(raceInput)
        local target = tonumber(raceInput)
        if target and target > 0 then
            byte.raceTarget = target
        else
            byte.raceTarget = nil
        end
    end
)
Tab2:CreateToggle(
    "Fill Race Queue",
    function(state)
        byte.fillRace = state
        if state then
            spawn(
                function()
                    while byte.fillRace do
                        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer(
                            "joinRace"
                        )
                        wait()
                    end
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Enable Race Automation",
    function(state)
        byte.racing = state

        if not state then
            byte.racing = false
            byte.smoothRacing = false
            return
        end

        if byte.race == "Teleport" then
            spawn(
                function()
                    local startCount =
                        player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Races") and
                        player.leaderstats.Races.Value or
                        0
                    ReplicatedStorage.rEvents.raceEvent:FireServer("joinRace")
                    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    local racePoints = {
                        Vector3.new(48.31, 36.31, -8680.45),
                        Vector3.new(1686.07, 36.31, -5946.63),
                        Vector3.new(1001.33, 36.31, -10986.22)
                    }

                    while byte.racing do
                        local currentCount =
                            player.leaderstats and player.leaderstats.Races and player.leaderstats.Races.Value or 0
                        if byte.raceTarget and currentCount >= byte.raceTarget then
                            byte.racing = false
                            break
                        end

                        if hrp then
                            for _, pos in ipairs(racePoints) do
                                if not byte.racing or byte.race ~= "Teleport" then
                                    break
                                end
                                hrp.CFrame = CFrame.new(pos)
                                wait(0.4)
                            end
                        end
                        wait(0.5)
                    end
                end
            )
        elseif byte.race == "Smooth" then
            byte.smoothRacing = true
            spawn(
                function()
                    while byte.smoothRacing and byte.racing do
                        local currentCount =
                            player.leaderstats and player.leaderstats.Races and player.leaderstats.Races.Value or 0
                        if byte.raceTarget and currentCount >= byte.raceTarget then
                            byte.racing = false
                            byte.smoothRacing = false
                            break
                        end
                        wait(1)
                    end
                end
            )
        end
    end
)

Tab2:CreateLabel("Hoops")
Tab2:CreateButton("Clear Hoops", cleanHoops)
Tab2:CreateToggle(
    "Enable Hoop Automation",
    function(state)
        byte.hoop = state
        if state then
            spawn(collectHoopsLoop)
        end
    end
)

Tab2:CreateSection("Miscellaneous")
Tab2:CreateToggle(
    "Enable Gift Automation",
    function(state)
        byte.gifts = state
        if state then
            spawn(
                function()
                    while byte.gifts do
                        for i = 1, 8 do
                            local remote =
                                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild(
                                "freeGiftClaimRemote"
                            )
                            remote:InvokeServer("claimGift", i)
                        end
                        wait(0.5)
                    end
                end
            )
        end
    end
)

Tab2:CreateToggle(
    "Enable Chest Automation",
    function(state)
        byte.chests = state
        if state then
            spawn(
                function()
                    while byte.chests do
                        local rEvents = game:GetService("ReplicatedStorage"):WaitForChild("rEvents")

                        rEvents:WaitForChild("groupRemote"):InvokeServer("groupRewards")

                        local checkChestRemote = rEvents:WaitForChild("checkChestRemote")
                        local chests = {"Magma Chest", "Enchanted Chest", "Golden Chest"}

                        for _, chestName in ipairs(chests) do
                            checkChestRemote:InvokeServer(chestName)
                        end

                        wait(0.5)
                    end
                end
            )
        end
    end
)

Tab2:CreateToggle(
    "Enable Wheel Automation",
    function(state)
        byte.spinWheel = state
        if state then
            spawn(
                function()
                    local replicatedStorage = game:GetService("ReplicatedStorage")
                    local rEvents = replicatedStorage:WaitForChild("rEvents")
                    local wheelRemote = rEvents:WaitForChild("openFortuneWheelRemote")
                    local wheelChance =
                        replicatedStorage:WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")

                    while byte.spinWheel do
                        wheelRemote:InvokeServer("openFortuneWheel", wheelChance)
                        wait(0.5)
                    end
                end
            )
        end
    end
)

Tab2:CreateButton(
    "Unlock Codes",
    function()
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
    end
)

Tab3:CreateSection("Orb Automation")

Tab3:CreateLabel("Main Automation")

Tab3:CreateDropdown(
    "Orb Type",
    validOrbs,
    function(selected)
        orbFarms.primary.settings.orb = selected
    end
)

Tab3:CreateDropdown(
    "Target City",
    validCities,
    function(selected)
        orbFarms.primary.settings.city = selected
    end
)

Tab3:CreateBox(
    "Collection Rate",
    function(input)
        local number = tonumber(input)
        if number then
            orbFarms.primary.settings.speed = number
        end
    end
)

Tab3:CreateBox(
    "Batch Cooldown",
    function(input)
        local inputNumber = tonumber(input)
        if inputNumber and inputNumber > 0 then
            orbFarms.primary.settings.cooldown = inputNumber / 1000
        else
            orbFarms.primary.settings.cooldown = 0.4
        end
    end
)

Tab3:CreateToggle(
    "Enable Orb Automation",
    function(state)
        orbFarms.primary.active = state
        if state then
            spawn(
                function()
                    startOrbFarm(orbFarms.primary, orbFarms.primary.settings)
                end
            )
        end
    end
)

Tab3:CreateLabel("Backup Automation")

Tab3:CreateDropdown(
    "Set Orb",
    validOrbs,
    function(selected)
        orbFarms.secondary.settings.orb = selected
    end
)

Tab3:CreateDropdown(
    "Set City",
    validCities,
    function(selected)
        orbFarms.secondary.settings.city = selected
    end
)

Tab3:CreateBox(
    "Collection Rate",
    function(input)
        local number = tonumber(input)
        if number then
            orbFarms.secondary.settings.speed = number
        end
    end
)

Tab3:CreateBox(
    "Batch Cooldown",
    function(input)
        local inputNumber = tonumber(input)
        if inputNumber and inputNumber > 0 then
            orbFarms.secondary.settings.cooldown = inputNumber / 1000
        else
            orbFarms.secondary.settings.cooldown = 0.4
        end
    end
)

Tab3:CreateToggle(
    "Enable Orb Automation",
    function(state)
        orbFarms.secondary.active = state
        if state then
            spawn(
                function()
                    startOrbFarm(orbFarms.secondary, orbFarms.secondary.settings)
                end
            )
        end
    end
)

Tab3:CreateLabel("Extra Automation")

Tab3:CreateDropdown(
    "Orb Type",
    validOrbs,
    function(selected)
        orbFarms.third.settings.orb = selected
    end
)

Tab3:CreateDropdown(
    "Target City",
    validCities,
    function(selected)
        orbFarms.third.settings.city = selected
    end
)

Tab3:CreateBox(
    "Collection Rate",
    function(input)
        local number = tonumber(input)
        if number then
            orbFarms.third.settings.speed = number
        end
    end
)

Tab3:CreateBox(
    "Batch Cooldown",
    function(input)
        local inputNumber = tonumber(input)
        if inputNumber and inputNumber > 0 then
            orbFarms.third.settings.cooldown = inputNumber / 1000
        else
            orbFarms.third.settings.cooldown = 0.4
        end
    end
)

Tab3:CreateToggle(
    "Enable Orb Automation",
    function(state)
        orbFarms.third.active = state
        if state then
            spawn(
                function()
                    startOrbFarm(orbFarms.third, orbFarms.third.settings)
                end
            )
        end
    end
)

Tab4:CreateSection("Rebirth Automation")

Tab4:CreateLabel("Automatic")
Tab4:CreateBox(
    "Rebirth Cooldown",
    function(input)
        byte.rebirthCooldown = tonumber(input) or 0.2
    end
)

Tab4:CreateToggle(
    "Enable Rebirth Automation",
    function(state)
        byte.rebirth = state
        if state then
            spawn(
                function()
                    while byte.rebirth do
                        ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                        wait(byte.rebirthCooldown)
                    end
                end
            )
        end
    end
)

Tab4:CreateLabel("Target-Based")

Tab4:CreateBox(
    "Target Amount",
    function(input)
        byte.rebirthTargetAmount = tonumber(input) or 0
    end
)

Tab4:CreateBox(
    "Target Cooldown",
    function(input)
        byte.rebirthTargetCooldown = tonumber(input) or 0.5
    end
)

Tab4:CreateToggle(
    "Enable Rebirth Automation",
    function(state)
        byte.rebirthTarget = state
        if state then
            spawn(
                function()
                    while byte.rebirthTarget do
                        local success =
                            pcall(
                            function()
                                local leaderstats = player:FindFirstChild("leaderstats")
                                local rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths")
                                if not rebirths then
                                    return
                                end

                                local before = rebirths.Value
                                ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                                wait(byte.rebirthTargetCooldown)
                                local after = rebirths.Value

                                if after >= byte.rebirthTargetAmount then
                                    DesyncedLibrary:createNotification("Successfully reached rebirth target!")
                                    byte.rebirthTarget = false
                                    orbFarms.primary.active = false
                                    orbFarms.secondary.active = false
                                    orbFarms.third.active = false
                                end
                            end
                        )

                        if not success then
                            byte.rebirthTarget = false
                            orbFarms.primary.active = false
                            orbFarms.secondary.active = false
                            orbFarms.third.active = false
                        end
                    end
                end
            )
        else
            byte.rebirthTarget = false
            orbFarms.primary.active = false
            orbFarms.secondary.active = false
            orbFarms.third.active = false
        end
    end
)

Tab4:CreateLabel("Instant")

Tab4:CreateBox(
    "Rebirth Amount",
    function(input)
        byte.instantRebirthAmount = tonumber(input) or 0
    end
)

Tab4:CreateButton(
    "Execute Rebirths",
    function()
        for i = 1, byte.instantRebirthAmount do
            ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
        end
    end
)

Tab5:CreateSection("Rebirth Calculator")
Tab5:CreateLabel("Calculation Options")

local MAX_REBIRTH = 250000

local Base_PetType_XP_Threshold = {
    Basic = 1000,
    Advanced = 2000,
    Rare = 3000,
    Epic = 4000,
    Unique = 5000,
    Omega = 10000
}

local Base_Stats_Per_Add = {
    Basic = 1,
    Advanced = 3,
    Rare = 4,
    Epic = 5,
    Unique = 6,
    Omega = 7
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
    Ethereal_SpeedJungle = 1500
}

local NoStepBooster = {
    Yellow_City = 15,
    Yellow_SnowCity = 30,
    Yellow_MagmaCity = 45,
    Yellow_LegendsHighway = 60,
    Yellow_SpeedJungle = 75,
    Red_MagmaCity = 60,
    Ethereal_MagmaCity = 600
}

local rebirthValue = 0
local hasStepBoosters = false
local hasPremium = false

Tab5:CreateBox(
    "Rebirth Count",
    function(input)
        rebirthValue = tonumber(input)
    end
)

Tab5:CreateToggle(
    "Step Boosters",
    function(state)
        hasStepBoosters = state
    end
)

Tab5:CreateToggle(
    "Premium",
    function(state)
        hasPremium = state
    end
)

local orbLabel
local cityLabel
local speedLabel
local petLabel

Tab5:CreateButton(
    "Calculate Glitch",
    function()
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
                            table.insert(
                                results,
                                {
                                    orb = orbType,
                                    city = loc,
                                    pet = petType,
                                    speed = stats
                                }
                            )
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
            orbLabel.SetText("Orb: -")
            cityLabel.SetText("City: -")
            speedLabel.SetText("Speed: -")
            petLabel.SetText("Pet: -")

            game:GetService("StarterGui"):SetCore(
                "SendNotification",
                {
                    Title = "Byte",
                    Text = "Invalid rebirth!",
                    Icon = "rbxassetid://133836095002760",
                    Duration = 5
                }
            )
            return
        end

        local results = check_glitch(rebirthValue)

        if #results > 0 then
            table.sort(
                results,
                function(a, b)
                    return a.speed > b.speed
                end
            )

            local best = results[1]
            orbLabel.SetText("Orb: " .. best.orb)
            cityLabel.SetText("City: " .. best.city)
            speedLabel.SetText("Speed: +" .. best.speed)
            petLabel.SetText("Pet: " .. best.pet)

            game:GetService("StarterGui"):SetCore(
                "SendNotification",
                {
                    Title = "Byte",
                    Text = "Glitch found!",
                    Icon = "rbxassetid://133836095002760",
                    Duration = 5
                }
            )
        else
            orbLabel.SetText("Orb: -")
            cityLabel.SetText("City: -")
            speedLabel.SetText("Speed: -")
            petLabel.SetText("Pet: -")

            game:GetService("StarterGui"):SetCore(
                "SendNotification",
                {
                    Title = "Byte",
                    Text = "No glitch found!",
                    Icon = "rbxassetid://133836095002760",
                    Duration = 5
                }
            )
        end
    end
)

Tab5:CreateButton(
    "Clear Results",
    function()
        orbLabel.SetText("Orb: -")
        cityLabel.SetText("City: -")
        speedLabel.SetText("Speed: -")
        petLabel.SetText("Pet: -")
    end
)

Tab5:CreateLabel("Calculation Results")

orbLabel = Tab5:CreateLabel("Orb: -")
cityLabel = Tab5:CreateLabel("City: -")
speedLabel = Tab5:CreateLabel("Speed: -")
petLabel = Tab5:CreateLabel("Pet: -")

Tab6:CreateSection("Player Statistics Spy")

local liveMode = false
local liveConnections = {}

local function updateOtherPlayerStats(username)
    local Players = game:GetService("Players")
    local targetPlayer = Players:FindFirstChild(username)

    for _, conn in ipairs(liveConnections) do
        if conn.Connected then
            conn:Disconnect()
        end
    end
    liveConnections = {}

    if not targetPlayer or not targetPlayer:FindFirstChild("leaderstats") then
        Tab6.statsLabel1.SetText("Steps: -")
        Tab6.statsLabel2.SetText("Rebirths: -")
        Tab6.statsLabel3.SetText("Hoops: -")
        Tab6.statsLabel4.SetText("Races: -")
        return
    end

    local leaderstats = targetPlayer.leaderstats

    local function updateLabels()
        Tab6.statsLabel1.SetText("Steps: " .. (leaderstats.Steps and leaderstats.Steps.Value or "-"))
        Tab6.statsLabel2.SetText("Rebirths: " .. (leaderstats.Rebirths and leaderstats.Rebirths.Value or "-"))
        Tab6.statsLabel3.SetText("Hoops: " .. (leaderstats.Hoops and leaderstats.Hoops.Value or "-"))
        Tab6.statsLabel4.SetText("Races: " .. (leaderstats.Races and leaderstats.Races.Value or "-"))
    end

    updateLabels()

    if liveMode then
        for _, statName in ipairs({"Steps", "Rebirths", "Hoops", "Races"}) do
            local stat = leaderstats:FindFirstChild(statName)
            if stat then
                table.insert(liveConnections, stat.Changed:Connect(updateLabels))
            end
        end
    end
end

Tab6:CreateLabel("Spy Options")
local targetUsername = ""
Tab6:CreateBox(
    "Player Username",
    function(input)
        targetUsername = input
    end
)
Tab6:CreateButton(
    "Check Statistics",
    function()
        if targetUsername ~= "" then
            updateOtherPlayerStats(targetUsername)
        end
    end
)
Tab6:CreateToggle(
    "Live Statistics",
    function(state)
        liveMode = state
        if targetUsername ~= "" then
            updateOtherPlayerStats(targetUsername)
        end
    end
)
Tab6:CreateButton(
    "Clear Results",
    function()
        Tab6.statsLabel1.SetText("Steps: -")
        Tab6.statsLabel2.SetText("Rebirths: -")
        Tab6.statsLabel3.SetText("Hoops: -")
        Tab6.statsLabel4.SetText("Races: -")
    end
)

Tab6:CreateLabel("Spy Results")

Tab6.statsLabel1 = Tab6:CreateLabel("Steps: -")
Tab6.statsLabel2 = Tab6:CreateLabel("Rebirths: -")
Tab6.statsLabel3 = Tab6:CreateLabel("Hoops: -")
Tab6.statsLabel4 = Tab6:CreateLabel("Races: -")

Tab7:CreateSection("Pet Hatching")

local function createPetHatchSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateLabel(sectionName)

    _G[selectionVarName] = petList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown(
        "Select Pet",
        petList,
        function(input)
            _G[selectionVarName] = input
        end
    )

    tab:CreateToggle(
        "Enable Hatch Automation",
        function(state)
            _G[toggleVarName] = state
            if state then
                spawn(
                    function()
                        while _G[toggleVarName] do
                            local pet = _G[selectionVarName]
                            if pet then
                                local args = {
                                    game:GetService("ReplicatedStorage"):WaitForChild("cPetShopFolder"):WaitForChild(
                                        pet
                                    )
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("cPetShopRemote"):InvokeServer(
                                    unpack(args)
                                )
                            end
                            wait()
                        end
                    end
                )
            end
        end
    )
end

createPetHatchSection(
    Tab7,
    "Hatch Basic Pets",
    {
        "Red Bunny",
        "Red Kitty",
        "Blue Bunny",
        "Silver Dog",
        "Yellow Squeak"
    },
    "selectedbasicpettohatch",
    "hatchBasicPets"
)

createPetHatchSection(
    Tab7,
    "Hatch Advanced Pets",
    {
        "Green Vampy",
        "Dark Golem",
        "Pink Butterfly",
        "Yellow Butterfly",
        "Green Golem"
    },
    "selectedadvancedpettohatch",
    "hatchAdvancedPets"
)

createPetHatchSection(
    Tab7,
    "Hatch Rare Pets",
    {
        "Purple Pegasus",
        "Golden Angel",
        "Orange Pegasus",
        "Orange Falcon",
        "Blue Firecaster",
        "White Phoenix",
        "Red Phoenix",
        "Red Firecaster"
    },
    "selectedrarepettohatch",
    "hatchRarePets"
)

createPetHatchSection(
    Tab7,
    "Hatch Epic Pets",
    {
        "Golden Phoenix",
        "Green Firecaster",
        "Voltaic Falcon",
        "Blue Phoenix",
        "Divine Pegasus"
    },
    "selectedepicpettohatch",
    "hatchEpicPets"
)

createPetHatchSection(
    Tab7,
    "Hatch Unique Pets",
    {
        "Flaming Hedgehog",
        "Electro Golem",
        "Voltaic Falcon",
        "Void Dragon",
        "Ultra Birdie",
        "Quantum Dragon",
        "Tundra Dragon",
        "Magic Butterfly",
        "Maestro Dog",
        "Golden Viking",
        "Speedy Sensei"
    },
    "selecteduniquepettohatch",
    "hatchUniquePets"
)

createPetHatchSection(
    Tab7,
    "Hatch Omega Pets",
    {
        "Soul Fusion Dog",
        "Hypersonic Pegasus",
        "Dark Soul Birdie",
        "Eternal Nebula Dragon",
        "Shadows Edge Kitty",
        "Ultimate Overdrive Bunny",
        "Swift Samurai"
    },
    "selectedomegapettohatch",
    "hatchOmegaPets"
)

Tab7:CreateSection("Pet Evolving")

local function createPetEvolveSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateLabel(sectionName)

    _G[selectionVarName] = petList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown(
        "Select Pet",
        petList,
        function(input)
            _G[selectionVarName] = input
        end
    )

    tab:CreateToggle(
        "Enable Evolve Automation",
        function(state)
            _G[toggleVarName] = state
            if state then
                spawn(
                    function()
                        while _G[toggleVarName] do
                            local pet = _G[selectionVarName]
                            if pet then
                                local args = {
                                    "evolvePet",
                                    pet
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild(
                                    "petEvolveEvent"
                                ):FireServer(unpack(args))
                            end
                            wait()
                        end
                    end
                )
            end
        end
    )
end

createPetEvolveSection(
    Tab7,
    "Evolve Basic Pets",
    {
        "Red Bunny",
        "Red Kitty",
        "Blue Bunny",
        "Silver Dog",
        "Yellow Squeak"
    },
    "selectedbasicpettoevolve",
    "evolveBasicPets"
)

createPetEvolveSection(
    Tab7,
    "Evolve Advanced Pets",
    {
        "Green Vampy",
        "Dark Golem",
        "Pink Butterfly",
        "Yellow Butterfly",
        "Green Golem"
    },
    "selectedadvancedpettoevolve",
    "evolveAdvancedPets"
)

createPetEvolveSection(
    Tab7,
    "Evolve Rare Pets",
    {
        "Purple Pegasus",
        "Golden Angel",
        "Orange Pegasus",
        "Orange Falcon",
        "Blue Firecaster",
        "White Phoenix",
        "Red Phoenix",
        "Red Firecaster"
    },
    "selectedrarepettoevolve",
    "evolveRarePets"
)

createPetEvolveSection(
    Tab7,
    "Evolve Epic Pets",
    {
        "Golden Phoenix",
        "Green Firecaster",
        "Voltaic Falcon",
        "Blue Phoenix",
        "Divine Pegasus"
    },
    "selectedepicpettoevolve",
    "evolveEpicPets"
)

createPetEvolveSection(
    Tab7,
    "Evolve Unique Pets",
    {
        "Flaming Hedgehog",
        "Electro Golem",
        "Voltaic Falcon",
        "Void Dragon",
        "Ultra Birdie",
        "Quantum Dragon",
        "Tundra Dragon",
        "Magic Butterfly",
        "Maestro Dog",
        "Golden Viking",
        "Speedy Sensei"
    },
    "selecteduniquepettoevolve",
    "evolveUniquePets"
)

createPetEvolveSection(
    Tab7,
    "Evolve Omega Pets",
    {
        "Soul Fusion Dog",
        "Hypersonic Pegasus",
        "Dark Soul Birdie",
        "Eternal Nebula Dragon",
        "Shadows Edge Kitty",
        "Ultimate Overdrive Bunny",
        "Swift Samurai"
    },
    "selectedomegapettoevolve",
    "evolveOmegaPets"
)

Tab8:CreateSection("Hatch Trails")

local function createTrailSection(tab, label, trailList)
    tab:CreateLabel(label)

    local selected = "_G.selectedTrail_" .. label
    local toggle = "_G.trailToggle_" .. label

    _G[selected] = trailList[1]
    _G[toggle] = false

    tab:CreateDropdown(
        "Select Trail",
        trailList,
        function(choice)
            _G[selected] = choice
        end
    )

    tab:CreateToggle(
        "Enable Hatch Automation",
        function(state)
            _G[toggle] = state
            if state then
                spawn(
                    function()
                        while _G[toggle] do
                            wait()
                            local chosen = _G[selected]
                            if chosen then
                                local args = {
                                    game:GetService("ReplicatedStorage"):WaitForChild("cPetShopFolder"):WaitForChild(
                                        chosen
                                    )
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("cPetShopRemote"):InvokeServer(
                                    unpack(args)
                                )
                            end
                        end
                    end
                )
            end
        end
    )
end

createTrailSection(
    Tab8,
    "1-5 Trails",
    {
        "1st Trail",
        "2nd Trail",
        "Third Trail",
        "Fourth Trail",
        "Fifth Trail"
    }
)

createTrailSection(
    Tab8,
    "B Trails",
    {
        "BG Speed",
        "Blue & Green",
        "Blue Coin",
        "Blue Gem",
        "Blue Lightning",
        "Blue Snow",
        "Blue Soul",
        "Blue Sparks",
        "Blue Storm",
        "Blue Trail"
    }
)

createTrailSection(Tab8, "D Trails", {"Dragonfire"})

createTrailSection(
    Tab8,
    "G Trails",
    {
        "Golden Lightning",
        "Green & Orange",
        "Green Coin",
        "Green Gem",
        "Green Lightning",
        "Green Snow",
        "Green Soul",
        "Green Sparks",
        "Green Storm",
        "Green Trail"
    }
)

createTrailSection(Tab8, "H Trails", {"Hyperblast"})

createTrailSection(
    Tab8,
    "O Trails",
    {
        "OG Speed",
        "Orange Coin",
        "Orange Gem",
        "Orange Lightning",
        "Orange Snow",
        "Orange Soul",
        "Orange Sparks",
        "Orange Storm",
        "Orange Trail"
    }
)

createTrailSection(
    Tab8,
    "P Trails",
    {
        "PP Speed",
        "Pink Gem",
        "Pink Lightning",
        "Pink Snow",
        "Pink Soul",
        "Pink Sparks",
        "Pink Storm",
        "Pink Trail",
        "Purple & Pink",
        "Purple Coin",
        "Purple Gem",
        "Purple Lightning",
        "Purple Soul",
        "Purple Sparks",
        "Purple Storm",
        "Purple Trail"
    }
)

createTrailSection(
    Tab8,
    "R Trails",
    {
        "RB Speed",
        "Rainbow Lightning",
        "Rainbow Soul",
        "Rainbow Sparks",
        "Rainbow Speed",
        "Rainbow Steps",
        "Rainbow Storm",
        "Rainbow Trail",
        "Red & Blue",
        "Red Coin",
        "Red Gem",
        "Red Lightning",
        "Red Snow",
        "Red Soul",
        "Red Sparks",
        "Red Storm",
        "Red Trail"
    }
)

createTrailSection(Tab8, "W Trails", {"White Snow"})

createTrailSection(
    Tab8,
    "Y Trails",
    {
        "YB Speed",
        "Yellow & Blue",
        "Yellow Soul",
        "Yellow Sparks",
        "Yellow Trail"
    }
)

Tab9:CreateSection("Open Crystals")

local function createCrystalSection(tab, sectionName, crystalList, selectionVarName, toggleVarName)
    tab:CreateLabel(sectionName)

    _G[selectionVarName] = crystalList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown(
        "Select Crystal",
        crystalList,
        function(input)
            _G[selectionVarName] = input
        end
    )

    tab:CreateToggle(
        "Enable Open Automation",
        function(state)
            _G[toggleVarName] = state
            if state then
                spawn(
                    function()
                        while _G[toggleVarName] do
                            local crystal = _G[selectionVarName]
                            if crystal then
                                local args = {[1] = "openCrystal", [2] = crystal}
                                game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild(
                                    "openCrystalRemote"
                                ):InvokeServer(unpack(args))
                            end
                            wait()
                        end
                    end
                )
            end
        end
    )
end

local cityCrystals = {
    "Red Crystal",
    "Lightning Crystal",
    "Yellow Crystal",
    "Purple Crystal",
    "Blue Crystal",
    "Snow Crystal",
    "Lava Crystal",
    "Inferno Crystal",
    "Electro Legends Crystal",
    "Jungle Crystal"
}

local spaceCrystals = {
    "Space Crystal",
    "Alien Crystal"
}

local desertCrystals = {
    "Desert Crystal",
    "Electro Crystal"
}

createCrystalSection(Tab9, "City Crystals", cityCrystals, "selectedCityCrystal", "autoOpenCityCrystal")
createCrystalSection(Tab9, "Space Crystals", spaceCrystals, "selectedSpaceCrystal", "autoOpenSpaceCrystal")
createCrystalSection(Tab9, "Desert Crystals", desertCrystals, "selectedDesertCrystal", "autoOpenDesertCrystal")

Tab10:CreateSection("Unlock Ultimates")
Tab10:CreateLabel("Rebirth Pets")
Tab10:CreateButton(
    "Magzor",
    function()
        local args = {"upgradeUltimate", "Magzor"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Crowd Surfer",
    function()
        local args = {"upgradeUltimate", "Crowd Surfer"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Sorenzo",
    function()
        local args = {"upgradeUltimate", "Sorenzo"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateLabel("Game Upgrades")
Tab10:CreateButton(
    "x2 Trail Boosts",
    function()
        local args = {"upgradeUltimate", "x2 Trail Boosts"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "+1 Pet Slot",
    function()
        local args = {"upgradeUltimate", "+1 Pet Slot"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "+10 Item Capacity",
    function()
        local args = {"upgradeUltimate", "+10 Item Capacity"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "+1 Daily Spin",
    function()
        local args = {"upgradeUltimate", "+1 Daily Spin"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "x2 Chest Rewards",
    function()
        local args = {"upgradeUltimate", "x2 Chest Rewards"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "x2 Quest Rewards",
    function()
        local args = {"upgradeUltimate", "x2 Quest Rewards"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateLabel("Enhancements")
Tab10:CreateButton(
    "Gem Booster",
    function()
        local args = {"upgradeUltimate", "Gem Booster"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Step Booster",
    function()
        local args = {"upgradeUltimate", "Step Booster"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Infernal Gems",
    function()
        local args = {"upgradeUltimate", "Infernal Gems"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Ethereal Orbs",
    function()
        local args = {"upgradeUltimate", "Ethereal Orbs"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Demon Hoops",
    function()
        local args = {"upgradeUltimate", "Demon Hoops"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)
Tab10:CreateButton(
    "Divine Rebirth",
    function()
        local args = {"upgradeUltimate", "Divine Rebirth"}
        game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
    end
)

local function getTableKeys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

Tab11:CreateSection("Player Teleports")

Tab11:CreateLabel("Main Teleports")
local mainLocations = {
    ["City"] = CFrame.new(
        -9682.98828,
        74.8522873,
        3099.03394,
        0.087131381,
        0,
        0.996196866,
        0,
        1,
        0,
        -0.996196866,
        0,
        0.087131381
    ),
    ["Snow City"] = CFrame.new(-9676.13867, 74.8522873, 3782.69385),
    ["Magma City"] = CFrame.new(-11054.9688, 232.791656, 4898.62842),
    ["Legends Highway"] = CFrame.new(-13098.8711, 232.791656, 5907.62793),
    ["Speed Jungle"] = CFrame.new(-15274, 399, 5576)
}
local mainOrder = {"City", "Snow City", "Magma City", "Legends Highway", "Speed Jungle"}

local selectedMainLocation = mainOrder[1]
Tab11:CreateDropdown(
    "Set Location",
    mainOrder,
    function(loc)
        selectedMainLocation = loc
    end
)
Tab11:CreateButton(
    "Teleport",
    function()
        teleportTo(mainLocations[selectedMainLocation])
    end
)

Tab11:CreateLabel("Race & Other Areas")
local otherLocations = {
    ["Desert Race"] = CFrame.new(48.3109131, 36.3147125, -8680.45312),
    ["Grassland Race"] = CFrame.new(1686.07495, 36.3147125, -5946.63428),
    ["Magma Race"] = CFrame.new(1001.33118, 36.3147125, -10986.2178),
    ["Space World"] = CFrame.new(-331.764069, 5.45415115, 585.201721),
    ["Desert World"] = CFrame.new(2519.90063, 15.7072296, 4355.74072)
}
local otherOrder = {"Desert Race", "Grassland Race", "Magma Race", "Space World", "Desert World"}

local selectedOtherLocation = otherOrder[1]
Tab11:CreateDropdown(
    "Set Location",
    otherOrder,
    function(loc)
        selectedOtherLocation = loc
    end
)
Tab11:CreateButton(
    "Teleport",
    function()
        teleportTo(otherLocations[selectedOtherLocation])
    end
)

Tab11:CreateLabel("Space Teleports")
local spaceLocations = {
    ["+1000 Hoop"] = CFrame.new(-477, 156, 755),
    ["Starway Race"] = CFrame.new(-5018, 29, -4779)
}
local spaceOrder = {"+1000 Hoop", "Starway Race"}

local selectedSpaceLocation = spaceOrder[1]
Tab11:CreateDropdown(
    "Set Location",
    spaceOrder,
    function(loc)
        selectedSpaceLocation = loc
    end
)
Tab11:CreateButton(
    "Teleport",
    function()
        teleportTo(spaceLocations[selectedSpaceLocation])
    end
)

Tab11:CreateLabel("Desert Teleports")
local desertLocations = {
    ["+8000 Hoop"] = CFrame.new(-3386, 259, 16916),
    ["Speedway Race"] = CFrame.new(663, 28, 9767),
    ["Second Island"] = CFrame.new(-10517, 621, -5)
}
local desertOrder = {"+8000 Hoop", "Speedway Race", "Second Island"}

local selectedDesertLocation = desertOrder[1]
Tab11:CreateDropdown(
    "Set Location",
    desertOrder,
    function(loc)
        selectedDesertLocation = loc
    end
)
Tab11:CreateButton(
    "Teleport",
    function()
        teleportTo(desertLocations[selectedDesertLocation])
    end
)

Tab11:CreateLabel("World Teleports")
local teleportService = game:GetService("TeleportService")
local worldTeleports = {
    ["City"] = 3101667897,
    ["Outer Space"] = 3232996272,
    ["Speed Desert"] = 3276265788
}
local worldOrder = {"City", "Outer Space", "Speed Desert"}

local selectedWorld = worldOrder[1]
Tab11:CreateDropdown(
    "Set Location",
    worldOrder,
    function(world)
        selectedWorld = world
    end
)
Tab11:CreateButton(
    "Teleport",
    function()
        teleportService:Teleport(worldTeleports[selectedWorld])
    end
)

Tab11:CreateLabel("Server Teleports")
local serverOptions = {
    ["Lowest Player Count"] = LowestPlayer,
    ["Server Hop"] = Serverhop,
    ["Rejoin"] = Rejoin
}
local serverOrder = {"Lowest Player Count", "Server Hop", "Rejoin"}

local selectedServerOption = serverOrder[1]
Tab11:CreateDropdown(
    "Server Options",
    serverOrder,
    function(choice)
        selectedServerOption = choice
    end
)
Tab11:CreateButton(
    "Execute",
    function()
        serverOptions[selectedServerOption]()
    end
)

Tab12:CreateSection("Player Options")
Tab12:CreateBox(
    "Set Walk Speed",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
    end
)
Tab12:CreateBox(
    "Set Jump Power",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input)
    end
)
Tab12:CreateBox(
    "Set Hip Height",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(input)
    end
)
Tab12:CreateBox(
    "Set Gravity",
    function(input)
        workspace.Gravity = tonumber(input)
    end
)

Tab12:CreateSection("Character Options")
Tab12:CreateToggle(
    "Freeze Character",
    function(state)
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        hrp.Anchored = state
    end
)
Tab12:CreateToggle(
    "Enable Bull State",
    function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CustomPhysicalProperties = state and PhysicalProperties.new(30, 0.3, 0.5) or nil
            end
        end
    end
)
