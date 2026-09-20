--[[
    KAITUN SCRIPT BLOX FRUITS - SEA 1 COMPLETO
    Baseado em scripts da comunidade
    Use por sua própria conta e risco
]]

getgenv().Settings = {
    ["Auto Farm"] = true,
    ["Fast Attack"] = true,
    ["Auto Quest"] = true,
    ["Auto New World"] = true, -- Auto TP para Sea 2 ao atingir lvl 700
    ["Auto Third Sea"] = false,
    
    -- Configurações de Farm
    ["Bring Mob"] = true,
    ["Fast Attack Speed"] = 0.1,
    ["Bypass TP"] = true,
    
    -- Auto Haki & Combat
    ["Auto Buso Haki"] = true,
    ["Auto Observation Haki"] = true,
    ["Auto Observation Haki v2"] = true,
    
    -- Auto Second Sea Requirements
    ["Auto Saber"] = true,
    ["Auto Pole"] = true,
    
    -- Fighting Styles
    ["Auto Superhuman"] = true,
    ["Select Fighting Style"] = "Dragon Talon",
    
    -- Fruit Settings
    ["Auto Devil Fruit"] = true,
    ["Auto Store Fruit"] = true,
    ["Select Main Fruit"] = {"Dough", "Leopard", "Dragon", "Shadow", "Venom"},
    
    -- Stats Distribution
    ["Auto Stats"] = true,
    ["Select Stats"] = {
        ["Melee"] = true,
        ["Defense"] = true,
        ["Sword"] = false,
        ["Gun"] = false,
        ["Devil Fruit"] = false
    },
    
    -- Weapons
    ["Select Weapon"] = {
        "Combat",
        "Katana",
        "Cutlass"
    },
    
    -- Misc
    ["Auto Click"] = false,
    ["Hop Server Low Player"] = true,
    ["Hop When Level Cap"] = true,
}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Anti AFK
LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Quest Database Sea 1
local QuestSea1 = {
    {MinLv = 1, MaxLv = 9, QuestName = "BanditQuest1", LevelQuest = 1, NameMon = "Bandit", NameArea = "Bandit", CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231), CFrameMon = CFrame.new(1199.31287, 52.2717781, 1536.91516)},
    {MinLv = 10, MaxLv = 14, QuestName = "JungleQuest", LevelQuest = 1, NameMon = "Monkey", NameArea = "Jungle", CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838), CFrameMon = CFrame.new(-1448.51806, 67.8515587, 11.46579)},
    {MinLv = 15, MaxLv = 29, QuestName = "JungleQuest", LevelQuest = 2, NameMon = "Gorilla", NameArea = "Jungle", CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838), CFrameMon = CFrame.new(-1129.8836, 40.4686775, -525.4237)},
    {MinLv = 30, MaxLv = 39, QuestName = "BuggyQuest1", LevelQuest = 1, NameMon = "Pirate", NameArea = "Pirate", CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498), CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)},
    {MinLv = 40, MaxLv = 59, QuestName = "BuggyQuest1", LevelQuest = 2, NameMon = "Brute", NameArea = "Pirate", CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498), CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)},
    {MinLv = 60, MaxLv = 74, QuestName = "DesertQuest", LevelQuest = 1, NameMon = "Desert Bandit", NameArea = "Desert", CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359), CFrameMon = CFrame.new(932.5985717773438, 6.4822506904602051, 4488.24609375)},
    {MinLv = 75, MaxLv = 89, QuestName = "DesertQuest", LevelQuest = 2, NameMon = "Desert Officer", NameArea = "Desert", CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359), CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)},
    {MinLv = 90, MaxLv = 99, QuestName = "SnowQuest", LevelQuest = 1, NameMon = "Snowman", NameArea = "Snow", CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796), CFrameMon = CFrame.new(1197.4308, 87.272789, -1416.92371)},
    {MinLv = 100, MaxLv = 119, QuestName = "SnowQuest", LevelQuest = 2, NameMon = "Winter Warrior", NameArea = "Snow", CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796), CFrameMon = CFrame.new(1295.62683, 87.2724991, -1240.24292)},
    {MinLv = 120, MaxLv = 149, QuestName = "MarineQuest2", LevelQuest = 1, NameMon = "Chief Petty Officer", NameArea = "Marine", CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018), CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516)},
    {MinLv = 150, MaxLv = 174, QuestName = "MarineQuest2", LevelQuest = 2, NameMon = "Sky Bandit", NameArea = "Sky", CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018), CFrameMon = CFrame.new(-4953.20703, 295.74420166015625, -2899.22900390625)},
    {MinLv = 175, MaxLv = 189, QuestName = "PrisonerQuest", LevelQuest = 1, NameMon = "Prisoner", NameArea = "Prison", CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514), CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877)},
    {MinLv = 190, MaxLv = 209, QuestName = "PrisonerQuest", LevelQuest = 2, NameMon = "Dangerous Prisoner", NameArea = "Prison", CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514), CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877)},
    {MinLv = 210, MaxLv = 249, QuestName = "ColossumQuest", LevelQuest = 1, NameMon = "Toga Warrior", NameArea = "Colosseum", CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762), CFrameMon = CFrame.new(-1779.97998, 44.6077499, -2736.35474)},
    {MinLv = 250, MaxLv = 274, QuestName = "ColossumQuest", LevelQuest = 2, NameMon = "Gladiator", NameArea = "Colosseum", CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762), CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309)},
    {MinLv = 275, MaxLv = 299, QuestName = "MagmaQuest", LevelQuest = 1, NameMon = "Military Soldier", NameArea = "Magma", CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395), CFrameMon = CFrame.new(-5411.16455, 11.081554, 8454.29785)},
    {MinLv = 300, MaxLv = 324, QuestName = "MagmaQuest", LevelQuest = 2, NameMon = "Military Spy", NameArea = "Magma", CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395), CFrameMon = CFrame.new(-5802.8476, 86.26241, 8828.859375)},
    {MinLv = 325, MaxLv = 374, QuestName = "FishmanQuest", LevelQuest = 1, NameMon = "Fishman Warrior", NameArea = "Fishman", CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734), CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)},
    {MinLv = 375, MaxLv = 424, QuestName = "FishmanQuest", LevelQuest = 2, NameMon = "Fishman Commando", NameArea = "Fishman", CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734), CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)},
    {MinLv = 425, MaxLv = 449, QuestName = "SkyExp1Quest", LevelQuest = 1, NameMon = "God's Guard", NameArea = "Sky", CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643), CFrameMon = CFrame.new(-4628.0498, 866.92267, -1931.2352)},
    {MinLv = 450, MaxLv = 474, QuestName = "SkyExp1Quest", LevelQuest = 2, NameMon = "Shanda", NameArea = "Sky", CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196), CFrameMon = CFrame.new(-7678.48974, 5566.40918, -497.736023)},
    {MinLv = 475, MaxLv = 524, QuestName = "SkyExp2Quest", LevelQuest = 1, NameMon = "Royal Squad", NameArea = "Sky", CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194), CFrameMon = CFrame.new(-7555.04199, 5606.90479, -1303.72314)},
    {MinLv = 525, MaxLv = 549, QuestName = "SkyExp2Quest", LevelQuest = 2, NameMon = "Royal Soldier", NameArea = "Sky", CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194), CFrameMon = CFrame.new(-7837.1416, 5649.65186, -1791.08582)},
    {MinLv = 550, MaxLv = 624, QuestName = "FountainQuest", LevelQuest = 1, NameMon = "Galley Pirate", NameArea = "Fountain", CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293), CFrameMon = CFrame.new(5551.02197, 78.90135192871094, 3930.412841796875)},
    {MinLv = 625, MaxLv = 649, QuestName = "FountainQuest", LevelQuest = 2, NameMon = "Galley Captain", NameArea = "Fountain", CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293), CFrameMon = CFrame.new(5441.95166, 42.5098877, 4950.09375)},
    {MinLv = 650, MaxLv = 699, QuestName = "ZombieQuest", LevelQuest = 1, NameMon = "Zombie", NameArea = "Zombie", CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061), CFrameMon = CFrame.new(-5657.77685546875, 78.96808624267578, -928.68701171875)},
    {MinLv = 700, MaxLv = 1000, QuestName = "ZombieQuest", LevelQuest = 2, NameMon = "Vampire", NameArea = "Zombie", CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061), CFrameMon = CFrame.new(-6037.66796875, 0.4377521872520447, -1317.9800109863281)},
}

