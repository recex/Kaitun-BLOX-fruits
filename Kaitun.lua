--[[
    ╔═══════════════════════════════════════════════════════════╗
    ║          KAITUN HUB COMPLETO - BLOX FRUITS                ║
    ║              All Seas + Debug System                      ║
    ║                   v2.0 - 2024                            ║
    ╚═══════════════════════════════════════════════════════════╝
]]

repeat wait() until game:IsLoaded()
wait(1)

-- Proteção Anti-Kick
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- ════════════════════════════════════════════════════════════
--                    SISTEMA DE LOGS E DEBUG
-- ════════════════════════════════════════════════════════════

local LogSystem = {
    Logs = {},
    MaxLogs = 100,
    Errors = {}
}

function LogSystem:Add(type, message)
    local timestamp = os.date("%H:%M:%S")
    local logEntry = string.format("[%s] [%s] %s", timestamp, type, message)
    
    table.insert(self.Logs, 1, logEntry)
    
    if #self.Logs > self.MaxLogs then
        table.remove(self.Logs, #self.Logs)
    end
    
    if type == "ERROR" then
        table.insert(self.Errors, logEntry)
    end
    
    print(logEntry)
end

function LogSystem:GetAll()
    return table.concat(self.Logs, "\n")
end

function LogSystem:GetErrors()
    return table.concat(self.Errors, "\n")
end

function LogSystem:Clear()
    self.Logs = {}
    self.Errors = {}
end

-- ════════════════════════════════════════════════════════════
--                      SERVICES & VARIABLES
-- ════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

LogSystem:Add("INFO", "Serviços carregados com sucesso")

-- ════════════════════════════════════════════════════════════
--                    CONFIGURAÇÕES PRINCIPAIS
-- ════════════════════════════════════════════════════════════

getgenv().Config = {
    -- === AUTO FARM ===
    ["Auto Farm Level"] = true,
    ["Auto Farm Mastery"] = false,
    ["Fast Attack"] = true,
    ["Fast Attack Delay"] = 0.1,
    ["Bring Mob"] = true,
    ["Bring Mob Distance"] = 350,
    
    -- === AUTO QUEST ===
    ["Auto Quest"] = true,
    ["Auto New World"] = true,
    ["Auto Third World"] = true,
    
    -- === COMBAT ===
    ["Auto Haki"] = true,
    ["Auto Buso Haki"] = true,
    ["Auto Ken Haki"] = true,
    ["Auto Ken Haki V2"] = true,
    
    -- === STATS ===
    ["Auto Stats"] = true,
    ["Stats Mode"] = "Melee", -- Melee, Defense, Sword, Gun, Fruit
    ["Points Per Upgrade"] = 1,
    
    -- === WEAPONS ===
    ["Select Weapon"] = {"Melee", "Combat"},
    ["Auto Farm Bone"] = false,
    ["Auto Farm Mastery Bone"] = false,
    
    -- === FIGHTING STYLES ===
    ["Auto Superhuman"] = true,
    ["Auto DeathStep"] = true,
    ["Auto SharkmanKarate"] = true,
    ["Auto ElectricClaw"] = true,
    ["Auto DragonTalon"] = true,
    ["Auto Godhuman"] = true,
    
    -- === SWORDS ===
    ["Auto Saber"] = true,
    ["Auto Pole V1"] = true,
    ["Auto Pole V2"] = false,
    ["Auto Rengoku"] = false,
    ["Auto Shisui"] = false,
    ["Auto Saddi"] = false,
    ["Auto Wando"] = false,
    ["Auto Canvander"] = false,
    ["Auto Buddy Sword"] = false,
    ["Auto Twin Hook"] = false,
    ["Auto True Triple Katana"] = false,
    ["Auto Cursed Dual Katana"] = false,
    
    -- === GUNS ===
    ["Auto Soul Guitar"] = false,
    ["Auto Serpent Bow"] = false,
    
    -- === ACCESSORIES ===
    ["Auto Farm Dark Coat"] = false,
    ["Auto Farm Ghoul Mask"] = false,
    ["Auto Farm Swan Glasses"] = false,
    ["Auto Farm Valkyrie Helm"] = false,
    
    -- === FRUITS ===
    ["Auto Random Fruit"] = true,
    ["Auto Store Fruit"] = true,
    ["Select Main Fruit"] = {"Leopard", "Dragon", "Dough", "Shadow", "Venom", "Spirit", "Control", "Gravity", "Mammoth", "T-Rex"},
    ["Auto Awaken Fruit"] = false,
    
    -- === BOSSES ===
    ["Auto Farm All Boss"] = false,
    ["Auto Farm Boss Selected"] = false,
    ["Select Boss"] = {},
    
    -- === MASTERY ===
    ["Mastery Mode"] = "Level", -- Level, Near
    ["Kill At"] = 25,
    ["Mastery Devil Fruit"] = false,
    ["Mastery Gun"] = false,
    ["Mastery Sword"] = false,
    
    -- === RAIDS ===
    ["Auto Raid"] = false,
    ["Select Raid"] = "Flame",
    ["Auto Awakener"] = false,
    ["Auto Next Island Raid"] = false,
    
    -- === OBSERVATION HAKI ===
    ["Auto Farm Observation"] = true,
    ["Observation Range"] = 1000,
    
    -- === SEA EVENTS ===
    ["Auto Terrorshark"] = false,
    ["Auto Piranha"] = false,
    ["Auto Fish Crew Member"] = false,
    ["Auto Ship Farm"] = false,
    ["Auto Leviathan"] = false,
    ["Auto Frozen Dimension"] = false,
    
    -- === MATERIAL FARM ===
    ["Auto Farm Ectoplasm"] = false,
    ["Auto Farm Bone"] = false,
    ["Auto Farm Scrap Metal"] = false,
    ["Auto Farm Leather"] = false,
    ["Auto Farm Angel Wings"] = false,
    ["Auto Farm Magma Ore"] = false,
    ["Auto Farm Radioactive Material"] = false,
    ["Auto Farm Vampire Fang"] = false,
    ["Auto Farm Mystic Droplet"] = false,
    ["Auto Farm Conjured Cocoa"] = false,
    
    -- === MISC ===
    ["Auto Farm Chest"] = false,
    ["Auto Farm Chest Tween"] = false,
    ["Chest Farm Distance"] = 1000,
    
    ["Auto Elite Hunter"] = false,
    ["Auto Farm Cake Prince"] = false,
    ["Auto Farm Dough King"] = false,
    
    -- === TELEPORT ===
    ["Bypass TP"] = true,
    ["TP Speed"] = 350,
    
    -- === SERVER HOP ===
    ["Auto Server Hop"] = false,
    ["Hop When Level Cap"] = true,
    ["Hop When Complete Quest"] = false,
    ["Server Hop Delay"] = 300,
    
    -- === WEBHOOKS ===
    ["Enable Webhook"] = false,
    ["Webhook URL"] = "",
    ["Webhook Events"] = {
        ["Level Up"] = false,
        ["Fruit Drop"] = false,
        ["Boss Spawn"] = false,
        ["Elite Spawn"] = false,
        ["Full Moon"] = false,
    },
    
    -- === MISC SETTINGS ===
    ["White Screen"] = false,
    ["Hide UI"] = false,
    ["FPS Boost"] = true,
    ["Remove Damage Counter"] = true,
    ["Remove Notifications"] = false,
}

LogSystem:Add("SUCCESS", "Configurações carregadas")

-- ════════════════════════════════════════════════════════════
--                    WORLD CHECK & DETECTION
-- ════════════════════════════════════════════════════════════

function CheckWorld()
    local placeId = game.PlaceId
    if placeId == 2753915549 then
        return "Sea1"
    elseif placeId == 4442272183 then
        return "Sea2"
    elseif placeId == 7449423635 then
        return "Sea3"
    else
        return "Unknown"
    end
end

local World = CheckWorld()
LogSystem:Add("INFO", "Mundo detectado: " .. World)

-- ════════════════════════════════════════════════════════════
--                    QUEST DATABASE - SEA 1
-- ════════════════════════════════════════════════════════════

local QuestSea1 = {
    {MinLv = 1, MaxLv = 9, QuestName = "BanditQuest1", LevelQuest = 1, NameMon = "Bandit", NameArea = "Bandit", 
     CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231), 
     CFrameMon = CFrame.new(1199.31287, 52.2717781, 1536.91516)},
    
    {MinLv = 10, MaxLv = 14, QuestName = "JungleQuest", LevelQuest = 1, NameMon = "Monkey", NameArea = "Jungle",
     CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838),
     CFrameMon = CFrame.new(-1448.51806, 67.8515587, 11.46579)},
    
    {MinLv = 15, MaxLv = 29, QuestName = "JungleQuest", LevelQuest = 2, NameMon = "Gorilla", NameArea = "Jungle",
     CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838),
     CFrameMon = CFrame.new(-1129.8836, 40.4686775, -525.4237)},
    
    {MinLv = 30, MaxLv = 39, QuestName = "BuggyQuest1", LevelQuest = 1, NameMon = "Pirate", NameArea = "Pirate",
     CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498),
     CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)},
    
    {MinLv = 40, MaxLv = 59, QuestName = "BuggyQuest1", LevelQuest = 2, NameMon = "Brute", NameArea = "Pirate",
     CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498),
     CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)},
    
    {MinLv = 60, MaxLv = 74, QuestName = "DesertQuest", LevelQuest = 1, NameMon = "Desert Bandit", NameArea = "Desert",
     CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359),
     CFrameMon = CFrame.new(932.5985717773438, 6.4822506904602051, 4488.24609375)},
    
    {MinLv = 75, MaxLv = 89, QuestName = "DesertQuest", LevelQuest = 2, NameMon = "Desert Officer", NameArea = "Desert",
     CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359),
     CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)},
    
    {MinLv = 90, MaxLv = 99, QuestName = "SnowQuest", LevelQuest = 1, NameMon = "Snowman", NameArea = "Snow",
     CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796),
     CFrameMon = CFrame.new(1197.4308, 87.272789, -1416.92371)},
    
    {MinLv = 100, MaxLv = 119, QuestName = "SnowQuest", LevelQuest = 2, NameMon = "Winter Warrior", NameArea = "Snow",
     CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796),
     CFrameMon = CFrame.new(1295.62683, 87.2724991, -1240.24292)},
    
    {MinLv = 120, MaxLv = 149, QuestName = "MarineQuest2", LevelQuest = 1, NameMon = "Chief Petty Officer", NameArea = "Marine",
     CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018),
     CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516)},
    
    {MinLv = 150, MaxLv = 174, QuestName = "MarineQuest2", LevelQuest = 2, NameMon = "Sky Bandit", NameArea = "Sky",
     CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018),
     CFrameMon = CFrame.new(-4953.20703, 295.74420166015625, -2899.22900390625)},
    
    {MinLv = 175, MaxLv = 189, QuestName = "PrisonerQuest", LevelQuest = 1, NameMon = "Prisoner", NameArea = "Prison",
     CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514),
     CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877)},
    
    {MinLv = 190, MaxLv = 209, QuestName = "PrisonerQuest", LevelQuest = 2, NameMon = "Dangerous Prisoner", NameArea = "Prison",
     CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514),
     CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877)},
    
    {MinLv = 210, MaxLv = 249, QuestName = "ColossumQuest", LevelQuest = 1, NameMon = "Toga Warrior", NameArea = "Colosseum",
     CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762),
     CFrameMon = CFrame.new(-1779.97998, 44.6077499, -2736.35474)},
    
    {MinLv = 250, MaxLv = 274, QuestName = "ColossumQuest", LevelQuest = 2, NameMon = "Gladiator", NameArea = "Colosseum",
     CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762),
     CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309)},
    
    {MinLv = 275, MaxLv = 299, QuestName = "MagmaQuest", LevelQuest = 1, NameMon = "Military Soldier", NameArea = "Magma",
     CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395),
     CFrameMon = CFrame.new(-5411.16455, 11.081554, 8454.29785)},
    
    {MinLv = 300, MaxLv = 324, QuestName = "MagmaQuest", LevelQuest = 2, NameMon = "Military Spy", NameArea = "Magma",
     CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395),
     CFrameMon = CFrame.new(-5802.8476, 86.26241, 8828.859375)},
    
    {MinLv = 325, MaxLv = 374, QuestName = "FishmanQuest", LevelQuest = 1, NameMon = "Fishman Warrior", NameArea = "Fishman",
     CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734),
     CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)},
    
    {MinLv = 375, MaxLv = 424, QuestName = "FishmanQuest", LevelQuest = 2, NameMon = "Fishman Commando", NameArea = "Fishman",
     CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734),
     CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)},
    
    {MinLv = 425, MaxLv = 449, QuestName = "SkyExp1Quest", LevelQuest = 1, NameMon = "God's Guard", NameArea = "Sky",
     CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643),
     CFrameMon = CFrame.new(-4628.0498, 866.92267, -1931.2352)},
    
    {MinLv = 450, MaxLv = 474, QuestName = "SkyExp1Quest", LevelQuest = 2, NameMon = "Shanda", NameArea = "Sky",
     CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196),
     CFrameMon = CFrame.new(-7678.48974, 5566.40918, -497.736023)},
    
    {MinLv = 475, MaxLv = 524, QuestName = "SkyExp2Quest", LevelQuest = 1, NameMon = "Royal Squad", NameArea = "Sky",
     CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194),
     CFrameMon = CFrame.new(-7555.04199, 5606.90479, -1303.72314)},
    
    {MinLv = 525, MaxLv = 549, QuestName = "SkyExp2Quest", LevelQuest = 2, NameMon = "Royal Soldier", NameArea = "Sky",
     CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194),
     CFrameMon = CFrame.new(-7837.1416, 5649.65186, -1791.08582)},
    
    {MinLv = 550, MaxLv = 624, QuestName = "FountainQuest", LevelQuest = 1, NameMon = "Galley Pirate", NameArea = "Fountain",
     CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293),
     CFrameMon = CFrame.new(5551.02197, 78.90135192871094, 3930.412841796875)},
    
    {MinLv = 625, MaxLv = 649, QuestName = "FountainQuest", LevelQuest = 2, NameMon = "Galley Captain", NameArea = "Fountain",
     CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293),
     CFrameMon = CFrame.new(5441.95166, 42.5098877, 4950.09375)},
    
    {MinLv = 650, MaxLv = 699, QuestName = "ZombieQuest", LevelQuest = 1, NameMon = "Zombie", NameArea = "Zombie",
     CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061),
     CFrameMon = CFrame.new(-5657.77685546875, 78.96808624267578, -928.68701171875)},
    
    {MinLv = 700, MaxLv = 1500, QuestName = "ZombieQuest", LevelQuest = 2, NameMon = "Vampire", NameArea = "Zombie",
     CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061),
     CFrameMon = CFrame.new(-6037.66796875, 0.4377521872520447, -1317.9800109863281)},
}

