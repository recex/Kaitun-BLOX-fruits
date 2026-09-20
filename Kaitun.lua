--[[
    KAITUN MEGA HUB - BLOX FRUITS
    Funcionalidade: Sea 1 -> Sea 2 -> Sea 3 (Level Max)
    Recursos: Auto Farm, Auto Quest, Pegar Tudo, Console de Erros/Logs
]]

-- ========================================== --
--               LOG SYSTEM                   --
-- ========================================== --
local Logs = {}
local function AddLog(msg, isError)
    local time = os.date("%H:%M:%S")
    local prefix = isError and "[ERRO] " or "[INFO] "
    local finalMsg = time .. " | " .. prefix .. msg
    table.insert(Logs, finalMsg)
    if #Logs > 100 then table.remove(Logs, 1) end -- Limite de logs
    if HubUI and HubUI.ConsoleList then
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,0,0,20)
        txt.BackgroundTransparency = 1
        txt.Text = finalMsg
        txt.TextColor3 = isError and Color3.fromRGB(255,80,80) or Color3.fromRGB(200,200,200)
        txt.TextXAlignment = Enum.TextXAlignment.Left
        txt.Font = Enum.Font.Code
        txt.TextSize = 13
        txt.Parent = HubUI.ConsoleList
        HubUI.ConsoleList.CanvasSize = UDim2.new(0,0,0, HubUI.ConsoleList.UIListLayout.AbsoluteContentSize.Y)
    end
    print(finalMsg)
end

-- ========================================== --
--               MEGA HUB UI                  --
-- ========================================== --
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "KaitunMegaHub"

local HubUI = {}
HubUI.ConsoleList = nil

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 800, 0, 500)
main.Position = UDim2.new(0.5, -400, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

-- Title
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(15,15,15)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "🏴‍☠️ KAITUN MEGA HUB | SEA 1 -> 3 | GET ALL"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 8)

-- Tabs (Left Side)
local tabs = Instance.new("Frame", main)
tabs.Size = UDim2.new(0, 150, 1, -40)
tabs.Position = UDim2.new(0,0,0,40)
tabs.BackgroundColor3 = Color3.fromRGB(30,30,30)

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -150, 1, -40)
content.Position = UDim2.new(0,150,0,40)
content.BackgroundColor3 = Color3.fromRGB(35,35,35)

-- Console Setup (Right Side)
local consoleFrame = Instance.new("Frame", content)
consoleFrame.Size = UDim2.new(1,-10,1,-45)
consoleFrame.Position = UDim2.new(0,5,0,35)
consoleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
consoleFrame.ClipsDescendants = true
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 5)

local consoleList = Instance.new("ScrollingFrame", consoleFrame)
consoleList.Size = UDim2.new(1,-10,1,-10)
consoleList.Position = UDim2.new(0,5,0,5)
consoleList.BackgroundTransparency = 1
consoleList.ScrollBarThickness = 5
local layout = Instance.new("UIListLayout", consoleList)
layout.SortOrder = Enum.SortOrder.LayoutOrder
HubUI.ConsoleList = consoleList

-- Copy Logs Button
local copyBtn = Instance.new("TextButton", content)
copyBtn.Size = UDim2.new(0,100,0,25)
copyBtn.Position = UDim2.new(1,-110,0,5)
copyBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.Text = "Copiar Logs"
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 5)
copyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        setclipboard(table.concat(Logs, "\n"))
        AddLog("Logs copiados para o clipboard!", false)
    end)
end)

-- Status Label
local statusLbl = Instance.new("TextLabel", content)
statusLbl.Size = UDim2.new(1,-120,0,25)
statusLbl.Position = UDim2.new(0,10,0,5)
statusLbl.BackgroundTransparency = 1
statusLbl.TextColor3 = Color3.fromRGB(0,255,0)
statusLbl.Text = "STATUS: INICIANDO(0)..."
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.Font = Enum.Font.GothamBold
statusLbl.TextSize = 14

