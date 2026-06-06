local NoxLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

NoxLib.Objects = {}
NoxLib.Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Topbar = Color3.fromRGB(23, 23, 30),
    Sidebar = Color3.fromRGB(19, 19, 26),
    TextColor = Color3.fromRGB(240, 240, 245),
    Accent = Color3.fromRGB(0, 125, 255),
    ElementBackground = Color3.fromRGB(27, 27, 36),
    ElementHover = Color3.fromRGB(35, 35, 48)
}

local function ApplyCorner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 6)
    c.Parent = obj
    return c
end

local function ApplyStroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(45, 45, 55)
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

function NoxLib:KeySystem(KeyConfig)
    local KeyTitle = KeyConfig.Title or "Key System"
    local TargetKey = KeyConfig.Key or "NoxKey"
    local SubmitCallback = KeyConfig.Callback
    
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "NoxKeySystem"
    KeyGui.Parent = CoreGui
    KeyGui.DisplayOrder = 10
    
    local Blur = Instance.new("BlurEffect")
    Blur.Size = 0
    Blur.Parent = game:GetService("Lighting")
    TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 15}):Play()
    
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 340, 0, 190)
    Frame.Position = UDim2.new(0.5, -170, 0.5, -95)
    Frame.BackgroundColor3 = NoxLib.Theme.Background
    Frame.BackgroundTransparency = 1
    Frame.Parent = KeyGui
    ApplyCorner(Frame, 8)
    ApplyStroke(Frame)
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.Text = KeyTitle
    Title.TextColor3 = NoxLib.Theme.TextColor
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 16
    Title.BackgroundTransparency = 1
    Title.Parent = Frame
    
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(1, -40, 0, 36)
    Input.Position = UDim2.new(0, 20, 0, 60)
    Input.BackgroundColor3 = NoxLib.Theme.ElementBackground
    Input.PlaceholderText = "Enter Activation Key..."
    Input.Text = ""
    Input.TextColor3 = NoxLib.Theme.TextColor
    Input.Font = Enum.Font.SourceSans
    Input.TextSize = 14
    Input.Parent = Frame
    ApplyCorner(Input, 6)
    ApplyStroke(Input)
    
    local Submit = Instance.new("TextButton")
    Submit.Size = UDim2.new(0, 140, 0, 34)
    Submit.Position = UDim2.new(0.5, -70, 0, 125)
    Submit.BackgroundColor3 = NoxLib.Theme.Accent
    Submit.Text = "Verify Key"
    Submit.TextColor3 = Color3.fromRGB(255, 255, 255)
    Submit.Font = Enum.Font.SourceSansBold
    Submit.TextSize = 14
    Submit.Parent = Frame
    ApplyCorner(Submit, 6)
    
    TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    
    Submit.MouseButton1Click:Connect(function()
        if Input.Text == TargetKey then
            Submit.Text = "Access Granted!"
            Submit.BackgroundColor3 = Color3.fromRGB(46, 184, 114)
            TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1, Size = UDim2.new(0, 300, 0, 150)}):Play()
            TweenService:Create(Blur, TweenInfo.new(0.3), {Size = 0}):Play()
            task.wait(0.3)
            Blur:Destroy()
            KeyGui:Destroy()
            if SubmitCallback then SubmitCallback(true) end
        else
            Submit.Text = "Access Denied!"
            Submit.BackgroundColor3 = Color3.fromRGB(219, 68, 85)
            task.wait(1)
            Submit.Text = "Verify Key"
            Submit.BackgroundColor3 = NoxLib.Theme.Accent
        end
    end)
    
    repeat task.wait() until not KeyGui.Parent
end

