--[[
Current:
Reach
Slap Aura

To Do:
Most of the anti ability toggles
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BLACKLISTED_GUIS = {
	SquidInk = true,
	MailPopup = true,
}
local TELEPORTS = {
	["Arena"] = workspace.Origo.Position,
	["Slapple Island"] = Vector3.new(-427, 108, -21),
	["Grinding Area"] = Vector3.new(3030.67505, 145.273941, 2.81500006),
	["Brazil Portal"] = workspace.Lobby.brazil.portal.Position,
	["Win Area"] = Vector3.new(3431, -115, -23),
}
local BARRIERS = {
	workspace.DEATHBARRIER,
	workspace.DEATHBARRIER2,
	workspace.ArenaBarrier,
	workspace.AntiDefaultArena,
}

local isAntiGhostEnabled = false
local isAntiPusherEnabled = false
local isAntiReaperEnabled = false
local isAntiTimestopEnabled = false
local isPlayerEspEnabled = true
local deathSoundsDisabled = true
local visualsHidden = true
local isFarmingComp = false

--// Functions
local function enterArena()
	repeat
		task.wait()
	until Players.LocalPlayer.Character ~= nil
		and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		and Players.LocalPlayer.Character.Humanoid.Health > 0

	repeat
		wait(0.5)
		firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0)
		firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1)
	until Players.LocalPlayer.Character:FindFirstChild("entered") ~= nil
end

--// Script
-- selene: allow(incorrect_standard_library_use)
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadneo/roblox/main/General/Window.lua"))()
Window.DARK.Size = UDim2.fromOffset(400, 320)
local window = Window.new("Slap Battles: Main Game", Window.DARK, Enum.KeyCode.RightControl)

local espFolder = Instance.new("Folder")
espFolder.Name = "EspFolder"
espFolder.Parent = game:GetService("CoreGui")

--// Active Category
local activeCategory = window:CreateCategory("Active")
local gloveSection = activeCategory:CreateSection("Gloves")
local miscSection = activeCategory:CreateSection("Misc")

gloveSection:CreateToggle("Show Invisible Players", isAntiGhostEnabled).Toggled:Connect(function(state)
	isAntiGhostEnabled = state
end)
gloveSection:CreateToggle("Anti Pusher", isAntiPusherEnabled).Toggled:Connect(function(state)
	isAntiPusherEnabled = state
end)
gloveSection:CreateToggle("Anti Reaper", isAntiReaperEnabled).Toggled:Connect(function(state)
	isAntiReaperEnabled = state
	if state then
		ReplicatedStorage.ReaperGone:FireServer(Players.LocalPlayer.Character:FindFirstChild("DeathMark"))
	end
end)
gloveSection:CreateToggle("Anti Timestop", isAntiTimestopEnabled).Toggled:Connect(function(state)
	isAntiTimestopEnabled = state
end)

miscSection:CreateToggle("Player ESP", isPlayerEspEnabled).Toggled:Connect(function(state)
	isPlayerEspEnabled = state
	for _, gui in ipairs(espFolder:GetChildren()) do
		gui.Enabled = state
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character:FindFirstChild("Head") and player.Character.Head:FindFirstChild("Nametag") then
			player.Character.Head.Nametag.Enabled = not state
		end
	end
end)
miscSection:CreateToggle("Disable Killbricks").Toggled:Connect(function(state)
	for _, barrier in ipairs(BARRIERS) do
		barrier.CanTouch = not state
	end

	if state then
		workspace.DEATHBARRIER.CanCollide = true
		workspace.DEATHBARRIER.Transparency = 0.5
		workspace.DEATHBARRIER.CastShadow = false
		workspace.DEATHBARRIER2.CanCollide = true
		workspace.DEATHBARRIER2.Transparency = 0.5
		workspace.DEATHBARRIER2.CastShadow = false
	else
		workspace.DEATHBARRIER.CanCollide = false
		workspace.DEATHBARRIER.Transparency = 1
		workspace.DEATHBARRIER.CastShadow = true
		workspace.DEATHBARRIER2.CanCollide = false
		workspace.DEATHBARRIER2.Transparency = 1
		workspace.DEATHBARRIER2.CastShadow = true
	end
end)
miscSection:CreateToggle("Death Sounds Disabled", deathSoundsDisabled).Toggled:Connect(function(state)
	deathSoundsDisabled = state
end)
miscSection:CreateToggle("Hide Visuals", visualsHidden).Toggled:Connect(function(state)
	visualsHidden = state
end)

--// Teleports Category
local teleportCategory = window:CreateCategory("Teleports")
local teleportSection = teleportCategory:CreateSection("Teleports")

for teleportName, teleport in pairs(TELEPORTS) do
	teleportSection:CreateButton(teleportName).Activated:Connect(function()
		Players.LocalPlayer.Character:MoveTo(teleport)
	end)
