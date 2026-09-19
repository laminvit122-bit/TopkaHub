-- script by DevScripts
-- Topka Hub
-- ЧАСТЬ 1

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local isMinimized = false
local mainFrame = nil
local savedPosition = nil
local currentTab = "Main"
local language = "en"
local speedHackEnabled = false
local jumpPowerEnabled = false
local speedValue = 1
local jumpValue = 1
local speedSettingsOpen = false
local jumpSettingsOpen = false
local soundEnabled = true

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://101572333845544"
clickSound.Volume = 0.5
clickSound.Parent = game:GetService("SoundService")

local function playClick()
    if soundEnabled and clickSound then
        clickSound:Play()
    end
end

local lang = {
    en = {
        title = "Topka Hub", main = "MAIN", teleports = "TELEPORTS", player = "PLAYER", settings = "SETTINGS",
        language = "Language", english = "English", russian = "Russian", sound = "Sound",
        soundOn = "Sound ON 🔊", soundOff = "Sound OFF 🔇", speedHack = "Speed Hack", jumpPower = "Jump Power",
        speed = "Speed", jump = "Jump", speedOn = "Speed Hack ON ✅", speedOff = "Speed Hack OFF",
        jumpOn = "Jump Power ON ✅", jumpOff = "Jump Power OFF",
        bank = "Bank", bankRings = "Bank (Rings)", armory1 = "Armory 1", armory2 = "Armory 2", armory3 = "Armory 3",
        militaryBase = "Military Base (Street)", militaryBunker = "Military Base (Bunker)", police = "Police Station",
        paintball = "Paintball Shop", blackMarket = "Black Market", credit = "script by DevScripts",
    },
    ru = {
        title = "Topka Hub", main = "ГЛАВНАЯ", teleports = "ТЕЛЕПОРТЫ", player = "ИГРОК", settings = "НАСТРОЙКИ",
        language = "Язык", english = "Английский", russian = "Русский", sound = "Звук",
        soundOn = "Звук ВКЛ 🔊", soundOff = "Звук ВЫКЛ 🔇", speedHack = "Спид Хак", jumpPower = "Сила Прыжка",
        speed = "Скорость", jump = "Прыжок", speedOn = "Speed Hack ON ✅", speedOff = "Speed Hack OFF",
        jumpOn = "Jump Power ON ✅", jumpOff = "Jump Power OFF",
        bank = "Банк", bankRings = "Банк (кольца)", armory1 = "Оружейная 1", armory2 = "Оружейная 2", armory3 = "Оружейная 3",
        militaryBase = "Военная база (улица)", militaryBunker = "Военная база (бункер)", police = "Полицейский участок",
        paintball = "Магазин пейнтбола", blackMarket = "Чёрный рынок", credit = "script by DevScripts",
    }
}

local function t(key)
    return lang[language][key] or key
end

local Coords = {
    Bank = Vector3.new(1117.9, 8.2, -327.3), BankRings = Vector3.new(1593.5, 8.4, -690.6),
    Armory1 = Vector3.new(674.3, 6.2, -683.3), Armory2 = Vector3.new(1597.1, 6.2, -614.1),
    Armory3 = Vector3.new(1128.3, 25.3, -1332.6), MilitaryBase = Vector3.new(797.8, 25.3, -1334.2),
    MilitaryBunker = Vector3.new(371.6, 15.1, -1360.1), Police = Vector3.new(605.2, 9.0, -833.5),
    Paintball = Vector3.new(1769.3, 6.2, -432.6), BlackMarket = Vector3.new(656.4, -16.5, -73.5),
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TopkaHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 560)
mainFrame.Position = UDim2.new(0.5, -160, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 30)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(180, 80, 255)
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 5, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 5, 30)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 10, 70))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

-- TOP BAR
local topBar = Instance.new("TextButton")
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(35, 10, 60)
topBar.BackgroundTransparency = 0.1
topBar.BorderSizePixel = 0
topBar.Text = ""
topBar.AutoButtonColor = false
topBar.Active = true
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 20)
topCorner.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = t("title")
title.TextColor3 = Color3.fromRGB(200, 80, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(0.82, 0, 0, 7)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 150)
minimizeBtn.Text = "─"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.TextSize = 20
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(0.9, 0, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 50)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function() playClick() screenGui:Destroy() end)