-- Toggle Buttons Setup
local toggles = {}
local function CreateToggle(name, yPos, default)
    local btn = Instance.new("TextButton", tabs)
    btn.Size = UDim2.new(1,-10,0,35)
    btn.Position = UDim2.new(0,5,0,yPos)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Text = name .. ": OFF"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    toggles[name] = default
    if default then btn.Text = name .. ": ON" btn.BackgroundColor3 = Color3.fromRGB(0,150,0) end
    
    btn.MouseButton1Click:Connect(function()
        toggles[name] = not toggles[name]
        btn.Text = name .. (toggles[name] and ": ON" or ": OFF")
        btn.BackgroundColor3 = toggles[name] and Color3.fromRGB(0,150,0) or Color3.fromRGB(45,45,45)
        AddLog("Toggle " .. name .. " alterado para " .. tostring(toggles[name]), false)
    end)
end

CreateToggle("Auto Farm", 10, true)
CreateToggle("Auto Quest", 50, true)
CreateToggle("Fast Attack", 90, true)
CreateToggle("Get All Items", 130, true) -- PEGAR TUDO
CreateToggle("Auto Sea 2/3", 170, true) -- LEVEL MAX THIRD SEA
CreateToggle("Anti-AFK", 210, true)

-- ========================================== --
--            GAME LOGIC & HOOKS              --
-- ========================================== --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- Anti AFK
player.Idled:connect(function()
    if toggles["Anti-AFK"] then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        AddLog("Anti-AFK ativado", false)
    end
end)

-- Safe Invoke
local function SafeInvoke(...)
    local args = {...}
    local success, result = pcall(function()
        return CommF:InvokeServer(unpack(args))
    end)
    if not success then AddLog("CommF_ Falhou: " .. tostring(result), true) end
    return result
end

