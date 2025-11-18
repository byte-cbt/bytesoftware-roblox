--[[
Byte Software - Desynced
---------------------------------
Credits:
  - Byt3c0de (www.byt3c0de.net | @byt3c0de.net)
  - Byte Software (www.bytesoftware.net | discord.gg/bytesoftware)
  - Everyone who has supported me on this journey

I’ve created these scripts and am sharing them openly so that others can learn, experiment, and build amazing projects. 
I hope my code inspires creativity and helps you on your own development journey!

Have fun coding!
]]

local DesyncedLibrary = loadstring(game:HttpGet("https://bytesoftware.net/roblox/desynced/library.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local placeId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local runService = game:GetService("RunService")
local player = game.Players.LocalPlayer

local isAuto = {
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

local pingLimits = { min = 450, max = 1450 }

ReplicatedStorage.raceInProgress.Changed:Connect(function()
    if isAuto.smoothRacing and ReplicatedStorage.raceInProgress.Value then
        ReplicatedStorage.rEvents.raceEvent:FireServer("joinRace")
    end
end)

ReplicatedStorage.raceStarted.Changed:Connect(function()
    if isAuto.smoothRacing and ReplicatedStorage.raceStarted.Value then
        for _, v in ipairs(workspace.raceMaps:GetChildren()) do
            local oldCFrame = v.finishPart.CFrame
            v.finishPart.CFrame = player.Character.HumanoidRootPart.CFrame
            wait()
            v.finishPart.CFrame = oldCFrame
        end
        wait(2)
    end
end)

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
        settings = { orb = "", city = "", speed = 400, cooldown = 0.4 }
    },
    secondary = {
        active = false,
        settings = { orb = "", city = "", speed = 400, cooldown = 0.4 }
    },
    third = {
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
        DesyncedLibrary:createNotification("Orb Auto Farm settings incomplete!")
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

local function collectHoopsLoop()
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    while isAuto.hoop do
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

local Window = DesyncedLibrary:CreateWindow("Desynced", "Legends Of Speed")

DesyncedLibrary:createNotification("The script for Legends Of Speed has been successfully loaded.")

local Tab1 = Window:CreateTab("Universal Tools", "96221607452840")
local Tab2 = Window:CreateTab("Auto Farming", "103858677733367")
local Tab3 = Window:CreateTab("Pet Hatching", "84773625854784")
local Tab4 = Window:CreateTab("Pet Evolution", "84773625854784")

local Tab5 = Window:CreateTab("Crystal Farming", "114902365269370")
local Tab6 = Window:CreateTab("Trail Hatching", "88426869189754")

local Tab7 = Window:CreateTab("Ultimates", "88426869189754")
local Tab8 = Window:CreateTab("Teleportation", "140134362123695")
local Tab9 = Window:CreateTab("Rebirth System", "98702116897863")
local Tab12 = Window:CreateTab("Rebirth Calculator", "71239076961795")
local Tab10 = Window:CreateTab("Script Settings", "139117814373418")
local Tab11 = Window:CreateTab("Player Statistics", "133249606271733")

Tab1:CreateSection("Miscellaneous")
Tab1:CreateButton("Join Desynced Discord", function()
    setclipboard("https://discord.gg/bytesoftware")
    DesyncedLibrary:createNotification("Discord invite link has been copied to your clipboard.")
end)

Tab1:CreateToggle("Safe Lock", function(state) end)
Tab1:CreateBox("Enter FPS Cap", function(v)
    runService:Set3dRenderingEnabled(true)
    setfpscap(tonumber(v) or 60)
    DesyncedLibrary:createNotification("FPS cap set to " .. (tonumber(v) or 60))
end)


    Tab1:CreateSection("Network Optimization")
    Tab1:CreateToggle("Enable Ping Stabilizer", function(state)
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
    Tab1:CreateToggle("Connection Enhancer", function(state)
        isAuto.enhanceConnection = state
        if state then
            spawn(function()
                while isAuto.enhanceConnection do
                    local networkClient = game:GetService("NetworkClient")
                    networkClient:SetOutgoingKBPSLimit(800000)
                    networkClient:SetIncomingKBPSLimit(800000)
                    wait(5)
                end
            end)
        end
    end)

Tab1:CreateSection("Race Farming")
Tab1:CreateDropdown("Racing Mode", {"Teleport", "Smooth"}, function(selected)
    isAuto.race = selected
end)

    Tab1:CreateToggle("Auto Fill Race", function(state)
        isAuto.fillRace = state
        if state then
            spawn(function()
                while isAuto.fillRace do
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("raceEvent"):FireServer("joinRace")
                    wait()
                end
            end)
        end
    end)

    Tab1:CreateBox("Race Target", function(raceInput)
        local target = tonumber(raceInput)
        if target and target > 0 then
            isAuto.raceTarget = target
            DesyncedLibrary:createNotification("Auto Race target set to " .. target)
        else
            isAuto.raceTarget = nil
        end
    end)

Tab1:CreateToggle("Enable Auto Racing", function(state)
    isAuto.racing = state

    if not state then
        isAuto.racing = false
        isAuto.smoothRacing = false
        return
    end

    if isAuto.race == "Teleport" then
        spawn(function()
            local startCount = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Races") and player.leaderstats.Races.Value or 0
            ReplicatedStorage.rEvents.raceEvent:FireServer("joinRace")
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local racePoints = {
                Vector3.new(48.31, 36.31, -8680.45),
                Vector3.new(1686.07, 36.31, -5946.63),
                Vector3.new(1001.33, 36.31, -10986.22)
            }

            while isAuto.racing do
                local currentCount = player.leaderstats and player.leaderstats.Races and player.leaderstats.Races.Value or 0
                if isAuto.raceTarget and currentCount >= isAuto.raceTarget then
                    DesyncedLibrary:createNotification("Successfully reached race target!")
                    isAuto.racing = false
                    break
                end

                if hrp then
                    for _, pos in ipairs(racePoints) do
                        if not isAuto.racing or isAuto.race ~= "Teleport" then break end
                        hrp.CFrame = CFrame.new(pos)
                        wait(0.4)
                    end
                end
                wait(0.5)
            end
        end)

    elseif isAuto.race == "Smooth" then
        isAuto.smoothRacing = true
        spawn(function()
            while isAuto.smoothRacing and isAuto.racing do
                local currentCount = player.leaderstats and player.leaderstats.Races and player.leaderstats.Races.Value or 0
                if isAuto.raceTarget and currentCount >= isAuto.raceTarget then
                    DesyncedLibrary:createNotification("Successfully reached race target!")
                    isAuto.racing = false
                    isAuto.smoothRacing = false
                    break
                end
                wait(1)
            end
        end)
    end
end)

Tab1:CreateSection("Hoop Farming")
Tab1:CreateButton("Clear Hoops", cleanHoops)
Tab1:CreateToggle("Enable Auto Hoops", function(state)
    isAuto.hoop = state
    if state then spawn(collectHoopsLoop) end
end)

Tab1:CreateSection("Extra Farming Options")
Tab1:CreateToggle("Enable Auto Gifts", function(state)
    isAuto.gifts = state
    if state then
        spawn(function()
            while isAuto.gifts do
                for i = 1, 8 do
                    local remote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("freeGiftClaimRemote")
                    remote:InvokeServer("claimGift", i)
                end
                wait(0.5)
            end
        end)
    end
end)

Tab1:CreateToggle("Auto Claim Chests", function(state)
    isAuto.chests = state
    if state then
        spawn(function()
            while isAuto.chests do
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

Tab1:CreateToggle("Auto Spin Wheel", function(state)
    isAuto.spinWheel = state
    if state then
        spawn(function()
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local rEvents = replicatedStorage:WaitForChild("rEvents")
            local wheelRemote = rEvents:WaitForChild("openFortuneWheelRemote")
            local wheelChance = replicatedStorage:WaitForChild("fortuneWheelChances"):WaitForChild("Fortune Wheel")

            while isAuto.spinWheel do
                wheelRemote:InvokeServer("openFortuneWheel", wheelChance)
                wait(0.5)
            end
        end)
    end
end)

Tab1:CreateButton("Claim All Codes", function()
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

Tab1:CreateSection("Trading")
Tab1:CreateToggle("Enable Trading", function(state)
    local action = state and "enableTrading" or "disableTrading"
    ReplicatedStorage:WaitForChild("rEvents"):WaitForChild("tradingEvent"):FireServer(action)
end)
Tab1:CreateBox("Trade Target Username", function(input)
    usernameTrade = input
end)
Tab1:CreateButton("Send Trade Request", function()
    if usernameTrade and usernameTrade ~= "" then
        local targetPlayer = Players:FindFirstChild(usernameTrade)
        if targetPlayer then
            ReplicatedStorage.rEvents.tradingEvent:FireServer("sendTradeRequest", targetPlayer)
            DesyncedLibrary:createNotification("Trade sent to: " .. usernameTrade)
        else
            DesyncedLibrary:createNotification("Player not found: " .. usernameTrade)
        end
    end
end)


    Tab2:CreateSection("Primary Auto Farm")
    Tab2:CreateDropdown("Orb Type", validOrbs, function(selected)
        orbFarms.primary.settings.orb = selected
    end)
    Tab2:CreateDropdown("Target City", validCities, function(selected)
        orbFarms.primary.settings.city = selected
    end)
    Tab2:CreateDropdown("Collection Rate", {
        "x800 Orbs", "x900 Orbs", "x1000 Orbs", "x1100 Orbs", "x1200 Orbs", "x1300 Orbs",
        "x1400 Orbs", "x1500 Orbs", "x1600 Orbs", "x1800 Orbs"
    }, function(selected)
        local number = tonumber(selected:match("x(%d+)"))
        if number then
            orbFarms.primary.settings.speed = number
        end
    end)
    Tab2:CreateBox("Orb Collection Cooldown", function(input)
        local inputNumber = tonumber(input)
        if inputNumber and inputNumber > 0 then
            orbFarms.primary.settings.cooldown = inputNumber / 1000
        else
            orbFarms.primary.settings.cooldown = 0.4
        end
    end)
    Tab2:CreateToggle("Enable Auto Orb Collection", function(state)
        orbFarms.primary.active = state
        if state then spawn(function() startOrbFarm(orbFarms.primary, orbFarms.primary.settings) end) end
    end)

    Tab2:CreateSection("Secondary Auto Farm")
    Tab2:CreateDropdown("Orb Type", validOrbs, function(selected)
        orbFarms.secondary.settings.orb = selected
    end)
    Tab2:CreateDropdown("Target City", validCities, function(selected)
        orbFarms.secondary.settings.city = selected
    end)
    Tab2:CreateDropdown("Collection Rate", {
        "x800 Orbs", "x900 Orbs", "x1000 Orbs", "x1100 Orbs", "x1200 Orbs", "x1300 Orbs",
        "x1400 Orbs", "x1500 Orbs", "x1600 Orbs", "x1800 Orbs"
    }, function(selected)
        local number = tonumber(selected:match("x(%d+)"))
        if number then
            orbFarms.secondary.settings.speed = number
        end
    end)
    Tab2:CreateBox("Orb Collection Cooldown", function(input)
        local inputNumber = tonumber(input)
        if inputNumber and inputNumber > 0 then
            orbFarms.secondary.settings.cooldown = inputNumber / 1000
        else
            orbFarms.secondary.settings.cooldown = 0.4
        end
    end)
    Tab2:CreateToggle("Enable Auto Orb Collection", function(state)
        orbFarms.secondary.active = state
        if state then spawn(function() startOrbFarm(orbFarms.secondary, orbFarms.secondary.settings) end) end
    end)

    Tab2:CreateSection("Third Auto Farm")
    Tab2:CreateDropdown("Orb Type", validOrbs, function(selected)
        orbFarms.third.settings.orb = selected
    end)
    Tab2:CreateDropdown("Target City", validCities, function(selected)
        orbFarms.third.settings.city = selected
    end)
    Tab2:CreateDropdown("Collection Rate", {
        "x800 Orbs", "x900 Orbs", "x1000 Orbs", "x1100 Orbs", "x1200 Orbs", "x1300 Orbs",
        "x1400 Orbs", "x1500 Orbs", "x1600 Orbs", "x1800 Orbs"
    }, function(selected)
        local number = tonumber(selected:match("x(%d+)"))
        if number then
            orbFarms.third.settings.speed = number
        end
    end)
    Tab2:CreateBox("Orb Collection Cooldown", function(input)
        local inputNumber = tonumber(input)
        if inputNumber and inputNumber > 0 then
            orbFarms.third.settings.cooldown = inputNumber / 1000
        else
            orbFarms.third.settings.cooldown = 0.4
        end
    end)
    Tab2:CreateToggle("Enable Auto Orb Collection", function(state)
        orbFarms.third.active = state
        if state then spawn(function() startOrbFarm(orbFarms.third, orbFarms.third.settings) end) end
    end)

local function createPetHatchSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateSection(sectionName)

    _G[selectionVarName] = petList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown("Select Pet", petList, function(input)
        _G[selectionVarName] = input
    end)

    tab:CreateToggle("Auto Hatch", function(state)
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

createPetHatchSection(Tab3, "Hatch Basic Pets", {
    "Red Bunny", "Red Kitty", "Blue Bunny", "Silver Dog", "Yellow Squeak"
}, "selectedbasicpettohatch", "hatchBasicPets")

createPetHatchSection(Tab3, "Hatch Advanced Pets", {
    "Green Vampy", "Dark Golem", "Pink Butterfly", "Yellow Butterfly", "Green Golem"
}, "selectedadvancedpettohatch", "hatchAdvancedPets")

createPetHatchSection(Tab3, "Hatch Rare Pets", {
    "Purple Pegasus", "Golden Angel", "Orange Pegasus", "Orange Falcon", "Blue Firecaster",
    "White Phoenix", "Red Phoenix", "Red Firecaster"
}, "selectedrarepettohatch", "hatchRarePets")

createPetHatchSection(Tab3, "Hatch Epic Pets", {
    "Golden Phoenix", "Green Firecaster", "Voltaic Falcon", "Blue Phoenix", "Divine Pegasus"
}, "selectedepicpettohatch", "hatchEpicPets")

createPetHatchSection(Tab3, "Hatch Unique Pets", {
    "Flaming Hedgehog", "Electro Golem", "Voltaic Falcon", "Void Dragon", "Ultra Birdie",
    "Quantum Dragon", "Tundra Dragon", "Magic Butterfly", "Maestro Dog", "Golden Viking", "Speedy Sensei"
}, "selecteduniquepettohatch", "hatchUniquePets")

createPetHatchSection(Tab3, "Hatch Omega Pets", {
    "Soul Fusion Dog", "Hypersonic Pegasus", "Dark Soul Birdie", "Eternal Nebula Dragon",
    "Shadows Edge Kitty", "Ultimate Overdrive Bunny", "Swift Samurai"
}, "selectedomegapettohatch", "hatchOmegaPets")

local function createPetEvolveSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateSection(sectionName)

    _G[selectionVarName] = petList[1]
    _G[toggleVarName] = false

    tab:CreateDropdown("Select Pet to Evolve", petList, function(input)
        _G[selectionVarName] = input
    end)

    tab:CreateToggle("Auto Evolve", function(state)
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

createPetEvolveSection(Tab4, "Evolve Basic Pets", {
    "Red Bunny", "Red Kitty", "Blue Bunny", "Silver Dog", "Yellow Squeak"
}, "selectedbasicpettoevolve", "evolveBasicPets")

createPetEvolveSection(Tab4, "Evolve Advanced Pets", {
    "Green Vampy", "Dark Golem", "Pink Butterfly", "Yellow Butterfly", "Green Golem"
}, "selectedadvancedpettoevolve", "evolveAdvancedPets")

createPetEvolveSection(Tab4, "Evolve Rare Pets", {
    "Purple Pegasus", "Golden Angel", "Orange Pegasus", "Orange Falcon", "Blue Firecaster",
    "White Phoenix", "Red Phoenix", "Red Firecaster"
}, "selectedrarepettoevolve", "evolveRarePets")

createPetEvolveSection(Tab4, "Evolve Epic Pets", {
    "Golden Phoenix", "Green Firecaster", "Voltaic Falcon", "Blue Phoenix", "Divine Pegasus"
}, "selectedepicpettoevolve", "evolveEpicPets")

createPetEvolveSection(Tab4, "Evolve Unique Pets", {
    "Flaming Hedgehog", "Electro Golem", "Voltaic Falcon", "Void Dragon", "Ultra Birdie",
    "Quantum Dragon", "Tundra Dragon", "Magic Butterfly", "Maestro Dog", "Golden Viking", "Speedy Sensei"
}, "selecteduniquepettoevolve", "evolveUniquePets")

createPetEvolveSection(Tab4, "Evolve Omega Pets", {
    "Soul Fusion Dog", "Hypersonic Pegasus", "Dark Soul Birdie", "Eternal Nebula Dragon",
    "Shadows Edge Kitty", "Ultimate Overdrive Bunny", "Swift Samurai"
}, "selectedomegapettoevolve", "evolveOmegaPets")

if Tab5 then

    local function createCrystalSection(tab, sectionName, crystalList, selectionVarName, toggleVarName)
        tab:CreateSection(sectionName)

        _G[selectionVarName] = crystalList[1]
        _G[toggleVarName] = false

        tab:CreateDropdown("Select Crystal", crystalList, function(input)
            _G[selectionVarName] = input
        end)

        tab:CreateToggle("Auto Open", function(state)
            _G[toggleVarName] = state
            if state then
                spawn(function()
                    while _G[toggleVarName] do
                        local crystal = _G[selectionVarName]
                        if crystal then
                            local args = {
                                [1] = "openCrystal",
                                [2] = crystal
                            }
                            game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("openCrystalRemote"):InvokeServer(unpack(args))
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

    createCrystalSection(Tab5, "City Crystals", cityCrystals, "selectedCityCrystal", "autoOpenCityCrystal")
    createCrystalSection(Tab5, "Space Crystals", spaceCrystals, "selectedSpaceCrystal", "autoOpenSpaceCrystal")
    createCrystalSection(Tab5, "Desert Crystals", desertCrystals, "selectedDesertCrystal", "autoOpenDesertCrystal")
end
if Tab6 then

    local function createTrailSection(tab, label, trailList)
        tab:CreateSection(label)

        local selected = "_G.selectedTrail_" .. label
        local toggle = "_G.trailToggle_" .. label

        _G[selected] = trailList[1]
        _G[toggle] = false

        tab:CreateDropdown("Select " .. label .. " Trail", trailList, function(choice)
            _G[selected] = choice
        end)

        tab:CreateToggle("Auto Hatch " .. label, function(state)
            _G[toggle] = state
            if state then
                spawn(function()
                    while _G[toggle] do wait()
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

    createTrailSection(Tab6, "1-5", {
        "1st Trail", "2nd Trail", "Third Trail", "Fourth Trail", "Fifth Trail"
    })

    createTrailSection(Tab6, "B", {
        "BG Speed", "Blue & Green", "Blue Coin", "Blue Gem", "Blue Lightning", "Blue Snow",
        "Blue Soul", "Blue Sparks", "Blue Storm", "Blue Trail"
    })

    createTrailSection(Tab6, "D", {
        "Dragonfire"
    })

    createTrailSection(Tab6, "G", {
        "Golden Lightning", "Green & Orange", "Green Coin", "Green Gem", "Green Lightning",
        "Green Snow", "Green Soul", "Green Sparks", "Green Storm", "Green Trail"
    })

    createTrailSection(Tab6, "H", {
        "Hyperblast"
    })

    createTrailSection(Tab6, "O", {
        "OG Speed", "Orange Coin", "Orange Gem", "Orange Lightning", "Orange Snow",
        "Orange Soul", "Orange Sparks", "Orange Storm", "Orange Trail"
    })

    createTrailSection(Tab6, "P", {
        "PP Speed", "Pink Gem", "Pink Lightning", "Pink Snow", "Pink Soul", "Pink Sparks",
        "Pink Storm", "Pink Trail", "Purple & Pink", "Purple Coin", "Purple Gem",
        "Purple Lightning", "Purple Soul", "Purple Sparks", "Purple Storm", "Purple Trail"
    })

    createTrailSection(Tab6, "R", {
        "RB Speed", "Rainbow Lightning", "Rainbow Soul", "Rainbow Sparks", "Rainbow Speed",
        "Rainbow Steps", "Rainbow Storm", "Rainbow Trail", "Red & Blue", "Red Coin", "Red Gem",
        "Red Lightning", "Red Snow", "Red Soul", "Red Sparks", "Red Storm", "Red Trail"
    })

    createTrailSection(Tab6, "W", {
        "White Snow"
    })

    createTrailSection(Tab6, "Y", {
        "YB Speed", "Yellow & Blue", "Yellow Soul", "Yellow Sparks", "Yellow Trail"
    })
end

Tab7:CreateLabel("You will lose rebirths by using these upgrades!")
Tab7:CreateSection("Rebirth Pets")
Tab7:CreateButton("Magzor", function()
    local args = { "upgradeUltimate", "Magzor" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Crowd Surfer", function()
    local args = { "upgradeUltimate", "Crowd Surfer" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Sorenzo", function()
    local args = { "upgradeUltimate", "Sorenzo" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateSection("Game Upgrades")
Tab7:CreateButton("x2 Trail Boosts", function()
    local args = { "upgradeUltimate", "x2 Trail Boosts" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("+1 Pet Slot", function()
    local args = { "upgradeUltimate", "+1 Pet Slot" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("+10 Item Capacity", function()
    local args = { "upgradeUltimate", "+10 Item Capacity" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("+1 Daily Spin", function()
    local args = { "upgradeUltimate", "+1 Daily Spin" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("x2 Chest Rewards", function()
    local args = { "upgradeUltimate", "x2 Chest Rewards" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("x2 Quest Rewards", function()
    local args = { "upgradeUltimate", "x2 Quest Rewards" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateSection("Enhancements")
Tab7:CreateButton("Gem Booster", function()
    local args = { "upgradeUltimate", "Gem Booster" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Step Booster", function()
    local args = { "upgradeUltimate", "Step Booster" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Infernal Gems", function()
    local args = { "upgradeUltimate", "Infernal Gems" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Ethereal Orbs", function()
    local args = { "upgradeUltimate", "Ethereal Orbs" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Demon Hoops", function()
    local args = { "upgradeUltimate", "Demon Hoops" }
    game:GetService("ReplicatedStorage").rEvents.ultimatesRemote:InvokeServer(unpack(args))
end)
Tab7:CreateButton("Divine Rebirth", function()
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

Tab8:CreateSection("Main Teleports")
local mainLocations = {
    ["City"] = CFrame.new(-9682.98828, 74.8522873, 3099.03394, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381),
    ["Snow City"] = CFrame.new(-9676.13867, 74.8522873, 3782.69385),
    ["Magma City"] = CFrame.new(-11054.9688, 232.791656, 4898.62842),
    ["Legends Highway"] = CFrame.new(-13098.8711, 232.791656, 5907.62793),
    ["Speed Jungle"] = CFrame.new(-15274, 399, 5576)
}
local mainOrder = { "City", "Snow City", "Magma City", "Legends Highway", "Speed Jungle" }
Tab8:CreateDropdown("Select Main Location", mainOrder, function(loc)
    teleportTo(mainLocations[loc])
end)
Tab8:CreateSection("Race & Other Areas")
local otherLocations = {
    ["Desert Race"] = CFrame.new(48.3109131, 36.3147125, -8680.45312),
    ["Grassland Race"] = CFrame.new(1686.07495, 36.3147125, -5946.63428),
    ["Magma Race"] = CFrame.new(1001.33118, 36.3147125, -10986.2178),
    ["Space World"] = CFrame.new(-331.764069, 5.45415115, 585.201721),
    ["Desert World"] = CFrame.new(2519.90063, 15.7072296, 4355.74072)
}
local otherOrder = { "Desert Race", "Grassland Race", "Magma Race", "Space World", "Desert World" }
Tab8:CreateDropdown("Select Race/Area", otherOrder, function(loc)
    teleportTo(otherLocations[loc])
end)
Tab8:CreateSection("Space Teleports")
local spaceLocations = {
    ["+1000 Hoop"] = CFrame.new(-477, 156, 755),
    ["Starway Race"] = CFrame.new(-5018, 29, -4779)
}
local spaceOrder = { "+1000 Hoop", "Starway Race" }
Tab8:CreateDropdown("Select Space Location", spaceOrder, function(loc)
    teleportTo(spaceLocations[loc])
end)
Tab8:CreateSection("Desert Teleports")
local desertLocations = {
    ["+8000 Hoop"] = CFrame.new(-3386, 259, 16916),
    ["Speedway Race"] = CFrame.new(663, 28, 9767),
    ["Second Island"] = CFrame.new(-10517, 621, -5)
}
local desertOrder = { "+8000 Hoop", "Speedway Race", "Second Island" }
Tab8:CreateDropdown("Select Desert Location", desertOrder, function(loc)
    teleportTo(desertLocations[loc])
end)

    Tab8:CreateSection("World Teleports")
    local teleportService = game:GetService("TeleportService")
    local worldTeleports = {
        ["City"] = 3101667897,
        ["Outer Space"] = 3232996272,
        ["Speed Desert"] = 3276265788
    }
    local worldOrder = { "City", "Outer Space", "Speed Desert" }
    Tab8:CreateDropdown("Select World", worldOrder, function(world)
        teleportService:Teleport(worldTeleports[world])
    end)
    Tab8:CreateSection("Server Teleports")
    local serverOptions = {
        ["Lowest Player Count"] = LowestPlayer,
        ["Server Hop"] = Serverhop,
        ["Rejoin"] = Rejoin
    }
    local serverOrder = { "Lowest Player Count", "Server Hop", "Rejoin" }
    Tab8:CreateDropdown("Server Options", serverOrder, function(choice)
        serverOptions[choice]()
    end)

Tab9:CreateSection("Rebirth Farming")
Tab9:CreateBox("Rebirth Cooldown (sec)", function(input)
    isAuto.rebirthCooldown = tonumber(input) or 0.2
end)
Tab9:CreateToggle("Auto Rebirth", function(state)
    isAuto.rebirth = state
    if state then
        spawn(function()
            while isAuto.rebirth do
                ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                wait(isAuto.rebirthCooldown)
            end
        end)
    end
end)

Tab9:CreateSection("Targeted Rebirth Farming")
Tab9:CreateBox("Rebirth Target Amount", function(input)
    isAuto.rebirthTargetAmount = tonumber(input) or 0
    DesyncedLibrary:createNotification("Auto Rebirth target set to " .. isAuto.rebirthTargetAmount)
end)
Tab9:CreateBox("Target Rebirth Cooldown (sec)", function(input)
    isAuto.rebirthTargetCooldown = tonumber(input) or 0.5
end)
Tab9:CreateToggle("Targeted Auto Rebirth", function(state)
    isAuto.rebirthTarget = state
    if state then
        spawn(function()
            while isAuto.rebirthTarget do
                local success = pcall(function()
                    local leaderstats = player:FindFirstChild("leaderstats")
                    local rebirths = leaderstats and leaderstats:FindFirstChild("Rebirths")
                    if not rebirths then return end

                    local before = rebirths.Value
                    ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
                    wait(isAuto.rebirthTargetCooldown)
                    local after = rebirths.Value

                    if after >= isAuto.rebirthTargetAmount then
                        DesyncedLibrary:createNotification("Successfully reached rebirth target!")
                        isAuto.rebirthTarget = false
                        orbFarms.primary.active = false
                        orbFarms.secondary.active = false
                        orbFarms.third.active = false
                    end
                end)
                if not success then
                    isAuto.rebirthTarget = false
                    orbFarms.primary.active = false
                    orbFarms.secondary.active = false
                    orbFarms.third.active = false
                end
            end
        end)
    else
        isAuto.rebirthTarget = false
        orbFarms.primary.active = false
        orbFarms.secondary.active = false
        orbFarms.third.active = false
    end
end)

    Tab9:CreateSection("Instant Rebirth Farming")
    Tab9:CreateBox("Rebirths to Perform", function(input)
        isAuto.instantRebirthAmount = tonumber(input) or 0
    end)
    Tab9:CreateButton("Start Rebirth", function()
        for i = 1, isAuto.instantRebirthAmount do
            ReplicatedStorage.rEvents.rebirthEvent:FireServer("rebirthRequest")
        end
    end)

    Tab12:CreateSection("Rebirth Calculator")
    Tab12:CreateLabel("Credits to byt3c0de_net and pb_cryo")

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

    Tab12:CreateBox("Enter Rebirth", function(input)
        rebirthValue = tonumber(input)
    end)

    Tab12:CreateToggle("Step Boosters", function(state)
        hasStepBoosters = state
    end)

    Tab12:CreateToggle("Premium", function(state)
        hasPremium = state
    end)

    local orbLabel
    local cityLabel
    local speedLabel
    local petLabel

    Tab12:CreateButton("Calculate Glitch", function()
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
                                speed = stats
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
            orbLabel.SetText("Orb: -")
            cityLabel.SetText("City: -")
            speedLabel.SetText("Speed: -")
            petLabel.SetText("Pet: -")
            DesyncedLibrary:createNotification("Invalid rebirth!")
            return
        end

        local results = check_glitch(rebirthValue)

        if #results > 0 then
            table.sort(results, function(a, b)
                return a.speed > b.speed
            end)

            local best = results[1]
            orbLabel.SetText("Orb: " .. best.orb)
            cityLabel.SetText("City: " .. best.city)
            speedLabel.SetText("Speed: +" .. best.speed)
            petLabel.SetText("Pet: " .. best.pet)
            DesyncedLibrary:createNotification("Glitch has been found!")
        else
            orbLabel.SetText("Orb: -")
            cityLabel.SetText("City: -")
            speedLabel.SetText("Speed: -")
            petLabel.SetText("Pet: -")
            DesyncedLibrary:createNotification("No glitch has been found!")
        end
    end)

    orbLabel = Tab12:CreateLabel("Orb:")
    cityLabel = Tab12:CreateLabel("City:")
    speedLabel = Tab12:CreateLabel("Speed:")
    petLabel = Tab12:CreateLabel("Pet:")

Tab10:CreateSection("General Settings")
Tab10:CreateToggle("Anti-Idle Protection", function(state)
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
Tab10:CreateToggle("Freeze Character", function(state)
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    hrp.Anchored = state
end)
Tab10:CreateToggle("Enable Bull Mode", function(state)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CustomPhysicalProperties = state
                and PhysicalProperties.new(30, 0.3, 0.5)
                or nil
        end
    end
end)
Tab10:CreateSection("Player Settings")
Tab10:CreateBox("Set Walk Speed", function(input)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
end)
Tab10:CreateBox("Set Jump Power", function(input)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input)
end)
Tab10:CreateBox("Set Hip Height", function(input)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(input)
end)
Tab10:CreateBox("Set Gravity", function(input)
    workspace.Gravity = tonumber(input)
end)

Tab11:CreateSection("Player Stats")
Tab11.statsLabel1 = Tab11:CreateLabel("Steps: ")
Tab11.statsLabel2 = Tab11:CreateLabel("Rebirths: ")
Tab11.statsLabel3 = Tab11:CreateLabel("Hoops: ")
Tab11.statsLabel4 = Tab11:CreateLabel("Races: ")
Tab11:CreateSection("Pet Stats")
Tab11.petsLabel1 = Tab11:CreateLabel("Equipped: ")
Tab11.petsLabel2 = Tab11:CreateLabel("Total Steps: ")
Tab11.petsLabel3 = Tab11:CreateLabel("Total Gems: ")

local function updateStats()
    local player = game.Players.LocalPlayer
    local leaderstats = player:FindFirstChild("leaderstats")

    repeat wait() until player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("gameGui")

    local petMenu = player.PlayerGui.gameGui:FindFirstChild("petsMenu")
    if not petMenu then return end

    local petInfoMenu = petMenu:FindFirstChild("petInfoMenu")
    if not petInfoMenu then return end

    local equippedPetsLabel = petInfoMenu:FindFirstChild("petsLabel")
    local petStepsLabel = petInfoMenu:FindFirstChild("totalStepsLabel") and petInfoMenu.totalStepsLabel:FindFirstChild("stepsLabel")
    local petGemsLabel = petInfoMenu:FindFirstChild("totalGemsLabel") and petInfoMenu.totalGemsLabel:FindFirstChild("gemsLabel")

    local function convertFormattedNumber(text)
        if not text then return "0" end

        local num, suffix = text:match("([%d%.]+)([KMBT]?)")
        if not num then return "0" end

        num = tonumber(num) or 0

        local multipliers = { K = 1e3, M = 1e6, B = 1e9, T = 1e12 }
        local multiplier = multipliers[suffix] or 1
        return tostring(math.floor(num * multiplier))
    end

    local function onStatChanged()
        if leaderstats then
            if leaderstats:FindFirstChild("Steps") then
                Tab11.statsLabel1.SetText("Steps: " .. leaderstats.Steps.Value)
            end
            if leaderstats:FindFirstChild("Rebirths") then
                Tab11.statsLabel2.SetText("Rebirths: " .. leaderstats.Rebirths.Value)
            end
            if leaderstats:FindFirstChild("Hoops") then
                Tab11.statsLabel3.SetText("Hoops: " .. leaderstats.Hoops.Value)
            end
            if leaderstats:FindFirstChild("Races") then
                Tab11.statsLabel4.SetText("Races: " .. leaderstats.Races.Value)
            end
        end

        if equippedPetsLabel then
            local petCount = convertFormattedNumber(equippedPetsLabel.Text)
            Tab11.petsLabel1.SetText("Equipped: " .. petCount)
        end
        if petStepsLabel then
            local stepsCount = convertFormattedNumber(petStepsLabel.Text)
            Tab11.petsLabel2.SetText("Total Steps: " .. stepsCount)
        end
        if petGemsLabel then
            local gemsCount = convertFormattedNumber(petGemsLabel.Text)
            Tab11.petsLabel3.SetText("Total Gems: " .. gemsCount)
        end
    end

    if leaderstats then
        for _, stat in ipairs(leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                stat.Changed:Connect(onStatChanged)
            end
        end
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