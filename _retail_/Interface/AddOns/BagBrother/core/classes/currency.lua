--[[
	A currency button.
	All Rights Reserved
--]]

local ADDON, Addon = ...
local C = LibStub('C_Everywhere').CurrencyInfo
local Currency = Addon.Tipped:NewClass('Currency', 'Button')

function Currency:Construct()
	local b = self:Super(Currency):Construct()
	b:SetNormalFontObject('NumberFontNormalRight')
	b:SetHeight(24)
	return b
end

function Currency:Set(data)
	self:SetText(format('%s|T%s:14:14:2:0%s|t  ', data.quantity or 0, data.iconFileID or 0, data.iconArgs or ''))
	self.data = data
	self:Show()
	self:SetWidth(self:GetTextWidth() + 2)
end

function Currency:OnClick()
	if IsModifiedClick('CHATLINK') then
		HandleModifiedItemClick(C.GetCurrencyLink(self.data.currencyTypesID, self.data.quantity))
	elseif not self:IsCached() then
		ToggleCharacter('TokenFrame')
	end
end

function Currency:OnEnter()
	GameTooltip:SetOwner(self:GetTipAnchor())
	if self:IsCached() then
		(GameTooltip.SetCurrencyByID or GameTooltip.SetCurrencyTokenByID)(GameTooltip, self.data.currencyTypesID)
	else
		GameTooltip:SetBackpackToken(self.data.index)
	end
end
