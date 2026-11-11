
-- CHINU HUB V1
-- Made by Chinu Studios
-- Game: Steal an Egg

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ChinuHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local blue = Color3.fromRGB(25, 125, 255)
local dark = Color3.fromRGB(12, 20, 38)

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(330, 420)
main.Position = UDim2.new(0.5, -165, 0.5, -210)
main.BackgroundColor3 = dark
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 14)

local stroke = Instance.new("UIStroke")
stroke.Color = blue
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundColor3 = blue
title.Text = "CHINU HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 25
title.Font = Enum.Font.GothamBold
title.Parent = main

Instance.new("UICorner", title).CornerRadius =
    UDim.new(0, 12)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 30)
status.Position = UDim2.fromOffset(10, 60)
status.BackgroundTransparency = 1
status.Text = "Welcome to Steal an Egg!"
status.TextColor3 = Color3.fromRGB(160, 200, 255)
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.Parent = main

local function createButton(name, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.88, 0, 0, 38)
    button.Position = UDim2.new(0.06, 0, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(25, 55, 95)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = main

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 8)

    button.Activated:Connect(callback)
end

-- EGG SECTION
createButton("🥚 Egg ESP", 100, function()
    status.Text = "Egg ESP selected"
end)

createButton("⭐ Rarest Egg Finder", 145, function()
    status.Text = "Rarest Egg Finder selected"
end)

createButton("🏆 Best Egg Finder", 190, function()
    status.Text = "Best Egg Finder selected"
end)

-- TELEPORT SECTION
createButton("🏠 Teleport to Base", 235, function()
    status.Text = "Base teleport needs a Base point"
end)

createButton("🏃 Teleport to Treadmill", 280, function()
    status.Text = "Treadmill point needs setup"
end)

-- SETTINGS
createButton("⚡ Movement Speed", 325, function()
    local character = player.Character
    local humanoid = character and
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = 24
        status.Text = "Movement speed set!"
    end
end)

createButton("❌ Close Hub", 370, function()
    gui:Destroy()
end)

print("CHINU HUB V1 loaded!")

