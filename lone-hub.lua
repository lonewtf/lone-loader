-- Lone Hub for Trident Survival
-- Paste this into your executor

local function CreateHub()
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    -- Create Main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LoneHub"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)

    -- Drop shadow (subtle)
    local Shadow = Instance.new("Frame")
    Shadow.Size = UDim2.new(1, 0, 1, 0)
    Shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    Shadow.BackgroundTransparency = 0.4
    Shadow.BorderSizePixel = 0
    Shadow.ZIndex = MainFrame.ZIndex - 1
    Shadow.Parent = MainFrame
    Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0, 6)

    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 6)
    -- Round only top corners
    local TitleCornerFix = Instance.new("Frame")
    TitleCornerFix.Size = UDim2.new(1, 0, 0, 10)
    TitleCornerFix.BackgroundColor3 = TitleBar.BackgroundColor3
    TitleCornerFix.BorderSizePixel = 0
    TitleCornerFix.Position = UDim2.new(0, 0, 0, 30)
    TitleCornerFix.ZIndex = 2
    TitleCornerFix.Parent = TitleBar

    -- Title Label
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = "Lone"
    TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 18
    TitleLabel.Size = UDim2.new(0, 100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    -- Version label
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Text = "v1.0"
    VersionLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
    VersionLabel.Font = Enum.Font.Gotham
    VersionLabel.TextSize = 12
    VersionLabel.Size = UDim2.new(0, 40, 0, 20)
    VersionLabel.Position = UDim2.new(0, 120, 0, 8)
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Parent = TitleBar

    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 16
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 3)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseButton.BackgroundTransparency = 0.9
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = TitleBar
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 4)
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Dragging functionality
    local dragging = false
    local dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    TitleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 130, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 0)
    -- Round only left bottom
    local SidebarFix = Instance.new("Frame")
    SidebarFix.Size = UDim2.new(0, 10, 1, -10)
    SidebarFix.BackgroundColor3 = Sidebar.BackgroundColor3
    SidebarFix.BorderSizePixel = 0
    SidebarFix.Position = UDim2.new(0, 0, 0, 0)
    SidebarFix.ZIndex = 1
    SidebarFix.Parent = Sidebar

    -- Tab buttons
    local Tabs = {}
    local ContentFrames = {}

    -- Create a frame for each tab's content
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -140, 1, -45)
    ContentContainer.Position = UDim2.new(0, 140, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local function CreateTab(name, contentFunc)
        local Button = Instance.new("TextButton")
        Button.Text = name
        Button.TextColor3 = Color3.fromRGB(180, 180, 190)
        Button.Font = Enum.Font.GothamSemibold
        Button.TextSize = 14
        Button.Size = UDim2.new(1, -10, 0, 35)
        Button.Position = UDim2.new(0, 5, 0, 10 + (#Tabs * 40))
        Button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        Button.BackgroundTransparency = 0.8
        Button.BorderSizePixel = 0
        Button.Parent = Sidebar
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 5)

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Size = UDim2.new(1, 0, 1, 0)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Visible = false
        ContentFrame.Parent = ContentContainer

        table.insert(Tabs, {Button = Button, Frame = ContentFrame})
        table.insert(ContentFrames, ContentFrame)

        Button.MouseButton1Click:Connect(function()
            for _, tab in ipairs(Tabs) do
                tab.Button.BackgroundTransparency = 0.8
                tab.Frame.Visible = false
            end
            Button.BackgroundTransparency = 0.3
            ContentFrame.Visible = true
        end)

        -- Call content function to populate
        contentFunc(ContentFrame)

        return ContentFrame
    end

    -- Helper to create toggle
    local function CreateToggle(parent, text, default, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
        ToggleFrame.Position = UDim2.new(0, 10, 0, parent:GetChildren() and 10 + (#parent:GetChildren() * 35) or 10)
        ToggleFrame.BackgroundTransparency = 1
        ToggleFrame.Parent = parent

        local Label = Instance.new("TextLabel")
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(220, 220, 230)
        Label.Font = Enum.Font.Gotham
        Label.TextSize = 14
        Label.Size = UDim2.new(0, 150, 1, 0)
        Label.BackgroundTransparency = 1
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleFrame

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0, 36, 0, 20)
        ToggleButton.Position = UDim2.new(1, -40, 0.5, -10)
        ToggleButton.BackgroundColor3 = default and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(50, 50, 55)
        ToggleButton.BorderSizePixel = 0
        ToggleButton.Text = ""
        ToggleButton.Parent = ToggleFrame
        Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

        local ToggleDot = Instance.new("Frame")
        ToggleDot.Size = UDim2.new(0, 16, 0, 16)
        ToggleDot.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        ToggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleDot.BorderSizePixel = 0
        ToggleDot.BackgroundTransparency = 0.1
        ToggleDot.Parent = ToggleButton
        Instance.new("UICorner", ToggleDot).CornerRadius = UDim.new(1, 0)

        local toggled = default
        local function updateUI()
            if toggled then
                ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
                ToggleDot:TweenPosition(UDim2.new(1, -18, 0.5, -8), "InOut", "Quad", 0.15)
            else
                ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                ToggleDot:TweenPosition(UDim2.new(0, 2, 0.5, -8), "InOut", "Quad", 0.15)
            end
        end

        ToggleButton.MouseButton1Click:Connect(function()
            toggled = not toggled
            updateUI()
            callback(toggled)
        end)
    end

    -- Create tabs
    CreateTab("Main", function(f)
        CreateToggle(f, "Speed Boost", false, function(v)
            if v then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
            else
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
        end)
        CreateToggle(f, "Infinite Jump", false, function(v)
            local plr = game.Players.LocalPlayer
            local hum = plr.Character and plr.Character:FindFirstChild("Humanoid")
            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = v and 1000 or 50
            end
        end)
        CreateToggle(f, "No Clip", false, function(v)
            local chr = game.Players.LocalPlayer.Character
            if chr then
                for _, part in ipairs(chr:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = not v
                    end
                end
            end
        end)
    end)

    CreateTab("ESP", function(f)
        CreateToggle(f, "Player ESP", false, function(v)
            -- Placeholder: Highlight other players
            for _, plr in ipairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = plr.Character
                    highlight.FillColor = Color3.fromRGB(0, 120, 255)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = plr.Character
                    highlight.Enabled = v
                end
            end
        end)
        CreateToggle(f, "Item ESP", false, function(v)
            -- Placeholder for item highlights
            print("Item ESP toggled:", v)
        end)
    end)

    CreateTab("Teleports", function(f)
        local locations = {
            {"Spawn Island", CFrame.new(0, 50, 0)},
            {"Battle Arena", CFrame.new(100, 30, 200)},
            {"Boss Lair", CFrame.new(-150, 20, -100)},
        }
        for i, loc in ipairs(locations) do
            local btn = Instance.new("TextButton")
            btn.Text = loc[1]
            btn.TextColor3 = Color3.fromRGB(200, 200, 210)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 13
            btn.Size = UDim2.new(1, -20, 0, 28)
            btn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*35)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            btn.BorderSizePixel = 0
            btn.Parent = f
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                game.Players.LocalPlayer.Character:MoveTo(loc[2].Position)
            end)
        end
    end)

    CreateTab("Misc", function(f)
        CreateToggle(f, "Anti-AFK", false, function(v)
            -- Simple infinite jump to prevent disconnect
            while v do
                local player = game.Players.LocalPlayer
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = player.Character.HumanoidRootPart
                    hrp.Velocity = hrp.Velocity + Vector3.new(0, 0.1, 0)
                end
                wait(1)
            end
        end)
        CreateToggle(f, "Fullbright", false, function(v)
            local lighting = game:GetService("Lighting")
            if v then
                lighting.Brightness = 2
                lighting.ClockTime = 14
                lighting.FogEnd = 100000
                lighting.GlobalShadows = false
            else
                lighting.Brightness = 2
                lighting.ClockTime = 14
                lighting.FogEnd = 100000
                lighting.GlobalShadows = true
            end
        end)
    end)

    -- Activate first tab
    if Tabs[1] then
        Tabs[1].Button.BackgroundTransparency = 0.3
        Tabs[1].Frame.Visible = true
    end
end

CreateHub()
