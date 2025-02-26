---@class WarpDeplete: AceAddon,AceComm-3.0,AceConsole-3.0,AceEvent-3.0,AceTimer-3.0
WarpDeplete = LibStub("AceAddon-3.0"):NewAddon(
  "WarpDeplete",
  "AceComm-3.0",
  "AceConsole-3.0",
  "AceEvent-3.0",
  "AceTimer-3.0"
)

WarpDeplete.isShown = false

WarpDeplete.L = LibStub("AceLocale-3.0"):GetLocale("WarpDeplete", true)
local L = WarpDeplete.L

WarpDeplete.Util = {}
local Util = WarpDeplete.Util

WarpDeplete.LSM = LibStub("LibSharedMedia-3.0")
WarpDeplete.Glow = LibStub("LibCustomGlow-1.0")

WarpDeplete.defaultChallengeState = {
  demoModeActive = false,
  inChallenge = false,
  challengeCompleted = false
}

WarpDeplete.defaultForcesState = {
  pullCount = 0,
  currentCount = 0,
  totalCount = 100,

  pullPercent = 0,
  currentPercent = 0,
  glowActive = false,
  currentPull = {},

  completed = false,
  completedTime = 0,

  hasMDTTotalCount = false,
}

WarpDeplete.defaultTimerState = {
  startTime = nil,
  isBlizzardTimer = false,
  running = false,
  deaths = 0,
  deathDetails = {},

  current = 0,
  remaining = 0,
  limit = 0,
  startOffset = 0,
  limits = {0, 0, 0},

  plusTwo = 0,
  plusThree = 0
}

WarpDeplete.defaultObjectivesState = {}

WarpDeplete.defaultKeyDetailsState = {
  level = 0,
  affixes = {},
  affixIds = {}
}

-- Check if Kaliel's Tracker is loaded, since it creates a
-- background frame for the objective window that will not be
-- hidden if only the objective window itself is hidden.
local KT = LibStub("AceAddon-3.0"):GetAddon("!KalielsTracker", true)

function WarpDeplete:OnInitialize()
  local frames = {}

  frames.root = CreateFrame("Frame", "WarpDepleteFrame", UIParent)
  frames.bars = CreateFrame("Frame", "WarpDepleteBars", frames.root)
  frames.deathsTooltip = CreateFrame("Frame", "WarpDepleteDeathsTooltip", frames.root)

  -- We use an empty frame to which we parent the blizzard objective tracker.
  -- This can then be hidden and not be affected by blizzard unhiding the
  -- objective tracker itself.
  frames.hiddenObjectiveTrackerParent = CreateFrame("frame")
  frames.hiddenObjectiveTrackerParent:Hide()

  self.frames = frames
end

function WarpDeplete:OnEnable()
  self.forcesState = Util.copy(self.defaultForcesState)
  self.timerState = Util.copy(self.defaultTimerState)
  self.challengeState = Util.copy(self.defaultChallengeState)
  self.objectivesState = Util.copy(self.defaultObjectivesState)
  self.keyDetailsState = Util.copy(self.defaultKeyDetailsState)

  self:InitDb()
  self:InitOptions()
  self:InitChatCommands()
  self:InitDisplay()

  self:RegisterGlobalEvents()
  self:RegisterComms()
  self:Hide()

  if not self.db.global.mdtAlertShown and not MDT then
    self.db.global.mdtAlertShown = true
    self:ShowMDTAlert()
  end

  if self.db.global.DEBUG then
    self:EnableDemoMode()
  end
end

function WarpDeplete:ShowMDTAlert()
  Util.showAlert(
    "MDT_NOT_FOUND",
    L["Mythic Dungeon Tools (MDT) is not installed."].."\n\n" ..
    L["WarpDeplete will not display mob counts or count for the current pull."]
    .. " \n\n" .. L["Install MDT to enable this functionality."])
end

function WarpDeplete:OnDisable()
end

