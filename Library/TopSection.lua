local TopSection = {}
TopSection.asset = game:GetObjects('rbxassetid://17493046479')[1]


function TopSection:create()
    local section = TopSection.asset:Clone()
    section.Parent = self.top_sections

end


return TopSection