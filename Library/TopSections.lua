local TopSections = {}


function TopSection:update()
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
    section.Parent = self.top_sections
end


return TopSections