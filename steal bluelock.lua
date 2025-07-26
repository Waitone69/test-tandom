local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui


local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui


local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame


local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "BRAINROT SIKEN"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = frame


local teleportButton = Instance.new("TextButton")
teleportButton.Name = "TeleportButton"
teleportButton.Size = UDim2.new(0, 180, 0, 40)
teleportButton.Position = UDim2.new(0, 10, 0, 40)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
teleportButton.Text = "Teleport"
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.TextScaled = true
teleportButton.Font = Enum.Font.Gotham
teleportButton.Parent = frame


local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = teleportButton


local buttonTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

teleportButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(teleportButton, buttonTweenInfo, {
        BackgroundColor3 = Color3.fromRGB(30, 190, 255)
    })
    tween:Play()
end)

teleportButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(teleportButton, buttonTweenInfo, {
        BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    })
    tween:Play()
end)


local function teleportForward()
    character = player.Character
    if not character then return end
    
    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local currentCFrame = humanoidRootPart.CFrame
    local lookDirection = currentCFrame.LookVector
    --TP UZAKLIGI
    local teleportDistance = 10 
    
    local newPosition = currentCFrame.Position + (lookDirection * teleportDistance)
    local newCFrame = CFrame.new(newPosition, newPosition + lookDirection)
    
    humanoidRootPart.CFrame = newCFrame
    
    local flashTween = TweenService:Create(teleportButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    })
    local returnTween = TweenService:Create(teleportButton, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    })
    
    flashTween:Play()
    flashTween.Completed:Connect(function()
        returnTween:Play()
    end)
end

teleportButton.MouseButton1Click:Connect(teleportForward)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)











-- FAST STEAL ICIN

local function convertProximityPrompt(prompt)
    prompt.HoldDuration = 0
    
    if prompt.ActionText == "Hold" or prompt.ActionText == "" then
        prompt.ActionText = "Press"
    end
    
    print("Converted ProximityPrompt:", prompt.Parent.Name)
end


local function convertAllExistingPrompts()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            convertProximityPrompt(descendant)
        end
    end
end


local function onDescendantAdded(descendant)
    if descendant:IsA("ProximityPrompt") then
        convertProximityPrompt(descendant)
    end
end


convertAllExistingPrompts()


workspace.DescendantAdded:Connect(onDescendantAdded)

print("Script calisdi baba")
