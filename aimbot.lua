-- Compiled with roblox-ts v2.3.0
local Workspace = cloneref(game:GetService("Workspace"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local MiscFolder = Workspace:WaitForChild("Misc")
local AIFolder = MiscFolder:WaitForChild("AI")
local Camera = Workspace.CurrentCamera
local RangedController = {}
do
    local _container = RangedController
    local CHAIN
    local aimbot_toggle
    local lookAt = function(cframe)
        local lookAtPos = CFrame.new(Camera.CFrame.Position, cframe.Position)
        Camera.CFrame = lookAtPos
    end
    local getChain = function()
        if CHAIN then
            return CHAIN
        end
        local chosen
        for _, child in AIFolder:GetChildren() do
            local chainModel = child
            local rootPart = chainModel:FindFirstChild("HumanoidRootPart")
            if rootPart then
                chosen = chainModel
            end
        end
        return chosen
    end
    local onRender = function()
        CHAIN = getChain()
        if CHAIN ~= nil then
            if aimbot_toggle then
                lookAt(CHAIN:GetPivot())
            end
        end
    end
    local function __init()
        aimbot_toggle = false
        UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.H then
                CHAIN = nil
                aimbot_toggle = not aimbot_toggle -- Переключение состояния
            end
        end)
        RunService.RenderStepped:Connect(function()
            return onRender()
        end)
    end
    _container.__init = __init
end
RangedController.__init()
return 0