end
teleportSection:CreateButton("Plate").Activated:Connect(function()
	Players.LocalPlayer.Character:MoveTo(game:GetService("Workspace").Arena.Plate.Position + Vector3.new(0, 2, 0))
end)

--// Farming Category
local farmingCategory = window:CreateCategory("Autofarm")
local autofarmsSection = farmingCategory:CreateSection("Autofarms")

local isEnteringArena = false
local isFarmingSlapples = false
local isFarmingBrick = false
local isFarmingBob = false

for _, slapple in ipairs(workspace.Arena.island5.Slapples:GetChildren()) do
	slapple.Glove:GetPropertyChangedSignal("Transparency"):Connect(function()
		if isFarmingSlapples and slapple.Glove.Transparency == 0 then
			firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, slapple.Glove, 0)
			firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, slapple.Glove, 1)
		end
	end)
end

autofarmsSection:CreateToggle("Loop Enter Arena").Toggled:Connect(function(state)
	isEnteringArena = state
	while isEnteringArena do
		enterArena()
	end
end)
autofarmsSection:CreateToggle("Slapple Farm").Toggled:Connect(function(state)
	isFarmingSlapples = state
	if isFarmingSlapples then
		for _, slapple in ipairs(workspace.Arena.island5.Slapples:GetChildren()) do
			if slapple:FindFirstChild("Glove") and slapple.Glove:FindFirstChildOfClass("TouchTransmitter") then
				firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, slapple.Glove, 0)
				firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, slapple.Glove, 1)
			end
		end
	end
end)
autofarmsSection:CreateToggle("Brick Farm").Toggled:Connect(function(state)
	isFarmingBrick = state
	while isFarmingBrick do
		ReplicatedStorage.lbrick:FireServer()
		local brickCount = Players.LocalPlayer.PlayerGui.BRICKCOUNT
		local bricks = tonumber(brickCount.ImageLabel.TextLabel.Text)
		brickCount.ImageLabel.TextLabel.Text = bricks + 1
		task.wait(5)
	end
end)
autofarmsSection:CreateToggle("Bob Farm").Toggled:Connect(function(state)
	isFarmingBob = state
	while isFarmingBob do
		enterArena()
		ReplicatedStorage.Duplicate:FireServer()
		Players.LocalPlayer.Character.Humanoid.Health = 0
		task.wait(3)
	end
end)
autofarmsSection:CreateToggle("Competition Autofarm", isFarmingComp).Toggled:Connect(function(state)
	isFarmingComp = state
end)

window:Mount()

--// Hide Visuals
Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	print(child.Name)
	if BLACKLISTED_GUIS[child.Name] then
		task.wait()
		child:Destroy()
	end
end)
workspace.ChildAdded:Connect(function(child)
	task.wait()
	if visualsHidden and child.Name == "creepyambiance" then
		game:GetService("Lighting").ExposureCompensation = 0
		child.Volume = 0
	elseif visualsHidden and child.Name == "guest666" then
		child:Destroy()
	elseif isAntiPusherEnabled and child.Name == "wall" then
		child.Transparency = 0.5
		child.CanCollide = false
	end
end)
game:GetService("Lighting").ChildAdded:Connect(function(child)
	task.wait()
	if visualsHidden then
		child:Destroy()
	end
end)

local metatable = getrawmetatable(game)
local oldIndex = metatable.__index
setreadonly(metatable, false)

metatable.__index = function(instance, property)
	if checkcaller() then
		return oldIndex(instance, property)
	end

	if instance == game:GetService("Lighting") and property == "Sky" then
		return nil
	end
	return oldIndex(instance, property)
end

--// Anti Reaper and Disable Death Sounds
Players.LocalPlayer.CharacterAdded:Connect(function(character)
	character.ChildAdded:Connect(function(child)
		if isAntiReaperEnabled and child.Name == "DeathMark" then
			ReplicatedStorage.ReaperGone:FireServer(Players.LocalPlayer.Character.DeathMark)
		end
	end)

	local torso = character:WaitForChild("Torso")
	torso.ChildAdded:Connect(function(child)
		if deathSoundsDisabled and child:IsA("Sound") then
			child.Volume = 0
		end
	end)
end)

--// Anti Timestop and Anti Ghost
coroutine.wrap(function()
	while true do
		if isAntiTimestopEnabled and Players.LocalPlayer.Character:FindFirstChild("TSVulnerability") then
			for _, part in ipairs(Players.LocalPlayer.Character:GetChildren()) do
				if part:IsA("BasePart") then
					part.Anchored = false
				end
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if
				isAntiGhostEnabled
				and player.Character
				and player.Character:FindFirstChild("Head")
				and player.Character.Head.Transparency == 1
			then
				for _, instance in pairs((player.Character:GetDescendants())) do
					if (instance:IsA("BasePart") and instance.Name ~= "HumanoidRootPart") or instance:IsA("Decal") then
						instance.Transparency = 0.5
					end
				end
			end
		end

		task.wait(0.1)
	end
end)()

