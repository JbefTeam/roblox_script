local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Doors Script By JBEFTeam", "Midnight")


local Main = Window:NewTab("Main")
local PlayerSection = Tab:NewSection("Player")


PlayerSection:NewSlider("Walk Speed", "Change your walk speed.", 500, 16, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)


PlayerSection:NewToggle("Jump Enabled", "Enable disable jump.", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 0
    end
end)


PlayerSection:NewButton("NoClip", "Walk trough walls.Press E To Open", function()
    noclip = false
    game:GetService('RunService').Stepped:connect(function()
    if noclip then
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    plr = game.Players.LocalPlayer
    mouse = plr:GetMouse()
    mouse.KeyDown:connect(function(key)
    
    if key == "e" then
    noclip = not noclip
    game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
    end
    end)
    print('Loaded')
    print('Press "E" to noclip')
end)

local OthersSection = Tab:NewSection("Others")


OthersSection:NewButton("Die", "Do you want to die because of stuck?Click Me!", function()
    player.Character.Humanoid.Health = 0
end)


OthersSection:NewButton("Full Health", "Do you have low health?Click Me!", function()
    player.Character.Humanoid.Health = 100
end)


OthersSection:NewButton("Half Health", "Do you have low health?Click Me!", function()
    player.Character.Humanoid.Health = 50
end)


OthersSection:NewButton("Revive", "Oh.You dont have robux for revive.Here you go!", function()
    game.ReplicatedStorage.Bricks.Revive:FireServer()
end)


local Others = Window:NewTab("Others")
local OthersSection2 = Tab:NewSection("Others")


OthersSection2:NewButton("Admin", "Open İnfinite Yield.", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)


OthersSection2:NewTextBox("Change My Name", "Change your name on game.(Temporarily)", function(txt)
	wait(2)
Player = game.Players.LocalPlayer
Char = Player.Character
Head = Char.Humanoid
Head.Name = "Copy"
local Copy = Head:Clone()
Head:Destroy()
Copy.Name = (txt)
end)

OthersSection2:NewLabel("Your current name is")
label:UpdateLabel("Your current name is" + (txt))