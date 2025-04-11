local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Configuration
local hitboxSize = 5
local hitboxVisible = false
local hitboxColor = Color3.fromRGB(128, 128, 128) -- Default grey
local transparencyLevel = 0.5
local hitboxes = {}

-- Create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HitboxExtenderGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Parent the ScreenGui properly
if game:GetService("RunService"):IsStudio() then
    screenGui.Parent = player.PlayerGui
else
    pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not screenGui.Parent then
        screenGui.Parent = player.PlayerGui
    end
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 380)
mainFrame.Position = UDim2.new(0.8, -140, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Add shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.ZIndex = -1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.6
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.Parent = mainFrame

-- Rounded corners for main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

-- Rounded corners for title bar
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Title text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Hitbox Extender"
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 18
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Parent = titleBar

-- Toggle button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 240, 0, 50)
toggleButton.Position = UDim2.new(0.5, -120, 0, 60)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
toggleButton.Text = "Enable Hitboxes"
toggleButton.Font = Enum.Font.GothamSemibold
toggleButton.TextSize = 16
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BorderSizePixel = 0
toggleButton.AutoButtonColor = false
toggleButton.Parent = mainFrame

-- Toggle button corner
local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 8)
toggleCorner.Parent = toggleButton

-- Size control section
local sizeSection = Instance.new("Frame")
sizeSection.Name = "SizeSection"
sizeSection.Size = UDim2.new(0, 240, 0, 70)
sizeSection.Position = UDim2.new(0.5, -120, 0, 130)
sizeSection.BackgroundTransparency = 1
sizeSection.Parent = mainFrame

-- Size label
local sizeLabel = Instance.new("TextLabel")
sizeLabel.Name = "SizeLabel"
sizeLabel.Size = UDim2.new(1, 0, 0, 30)
sizeLabel.BackgroundTransparency = 1
sizeLabel.Text = "Hitbox Size: " .. hitboxSize
sizeLabel.Font = Enum.Font.GothamSemibold
sizeLabel.TextSize = 14
sizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sizeLabel.Parent = sizeSection

-- Size slider background
local sizeSliderBG = Instance.new("Frame")
sizeSliderBG.Name = "SliderBackground"
sizeSliderBG.Size = UDim2.new(1, 0, 0, 10)
sizeSliderBG.Position = UDim2.new(0, 0, 0, 40)
sizeSliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
sizeSliderBG.BorderSizePixel = 0
sizeSliderBG.Parent = sizeSection

-- Size slider background corner
local sizeBGCorner = Instance.new("UICorner")
sizeBGCorner.CornerRadius = UDim.new(0, 5)
sizeBGCorner.Parent = sizeSliderBG

-- Size slider fill
local sizeSliderFill = Instance.new("Frame")
sizeSliderFill.Name = "SliderFill"
sizeSliderFill.Size = UDim2.new((hitboxSize - 1) / 19, 0, 1, 0)
sizeSliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
sizeSliderFill.BorderSizePixel = 0
sizeSliderFill.Parent = sizeSliderBG

-- Size slider fill corner
local sizeFillCorner = Instance.new("UICorner")
sizeFillCorner.CornerRadius = UDim.new(0, 5)
sizeFillCorner.Parent = sizeSliderFill

-- Size slider knob
local sizeSliderKnob = Instance.new("Frame")
sizeSliderKnob.Name = "SliderKnob"
sizeSliderKnob.Size = UDim2.new(0, 20, 0, 20)
sizeSliderKnob.Position = UDim2.new((hitboxSize - 1) / 19, -10, 0.5, -10)
sizeSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sizeSliderKnob.BorderSizePixel = 0
sizeSliderKnob.ZIndex = 2
sizeSliderKnob.Parent = sizeSliderBG

-- Size slider knob corner
local sizeKnobCorner = Instance.new("UICorner")
sizeKnobCorner.CornerRadius = UDim.new(1, 0)
sizeKnobCorner.Parent = sizeSliderKnob

