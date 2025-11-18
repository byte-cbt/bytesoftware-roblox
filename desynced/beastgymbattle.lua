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
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local player = game.Players.LocalPlayer

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

local function firePPrompt()
    for _, instance in ipairs(workspace:GetDescendants()) do
        if instance:IsA("ProximityPrompt") then
            local prompt = instance
            local targetPart = prompt.Parent

            if targetPart and targetPart:IsA("BasePart") then
                local distance = (targetPart.Position - rootPart.Position).Magnitude
                if distance <= prompt.MaxActivationDistance then
                    prompt:InputHoldBegin()
                    task.wait(prompt.HoldDuration)
                    prompt:InputHoldEnd()
                end
            end
        end
    end
end

local isAuto = {
    selectTraining1_1 = "",
    autoTraining1_1 = false,
    selectTraining1_2 = "",
    autoTraining1_2 = false,
    selectTraining1_3 = "",
    autoTraining1_3 = false,
    selectTraining1_4 = "",
    autoTraining1_4 = false,
    selectTraining2_1 = "",
    autoTraining2_1 = false,
    selectTraining2_2 = "",
    autoTraining1_2 = false,
    selectTraining2_3 = "",
    autoTraining2_3 = false,
    selectTraining3_1 = "",
    autoTraining3_1 = false,
    selectTraining3_2 = "",
    autoTraining3_2 = false,
    selectTraining3_3 = "",
    autoTraining3_3 = false,
    selectTraining4_1 = "",
    autoTraining4_1 = false,
    selectTraining4_2 = "",
    autoTraining4_2 = false,
    selectTraining4_3 = "",
    autoTraining4_3 = false,
    selectTraining5_1 = "",
    autoTraining5_1 = false,
    selectTraining5_2 = "",
    autoTraining5_2 = false,
    selectTraining4_3 = "",
    autoTraining4_3 = false,
    selectTraining6_1 = "",
    autoTraining6_1 = false,
    selectTraining6_2 = "",
    autoTraining6_2 = false,
    selectTraining6_3 = "",
    autoTraining6_3 = false,
    selectTraining7_1 = "",
    autoTraining7_1 = false,
    selectTraining7_2 = "",
    autoTraining7_2 = false,
    selectTraining7_3 = "",
    autoTraining7_3 = false,
    autoUpgradeTraining = false,
    autoRebirth = false,
    autoClaimGifts = false,
    autoSpinWheel = false,
    selectEgg1 = false,
    autoHatch1 = false,
    selectEgg2 = false,
    autoHatch2 = false,
    selectEgg3 = false,
    autoHatch3 = false,
    selectEgg4 = false,
    autoHatch4 = false,
    selectEgg5 = false,
    autoHatch5 = false,
    selectEgg6 = false,
    autoHatch6 = false,
    selectEgg7 = false,
    autoHatch7 = false
}

local function teleportTo(cframe)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
end

local Window = DesyncedLibrary:CreateWindow("Desynced", "Beast Gym Battle")

DesyncedLibrary:createNotification("The script for Beast Gym Battle has been loaded!")

local Tab1 = Window:CreateTab("Universal Tools", "96221607452840")
local Tab2 = Window:CreateTab("Spawn World", "127006372331103")
local Tab3 = Window:CreateTab("City Gym", "127006372331103")
local Tab4 = Window:CreateTab("School Gym", "127006372331103")
local Tab5 = Window:CreateTab("Arena Gym", "127006372331103")
local Tab6 = Window:CreateTab("Smelter Gym", "127006372331103")
local Tab7 = Window:CreateTab("Urban Gym", "127006372331103")
local Tab8 = Window:CreateTab("Wharf Gym", "127006372331103")
local Tab96 = Window:CreateTab("Egg Hatching", "84773625854784")
local Tab97 = Window:CreateTab("Teleportation", "140134362123695")
local Tab98 = Window:CreateTab("Script Settings", "139117814373418")
local Tab99 = Window:CreateTab("Player Statistics", "133249606271733")

Tab1:CreateSection("Miscellaneous")
Tab1:CreateButton(
    "Join Desynced Discord",
    function()
        setclipboard("https://discord.gg/bytesoftware")
        DesyncedLibrary:createNotification("The Discord Server invite has been copied to your clipboard!")
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

Tab1:CreateSection("Basic Auto Farm")
Tab1:CreateToggle(
    "Auto Rebirth",
    function(state)
        isAuto.autoRebirth = state

        if state then
            spawn(
                function()
                    while isAuto.autoRebirth do
                        wait()
                        game:GetService("ReplicatedStorage"):WaitForChild("RebirthSystem"):WaitForChild("Remotes"):WaitForChild(
                            "Rebirth"
                        ):FireServer()
                        task.wait(0.1)
                    end
                end
            )
        end
    end
)
Tab1:CreateToggle(
    "Auto Upgrade Speed",
    function(state)
        isAuto.autoUpgradeTraining = state

        if state then
            spawn(
                function()
                    while isAuto.autoUpgradeTraining do
                        wait()
                        game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                            "UpgradeAutoTrain"
                        ):FireServer()
                        task.wait(0.1)
                    end
                end
            )
        end
    end
)
Tab1:CreateToggle(
    "Auto Claim Gifts",
    function(state)
        isAuto.autoClaimGifts = state

        if state then
            spawn(
                function()
                    while isAuto.autoClaimGifts do
                        wait()
                        for i = 1, 12 do
                            local claimRemote =
                                game:GetService("ReplicatedStorage"):WaitForChild("GiftSystem"):WaitForChild("Remotes"):WaitForChild(
                                "Claim"
                            )
                            claimRemote:FireServer(i)
                            task.wait(0.1)
                        end
                        task.wait(1)
                    end
                end
            )
        end
    end
)
Tab1:CreateToggle(
    "Auto Spin Wheel",
    function(state)
        isAuto.autoSpinWheel = state

        if state then
            spawn(
                function()
                    while isAuto.autoSpinWheel do
                        wait()
                        game:GetService("ReplicatedStorage"):WaitForChild("SpinSystem"):WaitForChild("Remotes"):WaitForChild(
                            "Spin"
                        ):FireServer()
                        task.wait(1)
                    end
                end
            )
        end
    end
)

Tab1:CreateSection("Other")
Tab1:CreateButton(
    "Disable Gamepass Popup",
    function()
        local prompt = game:GetService("CoreGui"):FindFirstChild("PurchasePromptApp")
        if prompt then
            prompt:Destroy()
        end
    end
)

Tab1:CreateSection("Trading")
Tab1:CreateBox(
    "Trade Target Username",
    function(input)
        usernameTrade = input
    end
)
Tab1:CreateButton(
    "Send Trade Request",
    function()
        if usernameTrade and usernameTrade ~= "" then
            local targetPlayer = game.Players:FindFirstChild(usernameTrade)
            if targetPlayer then
                game:GetService("ReplicatedStorage"):WaitForChild("TradeSystem"):WaitForChild("Remotes"):WaitForChild(
                    "RequestTrade"
                ):FireServer(targetPlayer)
                DesyncedLibrary:createNotification("Trade sent to: " .. usernameTrade)
            else
                DesyncedLibrary:createNotification("Player not found: " .. usernameTrade)
            end
        end
    end
)

