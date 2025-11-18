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

local isAuto = {
    globalTarget = nil,
    gunName = "",
    autoKill = false,
    autoGun = false
}

local function teleportTo(cframe)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
end

local Window = DesyncedLibrary:CreateWindow("Desynced", "Zombie Attack")

DesyncedLibrary:createNotification("The script for Zombie Attack has been successfully loaded.")

local Tab1 = Window:CreateTab("Universal Tools", "96221607452840")
local Tab2 = Window:CreateTab("Auto Farming", "91650065131944")
local Tab3 = Window:CreateTab("Teleportation", "140134362123695")
local Tab4 = Window:CreateTab("Script Settings", "139117814373418")
local Tab5 = Window:CreateTab("Player Statistics", "133249606271733")

Tab1:CreateSection("Miscellaneous")
Tab1:CreateButton("Join Discord", function()
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

    Tab1:CreateSection("Extra Options")
    Tab1:CreateButton("Get All Guns",function()
        for _, Thing in pairs(game.ReplicatedStorage.Guns:GetChildren()) do
            if Thing:IsA("Tool") then
                Thing.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end)
    Tab1:CreateButton("Get All Knifes",function()
        for _, Thing in pairs(game.ReplicatedStorage.Knives:GetChildren()) do
            if Thing:IsA("Tool") then
                Thing.Parent = game.Players.LocalPlayer.Backpack
            end
        end
    end)

Tab2:CreateSection("General Farming")
Tab2:CreateToggle("Auto Kill", function(state)
    isAuto.autoKill = state
    if state then
        spawn(function()
            local groundDistance = 8
            local Player = game:GetService("Players").LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            local normalWalkSpeed = Humanoid.WalkSpeed
            local normalJumpPower = Humanoid.JumpPower
            local normalGravity = game.Workspace.Gravity

            Humanoid.WalkSpeed = 0
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            game.Workspace.Gravity = 0

            local function getNearest()
                local nearest, dist = nil, 99999
                for _, v in pairs(game.Workspace.BossFolder:GetChildren()) do
                    if v:FindFirstChild("Head") then
                        local m = (Character.Head.Position - v.Head.Position).Magnitude
                        if m < dist then
                            dist = m
                            nearest = v
                        end
                    end
                end
                for _, v in pairs(game.Workspace.enemies:GetChildren()) do
                    if v:FindFirstChild("Head") then
                        local m = (Character.Head.Position - v.Head.Position).Magnitude
                        if m < dist then
                            dist = m
                            nearest = v
                        end
                    end
                end
                return nearest
            end

            while isAuto.autoKill do
                task.wait()

                Character = Player.Character
                if Character and Character:FindFirstChild("HumanoidRootPart") then
                    local target = getNearest()
                    if target and target:FindFirstChild("Head") and target:FindFirstChild("HumanoidRootPart") then
                        isAuto.globalTarget = target

                        local cam = game.Workspace.CurrentCamera
                        cam.CFrame = CFrame.new(cam.CFrame.Position, target.Head.Position)
                        Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9)
                    end

                    local velocity = Character.HumanoidRootPart.Velocity
                    Character.HumanoidRootPart.Velocity = Vector3.new(0, velocity.Y, 0)

                    if isAuto.globalTarget and isAuto.globalTarget:FindFirstChild("Head") and Character:FindFirstChildOfClass("Tool") then
                        local tool = Character:FindFirstChildOfClass("Tool")
                        if tool then
                            game.ReplicatedStorage.Gun:FireServer({
                                Normal = Vector3.new(0, 0, 0),
                                Direction = isAuto.globalTarget.Head.Position,
                                Name = tool.Name,
                                Hit = isAuto.globalTarget.Head,
                                Origin = isAuto.globalTarget.Head.Position,
                                Pos = isAuto.globalTarget.Head.Position,
                            })
                        end
                    end
                end
            end

            local Character = Player.Character
            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then
                    Humanoid.WalkSpeed = Character:GetAttribute("NormalWalkSpeed") or 16
                    Humanoid.JumpPower = Character:GetAttribute("NormalJumpPower") or 50
                    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                end
            end
            game.Workspace.Gravity = Character:GetAttribute("NormalGravity") or 196.2
            isAuto.globalTarget = nil
        end)
    end
end)