-- ════════════════════════════════════════════════════════════
--                    QUEST DATABASE - SEA 2
-- ════════════════════════════════════════════════════════════

local QuestSea2 = {
    {MinLv = 700, MaxLv = 724, QuestName = "Area1Quest", LevelQuest = 1, NameMon = "Raider", NameArea = "Area 1",
     CFrameQuest = CFrame.new(-427.690826, 72.9990997, 1835.89062),
     CFrameMon = CFrame.new(-746.070923, 39.4589119, 2390.13599)},
    
    {MinLv = 725, MaxLv = 774, QuestName = "Area1Quest", LevelQuest = 2, NameMon = "Mercenary", NameArea = "Area 1",
     CFrameQuest = CFrame.new(-427.690826, 72.9990997, 1835.89062),
     CFrameMon = CFrame.new(-974.433594, 141.350677, 1624.73425)},
    
    {MinLv = 775, MaxLv = 849, QuestName = "Area2Quest", LevelQuest = 1, NameMon = "Swan Pirate", NameArea = "Area 2",
     CFrameQuest = CFrame.new(638.118835, 71.769905, 918.140259),
     CFrameMon = CFrame.new(970.369080, 142.653198, 1217.65283)},
    
    {MinLv = 850, MaxLv = 899, QuestName = "Area2Quest", LevelQuest = 2, NameMon = "Marine Commodore", NameArea = "Area 2",
     CFrameQuest = CFrame.new(638.118835, 71.769905, 918.140259),
     CFrameMon = CFrame.new(2286.23657, 72.9919281, 863.862854)},
    
    {MinLv = 900, MaxLv = 949, QuestName = "MarineQuest3", LevelQuest = 1, NameMon = "Marine Lieutenant", NameArea = "Marine",
     CFrameQuest = CFrame.new(-2440.96509, 71.7140732, -3216.06812),
     CFrameMon = CFrame.new(-2823.48657, 72.9919281, -2865.21899)},
    
    {MinLv = 950, MaxLv = 974, QuestName = "MarineQuest3", LevelQuest = 2, NameMon = "Marine Captain", NameArea = "Marine",
     CFrameQuest = CFrame.new(-2440.96509, 71.7140732, -3216.06812),
     CFrameMon = CFrame.new(-1869.76025, 72.9919281, -3318.68994)},
    
    {MinLv = 975, MaxLv = 999, QuestName = "ZombieQuest", LevelQuest = 1, NameMon = "Zombie", NameArea = "Zombie",
     CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061),
     CFrameMon = CFrame.new(-5657.77686, 78.9680862, -928.687012)},
    
    {MinLv = 1000, MaxLv = 1049, QuestName = "ZombieQuest", LevelQuest = 2, NameMon = "Vampire", NameArea = "Zombie",
     CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061),
     CFrameMon = CFrame.new(-6037.66797, 0.437752187, -1317.98010)},
    
    {MinLv = 1050, MaxLv = 1099, QuestName = "SnowMountainQuest", LevelQuest = 1, NameMon = "Snow Trooper", NameArea = "Snow Mountain",
     CFrameQuest = CFrame.new(607.052002, 401.270233, -5370.50293),
     CFrameMon = CFrame.new(535.398560, 432.454590, -5484.40869)},
    
    {MinLv = 1100, MaxLv = 1124, QuestName = "SnowMountainQuest", LevelQuest = 2, NameMon = "Winter Warrior", NameArea = "Snow Mountain",
     CFrameQuest = CFrame.new(607.052002, 401.270233, -5370.50293),
     CFrameMon = CFrame.new(1223.26685, 454.575378, -5170.02148)},
    
    {MinLv = 1125, MaxLv = 1174, QuestName = "IceSideQuest", LevelQuest = 1, NameMon = "Lab Subordinate", NameArea = "Ice",
     CFrameQuest = CFrame.new(-6061.84375, 15.926302, -4902.97168),
     CFrameMon = CFrame.new(-5720.45898, 15.9266396, -4312.71484)},
    
    {MinLv = 1175, MaxLv = 1199, QuestName = "IceSideQuest", LevelQuest = 2, NameMon = "Horned Warrior", NameArea = "Ice",
     CFrameQuest = CFrame.new(-6061.84375, 15.926302, -4902.97168),
     CFrameMon = CFrame.new(-6401.27881, 15.9266396, -5905.69043)},
    
    {MinLv = 1200, MaxLv = 1249, QuestName = "FireSideQuest", LevelQuest = 1, NameMon = "Lava Pirate", NameArea = "Fire",
     CFrameQuest = CFrame.new(-5430.75342, 15.9269638, -5298.29932),
     CFrameMon = CFrame.new(-5270.31104, 29.1532173, -4906.42578)},
    
    {MinLv = 1250, MaxLv = 1274, QuestName = "FireSideQuest", LevelQuest = 2, NameMon = "Ship Deckhand", NameArea = "Fire",
     CFrameQuest = CFrame.new(-5430.75342, 15.9269638, -5298.29932),
     CFrameMon = CFrame.new(-5415.51611, 15.9269638, -5159.95068)},
    
    {MinLv = 1275, MaxLv = 1299, QuestName = "FrostQuest", LevelQuest = 1, NameMon = "Ship Engineer", NameArea = "Frost",
     CFrameQuest = CFrame.new(5249.14355, 28.2144527, -6132.08887),
     CFrameMon = CFrame.new(5278.73877, 28.9706802, -6054.84961)},
    
    {MinLv = 1300, MaxLv = 1324, QuestName = "FrostQuest", LevelQuest = 2, NameMon = "Ship Steward", NameArea = "Frost",
     CFrameQuest = CFrame.new(5249.14355, 28.2144527, -6132.08887),
     CFrameMon = CFrame.new(5141.68604, 28.2144547, -6340.35303)},
    
    {MinLv = 1325, MaxLv = 1349, QuestName = "ShipQuest1", LevelQuest = 1, NameMon = "Ship Deckhand", NameArea = "Ship",
     CFrameQuest = CFrame.new(1038.38647, 125.081398, 32910.1680),
     CFrameMon = CFrame.new(1163.16187, 125.081398, 33039.0742)},
    
    {MinLv = 1350, MaxLv = 1374, QuestName = "ShipQuest1", LevelQuest = 2, NameMon = "Ship Engineer", NameArea = "Ship",
     CFrameQuest = CFrame.new(1038.38647, 125.081398, 32910.1680),
     CFrameMon = CFrame.new(919.196045, 125.081398, 32910.7617)},
    
    {MinLv = 1375, MaxLv = 1424, QuestName = "ShipQuest2", LevelQuest = 1, NameMon = "Ship Steward", NameArea = "Ship",
     CFrameQuest = CFrame.new(968.369080, 125.081398, 33245.5781),
     CFrameMon = CFrame.new(918.359863, 125.081398, 33394.9414)},
    
    {MinLv = 1425, MaxLv = 1449, QuestName = "ShipQuest2", LevelQuest = 2, NameMon = "Ship Officer", NameArea = "Ship",
     CFrameQuest = CFrame.new(968.369080, 125.081398, 33245.5781),
     CFrameMon = CFrame.new(944.125305, 125.081398, 33444.3828)},
    
    {MinLv = 1450, MaxLv = 1474, QuestName = "FrostQuest", LevelQuest = 1, NameMon = "Arctic Warrior", NameArea = "Frost",
     CFrameQuest = CFrame.new(5668.11377, 28.2029991, -6484.29346),
     CFrameMon = CFrame.new(5935.23779, 28.2029991, -6371.79883)},
    
    {MinLv = 1475, MaxLv = 1500, QuestName = "FrostQuest", LevelQuest = 2, NameMon = "Snow Lurker", NameArea = "Frost",
     CFrameQuest = CFrame.new(5668.11377, 28.2029991, -6484.29346),
     CFrameMon = CFrame.new(5628.48535, 28.2029991, -6839.40137)},
}

