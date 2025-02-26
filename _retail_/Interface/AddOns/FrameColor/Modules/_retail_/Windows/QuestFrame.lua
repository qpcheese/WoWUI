local _, addonTable = ...
local addon = addonTable.addon

local module = addon:NewModule("QuestFrame")
local color1, color2, color3, color4

function module:OnEnable()
    local dbObj = addon.db.profile["Windows"]["QuestFrame"]
    if dbObj.classcolored1 then
        color1 = addonTable.classColor
    else
        color1 = dbObj.color1
    end
    if dbObj.classcolored2 then
        color2 = addonTable.classColor
    else
        color2 = dbObj.color2
    end
    if dbObj.classcolored4 then
        color4 = addonTable.classColor
    else
        color4 = dbObj.color4
    end
    self:Recolor(color1, color2, color3, color4, 1)
end

function module:OnDisable()
    local color = {r=1,g=1,b=1,a=1}
    self:Recolor(color, color, color, color, 0)
end

function module:Recolor(color1, color2, color3, color4, desaturation)
    --reskin frames
    for _,frame in pairs({
        QuestFrame,
        QuestFrameInset,
    }) do 
        addon:SkinNineSliced(frame, color1, desaturation)
    end
    local bg = QuestFrameBg
    if bg then
        bg:SetDesaturation(desaturation)
        bg:SetVertexColor(color2.r,color2.g,color2.b,color2.a)
    end
    --[[
        ]]
    -- NPC Model Flow 
    for _,texture in pairs({
        QuestModelScene.TopBarBg,
        QuestModelScene.Border,
        QuestModelScene.ModelNameDivider,
        QuestModelScene.ModelNameBackground,
    }) do
        texture:SetDesaturation(desaturation)
        texture:SetVertexColor(color1.r,color1.g,color1.b,color1.a)
    end
    --reskin scrollbars
    for _, scrollBar in pairs({
        QuestDetailScrollFrame,
        QuestNPCModelTextScrollFrame,
    }) do
        addon:SkinScrollBar(scrollBar, color4)
    end
    
end


