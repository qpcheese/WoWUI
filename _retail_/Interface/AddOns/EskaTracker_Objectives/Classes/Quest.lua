--============================================================================--
--                         EskaTracker : Objectives                           --
-- Author     : Skamer <https://mods.curse.com/members/DevSkamer>             --
-- Website    : https://wow.curseforge.com/projects/eskatracker-objectives    --
--============================================================================--
Eska              "EskaTracker.Classes.Quest"                                 ""
--============================================================================--
namespace "EKT"
--============================================================================--
SHOW_QUEST_LEVEL_OPTION                         = "show-quest-level"
SHOW_QUEST_TAG_ICON_SETTING                     = "show-quest-tag-icon"
COLOR_QUEST_LEVEL_BY_DIFFICULTY_OPTION          = "color-quest-level-by-difficulty"
QUEST_HEADER_LEFT_CLICK_ACTION_OPTION           = "quest-left-click-action"
QUEST_HEADER_MIDDLE_CLICK_ACTION_OPTION         = "quest-middle-click-action"
QUEST_HEADER_RIGHT_CLICK_ACTION_OPTION          = "quest-right-click-action"
QUEST_HEADER_CTRL_LEFT_CLICK_ACTION_OPTION      = "quest-ctrl-left-click-action"
QUEST_HEADER_CTRL_MIDDLE_CLICK_ACTION_OPTION    = "quest-ctrl-middle-click-action"
QUEST_HEADER_CTRL_RIGHT_CLICK_ACTION_OPTION     = "quest-ctrl-right-click-action"
QUEST_HEADER_SHIFT_LEFT_CLICK_ACTION_OPTION     = "quest-shift-left-click-action"
QUEST_HEADER_SHIFT_MIDDLE_CLICK_ACTION_OPTION   = "quest-shift-middle-click-action"
QUEST_HEADER_SHIFT_RIGHT_CLICK_ACTION_OPTION    = "quest-shift-right-click-action"
QUEST_HEADER_ALT_LEFT_CLICK_ACTION_OPTION       = "quest-alt-left-click-action"
QUEST_HEADER_ALT_MIDDLE_CLICK_ACTION_OPTION     = "quest-alt-middle-click-action"
QUEST_HEADER_ALT_RIGHT_CLICK_ACTION_OPTION      = "quest-alt-right-click-action"
--============================================================================--
__Recyclable__()
class "Quest" (function(_ENV)
  EnumQuestTag = _G.Enum.QuestTag

  inherit "Frame" extend "IObjectiveHolder"
  _QuestCache = setmetatable({}, { __mode = "k"})
  ------------------------------------------------------------------------------
  --                              Events                                      --
  ------------------------------------------------------------------------------
  --- Fired when the distance has changed
  event "OnDistanceChanged"
  --- Fired when there is a change on OnMap
  event "IsOnMapChanged"
  --- Fired when the quest state has changed
  event "IsCompletedChanged"
  ------------------------------------------------------------------------------
  --                                Handlers                                  --
  ------------------------------------------------------------------------------
  local function UpdateProps(self, new, old, prop)
    if prop == "name" then
      self:ForceSkin(Theme.SkinFlags.TEXT_TRANSFORM, Theme:GetElementID(self.frame.name))
    elseif prop == "level" then
      self:ForceSkin(nil, Theme:GetElementID(self.frame.level))
    elseif prop == "isTracked" then
      self:ForceSkin()
    elseif prop == "distance" then
      self.OnDistanceChanged(self, new)
    elseif prop == "tag" then
      if new == EnumQuestTag.Raid or new == EnumQuestTag.Dungeon or new == EnumQuestTag.Legendary then
        if not self.tagElementIDsCache then
          self.tagElementIDsCache = {}
        else
          wipe(self.tagElementIDsCache)
        end
      end

      local coords = QUEST_TAG_TCOORDS[new]
      if coords then
        self.frame.tagIcon:SetTexCoord(unpack(coords))
        if Settings:Get(SHOW_QUEST_TAG_ICON_SETTING) then
          self:ShowTagIcon()
        end
      else
        self:HideTagIcon()
      end

      self:Skin()
    end
  end
  ------------------------------------------------------------------------------
  --                                   Methods                                --
  ------------------------------------------------------------------------------
  function GetQuestItem(self)
    if not self.questItem then
      self.questItem = ObjectManager:Get(QuestItem)
      self.questItem:SetParent(self.frame)
    end

    return self.questItem
  end

  function GetQuestRewards(self)
    if not self.questRewards then
      self.questRewards = ObjectManager:Get(Rewards)
      self.questRewards:SetParent(self.frame)

      self.questRewards.OnHeightChanged = function(_, new, old)
        self.height = self.height + (new - old)
      end
    end

    return self.questRewards
  end

  function ShowTagIcon(self)
    self.frame.tagIcon:Show()
    self.frame.name:SetPoint("LEFT", self.frame.tagIcon, "RIGHT")
  end

  function HideTagIcon(self)
    self.frame.tagIcon:Hide()
    self.frame.name:SetPoint("LEFT")
  end

  function ShowLevel(self)
    self.frame.level:Show()
    self.frame.name:SetPoint("RIGHT", self.frame.level, "LEFT")
  end

  function HideLevel(self)
    self.frame.level:Hide()
    self.frame.name:SetPoint("RIGHT")

  end

  __Arguments__ { Number }
  function TagHasCustomBehavior(self, tag)
    if tag == EnumQuestTag.Raid or tag == EnumQuestTag.Dungeon or tag == EnumQuestTag.Legendary then
      return true
    end

    return false
  end

  __Arguments__ { Table }
  function GetTagElementID(self, frame)
    local elementID = Theme:GetElementID(frame)
    if self:TagHasCustomBehavior(self.tag) then
      local tagElementID = self.tagElementIDsCache[frame]
      if not tagElementID then
        if self.tag == EnumQuestTag.Raid then
          tagElementID = elementID:gsub("(quest)", "raid-quest")
        elseif self.tag == EnumQuestTag.Dungeon then
          tagElementID = elementID:gsub("(quest)", "dungeon-quest")
        elseif self.tag == EnumQuestTag.Legendary then
          tagElementID = elementID:gsub("(quest)", "legendary-quest")
        end
        self.tagElementIDsCache[frame] = tagElementID
      end
      return tagElementID
    end
  end

  __Arguments__ { Table, Variable.Optional(String) }
  function NeedSkin(self, frame, target)
    if self:TagHasCustomBehavior(self.tag) then
      if target then
        local elementID = self:GetTagElementID(frame)
        if elementID and elementID == target then
          return true
        end
      end
    end

    return Theme:NeedSkin(frame, target)
  end



  __Arguments__ { Variable.Optional(Theme.SkinFlags, Theme.DefaultSkinFlags), Variable.Optional(String) }
  function OnSkin(self, flags, target)
    super.OnSkin(self, flags, target)

    local state = self:GetCurrentState()

    if self:NeedSkin(self.frame, target) then
      Theme:SkinFrame(self.frame, flags, state, self:GetTagElementID(self.frame), Theme:GetElementID(self.frame))
    end

    if self:NeedSkin(self.frame.header, target) then
      Theme:SkinFrame(self.frame.header, flags, state, self:GetTagElementID(self.frame.header), Theme:GetElementID(self.frame.header))
    end

    if self:NeedSkin(self.frame.name, target) then
      Theme:SkinText(self.frame.name, flags, self.name, state, self:GetTagElementID(self.frame.name), Theme:GetElementID(self.frame.name))
    end

    if self:NeedSkin(self.frame.level, target) then
      if Settings:Get(COLOR_QUEST_LEVEL_BY_DIFFICULTY_OPTION) then
        local color = GetQuestDifficultyColor(self.level)
        self.frame.level:SetTextColor(color.r, color.g, color.b)
        Theme:SkinText(self.frame.level, API:RemoveFlag(flags, Theme.SkinFlags.TEXT_COLOR), self.level, state, self:GetTagElementID(self.frame.level), Theme:GetElementID(self.frame.level))
      else
        Theme:SkinText(self.frame.level, flags, self.level, state, self:GetTagElementID(self.frame.level), Theme:GetElementID(self.frame.level))
      end
    end
  end

  function OnLayout(self, layout)
      local previousFrame

      if self.questItem and not self.questItem:IsShown() then
        self.questItem:Show()
      end

      for index, obj in self.objectives:GetIterator() do
        obj:Hide()
        obj:ClearAllPoints()
        if index == 1 then
          obj:SetPoint("TOP", 0, -21)
          if self.questItem then
            self.questItem:SetPoint("TOPLEFT", self.frame.header, "BOTTOMLEFT", 5, -2)
            obj:SetPoint("LEFT", self.questItem.frame, "RIGHT")
          else
            obj:SetPoint("LEFT")
          end
          obj:SetPoint("RIGHT")
        else
          obj:SetPoint("TOPLEFT", previousFrame, "BOTTOMLEFT")
          obj:SetPoint("RIGHT")
        end
        obj:Show()
        previousFrame = obj.frame
      end

      if self.questRewards then
        if not self.questRewards:IsShown() then
          self.questRewards:Show()
        end
        self.questRewards:SetPoint("TOP", previousFrame, "BOTTOM")
        self.questRewards:SetPoint("LEFT")
        self.questRewards:SetPoint("RIGHT")
      end


      self:CalculateHeight()
  end

  function GetCurrentState(self)
    if self.isTracked then
      return "tracked"
    end
  end

  function CalculateHeight(self)
    local height = self.baseHeight

    local objectivesHeight = self:GetObjectivesHeight()

    if self.questItem then
      local itemHeight = self.questItem.height
      if objectivesHeight > itemHeight + 2 then
        height = height + objectivesHeight
      else
        height = height + itemHeight + 2
      end
    else
      height = height + objectivesHeight
    end

    -- offset
    height = height + 2

    self.height = height
  end

  function OnReset(self)
    super.OnReset(self)

    -- Reset properties
    self.numObjectives  = nil
    self.id             = nil
    self.level          = nil
    self.header         = nil
    self.tag            = nil
    self.distance       = nil
    self.isTask         = nil
    self.isHidden       = nil
    self.isOnMap        = nil
    self.isTracked      = nil
    self.isInArea       = nil
    self.isCompleted    = nil

    -- Reset quest item if exists
    if self.questItem then
      self.questItem:Recycle()
      self.questItem = nil
    end
  end

  function OnRecycle(self)
    super.OnRecycle(self)

    -- Remvoe Event handlers
    self.OnDistanceChanged  = nil
    self.IsOnMapChanged     = nil
    self.IsCompletedChanged = nil
  end


  __Arguments__ { String }
  function IsRegisteredSetting(self, option)
    if option == SHOW_QUEST_LEVEL_OPTION or option == COLOR_QUEST_LEVEL_BY_DIFFICULTY_OPTION or option == SHOW_QUEST_TAG_ICON_SETTING then
      return true
    end

    return super.IsRegisteredSetting(self, option)
  end

  __Arguments__ { String, Variable.Optional(), Variable.Optional() }
  function OnSetting(self, option, new, old)
    if option == SHOW_QUEST_LEVEL_OPTION then
      if new then
        self:ShowLevel()
      else
        self:HideLevel()
      end
    elseif option == COLOR_QUEST_LEVEL_BY_DIFFICULTY_OPTION then
        self:ForceSkin(Theme.SkinFlags.TEXT_COLOR, Theme:GetElementID(self.frame.level))
    elseif option == SHOW_QUEST_TAG_ICON_SETTING then
      if new and QUEST_TAG_TCOORDS[self.tag] then
        self:ShowTagIcon()
      else
        self:HideTagIcon()
      end
    end
  end


  function Init(self)
    local prefix = self:GetClassPrefix()
    local state  = self:GetCurrentState()

    -- Register frames in the theme system
    Theme:RegisterFrame(prefix..".frame", self.frame, "quest.frame")
    Theme:RegisterFrame(prefix..".header", self.frame.header, "quest.header")
    Theme:RegisterText(prefix..".name", self.frame.name, "quest.name")
    Theme:RegisterText(prefix..".level", self.frame.level, "quest.level")

    -- Then skin them
    Theme:SkinFrame(self.frame, nil, state, self:GetTagElementID(self.frame))
    Theme:SkinFrame(self.frame.header, nil, state, self:GetTagElementID(self.frame.header))
    Theme:SkinText(self.frame.name, nil, self.name, state, self:GetTagElementID(self.frame.name))
    Theme:SkinText(self.frame.level, API:RemoveFlag(Theme.DefaultSkinFlags, Theme.SkinFlags.TEXT_COLOR), self.level, state, self:GetTagElementID(self.frame.level))

    -- Load options
    self:LoadSetting(SHOW_QUEST_LEVEL_OPTION)
    self:LoadSetting(COLOR_QUEST_LEVEL_BY_DIFFICULTY_OPTION)
  end

  function PrepareContextMenu(self)
    ContextMenu():ClearAll()
    ContextMenu():AnchorTo(self.frame.header):UpdateAnchorPoint()
    if not QuestUtils_IsQuestWorldQuest(self.id) then
      if C_SuperTrack.GetSuperTrackedQuestID() == self.id then
        ContextMenu():AddAction("stop-super-tracking-quest")
      else
        ContextMenu():AddAction("super-track-quest", self)
      end
    end
    ContextMenu():AddAction("show-quest-details", self)
    ContextMenu():AddAction("link-quest-to-chat", self)

    -- Second separator
    ContextMenu():AddItem(MenuItemSeparator())
    ContextMenu():AddAction("find-group-for-quest", self)

    -- TomTom Support
    if TomTomAddon.IsLoaded() then
      ContextMenu():AddAction("tomtom-addon-add-quest-waypoint", self)
    end

    -- Third separator
    ContextMenu():AddItem(MenuItemSeparator())
    ContextMenu():AddAction("untrack-quest", self)
    ContextMenu():AddAction("abandon-quest", self)

    -- Fourth separator
    -- TODO: Remove later (it's currently used for debug)
    ContextMenu():AddItem(MenuItemSeparator())
    ContextMenu():AddItem("[DEBUG] Info", nil, function() self:Print() end)
    ContextMenu():Finish()
  end

  function Print(self)
    print("------------")
    print("ID:", self.id)
    print("Name:", self.name)
    print("Level:", self.level)
    print("Header:", self.header)
    print("Tag:", self.tag)
    print("Distance:", self.distance)
    print("isBounty:", self.isBounty)
    print("isTask:", self.isTask)
    print("isHidden", self.isHidden)
    print("isOnMap", self.isOnMap)
    print("isInArea", self.isInArea)
    print("isTracked", self.isTracked)
    print("isCompleted", self.isCompleted)
    print("------------")
  end
  ------------------------------------------------------------------------------
  --                            Properties                                    --
  ------------------------------------------------------------------------------
  property "id"         { TYPE = Number, DEFAULT = -1 }
  property "name"       { TYPE = String, HANDLER = UpdateProps, DEFAULT =  "" }
  property "level"      { TYPE = Number, DEFAULT = 0, HANDLER = UpdateProps }
  property "header"     { TYPE = String, DEFAULT = "Misc" }
  property "tag"        { TYPE = Number, DEFAULT = 0, HANDLER = UpdateProps }
  property "tagIcon"    { TYPE = Number, DEFAULT = 0, HANDLER = UpdateProps }
  property "distance"   { TYPE = Number, DEFAULT = -1, HANDLER = UpdateProps }
  property "isBounty"   { TYPE = Boolean, DEFAULT = false }
  property "isTask"     { TYPE = Boolean, DEFAULT = false }
  property "isHidden"   { TYPE = Boolean, DEFAULT = false }
  property "isOnMap"    { TYPE = Boolean, DEFAULT = false, EVENT = "IsOnMapChanged", HANDLER = UpdateProps }
  property "isInArea"   { TYPE = Boolean, DEFAULT = false, HANDLER = UpdateProps }
  property "isTracked"  { TYPE = Boolean, DEFAULT = false }
  property "isCompleted" { TYPE = AnyBool, DEFAULT = false, EVENT = "IsCompletedChanged"}

  __Static__() property "_prefix" { DEFAULT = "quest" }
  ------------------------------------------------------------------------------
  --                            Constructors                                  --
  ------------------------------------------------------------------------------
  function Quest(self)
    super(self, CreateFrame("Frame", nil, nil, "BackdropTemplate"))
    self.frame:SetBackdrop(_Backdrops.Common)
    self.frame:SetBackdropBorderColor(0, 0, 0, 0)

    local headerFrame = CreateFrame("Button", nil, self.frame, "BackdropTemplate")
    headerFrame:SetBackdrop(_Backdrops.Common)
    headerFrame:SetBackdropBorderColor(0, 0, 0, 0)
    headerFrame:SetPoint("TOPRIGHT")
    headerFrame:SetPoint("TOPLEFT")
    headerFrame:SetHeight(21)
    headerFrame:RegisterForClicks("RightButtonUp", "LeftButtonUp", "MiddleButtonUp")
    self.frame.header = headerFrame

    -- Script
    headerFrame:SetScript("OnClick", function(_, button, down)
      local shiftKeyIsDown = IsShiftKeyDown()
      local altKeyIsDown = IsAltKeyDown()
      local ctrlKeyIsDown = IsControlKeyDown()

      if button == "RightButton" then
        local action
        if ctrlKeyIsDown then
          action = Settings:Get(QUEST_HEADER_CTRL_RIGHT_CLICK_ACTION_OPTION)
        elseif altKeyIsDown then
          action = Settings:Get(QUEST_HEADER_ALT_RIGHT_CLICK_ACTION_OPTION)
        elseif shiftKeyIsDown then
          action = Settings:Get(QUEST_HEADER_SHIFT_RIGHT_CLICK_ACTION_OPTION)
        else
          action = Settings:Get(QUEST_HEADER_RIGHT_CLICK_ACTION_OPTION)
        end
        Actions:Exec(action, self)
      elseif button == "LeftButton" then
        local action
        if ctrlKeyIsDown then
          action = Settings:Get(QUEST_HEADER_CTRL_LEFT_CLICK_ACTION_OPTION)
        elseif altKeyIsDown then
          action = Settings:Get(QUEST_HEADER_ALT_LEFT_CLICK_ACTION_OPTION)
        elseif shiftKeyIsDown then
          action = Settings:Get(QUEST_HEADER_SHIFT_LEFT_CLICK_ACTION_OPTION)
        else
          action = Settings:Get(QUEST_HEADER_LEFT_CLICK_ACTION_OPTION)
        end
        Actions:Exec(action, self)
      elseif button == "MiddleButton" then
        local action
        if ctrlKeyIsDown then
          action = Settings:Get(QUEST_HEADER_CTRL_MIDDLE_CLICK_ACTION_OPTION)
        elseif altKeyIsDown then
          action = Settings:Get(QUEST_HEADER_ALT_MIDDLE_CLICK_ACTION_OPTION)
        elseif shiftKeyIsDown then
          action = Settings:Get(QUEST_HEADER_SHIFT_MIDDLE_CLICK_ACTION_OPTION)
        else
          action = Settings:Get(QUEST_HEADER_MIDDLE_CLICK_ACTION_OPTION)
        end
        Actions:Exec(action, self)
      end
    end)

    headerFrame:SetScript("OnEnter", function()
      Theme:SkinFrame(headerFrame, nil, "hover")
      self:OnEnter()
    end)
    headerFrame:SetScript("OnLeave", function()
      Theme:SkinFrame(headerFrame)
      self:OnLeave()
    end)

    local name = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    name:GetFontObject():SetShadowOffset(0.5, 0)
    name:GetFontObject():SetShadowColor(0, 0, 0, 0.4)
    name:SetPoint("LEFT", 10, 0)
    name:SetPoint("RIGHT")
    name:SetPoint("TOP")
    name:SetPoint("BOTTOM")
    self.frame.name = name

    local level = headerFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    level:GetFontObject():SetShadowOffset(0.5, 0)
    level:GetFontObject():SetShadowColor(0, 0, 0, 0.4)
    level:SetPoint("RIGHT", -2)
    self.frame.level = level

    local tagIcon = headerFrame:CreateTexture()
    tagIcon:SetPoint("LEFT")
    tagIcon:SetHeight(16)
    tagIcon:SetWidth(16)
    tagIcon:SetTexture(QUEST_ICONS_FILE)
    tagIcon:Hide()
    self.frame.tagIcon = tagIcon

    self.baseHeight = 21
    self.height = self.baseHeight

    -- Keep it in the cache for later.
    _QuestCache[self] = true
    -- Init things (register, skin elements)
    Init(self)
  end
end)

--------------------------------------------------------------------------------
--                          Scorpio OnLoad                                    --
--------------------------------------------------------------------------------
function OnLoad(self)
  -- Register the options
  Settings:Register(SHOW_QUEST_LEVEL_OPTION, true)
  Settings:Register(COLOR_QUEST_LEVEL_BY_DIFFICULTY_OPTION, true)
  Settings:Register(SHOW_QUEST_TAG_ICON_SETTING, true)
  Settings:Register(QUEST_HEADER_LEFT_CLICK_ACTION_OPTION, "show-quest-details-with-map")
  Settings:Register(QUEST_HEADER_MIDDLE_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_RIGHT_CLICK_ACTION_OPTION, "toggle-context-menu")

  -- Ctrl
  Settings:Register(QUEST_HEADER_CTRL_LEFT_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_CTRL_MIDDLE_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_CTRL_RIGHT_CLICK_ACTION_OPTION, "none")
  -- Shift
  Settings:Register(QUEST_HEADER_SHIFT_LEFT_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_SHIFT_MIDDLE_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_SHIFT_RIGHT_CLICK_ACTION_OPTION, "none")
  -- Alt
  Settings:Register(QUEST_HEADER_ALT_LEFT_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_ALT_MIDDLE_CLICK_ACTION_OPTION, "none")
  Settings:Register(QUEST_HEADER_ALT_RIGHT_CLICK_ACTION_OPTION, "none")
end

--------------------------------------------------------------------------------
--                         Actions
--------------------------------------------------------------------------------
__Action__ "show-quest-details" "Show details"
class "ShowQuestDetailsAction" (function(_ENV)

  __Arguments__ { Number }
  __Static__() function Exec(questID)
      local quest = QuestCache:Get(questID)
      if quest.isAutoComplete and quest:IsComplete() then 
        ShowQuestComplete(questID)
      else 
        QuestLogPopupDetailFrame_Show(quest:GetQuestLogIndex())
      end
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    ShowQuestDetailsAction.Exec(quest.id)
  end
end)

__Action__ "show-quest-details-with-map" "Show details with map"
class "ShowQuestDetailsWithMapAction" (function(_ENV)
  __Arguments__ { Number }
  __Static__() function Exec(questID)
    Utils.Quest.ShowQuestDetailsWithMap(questID)
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    ShowQuestDetailsWithMapAction.Exec(quest.id)
  end
end)


__Action__ "link-quest-to-chat" "Link to chat"
class "LinkQuestToChatAction" (function(_ENV)
  __Arguments__ { Number }
  __Static__() function Exec(questID)
    ChatFrame_OpenChat(GetQuestLink(questID))
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    LinkQuestToChatAction.Exec(quest.id)
  end
end)

__Action__ "untrack-quest" "Untrack"
class "UntrackQuestAction" (function(_ENV)
  __Arguments__ { Number }
  __Static__() function Exec(questID)
    C_QuestLog.RemoveQuestWatch(questID)
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    UntrackQuestAction.Exec(quest.id)
  end

end)

__Action__ "abandon-quest" "Abandon"
class "AbandonQuestAction" (function(_ENV)
  __Arguments__ { Number }
  __Static__() function Exec(questID)
    QuestMapQuestOptions_AbandonQuest(questID)
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    AbandonQuestAction.Exec(quest.id)
  end
end)

__Action__ "stop-super-tracking-quest" "Stop supertracking"
class "StopSuperTrackingQuestAction" (function(_ENV)
  __Static__() function Exec()
    C_SuperTrack.SetSuperTrackedQuestID(0)
    QuestSuperTracking_ChooseClosestQuest()
  end
end)

__Action__ "super-track-quest" "Supertrack quest"
class "SuperTrackQuestAction" (function(_ENV)
  __Arguments__ { Number }
  __Static__() function Exec(questID)
    C_SuperTrack.SetSuperTrackedQuestID(questID)
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    SuperTrackQuestAction.Exec(quest.id)
  end
end)

__Action__ "find-group-for-quest" "Find a group"
class "FindGroupForQuestAction" (function(_ENV)
  __Arguments__{ Number }
  __Static__() function Exec(questID)
    LFGListUtil_FindQuestGroup(questID)
  end

  __Arguments__ { Quest }
  __Static__() function Exec(quest)
    FindGroupForQuestAction.Exec(quest.id)
  end
end)

class "QuestPopupNotification" (function(_ENV)
  inherit "InteractiveNotification"

  stringQuestOffer    = string.format("%s\n|cff0fffff%s|r", L["QUEST_POPUP_QUEST_OFFER"], QUEST_WATCH_POPUP_CLICK_TO_VIEW)
  stringQuestComplete = string.format("%s\n|cff0fffff%s|r", L["QUEST_POPUP_QUEST_COMPLETE"], QUEST_WATCH_POPUP_CLICK_TO_COMPLETE)
  ------------------------------------------------------------------------------
  --                                Handlers                                  --
  ------------------------------------------------------------------------------
  local function UpdateType(self, new, old)
    if new == "OFFER" then
      self.title = QUEST_WATCH_POPUP_QUEST_DISCOVERED
      self.text = stringQuestOffer:format(self.questName)
    elseif new == "COMPLETE" then
      self.title = QUEST_WATCH_POPUP_QUEST_COMPLETE
      self.text  = stringQuestComplete:format(self.questName)
    end
  end

  local function UpdateName(self, new)
    UpdateType(self, self.type)
  end

  local function OnEnterHandler(self)
    self:SetColor(1, 0, 0)
  end

  local function OnLeaveHandler(self)
    self:SetColor(200/255, 0, 0)
  end

  local function OnClickHandler(self)
    if self.type == "OFFER" then
      ShowQuestOffer(self.questID)
      RemoveAutoQuestPopUp(self.questID)
    elseif self.type == "COMPLETE" then
      ShowQuestComplete(self.questID)
      RemoveAutoQuestPopUp(self.questID)
    end
  end
  ------------------------------------------------------------------------------
  --                             Methods                                      --
  ------------------------------------------------------------------------------
  __Arguments__ { Number }
  function SetQuestID(self, questID)
    self.questID = questID
    return self
  end

  __Arguments__ { String }
  function SetQuestName(self, questName)
    self.questName = questName
    return self
  end

  __Arguments__ { String }
  function SetType(self, type)
    self.type = type
    return self
  end
  ------------------------------------------------------------------------------
  --                         Properties                                       --
  ------------------------------------------------------------------------------
  property "questID"   { TYPE = Number }
  property "questName" { TYPE = String, DEFAULT = "", HANDLER = UpdateName }
  property "type"      { TYPE = String, DEFAULT = "OFFER", HANDLER = UpdateType } -- COMPLETE
  ------------------------------------------------------------------------------
  --                            Constructors                                  --
  ------------------------------------------------------------------------------
  function QuestPopupNotification(self)
    super(self)

    self:SetColor(204/255, 0, 0)

    self.frame.title:SetTextColor(1, 216/255, 0)

    UpdateType(self, self.type)

    self.OnEnter = OnEnterHandler
    self.OnLeave = OnLeaveHandler
    self.OnClick = self.OnClick + OnClickHandler
  end
end)
