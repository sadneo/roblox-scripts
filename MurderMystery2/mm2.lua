local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local GeneratePage = require(ReplicatedStorage.Modules.EmoteModule).GeneratePage

local SPAWN_POSITION = Vector3.new(-108, 138, 9)
local VOTING_ROOM_POSITION = Vector3.new(-108, 141, 83)

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

local targetName
local isTrappingAll = false
local isTrappingTarget = false

local deadChatSettings = { --customize private logs
	Color = Color3.fromRGB(163, 162, 165); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}
local runningSpeed = 24
local runningPower = 100
local seeDeadChatEnabled = false
local silentAimEnabled = false
local isKnivesEnabled = false
local isTrapsEnabled = false

local coinFolder
local coinEspEnabled = false
local espEnabled = false
local namesEnabled = false

local isThrowing = false
local isTrapping = false
--local isStrafing = false

local espFolder = Instance.new("Folder")
espFolder.Name = "EspFolder"
espFolder.Parent = CoreGui

-- functions
local function createEspBox(instance, color) -- need to set parent, name is set for you
    local espBox = Instance.new("BoxHandleAdornment")
    espBox.Name = instance.Name
    espBox.Visible = espEnabled
    espBox.Adornee = instance
    espBox.AlwaysOnTop = true
    espBox.ZIndex = 10
    espBox.Size = instance.Size
    espBox.Transparency = 0.8
    espBox.Color3 = color
    return espBox
end

local function createEspName(person)
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Enabled = namesEnabled
    BillboardGui.Adornee = person.Character.Head
    BillboardGui.Name = "Head"
    BillboardGui.Size = UDim2.new(0, 100, 0, 150)
    BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
    BillboardGui.AlwaysOnTop = true

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = person.Name
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0, 0, 0, -50)
    TextLabel.Size = UDim2.new(0, 100, 0, 100)
    TextLabel.Font = Enum.Font.SourceSansSemibold
    TextLabel.TextSize = 20
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    TextLabel.ZIndex = 10
    TextLabel.Parent = BillboardGui

    return BillboardGui
end

local function playerEsp(person) -- idk, might wanna create a new way? i don't like this lengthy function
    if person == player then return nil end
    local ESPHolder = Instance.new("Folder")
    ESPHolder.Name = person.Name.."EspFolder"
    ESPHolder.Parent = CoreGui

    if not person.Character then -- wait for body parts for the esp
        person.CharacterAdded:Wait()
        task.wait(1)
    end

    for _, bodyPart in pairs (person.Character:GetChildren()) do -- chams
        if bodyPart:IsA("BasePart") then
            local espPart = createEspBox(bodyPart, Color3.new(0, 1, 0))
            espPart.Parent = ESPHolder
        end
    end
    createEspName(person).Parent = ESPHolder

    local x
    
    person.CharacterAdded:Connect(function(character)
        x:Disconnect()
        for _, espPart in ipairs(ESPHolder:GetChildren()) do
            espPart.Adornee = character:WaitForChild(espPart.Name)
            if espPart:IsA("BoxHandleAdornment") then
                espPart.Color3 = Color3.new(0, 1, 0)
            end
        end
        
        x = person.Backpack.ChildAdded:Connect(function(tool)
            if tool.Name == "Tool" then
                tool:GetPropertyChangedSignal("Name"):Wait()
            end
            if tool.Name == "Gun" then
                for _, espPart in ipairs(ESPHolder:GetChildren()) do
                    if espPart:IsA("BoxHandleAdornment") then
                        espPart.Color3 = Color3.new(0, 0, 1)
                    end
                end
            elseif tool.Name == "Knife" then
                for _, espPart in ipairs(ESPHolder:GetChildren()) do
                    if espPart:IsA("BoxHandleAdornment") then
                        espPart.Color3 = Color3.new(1, 0, 0)
                    end
                end
            end
        end)
    end)

    
    x = person.Backpack.ChildAdded:Connect(function(tool)
        if tool.Name == "Tool" then
            tool:GetPropertyChangedSignal("Name"):Wait()
        end
        if tool.Name == "Gun" then
            for _, espPart in ipairs(ESPHolder:GetChildren()) do
                if espPart:IsA("BoxHandleAdornment") then
                    espPart.Color3 = Color3.new(0, 0, 1)
                end
            end
        elseif tool.Name == "Knife" then
            for _, espPart in ipairs(ESPHolder:GetChildren()) do
                if espPart:IsA("BoxHandleAdornment") then
                    espPart.Color3 = Color3.new(1, 0, 0)
                end
            end
        end
    end)

    return ESPHolder
