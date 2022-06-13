local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GUN_PICKUP_WAIT = 0.25
local GOD_MODE_WAIT = 0.1
local GOD_MODE_NAME = "1"

-- selene: allow(incorrect_standard_library_use)
local Finity = loadstring(game:HttpGet("https://pastebin.com/raw/xpT46ucU"))()
local State = loadstring(game:HttpGet(""))()

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()


local Window = Finity.new(true, "MM2", UDim2.new(0, 600, 0, 350))
Window.ChangeToggleKey(Enum.KeyCode.RightControl)


local CategoryA = FinityWindow:Category("Active")
local SectorA1 = CategoryA:Sector("Gameplay")
SectorA1:Cheat("Toggle", "Invisibility", function(state)
    ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(state)
end)
SectorA1:Cheat("Toggle", "Trail", function(state)
    character.SpeedTrail.Toggle:FireServer(state)
end)
SectorA1:Cheat("Button", "Fake Gun", function()
    ReplicatedStorage.Remotes.Gameplay.FakeGun:FireServer(true)
end)
SectorA1:Cheat("Button", "God Mode", function()
    character.Humanoid.Name = GOD_MODE_NAME

    local newHumanoid = character[GOD_MODE_NAME]:Clone()
    newHumanoid.Parent = character
    wait(GOD_MODE_WAIT)
    character[GOD_MODE_NAME]:Destroy()

    -- selene: allow(incorrect_standard_library_use)
    workspace.CurrentCamera.CameraSubject = newHumanoid
    character.Animate.Disabled = true
    wait(GOD_MODE_WAIT)
    character.Animate.Disabled = false
    newHumanoid.BreakJointsOnDeath = false
end)
SectorA1:Cheat("Button", "Grab Gun", function()
    local gun = workspace:FindFirstChild("GunDrop")
    local humanoidRootPart = character.HumanoidRootPart

    local oldCFrame = humanoidRootPart.CFrame

    if gun ~= nil then
        humanoidRootPart.CFrame = gun.CFrame
        wait(GUN_PICKUP_WAIT)
        humanoidRootPart.CFrame = oldCFrame
    end
end)
local SectorA2 = CategoryA:Sector("Teleports")
SectorA2:Cheat("Button", "Map", function()
    for _, map in ipairs(workspace:GetChildren()) do
        local spawns = map:FindFirstChild("Spawns")
        if spawns then
            character:MoveTo(spawns.Spawn.Position)
        end
    end
end)
SectorA2:Cheat("Button", "Spawn", function()
    character:MoveTo(SPAWN_POSITION)
end)
SectorA2:Cheat("Button", "Voting Room", function()
    character:MoveTo(VOTING_ROOM_POSITION)
end)