-- Tween TP (Evita bug de teleporte infinito do Blox Fruits)
local function TeleportTo(CFramePos)
    pcall(function()
        local root = player.Character.HumanoidRootPart
        local dist = (root.Position - CFramePos.Position).Magnitude
        if dist > 1500 then -- Bypass para distancias longas
            root.CFrame = CFramePos
            wait(0.1)
        else
            local tween = game:GetService("TweenService"):Create(root, TweenInfo.new(dist/350, Enum.EasingStyle.Linear), {CFrame = CFramePos})
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

-- Quest Data (Abreviado para caber, mas pega do level 1 ao 1500+)
-- Estrutura: {Level, "QuestName", QuestLvl, "MobName", CFrameQuest, CFrameMob}
local QuestData = {
    {1, "BanditQuest1", 1, "Bandit", CFrame.new(1059, 17, 1547), CFrame.new(1059, 17, 1547)},
    {10, "JungleQuest", 1, "Monkey", CFrame.new(-1598, 36, 153), CFrame.new(-1448, 68, 11)},
    {15, "JungleQuest", 2, "Gorilla", CFrame.new(-1598, 36, 153), CFrame.new(-1129, 41, -525)},
    {30, "BuggyQuest1", 1, "Pirate", CFrame.new(-1141, 5, 3832), CFrame.new(-1103, 14, 3946)},
    {35, "BuggyQuest1", 2, "Brute", CFrame.new(-1141, 5, 3832), CFrame.new(-1140, 15, 4350)},
    {40, "DesertQuest", 1, "Desert Bandit", CFrame.new(894, 6, 4392), CFrame.new(932, 7, 4484)},
    {60, "DesertQuest", 2, "Desert Officer", CFrame.new(894, 6, 4392), CFrame.new(1608, 9, 4371)},
    {90, "SnowQuest", 1, "Snowman", CFrame.new(1389, 88, -1299), CFrame.new(1197, 87, -1417)},
    {100, "SnowQuest", 2, "Winter Warrior", CFrame.new(1389, 88, -1299), CFrame.new(1295, 87, -1240)},
    {120, "MarineQuest2", 1, "Chief Petty Officer", CFrame.new(-5040, 28, 4325), CFrame.new(-4883, 23, 4256)},
    {150, "MarineQuest2", 2, "Sky Bandit", CFrame.new(-5040, 28, 4325), CFrame.new(-4953, 296, -2899)},
    {175, "PrisonerQuest", 1, "Prisoner", CFrame.new(5309, 2, 475), CFrame.new(5433, 89, 515)},
    {190, "PrisonerQuest", 2, "Dangerous Prisoner", CFrame.new(5309, 2, 475), CFrame.new(5433, 89, 515)},
    {210, "ColossumQuest", 1, "Toga Warrior", CFrame.new(-1576, 8, -2983), CFrame.new(-1780, 45, -2736)},
    {250, "ColossumQuest", 2, "Gladiator", CFrame.new(-1576, 8, -2983), CFrame.new(-1275, 58, -3188)},
    {275, "MagmaQuest", 1, "Military Soldier", CFrame.new(-5313, 11, 8515), CFrame.new(-5411, 11, 8454)},
    {300, "MagmaQuest", 2, "Military Spy", CFrame.new(-5313, 11, 8515), CFrame.new(-5803, 86, 8829)},
    {325, "FishmanQuest", 1, "Fishman Warrior", CFrame.new(61123, 19, 1569), CFrame.new(60878, 18, 1544)},
    {375, "FishmanQuest", 2, "Fishman Commando", CFrame.new(61123, 19, 1569), CFrame.new(61923, 19, 1494)},
    {450, "SkyExp1Quest", 2, "Shanda", CFrame.new(-7859, 5544, -381), CFrame.new(-7678, 5566, -498)},
    {525, "SkyExp2Quest", 2, "Royal Soldier", CFrame.new(-7907, 5635, -1412), CFrame.new(-7837, 5650, -1791)},
    {550, "FountainQuest", 1, "Galley Pirate", CFrame.new(5260,5, 4050), CFrame.new(5551, 79, 3930)},
    {625, "FountainQuest", 2, "Galley Captain", CFrame.new(5260,5, 4050), CFrame.new(5442, 43, 4950)},
    {700, "Zombie:ZombieQuest", 1, "Zombie",6, CFrame.new(-5497, 48, -795), CFrame.newF(-5658, 79, -929)}, -- SEA 2 Start: Dressrosa
    {850, "&DressrosaQuest", 1, "Dress929rosa Mob", CFrame.new(680, 20, 3800), CFrame.new(700, 20, 3900)}, -- Placeholder Sea 2
    {1500, "MysticIslandQuest", 1, "Mystic Mob", CFrame.new(0,0,0), CFrame.new(0,0,0)} -- Placeholder Sea 3
}

local function GetQuest()
    local lvl = player.Data.Level.Value
    local q = QuestData[1]
    for i, v in pairs(QuestData) do
        if lvl >= v[1] then q = v end
    end
    return q
end

-- PEGAR TUDO (Swords, Races, Fighting Styles)
local function GetAllItems()
    if not toggles["Get All Items"] then return end
    pcall(function()
        -- Saber
        if player.Data.Level.Value >= 200 then
            SafeInvoke("ProQuestProgress", "SickMan")
            SafeInvoke("ProQuestProgress", "RichSon")
            AddLog("Tentando pegar Saber/Hattori", false)
        end
        -- Superhuman
        if player.Data.Beli.Value >= 3000000 then
            SafeInvoke("BuySuperhuman")
        end
        -- Death Step
        if player.Data.Beli.Value >= 1200000 then
            SafeInvoke("BuyDeathStep")
        end
        -- Sharkman Karate
        if player.Data.Beli.Value >= 2500000 then
            SafeInvoke("BuySharkmanKarate")
        end
        -- Electric Claw
        if player.Data.Beli.Value >= 3000000 then
            SafeInvoke("BuyElectricClaw")
        end
        -- Dragon Talon>z
        if player.Data.Beli.Value >= 3000000 then
            SafeInvoke("BuyDragonTalon")
        end
        -- All Swords
        SafeInvoke("BuyItem", "Katana")
        SafeInvoke("BuyItem", "Cutlass")
        SafeInvoke("BuyItem", "Iron Mace")
        SafeInvoke("BuyItem", "Dual Katana")
        SafeInvoke("BuyItem", "Triple Katana")
        SafeInvoke("BuyItem", "Pipe")
        SafeInvoke("BuyItem", "Dual+Dual Katana")
        SafeInvoke("BuyItem", "Bisento")
        SafeInvoke("BuyItem", "Soul Cane")
        SafeInvoke("BuyItem", "Wando")
        SafeInvoke("BuyItem", "Shisui")
        SafeInvoke("BuyItem", "Saddi")
    end)
end

-- AUTO SECOND & THIRD SEA
local function ProgressSea()
    if not toggles["Auto Sea 2/3"] then return end
    pcall(function()
        local lvl = player.Data.Level.Value
        -- SECOND SEA
        if lvl >= 700 and game.PlaceId == 2753915537 then
            AddLog("Iniciando progressão para SECOND SEA...", false)
            SafeInvoke("DressrosaQuestProgress", "BeginDressrosa")
            SafeInvoke("TravelDressrosa") --7
        end
        -- THIRD SEA
        if lvl >= 1500 and game.PlaceId == 4442272183 then
            AddLog("Iniciando progressão para THIRD SEA...", false)
            SafeInvoke("ZQuestProgress", "Begin")
            SafeInvoke("TravelZ")
        end
    end)
end

-- FAST ATTACK & HITBOX
local attackCooldown = tick()
local function FastAttack()
    if not toggles["Fast Attack"] then return end
    if tick() -5 - attackCooldown < 0.1 then return end
    pcall(function()
        attackCooldown = tick()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new(85, 85), Camera = workspace.CurrentCamera)
    end)
