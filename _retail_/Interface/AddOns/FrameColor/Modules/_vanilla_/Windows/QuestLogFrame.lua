local _, addonTable = ...
local addon = addonTable.addon

local module = addon:NewModule("QuestLogFrame")
local color1

function module:OnEnable()
    local dbObj = addon.db.profile["Windows"]["QuestLogFrame"]
    if dbObj.classcolored1 then
        color1 = addonTable.classColor
    else
        color1 = dbObj.color1
    end
    if not QuestLogFrame.ParchmentFrame then
        QuestLogFrame.ParchmentFrame = QuestLogFrame:CreateTexture(nil, "OVERLAY", nil, 1)
        QuestLogFrame.ParchmentFrame:SetTexture(addonTable.texturePaths.ParchmentFrame)
        QuestLogFrame.ParchmentFrame:SetAllPoints(QuestLogDetailScrollFrame)
    end
    self:Recolor(color1, 1)
end

function module:OnDisable()
    local color = {r=1,g=1,b=1,a=1}
    self:Recolor(color, 0)
end

function module:Recolor(color1, desaturation)
    for _,v in pairs({QuestLogFrame:GetRegions()}) do
        if v:GetObjectType() == "Texture" then
            if v:GetDrawLayer() == "ARTWORK" then
                v:SetDesaturation(desaturation)
                v:SetVertexColor(color1.r,color1.g,color1.b)
            end
        end
    end
end


