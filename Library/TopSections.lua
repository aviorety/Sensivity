local TweenService = game:GetService('TweenService')

local TopSections = {}
TopSections.assets = {
    left_sections = game:GetObjects('rbxassetid://17503326196')[1],
    right_sections = game:GetObjects('rbxassetid://17503333599')[1],

    top_sections = game:GetObjects('rbxassetid://17492980293')[1],
    section = game:GetObjects('rbxassetid://17493046479')[1]
}


function TopSections:open()
    TweenService:Create(self, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.6
    }):Play()

    TweenService:Create(self.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Transparency = 0.8
    }):Play()

    TweenService:Create(self.SectionName, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        TextTransparency = 0
    }):Play()
end


function TopSections:close()
    TweenService:Create(self, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()

    TweenService:Create(self.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play()

    TweenService:Create(self.SectionName, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        TextTransparency = 0.5
    }):Play()
end


function TopSections:update()
    for _, object in self.container:GetChildren() do
        if not object.Name:find('Sections') or object.Name:find('Top') then
            continue
        end

        object.Visible = object == self.left_sections or object == self.right_sections
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


function TopSections:create()
    local section = TopSections.assets.section:Clone()
    section.SectionName.Text = self.name

    local left_sections = TopSections.assets.left_sections:Clone()
    local right_sections = TopSections.assets.right_sections:Clone()

    if self.container:FindFirstChild('TopSections') then
        left_sections.Visible = false
        right_sections.Visible = false
    end

    if not self.top_sections:FindFirstChild('Section') then
        section.Parent = self.top_sections
        left_sections.Parent = self.container
        right_sections.Parent = self.container

        TopSections.update({
            left_sections = left_sections,
            right_sections = right_sections,
            section = section,

            container = self.container,
            top_sections = self.top_sections
        })
    else
        left_sections.Visible = false
        right_sections.Visible = false
    end

    section.Parent = self.top_sections
    left_sections.Parent = self.container
    right_sections.Parent = self.container

    section.MouseButton1Click:Connect(function()
        left_sections.Visible = true
        right_sections.Visible = true

        TopSections.update({
            left_sections = left_sections,
            right_sections = right_sections,
            section = section,

            container = self.container,
            top_sections = self.top_sections
        })
    end)

    return {
        section = section,
        left_sections = left_sections,
        right_sections = right_sections
    }
end


return TopSections