function NoxLib:CreateWindow(Config)
    local TitleText = Config.Title or "NoxLib UI"
    local SubTitleText = Config.SubTitle or "Premium"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NoxLibScreenGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 560, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
    MainFrame.BackgroundColor3 = NoxLib.Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Selectable = true
    MainFrame.ClipsDescendants = true
    MainFrame.BackgroundTransparency = 1
    MainFrame.Parent = ScreenGui
    ApplyCorner(MainFrame, 9)
    ApplyStroke(MainFrame)
    
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Size = UDim2.new(1, 0, 0, 42)
    Topbar.BackgroundColor3 = NoxLib.Theme.Topbar
    Topbar.BorderSizePixel = 0
    Topbar.Parent = MainFrame
    ApplyCorner(Topbar, 9)
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Text = TitleText .. " <font color='rgb(140,140,150)'>[" .. SubTitleText .. "]</font>"
    Title.RichText = true
    Title.TextColor3 = NoxLib.Theme.TextColor
    Title.TextSize = 14
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Topbar
    
    local Controls = Instance.new("Frame")
    Controls.Name = "Controls"
    Controls.Size = UDim2.new(0, 120, 1, 0)
    Controls.Position = UDim2.new(1, -135, 0, 0)
    Controls.BackgroundTransparency = 1
    Controls.Parent = Topbar
    
    local UIListLayoutControls = Instance.new("UIListLayout")
    UIListLayoutControls.FillDirection = Enum.FillDirection.Horizontal
    UIListLayoutControls.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayoutControls.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayoutControls.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayoutControls.Padding = UDim.new(0, 8)
    UIListLayoutControls.Parent = Controls

    local function CreateControl(name, text, color, order)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(0, 26, 0, 26)
        btn.BackgroundColor3 = color
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 14
        btn.Font = Enum.Font.SourceSansBold
        btn.LayoutOrder = order
        btn.Parent = Controls
        ApplyCorner(btn, 6)
        return btn
    end
    
    local MinimizeBtn = CreateControl("MinimizeBtn", "-", Color3.fromRGB(50, 50, 60), 1)
    local MaximizeBtn = CreateControl("MaximizeBtn", "+", Color3.fromRGB(50, 50, 60), 2)
    local CloseBtn = CreateControl("CloseBtn", "×", Color3.fromRGB(180, 50, 60), 3)
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, 0, 1, -42)
    ContentFrame.Position = UDim2.new(0, 0, 0, 42)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame
    
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 145, 1, 0)
    Sidebar.BackgroundColor3 = NoxLib.Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = ContentFrame
    
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 6)
    SidebarLayout.Parent = Sidebar
    
    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingLeft = UDim.new(0, 10)
    SidebarPadding.PaddingTop = UDim.new(0, 12)
    SidebarPadding.Parent = Sidebar

    local PagesFolder = Instance.new("Folder")
    PagesFolder.Name = "Pages"
    PagesFolder.Parent = ContentFrame

    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

    local isMaximized = false
    local originalSize = MainFrame.Size
    local originalPosition = MainFrame.Position
    
    MaximizeBtn.MouseButton1Click:Connect(function()
        if not isMaximized then
            originalSize = MainFrame.Size
            originalPosition = MainFrame.Position
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(1, -50, 1, -50),
                Position = UDim2.new(0, 25, 0, 25)
            }):Play()
            MaximizeBtn.Text = "❐"
            isMaximized = true
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = originalSize,
                Position = originalPosition
            }):Play()
            MaximizeBtn.Text = "+"
            isMaximized = false
        end
    end)
    
    local isMinimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        if not isMinimized then
            TweenService:Create(ContentFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            TweenService:Create(MainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 560, 0, 42)}):Play()
            isMinimized = true
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.25), {Size = isMaximized and UDim2.new(1, -50, 1, -50) or originalSize}):Play()
            TweenService:Create(ContentFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, 0, 1, -42)}):Play()
            isMinimized = false
        end
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundTransparency = 1, Size = UDim2.new(0, 500, 0, 300)}):Play()
        task.wait(0.25)
        ScreenGui:Destroy()
    end)
    
    local dragging, dragInput, dragStart, startPos
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local WindowAPI = {}
    local FirstTab = true

    function WindowAPI:CreateTab(TabConfig)
        local TabName = TabConfig.Name or "Tab"
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName .. "Btn"
        TabButton.Size = UDim2.new(1, -12, 0, 34)
        TabButton.BackgroundColor3 = NoxLib.Theme.Sidebar
        TabButton.Text = "  " .. TabName
        TabButton.TextColor3 = Color3.fromRGB(160, 160, 170)
        TabButton.TextSize = 13
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = Sidebar
        ApplyCorner(TabButton, 6)
        
        local Page = Instance.new("ScrollingFrame")
        Page.Name = TabName .. "Page"
        Page.Size = UDim2.new(1, -165, 1, -20)
        Page.Position = UDim2.new(0, 155, 0, 10)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 4
        Page.ScrollBarImageColor3 = Color3.fromRGB(65, 65, 75)
        Page.Visible = false
        Page.Active = false
        Page.Parent = PagesFolder
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = Page
        
        PageLayout.Changed:Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
        end)
        
        if FirstTab then
            Page.Visible = true
            Page.Active = true
            TabButton.TextColor3 = NoxLib.Theme.TextColor
            TabButton.BackgroundColor3 = NoxLib.Theme.ElementBackground
            ApplyStroke(TabButton, NoxLib.Theme.Accent, 1)
            FirstTab = false
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(PagesFolder:GetChildren()) do
                p.Visible = false
                p.Active = false
            end
            for _, btn in pairs(Sidebar:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
                    btn.BackgroundColor3 = NoxLib.Theme.Sidebar
                    local str = btn:FindFirstChildOfClass("UIStroke")
                    if str then str:Destroy() end
                end
            end
            Page.Visible = true
            Page.Active = true
            TabButton.TextColor3 = NoxLib.Theme.TextColor
            TabButton.BackgroundColor3 = NoxLib.Theme.ElementBackground
            ApplyStroke(TabButton, NoxLib.Theme.Accent, 1)
        end)
        
        local TabAPI = {}
        
        function TabAPI:AddSection(SectionName)
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, -10, 0, 26)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = "— " .. SectionName .. " —"
            SectionLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
            SectionLabel.TextSize = 12
            SectionLabel.Font = Enum.Font.SourceSansBold
            SectionLabel.Parent = Page
        end
        
        function TabAPI:AddButton(BtnConfig)
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, -10, 0, 38)
            b.BackgroundColor3 = NoxLib.Theme.ElementBackground
            b.Text = "  " .. (BtnConfig.Name or "Button")
            b.TextColor3 = NoxLib.Theme.TextColor
            b.TextSize = 14
            b.Font = Enum.Font.SourceSans
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Parent = Page
            ApplyCorner(b, 6)
            ApplyStroke(b)
            
            b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = NoxLib.Theme.ElementHover}):Play() end)
            b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = NoxLib.Theme.ElementBackground}):Play() end)
            
            b.MouseButton1Click:Connect(function()
                local oldColor = b.BackgroundColor3
                b.BackgroundColor3 = NoxLib.Theme.Accent
                TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = oldColor}):Play()
                if BtnConfig.Callback then BtnConfig.Callback() end
            end)
            
            local ButtonAPI = {}
            function ButtonAPI:SetText(txt) b.Text = "  " .. txt end
            return ButtonAPI
        end
        
        function TabAPI:AddToggle(ToggleConfig)
            local tState = ToggleConfig.Default or false
            local InternalTable = {Instance = nil, Callback = ToggleConfig.Callback}
            
            local tFrame = Instance.new("TextButton")
            tFrame.Size = UDim2.new(1, -10, 0, 38)
            tFrame.BackgroundColor3 = NoxLib.Theme.ElementBackground
            tFrame.Text = "  " .. (ToggleConfig.Name or "Toggle")
            tFrame.TextColor3 = NoxLib.Theme.TextColor
            tFrame.TextSize = 14
            tFrame.Font = Enum.Font.SourceSans
            tFrame.TextXAlignment = Enum.TextXAlignment.Left
            tFrame.Parent = Page
            ApplyCorner(tFrame, 6)
            ApplyStroke(tFrame)
            
            local Track = Instance.new("Frame")
            Track.Size = UDim2.new(0, 36, 0, 20)
            Track.Position = UDim2.new(1, -46, 0, 9)
            Track.BackgroundColor3 = tState and NoxLib.Theme.Accent or Color3.fromRGB(55, 55, 65)
            Track.Parent = tFrame
            ApplyCorner(Track, 10)
            
            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 14, 0, 14)
            Knob.Position = tState and UDim2.new(1, -17, 0, 3) or UDim2.new(0, 3, 0, 3)
            Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Knob.Parent = Track
            ApplyCorner(Knob, 8)
            
            local function updateToggle(animate)
                local targetTrackPos = tState and UDim2.new(1, -17, 0, 3) or UDim2.new(0, 3, 0, 3)
                local targetColor = tState and NoxLib.Theme.Accent or Color3.fromRGB(55, 55, 65)
                
                if animate ~= false then
                    TweenService:Create(Track, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
                    TweenService:Create(Knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetTrackPos}):Play()
                else
                    Track.BackgroundColor3 = targetColor
                    Knob.Position = targetTrackPos
                end
                if InternalTable.Callback then InternalTable.Callback(tState) end
            end
            
            tFrame.MouseButton1Click:Connect(function()
                tState = not tState
                updateToggle(true)
            end)
            
            if ToggleConfig.Default then
                task.spawn(function() updateToggle(false) end)
            end
            
            local ToggleAPI = {}
            function ToggleAPI:Set(val) tState = val updateToggle(true) end
            function ToggleAPI:Get() return tState end
            function ToggleAPI:SetCallback(cb) InternalTable.Callback = cb end
            return ToggleAPI
        end
        
        function TabAPI:AddSlider(SliderConfig)
            local Min = SliderConfig.Min or 0
            local Max = SliderConfig.Max or 100
            local Def = math.clamp(SliderConfig.Default or Min, Min, Max)
            local Decimals = SliderConfig.Decimals or 0
            
            local sFrame = Instance.new("Frame")
            sFrame.Size = UDim2.new(1, -10, 0, 48)
            sFrame.BackgroundColor3 = NoxLib.Theme.ElementBackground
            sFrame.Parent = Page
            ApplyCorner(sFrame, 6)
            ApplyStroke(sFrame)
            
            local sLabel = Instance.new("TextLabel")
            sLabel.Size = UDim2.new(1, -20, 0, 22)
            sLabel.Position = UDim2.new(0, 10, 0, 4)
            sLabel.Text = (SliderConfig.Name or "Slider") .. ": " .. tostring(Def)
            sLabel.TextColor3 = NoxLib.Theme.TextColor
            sLabel.TextSize = 13
            sLabel.Font = Enum.Font.SourceSans
            sLabel.TextXAlignment = Enum.TextXAlignment.Left
            sLabel.BackgroundTransparency = 1
            sLabel.Parent = sFrame
            
            local SliderBar = Instance.new("TextButton")
            SliderBar.Size = UDim2.new(1, -20, 0, 6)
            SliderBar.Position = UDim2.new(0, 10, 0, 32)
            SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            SliderBar.Text = ""
            SliderBar.Parent = sFrame
            ApplyCorner(SliderBar, 3)
            
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((Def - Min) / (Max - Min), 0, 1, 0)
            Fill.BackgroundColor3 = NoxLib.Theme.Accent
            Fill.BorderSizePixel = 0
            Fill.Parent = SliderBar
            ApplyCorner(Fill, 3)
            
            local sliding = false
            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                local val = Min + (pos * (Max - Min))
                val = math.round(val * (10^Decimals)) / (10^Decimals)
                TweenService:Create(Fill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
                sLabel.Text = (SliderConfig.Name or "Slider") .. ": " .. tostring(val)
                if SliderConfig.Callback then SliderConfig.Callback(val) end
            end
            
            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
                    sliding = true 
                    updateSlider(input) 
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateSlider(input) end
            end)
            
            local SliderAPI = {}
            function SliderAPI:Set(val)
                local bounded = math.clamp(val, Min, Max)
                local pos = (bounded - Min) / (Max - Min)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                sLabel.Text = (SliderConfig.Name or "Slider") .. ": " .. tostring(bounded)
                if SliderConfig.Callback then SliderConfig.Callback(bounded) end
            end
            return SliderAPI
        end
        
        function TabAPI:AddDropdown(DropConfig)
            local Options = DropConfig.Options or {}
            local Selected = DropConfig.Default or (Options[1] or "None")
            local Dropping = false
            
            local dFrame = Instance.new("Frame")
            dFrame.Size = UDim2.new(1, -10, 0, 38)
            dFrame.BackgroundColor3 = NoxLib.Theme.ElementBackground
            dFrame.ClipsDescendants = true
            dFrame.Parent = Page
            ApplyCorner(dFrame, 6)
            ApplyStroke(dFrame)
            
            local Trigger = Instance.new("TextButton")
            Trigger.Size = UDim2.new(1, 0, 0, 38)
            Trigger.BackgroundTransparency = 1
            Trigger.Text = "  " .. (DropConfig.Name or "Dropdown") .. " [" .. tostring(Selected) .. "]"
            Trigger.TextColor3 = NoxLib.Theme.TextColor
            Trigger.TextSize = 14
            Trigger.Font = Enum.Font.SourceSans
            Trigger.TextXAlignment = Enum.TextXAlignment.Left
            Trigger.Parent = dFrame
            
            local Indicator = Instance.new("TextLabel")
            Indicator.Size = UDim2.new(0, 30, 1, 0)
            Indicator.Position = UDim2.new(1, -35, 0, 0)
            Indicator.BackgroundTransparency = 1
            Indicator.Text = "▼"
            Indicator.TextColor3 = Color3.fromRGB(15, 15, 150)
            Indicator.TextSize = 11
            Indicator.Parent = Trigger
            
            local ListScroll = Instance.new("ScrollingFrame")
            ListScroll.Size = UDim2.new(1, -12, 0, 0)
            ListScroll.Position = UDim2.new(0, 6, 0, 38)
            ListScroll.BackgroundTransparency = 1
            ListScroll.BorderSizePixel = 0
            ListScroll.ScrollBarThickness = 2
            ListScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
            ListScroll.Parent = dFrame
            
            local dLayout = Instance.new("UIListLayout")
            dLayout.SortOrder = Enum.SortOrder.LayoutOrder
            dLayout.Padding = UDim.new(0, 3)
            dLayout.Parent = ListScroll
            
            local function toggleDrop()
                Dropping = not Dropping
                local maxVisibleItems = math.min(#Options, 4)
                local listHeight = maxVisibleItems * 29
                local targetFrameHeight = Dropping and (38 + listHeight + 6) or 38
                local targetScrollHeight = Dropping and listHeight or 0
                
                TweenService:Create(dFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(1, -10, 0, targetFrameHeight)}):Play()
                TweenService:Create(ListScroll, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(1, -12, 0, targetScrollHeight)}):Play()
                TweenService:Create(Indicator, TweenInfo.new(0.2), {Rotation = Dropping and 180 or 0}):Play()
                
                task.wait(0.1)
                ListScroll.CanvasSize = UDim2.new(0, 0, 0, dLayout.AbsoluteContentSize.Y)
                Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
            end
            
            Trigger.MouseButton1Click:Connect(toggleDrop)
            
            local function buildList()
                for _, child in pairs(ListScroll:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, opt in ipairs(Options) do
                    local oBtn = Instance.new("TextButton")
                    oBtn.Size = UDim2.new(1, 0, 0, 26)
                    oBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                    oBtn.Text = "  " .. tostring(opt)
                    oBtn.TextColor3 = Color3.fromRGB(190, 190, 200)
                    oBtn.TextSize = 13
                    oBtn.Font = Enum.Font.SourceSans
                    oBtn.TextXAlignment = Enum.TextXAlignment.Left
                    oBtn.Parent = ListScroll
                    ApplyCorner(oBtn, 4)
                    
                    oBtn.MouseButton1Click:Connect(function()
                        Selected = opt
                        Trigger.Text = "  " .. (DropConfig.Name or "Dropdown") .. " [" .. tostring(Selected) .. "]"
                        if DropConfig.Callback then DropConfig.Callback(Selected) end
                        toggleDrop()
                    end)
                end
            end
            
            buildList()
            
            local DropAPI = {}
            function DropAPI:Refresh(newList)
                Options = newList
                buildList()
                if Dropping then
                    local maxVisibleItems = math.min(#Options, 4)
                    ListScroll.Size = UDim2.new(1, -12, 0, maxVisibleItems * 29)
                    dFrame.Size = UDim2.new(1, -10, 0, 38 + (maxVisibleItems * 29) + 6)
                end
            end
            function DropAPI:Set(val)
                Selected = val
                Trigger.Text = "  " .. (DropConfig.Name or "Dropdown") .. " [" .. tostring(Selected) .. "]"
                if DropConfig.Callback then DropConfig.Callback(val) end
            end
            return DropAPI
        end
        
        function TabAPI:AddTextbox(TextConfig)
            local tbFrame = Instance.new("Frame")
            tbFrame.Size = UDim2.new(1, -10, 0, 42)
            tbFrame.BackgroundColor3 = NoxLib.Theme.ElementBackground
            tbFrame.Parent = Page
            ApplyCorner(tbFrame, 6)
            ApplyStroke(tbFrame)
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0, 150, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Text = TextConfig.Name or "Textbox"
            Label.TextColor3 = NoxLib.Theme.TextColor
            Label.Font = Enum.Font.SourceSans
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = tbFrame
            
            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(0, 160, 0, 26)
            Box.Position = UDim2.new(1, -170, 0, 8)
            Box.BackgroundColor3 = Color3.fromRGB(38, 38, 48)
            Box.Text = TextConfig.Default or ""
            Box.PlaceholderText = TextConfig.Placeholder or "Write value..."
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Box.TextSize = 13
            Box.Font = Enum.Font.SourceSans
            Box.Parent = tbFrame
            ApplyCorner(Box, 5)
            ApplyStroke(Box)
            
            Box.FocusLost:Connect(function(ep)
                if TextConfig.Callback then TextConfig.Callback(Box.Text, ep) end
            end)
            
            local TextboxAPI = {}
            function TextboxAPI:Set(txt) Box.Text = txt end
            function TextboxAPI:Get() return Box.Text end
            return TextboxAPI
        end
        
        function TabAPI:AddKeybind(KeyConfig)
            local currentKey = KeyConfig.Default or Enum.KeyCode.RightShift
            local waiting = false
            
            local kFrame = Instance.new("Frame")
            kFrame.Size = UDim2.new(1, -10, 0, 38)
            kFrame.BackgroundColor3 = NoxLib.Theme.ElementBackground
            kFrame.Parent = Page
            ApplyCorner(kFrame, 6)
            ApplyStroke(kFrame)
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0, 200, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Text = KeyConfig.Name or "Keybind"
            Label.TextColor3 = NoxLib.Theme.TextColor
            Label.Font = Enum.Font.SourceSans
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = kFrame
            
            local KeyBtn = Instance.new("TextButton")
            KeyBtn.Size = UDim2.new(0, 100, 0, 24)
            KeyBtn.Position = UDim2.new(1, -110, 0, 7)
            KeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            KeyBtn.Text = currentKey.Name
            KeyBtn.TextColor3 = NoxLib.Theme.TextColor
            KeyBtn.Font = Enum.Font.SourceSansBold
            KeyBtn.TextSize = 12
            KeyBtn.Parent = kFrame
            ApplyCorner(KeyBtn, 5)
            ApplyStroke(KeyBtn)
            
            KeyBtn.MouseButton1Click:Connect(function()
                waiting = true
                KeyBtn.Text = "[Press Key]"
                KeyBtn.BackgroundColor3 = NoxLib.Theme.ElementHover
            end)
            
            UserInputService.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                if waiting then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        KeyBtn.Text = currentKey.Name
                        KeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                        waiting = false
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        currentKey = Enum.KeyCode.Unknown
                        KeyBtn.Text = "Mouse1"
                        KeyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                        waiting = false
                    end
                elseif input.KeyCode == currentKey and not waiting then
                    if KeyConfig.Callback then KeyConfig.Callback() end
                end
            end)
            
            local KeybindAPI = {}
            function KeybindAPI:Get() return currentKey end
            return KeybindAPI
        end
        
        function TabAPI:AddLabel(LabelText)
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(1, -10, 0, 24)
            l.BackgroundTransparency = 1
            l.Text = "  " .. LabelText
            l.TextColor3 = Color3.fromRGB(210, 210, 220)
            l.TextSize = 13
            l.Font = Enum.Font.SourceSans
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.Parent = Page
            
            local LabelAPI = {}
            function LabelAPI:Set(newText) l.Text = "  " .. newText end
            return LabelAPI
        end
        
        return TabAPI
    end

    function WindowAPI:Notify(NotifConfig)
        local nFrame = Instance.new("Frame")
        nFrame.Name = "NoxNotification"
        nFrame.Size = UDim2.new(0, 250, 0, 68)
        nFrame.Position = UDim2.new(1, 30, 1, -85)
        nFrame.BackgroundColor3 = NoxLib.Theme.Topbar
        nFrame.BorderSizePixel = 0
        nFrame.Parent = ScreenGui
        ApplyCorner(nFrame, 7)
        ApplyStroke(nFrame, NoxLib.Theme.Accent, 1)
        
        local nTitle = Instance.new("TextLabel")
        nTitle.Size = UDim2.new(1, -10, 0, 22)
        nTitle.Position = UDim2.new(0, 10, 0, 5)
        nTitle.Text = NotifConfig.Title or "Notification"
        nTitle.TextColor3 = NoxLib.Theme.Accent
        nTitle.Font = Enum.Font.SourceSansBold
        nTitle.TextSize = 14
        nTitle.TextXAlignment = Enum.TextXAlignment.Left
        nTitle.BackgroundTransparency = 1
        nTitle.Parent = nFrame
        
        local nContent = Instance.new("TextLabel")
        nContent.Size = UDim2.new(1, -20, 0, 34)
        nContent.Position = UDim2.new(0, 10, 0, 26)
        nContent.Text = NotifConfig.Content or "Notification details text..."
        nContent.TextColor3 = NoxLib.Theme.TextColor
        nContent.Font = Enum.Font.SourceSans
        nContent.TextSize = 13
        nContent.TextWrapped = true
        nContent.TextXAlignment = Enum.TextXAlignment.Left
        nContent.TextYAlignment = Enum.TextYAlignment.Top
        nContent.BackgroundTransparency = 1
        nContent.Parent = nFrame
        
        TweenService:Create(nFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -270, 1, -85)}):Play()
        
        task.spawn(function()
            task.wait(NotifConfig.Duration or 3.5)
            local fade = TweenService:Create(nFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 30, 1, -85)})
            fade:Play()
            fade.Completed:Connect(function() nFrame:Destroy() end)
        end)
    end
    
    return WindowAPI
end

return NoxLib
