local TweenService = game:GetService('TweenService')

local TopSections = {}
TopSections.assets = {
    top_sections = game:GetObjects('rbxassetid://17492980293')[1],
    section = game:GetObjects('rbxassetid://17493046479')[1]
}


function TopSections:open()
    TweenService:Create(self, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 0.6
    }):Play()

    TweenService:Create(self.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        Transparency = 0.8
    }):Play()

    TweenService:Create(self.SectionName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        TextTransparency = 0
    }):Play()
end


function TopSections:close()
    TweenService:Create(self, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(self.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        Transparency = 1
    }):Play()

    TweenService:Create(self.SectionName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
        TextTransparency = 0.5
    }):Play()
end


function TopSections:update()
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


function TopSections:create()
    local section = TopSections.assets.section:Clone()
    section.SectionName.Text = self.name

    if not self.top_sections:FindFirstChild('Section') then
        TopSections.update({
            top_sections = self.top_sections,
            section = section
        })
    end
    
    section.Parent = self.top_sections

    section.MouseButton1Click:Connect(function()
        TopSections.update({
            top_sections = self.top_sections,
            section = section
        })
    end)
end


return TopSections