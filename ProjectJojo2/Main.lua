--[[
Feature Ideas:
-- auto grinding for stands
]]

local QUESTS = {
    ["Dummy Hater"] = {
        Name = "Dummy Hater";
        LevelRequirement = 0;
        CashReward = 2100;
        ExpReward = 450;
        MasterExpReward = 0;
        WorthinessReward = 3;
        SpecialReward = "";
        Difficulty = "Easy";
        QuestGiver = "Gyro";
        RequirmentText = "Kill Plastic Dummies";
        RequirmentCount = 5;
        NPCSpeech1 = "What's up? I'll be honest... Those dummies over there are bugging me. Ill pay 'ya if you kil-er... exterminate some of them.";
        NPCSpeech2 = "Hey, thanks for that. I've still got some loose change, so, if you exterminate some more, i'll pay you again.";
        NPCSpeechUnfinished = "Hey, buddy, you gonna finish that task I gave you?";
        NPCRequirementFailed = "How are you below level zero...";
        NPCLink = "GyroDummyHater";
        Dummies = {"Plastic Dummy (Level 1)", "Ethereal Dummy (Level 1)"}
    };
    Deforestation = {
        Name = "Deforestation";
        LevelRequirement = 5;
        CashReward = 2800;
        ExpReward = 2750;
        MasterExpReward = 0;
        WorthinessReward = 10;
        SpecialReward = "";
        Difficulty = "Easy";
        QuestGiver = "Gyro";
        RequirmentText = "Kill Wood Dummies";
        RequirmentCount = 5;
        NPCSpeech1 = "I hate trees. I'll pay you if you chop down some of those dummies made of wood over there.";
        NPCSpeech2 = "Hey, thanks for that. I'll pay you if you chop down some more.";
        NPCSpeechUnfinished = "... They're wooden dummies man, are you really struggling this much?";
        NPCRequirementFailed = "Come back when you're a bit more experienced. [Level 5]";
        NPCLink = "GyroDeforestation";
        Dummies = {"Wood Dummy (Level 5)", "Forest Dummy (Level 5)"}
    };
    ["Surf's Up!"] = {
        Name = "Surf's Up!";
        LevelRequirement = 10;
        CashReward = 4900;
        ExpReward = 7200;
        MasterExpReward = 0;
        WorthinessReward = 15;
        SpecialReward = "";
        Difficulty = "Easy";
        QuestGiver = "Surfer Dude Gyro";
        RequirmentText = "Kill Ice Dummies";
        RequirmentCount = 6;
        NPCSpeech1 = "Sah' dude! Like, I'm trying to chill out here and take a swim, but, those ice dummies are freezing the lake! I'll pay you if you like... get rid of them.";
        NPCSpeech2 = "Wussah' dude? Like, thanks for gettin' rid of them! Seems like the lake's still frozen, though. Do it again!";
        NPCSpeechUnfinished = "Like... you're crampin' my style, brah...";
        NPCRequirementFailed = "Come back when you're a bit more experienced. [Level 10]";
        NPCLink = "GyroSurfsUp";
        Dummies = {"Ice Dummy (Level 10)", "Blizzard Dummy (Level 10)"}
    };
    ["Not Rockin'"] = {
        Name = "Not Rockin'";
        LevelRequirement = 15;
        CashReward = 5600;
        ExpReward = 24250;
        MasterExpReward = 0;
        WorthinessReward = 20;
        SpecialReward = "";
        Difficulty = "Medium";
        QuestGiver = "Gyro Presley";
        RequirmentText = "Kill Rock Dummies";
        RequirmentCount = 6;
        NPCSpeech1 = "Hey man, I came out here because I heard there were some serious rockers in here! Maybe if you get rid of all the rocks in there I can find my people!";
        NPCSpeech2 = "I got some more money, and it seems like there's still some in there... Do it again!";
        NPCSpeechUnfinished = "So, you wanna hire me for a party?";
        NPCRequirementFailed = "Come back when you're a bit more experienced. [Level 15]";
        NPCLink = "GyroRockin";
        Dummies = {"Rock Dummy (Level 15)", "Fortress Dummy (Level 15)"}
    };
    ["Stone Revolution"] = {
        Name = "Stone Revolution";
        LevelRequirement = 25;
        CashReward = 7700;
        ExpReward = 61625;
        MasterExpReward = 0;
        WorthinessReward = 30;
        SpecialReward = "";
        Difficulty = "Medium";
        QuestGiver = "Gyro";
        RequirmentText = "Kill Metal Dummies";
        RequirmentCount = 7;
        NPCSpeech1 = "I HATE METAL! These metal dummies moved in near my house, and it's really bugging me! Take them out!";
        NPCSpeech2 = "STONE FOR LIIIIIIFFFEEEE!!! Take some more out, I've got the cash.";
        NPCSpeechUnfinished = "They're still there!";
        NPCRequirementFailed = "Come back when you're a bit more experienced. [Level 25]";
        NPCLink = "GyroStoneRevolution";
        Dummies = {"Metal Dummy (Level 25)", "Reinforced Dummy (Level 25)"}
    };
    ["Metal Revolution"] = {
        Name = "Metal Revolution";
        LevelRequirement = 35;
        CashReward = 8400;
        ExpReward = 126000;
        MasterExpReward = 0;
        WorthinessReward = 40;
        SpecialReward = "";
        Difficulty = "Medium";
        QuestGiver = "Gyro";
        RequirmentText = "Kill Cobalt Dummies";
        RequirmentCount = 7;
        NPCSpeech1 = "Man, those cobalt dummies over there are really bugging me. I'll pay you to take some out.";
        NPCSpeech2 = "Seems like they're able to rebuild themselves. I'll pay you to take a few more out.";
        NPCSpeechUnfinished = "Have you seen my distant brother?";
        NPCRequirementFailed = "Come back when you're a bit more experienced. [Level 35]";
        NPCLink = "GyroMetalRevolution";
        Dummies = {"Cobalt Dummy (Level 35)", "Corroded Dummy (Level 35)"}
    };
    ["Giant Problems"] = {
        Name = "Giant Problems";
        LevelRequirement = 45;
        CashReward = 10500;
        ExpReward = 203000;
        MasterExpReward = 0;
        WorthinessReward = 50;
        SpecialReward = "";
        Difficulty = "Medium";
        QuestGiver = "Gyro";
        RequirmentText = "Kill Giant Dummies";
        RequirmentCount = 8;
        NPCSpeech1 = "GAH! I'm afraid of big things! Take these giant dummies out so I can chill out!";
        NPCSpeech2 = "There's still more! Please, take them out!";
        NPCSpeechUnfinished = "I'm freakin' out here.";
        NPCRequirementFailed = "Come back when you're a bit more experienced. [Level 45]";
        NPCLink = "GyroGiantProblems";
        Dummies = {"Giant Dummy (Level 45)", "Dwarf Dummy (Level 45)"}
    };
}
local ITEMS = {
    Aja = {
        FolderName = "Quest Ajas",
        Name = "Aja",
        QuestNPC = "Zepelli"
    },
    Guitar = {
        FolderName = "Quest Guitars",
        Name = "Cube",
        QuestNPC = "Akira Otoishi"
    },
    Beetle = {
        FolderName = "Quest Beetles",
        Name = "Quest Beetle",
        QuestNPC = "Jobin Higashikata"
    },
}