--// Player ESP
local function createBillboardGui()
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "BillboardGui"
	billboardGui.Active = true
	billboardGui.AlwaysOnTop = true
	billboardGui.LightInfluence = 1
	billboardGui.Size = UDim2.fromOffset(200, 32)
	billboardGui.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
	billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "NameLabel"
	nameLabel.Text = "Joe"
	nameLabel.TextColor3 = Color3.fromRGB(237, 246, 249)
	nameLabel.TextScaled = true
	nameLabel.TextSize = 12
	nameLabel.TextWrapped = true
	nameLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	nameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Size = UDim2.fromScale(1, 0.5)
	nameLabel.Font = Enum.Font.SourceSansBold
	nameLabel.Parent = billboardGui

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "TextLabel"
	textLabel.Text = "{ Placeholder }"
	textLabel.TextColor3 = Color3.fromRGB(226, 149, 120)
	textLabel.TextScaled = true
	textLabel.TextSize = 12
	textLabel.TextWrapped = true
	textLabel.TextYAlignment = Enum.TextYAlignment.Top
	textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.BackgroundTransparency = 1
	textLabel.Position = UDim2.fromScale(0, 0.5)
	textLabel.Size = UDim2.fromScale(1, 0.5)
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.Parent = billboardGui

	return billboardGui
end
local initPlayerEsp = function(player)
	local GLOVES = {
		["OVERKILL"] = Color3.fromRGB(146, 20, 12),
		["Error"] = Color3.fromRGB(146, 20, 12),
		["Killstreak"] = Color3.fromRGB(146, 20, 12),
		["Reaper"] = Color3.fromRGB(146, 20, 12),
		["God's Hand"] = Color3.fromRGB(146, 20, 12),
		["The Flex"] = Color3.fromRGB(146, 20, 12),

		["Swapper"] = Color3.fromRGB(125, 223, 100),
		["Za Hando"] = Color3.fromRGB(125, 223, 100),
		["Reverse"] = Color3.fromRGB(125, 223, 100),
		["Leash"] = Color3.fromRGB(125, 223, 100),
		["Disarm"] = Color3.fromRGB(125, 223, 100),
		["bob"] = Color3.fromRGB(125, 223, 100),
		["bus"] = Color3.fromRGB(125, 223, 100),
		["Link"] = Color3.fromRGB(125, 223, 100),
	}

	local billboardGui = createBillboardGui()
	billboardGui.Name = player.Name
	billboardGui.NameLabel.Text = player.DisplayName
	billboardGui.Enabled = isPlayerEspEnabled
	billboardGui.Parent = espFolder

	local currentCharacter = player.Character
	if not currentCharacter then
		currentCharacter = player.CharacterAdded:Wait()
		currentCharacter:WaitForChild("Head")
		currentCharacter:WaitForChild("Humanoid")
	end
	task.wait()

	local health = currentCharacter:FindFirstChildWhichIsA("Humanoid").Health
	local glove = player.leaderstats.Glove.Value
	billboardGui.Adornee = currentCharacter.Head

	local function updateLabel()
		local text = string.format("{ Health: %.2f, Glove: %s }", health, glove)
		billboardGui.TextLabel.Text = text
		if GLOVES[glove] then
			billboardGui.TextLabel.TextColor3 = GLOVES[glove]
		else
			billboardGui.TextLabel.TextColor3 = Color3.fromRGB(226, 149, 120)
		end
	end

	updateLabel()

	player.CharacterAdded:Connect(function(character)
		local head = character:WaitForChild("Head")
		billboardGui.Adornee = head
		head:WaitForChild("Nametag").Enabled = false

		local humanoid = character:WaitForChild("Humanoid")
		health = humanoid.Health
		updateLabel()

		humanoid.HealthChanged:Connect(function(newHealth)
			health = newHealth
			updateLabel()
		end)
	end)
	player:WaitForChild("leaderstats").Glove.Changed:Connect(function(newGlove)
		glove = newGlove
		updateLabel()
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	coroutine.wrap(initPlayerEsp)(player)
end
Players.PlayerAdded:Connect(initPlayerEsp)
Players.PlayerRemoving:Connect(function(player)
	espFolder[player.Name]:Destroy()
end)

--// Comp Autofarm
game.ReplicatedStorage.PromptEvent.OnClientEvent:Connect(function()
	if isFarmingComp then
		game.ReplicatedStorage.EventAnswered:FireServer(true)
		task.wait(22)
		Players.LocalPlayer.Character:MoveTo(TELEPORTS["Win Area"])
	end
end)
