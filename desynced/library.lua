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

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local username = player.Name

if game.CoreGui:FindFirstChild("Library") then
    game.CoreGui:FindFirstChild("Library"):Destroy()
end

_G.SafeLock = false

local DesyncedLibrary = {}

local Library = Instance.new("ScreenGui")

Library.Name = "Library"
Library.Parent = game.CoreGui
Library.Enabled = true

local activeNotifications = {}
local notificationSpacing = 10
local notificationHeight = 90

function DesyncedLibrary:createNotification(descriptionText)
    local Notification_1 = Instance.new("Frame")
    local Background_2 = Instance.new("ImageLabel")
    local UICorner_21 = Instance.new("UICorner")
    local UICorner_22 = Instance.new("UICorner")
    local Title_2 = Instance.new("TextLabel")
    local UIPadding_20 = Instance.new("UIPadding")
    local Description_1 = Instance.new("TextLabel")
    local UIPadding_21 = Instance.new("UIPadding")

    Notification_1.Name = "Notification"
    Notification_1.Parent = Library
    Notification_1.AnchorPoint = Vector2.new(1, 1)
    Notification_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Notification_1.BackgroundTransparency = 0.10000000149011612
    Notification_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Notification_1.BorderSizePixel = 0
    Notification_1.Position = UDim2.new(1, -10, 1, -10)
    Notification_1.Size = UDim2.new(0, 235, 0, 82)
    Notification_1.ClipsDescendants = true

    Background_2.Name = "Background"
    Background_2.Parent = Notification_1
    Background_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Background_2.BackgroundTransparency = 1
    Background_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Background_2.BorderSizePixel = 0
    Background_2.Size = UDim2.new(1, 0, 0.999999523, 0)
    Background_2.ClipsDescendants = true
    Background_2.Image = "rbxassetid://126110720770200"
    Background_2.ImageTransparency = 0.44999998807907104

    UICorner_21.Parent = Background_2
    UICorner_21.CornerRadius = UDim.new(0, 10)

    UICorner_22.Parent = Notification_1
    UICorner_22.CornerRadius = UDim.new(0, 10)

    Title_2.Name = "Title"
    Title_2.Parent = Notification_1
    Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_2.BackgroundTransparency = 1
    Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title_2.BorderSizePixel = 0
    Title_2.Size = UDim2.new(1, 0, 0, 30)
    Title_2.Font = Enum.Font.Jura
    Title_2.RichText = true
    Title_2.Text = "<b>Desynced  |</b>  Notification"
    Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_2.TextSize = 15
    Title_2.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_20.Parent = Title_2
    UIPadding_20.PaddingLeft = UDim.new(0, 10)

    Description_1.Name = "Description"
    Description_1.Parent = Notification_1
    Description_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Description_1.BackgroundTransparency = 1
    Description_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Description_1.BorderSizePixel = 0
    Description_1.Position = UDim2.new(0, 0, 0.365853667, 0)
    Description_1.Size = UDim2.new(1, 0, 0.111923866, 40)
    Description_1.ClipsDescendants = true
    Description_1.Font = Enum.Font.Jura
    Description_1.LineHeight = 1.0800000429153442
    Description_1.RichText = true
    Description_1.Text = descriptionText
    Description_1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description_1.TextSize = 15
    Description_1.TextWrapped = true
    Description_1.TextXAlignment = Enum.TextXAlignment.Left
    Description_1.TextYAlignment = Enum.TextYAlignment.Top

    UIPadding_21.Parent = Description_1
    UIPadding_21.PaddingLeft = UDim.new(0, 10)
    UIPadding_21.PaddingRight = UDim.new(0, 10)
    UIPadding_21.PaddingTop = UDim.new(0, 2)

    local index = #activeNotifications + 1
    table.insert(activeNotifications, Notification_1)

    local targetY = -((notificationHeight + notificationSpacing) * (index - 1)) - 10

    Notification_1.Position = UDim2.new(1, -10, 1, 100)
    TweenService:Create(
        Notification_1,
        TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -10, 1, targetY)}
    ):Play()

    task.delay(
        4,
        function()
            local tweenOut =
                TweenService:Create(Notification_1, TweenInfo.new(0.5), {Position = UDim2.new(1, 300, 1, targetY)})
            tweenOut:Play()
            tweenOut.Completed:Wait()
            Notification_1:Destroy()

            table.remove(activeNotifications, table.find(activeNotifications, Notification_1))
            for i, notif in ipairs(activeNotifications) do
                local newY = -((notificationHeight + notificationSpacing) * (i - 1)) - 10
                TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, -10, 1, newY)}):Play()
            end
        end
    )
end

