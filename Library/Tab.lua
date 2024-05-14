local TweenService = game:GetService('TweenService')

local Tab = {}
Tab.asset = game:GetObjects('rbxassetid://17492924358')[1]


function Tab:open()
    TweenService:Create(self.IconBackground, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        ImageTransparency = 0
    }):Play()

    TweenService:Create(self.IconBackground.Icon, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        ImageTransparency = 0
    }):Play()

    TweenService:Create(self.TabName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        TextTransparency = 0
    }):Play()
end


function Tab:close()
    TweenService:Create(self.IconBackground, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        ImageTransparency = 1
    }):Play()

    TweenService:Create(self.IconBackground.Icon, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        ImageTransparency = 0.5
    }):Play()

    TweenService:Create(self.TabName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        TextTransparency = 0.5
    }):Play()
end


function Tab:update()
    for _, object in self.tabs:GetChildren() do
        if object.Name ~= 'Tab' then
            continue
        end

        if object ~= self.tab then
            Tab.close(object)

            continue
        end

        Tab.open(object)
    end
end


function Tab:create()
    local tab = Tab.asset:Clone()
    tab.Parent = self.container.Tabs
    tab.TabName.Text = self.name
    tab.IconBackground.Icon.Image = self.icon

    local top_sections = self.TopSections.assets.top_sections:Clone()

    if self.container:FindFirstChild('TopSections') then
        top_sections.Visible = false
    else
        Tab.update({
            tabs = self.container.Tabs,
            tab = tab
        })
    end
    
    top_sections.Parent = self.container

    tab.MouseButton1Click:Connect(function()
        Tab.update({
            tabs = self.container.Tabs,
            tab = tab
        })

        self.TopSections.update({
            top_sections = top_sections,
            container = self.container
        })
    end)

    return top_sections
end


return Tab