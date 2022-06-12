local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local hitboxSize = 2

-- selene: allow(incorrect_standard_library_use)
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/sadneo/roblox-cheats/master/Finity.lua"))()
local window = Finity.new(true, "MM2", UDim2.new(0, 600, 0, 350))
window.ChangeToggleKey(Enum.KeyCode.RightControl)

local gamingCategory = window:Category("Gaming")
local gamingSector = gamingCategory:Sector("Gaming")
gamingSector:Cheat("Slider", "Hitbox Size", function(value)
    hitboxSize = value
end, {default = hitboxSize, min = 0, max = 100, suffix = " studs"})

RunService.Heartbeat:Connect(function()
    if player.Character == nil and player.Character.Humanoid.Health <= 0 then return end
    print("poop")
    do
        local glove
        for _, instance in ipairs(player.Character:GetChildren()) do
            if instance:IsA("Tool") and instance.Name ~= "Radio" then
                glove = instance
                break
            end
        end
        
        if glove ~= nil then
            print("e")
            local texture = glove.Glove:FindFirstChildOfClass("Texture")
            if texture then
                texture:Destroy()
            end
            glove.Glove.Transparency = 1
            glove.Glove.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
        end
    end

    --[[do
        if player.Character.Humanoid.PlatformStand then
            player.Character.Humanoid.PlatformStand = false
        end

        if player.Character:FindFirstChild("Ragdolled") ~= nil then
            
        end
    end]]
end)

--[[
if _G.PreventRagdoll then
    if LocalPlayer.Character ~= nil and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") ~= nil and LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and LocalPlayer.Character:WaitForChild("Torso").Transparency == 0 then
        if LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand == true then LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false; end
        if LocalPlayer.Character:WaitForChild("Ragdolled") ~= nil then
            if LocalPlayer.Character:WaitForChild("Ragdolled").Value == false then hum_cframe = LocalPlayer.Character:FindFirstChild("Torso").CFrame; end
            if ragdoll_debounce == true then if ragdoll_debounce_1 < 6 then LocalPlayer.Character:FindFirstChild("Torso").CFrame = hum_cframe; ragdoll_debounce = false; elseif ragdoll_debounce_1 == 6 then ragdoll_debounce_1 = 0; ragdoll_debounce = false; end end
            if LocalPlayer.Character:WaitForChild("Ragdolled").Value == true then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
                LocalPlayer.Character:FindFirstChild("Head").Anchored = true;
                LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true;
                LocalPlayer.Character:FindFirstChild("Torso").Anchored = true;
                --LocalPlayer.Character:FindFirstChild("Torso").CFrame = hum_cframe;
                ragdoll_debounce = true;
                for _,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                    if v.Name == "Head" or v.Name == "Torso" or v.Name == "Left Arm" or v.Name == "Right Arm" or v.Name == "Left Leg" or v.Name == "Right Leg" or v.Name == "HumanoidRootPart" or v.Name == "Torso" then
                        for _,r in pairs(v:GetChildren()) do
                            if r:IsA("BallSocketConstrait") or r:IsA("BodyVelocity") or r:IsA("BodyAngularVelocity") then
                                r:Destroy();
                            elseif r:IsA("Attachment") then
                                if r.Name == "a0" or r.Name == "a1" or r.Name == "torsoweld" then
                                    r:Destroy();
                                end
                            end
                        end
                    elseif string.sub(v.Name, 0, 8) == "FakePart" then
                        v.Anchored = true;
                        v.CanCollide = false;
                    elseif v.Name == "Icecube" then
                        LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
                        v:Destroy();
                    end
                end
            elseif LocalPlayer.Character:WaitForChild("Ragdolled").Value == false then
                LocalPlayer.Character:FindFirstChild("Head").Anchored = false;
                LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false;
                LocalPlayer.Character:FindFirstChild("Torso").Anchored = false;
            end
        end
    end
end


if _G.AntiTimestop then
    if LocalPlayer.Character ~= nil and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") ~= nil and LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 and LocalPlayer.Character:WaitForChild("Torso").Transparency == 0 then
        if game:GetService("Workspace"):FindFirstChild("universaltimestop") ~= nil then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
            LocalPlayer.Character:FindFirstChild("TSVulnerability").Value = false;
            for _,v in pairs(LocalPlayer.Character:GetChildren()) do
                if v:IsA("MeshPart") or v:IsA("Part") then
                    v.Anchored = false;
                end
            end
        elseif not game:GetService("Workspace"):FindFirstChild("universaltimestop") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false;
            LocalPlayer.Character:FindFirstChild("TSVulnerability").Value = true;
        end
    end
end



spawn(function()
    if _G.RemoveColorCorrection then
        if game:GetService("Lighting"):FindFirstChildOfClass("ColorCorrectionEffect") then
            game:GetService("Lighting"):FindFirstChildOfClass("ColorCorrectionEffect"):Destroy();
        end
           
        for _,v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
            if v.Name == "VineThudImageScreenGUI" or v.Name == "MailPopup" or v.Name == "MittenBlind" then 
                v:Destroy();
            end
        end

        for _,p in pairs(game:GetService("Workspace"):GetChildren()) do
            if p.Name == "wall" or p.Name == "BusModel" then
                p.CanCollide = false;
                p.CanTouch = false;
                p.Transparency = 0.8;
            end
        end
                
        for _,v in pairs(game:GetService("Players"):GetChildren()) do
            if v.Character:FindFirstChild("rock") then
                v.Character:FindFirstChild("rock").CanTouch = false;
                v.Character:FindFirstChild("rock").CanCollide = false;
            end
        end
    end
end)]]