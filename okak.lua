-- Вызов основных сервисов
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
 
-- ==========================================
-- СИСТЕМА ДОСТУПА (WHITELIST)
-- ==========================================
local allowedUsers = {
    "ТвойРеальныйНик1", -- Замени на свой ник
    "НикДруга",         -- Добавляй новых людей через запятую
    "ЕщеОдинНик"
}
 
local hasAccess = false
for _, username in ipairs(allowedUsers) do
    if username == LocalPlayer.Name then
        hasAccess = true
        break
    end
end
 
if not hasAccess then
    -- Показываем ошибку и останавливаем скрипт
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ Доступ закрыт",
            Text = "У вас нет разрешения на использование скрипта.",
            Duration = 5
        })
    end)
    return -- Эта команда полностью обрывает загрузку скрипта дальше
end
 
-- Приветствие при успешном входе
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✅ Доступ разрешен",
        Text = "Добро пожаловать, " .. LocalPlayer.Name .. "!",
        Duration = 3
    })
end)
 
-- ==========================================
-- БАЗА ЦЕН SUPREME VALUES
-- ==========================================
local mm2Values = {
    -- Tier 4
    ["Traveler's Gun"] = 5600, ["Evergun"] = 3450, ["Constellation"] = 2700, 
    ["Evergreen"] = 2500, ["Turkey"] = 2450, ["Vampire's Gun"] = 1950, 
    ["Alienbeam"] = 1975, ["Darkshot"] = 1775, ["Darksword"] = 1750, 
    ["Raygun"] = 1750, ["Blossom"] = 1360, ["Sakura"] = 1350, 
    ["Sunrise"] = 1125, ["Snowcannon"] = 850, ["Bauble"] = 825, 
    ["Sunset"] = 625, ["Soul"] = 615, ["Spirit"] = 605, 
    ["Rainbow Gun"] = 420, ["Flora"] = 410, ["Rainbow"] = 410, 
    ["Bloom"] = 400,
    -- Tier 3
    ["Heart Wand"] = 340, ["Ocean"] = 285, ["Waves"] = 280, 
    ["Xenoknife"] = 280, ["Xenoshot"] = 280, ["Flowerwood Gun"] = 265, 
    ["Blizzard"] = 260, ["Flowerwood"] = 260, ["Snowstorm"] = 260, 
    ["Snow Dagger"] = 250, ["Watergun"] = 250, ["Icecream"] = 135, 
    ["Treat"] = 155, ["Beachy"] = 145, ["Sands"] = 145, 
    ["Sweet"] = 150, ["Borealis"] = 145, ["Australis"] = 140, 
    ["Bat"] = 120, ["Pearlshine"] = 85, ["Pearl"] = 80, 
    ["Candy"] = 80, ["Heartblade"] = 65,
    -- Tier 2
    ["Luger"] = 40, ["Red Luger"] = 37, ["Phantom"] = 35, 
    ["Spectre"] = 35, ["Candleflame"] = 33, ["Darkbringer"] = 33, 
    ["Elderwood Blade"] = 33, ["Elderwood Revolver"] = 33, 
    ["Iceblaster"] = 33, ["Lightbringer"] = 33, ["Makeshift"] = 33, 
    ["Sugar"] = 32, ["Ornament"] = 32, ["Green Luger"] = 23, 
    ["Amerilaser"] = 22, ["Laser"] = 22, ["Hallowgun"] = 20, 
    ["Nightblade"] = 20, ["Shark"] = 20,
    -- Tier 1
    ["Icebeam"] = 18, ["Plasmabeam"] = 18, ["Swirly Gun"] = 18, 
    ["Battleaxe II"] = 17, ["Blaster"] = 17, ["Ginger Luger"] = 17, 
    ["Pixel"] = 17, ["Gemstone"] = 15, ["Iceflake"] = 15, 
    ["Old Glory"] = 15, ["Plasmablade"] = 15, ["Slasher"] = 15, 
    ["Vampire's Edge"] = 15, ["Cookiecane"] = 13, ["Deathshard"] = 13, 
    ["Eternalcane"] = 13, ["Gingerblade"] = 13, ["Jinglegun"] = 13, 
    ["Lugercane"] = 13, ["Minty"] = 13, ["Nebula"] = 13, 
    ["Virtual"] = 13, ["Battleaxe"] = 12, ["Gingermint"] = 12, 
    ["Swirly Blade"] = 12, ["Chill"] = 10, ["Clockwork"] = 10, 
    ["Fang"] = 10, ["Frostsaber"] = 10, ["Heat"] = 10, 
    ["Spider"] = 10, ["Tides"] = 10,
    -- Tier 0
    ["Bioblade"] = 8, ["Eternal III"] = 8, ["Eternal IV"] = 8, 
    ["Hallow's Blade"] = 8, ["Hallow's Edge"] = 8, ["Handsaw"] = 8, 
    ["Boneblade"] = 7, ["Eternal"] = 7, ["Eternal II"] = 7, 
    ["Frostbite"] = 7, ["Ghostblade"] = 7, ["Ice Dragon"] = 7, 
    ["Ice Shard"] = 7, ["Prismatic"] = 7, ["Pumpking"] = 7, 
    ["Saw"] = 7, ["Xmas"] = 7, ["Eggblade"] = 5, ["Flames"] = 5, 
    ["Snowflake"] = 5, ["Winter's Edge"] = 5, ["Peppermint"] = 4, 
    ["Cookieblade"] = 3, ["Blue Seer"] = 3, ["Purple Seer"] = 3, 
    ["Red Seer"] = 3, ["Seer"] = 3, ["Orange Seer"] = 2, 
    ["Yellow Seer"] = 2,
    -- Tier 3 (Chroma)
    ["C. Traveler's Gun"] = 220000, ["Chroma Evergun"] = 75000, 
    ["Chroma Evergreen"] = 48000, ["Chroma Bauble"] = 34000, 
    ["C. Vampire's Gun"] = 29000, ["C. Constellation"] = 27000, 
    ["Chroma Alienbeam"] = 24000,
    -- Tier 2 (Chroma)
    ["Chroma Raygun"] = 13500, ["Chroma Sunrise"] = 13250, 
    ["Chroma Sunset"] = 9250, ["Chroma Snowcannon"] = 7750, 
    ["Chroma Blizzard"] = 7250, ["Chroma Snowstorm"] = 4250, 
    ["Chroma Heart Wand"] = 4250, ["Chroma Snow Dagger"] = 3500, 
    ["Chroma Watergun"] = 3400, ["Chroma Treat"] = 2400, 
    ["Chroma Sweet"] = 2200, ["Chroma Icecream"] = 1900, 
    ["Chroma Sands"] = 1850, ["Chroma Beachy"] = 1750, 
    ["Chroma Ornament"] = 1800,
    -- Tier 1 (Chroma & Pets)
    ["Chroma Darkbringer"] = 65, ["Chroma Lightbringer"] = 60, 
    ["Chroma Luger"] = 50, ["Chroma Candleflame"] = 40, 
    ["Chroma Laser"] = 40, ["Chroma Swirly Gun"] = 38, 
    ["C. Elderwood Blade"] = 37, ["Chroma Deathshard"] = 35, 
    ["Chroma Cookiecane"] = 32, ["Chroma Fang"] = 32, 
    ["Chroma Gemstone"] = 32, ["Chroma Shark"] = 32, 
    ["Chroma Slasher"] = 32, ["Chroma Heat"] = 28, 
    ["Chroma Seer"] = 28, ["Chroma Gingerblade"] = 27, 
    ["Chroma Tides"] = 27, ["Chroma Saw"] = 23, 
    ["Chroma Boneblade"] = 22, ["Chroma Fire Bat"] = 3, 
    ["Chroma Fire Bear"] = 3, ["Chroma Fire Bunny"] = 3, 
    ["Chroma Fire Cat"] = 3, ["Chroma Fire Dog"] = 3, 
    ["Chroma Fire Fox"] = 3, ["Chroma Fire Pig"] = 3,
    -- Ancients / Misc
    ["Gingerscope"] = 17750, ["Traveler's Axe"] = 8100, 
    ["Celestial"] = 2450, ["Vampire's Axe"] = 1300, 
    ["Harvester"] = 250, ["Icepiercer"] = 160, ["Icebreaker"] = 65, 
    ["Batwing"] = 42, ["Elderwood Scythe"] = 38, 
    ["Swirly Axe"] = 38, ["Hallowscythe"] = 30, 
    ["Logchopper"] = 18, ["Icewing"] = 13
}
 
