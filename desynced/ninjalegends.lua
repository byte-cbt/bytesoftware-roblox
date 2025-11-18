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
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local placeId = game.PlaceId
local StarterGui = game:GetService("StarterGui")
local player = game.Players.LocalPlayer

local isAuto = {
    swingKatana = false,
    sellBest = false,
    buyBelts = false,
    buySkills = false,
    buySwords = false,
    buyRanks = false,
    evolveAll = false,
    enhanceConnection = false,
    autoKill = false,
    lightSkill = false,
    darkSkill = false
}

local pingLimits = {min = 450, max = 1450}

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

local function teleportToBaseplate()
    local baseplatePosition = Vector3.new(10000, 2000, -10000)

    local baseplate = Instance.new("Part")
    baseplate.Size = Vector3.new(300, 5, 300)
    baseplate.Anchored = true
    baseplate.Transparency = 1
    baseplate.CanCollide = true
    baseplate.Position = baseplatePosition
    baseplate.Name = "SafeBaseplate"
    baseplate.Parent = workspace

    local function createWall(size, offset)
        local wall = Instance.new("Part")
        wall.Size = size
        wall.Anchored = true
        wall.Transparency = 1
        wall.CanCollide = true
        wall.Position = baseplatePosition + offset
        wall.Parent = workspace
    end

    createWall(Vector3.new(300, 50, 1), Vector3.new(0, 25, 150))
    createWall(Vector3.new(300, 50, 1), Vector3.new(0, 25, -150))
    createWall(Vector3.new(1, 50, 300), Vector3.new(150, 25, 0))
    createWall(Vector3.new(1, 50, 300), Vector3.new(-150, 25, 0))

    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character:MoveTo(baseplatePosition + Vector3.new(0, 5, 0))
    end
end

local function teleportBack()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
        CFrame.new(
        30.2903004,
        3.19602513,
        26.960619,
        -0.0679417104,
        1.0007718e-07,
        0.997689307,
        4.96522434e-10,
        1,
        -1.00275152e-07,
        -0.997689307,
        -6.31749009e-09,
        -0.0679417104
    )
end

local Window = DesyncedLibrary:CreateWindow("Desynced", "Ninja Legends")

DesyncedLibrary:createNotification("The script for Ninja Legends has been successfully loaded.")

local Tab1 = Window:CreateTab("Universal Tools", "96221607452840")
local Tab2 = Window:CreateTab("Auto Farming", "88261448480216")
local Tab3 = Window:CreateTab("Pet Hatching", "84773625854784")

local Tab4 = Window:CreateTab("Crystal Farming", "114902365269370")

local Tab5 = Window:CreateTab("Teleportation", "140134362123695")
local Tab6 = Window:CreateTab("Script Settings", "139117814373418")
local Tab7 = Window:CreateTab("Player Statistics", "133249606271733")

Tab1:CreateSection("Miscellaneous")
Tab1:CreateButton(
    "Join Desynced Discord",
    function()
        setclipboard("https://discord.gg/bytesoftware")
        DesyncedLibrary:createNotification("Discord invite link has been copied to your clipboard.")
    end
)

Tab1:CreateToggle(
    "Safe Lock",
    function(state)
    end
)
Tab1:CreateBox(
    "Enter FPS Cap",
    function(v)
        runService:Set3dRenderingEnabled(true)
        setfpscap(tonumber(v) or 60)
        DesyncedLibrary:createNotification("FPS cap set to " .. (tonumber(v) or 60))
    end
)

