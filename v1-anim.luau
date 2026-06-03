-- [[ V1 Movement System - Optimized Version ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local V1_ANIMATIONS = {
    Idle  = "rbxassetid://109752457660298",
    Walk  = "rbxassetid://103979922296239",
    Run   = "rbxassetid://104785408689451",
    Jump  = "rbxassetid://70399570944472",
    Fall  = "rbxassetid://104724571711291",
    Climb = "rbxassetid://111565806941062",
    Swim  = "rbxassetid://77140283527772"
}

-- เพิ่มตัวแปรเช็คสถานะการ Inject
local isInjected = false

local function GetRawAnimationId(catalogId)
    local success, objects = pcall(function() return game:GetObjects(catalogId) end)
    if success and objects and objects[1] then
        if objects[1]:IsA("Animation") then return objects[1].AnimationId end
        local anim = objects[1]:FindFirstChildWhichIsA("Animation", true)
        if anim then return anim.AnimationId end
    end
    return catalogId
end

local function InjectV1Animations(character)
    -- ถ้าเคย Inject ไปแล้ว ให้ข้ามไปเลย ไม่ต้องโหลดซ้ำ
    if isInjected then return end
    
    local animateScript = character:WaitForChild("Animate", 10)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if not animateScript or not humanoid then return end

    animateScript.Disabled = true

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

    animateScript.Disabled = false
    isInjected = true -- ล็อกสถานะว่ารันเสร็จสิ้นแล้ว
    print("V1 Movement Injected Successfully!")
end

-- รันครั้งเดียวเมื่อสคริปต์ทำงาน
if LocalPlayer.Character then 
    InjectV1Animations(LocalPlayer.Character) 
end

-- ตัดการฟัง CharacterAdded ทิ้ง เพื่อไม่ให้มันโหลดซ้ำตอนเกิดใหม่
