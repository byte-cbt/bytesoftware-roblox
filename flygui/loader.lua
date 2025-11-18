--[[
Byte Software - Fly GUI
---------------------------------
Credits:
  - Byt3c0de (www.byt3c0de.net | @byt3c0de.net)
  - Byte Software (www.bytesoftware.net | discord.gg/bytesoftware)
  - Everyone who has supported me on this journey

I’ve created these scripts and am sharing them openly so that others can learn, experiment, and build amazing projects. 
I hope my code inspires creativity and helps you on your own development journey!

Have fun coding!
]]

local Library = loadstring(game:HttpGet("https://bytesoftware.net/roblox/flygui/library.lua", true))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local flySpeed = 50
local flyEnabled = false
local flying = false
local bodyVelocity, bodyGyro, flyConnection, stateChangedConnection, animationConnection, noclipConnection
local currentKeybind = Enum.KeyCode.F
local settingKeybind = false
local lastLookDirection = Vector3.new(0, 0, -1)
local rotationSpeed = (getgenv and getgenv().rotationSpeed) or 0.03

local originalCollisionStates = {}

local speeds = 1
local speaker = game:GetService("Players").LocalPlayer
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
local nowe = false
local tpwalking = false

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function getRootPart()
    local char = getCharacter()
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
end

local function waitForControlModule()
    local success, controlModule =
        pcall(
        function()
            return require(
                player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule")
            )
        end
    )
    if success then
        return controlModule
    else
        return nil
    end
end

local function isMovementAnimation(animationId)
    if not animationId then
        return false
    end
    local movementAnimIds = {
        "rbxassetid://180436334",
        "rbxassetid://180436148",
        "rbxassetid://125750702",
        "rbxassetid://180436148",
        "rbxassetid://180435571",
        "rbxassetid://180435792",
        "rbxassetid://180436334"
    }
    for _, id in pairs(movementAnimIds) do
        if animationId:find(id:gsub("rbxassetid://", "")) then
            return true
        end
    end
    return false
end

local function isCharacterAnchored()
    local char = getCharacter()
    local root = getRootPart()
    if not char or not root then
        return false
    end
    if root.Anchored then
        return true
    end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Sit then
        return true
    end
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Anchored then
            return true
        end
    end
    local joints = root:GetJoints()
    for _, joint in pairs(joints) do
        if joint:IsA("Motor6D") or joint:IsA("Weld") or joint:IsA("WeldConstraint") then
            local otherPart = joint.Part0 == root and joint.Part1 or joint.Part0
            if otherPart and otherPart.Anchored and otherPart.Parent ~= char then
                return true
            end
        end
    end
    return false
end

local function handleAnimations()
    local char = getCharacter()
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end
    if animationConnection then
        animationConnection:Disconnect()
    end
    animationConnection =
        humanoid.AnimationPlayed:Connect(
        function(track)
            if flyEnabled and flying then
                if track.Animation and track.Animation.AnimationId then
                    local animId = track.Animation.AnimationId
                    if isMovementAnimation(animId) then
                        track:Stop()
                    end
                end
            end
        end
    )
end

local function preventSitting()
    local char = getCharacter()
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    if humanoid and flyEnabled then
        if stateChangedConnection then
            stateChangedConnection:Disconnect()
        end
        stateChangedConnection =
            humanoid.StateChanged:Connect(
            function(old, new)
                if flyEnabled then
                    if new == Enum.HumanoidStateType.Seated then
                        task.spawn(
                            function()
                                task.wait(0.1)
                                if flyEnabled and humanoid.Parent then
                                    humanoid:ChangeState(Enum.HumanoidStateType.Running)
                                end
                            end
                        )
                    elseif
                        old == Enum.HumanoidStateType.Seated and
                            (new == Enum.HumanoidStateType.Jumping or new == Enum.HumanoidStateType.Running or
                                new == Enum.HumanoidStateType.Freefall)
                     then
                        task.spawn(
                            function()
                                task.wait(0.2)
                                if flyEnabled and humanoid.Parent then
                                    humanoid.PlatformStand = true
                                    if not flying then
                                        startFly()
                                    end
                                end
                            end
                        )
                    end
                end
            end
        )
    end
end

local function storeOriginalCollisions()
    originalCollisionStates = {}
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                originalCollisionStates[v] = v.CanCollide
            end
        end
    end