local lastMyTotal = 0
local lastTheirTotal = 0
 
-- Удаляем старое GUI
if CoreGui:FindFirstChild("MM2WinterCalc") then
    CoreGui.MM2WinterCalc:Destroy()
end
 
-- Основной ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2WinterCalc"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui
 
-- ==========================================
-- ДИЗАЙН: ВЕРХНЯЯ "ШТОРКА"
-- ==========================================
local TopIsland = Instance.new("TextButton")
TopIsland.Size = UDim2.new(0, 160, 0, 35)
TopIsland.Position = UDim2.new(0.5, -80, 0, 15)
TopIsland.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
TopIsland.Text = "❄ MM2 Calc"
TopIsland.TextColor3 = Color3.fromRGB(220, 240, 255)
TopIsland.Font = Enum.Font.GothamBold
TopIsland.TextSize = 15
TopIsland.AutoButtonColor = false
TopIsland.Draggable = true
TopIsland.Active = true
TopIsland.Parent = ScreenGui
 
local IslandCorner = Instance.new("UICorner")
IslandCorner.CornerRadius = UDim.new(1, 0)
IslandCorner.Parent = TopIsland
 
local IslandStroke = Instance.new("UIStroke")
IslandStroke.Color = Color3.fromRGB(255, 255, 255)
IslandStroke.Transparency = 0.8
IslandStroke.Thickness = 1
IslandStroke.Parent = TopIsland
 
