
--==================================================
-- CHINU HUB V3
-- Made by Chinu Studios
-- Game: Steal an Egg
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old version
local old = playerGui:FindFirstChild("ChinuHub")
if old then old:Destroy() end

-- COLORS
local BLUE = Color3.fromRGB(25, 125, 255)
local DARK = Color3.fromRGB(10, 17, 32)
local PANEL = Color3.fromRGB(19, 32, 54)
local WHITE = Color3.fromRGB(255,255,255)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ChinuHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(360, 430)
main.Position = UDim2.new(0.5,-180,0.5,-215)
main.BackgroundColor3 = DARK
main.Parent = gui

Instance.new("UICorner",main).CornerRadius = UDim.new(0,15)

local stroke = Instance.new("UIStroke")
stroke.Color = BLUE
stroke.Thickness = 2
stroke.Parent = main

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,55)
title.BackgroundColor3 = BLUE
title.Text = "CHINU HUB V3"
title.TextColor3 = WHITE
title.TextSize = 23
title.Font = Enum.Font.GothamBold
title.Parent = main

Instance.new("UICorner",title).CornerRadius = UDim.new(0,12)

-- DRAGGING
local dragging = false
local dragStart, startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,-20,0,30)
status.Position = UDim2.fromOffset(10,60)
status.BackgroundTransparency = 1
status.Text = "Welcome, "..player.Name.."!"
status.TextColor3 = Color3.fromRGB(150,200,255)
status.TextSize = 13
status.Font = Enum.Font.Gotham
status.Parent = main

-- CONTENT
local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(10,140)
content.Size = UDim2.new(1,-20,1,-150)
content.BackgroundTransparency = 1
content.Parent = main

local function clearContent()
    for _,v in ipairs(content:GetChildren()) do
        v:Destroy()
    end
end

local function makeButton(text,y,callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,0,0,40)
    button.Position = UDim2.fromOffset(0,y)
    button.BackgroundColor3 = PANEL
    button.TextColor3 = WHITE
    button.Text = text
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = content

    Instance.new("UICorner",button).CornerRadius = UDim.new(0,9)

    button.Activated:Connect(function()
        TweenService:Create(button,TweenInfo.new(0.12),{
            BackgroundColor3 = BLUE
        }):Play()

        callback()

        task.delay(0.2,function()
            if button.Parent then
                TweenService:Create(button,TweenInfo.new(0.2),{
                    BackgroundColor3 = PANEL
                }):Play()
            end
        end)
    end)
end

-- TABS
local tabs = Instance.new("Frame")
tabs.Position = UDim2.fromOffset(10,100)
tabs.Size = UDim2.new(1,-20,0,32)
tabs.BackgroundTransparency = 1
tabs.Parent = main

local tabNames = {"EGG","TELEPORT","SETTINGS","PREMIUM"}

local function showTab(tab)
    clearContent()

    if tab == "EGG" then
        makeButton("🥚 Egg ESP",0,function()
            status.Text = "Egg ESP requires your game's egg data."
        end)

        makeButton("⭐ Rarest Egg Finder",48,function()
            status.Text = "Connect your egg rarity data."
        end)

        makeButton("🏆 Best Egg Finder",96,function()
            status.Text = "Connect your egg value data."
        end)

    elseif tab == "TELEPORT" then
        makeButton("🏠 Teleport to Base",0,function()
            status.Text = "Configure your own game's BasePoint."
        end)

        makeButton("🏃 Teleport to Treadmill",48,function()
            status.Text = "Configure your own game's TreadmillPoint."
        end)

        makeButton("🌎 Teleport to Zone",96,function()
            status.Text = "Configure your own game's ZonePoint."
        end)

    elseif tab == "SETTINGS" then
        makeButton("⚡ Speed: 16",0,function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = 16
                status.Text = "Normal speed enabled."
            end
        end)

        makeButton("⚡ Speed: 24",48,function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = 24
                status.Text = "Speed set to 24."
            end
        end)

        makeButton("🔄 Reset Speed",96,function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = 16
                status.Text = "Speed reset."
            end
        end)

    elseif tab == "PREMIUM" then
        makeButton("🔑 Premium Key",0,function()
            status.Text = "Premium access requires server validation."
        end)

        makeButton("⭐ Premium Features",48,function()
            status.Text = "Premium features coming soon."
        end)
    end
end

for i,tabName in ipairs(tabNames) do
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0.25,-4,1,0)
    tab.Position = UDim2.new((i-1)*0.25,0,0,0)
    tab.BackgroundColor3 = PANEL
    tab.Text = tabName
    tab.TextColor3 = WHITE
    tab.TextSize = 10
    tab.Font = Enum.Font.GothamBold
    tab.Parent = tabs

    Instance.new("UICorner",tab).CornerRadius = UDim.new(0,6)

    tab.Activated:Connect(function()
        showTab(tabName)
        status.Text = tabName.." SECTION"
    end)
end

-- MINIMIZE
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35,35)
minimize.Position = UDim2.new(1,-43,0,10)
minimize.BackgroundColor3 = DARK
minimize.Text = "-"
minimize.TextColor3 = WHITE
minimize.TextSize = 22
minimize.Parent = main

minimize.Activated:Connect(function()
    content.Visible = not content.Visible
    tabs.Visible = not tabs.Visible
    main.Size = content.Visible
        and UDim2.fromOffset(360,430)
        or UDim2.fromOffset(360,95)
end)

showTab("EGG")

print("CHINU HUB V3 LOADED!")