Tab2:CreateBox("Enter Gun Name", function(input)
    isAuto.gunName = input
end)

Tab2:CreateToggle("Auto Equip Gun", function(state)
    isAuto.autoGun = state
    if state then
        spawn(function()
            while isAuto.autoGun do
                task.wait(0.2)

                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local backpack = player:FindFirstChild("Backpack")

                if humanoid and backpack and isAuto.gunName and isAuto.gunName ~= "" then
                    for _, tool in ipairs(backpack:GetChildren()) do
                        if tool:IsA("Tool") and tool.Name == isAuto.gunName then
                            humanoid:EquipTool(tool)
                            break
                        end
                    end
                end
            end
        end)
    else
        task.wait(0.1)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:UnequipTools()
        end
    end
end)

local function getTableKeys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys
end

Tab3:CreateSection("Main Teleports")
local mainLocations = {
    ["Spawn"] = CFrame.new(143.896622, -39.7914124, 2512.38745, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Active Map"] = CFrame.new(66.5044479, -39.7914124, 2467.40869, 0.999507248, -4.64199434e-09, -0.0313879475, 1.8045091e-09, 1, -9.04287987e-08, 0.0313879475, 9.03276032e-08, 0.999507248)
}
local mainOrder = { "Spawn", "Active Map" }
Tab3:CreateDropdown("Select Main Location", mainOrder, function(loc)
    teleportTo(mainLocations[loc])
end)

    Tab3:CreateSection("Server Teleports")
    local serverOptions = {
        ["Lowest Player Count"] = LowestPlayer,
        ["Server Hop"] = Serverhop,
        ["Rejoin"] = Rejoin
    }
    local serverOrder = { "Lowest Player Count", "Server Hop", "Rejoin" }
    Tab3:CreateDropdown("Server Options", serverOrder, function(choice)
        serverOptions[choice]()
    end)

Tab4:CreateSection("General Settings")
Tab4:CreateToggle("Anti-Idle Protection", function(state)
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
Tab4:CreateToggle("Freeze Character", function(state)
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    hrp.Anchored = state
end)
Tab4:CreateToggle("Enable Bull Mode", function(state)
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
Tab4:CreateSection("Player Settings")
Tab4:CreateBox("Set Walk Speed", function(input)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(input)
end)
Tab4:CreateBox("Set Jump Power", function(input)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(input)
end)
Tab4:CreateBox("Set Hip Height", function(input)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = tonumber(input)
end)
Tab4:CreateBox("Set Gravity", function(input)
    workspace.Gravity = tonumber(input)
end)

Tab5:CreateSection("Player Stats")
Tab5.statsLabel1 = Tab5:CreateLabel("Kills: ")
Tab5.statsLabel2 = Tab5:CreateLabel("Level: ")
Tab5.statsLabel3 = Tab5:CreateLabel("Cash: ")

local function updateStats()
    local player = game.Players.LocalPlayer
    local leaderstats = player:FindFirstChild("leaderstats")

    local function onStatChanged()
        if leaderstats then
            if leaderstats:FindFirstChild("Kills") then
                Tab5.statsLabel1.SetText("Kills: " .. leaderstats.Kills.Value)
            end
            if leaderstats:FindFirstChild("Level") then
                Tab5.statsLabel2.SetText("Level: " .. leaderstats.Level.Value)
            end
            if leaderstats:FindFirstChild("Cash") then
                Tab5.statsLabel3.SetText("Cash: " .. leaderstats.Cash.Value)
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