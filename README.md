-- [[ V1 Movement System - Final Working Version ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ใส่ ID หน้าเว็บปกติได้เลย เดี๋ยวสคริปต์จัดการดึง Raw ID ให้เอง
local V1_ANIMATIONS = {
    Idle  = "rbxassetid://109752457660298",
    Walk  = "rbxassetid://103979922296239",
    Run   = "rbxassetid://104785408689451",
    Jump  = "rbxassetid://70399570944472",
    Fall  = "rbxassetid://104724571711291",
    Climb = "rbxassetid://111565806941062",
    Swim  = "rbxassetid://77140283527772"
}

-- ฟังก์ชันดึง Raw ID (ตัวที่สคริปต์ Animate ต้องการจริงๆ)
local function GetRawAnimationId(catalogId)
    local success, objects = pcall(function() return game:GetObjects(catalogId) end)
    if success and objects and objects[1] then
        if objects[1]:IsA("Animation") then return objects[1].AnimationId end
        local anim = objects[1]:FindFirstChildWhichIsA("Animation", true)
        if anim then return anim.AnimationId end
    end
    return catalogId -- ถ้าดึงไม่ได้ ให้ใช้ค่าเดิม
end

local function InjectV1Animations(character)
    local animateScript = character:WaitForChild("Animate", 10)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if not animateScript or not humanoid then return end

    animateScript.Disabled = true

    -- แปลงทุก ID ให้เป็น Raw ID ก่อนเอาไปใส่
    for name, id in pairs(V1_ANIMATIONS) do
        V1_ANIMATIONS[name] = GetRawAnimationId(id)
    end

    local function Replace(animName, targetName, assetId)
        local container = animateScript:FindFirstChild(animName)
        if container then
            local anim = container:FindFirstChild(targetName)
            if anim then anim.AnimationId = assetId end
        end
    end

    Replace("idle", "Animation1", V1_ANIMATIONS.Idle)
    Replace("idle", "Animation2", V1_ANIMATIONS.Idle)
    Replace("walk", "WalkAnim", V1_ANIMATIONS.Walk)
    Replace("run", "RunAnim", V1_ANIMATIONS.Run)
    Replace("jump", "JumpAnim", V1_ANIMATIONS.Jump)
    Replace("fall", "FallAnim", V1_ANIMATIONS.Fall)
    Replace("climb", "ClimbAnim", V1_ANIMATIONS.Climb)
    Replace("swim", "SwimAnim", V1_ANIMATIONS.Swim)

    -- รีเซ็ต Animator เพื่อให้มันอ่านค่าใหม่
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do track:Stop(0) end
    end

    animateScript.Disabled = false
    print("V1 Movement Injected Successfully!")
end

if LocalPlayer.Character then InjectV1Animations(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    InjectV1Animations(char)
end)