-- ════════════════════════════════════════════════════════════
--                    QUEST DATABASE - SEA 3
-- ════════════════════════════════════════════════════════════

local QuestSea3 = {
    {MinLv = 1500, MaxLv = 1524, QuestName = "PiratePortQuest", LevelQuest = 1, NameMon = "Pirate Millionaire", NameArea = "Port Town",
     CFrameQuest = CFrame.new(-290.281433, 42.9034653, 5579.81689),
     CFrameMon = CFrame.new(-235.708359, 46.9034653, 5628.34961)},
    
    {MinLv = 1525, MaxLv = 1574, QuestName = "PiratePortQuest", LevelQuest = 2, NameMon = "Pistol Billionaire", NameArea = "Port Town",
     CFrameQuest = CFrame.new(-290.281433, 42.9034653, 5579.81689),
     CFrameMon = CFrame.new(-236.128052, 46.9034653, 5767.88086)},
    
    {MinLv = 1575, MaxLv = 1599, QuestName = "AmazonQuest", LevelQuest = 1, NameMon = "Amazon", NameArea = "Amazon",
     CFrameQuest = CFrame.new(5253.17871, 51.6501541, -1131.91016),
     CFrameMon = CFrame.new(5234.42871, 51.7335052, -1232.32104)},
    
    {MinLv = 1600, MaxLv = 1624, QuestName = "AmazonQuest", LevelQuest = 2, NameMon = "Amazon Warrior", NameArea = "Amazon",
     CFrameQuest = CFrame.new(5253.17871, 51.6501541, -1131.91016),
     CFrameMon = CFrame.new(5315.76758, 51.6501541, -1165.66016)},
    
    {MinLv = 1625, MaxLv = 1649, QuestName = "MarineTreeIsland", LevelQuest = 1, NameMon = "Marine Commodore", NameArea = "Marine Tree",
     CFrameQuest = CFrame.new(2179.98193, 28.7315979, -6740.97559),
     CFrameMon = CFrame.new(2490.74951, 28.7315979, -7163.46777)},
    
    {MinLv = 1650, MaxLv = 1699, QuestName = "MarineTreeIsland", LevelQuest = 2, NameMon = "Marine Rear Admiral", NameArea = "Marine Tree",
     CFrameQuest = CFrame.new(2179.98193, 28.7315979, -6740.97559),
     CFrameMon = CFrame.new(3951.88965, 28.7315979, -6912.31934)},
    
    {MinLv = 1700, MaxLv = 1724, QuestName = "DeepForestIsland", LevelQuest = 1, NameMon = "Mythological Pirate", NameArea = "Deep Forest",
     CFrameQuest = CFrame.new(-13232.7148, 332.40396, -7625.67578),
     CFrameMon = CFrame.new(-13547.9961, 376.553741, -7901.85107)},
    
    {MinLv = 1725, MaxLv = 1774, QuestName = "DeepForestIsland", LevelQuest = 2, NameMon = "Jungle Pirate", NameArea = "Deep Forest",
     CFrameQuest = CFrame.new(-13232.7148, 332.40396, -7625.67578),
     CFrameMon = CFrame.new(-12107.5859, 332.40396, -10548.7939)},
    
    {MinLv = 1775, MaxLv = 1799, QuestName = "HauntedQuest1", LevelQuest = 1, NameMon = "Haunted Castle Living Zombie", NameArea = "Haunted Castle",
     CFrameQuest = CFrame.new(-9479.85645, 141.215515, 5566.09277),
     CFrameMon = CFrame.new(-9547.24902, 141.215515, 5727.03906)},
    
    {MinLv = 1800, MaxLv = 1824, QuestName = "HauntedQuest1", LevelQuest = 2, NameMon = "Demonic Soul", NameArea = "Haunted Castle",
     CFrameQuest = CFrame.new(-9479.85645, 141.215515, 5566.09277),
     CFrameMon = CFrame.new(-9524.20703, 172.130661, 6078.16064)},
    
    {MinLv = 1825, MaxLv = 1849, QuestName = "HauntedQuest2", LevelQuest = 1, NameMon = "Posessed Mummy", NameArea = "Haunted Castle",
     CFrameQuest = CFrame.new(-9546.99023, 172.130661, 6078.16064),
     CFrameMon = CFrame.new(-9582.08887, 6.25166559, 6205.58105)},
    
    {MinLv = 1850, MaxLv = 1899, QuestName = "HauntedQuest2", LevelQuest = 2, NameMon = "Peanut Scout", NameArea = "Haunted Castle",
     CFrameQuest = CFrame.new(-9546.99023, 172.130661, 6078.16064),
     CFrameMon = CFrame.new(-9624.42383, 172.130661, 6286.88379)},
    
    {MinLv = 1900, MaxLv = 1924, QuestName = "PeanutIsland", LevelQuest = 1, NameMon = "Peanut Scout", NameArea = "Peanut Island",
     CFrameQuest = CFrame.new(-2104.8269, 38.1299324, -10194.418),
     CFrameMon = CFrame.new(-2098.07886, 38.1299324, -10351.4258)},
    
    {MinLv = 1925, MaxLv = 1974, QuestName = "PeanutIsland", LevelQuest = 2, NameMon = "Peanut President", NameArea = "Peanut Island",
     CFrameQuest = CFrame.new(-2104.8269, 38.1299324, -10194.418),
     CFrameMon = CFrame.new(-1859.49268, 38.1299324, -10424.4336)},
    
    {MinLv = 1975, MaxLv = 1999, QuestName = "IceCreamIsland", LevelQuest = 1, NameMon = "Ice Cream Chef", NameArea = "Ice Cream Island",
     CFrameQuest = CFrame.new(-821.231934, 65.3961334, -10965.5068),
     CFrameMon = CFrame.new(-821.542297, 65.8227005, -11083.6621)},
    
    {MinLv = 2000, MaxLv = 2024, QuestName = "IceCreamIsland", LevelQuest = 2, NameMon = "Ice Cream Commander", NameArea = "Ice Cream Island",
     CFrameQuest = CFrame.new(-821.231934, 65.3961334, -10965.5068),
     CFrameMon = CFrame.new(-610.941895, 65.8227005, -11253.0781)},
    
    {MinLv = 2025, MaxLv = 2049, QuestName = "CakeQuest1", LevelQuest = 1, NameMon = "Cookie Crafter", NameArea = "Cake Land",
     CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295),
     CFrameMon = CFrame.new(-2321.68652, 37.7982254, -12216.5879)},
    
    {MinLv = 2050, MaxLv = 2074, QuestName = "CakeQuest1", LevelQuest = 2, NameMon = "Cake Guard", NameArea = "Cake Land",
     CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295),
     CFrameMon = CFrame.new(-1766.09766, 37.7982254, -12233.4355)},
    
    {MinLv = 2075, MaxLv = 2099, QuestName = "CakeQuest2", LevelQuest = 1, NameMon = "Baking Staff", NameArea = "Cake Land",
     CFrameQuest = CFrame.new(-1927.43677, 37.7982254, -12842.5801),
     CFrameMon = CFrame.new(-1885.08203, 37.7982254, -12923.4219)},
    
    {MinLv = 2100, MaxLv = 2124, QuestName = "CakeQuest2", LevelQuest = 2, NameMon = "Head Baker", NameArea = "Cake Land",
     CFrameQuest = CFrame.new(-1927.43677, 37.7982254, -12842.5801),
     CFrameMon = CFrame.new(-2203.24219, 109.798218, -12788.8398)},
    
    {MinLv = 2125, MaxLv = 2149, QuestName = "ChocQuest1", LevelQuest = 1, NameMon = "Chocolate Bar Battler", NameArea = "Chocolate Island",
     CFrameQuest = CFrame.new(233.141403, 29.8238888, -12200.2285),
     CFrameMon = CFrame.new(582.590698, 29.8238888, -12614.6182)},
    
    {MinLv = 2150, MaxLv = 2199, QuestName = "ChocQuest1", LevelQuest = 2, NameMon = "Sweet Thief", NameArea = "Chocolate Island",
     CFrameQuest = CFrame.new(233.141403, 29.8238888, -12200.2285),
     CFrameMon = CFrame.new(114.577698, 29.8238888, -12463.9893)},
    
    {MinLv = 2200, MaxLv = 2224, QuestName = "ChocQuest2", LevelQuest = 1, NameMon = "Candy Rebel", NameArea = "Chocolate Island",
     CFrameQuest = CFrame.new(151.118927, 23.8238888, -12774.6172),
     CFrameMon = CFrame.new(134.231995, 23.8238888, -12856.6211)},
    
    {MinLv = 2225, MaxLv = 2299, QuestName = "ChocQuest2", LevelQuest = 2, NameMon = "Candy Pirate", NameArea = "Chocolate Island",
     CFrameQuest = CFrame.new(151.118927, 23.8238888, -12774.6172),
     CFrameMon = CFrame.new(-201.951004, 23.8238888, -12878.5381)},
    
    {MinLv = 2300, MaxLv = 2324, QuestName = "TikiQuest1", LevelQuest = 1, NameMon = "Tiki Warrior", NameArea = "Tiki Outpost",
     CFrameQuest = CFrame.new(-16542.2813, 55.6863556, -173.230499),
     CFrameMon = CFrame.new(-16836.4688, 55.6863556, -339.465576)},
    
    {MinLv = 2325, MaxLv = 2349, QuestName = "TikiQuest1", LevelQuest = 2, NameMon = "Tiki Master", NameArea = "Tiki Outpost",
     CFrameQuest = CFrame.new(-16542.2813, 55.6863556, -173.230499),
     CFrameMon = CFrame.new(-16926.4688, 55.6863556, -83.465576)},
    
    {MinLv = 2350, MaxLv = 2374, QuestName = "TikiQuest2", LevelQuest = 1, NameMon = "Lava Pirate", NameArea = "Tiki Outpost",
     CFrameQuest = CFrame.new(-16542.2813, 55.6863556, 1044.76953),
     CFrameMon = CFrame.new(-16838.4688, 55.6863556, 1310.46558)},
    
    {MinLv = 2375, MaxLv = 2399, QuestName = "TikiQuest2", LevelQuest = 2, NameMon = "Lava Pirate Captain", NameArea = "Tiki Outpost",
     CFrameQuest = CFrame.new(-16542.2813, 55.6863556, 1044.76953),
     CFrameMon = CFrame.new(-16926.4688, 55.6863556, 1178.46558)},
    
    {MinLv = 2400, MaxLv = 2424, QuestName = "VolcanoQuest1", LevelQuest = 1, NameMon = "Lava Pirate", NameArea = "Volcano",
     CFrameQuest = CFrame.new(-5431.09033, 15.9868021, -5295.43457),
     CFrameMon = CFrame.new(-5270.31104, 29.1532173, -4906.42578)},
    
    {MinLv = 2425, MaxLv = 2449, QuestName = "VolcanoQuest1", LevelQuest = 2, NameMon = "Ship Deckhand", NameArea = "Volcano",
     CFrameQuest = CFrame.new(-5431.09033, 15.9868021, -5295.43457),
     CFrameMon = CFrame.new(-5415.51611, 15.9868021, -5159.95068)},
    
    {MinLv = 2450, MaxLv = 2474, QuestName = "VolcanoQuest2", LevelQuest = 1, NameMon = "Magma Admiral", NameArea = "Volcano",
     CFrameQuest = CFrame.new(-5432.09033, 15.9868021, -5296.43457),
     CFrameMon = CFrame.new(-5765.80566, 82.9265213, -5457.08887)},
    
    {MinLv = 2475, MaxLv = 2524, QuestName = "VolcanoQuest2", LevelQuest = 2, NameMon = "Lava Pirate Captain", NameArea = "Volcano",
     CFrameQuest = CFrame.new(-5432.09033, 15.9868021, -5296.43457),
     CFrameMon = CFrame.new(-5270.31104, 29.1532173, -4906.42578)},
    
    {MinLv = 2525, MaxLv = 3000, QuestName = "VolcanoQuest2", LevelQuest = 2, NameMon = "Beast Hunter", NameArea = "Volcano",
     CFrameQuest = CFrame.new(-5432.09033, 15.9868021, -5296.43457),
     CFrameMon = CFrame.new(-3424.40112, 123.234642, -3326.47583)},
}

