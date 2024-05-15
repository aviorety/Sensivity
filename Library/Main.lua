local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')

local Blur = loadstring(game:HttpGet('https://raw.githubusercontent.com/aviorety/Sensivity/main/Library/Blur.lua'))()

local TopSections = loadstring(game:HttpGet('https://raw.githubusercontent.com/aviorety/Sensivity/main/Library/TopSections.lua'))()


function TopSections:update()
    for _, object in self.container:GetChildren() do
        if not object.Name:find('Sections') or object.Name:find('Top') then
            continue
        end

        if object ~= self.left_sections or object ~= self.right_sections then
            object.Visible = false

            continue
        end

        object.Visible = true
        object.BackgroundTransparency = 0.5
    end

    for _, object in self.top_sections:GetChildren() do
        if object.Name ~= 'Section' then
            continue
        end

        if object ~= self.section then
            TopSections.close(object)

            continue
        end

        TopSections.open(object)
    end
end


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

    local TabManager = {}

    function TabManager:create_tab()
        local top_sections = Tab.create({
            TopSections = TopSections,
            container = container.Container,
            name = self.name,
            icon = self.icon
        })

        local TopSectionManager = {}

        function TopSectionManager:create_section()
            local section = TopSections.create({
                container = container.Container,
                top_sections = top_sections,
                name = self
            })


        end

        return TopSectionManager
    end

    return TabManager
end


local main = Library.init()


do
    local blatant = main.create_tab({
        name = 'Blatant',
        icon = 'rbxassetid://17447902260'
    })

    local main = blatant.create_section('Main')
end


do
    local visual = main.create_tab({
        name = 'Visual',
        icon = 'rbxassetid://17447918843'
    })

    local entity = visual.create_section('Entity')
    local world = visual.create_section('World')
end


do
    local misc = main.create_tab({
        name = 'Misc',
        icon = 'rbxassetid://17487146915'
    })

    local main = misc.create_section('Main')
end


return Library