local expandBtn = Instance.new("ImageButton")
expandBtn.Size = UDim2.new(0, 60, 0, 60)
expandBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
expandBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
expandBtn.BackgroundTransparency = 1
expandBtn.Image = "rbxassetid://106736027475149"
expandBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
expandBtn.Visible = false
expandBtn.Parent = screenGui

local expandCorner = Instance.new("UICorner")
expandCorner.CornerRadius = UDim.new(0, 16)
expandCorner.Parent = expandBtn

local function minimizeGUI()
    if isMinimized then return end
    isMinimized = true
    savedPosition = mainFrame.Position
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1
    }):Play()
    task.wait(0.3)
    mainFrame.Visible = false
    expandBtn.Visible = true
    expandBtn.Size = UDim2.new(0, 10, 0, 10)
    expandBtn.Position = UDim2.new(0.5, -5, 0.5, -5)
    TweenService:Create(expandBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 60, 0, 60), Position = UDim2.new(0.02, 0, 0.02, 0)
    }):Play()
end

local function expandGUI()
    if not isMinimized then return end
    isMinimized = false
    TweenService:Create(expandBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 10, 0, 10), Position = UDim2.new(0.5, -5, 0.5, -5)}):Play()
    task.wait(0.2)
    expandBtn.Visible = false
    mainFrame.Visible = true
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.BackgroundTransparency = 0.05
    local targetPos = savedPosition or UDim2.new(0.5, -160, 0.2, 0)
    mainFrame.Position = UDim2.new(targetPos.X.Scale, targetPos.X.Offset, targetPos.Y.Scale, targetPos.Y.Offset)
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 320, 0, 560)}):Play()
end

minimizeBtn.MouseButton1Click:Connect(function() playClick() minimizeGUI() end)
expandBtn.MouseButton1Click:Connect(function() playClick() expandGUI() end)

-- DRAG
local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch 
       or input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local btnPos = minimizeBtn.AbsolutePosition
        local btnPos2 = closeBtn.AbsolutePosition
        local btnSize = minimizeBtn.AbsoluteSize
        if mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X
           and mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y then
            return
        end
        if mousePos.X >= btnPos2.X and mousePos.X <= btnPos2.X + btnSize.X
           and mousePos.Y >= btnPos2.Y and mousePos.Y <= btnPos2.Y + btnSize.Y then
            return
        end
        
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and dragStart and startPos 
       and (input.UserInputType == Enum.UserInputType.Touch 
       or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- TABS
local tabNames = {"Main", "Player", "Teleports", "Settings"}
local tabButtons = {}
local tabContents = {}

local tabPanel = Instance.new("ScrollingFrame")
tabPanel.Size = UDim2.new(1, 0, 0, 45)
tabPanel.Position = UDim2.new(0, 0, 0, 48)
tabPanel.BackgroundColor3 = Color3.fromRGB(35, 10, 60)
tabPanel.BackgroundTransparency = 0.3
tabPanel.BorderSizePixel = 0
tabPanel.ScrollBarThickness = 3
tabPanel.CanvasSize = UDim2.new(0, #tabNames * 100, 0, 0)
tabPanel.Active = true
tabPanel.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 5)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Parent = tabPanel

for _, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 73, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
    btn.BackgroundTransparency = 0.5
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabPanel
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    tabButtons[name] = btn
end

local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, 0, 1, -98)
contentFrame.Position = UDim2.new(0, 0, 0, 96)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 10
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 150, 255)
contentFrame.ScrollBarImageTransparency = 0.1
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
contentFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
contentFrame.Active = true
contentFrame.Parent = mainFrame

for _, name in ipairs(tabNames) do
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.Position = UDim2.new(0, 0, 0, 0)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 8
    container.ScrollBarImageColor3 = Color3.fromRGB(200, 150, 255)
    container.CanvasSize = UDim2.new(0, 0, 0, 1000)
    container.ScrollingDirection = Enum.ScrollingDirection.Y
    container.Active = true
    container.Visible = (name == "Main")
    container.Parent = contentFrame
    tabContents[name] = container
end

