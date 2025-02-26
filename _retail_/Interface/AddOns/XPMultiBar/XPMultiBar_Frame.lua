--[=====[
		## XP MultiBar ver. 11.0.0-final
		## XPMultiBar_Frame.lua - module
		Frame module (UI) for XPMultiBar addon
--]=====]

local addonName = ...
local Utils = LibStub("rmUtils-1.1")
local AceAddon = LibStub("AceAddon-3.0")
local XPMultiBar = AceAddon:GetAddon(addonName)
local UI = XPMultiBar:NewModule("UI", "AceEvent-3.0")

local geterrorhandler = geterrorhandler
local ipairs = ipairs
local type = type
local unpack = unpack
local xpcall = xpcall
local math_floor = math.floor

local CreateFrame = CreateFrame
local GameFontNormal = GameFontNormal
local GetTime = GetTime
local IsAltKeyDown = IsAltKeyDown
local IsControlKeyDown = IsControlKeyDown
local IsShiftKeyDown = IsShiftKeyDown
local StatusTrackingBarManager = StatusTrackingBarManager
local MainMenuExpBar = MainMenuExpBar
local ReputationWatchBar = ReputationWatchBar
local UIParent = UIParent

-- Remove all known globals after this point
-- luacheck: std none

local barFrame
local barEvent

local function onBarEvent(...)
	return barEvent and barEvent(...)
end

local previousStatusTrackingBarVisibility

local margins = {
	[1] = { 2, 2, },
	[ [[interface\dialogframe\ui-dialogbox-border]]	] = { 2, 3 },
	[ [[interface\friendsframe\ui-toast-border]]	] = { 3, 3 },
	[ [[interface\tooltips\ui-tooltip-border]]		] = { 2, 2 },
	[ [[interface\minimap\tooltipbackdrop]]			] = { 4, 4 },
}
local defaultBorderColor = { r = 0.5, g = 0.5, b = 0.5, a = 1 }
local noBorderColor = { r = 0, g = 0, b = 0, a = 0 }

-- luacheck: push globals XPMultiBarButtonBackdropInfo

XPMultiBarButtonBackdropInfo = {
	edgeFile = "Interface\\FriendsFrame\\UI-Toast-Border",
	edgeSize = 10,
	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}

-- luacheck: pop

-- luacheck: push globals XPMultiBarInnerBarFrameMixin XPMultiBarFrameMixin XPMultiBarButtonMixin

XPMultiBarInnerBarFrameMixin = {}
XPMultiBarFrameMixin = {}
XPMultiBarButtonMixin = {}

local ibx = XPMultiBarInnerBarFrameMixin
local fx = XPMultiBarFrameMixin
local bx = XPMultiBarButtonMixin

-- luacheck: pop

--[[ Frame object mixin methods ]]

function fx:OnLoad()
	barFrame = self

	self:Hide()

	-- Set frame levels
	self:SetFrameLevel(0)
	local level = self:GetFrameLevel()
	local children = { self.background, self.remaining, self.xpbar, self.bubbles, self.button }

	for i, v in ipairs(children) do
		v:SetFrameLevel(level + i)
	end

	-- Set bubbles texture not tiling
	self.bubbles.tex:SetHorizTile(false)

	self.button:RegisterForDrag("LeftButton")
	self.button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
end

function fx:SetBarValues(barKey, min, max, value)
	local bar = self[barKey]
	bar:SetMinMaxValues(min, max)
	bar:SetValue(value)
end

function fx:SetBarColor(barKey, color)
	local bar = self[barKey]
	bar:SetStatusBarColor(color.r, color.g, color.b, color.a)
end

function fx:SetBarVisible(barKey, visible)
	self[barKey]:SetShown(visible)
end

--[[ Inner bar object mixin methods ]]

function ibx:SetMargin(x, y)
	if type(x) ~= "number" then
		x = 0
	elseif x < 0 then
		x = -x
	end
	if type(y) ~= "number" then
		y = 0
	elseif y < 0 then
		y = -y
	end

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", x, -y)
	self:SetPoint("BOTTOMRIGHT", -x, y)
end