function DesyncedLibrary:CreateWindow(Title, Description)
    local uiOpen = true

    local Main_1 = Instance.new("Frame")
    local Background_1 = Instance.new("ImageLabel")
    local UICorner_1 = Instance.new("UICorner")
    local UICorner_2 = Instance.new("UICorner")
    local Topbar_1 = Instance.new("Frame")
    local Title_1 = Instance.new("TextLabel")
    local UIPadding_1 = Instance.new("UIPadding")
    local UIPadding_2 = Instance.new("UIPadding")
    local Tabs_1 = Instance.new("Frame")
    local TabsHolder_1 = Instance.new("ScrollingFrame")
    local UIListLayout_1 = Instance.new("UIListLayout")
    local ElementsHolder_1 = Instance.new("Frame")
    local User_1 = Instance.new("Frame")
    local UICorner_6 = Instance.new("UICorner")
    local UserIcon_1 = Instance.new("ImageLabel")
    local UserText_1 = Instance.new("TextLabel")
    local UIPadding_7 = Instance.new("UIPadding")

    Main_1.Name = "Main"
    Main_1.Parent = Library
    Main_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Main_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Main_1.BackgroundTransparency = 0.10000000149011612
    Main_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main_1.BorderSizePixel = 0
    Main_1.Position = UDim2.new(0.5, 0, 2, 0)
    Main_1.Size = UDim2.new(0, 530, 0, 300)
    Main_1.ClipsDescendants = true
    Main_1.Active = true
    Main_1.Visible = true

    Background_1.Name = "Background"
    Background_1.Parent = Main_1
    Background_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Background_1.BackgroundTransparency = 1
    Background_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Background_1.BorderSizePixel = 0
    Background_1.Size = UDim2.new(1, 0, 1, 0)
    Background_1.ClipsDescendants = true
    Background_1.Image = "rbxassetid://126110720770200"
    Background_1.ImageTransparency = 0.44999998807907104

    UICorner_1.Parent = Background_1
    UICorner_1.CornerRadius = UDim.new(0, 10)

    UICorner_2.Parent = Main_1
    UICorner_2.CornerRadius = UDim.new(0, 10)

    Topbar_1.Name = "Topbar"
    Topbar_1.Parent = Main_1
    Topbar_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Topbar_1.BackgroundTransparency = 1
    Topbar_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Topbar_1.BorderSizePixel = 0
    Topbar_1.Position = UDim2.new(5.75803369e-08, 0, 0, 0)
    Topbar_1.Size = UDim2.new(0, 530, 0, 30)
    Topbar_1.ZIndex = 2

    Title_1.Name = "Title"
    Title_1.Parent = Topbar_1
    Title_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_1.BackgroundTransparency = 1
    Title_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title_1.BorderSizePixel = 0
    Title_1.Size = UDim2.new(0, 400, 0, 30)
    Title_1.Font = Enum.Font.Jura
    Title_1.RichText = true
    Title_1.Text = "<b>" .. Title .. "  |</b>  " .. Description
    Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_1.TextSize = 15
    Title_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_1.Parent = Title_1
    UIPadding_1.PaddingLeft = UDim.new(0, 10)

    Tabs_1.Name = "Tabs"
    Tabs_1.Parent = Main_1
    Tabs_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs_1.BackgroundTransparency = 1
    Tabs_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tabs_1.BorderSizePixel = 0
    Tabs_1.Position = UDim2.new(0, 0, 0.1, 0)
    Tabs_1.Size = UDim2.new(0, 170, 0, 220)
    Tabs_1.ZIndex = 2

    TabsHolder_1.Name = "TabsHolder"
    TabsHolder_1.Parent = Tabs_1
    TabsHolder_1.Active = true
    TabsHolder_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsHolder_1.BackgroundTransparency = 1
    TabsHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabsHolder_1.BorderSizePixel = 0
    TabsHolder_1.Size = UDim2.new(0, 170, 0, 220)
    TabsHolder_1.ClipsDescendants = true
    TabsHolder_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabsHolder_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
    TabsHolder_1.CanvasPosition = Vector2.new(0, 0)
    TabsHolder_1.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsHolder_1.ElasticBehavior = Enum.ElasticBehavior.Never
    TabsHolder_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    TabsHolder_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    TabsHolder_1.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    TabsHolder_1.ScrollBarImageTransparency = 1
    TabsHolder_1.ScrollBarThickness = 1
    TabsHolder_1.ScrollingDirection = Enum.ScrollingDirection.Y
    TabsHolder_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
    TabsHolder_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
    TabsHolder_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

    UIListLayout_1.Parent = TabsHolder_1
    UIListLayout_1.Padding = UDim.new(0, 6)
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

    ElementsHolder_1.Name = "ElementsHolder"
    ElementsHolder_1.Parent = Main_1
    ElementsHolder_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ElementsHolder_1.BackgroundTransparency = 1
    ElementsHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ElementsHolder_1.BorderSizePixel = 0
    ElementsHolder_1.Position = UDim2.new(0.345, 0, 0.1, 0)
    ElementsHolder_1.Size = UDim2.new(0, 340, 0, 260)
    ElementsHolder_1.ZIndex = 2
    ElementsHolder_1.ClipsDescendants = true

    User_1.Name = "User"
    User_1.Parent = Main_1
    User_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    User_1.BackgroundTransparency = 0.800000011920929
    User_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    User_1.BorderSizePixel = 0
    User_1.Position = UDim2.new(0, 8, 0.87, 0)
    User_1.Size = UDim2.new(0, 160, 0, 30)
    User_1.ZIndex = 2

    UICorner_6.Parent = User_1
    UICorner_6.CornerRadius = UDim.new(0, 6)

    UserIcon_1.Name = "UserIcon"
    UserIcon_1.Parent = User_1
    UserIcon_1.AnchorPoint = Vector2.new(0, 0.5)
    UserIcon_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserIcon_1.BackgroundTransparency = 1
    UserIcon_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UserIcon_1.BorderSizePixel = 0
    UserIcon_1.Position = UDim2.new(0, 8, 0.5, 0)
    UserIcon_1.Size = UDim2.new(0, 18, 0, 18)
    UserIcon_1.Image = "rbxassetid://73054449943371"

    UserText_1.Name = "UserText"
    UserText_1.Parent = User_1
    UserText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UserText_1.BackgroundTransparency = 1
    UserText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UserText_1.BorderSizePixel = 0
    UserText_1.Size = UDim2.new(0, 160, 0, 30)
    UserText_1.Font = Enum.Font.Jura
    UserText_1.RichText = true
    UserText_1.Text = "<b>" .. username .. "</b>"
    UserText_1.TextColor3 = Color3.fromRGB(140, 140, 140)
    UserText_1.TextSize = 14
    UserText_1.TextXAlignment = Enum.TextXAlignment.Left
    UserText_1.ClipsDescendants = true
    UserText_1.TextTruncate = Enum.TextTruncate.AtEnd

    UIPadding_7.Parent = UserText_1
    UIPadding_7.PaddingLeft = UDim.new(0, 36)

    local dragging
    local dragInput
    local dragStart
    local startPos

    function Lerp(a, b, m)
        return a + (b - a) * m
    end

    local lastMousePos
    local lastGoalPos
    local DRAG_SPEED = 10

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

    runService.Heartbeat:Connect(Update)

    UserInputService.InputBegan:Connect(
        function(input, gameProcessed)
            if not gameProcessed then
                if input.KeyCode == Enum.KeyCode.LeftAlt then
                    Library.Enabled = not Library.Enabled
                end
            end
        end
    )

    local UITogglerHolder_1 = Instance.new("Frame")
    local UICorner_19 = Instance.new("UICorner")
    local UIToggler_1 = Instance.new("ImageButton")
    local UICorner_20 = Instance.new("UICorner")
    local UITogglerLogo_1 = Instance.new("ImageLabel")

    UITogglerHolder_1.Name = "UITogglerHolder"
    UITogglerHolder_1.Parent = Library
    UITogglerHolder_1.AnchorPoint = Vector2.new(0.5, 0.5)
    UITogglerHolder_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    UITogglerHolder_1.BackgroundTransparency = 0.10000000149011612
    UITogglerHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UITogglerHolder_1.BorderSizePixel = 0
    UITogglerHolder_1.Position = UDim2.new(0.5, 0, -0.5, 0)
    UITogglerHolder_1.Size = UDim2.new(0, 36, 0, 36)
    UITogglerHolder_1.ClipsDescendants = true

    UICorner_19.Parent = UITogglerHolder_1

    UIToggler_1.Name = "UIToggler"
    UIToggler_1.Parent = UITogglerHolder_1
    UIToggler_1.Active = true
    UIToggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UIToggler_1.BackgroundTransparency = 1
    UIToggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UIToggler_1.BorderSizePixel = 0
    UIToggler_1.Size = UDim2.new(0, 36, 0, 36)
    UIToggler_1.ZIndex = 2
    UIToggler_1.ClipsDescendants = true
    UIToggler_1.Image = "rbxassetid://131129943627373"
    UIToggler_1.ImageTransparency = 0.44999998807907104

    UICorner_20.Parent = UIToggler_1

    UITogglerLogo_1.Name = "UITogglerLogo"
    UITogglerLogo_1.Parent = UITogglerHolder_1
    UITogglerLogo_1.AnchorPoint = Vector2.new(0.5, 0.5)
    UITogglerLogo_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UITogglerLogo_1.BackgroundTransparency = 1
    UITogglerLogo_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UITogglerLogo_1.BorderSizePixel = 0
    UITogglerLogo_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    UITogglerLogo_1.Size = UDim2.new(0, 30, 0, 30)
    UITogglerLogo_1.ZIndex = 2
    UITogglerLogo_1.Image = "rbxassetid://136966526591317"

    UIToggler_1.MouseButton1Click:Connect(
        function()
            if uiOpen then
                uiOpen = false

                local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local goal = {Position = UDim2.new(0.5, 0, 2, 0)}
                local tween = TweenService:Create(Main_1, tweenInfo, goal)
                tween:Play()
                dragging = false
                lastGoalPos = nil
                startPos = nil
            else
                uiOpen = true

                local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                local goal = {Position = UDim2.new(0.5, 0, 0.5, 0)}
                local tween = TweenService:Create(Main_1, tweenInfo, goal)
                tween:Play()
                dragging = false
                lastGoalPos = nil
                startPos = nil
            end
        end
    )

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local goalUIToggle = {Position = UDim2.new(0.5, 0, 0.015, 0)}
    local tweenUIToggle = TweenService:Create(UITogglerHolder_1, tweenInfo, goalUIToggle)

    local goalMain = {Position = UDim2.new(0.5, 0, 0.5, 0)}
    local tweenMain = TweenService:Create(Main_1, tweenInfo, goalMain)

    tweenMain:Play()
    tweenUIToggle:Play()

    local Tabs = {}

    local allTitles = {}
    local allIcons = {}
    local allTabs = {}

    local currentTab = nil
    local currentIcon = nil
    local currentTabIndex = nil
    local first = true

    function Tabs:CreateTab(Title, Icon)
        local TabHolder_1 = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")
        local TabTitle_1 = Instance.new("TextButton")
        local UIPadding_3 = Instance.new("UIPadding")
        local TabIcon_1 = Instance.new("ImageLabel")
        local UIPadding_4 = Instance.new("UIPadding")
        local Elements_1 = Instance.new("Frame")
        local Items_1 = Instance.new("ScrollingFrame")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local UIPadding_8 = Instance.new("UIPadding")

        TabHolder_1.Name = "TabHolder"
        TabHolder_1.Parent = TabsHolder_1
        TabHolder_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        TabHolder_1.BackgroundTransparency = 0.800000011920929
        TabHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabHolder_1.BorderSizePixel = 0
        TabHolder_1.Size = UDim2.new(0, 160, 0, 30)

        UICorner_3.Parent = TabHolder_1
        UICorner_3.CornerRadius = UDim.new(0, 6)

        TabTitle_1.Name = "TabTitle"
        TabTitle_1.Parent = TabHolder_1
        TabTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle_1.BackgroundTransparency = 1
        TabTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabTitle_1.BorderSizePixel = 0
        TabTitle_1.Size = UDim2.new(0, 160, 0, 30)
        TabTitle_1.Font = Enum.Font.Jura
        TabTitle_1.RichText = true
        TabTitle_1.Text = "<b>" .. Title .. "</b>"
        TabTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)
        TabTitle_1.TextSize = 14
        TabTitle_1.TextXAlignment = Enum.TextXAlignment.Left
        TabTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)

        UIPadding_3.Parent = TabTitle_1
        UIPadding_3.PaddingLeft = UDim.new(0, 36)

        TabIcon_1.Name = "TabIcon"
        TabIcon_1.Parent = TabHolder_1
        TabIcon_1.AnchorPoint = Vector2.new(0, 0.5)
        TabIcon_1.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
        TabIcon_1.BackgroundTransparency = 1
        TabIcon_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabIcon_1.BorderSizePixel = 0
        TabIcon_1.Position = UDim2.new(0, 8, 0.5, 0)
        TabIcon_1.Size = UDim2.new(0, 18, 0, 18)
        TabIcon_1.Image = "rbxassetid://" .. Icon
        TabIcon_1.ImageColor3 = Color3.fromRGB(140, 140, 140)

        UIPadding_4.Parent = TabsHolder_1
        UIPadding_4.PaddingBottom = UDim.new(0, 4)
        UIPadding_4.PaddingLeft = UDim.new(0, 8)
        UIPadding_4.PaddingTop = UDim.new(0, 4)

        Elements_1.Name = "Elements"
        Elements_1.Parent = ElementsHolder_1
        Elements_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Elements_1.BackgroundTransparency = 1
        Elements_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Elements_1.BorderSizePixel = 0
        Elements_1.Size = UDim2.new(0, 340, 0, 260)

        Items_1.Name = "Items"
        Items_1.Parent = Elements_1
        Items_1.Active = true
        Items_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Items_1.BackgroundTransparency = 1
        Items_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Items_1.BorderSizePixel = 0
        Items_1.Size = UDim2.new(0, 340, 0, 260)
        Items_1.ClipsDescendants = true
        Items_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Items_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
        Items_1.CanvasPosition = Vector2.new(0, 4)
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

        UIListLayout_2.Parent = Items_1
        UIListLayout_2.Padding = UDim.new(0, 6)
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

        UIPadding_8.Parent = Items_1
        UIPadding_8.PaddingBottom = UDim.new(0, 4)
        UIPadding_8.PaddingTop = UDim.new(0, 4)

        table.insert(allTitles, TabTitle_1)
        table.insert(allIcons, TabIcon_1)
        table.insert(allTabs, Elements_1)

        if first then
            first = false
            Elements_1.Visible = true
            Elements_1.Position = UDim2.new(0, 0, 0, 0)

            currentTab = TabTitle_1
            currentIcon = TabIcon_1
            currentTabIndex = 1

            TabTitle_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabIcon_1.ImageColor3 = Color3.fromRGB(255, 255, 255)
        else
            Elements_1.Visible = false
            TabTitle_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            TabIcon_1.ImageColor3 = Color3.fromRGB(180, 180, 180)
        end

        TabTitle_1.MouseButton1Click:Connect(
            function()
                if currentTab == TabTitle_1 then
                    return
                end

                local newIndex = table.find(allTitles, TabTitle_1)
                if not newIndex then
                    return
                end

                local direction = (newIndex > currentTabIndex) and 1 or -1
                local currentFrame = allTabs[currentTabIndex]
                local newFrame = allTabs[newIndex]

                if currentTab and currentIcon then
                    TweenService:Create(currentTab, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play(

                    )

                    TweenService:Create(currentIcon, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(180, 180, 180)}):Play(

                    )
                end

                TweenService:Create(TabTitle_1, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()

                TweenService:Create(TabIcon_1, TweenInfo.new(0.2), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()

                newFrame.Position = UDim2.new(direction, 0, 0, 0)
                newFrame.Visible = true

                local tweenOut =
                    TweenService:Create(currentFrame, TweenInfo.new(0.25), {Position = UDim2.new(-direction, 0, 0, 0)})
                local tweenIn = TweenService:Create(newFrame, TweenInfo.new(0.25), {Position = UDim2.new(0, 0, 0, 0)})

                tweenOut:Play()
                tweenIn:Play()

                tweenOut.Completed:Connect(
                    function()
                        currentFrame.Visible = false
                    end
                )

                currentTab = TabTitle_1
                currentIcon = TabIcon_1
                currentTabIndex = newIndex
            end
        )

        local Elements = {}

        function Elements:CreateSection(Title)
            local Section_1 = Instance.new("Frame")
            local SectionTitle_1 = Instance.new("TextLabel")
            local UIPadding_9 = Instance.new("UIPadding")

            Section_1.Name = "Section"
            Section_1.Parent = Items_1
            Section_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Section_1.BackgroundTransparency = 1
            Section_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Section_1.BorderSizePixel = 0
            Section_1.Size = UDim2.new(0, 336, 0, 28)

            SectionTitle_1.Name = "SectionTitle"
            SectionTitle_1.Parent = Section_1
            SectionTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle_1.BackgroundTransparency = 1
            SectionTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionTitle_1.BorderSizePixel = 0
            SectionTitle_1.Size = UDim2.new(0, 336, 0, 28)
            SectionTitle_1.Font = Enum.Font.Jura
            SectionTitle_1.RichText = true
            SectionTitle_1.Text = "<b>" .. Title .. "</b>"
            SectionTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)
            SectionTitle_1.TextSize = 14
            SectionTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_9.Parent = SectionTitle_1
            UIPadding_9.PaddingLeft = UDim.new(0, 2)
        end

        function Elements:CreateLabel(Title)
            local Label_1 = Instance.new("Frame")
            local UICorner_7 = Instance.new("UICorner")
            local LabelTitle_1 = Instance.new("TextLabel")

            Label_1.Name = "Label"
            Label_1.Parent = Items_1
            Label_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Label_1.BackgroundTransparency = 0.800000011920929
            Label_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Label_1.BorderSizePixel = 0
            Label_1.Size = UDim2.new(0, 336, 0, 28)

            UICorner_7.Parent = Label_1
            UICorner_7.CornerRadius = UDim.new(0, 6)

            LabelTitle_1.Name = "LabelTitle"
            LabelTitle_1.Parent = Label_1
            LabelTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle_1.BackgroundTransparency = 1
            LabelTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelTitle_1.BorderSizePixel = 0
            LabelTitle_1.Size = UDim2.new(0, 336, 0, 28)
            LabelTitle_1.Font = Enum.Font.Jura
            LabelTitle_1.RichText = true
            LabelTitle_1.Text = "<b>" .. Title .. "</b>"
            LabelTitle_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle_1.TextSize = 14

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
            local UIPadding_17 = Instance.new("UIPadding")

            Button_1.Name = "Button"
            Button_1.Parent = Items_1
            Button_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Button_1.BackgroundTransparency = 0.800000011920929
            Button_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Button_1.BorderSizePixel = 0
            Button_1.Size = UDim2.new(0, 336, 0, 34)

            UICorner_16.Parent = Button_1
            UICorner_16.CornerRadius = UDim.new(0, 6)

            ButtonTitle_1.Name = "ButtonTitle"
            ButtonTitle_1.Parent = Button_1
            ButtonTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle_1.BackgroundTransparency = 1
            ButtonTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ButtonTitle_1.BorderSizePixel = 0
            ButtonTitle_1.Size = UDim2.new(0, 336, 0, 34)
            ButtonTitle_1.Font = Enum.Font.Jura
            ButtonTitle_1.RichText = true
            ButtonTitle_1.Text = "<b>" .. Title .. "</b>"
            ButtonTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)
            ButtonTitle_1.TextSize = 14
            ButtonTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_17.Parent = ButtonTitle_1
            UIPadding_17.PaddingLeft = UDim.new(0, 16)

            ButtonTitle_1.MouseButton1Click:Connect(
                function()
                    if _G.SafeLock then
                        DesyncedLibrary:createNotification("Safe Lock on! Disable to use features.")
                        return
                    end

                    local tween1 =
                        TweenService:Create(
                        ButtonTitle_1,
                        TweenInfo.new(0.1),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    )
                    tween1:Play()

                    tween1.Completed:Connect(
                        function()
                            local tween2 =
                                TweenService:Create(
                                ButtonTitle_1,
                                TweenInfo.new(0.2),
                                {TextColor3 = Color3.fromRGB(140, 140, 140)}
                            )
                            tween2:Play()
                        end
                    )
                    Callback()
                end
            )
        end

        function Elements:CreateToggle(Title, Callback)
            Callback = Callback or function()
                end

            local toggled = false
            local debounce = false

            local Toggle_1 = Instance.new("Frame")
            local UICorner_8 = Instance.new("UICorner")
            local ToggleTitle_1 = Instance.new("TextLabel")
            local UIPadding_10 = Instance.new("UIPadding")
            local TogglerHolder_1 = Instance.new("Frame")
            local UICorner_9 = Instance.new("UICorner")
            local Toggler_1 = Instance.new("TextButton")

            Toggle_1.Name = "Toggle"
            Toggle_1.Parent = Items_1
            Toggle_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Toggle_1.BackgroundTransparency = 0.800000011920929
            Toggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle_1.BorderSizePixel = 0
            Toggle_1.Size = UDim2.new(0, 336, 0, 34)

            UICorner_8.Parent = Toggle_1
            UICorner_8.CornerRadius = UDim.new(0, 6)

            ToggleTitle_1.Name = "ToggleTitle"
            ToggleTitle_1.Parent = Toggle_1
            ToggleTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle_1.BackgroundTransparency = 1
            ToggleTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleTitle_1.BorderSizePixel = 0
            ToggleTitle_1.Size = UDim2.new(0, 240, 0, 34)
            ToggleTitle_1.Font = Enum.Font.Jura
            ToggleTitle_1.RichText = true
            ToggleTitle_1.Text = "<b>" .. Title .. "</b>"
            ToggleTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)
            ToggleTitle_1.TextSize = 14
            ToggleTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_10.Parent = ToggleTitle_1
            UIPadding_10.PaddingLeft = UDim.new(0, 16)

            TogglerHolder_1.Name = "TogglerHolder"
            TogglerHolder_1.Parent = Toggle_1
            TogglerHolder_1.AnchorPoint = Vector2.new(0, 0.5)
            TogglerHolder_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            TogglerHolder_1.BackgroundTransparency = 0.75
            TogglerHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TogglerHolder_1.BorderSizePixel = 0
            TogglerHolder_1.Position = UDim2.new(0, 300, 0.5, 0)
            TogglerHolder_1.Size = UDim2.new(0, 22, 0, 22)

            UICorner_9.Parent = TogglerHolder_1
            UICorner_9.CornerRadius = UDim.new(0, 6)

            Toggler_1.Name = "Toggler"
            Toggler_1.Parent = TogglerHolder_1
            Toggler_1.Active = true
            Toggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggler_1.BackgroundTransparency = 1
            Toggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggler_1.BorderSizePixel = 0
            Toggler_1.Size = UDim2.new(0, 22, 0, 22)
            Toggler_1.Font = Enum.Font.SourceSans
            Toggler_1.Text = ""
            Toggler_1.TextSize = 14

            Toggler_1.MouseButton1Click:Connect(
                function()
                    if _G.SafeLock then
                        if ToggleTitle_1.Text == "<b>Safe Lock</b>" then
                            _G.SafeLock = false
                            local offTween =
                                TweenService:Create(
                                TogglerHolder_1,
                                tweenInfo,
                                {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}
                            )
                            local offTween2 =
                                TweenService:Create(
                                ToggleTitle_1,
                                tweenInfo,
                                {TextColor3 = Color3.fromRGB(140, 140, 140)}
                            )
                            offTween:Play()
                            offTween2:Play()
                            DesyncedLibrary:createNotification("Safe Lock disabled! All inputs unlocked.")
                            return
                        else
                            DesyncedLibrary:createNotification("Safe Lock on! Disable to use features.")
                            return
                        end
                    else
                        if ToggleTitle_1.Text == "<b>Safe Lock</b>" then
                            _G.SafeLock = true
                            local onTween =
                                TweenService:Create(
                                TogglerHolder_1,
                                tweenInfo,
                                {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                            )
                            local onTween2 =
                                TweenService:Create(
                                ToggleTitle_1,
                                tweenInfo,
                                {TextColor3 = Color3.fromRGB(255, 255, 255)}
                            )
                            onTween:Play()
                            onTween2:Play()
                            DesyncedLibrary:createNotification("Safe Lock enabled! All inputs locked.")
                            return
                        end
                    end

                    if debounce then
                        return
                    end

                    debounce = true
                    local tweenInfo = TweenInfo.new(0.2)

                    if not toggled then
                        local onTween =
                            TweenService:Create(
                            TogglerHolder_1,
                            tweenInfo,
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        )
                        local onTween2 =
                            TweenService:Create(ToggleTitle_1, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                        onTween:Play()
                        onTween2:Play()
                        toggled = true
                    else
                        local offTween =
                            TweenService:Create(
                            TogglerHolder_1,
                            tweenInfo,
                            {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}
                        )
                        local offTween2 =
                            TweenService:Create(ToggleTitle_1, tweenInfo, {TextColor3 = Color3.fromRGB(140, 140, 140)})
                        offTween:Play()
                        offTween2:Play()
                        toggled = false
                    end

                    pcall(Callback, toggled)
                    debounce = false
                end
            )
        end

        function Elements:CreateBox(Title, Callback)
            local Box_1 = Instance.new("Frame")
            local UICorner_17 = Instance.new("UICorner")
            local BoxTitle_1 = Instance.new("TextLabel")
            local UIPadding_18 = Instance.new("UIPadding")
            local TextBoxHolder_1 = Instance.new("Frame")
            local UICorner_18 = Instance.new("UICorner")
            local TextBox_1 = Instance.new("TextBox")
            local UIPadding_19 = Instance.new("UIPadding")

            Box_1.Name = "Box"
            Box_1.Parent = Items_1
            Box_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Box_1.BackgroundTransparency = 0.800000011920929
            Box_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box_1.BorderSizePixel = 0
            Box_1.Size = UDim2.new(0, 336, 0, 34)

            UICorner_17.Parent = Box_1
            UICorner_17.CornerRadius = UDim.new(0, 6)

            BoxTitle_1.Name = "BoxTitle"
            BoxTitle_1.Parent = Box_1
            BoxTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BoxTitle_1.BackgroundTransparency = 1
            BoxTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            BoxTitle_1.BorderSizePixel = 0
            BoxTitle_1.Size = UDim2.new(0, 240, 0, 34)
            BoxTitle_1.Font = Enum.Font.Jura
            BoxTitle_1.RichText = true
            BoxTitle_1.Text = "<b>" .. Title .. "</b>"
            BoxTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)
            BoxTitle_1.TextSize = 14
            BoxTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_18.Parent = BoxTitle_1
            UIPadding_18.PaddingLeft = UDim.new(0, 16)

            TextBoxHolder_1.Name = "TextBoxHolder"
            TextBoxHolder_1.Parent = Box_1
            TextBoxHolder_1.AnchorPoint = Vector2.new(0, 0.5)
            TextBoxHolder_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxHolder_1.BackgroundTransparency = 0.75
            TextBoxHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxHolder_1.BorderSizePixel = 0
            TextBoxHolder_1.Position = UDim2.new(-0.178571433, 300, 0.5, 0)
            TextBoxHolder_1.Size = UDim2.new(0, 82, 0, 22)

            UICorner_18.Parent = TextBoxHolder_1
            UICorner_18.CornerRadius = UDim.new(0, 6)

            TextBox_1.Parent = TextBoxHolder_1
            TextBox_1.Active = true
            TextBox_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_1.BackgroundTransparency = 1
            TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_1.BorderSizePixel = 0
            TextBox_1.CursorPosition = -1
            TextBox_1.Size = UDim2.new(0, 82, 0, 22)
            TextBox_1.ClipsDescendants = true
            TextBox_1.Font = Enum.Font.Jura
            TextBox_1.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
            TextBox_1.PlaceholderText = "..."
            TextBox_1.Text = ""
            TextBox_1.TextEditable = true
            TextBox_1.ClearTextOnFocus = false
            TextBox_1.TextColor3 = Color3.fromRGB(140, 140, 140)
            TextBox_1.TextSize = 14
            TextBox_1.TextTruncate = Enum.TextTruncate.AtEnd
            TextBox_1.TextXAlignment = Enum.TextXAlignment.Right

            UIPadding_19.Parent = TextBox_1
            UIPadding_19.PaddingLeft = UDim.new(0, 8)
            UIPadding_19.PaddingRight = UDim.new(0, 8)

            TextBox_1.Focused:Connect(
                function()
                    if _G.SafeLock then
                        TextBox_1.TextEditable = false
                        DesyncedLibrary:createNotification("Safe Lock on! Disable to use features.")
                        return
                    end

                    TextBox_1.TextEditable = true
                    local tweenIn =
                        TweenService:Create(
                        BoxTitle_1,
                        TweenInfo.new(0.1),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    )
                    tweenIn:Play()
                end
            )

            TextBox_1.FocusLost:Connect(
                function()
                    if _G.SafeLock then
                        return
                    end

                    Callback(TextBox_1.Text)
                    local tweenOut =
                        TweenService:Create(
                        BoxTitle_1,
                        TweenInfo.new(0.2),
                        {TextColor3 = Color3.fromRGB(140, 140, 140)}
                    )
                    tweenOut:Play()
                end
            )
        end

        function Elements:CreateDropdown(Title, Options, Callback)
            local Dropdown_1 = Instance.new("Frame")
            local UICorner_12 = Instance.new("UICorner")
            local A_Dropdown_1 = Instance.new("Frame")
            local DropdownBarHolder_1 = Instance.new("Frame")
            local UICorner_13 = Instance.new("UICorner")
            local SelectedText_1 = Instance.new("TextLabel")
            local UIPadding_12 = Instance.new("UIPadding")
            local DropdownToggler_1 = Instance.new("ImageButton")
            local DropdownTitle_1 = Instance.new("TextLabel")
            local UIPadding_13 = Instance.new("UIPadding")
            local B_Dropdown_1 = Instance.new("Frame")
            local UIListLayout_3 = Instance.new("UIListLayout")
            local UIPadding_14 = Instance.new("UIPadding")

            local OptionButton_2 = Instance.new("TextButton")
            local UIPadding_16 = Instance.new("UIPadding")
            local UIListLayout_4 = Instance.new("UIListLayout")

            Dropdown_1.Name = "Dropdown"
            Dropdown_1.Parent = Items_1
            Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            Dropdown_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Dropdown_1.BackgroundTransparency = 0.800000011920929
            Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown_1.BorderSizePixel = 0
            Dropdown_1.Size = UDim2.new(0, 336, 0, 34)

            UICorner_12.Parent = Dropdown_1
            UICorner_12.CornerRadius = UDim.new(0, 6)

            A_Dropdown_1.Name = "A_Dropdown"
            A_Dropdown_1.Parent = Dropdown_1
            A_Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            A_Dropdown_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            A_Dropdown_1.BackgroundTransparency = 1
            A_Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            A_Dropdown_1.BorderSizePixel = 0
            A_Dropdown_1.Size = UDim2.new(0, 336, 0, 34)

            DropdownBarHolder_1.Name = "DropdownBarHolder"
            DropdownBarHolder_1.Parent = A_Dropdown_1
            DropdownBarHolder_1.AnchorPoint = Vector2.new(0, 0.5)
            DropdownBarHolder_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBarHolder_1.BackgroundTransparency = 0.75
            DropdownBarHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBarHolder_1.BorderSizePixel = 0
            DropdownBarHolder_1.Position = UDim2.new(-0.327380955, 300, 0.5, 0)
            DropdownBarHolder_1.Size = UDim2.new(0, 132, 0, 22)

            UICorner_13.Parent = DropdownBarHolder_1
            UICorner_13.CornerRadius = UDim.new(0, 6)

            SelectedText_1.Name = "SelectedText"
            SelectedText_1.Parent = DropdownBarHolder_1
            SelectedText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SelectedText_1.BackgroundTransparency = 1
            SelectedText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SelectedText_1.BorderSizePixel = 0
            SelectedText_1.Size = UDim2.new(0, 100, 0, 22)
            SelectedText_1.ClipsDescendants = true
            SelectedText_1.Font = Enum.Font.Jura
            SelectedText_1.RichText = true
            SelectedText_1.Text = "None"
            SelectedText_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            SelectedText_1.TextSize = 14
            SelectedText_1.TextTruncate = Enum.TextTruncate.AtEnd
            SelectedText_1.TextXAlignment = Enum.TextXAlignment.Right

            UIPadding_12.Parent = SelectedText_1
            UIPadding_12.PaddingRight = UDim.new(0, 2)

            DropdownToggler_1.Name = "DropdownToggler"
            DropdownToggler_1.Parent = DropdownBarHolder_1
            DropdownToggler_1.Active = true
            DropdownToggler_1.AnchorPoint = Vector2.new(0, 0.5)
            DropdownToggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownToggler_1.BackgroundTransparency = 1
            DropdownToggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownToggler_1.BorderSizePixel = 0
            DropdownToggler_1.Position = UDim2.new(0.819999993, 0, 0.5, 0)
            DropdownToggler_1.Rotation = 180
            DropdownToggler_1.Size = UDim2.new(0, 12, 0, 12)
            DropdownToggler_1.Image = "rbxassetid://128993416980283"

            DropdownTitle_1.Name = "DropdownTitle"
            DropdownTitle_1.Parent = A_Dropdown_1
            DropdownTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle_1.BackgroundTransparency = 1
            DropdownTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownTitle_1.BorderSizePixel = 0
            DropdownTitle_1.Size = UDim2.new(0, 190, 0, 34)
            DropdownTitle_1.Font = Enum.Font.Jura
            DropdownTitle_1.RichText = true
            DropdownTitle_1.Text = "<b>" .. Title .. "</b>"
            DropdownTitle_1.TextColor3 = Color3.fromRGB(140, 140, 140)
            DropdownTitle_1.TextSize = 14
            DropdownTitle_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_13.Parent = DropdownTitle_1
            UIPadding_13.PaddingLeft = UDim.new(0, 16)

            B_Dropdown_1.Name = "B_Dropdown"
            B_Dropdown_1.Parent = Dropdown_1
            B_Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            B_Dropdown_1.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            B_Dropdown_1.BackgroundTransparency = 1
            B_Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            B_Dropdown_1.BorderSizePixel = 0
            B_Dropdown_1.Size = UDim2.new(0, 336, 0, 34)
            B_Dropdown_1.Visible = false

            UIListLayout_3.Parent = B_Dropdown_1
            UIListLayout_3.Padding = UDim.new(0, 6)
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

            UIPadding_14.Parent = B_Dropdown_1
            UIPadding_14.PaddingBottom = UDim.new(0, 8)
            UIPadding_14.PaddingLeft = UDim.new(0, 13)
            UIPadding_14.PaddingTop = UDim.new(0, 2)

            UIListLayout_4.Parent = Dropdown_1
            UIListLayout_4.SortOrder = Enum.SortOrder.Name

            local isDropdownOpen = false

            local function ToggleDropdown()
                if _G.SafeLock then
                    DesyncedLibrary:createNotification("Safe Lock on! Disable to use features.")
                    return
                end

                isDropdownOpen = not isDropdownOpen
                local targetRotation = isDropdownOpen and 90 or 180
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local rotationTween = TweenService:Create(DropdownToggler_1, tweenInfo, {Rotation = targetRotation})

                rotationTween:Play()
                B_Dropdown_1.Visible = isDropdownOpen

                local textColor = isDropdownOpen and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)
                local textTweenInfo = TweenInfo.new(isDropdownOpen and 0.1 or 0.2)
                local titleTween = TweenService:Create(DropdownTitle_1, textTweenInfo, {TextColor3 = textColor})
                titleTween:Play()
            end

            DropdownToggler_1.MouseButton1Click:Connect(ToggleDropdown)

            for _, optionText in ipairs(Options) do
                local optionFrame = Instance.new("Frame")
                local corner = Instance.new("UICorner")
                local button = Instance.new("TextButton")
                local padding = Instance.new("UIPadding")

                optionFrame.Name = "OptionFrame"
                optionFrame.Parent = B_Dropdown_1
                optionFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                optionFrame.BackgroundTransparency = 0.75
                optionFrame.BorderSizePixel = 0
                optionFrame.Size = UDim2.new(0, 310, 0, 28)

                corner.Parent = optionFrame
                corner.CornerRadius = UDim.new(0, 6)

                button.Name = "OptionButton"
                button.Parent = optionFrame
                button.Active = true
                button.BackgroundTransparency = 1
                button.Size = UDim2.new(0, 310, 0, 28)
                button.Font = Enum.Font.Jura
                button.RichText = true
                button.Text = "<b>" .. optionText .. "</b>"
                button.TextColor3 = Color3.fromRGB(180, 180, 180)
                button.TextSize = 14
                button.TextXAlignment = Enum.TextXAlignment.Right

                padding.Parent = button
                padding.PaddingRight = UDim.new(0, 14)

                button.MouseButton1Click:Connect(
                    function()
                        if _G.SafeLock then
                            DesyncedLibrary:createNotification("Safe Lock on! Disable to use features.")
                            return
                        end

                        SelectedText_1.Text = optionText
                        Callback(optionText)
                        ToggleDropdown()
                    end
                )
            end
        end
        return Elements
    end
    return Tabs
end
return DesyncedLibrary