local function createBtn(text, yPos, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 260, 0, 45)
    btn.Position = UDim2.new(0.5, -130, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 17
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    if callback then
        btn.MouseButton1Click:Connect(function() playClick() callback() end)
    end
    return btn
end

print("Topka Hub - Часть 1 загружена! Вставьте Часть 2")
-- script by DevScripts
-- Topka Hub
-- ЧАСТЬ 2

-- MAIN (пока пустая)
local mainWelcome = Instance.new("TextLabel")
mainWelcome.Size = UDim2.new(1, 0, 0, 40)
mainWelcome.Position = UDim2.new(0, 0, 0, 40)
mainWelcome.BackgroundTransparency = 1
mainWelcome.Text = "Topka Hub"
mainWelcome.TextColor3 = Color3.fromRGB(200, 80, 255)
mainWelcome.TextSize = 26
mainWelcome.Font = Enum.Font.GothamBold
mainWelcome.Parent = tabContents["Main"]

local mainSub = Instance.new("TextLabel")
mainSub.Size = UDim2.new(1, 0, 0, 30)
mainSub.Position = UDim2.new(0, 0, 0, 80)
mainSub.BackgroundTransparency = 1
mainSub.Text = "script by DevScripts"
mainSub.TextColor3 = Color3.fromRGB(150, 100, 200)
mainSub.TextSize = 14
mainSub.Font = Enum.Font.GothamBold
mainSub.Parent = tabContents["Main"]

-- TELEPORTS
createBtn(t("bank"), 40, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.Bank) end
end)
createBtn(t("bankRings"), 90, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.BankRings) end
end)
createBtn(t("armory1"), 140, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.Armory1) end
end)
createBtn(t("armory2"), 190, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.Armory2) end
end)
createBtn(t("armory3"), 240, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.Armory3) end
end)
createBtn(t("militaryBase"), 290, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.MilitaryBase) end
end)
createBtn(t("militaryBunker"), 340, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.MilitaryBunker) end
end)
createBtn(t("police"), 390, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.Police) end
end)
createBtn(t("paintball"), 440, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.Paintball) end
end)
createBtn(t("blackMarket"), 490, tabContents["Teleports"], function() 
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then root.CFrame = CFrame.new(Coords.BlackMarket) end
end)

-- PLAYER: SPEED
local speedHackBtn = createBtn(t("speedHack"), 40, tabContents["Player"], nil)

local speedStatus = Instance.new("TextButton")
speedStatus.Size = UDim2.new(0, 260, 0, 35)
speedStatus.Position = UDim2.new(0.5, -130, 0, 95)
speedStatus.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
speedStatus.BackgroundTransparency = 0.3
speedStatus.Text = t("speedOff")
speedStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
speedStatus.TextSize = 18
speedStatus.Font = Enum.Font.GothamBold
speedStatus.Parent = tabContents["Player"]
local ssCorner = Instance.new("UICorner")
ssCorner.CornerRadius = UDim.new(0, 10)
ssCorner.Parent = speedStatus

local speedSettings = Instance.new("Frame")
speedSettings.Size = UDim2.new(1, 0, 0, 0)
speedSettings.Position = UDim2.new(0, 0, 0, 135)
speedSettings.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
speedSettings.BackgroundTransparency = 0.3
speedSettings.BorderSizePixel = 0
speedSettings.ClipsDescendants = true
speedSettings.Parent = tabContents["Player"]
local speedSettingsCorner = Instance.new("UICorner")
speedSettingsCorner.CornerRadius = UDim.new(0, 10)
speedSettingsCorner.Parent = speedSettings

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 120, 0, 40)
speedLabel.Position = UDim2.new(0.1, 0, 0, 15)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = t("speed") .. ":"
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.TextSize = 18
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Parent = speedSettings

local speedVal = Instance.new("TextLabel")
speedVal.Size = UDim2.new(0, 70, 0, 40)
speedVal.Position = UDim2.new(0.42, 0, 0, 15)
speedVal.BackgroundTransparency = 1
speedVal.Text = tostring(speedValue)
speedVal.TextColor3 = Color3.fromRGB(200, 150, 255)
speedVal.TextSize = 18
speedVal.Font = Enum.Font.GothamBold
speedVal.Parent = speedSettings

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 40, 0, 40)
speedMinus.Position = UDim2.new(0.6, 0, 0, 15)
speedMinus.BackgroundColor3 = Color3.fromRGB(100, 30, 150)
speedMinus.Text = "-"
speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedMinus.TextSize = 22
speedMinus.Font = Enum.Font.GothamBold
speedMinus.Parent = speedSettings
local smCorner = Instance.new("UICorner")
smCorner.CornerRadius = UDim.new(0, 8)
smCorner.Parent = speedMinus