function ibx:SetTexture(texturePath, horizTile)
	local texture = self:GetStatusBarTexture()
	texture:SetTexture(texturePath, horizTile and "REPEAT" or "CLAMP", "CLAMP", "TRILINEAR")
	texture:SetHorizTile(horizTile or false)
	texture:SetVertTile(false)
end

--[[ Button object mixin methods ]]

function bx:OnLoad()
	self.xpIcons = { self.expMaxIcon, self.expStopIcon, self.expCapIcon }
	self.azerIcons = { self.azerMaxIcon }
	self.repIcons = { self.piGlow, self.piIcon, self.piCheck, self.lfgBonusIcon, self.repBonusIcon, self.atWarIcon, self.renownIcon }
	self.icons = Utils.Append(self.xpIcons, self.azerIcons, self.repIcons)
	self:HideAllIcons()
end

function bx:OnClick(button, down)
	onBarEvent("button-click", button, IsControlKeyDown(), IsAltKeyDown(), IsShiftKeyDown())
end

function bx:OnEnter(motion)
	onBarEvent("button-over", true, IsControlKeyDown(), IsAltKeyDown(), IsShiftKeyDown())
end

function bx:OnLeave(motion)
	onBarEvent("button-over", false, IsControlKeyDown(), IsAltKeyDown(), IsShiftKeyDown())
end

function bx:OnDragStart()
	local bar = self:GetParent()
	if bar:IsMovable() then
		bar:StartMoving()
	end
end

function bx:OnDragStop()
	local bar = self:GetParent()
	if bar:IsMovable() then
		bar:StopMovingOrSizing()
		onBarEvent("save-position", UI:GetPosition())
	end
end

function bx:OnUpdate()
	if (not Utils.IsClassic) and self.piGlow:IsShown() then
		local alpha
		local time = GetTime()
		local value = time - math_floor(time)
		local direction = math_floor(time) % 2;

		if direction == 0 then
			alpha = value
		else
			alpha = 1 - value
		end

		self.piGlow:SetAlpha(alpha)
	end
end

function bx:SetBorderTexture(texture, color)
	local bd = self:GetBackdrop()
	bd.edgeFile = texture
	if color then
		-- Probably a bug: it is always set to 1,1,1,1
		bd.backdropBorderColor = color
	end

	self:SetBackdrop(bd)
end

function bx:SetBorderColor(color)
	self:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
end

function bx:GetVisibleIconWidth()
	for _, icon in ipairs(self.icons) do
		if icon ~= self.piGlow and icon ~= self.piCheck and icon:IsVisible() then
			return icon == self.piIcon and 20 or icon:GetWidth()
		end
	end
	return 0
end

function bx:AdjustTextPoint()
	local text = self.text
	local iconWidth = self:GetVisibleIconWidth()
	local offset = 5 -- default icon offset

	if self.repBonusIcon:IsVisible() and self.lfgBonusIcon:IsVisible() then
		offset = 10
	end
	local textOffset = iconWidth > 0 and (iconWidth + offset) / 2.0 or 0

	if textOffset ~= text.offset then
		text:ClearAllPoints()
		text:SetPoint("CENTER", textOffset, 0)
		text.offset = textOffset
	end
end

function bx:HideAllIcons()
	for _, icon in ipairs(self.icons) do
		icon:Hide()
	end
end

function bx:SetXPIcons(info)
	self:HideAllIcons()
	if type(info) == "table" then
		local isMaxLevel, isXPStopped, isLevelCap = unpack(info)
		if isMaxLevel then
			self.expMaxIcon:Show()
		elseif isXPStopped then
			self.expStopIcon:Show()
		elseif isLevelCap then
			self.expCapIcon:Show()
		end
	end
	self:AdjustTextPoint()
end

function bx:SetAzeriteIcons(info)
	self:HideAllIcons()
	if type(info) == "table" then
		local isHeartMaxLevel = unpack(info)
		if isHeartMaxLevel then
			self.azerMaxIcon:Show()
		end
	end
	self:AdjustTextPoint()
end

