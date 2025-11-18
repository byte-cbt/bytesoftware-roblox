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

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

if game.CoreGui:FindFirstChild("Tools") then
    game.CoreGui:FindFirstChild("Tools"):Destroy()
end

local Tools = {}
function Tools:CreateWindow(Title)
    local Tools = Instance.new("ScreenGui")
    local Main_1 = Instance.new("Frame")
    local UICorner_1 = Instance.new("UICorner")
    local UIStroke_1 = Instance.new("UIStroke")
    local Topbar_1 = Instance.new("Frame")
    local Title_1 = Instance.new("TextLabel")
    local UIPadding_1 = Instance.new("UIPadding")
    local CloseButton_1 = Instance.new("ImageButton")
    local Elements_1 = Instance.new("Frame")
    local Items_1 = Instance.new("ScrollingFrame")
    local UIListLayout_1 = Instance.new("UIListLayout")
    local UIPadding_4 = Instance.new("UIPadding")

    Tools.Name = "Tools"
    Tools.Parent = game.CoreGui
    Tools.Enabled = true

    Main_1.Name = "Main"
    Main_1.Parent = Tools
    Main_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Main_1.BackgroundColor3 = Color3.fromRGB(48, 40, 65)
    Main_1.BackgroundTransparency = 0.25
    Main_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main_1.BorderSizePixel = 0
    Main_1.Position = UDim2.new(0.5, 0, 1.5, 0)
    Main_1.Size = UDim2.new(0, 222, 0, 132)
    Main_1.Visible = true
    Main_1.Active = true

    UICorner_1.Parent = Main_1

    UIStroke_1.Parent = Main_1
    UIStroke_1.Color = Color3.fromRGB(146, 129, 180)
    UIStroke_1.Thickness = 0

    Topbar_1.Name = "Topbar"
    Topbar_1.Parent = Main_1
    Topbar_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Topbar_1.BackgroundTransparency = 1
    Topbar_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Topbar_1.BorderSizePixel = 0
    Topbar_1.Size = UDim2.new(0, 222, 0, 26)

    Title_1.Name = "Title"
    Title_1.Parent = Topbar_1
    Title_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_1.BackgroundTransparency = 1
    Title_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title_1.BorderSizePixel = 0
    Title_1.Size = UDim2.new(0, 193, 0, 26)
    Title_1.Font = Enum.Font.Highway
    Title_1.Text = "Byt3c0de - " .. Title
    Title_1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_1.TextSize = 14
    Title_1.TextTruncate = Enum.TextTruncate.SplitWord
    Title_1.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding_1.Parent = Title_1
    UIPadding_1.PaddingLeft = UDim.new(0, 8)

    CloseButton_1.Name = "CloseButton"
    CloseButton_1.Parent = Topbar_1
    CloseButton_1.Active = true
    CloseButton_1.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton_1.BackgroundTransparency = 1
    CloseButton_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton_1.BorderSizePixel = 0
    CloseButton_1.Position = UDim2.new(0.899999976, 0, 0.5, 0)
    CloseButton_1.Size = UDim2.new(0, 16, 0, 16)
    CloseButton_1.Image = "rbxassetid://81795913772981"

    Elements_1.Name = "Elements"
    Elements_1.Parent = Main_1
    Elements_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Elements_1.BackgroundTransparency = 1
    Elements_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Elements_1.BorderSizePixel = 0
    Elements_1.Position = UDim2.new(0, 0, 0.19, 0)
    Elements_1.Size = UDim2.new(0, 222, 0, 104)

    Items_1.Name = "Items"
    Items_1.Parent = Elements_1
    Items_1.Active = true
    Items_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items_1.BackgroundTransparency = 1
    Items_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Items_1.BorderSizePixel = 0
    Items_1.Size = UDim2.new(0, 220, 0, 104)
    Items_1.ClipsDescendants = true
    Items_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Items_1.BottomImage = "rbxasset://textures/ui/Scroll/scroll-bottom.png"
    Items_1.CanvasPosition = Vector2.new(0, 70)
    Items_1.CanvasSize = UDim2.new(0, 0, 0, 0)
    Items_1.ElasticBehavior = Enum.ElasticBehavior.Never
    Items_1.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    Items_1.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
    Items_1.ScrollBarImageColor3 = Color3.fromRGB(111, 97, 154)
    Items_1.ScrollBarImageTransparency = 0
    Items_1.ScrollBarThickness = 5
    Items_1.ScrollingDirection = Enum.ScrollingDirection.XY
    Items_1.TopImage = "rbxasset://textures/ui/Scroll/scroll-top.png"
    Items_1.VerticalScrollBarInset = Enum.ScrollBarInset.None
    Items_1.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

    UIListLayout_1.Parent = Items_1
    UIListLayout_1.Padding = UDim.new(0, 8)
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder

    UIPadding_4.Parent = Items_1
    UIPadding_4.PaddingBottom = UDim.new(0, 6)
    UIPadding_4.PaddingLeft = UDim.new(0, 8)
    UIPadding_4.PaddingTop = UDim.new(0, 4)

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
                    UIStroke_1,
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
                                UIStroke_1,
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
                    Tools.Enabled = not Tools.Enabled
                end
            end
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
            game.CoreGui:FindFirstChild("Tools"):Destroy()
        end
    )

    wait(2)

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local goal = {Position = UDim2.new(0.5, 0, 0.5, 0)}
    local tween = TweenService:Create(Main_1, tweenInfo, goal)
    tween:Play()

    local Elements = {}
    function Elements:CreateLabel(Title)
        local Label_1 = Instance.new("Frame")
        local UICorner_40 = Instance.new("UICorner")
        local LabelTitle_1 = Instance.new("TextLabel")
        local UIPadding_50 = Instance.new("UIPadding")

        Label_1.Name = "Button"
        Label_1.Parent = Items_1
        Label_1.BackgroundColor3 = Color3.fromRGB(87, 78, 119)
        Label_1.BackgroundTransparency = 0.44999998807907104
        Label_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Label_1.BorderSizePixel = 0
        Label_1.Size = UDim2.new(0, 200, 0, 30)

        UICorner_40.Parent = Label_1
        UICorner_40.CornerRadius = UDim.new(0, 6)

        LabelTitle_1.Name = "ButtonTitle"
        LabelTitle_1.Parent = Label_1
        LabelTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelTitle_1.BackgroundTransparency = 1
        LabelTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        LabelTitle_1.BorderSizePixel = 0
        LabelTitle_1.Size = UDim2.new(0, 200, 0, 30)
        LabelTitle_1.Font = Enum.Font.Highway
        LabelTitle_1.Text = Title
        LabelTitle_1.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelTitle_1.TextSize = 14
        LabelTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
        LabelTitle_1.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding_50.Parent = LabelTitle_1
        UIPadding_50.PaddingLeft = UDim.new(0, 8)

        local dynamicLabel = {}
        dynamicLabel.SetText = function(newText)
            LabelTitle_1.Text = newText
        end
        return dynamicLabel
    end
    function Elements:CreateButton(Title, Callback)
        local Button_1 = Instance.new("Frame")
        local UICorner_4 = Instance.new("UICorner")
        local ButtonTitle_1 = Instance.new("TextButton")
        local UIPadding_5 = Instance.new("UIPadding")

        Button_1.Name = "Button"
        Button_1.Parent = Items_1
        Button_1.BackgroundColor3 = Color3.fromRGB(87, 78, 119)
        Button_1.BackgroundTransparency = 0.44999998807907104
        Button_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Button_1.BorderSizePixel = 0
        Button_1.Size = UDim2.new(0, 200, 0, 30)

        UICorner_4.Parent = Button_1
        UICorner_4.CornerRadius = UDim.new(0, 6)

        ButtonTitle_1.Name = "ButtonTitle"
        ButtonTitle_1.Parent = Button_1
        ButtonTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonTitle_1.BackgroundTransparency = 1
        ButtonTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ButtonTitle_1.BorderSizePixel = 0
        ButtonTitle_1.Size = UDim2.new(0, 200, 0, 30)
        ButtonTitle_1.Font = Enum.Font.Highway
        ButtonTitle_1.Text = Title
        ButtonTitle_1.TextColor3 = Color3.fromRGB(180, 180, 180)
        ButtonTitle_1.TextSize = 14
        ButtonTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
        ButtonTitle_1.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding_5.Parent = ButtonTitle_1
        UIPadding_5.PaddingLeft = UDim.new(0, 8)

        Button_1.MouseEnter:Connect(
            function()
                local tween =
                    TweenService:Create(ButtonTitle_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                tween:Play()
            end
        )

        Button_1.MouseLeave:Connect(
            function()
                local tween =
                    TweenService:Create(ButtonTitle_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(180, 180, 180)})
                tween:Play()
            end
        )

        ButtonTitle_1.MouseButton1Click:Connect(
            function()
                local tween1 =
                    TweenService:Create(ButtonTitle_1, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(139, 92, 246)})
                tween1:Play()

                tween1.Completed:Connect(
                    function()
                        local tween2 =
                            TweenService:Create(
                            ButtonTitle_1,
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
    function Elements:CreateBox(Title, Callback)
        local Box_1 = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local BoxTitle_1 = Instance.new("TextLabel")
        local UIPadding_2 = Instance.new("UIPadding")
        local TextBoxHolder_1 = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")
        local TextBox_1 = Instance.new("TextBox")
        local UIPadding_3 = Instance.new("UIPadding")

        Box_1.Parent = Items_1
        Box_1.BackgroundColor3 = Color3.fromRGB(87, 78, 119)
        Box_1.BackgroundTransparency = 0.44999998807907104
        Box_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Box_1.BorderSizePixel = 0
        Box_1.Size = UDim2.new(0, 200, 0, 30)

        UICorner_2.Parent = Box_1
        UICorner_2.CornerRadius = UDim.new(0, 6)

        BoxTitle_1.Name = "BoxTitle"
        BoxTitle_1.Parent = Box_1
        BoxTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BoxTitle_1.BackgroundTransparency = 1
        BoxTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        BoxTitle_1.BorderSizePixel = 0
        BoxTitle_1.Size = UDim2.new(0, 126, 0, 30)
        BoxTitle_1.Font = Enum.Font.Highway
        BoxTitle_1.Text = Title
        BoxTitle_1.TextColor3 = Color3.fromRGB(180, 180, 180)
        BoxTitle_1.TextSize = 14
        BoxTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
        BoxTitle_1.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding_2.Parent = BoxTitle_1
        UIPadding_2.PaddingLeft = UDim.new(0, 8)

        TextBoxHolder_1.Name = "TextBoxHolder"
        TextBoxHolder_1.Parent = Box_1
        TextBoxHolder_1.AnchorPoint = Vector2.new(0, 0.5)
        TextBoxHolder_1.BackgroundColor3 = Color3.fromRGB(140, 127, 190)
        TextBoxHolder_1.BackgroundTransparency = 0.5
        TextBoxHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextBoxHolder_1.BorderSizePixel = 0
        TextBoxHolder_1.Position = UDim2.new(0.629999995, 0, 0.5, 0)
        TextBoxHolder_1.Size = UDim2.new(0, 70, 0, 22)

        UICorner_3.Parent = TextBoxHolder_1
        UICorner_3.CornerRadius = UDim.new(0, 6)

        TextBox_1.Parent = TextBoxHolder_1
        TextBox_1.Active = true
        TextBox_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextBox_1.BackgroundTransparency = 1
        TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextBox_1.BorderSizePixel = 0
        TextBox_1.CursorPosition = -1
        TextBox_1.Size = UDim2.new(0, 70, 0, 22)
        TextBox_1.Font = Enum.Font.Highway
        TextBox_1.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
        TextBox_1.PlaceholderText = ""
        TextBox_1.Text = ""
        TextBox_1.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox_1.TextSize = 14
        TextBox_1.TextTruncate = Enum.TextTruncate.SplitWord

        UIPadding_3.Parent = TextBox_1
        UIPadding_3.PaddingLeft = UDim.new(0, 3)
        UIPadding_3.PaddingRight = UDim.new(0, 3)

        local fix = false

        TextBox_1.Focused:Connect(
            function()
                local tween =
                    TweenService:Create(BoxTitle_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(139, 92, 246)})
                tween:Play()
                fix = true
            end
        )

        TextBox_1.FocusLost:Connect(
            function()
                local tween =
                    TweenService:Create(BoxTitle_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(180, 180, 180)})
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
                        BoxTitle_1,
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
                        BoxTitle_1,
                        TweenInfo.new(0.3),
                        {TextColor3 = Color3.fromRGB(180, 180, 180)}
                    )
                    tween:Play()
                    fix = false
                end
            end
        )
    end
    function Elements:CreateToggle(Title, Callback)
        Callback = Callback or function()
            end

        local toggled = false
        local debounce = false

        local Toggle_1 = Instance.new("Frame")
        local UICorner_5 = Instance.new("UICorner")
        local ToggleHolder_1 = Instance.new("Frame")
        local UICorner_6 = Instance.new("UICorner")
        local Toggler_1 = Instance.new("TextButton")
        local TogglerIndicator_1 = Instance.new("Frame")
        local UICorner_7 = Instance.new("UICorner")
        local ToggleTitle_1 = Instance.new("TextLabel")
        local UIPadding_6 = Instance.new("UIPadding")

        Toggle_1.Name = "Toggle"
        Toggle_1.Parent = Items_1
        Toggle_1.BackgroundColor3 = Color3.fromRGB(87, 78, 119)
        Toggle_1.BackgroundTransparency = 0.44999998807907104
        Toggle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Toggle_1.BorderSizePixel = 0
        Toggle_1.Size = UDim2.new(0, 200, 0, 30)

        UICorner_5.Parent = Toggle_1
        UICorner_5.CornerRadius = UDim.new(0, 6)

        ToggleHolder_1.Name = "ToggleHolder"
        ToggleHolder_1.Parent = Toggle_1
        ToggleHolder_1.AnchorPoint = Vector2.new(0, 0.5)
        ToggleHolder_1.BackgroundColor3 = Color3.fromRGB(140, 127, 190)
        ToggleHolder_1.BackgroundTransparency = 0.9
        ToggleHolder_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ToggleHolder_1.BorderSizePixel = 0
        ToggleHolder_1.Position = UDim2.new(0.699999988, 1, 0.5, 0)
        ToggleHolder_1.Size = UDim2.new(0, 50, 0, 16)

        UICorner_6.Parent = ToggleHolder_1

        Toggler_1.Name = "Toggler"
        Toggler_1.Parent = ToggleHolder_1
        Toggler_1.Active = true
        Toggler_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Toggler_1.BackgroundTransparency = 1
        Toggler_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Toggler_1.BorderSizePixel = 0
        Toggler_1.Size = UDim2.new(0, 50, 0, 16)
        Toggler_1.Font = Enum.Font.SourceSans
        Toggler_1.Text = ""
        Toggler_1.TextSize = 14

        TogglerIndicator_1.Name = "TogglerIndicator"
        TogglerIndicator_1.Parent = ToggleHolder_1
        TogglerIndicator_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TogglerIndicator_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TogglerIndicator_1.BorderSizePixel = 0
        TogglerIndicator_1.Position = UDim2.new(0, 1, 0, 1)
        TogglerIndicator_1.Size = UDim2.new(0, 14, 0, 14)

        UICorner_7.Parent = TogglerIndicator_1
        UICorner_7.CornerRadius = UDim.new(0, 45)

        ToggleTitle_1.Name = "ToggleTitle"
        ToggleTitle_1.Parent = Toggle_1
        ToggleTitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleTitle_1.BackgroundTransparency = 1
        ToggleTitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ToggleTitle_1.BorderSizePixel = 0
        ToggleTitle_1.Size = UDim2.new(0, 120, 0, 30)
        ToggleTitle_1.Font = Enum.Font.Highway
        ToggleTitle_1.Text = Title
        ToggleTitle_1.TextColor3 = Color3.fromRGB(180, 180, 180)
        ToggleTitle_1.TextSize = 14
        ToggleTitle_1.TextTruncate = Enum.TextTruncate.SplitWord
        ToggleTitle_1.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding_6.Parent = ToggleTitle_1
        UIPadding_6.PaddingLeft = UDim.new(0, 8)

        Toggle_1.MouseEnter:Connect(
            function()
                local tween =
                    TweenService:Create(ToggleTitle_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)})
                tween:Play()
            end
        )

        Toggle_1.MouseLeave:Connect(
            function()
                local tween =
                    TweenService:Create(ToggleTitle_1, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(180, 180, 180)})
                tween:Play()
            end
        )

        Toggler_1.MouseButton1Click:Connect(
            function()
                local tweenInfo = TweenInfo.new(0.3)

                if not toggled then
                    local onTween =
                        TweenService:Create(TogglerIndicator_1, tweenInfo, {Position = UDim2.new(0, 35, 0, 1)})
                    onTween:Play()
                    local onTween2 = TweenService:Create(ToggleHolder_1, tweenInfo, {BackgroundTransparency = 0.5})
                    onTween:Play()
                    onTween2:Play()
                    toggled = true
                else
                    local offTween =
                        TweenService:Create(TogglerIndicator_1, tweenInfo, {Position = UDim2.new(0, 1, 0, 1)})
                    local offTween2 = TweenService:Create(ToggleHolder_1, tweenInfo, {BackgroundTransparency = 0.9})
                    offTween:Play()
                    offTween2:Play()
                    toggled = false
                end

                pcall(Callback, toggled)
            end
        )
    end
    return Elements
end
return Tools