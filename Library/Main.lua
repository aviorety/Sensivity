local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')

local Blur = loadstring(game:HttpGet('https://raw.githubusercontent.com/aviorety/Sensivity/main/Library/Blur.lua'))()
local Tab = loadstring(game:HttpGet('https://raw.githubusercontent.com/aviorety/Sensivity/main/Library/Tab.lua'))()

local Library = {}
Library.flags = {}
Library.connections = {}

Library.container = nil
Library.container_open = true
Library.keybind = Enum.KeyCode.Insert


function Library:clear()
    for _, object in CoreGui:GetChildren() do
        if object.Name ~= 'Sensivity' then
            continue
        end

        object:Destroy()
    end
end


function Library:open()
    TweenService:Create(self.Container, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 707, 0, 390)
    }):Play()
end


function Library:close()
    TweenService:Create(self.Container, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
end


function Library:init()
    Library.clear()

    local container = game:GetObjects('rbxassetid://17487656336')[1]
    container.Parent = CoreGui
    container.Container.Size = UDim2.new(0, 0, 0, 0)

    Library.container = container
    Library.open(container)

    Blur.new(container.Container)

    Library.connections['open'] = UserInputService.InputBegan:Connect(function(input: InputObject, process: boolean)
        if process then
            return
        end

        if input.KeyCode ~= Library.keybind then
            return
        end

        if not Library.container.Parent then
            if Library.connections['open'] then
                Library.connections['open']:Disconnect()
                Library.connections['open'] = nil
            end

            return
        end

        Library.container_open = not Library.container_open

        if Library.container_open then
            Library.open(container)
        else
            Library.close(container)
        end
    end)
end


local main = Library.init()

return Library