end

local noclipfly = true

local function enableNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    if not noclipfly then
        return
    end
    storeOriginalCollisions()

    noclipConnection =
        RunService.Stepped:Connect(
        function()
            if not flyEnabled or not flying then
                return
            end
            local char = player.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end
    )
end

local function disableNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                if originalCollisionStates[v] ~= nil then
                    v.CanCollide = originalCollisionStates[v]
                else
                    if
                        v.Name == "Head" or v.Name == "HumanoidRootPart" or v.Name == "Torso" or v.Name == "UpperTorso" or
                            v.Name == "LowerTorso"
                     then
                        v.CanCollide = false
                    else
                        v.CanCollide = true
                    end
                end
            end
        end
    end
    task.wait(0.1)
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        if humanoid and root then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            task.wait(0.05)
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
    originalCollisionStates = {}
end

function startFlyV3()
    if not flyEnabled then
        return
    end
    flying = true

    if nowe == true then
        nowe = false

        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    else
        nowe = true

        for i = 1, speeds do
            spawn(
                function()
                    local hb = game:GetService("RunService").Heartbeat
                    tpwalking = true
                    local chr = game.Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end
            )
        end

        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
        local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

        for i, v in next, Hum:GetPlayingAnimationTracks() do
            v:AdjustSpeed(0)
        end

        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
        speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
        speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    end

    if
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType ==
            Enum.HumanoidRigType.R6
     then
        local plr = game.Players.LocalPlayer
        local torso = plr.Character.Torso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed_v3 = 0

        local bg = Instance.new("BodyGyro", torso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end

        spawn(
            function()
                while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
                    wait()

                    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                        speed_v3 = speed_v3 + .5 + (speed_v3 / maxspeed)
                        if speed_v3 > maxspeed then
                            speed_v3 = maxspeed
                        end
                    elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed_v3 ~= 0 then
                        speed_v3 = speed_v3 - 1
                        if speed_v3 < 0 then
                            speed_v3 = 0
                        end
                    end

                    if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                        bv.velocity =
                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) +
                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) -
                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                            speed_v3
                        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                    elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed_v3 ~= 0 then
                        bv.velocity =
                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) +
                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) -
                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                            speed_v3
                    else
                        bv.velocity = Vector3.new(0, 0, 0)
                    end

                    bg.cframe =
                        game.Workspace.CurrentCamera.CoordinateFrame *
                        CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed_v3 / maxspeed), 0, 0)
                end

                ctrl = {f = 0, b = 0, l = 0, r = 0}
                lastctrl = {f = 0, b = 0, l = 0, r = 0}
                speed_v3 = 0
                bg:Destroy()
                bv:Destroy()
                plr.Character.Humanoid.PlatformStand = false
                game.Players.LocalPlayer.Character.Animate.Disabled = false
                tpwalking = false
            end
        )
    else
        local plr = game.Players.LocalPlayer
        local UpperTorso = plr.Character.UpperTorso
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed_v3 = 0

        local bg = Instance.new("BodyGyro", UpperTorso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = UpperTorso.CFrame
        local bv = Instance.new("BodyVelocity", UpperTorso)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

        if nowe == true then
            plr.Character.Humanoid.PlatformStand = true
        end

        spawn(
            function()
                while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
                    wait()

                    if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                        speed_v3 = speed_v3 + .5 + (speed_v3 / maxspeed)
                        if speed_v3 > maxspeed then
                            speed_v3 = maxspeed
                        end
                    elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed_v3 ~= 0 then
                        speed_v3 = speed_v3 - 1
                        if speed_v3 < 0 then
                            speed_v3 = 0
                        end
                    end

                    if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                        bv.velocity =
                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) +
                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) -
                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                            speed_v3
                        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                    elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed_v3 ~= 0 then
                        bv.velocity =
                            ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) +
                            ((game.Workspace.CurrentCamera.CoordinateFrame *
                                CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) -
                                game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                            speed_v3
                    else
                        bv.velocity = Vector3.new(0, 0, 0)
                    end

                    bg.cframe =
                        game.Workspace.CurrentCamera.CoordinateFrame *
                        CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed_v3 / maxspeed), 0, 0)
                end

                ctrl = {f = 0, b = 0, l = 0, r = 0}
                lastctrl = {f = 0, b = 0, l = 0, r = 0}
                speed_v3 = 0
                bg:Destroy()
                bv:Destroy()
                plr.Character.Humanoid.PlatformStand = false
                game.Players.LocalPlayer.Character.Animate.Disabled = false
                tpwalking = false
            end
        )
    end

    enableNoclip()