function bx:SetFactionIcons(info)
	self:HideAllIcons()
	if type(info) == "table" then
		local hasBonus, hasLfgBonus, isParagon, hasParagonReward, isAtWar, isRenown = unpack(info)
		if hasBonus then
			self.repBonusIcon:Show()
		end
		if hasLfgBonus then
			self.lfgBonusIcon:Show()
			if hasBonus then
				self.lfgBonusIcon:ClearAllPoints()
				self.lfgBonusIcon:SetPoint("RIGHT", self.text, "LEFT", -10, 0)
			end
		end
		if not hasBonus or not hasLfgBonus then
			self.lfgBonusIcon:ClearAllPoints()
			self.lfgBonusIcon:SetPoint("RIGHT", self.text, "LEFT", -5, 0)
		end
		if isParagon then
			self.piIcon:Show()
			self.piGlow:SetShown(hasParagonReward)
			self.piCheck:SetShown(hasParagonReward)
		end
		if isAtWar then
			self.atWarIcon:Show()
		end
		if isRenown then
			self.renownIcon:Show()
		end
	end
	self:AdjustTextPoint()
end

--[[ Module methods ]]

function UI:OnInitialize()
	self.barFrame = barFrame

	barEvent = Utils.Event.New("OnBarEvent")
end

function UI:OnEnable(...)
	local hideStatusTrackingBar = ...
	self.barFrame:Show()
	self:SetStatusTrackingBarHidden(hideStatusTrackingBar)
end

function UI:OnDisable()
	self:SetStatusTrackingBarHidden(false)
	self.barFrame:Hide()
end

function UI:RegisterBarEventHandler(func, receiver)
	barEvent:AddHandler(func, receiver)
end

function UI:EnableEx(...)
	-- shortened impl of AceAddon's module:Enable
	-- suitable for passing arguments to module:OnEnable handler
	self:SetEnabledState(true)

	local aa = AceAddon

	if not aa.statuses[self.name] and self.enabledState then
		aa.statuses[self.name] = true

		if type(self.OnEnable) == "function" then
			xpcall(self.OnEnable, geterrorhandler(), self, ...)
		end

		return aa.statuses[self.name]
	end

	return false
end

function UI:GetBarText()
	return self.barFrame.button.text:GetText()
end

function UI:GetPosition()
	local anchor, _, anchorRel, x, y = self.barFrame:GetPoint()
	local s = self.barFrame:GetEffectiveScale()

	return { anchor = anchor, anchorRel = anchorRel, x = x * s, y = y * s }
end

function UI:SetPosition(position)
	local anchor, anchorRel, x, y = position.anchor, position.anchorRel, position.x, position.y
	local s = self.barFrame:GetEffectiveScale()

	x, y = x / s, y / s

	if anchorRel == "-" then
		anchorRel = anchor
	end

	self.barFrame:ClearAllPoints()
	self.barFrame:SetPoint(anchor, UIParent, anchorRel, x, y)
end

function UI:SetLocked(value)
	self.barFrame:SetMovable(not value)
	self.barFrame.locked = value
end

function UI:SetClamp(value)
	self.barFrame:SetClampedToScreen(value)
end

function UI:SetStrata(strata)
	self.barFrame:SetFrameStrata(strata)
end

function UI:SetSize(width, height)
	self.barFrame:SetSize(width, height)
end

function UI:SetWidth(width)
	self.barFrame:SetWidth(width)
end

function UI:SetHeight(height)
	self.barFrame:SetHeight(height)
end

function UI:SetScale(scale)
	local pos = self:GetPosition()
	self.barFrame:SetScale(scale)
	self:SetPosition(pos)
	onBarEvent("set-position", pos)
end

function UI:SetFontOptions(font, size, outline)
	local normalFont, normalSize, normalFlags, flags
	if not font or not size or outline == nil then
		normalFont, normalSize, normalFlags = GameFontNormal:GetFont()
	end

	-- TODO: normalFlags excluing OUTLINE?
	flags = outline and "OUTLINE" or normalFlags

	self.barFrame.button.text:SetFont(font or normalFont, size or normalSize, flags)
end

function UI:SetTexture(texturePath, horizTile, bgColor)
	Utils.ForEach(
		{ self.barFrame.background, self.barFrame.remaining, self.barFrame.xpbar },
		function(bar)
			bar:SetTexture(texturePath, horizTile)
		end
	)
	self:SetBackgroundColor(bgColor)
end

function UI:SetBackgroundColor(color)
	if color then
		self.barFrame.background:SetStatusBarColor(color.r, color.g, color.b, color.a)
	end