-- Transparency control section
local transparencySection = Instance.new("Frame")
transparencySection.Name = "TransparencySection"
transparencySection.Size = UDim2.new(0, 240, 0, 70)
transparencySection.Position = UDim2.new(0.5, -120, 0, 210)
transparencySection.BackgroundTransparency = 1
transparencySection.Parent = mainFrame

-- Transparency label
local transparencyLabel = Instance.new("TextLabel")
transparencyLabel.Name = "TransparencyLabel"
transparencyLabel.Size = UDim2.new(1, 0, 0, 30)
transparencyLabel.BackgroundTransparency = 1
transparencyLabel.Text = "Transparency: " .. math.floor(transparencyLevel * 100) .. "%"
transparencyLabel.Font = Enum.Font.GothamSemibold
transparencyLabel.TextSize = 14
transparencyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
transparencyLabel.Parent = transparencySection

-- Transparency slider background
local transparencySliderBG = Instance.new("Frame")
transparencySliderBG.Name = "SliderBackground"
transparencySliderBG.Size = UDim2.new(1, 0, 0, 10)
transparencySliderBG.Position = UDim2.new(0, 0, 0, 40)
transparencySliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
transparencySliderBG.BorderSizePixel = 0
transparencySliderBG.Parent = transparencySection

-- Transparency slider background corner
local transparencyBGCorner = Instance.new("UICorner")
transparencyBGCorner.CornerRadius = UDim.new(0, 5)
transparencyBGCorner.Parent = transparencySliderBG

-- Transparency slider fill
local transparencySliderFill = Instance.new("Frame")
transparencySliderFill.Name = "SliderFill"
transparencySliderFill.Size = UDim2.new(1 - transparencyLevel, 0, 1, 0)
transparencySliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
transparencySliderFill.BorderSizePixel = 0
transparencySliderFill.Parent = transparencySliderBG

-- Transparency slider fill corner
local transparencyFillCorner = Instance.new("UICorner")
transparencyFillCorner.CornerRadius = UDim.new(0, 5)
transparencyFillCorner.Parent = transparencySliderFill

-- Transparency slider knob
local transparencySliderKnob = Instance.new("Frame")
transparencySliderKnob.Name = "SliderKnob"
transparencySliderKnob.Size = UDim2.new(0, 20, 0, 20)
transparencySliderKnob.Position = UDim2.new(1 - transparencyLevel, -10, 0.5, -10)
transparencySliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
transparencySliderKnob.BorderSizePixel = 0
transparencySliderKnob.ZIndex = 2
transparencySliderKnob.Parent = transparencySliderBG

-- Transparency slider knob corner
local transparencyKnobCorner = Instance.new("UICorner")
transparencyKnobCorner.CornerRadius = UDim.new(1, 0)
transparencyKnobCorner.Parent = transparencySliderKnob

-- Color button
local colorButton = Instance.new("TextButton")
colorButton.Name = "ColorButton"
colorButton.Size = UDim2.new(0, 240, 0, 50)
colorButton.Position = UDim2.new(0.5, -120, 0, 290)
colorButton.BackgroundColor3 = hitboxColor
colorButton.Text = "Change Color"
colorButton.Font = Enum.Font.GothamSemibold
colorButton.TextSize = 16
colorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
colorButton.BorderSizePixel = 0
colorButton.AutoButtonColor = false
colorButton.Parent = mainFrame

-- Color button corner
local colorCorner = Instance.new("UICorner")
colorCorner.CornerRadius = UDim.new(0, 8)
colorCorner.Parent = colorButton

