getgenv().autoTap = false
getgenv().autoRebirth = false
getgenv().autoEgg = false
getgenv().autoBoss = false
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Asleep Hub | Anime Clicker Simulator", "GrapeTheme")
local Main = Window:NewTab("Main")
local mainSection = Main:NewSection("Autofarm")
local teleportsSection = Main:NewSection("Teleports")
local remotePath = game:GetService("ReplicatedStorage").Remotes
local rebirthAmount
local selectEgg
local selectWorld
local selectBoss

mainSection:NewToggle("Auto Click", "Automatically Click", function (state)
    getgenv().autoTap = state
    print('Autoclick is ', state)
    if state then
        doTap();
    end
end)

mainSection:NewSlider("Rebirths", "Select how many rebirths", 100, 0, function (v)
    SelectRebirth = v
end)

mainSection:NewToggle("Auto Rebirth", "Automatically Rebirth", function(state)
    getgenv().autoRebirth = state
    print("autorebirth is", state)
    if state then
        doRebirth(SelectRebirth)
    end
end)

eggList = {}
for i,v in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
    if v:IsA('Model') then
        if not table.find(eggList, v.Name) then
            table.insert(eggList, v.Name)
        end
    end
    end

mainSection:NewDropdown("Eggs", "Select An Egg", eggList, function (currentOption)
    selectEgg = currentOption
end)

mainSection:NewToggle("Auto Open Egg", "Automatically Open Eggs", function (state)
    getgenv().autoEgg = state
    print("Autoegg is", state)
    if state then
        openEgg(selectEgg)
    end
end)
bossList = {}
for i,v in pairs(game:GetService("Workspace").BossZones:GetChildren()) do
    if v:IsA('Model') then
        if not table.find(bossList, v.Name) then
            table.insert(bossList, v.Name)
        end
    end
    end
mainSection:NewDropdown("Bosses", "Select a Boss", bossList, function (currentOption)
    selectBoss = currentOption
    print(selectBoss)
end)

mainSection:NewToggle("Autofarm Boss", "Autofarm a boss", function (state)
    farmboss = state
    if game.Players.LocalPlayer then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").BossZones[selectBoss].Touch.CFrame
    end
    while farmboss do task.wait()
        wait(0.1)
        local args = {
            [1] = true,
            [3] = "Clicker!",
            [4] = selectBoss
        }
        game:GetService("ReplicatedStorage").Remotes.ClickRemote:FireServer(unpack(args))
    end
end)

worldList = {}
for i,v in pairs(game:GetService("Workspace").Worlds:GetChildren()) do
    if v:IsA('Folder') then
        if not table.find(worldList, v.Name) then
            table.insert(worldList, v.Name)
        end
    end
    end
teleportsSection:NewDropdown("Worlds", "Select a World", worldList, function (currentOption)
    selectWorld = currentOption
end)
teleportsSection:NewButton("Teleport To World", "Teleport to selected world", function ()
    teleportWorld(selectWorld)
end)

function doTap()
    spawn(function()
        while autoTap == true do
            local args = {[1] = false, [2] = false,[3] = "Clicker!"}
            remotePath.ClickRemote:FireServer(unpack(args))
            wait()
        end
    end)
end

function doRebirth(SelectRebirth)
    spawn(function()
        while autoRebirth == true do
            local args = {
                [1] = SelectRebirth
            }
            game:GetService("ReplicatedStorage").Remotes.RebirthRemote:FireServer(unpack(args))
            wait()
        end
    end) 
end

function openEgg(eggType)
    spawn(function()
        while wait() do
            if not autoEgg then break end;
            local args = { [1] = eggType, [2] = false, [3] = false}
            game:GetService("ReplicatedStorage").Remotes.OpenEgg:InvokeServer(unpack(args))
            wait()
        end
    end)
end

function teleportBoss(boss)
    if game.Players.LocalPlayer then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").BossZones[boss].Touch.CFrame
    end
end

function teleportWorld(world)
    if game.Players.LocalPlayer then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Worlds[world].Spawn.CFrame
    end
end
