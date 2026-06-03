-- [[ V1 Animation Hub - Codex System ]] --
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AnimationCodexUI"

-- Open Button
local OpenBtn = Instance.new("ImageButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenBtn.Image = "rbxassetid://10723356073"
OpenBtn.Draggable = true
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)

-- Main Book Frame
local BookFrame = Instance.new("Frame", ScreenGui)
BookFrame.Size = UDim2.new(0, 450, 0, 300)
BookFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
BookFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Darker, more mysterious
BookFrame.Visible = false
Instance.new("UICorner", BookFrame)
Instance.new("UIStroke", BookFrame).Color = Color3.fromRGB(200, 200, 200)

-- Page System
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

-- Page 1: Welcome
local P1 = CreatePage(1)
local Text1 = Instance.new("TextLabel", P1)
Text1.Text = "WELCOME, MACHINE.\n\nThis codex contains the forbidden arts of kinetic mastery. Tread carefully.\n\n[ For custom requests, contact: KDHJFJFH2 ]"
Text1.Size = UDim2.new(0.9, 0, 0.8, 0)
Text1.Position = UDim2.new(0.05, 0, 0.1, 0)
Text1.BackgroundTransparency = 1
Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
Text1.TextScaled = true

-- Page 2: V1 Movement
local P2 = CreatePage(2)
local V1Title = Instance.new("TextLabel", P2)
V1Title.Text = "V1: THE BLOOD-FUELED AGILITY"
V1Title.Size = UDim2.new(1, 0, 0.2, 0)
V1Title.TextColor3 = Color3.fromRGB(255, 50, 50)
V1Title.BackgroundTransparency = 1

local V1Desc = Instance.new("TextLabel", P2)
V1Desc.Text = "A high-octane movement protocol designed for absolute dominance. Experience hyper-mobility, rhythmic slides, and aerial maneuvers that defy standard physical laws."
V1Desc.Position = UDim2.new(0.1, 0, 0.25, 0)
V1Desc.Size = UDim2.new(0.8, 0, 0.4, 0)
V1Desc.BackgroundTransparency = 1
V1Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
V1Desc.TextWrapped = true

local RunBtn = Instance.new("TextButton", P2)
RunBtn.Text = "INITIALIZE PROTOCOL"
RunBtn.Position = UDim2.new(0.25, 0, 0.75, 0)
RunBtn.Size = UDim2.new(0.5, 0, 0.15, 0)
RunBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/tuesdayxd70888-a11y/v1-anim.luau/refs/heads/main/v1-anim.luau"))()
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

OpenBtn.MouseButton1Click:Connect(function()
    BookFrame.Visible = not BookFrame.Visible
end)