-- Get Current Quest
function GetCurrentQuest()
    local Lv = LocalPlayer.Data.Level.Value
    for i, v in pairs(QuestSea1) do
        if Lv >= v.MinLv and Lv <= v.MaxLv then
            return v
        end
    end
    return QuestSea1[#QuestSea1]
end

-- Tween/TP Function
function TP(P1)
    pcall(function()
        local Distance = (P1.Position - RootPart.Position).Magnitude
        
        if Distance < 250 then
            RootPart.CFrame = P1
        else
            local Speed = 300
            local tween_s = game:service"TweenService"
            local info = TweenInfo.new((RootPart.Position - P1.Position).Magnitude/Speed, Enum.EasingStyle.Linear)
            local tween = tween_s:Create(RootPart, info, {CFrame = P1})
            tween:Play()
            
            if Settings["Bypass TP"] then
                if Distance > 3000 then
                    RootPart.CFrame = P1
                end
            end
        end
    end)
end

-- Equipar arma
function EquipWeapon(ToolSe)
    if LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local tool = LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(0.4)
        Humanoid:EquipTool(tool)
    end
end

-- Fast Attack Function
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigEvent = CombatFrameworkR.RigEvent
local AttackAnim = Instance.new("Animation")
local AttackCoolDown = 0
local AttackFunction = 0
local CancelCoolDown = 0
local MaxAttacks = 5

function CurrentWeapon()
    local ac = CombatFrameworkR.activeController
    local ret = ac.blades[1]
    if not ret then return "Combat" end
    pcall(function()
        while ret.Parent ~= Character do ret = ret.Parent end
    end)
    if not ret then return "Combat" end
    return ret
end

function GetAttackCount()
    local ac = CombatFrameworkR.activeController
    for i = 1, MaxAttacks do
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(Character, {Character.HumanoidRootPart}, 60)
        if #bladehit > 0 then
            return i
        end
    end
    return 0
end

function AttackFunction()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        for i = 1, 1 do
            local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(Character, {Character.HumanoidRootPart}, 60)
            local cac = {}
            local hash = {}
            for k, v in pairs(bladehit) do
                if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                    table.insert(cac, v.Parent.HumanoidRootPart)
                    hash[v.Parent] = true
                end
            end
            bladehit = cac
            if #bladehit > 0 then
                pcall(function()
                    ac:attack()
                end)
            end
        end
    end
end

-- Auto Buso Haki
spawn(function()
    while wait() do
        pcall(function()
            if Settings["Auto Buso Haki"] then
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    local args = {"Buso"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end
        end)
    end
end)

-- Auto Farm
spawn(function()
    while wait() do
        pcall(function()
            if Settings["Auto Farm"] then
                local QuestData = GetCurrentQuest()
                
                -- Take Quest
                if Settings["Auto Quest"] then
                    local MyLevel = LocalPlayer.Data.Level.Value
                    if not string.find(LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, QuestData.NameMon) or LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        repeat wait() TP(QuestData.CFrameQuest) until (QuestData.CFrameQuest.Position - RootPart.Position).Magnitude <= 5
                        wait(0.3)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestData.QuestName, QuestData.LevelQuest)
                    end
                end
                
                -- Farm Mobs
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if v.Name == QuestData.NameMon then
                            repeat wait()
                                if Settings["Fast Attack"] then
                                    AttackFunction()
                                end
                                
                                EquipWeapon(Settings["Select Weapon"][1])
                                v.HumanoidRootPart.CanCollide = false
                                v.Head.CanCollide = false
                                v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                
                            until not Settings["Auto Farm"] or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                end
                
                -- Go to Mob Spawn if no mobs
                TP(QuestData.CFrameMon)
            end
        end)
    end
end)

-- Auto Stats
spawn(function()
    while wait() do
        pcall(function()
            if Settings["Auto Stats"] then
                local StatsList = Settings["Select Stats"]
                if LocalPlayer.Data.Points.Value > 0 then
                    if StatsList["Melee"] then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", LocalPlayer.Data.Points.Value)
                    end
                    if StatsList["Defense"] then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", LocalPlayer.Data.Points.Value)
                    end
                    if StatsList["Sword"] then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", LocalPlayer.Data.Points.Value)
                    end
                    if StatsList["Gun"] then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", LocalPlayer.Data.Points.Value)
                    end
                    if StatsList["Devil Fruit"] then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", LocalPlayer.Data.Points.Value)
                    end
                end
            end
        end)
    end
end)

-- Auto Saber
spawn(function()
    while wait() do
        pcall(function()
            if Settings["Auto Saber"] and LocalPlayer.Data.Level.Value >= 200 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
                    wait(0.5)
                    TP(CFrame.new(1397.229, 37.3480835, -1320.85217))
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Mob Leader" then
                                repeat wait()
                                    if Settings["Fast Attack"] then
                                        AttackFunction()
                                    end
                                    EquipWeapon(Settings["Select Weapon"][1])
                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                until not v.Parent or v.Humanoid.Health <= 0 or not Settings["Auto Saber"]
                            end
                        end
                    else
                        TP(CFrame.new(-2848.59399, 7.4272871, 5342.44043))
                    end
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                    wait(0.5)
                    EquipWeapon("Relic")
                    wait(0.5)
                    TP(CFrame.new(-1404.91504, 29.9773273, 3.80598116))
                end
            end
        end)
    end
end)

-- Auto Second Sea
spawn(function()
    while wait() do
        pcall(function()
            if Settings["Auto New World"] and LocalPlayer.Data.Level.Value >= 700 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress") == 0 then
                    if not game.Players.LocalPlayer.Backpack:FindFirstChild("Key") and not LocalPlayer.Character:FindFirstChild("Key") then
                        TP(CFrame.new(-12471.169921875, 374.9144592285156, -7551.677734375))
                    elseif LocalPlayer.Backpack:FindFirstChild("Key") or LocalPlayer.Character:FindFirstChild("Key") then
                        EquipWeapon("Key")
                        TP(CFrame.new(1347.7014160156, 37.356590270996, -7460.4438476563))
                    end
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress") == 1 then
                    TP(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress") == 2 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                end
            end
        end)
    end
end)

-- Server Hop quando chegar no level cap
spawn(function()
    while wait(1) do
        if Settings["Hop When Level Cap"] and LocalPlayer.Data.Level.Value >= 700 then
            local PlaceID = game.PlaceId
            local AllIDs = {}
            local foundAnything = ""
            local actualHour = os.date("!*t").hour
            local Deleted = false
            
            function TPReturner()
                local Site
                if foundAnything == "" then
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
                else
                    Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                end
                local ID = ""
                if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                    foundAnything = Site.nextPageCursor
                end
                local num = 0
                for i,v in pairs(Site.data) do
                    local Possible = true
                    ID = tostring(v.id)
                    if tonumber(v.maxPlayers) > tonumber(v.playing) then
                        for _,Existing in pairs(AllIDs) do
                            if num ~= 0 then
                                if ID == tostring(Existing) then
                                    Possible = false
                                end
                            else
                                if tonumber(actualHour) ~= tonumber(Existing) then
                                    local delFile = pcall(function()
                                        AllIDs = {}
                                        table.insert(AllIDs, actualHour)
                                    end)
                                end
                            end
                            num = num + 1
                        end
                        if Possible == true then
                            table.insert(AllIDs, ID)
                            wait()
                            pcall(function()
                                wait()
                                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                            end)
                            wait(4)
                        end
                    end
                end
            end
            
            function Teleport()
                while wait() do
                    pcall(function()
                        TPReturner()
                        if foundAnything ~= "" then
                            TPReturner()
                        end
                    end)
                end
            end
            Teleport()
        end
    end
end)

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "🏴‍☠️ Kaitun Script";
    Text = "Script Loaded! Sea 1";
    Duration = 5;
})

print("✅ Kaitun Script Sea 1 - Loaded Successfully")
print("📊 Current Level:", LocalPlayer.Data.Level.Value)
print("🎯 Current Quest:", GetCurrentQuest().QuestName)
