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
    "TONA_TT228",     -- ←←← ЗАМЕНИ ЭТО НА СВОЙ НИК
    "Nikdruga"
}

local hasAccess = false
local myNameLower = string.lower(LocalPlayer.Name)

for _, username in ipairs(allowedUsers) do
    if string.lower(username) == myNameLower then
        hasAccess = true
        break
    end
end

if not hasAccess then
    -- Показываем, какой ник реально у тебя (чтобы было видно в чём ошибка)
    warn("Твой ник в игре: " .. LocalPlayer.Name)
    warn("Он не найден в списке allowedUsers")

    if CoreGui:FindFirstChild("MM2NoAccess") then
        CoreGui.MM2NoAccess:Destroy()
    end

    local blockGui = Instance.new("ScreenGui")
    blockGui.Name = "MM2NoAccess"
    blockGui.ResetOnSpawn = false
    blockGui.Parent = CoreGui

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(10, 15, 25)
    bg.Active = true
    bg.Parent = blockGui

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 10, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 45, 75))
    }
    grad.Rotation = 90
    grad.Parent = bg

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 80)
    title.Position = UDim2.new(0, 0, 0.4, -40)
    title.BackgroundTransparency = 1
    title.Text = "❄ ДОСТУП ЗАКРЫТ ❄"
    title.TextColor3 = Color3.fromRGB(200, 240, 255)
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 45
    title.Parent = bg

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 40)
    sub.Position = UDim2.new(0, 0, 0.4, 40)
    sub.BackgroundTransparency = 1
    sub.Text = "Твой аккаунт ("..LocalPlayer.Name..") не найден в базе."
    sub.TextColor3 = Color3.fromRGB(150, 200, 230)
    sub.Font = Enum.Font.GothamBold
    sub.TextSize = 20
    sub.Parent = bg

    task.spawn(function()
        while task.wait(0.1) do
            local flake = Instance.new("TextLabel")
            flake.Text = "❄"
            flake.TextColor3 = Color3.fromRGB(255, 255, 255)
            flake.TextTransparency = math.random(30, 80) / 100
            flake.BackgroundTransparency = 1
            local size = math.random(15, 30)
            flake.TextSize = size
            flake.Size = UDim2.new(0, size, 0, size)
            flake.Position = UDim2.new(math.random(), 0, -0.1, 0)
            flake.ZIndex = 0
            flake.Parent = bg

            local tween = TweenService:Create(flake, TweenInfo.new(math.random(5, 10), Enum.EasingStyle.Linear), {
                Position = UDim2.new(flake.Position.X.Scale, 0, 1.2, 0),
                Rotation = math.random(-360, 360)
            })
            tween:Play()
            tween.Completed:Connect(function() flake:Destroy() end)
        end
    end)

    return
end

-- Приветствие
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "✅ Доступ разрешен",
        Text = "Добро пожаловать, " .. LocalPlayer.Name .. "!",
        Duration = 3
    })
end)

-- ==========================================
-- БАЗА ЦЕН
-- ==========================================
local mm2Values = {
    -- Tier 4
    ["Traveler's Gun"] = 5600, ["Evergun"] = 3450, ["Constellation"] = 2700, 
    ["Evergreen"] = 2500, ["Turkey"] = 2450, ["Vampire's Gun"] = 1950, 
    ["Alienbeam"] = 1925, ["Darkshot"] = 1775, ["Darksword"] = 1750, 
    ["Raygun"] = 1700, ["Blossom"] = 1360, ["Sakura"] = 1350, 
    ["Sunrise"] = 1125, ["Snowcannon"] = 850, ["Bauble"] = 825, 
    ["Sunset"] = 625, ["Soul"] = 615, ["Spirit"] = 605, 
    ["Rainbow Gun"] = 420, ["Flora"] = 410, ["Rainbow"] = 410, 
    ["Bloom"] = 400,
    -- Tier 3
    ["Heart Wand"] = 340, ["Ocean"] = 285, ["Waves"] = 280, 
    ["Xenoknife"] = 280, ["Xenoshot"] = 280, ["Flowerwood Gun"] = 265, 
    ["Blizzard"] = 260, ["Flowerwood"] = 260, ["Snowstorm"] = 260, 
    ["Snow Dagger"] = 250, ["Watergun"] = 250, ["Icecream"] = 160, 
    ["Treat"] = 155, ["Beachy"] = 150, ["Sands"] = 150, 
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
    ["Chroma Sunrise"] = 13250, ["Chroma Raygun"] = 13250, 
    ["Chroma Sunset"] = 9250, ["Chroma Blizzard"] = 7500, 
    ["Chroma Snowcannon"] = 7750, ["Chroma Snowstorm"] = 4250, 
    ["Chroma Heart Wand"] = 4250, ["Chroma Snow Dagger"] = 3500, 
    ["Chroma Watergun"] = 3400, ["Chroma Treat"] = 2500, 
    ["Chroma Sweet"] = 2250, ["Chroma Icecream"] = 2000, 
    ["Chroma Sands"] = 1900, ["Chroma Beachy"] = 1800, 
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
    ["Celestial"] = 2450, ["Vampire's Axe"] = 1275, 
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
-- ВЕРХНЯЯ ШТОРКА
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
-- ОСНОВНОЕ МЕНЮ
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
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 360, 0, 260),
            BackgroundTransparency = 0.85
        }):Play()
    else
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
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

            local tween = TweenService:Create(flake, TweenInfo.new(math.random(4, 8), Enum.EasingStyle.Linear), {
                Position = UDim2.new(flake.Position.X.Scale, 0, 1.2, 0),
                Rotation = math.random(-360, 360)
            })
            tween:Play()
            tween.Completed:Connect(function() flake:Destroy() end)
        end
    end
