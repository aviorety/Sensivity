local TweenService = game:GetService('TweenService')

local TopSections = {}
TopSections.assets = {
    top_sections = game:GetObjects('rbxassetid://17492980293')[1],
    section = game:GetObjects('rbxassetid://17493046479')[1]
}


function TopSections:open()
    TweenService:Create(self, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 0
    }):Play()

    TweenService:Create(self, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        TextTransparency = 0
    }):Play()
end


function TopSections:close()
    TweenService:Create(self, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(self, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        TextTransparency = 0.5
    }):Play()
end


function TopSections:update()
    for _, object in self.container:GetChildren() do
        if object.Name ~= 'TopSections' then
            continue
        end

        if object ~= self.top_sections then
            object.Visible = false

            continue
        end

        object.Visible = true
    end
end


function TopSections:create()
    local section = TopSections.assets.section:Clone()
    section.SectionName.Text = self.name

    if not self.top_sections:FindFirstChild('Section') then
        TopSections:open(section)
    end
    
    section.Parent = self.top_sections
end


return TopSections