end

local function ClosestPlayerToMouse()
    local target = nil
    local dist = math.huge
    for _, person in ipairs(Players:GetPlayers()) do
        if person.Name ~= player.Name and person.Character and person.Character:FindFirstChild("HumanoidRootPart") then
            local screenpoint = camera:WorldToScreenPoint(person.Character.HumanoidRootPart.Position)
            local check = (Vector2.new(mouse.X, mouse.Y)-Vector2.new(screenpoint.X, screenpoint.Y)).Magnitude

            if check < dist then
                target = person.Character.HumanoidRootPart
                dist = check
            end
        end
    end

    return target
end

local function onChatted(chatter, message)
    if seeDeadChatEnabled == true then
        if chatter ~= player then
            deadChatSettings.Text = "["..chatter.Name.."]: ".. message
            StarterGui:SetCore("ChatMakeSystemMessage", deadChatSettings)
         end
    end
end

-- UI
-- selene: allow(incorrect_standard_library_use)
local library = loadstring(game:HttpGet("https://pastebin.com/raw/xpT46ucU"))()

local FinityWindow = library.new(true, "MM2", UDim2.new(0, 600, 0, 350))
FinityWindow.ChangeToggleKey(Enum.KeyCode.RightControl)

local CategoryA = FinityWindow:Category("Active")
local SectorA1 = CategoryA:Sector("Gameplay")
SectorA1:Cheat("Toggle", "Invisibility", function(state)
    ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(state)
end)
SectorA1:Cheat("Toggle", "Trail", function(state)
    player.Character.SpeedTrail.Toggle:FireServer(state)
end)
SectorA1:Cheat("Button", "Fake Gun", function()
    ReplicatedStorage.Remotes.Gameplay.FakeGun:FireServer(true)
end)
SectorA1:Cheat("Button", "God Mode", function()
    player.Character.Humanoid.Name = "1"
    local newHumanoid = player.Character["1"]:Clone()
    newHumanoid.Parent = player.Character
    newHumanoid.Name = "Humanoid"
    wait(0.1)
    player.Character["1"]:Destroy()

    -- selene: allow(incorrect_standard_library_use)
    workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
    player.Character.Animate.Disabled = true
    wait(0.1)
    player.Character.Animate.Disabled = false
    newHumanoid.BreakJointsOnDeath = false
end)
SectorA1:Cheat("Button", "Grab Gun", function()
    local oldCFrame = player.Character.HumanoidRootPart.CFrame

    if workspace:FindFirstChild("GunDrop") ~= nil then
        player.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame
        wait(.25)
        player.Character.HumanoidRootPart.CFrame = oldCFrame
    end
end)

local SectorA2 = CategoryA:Sector("Teleports")
SectorA2:Cheat("Button", "Map", function()
    for _, map in ipairs(workspace:GetChildren()) do
        local spawns = map:FindFirstChild("Spawns")
        if spawns then
            player.Character:MoveTo(spawns.Spawn.Position)
        end
    end
end)
SectorA2:Cheat("Button", "Spawn", function()
    player.Character:MoveTo(SPAWN_POSITION)
end)
SectorA2:Cheat("Button", "Voting Room", function()
    player.Character:MoveTo(VOTING_ROOM_POSITION)
end)


