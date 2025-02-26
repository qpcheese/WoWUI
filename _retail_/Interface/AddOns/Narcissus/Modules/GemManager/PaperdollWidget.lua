local _, addon = ...
local L = Narci.L;
local CallbackRegistry = addon.CallbackRegistry;
local TimerunningUtil = addon.TimerunningUtil;
local Gemma = addon.Gemma;
local ItemCache = Gemma.ItemCache;
local AtlasUtil = Gemma.AtlasUtil;

local GetItemQualityColor = NarciAPI.GetItemQualityColor;

NarciGemManagerPaperdollWidgetMixin = {};

function NarciGemManagerPaperdollWidgetMixin:OnLoad()
    Gemma.PaperdollWidget = self;
    NarciPaperDollWidgetController:AddWidget(self, 4, "PaperDollWidget_Remix");
end

function NarciGemManagerPaperdollWidgetMixin:OnShow()
    if self.Init then
        self:Init();
    end

    CallbackRegistry:Trigger("PaperdollWidget.Gem.OnShow", self);
end

function NarciGemManagerPaperdollWidgetMixin:OnHide()
    CallbackRegistry:Trigger("PaperdollWidget.Gem.OnHide", self);
end

function NarciGemManagerPaperdollWidgetMixin:Init()
    self.Init = nil;

    AtlasUtil:SetAtlas(self.Background, "hourglass-background");
    AtlasUtil:SetAtlas(self.Drip, "hourglass-drip");
    AtlasUtil:SetAtlas(self.Highlight, "hourglass-shine");

    self.DripMask:SetTexture("Interface/AddOns/Narcissus/Art/Modules/GemManager/Mask-Hourglass-Drip", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");
    self.HighlightMask:SetTexture("Interface/AddOns/Narcissus/Art/Modules/GemManager/Mask-Hourglass-Highlight", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");

    self.AnimDrip:Play();
end

function NarciGemManagerPaperdollWidgetMixin:ResetAnchor()
    self:ClearAllPoints();
    self:SetParent(self.parent);
    self:SetPoint("CENTER", self.parent, "CENTER", -2, 0);
end

function NarciGemManagerPaperdollWidgetMixin:OnClick()
    self:HideTooltip();
    Gemma.MainFrame:ToggleUI();
end

function NarciGemManagerPaperdollWidgetMixin:OnEnter()
    self.Highlight.AnimShine:Play();
    self.Highlight:Show();

    self:ShowTooltip();
end

function NarciGemManagerPaperdollWidgetMixin:OnLeave()
    self:StopUpdate();
    self:HideTooltip();
end

local function FormatStats(stat, count)
    return "|cffffffff"..count.."|r  |cffffd100"..stat.."|r"
end

function NarciGemManagerPaperdollWidgetMixin:OnUpdate(elapsed)
    self.t = self.t + elapsed;
    if self.t >= 0.2 then
        self:StopUpdate();
        if self:IsShown() and self:IsMouseOver() and self.shouldShowTooltip then
            self:ShowTooltip();
        end
    end
end

function NarciGemManagerPaperdollWidgetMixin:RequestUpdate()
    --equipment, bag scan / tooltip data cache
    self.t = 0;
    self:SetScript("OnUpdate", self.OnUpdate);
end

function NarciGemManagerPaperdollWidgetMixin:Update()
    --Due to equipment changed / paperdoll becomes visible
    if TimerunningUtil.IsTimerunningMode() then
        self:Show();
        self:RequestUpdate();
        return true
    else
        NarciPaperDollWidgetController:RemoveWidget(self);
        return false
    end
end

function NarciGemManagerPaperdollWidgetMixin:StopUpdate()
    if self.t then
        self:SetScript("OnUpdate", nil);
        self.t = nil;
    end
end

function NarciGemManagerPaperdollWidgetMixin:OnItemLoaded(itemID)
    self:RequestUpdate();
end

function NarciGemManagerPaperdollWidgetMixin:ShowTooltip()
    self.shouldShowTooltip = true;

    --Test
    local tooltip = GameTooltip;
    local GetItemIcon = C_Item.GetItemIconByID;
    local FORMAT_ICON_TEXT = "|T%s:18:18|t  %s";

    tooltip:SetOwner(self, "ANCHOR_NONE");
    tooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 0, 0);

    local rank = TimerunningUtil.GetThreadRank();
    tooltip:AddDoubleLine(L["Cloak Rank"], rank, 0.902, 0.800, 0.502, 1, 1, 1);
    tooltip:AddLine(" ");

    tooltip:AddLine((AUCTION_CATEGORY_GEMS or "Gems")..":", 0.5, 0.5, 0.5, true);

    local dataProvider = Gemma:GetDataProviderByName("Pandaria");
    local activeGems = dataProvider:GetActiveGems();

    if activeGems then
        local anyStats = false;
        local statData;
        for i = 1, 8 do
            statData = activeGems.stats[i];
            if statData then
                anyStats = true;
                tooltip:AddLine(FormatStats(statData[2], statData[1]));
            end
        end

        if anyStats then
            tooltip:AddLine(" ");
        end

        for i, itemID in ipairs(activeGems.traits) do
            local icon = GetItemIcon(itemID);
            local name = ItemCache:GetItemName(itemID, self);
            local quality = ItemCache:GetItemQuality(itemID, self);
            local r, g, b = GetItemQualityColor(quality);

            if icon and name and r then
                tooltip:AddLine(string.format(FORMAT_ICON_TEXT, icon, name), r, g, b);
            end
        end
    end

    tooltip:AddLine(" ");
    tooltip:AddLine(L["Click To Open Gem Manager"], 0.5, 0.5, 0.5, true);

    tooltip:Show();
end

function NarciGemManagerPaperdollWidgetMixin:HideTooltip()
    self.shouldShowTooltip = false;
    GameTooltip:Hide();
end