local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0, 40, 0, 40)
speedPlus.Position = UDim2.new(0.75, 0, 0, 15)
speedPlus.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
speedPlus.TextSize = 22
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Parent = speedSettings
local spCorner = Instance.new("UICorner")
spCorner.CornerRadius = UDim.new(0, 8)
spCorner.Parent = speedPlus

local speedConnection = nil

speedHackBtn.MouseButton1Click:Connect(function()
    playClick()
    speedHackEnabled = not speedHackEnabled
    if speedHackEnabled then
        TweenService:Create(speedHackBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(100, 30, 200)}):Play()
        speedHackBtn.Text = t("speedOn")
        speedHackBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        speedStatus.Text = t("speedOn")
        speedStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        if speedConnection then speedConnection:Disconnect() end
        speedConnection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 16 * speedValue
            end
        end)
    else
        TweenService:Create(speedHackBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(50, 20, 80)}):Play()
        speedHackBtn.Text = t("speedHack")
        speedHackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        speedStatus.Text = t("speedOff")
        speedStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        if speedConnection then speedConnection:Disconnect() speedConnection = nil end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 16 end
    end
end)

speedStatus.MouseButton1Click:Connect(function()
    playClick()
    speedSettingsOpen = not speedSettingsOpen
    TweenService:Create(speedSettings, TweenInfo.new(0.4), {
        Size = speedSettingsOpen and UDim2.new(1, 0, 0, 70) or UDim2.new(1, 0, 0, 0)
    }):Play()
end)

speedMinus.MouseButton1Click:Connect(function()
    playClick()
    speedValue = math.max(speedValue - 1, 1)
    speedVal.Text = tostring(speedValue)
    if speedHackEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 16 * speedValue end
    end
end)

speedPlus.MouseButton1Click:Connect(function()
    playClick()
    speedValue = math.min(speedValue + 1, 200)
    speedVal.Text = tostring(speedValue)
    if speedHackEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = 16 * speedValue end
    end
end)

-- PLAYER: JUMP
local jumpBtn = createBtn(t("jumpPower"), 220, tabContents["Player"], nil)

local jumpStatus = Instance.new("TextButton")
jumpStatus.Size = UDim2.new(0, 260, 0, 35)
jumpStatus.Position = UDim2.new(0.5, -130, 0, 275)
jumpStatus.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
jumpStatus.BackgroundTransparency = 0.3
jumpStatus.Text = t("jumpOff")
jumpStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
jumpStatus.TextSize = 18
jumpStatus.Font = Enum.Font.GothamBold
jumpStatus.Parent = tabContents["Player"]
local jsCorner = Instance.new("UICorner")
jsCorner.CornerRadius = UDim.new(0, 10)
jsCorner.Parent = jumpStatus

local jumpSettings = Instance.new("Frame")
jumpSettings.Size = UDim2.new(1, 0, 0, 0)
jumpSettings.Position = UDim2.new(0, 0, 0, 315)
jumpSettings.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
jumpSettings.BackgroundTransparency = 0.3
jumpSettings.BorderSizePixel = 0
jumpSettings.ClipsDescendants = true
jumpSettings.Parent = tabContents["Player"]
local jumpSettingsCorner = Instance.new("UICorner")
jumpSettingsCorner.CornerRadius = UDim.new(0, 10)
jumpSettingsCorner.Parent = jumpSettings

local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0, 120, 0, 40)
jumpLabel.Position = UDim2.new(0.1, 0, 0, 15)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = t("jump") .. ":"
jumpLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jumpLabel.TextSize = 18
jumpLabel.Font = Enum.Font.GothamBold
jumpLabel.Parent = jumpSettings

local jumpVal = Instance.new("TextLabel")
jumpVal.Size = UDim2.new(0, 70, 0, 40)
jumpVal.Position = UDim2.new(0.42, 0, 0, 15)
jumpVal.BackgroundTransparency = 1
jumpVal.Text = tostring(jumpValue)
jumpVal.TextColor3 = Color3.fromRGB(200, 150, 255)
jumpVal.TextSize = 18
jumpVal.Font = Enum.Font.GothamBold
jumpVal.Parent = jumpSettings