Tab1:CreateSection("Network Optimization")
Tab1:CreateToggle(
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
Tab1:CreateToggle(
    "Connection Enhancer",
    function(state)
        isAuto.enhanceConnection = state
        if state then
            spawn(
                function()
                    while isAuto.enhanceConnection do
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

Tab1:CreateSection("Elements")

local elements = {
    "Frost",
    "Electral Chaos",
    "Lightning",
    "Inferno",
    "Masterful Wrath",
    "Shadow Charge",
    "Shadowfire",
    "Eternity Storm",
    "Blazing Entity"
}

for _, element in ipairs(elements) do
    Tab1:CreateButton(
        element .. " Element",
        function()
            game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(element)
        end
    )
end

Tab1:CreateSection("Other")
Tab1:CreateButton(
    "Unlock All Elements",
    function()
        local elements = {
            "Frost",
            "Electral Chaos",
            "Lightning",
            "Inferno",
            "Masterful Wrath",
            "Shadow Charge",
            "Shadowfire",
            "Eternity Storm",
            "Blazing Entity"
        }

        for _, element in ipairs(elements) do
            game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(element)
        end
    end
)
Tab1:CreateButton(
    "Unlock All Islands",
    function()
        local islandCFrames = {
            CFrame.new(80, 766, -188),
            CFrame.new(233, 2013, 331),
            CFrame.new(165, 4047, 51),
            CFrame.new(186, 5656, 76),
            CFrame.new(189, 9284, 31),
            CFrame.new(139, 13680, 74),
            CFrame.new(135, 17686, 61),
            CFrame.new(108, 24069, 84),
            CFrame.new(171, 28255, 39),
            CFrame.new(180, 33206, 28),
            CFrame.new(-109, 39434, 155),
            CFrame.new(183, 46010, 36),
            CFrame.new(166, 52607, 34),
            CFrame.new(188, 59594, 24),
            CFrame.new(226, 66669, 15),
            CFrame.new(197, 70271, 7),
            CFrame.new(142, 74445, 71),
            CFrame.new(143, 79747, 72),
            CFrame.new(139, 83199, 73),
            CFrame.new(136, 87051, 63),
            CFrame.new(136, 91255, 60)
        }

        for _, cframe in ipairs(islandCFrames) do
            teleportTo(cframe)
            wait(0.2)
        end
    end
)
Tab1:CreateButton(
    "Claim All Codes",
    function()
        local codes = {
            "innerpeace5k",
            "silentshadows1000",
            "skyblades10k",
            "chaosblade1000",
            "soulninja1000",
            "epictrain15",
            "roboninja15",
            "christmasninja500",
            "zenmaster15K",
            "darkelements2000",
            "omegasecrets5000",
            "ultrasecrets10k",
            "elementmaster750",
            "secretcrystal1000",
            "skymaster750",
            "legends700m",
            "dojomasters500",
            "dragonlegend750",
            "zenmaster500",
            "epicelements500",
            "goldupdate500",
            "legends500m",
            "senseisanta500",
            "blizzardninja500",
            "mythicalninja500",
            "legendaryninja500",
            "shadowninja500",
            "legends200M",
            "epicflyingninja500",
            "flyingninja500",
            "dragonwarrior500",
            "swiftblade300",
            "DesertNinja250",
            "fastninja100",
            "epicninja250",
            "masterninja750",
            "sparkninja20",
            "soulhunter5"
        }

        local codeRemote = game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("codeRemote")
        for _, code in ipairs(codes) do
            codeRemote:InvokeServer(code)
        end
    end
)
Tab1:CreateButton(
    "Infinite Jump",
    function()
        game:GetService("Players").LocalPlayer.multiJumpCount.Value = 999999999
    end
)

Tab2:CreateSection("Auto Farm")
Tab2:CreateToggle(
    "Auto Swing Katana",
    function(state)
        isAuto.swingKatana = state
        if state then
            spawn(
                function()
                    while isAuto.swingKatana do
                        pcall(
                            function()
                                local Weapon
                                for _, Tool in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                                    if Tool:FindFirstChild("ninjitsuGain") then
                                        Weapon = Tool
                                        break
                                    end
                                end

                                if Weapon then
                                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(
                                        Weapon
                                    )
                                end
                            end
                        )

                        game:GetService("Players").LocalPlayer:FindFirstChild("ninjaEvent"):FireServer("swingKatana")
                        wait()
                    end
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Auto Sell",
    function(state)
        isAuto.sellBest = state
        if state then
            spawn(
                function()
                    local correctCircle = nil
                    for _, circle in pairs(game.workspace.sellAreaCircles:GetChildren()) do
                        if circle.Name == "sellAreaCircle16" and circle:FindFirstChild("areaName") then
                            if circle.areaName.Value == "Blazing Vortex Island" then
                                correctCircle = circle
                                break
                            end
                        end
                    end

                    if not correctCircle then
                        return
                    end

                    while isAuto.sellBest do
                        wait()
                        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            correctCircle.circleInner.CFrame = hrp.CFrame
                            wait(0.05)
                            correctCircle.circleInner.CFrame = game.Workspace.Part.CFrame
                        end
                    end
                end
            )
        end
    end
)

Tab2:CreateSection("Auto Buy")
Tab2:CreateToggle(
    "Auto Buy Swords",
    function(state)
        isAuto.buySwords = state
        if state then
            spawn(
                function()
                    while isAuto.buySwords do
                        local oh1 = "buyAllSwords"
                        local oh2 = {"Soul Fusion Island"}
                        for i = 1, #oh2 do
                            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                        end
                        wait()
                    end
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Auto Buy Belts",
    function(state)
        isAuto.buyBelts = state
        if state then
            spawn(
                function()
                    while isAuto.buyBelts do
                        local oh1 = "buyAllBelts"
                        local oh2 = {"Soul Fusion Island"}
                        for i = 1, #oh2 do
                            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                        end
                        wait()
                    end
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Auto Buy Skill",
    function(state)
        isAuto.buySkills = state
        if state then
            spawn(
                function()
                    while isAuto.buySkills do
                        local oh1 = "buyAllSkills"
                        local oh2 = {"Soul Fusion Island"}
                        for i = 1, #oh2 do
                            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, oh2[i])
                        end
                        wait()
                    end
                end
            )
        end
    end
)
Tab2:CreateToggle(
    "Auto Buy Ranks",
    function(state)
        isAuto.buyRanks = state
        if state then
            spawn(
                function()
                    while isAuto.buyRanks do
                        local oh1 = "buyRank"
                        local ranks = game:GetService("ReplicatedStorage").Ranks.Ground:GetChildren()
                        for i = 1, #ranks do
                            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(oh1, ranks[i].Name)
                        end
                        wait()
                    end
                end
            )
        end
    end
)

Tab2:CreateSection("Auto Kill")

local player = game.Players.LocalPlayer
local originalSizes = {}
local charAddedConnection

Tab2:CreateToggle(
    "Auto Kill Farm",
    function(state)
        isAuto.autoKill = state

        local function shrinkCharacter(char)
            originalSizes[char] = {}

            local function shrink(part)
                if part:IsA("BasePart") then
                    table.insert(
                        originalSizes[char],
                        {
                            part = part,
                            size = part.Size,
                            transparency = part.Transparency,
                            canCollide = part.CanCollide
                        }
                    )
                    part.Size = Vector3.new(0.5, 0.5, 0.5)
                    part.Transparency = 0.95
                    part.CanCollide = false
                end
            end

            for _, part in ipairs(char:GetDescendants()) do
                shrink(part)
            end

            for _, acc in ipairs(char:GetChildren()) do
                if acc:IsA("Accessory") and acc:FindFirstChild("Handle") then
                    shrink(acc.Handle)
                end
            end

            if char:FindFirstChild("Humanoid") then
                char.Humanoid.HipHeight = 0.1
            end
        end

        local function restoreCharacter(char)
            local savedParts = originalSizes[char]
            if savedParts then
                for _, data in ipairs(savedParts) do
                    if data.part then
                        data.part.Size = data.size
                        data.part.Transparency = data.transparency
                        data.part.CanCollide = data.canCollide
                    end
                end
            end

            if char:FindFirstChild("Humanoid") then
                char.Humanoid.HipHeight = 2
            end
        end

        local function equipWeapon()
            for _, tool in pairs(player.Backpack:GetChildren()) do
                if tool:IsA("Tool") and tool:FindFirstChild("attackKatanaScript") then
                    player.Character.Humanoid:EquipTool(tool)
                    break
                end
            end
        end

        local function handleCharacter(char)
            char:WaitForChild("HumanoidRootPart")
            wait(1)
            if isAuto.autoKill then
                teleportToBaseplate()
                shrinkCharacter(char)
            end
        end

        if state then
            if player.Character then
                handleCharacter(player.Character)
            end

            charAddedConnection =
                player.CharacterAdded:Connect(
                function(char)
                    handleCharacter(char)
                end
            )

            spawn(
                function()
                    local players = game.Players:GetPlayers()

                    game.Players.PlayerRemoving:Connect(
                        function()
                            players = game.Players:GetPlayers()
                        end
                    )

                    game.Players.PlayerAdded:Connect(
                        function()
                            players = game.Players:GetPlayers()
                        end
                    )

                    while isAuto.autoKill and task.wait(0.4) do
                        pcall(
                            function()
                                local char = player.Character
                                if not char or not char:FindFirstChild("HumanoidRootPart") then
                                    return
                                end

                                player.ninjaEvent:FireServer("goInvisible")

                                local head = char:FindFirstChild("Head")
                                if head and head:FindFirstChild("nameGui") then
                                    head.nameGui:Destroy()
                                end

                                for _, target in ipairs(players) do
                                    if target ~= player and workspace:FindFirstChild(target.Name) then
                                        local targetChar = workspace[target.Name]
                                        if
                                            targetChar:FindFirstChild("HumanoidRootPart") and
                                                not targetChar:FindFirstChild("inSafezone")
                                         then
                                            targetChar.HumanoidRootPart.CFrame =
                                                char.HumanoidRootPart.CFrame + Vector3.new(4.5, 0, 0)
                                        end
                                    end
                                end

                                local tool = char:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool:Activate()
                                end

                                for _, orb in ipairs(workspace:WaitForChild("soulPartsFolder"):GetChildren()) do
                                    if orb.Name == "soulPart" and orb.collectPlayers:FindFirstChild(player.Name) then
                                        if (orb.Position - char.HumanoidRootPart.Position).Magnitude <= 25 then
                                            player.ninjaEvent:FireServer("collectSoul", orb)
                                        end
                                    end
                                end

                                equipWeapon()
                            end
                        )
                    end
                end
            )
        else
            teleportBack()
            if player.Character then
                restoreCharacter(player.Character)
            end
            originalSizes[player.Character] = nil

            if charAddedConnection then
                charAddedConnection:Disconnect()
                charAddedConnection = nil
            end
        end
    end
)

Tab3:CreateSection("Evolve Pets")
Tab3:CreateToggle(
    "Auto Evolve All",
    function(state)
        isAuto.evolveAll = state
        if state then
            spawn(
                function()
                    while isAuto.evolveAll do
                        wait()
                        local args = {"autoEvolvePets"}
                        game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("autoEvolveRemote"):InvokeServer(
                            unpack(args)
                        )
                    end
                end
            )
        end
    end
)

local function createPetHatchSection(tab, sectionName, petList, selectionVarName, toggleVarName)
    tab:CreateSection(sectionName)

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
        "Auto Hatch",
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
    Tab3,
    "Hatch Pets - A",
    {
        "Ancient Inferno Kitty",
        "Ancient Master Wraith",
        "Ancient Millenium Bunny",
        "Azure Series Omega Pegasus",
        "Azure Wonder Kitty"
    },
    "selectedPet_A",
    "autoHatch_A"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - B",
    {"Blizzard Bunny", "Blue Birdie", "Blue Falcon", "Blue Firecaster", "Blue Hedgehog", "Butterfly Sensei"},
    "selectedPet_B",
    "autoHatch_B"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - C",
    {
        "Christmas Sensei Reindeer",
        "Corrupted Elements Hydra",
        "Corrupted Soul Dragon",
        "Cosmic Hunter Dragon",
        "Crimson Vampy",
        "Cybernetic Emerald Dragon",
        "Cybernetic Showdown Dragon",
        "Cybernetic Sleigh Rider",
        "Cybernetic Strike Leviathan",
        "CYBER: Ancient Master Wraith"
    },
    "selectedPet_C",
    "autoHatch_C"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - D",
    {
        "Dark Golem",
        "Dark Karma Dragon",
        "Dark Lunar Leviathan",
        "Dark Soul Birdie",
        "Dark Vortex Manticore",
        "Dark Vampy",
        "Darkstar Eternal Kitty",
        "Darkstorm Elemental Hydra",
        "Dawn Horizon Birdie",
        "Destiny Heroes Golem",
        "Diamond Strike Falcon",
        "Divine Prophecy Dragon",
        "DRAGON: Nebula Skystorm",
        "Dual Destiny Shadow Dragon",
        "Dual Eternal Charge Dragon",
        "Dual Starlight Eclipse Dragon",
        "Dual Warp Drive Dragon"
    },
    "selectedPet_D",
    "autoHatch_D"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - E",
    {
        "Energized Skyraider Cerberus",
        "Electro Bunny",
        "Electro Golem",
        "Eternal Abyss Wyvern",
        "Eternal Nebula Dragon",
        "Eternal Strike Leviathan",
        "Eternity Heroes Kitty",
        "Eternity Legends Bunny",
        "Eternity Shadow Kitty"
    },
    "selectedPet_E",
    "autoHatch_E"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - F",
    {"Flaming Hedgehog", "Frostwave Legends Penguin", "Frostwave Pegasus"},
    "selectedPet_F",
    "autoHatch_F"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - G",
    {
        "GLITCH: Awakened Nighthunter",
        "Golden Dawn Bunny",
        "Golden Pheonix",
        "Golden Sparks Dog",
        "Golden Spirit Kitty",
        "Golden Strike Dragon",
        "Golden Sun Pegasus",
        "Green Bunny",
        "Green Butterfly",
        "Green Firecaster",
        "Green Golem",
        "Green Vampy"
    },
    "selectedPet_G",
    "autoHatch_G"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - H",
    {"Heatwave Shadow Penguin", "Hypersonic Pegasus"},
    "selectedPet_H",
    "autoHatch_H"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - I",
    {
        "Infernal Dragon",
        "Inner Darkness Hydra",
        "Inner Focus Penguin",
        "Inner Peace Birdie",
        "Inner Peace Cerberus",
        "Inner Peace Legion"
    },
    "selectedPet_I",
    "autoHatch_I"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - L",
    {"Light Angel", "Lightning Bolt Bunny", "Lightning Strike Phantom"},
    "selectedPet_L",
    "autoHatch_L"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - M",
    {
        "Magic Butterfly",
        "Magical Pegasus",
        "Master Guardian Manticore",
        "Master Underworld Phantom",
        "Masterful Strike Leviathan",
        "Mini Chaos Legend",
        "Mini Legend",
        "Mini Ninja",
        "Mini Sensei",
        "Mini Vortex Legend",
        "Mystic Shadows Dragon",
        "Mystical Midnight Pegasus",
        "Mystical Power Manticore"
    },
    "selectedPet_M",
    "autoHatch_M"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - O",
    {"Orange Birdie", "Orange Dragon", "Orange Falcon", "Orange Hedgehog", "Orange Pegasus"},
    "selectedPet_O",
    "autoHatch_O"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - P",
    {
        "Phantom Genesis Dragon",
        "Phantom Soul Seeker",
        "Pink Butterfly",
        "Pink Stardust Dog",
        "Purple Angel",
        "Purple Birdie",
        "Purple Dog",
        "Purple Dragon",
        "Purple Falcon",
        "Purple Pegasus"
    },
    "selectedPet_P",
    "autoHatch_P"
)

createPetHatchSection(Tab3, "Hatch Pets - Q", {"Quantum Dragon"}, "selectedPet_Q", "autoHatch_Q")

createPetHatchSection(
    Tab3,
    "Hatch Pets - R",
    {
        "Red Bunny",
        "Red Dragon",
        "Red Firecaster",
        "Red Golem",
        "Red Kitty",
        "Red Pheonix",
        "Rising Abyss Birdie",
        "Rising Dawn Midnight Wyvern",
        "Rising Divine Dragon",
        "Rising Millenium Hydra",
        "Royal Cosmo Pegasus",
        "Ruby Midnight Wyvern"
    },
    "selectedPet_R",
    "autoHatch_R"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - S",
    {
        "Secret Shadows Leviathan",
        "Shadow Eclipse Leviathan",
        "Shadowstorm Bunny",
        "Shadows Edge Kitty",
        "Silver Dog",
        "Soul Clash Golem",
        "Soul Focus Phantom",
        "Starhunter Pegasus",
        "Starstrike Overdrive Dragon",
        "Sub-Zero Frost Hydra",
        "Supercharged Midnight Kitty",
        "Swift Eclipse Bunny"
    },
    "selectedPet_S",
    "autoHatch_S"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - T",
    {
        "Tan Dog",
        "Teal Shadow Dragon",
        "Teal Thunderstorm Dragon",
        "Thunder Strike Falcon",
        "Tundra Dragon",
        "Twin Element Birdies",
        "Twilight Magical Kitty"
    },
    "selectedPet_T",
    "autoHatch_T"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - U",
    {
        "Ultimate Overdrive Bunny",
        "Ultimate Supernova Pegasus",
        "Ultranova Firecaster",
        "Ultra Birdie",
        "Ultra Chaos Fusion Dragon",
        "Underworld Duo Dragon",
        "Unleashed Sub-Zero Dragon",
        "Unlimited Secrets Master Dragon"
    },
    "selectedPet_U",
    "autoHatch_U"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - V",
    {"Void Dragon", "Void Omega Pegasus", "Voltaic Falcon"},
    "selectedPet_V",
    "autoHatch_V"
)

createPetHatchSection(
    Tab3,
    "Hatch Pets - W",
    {"White Pegasus", "White Pheonix", "Winter Legends Polar Bear", "Winter Wonder Kitty"},
    "selectedPet_W",
    "autoHatch_W"
)

createPetHatchSection(Tab3, "Hatch Pets - Y", {"Yellow Butterfly", "Yellow Squeak"}, "selectedPet_Y", "autoHatch_Y")

createPetHatchSection(Tab3, "Hatch Pets - Z", {"Zen Master Leviathan"}, "selectedPet_Z", "autoHatch_Z")

if Tab4 then
    local function createCrystalSection(tab, sectionName, crystalList, selectionVarName, toggleVarName)
        tab:CreateSection(sectionName)

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
            "Auto Open",
            function(state)
                _G[toggleVarName] = state
                if state then
                    spawn(
                        function()
                            while _G[toggleVarName] do
                                local crystal = _G[selectionVarName]
                                if crystal then
                                    local args = {
                                        [1] = "openCrystal",
                                        [2] = crystal
                                    }
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

    local allCrystals = {
        "Blue Crystal",
        "Purple Crystal",
        "Enchanted Crystal",
        "Astral Crystal",
        "Golden Crystal",
        "Inferno Crystal",
        "Galaxy Crystal",
        "Frozen Crystal",
        "Eternal Crystal",
        "Storm Crystal",
        "Thunder Crystal",
        "Secret Blades Crystal",
        "Infinity Void Crystal"
    }

    createCrystalSection(Tab4, "Crystals", allCrystals, "selectedCrystalTab4", "autoOpenCrystalTab4")
end

Tab5:CreateSection("Island Teleports")

local islandTeleports = {
    ["Spawn Island"] = CFrame.new(
        30.2903004,
        3.19602513,
        26.960619,
        -0.0679417104,
        1.0007718e-07,
        0.997689307,
        4.96522434e-10,
        1,
        -1.00275152e-07,
        -0.997689307,
        -6.31749009e-09,
        -0.0679417104
    ),
    ["Enchanted Island"] = CFrame.new(80, 766, -188),
    ["Astral Island"] = CFrame.new(233, 2013, 331),
    ["Mystical Island"] = CFrame.new(165, 4047, 51),
    ["Space Island"] = CFrame.new(186, 5656, 76),
    ["Tundra Island"] = CFrame.new(189, 9284, 31),
    ["Eternal Island"] = CFrame.new(139, 13680, 74),
    ["Sandstorm Island"] = CFrame.new(135, 17686, 61),
    ["Thunderstorm Island"] = CFrame.new(108, 24069, 84),
    ["Ancient Inferno Island"] = CFrame.new(171, 28255, 39),
    ["Midnight Shadow Island"] = CFrame.new(180, 33206, 28),
    ["Mythical Souls Island"] = CFrame.new(-109, 39434, 155),
    ["Winter Wonder Island"] = CFrame.new(183, 46010, 36),
    ["Golden Master Island"] = CFrame.new(166, 52607, 34),
    ["Dragon Legend Island"] = CFrame.new(188, 59594, 24),
    ["Cybernetic Legends Island"] = CFrame.new(226, 66669, 15),
    ["Skystorm Ultraus Island"] = CFrame.new(197, 70270, 8),
    ["Chaos Legends Island"] = CFrame.new(142, 74445, 71),
    ["Soul Fusion Island"] = CFrame.new(143, 79747, 72),
    ["Dark Elements Island"] = CFrame.new(139, 83199, 73),
    ["Inner Peace Island"] = CFrame.new(136, 87051, 63),
    ["Blazing Vortex Island"] = CFrame.new(136, 91255, 60)
}

local islandOrder = {
    "Spawn Island",
    "Enchanted Island",
    "Astral Island",
    "Mystical Island",
    "Space Island",
    "Tundra Island",
    "Eternal Island",
    "Sandstorm Island",
    "Thunderstorm Island",
    "Ancient Inferno Island",
    "Midnight Shadow Island",
    "Mythical Souls Island",
    "Winter Wonder Island",
    "Golden Master Island",
    "Dragon Legend Island",
    "Cybernetic Legends Island",
    "Skystorm Ultraus Island",
    "Chaos Legends Island",
    "Soul Fusion Island",
    "Dark Elements Island",
    "Inner Peace Island",
    "Blazing Vortex Island"
}

Tab5:CreateDropdown(
    "Select Island",
    islandOrder,
    function(selectedIsland)
        local cframe = islandTeleports[selectedIsland]
        if cframe then
            teleportTo(cframe)
        end
    end
)

Tab5:CreateSection("Other Teleports")

local teleportLocations = {
    ["King Of The Hill"] = CFrame.new(227.120529, 89.8075867, -285.06219),
    ["Pet Cloning Altar"] = CFrame.new(4520.91943, 122.947517, 1401.6312),
    ["Altar Of Elements"] = CFrame.new(732.294434, 122.947517, -5908.3461),
    ["Infinity Stats Dojo"] = CFrame.new(-4109.91553, 122.94751, -5908.6845),
    ["Mystical Waters"] = CFrame.new(344, 8824, 125),
    ["Lava Pit"] = CFrame.new(-128, 12952, 274),
    ["Tornado"] = CFrame.new(320, 16872, -17),
    ["Sword Of Legends"] = CFrame.new(1831, 38, -140),
    ["Sword Of Ancients"] = CFrame.new(613, 38, 2411),
    ["Elemental Tornado"] = CFrame.new(323, 30383, -10),
    ["Fallen Infinity Blade"] = CFrame.new(1859, 38, -6788),
    ["Zen Masters Blade"] = CFrame.new(5019, 38, 1614)
}

local teleportOrder = {
    "King Of The Hill",
    "Pet Cloning Altar",
    "Altar Of Elements",
    "Infinity Stats Dojo",
    "Mystical Waters",
    "Lava Pit",
    "Tornado",
    "Sword Of Legends",
    "Sword Of Ancients",
    "Elemental Tornado",
    "Fallen Infinity Blade",
    "Zen Masters Blade"
}

Tab5:CreateDropdown(
    "Select Location",
    teleportOrder,
    function(selected)
        local cframe = teleportLocations[selected]
        if cframe then
            teleportTo(cframe)
        end
    end
)

Tab5:CreateSection("Server Teleports")
local serverOptions = {
    ["Lowest Player Count"] = LowestPlayer,
    ["Server Hop"] = Serverhop,
    ["Rejoin"] = Rejoin
}
local serverOrder = {"Lowest Player Count", "Server Hop", "Rejoin"}
Tab5:CreateDropdown(
    "Server Options",
    serverOrder,
    function(choice)
        serverOptions[choice]()
    end
)

Tab6:CreateSection("General Settings")
Tab6:CreateToggle(
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
Tab6:CreateToggle(
    "Freeze Character",
    function(state)
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        hrp.Anchored = state
    end
)
Tab6:CreateToggle(
    "Enable Bull Mode",
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
Tab6:CreateSection("Player Settings")
Tab6:CreateBox(
    "Set Walk Speed",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
    end
)
Tab6:CreateBox(
    "Set Jump Power",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input)
    end
)
Tab6:CreateBox(
    "Set Hip Height",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(input)
    end
)
Tab6:CreateBox(
    "Set Gravity",
    function(input)
        workspace.Gravity = tonumber(input)
    end
)

Tab7:CreateSection("Player Stats")
Tab7.statsLabel1 = Tab7:CreateLabel("Ninjitsu: ")
Tab7.statsLabel2 = Tab7:CreateLabel("Kills: ")
Tab7.statsLabel3 = Tab7:CreateLabel("Streak: ")
Tab7:CreateSection("Pet Stats")
Tab7.petsLabel1 = Tab7:CreateLabel("Equipped: ")
Tab7.petsLabel2 = Tab7:CreateLabel("Total Coins: ")
Tab7.petsLabel3 = Tab7:CreateLabel("Total Chi: ")

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

    local equippedPetsLabel = petInfoMenu:FindFirstChild("petsLabel")
    local petCoinsLabel =
        petInfoMenu:FindFirstChild("totalStepsLabel") and petInfoMenu.totalStepsLabel:FindFirstChild("stepsLabel")
    local petChiLabel =
        petInfoMenu:FindFirstChild("totalGemsLabel") and petInfoMenu.totalGemsLabel:FindFirstChild("gemsLabel")

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
            if leaderstats:FindFirstChild("Ninjitsu") then
                Tab7.statsLabel1.SetText("Ninjitsu: " .. leaderstats.Ninjitsu.Value)
            end
            if leaderstats:FindFirstChild("Kills") then
                Tab7.statsLabel2.SetText("Kills: " .. leaderstats.Kills.Value)
            end
            if leaderstats:FindFirstChild("Streak") then
                Tab7.statsLabel3.SetText("Streak: " .. leaderstats.Streak.Value)
            end
        end

        if equippedPetsLabel then
            local petCount = convertFormattedNumber(equippedPetsLabel.Text)
            Tab7.petsLabel1.SetText("Equipped: " .. petCount)
        end
        if petCoinsLabel then
            local coinsCount = convertFormattedNumber(petCoinsLabel.Text)
            Tab7.petsLabel2.SetText("Total Coins: " .. coinsCount)
        end
        if petChiLabel then
            local chiCount = convertFormattedNumber(petChiLabel.Text)
            Tab7.petsLabel3.SetText("Total Chi: " .. chiCount)
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
    if petCoinsLabel then
        petCoinsLabel:GetPropertyChangedSignal("Text"):Connect(onStatChanged)
    end
    if petChiLabel then
        petChiLabel:GetPropertyChangedSignal("Text"):Connect(onStatChanged)
    end

    onStatChanged()
end

updateStats()