local CategoryB = FinityWindow:Category("Other")
local SectorB1 = CategoryB:Sector("Other")
SectorB1:Cheat("Button", "Btools", function()
    -- selene: allow(incorrect_standard_library_use)
    local Clone_T = Instance.new("HopperBin", player.Backpack)
    Clone_T.BinType = "Clone"
    -- selene: allow(incorrect_standard_library_use)
    local Destruct = Instance.new("HopperBin", player.Backpack)
    Destruct.BinType = "Hammer"
    -- selene: allow(incorrect_standard_library_use)
    local Hold_T = Instance.new("HopperBin", player.Backpack)
    Hold_T.BinType = "Grab"
end)
SectorB1:Cheat("Button", "Unlock Workspace", function()
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Locked = false
        end
    end
end)
SectorB1:Cheat("Button", "Remove Barriers", function()
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            if part.Transparency ~= 0 then
                part.CanCollide = false
            else
                part.CanCollide = true
            end
        end
    end
end)
SectorB1:Cheat("Button", "Emotes", function()
    local target = player.PlayerGui.MainGUI.Game:FindFirstChild("Emotes")
    local emotelist = {"headless", "zombie", "zen", "ninja", "floss", "dab"}
    GeneratePage(emotelist, target, "Emotes")
end)
SectorB1:Cheat("Toggle", "X-Ray", function(state)
    for _, basePart in ipairs(workspace:GetDescendants()) do
        if basePart:IsA("BasePart") then
            basePart.Transparency = state and .5 or 0
        end
    end
end)
SectorB1:Cheat("Toggle", "Void Protection", function(state)
    -- selene: allow(incorrect_standard_library_use)
    workspace.FallenPartsDestroyHeight = state and -50000 or -500
end)