LogSystem:Add("SUCCESS", "Quest database loaded - All Seas")

-- ════════════════════════════════════════════════════════════
--                    FUNÇÕES PRINCIPAIS
-- ════════════════════════════════════════════════════════════

-- Get Current Quest Based on World
function GetCurrentQuest()
    pcall(function()
        local MyLevel = LocalPlayer.Data.Level.Value
        local QuestTable
        
        if World == "Sea1" then
            QuestTable = QuestSea1
        elseif World == "Sea2" then
            QuestTable = QuestSea2
        elseif World == "Sea3" then
            QuestTable = QuestSea3
        else
            LogSystem:Add("ERROR", "Mundo não reconhecido!")
            return nil
        end
        
        for i, v in pairs(QuestTable) do
            if MyLevel >= v.MinLv and MyLevel <= v.MaxLv then
                LogSystem:Add("INFO", "Quest atual: " .. v.QuestName .. " - " .. v.NameMon)
                return v
            end
        end
        
        return QuestTable[#QuestTable]
    end)
end

-- Tween Function
getgenv().ToTargetP = nil
getgenv().TweenSpeed = Config["TP Speed"]

function TP(P1)
    pcall(function()
        local Character = LocalPlayer.Character
        if not Character or not Character:FindFirstChild("HumanoidRootPart") then 
            LogSystem:Add("ERROR", "Character ou HumanoidRootPart não encontrado")
            return 
        end
        
        local RootPart = Character.HumanoidRootPart
        local Distance = (P1.Position - RootPart.Position).Magnitude
        
        if Distance < 250 then
            RootPart.CFrame = P1
            wait()
            Character.Humanoid:ChangeState(11)
        else
            if ToTargetP then
                ToTargetP:Cancel()
            end
            
            local tween_s = game:service"TweenService"
            local info = TweenInfo.new((RootPart.Position - P1.Position).Magnitude/getgenv().TweenSpeed, Enum.EasingStyle.Linear)
            
            getgenv().ToTargetP = tween_s:Create(RootPart, info, {CFrame = P1})
            getgenv().ToTargetP:Play()
            
            if Config["Bypass TP"] then
                if Distance > 3000 then
                    Character:SetPrimaryPartCFrame(P1)
                    wait()
                    getgenv().ToTargetP:Cancel()
                end
            end
        end
    end)
end

-- Equip Weapon
function EquipWeapon(ToolSe)
    pcall(function()
        if LocalPlayer.Backpack:FindFirstChild(ToolSe) then
            local tool = LocalPlayer.Backpack:FindFirstChild(ToolSe)
            wait(0.5)
            LocalPlayer.Character.Humanoid:EquipTool(tool)
            LogSystem:Add("INFO", "Equipou arma: " .. ToolSe)
        end
    end)
end

-- ════════════════════════════════════════════════════════════
--                    FAST ATTACK SYSTEM
-- ════════════════════════════════════════════════════════════

local CombatFramework = require(LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigEvent = game:GetService("ReplicatedStorage").RigControllerEvent
local AttackAnim = Instance.new("Animation")
local AttackCoolDown = 0
local cooldowntickFire = 0
local MaxFire = 1000
local FireCoolDown = 0
local bladehit = {}

function CurrentWeapon()
    local ac = CombatFrameworkR.activeController
    local ret = ac.blades[1]
    if not ret then return LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
    pcall(function()
        while ret.Parent ~= LocalPlayer.Character do ret = ret.Parent end
    end)
    if not ret then return LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
    return ret
end

function getAllBladeHitsPlayers(Sizes)
    local Hits = {}
    local Client = LocalPlayer
    local Characters = game:GetService("Workspace").Characters:GetChildren()
    for i=1,#Characters do local v = Characters[i]
        local Human = v:FindFirstChildOfClass("Humanoid")
        if v.Name ~= Client.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
            table.insert(Hits,Human.RootPart)
        end
    end
    return Hits
end

function getAllBladeHits(Sizes)
    local Hits = {}
    local Client = LocalPlayer
    local Enemies = game:GetService("Workspace").Enemies:GetChildren()
    for i=1,#Enemies do local v = Enemies[i]
        local Human = v:FindFirstChildOfClass("Humanoid")
        if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
            table.insert(Hits,Human.RootPart)
        end
    end
    return Hits
end

function AttackFunction()
    pcall(function()
        local ac = CombatFrameworkR.activeController
        if ac and ac.equipped then
            for indexincrement = 1, 1 do
                local bladehit = getAllBladeHits(60)
                if #bladehit > 0 then
                    local u2 = debug.getupvalue(ac.attack, 5)
                    local u3 = debug.getupvalue(ac.attack, 6)
                    local u4 = debug.getupvalue(ac.attack, 4)
                    local u5 = debug.getupvalue(ac.attack, 7)
                    local increment = 4
                    local u7 = debug.getupvalue(ac.attack, 3)
                    local u8 = (u8 or 0) + 1
                    debug.setupvalue(ac.attack, 3, u8)
                    for k, v in pairs(ac.animator.anims.basic) do
                        v:Play(0.01,0.01,0.01)
                    end                 
                    if LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
                        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
                        game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u6 / 0.004 * 14), u7)
                        game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
                    end
                end
            end
        end
    end)