-- ==========================================
-- ДИЗАЙН: ОСНОВНОЕ МЕНЮ
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 260)
MainFrame.Position = UDim2.new(0.5, -180, 0, 60)
MainFrame.BackgroundColor3 = Color3.fromRGB(200, 230, 255)
MainFrame.BackgroundTransparency = 0.85
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Active = true       
MainFrame.Draggable = true    
MainFrame.Parent = ScreenGui
 
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame
 
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 210, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame
 
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.5
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame
 
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Supreme Values"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 22
TitleLabel.ZIndex = 2
TitleLabel.Parent = MainFrame
 
local MyValueLabel = Instance.new("TextLabel")
MyValueLabel.Size = UDim2.new(1, -40, 0, 40)
MyValueLabel.Position = UDim2.new(0, 20, 0, 45)
MyValueLabel.BackgroundTransparency = 1
MyValueLabel.Text = "Моя сторона: 0"
MyValueLabel.TextColor3 = Color3.fromRGB(120, 255, 170)
MyValueLabel.Font = Enum.Font.GothamBold
MyValueLabel.TextSize = 20
MyValueLabel.TextXAlignment = Enum.TextXAlignment.Left
MyValueLabel.ZIndex = 2
MyValueLabel.Parent = MainFrame
 
local TheirValueLabel = Instance.new("TextLabel")
TheirValueLabel.Size = UDim2.new(1, -40, 0, 40)
TheirValueLabel.Position = UDim2.new(0, 20, 0, 85)
TheirValueLabel.BackgroundTransparency = 1
TheirValueLabel.Text = "Их сторона: 0"
TheirValueLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
TheirValueLabel.Font = Enum.Font.GothamBold
TheirValueLabel.TextSize = 20
TheirValueLabel.TextXAlignment = Enum.TextXAlignment.Left
TheirValueLabel.ZIndex = 2
TheirValueLabel.Parent = MainFrame
 
local DiffLabel = Instance.new("TextLabel")
DiffLabel.Size = UDim2.new(1, -40, 0, 40)
DiffLabel.Position = UDim2.new(0, 20, 0, 125)
DiffLabel.BackgroundTransparency = 1
DiffLabel.Text = "="
DiffLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
DiffLabel.Font = Enum.Font.GothamBlack
DiffLabel.TextSize = 24
DiffLabel.TextXAlignment = Enum.TextXAlignment.Center
DiffLabel.ZIndex = 2
DiffLabel.Parent = MainFrame
 
local ChatButton = Instance.new("TextButton")
ChatButton.Size = UDim2.new(1, -40, 0, 45)
ChatButton.Position = UDim2.new(0, 20, 1, -65)
ChatButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ChatButton.BackgroundTransparency = 0.8
ChatButton.Text = "Отправить в [trading]"
ChatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatButton.Font = Enum.Font.GothamBold
ChatButton.TextSize = 16
ChatButton.ZIndex = 2
ChatButton.AutoButtonColor = false
ChatButton.Parent = MainFrame
 
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 12)
BtnCorner.Parent = ChatButton
 
local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(255, 255, 255)
BtnStroke.Transparency = 0.4
BtnStroke.Thickness = 1
BtnStroke.Parent = ChatButton
 
-- ==========================================
-- АНИМАЦИИ
-- ==========================================
local isMenuOpen = false
TopIsland.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    if isMenuOpen then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 360, 0, 0)
        MainFrame.BackgroundTransparency = 1
 
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0, 360, 0, 260),
            BackgroundTransparency = 0.85
        }):Play()
    else
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        local closeTween = TweenService:Create(MainFrame, tweenInfo, {
            Size = UDim2.new(0, 360, 0, 0),
            BackgroundTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            if not isMenuOpen then MainFrame.Visible = false end
        end)
    end
end)
 
