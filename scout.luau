-- [[ Scout Movement Override Suite: Stable Edition ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ใช้ URL เต็มของคุณได้เลย สคริปต์จะดึง ID ให้เอง
local SCOUT_ANIMATIONS = {
    Idle  = "rbxassetid://80143328896830",
    Walk  = "rbxassetid://129822566445023",
    Run   = "rbxassetid://110208399858856",
    Jump  = "rbxassetid://91371366565554",
    Fall  = "rbxassetid://108644020480886",
    Climb = "rbxassetid://83846179178230",
    Swim  = "rbxassetid://89995257414409"
}

-- ฟังก์ชันดึง ID แท้ (สำคัญมาก)
local function GetRawID(assetId)
    local success, id = pcall(function()
        return game:GetObjects(assetId)[1].AnimationId
    end)
    return success and id or assetId
end

local function InjectScoutAnimations(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    local animateScript = character:WaitForChild("Animate", 10)
    
    if not humanoid or not animateScript then return end

    -- อัปเดต ID ให้อยู่ในรูปแบบที่ถูกต้องก่อนใช้งาน
    local function setAnim(name, childName, rawId)
        local container = animateScript:FindFirstChild(name)
        if container then
            local animTarget = container:FindFirstChild(childName)
            if animTarget and animTarget:IsA("Animation") then
                animTarget.AnimationId = rawId
            end
        end
    end

    -- แปลงและตั้งค่า
    setAnim("idle", "Animation1", GetRawID(SCOUT_ANIMATIONS.Idle))
    setAnim("idle", "Animation2", GetRawID(SCOUT_ANIMATIONS.Idle))
    setAnim("walk", "WalkAnim", GetRawID(SCOUT_ANIMATIONS.Walk))
    setAnim("run", "RunAnim", GetRawID(SCOUT_ANIMATIONS.Run))
    setAnim("jump", "JumpAnim", GetRawID(SCOUT_ANIMATIONS.Jump))
    setAnim("fall", "FallAnim", GetRawID(SCOUT_ANIMATIONS.Fall))
    setAnim("climb", "ClimbAnim", GetRawID(SCOUT_ANIMATIONS.Climb))
    setAnim("swim", "Swim", GetRawID(SCOUT_ANIMATIONS.Swim))

    -- รีเซ็ต Animate Script ให้โหลดค่าใหม่
    animateScript.Disabled = true
    task.wait(0.2)
    animateScript.Disabled = false
    
    print("[Scout Suite]: Successfully injected and refreshed.")
end

-- ระบบเชื่อมต่อ character
local function Setup(char)
    task.wait(1) -- รอ rig โหลดเสร็จสนิท
    InjectScoutAnimations(char)
end

if LocalPlayer.Character then Setup(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(Setup)
    setAnim("idle", "Animation2", MOVEMENT_CATALOG_IDS.Idle)
    setAnim("walk", "WalkAnim", MOVEMENT_CATALOG_IDS.Walk)
    setAnim("run", "RunAnim", MOVEMENT_CATALOG_IDS.Run)
    setAnim("jump", "JumpAnim", MOVEMENT_CATALOG_IDS.Jump)
    setAnim("fall", "FallAnim", MOVEMENT_CATALOG_IDS.Fall)
    setAnim("climb", "ClimbAnim", MOVEMENT_CATALOG_IDS.Climb)
    setAnim("swim", "Swim", MOVEMENT_CATALOG_IDS.Swim)

    -- [4] Force Reset & Refresh
    if animator then
        for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            track:Stop(0)
        end
    end

    animateScript.Disabled = true
    task.wait(0.1)
    animateScript.Disabled = false
    
    print("[Scout Suite Pro]: Animations Applied & Verified.")
end

-- [5] Reliable Connection
local function SetupCharacter(char)
    task.wait(0.5) -- Small buffer for character rig streaming
    InjectScoutAnimations(char)
end

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(SetupCharacter)
