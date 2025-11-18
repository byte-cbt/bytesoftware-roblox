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

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if game.CoreGui:FindFirstChild("Library") then
    game.CoreGui:FindFirstChild("Library"):Destroy()
end

local Library = {}
function Library:CreateWindow(Title)
    local Library = Instance.new("ScreenGui")
    local Main_1 = Instance.new("Frame")
    local UIStroke_999 = Instance.new("UIStroke")
    local UICorner_1 = Instance.new("UICorner")
    local Topbar_1 = Instance.new("Frame")
    local Title_1 = Instance.new("TextLabel")
    local UIPadding_1 = Instance.new("UIPadding")
    local CloseButton_1 = Instance.new("ImageButton")
    local MinimizeButton_1 = Instance.new("ImageButton")
    local TabsHolder_1 = Instance.new("Frame")
    local Tabs_1 = Instance.new("ScrollingFrame")
    local ElementsHolder_1 = Instance.new("Frame")
    local UIToggle_1 = Instance.new("Frame")
    local UICorner_99 = Instance.new("UICorner")
    local UIToggler_1 = Instance.new("TextButton")
    local UIStroke_99 = Instance.new("UIStroke")

    Library.Name = "Library"
    Library.Parent = game.CoreGui
    Library.Enabled = true

    Main_1.Name = "Main"
    Main_1.Parent = Library
    Main_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Main_1.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
    Main_1.BackgroundTransparency = 0.019999999552965164
    Main_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main_1.BorderSizePixel = 0
    Main_1.Position = UDim2.new(0.5, 0, 1.5, 0)
    Main_1.Size = UDim2.new(0, 440, 0, 290)
    Main_1.Visible = true
    Main_1.Active = true

    UIStroke_999.Parent = Main_1
    UIStroke_999.Color = Color3.fromRGB(139, 92, 246)
    UIStroke_999.Thickness = 0

    UICorner_1.Parent = Main_1

    Topbar_1.Name = "Topbar"
    Topbar_1.Parent = Main_1
    Topbar_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Topbar_1.BackgroundTransparency = 1
    Topbar_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Topbar_1.BorderSizePixel = 0
    Topbar_1.Size = UDim2.new(0, 440, 0, 30)

    Title_1.Name = "Title"
    Title_1.Parent = Topbar_1
    Title_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_1.BackgroundTransparency = 1
    Title_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title_1.BorderSizePixel = 0
    Title_1.Size = UDim2.new(0, 186, 0, 30)
    Title_1.Font = Enum.Font.RobotoMono
    Title_1.RichText = true
    Title_1.Text = "<b>" .. Title .. "</b>"
    Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_1.TextSize = 16
    Title_1.TextTruncate = Enum.TextTruncate.SplitWord
    Title_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_1.Parent = Title_1
    UIPadding_1.PaddingLeft = UDim.new(0, 10)

    CloseButton_1.Name = "CloseButton"
    CloseButton_1.Parent = Topbar_1
    CloseButton_1.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton_1.BackgroundTransparency = 1
    CloseButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton_1.BorderSizePixel = 0
    CloseButton_1.Position = UDim2.new(0.945, 0, 0.519999981, 0)
    CloseButton_1.Size = UDim2.new(0, 14, 0, 14)
    CloseButton_1.Image = "rbxassetid://109949868819465"

    MinimizeButton_1.Name = "MinimizeButton"
    MinimizeButton_1.Parent = Topbar_1
    MinimizeButton_1.AnchorPoint = Vector2.new(0, 0.5)
    MinimizeButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton_1.BackgroundTransparency = 1
    MinimizeButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeButton_1.BorderSizePixel = 0
    MinimizeButton_1.Position = UDim2.new(0.89, 0, 0.519999981, 0)
    MinimizeButton_1.Size = UDim2.new(0, 14, 0, 14)
    MinimizeButton_1.Image = "rbxassetid://138993042509032"

    TabsHolder_1.Name = "TabsHolder"
    TabsHolder_1.Parent = Main_1
    TabsHolder_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsHolder_1.BackgroundTransparency = 1
    TabsHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabsHolder_1.BorderSizePixel = 0
    TabsHolder_1.Position = UDim2.new(0, 0, 0, 34)
    TabsHolder_1.Size = UDim2.new(0, 148, 0, 246)

    Tabs_1.Name = "Tabs"
    Tabs_1.Parent = TabsHolder_1
    Tabs_1.Active = true
    Tabs_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs_1.BackgroundTransparency = 1
    Tabs_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tabs_1.BorderSizePixel = 0
    Tabs_1.Size = UDim2.new(0, 148, 0, 246)
    Tabs_1.ClipsDescendants = true
    Tabs_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Tabs_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
    Tabs_1.CanvasPosition = Vector2.new(0, 0)
    Tabs_1.CanvasSize = UDim2.new(0, 0, 0, 0)
    Tabs_1.ElasticBehavior = Enum.ElasticBehavior.Never
    Tabs_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    Tabs_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    Tabs_1.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    Tabs_1.ScrollBarImageTransparency = 1
    Tabs_1.ScrollBarThickness = 1
    Tabs_1.ScrollingDirection = Enum.ScrollingDirection.Y
    Tabs_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
    Tabs_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
    Tabs_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

    ElementsHolder_1.Name = "ElementsHolder"
    ElementsHolder_1.Parent = Main_1
    ElementsHolder_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ElementsHolder_1.BackgroundTransparency = 1
    ElementsHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ElementsHolder_1.BorderSizePixel = 0
    ElementsHolder_1.Position = UDim2.new(0, 150, 0, 34)
    ElementsHolder_1.Size = UDim2.new(0, 280, 0, 246)
    ElementsHolder_1.ClipsDescendants = true

    UIToggle_1.Name = "UIToggle"
    UIToggle_1.Parent = Library
    UIToggle_1.AnchorPoint = Vector2.new(0.5, 0.5)
    UIToggle_1.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
    UIToggle_1.BackgroundTransparency = 0.019999999552965164
    UIToggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UIToggle_1.BorderSizePixel = 0
    UIToggle_1.Position = UDim2.new(0.5, 0, -0.5, 0)
    UIToggle_1.Size = UDim2.new(0, 22, 0, 22)

    UICorner_99.Parent = UIToggle_1
    UICorner_99.CornerRadius = UDim.new(0, 90)

    UIToggler_1.Name = "UIToggler"
    UIToggler_1.Parent = UIToggle_1
    UIToggler_1.Active = true
    UIToggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    UIToggler_1.BackgroundTransparency = 1
    UIToggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UIToggler_1.BorderSizePixel = 0
    UIToggler_1.Size = UDim2.new(1, 0, 1, 0)
    UIToggler_1.Font = Enum.Font.SourceSans
    UIToggler_1.Text = ""
    UIToggler_1.TextSize = 14

    UIStroke_99.Parent = UIToggle_1
    UIStroke_99.Color = Color3.fromRGB(139, 92, 246)
    UIStroke_99.Thickness = 0

    local dragging
    local dragInput
    local dragStart
    local startPos

    function Lerp(a, b, m)
        return a + (b - a) * m
    end

    local lastMousePos
    local lastGoalPos
    local DRAG_SPEED = 6

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

                local tween =
                    TweenService:Create(
                    UIStroke_999,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Thickness = 1}
                )
                tween:Play()

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                            local tween1 =
                                TweenService:Create(
                                UIStroke_999,
                                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {Thickness = 0}
                            )
                            tween1:Play()
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

    MinimizeButton_1.MouseEnter:Connect(
        function()
            local tween =
                TweenService:Create(MinimizeButton_1, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(139, 92, 246)})
            tween:Play()
        end
    )

    MinimizeButton_1.MouseLeave:Connect(
        function()
            local tween =
                TweenService:Create(MinimizeButton_1, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            tween:Play()
        end
    )

    CloseButton_1.MouseEnter:Connect(
        function()
            local tween =
                TweenService:Create(CloseButton_1, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(139, 92, 246)})
            tween:Play()
        end
    )

    CloseButton_1.MouseLeave:Connect(
        function()
            local tween =
                TweenService:Create(CloseButton_1, TweenInfo.new(0.3), {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            tween:Play()
        end
    )

    UIToggle_1.MouseEnter:Connect(
        function()
            local tween = TweenService:Create(UIToggle_1, TweenInfo.new(0.3), {Size = UDim2.new(0, 24, 0, 24)})
            local tween2 =
                TweenService:Create(
                UIStroke_99,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Thickness = 1}
            )
            tween:Play()
            tween2:Play()
        end
    )

    UIToggle_1.MouseLeave:Connect(
        function()
            local tween = TweenService:Create(UIToggle_1, TweenInfo.new(0.3), {Size = UDim2.new(0, 22, 0, 22)})
            local tween2 =
                TweenService:Create(
                UIStroke_99,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Thickness = 0}
            )
            tween:Play()
            tween2:Play()
        end
    )

    MinimizeButton_1.MouseButton1Click:Connect(
        function()
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local goal = {Position = UDim2.new(0.5, 0, 1.5, 0)}
            local tween = TweenService:Create(Main_1, tweenInfo, goal)
            local goal2 = {Position = UDim2.new(0.5, 0, 0.02, 0)}
            local tween2 = TweenService:Create(UIToggle_1, tweenInfo, goal2)
            dragging = false
            lastGoalPos = nil
            startPos = nil
            tween:Play()
            tween2:Play()
        end
    )

    CloseButton_1.MouseButton1Click:Connect(
        function()
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local goal = {Position = UDim2.new(0.5, 0, 1.5, 0)}
            local tween = TweenService:Create(Main_1, tweenInfo, goal)
            dragging = false
            lastGoalPos = nil
            startPos = nil
            tween:Play()
            wait(1)
            game.CoreGui:FindFirstChild("Library"):Destroy()
        end
    )

    UIToggler_1.MouseButton1Click:Connect(
        function()
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local goal = {Position = UDim2.new(0.5, 0, 0.5, 0)}
            local tween = TweenService:Create(Main_1, tweenInfo, goal)
            local goal2 = {Position = UDim2.new(0.5, 0, -0.5, 0)}
            local tween2 = TweenService:Create(UIToggle_1, tweenInfo, goal2)
            dragging = false
            lastGoalPos = nil
            startPos = nil
            tween:Play()
            tween2:Play()
        end
    )

    wait(2)

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goal = {Position = UDim2.new(0.5, 0, 0.5, 0)}
    local tween = TweenService:Create(Main_1, tweenInfo, goal)
    tween:Play()

    local Tabs = {}
    local allTitles = {}
    local allIcons = {}
    local allTabs = {}
    local currentTab = nil
    local currentIcon = nil
    local currentTabIndex = nil
    local first = true
    function Tabs:CreateTabs(TabTitle)
        local TabHolder_1 = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local TabButton_1 = Instance.new("TextButton")
        local UIPadding_2 = Instance.new("UIPadding")
        local TabIndicator_1 = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")
        local UIListLayout_1 = Instance.new("UIListLayout")
        local UIPadding_3 = Instance.new("UIPadding")
        local Elements_1 = Instance.new("Frame")
        local Items_1 = Instance.new("ScrollingFrame")
        local UIPadding_6 = Instance.new("UIPadding")
        local UIListLayout_2 = Instance.new("UIListLayout")

        TabHolder_1.Name = "TabHolder"
        TabHolder_1.Parent = Tabs_1
        TabHolder_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
        TabHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabHolder_1.BorderSizePixel = 0
        TabHolder_1.Size = UDim2.new(0, 130, 0, 24)

        UICorner_2.Parent = TabHolder_1
        UICorner_2.CornerRadius = UDim.new(0, 4)

        TabButton_1.Name = "TabButton"
        TabButton_1.Parent = TabHolder_1
        TabButton_1.Active = true
        TabButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton_1.BackgroundTransparency = 1
        TabButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabButton_1.BorderSizePixel = 0
        TabButton_1.Size = UDim2.new(0, 130, 0, 22)
        TabButton_1.Font = Enum.Font.RobotoMono
        TabButton_1.RichText = true
        TabButton_1.Text = "<b>" .. TabTitle .. "</b>"
        TabButton_1.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabButton_1.TextSize = 16
        TabButton_1.TextTruncate = Enum.TextTruncate.SplitWord
        TabButton_1.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding_2.Parent = TabButton_1
        UIPadding_2.PaddingLeft = UDim.new(0, 15)

        TabIndicator_1.Name = "TabIndicator"
        TabIndicator_1.Parent = TabHolder_1
        TabIndicator_1.AnchorPoint = Vector2.new(0, 0.5)
        TabIndicator_1.BackgroundTransparency = 1
        TabIndicator_1.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
        TabIndicator_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabIndicator_1.BorderSizePixel = 0
        TabIndicator_1.Position = UDim2.new(0, 0, 0.5, 0)
        TabIndicator_1.Size = UDim2.new(0, 6, 0, 16)

        UICorner_3.Parent = TabIndicator_1

        UIListLayout_1.Parent = Tabs_1
        UIListLayout_1.Padding = UDim.new(0, 6)
        UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

        UIPadding_3.Parent = Tabs_1
        UIPadding_3.PaddingBottom = UDim.new(0, 4)
        UIPadding_3.PaddingLeft = UDim.new(0, 10)
        UIPadding_3.PaddingTop = UDim.new(0, 2)

        Elements_1.Name = "Elements"
        Elements_1.Parent = ElementsHolder_1
        Elements_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Elements_1.BackgroundTransparency = 1
        Elements_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Elements_1.BorderSizePixel = 0
        Elements_1.Size = UDim2.new(0, 280, 0, 246)

        Items_1.Name = "Items"
        Items_1.Parent = Elements_1
        Items_1.Active = true
        Items_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Items_1.BackgroundTransparency = 1
        Items_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Items_1.BorderSizePixel = 0
        Items_1.Size = UDim2.new(0, 280, 0, 246)
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

        UIPadding_6.Parent = Items_1
        UIPadding_6.PaddingBottom = UDim.new(0, 4)
        UIPadding_6.PaddingLeft = UDim.new(0, 4)

        UIListLayout_2.Parent = Items_1
        UIListLayout_2.Padding = UDim.new(0, 6)
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

        table.insert(allTitles, TabButton_1)
        table.insert(allIcons, TabIndicator_1)
        table.insert(allTabs, Elements_1)

        if first then
            first = false
            Elements_1.Visible = true
            Elements_1.Position = UDim2.new(0, 0, 0, 0)

            currentTab = TabButton_1
            currentIcon = TabIndicator_1
            currentTabIndex = 1

            TabButton_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabIndicator_1.BackgroundTransparency = 0
        else
            Elements_1.Visible = false
            TabButton_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            TabIndicator_1.BackgroundTransparency = 1
        end

        TabHolder_1.MouseEnter:Connect(
            function()
                if TabButton_1 == currentTab then
                    return
                else
                    local tween =
                        TweenService:Create(
                        TabButton_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    )
                    tween:Play()
                end
            end
        )

        TabHolder_1.MouseLeave:Connect(
            function()
                if TabButton_1 == currentTab then
                    return
                else
                    local tween =
                        TweenService:Create(
                        TabButton_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(180, 180, 180)}
                    )
                    tween:Play()
                end
            end
        )

        TabButton_1.MouseButton1Click:Connect(
            function()
                if currentTab == TabButton_1 then
                    return
                end

                local newIndex = table.find(allTitles, TabButton_1)
                if not newIndex then
                    return
                end

                local direction = (newIndex > currentTabIndex) and 1 or -1
                local currentFrame = allTabs[currentTabIndex]
                local newFrame = allTabs[newIndex]

                if currentTab and currentIcon then
                    TweenService:Create(currentTab, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play(

                    )
                    TweenService:Create(currentIcon, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                end
                TweenService:Create(TabButton_1, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play(

                )
                TweenService:Create(TabIndicator_1, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()

                newFrame.Position = UDim2.new(direction, 0, 0, 0)
                newFrame.Visible = true

                local tweenOut =
                    TweenService:Create(currentFrame, TweenInfo.new(0.3), {Position = UDim2.new(-direction, 0, 0, 0)})
                local tweenIn = TweenService:Create(newFrame, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 0)})

                tweenOut:Play()
                tweenIn:Play()

                tweenOut.Completed:Connect(
                    function()
                        currentFrame.Visible = false
                    end
                )

                currentTab = TabButton_1
                currentIcon = TabIndicator_1
                currentTabIndex = newIndex
            end
        )

        local Elements = {}
        function Elements:CreateSection(SectionText)
            local Section_1 = Instance.new("Frame")
            local SectionText_1 = Instance.new("TextLabel")
            local UIPadding_7 = Instance.new("UIPadding")

            Section_1.Name = "Section"
            Section_1.Parent = Items_1
            Section_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            Section_1.BackgroundTransparency = 1
            Section_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Section_1.BorderSizePixel = 0
            Section_1.Size = UDim2.new(0, 274, 0, 24)

            SectionText_1.Name = "SectionText"
            SectionText_1.Parent = Section_1
            SectionText_1.Active = true
            SectionText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectionText_1.BackgroundTransparency = 1
            SectionText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionText_1.BorderSizePixel = 0
            SectionText_1.Size = UDim2.new(0, 274, 0, 24)
            SectionText_1.Font = Enum.Font.RobotoMono
            SectionText_1.RichText = true
            SectionText_1.Text = "<b>" .. SectionText .. "</b>"
            SectionText_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionText_1.TextSize = 16
            SectionText_1.TextTruncate = Enum.TextTruncate.SplitWord
            SectionText_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_7.Parent = SectionText_1
        end
        function Elements:CreateLabel(LabelText)
            local Label_1 = Instance.new("Frame")
            local UICorner_15 = Instance.new("UICorner")
            local LabelText_1 = Instance.new("TextLabel")
            local UIPadding_0000 = Instance.new("UIPadding")

            Label_1.Name = "Label"
            Label_1.Parent = Items_1
            Label_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            Label_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Label_1.BorderSizePixel = 0
            Label_1.Size = UDim2.new(0, 274, 0, 24)

            UICorner_15.Parent = Label_1
            UICorner_15.CornerRadius = UDim.new(0, 4)

            LabelText_1.Name = "LabelText"
            LabelText_1.Parent = Label_1
            LabelText_1.Active = true
            LabelText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelText_1.BackgroundTransparency = 1
            LabelText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            LabelText_1.BorderSizePixel = 0
            LabelText_1.Size = UDim2.new(0, 274, 0, 24)
            LabelText_1.Font = Enum.Font.RobotoMono
            LabelText_1.RichText = true
            LabelText_1.Text = "<b>" .. LabelText .. "</b>"
            LabelText_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelText_1.TextSize = 16
            LabelText_1.TextTruncate = Enum.TextTruncate.SplitWord
            LabelText_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_0000.Parent = LabelText_1
            UIPadding_0000.PaddingLeft = UDim.new(0, 12)

            local dynamicLabel = {}
            dynamicLabel.SetText = function(newText)
                LabelText_1.Text = "<b>" .. newText .. "</b>"
            end
            return dynamicLabel
        end
        function Elements:CreateButton(ButtonText, Callback)
            local Button_1 = Instance.new("Frame")
            local UICorner_8 = Instance.new("UICorner")
            local ButtonBtn_1 = Instance.new("TextButton")
            local UIPadding_8 = Instance.new("UIPadding")

            Button_1.Name = "Button"
            Button_1.Parent = Items_1
            Button_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            Button_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Button_1.BorderSizePixel = 0
            Button_1.Position = UDim2.new(0, 0, 0.121951222, 0)
            Button_1.Size = UDim2.new(0, 274, 0, 28)

            UICorner_8.Parent = Button_1
            UICorner_8.CornerRadius = UDim.new(0, 4)

            ButtonBtn_1.Name = "ButtonBtn"
            ButtonBtn_1.Parent = Button_1
            ButtonBtn_1.Active = true
            ButtonBtn_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonBtn_1.BackgroundTransparency = 1
            ButtonBtn_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ButtonBtn_1.BorderSizePixel = 0
            ButtonBtn_1.Size = UDim2.new(0, 274, 0, 28)
            ButtonBtn_1.Font = Enum.Font.RobotoMono
            ButtonBtn_1.RichText = true
            ButtonBtn_1.Text = "<b>" .. ButtonText .. "</b>"
            ButtonBtn_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            ButtonBtn_1.TextSize = 16
            ButtonBtn_1.TextTruncate = Enum.TextTruncate.SplitWord
            ButtonBtn_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_8.Parent = ButtonBtn_1
            UIPadding_8.PaddingLeft = UDim.new(0, 12)

            Button_1.MouseEnter:Connect(
                function()
                    local tween =
                        TweenService:Create(
                        ButtonBtn_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    )
                    tween:Play()
                end
            )

            Button_1.MouseLeave:Connect(
                function()
                    local tween =
                        TweenService:Create(
                        ButtonBtn_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(180, 180, 180)}
                    )
                    tween:Play()
                end
            )

            ButtonBtn_1.MouseButton1Click:Connect(
                function()
                    local tween1 =
                        TweenService:Create(
                        ButtonBtn_1,
                        TweenInfo.new(0.1),
                        {TextColor3 = Color3.fromRGB(139, 92, 246)}
                    )
                    tween1:Play()

                    tween1.Completed:Connect(
                        function()
                            local tween2 =
                                TweenService:Create(
                                ButtonBtn_1,
                                TweenInfo.new(0.2),
                                {TextColor3 = Color3.fromRGB(180, 180, 180)}
                            )
                            tween2:Play()
                        end
                    )
                    Callback()
                end
            )
        end
        function Elements:CreateToggle(ToggleText, Callback)
            Callback = Callback or function()
                end

            local toggled = false
            local debounce = false

            local Toggle_1 = Instance.new("Frame")
            local UICorner_11 = Instance.new("UICorner")
            local ToggleText_1 = Instance.new("TextLabel")
            local UIPadding_11 = Instance.new("UIPadding")
            local TogglerHolder_1 = Instance.new("Frame")
            local UICorner_12 = Instance.new("UICorner")
            local Toggler_1 = Instance.new("TextButton")

            Toggle_1.Name = "Toggle"
            Toggle_1.Parent = Items_1
            Toggle_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            Toggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle_1.BorderSizePixel = 0
            Toggle_1.Size = UDim2.new(0, 274, 0, 28)

            UICorner_11.Parent = Toggle_1
            UICorner_11.CornerRadius = UDim.new(0, 4)

            ToggleText_1.Name = "ToggleText"
            ToggleText_1.Parent = Toggle_1
            ToggleText_1.Active = true
            ToggleText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleText_1.BackgroundTransparency = 1
            ToggleText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleText_1.BorderSizePixel = 0
            ToggleText_1.Size = UDim2.new(0, 230, 0, 28)
            ToggleText_1.Font = Enum.Font.RobotoMono
            ToggleText_1.RichText = true
            ToggleText_1.Text = "<b>" .. ToggleText .. "</b>"
            ToggleText_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            ToggleText_1.TextSize = 16
            ToggleText_1.TextTruncate = Enum.TextTruncate.SplitWord
            ToggleText_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_11.Parent = ToggleText_1
            UIPadding_11.PaddingLeft = UDim.new(0, 12)

            TogglerHolder_1.Name = "TogglerHolder"
            TogglerHolder_1.Parent = Toggle_1
            TogglerHolder_1.AnchorPoint = Vector2.new(0, 0.5)
            TogglerHolder_1.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
            TogglerHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TogglerHolder_1.BorderSizePixel = 0
            TogglerHolder_1.Position = UDim2.new(0.899999976, 0, 0.5, 0)
            TogglerHolder_1.Size = UDim2.new(0, 16, 0, 16)

            UICorner_12.Parent = TogglerHolder_1
            UICorner_12.CornerRadius = UDim.new(0, 4)

            Toggler_1.Name = "Toggler"
            Toggler_1.Parent = TogglerHolder_1
            Toggler_1.Active = true
            Toggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggler_1.BackgroundTransparency = 1
            Toggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggler_1.BorderSizePixel = 0
            Toggler_1.Size = UDim2.new(0, 16, 0, 16)
            Toggler_1.Font = Enum.Font.SourceSans
            Toggler_1.Text = ""
            Toggler_1.TextSize = 14

            Toggle_1.MouseEnter:Connect(
                function()
                    local tween =
                        TweenService:Create(
                        ToggleText_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    )
                    tween:Play()
                end
            )

            Toggle_1.MouseLeave:Connect(
                function()
                    local tween =
                        TweenService:Create(
                        ToggleText_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(180, 180, 180)}
                    )
                    tween:Play()
                end
            )

            Toggler_1.MouseButton1Click:Connect(
                function()
                    local tweenInfo = TweenInfo.new(0.3)

                    if not toggled then
                        local onTween =
                            TweenService:Create(
                            TogglerHolder_1,
                            tweenInfo,
                            {BackgroundColor3 = Color3.fromRGB(139, 92, 246)}
                        )
                        onTween:Play()
                        toggled = true
                    else
                        local offTween =
                            TweenService:Create(
                            TogglerHolder_1,
                            tweenInfo,
                            {BackgroundColor3 = Color3.fromRGB(28, 28, 40)}
                        )
                        offTween:Play()
                        toggled = false
                    end

                    pcall(Callback, toggled)
                end
            )
        end
        function Elements:CreateBox(BoxText, Callback)
            local Box_1 = Instance.new("Frame")
            local UICorner_9 = Instance.new("UICorner")
            local BoxText_1 = Instance.new("TextLabel")
            local UIPadding_9 = Instance.new("UIPadding")
            local TexthoxHolder_1 = Instance.new("Frame")
            local TextBox_1 = Instance.new("TextBox")
            local UIPadding_10 = Instance.new("UIPadding")
            local UICorner_10 = Instance.new("UICorner")

            Box_1.Name = "Box"
            Box_1.Parent = Items_1
            Box_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            Box_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box_1.BorderSizePixel = 0
            Box_1.Size = UDim2.new(0, 274, 0, 28)

            UICorner_9.Parent = Box_1
            UICorner_9.CornerRadius = UDim.new(0, 4)

            BoxText_1.Name = "BoxText"
            BoxText_1.Parent = Box_1
            BoxText_1.Active = true
            BoxText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BoxText_1.BackgroundTransparency = 1
            BoxText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            BoxText_1.BorderSizePixel = 0
            BoxText_1.Size = UDim2.new(0, 160, 0, 28)
            BoxText_1.Font = Enum.Font.RobotoMono
            BoxText_1.RichText = true
            BoxText_1.Text = "<b>" .. BoxText .. "</b>"
            BoxText_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            BoxText_1.TextSize = 16
            BoxText_1.TextTruncate = Enum.TextTruncate.SplitWord
            BoxText_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_9.Parent = BoxText_1
            UIPadding_9.PaddingLeft = UDim.new(0, 12)

            TexthoxHolder_1.Name = "TexthoxHolder"
            TexthoxHolder_1.Parent = Box_1
            TexthoxHolder_1.AnchorPoint = Vector2.new(0, 0.5)
            TexthoxHolder_1.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
            TexthoxHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TexthoxHolder_1.BorderSizePixel = 0
            TexthoxHolder_1.Position = UDim2.new(0.600000024, 0, 0.5, 0)
            TexthoxHolder_1.Size = UDim2.new(0, 100, 0, 16)

            TextBox_1.Parent = TexthoxHolder_1
            TextBox_1.Active = true
            TextBox_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_1.BackgroundTransparency = 1
            TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_1.BorderSizePixel = 0
            TextBox_1.CursorPosition = -1
            TextBox_1.Size = UDim2.new(0, 100, 0, 16)
            TextBox_1.Font = Enum.Font.RobotoMono
            TextBox_1.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_1.PlaceholderText = ""
            TextBox_1.RichText = true
            TextBox_1.Text = ""
            TextBox_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            TextBox_1.TextSize = 13
            TextBox_1.TextTruncate = Enum.TextTruncate.SplitWord

            UIPadding_10.Parent = TextBox_1
            UIPadding_10.PaddingLeft = UDim.new(0, 6)
            UIPadding_10.PaddingRight = UDim.new(0, 6)

            UICorner_10.Parent = TexthoxHolder_1
            UICorner_10.CornerRadius = UDim.new(0, 4)

            local fix = false

            TextBox_1.Focused:Connect(
                function()
                    local tween =
                        TweenService:Create(BoxText_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(139, 92, 246)})
                    tween:Play()
                    fix = true
                end
            )

            TextBox_1.FocusLost:Connect(
                function()
                    local tween =
                        TweenService:Create(BoxText_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(180, 180, 180)})
                    tween:Play()
                    fix = false
                    Callback(TextBox_1.Text)
                end
            )

            Box_1.MouseEnter:Connect(
                function()
                    if fix then
                        return
                    else
                        local tween =
                            TweenService:Create(
                            BoxText_1,
                            TweenInfo.new(0.3),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        )
                        tween:Play()
                    end
                end
            )

            Box_1.MouseLeave:Connect(
                function()
                    if fix then
                        return
                    else
                        local tween =
                            TweenService:Create(
                            BoxText_1,
                            TweenInfo.new(0.3),
                            {TextColor3 = Color3.fromRGB(180, 180, 180)}
                        )
                        tween:Play()
                        fix = false
                    end
                end
            )
        end
        function Elements:CreateDropdown(DropdownText, Options, Callback)
            local Dropdown_1 = Instance.new("Frame")
            local UICorner_16 = Instance.new("UICorner")
            local A_Dropdown_1 = Instance.new("Frame")
            local UICorner_17 = Instance.new("UICorner")
            local DropdownText_1 = Instance.new("TextLabel")
            local UIPadding_13 = Instance.new("UIPadding")
            local SelectionHolder_1 = Instance.new("Frame")
            local UICorner_18 = Instance.new("UICorner")
            local SelectedText_1 = Instance.new("TextLabel")
            local UIPadding_14 = Instance.new("UIPadding")
            local DropdownToggle_1 = Instance.new("ImageButton")
            local UIListLayout_3 = Instance.new("UIListLayout")
            local B_Dropdown_1 = Instance.new("Frame")
            local UICorner_19 = Instance.new("UICorner")
            local UIListLayout_4 = Instance.new("UIListLayout")
            local UIPadding_15 = Instance.new("UIPadding")

            Dropdown_1.Name = "Dropdown"
            Dropdown_1.Parent = Items_1
            Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            Dropdown_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown_1.BorderSizePixel = 0
            Dropdown_1.Size = UDim2.new(0, 274, 0, 28)

            UICorner_16.Parent = Dropdown_1
            UICorner_16.CornerRadius = UDim.new(0, 4)

            A_Dropdown_1.Name = "A_Dropdown"
            A_Dropdown_1.Parent = Dropdown_1
            A_Dropdown_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            A_Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            A_Dropdown_1.BorderSizePixel = 0
            A_Dropdown_1.Size = UDim2.new(0, 274, 0, 28)

            UICorner_17.Parent = A_Dropdown_1
            UICorner_17.CornerRadius = UDim.new(0, 4)

            DropdownText_1.Name = "DropdownText"
            DropdownText_1.Parent = A_Dropdown_1
            DropdownText_1.Active = true
            DropdownText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownText_1.BackgroundTransparency = 1
            DropdownText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownText_1.BorderSizePixel = 0
            DropdownText_1.Size = UDim2.new(0, 160, 0, 28)
            DropdownText_1.Font = Enum.Font.RobotoMono
            DropdownText_1.RichText = true
            DropdownText_1.Text = "<b>" .. DropdownText .. "</b>"
            DropdownText_1.TextColor3 = Color3.fromRGB(180, 180, 180)
            DropdownText_1.TextSize = 16
            DropdownText_1.TextTruncate = Enum.TextTruncate.SplitWord
            DropdownText_1.TextXAlignment = Enum.TextXAlignment.Left

            UIPadding_13.Parent = DropdownText_1
            UIPadding_13.PaddingLeft = UDim.new(0, 12)

            SelectionHolder_1.Name = "SelectionHolder"
            SelectionHolder_1.Parent = A_Dropdown_1
            SelectionHolder_1.AnchorPoint = Vector2.new(0, 0.5)
            SelectionHolder_1.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
            SelectionHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SelectionHolder_1.BorderSizePixel = 0
            SelectionHolder_1.Position = UDim2.new(0.600000024, 0, 0.519999981, 0)
            SelectionHolder_1.Size = UDim2.new(0, 100, 0, 18)

            UICorner_18.Parent = SelectionHolder_1
            UICorner_18.CornerRadius = UDim.new(0, 4)

            SelectedText_1.Name = "SelectedText"
            SelectedText_1.Parent = SelectionHolder_1
            SelectedText_1.Active = true
            SelectedText_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SelectedText_1.BackgroundTransparency = 1
            SelectedText_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SelectedText_1.BorderSizePixel = 0
            SelectedText_1.Size = UDim2.new(0, 82, 0, 16)
            SelectedText_1.Font = Enum.Font.RobotoMono
            SelectedText_1.RichText = true
            SelectedText_1.Text = "None"
            SelectedText_1.TextColor3 = Color3.fromRGB(255, 255, 255)
            SelectedText_1.TextSize = 13
            SelectedText_1.TextTruncate = Enum.TextTruncate.SplitWord
            SelectedText_1.TextXAlignment = Enum.TextXAlignment.Right

            UIPadding_14.Parent = SelectedText_1
            UIPadding_14.PaddingLeft = UDim.new(0, 4)
            UIPadding_14.PaddingRight = UDim.new(0, 4)

            DropdownToggle_1.Name = "DropdownToggle"
            DropdownToggle_1.Parent = SelectionHolder_1
            DropdownToggle_1.Active = true
            DropdownToggle_1.AnchorPoint = Vector2.new(0, 0.5)
            DropdownToggle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownToggle_1.BackgroundTransparency = 1
            DropdownToggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownToggle_1.BorderSizePixel = 0
            DropdownToggle_1.Position = UDim2.new(0, 82, 0.5, 0)
            DropdownToggle_1.Rotation = 180
            DropdownToggle_1.Size = UDim2.new(0, 12, 0, 12)
            DropdownToggle_1.Image = "rbxassetid://74694567980787"

            UIListLayout_3.Parent = Dropdown_1
            UIListLayout_3.SortOrder = Enum.SortOrder.Name

            B_Dropdown_1.Name = "B_Dropdown"
            B_Dropdown_1.Parent = Dropdown_1
            B_Dropdown_1.AutomaticSize = Enum.AutomaticSize.Y
            B_Dropdown_1.BackgroundColor3 = Color3.fromRGB(42, 39, 63)
            B_Dropdown_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            B_Dropdown_1.BorderSizePixel = 0
            B_Dropdown_1.Size = UDim2.new(0, 274, 0, 0)
            B_Dropdown_1.Visible = false

            UICorner_19.Parent = B_Dropdown_1
            UICorner_19.CornerRadius = UDim.new(0, 4)

            UIListLayout_4.Parent = B_Dropdown_1
            UIListLayout_4.Padding = UDim.new(0, 8)
            UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

            UIPadding_15.Parent = B_Dropdown_1
            UIPadding_15.PaddingBottom = UDim.new(0, 8)
            UIPadding_15.PaddingLeft = UDim.new(0, 12)
            UIPadding_15.PaddingTop = UDim.new(0, 4)

            local isDropdownOpen = false

            local function ToggleDropdown()
                isDropdownOpen = not isDropdownOpen
                local targetRotation = isDropdownOpen and 90 or 180
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                local rotationTween = TweenService:Create(DropdownToggle_1, tweenInfo, {Rotation = targetRotation})

                rotationTween:Play()
                B_Dropdown_1.Visible = isDropdownOpen

                local textColor = isDropdownOpen and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(255, 255, 255)
                local textTweenInfo = TweenInfo.new(isDropdownOpen and 0.3 or 0.3)
                local titleTween = TweenService:Create(DropdownText_1, textTweenInfo, {TextColor3 = textColor})
                titleTween:Play()
            end

            DropdownToggle_1.MouseButton1Click:Connect(ToggleDropdown)

            for _, optionText in ipairs(Options) do
                local OptionHolder_1 = Instance.new("Frame")
                local UICorner_20 = Instance.new("UICorner")
                local OptionButton_1 = Instance.new("TextButton")

                OptionHolder_1.Name = "OptionHolder"
                OptionHolder_1.Parent = B_Dropdown_1
                OptionHolder_1.AnchorPoint = Vector2.new(0, 0.5)
                OptionHolder_1.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
                OptionHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
                OptionHolder_1.BorderSizePixel = 0
                OptionHolder_1.Position = UDim2.new(0, 0, 0.5, 0)
                OptionHolder_1.Size = UDim2.new(0, 252, 0, 22)

                UICorner_20.Parent = OptionHolder_1
                UICorner_20.CornerRadius = UDim.new(0, 4)

                OptionButton_1.Name = "OptionButton"
                OptionButton_1.Parent = OptionHolder_1
                OptionButton_1.Active = true
                OptionButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton_1.BackgroundTransparency = 1
                OptionButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
                OptionButton_1.BorderSizePixel = 0
                OptionButton_1.Size = UDim2.new(0, 252, 0, 22)
                OptionButton_1.Font = Enum.Font.RobotoMono
                OptionButton_1.RichText = true
                OptionButton_1.Text = "<b>" .. optionText .. "</b>"
                OptionButton_1.TextColor3 = Color3.fromRGB(180, 180, 180)
                OptionButton_1.TextSize = 14

                OptionButton_1.MouseButton1Click:Connect(
                    function()
                        SelectedText_1.Text = optionText
                        Callback(optionText)
                        ToggleDropdown()
                    end
                )

                OptionHolder_1.MouseEnter:Connect(
                    function()
                        local tween =
                            TweenService:Create(
                            OptionButton_1,
                            TweenInfo.new(0.3),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        )
                        tween:Play()
                    end
                )

                OptionHolder_1.MouseLeave:Connect(
                    function()
                        local tween =
                            TweenService:Create(
                            OptionButton_1,
                            TweenInfo.new(0.3),
                            {TextColor3 = Color3.fromRGB(180, 180, 180)}
                        )
                        tween:Play()
                    end
                )
            end

            Dropdown_1.MouseEnter:Connect(
                function()
                    local tween =
                        TweenService:Create(
                        DropdownText_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(255, 255, 255)}
                    )
                    tween:Play()
                end
            )

            Dropdown_1.MouseLeave:Connect(
                function()
                    local tween =
                        TweenService:Create(
                        DropdownText_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(180, 180, 180)}
                    )
                    tween:Play()
                end
            )
        end
        return Elements
    end
    return Tabs
end
return Library