function WarpDeplete:UpdateDemoModeForces()
  if not self.challengeState.demoModeActive then return end

  if self.db.profile.showForcesGlow and self.db.profile.demoForcesGlow then
    self:SetForcesPercent(92)
    self:SetForcesPull(8)
  elseif self.db.profile.unclampForcesPercent then
    self:SetForcesPercent(101)
    self:SetForcesPull(3.4)
  else
    self:SetForcesPercent(34)
    self:SetForcesPull(7)
  end
end

function WarpDeplete:EnableDemoMode()
  if self.challengeState.inChallenge then
    self:Print(L["Can't enable demo mode while in an active challenge!"])
    return
  end

  if self.challengeState.demoModeActive then return end

  self:ResetState()
  self.challengeState.demoModeActive = true

  local objectives = {}
  for i = 1, 5 do
    objectives[i] = { name = L["Test Boss Name"] .. " " .. i }

    if i < 4 then
      objectives[i].time = 520 * i
    end
  end

  self:SetObjectives(objectives)
  self:SetKeyDetails(30, {L["Tyrannical"], L["Bolstering"], L["Spiteful"]}, {9, 7, 123, 132})

  self:SetTimerLimit(35 * 60)
  self:SetTimerRemaining(20 * 60)
  self:SetDeaths(3)

  self:UpdateDemoModeForces()

  local classTable = {
    "SHAMAN",
    "DEMONHUNTER",
    "MONK",
    "DRUID",
    "MAGE"
  }

  local nameTable = {
    "GroupMember1",
    "GroupMember2",
    "GroupMember3",
    "GroupMember4",
    "GroupMember5",
  }

  for i = 1, 30 do
    local class = classTable[(i % #classTable) + 1]
    local name = nameTable[(i % #nameTable) + 1]
    local time = i * 7

    self:AddDeathDetails(time, name, class)
  end

  self:Show()
end

function WarpDeplete:DisableDemoMode()
  if not self.challengeState.demoModeActive then return end
  self.challengeState.demoModeActive = false

  self:Hide()
  self:ResetState()
end

function WarpDeplete:ShowBlizzardObjectiveTracker()
  -- As SylingTracker replaces the blizzard objective tracker in hiding
  -- it, we prevent WarpDeplete to reshown the tracker.
  if C_AddOns.IsAddOnLoaded("SylingTracker") then
    return
  end

  -- FIXME(happens): See HideBlizzardObjectiveTracker
  ObjectiveTrackerFrame:SetAlpha(1)

  if ObjectiveTrackerFrame:GetParent() == self.frames.hiddenObjectiveTrackerParent then
    ObjectiveTrackerFrame:SetParent(self.originalObjectiveTrackerParent or UIParent)
  end
end

function WarpDeplete:HideBlizzardObjectiveTracker()
  -- FIXME(happens): The reparenting method seems to not work for some people.
  -- As an additional fallback, we set the alpha to 0.
  ObjectiveTrackerFrame:SetAlpha(0)

  self.originalObjectiveTrackerParent = ObjectiveTrackerFrame:GetParent()
  ObjectiveTrackerFrame:SetParent(self.frames.hiddenObjectiveTrackerParent)
end

function WarpDeplete:ShowExternals()
  if KT ~= nil then
    KT.frame:Show()
  end
end

function WarpDeplete:HideExternals()
  if KT ~= nil then
    KT.frame:Hide()
  end
end

function WarpDeplete:Show()
  self.isShown = true
  self.frames.root:Show()
  self:UpdateLayout()

  self:HideBlizzardObjectiveTracker()
  self:HideExternals()
end

function WarpDeplete:Hide()
  self.isShown = false
  self.frames.root:Hide()

  self:ShowBlizzardObjectiveTracker()
  self:ShowExternals()
end


function WarpDeplete:ResetState()
  self:PrintDebug("Resetting state")

  self.forcesState = Util.copy(self.defaultForcesState)
  self.timerState = Util.copy(self.defaultTimerState)
  self.challengeState = Util.copy(self.defaultChallengeState)
  self.objectivesState = Util.copy(self.defaultObjectivesState)
  self.keyDetailsState = Util.copy(self.defaultKeyDetailsState)
end