end)

-- ==========================================
-- ЛОГИКА РАСЧЁТА
-- ==========================================
local function formatNumber(n)
    local formatted = tostring(n)
    while true do  
        local k
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local function isTrulyVisible(guiElement)
    local current = guiElement
    while current and current:IsA("GuiObject") do
        if not current.Visible then return false end
        current = current.Parent
    end
    return true
end

ChatButton.MouseButton1Click:Connect(function()
    local msg = string.format("Trade Value - Мой офер: %s | Их офер: %s", formatNumber(lastMyTotal), formatNumber(lastTheirTotal))
    pcall(function()
        local TextChatService = game:GetService("TextChatService")
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = TextChatService.TextChannels:FindFirstChild("trading") or TextChatService.TextChannels:FindFirstChild("RBXGeneral")
            if channel then channel:SendAsync(msg) end
        else
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "trading")
        end
    end)
end)

local function getSlotFrame(element, tradeGui)
    local current = element
    while current and current.Parent do
        local p = current.Parent
        local pName = p.Name:lower()
        if p == tradeGui or p:IsA("ScreenGui") or p:IsA("ScrollingFrame") or 
           pName:find("offer") or pName:find("container") or pName:find("slots") or pName == "tradegui" then
            return current
        end
        current = p
    end
    return element.Parent
end

local function getSlotValue(slotFrame)
    local rawName = nil
    local multiplier = 1
    local isChroma = false

    for _, child in ipairs(slotFrame:GetDescendants()) do
        if child:IsA("GuiObject") and isTrulyVisible(child) then
            if child.Name:lower():find("chroma") then
                isChroma = true
            end

            if child:IsA("TextLabel") then
                local txt = child.Text

                if txt:lower():find("chroma") then
                    isChroma = true
                end

                local count = string.match(txt, "[xX]%s*(%d+)") or string.match(txt, "(%d+)%s*[xX]")
                if count then
                    local num = tonumber(count)
                    if num and num > multiplier then
                        multiplier = num
                    end
                end

                if mm2Values[txt] or mm2Values["Chroma " .. txt] or mm2Values["C. " .. txt] then
                    rawName = txt
                end

            elseif child:IsA("ImageLabel") or child:IsA("ImageButton") then
                if child.Image:lower():find("chroma") then
                    isChroma = true
                end
            end
        end
    end

    if rawName then
        local valKey = rawName
        if isChroma then
            if mm2Values["Chroma " .. rawName] then
                valKey = "Chroma " .. rawName
            elseif mm2Values["C. " .. rawName] then
                valKey = "C. " .. rawName
            end
        end
        local baseValue = mm2Values[valKey] or mm2Values[rawName] or 0
        return baseValue * multiplier
    end
    return 0
end

local function calculateValues()
    local myTotal = 0
    local theirTotal = 0
    local countedSlots = {}

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end

    local tradeGui = playerGui:FindFirstChild("TradeGUI")
    if tradeGui and tradeGui.Enabled then
        local container = tradeGui:FindFirstChild("Container") or tradeGui
        local guiCenterY = container.AbsolutePosition.Y + (container.AbsoluteSize.Y / 2)

        if guiCenterY == 0 then
            guiCenterY = workspace.CurrentCamera.ViewportSize.Y / 2
        end

        for _, element in ipairs(tradeGui:GetDescendants()) do
            if element:IsA("TextLabel") and isTrulyVisible(element) then
                if not element:FindFirstAncestorWhichIsA("ScrollingFrame") then
                    local txt = element.Text
                    if mm2Values[txt] or mm2Values["Chroma " .. txt] or mm2Values["C. " .. txt] then
                        local slotFrame = getSlotFrame(element, tradeGui)
                        if slotFrame and not countedSlots[slotFrame] then
                            countedSlots[slotFrame] = true
                            local slotVal = getSlotValue(slotFrame)

                            if element.AbsolutePosition.Y < guiCenterY then
                                myTotal = myTotal + slotVal
                            else
                                theirTotal = theirTotal + slotVal
                            end
                        end
                    end
                end
            end
        end
    end

    lastMyTotal = myTotal
    lastTheirTotal = theirTotal

    MyValueLabel.Text = "Моя сторона: " .. formatNumber(myTotal)
    TheirValueLabel.Text = "Их сторона: " .. formatNumber(theirTotal)

    local diff = theirTotal - myTotal
    if diff > 0 then
        DiffLabel.Text = "+" .. formatNumber(diff)
        DiffLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
    elseif diff < 0 then
        DiffLabel.Text = "-" .. formatNumber(math.abs(diff))
        DiffLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    else
        DiffLabel.Text = "="
        DiffLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    end
end

task.spawn(function()
    while task.wait(0.3) do
        pcall(calculateValues)
    end
end)