local jumpMinus = Instance.new("TextButton")
jumpMinus.Size = UDim2.new(0, 40, 0, 40)
jumpMinus.Position = UDim2.new(0.6, 0, 0, 15)
jumpMinus.BackgroundColor3 = Color3.fromRGB(100, 30, 150)
jumpMinus.Text = "-"
jumpMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpMinus.TextSize = 22
jumpMinus.Font = Enum.Font.GothamBold
jumpMinus.Parent = jumpSettings
local jmCorner = Instance.new("UICorner")
jmCorner.CornerRadius = UDim.new(0, 8)
jmCorner.Parent = jumpMinus

local jumpPlus = Instance.new("TextButton")
jumpPlus.Size = UDim2.new(0, 40, 0, 40)
jumpPlus.Position = UDim2.new(0.75, 0, 0, 15)
jumpPlus.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
jumpPlus.Text = "+"
jumpPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPlus.TextSize = 22
jumpPlus.Font = Enum.Font.GothamBold
jumpPlus.Parent = jumpSettings
local jpCorner = Instance.new("UICorner")
jpCorner.CornerRadius = UDim.new(0, 8)
jpCorner.Parent = jumpPlus

local jumpConnection = nil

local function getJumpPower()
    if jumpValue == 1 then return 50 else return 50 * jumpValue end
end

jumpBtn.MouseButton1Click:Connect(function()
    playClick()
    jumpPowerEnabled = not jumpPowerEnabled
    if jumpPowerEnabled then
        TweenService:Create(jumpBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(100, 30, 200)}):Play()
        jumpBtn.Text = t("jumpOn")
        jumpBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        jumpStatus.Text = t("jumpOn")
        jumpStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        if jumpConnection then jumpConnection:Disconnect() end
        jumpConnection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.UseJumpPower = true
                char.Humanoid.JumpPower = getJumpPower()
            end
        end)
    else
        TweenService:Create(jumpBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(50, 20, 80)}):Play()
        jumpBtn.Text = t("jumpPower")
        jumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        jumpStatus.Text = t("jumpOff")
        jumpStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
        if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = 50 end
    end
end)

jumpStatus.MouseButton1Click:Connect(function()
    playClick()
    jumpSettingsOpen = not jumpSettingsOpen
    TweenService:Create(jumpSettings, TweenInfo.new(0.4), {
        Size = jumpSettingsOpen and UDim2.new(1, 0, 0, 70) or UDim2.new(1, 0, 0, 0)
    }):Play()
end)

jumpMinus.MouseButton1Click:Connect(function()
    playClick()
    jumpValue = math.max(jumpValue - 1, 1)
    jumpVal.Text = tostring(jumpValue)
    if jumpPowerEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = getJumpPower() end
    end
end)

jumpPlus.MouseButton1Click:Connect(function()
    playClick()
    jumpValue = math.min(jumpValue + 1, 70)
    jumpVal.Text = tostring(jumpValue)
    if jumpPowerEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = getJumpPower() end
    end
end)

print("Topka Hub - Часть 2 загружена! Вставьте Часть 3")
-- script by DevScripts
-- Topka Hub
-- ЧАСТЬ 3

local settingsContainer = tabContents["Settings"]

local COLOR_ACTIVE = Color3.fromRGB(0, 150, 0)
local COLOR_INACTIVE = Color3.fromRGB(0, 0, 0)

-- ЯЗЫК
local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1, 0, 0, 30)
langLabel.Position = UDim2.new(0, 0, 0, 40)
langLabel.BackgroundTransparency = 1
langLabel.Text = t("language") .. ":"
langLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
langLabel.TextSize = 17
langLabel.Font = Enum.Font.GothamBold
langLabel.Parent = settingsContainer

local langEnBtn = createBtn(t("english"), 75, settingsContainer, nil)
local langRuBtn = createBtn(t("russian"), 130, settingsContainer, nil)

langEnBtn.BackgroundColor3 = COLOR_ACTIVE
langRuBtn.BackgroundColor3 = COLOR_INACTIVE