ChatButton.MouseEnter:Connect(function()
    TweenService:Create(ChatButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
end)
ChatButton.MouseLeave:Connect(function()
    TweenService:Create(ChatButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
end)
 
task.spawn(function()
    while task.wait(0.15) do
        if isMenuOpen then
            local flake = Instance.new("TextLabel")
            flake.Text = "❄"
            flake.TextColor3 = Color3.fromRGB(255, 255, 255)
            flake.TextTransparency = math.random(20, 70) / 100
            flake.BackgroundTransparency = 1
            local size = math.random(10, 24)
            flake.TextSize = size
            flake.Size = UDim2.new(0, size, 0, size)
            flake.Position = UDim2.new(math.random(), 0, -0.1, 0)
            flake.ZIndex = 1
            flake.Parent = MainFrame
 
            local duration = math.random(4, 8)
            local endY = 1.2
            local spin = math.random(-360, 360)
 
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(flake, tweenInfo, {
                Position = UDim2.new(flake.Position.X.Scale, 0, endY, 0),
                Rotation = spin
            })
 
            tween:Play()
            tween.Completed:Connect(function()
                flake:Destroy()
            end)
        end
    end
end)
 
-- ==========================================
-- СИСТЕМЫ И ЛОГИКА РАСЧЕТА
-- ==========================================
local function formatNumber(n)
    if not n then return "0" end
    return tostring(n):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end
 
local function calculateTotal(playerName)
    local player = Players:FindFirstChild(playerName)
    if not player or not player:FindFirstChild("Data") or not player.Data:FindFirstChild("Inventory") or not player.Data.Inventory:FindFirstChild("Weapons") then
        return 0
    end
    
    local total = 0
    for _, item in ipairs(player.Data.Inventory.Weapons:GetChildren()) do
        local itemName = item.Name
        if mm2Values[itemName] then
            if item:FindFirstChild("Count") and item.Count:IsA("IntValue") then
                total = total + (mm2Values[itemName] * item.Count.Value)
            else
                total = total + mm2Values[itemName]
            end
        end
    end
    return total
end
 
local function sendTradeMessage()
    local myAmountText = formatNumber(lastMyTotal)
    local theirAmountText = formatNumber(lastTheirTotal)
    
    local diff = lastMyTotal - lastTheirTotal
    local status = ""
    if diff > 0 then
        status = "В плюсе на: " .. formatNumber(diff)
    elseif diff < 0 then
        status = "В минусе на: " .. formatNumber(math.abs(diff))
    else
        status = "Равный обмен"
    end
 
    local message = string.format("Мои: %s | Их: %s | Итог: %s (Supreme Values)", myAmountText, theirAmountText, status)
    
    local tcs = game:GetService("TextChatService")
    if tcs.ChatVersion == Enum.ChatVersion.TextChatService then
        local channel = tcs.TextChannels:FindFirstChild("RBXGeneral") or tcs.TextChannels:FindFirstChild("RBXSystem")
        if channel then
            channel:SendAsync(message)
        end
    else
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(message, "All")
    end
end
 
ChatButton.MouseButton1Click:Connect(sendTradeMessage)
 
local function getTradingPartner()
    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    if not gui then return nil end
 
    local mainGUI = gui:FindFirstChild("MainGUI")
    if mainGUI and mainGUI:FindFirstChild("Game") and mainGUI.Game:FindFirstChild("Trading") then
        local targetName = mainGUI.Game.Trading.Player2.PlayerName.Text
        if targetName and targetName ~= "Player" and targetName ~= "" then
            return targetName
        end
    end
    return nil
end
 
-- Цикл обновления
RunService.RenderStepped:Connect(function()
    if isMenuOpen then
        local myTotal = calculateTotal(LocalPlayer.Name)
        local partnerName = getTradingPartner()
        local theirTotal = 0
        
        if partnerName then
            theirTotal = calculateTotal(partnerName)
            TheirValueLabel.Text = "Их сторона ("..partnerName.."): " .. formatNumber(theirTotal)
        else
            TheirValueLabel.Text = "Их сторона: Нет трейда"
        end
 
        MyValueLabel.Text = "Моя сторона: " .. formatNumber(myTotal)
        
        lastMyTotal = myTotal
        lastTheirTotal = theirTotal
 
        if partnerName then
            local diff = myTotal - theirTotal
            if diff > 0 then
                DiffLabel.Text = "Loss: -" .. formatNumber(diff)
                DiffLabel.TextColor3 = Color3.fromRGB(255, 100, 100) -- Red
            elseif diff < 0 then
                DiffLabel.Text = "Win: +" .. formatNumber(math.abs(diff))
                DiffLabel.TextColor3 = Color3.fromRGB(100, 255, 100) -- Green
            else
                DiffLabel.Text = "Fair"
                DiffLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- Gray
            end
        else
            DiffLabel.Text = "="
            DiffLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
        end
    end
end)
