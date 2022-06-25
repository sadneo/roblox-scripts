local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local SPAWN_POSITION = CFrame.new(-108, 138, 9)
local VOTING_ROOM_POSITION = CFrame.new(-108, 141, 83)

local playerEspEnabled = true
local gunEspEnabled = true
local coinEspEnabled = true
local runSpeed = 24
local runKeybind = Enum.KeyCode.LeftControl
local trapKeybind = Enum.KeyCode.R
local invisKeybind = Enum.KeyCode.T
local grabGunKeybind = Enum.KeyCode.G

local invisToggle
local runningToggle
local grabGunButton
local trapToggle

-- selene: allow(incorrect_standard_library_use)
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadneo/roblox/main/General/Window.lua"))()
Window.DARK.Size = UDim2.fromOffset(400, 320)
local window = Window.new("MM2", Window.DARK, Enum.KeyCode.RightControl)

local espFolder = Instance.new("Folder")
espFolder.Name = "Highlights"
espFolder.Parent = game:GetService("CoreGui")

do
	local activeCategory = window:CreateCategory("Active")
	local gameplaySection = activeCategory:CreateSection("Gameplay")
	local teleportSection = activeCategory:CreateSection("Teleports")

	invisToggle = gameplaySection:CreateToggle("Invisibility")
	invisToggle.Toggled:Connect(function(state)
		ReplicatedStorage.Remotes.Gameplay.Stealth:FireServer(state)
	end)
	gameplaySection:CreateToggle("Trail").Toggled:Connect(function(state)
		Players.LocalPlayer.Character.SpeedTrail.Toggle:FireServer(state)
	end)
	runningToggle = gameplaySection:CreateToggle("Run")
	runningToggle.Toggled:Connect(function(state)
		local speed = runSpeed
		if not state then
			speed = 16
		end
		Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
	end)
	gameplaySection:CreateButton("God Mode").Activated:Connect(function()
		local GOD_MODE_WAIT = 0.1
		local GOD_MODE_NAME = "1"

		Players.LocalPlayer.Character.Humanoid.Name = GOD_MODE_NAME
		local newHumanoid = Players.LocalPlayer.Character[GOD_MODE_NAME]:Clone()
		newHumanoid.Parent = Players.LocalPlayer.Character
		wait(GOD_MODE_WAIT)
		Players.LocalPlayer.Character[GOD_MODE_NAME]:Destroy()

		-- selene: allow(incorrect_standard_library_use)
		workspace.CurrentCamera.CameraSubject = newHumanoid
		Players.LocalPlayer.Character.Animate.Disabled = true
		wait(GOD_MODE_WAIT)
		Players.LocalPlayer.Character.Animate.Disabled = false
		newHumanoid.BreakJointsOnDeath = false
	end)
	grabGunButton = gameplaySection:CreateButton("Grab Gun")
	grabGunButton.Activated:Connect(function()
		local GUN_PICKUP_WAIT = 0.25
		local gun = workspace:FindFirstChild("GunDrop")

		local root = Players.LocalPlayer.Character.HumanoidRootPart
		local oldCFrame = root.CFrame

		if gun ~= nil then
			root.CFrame = gun.CFrame
			wait(GUN_PICKUP_WAIT)
			root.CFrame = oldCFrame
		end
	end)
	gameplaySection:CreateButton("Fake Gun").Activated:Connect(function()
		ReplicatedStorage.Remotes.Gameplay.FakeGun:FireServer(true)
	end)

	teleportSection:CreateButton("Map").Activated:Connect(function()
		for _, map in ipairs(workspace:GetChildren()) do
			local spawns = map:FindFirstChild("Spawns")
			if spawns then
				Players.LocalPlayer.Character:PivotTo(CFrame.new(spawns.Spawn.Position))
			end
		end
	end)
	teleportSection:CreateButton("Spawn").Activated:Connect(function()
		Players.LocalPlayer.Character:PivotTo(SPAWN_POSITION)
	end)
	teleportSection:CreateButton("Voting Room").Activated:Connect(function()
		Players.LocalPlayer.Character:PivotTo(VOTING_ROOM_POSITION)
	end)