end

function UI:SetMargin(x, y)
	Utils.ForEach(
		{ self.barFrame.background, self.barFrame.remaining, self.barFrame.xpbar, self.barFrame.bubbles },
		function(bar)
			bar:SetMargin(x, y)
		end
	)
end

function UI:SetBorder(texture, color)
	local bTexture, bMargins, bColor
	if not texture then
		bColor = noBorderColor
	elseif texture == true then
		bColor = color or defaultBorderColor
	else
		bTexture = texture
		bMargins = margins[texture:lower()] or margins[1]
		bColor = color or defaultBorderColor
	end

	if bTexture then
		self.barFrame.button:SetBorderTexture(bTexture)
		self.barFrame.button:SetBorderColor(bColor)
	elseif bColor then
		self.barFrame.button:SetBorderColor(bColor)
	end
	if bMargins then
		self:SetMargin(unpack(bMargins))
	end
end

function UI:ShowBubbles(value)
	if value then
		self.barFrame.bubbles:Show()
	else
		self.barFrame.bubbles:Hide()
	end
end

function UI:HideBlizzFrame(frame)
	if not self.uiHider then
		self.uiHider = CreateFrame("Frame")
		self.uiHider:Hide()
	end
	if frame then
		frame._parent = frame:GetParent()
		frame:Hide()
		frame:SetParent(self.uiHider)
	end
end

function UI:UnhideBlizzFrame(frame)
	if frame then
		frame:Show()
		if frame._parent then
			frame:SetParent(frame._parent)
		end
	end
end

function UI:SetStatusTrackingBarHidden(hide)
	-- WoW Classic
	if MainMenuExpBar and ReputationWatchBar then
		if hide then
			previousStatusTrackingBarVisibility = MainMenuExpBar:IsVisible()
			self:HideBlizzFrame(MainMenuExpBar)
			self:HideBlizzFrame(ReputationWatchBar)
		elseif previousStatusTrackingBarVisibility then
			previousStatusTrackingBarVisibility = false
			self:UnhideBlizzFrame(MainMenuExpBar)
			self:UnhideBlizzFrame(ReputationWatchBar)
		end
	end
	-- WoW Retail
	if StatusTrackingBarManager then
		if hide then
			previousStatusTrackingBarVisibility = StatusTrackingBarManager:IsVisible()
			-- do not reparent, because some specific parent method is called (and reparenting is not required)
			StatusTrackingBarManager:Hide()
		elseif previousStatusTrackingBarVisibility then
			previousStatusTrackingBarVisibility = false
			StatusTrackingBarManager:Show()
		end
	end
end

function UI:SetMainBarValues(min, max, value)
	self.barFrame:SetBarValues("xpbar", min, max, value)
end

function UI:SetMainBarColor(color, setBorder)
	self.barFrame:SetBarColor("xpbar", color)
	if setBorder then
		self:SetBorder(true, color)
	end
end

function UI:SetMainBarVisible(visible, setBorder)
	self.barFrame:SetBarVisible("xpbar", visible)
	if not visible and setBorder then
		self:SetBorder(true, defaultBorderColor)
	end
end

function UI:SetRemainingBarValues(min, max, value)
	self.barFrame:SetBarValues("remaining", min, max, value)
end

function UI:SetRemainingBarColor(color)
	self.barFrame:SetBarColor("remaining", color)
end

function UI:SetRemainingBarVisible(visible)
	self.barFrame:SetBarVisible("remaining", visible)
end

function UI:SetBarText(text)
	self.barFrame.button.text:SetShown(text and true or false)
	self.barFrame.button.text:SetText(text)
end

function UI:SetBarTextColor(color)
	if color then
		self.barFrame.button.text:SetTextColor(color.r, color.g, color.b, color.a)
	end
end

function UI:HideIcons()
	self.barFrame.button:HideAllIcons()
end

function UI:SetXPInfo(info)
	self.barFrame.button:SetXPIcons(info)
end

function UI:SetAzeriteInfo(info)
	self.barFrame.button:SetAzeriteIcons(info)
end

function UI:SetFactionInfo(id, factionInfo)
	self.barFrame.button:SetFactionIcons(factionInfo)
end