local SectorB2 = CategoryB:Sector("Traps")
SectorB2:Cheat("Textbox", "Player Name", function(name)
    for _, person in ipairs(Players:GetPlayers()) do
        if string.lower(string.sub(person.Name, 1, #name)) == string.lower(name) then
            targetName = person
        end
    end
end, {placeholder = "Username"})
SectorB2:Cheat("Button", "Trap Target", function()
    local targetPlayer = targetName
    if targetPlayer then
        local hrp = targetPlayer.Character.HumanoidRootPart.Position
        ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(CFrame.new(hrp))
    end
end)
SectorB2:Cheat("Checkbox", "Loop Trap Target", function(state) 
	isTrappingTarget = state
    while isTrappingTarget do
        local hrp = targetName.Character.HumanoidRootPart.Position
        ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(CFrame.new(hrp))
        task.wait()
    end
end)
SectorB2:Cheat("Button", "Trap All", function()
    for _, person in ipairs(Players:GetPlayers()) do
		local hrp = person.Character.HumanoidRootPart.CFrame.Position
		ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(CFrame.new(hrp))
	end
end)
SectorB2:Cheat("Checkbox", "Loop Trap All", function(state)
	isTrappingAll = state
    while isTrappingAll do
        for _, person in ipairs(Players:GetPlayers()) do
            local hrp = person.Character.HumanoidRootPart
            ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(hrp.CFrame)
        end
        task.wait()
    end
end)

local CategoryC = FinityWindow:Category("Settings")
local SectorC1 = CategoryC:Sector("Keybinds")
SectorC1:Cheat("Label", "Run (Ctrl)")
SectorC1:Cheat("Textbox", "Running Speed", function(value)
    if type(value) == "number" then
        runningSpeed = value
    end
end, {placeholder = "Integer"})
SectorC1:Cheat("Textbox", "Running Power", function(value)
    if type(value) == "number" then
        runningPower = value
    end
end, {placeholder = "Integer"})
SectorC1:Cheat("Toggle", "Dead Chat Enabled", function(state)
    seeDeadChatEnabled = state
end)
SectorC1:Cheat("Toggle", "Gun Silent Aim", function(state)
    silentAimEnabled = state
end)
SectorC1:Cheat("Toggle", "Traps Enabled (T)", function(state)
    isTrapsEnabled = state
end)
SectorC1:Cheat("Toggle", "Knives Enabled (R)", function(state)
    isKnivesEnabled = state
end)

local SectorC2 = CategoryC:Sector("Visuals")
SectorC2:Cheat("Label", "Gun ESP")
SectorC2:Cheat("Toggle", "Coin ESP", function(state)
    coinEspEnabled = state

    if coinFolder then
        for _, coinEsp in ipairs(coinFolder:GetChildren()) do
            coinEsp.Visible = coinEspEnabled
        end
    end
end)
SectorC2:Cheat("Toggle", "Player ESP", function(state)
    espEnabled = state
    for _, boxEsp in ipairs(espFolder:GetDescendants()) do
        if boxEsp:IsA("BoxHandleAdornment") then
            boxEsp.Visible = espEnabled
        end
    end
end)
SectorC2:Cheat("Toggle", "Names", function(state)
    namesEnabled = state
    for _, nameEsp in ipairs(espFolder:GetDescendants()) do
        if nameEsp:IsA("BillboardGui") then
            nameEsp.Enabled = namesEnabled
        end
    end
end)

-- dead chat
for _, person in ipairs(Players:GetPlayers()) do
	person.Chatted:Connect(function(message)
		coroutine.wrap(onChatted)(person, message)
	end)
    local folder = playerEsp(person)
    if folder then
        folder.Parent = espFolder
    end
end
Players.PlayerAdded:Connect(function(person)
	person.Chatted:Connect(function(message)
		coroutine.wrap(onChatted)(person, message)
	end)
    local folder = playerEsp(person)
    folder.Parent = espFolder
end)
Players.PlayerRemoving:Connect(function(person)
    local folder = espFolder[person.Name.."EspFolder"]
    folder:Destroy()
end)

-- coin and gun esp
workspace.ChildAdded:Connect(function(child)
    if child.Name == "GunDrop" then
        local gunEsp = createEspBox(child, Color3.new(1, 1, 1))
        gunEsp.Parent = child
    -- else
    --     local ad = child.ChildAdded:Wait()
    --     if ad.Name == "Spawns" then
    --         for i = 1, 10 do
    --             print("ooga booga")
    --         end
    --         --local coinContainer = child.CoinContainer
    --         child.ChildAdded:Connect(function(thing)
    --             print(thing)
    --         end)
    --         -- repeat
    --         --     local cc = child.ChildAdded:Wait()
    --         --     print(cc.Name)
    --         --     cc:GetPropertyChangedSignal("Name"):Wait()
    --         -- until coinContainer.Name == "CoinContainer"

    --         coinFolder = Instance.new("Folder")
    --         coinFolder.Name = "CoinFolder"
    --         coinFolder.Parent = child
            

    --         -- coinContainer.ChildAdded:Connect(function(coin)
    --         --     local coinEsp = createEspBox(child, Color3.fromRGB(255, 255, 0))
    --         --     coinEsp.Visible = coinEspEnabled
    --         --     coinEsp.Parent = coinFolder
    --         -- end)
    --     end
    end
end)


-- keybinds
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if input.KeyCode == Enum.KeyCode.R then
        isThrowing = true
        while isThrowing and isKnivesEnabled do
            local knife = player.Character.Knife

            local A_1 = CFrame.new(mouse.Hit.Position)
            local A_2 = knife.Handle.Position
            knife.Throw:FireServer(A_1, A_2)

            RunService.Heartbeat:Wait()
        end
	elseif input.KeyCode == Enum.KeyCode.T then
        isTrapping = true
        while isTrapping == true and isTrapsEnabled == true do
            local A_1 = CFrame.new(mouse.Hit.Position)
            local Event = ReplicatedStorage.TrapSystem.PlaceTrap
            Event:InvokeServer(A_1)

            RunService.Heartbeat:Wait()
        end
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        Players.LocalPlayer.Character.Humanoid.WalkSpeed = runningSpeed
        Players.LocalPlayer.Character.Humanoid.JumpPower = runningPower
    end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.R then
		isThrowing = false
	elseif input.KeyCode == Enum.KeyCode.T then
		isTrapping = false
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.JumpPower = 50
    end
end)

-- selene: allow(undefined_variable)
local mt = getrawmetatable(game)
-- selene: allow(undefined_variable)
setreadonly(mt, false)
local namecall = mt.__namecall

mt.__namecall = function(self, ...)
    local args = {...}
    -- selene: allow(undefined_variable)
    local method = getnamecallmethod()
    if silentAimEnabled and tostring(self) == "ShootGun" and tostring(method) == "InvokeServer" then
        local target = ClosestPlayerToMouse()

        -- local diff = (target.Position - self.Parent.Parent.Handle.Position)
        -- local lookVector = diff.Unit
        -- local pos = self.Parent.Parent.Handle.Position + lookVector * diff.Magnitude * 3
        
        args[2] = target.Position
        return self.InvokeServer(self, unpack(args))
    end

    return namecall(self, ...)
end