end
do
	local otherCategory = window:CreateCategory("Other")
	local trapSection = otherCategory:CreateSection("Traps")
	local otherSection = otherCategory:CreateSection("Other")

	local target = Players.LocalPlayer
	local trappingTarget = false
	local trappingAll = false
	local trappingCursor = false

	local targetTextbox = trapSection:CreateTextbox("Target", "Player Name")
	targetTextbox.FocusLost:Connect(function()
		local targetName = targetTextbox:GetValue()
		for _, player in ipairs(Players:GetPlayers()) do
			if string.lower(string.sub(player.Name, 1, #targetName)) == string.lower(targetName) then
				target = player
			end
		end
	end)
	trapSection:CreateToggle("Trap Target").Toggled:Connect(function(state)
		trappingTarget = state
		while trappingTarget do
			local root = target.Character.HumanoidRootPart
			ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(CFrame.new(root.Position))
			task.wait()
		end
	end)
	trapSection:CreateToggle("Trap All").Toggled:Connect(function(state)
		trappingAll = state
		while trappingAll do
			for _, person in ipairs(Players:GetPlayers()) do
				local hrp = person.Character.HumanoidRootPart
				ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(hrp.CFrame)
			end
			task.wait()
		end
	end)
	trapToggle = trapSection:CreateToggle("Trap Cursor")
	trapToggle.Toggled:Connect(function(state)
		trappingCursor = state
		while trappingCursor do
			local cframe = CFrame.new(Players.LocalPlayer:GetMouse().Hit.Position)
			ReplicatedStorage.TrapSystem.PlaceTrap:InvokeServer(cframe)
			task.wait()
		end
	end)

	otherSection:CreateToggle("Void Protection", true).Toggled:Connect(function(state)
		-- selene: allow(incorrect_standard_library_use)
		workspace.FallenPartsDestroyHeight = state and -50000 or -500
	end)
	-- selene: allow(incorrect_standard_library_use)
	workspace.FallenPartsDestroyHeight = -50000
end
do
	local settingsCategory = window:CreateCategory("Settings")
	local visualsSection = settingsCategory:CreateSection("Visuals")
	local settingsSection = settingsCategory:CreateSection("Settings")
	local keybindsSection = settingsCategory:CreateSection("Keybinds")

	visualsSection:CreateToggle("Player ESP", playerEspEnabled).Toggled:Connect(function(state)
		playerEspEnabled = state
		for _, esp in ipairs(espFolder:GetChildren()) do
			if esp.Name ~= "GunHighlight" then
				esp.Enabled = state
			end
		end
	end)
	visualsSection:CreateToggle("Gun Esp", gunEspEnabled).Toggled:Connect(function(state)
		gunEspEnabled = state
		local highlight = espFolder:FindFirstChild("GunHighlight")
		if highlight then
			highlight.Enabled = state
		end
	end)
	visualsSection:CreateToggle("Coin ESP", coinEspEnabled).Toggled:Connect(function(state)
		coinEspEnabled = state
		local highlight = espFolder:FindFirstChild("CoinHighlight")
		if highlight then
			highlight.Enabled = state
		end
	end)

	local silentAimToggle = settingsSection:CreateToggle("Silent Aim", true)
	local runSpeedTextbox = settingsSection:CreateTextbox("Running Speed", "WalkSpeed")
	runSpeedTextbox.FocusLost:Connect(function()
		runSpeed = runSpeedTextbox:GetValue()
	end)

	-- keybindsSection:CreateKeybind("Run", runKeybind)
	-- keybindsSection:CreateKeybind("Trap", trapKeybind)
	-- keybindsSection:CreateKeybind("Invisibility", trapKeybind)
	-- keybindsSection:CreateKeybind("Grab Gun", trapKeybind)

	-- selene: allow(undefined_variable)
	local mt = getrawmetatable(game)
	-- selene: allow(undefined_variable)
	setreadonly(mt, false)
	local namecall = mt.__namecall

	mt.__namecall = function(self, ...)
		local args = { ... }
		-- selene: allow(undefined_variable)
		local method = getnamecallmethod()
		if silentAimToggle:GetValue() and tostring(self) == "ShootGun" and tostring(method) == "InvokeServer" then
			local target = nil
			local dist = math.huge
			for _, person in ipairs(Players:GetPlayers()) do
				if
					person.Name ~= Players.LocalPlayer.Name
					and person.Character
					and person.Character:FindFirstChild("HumanoidRootPart")
				then
					local screenpoint = workspace.Camera:WorldToScreenPoint(person.Character.HumanoidRootPart.Position)
					local check = (
						Vector2.new(Players.LocalPlayer:GetMouse().X, Players.LocalPlayer:GetMouse().Y)
						- Vector2.new(screenpoint.X, screenpoint.Y)
					).Magnitude

					if check < dist then
						target = person.Character.HumanoidRootPart
						dist = check
					end
				end
			end

			args[2] = target.Position
			return self.InvokeServer(self, unpack(args))
		end

		return namecall(self, ...)
	end

	window:Mount()
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then
		return
	end

	if input.KeyCode == runKeybind then
		runningToggle:SetValue(true)
	elseif input.KeyCode == trapKeybind then
		trapToggle:SetValue(true)
	elseif input.KeyCode == invisKeybind then
		invisToggle:SetValue(not invisToggle:GetValue())
	elseif input.KeyCode == grabGunKeybind then
		local GUN_PICKUP_WAIT = 0.25
		local gun = workspace:FindFirstChild("GunDrop")

		local root = Players.LocalPlayer.Character.HumanoidRootPart
		local oldCFrame = root.CFrame

		if gun ~= nil then
			root.CFrame = gun.CFrame
			wait(GUN_PICKUP_WAIT)
			root.CFrame = oldCFrame
		end
	end
end)

UserInputService.InputEnded:Connect(function(input, _gameProcessedEvent)
	if input.KeyCode == runKeybind then
		runningToggle:SetValue(false)
	elseif input.KeyCode == trapKeybind then
		trapToggle:SetValue(false)
	end
end)

do
	local function createHighlight(name, adornee)
		local highlight = Instance.new("Highlight")
		highlight.Name = name
		highlight.Adornee = adornee
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.FillColor = Color3.fromRGB(0, 255, 0)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 1
		highlight.Parent = espFolder
		return highlight
	end

	workspace.ChildAdded:Connect(function(child)
		task.wait()
		if child.Name == "GunDrop" then
			local highlight = createHighlight("GunHighlight", child)
			highlight.Enabled = gunEspEnabled
			highlight.FillColor = Color3.fromRGB(255, 255, 255)
			child.AncestryChanged:Wait()
			highlight:Destroy()
		end
	end)

	local function esp(player)
		if player == Players.LocalPlayer then
			return
		end

		local highlight = createHighlight(player.Name, player.Character)
		highlight.Enabled = playerEspEnabled

		player:WaitForChild("Backpack").ChildAdded:Connect(function(tool)
			if tool.Name == "Tool" then
				tool:GetPropertyChangedSignal("Name"):Wait()
			end
			if tool.Name == "Gun" then
				highlight.FillColor = Color3.fromRGB(0, 0, 255)
			elseif tool.Name == "Knife" then
				highlight.FillColor = Color3.fromRGB(255, 0, 0)
			end
		end)

		player.CharacterAdded:Connect(function(character)
			highlight.FillColor = Color3.fromRGB(0, 255, 0)
			highlight.Adornee = character

			player:WaitForChild("Backpack").ChildAdded:Connect(function(tool)
				if tool.Name == "Tool" then
					tool:GetPropertyChangedSignal("Name"):Wait()
				end
				if tool.Name == "Gun" then
					highlight.FillColor = Color3.fromRGB(0, 0, 255)
				elseif tool.Name == "Knife" then
					highlight.FillColor = Color3.fromRGB(255, 0, 0)
				end
			end)
		end)
	end

	local function cleanupEsp(player)
		espFolder:FindFirstChild(player.Name):Destroy()
	end

	for _, player in ipairs(Players:GetPlayers()) do
		coroutine.wrap(esp)(player)
	end
	Players.PlayerAdded:Connect(esp)
	Players.PlayerRemoving:Connect(cleanupEsp)
end
