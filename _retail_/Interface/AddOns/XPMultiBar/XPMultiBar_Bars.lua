--[=====[
		## XP MultiBar ver. 11.0.0-final
		## XPMultiBar_Bars.lua - module
		Bar displaying logic for XPMultiBar addon
--]=====]

local addonName = ...
local Utils = LibStub("rmUtils-1.1")
local XPMultiBar = LibStub("AceAddon-3.0"):GetAddon(addonName)
local Bars = XPMultiBar:NewModule("Bars")

local B = Bars

-- Remove all known globals after this point
-- luacheck: std none

-- Bar consts
B.None = 0
B.XP = 1
B.AZ = 2
B.REP = 3

local currentSettings = {
	priority = {},
	isMaxLevelXP = false,
	hasAzerite = false,
	isMaxLevelAzerite = false,
}

local currentState = {
	isOver = false,
	isAlt = false,
	isShift = false,
}

local currentBars = nil
local visibleBar = nil
local mouseOverWithShift = nil

local function GetCurrentBars(state)
	local prio, maxLevelXP = state.priority, state.isMaxLevelXP
	local index = maxLevelXP and 3 or 1
	return Utils.SliceLength(prio, (index - 1) * 3 + 1, 3)
end

function B:OnInitialize()
end

function B.UpdateBarSettings(barSettings)
	Utils.Override(currentSettings, barSettings)
	currentBars = GetCurrentBars(currentSettings)
end

function B.UpdateBarState(isOver, isAlt, isShift)

	if isOver == nil then
		isOver, isAlt, isShift = currentState.isOver, currentState.isAlt, currentState.isShift
	end

	mouseOverWithShift = isOver and isShift

	Utils.Override(currentState, { isOver = false, isAlt = false, isShift = false, })

	if not isOver or mouseOverWithShift then
		visibleBar = currentBars[1]
	elseif isAlt then
		visibleBar = currentBars[3]
	else
		visibleBar = currentBars[2]
	end
end

function B.GetVisibleBar()
	return visibleBar
end