local Queue = {}
Queue.__index = Queue

function Queue.new()
    local queue = {}
	setmetatable(queue, Queue)
	queue.queue = {}
    queue.firstIndex = 1
    queue.lastIndex = 0
	return queue
end

function Queue:enqueue(item)
    self.lastIndex += 1
    self.queue[self.lastIndex] = item
end

function Queue:dequeue()
    if self.firstIndex > self.lastIndex then
        return nil
    end

    local item = self.queue[self.firstIndex]
    self.queue[self.firstIndex] = nil
    self.firstIndex += 1
	return item
end

function Queue:print()
    print("firstIndex", self.firstIndex)
    print("lastIndex", self.lastIndex)
    for k, v in pairs(self.queue) do
        print(k, v)
    end
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = Players.LocalPlayer
local items = Workspace.Items
local npcs = Workspace.NPCs
local mobs = Workspace.Mobs

local autofarmDummy = false
local ongoingQuestActive = false
local ongoingQuest = nil

local teleportCheck = false
Players.LocalPlayer.OnTeleport:Connect(function()
    warn('works')
	if not teleportCheck and queue_on_teleport then
		teleportCheck = true
		queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/sadneo/roblox-scripts/refs/heads/main/ProjectJojo2/Main.lua'))()")
	end
end)

local function findQuestItem(itemDetails)
    local npc = npcs:FindFirstChild(itemDetails.QuestNPC)
    local npcClickDetector = npc:FindFirstChildWhichIsA("ClickDetector", true)
    if not npcClickDetector then
        warn("NPC does not have click detector")
    end

    player.Character:MoveTo(npc.PrimaryPart.Position)
    task.wait(0.2)
    fireclickdetector(npcClickDetector, 5)
    task.wait(2)
    
    for _, itemInstance in workspace.NPCs[itemDetails.FolderName]:GetChildren() do
        if itemInstance[itemDetails.Name].Transparency ~= 1 then
            game.Players.LocalPlayer.Character:MoveTo(itemInstance.PrimaryPart.Position)
            break
        end
    end
end

local function getQuest()
    while autofarmDummy and not ongoingQuestActive do
        player.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
		local npc = npcs:FindFirstChild(ongoingQuest.NPCLink)
		local npcClickDetector = npc:FindFirstChildWhichIsA("ClickDetector", true)
        if not npcClickDetector then
            warn("NPC does not have click detector")
        end

		player.Character:MoveTo(npc.PrimaryPart.Position)
		task.wait(0.2)
		fireclickdetector(npcClickDetector, 5)
		task.wait(.4)
    end