-- ЗВУК ОБЩИЙ
local soundLabel = Instance.new("TextLabel")
soundLabel.Size = UDim2.new(1, 0, 0, 30)
soundLabel.Position = UDim2.new(0, 0, 0, 185)
soundLabel.BackgroundTransparency = 1
soundLabel.Text = t("sound") .. ":"
soundLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
soundLabel.TextSize = 17
soundLabel.Font = Enum.Font.GothamBold
soundLabel.Parent = settingsContainer

local soundBtn = createBtn(t("soundOn"), 220, settingsContainer, nil)
soundBtn.BackgroundColor3 = COLOR_ACTIVE

soundBtn.MouseButton1Click:Connect(function()
    soundEnabled = not soundEnabled
    if soundEnabled then
        soundBtn.Text = t("soundOn")
        soundBtn.BackgroundColor3 = COLOR_ACTIVE
        clickSound:Play()
    else
        soundBtn.Text = t("soundOff")
        soundBtn.BackgroundColor3 = COLOR_INACTIVE
    end
end)

-- ВЫБОР ЗВУКА КЛИКА
local soundChoiceLabel = Instance.new("TextLabel")
soundChoiceLabel.Size = UDim2.new(1, 0, 0, 30)
soundChoiceLabel.Position = UDim2.new(0, 0, 0, 275)
soundChoiceLabel.BackgroundTransparency = 1
soundChoiceLabel.Text = "Click Sound:"
soundChoiceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
soundChoiceLabel.TextSize = 17
soundChoiceLabel.Font = Enum.Font.GothamBold
soundChoiceLabel.Parent = settingsContainer

local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(0, 260, 0, 45)
dropdownFrame.Position = UDim2.new(0.5, -130, 0, 310)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 55)
dropdownFrame.BackgroundTransparency = 0.2
dropdownFrame.BorderSizePixel = 0
dropdownFrame.ZIndex = 5
dropdownFrame.Parent = settingsContainer
local ddCorner = Instance.new("UICorner")
ddCorner.CornerRadius = UDim.new(0, 10)
ddCorner.Parent = dropdownFrame

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, 0, 1, 0)
dropdownBtn.BackgroundTransparency = 1
dropdownBtn.Text = ""
dropdownBtn.ZIndex = 6
dropdownBtn.Parent = dropdownFrame

local dropdownText = Instance.new("TextLabel")
dropdownText.Size = UDim2.new(1, -50, 1, 0)
dropdownText.Position = UDim2.new(0, 12, 0, 0)
dropdownText.BackgroundTransparency = 1
dropdownText.Text = "Variant 1"
dropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownText.TextSize = 16
dropdownText.Font = Enum.Font.GothamBold
dropdownText.TextXAlignment = Enum.TextXAlignment.Left
dropdownText.ZIndex = 6
dropdownText.Parent = dropdownFrame

local dropdownArrow = Instance.new("TextLabel")
dropdownArrow.Size = UDim2.new(0, 40, 1, 0)
dropdownArrow.Position = UDim2.new(1, -45, 0, 0)
dropdownArrow.BackgroundTransparency = 1
dropdownArrow.Text = "⌃\n⌄"
dropdownArrow.TextColor3 = Color3.fromRGB(255, 200, 100)
dropdownArrow.TextSize = 14
dropdownArrow.Font = Enum.Font.GothamBold
dropdownArrow.TextYAlignment = Enum.TextYAlignment.Center
dropdownArrow.ZIndex = 6
dropdownArrow.Parent = dropdownFrame

local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(0, 260, 0, 0)
dropdownList.Position = UDim2.new(0.5, -130, 0, 358)
dropdownList.BackgroundColor3 = Color3.fromRGB(30, 15, 55)
dropdownList.BackgroundTransparency = 0.05
dropdownList.BorderSizePixel = 0
dropdownList.ClipsDescendants = true
dropdownList.Visible = false
dropdownList.ZIndex = 10
dropdownList.Parent = settingsContainer
local dlCorner = Instance.new("UICorner")
dlCorner.CornerRadius = UDim.new(0, 10)
dlCorner.Parent = dropdownList

local dropdownOpen = false
local optionButtons = {}

local soundOptions = {
    {name = "No Sound", id = nil},
    {name = "Variant 1", id = "rbxassetid://101572333845544"},
    {name = "ID: 132078503796732", id = "rbxassetid://132078503796732"},
}

local currentSoundOption = 2

local function applySoundOption(index)
    currentSoundOption = index
    local opt = soundOptions[index]
    dropdownText.Text = opt.name
    if opt.id then
        clickSound.SoundId = opt.id
    end
    clickSound.Volume = 0.5