-- Functions
local function updateHitboxSize(newSize)
    hitboxSize = math.clamp(newSize, 1, 20)
    sizeLabel.Text = "Hitbox Size: " .. hitboxSize
    sizeSliderFill.Size = UDim2.new((hitboxSize - 1) / 19, 0, 1, 0)
    sizeSliderKnob.Position = UDim2.new((hitboxSize - 1) / 19, -10, 0.5, -10)
    
    -- Update existing hitboxes
    for _, hitbox in pairs(hitboxes) do
        if hitbox and hitbox.Parent then
            hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            
            -- Update adornment size
            local adornment = hitbox:FindFirstChildOfClass("BoxHandleAdornment")
            if adornment then
                adornment.Size = Vector3.new(1, 1, 1)
            end
        end
    end
end

local function updateTransparency(newTransparency)
    transparencyLevel = math.clamp(newTransparency, 0, 1)
    transparencyLabel.Text = "Transparency: " .. math.floor(transparencyLevel * 100) .. "%"
    transparencySliderFill.Size = UDim2.new(1 - transparencyLevel, 0, 1, 0)
    transparencySliderKnob.Position = UDim2.new(1 - transparencyLevel, -10, 0.5, -10)
    
    -- Update existing hitboxes
    for _, hitbox in pairs(hitboxes) do
        if hitbox and hitbox.Parent then
            hitbox.Transparency = transparencyLevel
            
            -- Update adornment transparency
            local adornment = hitbox:FindFirstChildOfClass("BoxHandleAdornment")
            if adornment then
                adornment.Transparency = transparencyLevel
            end
        end
    end
end

local function cleanupHitboxes()
    for _, hitbox in pairs(hitboxes) do
        if hitbox and hitbox.Parent then
            hitbox:Destroy()
        end
    end
    hitboxes = {}
end

local function createHitbox(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local rootPart = targetPlayer.Character.HumanoidRootPart
    
    -- Create hitbox
    local hitbox = Instance.new("Part")
    hitbox.Name = "Hitbox_" .. targetPlayer.Name
    hitbox.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
    hitbox.Position = rootPart.Position
    hitbox.Anchored = true
    hitbox.CanCollide = false
    hitbox.Transparency = transparencyLevel
    hitbox.Color = hitboxColor
    hitbox.Material = Enum.Material.SmoothPlastic
    hitbox:SetAttribute("PlayerName", targetPlayer.Name)
    
    -- Make hitbox visible through walls
    local boxAdornment = Instance.new("BoxHandleAdornment")
    boxAdornment.Name = "HitboxAdornment"
    boxAdornment.Size = Vector3.new(1, 1, 1)
    boxAdornment.Adornee = hitbox
    boxAdornment.AlwaysOnTop = true
    boxAdornment.ZIndex = 10
    boxAdornment.Transparency = transparencyLevel
    boxAdornment.Color3 = hitboxColor
    boxAdornment.Parent = hitbox
    
    hitbox.Parent = workspace
    
    return hitbox
end

local function updateHitboxes()
    if not hitboxVisible then return end
    
    -- Clean up hitboxes for players who left
    for i = #hitboxes, 1, -1 do
        local hitbox = hitboxes[i]
        if not hitbox or not hitbox.Parent then
            table.remove(hitboxes, i)
        end
    end
    
    -- Create or update hitboxes for each player
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if targetPlayer ~= player and targetPlayer.Character and 
           targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            
            -- Check if this player already has a hitbox
            local existingHitbox = nil
            for _, hitbox in pairs(hitboxes) do
                if hitbox:GetAttribute("PlayerName") == targetPlayer.Name then
                    existingHitbox = hitbox
                    break
                end
            end
            
            if existingHitbox then
                -- Update existing hitbox
                existingHitbox.Position = targetPlayer.Character.HumanoidRootPart.Position
            else
                -- Create new hitbox
                local newHitbox = createHitbox(targetPlayer)
                if newHitbox then
                    table.insert(hitboxes, newHitbox)
                end
            end
        end
    end
end

-- Slider dragging functionality
local draggingSizeSlider = false
local draggingTransparencySlider = false

sizeSliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSizeSlider = true
        
        -- Update immediately
        local relativeX = input.Position.X - sizeSliderBG.AbsolutePosition.X
        local position = math.clamp(relativeX / sizeSliderBG.AbsoluteSize.X, 0, 1)
        local newSize = math.floor(position * 19) + 1
        updateHitboxSize(newSize)
    end
end)

transparencySliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingTransparencySlider = true
        
        -- Update immediately
        local relativeX = input.Position.X - transparencySliderBG.AbsolutePosition.X
        local position = math.clamp(relativeX / transparencySliderBG.AbsoluteSize.X, 0, 1)
        updateTransparency(1 - position)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSizeSlider = false
        draggingTransparencySlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if draggingSizeSlider then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = mousePos.X - sizeSliderBG.AbsolutePosition.X
            local position = math.clamp(relativeX / sizeSliderBG.AbsoluteSize.X, 0, 1)
            local newSize = math.floor(position * 19) + 1
            updateHitboxSize(newSize)
        elseif draggingTransparencySlider then
            local mousePos = UserInputService:GetMouseLocation()
            local relativeX = mousePos.X - transparencySliderBG.AbsolutePosition.X
            local position = math.clamp(relativeX / transparencySliderBG.AbsoluteSize.X, 0, 1)
            updateTransparency(1 - position)
        end
    end
end)

-- Button click handlers
toggleButton.MouseButton1Click:Connect(function()
    hitboxVisible = not hitboxVisible
    
    if hitboxVisible then
        toggleButton.Text = "Disable Hitboxes"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    else
        toggleButton.Text = "Enable Hitboxes"
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        cleanupHitboxes()
    end
end)

colorButton.MouseButton1Click:Connect(function()
    -- Cycle through colors: grey -> green -> red -> blue
    if hitboxColor == Color3.fromRGB(128, 128, 128) then
        hitboxColor = Color3.fromRGB(0, 255, 0) -- Green
    elseif hitboxColor == Color3.fromRGB(0, 255, 0) then
        hitboxColor = Color3.fromRGB(255, 0, 0) -- Red
    elseif hitboxColor == Color3.fromRGB(255, 0, 0) then
        hitboxColor = Color3.fromRGB(0, 0, 255) -- Blue
    else
        hitboxColor = Color3.fromRGB(128, 128, 128) -- Grey
    end
    
    colorButton.BackgroundColor3 = hitboxColor
    
    -- Update existing hitboxes
    for _, hitbox in pairs(hitboxes) do
        if hitbox and hitbox.Parent then
            hitbox.Color = hitboxColor
            
            -- Update adornment color
            local adornment = hitbox:FindFirstChildOfClass("BoxHandleAdornment")
            if adornment then
                adornment.Color3 = hitboxColor
            end
        end
    end
end)

-- Button hover effects
local function applyButtonHoverEffect(button, defaultColor)
    button.MouseEnter:Connect(function()
        local lighterColor = Color3.new(
            math.min(defaultColor.R + 0.1, 1),
            math.min(defaultColor.G + 0.1, 1),
            math.min(defaultColor.B + 0.1, 1)
        )
        button.BackgroundColor3 = lighterColor
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = defaultColor
    end)
end

-- Apply hover effects
applyButtonHoverEffect(toggleButton, Color3.fromRGB(60, 60, 65))
applyButtonHoverEffect(colorButton, hitboxColor)

-- Update hitboxes periodically
local lastUpdate = tick()
RunService.RenderStepped:Connect(function()
    -- Update hitboxes every 0.1 seconds for better performance
    local currentTime = tick()
    if currentTime - lastUpdate < 0.1 then return end
    lastUpdate = currentTime
    
    updateHitboxes()
end)

-- Clean up when player leaves
Players.PlayerRemoving:Connect(function(plr)
    if plr == player then
        cleanupHitboxes()
    end
end)
