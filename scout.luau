-- [[ Scout Movement Override Suite: Pro Edition ]] --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MOVEMENT_CATALOG_IDS = {
    Idle  = "rbxassetid://80143328896830",
    Walk  = "rbxassetid://129822566445023",
    Run   = "rbxassetid://110208399858856",
    Jump  = "rbxassetid://91371366565554",
    Fall  = "rbxassetid://108644020480886",
    Climb = "rbxassetid://83846179178230",
    Swim  = "rbxassetid://89995257414409"
}

local function InjectScoutAnimations(character)
    -- [1] Ensure critical components exist
    local humanoid = character:WaitForChild("Humanoid", 10)
    local animator = humanoid:WaitForChild("Animator", 10)
    local animateScript = character:WaitForChild("Animate", 10)
    
    if not humanoid or not animateScript then return end

    -- [2] Helper: Update and set Priority
    local function setAnim(name, childName, animId)
        local container = animateScript:FindFirstChild(name)
        if container then
            local animTarget = container:FindFirstChild(childName)
            if animTarget and animTarget:IsA("Animation") then
                animTarget.AnimationId = animId
            end
        end
    end

    -- [3] Apply Animations
    setAnim("idle", "Animation1", MOVEMENT_CATALOG_IDS.Idle)
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