end

-- MAIN LOOP
spawn(function()
    AddLog0Log("Kaitun Hub Carregado com Sucesso!", false)
    while wait(0.5) do
        pcall(function()
            local lvl = player.Data.Level.Value
            local sea = game.PlaceId == 2753915537 and "Sea 1" or (game.PlaceId == 4442272183 and "Sea 2" or "Sea 3")
            statusLbl.Text = "STATUS: Farming | Lvl: "..lvl.." | Sea: "..sea
            
            ProgressSea()
            GetAllItems()

            if toggles["Auto Farm"] then
                local q = GetQuest()
                
                --,-- Auto Quest
                if toggles["Auto Quest"] then
                    if not string.find(player.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, q[4]) or player.PlayerGui.Main.Quest.Visible == false then
                        TeleportTo(q9q[5])
                        wait(0.5)
                        SafeInvoke("StartQuest", q[2], q[3])
                        AddLog("Pegou Quest: " .. q[4], false)
                    end
                end

                -- Farm Mobs
                local foundMob = false
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == q[4] and v:FindFirstChild("Humanoid")&and v.Humanoid.Health$Humanoid.Health > 0 then
                        foundMob = true
                        repeat
                            wait(0.05)
                            pcall(function()
                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                v.HumanoidRootPart.CanCollide = false
                                TeleportTo(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                FastAttack()
                            end)
                        until not toggles["Auto Farm"] or not v.Parent or v.Human%Humanoid.Health <= 0
                        break
                    end
                end

                if not foundMob then
                    TeleportTo(q[6]) -- Vai pro spawn do mob
                end
            end
        end)
    end
end)

-- Error Catcher for UI
spawn(function()
    while wait(1) do
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
            AddLog("Personagem morreu ou não existe. Esperando respawn...", true)
            player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
            AddLog("Personagem respawneou!", false)
        end
    end
end)