Tab2:CreateSection("Spawn Area Gym")
Tab2:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Abs", "Back"},
    function(selected)
        isAuto.selectTraining1_1 = selected
    end
)
Tab2:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining1_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining1_1 then
                        wait()
                        if isAuto.selectTraining1_1 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    495.436737,
                                    6.95476437,
                                    -2.76068568,
                                    0.874915421,
                                    1.89916278e-08,
                                    0.484275788,
                                    -3.74941855e-08,
                                    1,
                                    2.85222033e-08,
                                    -0.484275788,
                                    -4.31120419e-08,
                                    0.874915421
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_1 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    465.906982,
                                    6.95475245,
                                    -42.2561722,
                                    -0.461182475,
                                    5.20617256e-08,
                                    0.887305319,
                                    4.14509493e-08,
                                    1,
                                    -3.71295812e-08,
                                    -0.887305319,
                                    1.96561345e-08,
                                    -0.461182475
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_1 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    459.196045,
                                    6.95477629,
                                    40.8308449,
                                    0.683490515,
                                    4.6860265e-08,
                                    -0.729959369,
                                    -1.99550527e-08,
                                    1,
                                    4.55109941e-08,
                                    0.729959369,
                                    -1.65399552e-08,
                                    0.683490515
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_1 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    423.020477,
                                    6.95476866,
                                    15.8521214,
                                    -0.496571153,
                                    6.700526e-08,
                                    -0.867996037,
                                    3.56408592e-08,
                                    1,
                                    5.68056002e-08,
                                    0.867996037,
                                    -2.72810263e-09,
                                    -0.496571153
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_1 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    421.549957,
                                    7.04615545,
                                    -24.2941399,
                                    -0.0147562139,
                                    -8.32124627e-08,
                                    -0.999891102,
                                    -4.89471716e-08,
                                    1,
                                    -8.24991702e-08,
                                    0.999891102,
                                    4.77244662e-08,
                                    -0.0147562139
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab2:CreateSection("Train Area 1 Gym")
Tab2:CreateDropdown(
    "Select Training",
    {"Chest 1", "Chest 2", "Arms 1", "Arms 2", "Legs 1", "Legs 2", "Back 1", "Back 2", "Abs 1", "Abs 2"},
    function(selected)
        isAuto.selectTraining1_2 = selected
    end
)
Tab2:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining1_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining1_2 then
                        wait()
                        if isAuto.selectTraining1_2 == "Chest 1" then
                            teleportTo(
                                CFrame.new(
                                    400.146759,
                                    7.02496767,
                                    -87.4672165,
                                    -0.834204972,
                                    -1.55852009e-09,
                                    -0.551454484,
                                    -7.96369637e-10,
                                    1,
                                    -1.62150204e-09,
                                    0.551454484,
                                    -9.1350344e-10,
                                    -0.834204972
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Chest 2" then
                            teleportTo(
                                CFrame.new(
                                    357.799103,
                                    7.02496767,
                                    -87.8952866,
                                    -0.833358824,
                                    2.31788658e-10,
                                    0.552732408,
                                    -4.34911794e-11,
                                    1,
                                    -4.84922602e-10,
                                    -0.552732408,
                                    -4.28153485e-10,
                                    -0.833358824
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Arms 1" then
                            teleportTo(
                                CFrame.new(
                                    401.446259,
                                    7.02496767,
                                    -106.625679,
                                    -0.150170222,
                                    -7.80584202e-08,
                                    -0.988660157,
                                    1.14685337e-08,
                                    1,
                                    -8.06957274e-08,
                                    0.988660157,
                                    -2.34565771e-08,
                                    -0.150170222
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Arms 2" then
                            teleportTo(
                                CFrame.new(
                                    359.641571,
                                    7.02496767,
                                    -106.822098,
                                    -0.819263041,
                                    8.16166335e-08,
                                    0.573417902,
                                    1.10227866e-07,
                                    1,
                                    1.51529616e-08,
                                    -0.573417902,
                                    7.56208891e-08,
                                    -0.819263041
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Legs 1" then
                            teleportTo(
                                CFrame.new(
                                    398.806152,
                                    7.02496719,
                                    -144.893646,
                                    0.935965121,
                                    4.69348507e-08,
                                    0.352092683,
                                    -2.06342747e-08,
                                    1,
                                    -7.84506184e-08,
                                    -0.352092683,
                                    6.61618671e-08,
                                    0.935965121
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Legs 2" then
                            teleportTo(
                                CFrame.new(
                                    358.80658,
                                    7.02496767,
                                    -143.99527,
                                    0.976379991,
                                    -8.8393225e-12,
                                    0.216060415,
                                    1.68323346e-08,
                                    1,
                                    -7.60246479e-08,
                                    -0.216060415,
                                    7.78657423e-08,
                                    0.976379991
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Back 1" then
                            teleportTo(
                                CFrame.new(
                                    400.178131,
                                    7.02496719,
                                    -133.771088,
                                    -0.929833531,
                                    3.18769655e-09,
                                    -0.367980421,
                                    2.73369483e-09,
                                    1,
                                    1.75502646e-09,
                                    0.367980421,
                                    6.25936247e-10,
                                    -0.929833531
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Back 2" then
                            teleportTo(
                                CFrame.new(
                                    357.645142,
                                    7.02496767,
                                    -134.913544,
                                    -0.819461465,
                                    -4.28173017e-08,
                                    0.573134303,
                                    -5.89134537e-08,
                                    1,
                                    -9.52657153e-09,
                                    -0.573134303,
                                    -4.15719796e-08,
                                    -0.819461465
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Abs 1" then
                            teleportTo(
                                CFrame.new(
                                    387.131287,
                                    7.0905838,
                                    -79.5438538,
                                    -0.952690244,
                                    2.5337604e-08,
                                    0.303942859,
                                    5.50617152e-09,
                                    1,
                                    -6.61042918e-08,
                                    -0.303942859,
                                    -6.13033535e-08,
                                    -0.952690244
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_2 == "Abs 2" then
                            teleportTo(
                                CFrame.new(
                                    374.720642,
                                    7.02307415,
                                    -80.403389,
                                    -0.934437931,
                                    0.000111905763,
                                    0.35612601,
                                    0.000184595701,
                                    0.99999994,
                                    0.000170129322,
                                    -0.356125981,
                                    0.000224714619,
                                    -0.934437931
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab2:CreateSection("Train Area 2 Gym")
Tab2:CreateDropdown(
    "Select Training",
    {"Chest 1", "Chest 2", "Arms 1", "Arms 2", "Legs 1", "Legs 2", "Back 1", "Back 2", "Abs 1", "Abs 2"},
    function(selected)
        isAuto.selectTraining1_3 = selected
    end
)
Tab2:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining1_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining1_3 then
                        wait()
                        if isAuto.selectTraining1_3 == "Chest 1" then
                            teleportTo(
                                CFrame.new(
                                    552.819519,
                                    7.02496767,
                                    75.1687088,
                                    0.648126423,
                                    4.54706353e-08,
                                    0.761532724,
                                    3.27693783e-08,
                                    1,
                                    -8.7598778e-08,
                                    -0.761532724,
                                    8.17300432e-08,
                                    0.648126423
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Chest 2" then
                            teleportTo(
                                CFrame.new(
                                    584.851929,
                                    7.02496767,
                                    74.6250153,
                                    0.814879477,
                                    -3.83923948e-10,
                                    -0.579630435,
                                    -1.08284528e-08,
                                    1,
                                    -1.58856519e-08,
                                    0.579630435,
                                    1.92213925e-08,
                                    0.814879477
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Arms 1" then
                            teleportTo(
                                CFrame.new(
                                    553.435364,
                                    7.02496767,
                                    96.947319,
                                    0.86357379,
                                    -3.69406195e-08,
                                    0.504222453,
                                    3.26963807e-08,
                                    1,
                                    1.72639734e-08,
                                    -0.504222453,
                                    1.5775341e-09,
                                    0.86357379
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Arms 2" then
                            teleportTo(
                                CFrame.new(
                                    584.591125,
                                    7.02496767,
                                    96.3299026,
                                    0.329062432,
                                    -1.83247479e-08,
                                    -0.944308162,
                                    1.04023705e-08,
                                    1,
                                    -1.57805662e-08,
                                    0.944308162,
                                    -4.63025218e-09,
                                    0.329062432
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Legs 1" then
                            teleportTo(
                                CFrame.new(
                                    549.803101,
                                    7.71939278,
                                    144.691589,
                                    -0.722832382,
                                    6.85139554e-08,
                                    0.691023409,
                                    -3.87497545e-09,
                                    1,
                                    -1.03201877e-07,
                                    -0.691023409,
                                    -7.72753523e-08,
                                    -0.722832382
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Legs 2" then
                            teleportTo(
                                CFrame.new(
                                    585.214417,
                                    8.0953331,
                                    142.782501,
                                    -0.474200636,
                                    -3.60297321e-08,
                                    -0.880416811,
                                    -6.84493742e-08,
                                    1,
                                    -4.05603018e-09,
                                    0.880416811,
                                    5.83406035e-08,
                                    -0.474200636
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Back 1" then
                            teleportTo(
                                CFrame.new(
                                    552.751526,
                                    7.02496767,
                                    113.24147,
                                    -0.421945214,
                                    5.94000902e-08,
                                    0.906621337,
                                    4.33107843e-08,
                                    1,
                                    -4.53610696e-08,
                                    -0.906621337,
                                    2.01265937e-08,
                                    -0.421945214
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Back 2" then
                            teleportTo(
                                CFrame.new(
                                    585.644409,
                                    7.02496767,
                                    110.550209,
                                    -0.992010593,
                                    -2.45735663e-08,
                                    -0.126154751,
                                    -4.06464338e-08,
                                    1,
                                    1.24831828e-07,
                                    0.126154751,
                                    1.28962228e-07,
                                    -0.992010593
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Abs 1" then
                            teleportTo(
                                CFrame.new(
                                    561.633667,
                                    7.02496767,
                                    59.9551773,
                                    0.999009073,
                                    4.57890721e-08,
                                    -0.0445064791,
                                    -4.91780767e-08,
                                    1,
                                    -7.50513891e-08,
                                    0.0445064791,
                                    7.71657653e-08,
                                    0.999009073
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_3 == "Abs 2" then
                            teleportTo(
                                CFrame.new(
                                    575.950073,
                                    7.02496719,
                                    59.4821777,
                                    0.85059303,
                                    1.8579172e-08,
                                    -0.525824606,
                                    -5.13266549e-08,
                                    1,
                                    -4.76944599e-08,
                                    0.525824606,
                                    6.75573943e-08,
                                    0.85059303
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab2:CreateSection("King Of The Hill")
Tab2:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining1_4 = selected
    end
)
Tab2:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining1_4 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining1_4 then
                        wait()
                        if isAuto.selectTraining1_4 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    370.030609,
                                    17.8215828,
                                    98.8096771,
                                    -0.998118639,
                                    -2.24809639e-07,
                                    -0.0613117516,
                                    -2.75621289e-07,
                                    1,
                                    8.20285095e-07,
                                    0.0613117516,
                                    8.35640662e-07,
                                    -0.998118639
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_4 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    401.380737,
                                    19.8137932,
                                    122.955849,
                                    -0.068363823,
                                    4.65547849e-08,
                                    0.997660458,
                                    6.56739108e-09,
                                    1,
                                    -4.6213934e-08,
                                    -0.997660458,
                                    3.39266548e-09,
                                    -0.068363823
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_4 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    398.705688,
                                    20.9093361,
                                    150.414047,
                                    0.529936433,
                                    -5.27133714e-08,
                                    0.848037362,
                                    2.24552608e-08,
                                    1,
                                    4.8127017e-08,
                                    -0.848037362,
                                    -6.46136034e-09,
                                    0.529936433
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_4 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    365.883209,
                                    17.8202801,
                                    130.589386,
                                    -0.362566948,
                                    -4.20493045e-08,
                                    0.931957722,
                                    -8.46441495e-08,
                                    1,
                                    1.21895374e-08,
                                    -0.931957722,
                                    -7.44652482e-08,
                                    -0.362566948
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining1_4 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    408.520813,
                                    17.8098717,
                                    99.8335724,
                                    0.111828208,
                                    0.000838231121,
                                    0.993727207,
                                    0.000274966907,
                                    0.999999583,
                                    -0.000874465215,
                                    -0.993727505,
                                    0.000371031987,
                                    0.111827932
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab3:CreateSection("Train Area 1 Gym")
Tab3:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Abs", "Back"},
    function(selected)
        isAuto.selectTraining2_1 = selected
    end
)
Tab3:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining2_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining2_1 then
                        wait()
                        if isAuto.selectTraining2_1 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    2473.02661,
                                    7.02528429,
                                    -1598.6759,
                                    0.940153301,
                                    2.43571296e-08,
                                    -0.340751797,
                                    -4.20206625e-08,
                                    1,
                                    -4.44568045e-08,
                                    0.340751797,
                                    5.61148248e-08,
                                    0.940153301
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_1 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    2473.94873,
                                    8.45268536,
                                    -1617.02686,
                                    0.795942366,
                                    -5.21037187e-08,
                                    0.605372369,
                                    7.06522885e-09,
                                    1,
                                    7.67795214e-08,
                                    -0.605372369,
                                    -5.68349847e-08,
                                    0.795942366
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_1 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    2471.90308,
                                    7.02352858,
                                    -1649.15015,
                                    0.97263968,
                                    -5.14792464e-06,
                                    -0.232318774,
                                    4.79502414e-05,
                                    1,
                                    0.000178592469,
                                    0.232318774,
                                    -0.000184845863,
                                    0.97263968
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_1 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    2470.92603,
                                    7.02528429,
                                    -1581.8374,
                                    0.864658117,
                                    -2.93535649e-08,
                                    -0.502360702,
                                    3.86675509e-08,
                                    1,
                                    8.12294321e-09,
                                    0.502360702,
                                    -2.64486264e-08,
                                    0.864658117
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_1 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    2474.2561,
                                    7.02528429,
                                    -1630.16443,
                                    0.999754846,
                                    1.07066942e-08,
                                    -0.0221406966,
                                    -1.07148166e-08,
                                    1,
                                    -2.48227494e-10,
                                    0.0221406966,
                                    4.85400165e-10,
                                    0.999754846
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab3:CreateSection("Train Area 2 Gym")
Tab3:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Abs", "Back"},
    function(selected)
        isAuto.selectTraining2_2 = selected
    end
)
Tab3:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining2_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining2_2 then
                        wait()
                        if isAuto.selectTraining2_2 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    2642.93335,
                                    7.02527285,
                                    -1511.01697,
                                    -0.910151958,
                                    -7.33063601e-08,
                                    -0.414274603,
                                    -3.31349881e-08,
                                    1,
                                    -1.0415431e-07,
                                    0.414274603,
                                    -8.10692597e-08,
                                    -0.910151958
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_2 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    2644.78711,
                                    8.6703043,
                                    -1488.55518,
                                    -0.927108645,
                                    -2.19246732e-09,
                                    -0.374792695,
                                    -1.70540311e-08,
                                    1,
                                    3.63360151e-08,
                                    0.374792695,
                                    4.00791578e-08,
                                    -0.927108645
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_2 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    2645.11084,
                                    7.67111349,
                                    -1445.60327,
                                    -0.945445061,
                                    -7.25173477e-09,
                                    0.325781554,
                                    -8.20347168e-09,
                                    1,
                                    -1.54765323e-09,
                                    -0.325781554,
                                    -4.13576062e-09,
                                    -0.945445061
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_2 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    2639.37354,
                                    7.02528429,
                                    -1529.27808,
                                    -0.537679434,
                                    1.48850452e-08,
                                    -0.843149364,
                                    1.76435897e-08,
                                    1,
                                    6.40272146e-09,
                                    0.843149364,
                                    -1.14335688e-08,
                                    -0.537679434
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining2_2 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    2644.00195,
                                    7.02528238,
                                    -1473.76025,
                                    -0.976532161,
                                    5.97909917e-08,
                                    -0.215371728,
                                    1.88414671e-08,
                                    1,
                                    1.92187201e-07,
                                    0.215371728,
                                    1.83619065e-07,
                                    -0.976532161
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab3:CreateSection("King Of The Hill")
Tab3:CreateDropdown(
    "Select Training",
    {"All In One"},
    function(selected)
        isAuto.selectTraining2_3 = selected
    end
)
Tab3:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining2_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining2_3 then
                        wait()
                        if isAuto.selectTraining2_3 == "All In One" then
                            teleportTo(
                                CFrame.new(
                                    2479.88965,
                                    15.5776577,
                                    -1475.03308,
                                    0.941905975,
                                    4.0406487e-08,
                                    0.335876733,
                                    -6.84939465e-08,
                                    1,
                                    7.17774356e-08,
                                    -0.335876733,
                                    -9.06131135e-08,
                                    0.941905975
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab4:CreateSection("Train Area 1 Gym")
Tab4:CreateDropdown(
    "Select Training",
    {"Chest 1", "Chest 2", "Arms 1", "Arms 2", "Legs 1", "Legs 2", "Back 1", "Back 2", "Abs 1", "Abs 2"},
    function(selected)
        isAuto.selectTraining3_1 = selected
    end
)
Tab4:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining3_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining3_1 then
                        wait()
                        if isAuto.selectTraining3_1 == "Chest 1" then
                            teleportTo(
                                CFrame.new(
                                    2671.03931,
                                    10.2122841,
                                    909.646057,
                                    0.990289092,
                                    5.56918867e-09,
                                    -0.139023378,
                                    -1.7569219e-08,
                                    1,
                                    -8.50894111e-08,
                                    0.139023378,
                                    8.67056471e-08,
                                    0.990289092
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Chest 2" then
                            teleportTo(
                                CFrame.new(
                                    2700.81885,
                                    12.5512257,
                                    906.58075,
                                    -0.25538215,
                                    5.55438695e-10,
                                    -0.966840208,
                                    -3.18940013e-10,
                                    1,
                                    6.5873379e-10,
                                    0.966840208,
                                    4.76592876e-10,
                                    -0.25538215
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Arms 1" then
                            teleportTo(
                                CFrame.new(
                                    2673.07056,
                                    11.4785194,
                                    920.060913,
                                    -0.983370841,
                                    -8.14919154e-09,
                                    -0.181608811,
                                    3.27718674e-09,
                                    1,
                                    -6.26174526e-08,
                                    0.181608811,
                                    -6.21713454e-08,
                                    -0.983370841
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Arms 2" then
                            teleportTo(
                                CFrame.new(
                                    2701.84644,
                                    11.4542217,
                                    920.542542,
                                    0.456861019,
                                    1.1389281e-07,
                                    -0.889538109,
                                    -2.44646947e-09,
                                    1,
                                    1.26779412e-07,
                                    0.889538109,
                                    -5.57443407e-08,
                                    0.456861019
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Legs 1" then
                            teleportTo(
                                CFrame.new(
                                    2671.1521,
                                    10.2122841,
                                    950.621338,
                                    -0.732372403,
                                    1.00767608e-07,
                                    -0.680904269,
                                    3.59408645e-08,
                                    1,
                                    1.09333293e-07,
                                    0.680904269,
                                    5.5600399e-08,
                                    -0.732372403
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Legs 2" then
                            teleportTo(
                                CFrame.new(
                                    2702.26025,
                                    10.2122841,
                                    951.336792,
                                    -0.873610914,
                                    -9.9633084e-08,
                                    -0.486625105,
                                    -8.0046398e-08,
                                    1,
                                    -6.10401685e-08,
                                    0.486625105,
                                    -1.43727679e-08,
                                    -0.873610914
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Back 1" then
                            teleportTo(
                                CFrame.new(
                                    2670.81885,
                                    10.2122841,
                                    933.429016,
                                    -0.501322985,
                                    3.51382923e-10,
                                    0.865260243,
                                    -3.18250386e-08,
                                    1,
                                    -1.88452045e-08,
                                    -0.865260243,
                                    -3.69844741e-08,
                                    -0.501322985
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Back 2" then
                            teleportTo(
                                CFrame.new(
                                    2703.34424,
                                    10.2122841,
                                    930.404663,
                                    0.160157531,
                                    -2.07966906e-08,
                                    -0.987091482,
                                    1.3265379e-08,
                                    1,
                                    -1.89163227e-08,
                                    0.987091482,
                                    -1.0064551e-08,
                                    0.160157531
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Abs 1" then
                            teleportTo(
                                CFrame.new(
                                    2676.76978,
                                    10.2122841,
                                    899.21228,
                                    0.243642673,
                                    -4.79373874e-09,
                                    -0.969865084,
                                    8.1345064e-09,
                                    1,
                                    -2.89919289e-09,
                                    0.969865084,
                                    -7.18300663e-09,
                                    0.243642673
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_1 == "Abs 2" then
                            teleportTo(
                                CFrame.new(
                                    2695.1665,
                                    10.2122841,
                                    897.914062,
                                    -0.779661119,
                                    4.42231958e-08,
                                    0.626201689,
                                    3.86127255e-08,
                                    1,
                                    -2.25460202e-08,
                                    -0.626201689,
                                    6.60109878e-09,
                                    -0.779661119
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab4:CreateSection("Train Area 2 Gym")
Tab4:CreateDropdown(
    "Select Training",
    {"Chest 1", "Chest 2", "Arms 1", "Arms 2", "Legs 1", "Legs 2", "Back 1", "Back 2", "Abs 1", "Abs 2"},
    function(selected)
        isAuto.selectTraining3_2 = selected
    end
)
Tab4:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining3_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining3_2 then
                        wait()
                        if isAuto.selectTraining3_2 == "Chest 1" then
                            teleportTo(
                                CFrame.new(
                                    2556.72192,
                                    10.2122841,
                                    770.599182,
                                    0.990036011,
                                    -3.21861382e-09,
                                    0.140814409,
                                    -2.97518277e-09,
                                    1,
                                    4.37750103e-08,
                                    -0.140814409,
                                    -4.37577832e-08,
                                    0.990036011
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Chest 2" then
                            teleportTo(
                                CFrame.new(
                                    2523.49951,
                                    10.2122841,
                                    769.833191,
                                    0.863186419,
                                    -3.50867735e-09,
                                    -0.504885375,
                                    1.35962885e-09,
                                    1,
                                    -4.62493954e-09,
                                    0.504885375,
                                    3.30572814e-09,
                                    0.863186419
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Arms 1" then
                            teleportTo(
                                CFrame.new(
                                    2555.25293,
                                    11.6923027,
                                    753.438354,
                                    0.997166753,
                                    -3.27332272e-09,
                                    -0.0752224177,
                                    2.75787904e-09,
                                    1,
                                    -6.95613611e-09,
                                    0.0752224177,
                                    6.72897338e-09,
                                    0.997166753
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Arms 2" then
                            teleportTo(
                                CFrame.new(
                                    2528.13623,
                                    11.674017,
                                    756.501831,
                                    0.889197469,
                                    -6.78392027e-08,
                                    0.457523584,
                                    3.23769669e-08,
                                    1,
                                    8.53501021e-08,
                                    -0.457523584,
                                    -6.10798736e-08,
                                    0.889197469
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Legs 1" then
                            teleportTo(
                                CFrame.new(
                                    2555.50708,
                                    10.2122841,
                                    719.768372,
                                    0.477405369,
                                    -7.30064409e-09,
                                    -0.87868315,
                                    -2.17777019e-09,
                                    1,
                                    -9.49184376e-09,
                                    0.87868315,
                                    6.44502718e-09,
                                    0.477405369
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Legs 2" then
                            teleportTo(
                                CFrame.new(
                                    2529.67285,
                                    10.1959543,
                                    719.507141,
                                    0.304420531,
                                    0.013745511,
                                    0.952438533,
                                    -0.00542230718,
                                    0.999904692,
                                    -0.012697448,
                                    -0.952522278,
                                    -0.00129905052,
                                    0.304466069
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Back 1" then
                            teleportTo(
                                CFrame.new(
                                    2558.32495,
                                    10.2122841,
                                    742.271423,
                                    -0.250259459,
                                    -2.07296686e-08,
                                    0.968178809,
                                    -4.17890895e-08,
                                    1,
                                    1.06091491e-08,
                                    -0.968178809,
                                    -3.78042699e-08,
                                    -0.250259459
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Back 2" then
                            teleportTo(
                                CFrame.new(
                                    2526.97339,
                                    10.2122841,
                                    740.639221,
                                    -0.47852686,
                                    2.33921451e-08,
                                    -0.878072917,
                                    5.01341688e-08,
                                    1,
                                    -6.81492751e-10,
                                    0.878072917,
                                    -4.43475656e-08,
                                    -0.47852686
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Abs 1" then
                            teleportTo(
                                CFrame.new(
                                    2551.34277,
                                    10.2122841,
                                    775.717041,
                                    -0.784804046,
                                    -9.29010184e-08,
                                    0.619743943,
                                    -5.69741019e-08,
                                    1,
                                    7.77539029e-08,
                                    -0.619743943,
                                    2.57122217e-08,
                                    -0.784804046
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining3_2 == "Abs 2" then
                            teleportTo(
                                CFrame.new(
                                    2535.09937,
                                    10.2128429,
                                    778.562195,
                                    0.934661627,
                                    0.0186420679,
                                    0.355049461,
                                    -0.00748005835,
                                    0.999434471,
                                    -0.0327847302,
                                    -0.355459839,
                                    0.0279868376,
                                    0.934272468
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab4:CreateSection("King Of The Hill")
Tab4:CreateDropdown(
    "Select Training",
    {"All In One"},
    function(selected)
        isAuto.selectTraining3_3 = selected
    end
)
Tab4:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining3_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining3_3 then
                        wait()
                        if isAuto.selectTraining3_3 == "All In One" then
                            teleportTo(
                                CFrame.new(
                                    2691.54541,
                                    15.5528765,
                                    756.284485,
                                    -0.634926379,
                                    2.28509904e-08,
                                    -0.772572637,
                                    -2.49477878e-08,
                                    1,
                                    5.00807253e-08,
                                    0.772572637,
                                    5.10715523e-08,
                                    -0.634926379
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab5:CreateSection("Train Area 1 Gym")
Tab5:CreateDropdown(
    "Select Training",
    {
        "Chest 1",
        "Chest 2",
        "Arms 1",
        "Arms 2",
        "Legs 1",
        "Legs 2",
        "Back 1",
        "Back 2",
        "Abs 1",
        "Abs 2",
        "Abs 3",
        "Abs 4"
    },
    function(selected)
        isAuto.selectTraining4_1 = selected
    end
)
Tab5:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining4_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining4_1 then
                        wait()
                        if isAuto.selectTraining4_1 == "Chest 1" then
                            teleportTo(
                                CFrame.new(
                                    4701.13672,
                                    244.169418,
                                    -656.271484,
                                    -0.185774714,
                                    -1.18244181e-07,
                                    0.982592344,
                                    3.88431722e-08,
                                    1,
                                    1.27682924e-07,
                                    -0.982592344,
                                    6.18872633e-08,
                                    -0.185774714
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Chest 2" then
                            teleportTo(
                                CFrame.new(
                                    4728.54395,
                                    244.169434,
                                    -657.227844,
                                    -0.670706451,
                                    3.14907496e-08,
                                    -0.741722882,
                                    9.65045217e-08,
                                    1,
                                    -4.48084521e-08,
                                    0.741722882,
                                    -1.01632928e-07,
                                    -0.670706451
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Arms 1" then
                            teleportTo(
                                CFrame.new(
                                    4697.9585,
                                    245.601532,
                                    -635.634399,
                                    0.472510487,
                                    -2.74773129e-08,
                                    0.881325066,
                                    1.74224883e-08,
                                    1,
                                    2.18364438e-08,
                                    -0.881325066,
                                    5.03692732e-09,
                                    0.472510487
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Arms 2" then
                            teleportTo(
                                CFrame.new(
                                    4723.62305,
                                    244.169434,
                                    -637.465759,
                                    0.0194737371,
                                    -1.0579887e-09,
                                    -0.999810398,
                                    3.09335735e-09,
                                    1,
                                    -9.97938621e-10,
                                    0.999810398,
                                    -3.07333714e-09,
                                    0.0194737371
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Legs 1" then
                            teleportTo(
                                CFrame.new(
                                    4698.47559,
                                    244.169434,
                                    -583.159363,
                                    0.256826192,
                                    1.43802268e-08,
                                    0.966457605,
                                    -2.18123368e-08,
                                    1,
                                    -9.08291042e-09,
                                    -0.966457605,
                                    -1.87479703e-08,
                                    0.256826192
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Legs 2" then
                            teleportTo(
                                CFrame.new(
                                    4725.11426,
                                    244.169434,
                                    -586.479187,
                                    -0.337811142,
                                    -1.09299094e-08,
                                    -0.941213906,
                                    -3.68370046e-08,
                                    1,
                                    1.60860392e-09,
                                    0.941213906,
                                    3.5214903e-08,
                                    -0.337811142
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Back 1" then
                            teleportTo(
                                CFrame.new(
                                    4696.75977,
                                    244.169434,
                                    -615.782532,
                                    -0.898401558,
                                    -2.53428478e-09,
                                    0.43917495,
                                    -2.78345507e-08,
                                    1,
                                    -5.11694012e-08,
                                    -0.43917495,
                                    -5.81949067e-08,
                                    -0.898401558
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Back 2" then
                            teleportTo(
                                CFrame.new(
                                    4725.24121,
                                    244.289673,
                                    -614.970947,
                                    -0.566189289,
                                    1.6679305e-08,
                                    -0.824275255,
                                    4.07802467e-08,
                                    1,
                                    -7.77656872e-09,
                                    0.824275255,
                                    -3.80171592e-08,
                                    -0.566189289
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Abs 1" then
                            teleportTo(
                                CFrame.new(
                                    4659.98145,
                                    244.169434,
                                    -635.899353,
                                    0.0900537595,
                                    2.59001212e-08,
                                    0.99593693,
                                    -2.86213311e-08,
                                    1,
                                    -2.34178117e-08,
                                    -0.99593693,
                                    -2.63961777e-08,
                                    0.0900537595
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Abs 2" then
                            teleportTo(
                                CFrame.new(
                                    4656.58545,
                                    244.169434,
                                    -638.797058,
                                    0.56456399,
                                    6.66475088e-08,
                                    0.825389326,
                                    -7.09285146e-08,
                                    1,
                                    -3.22318492e-08,
                                    -0.825389326,
                                    -4.03466984e-08,
                                    0.56456399
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Abs 3" then
                            teleportTo(
                                CFrame.new(
                                    4651.87549,
                                    244.169434,
                                    -643.045898,
                                    0.642274141,
                                    -7.68660797e-08,
                                    0.766474962,
                                    5.19620116e-08,
                                    1,
                                    5.67431719e-08,
                                    -0.766474962,
                                    3.38290929e-09,
                                    0.642274141
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_1 == "Abs 4" then
                            teleportTo(
                                CFrame.new(
                                    4648.26123,
                                    244.169434,
                                    -646.239258,
                                    0.661427677,
                                    3.14859641e-08,
                                    0.750008941,
                                    -1.18479795e-08,
                                    1,
                                    -3.15321351e-08,
                                    -0.750008941,
                                    1.1970136e-08,
                                    0.661427677
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab5:CreateSection("Train Area 1 Gym")
Tab5:CreateDropdown(
    "Select Training",
    {
        "Chest 1",
        "Chest 2",
        "Arms 1",
        "Arms 2",
        "Legs 1",
        "Legs 2",
        "Back 1",
        "Back 2",
        "Abs 1",
        "Abs 2",
        "Abs 3",
        "Abs 4"
    },
    function(selected)
        isAuto.selectTraining4_2 = selected
    end
)
Tab5:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining4_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining4_2 then
                        wait()
                        if isAuto.selectTraining4_2 == "Chest 1" then
                            teleportTo(
                                CFrame.new(
                                    4754.12939,
                                    244.169434,
                                    -689.031738,
                                    -0.779108167,
                                    -1.26581497e-07,
                                    -0.626889527,
                                    -8.8042249e-08,
                                    1,
                                    -9.24996399e-08,
                                    0.626889527,
                                    -1.68744574e-08,
                                    -0.779108167
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Chest 2" then
                            teleportTo(
                                CFrame.new(
                                    4755.12207,
                                    244.169434,
                                    -720.727478,
                                    0.0950642303,
                                    -8.36930667e-08,
                                    -0.99547112,
                                    4.27057287e-08,
                                    1,
                                    -7.99955657e-08,
                                    0.99547112,
                                    -3.49076039e-08,
                                    0.0950642303
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Arms 1" then
                            teleportTo(
                                CFrame.new(
                                    4775.48438,
                                    245.713898,
                                    -690.718628,
                                    -0.108864322,
                                    -9.62373861e-08,
                                    -0.994056642,
                                    -7.80207898e-08,
                                    1,
                                    -8.82683153e-08,
                                    0.994056642,
                                    6.79478163e-08,
                                    -0.108864322
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Arms 2" then
                            teleportTo(
                                CFrame.new(
                                    4774.64062,
                                    245.566574,
                                    -721.443542,
                                    0.969629705,
                                    -2.52899302e-08,
                                    -0.244577557,
                                    3.99583442e-08,
                                    1,
                                    5.50126806e-08,
                                    0.244577557,
                                    -6.31148467e-08,
                                    0.969629705
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Legs 1" then
                            teleportTo(
                                CFrame.new(
                                    4830.20166,
                                    244.169434,
                                    -692.78363,
                                    -0.601634681,
                                    -3.74730043e-08,
                                    -0.798771381,
                                    -5.09818712e-08,
                                    1,
                                    -8.51375415e-09,
                                    0.798771381,
                                    3.56006886e-08,
                                    -0.601634681
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Legs 2" then
                            teleportTo(
                                CFrame.new(
                                    4829.71924,
                                    244.169434,
                                    -722.213928,
                                    -0.0556722097,
                                    3.24332583e-09,
                                    -0.998449087,
                                    4.2895687e-09,
                                    1,
                                    3.0091829e-09,
                                    0.998449087,
                                    -4.11538803e-09,
                                    -0.0556722097
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Back 1" then
                            teleportTo(
                                CFrame.new(
                                    4793.01367,
                                    244.169434,
                                    -690.150024,
                                    0.791183591,
                                    5.82001647e-08,
                                    -0.611578703,
                                    1.02249986e-08,
                                    1,
                                    1.08391632e-07,
                                    0.611578703,
                                    -9.20110708e-08,
                                    0.791183591
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Back 2" then
                            teleportTo(
                                CFrame.new(
                                    4793.44531,
                                    244.169434,
                                    -718.775696,
                                    0.746195495,
                                    3.21349205e-08,
                                    0.6657269,
                                    -2.04697113e-08,
                                    1,
                                    -2.53264716e-08,
                                    -0.6657269,
                                    5.27126165e-09,
                                    0.746195495
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Abs 1" then
                            teleportTo(
                                CFrame.new(
                                    4766.4585,
                                    244.169434,
                                    -767.57605,
                                    0.998758376,
                                    4.03992679e-08,
                                    0.0498164408,
                                    -3.70689648e-08,
                                    1,
                                    -6.77753889e-08,
                                    -0.0498164408,
                                    6.58445884e-08,
                                    0.998758376
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Abs 2" then
                            teleportTo(
                                CFrame.new(
                                    4769.7085,
                                    244.169418,
                                    -764.394043,
                                    -0.104921848,
                                    -3.76977773e-08,
                                    -0.994480491,
                                    -6.86644412e-08,
                                    1,
                                    -3.06626191e-08,
                                    0.994480491,
                                    6.50682708e-08,
                                    -0.104921848
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Abs 3" then
                            teleportTo(
                                CFrame.new(
                                    4773.19238,
                                    244.169434,
                                    -762.167297,
                                    0.0440276377,
                                    -2.55802473e-08,
                                    -0.999030292,
                                    3.21727853e-08,
                                    1,
                                    -2.41872087e-08,
                                    0.999030292,
                                    -3.10766808e-08,
                                    0.0440276377
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining4_2 == "Abs 4" then
                            teleportTo(
                                CFrame.new(
                                    4776.91846,
                                    244.169434,
                                    -760.462585,
                                    -0.166375786,
                                    -4.27420446e-08,
                                    -0.986062407,
                                    -1.73175128e-08,
                                    1,
                                    -4.04242435e-08,
                                    0.986062407,
                                    1.03505329e-08,
                                    -0.166375786
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab5:CreateSection("King Of The Hill")
Tab5:CreateDropdown(
    "Select Training",
    {"All In One"},
    function(selected)
        isAuto.selectTraining4_3 = selected
    end
)
Tab5:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining4_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining4_3 then
                        wait()
                        if isAuto.selectTraining4_3 == "All In One" then
                            teleportTo(
                                CFrame.new(
                                    4624.27002,
                                    247.110855,
                                    -703.368835,
                                    -0.114998959,
                                    -1.51348072e-08,
                                    0.993365586,
                                    2.04793729e-08,
                                    1,
                                    1.7606725e-08,
                                    -0.993365586,
                                    2.23682601e-08,
                                    -0.114998959
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab6:CreateSection("Train Area 1 Gym")
Tab6:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining5_1 = selected
    end
)

Tab6:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining5_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining5_1 then
                        wait()
                        if isAuto.selectTraining5_1 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    -2357.23706,
                                    35.6796951,
                                    4516.89648,
                                    0.403840691,
                                    -2.50731631e-08,
                                    -0.914829314,
                                    -1.47602712e-08,
                                    1,
                                    -3.39232251e-08,
                                    0.914829314,
                                    2.72027076e-08,
                                    0.403840691
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_1 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    -2366.40723,
                                    36.2359962,
                                    4482.42822,
                                    0.445555866,
                                    -9.90484992e-08,
                                    -0.895254135,
                                    1.669871e-08,
                                    1,
                                    -1.02326581e-07,
                                    0.895254135,
                                    3.06426173e-08,
                                    0.445555866
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_1 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    -2320.51074,
                                    35.6796913,
                                    4520.2002,
                                    0.803702891,
                                    7.40912114e-08,
                                    -0.595030844,
                                    -3.21089679e-08,
                                    1,
                                    8.11472987e-08,
                                    0.595030844,
                                    -4.61124898e-08,
                                    0.803702891
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_1 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    -2340.22949,
                                    35.6796951,
                                    4478.021,
                                    0.986613333,
                                    2.2095902e-08,
                                    0.163077161,
                                    -5.27352473e-09,
                                    1,
                                    -1.03588825e-07,
                                    -0.163077161,
                                    1.01342124e-07,
                                    0.986613333
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_1 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    -2382.60571,
                                    35.6796951,
                                    4515.21582,
                                    -0.339183807,
                                    -5.39168283e-08,
                                    -0.940720141,
                                    1.03235971e-08,
                                    1,
                                    -6.10366726e-08,
                                    0.940720141,
                                    -3.04142667e-08,
                                    -0.339183807
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab6:CreateSection("Train Area 2 Gym")
Tab6:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining5_2 = selected
    end
)

Tab6:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining5_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining5_2 then
                        wait()
                        if isAuto.selectTraining5_2 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    -2518.35059,
                                    35.6796951,
                                    4482.44678,
                                    0.310007215,
                                    -1.24101236e-08,
                                    0.950734198,
                                    -2.5301313e-08,
                                    1,
                                    2.1303233e-08,
                                    -0.950734198,
                                    -3.06589811e-08,
                                    0.310007215
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_2 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    -2505.16382,
                                    35.6787148,
                                    4520.35303,
                                    0.981667161,
                                    8.425733e-08,
                                    0.190603226,
                                    -7.22032354e-08,
                                    1,
                                    -7.0186573e-08,
                                    -0.190603226,
                                    5.51376864e-08,
                                    0.981667161
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_2 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    -2559.35474,
                                    35.6796951,
                                    4482.80664,
                                    0.936763942,
                                    -2.1956752e-09,
                                    -0.349961847,
                                    1.01417212e-08,
                                    1,
                                    2.08729123e-08,
                                    0.349961847,
                                    -2.31022081e-08,
                                    0.936763942
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_2 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    -2522.65356,
                                    35.6796951,
                                    4516.28516,
                                    -0.75021112,
                                    3.35846417e-09,
                                    0.661198378,
                                    3.3285803e-09,
                                    1,
                                    -1.30267475e-09,
                                    -0.661198378,
                                    1.2235708e-09,
                                    -0.75021112
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining5_2 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    -2491.57227,
                                    35.6796951,
                                    4485.98096,
                                    0.733972251,
                                    4.55702853e-09,
                                    0.67917943,
                                    -1.9781492e-08,
                                    1,
                                    1.46677559e-08,
                                    -0.67917943,
                                    -2.42009079e-08,
                                    0.733972251
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab6:CreateSection("King Of The Hill")
Tab6:CreateDropdown(
    "Select Training",
    {"All In One"},
    function(selected)
        isAuto.selectTraining5_3 = selected
    end
)
Tab6:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining5_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining5_3 then
                        wait()
                        if isAuto.selectTraining5_3 == "All In One" then
                            teleportTo(
                                CFrame.new(
                                    -2437.53857,
                                    39.5158844,
                                    4589.36279,
                                    -0.929674566,
                                    2.86148349e-08,
                                    -0.368381888,
                                    1.0448387e-08,
                                    1,
                                    5.13088061e-08,
                                    0.368381888,
                                    4.38514967e-08,
                                    -0.929674566
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab7:CreateSection("Train Area 1 Gym")
Tab7:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining6_1 = selected
    end
)

Tab7:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining6_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining6_1 then
                        wait()
                        if isAuto.selectTraining6_1 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    -2408.68286,
                                    13.707284,
                                    1637.27808,
                                    -0.37167275,
                                    2.91950091e-08,
                                    0.9283638,
                                    4.38526691e-08,
                                    1,
                                    -1.38912863e-08,
                                    -0.9283638,
                                    3.55482186e-08,
                                    -0.37167275
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_1 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    -2374.43335,
                                    13.707284,
                                    1622.41931,
                                    -0.416755944,
                                    -2.82003043e-09,
                                    -0.909018397,
                                    -4.95692998e-09,
                                    1,
                                    -8.29686486e-10,
                                    0.909018397,
                                    4.16016377e-09,
                                    -0.416755944
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_1 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    -2408.9751,
                                    13.707284,
                                    1661.22534,
                                    -0.869743168,
                                    4.61845389e-08,
                                    0.493504643,
                                    2.27543353e-08,
                                    1,
                                    -5.34830029e-08,
                                    -0.493504643,
                                    -3.52871083e-08,
                                    -0.869743168
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_1 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    -2369.52783,
                                    13.707284,
                                    1648.37695,
                                    -0.507799983,
                                    2.76817911e-08,
                                    -0.861474991,
                                    -1.9569308e-08,
                                    1,
                                    4.36682264e-08,
                                    0.861474991,
                                    3.90331927e-08,
                                    -0.507799983
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_1 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    -2406.40649,
                                    13.707284,
                                    1607.68481,
                                    -0.639625013,
                                    -1.18905234e-07,
                                    0.768687069,
                                    -7.95040265e-08,
                                    1,
                                    8.85307827e-08,
                                    -0.768687069,
                                    -4.48721416e-09,
                                    -0.639625013
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab7:CreateSection("Train Area 2 Gym")
Tab7:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining6_2 = selected
    end
)

Tab7:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining6_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining6_2 then
                        wait()
                        if isAuto.selectTraining6_2 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    -2306.47949,
                                    13.707284,
                                    1570.90295,
                                    -0.833271742,
                                    -3.88148074e-08,
                                    -0.552863657,
                                    -1.77715318e-08,
                                    1,
                                    -4.34217213e-08,
                                    0.552863657,
                                    -2.63568598e-08,
                                    -0.833271742
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_2 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    -2325.30005,
                                    13.707284,
                                    1541.25208,
                                    0.623150349,
                                    4.45344277e-08,
                                    -0.782102048,
                                    -4.88545737e-08,
                                    1,
                                    1.80164221e-08,
                                    0.782102048,
                                    2.69823239e-08,
                                    0.623150349
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_2 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    -2276.01855,
                                    13.707284,
                                    1569.93494,
                                    -0.422768265,
                                    2.80716712e-08,
                                    -0.906237841,
                                    -2.8038869e-09,
                                    1,
                                    3.22840918e-08,
                                    0.906237841,
                                    1.61896772e-08,
                                    -0.422768265
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_2 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    -2297.26562,
                                    13.707284,
                                    1538.22583,
                                    0.539179325,
                                    4.38543708e-08,
                                    -0.842190981,
                                    5.28242694e-09,
                                    1,
                                    5.54536292e-08,
                                    0.842190981,
                                    -3.43482647e-08,
                                    0.539179325
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        elseif isAuto.selectTraining6_2 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    -2338.52441,
                                    13.707284,
                                    1576.70801,
                                    0.785598516,
                                    1.45034731e-08,
                                    -0.618736625,
                                    -1.20121593e-08,
                                    1,
                                    8.18884605e-09,
                                    0.618736625,
                                    9.99217487e-10,
                                    0.785598516
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage").TrainingSystem.Remotes.AutoTrain:FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab7:CreateSection("King Of The Hill")
Tab7:CreateDropdown(
    "Select Training",
    {"All In One"},
    function(selected)
        isAuto.selectTraining6_3 = selected
    end
)
Tab7:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining6_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining6_3 then
                        wait()
                        if isAuto.selectTraining6_3 == "All In One" then
                            teleportTo(
                                CFrame.new(
                                    -2392.01855,
                                    17.6716137,
                                    1461.70166,
                                    0.924798906,
                                    4.07487377e-08,
                                    0.380456269,
                                    -4.17150225e-08,
                                    1,
                                    -5.70559955e-09,
                                    -0.380456269,
                                    -1.05942091e-08,
                                    0.924798906
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab8:CreateSection("Train Area 1 Gym")
Tab8:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining7_1 = selected
    end
)
Tab8:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining7_1 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining7_1 then
                        wait()
                        if isAuto.selectTraining7_1 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    -4876.53906,
                                    35.2456284,
                                    2268.98926,
                                    -0.914173365,
                                    5.9702967e-09,
                                    0.405323446,
                                    -2.27882619e-08,
                                    1,
                                    -6.61267379e-08,
                                    -0.405323446,
                                    -6.96879212e-08,
                                    -0.914173365
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_1 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    -4880.30762,
                                    36.3319664,
                                    2243.57886,
                                    -0.00982025638,
                                    2.12070699e-08,
                                    -0.99995178,
                                    6.42155342e-08,
                                    1,
                                    2.05774491e-08,
                                    0.99995178,
                                    -6.40103579e-08,
                                    -0.00982025638
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_1 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    -4854.04004,
                                    35.2456284,
                                    2248.70532,
                                    0.896489859,
                                    -2.71620237e-09,
                                    0.443064243,
                                    2.02056256e-08,
                                    1,
                                    -3.47532811e-08,
                                    -0.443064243,
                                    4.01083575e-08,
                                    0.896489859
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_1 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    -4855.95898,
                                    35.2456284,
                                    2270.68945,
                                    -0.208065957,
                                    3.14465831e-09,
                                    -0.978114784,
                                    -1.92685971e-11,
                                    1,
                                    3.21911853e-09,
                                    0.978114784,
                                    6.88635871e-10,
                                    -0.208065957
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_1 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    -4885.06494,
                                    35.2456284,
                                    2251.77539,
                                    -0.868639886,
                                    -2.41944189e-08,
                                    0.49544397,
                                    -7.27885805e-08,
                                    1,
                                    -7.87831667e-08,
                                    -0.49544397,
                                    -1.04496863e-07,
                                    -0.868639886
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab8:CreateSection("Train Area 2 Gym")
Tab8:CreateDropdown(
    "Select Training",
    {"Chest", "Arms", "Legs", "Back", "Abs"},
    function(selected)
        isAuto.selectTraining7_2 = selected
    end
)
Tab8:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining7_2 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining7_2 then
                        wait()
                        if isAuto.selectTraining7_2 == "Chest" then
                            teleportTo(
                                CFrame.new(
                                    -4950.11963,
                                    35.2456284,
                                    2176.60107,
                                    0.94080168,
                                    4.01225009e-08,
                                    -0.338957459,
                                    -4.2623725e-08,
                                    1,
                                    6.49876541e-11,
                                    0.338957459,
                                    1.43864893e-08,
                                    0.94080168
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_2 == "Arms" then
                            teleportTo(
                                CFrame.new(
                                    -4973.81885,
                                    36.8385773,
                                    2172.53564,
                                    0.950438619,
                                    8.24481745e-08,
                                    0.310912341,
                                    -5.66086342e-08,
                                    1,
                                    -9.21325523e-08,
                                    -0.310912341,
                                    6.99660134e-08,
                                    0.950438619
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_2 == "Legs" then
                            teleportTo(
                                CFrame.new(
                                    -4951.45947,
                                    35.3201752,
                                    2152.9519,
                                    0.451301575,
                                    -6.56655672e-08,
                                    -0.892371476,
                                    1.35792888e-07,
                                    1,
                                    -4.91053243e-09,
                                    0.892371476,
                                    -1.18961566e-07,
                                    0.451301575
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_2 == "Back" then
                            teleportTo(
                                CFrame.new(
                                    -4974.74316,
                                    35.2456284,
                                    2159.88525,
                                    0.999988198,
                                    4.49344597e-08,
                                    0.00485786144,
                                    -4.55115234e-08,
                                    1,
                                    1.18679125e-07,
                                    -0.00485786144,
                                    -1.18898811e-07,
                                    0.999988198
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        elseif isAuto.selectTraining7_2 == "Abs" then
                            teleportTo(
                                CFrame.new(
                                    -4955.35498,
                                    35.2456284,
                                    2188.97729,
                                    -0.201732978,
                                    1.06833639e-07,
                                    0.97944057,
                                    -4.98961228e-08,
                                    1,
                                    -1.19353174e-07,
                                    -0.97944057,
                                    -7.29477563e-08,
                                    -0.201732978
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab8:CreateSection("King Of The Hill")
Tab8:CreateDropdown(
    "Select Training",
    {"All In One"},
    function(selected)
        isAuto.selectTraining7_3 = selected
    end
)
Tab8:CreateToggle(
    "Auto Training",
    function(state)
        isAuto.autoTraining7_3 = state

        if state then
            spawn(
                function()
                    if isAuto.autoTraining7_3 then
                        wait()
                        if isAuto.selectTraining7_3 == "All In One" then
                            teleportTo(
                                CFrame.new(
                                    -5062.72021,
                                    39.8396111,
                                    2258.53198,
                                    -0.188753456,
                                    1.97618615e-08,
                                    0.982024491,
                                    -2.22884333e-09,
                                    1,
                                    -2.05519957e-08,
                                    -0.982024491,
                                    -6.06803896e-09,
                                    -0.188753456
                                )
                            )
                            wait(0.5)
                            firePPrompt()
                            wait(0.3)
                            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                                "AutoTrain"
                            ):FireServer()
                        end
                    end
                end
            )
        else
            game:GetService("ReplicatedStorage"):WaitForChild("TrainingSystem"):WaitForChild("Remotes"):WaitForChild(
                "AutoTrain"
            ):FireServer()
            wait(0.5)
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true
        end
    end
)

Tab96:CreateSection("Pet Options")
Tab96:CreateButton(
    "Equip Best Pets",
    function()
        game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild("EquipBest"):FireServer(

        )
    end
)
Tab96:CreateButton(
    "Craft All Pets",
    function()
        game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild("CraftAll"):FireServer(

        )
    end
)

Tab96:CreateSection("Spawn World Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Egg 1", "Egg 2", "Egg 3", "Egg 4"},
    function(selected)
        isAuto.selectEgg1 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch1 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg1 == "Egg 1" then
                        while isAuto.autoHatch1 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("SpawnEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg1 == "Egg 2" then
                        while isAuto.autoHatch1 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("SpawnEgg2", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg1 == "Egg 3" then
                        while isAuto.autoHatch1 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("SpawnEgg3", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg1 == "Egg 4" then
                        while isAuto.autoHatch1 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("SpawnEgg4", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab96:CreateSection("City Gym Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Winter Egg 1", "Winter Egg 2", "Winter Egg 3", "Winter Egg 4"},
    function(selected)
        isAuto.selectEgg2 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch2 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg2 == "Winter Egg 1" then
                        while isAuto.autoHatch2 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("WinterEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg2 == "Winter Egg 2" then
                        while isAuto.autoHatch2 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("WinterEgg2", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg2 == "Winter Egg 3" then
                        while isAuto.autoHatch2 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("WinterEgg3", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg2 == "Winter Egg 4" then
                        while isAuto.autoHatch2 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("WinterEgg4", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab96:CreateSection("School Gym Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Desert Egg 1", "Desert Egg 2", "Desert Egg 3", "Desert Egg 4"},
    function(selected)
        isAuto.selectEgg3 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch3 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg3 == "Desert Egg 1" then
                        while isAuto.autoHatch3 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DesertEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.autoHatch4 == "Desert Egg 2" then
                        while isAuto.autoHatch3 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DesertEgg2", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg3 == "Desert Egg 3" then
                        while isAuto.autoHatch3 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DesertEgg3", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg3 == "Desert Egg 4" then
                        while isAuto.autoHatch3 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DesertEgg4", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab96:CreateSection("Arena Gym Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Volcano Egg 1", "Volcano Egg 2", "Volcano Egg 3", "Volcano Egg 4"},
    function(selected)
        isAuto.selectEgg4 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch4 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg4 == "Volcano Egg 1" then
                        while isAuto.autoHatch4 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("VolcanoEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg4 == "Volcano Egg 2" then
                        while isAuto.autoHatch4 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("VolcanoEgg2", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg4 == "Volcano Egg 3" then
                        while isAuto.autoHatch4 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("VolcanoEgg3", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg4 == "Volcano Egg 4" then
                        while isAuto.autoHatch4 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("VolcanoEgg4", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab96:CreateSection("Smelter Gym Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Dark Matter Egg 1", "Dark Matter Egg 2", "Dark Matter Egg 3", "Dark Matter Egg 4"},
    function(selected)
        isAuto.selectEgg5 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch5 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg5 == "Dark Matter Egg 1" then
                        while isAuto.autoHatch5 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DarkMatterEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg5 == "Dark Matter Egg 2" then
                        while isAuto.autoHatch5 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DarkMatterEgg2", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg5 == "Dark Matter Egg 3" then
                        while isAuto.autoHatch5 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DarkMatterEgg3", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg5 == "Dark Matter Egg 4" then
                        while isAuto.autoHatch5 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("DarkMatterEgg4", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab96:CreateSection("Urban Gym Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Angel Egg 1", "Angel Egg 2", "Angel Egg 3", "Angel Egg 4"},
    function(selected)
        isAuto.selectEgg6 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch6 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg6 == "Angel Egg 1" then
                        while isAuto.autoHatch6 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("AngelEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg6 == "Angel Egg 2" then
                        while isAuto.autoHatch6 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("AngelEgg2", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg6 == "Angel Egg 3" then
                        while isAuto.autoHatch6 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("AngelEgg3", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg6 == "Angel Egg 4" then
                        while isAuto.autoHatch6 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("AngelEgg4", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab96:CreateSection("Wharf Gym Eggs")
Tab96:CreateDropdown(
    "Select Egg",
    {"Nature Egg 1", "Nature Egg 2"},
    function(selected)
        isAuto.selectEgg7 = selected
    end
)
Tab96:CreateToggle(
    "Auto Hatch",
    function(state)
        isAuto.autoHatch7 = state

        if state then
            spawn(
                function()
                    if isAuto.selectEgg7 == "Nature Egg 1" then
                        while isAuto.autoHatch7 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("NatureEgg1", nil, {})
                            wait(0.3)
                        end
                    elseif isAuto.selectEgg7 == "Nature Egg 2" then
                        while isAuto.autoHatch7 do
                            wait()
                            game:GetService("ReplicatedStorage"):WaitForChild("PetSystem"):WaitForChild("Remotes"):WaitForChild(
                                "HatchPet"
                            ):FireServer("NatureEgg2", nil, {})
                            wait(0.3)
                        end
                    end
                end
            )
        end
    end
)

Tab98:CreateSection("General Settings")
Tab98:CreateToggle(
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
Tab98:CreateToggle(
    "Freeze Character",
    function(state)
        local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
        hrp.Anchored = state
    end
)
Tab98:CreateToggle(
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
Tab98:CreateSection("Player Settings")
Tab98:CreateBox(
    "Set Walk Speed",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
    end
)
Tab98:CreateBox(
    "Set Jump Power",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input)
    end
)
Tab98:CreateBox(
    "Set Hip Height",
    function(input)
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(input)
    end
)
Tab98:CreateBox(
    "Set Gravity",
    function(input)
        workspace.Gravity = tonumber(input)
    end
)

local worldCFrames = {
    ["Spawn World"] = "Zone1",
    ["City Gym"] = "Zone2",
    ["School Gym"] = "Zone3",
    ["Arena Gym"] = "Zone4",
    ["Smelter Gym"] = "Zone5",
    ["Urban Gym"] = "Zone6",
    ["Wharf Gym"] = "Zone7"
}

local WorldTeleportEvent =
    game:GetService("ReplicatedStorage"):WaitForChild("WallSystem"):WaitForChild("Remotes"):WaitForChild(
    "TeleportPlayerToZone"
)

local worldList = {
    "Spawn World",
    "City Gym",
    "School Gym",
    "Arena Gym",
    "Smelter Gym",
    "Urban Gym",
    "Wharf Gym"
}

Tab97:CreateSection("Map Teleports")
Tab97:CreateDropdown(
    "Select Map",
    worldList,
    function(selected)
        WorldTeleportEvent:FireServer(worldCFrames[selected])
        teleportTo(worldCFrames[selected])
    end
)

Tab97:CreateSection("Server Teleports")
local serverOptions = {
    ["Lowest Player Count"] = LowestPlayer,
    ["Server Hop"] = Serverhop,
    ["Rejoin"] = Rejoin
}
local serverOrder = {"Lowest Player Count", "Server Hop", "Rejoin"}
Tab97:CreateDropdown(
    "Server Options",
    serverOrder,
    function(choice)
        serverOptions[choice]()
    end
)

Tab99:CreateSection("Player Stats")
Tab99.statsLabel1 = Tab99:CreateLabel("Kills: ")
Tab99.statsLabel2 = Tab99:CreateLabel("Power: ")
Tab99.statsLabel3 = Tab99:CreateLabel("Rebirths: ")

local function updateStats()
    local player = game.Players.LocalPlayer
    local leaderstats = player:FindFirstChild("leaderstats")

    local function onStatChanged()
        if leaderstats then
            for _, stat in ipairs(leaderstats:GetChildren()) do
                local name = stat.Name

                if name:find("Kills") then
                    Tab99.statsLabel1.SetText("Kills: " .. stat.Value)
                elseif name:find("Power") then
                    Tab99.statsLabel2.SetText("Power: " .. stat.Value)
                elseif name:find("Rebirth") then
                    Tab99.statsLabel3.SetText("Rebirths: " .. stat.Value)
                end
            end
        end
    end

    if leaderstats then
        for _, stat in ipairs(leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                stat.Changed:Connect(onStatChanged)
            end
        end
    end
    onStatChanged()
end
updateStats()
