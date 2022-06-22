local Library = loadstring(game:HttpGet("https://pastebin.com/raw/vyx4EfAD"))()
local Window = Library.CreateLib("Asleep Hub", "GrapeTheme")
local Tab = Window:NewTab("Key System")
local Section = Tab:NewSection("This is a private hub")
Section:NewTextBox("Enter Key", "Enter the KEY", function(txt)
	if txt == "zA6,Wcf7M{m-8J#P" then
        game.CoreGui["AsleepHubLoader"]:Destroy()
        if game.PlaceId == 3102144307 then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/AwokenYT/Asleep-Hub/main/clickersimulator.lua"))()
        else
            game.Players.LocalPlayer:Remove("Unsupported Game")
        end
    else
        game.Players[game.Players.LocalPlayer.Name]:Kick("Incorrect Key, Please try again")
    end
end)