end

local function killDummy()
	local dummy
    for _, dummyName in ipairs(ongoingQuest.Dummies) do
        local tryDummy = mobs:FindFirstChild(dummyName)
        if tryDummy ~= nil then
            dummy = tryDummy
        end
    end
    if dummy == nil then
        return
    end

	while autofarmDummy and dummy:FindFirstChild("HumanoidRootPart") do
        player.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
        local at = dummy.HumanoidRootPart.Position - Vector3.new(0, 3, 0)
        local lookAt = Vector3.new(0, 1, 0)
        local upVector = dummy.HumanoidRootPart.CFrame.RightVector
        local cf = CFrame.lookAlong(at, lookAt, upVector)
        player.Character:PivotTo(cf + cf.UpVector * 2)
        task.wait()
    end
	task.wait()
end

local function getBestQuest()
    local level = tonumber(player.PlayerGui.PlayerStats.PlayerStatsContainer.Experience.Level.LevelValue.Text) or 50
    local questBestFit = nil
    local questBestFitLevel = 0
    for _, quest in QUESTS do
        local req = quest.LevelRequirement
        if level >= req and req > questBestFitLevel then
            questBestFitLevel = req
            questBestFit = quest
        end
    end
    return questBestFit
end

function grabAllItems()
    local saveCFrame = player.Character.PrimaryPart.CFrame
    for _, item in items:GetChildren() do
        if #player.Backpack:GetChildren() >= 30 then
            break
        end

        local part = item:FindFirstChildWhichIsA("BasePart", false)
        local clickDetector = item:FindFirstChildWhichIsA("ClickDetector", true)
        if not part or not clickDetector then
            continue
        end

        player.Character:MoveTo(part.Position)
        task.wait(.2)
        fireclickdetector(clickDetector, 10)
    end
    player.Character:PivotTo(saveCFrame)
end

function showShop()
    local frame = player.PlayerGui.Items.ShopFrame
    frame.Visible = not frame.Visible
end

ReplicatedStorage.Events.Menu.UpdateQuest.OnClientEvent:Connect(function(_, info)
	ongoingQuestActive = info[1]
end)

local Finity = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/bloodball/UI-Librarys/refs/heads/main/Finity%20UI%20Lib"))()
print(("\n"):rep(100))

local interface = Finity.new(true, "Neo's Project Jojo 2", UDim2.fromOffset(450, 350))
interface.ChangeToggleKey(Enum.KeyCode.Delete)
local mainCategory = interface:Category("Main")
local generalSector = mainCategory:Sector("General")
generalSector:Cheat("Button", "Show Shop", showShop, {text="Toggle"})
generalSector:Cheat("Button", "Grab All Items", grabAllItems, {text="Grab"})
generalSector:Cheat("Label", "Press Delete to hide UI")
local autofarmSector = mainCategory:Sector("Autofarm")
autofarmSector:Cheat("Toggle", "Dummy Farm", function(value)
    autofarmDummy = value
    while autofarmDummy do
        local tryQuest = getBestQuest()
        if ongoingQuest ~= tryQuest then
            ongoingQuestActive = false
            ongoingQuest = tryQuest
        end
    
        if ongoingQuestActive then
            killDummy()
        else
            getQuest()
        end
        task.wait(.4)
    end
end)


local teleportCategory = interface:Category("Teleports")
local serverhopSector = teleportCategory:Sector("Serverhop")
serverhopSector:Cheat("Button", "Serverhop", function()
    local servers = {}
    local req = request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)})
    local body = game:GetService("HttpService"):JSONDecode(req.Body)

    if body and body.data then
        for _, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end

    if #servers > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
    end
end)
local teleportSector = teleportCategory:Sector("Points of Interest")
local teleports = {
    ["Restaurant"] = Vector3.new(-241, 9, -288),
    ["School"] = Vector3.new(-869, 6, 148),
    ["Fusion Area"] = Vector3.new(-1353, 9, -363),
    ["Mid"] = Vector3.new(15, 11, 84),
}
for name, location in teleports do
    teleportSector:Cheat("Button", name, function()
        player.Character:MoveTo(location)        
    end, {text="Teleport"})
end
local questSector = teleportCategory:Sector("Quest Items")
for questItemName, itemDetails in ITEMS do
    questSector:Cheat("Button", questItemName, function()
        findQuestItem(itemDetails)
    end, {text="Teleport"})
end


local npcCategory = interface:Category("NPCs")
local npcTeleportSector = npcCategory:Sector("Teleports")
for _, npc in npcs:GetChildren() do
    if npc.ClassName ~= "Model" then
        continue
    end

    npcTeleportSector:Cheat("Button", npc.Name, function()
		local position = npc.PrimaryPart.Position
        player.Character:MoveTo(position + Vector3.new(0, 5, 0))
    end)
end