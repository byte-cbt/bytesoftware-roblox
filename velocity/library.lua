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

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

if game.CoreGui:FindFirstChild("VelocityLibrary") then
    game.CoreGui:FindFirstChild("VelocityLibrary"):Destroy()
end

local Library = {}
function Library:CreateWindow()
    local VelocityLibrary = Instance.new("ScreenGui")
    local Main_1 = Instance.new("Frame")
    local UICorner_1 = Instance.new("UICorner")
    local MainBackground_1 = Instance.new("ImageLabel")
    local SideBar_1 = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local SideBarLogo_1 = Instance.new("ImageLabel")
    local TabsFrame_1 = Instance.new("ScrollingFrame")
    local UIListLayout_1 = Instance.new("UIListLayout")
    local UIPadding_1 = Instance.new("UIPadding")
    local ElementsHolder_1 = Instance.new("Frame")

    local TopBar_1 = Instance.new("Frame")
    local TopBarTitle_1 = Instance.new("TextLabel")
    local UIPadding_5 = Instance.new("UIPadding")
    local UICorner_6 = Instance.new("UICorner")
    local CloseFrame_1 = Instance.new("Frame")
    local UICorner_7 = Instance.new("UICorner")
    local CloseButton_1 = Instance.new("TextButton")
    local MinimizeFrame_1 = Instance.new("Frame")
    local UICorner_8 = Instance.new("UICorner")
    local MinimizeButton_1 = Instance.new("TextButton")
    local MaximizeFrame_1 = Instance.new("Frame")
    local UICorner_9 = Instance.new("UICorner")
    local MaximizeButton_1 = Instance.new("TextButton")
    local UIToggler_1 = Instance.new("ImageButton")

    VelocityLibrary.Name = "VelocityLibrary"
    VelocityLibrary.Parent = game.CoreGui
    VelocityLibrary.Enabled = true

    Main_1.Name = "Main"
    Main_1.Parent = VelocityLibrary
    Main_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
    Main_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main_1.BorderSizePixel = 0
    Main_1.Position = UDim2.new(0.337558359, 0, 0.25, 0)
    Main_1.Size = UDim2.new(0, 520, 0, 380)
    Main_1.Visible = true
    Main_1.Active = true

    UICorner_1.Parent = Main_1

    MainBackground_1.Name = "MainBackground"
    MainBackground_1.Parent = Main_1
    MainBackground_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainBackground_1.BackgroundTransparency = 1
    MainBackground_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MainBackground_1.BorderSizePixel = 0
    MainBackground_1.Size = UDim2.new(1, 0, 1, 0)
    MainBackground_1.Image = "rbxassetid://102676834187459"

    SideBar_1.Name = "SideBar"
    SideBar_1.Parent = MainBackground_1
    SideBar_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
    SideBar_1.BackgroundTransparency = 1
    SideBar_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SideBar_1.BorderSizePixel = 0
    SideBar_1.Position = UDim2.new(0, 4, 0, 4)
    SideBar_1.Size = UDim2.new(0, 50, 0, 372)
    SideBar_1.ZIndex = 2

    UICorner_2.Parent = SideBar_1

    SideBarLogo_1.Name = "SideBarLogo"
    SideBarLogo_1.Parent = SideBar_1
    SideBarLogo_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SideBarLogo_1.BackgroundTransparency = 1
    SideBarLogo_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SideBarLogo_1.BorderSizePixel = 0
    SideBarLogo_1.Position = UDim2.new(0, 5, 0, 5)
    SideBarLogo_1.Size = UDim2.new(0, 40, 0, 40)
    SideBarLogo_1.Image = "rbxassetid://92715042948482"
    SideBarLogo_1.ImageTransparency = 1

    TabsFrame_1.Name = "TabsFrame"
    TabsFrame_1.Parent = SideBar_1
    TabsFrame_1.Active = true
    TabsFrame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsFrame_1.BackgroundTransparency = 1
    TabsFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabsFrame_1.BorderSizePixel = 0
    TabsFrame_1.Position = UDim2.new(0, 0, 0, 60)
    TabsFrame_1.Size = UDim2.new(0, 50, 0, 297)
    TabsFrame_1.ClipsDescendants = true
    TabsFrame_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabsFrame_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
    TabsFrame_1.CanvasPosition = Vector2.new(0, 0)
    TabsFrame_1.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsFrame_1.ElasticBehavior = Enum.ElasticBehavior.Never
    TabsFrame_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    TabsFrame_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    TabsFrame_1.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    TabsFrame_1.ScrollBarImageTransparency = 1
    TabsFrame_1.ScrollBarThickness = 1
    TabsFrame_1.ScrollingDirection = Enum.ScrollingDirection.Y
    TabsFrame_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
    TabsFrame_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
    TabsFrame_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

    UIListLayout_1.Parent = TabsFrame_1
    UIListLayout_1.Padding = UDim.new(0, 14)
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

    UIPadding_1.Parent = TabsFrame_1
    UIPadding_1.PaddingLeft = UDim.new(0, 10)
    UIPadding_1.PaddingTop = UDim.new(0, 4)

    ElementsHolder_1.Name = "ElementsHolder"
    ElementsHolder_1.Parent = MainBackground_1
    ElementsHolder_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ElementsHolder_1.BackgroundTransparency = 1
    ElementsHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ElementsHolder_1.BorderSizePixel = 0
    ElementsHolder_1.Position = UDim2.new(0.111538462, 0, 0.115789473, 0)
    ElementsHolder_1.Size = UDim2.new(0, 462, 0, 336)
    ElementsHolder_1.ZIndex = 2
    ElementsHolder_1.ClipsDescendants = true

    TopBar_1.Name = "TopBar"
    TopBar_1.Parent = MainBackground_1
    TopBar_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
    TopBar_1.BackgroundTransparency = 1
    TopBar_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBar_1.BorderSizePixel = 0
    TopBar_1.Position = UDim2.new(0, 58, 0, 4)
    TopBar_1.Size = UDim2.new(0, 458, 0, 40)
    TopBar_1.ZIndex = 2

    TopBarTitle_1.Name = "TopBarTitle"
    TopBarTitle_1.Parent = TopBar_1
    TopBarTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopBarTitle_1.BackgroundTransparency = 1
    TopBarTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBarTitle_1.BorderSizePixel = 0
    TopBarTitle_1.Size = UDim2.new(0, 364, 0, 40)
    TopBarTitle_1.Font = Enum.Font.Ubuntu
    TopBarTitle_1.RichText = true
    TopBarTitle_1.Text = "<b>Velocity</b>  |  Byte Services"
    TopBarTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    TopBarTitle_1.TextSize = 14
    TopBarTitle_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_5.Parent = TopBarTitle_1
    UIPadding_5.PaddingLeft = UDim.new(0, 14)

    UICorner_6.Parent = TopBar_1

    CloseFrame_1.Name = "CloseFrame"
    CloseFrame_1.Parent = TopBar_1
    CloseFrame_1.BackgroundColor3 = Color3.fromRGB(255, 96, 92)
    CloseFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseFrame_1.BorderSizePixel = 0
    CloseFrame_1.Position = UDim2.new(0, 432, 0, 14)
    CloseFrame_1.Size = UDim2.new(0, 12, 0, 12)

    UICorner_7.Parent = CloseFrame_1

    CloseButton_1.Name = "CloseButton"
    CloseButton_1.Parent = CloseFrame_1
    CloseButton_1.Active = true
    CloseButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton_1.BackgroundTransparency = 1
    CloseButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton_1.BorderSizePixel = 0
    CloseButton_1.Size = UDim2.new(0, 12, 0, 12)
    CloseButton_1.Font = Enum.Font.SourceSans
    CloseButton_1.Text = ""
    CloseButton_1.TextSize = 14

    CloseButton_1.MouseEnter:Connect(
        function()
            local closeTween1 = TweenService:Create(CloseFrame_1, TweenInfo.new(0.3), {Transparency = 0.3})
            closeTween1:Play()
        end
    )

    CloseButton_1.MouseLeave:Connect(
        function()
            local closeTween2 = TweenService:Create(CloseFrame_1, TweenInfo.new(0.3), {Transparency = 0})
            closeTween2:Play()
        end
    )

    MinimizeFrame_1.Name = "MinimizeFrame"
    MinimizeFrame_1.Parent = TopBar_1
    MinimizeFrame_1.BackgroundColor3 = Color3.fromRGB(255, 189, 68)
    MinimizeFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeFrame_1.BorderSizePixel = 0
    MinimizeFrame_1.Position = UDim2.new(0, 412, 0, 14)
    MinimizeFrame_1.Size = UDim2.new(0, 12, 0, 12)

    UICorner_8.Parent = MinimizeFrame_1

    MinimizeButton_1.Name = "MinimizeButton"
    MinimizeButton_1.Parent = MinimizeFrame_1
    MinimizeButton_1.Active = true
    MinimizeButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton_1.BackgroundTransparency = 1
    MinimizeButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton_1.BorderSizePixel = 0
    MinimizeButton_1.Size = UDim2.new(0, 12, 0, 12)
    MinimizeButton_1.Font = Enum.Font.SourceSans
    MinimizeButton_1.Text = ""
    MinimizeButton_1.TextSize = 14

    MinimizeButton_1.MouseEnter:Connect(
        function()
            local minimizeTween1 = TweenService:Create(MinimizeFrame_1, TweenInfo.new(0.3), {Transparency = 0.3})
            minimizeTween1:Play()
        end
    )

    MinimizeButton_1.MouseLeave:Connect(
        function()
            local minimizeTween2 = TweenService:Create(MinimizeFrame_1, TweenInfo.new(0.3), {Transparency = 0})
            minimizeTween2:Play()
        end
    )

    MaximizeFrame_1.Name = "MaximizeFrame"
    MaximizeFrame_1.Parent = TopBar_1
    MaximizeFrame_1.BackgroundColor3 = Color3.fromRGB(0, 202, 78)
    MaximizeFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MaximizeFrame_1.BorderSizePixel = 0
    MaximizeFrame_1.Position = UDim2.new(0, 392, 0, 14)
    MaximizeFrame_1.Size = UDim2.new(0, 12, 0, 12)

    UICorner_9.Parent = MaximizeFrame_1

    MaximizeButton_1.Name = "MaximizeButton"
    MaximizeButton_1.Parent = MaximizeFrame_1
    MaximizeButton_1.Active = true
    MaximizeButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MaximizeButton_1.BackgroundTransparency = 1
    MaximizeButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MaximizeButton_1.BorderSizePixel = 0
    MaximizeButton_1.Size = UDim2.new(0, 12, 0, 12)
    MaximizeButton_1.Font = Enum.Font.SourceSans
    MaximizeButton_1.Text = ""
    MaximizeButton_1.TextSize = 14

    MaximizeButton_1.MouseEnter:Connect(
        function()
            local maximizeTween1 = TweenService:Create(MaximizeFrame_1, TweenInfo.new(0.3), {Transparency = 0.3})
            maximizeTween1:Play()
        end
    )

    MaximizeButton_1.MouseLeave:Connect(
        function()
            local maximizeTween2 = TweenService:Create(MaximizeFrame_1, TweenInfo.new(0.3), {Transparency = 0})
            maximizeTween2:Play()
        end
    )

    local HomeTabFrame_1 = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local HomeTabImageButton_1 = Instance.new("ImageButton")
    local UIPadding_2 = Instance.new("UIPadding")

    HomeTabFrame_1.Name = "HomeTabFrame"
    HomeTabFrame_1.Parent = TabsFrame_1
    HomeTabFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
    HomeTabFrame_1.BackgroundTransparency = 1
    HomeTabFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HomeTabFrame_1.BorderSizePixel = 0
    HomeTabFrame_1.Size = UDim2.new(0, 30, 0, 30)
    HomeTabFrame_1.LayoutOrder = -1

    UICorner_3.Parent = HomeTabFrame_1
    UICorner_3.CornerRadius = UDim.new(0, 6)

    HomeTabImageButton_1.Name = "HomeTabImageButton"
    HomeTabImageButton_1.Parent = HomeTabFrame_1
    HomeTabImageButton_1.Active = true
    HomeTabImageButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HomeTabImageButton_1.BackgroundTransparency = 1
    HomeTabImageButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    HomeTabImageButton_1.BorderSizePixel = 0
    HomeTabImageButton_1.Size = UDim2.new(0, 18, 0, 18)
    HomeTabImageButton_1.Image = "rbxassetid://123806560026440"

    UIPadding_2.Parent = HomeTabFrame_1
    UIPadding_2.PaddingLeft = UDim.new(0, 6)
    UIPadding_2.PaddingTop = UDim.new(0, 6)

    local Home_1 = Instance.new("Frame")
    local MonitorFrame_1 = Instance.new("Frame")
    local UICorner_10 = Instance.new("UICorner")
    local Monitor_1 = Instance.new("Frame")
    local ScriptHeader_1 = Instance.new("TextLabel")
    local UIPadding_6 = Instance.new("UIPadding")
    local InformationFrame_1 = Instance.new("Frame")
    local UICorner_11 = Instance.new("UICorner")
    local InformationImageFrame_1 = Instance.new("Frame")
    local UICorner_12 = Instance.new("UICorner")
    local InformationImage_1 = Instance.new("ImageLabel")
    local InformationText_1_1 = Instance.new("TextLabel")
    local UIPadding_7 = Instance.new("UIPadding")
    local InformationText_2_1 = Instance.new("TextLabel")
    local UIPadding_8 = Instance.new("UIPadding")
    local InformationText_3_1 = Instance.new("TextLabel")
    local UIPadding_9 = Instance.new("UIPadding")
    local InformationText_4_1 = Instance.new("TextLabel")
    local UIPadding_10 = Instance.new("UIPadding")
    local InformationText_5_1 = Instance.new("TextLabel")
    local UIPadding_11 = Instance.new("UIPadding")
    local StatisticsFrame_1 = Instance.new("Frame")
    local UICorner_13 = Instance.new("UICorner")
    local StatisticsImageFrame_1 = Instance.new("Frame")
    local UICorner_14 = Instance.new("UICorner")
    local StatisticsImage_1 = Instance.new("ImageLabel")
    local UICorner_15 = Instance.new("UICorner")
    local StatisticsText_1_1 = Instance.new("TextLabel")
    local UIPadding_12 = Instance.new("UIPadding")
    local StatisticsText_2_1 = Instance.new("TextLabel")
    local UIPadding_13 = Instance.new("UIPadding")
    local StatisticsText_3_1 = Instance.new("TextLabel")
    local UIPadding_14 = Instance.new("UIPadding")
    local StatisticsText_4_1 = Instance.new("TextLabel")
    local UIPadding_15 = Instance.new("UIPadding")
    local StatisticsText_5_1 = Instance.new("TextLabel")
    local UIPadding_16 = Instance.new("UIPadding")
    local ServerHeader_1 = Instance.new("TextLabel")
    local UIPadding_17 = Instance.new("UIPadding")
    local PingHeader_1 = Instance.new("TextLabel")
    local UIPadding_18 = Instance.new("UIPadding")
    local PingHeader_2 = Instance.new("TextLabel")
    local UIPadding_180 = Instance.new("UIPadding")

    Home_1.Name = "Home"
    Home_1.Parent = ElementsHolder_1
    Home_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Home_1.BackgroundTransparency = 1
    Home_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Home_1.BorderSizePixel = 0
    Home_1.Position = UDim2.new(0, 0, 0, 0)
    Home_1.Size = UDim2.new(0, 462, 0, 336)
    Home_1.ZIndex = 2

    MonitorFrame_1.Name = "MonitorFrame"
    MonitorFrame_1.Parent = Home_1
    MonitorFrame_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
    MonitorFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MonitorFrame_1.BorderSizePixel = 0
    MonitorFrame_1.Position = UDim2.new(0, 14, 0, 231)
    MonitorFrame_1.Size = UDim2.new(0, 430, 0, 86)

    UICorner_10.Parent = MonitorFrame_1

    Monitor_1.Name = "Monitor"
    Monitor_1.Parent = MonitorFrame_1
    Monitor_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
    Monitor_1.Transparency = 1
    Monitor_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Monitor_1.BorderSizePixel = 0
    Monitor_1.Position = UDim2.new(0, 10, 0, 8)
    Monitor_1.Size = UDim2.new(0, 410, 0, 72)

    local Stats = game:GetService("Stats")

    local MAX_POINTS = 50
    local UPDATE_INTERVAL = 0.2
    local MAX_PING = 400

    local FRAME_WIDTH = 410
    local FRAME_HEIGHT = 72
    local stepX = FRAME_WIDTH / (MAX_POINTS - 1)

    local pingHistory = table.create(MAX_POINTS, 0)

    local LineContainer = Instance.new("Frame")
    LineContainer.Size = UDim2.new(1, 0, 1, 0)
    LineContainer.BackgroundTransparency = 1
    LineContainer.ClipsDescendants = true
    LineContainer.Parent = Monitor_1

    local hoverTransparency = 0
    local isHovered = false

    local lines = {}
    for i = 1, MAX_POINTS - 1 do
        local line = Instance.new("Frame")
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        line.BackgroundTransparency = hoverTransparency
        line.Parent = LineContainer
        lines[i] = line
    end

    local function getPing()
        local pingString = Stats.Network.ServerStatsItem["Data Ping"]:GetValueString()
        return tonumber(pingString:match("%d+")) or 0
    end

    local function clampPing(ping)
        return math.clamp(ping, 0, MAX_PING)
    end

    MonitorFrame_1.MouseEnter:Connect(
        function()
            isHovered = true
            hoverTransparency = 0.3
            TweenService:Create(MonitorFrame_1, TweenInfo.new(0.3), {BackgroundTransparency = hoverTransparency}):Play()

            for _, line in ipairs(lines) do
                line.BackgroundTransparency = hoverTransparency
            end
        end
    )

    MonitorFrame_1.MouseLeave:Connect(
        function()
            isHovered = false
            hoverTransparency = 0
            TweenService:Create(MonitorFrame_1, TweenInfo.new(0.3), {BackgroundTransparency = hoverTransparency}):Play()

            for _, line in ipairs(lines) do
                line.BackgroundTransparency = hoverTransparency
            end
        end
    )

    task.spawn(
        function()
            while task.wait(UPDATE_INTERVAL) do
                local ping = clampPing(getPing())
                PingHeader_2.Text = string.format("<b>%dms</b>", ping)

                table.insert(pingHistory, ping)
                if #pingHistory > MAX_POINTS then
                    table.remove(pingHistory, 1)
                end

                for i = 2, #pingHistory do
                    local line = lines[i - 1]
                    if line then
                        local x1 = (i - 2) * stepX
                        local x2 = (i - 1) * stepX
                        local y1 = FRAME_HEIGHT - (pingHistory[i - 1] / MAX_PING) * FRAME_HEIGHT
                        local y2 = FRAME_HEIGHT - (pingHistory[i] / MAX_PING) * FRAME_HEIGHT

                        y1 = math.clamp(y1, 0, FRAME_HEIGHT)
                        y2 = math.clamp(y2, 0, FRAME_HEIGHT)

                        local dx, dy = x2 - x1, y2 - y1
                        local length = math.sqrt(dx * dx + dy * dy)

                        line.Size = UDim2.new(0, length, 0, 2)
                        line.Position = UDim2.new(0, (x1 + x2) / 2, 0, (y1 + y2) / 2)
                        line.Rotation = math.deg(math.atan2(dy, dx))
                        line.BackgroundTransparency = hoverTransparency
                    end
                end
            end
        end
    )

    ScriptHeader_1.Name = "ScriptHeader"
    ScriptHeader_1.Parent = Home_1
    ScriptHeader_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScriptHeader_1.BackgroundTransparency = 1
    ScriptHeader_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ScriptHeader_1.BorderSizePixel = 0
    ScriptHeader_1.Position = UDim2.new(0, 0, 0.020833334, 0)
    ScriptHeader_1.Size = UDim2.new(0, 209, 0, 40)
    ScriptHeader_1.Font = Enum.Font.Ubuntu
    ScriptHeader_1.RichText = true
    ScriptHeader_1.Text = "<b>Information</b>"
    ScriptHeader_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    ScriptHeader_1.TextSize = 16
    ScriptHeader_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_6.Parent = ScriptHeader_1
    UIPadding_6.PaddingLeft = UDim.new(0, 14)

    InformationFrame_1.Name = "InformationFrame"
    InformationFrame_1.Parent = Home_1
    InformationFrame_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
    InformationFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationFrame_1.BorderSizePixel = 0
    InformationFrame_1.Position = UDim2.new(0, 14, 0, 45)
    InformationFrame_1.Size = UDim2.new(0, 208, 0, 140)

    InformationFrame_1.MouseEnter:Connect(
        function()
            local informationTween1 = TweenService:Create(InformationFrame_1, TweenInfo.new(0.3), {Transparency = 0.3})
            informationTween1:Play()

            for _, child in ipairs(InformationFrame_1:GetDescendants()) do
                if child:IsA("TextLabel") then
                    TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 0.3}):Play()
                end
            end
        end
    )

    InformationFrame_1.MouseLeave:Connect(
        function()
            local informationTween2 = TweenService:Create(InformationFrame_1, TweenInfo.new(0.3), {Transparency = 0})
            informationTween2:Play()

            for _, child in ipairs(InformationFrame_1:GetDescendants()) do
                if child:IsA("TextLabel") then
                    TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                end
            end
        end
    )

    UICorner_11.Parent = InformationFrame_1

    InformationImageFrame_1.Name = "InformationImageFrame"
    InformationImageFrame_1.Parent = InformationFrame_1
    InformationImageFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
    InformationImageFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationImageFrame_1.BorderSizePixel = 0
    InformationImageFrame_1.Position = UDim2.new(0, 14, 0, 14)
    InformationImageFrame_1.Size = UDim2.new(0, 50, 0, 50)

    UICorner_12.Parent = InformationImageFrame_1

    InformationImage_1.Name = "InformationImage"
    InformationImage_1.Parent = InformationImageFrame_1
    InformationImage_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InformationImage_1.BackgroundTransparency = 1
    InformationImage_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationImage_1.BorderSizePixel = 0
    InformationImage_1.Position = UDim2.new(0, 5, 0, 5)
    InformationImage_1.Size = UDim2.new(0, 40, 0, 40)
    InformationImage_1.Image = "rbxassetid://92715042948482"

    InformationText_1_1.Name = "InformationText_1"
    InformationText_1_1.Parent = InformationFrame_1
    InformationText_1_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InformationText_1_1.BackgroundTransparency = 1
    InformationText_1_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationText_1_1.BorderSizePixel = 0
    InformationText_1_1.Size = UDim2.new(0, 209, 0, 40)
    InformationText_1_1.Font = Enum.Font.Ubuntu
    InformationText_1_1.RichText = true
    InformationText_1_1.Text = "<b>Velocity</b>"
    InformationText_1_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    InformationText_1_1.TextSize = 15
    InformationText_1_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_7.Parent = InformationText_1_1
    UIPadding_7.PaddingLeft = UDim.new(0, 76)
    UIPadding_7.PaddingTop = UDim.new(0, 14)

    InformationText_2_1.Name = "InformationText_2"
    InformationText_2_1.Parent = InformationFrame_1
    InformationText_2_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InformationText_2_1.BackgroundTransparency = 1
    InformationText_2_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationText_2_1.BorderSizePixel = 0
    InformationText_2_1.Size = UDim2.new(0, 209, 0, 40)
    InformationText_2_1.Font = Enum.Font.Ubuntu
    InformationText_2_1.RichText = true
    InformationText_2_1.Text = "<b>v0.0.1</b>"
    InformationText_2_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    InformationText_2_1.TextSize = 14
    InformationText_2_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_8.Parent = InformationText_2_1
    UIPadding_8.PaddingLeft = UDim.new(0, 76)
    UIPadding_8.PaddingTop = UDim.new(0, 56)

    InformationText_3_1.Name = "InformationText_3"
    InformationText_3_1.Parent = InformationFrame_1
    InformationText_3_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InformationText_3_1.BackgroundTransparency = 1
    InformationText_3_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationText_3_1.BorderSizePixel = 0
    InformationText_3_1.Size = UDim2.new(0, 209, 0, 40)
    InformationText_3_1.Font = Enum.Font.Ubuntu
    InformationText_3_1.RichText = true
    InformationText_3_1.Text = "<b>Crusader (@crvsades)</b>"
    InformationText_3_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    InformationText_3_1.TextSize = 14
    InformationText_3_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_9.Parent = InformationText_3_1
    UIPadding_9.PaddingLeft = UDim.new(0, 15)
    UIPadding_9.PaddingTop = UDim.new(0, 120)

    InformationText_4_1.Name = "InformationText_4"
    InformationText_4_1.Parent = InformationFrame_1
    InformationText_4_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InformationText_4_1.BackgroundTransparency = 1
    InformationText_4_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationText_4_1.BorderSizePixel = 0
    InformationText_4_1.Size = UDim2.new(0, 209, 0, 40)
    InformationText_4_1.Font = Enum.Font.Ubuntu
    InformationText_4_1.RichText = true
    InformationText_4_1.Text = "<b>discord.gg/byteservices</b>"
    InformationText_4_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    InformationText_4_1.TextSize = 14
    InformationText_4_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_10.Parent = InformationText_4_1
    UIPadding_10.PaddingLeft = UDim.new(0, 15)
    UIPadding_10.PaddingTop = UDim.new(0, 160)

    InformationText_5_1.Name = "InformationText_5"
    InformationText_5_1.Parent = InformationFrame_1
    InformationText_5_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    InformationText_5_1.BackgroundTransparency = 1
    InformationText_5_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    InformationText_5_1.BorderSizePixel = 0
    InformationText_5_1.Size = UDim2.new(0, 209, 0, 40)
    InformationText_5_1.Font = Enum.Font.Ubuntu
    InformationText_5_1.RichText = true
    InformationText_5_1.Text = "<b>www.byteservices.org</b>"
    InformationText_5_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    InformationText_5_1.TextSize = 14
    InformationText_5_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_11.Parent = InformationText_5_1
    UIPadding_11.PaddingLeft = UDim.new(0, 15)
    UIPadding_11.PaddingTop = UDim.new(0, 200)

    StatisticsFrame_1.Name = "StatisticsFrame"
    StatisticsFrame_1.Parent = Home_1
    StatisticsFrame_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
    StatisticsFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsFrame_1.BorderSizePixel = 0
    StatisticsFrame_1.Position = UDim2.new(0, 236, 0, 45)
    StatisticsFrame_1.Size = UDim2.new(0, 208, 0, 140)

    StatisticsFrame_1.MouseEnter:Connect(
        function()
            local statisticTween1 = TweenService:Create(StatisticsFrame_1, TweenInfo.new(0.3), {Transparency = 0.3})
            statisticTween1:Play()

            for _, child in ipairs(StatisticsFrame_1:GetDescendants()) do
                if child:IsA("TextLabel") then
                    TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 0.3}):Play()
                end
            end
        end
    )

    StatisticsFrame_1.MouseLeave:Connect(
        function()
            local statisticTween2 = TweenService:Create(StatisticsFrame_1, TweenInfo.new(0.3), {Transparency = 0})
            statisticTween2:Play()

            for _, child in ipairs(StatisticsFrame_1:GetDescendants()) do
                if child:IsA("TextLabel") then
                    TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
                end
            end
        end
    )

    UICorner_13.Parent = StatisticsFrame_1

    StatisticsImageFrame_1.Name = "StatisticsImageFrame"
    StatisticsImageFrame_1.Parent = StatisticsFrame_1
    StatisticsImageFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
    StatisticsImageFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsImageFrame_1.BorderSizePixel = 0
    StatisticsImageFrame_1.Position = UDim2.new(0, 14, 0, 14)
    StatisticsImageFrame_1.Size = UDim2.new(0, 50, 0, 50)

    UICorner_14.Parent = StatisticsImageFrame_1

    StatisticsImage_1.Name = "StatisticsImage"
    StatisticsImage_1.Parent = StatisticsImageFrame_1
    StatisticsImage_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatisticsImage_1.BackgroundTransparency = 1
    StatisticsImage_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsImage_1.BorderSizePixel = 0
    StatisticsImage_1.Size = UDim2.new(0, 50, 0, 50)
    StatisticsImage_1.Image = "rbxassetid://73794888783024"

    UICorner_15.Parent = StatisticsImage_1

    StatisticsText_1_1.Name = "StatisticsText_1"
    StatisticsText_1_1.Parent = StatisticsFrame_1
    StatisticsText_1_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatisticsText_1_1.BackgroundTransparency = 1
    StatisticsText_1_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsText_1_1.BorderSizePixel = 0
    StatisticsText_1_1.Size = UDim2.new(0, 209, 0, 40)
    StatisticsText_1_1.Font = Enum.Font.Ubuntu
    StatisticsText_1_1.RichText = true
    StatisticsText_1_1.Text = "<b>Legends Of Speed</b>"
    StatisticsText_1_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    StatisticsText_1_1.TextSize = 15
    StatisticsText_1_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_12.Parent = StatisticsText_1_1
    UIPadding_12.PaddingLeft = UDim.new(0, 76)
    UIPadding_12.PaddingTop = UDim.new(0, 14)

    StatisticsText_2_1.Name = "StatisticsText_2"
    StatisticsText_2_1.Parent = StatisticsFrame_1
    StatisticsText_2_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatisticsText_2_1.BackgroundTransparency = 1
    StatisticsText_2_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsText_2_1.BorderSizePixel = 0
    StatisticsText_2_1.Size = UDim2.new(0, 209, 0, 40)
    StatisticsText_2_1.Font = Enum.Font.Ubuntu
    StatisticsText_2_1.RichText = true
    StatisticsText_2_1.Text = "<b>4/22/2019</b>"
    StatisticsText_2_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    StatisticsText_2_1.TextSize = 14
    StatisticsText_2_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_13.Parent = StatisticsText_2_1
    UIPadding_13.PaddingLeft = UDim.new(0, 76)
    UIPadding_13.PaddingTop = UDim.new(0, 56)

    StatisticsText_3_1.Name = "StatisticsText_3"
    StatisticsText_3_1.Parent = StatisticsFrame_1
    StatisticsText_3_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatisticsText_3_1.BackgroundTransparency = 1
    StatisticsText_3_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsText_3_1.BorderSizePixel = 0
    StatisticsText_3_1.Size = UDim2.new(0, 209, 0, 40)
    StatisticsText_3_1.Font = Enum.Font.Ubuntu
    StatisticsText_3_1.RichText = true
    StatisticsText_3_1.Text = "<b>Scriptbloxian Studios</b>"
    StatisticsText_3_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    StatisticsText_3_1.TextSize = 14
    StatisticsText_3_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_14.Parent = StatisticsText_3_1
    UIPadding_14.PaddingLeft = UDim.new(0, 15)
    UIPadding_14.PaddingTop = UDim.new(0, 120)

    StatisticsText_4_1.Name = "StatisticsText_4"
    StatisticsText_4_1.Parent = StatisticsFrame_1
    StatisticsText_4_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatisticsText_4_1.BackgroundTransparency = 1
    StatisticsText_4_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsText_4_1.BorderSizePixel = 0
    StatisticsText_4_1.Size = UDim2.new(0, 209, 0, 40)
    StatisticsText_4_1.Font = Enum.Font.Ubuntu
    StatisticsText_4_1.RichText = true
    StatisticsText_4_1.Text = "<b>Incremental Simulator</b>"
    StatisticsText_4_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    StatisticsText_4_1.TextSize = 14
    StatisticsText_4_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_15.Parent = StatisticsText_4_1
    UIPadding_15.PaddingLeft = UDim.new(0, 15)
    UIPadding_15.PaddingTop = UDim.new(0, 160)

    StatisticsText_5_1.Name = "StatisticsText_5"
    StatisticsText_5_1.Parent = StatisticsFrame_1
    StatisticsText_5_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    StatisticsText_5_1.BackgroundTransparency = 1
    StatisticsText_5_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    StatisticsText_5_1.BorderSizePixel = 0
    StatisticsText_5_1.Size = UDim2.new(0, 209, 0, 40)
    StatisticsText_5_1.Font = Enum.Font.Ubuntu
    StatisticsText_5_1.RichText = true
    StatisticsText_5_1.Text = "<b>3101667897</b>"
    StatisticsText_5_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    StatisticsText_5_1.TextSize = 14
    StatisticsText_5_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_16.Parent = StatisticsText_5_1
    UIPadding_16.PaddingLeft = UDim.new(0, 15)
    UIPadding_16.PaddingTop = UDim.new(0, 200)

    ServerHeader_1.Name = "ServerHeader"
    ServerHeader_1.Parent = Home_1
    ServerHeader_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ServerHeader_1.BackgroundTransparency = 1
    ServerHeader_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ServerHeader_1.BorderSizePixel = 0
    ServerHeader_1.Position = UDim2.new(0, 223, 0.0209999997, 0)
    ServerHeader_1.Size = UDim2.new(0, 209, 0, 40)
    ServerHeader_1.Font = Enum.Font.Ubuntu
    ServerHeader_1.RichText = true
    ServerHeader_1.Text = "<b>Experience</b>"
    ServerHeader_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    ServerHeader_1.TextSize = 16
    ServerHeader_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_17.Parent = ServerHeader_1
    UIPadding_17.PaddingLeft = UDim.new(0, 14)

    PingHeader_1.Name = "PingHeader"
    PingHeader_1.Parent = Home_1
    PingHeader_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PingHeader_1.BackgroundTransparency = 1
    PingHeader_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PingHeader_1.BorderSizePixel = 0
    PingHeader_1.Position = UDim2.new(0, 0, 0, 194)
    PingHeader_1.Size = UDim2.new(0, 209, 0, 40)
    PingHeader_1.Font = Enum.Font.Ubuntu
    PingHeader_1.RichText = true
    PingHeader_1.Text = "<b>Monitor</b>"
    PingHeader_1.TextColor3 = Color3.fromRGB(220, 220, 220)
    PingHeader_1.TextSize = 16
    PingHeader_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_18.Parent = PingHeader_1
    UIPadding_18.PaddingLeft = UDim.new(0, 14)

    PingHeader_2.Name = "PingHeader2"
    PingHeader_2.Parent = Home_1
    PingHeader_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PingHeader_2.BackgroundTransparency = 1
    PingHeader_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    PingHeader_2.BorderSizePixel = 0
    PingHeader_2.Position = UDim2.new(0, 234, 0, 194)
    PingHeader_2.Size = UDim2.new(0, 209, 0, 40)
    PingHeader_2.Font = Enum.Font.Ubuntu
    PingHeader_2.RichText = true
    PingHeader_2.Text = "<b>PING HERE</b>"
    PingHeader_2.TextColor3 = Color3.fromRGB(220, 220, 220)
    PingHeader_2.TextSize = 16
    PingHeader_2.TextXAlignment = Enum.TextXAlignment.Right

    UIPadding_180.Parent = PingHeader_2
    UIPadding_180.PaddingLeft = UDim.new(0, 14)

    local dragging
    local dragInput
    local dragStart
    local startPos

    function Lerp(a, b, m)
        return a + (b - a) * m
    end

    local lastMousePos
    local lastGoalPos
    local DRAG_SPEED = 5

    function Update(dt)
        if not startPos then
            return
        end

        if not dragging and lastGoalPos then
            Main_1.Position =
                UDim2.new(
                startPos.X.Scale,
                Lerp(Main_1.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED),
                startPos.Y.Scale,
                Lerp(Main_1.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED)
            )
            return
        end

        local delta = lastMousePos - UserInputService:GetMouseLocation()
        local xGoal = startPos.X.Offset - delta.X
        local yGoal = startPos.Y.Offset - delta.Y
        lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)

        Main_1.Position =
            UDim2.new(
            startPos.X.Scale,
            Lerp(Main_1.Position.X.Offset, xGoal, dt * DRAG_SPEED),
            startPos.Y.Scale,
            Lerp(Main_1.Position.Y.Offset, yGoal, dt * DRAG_SPEED)
        )
    end

    Main_1.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Main_1.Position
                lastMousePos = UserInputService:GetMouseLocation()

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end
                )
            end
        end
    )

    Main_1.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                dragInput = input
            end
        end
    )

    RunService.Heartbeat:Connect(Update)

    UserInputService.InputBegan:Connect(
        function(input, gameProcessed)
            if not gameProcessed then
                if input.KeyCode == Enum.KeyCode.LeftAlt then
                    Library.Enabled = not Library.Enabled
                end
            end
        end
    )

    UIToggler_1.Name = "UIToggler"
    UIToggler_1.Parent = Main_1
    UIToggler_1.Active = true
    UIToggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UIToggler_1.BackgroundTransparency = 1
    UIToggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UIToggler_1.BorderSizePixel = 0
    UIToggler_1.Position = UDim2.new(0, 0, 0, 0)
    UIToggler_1.Size = UDim2.new(0, 31, 0, 31)
    UIToggler_1.Image = "rbxassetid://92715042948482"
    UIToggler_1.Visible = false
    UIToggler_1.ImageTransparency = 0

    MinimizeButton_1.MouseButton1Click:Connect(
        function()
            dragging = false
            lastGoalPos = nil
            startPos = nil

            ElementsHolder_1.Visible = false
            SideBar_1.Visible = false
            TopBar_1.Visible = false

            local targetSize = UDim2.new(0, 30, 0, 30)
            local targetPosition = UDim2.new(0.5, -10, 0, 20)

            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
            local tweenUI =
                TweenService:Create(
                Main_1,
                tweenInfo,
                {
                    Size = targetSize,
                    Position = targetPosition
                }
            )

            MainBackground_1.Visible = false

            tweenUI.Completed:Connect(
                function()
                    UIToggler_1.Visible = true
                end
            )

            tweenUI:Play()
        end
    )

    CloseButton_1.MouseButton1Click:Connect(
        function()
            dragging = false
            lastGoalPos = nil
            startPos = nil

            ElementsHolder_1.Visible = false
            SideBar_1.Visible = false
            TopBar_1.Visible = false

            local targetSize = UDim2.new(0, 0, 0, 0)
            local targetPosition = UDim2.new(0.5, -10, 0, 50)

            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
            local tweenUI =
                TweenService:Create(
                Main_1,
                tweenInfo,
                {
                    Size = targetSize,
                    Position = targetPosition
                }
            )

            MainBackground_1.Visible = false

            tweenUI.Completed:Connect(
                function()
                    game.CoreGui:FindFirstChild("VelocityLibrary"):Destroy()
                end
            )

            tweenUI:Play()
        end
    )

    UIToggler_1.MouseEnter:Connect(
        function()
            local uiToggleTween1 = TweenService:Create(UIToggler_1, TweenInfo.new(0.3), {ImageTransparency = 0.3})
            uiToggleTween1:Play()
        end
    )

    UIToggler_1.MouseLeave:Connect(
        function()
            local uiToggleTween2 = TweenService:Create(UIToggler_1, TweenInfo.new(0.3), {ImageTransparency = 0})
            uiToggleTween2:Play()
        end
    )

    UIToggler_1.MouseButton1Click:Connect(
        function()
            dragging = false
            lastGoalPos = nil
            startPos = nil

            UIToggler_1.Visible = false

            local targetSize = UDim2.new(0, 520, 0, 380)
            local targetPosition = UDim2.new(0.5, -260, 0.5, -190)

            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
            local tweenUI2 =
                TweenService:Create(
                Main_1,
                tweenInfo,
                {
                    Size = targetSize,
                    Position = targetPosition
                }
            )

            MainBackground_1.Visible = true

            tweenUI2.Completed:Connect(
                function()
                    ElementsHolder_1.Visible = true
                    SideBar_1.Visible = true
                    TopBar_1.Visible = true
                end
            )

            tweenUI2:Play()
        end
    )

    local Tabs = {}
    local first = true
    local currentTab = nil
    local currentTabIndicator = nil
    local currentElements = nil

    function Tabs:CreateTab(Icon)
        local TabFrame_1 = Instance.new("Frame")
        local UICorner_4 = Instance.new("UICorner")
        local TabImageButton_1 = Instance.new("ImageButton")
        local UIPadding_3 = Instance.new("UIPadding")

        TabFrame_1.Name = "TabFrame"
        TabFrame_1.Parent = TabsFrame_1
        TabFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
        TabFrame_1.BackgroundTransparency = 1
        TabFrame_1.BorderSizePixel = 0
        TabFrame_1.Size = UDim2.new(0, 30, 0, 30)

        UICorner_4.Parent = TabFrame_1
        UICorner_4.CornerRadius = UDim.new(0, 6)

        TabImageButton_1.Name = "TabImageButton"
        TabImageButton_1.Parent = TabFrame_1
        TabImageButton_1.Active = true
        TabImageButton_1.BackgroundTransparency = 1
        TabImageButton_1.Size = UDim2.new(0, 18, 0, 18)
        TabImageButton_1.Image = "rbxassetid://" .. Icon

        UIPadding_3.Parent = TabFrame_1
        UIPadding_3.PaddingLeft = UDim.new(0, 6)
        UIPadding_3.PaddingTop = UDim.new(0, 6)

        local Elements_1 = Instance.new("Frame")
        local Items_1 = Instance.new("ScrollingFrame")
        local UIPadding_19 = Instance.new("UIPadding")
        local UIListLayout_2 = Instance.new("UIListLayout")

        Elements_1.Name = "Elements"
        Elements_1.Parent = ElementsHolder_1
        Elements_1.BackgroundTransparency = 1
        Elements_1.Size = UDim2.new(0, 462, 0, 336)
        Elements_1.Visible = false
        Elements_1.Position = UDim2.new(0, 0, 0, 0)

        Items_1.Name = "Items"
        Items_1.Parent = Elements_1
        Items_1.Active = true
        Items_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Items_1.BackgroundTransparency = 1
        Items_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Items_1.BorderSizePixel = 0
        Items_1.Position = UDim2.new(0, 0, 0.0148809524, 0)
        Items_1.Size = UDim2.new(0, 462, 0, 327)
        Items_1.ClipsDescendants = true
        Items_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Items_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
        Items_1.CanvasPosition = Vector2.new(0, 0)
        Items_1.CanvasSize = UDim2.new(0, 0, 0, 0)
        Items_1.ElasticBehavior = Enum.ElasticBehavior.Never
        Items_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
        Items_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
        Items_1.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
        Items_1.ScrollBarImageTransparency = 1
        Items_1.ScrollBarThickness = 1
        Items_1.ScrollingDirection = Enum.ScrollingDirection.Y
        Items_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
        Items_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
        Items_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

        UIPadding_19.Parent = Items_1
        UIPadding_19.PaddingBottom = UDim.new(0, 14)
        UIPadding_19.PaddingLeft = UDim.new(0, 14)
        UIPadding_19.PaddingTop = UDim.new(0, 6)

        UIListLayout_2.Parent = Items_1
        UIListLayout_2.Padding = UDim.new(0, 8)
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

        if first then
            first = false
            Elements_1.Visible = false
            Home_1.Visible = true
            currentTab = HomeTabImageButton_1
            currentTabIndicator = HomeTabFrame_1
            currentElements = Home_1
            HomeTabFrame_1.BackgroundTransparency = 0
        else
            Elements_1.Visible = false
        end

        local function slideTo(newFrame)
            if currentElements == newFrame then
                return
            end
            if not currentElements then
                newFrame.Visible = true
                currentElements = newFrame
                return
            end

            local slideOutDir = UDim2.new(-1, 0, 0, 0)
            local slideInStart = UDim2.new(1, 0, 0, 0)

            local newIndex = table.find(ElementsHolder_1:GetChildren(), newFrame)
            local oldIndex = table.find(ElementsHolder_1:GetChildren(), currentElements)
            if newIndex and oldIndex and newIndex < oldIndex then
                slideOutDir = UDim2.new(1, 0, 0, 0)
                slideInStart = UDim2.new(-1, 0, 0, 0)
            end

            newFrame.Position = slideInStart
            newFrame.Visible = true

            local slideOut =
                TweenService:Create(
                currentElements,
                TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Position = slideOutDir, BackgroundTransparency = 1}
            )
            local slideIn =
                TweenService:Create(
                newFrame,
                TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
                {Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}
            )

            slideOut:Play()
            slideIn:Play()

            slideOut.Completed:Connect(
                function()
                    currentElements.Visible = false
                    currentElements.Position = UDim2.new(0, 0, 0, 0)
                    currentElements = newFrame
                end
            )
        end

        HomeTabImageButton_1.MouseButton1Click:Connect(
            function()
                if currentTab == HomeTabImageButton_1 then
                    return
                end

                if currentTabIndicator then
                    local deactivateTween =
                        TweenService:Create(currentTabIndicator, TweenInfo.new(0.3), {BackgroundTransparency = 1})
                    deactivateTween:Play()
                end

                local activateTween =
                    TweenService:Create(HomeTabFrame_1, TweenInfo.new(0.3), {BackgroundTransparency = 0})
                activateTween:Play()

                currentTab = HomeTabImageButton_1
                currentTabIndicator = HomeTabFrame_1

                slideTo(Home_1)
            end
        )

        HomeTabImageButton_1.MouseEnter:Connect(
            function()
                local homeTabTween =
                    TweenService:Create(HomeTabImageButton_1, TweenInfo.new(0.2), {ImageTransparency = 0.3})
                homeTabTween:Play()
            end
        )

        HomeTabImageButton_1.MouseLeave:Connect(
            function()
                local homeTabTween2 =
                    TweenService:Create(HomeTabImageButton_1, TweenInfo.new(0.3), {ImageTransparency = 0})
                homeTabTween2:Play()
            end
        )

        TabImageButton_1.MouseButton1Click:Connect(
            function()
                if currentTab == TabImageButton_1 then
                    return
                end

                if currentTabIndicator then
                    local deactivateTween =
                        TweenService:Create(currentTabIndicator, TweenInfo.new(0.3), {BackgroundTransparency = 1})
                    deactivateTween:Play()
                end

                local activateTween = TweenService:Create(TabFrame_1, TweenInfo.new(0.3), {BackgroundTransparency = 0})
                activateTween:Play()

                currentTab = TabImageButton_1
                currentTabIndicator = TabFrame_1

                slideTo(Elements_1)
            end
        )

        TabImageButton_1.MouseEnter:Connect(
            function()
                local normalTabTween =
                    TweenService:Create(TabImageButton_1, TweenInfo.new(0.2), {ImageTransparency = 0.3})
                normalTabTween:Play()
            end
        )

        TabImageButton_1.MouseLeave:Connect(
            function()
                local normalTabTween2 =
                    TweenService:Create(TabImageButton_1, TweenInfo.new(0.3), {ImageTransparency = 0})
                normalTabTween2:Play()
            end
        )

        local Elements = {}

        function Elements:CreateSection(Title)
            local Section_1 = Instance.new("Frame")
            local SectionTitle_1 = Instance.new("TextLabel")

            Section_1.Name = "Section"
            Section_1.Parent = Items_1
            Section_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Section_1.BackgroundTransparency = 1
            Section_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Section_1.BorderSizePixel = 0
            Section_1.Size = UDim2.new(0, 428, 0, 30)

            SectionTitle_1.Name = "SectionTitle"
            SectionTitle_1.Parent = Section_1
            SectionTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle_1.BackgroundTransparency = 1
            SectionTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionTitle_1.BorderSizePixel = 0
            SectionTitle_1.Position = UDim2.new(0, 0, 0.020833334, 0)
            SectionTitle_1.Size = UDim2.new(0, 428, 0, 30)
            SectionTitle_1.Font = Enum.Font.Ubuntu
            SectionTitle_1.RichText = true
            SectionTitle_1.Text = "<b>" .. Title .. "</b>"
            SectionTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            SectionTitle_1.TextSize = 16
            SectionTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
            SectionTitle_1.TextXAlignment = Enum.TextXAlignment.Left
        end

        function Elements:CreateLabel(Title)
            local Label_1 = Instance.new("Frame")
            local UICorner_26 = Instance.new("UICorner")
            local LabelTitle_1 = Instance.new("TextLabel")
            local UIPadding_28 = Instance.new("UIPadding")

            Label_1.Name = "Label"
            Label_1.Parent = Items_1
            Label_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            Label_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Label_1.BorderSizePixel = 0
            Label_1.Size = UDim2.new(0, 428, 0, 30)

            UICorner_26.Parent = Label_1

            LabelTitle_1.Name = "LabelTitle"
            LabelTitle_1.Parent = Label_1
            LabelTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle_1.BackgroundTransparency = 1
            LabelTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelTitle_1.BorderSizePixel = 0
            LabelTitle_1.Position = UDim2.new(0, 0, 0.020833334, 0)
            LabelTitle_1.Size = UDim2.new(0, 428, 0, 30)
            LabelTitle_1.Font = Enum.Font.Ubuntu
            LabelTitle_1.RichText = true
            LabelTitle_1.Text = "<b>" .. Title .. "</b>"
            LabelTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            LabelTitle_1.TextSize = 14
            LabelTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
            LabelTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_28.Parent = LabelTitle_1
            UIPadding_28.PaddingLeft = UDim.new(0, 14)

            Label_1.MouseEnter:Connect(
                function()
                    local labelTween1 = TweenService:Create(Label_1, TweenInfo.new(0.3), {Transparency = 0.3})
                    labelTween1:Play()
                end
            )

            Label_1.MouseLeave:Connect(
                function()
                    local labelTween2 = TweenService:Create(Label_1, TweenInfo.new(0.3), {Transparency = 0})
                    labelTween2:Play()
                end
            )

            LabelTitle_1.MouseEnter:Connect(
                function()
                    local labelTween3 = TweenService:Create(LabelTitle_1, TweenInfo.new(0.2), {TextTransparency = 0.3})
                    labelTween3:Play()
                end
            )

            LabelTitle_1.MouseLeave:Connect(
                function()
                    local labelTween4 = TweenService:Create(LabelTitle_1, TweenInfo.new(0.3), {TextTransparency = 0})
                    labelTween4:Play()
                end
            )

            local dynamicLabel = {}
            dynamicLabel.SetText = function(newText)
                LabelTitle_1.Text = "<b>" .. newText .. "</b>"
            end
            return dynamicLabel
        end

        function Elements:CreateButton(Title, Callback)
            local Button_1 = Instance.new("Frame")
            local UICorner_16 = Instance.new("UICorner")
            local ButtonTitle_1 = Instance.new("TextButton")
            local UIPadding_20 = Instance.new("UIPadding")
            local ButtonIndicator_1 = Instance.new("TextLabel")
            local UIPadding_21 = Instance.new("UIPadding")

            Button_1.Name = "Button"
            Button_1.Parent = Items_1
            Button_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            Button_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Button_1.BorderSizePixel = 0
            Button_1.Size = UDim2.new(0, 428, 0, 40)

            UICorner_16.Parent = Button_1

            ButtonTitle_1.Name = "ButtonTitle"
            ButtonTitle_1.Parent = Button_1
            ButtonTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle_1.BackgroundTransparency = 1
            ButtonTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ButtonTitle_1.BorderSizePixel = 0
            ButtonTitle_1.Position = UDim2.new(0, 0, 0.020833334, 0)
            ButtonTitle_1.Size = UDim2.new(0, 428, 0, 40)
            ButtonTitle_1.Font = Enum.Font.Ubuntu
            ButtonTitle_1.RichText = true
            ButtonTitle_1.Text = "<b>" .. Title .. "</b>"
            ButtonTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            ButtonTitle_1.TextSize = 16
            ButtonTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
            ButtonTitle_1.TextXAlignment = Enum.TextXAlignment.Left
            ButtonTitle_1.TextTransparency = 0

            UIPadding_20.Parent = ButtonTitle_1
            UIPadding_20.PaddingLeft = UDim.new(0, 14)

            ButtonIndicator_1.Name = "ButtonIndicator"
            ButtonIndicator_1.Parent = Button_1
            ButtonIndicator_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonIndicator_1.BackgroundTransparency = 1
            ButtonIndicator_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ButtonIndicator_1.BorderSizePixel = 0
            ButtonIndicator_1.Position = UDim2.new(0.81775701, 0, 0.0208335873, 0)
            ButtonIndicator_1.Size = UDim2.new(0, 78, 0, 40)
            ButtonIndicator_1.Font = Enum.Font.Ubuntu
            ButtonIndicator_1.RichText = true
            ButtonIndicator_1.Text = "<b>Clicked</b>"
            ButtonIndicator_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            ButtonIndicator_1.TextSize = 14
            ButtonIndicator_1.TextTruncate = Enum.TextTruncate.SplitWord
            ButtonIndicator_1.TextXAlignment = Enum.TextXAlignment.Right
            ButtonIndicator_1.TextTransparency = 1

            UIPadding_21.Parent = ButtonIndicator_1
            UIPadding_21.PaddingRight = UDim.new(0, 12)

            Button_1.MouseEnter:Connect(
                function()
                    local buttonTween5 = TweenService:Create(Button_1, TweenInfo.new(0.5), {Transparency = 0.3})
                    buttonTween5:Play()
                end
            )

            Button_1.MouseLeave:Connect(
                function()
                    local buttonTween6 = TweenService:Create(Button_1, TweenInfo.new(0.3), {Transparency = 0})
                    buttonTween6:Play()
                end
            )

            ButtonTitle_1.MouseEnter:Connect(
                function()
                    local buttonTween = TweenService:Create(ButtonTitle_1, TweenInfo.new(0.2), {TextTransparency = 0.3})
                    buttonTween:Play()
                end
            )

            ButtonTitle_1.MouseLeave:Connect(
                function()
                    local buttonTween2 = TweenService:Create(ButtonTitle_1, TweenInfo.new(0.3), {TextTransparency = 0})
                    buttonTween2:Play()
                end
            )

            ButtonTitle_1.MouseButton1Click:Connect(
                function()
                    local buttonTween3 =
                        TweenService:Create(ButtonIndicator_1, TweenInfo.new(0.2), {TextTransparency = 0.3})
                    buttonTween3:Play()

                    buttonTween3.Completed:Connect(
                        function()
                            task.wait(0.3)
                            local buttonTween4 =
                                TweenService:Create(ButtonIndicator_1, TweenInfo.new(0.3), {TextTransparency = 1})
                            buttonTween4:Play()
                        end
                    )

                    Callback()
                end
            )
        end

        function Elements:CreateBox(Title, Callback)
            local Box_1 = Instance.new("Frame")
            local UICorner_24 = Instance.new("UICorner")
            local BoxTitle_1 = Instance.new("TextLabel")
            local UIPadding_26 = Instance.new("UIPadding")
            local TextBoxFrame_1 = Instance.new("Frame")
            local UICorner_25 = Instance.new("UICorner")
            local TextBox_1 = Instance.new("TextBox")
            local UIPadding_27 = Instance.new("UIPadding")

            Box_1.Name = "Box"
            Box_1.Parent = Items_1
            Box_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            Box_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box_1.BorderSizePixel = 0
            Box_1.Size = UDim2.new(0, 428, 0, 40)

            UICorner_24.Parent = Box_1

            BoxTitle_1.Name = "BoxTitle"
            BoxTitle_1.Parent = Box_1
            BoxTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BoxTitle_1.BackgroundTransparency = 1
            BoxTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            BoxTitle_1.BorderSizePixel = 0
            BoxTitle_1.Position = UDim2.new(0, 0, 0.0208335873, 0)
            BoxTitle_1.Size = UDim2.new(0, 428, 0, 40)
            BoxTitle_1.Font = Enum.Font.Ubuntu
            BoxTitle_1.RichText = true
            BoxTitle_1.Text = "<b>" .. Title .. "</b>"
            BoxTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            BoxTitle_1.TextSize = 16
            BoxTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
            BoxTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_26.Parent = BoxTitle_1
            UIPadding_26.PaddingLeft = UDim.new(0, 14)

            TextBoxFrame_1.Name = "TextBoxFrame"
            TextBoxFrame_1.Parent = Box_1
            TextBoxFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
            TextBoxFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxFrame_1.BorderSizePixel = 0
            TextBoxFrame_1.Position = UDim2.new(0, 300, 0, 8)
            TextBoxFrame_1.Size = UDim2.new(0, 118, 0, 26)

            UICorner_25.Parent = TextBoxFrame_1
            UICorner_25.CornerRadius = UDim.new(0, 6)

            TextBox_1.Parent = TextBoxFrame_1
            TextBox_1.Active = true
            TextBox_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_1.BackgroundTransparency = 1
            TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_1.BorderSizePixel = 0
            TextBox_1.Size = UDim2.new(0, 118, 0, 26)
            TextBox_1.Font = Enum.Font.Ubuntu
            TextBox_1.PlaceholderColor3 = Color3.fromRGB(220, 220, 220)
            TextBox_1.PlaceholderText = ""
            TextBox_1.Text = ""
            TextBox_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            TextBox_1.TextSize = 14
            TextBox_1.TextTruncate = Enum.TextTruncate.SplitWord
            TextBox_1.ZIndex = 2

            UIPadding_27.Parent = TextBox_1
            UIPadding_27.PaddingLeft = UDim.new(0, 6)
            UIPadding_27.PaddingRight = UDim.new(0, 6)

            Box_1.MouseEnter:Connect(
                function()
                    local boxTween5 = TweenService:Create(Box_1, TweenInfo.new(0.3), {Transparency = 0.3})
                    boxTween5:Play()
                end
            )

            Box_1.MouseLeave:Connect(
                function()
                    local boxTween6 = TweenService:Create(Box_1, TweenInfo.new(0.3), {Transparency = 0})
                    boxTween6:Play()
                end
            )

            BoxTitle_1.MouseEnter:Connect(
                function()
                    local boxTween = TweenService:Create(BoxTitle_1, TweenInfo.new(0.2), {TextTransparency = 0.3})
                    boxTween:Play()
                end
            )

            BoxTitle_1.MouseLeave:Connect(
                function()
                    local boxTween2 = TweenService:Create(BoxTitle_1, TweenInfo.new(0.3), {TextTransparency = 0})
                    boxTween2:Play()
                end
            )

            TextBox_1.FocusLost:Connect(
                function()
                    Callback(TextBox_1.Text)
                end
            )
        end

        function Elements:CreateToggle(Title, Callback)
            Callback = Callback or function()
                end

            local toggled = false
            local debounce = false

            local Toggle_1 = Instance.new("Frame")
            local UICorner_18 = Instance.new("UICorner")
            local ToggleTitle_1 = Instance.new("TextLabel")
            local UIPadding_24 = Instance.new("UIPadding")
            local TogglerFrame_1 = Instance.new("Frame")
            local UICorner_19 = Instance.new("UICorner")
            local TogglerIndicator_1 = Instance.new("ImageLabel")
            local UICorner_20 = Instance.new("UICorner")
            local TogglerButton_1 = Instance.new("TextButton")

            Toggle_1.Name = "Toggle"
            Toggle_1.Parent = Items_1
            Toggle_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            Toggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle_1.BorderSizePixel = 0
            Toggle_1.Size = UDim2.new(0, 428, 0, 40)

            UICorner_18.Parent = Toggle_1

            ToggleTitle_1.Name = "ToggleTitle"
            ToggleTitle_1.Parent = Toggle_1
            ToggleTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle_1.BackgroundTransparency = 1
            ToggleTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleTitle_1.BorderSizePixel = 0
            ToggleTitle_1.Position = UDim2.new(0, 0, 0.0208335873, 0)
            ToggleTitle_1.Size = UDim2.new(0, 428, 0, 40)
            ToggleTitle_1.Font = Enum.Font.Ubuntu
            ToggleTitle_1.RichText = true
            ToggleTitle_1.Text = "<b>" .. Title .. "</b>"
            ToggleTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            ToggleTitle_1.TextSize = 16
            ToggleTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
            ToggleTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_24.Parent = ToggleTitle_1
            UIPadding_24.PaddingLeft = UDim.new(0, 14)

            TogglerFrame_1.Name = "TogglerFrame"
            TogglerFrame_1.Parent = Toggle_1
            TogglerFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
            TogglerFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TogglerFrame_1.BorderSizePixel = 0
            TogglerFrame_1.Position = UDim2.new(0, 392, 0, 8)
            TogglerFrame_1.Size = UDim2.new(0, 26, 0, 26)
            TogglerFrame_1.ZIndex = 2

            UICorner_19.Parent = TogglerFrame_1
            UICorner_19.CornerRadius = UDim.new(0, 6)

            TogglerIndicator_1.Name = "TogglerIndicator"
            TogglerIndicator_1.Parent = TogglerFrame_1
            TogglerIndicator_1.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            TogglerIndicator_1.BackgroundTransparency = 1
            TogglerIndicator_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TogglerIndicator_1.BorderSizePixel = 0
            TogglerIndicator_1.Position = UDim2.new(0, 1, 0, 1)
            TogglerIndicator_1.Size = UDim2.new(0, 24, 0, 24)
            TogglerIndicator_1.Image = "rbxassetid://92715042948482"
            TogglerIndicator_1.ImageTransparency = 1
            TogglerIndicator_1.ZIndex = 2

            UICorner_20.Parent = TogglerIndicator_1
            UICorner_20.CornerRadius = UDim.new(0, 6)

            TogglerButton_1.Name = "TogglerButton"
            TogglerButton_1.Parent = TogglerFrame_1
            TogglerButton_1.Active = true
            TogglerButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TogglerButton_1.BackgroundTransparency = 1
            TogglerButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TogglerButton_1.BorderSizePixel = 0
            TogglerButton_1.Size = UDim2.new(0, 26, 0, 26)
            TogglerButton_1.Font = Enum.Font.SourceSans
            TogglerButton_1.Text = ""
            TogglerButton_1.TextSize = 14
            TogglerButton_1.ZIndex = 2

            Toggle_1.MouseEnter:Connect(
                function()
                    local toggleTween5 = TweenService:Create(Toggle_1, TweenInfo.new(0.3), {Transparency = 0.3})
                    toggleTween5:Play()
                end
            )

            Toggle_1.MouseLeave:Connect(
                function()
                    local toggleTween6 = TweenService:Create(Toggle_1, TweenInfo.new(0.3), {Transparency = 0})
                    toggleTween6:Play()
                end
            )

            ToggleTitle_1.MouseEnter:Connect(
                function()
                    local toggleTween = TweenService:Create(ToggleTitle_1, TweenInfo.new(0.2), {TextTransparency = 0.3})
                    toggleTween:Play()
                end
            )

            ToggleTitle_1.MouseLeave:Connect(
                function()
                    local toggleTween2 = TweenService:Create(ToggleTitle_1, TweenInfo.new(0.3), {TextTransparency = 0})
                    toggleTween2:Play()
                end
            )

            TogglerButton_1.MouseButton1Click:Connect(
                function()
                    if debounce == false then
                        if toggled == false then
                            debounce = true
                            local onTween =
                                TweenService:Create(TogglerIndicator_1, TweenInfo.new(0.2), {ImageTransparency = 0})
                            onTween:Play()
                            debounce = false
                            toggled = true
                            pcall(Callback, toggled)
                        elseif toggled == true then
                            debounce = true
                            local offTween =
                                TweenService:Create(TogglerIndicator_1, TweenInfo.new(0.2), {ImageTransparency = 1})
                            offTween:Play()
                            debounce = false
                            toggled = false
                            pcall(Callback, toggled)
                        end
                    end
                end
            )
        end

        function Elements:CreateDropdown(Title, Options, Callback)
            local Dropdown_1 = Instance.new("Frame")
            local UICorner_27 = Instance.new("UICorner")
            local A_Dropdown_1 = Instance.new("Frame")
            local UICorner_28 = Instance.new("UICorner")
            local DropdownTitle_1 = Instance.new("TextLabel")
            local UIPadding_29 = Instance.new("UIPadding")
            local DropdownSelectionFrame_1 = Instance.new("Frame")
            local UICorner_29 = Instance.new("UICorner")
            local DropdownToggler_1 = Instance.new("ImageButton")
            local UICorner_30 = Instance.new("UICorner")
            local DropdownSelection_1 = Instance.new("TextLabel")
            local UIPadding_30 = Instance.new("UIPadding")
            local UIListLayout_3 = Instance.new("UIListLayout")
            local B_Dropdown_1 = Instance.new("Frame")
            local UIListLayout_4 = Instance.new("UIListLayout")
            local UIPadding_31 = Instance.new("UIPadding")

            local DropdownOptionFrame_2 = Instance.new("Frame")
            local UICorner_32 = Instance.new("UICorner")
            local OptionFrameButton_2 = Instance.new("TextButton")
            local UIPadding_33 = Instance.new("UIPadding")

            Dropdown_1.Name = "Dropdown"
            Dropdown_1.Parent = Items_1
            Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            Dropdown_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown_1.BorderSizePixel = 0
            Dropdown_1.Size = UDim2.new(0, 428, 0, 40)

            UICorner_27.Parent = Dropdown_1

            A_Dropdown_1.Name = "A_Dropdown"
            A_Dropdown_1.Parent = Dropdown_1
            A_Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            A_Dropdown_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            A_Dropdown_1.BackgroundTransparency = 1
            A_Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            A_Dropdown_1.BorderSizePixel = 0
            A_Dropdown_1.Size = UDim2.new(0, 428, 0, 40)

            UICorner_28.Parent = A_Dropdown_1

            DropdownTitle_1.Name = "DropdownTitle"
            DropdownTitle_1.Parent = A_Dropdown_1
            DropdownTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle_1.BackgroundTransparency = 1
            DropdownTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownTitle_1.BorderSizePixel = 0
            DropdownTitle_1.Position = UDim2.new(0, 0, 0.020834351, 0)
            DropdownTitle_1.Size = UDim2.new(0, 251, 0, 40)
            DropdownTitle_1.Font = Enum.Font.Ubuntu
            DropdownTitle_1.RichText = true
            DropdownTitle_1.Text = "<b>" .. Title .. "</b>"
            DropdownTitle_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            DropdownTitle_1.TextSize = 16
            DropdownTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
            DropdownTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_29.Parent = DropdownTitle_1
            UIPadding_29.PaddingLeft = UDim.new(0, 14)

            DropdownSelectionFrame_1.Name = "DropdownSelectionFrame"
            DropdownSelectionFrame_1.Parent = A_Dropdown_1
            DropdownSelectionFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
            DropdownSelectionFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownSelectionFrame_1.BorderSizePixel = 0
            DropdownSelectionFrame_1.Position = UDim2.new(0, 251, 0, 8)
            DropdownSelectionFrame_1.Size = UDim2.new(0, 167, 0, 26)

            UICorner_29.Parent = DropdownSelectionFrame_1
            UICorner_29.CornerRadius = UDim.new(0, 6)

            DropdownToggler_1.Name = "DropdownToggler"
            DropdownToggler_1.Parent = DropdownSelectionFrame_1
            DropdownToggler_1.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
            DropdownToggler_1.BackgroundTransparency = 1
            DropdownToggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownToggler_1.BorderSizePixel = 0
            DropdownToggler_1.Position = UDim2.new(0, 138, 0, 4)
            DropdownToggler_1.Rotation = 0
            DropdownToggler_1.Size = UDim2.new(0, 20, 0, 20)
            DropdownToggler_1.Image = "rbxassetid://103715129205443"
            DropdownToggler_1.ImageTransparency = 0

            UICorner_30.Parent = DropdownToggler_1
            UICorner_30.CornerRadius = UDim.new(0, 6)

            DropdownSelection_1.Name = "DropdownSelection"
            DropdownSelection_1.Parent = DropdownSelectionFrame_1
            DropdownSelection_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownSelection_1.BackgroundTransparency = 1
            DropdownSelection_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownSelection_1.BorderSizePixel = 0
            DropdownSelection_1.Size = UDim2.new(0, 130, 0, 26)
            DropdownSelection_1.Font = Enum.Font.Ubuntu
            DropdownSelection_1.RichText = true
            DropdownSelection_1.Text = "<b>None</b>"
            DropdownSelection_1.TextColor3 = Color3.fromRGB(220, 220, 220)
            DropdownSelection_1.TextSize = 14
            DropdownSelection_1.TextTruncate = Enum.TextTruncate.SplitWord
            DropdownSelection_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_30.Parent = DropdownSelection_1
            UIPadding_30.PaddingLeft = UDim.new(0, 10)
            UIPadding_30.PaddingRight = UDim.new(0, 10)

            UIListLayout_3.Parent = Dropdown_1
            UIListLayout_3.SortOrder = Enum.SortOrder.Name

            B_Dropdown_1.Name = "B_Dropdown"
            B_Dropdown_1.Parent = Dropdown_1
            B_Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            B_Dropdown_1.BackgroundColor3 = Color3.fromRGB(38, 37, 47)
            B_Dropdown_1.BackgroundTransparency = 1
            B_Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            B_Dropdown_1.BorderSizePixel = 0
            B_Dropdown_1.Size = UDim2.new(0, 428, 0, 40)
            B_Dropdown_1.Visible = false

            UIListLayout_4.Parent = B_Dropdown_1
            UIListLayout_4.Padding = UDim.new(0, 6)
            UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

            UIPadding_31.Parent = B_Dropdown_1
            UIPadding_31.PaddingBottom = UDim.new(0, 10)
            UIPadding_31.PaddingLeft = UDim.new(0, 10)
            UIPadding_31.PaddingTop = UDim.new(0, 4)

            Dropdown_1.MouseEnter:Connect(
                function()
                    local dropdownTween5 = TweenService:Create(Dropdown_1, TweenInfo.new(0.3), {Transparency = 0.3})
                    dropdownTween5:Play()
                end
            )

            Dropdown_1.MouseLeave:Connect(
                function()
                    local dropdownTween6 = TweenService:Create(Dropdown_1, TweenInfo.new(0.3), {Transparency = 0})
                    dropdownTween6:Play()
                end
            )

            DropdownTitle_1.MouseEnter:Connect(
                function()
                    local dropdownTween1 =
                        TweenService:Create(DropdownTitle_1, TweenInfo.new(0.3), {TextTransparency = 0.3})
                    dropdownTween1:Play()
                end
            )

            DropdownTitle_1.MouseLeave:Connect(
                function()
                    local dropdownTween2 =
                        TweenService:Create(DropdownTitle_1, TweenInfo.new(0.3), {TextTransparency = 0})
                    dropdownTween2:Play()
                end
            )

            DropdownToggler_1.MouseEnter:Connect(
                function()
                    local dropdownTween3 =
                        TweenService:Create(DropdownToggler_1, TweenInfo.new(0.3), {ImageTransparency = 0.3})
                    dropdownTween3:Play()
                end
            )

            DropdownToggler_1.MouseLeave:Connect(
                function()
                    local dropdownTween4 =
                        TweenService:Create(DropdownToggler_1, TweenInfo.new(0.3), {ImageTransparency = 0})
                    dropdownTween4:Play()
                end
            )

            DropdownSelection_1.MouseEnter:Connect(
                function()
                    local dropdownTween5 =
                        TweenService:Create(DropdownSelection_1, TweenInfo.new(0.3), {TextTransparency = 0.3})
                    dropdownTween5:Play()
                end
            )

            DropdownSelection_1.MouseLeave:Connect(
                function()
                    local dropdownTween6 =
                        TweenService:Create(DropdownSelection_1, TweenInfo.new(0.3), {TextTransparency = 0})
                    dropdownTween6:Play()
                end
            )

            local isDropdownOpen = false

            local function ToggleDropdown()
                isDropdownOpen = not isDropdownOpen
                local targetRotation = isDropdownOpen and -90 or 0
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
                local rotationTween = TweenService:Create(DropdownToggler_1, tweenInfo, {Rotation = targetRotation})

                rotationTween:Play()
                B_Dropdown_1.Visible = isDropdownOpen

                local textTransparency = isDropdownOpen and 0 or 0.5
                local textTweenInfo = TweenInfo.new(isDropdownOpen and 0.3 or 0.3)
                local titleTween =
                    TweenService:Create(DropdownTitle_1, textTweenInfo, {TextTransparency = textTransparency})
                titleTween:Play()
            end

            DropdownToggler_1.MouseButton1Click:Connect(ToggleDropdown)

            for _, optionText in ipairs(Options) do
                local DropdownOptionFrame_1 = Instance.new("Frame")
                local UICorner_31 = Instance.new("UICorner")
                local OptionFrameButton_1 = Instance.new("TextButton")
                local UIPadding_32 = Instance.new("UIPadding")

                DropdownOptionFrame_1.Name = "DropdownOptionFrame"
                DropdownOptionFrame_1.Parent = B_Dropdown_1
                DropdownOptionFrame_1.BackgroundColor3 = Color3.fromRGB(27, 26, 33)
                DropdownOptionFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
                DropdownOptionFrame_1.BorderSizePixel = 0
                DropdownOptionFrame_1.Position = UDim2.new(0, 10, 0, 8)
                DropdownOptionFrame_1.Size = UDim2.new(0, 408, 0, 28)

                UICorner_31.Parent = DropdownOptionFrame_1
                UICorner_31.CornerRadius = UDim.new(0, 6)

                OptionFrameButton_1.Name = "OptionFrameButton"
                OptionFrameButton_1.Parent = DropdownOptionFrame_1
                OptionFrameButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                OptionFrameButton_1.BackgroundTransparency = 1
                OptionFrameButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
                OptionFrameButton_1.BorderSizePixel = 0
                OptionFrameButton_1.Position = UDim2.new(0, 0, 0.0208335873, 0)
                OptionFrameButton_1.Size = UDim2.new(0, 408, 0, 28)
                OptionFrameButton_1.Font = Enum.Font.Ubuntu
                OptionFrameButton_1.RichText = true
                OptionFrameButton_1.Text = "<b>" .. optionText .. "</b>"
                OptionFrameButton_1.TextColor3 = Color3.fromRGB(220, 220, 220)
                OptionFrameButton_1.TextSize = 14
                OptionFrameButton_1.TextTruncate = Enum.TextTruncate.SplitWord
                OptionFrameButton_1.TextXAlignment = Enum.TextXAlignment.Right

                UIPadding_32.Parent = OptionFrameButton_1
                UIPadding_32.PaddingRight = UDim.new(0, 14)

                OptionFrameButton_1.MouseButton1Click:Connect(
                    function()
                        DropdownSelection_1.Text = "<b>" .. optionText .. "</b>"
                        Callback(optionText)
                        ToggleDropdown()
                    end
                )

                OptionFrameButton_1.MouseEnter:Connect(
                    function()
                        local optionTween2 =
                            TweenService:Create(OptionFrameButton_1, TweenInfo.new(0.3), {TextTransparency = 0.3})
                        optionTween2:Play()
                    end
                )

                OptionFrameButton_1.MouseLeave:Connect(
                    function()
                        local optionTween2 =
                            TweenService:Create(OptionFrameButton_1, TweenInfo.new(0.3), {TextTransparency = 0})
                        optionTween2:Play()
                    end
                )
            end
        end
        return Elements
    end
    return Tabs
end
return Library