end

for i, opt in ipairs(soundOptions) do
    local optBtn = Instance.new("TextButton")
    optBtn.Size = UDim2.new(1, -10, 0, 42)
    optBtn.Position = UDim2.new(0, 5, 0, 5 + (i - 1) * 45)
    optBtn.BackgroundColor3 = Color3.fromRGB(50, 25, 80)
    optBtn.Text = opt.name
    optBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    optBtn.TextSize = 15
    optBtn.Font = Enum.Font.GothamBold
    optBtn.ZIndex = 11
    optBtn.Parent = dropdownList
    local obCorner = Instance.new("UICorner")
    obCorner.CornerRadius = UDim.new(0, 8)
    obCorner.Parent = optBtn
    optionButtons[i] = optBtn
    
    optBtn.MouseButton1Click:Connect(function()
        applySoundOption(i)
        TweenService:Create(dropdownList, TweenInfo.new(0.25), {
            Size = UDim2.new(0, 260, 0, 0)
        }):Play()
        task.wait(0.25)
        dropdownList.Visible = false
        dropdownOpen = false
        if soundEnabled then clickSound:Play() end
    end)
end

dropdownBtn.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    if dropdownOpen then
        dropdownList.Visible = true
        TweenService:Create(dropdownList, TweenInfo.new(0.25), {
            Size = UDim2.new(0, 260, 0, 5 + #soundOptions * 45)
        }):Play()
    else
        TweenService:Create(dropdownList, TweenInfo.new(0.25), {
            Size = UDim2.new(0, 260, 0, 0)
        }):Play()
        task.wait(0.25)
        dropdownList.Visible = false
    end
    if soundEnabled then clickSound:Play() end
end)

-- CREDIT
local creditBtn = createBtn(t("credit"), 380, settingsContainer, nil)

-- ОБНОВЛЕНИЕ ЯЗЫКА
local function updateLanguage()
    title.Text = t("title")
    langLabel.Text = t("language") .. ":"
    langEnBtn.Text = t("english")
    langRuBtn.Text = t("russian")
    soundLabel.Text = t("sound") .. ":"
    soundBtn.Text = soundEnabled and t("soundOn") or t("soundOff")
    speedHackBtn.Text = speedHackEnabled and t("speedOn") or t("speedHack")
    jumpBtn.Text = jumpPowerEnabled and t("jumpOn") or t("jumpPower")
    speedLabel.Text = t("speed") .. ":"
    jumpLabel.Text = t("jump") .. ":"
    
    tabButtons["Main"].Text = t("main")
    tabButtons["Player"].Text = t("player")
    tabButtons["Teleports"].Text = t("teleports")
    tabButtons["Settings"].Text = t("settings")
    
    local teleportBtns = {}
    for _, child in ipairs(tabContents["Teleports"]:GetChildren()) do
        if child:IsA("TextButton") then
            table.insert(teleportBtns, child)
        end
    end
    local teleportKeys = {"bank", "bankRings", "armory1", "armory2", "armory3", "militaryBase", "militaryBunker", "police", "paintball", "blackMarket"}
    for i, btn in ipairs(teleportBtns) do
        if teleportKeys[i] then
            btn.Text = t(teleportKeys[i])
        end
    end
end

langEnBtn.MouseButton1Click:Connect(function()
    playClick()
    language = "en"
    langEnBtn.BackgroundColor3 = COLOR_ACTIVE
    langRuBtn.BackgroundColor3 = COLOR_INACTIVE
    updateLanguage()
end)

langRuBtn.MouseButton1Click:Connect(function()
    playClick()
    language = "ru"
    langRuBtn.BackgroundColor3 = COLOR_ACTIVE
    langEnBtn.BackgroundColor3 = COLOR_INACTIVE
    updateLanguage()
end)

-- SWITCH TAB
local function switchTab(tabName)
    currentTab = tabName
    for name, container in pairs(tabContents) do
        container.Visible = (name == tabName)
    end
    for name, btn in pairs(tabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(100, 30, 200)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(50, 20, 80)
            btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
    end
end

for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() playClick() switchTab(name) end)
end

switchTab("Main")

applySoundOption(2)

print("✅ Topka Hub - Полностью загружен!")
