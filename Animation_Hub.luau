-- [[ V1 Animation Hub - Codex System (Final Complete Version) ]] --
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. Create Main Container
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AnimationCodexUI"
ScreenGui.ResetOnSpawn = false -- กัน UI หายเวลาตัวละครตาย

-- 2. Open Button (Small)
local OpenBtn = Instance.new("ImageButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.Image = "rbxassetid://10723356073"
OpenBtn.Draggable = true
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)

-- 3. Main Book Frame
local BookFrame = Instance.new("Frame", ScreenGui)
BookFrame.Size = UDim2.new(0, 450, 0, 300)
BookFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
BookFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
BookFrame.Visible = false
Instance.new("UICorner", BookFrame)
Instance.new("UIStroke", BookFrame).Color = Color3.fromRGB(200, 200, 200)

-- Close Button (สำหรับปิด UI ใหญ่)
local CloseBtn = Instance.new("TextButton", BookFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CloseBtn)
CloseBtn.MouseButton1Click:Connect(function() BookFrame.Visible = false end)

-- 4. Page System
local currentPage = 1
local function UpdatePages()
    for _, child in pairs(BookFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name:sub(1,4) == "Page" then child.Visible = false end
    end
    BookFrame:FindFirstChild("Page"..currentPage).Visible = true
end

local function CreatePage(pageNum)
    local page = Instance.new("Frame", BookFrame)
    page.Name = "Page"..pageNum
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = (pageNum == 1)
    return page
end

-- Page 1: Welcome & Reset Control
local P1 = CreatePage(1)
local Text1 = Instance.new("TextLabel", P1)
Text1.Text = "WELCOME, MACHINE.\n\n[ For custom requests, contact: KDHJFJFH2 ]"
Text1.Size = UDim2.new(0.9, 0, 0.4, 0)
Text1.Position = UDim2.new(0.05, 0, 0.1, 0)
Text1.BackgroundTransparency = 1
Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
Text1.TextScaled = true

local ResetBtn = Instance.new("TextButton", P1)
ResetBtn.Text = "RESET CHARACTER"
ResetBtn.Position = UDim2.new(0.25, 0, 0.6, 0)
ResetBtn.Size = UDim2.new(0.5, 0, 0.15, 0)
ResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", ResetBtn)
ResetBtn.MouseButton1Click:Connect(function()
    if Player.Character then Player.Character:BreakJoints() end
end)

-- Page 2: V1 Movement
local P2 = CreatePage(2)
local V1Title = Instance.new("TextLabel", P2)
V1Title.Text = "V1: THE BLOOD-FUELED AGILITY"
V1Title.Size = UDim2.new(1, 0, 0.2, 0)
V1Title.TextColor3 = Color3.fromRGB(255, 50, 50)
V1Title.BackgroundTransparency = 1

local RunBtn = Instance.new("TextButton", P2)
RunBtn.Text = "INITIALIZE PROTOCOL"
RunBtn.Position = UDim2.new(0.25, 0, 0.5, 0)
RunBtn.Size = UDim2.new(0.5, 0, 0.2, 0)
RunBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", RunBtn)
RunBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tuesdayxd70888-a11y/v1-anim.luau/refs/heads/Animation_Hub/v1-anim.luau"))()
end)

-- Navigation Buttons
local NextBtn = Instance.new("TextButton", BookFrame)
NextBtn.Text = "→"
NextBtn.Position = UDim2.new(0.85, 0, 0.85, 0)
NextBtn.Size = UDim2.new(0, 40, 0, 40)
NextBtn.MouseButton1Click:Connect(function()
    currentPage = (currentPage % 2) + 1
    UpdatePages()
end)

OpenBtn.MouseButton1Click:Connect(function() BookFrame.Visible = not BookFrame.Visible end)