end

-- ════════════════════════════════════════════════════════════
--                    AUTO BUSO HAKI
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Buso Haki"] then
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
                    LogSystem:Add("INFO", "Ativou Buso Haki")
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO KEN HAKI
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Ken Haki"] then
                if not LocalPlayer.Character:FindFirstChild("HasBuso") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ken", true)
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO STATS
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Stats"] then
                local Points = LocalPlayer.Data.Points.Value
                if Points > 0 then
                    local StatToUpgrade = Config["Stats Mode"]
                    
                    if StatToUpgrade == "Melee" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", Config["Points Per Upgrade"])
                        LogSystem:Add("INFO", "Adicionou pontos em Melee")
                    elseif StatToUpgrade == "Defense" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", Config["Points Per Upgrade"])
                        LogSystem:Add("INFO", "Adicionou pontos em Defense")
                    elseif StatToUpgrade == "Sword" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", Config["Points Per Upgrade"])
                        LogSystem:Add("INFO", "Adicionou pontos em Sword")
                    elseif StatToUpgrade == "Gun" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Gun", Config["Points Per Upgrade"])
                        LogSystem:Add("INFO", "Adicionou pontos em Gun")
                    elseif StatToUpgrade == "Fruit" then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", Config["Points Per Upgrade"])
                        LogSystem:Add("INFO", "Adicionou pontos em Devil Fruit")
                    end
                    
                    wait(0.5)
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO FARM LEVEL
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Farm Level"] then
                local QuestData = GetCurrentQuest()
                if not QuestData then 
                    LogSystem:Add("ERROR", "QuestData é nil!")
                    return 
                end
                
                -- Take Quest
                if Config["Auto Quest"] then
                    local MyLevel = LocalPlayer.Data.Level.Value
                    
                    if PlayerGui.Main.Quest.Visible == false or not string.find(PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, QuestData.NameMon) then
                        repeat 
                            TP(QuestData.CFrameQuest) 
                            wait() 
                        until (QuestData.CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 or not Config["Auto Farm Level"]
                        
                        if (QuestData.CFrameQuest.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            wait(0.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestData.QuestName, QuestData.LevelQuest)
                            LogSystem:Add("SUCCESS", "Pegou quest: " .. QuestData.QuestName)
                            wait(0.5)
                        end
                    end
                end
                
                -- Farm Mobs
                local MobFound = false
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        if v.Name == QuestData.NameMon then
                            MobFound = true
                            repeat 
                                wait()
                                
                                -- Fast Attack
                                if Config["Fast Attack"] then
                                    AttackFunction()
                                end
                                
                                -- Equip Weapon
                                if Config["Select Weapon"] and Config["Select Weapon"][1] then
                                    EquipWeapon(Config["Select Weapon"][1])
                                end
                                
                                -- Disable Mob Collisions
                                v.HumanoidRootPart.CanCollide = false
                                v.Head.CanCollide = false
                                
                                -- Bring Mob
                                if Config["Bring Mob"] then
                                    v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                    v.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, Config["Bring Mob Distance"]/10)
                                end
                                
                                -- TP to Mob
                                TP(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                
                            until not Config["Auto Farm Level"] or not v.Parent or v.Humanoid.Health <= 0
                        end
                    end
                end
                
                -- Go to Mob Spawn if no mobs found
                if not MobFound then
                    TP(QuestData.CFrameMon)
                    LogSystem:Add("WARNING", "Nenhum mob encontrado. Indo para spawn...")
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO SABER (SEA 1)
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Saber"] and World == "Sea1" and LocalPlayer.Data.Level.Value >= 200 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
                    wait(0.5)
                    TP(CFrame.new(1397.229, 37.3480835, -1320.85217))
                    LogSystem:Add("INFO", "Auto Saber: Pegando copo...")
                    
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                    LogSystem:Add("INFO", "Auto Saber: Iniciando RichSon quest...")
                    
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v.Name == "Mob Leader" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                repeat 
                                    wait()
                                    if Config["Fast Attack"] then
                                        AttackFunction()
                                    end
                                    EquipWeapon(Config["Select Weapon"][1])
                                    TP(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                until not v.Parent or v.Humanoid.Health <= 0 or not Config["Auto Saber"]
                                
                                LogSystem:Add("SUCCESS", "Mob Leader derrotado!")
                            end
                        end
                    else
                        TP(CFrame.new(-2848.59399, 7.4272871, 5342.44043))
                        LogSystem:Add("INFO", "Indo para spawn do Mob Leader...")
                    end
                    
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                    wait(0.5)
                    EquipWeapon("Relic")
                    wait(0.5)
                    TP(CFrame.new(-1404.91504, 29.9773273, 3.80598116))
                    LogSystem:Add("SUCCESS", "Auto Saber completado!")
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO SECOND SEA (LVL 700+)
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto New World"] and World == "Sea1" and LocalPlayer.Data.Level.Value >= 700 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress") == 0 then
                    if not LocalPlayer.Backpack:FindFirstChild("Key") and not LocalPlayer.Character:FindFirstChild("Key") then
                        TP(CFrame.new(-12471.169921875, 374.9144592285156, -7551.677734375))
                        LogSystem:Add("INFO", "Indo pegar a Key...")
                    elseif LocalPlayer.Backpack:FindFirstChild("Key") or LocalPlayer.Character:FindFirstChild("Key") then
                        EquipWeapon("Key")
                        TP(CFrame.new(1347.7014160156, 37.356590270996, -7460.4438476563))
                        LogSystem:Add("INFO", "Usando Key na porta...")
                    end
                    
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress") == 1 then
                    TP(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                    LogSystem:Add("INFO", "Indo para King Legacy...")
                    
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress") == 2 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                    LogSystem:Add("SUCCESS", "Teleportando para Second Sea!")
                    wait(5)
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO THIRD SEA (LVL 1500+)
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Third World"] and World == "Sea2" and LocalPlayer.Data.Level.Value >= 1500 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
                    TP(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))
                    LogSystem:Add("INFO", "Indo iniciar quest para Third Sea...")
                    
                elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                    LogSystem:Add("SUCCESS", "Teleportando para Third Sea!")
                    wait(5)
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    SERVER HOP SYSTEM
-- ════════════════════════════════════════════════════════════

function ServerHop()
    pcall(function()
        LogSystem:Add("INFO", "Iniciando Server Hop...")
        
        local PlaceID = game.PlaceId
        local AllIDs = {}
        local foundAnything = ""
        local actualHour = os.date("!*t").hour
        
        local function TPReturner()
            local Site
            if foundAnything == "" then
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
            end
            
            if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
                foundAnything = Site.nextPageCursor
            end
            
            for i,v in pairs(Site.data) do
                if tonumber(v.maxPlayers) > tonumber(v.playing) then
                    local ID = tostring(v.id)
                    table.insert(AllIDs, ID)
                    wait()
                    TeleportService:TeleportToPlaceInstance(PlaceID, ID, LocalPlayer)
                    LogSystem:Add("SUCCESS", "Teleportando para novo servidor...")
                    wait(4)
                end
            end
        end
        
        TPReturner()
    end)
end

spawn(function()
    while wait(Config["Server Hop Delay"]) do
        if Config["Auto Server Hop"] then
            ServerHop()
        end
    end
end)

-- Level Cap Server Hop
spawn(function()
    while wait(1) do
        if Config["Hop When Level Cap"] then
            local LevelCap = 0
            
            if World == "Sea1" and LocalPlayer.Data.Level.Value >= 700 then
                LevelCap = 700
            elseif World == "Sea2" and LocalPlayer.Data.Level.Value >= 1500 then
                LevelCap = 1500
            elseif World == "Sea3" and LocalPlayer.Data.Level.Value >= 2550 then
                LevelCap = 2550
            end
            
            if LevelCap > 0 then
                LogSystem:Add("WARNING", "Level Cap atingido (" .. LevelCap .. "). Hopando servidor...")
                wait(2)
                ServerHop()
            end
        end
    end
end)

-- ════════════════════════════════════════════════════════════
--                    AUTO SUPERHUMAN
-- ════════════════════════════════════════════════════════════

spawn(function()
    while wait() do
        pcall(function()
            if Config["Auto Superhuman"] and LocalPlayer.Data.Level.Value >= 300 then
                if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Combat") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Combat") then
                    local args = {[1] = "BuyBlackLeg"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
                if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Black Leg") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value < 150 then
                    Config["Select Weapon"] = {"Black Leg"}
                else
                    if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") then
                        local args = {[1] = "BuyElectro"}
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
                    if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value < 150 then
                        Config["Select Weapon"] = {"Electro"}
                    else
                        if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") then
                            local args = {[1] = "BuyFishmanKarate"}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                        end
                        if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fishman Karate") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fishman Karate") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fishman Karate").Level.Value < 150 then
                            Config["Select Weapon"] = {"Fishman Karate"}
                        else
                            if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Claw") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Claw").Level.Value < 150 then
                                Config["Select Weapon"] = {"Dragon Claw"}
                            else
                                if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Superhuman") or not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Superhuman") then
                                    local args = {[1] = "BuySuperhuman"}
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    LogSystem:Add("SUCCESS", "Superhuman comprado!")
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- ════════════════════════════════════════════════════════════
--                    FPS BOOST
-- ════════════════════════════════════════════════════════════

if Config["FPS Boost"] then
    pcall(function()
        local decalsyeeted = true
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        
        settings().Rendering.QualityLevel = "Level01"
        
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
        
        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
        
        LogSystem:Add("SUCCESS", "FPS Boost ativado!")
    end)
end

-- ════════════════════════════════════════════════════════════
--                    WHITE SCREEN
-- ════════════════════════════════════════════════════════════

if Config["White Screen"] then
    game:GetService("RunService"):Set3dRenderingEnabled(false)
    LogSystem:Add("SUCCESS", "White Screen ativado!")
end

-- ════════════════════════════════════════════════════════════
--                    GUI - INTERFACE
-- ════════════════════════════════════════════════════════════

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🏴‍☠️ KAITUN HUB - " .. World, "DarkTheme")

-- ═══ TAB: STATUS ═══
local StatusTab = Window:NewTab("📊 Status")
local StatusSection = StatusTab:NewSection("Informações do Player")

StatusSection:NewLabel("Level: " .. LocalPlayer.Data.Level.Value)
StatusSection:NewLabel("Beli: " .. LocalPlayer.Data.Beli.Value)
StatusSection:NewLabel("Fragments: " .. (LocalPlayer.Data.Fragments.Value or 0))
StatusSection:NewLabel("World: " .. World)

local CurrentQuestData = GetCurrentQuest()
if CurrentQuestData then
    StatusSection:NewLabel("Quest Atual: " .. CurrentQuestData.QuestName)
    StatusSection:NewLabel("Mob: " .. CurrentQuestData.NameMon)
end

-- ═══ TAB: AUTO FARM ═══
local FarmTab = Window:NewTab("⚔️ Auto Farm")
local FarmSection = FarmTab:NewSection("Configurações de Farm")

FarmSection:NewToggle("Auto Farm Level", "Farm automaticamente", function(state)
    Config["Auto Farm Level"] = state
    LogSystem:Add("INFO", "Auto Farm Level: " .. tostring(state))
end)

FarmSection:NewToggle("Auto Quest", "Pega quest automaticamente", function(state)
    Config["Auto Quest"] = state
    LogSystem:Add("INFO", "Auto Quest: " .. tostring(state))
end)

FarmSection:NewToggle("Fast Attack", "Ataque rápido", function(state)
    Config["Fast Attack"] = state
    LogSystem:Add("INFO", "Fast Attack: " .. tostring(state))
end)

FarmSection:NewToggle("Bring Mob", "Traz mobs para você", function(state)
    Config["Bring Mob"] = state
    LogSystem:Add("INFO", "Bring Mob: " .. tostring(state))
end)

-- ═══ TAB: COMBAT ═══
local CombatTab = Window:NewTab("🥋 Combat")
local CombatSection = CombatTab:NewSection("Configurações de Combate")

CombatSection:NewToggle("Auto Buso Haki", "Ativa Buso automaticamente", function(state)
    Config["Auto Buso Haki"] = state
    LogSystem:Add("INFO", "Auto Buso Haki: " .. tostring(state))
end)

CombatSection:NewToggle("Auto Ken Haki", "Ativa Ken automaticamente", function(state)
    Config["Auto Ken Haki"] = state
    LogSystem:Add("INFO", "Auto Ken Haki: " .. tostring(state))
end)

CombatSection:NewToggle("Auto Superhuman", "Compra e upa Superhuman", function(state)
    Config["Auto Superhuman"] = state
    LogSystem:Add("INFO", "Auto Superhuman: " .. tostring(state))
end)

-- ═══ TAB: STATS ═══
local StatsTab = Window:NewTab("📈 Stats")
local StatsSection = StatsTab:NewSection("Configurações de Stats")

StatsSection:NewToggle("Auto Stats", "Upa stats automaticamente", function(state)
    Config["Auto Stats"] = state
    LogSystem:Add("INFO", "Auto Stats: " .. tostring(state))
end)

StatsSection:NewDropdown("Select Stats", "Escolha qual stat upar", {"Melee", "Defense", "Sword", "Gun", "Fruit"}, function(option)
    Config["Stats Mode"] = option
    LogSystem:Add("INFO", "Stats Mode: " .. option)
end)

StatsSection:NewSlider("Points Per Upgrade", "Quantos pontos por upgrade", 100, 1, function(value)
    Config["Points Per Upgrade"] = value
end)

-- ═══ TAB: QUESTS ═══
local QuestTab = Window:NewTab("📜 Quests")
local QuestSection = QuestTab:NewSection("Auto Quests Especiais")

if World == "Sea1" then
    QuestSection:NewToggle("Auto Saber", "Completa quest do Saber (Lvl 200+)", function(state)
        Config["Auto Saber"] = state
        LogSystem:Add("INFO", "Auto Saber: " .. tostring(state))
    end)
    
    QuestSection:NewToggle("Auto Pole V1", "Completa quest do Pole V1", function(state)
        Config["Auto Pole V1"] = state
        LogSystem:Add("INFO", "Auto Pole V1: " .. tostring(state))
    end)
    
    QuestSection:NewToggle("Auto New World", "Auto Second Sea (Lvl 700+)", function(state)
        Config["Auto New World"] = state
        LogSystem:Add("INFO", "Auto New World: " .. tostring(state))
    end)
end

if World == "Sea2" then
    QuestSection:NewToggle("Auto Third Sea", "Auto Third Sea (Lvl 1500+)", function(state)
        Config["Auto Third World"] = state
        LogSystem:Add("INFO", "Auto Third World: " .. tostring(state))
    end)
    
    QuestSection:NewToggle("Auto Pole V2", "Completa quest do Pole V2", function(state)
        Config["Auto Pole V2"] = state
        LogSystem:Add("INFO", "Auto Pole V2: " .. tostring(state))
    end)
end

-- ═══ TAB: MISC ═══
local MiscTab = Window:NewTab("⚙️ Misc")
local MiscSection = MiscTab:NewSection("Configurações Diversas")

MiscSection:NewToggle("FPS Boost", "Melhora o FPS", function(state)
    Config["FPS Boost"] = state
    if state then
        -- Reaplica FPS Boost
    end
end)

MiscSection:NewToggle("White Screen", "Desabilita renderização", function(state)
    Config["White Screen"] = state
    game:GetService("RunService"):Set3dRenderingEnabled(not state)
end)

MiscSection:NewToggle("Hop When Level Cap", "Muda servidor ao atingir level cap", function(state)
    Config["Hop When Level Cap"] = state
    LogSystem:Add("INFO", "Hop When Level Cap: " .. tostring(state))
end)

MiscSection:NewButton("Server Hop Manual", "Muda de servidor agora", function()
    ServerHop()
end)

-- ═══ TAB: LOGS ═══
local LogTab = Window:NewTab("📋 Logs & Debug")
local LogSection = LogTab:NewSection("Sistema de Logs")

LogSection:NewButton("Mostrar Todos os Logs", "Exibe todos os logs no console", function()
    print("═══════════════════════════════════")
    print("        KAITUN HUB - LOGS")
    print("═══════════════════════════════════")
    print(LogSystem:GetAll())
    print("═══════════════════════════════════")
end)

LogSection:NewButton("Mostrar Apenas Erros", "Exibe apenas os erros", function()
    print("═══════════════════════════════════")
    print("       KAITUN HUB - ERRORS")
    print("═══════════════════════════════════")
    print(LogSystem:GetErrors())
    print("═══════════════════════════════════")
end)

LogSection:NewButton("Copiar Logs (Console)", "Copia logs para console F9", function()
    setclipboard(LogSystem:GetAll())
    LogSystem:Add("SUCCESS", "Logs copiados para área de transferência!")
end)

LogSection:NewButton("Limpar Logs", "Limpa todos os logs", function()
    LogSystem:Clear()
    LogSystem:Add("INFO", "Logs limpos!")
end)

local DebugSection = LogTab:NewSection("Informações de Debug")

DebugSection:NewButton("Debug: Character Info", "Mostra info do personagem", function()
    local char = LocalPlayer.Character
    if char then
        LogSystem:Add("DEBUG", "Character Name: " .. char.Name)
        LogSystem:Add("DEBUG", "HumanoidRootPart: " .. tostring(char:FindFirstChild("HumanoidRootPart") ~= nil))
        LogSystem:Add("DEBUG", "Humanoid Health: " .. (char:FindFirstChild("Humanoid") and char.Humanoid.Health or "N/A"))
    else
        LogSystem:Add("ERROR", "Character não encontrado!")
    end
end)

DebugSection:NewButton("Debug: Quest Info", "Mostra info da quest", function()
    local quest = GetCurrentQuest()
    if quest then
        LogSystem:Add("DEBUG", "Quest Name: " .. quest.QuestName)
        LogSystem:Add("DEBUG", "Mob: " .. quest.NameMon)
        LogSystem:Add("DEBUG", "Min Level: " .. quest.MinLv)
        LogSystem:Add("DEBUG", "Max Level: " .. quest.MaxLv)
    else
        LogSystem:Add("ERROR", "Quest data não encontrada!")
    end
end)

DebugSection:NewButton("Debug: Enemies Count", "Conta inimigos no workspace", function()
    local count = 0
    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
        count = count + 1
    end
    LogSystem:Add("DEBUG", "Total de inimigos: " .. count)
end)

DebugSection:NewButton("Test All Functions", "Testa todas as funções principais", function()
    LogSystem:Add("TEST", "Iniciando teste de funções...")
    
    -- Test GetCurrentQuest
    local quest = GetCurrentQuest()
    if quest then
        LogSystem:Add("TEST", "✅ GetCurrentQuest() funcionando")
    else
        LogSystem:Add("ERROR", "❌ GetCurrentQuest() falhou")
    end
    
    -- Test Character
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LogSystem:Add("TEST", "✅ Character detectado")
    else
        LogSystem:Add("ERROR", "❌ Character não detectado")
    end
    
    -- Test Remotes
    pcall(function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
        LogSystem:Add("TEST", "✅ Remotes funcionando")
    end)
    
    LogSystem:Add("TEST", "Teste concluído!")
end)

-- ═══ TAB: CREDITS ═══
local CreditsTab = Window:NewTab("ℹ️ Credits")
local CreditsSection = CreditsTab:NewSection("Informações do Script")

CreditsSection:NewLabel("🏴‍☠️ KAITUN HUB v2.0")
CreditsSection:NewLabel("Desenvolvido para Blox Fruits")
CreditsSection:NewLabel("Suporta: Sea 1, 2 e 3")
CreditsSection:NewLabel("═════════════════════")
CreditsSection:NewLabel("Features:")
CreditsSection:NewLabel("✅ Auto Farm Level (All Seas)")
CreditsSection:NewLabel("✅ Auto Quest System")
CreditsSection:NewLabel("✅ Fast Attack")
CreditsSection:NewLabel("✅ Auto Stats")
CreditsSection:NewLabel("✅ Auto Haki")
CreditsSection:NewLabel("✅ Auto Second/Third Sea")
CreditsSection:NewLabel("✅ Auto Saber & Pole")
CreditsSection:NewLabel("✅ Auto Superhuman")
CreditsSection:NewLabel("✅ Server Hop")
CreditsSection:NewLabel("✅ FPS Boost")
CreditsSection:NewLabel("✅ Complete Log System")
CreditsSection:NewLabel("═════════════════════")
CreditsSection:NewLabel("⚠️ USE POR SUA CONTA E RISCO")

-- ════════════════════════════════════════════════════════════
--                    NOTIFICAÇÕES
-- ════════════════════════════════════════════════════════════

game.StarterGui:SetCore("SendNotification", {
    Title = "🏴‍☠️ KAITUN HUB";
    Text = "Script carregado com sucesso!";
    Duration = 5;
})

game.StarterGui:SetCore("SendNotification", {
    Title = "📊 Status";
    Text = "Level: " .. LocalPlayer.Data.Level.Value .. " | World: " .. World;
    Duration = 5;
})

-- Log Final
LogSystem:Add("SUCCESS", "════════════════════════════════════════")
LogSystem:Add("SUCCESS", "   KAITUN HUB CARREGADO COM SUCESSO")
LogSystem:Add("SUCCESS", "════════════════════════════════════════")
LogSystem:Add("INFO", "Player: " .. LocalPlayer.Name)
LogSystem:Add("INFO", "Level: " .. LocalPlayer.Data.Level.Value)
LogSystem:Add("INFO", "World: " .. World)
LogSystem:Add("INFO", "Quest Atual: " .. (CurrentQuestData and CurrentQuestData.QuestName or "N/A"))
LogSystem:Add("SUCCESS", "════════════════════════════════════════")
LogSystem:Add("WARNING", "Pressione F9 para ver os logs detalhados")
LogSystem:Add("WARNING", "Use o menu Logs & Debug para debug")
LogSystem:Add("SUCCESS", "════════════════════════════════════════")

print("🏴‍☠️ KAITUN HUB - Totalmente carregado!")