end

function startFly()
    startFlyV3()
end

function stopFly()
    flying = false
    nowe = false
    tpwalking = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    if stateChangedConnection then
        stateChangedConnection:Disconnect()
        stateChangedConnection = nil
    end
    if animationConnection then
        animationConnection:Disconnect()
        animationConnection = nil
    end

    disableNoclip()

    local char = getCharacter()
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    local root = getRootPart()

    if humanoid and root then
        root.AssemblyAngularVelocity = Vector3.zero
        root.AssemblyLinearVelocity = Vector3.zero
        humanoid.PlatformStand = false

        humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)

        task.wait(0.1)
        humanoid:ChangeState(Enum.HumanoidStateType.Running)

        char.Animate.Disabled = false
    end
end

local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        startFly()
    else
        stopFly()
    end
end

local function keyCodeToString(keyCode)
    local keyName = tostring(keyCode):gsub("Enum.KeyCode.", "")
    return keyName
end

local function updateKeybindDisplay()
    keybindLabel.Text = keyCodeToString(currentKeybind)
end

local keybindConnection =
    UserInputService.InputBegan:Connect(
    function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if settingKeybind then
            if input.KeyCode ~= Enum.KeyCode.Unknown then
                currentKeybind = input.KeyCode
                updateKeybindDisplay()
                settingKeybind = false
                keybindButton.Text = "Set Keybind"
                keybindButton.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
            end
        else
            if input.KeyCode == currentKeybind then
                toggleFly()
            end
        end
    end
)

local function cleanup()
    flyEnabled = false
    flying = false
    nowe = false
    tpwalking = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if stateChangedConnection then
        stateChangedConnection:Disconnect()
        stateChangedConnection = nil
    end
    if animationConnection then
        animationConnection:Disconnect()
        animationConnection = nil
    end
    if keybindConnection then
        keybindConnection:Disconnect()
        keybindConnection = nil
    end
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    disableNoclip()
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
        if humanoid and root then
            root.AssemblyAngularVelocity = Vector3.zero
            root.AssemblyLinearVelocity = Vector3.zero
            humanoid.PlatformStand = false
            task.wait()
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
            char.Animate.Disabled = false
        end
    end
end

player.CharacterRemoving:Connect(
    function()
        flying = false
        nowe = false
        tpwalking = false
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
        if stateChangedConnection then
            stateChangedConnection:Disconnect()
            stateChangedConnection = nil
        end
        if animationConnection then
            animationConnection:Disconnect()
            animationConnection = nil
        end
        disableNoclip()
    end
)

player.CharacterAdded:Connect(
    function(char)
        if flyEnabled then
            task.wait(1)
            startFly()
        end
        task.wait(0.7)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character.Humanoid.PlatformStand = false
            player.Character.Animate.Disabled = false
        end
    end
)

local Window = Library:CreateWindow("Fly GUI")

Window:CreateBox(
    "Enter Fly Speed",
    function(input)
        speeds = tonumber(input)
        if speeds < 1 then
            speeds = 1
        else
            if nowe == true then
                tpwalking = false
                for i = 1, speeds do
                    spawn(
                        function()
                            local hb = game:GetService("RunService").Heartbeat
                            tpwalking = true
                            local chr = game.Players.LocalPlayer.Character
                            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                            while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                                if hum.MoveDirection.Magnitude > 0 then
                                    chr:TranslateBy(hum.MoveDirection)
                                end
                            end
                        end
                    )
                end
            end
        end
    end
)
Window:CreateToggle(
    "Enable Fly",
    function(state)
        toggleFly()
    end
)

Window:CreateToggle(
    "Disable Noclip",
    function(state)
        if state then
            noclipfly = false
        else
            noclipfly = true
        end
    end
)

Window:CreateButton(
    "Move Up",
    function(state)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
        end
    end
)

Window:CreateButton(
    "Move Down",
    function(state)
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
        end
    end
)