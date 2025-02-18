----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, ns = ...

local addon = LibStub("AceAddon-3.0"):NewAddon(FOLDER_NAME, "AceEvent-3.0")
local AceDB = LibStub("AceDB-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HBD = LibStub('HereBeDragons-2.0')
local L = LibStub("AceLocale-3.0"):GetLocale(FOLDER_NAME)
ns.locale = L

_G.HandyNotes_TravelGuide = addon

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted

local portal_red       = ns.constants.icon.portal_red
local BoatX            = ns.constants.icon.boat_x
local molemachineX     = ns.constants.icon.molemachine_x

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local notavailable      = L["handler_tooltip_not_available"]
--local available       = L["handler_tooltip_available"] -- not in use
local RequiresPlayerLvl = L["handler_tooltip_requires_level"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RequiresRep       = L["handler_tooltip_rep"]
local RequiresToy       = L["handler_tooltip_toy"]
local RetrievindData    = L["handler_tooltip_data"]
local sanctum_feature   = L["handler_tooltip_sanctum_feature"]
local TNRank            = L["handler_tooltip_TNTIER"]

local areaPoisToRemove = {
    -- Alliance
    5846, -- Vol'dun
    5847, -- Nazmir
    5848, -- Zuldazar
    5873, -- Dustwallow Marsh, Boat to Menethil Harbor, Wetlands
    5874, -- Wetlands, Boat to Theramore Isle, Dustwallow Marsh
    5875, -- Wetlands, Boat to Daggercap Bay, Howling Fjord
    5876, -- Howling Fjord, Boat to Menethil Harbor, Wetlands
    5877, -- Borean Tundra, Boat to Stormwind City
    5878, -- Stormwind, Boat to Valiance Keep, Borean Tundra
    5879, -- Stormwind, Boat to Boralus Harbor, Tiragarde Sound
    5880, -- Tiragarde Sound, Boat to Stormwind City
    5892, -- The Jade Forest, Portal to Stormwind City
    6014, -- Stormwind Portal Room
    7340, -- Thaldraszus, Boat to Stormwind
    7335, -- Stormwind, Boat to Dragon Isle

    -- Horde
    5843, -- Drustvar
    5844, -- Tiragarde Sound
    5845, -- Stormsong Valley
    5883, -- Northern Stranglethorn, Zeppelin to Orgrimmar
    5884, -- Orgrimmar, Zeppelin to Grom'gol, Schlingendorntal
    5885, -- Orgrimmar, Zeppelin to Warsong Hold, Borean Tundra
    5886, -- Borean Tundra, Zeppelin to Orgrimmar
    5887, -- Echo Isles, Boat to Dazar'alor, Zuldazar
    5888, -- Zuldazar, Boat to Echo Isles, Durotar
    5890, -- The Jade Forest, Portal to Orgrimmar
    6015, -- Orgrimmar Portal Room
    6138, -- Mechagon
    7339, -- Thaldraszus, Zeppelin to Orgrimmar
    7341, -- Durotar, Zeppelin to the Waking Shores, Dragon Isles

    -- Neutral
    5881, -- The Cape of Stranglethorn, Boat to Ratschet
    5882, -- Northern Barrens, Boat to Booty
    7017, -- Oribos, Portal to Korthia
    7019, -- Oribos, Portal to Zereth Mortis
    7020, -- Zereth Mortis, Portalstone to Oribos
    7944, -- Amirdrassil, Boat to Stormglen
    7945, -- Gilneas, Boat to Belanaar
    7959, -- Dustwallow Marsh, Portal to Dalaran
    7960, -- Dragonblight, Portal to Dalaran
    7961 -- Searing Gorge, Portal to Dalaran
}

----------------------------------------------------------------------------------------------------
---------------------------------------------HookScript---------------------------------------------
----------------------------------------------------------------------------------------------------

-- This will remove specified AreaPois on the WorldMapFrame
local function RemoveAreaPOIs()
    if (not ns.db.remove_AreaPois) then return end

    for pin in WorldMapFrame:EnumeratePinsByTemplate("AreaPOIPinTemplate") do
        for _, poiID in ipairs(areaPoisToRemove) do
            local poi = C_AreaPoiInfo.GetAreaPOIInfo(WorldMapFrame:GetMapID(), pin.areaPoiID)
            if (poi ~= nil and poi.areaPoiID == poiID) then
                WorldMapFrame:RemovePin(pin)
                addon:debugmsg("removed AreaPoi "..poiID.." "..poi.name)
            end
        end
    end
end

do
    -- Hook the RefreshAllData() function of the "AreaPOIPinTemplate" data provider
    for dp in pairs(WorldMapFrame.dataProviders) do
        if (type(dp.GetPinTemplate) == "function") then
            if (dp:GetPinTemplate() == "AreaPOIPinTemplate") then
                hooksecurefunc(dp, "RefreshAllData", RemoveAreaPOIs)
            end
        end
    end
end

----------------------------------------------------------------------------------------------------
----------------------------------------------FUNCTIONS---------------------------------------------
----------------------------------------------------------------------------------------------------

-- returns the controlling faction
local function GetWarfrontState(id)
    -- Battle for Stromgarde 11, Battle for Darkshore 118
    local state = C_ContributionCollector.GetState(id)

    return (state == 1 or state == 2) and "Alliance" or "Horde"
end

-- returns the note for mixed portals
local function SetWarfrontNote()
    local astate = GetWarfrontState(11) -- Battle for Stromgarde
    local dstate = GetWarfrontState(118) -- Battle for Darkshore

    return (astate ~= select(1, UnitFactionGroup("player")) and notavailable or " ").."\n"..(dstate ~= select(1, UnitFactionGroup("player")) and notavailable or " ")
end

-- returns true when all requirements are fulfilled
local function ReqFulfilled(req, ...)
    if (req.quest and not IsQuestCompleted(req.quest))
    or (req.level and (UnitLevel("player") < req.level))
    or (req.sanctumtalent and not C_Garrison.GetTalentInfo(req.sanctumtalent).researched)
    or (req.timetravel and UnitLevel("player") >= 50 and not IsQuestCompleted(req.timetravel.quest) and not req.warfront and not req.timetravel.turn)
    or (req.timetravel and UnitLevel("player") >= 50 and IsQuestCompleted(req.timetravel.quest) and req.warfront and not req.timetravel.turn)
    or (req.timetravel and UnitLevel("player") >= 50 and IsQuestCompleted(req.timetravel.quest) and not req.warfront and req.timetravel.turn)
    or (req.warfront and GetWarfrontState(req.warfront) ~= select(1, UnitFactionGroup("player")))
    or (req.spell and not IsSpellKnown(req.spell))
    or (req.toy and not PlayerHasToy(req.toy))
    then
        return false
    end

    if (req.reputation) then
        local standing = C_Reputation.GetFactionDataByID(req.reputation[1]).currentStanding
        return standing >= req.reputation[2]
    end

    if (req.multiquest) then
        for i, quest in pairs(req.multiquest) do
            if (not IsQuestCompleted(quest)) then return false end
        end
    end

	return true
end

local function RefreshAfter(time)
    C_Timer.After(time, function() addon:Refresh() end)
end

-- workaround to prepare the multilabels with and without notes
-- because the game displays the first line in 14px and
-- the following lines in 13px with a normal for loop.
local function Prepare(label, note, level, quest)
    local t = {}

    for i, name in ipairs(label) do
        local NOTE = ''
        local LEVEL = ''
        local QUEST = ''

        -- set spell name as label
        if (type(name) == "number") then
            name = C_Spell.GetSpellInfo(name).name
        end

        -- add additional notes
        if (note and note[i] and ns.db.show_note) then
            NOTE = " ("..note[i]..")"
        end

        -- add required level information
        if (level and level[i] and UnitLevel("player") < level[i]) then
            LEVEL = "\n    |cFFFF0000"..RequiresPlayerLvl..": "..level[i].."|r"
        end

        -- add required quest information
        if (quest and quest[i] and not IsQuestCompleted(quest[i])) then
            local title = C_QuestLog.GetTitleForQuestID(quest[i])
            if (title ~= nil) then
                QUEST = "\n    |cFFFF0000"..RequiresQuest..": ["..title.."] (ID: "..quest[i]..")|r" -- red
            else
                QUEST = "\n    |cFFFF00FF"..RetrievindData.."|r" -- pink
                RefreshAfter(1) -- Refresh
            end
        end

        -- store everything together
        t[i] = name..NOTE..LEVEL..QUEST
    end

    return table.concat(t, "\n")
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(node)
    local icon_key = node.icon

    if (icon_key and ns.constants.icon[icon_key]) then
        return ns.constants.icon[icon_key]
    end
end

local function GetIconScale(icon)
    if (icon == "portal" or icon == "orderhall" or icon == "portal_mixed" or icon == "petBattlePortal" or icon == "ogreWaygate" or icon == "portal_purple") then
        return ns.db["icon_scale_portal"]
    elseif (icon == "boat" or icon == "aboat") then
        return ns.db["icon_scale_boat"]
    elseif (icon == "zeppelin" or icon == "hzeppelin") then
        return ns.db["icon_scale_zeppelin"]
    end

    return ns.db["icon_scale_"..icon] or ns.db["icon_scale_others"]
end

local function GetIconAlpha(icon)
    if (icon == "portal" or icon == "orderhall" or icon == "portal_mixed" or icon == "petBattlePortal" or icon == "ogreWaygate" or icon == "portal_purple") then
        return ns.db["icon_alpha_portal"]
    elseif (icon == "boat" or icon == "aboat") then
        return ns.db["icon_alpha_boat"]
    elseif (icon == "zeppelin" or icon == "hzeppelin") then
        return ns.db["icon_alpha_zeppelin"]
    end

    return ns.db["icon_alpha_"..icon] or ns.db["icon_alpha_others"]
end

local GetNodeInfo = function(node)
    local icon

    if (node) then
        local label = node.label or node.multilabel and Prepare(node.multilabel) or UNKNOWN
        if (node.requirements and not ReqFulfilled(node.requirements)) then
            icon = ((node.icon == "portal" or node.icon == "orderhall" or node.icon == "portal_mixed" or node.icon == "petBattlePortal" or node.icon == "ogreWaygate" or node.icon == "portal_purple") and portal_red)
            or (node.icon == "boat" and BoatX)
            or (node.icon == "molemachine" and molemachineX)
        else
            icon = SetIcon(node)
        end
        return label, icon, node.icon, node.scale, node.alpha
    end
end

local GetNodeInfoByCoord = function(uMapID, coord)
    return GetNodeInfo(ns.DB.nodes[uMapID] and ns.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, node)
    local nodereq = node.requirements
    if (node) then
        if (node.label) then
            tooltip:AddLine(node.label)
        end
        if (node.note and ns.db.show_note) then
            tooltip:AddLine("("..node.note..")")
        end
        if (node.multilabel and node.icon ~= "portal_mixed") then
            if (nodereq) then
                tooltip:AddLine(Prepare(node.multilabel, node.multinote, nodereq.multilevel, nodereq.multiquest))
            else
                tooltip:AddLine(Prepare(node.multilabel, node.multinote))
            end
        end
        if (node.npc) then
            tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(node.npc))
        end
        if (node.icon == "portal_mixed") then
            tooltip:AddDoubleLine(Prepare(node.multilabel, node.multinote), SetWarfrontNote(), nil,nil,nil,1) -- only the second line is red
        end
        if (nodereq) then
            if (nodereq.warfront and GetWarfrontState(nodereq.warfront) ~= select(1, UnitFactionGroup("player"))) then
                tooltip:AddLine(notavailable, 1) -- red
            end
            if (nodereq.level and UnitLevel("player") < nodereq.level) then
                tooltip:AddLine(RequiresPlayerLvl..": "..nodereq.level, 1) -- red
            end
            if (nodereq.quest and not IsQuestCompleted(nodereq.quest)) then
                if (not nodereq.hideQuestName) then
                    if (C_QuestLog.GetTitleForQuestID(nodereq.quest) ~= nil) then
                        tooltip:AddLine(RequiresQuest..": ["..C_QuestLog.GetTitleForQuestID(nodereq.quest).."] (ID: "..nodereq.quest..")",1,0,0)
                    else
                        tooltip:AddLine(RetrievindData,1,0,1) -- pink
                        RefreshAfter(1) -- Refresh
                    end
                elseif (nodereq.item) then -- OgreWaygate
                    local name = C_Item.GetItemNameByID(nodereq.item[1]) or RetrievindData
                    local quantity = nodereq.item[2]

                    if (name == RetrievindData) then RefreshAfter(1) end

                    tooltip:AddLine(requires..': '..quantity..'x '..name, 1) -- red
                elseif (node.icon == "molemachine") then
                    tooltip:AddLine(L["handler_tooltip_not_discovered"], 1) -- red
                end
            end
            if (nodereq.reputation) then
                local reqValuesForStandings = {0, 36000, 39000, 42000, 45000, 51000, 63000, 84000}
                local faction = C_Reputation.GetFactionDataByID(nodereq.reputation[1])
                if (faction and faction.reaction < nodereq.reputation[2]) then
                    local reqValue = reqValuesForStandings[nodereq.reputation[2]]
                    local value = faction.currentStanding
                    tooltip:AddLine(RequiresRep..": ",1) -- red
                    GameTooltip_ShowProgressBar(GameTooltip, 0, reqValue, value, faction.name..": "..value.." / "..reqValue)
                end
            end
            if (nodereq.timetravel and UnitLevel("player") >= 50) then -- don't show this under level 50
                local spellName = C_Spell.GetSpellInfo(nodereq.timetravel["spell"]).name
                if (spellName) then
                    if (not IsQuestCompleted(nodereq.timetravel["quest"]) and not nodereq.warfront and not nodereq.timetravel["turn"])
                    or (IsQuestCompleted(nodereq.timetravel["quest"]) and nodereq.warfront and not nodereq.timetravel["turn"])
                    or (IsQuestCompleted(nodereq.timetravel["quest"]) and not nodereq.warfront and nodereq.timetravel["turn"]) then
                        tooltip:AddLine(requires..': '..spellName, 1) -- text red / uncompleted
                    end
                end
            end
            if (nodereq.spell) then -- don't show this if the spell is known
                local spellName = C_Spell.GetSpellInfo(nodereq.spell).name
                local isKnown = IsSpellKnown(nodereq.spell)
                if (spellName and not isKnown) then
                    tooltip:AddLine(requires..': '..spellName, 1) -- red
                end
            end
            if (nodereq.toy) then
                local toyName = C_Item.GetItemInfo(nodereq.toy) or RetrievindData
                local isKnown = PlayerHasToy(nodereq.toy)

                if (toyName == RetrievindData) then RefreshAfter(1) end

                if (not isKnown) then
                    tooltip:AddLine(RequiresToy..': '..toyName, 1) -- red
                end
            end
            if (node.covenant and nodereq.sanctumtalent) then
                local TALENT = C_Garrison.GetTalentInfo(nodereq.sanctumtalent)
                if (not TALENT["researched"]) then
                    tooltip:AddLine(requires.." "..sanctum_feature..":", 1) -- red
                    tooltip:AddLine(TALENT["name"], 1, 1, 1) -- white
                    tooltip:AddTexture(TALENT["icon"], {margin={right=2}})
                    tooltip:AddLine("   • "..format(TNRank, TALENT["tier"]+1), 0.6, 0.6, 0.6) -- grey
                end
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, ns.DB.nodes[uMapID] and ns.DB.nodes[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
-------------------------------------------PluginHandler--------------------------------------------
----------------------------------------------------------------------------------------------------

local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if (self:GetCenter() > UIParent:GetCenter()) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    SetTooltipByCoord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
    if (self:GetParent() == WorldMapButton) then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local function hideNode(button, uMapID, coord)
    ns.hidden[uMapID][coord] = true
    addon:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if (C_AddOns.IsAddOnLoaded("TomTom")) then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = GetNodeInfoByCoord(uMapID, coord),
            from = L["handler_context_menu_addon_name"],
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function addBlizzardWaypoint(button, uMapID, coord)
    local x, y = HandyNotes:getXY(coord)
    local parentMapID = C_Map.GetMapInfo(uMapID)["parentMapID"]
    if (not C_Map.CanSetUserWaypointOnMap(uMapID)) then
        local wx, wy = HBD:GetWorldCoordinatesFromZone(x, y, uMapID)
        uMapID = parentMapID
        x, y = HBD:GetZoneCoordinatesFromWorld(wx, wy, parentMapID)
    end

    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(uMapID, x, y))
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end

--------------------------------------------CONTEXT MENU--------------------------------------------

do
    local currentMapID = nil
    local currentCoord = nil
    local function generateMenu(button, level)
        if (not level) then return end
        if (level == 1) then

            -- Create the title of the menu
            UIDropDownMenu_AddButton({
                isTitle = true,
                text = L["handler_context_menu_addon_name"],
                notCheckable = true
            }, level)

            -- TomTom waypoint menu item
            if (C_AddOns.IsAddOnLoaded("TomTom")) then
                UIDropDownMenu_AddButton({
                    text = L["handler_context_menu_add_tomtom"],
                    notCheckable = true,
                    func = addTomTomWaypoint,
                    arg1 = currentMapID,
                    arg2 = currentCoord
                }, level)
            end

            -- Blizzard waypoint menu item
            UIDropDownMenu_AddButton({
                text = L["handler_context_menu_add_map_pin"],
                notCheckable = true,
                func = addBlizzardWaypoint,
                arg1 = currentMapID,
                arg2 = currentCoord
            }, level)

            -- Hide menu item
            UIDropDownMenu_AddButton({
                text         = L["handler_context_menu_hide_node"],
                notCheckable = true,
                func         = hideNode,
                arg1         = currentMapID,
                arg2         = currentCoord
            }, level)

            -- Close menu item
            UIDropDownMenu_AddButton({
                text         = CLOSE,
                func         = closeAllDropdowns,
                notCheckable = true
            }, level)

        end
    end

    local HL_Dropdown = CreateFrame("Frame", FOLDER_NAME.."DropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        local TomTom = select(2, C_AddOns.IsAddOnLoaded('TomTom'))
        local dropdown = ns.db.easy_waypoint_dropdown

        if (down or button ~= "RightButton") then return end

        if (button == "RightButton" and not down and not ns.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (IsControlKeyDown() and ns.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (not TomTom or dropdown == 1) then
            addBlizzardWaypoint(button, uMapID, coord)
        elseif (TomTom and dropdown == 2) then
            addTomTomWaypoint(button, uMapID, coord)
        else
            addBlizzardWaypoint(button, uMapID, coord)
            if (TomTom) then addTomTomWaypoint(button, uMapID, coord) end
        end
    end
end

do
    local currentMapID = nil
    local function iter(t, prestate)
        if (not t) then return nil end
        local state, value = next(t, prestate)
        while state do
            if (value and ns:ShouldShow(state, value, currentMapID)) then
                local _, icon, iconname, scale, alpha = GetNodeInfo(value)
                    scale = (scale or 1) * GetIconScale(iconname)
                    alpha = (alpha or 1) * GetIconAlpha(iconname)
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end

    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, ns.DB.nodes[uMapID], nil
    end

    function ns:ShouldShow(coord, node, currentMapID)
        if (not ns.db.force_nodes) then
            if (ns.hidden[currentMapID] and ns.hidden[currentMapID][coord]) then
                return false
            end
            -- this will check if requirements are fulfilled, when remove_unknown option enabled
            if (node.requirements and ns.db.remove_unknown and not ReqFulfilled(node.requirements)) then
                return false
            end
            -- this will check if any node is for specific class
            if (node.class and node.class ~= select(2, UnitClass("player"))) then
                return false
            end
            -- this will check if any node is for specific faction
            if (node.faction and node.faction ~= select(1, UnitFactionGroup("player"))) then
                return false
            end
            -- this will check if any node is for specific covenant
            if (node.covenant and node.covenant ~= C_Covenants.GetActiveCovenantID()) then
                return false
            end
            if (node.icon == "portal" and not ns.db.show_portal) then return false end
            if (node.icon == "orderhall" and not ns.db.show_orderhall) then return false end
            if (node.icon == "worderhall" and not ns.db.show_orderhall) then return false end
            if (node.requirements and node.requirements.warfront and not ns.db.show_warfront) then return false end
            if (node.icon == "portal_mixed" and not ns.db.show_warfront) then return false end
            if (node.icon == "petBattlePortal" and not ns.db.show_petBattlePortal) then return false end
            if (node.icon == "ogreWaygate" and not ns.db.show_ogreWaygate) then return false end
            if (node.icon == "portal_purple" and not ns.db.show_reflectivePortal) then return false end
            if (node.icon == "flightMaster" and not ns.db.show_orderhall) then return false end
            if (node.icon == "tram" and not ns.db.show_tram) then return false end
            if (node.icon == "boat" and not ns.db.show_boat) then return false end
            if (node.icon == "aboat" and not ns.db.show_aboat) then return false end
            if (node.icon == "zeppelin" and not ns.db.show_zeppelin) then return false end
            if (node.icon == "hzeppelin" and not ns.db.show_hzeppelin) then return false end
            if (node.icon == "animaGateway" and not ns.db.show_animaGateway) then return false end
            if (node.icon == "teleportPlatform" and not ns.db.show_teleportPlatform) then return false end
            if (node.icon == "molemachine" and (not ns.db.show_molemachine or (select(2, UnitRace("player")) ~= "DarkIronDwarf"))) then return false end
        end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function addon:OnInitialize()
    self.db = AceDB:New(FOLDER_NAME.."DB", ns.constants.defaults)

    profile = self.db.profile
    ns.db = profile

    global = self.db.global
    ns.global = global

    ns.hidden = self.db.char.hidden

    if (ns.global.dev) then
        ns.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, ns.config.options)
end

function addon:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};
function events:ZONE_CHANGED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after ZONE_CHANGED")
end

function events:ZONE_CHANGED_INDOORS(...)
    addon:Refresh()

    addon:debugmsg("refreshed after ZONE_CHANGED_INDOORS")
end

function events:QUEST_FINISHED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after QUEST_FINISHED")
end

frame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
    frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end