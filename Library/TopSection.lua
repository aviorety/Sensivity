local TopSection = {}


function TopSection:create()
    local section = game:GetObjects('rbxassetid://17493046479')[1]
    section.Parent = self.top_sections
end


return TopSection