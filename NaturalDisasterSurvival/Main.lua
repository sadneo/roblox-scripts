local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local SAFE_SPOT = CFrame.new(-280, 150, 341)
local RESPAWN_POINT = CFrame.new(-299, 194, 374)

local roundNotifications = true
local roundNotificationSound = ""
local disableSandstorm = true
local disableBlizzard = true
local won = 0
local played = 0

local disasterLabel
local wonLabel
local playedLabel

local characterAddedConnection
local statusChangedConnection
local guiAddedConnection

-- selene: allow(incorrect_standard_library_use)
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadneo/roblox/main/General/Window.lua"))()
local window = Window.new("NDS", Window.DARK, Enum.KeyCode.RightControl)

do
	local miscCategory = window:CreateCategory("Disaster")
	local disasterSection = miscCategory:CreateSection("Disaster")
	local miscSection = miscCategory:CreateSection("Miscellaneous")
	local autofarmSection = miscCategory:CreateSection("Autofarm")

	local autofarming = false
	local eating = false

	disasterLabel = disasterSection:CreateLabel("Current Disaster: ")
	disasterSection:CreateToggle("Round Notifications", roundNotifications).Toggled:Connect(function(state)
		roundNotifications = state
	end)
	local noiseTextBox = disasterSection:CreateTextbox("Notification Noise", "rbxassetid://", "6753645454")
	noiseTextBox.FocusLost:Connect(function()
		roundNotificationSound = "rbxassetid://" .. noiseTextBox:GetText()
	end)

	miscSection:CreateButton("Delete Fall Damage", "Delete").Activated:Connect(function()
		local script = Players.LocalPlayer.Character:FindFirstChild("FallDamageScript")
		if script ~= nil then
			script:Destroy()
		end
	end)
	miscSection:CreateButton("Delete Exposure Tag", "Delete").Activated:Connect(function()
		local tag = Players.LocalPlayer.Character:FindFirstChild("SurvivalTag")
		if tag ~= nil and tag:FindFirstChild("ExposureTag") ~= nil then
			tag.ExposureTag:Destroy()
		end
	end)
	miscSection:CreateToggle("Show Compass Menu").Toggled:Connect(function(state)
		Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = state
	end)

	autofarmSection:CreateToggle("Autofarm").Toggled:Connect(function(state)
		autofarming = state

		coroutine.wrap(function()
			local character = Players.LocalPlayer.Character
			character.HumanoidRootPart.Anchored = true
			while autofarming do
				character:PivotTo(SAFE_SPOT)
				task.wait()
			end
			character:PivotTo(RESPAWN_POINT)
			character.HumanoidRootPart.Anchored = false
		end)()
	end)
	local ownsApple = Players.LocalPlayer.Character:FindFirstChild("RedApple")
		or Players.LocalPlayer.Backpack:FindFirstChild("RedApple")
	if ownsApple then
		autofarmSection:CreateToggle("Eat Apple").Toggled:Connect(function(state)
			eating = state

			while eating do
				if Players.LocalPlayer.Character:FindFirstChild("RedApple") ~= nil then
					Players.LocalPlayer.Character.RedApple:Activate()
				end
				task.wait()
			end
		end)
	end
	wonLabel = autofarmSection:CreateLabel("Rounds won: 0")
	playedLabel = autofarmSection:CreateLabel("Rounds played: 0")
end

do
	local settingsCategory = window:CreateCategory("Settings")
	local effectsSection = settingsCategory:CreateSection("Effects")
	local soundsSection = settingsCategory:CreateSection("Sounds")
	local guiSection = settingsCategory:CreateSection("Interface")

	effectsSection:CreateToggle("Disable Sandstorm Effects", disableSandstorm).Toggled:Connect(function(state)
		disableSandstorm = state

		local playerGui = Players.LocalPlayer.PlayerGui
		if disableSandstorm and playerGui:FindFirstChild("SandStormGui") then
			playerGui.SandStormGui:Destroy()
		end
	end)
	effectsSection:CreateToggle("Disable Blizzard Effects", disableBlizzard).Toggled:Connect(function(state)
		disableBlizzard = state

		local playerGui = Players.LocalPlayer.PlayerGui
		if disableBlizzard and playerGui:FindFirstChild("BlizzardGui") then
			playerGui.BlizzardGui:Destroy()
		end
	end)

	local disableAll = soundsSection:CreateToggle("Disable All")
	for _, sound in ipairs(workspace.ContentModel.Sounds:GetChildren()) do
		local originalVolume = sound.Volume
		local soundToggle = soundsSection:CreateToggle('Disable "' .. sound.Name .. '"', disableAll:GetState())
		soundToggle.Toggled:Connect(function(state)
			sound.Volume = state and 0 or originalVolume
			if state then
				sound:Stop()
			end
		end)
		disableAll.Toggled:Connect(function(state)
			soundToggle:SetState(state)
		end)
	end

	guiSection:CreateLabel("Hide Menu: K")
	guiSection:CreateButton("Destroy Interface", "Destroy").Activated:Connect(function()
		window:Destroy()
		characterAddedConnection:Disconnect()
		statusChangedConnection:Disconnect()
		guiAddedConnection:Disconnect()
	end)
end

local function updateDisasterLabel()
	local character = Players.LocalPlayer.Character
	local disaster = character:FindFirstChild("SurvivalTag") and character.SurvivalTag.Value or "nil"
	disasterLabel:SetText("Current Disaster: " .. disaster)
end

local function characterAdded(character)
	character.ChildAdded:Connect(function(_child)
		task.wait()
		updateDisasterLabel()
	end)
end

updateDisasterLabel()
characterAdded(Players.LocalPlayer.Character)
characterAddedConnection = Players.LocalPlayer.CharacterAdded:Connect(characterAdded)

statusChangedConnection = workspace.ContentModel.Status.Changed:Connect(function(value)
	if value == "Survivers" then
		played += 1
		for _, surviver in ipairs(workspace.ContentModel.Survivers:GetChildren()) do
			if surviver.Name == Players.LocalPlayer.Name then
				won += 1
				break
			end
		end

		wonLabel:SetText("Rounds won: " .. won)
		playedLabel:SetText("Rounds played: " .. played)
	elseif roundNotifications and value == "New Map" then
		StarterGui:SetCore("SendNotification", {
			Title = "New Round",
			Text = "A new round has began",
		})

		if roundNotificationSound ~= "" then
			local sound = Instance.new("Sound")
			sound.SoundId = "rbxassetid://" .. roundNotificationSound
			sound.Volume = 10
			SoundService:PlayLocalSound(sound)
			sound.Ended:Wait()
			sound:Destroy()
		end
	end
end)

guiAddedConnection = Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	if (disableSandstorm and child.Name == "SandStormGui") or (disableBlizzard and child.Name == "BlizzardGui") then
		child:Destroy()
	end
end)

window:Mount()
