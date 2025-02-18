--- Kaliel's Tracker
--- Copyright (c) 2012-2024, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...
local M = KT:NewModule(addonName.."_Help")
KT.Help = M

local T = LibStub("MSA-Tutorials-1.0")
local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

local db, dbChar
local mediaPath = "Interface\\AddOns\\"..addonName.."\\Media\\"
local helpPath = mediaPath.."Help\\"
local helpName = "help"
local helpNumPages = 12
local supportersName = "supporters"
local supportersNumPages = 1
local cTitle = "|cffffd200"
local cBold = "|cff00ffe3"
local cWarning = "|cffff7f00"
local cWarning2 = "|cffff4200"
local cDots = "|cff808080"
local offs = "\n|T:1:9|t"
local offs2 = "\n|T:1:18|t"
local beta = "|cffff7fff[Beta]|r"
local new = "|cffff7fff[NEW]|r"

local KTF = KT.frame

--------------
-- Internal --
--------------

local function AddonInfo(name)
	local info = "\nAddon "..name
	if C_AddOns.IsAddOnLoaded(name) then
		info = info.." |cff00ff00is installed|r. Support you can enable/disable in Options."
	else
		info = info.." |cffff0000is not installed|r."
	end
	return info
end

local function SetFormatedPatronName(tier, name, realm, note)
	if realm then
		realm = " @"..realm
	else
		realm = ""
	end
	if note then
		note = " ... "..note
	else
		note = ""
	end
	return format("- |cff%s%s|r|cff7f7f7f%s%s|r\n", KT.QUALITY_COLORS[tier], name, realm, note)
end

local function SetFormatedPlayerName(name, realm, note)
	if realm then
		realm = " @"..realm
	else
		realm = ""
	end
	if note then
		note = " ... "..note
	else
		note = ""
	end
	return format("- %s|cff7f7f7f%s%s|r\n", name, realm, note)
end

local function SetupTutorials()
	T.RegisterTutorial(helpName, {
		savedvariable = KT.db.global,
		key = "helpTutorial",
		title = KT.title.." |cffffffff"..KT.version.."|r",
		icon = helpPath.."KT_logo",
		font = "Fonts\\FRIZQT__.TTF",
		width = 552,
		imageWidth = 512,
		imageHeight = 256,
		{	-- 1
			image = helpPath.."help_kaliels-tracker",
			text = cTitle..KT.title.."|r is improved default Blizzard Objective Tracker.\n\n"..
					"Some features:\n"..
					"- Change tracker position\n"..
					"- Expand / Collapse tracker relative to selected position (direction)\n"..
					"- Auto set trackers height by content with max. height limit\n"..
					"- Scrolling when content is greater than max. height\n"..
					"- Remember collapsed tracker after logout/exit game\n\n"..
					"... and many other enhancements (see next pages).",
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		{	-- 2
			image = helpPath.."help_header-buttons",
			imageHeight = 128,
			text = cTitle.."Header buttons|r\n\n"..
					"Minimize button:                                Other buttons:\n"..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:0:14:0:14:209:170:0|t "..cDots.."...|r Expand Tracker                          "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:4:2:32:64:16:30:0:14:209:170:0|t  "..cDots.."...|r Open Quest Log\n"..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:0:14:16:30:209:170:0|t "..cDots.."...|r Collapse Tracker                        "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:4:2:32:64:16:30:16:30:209:170:0|t  "..cDots.."...|r Open Achievements\n"..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:0:14:32:46:209:170:0|t "..cDots.."...|r when is tracker empty               "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:4:2:32:64:16:30:32:46:209:170:0|t  "..cDots.."...|r Open Filters menu\n\n"..
					"Buttons |T"..mediaPath.."UI-KT-HeaderButtons:14:14:0:2:32:64:16:30:0:14:209:170:0|t and "..
					"|T"..mediaPath.."UI-KT-HeaderButtons:14:14:0:2:32:64:16:30:16:30:209:170:0|t you can disable in Options.\n\n"..
					"You can set "..cBold.."[key bind]|r for Minimize button.\n"..
					cBold.."Alt+Click|r on Minimize button opens "..KT.title.." Options.",
			textY = 16,
			shine = KTF.MinimizeButton,
			shineTop = 13,
			shineBottom = -14,
			shineRight = 15,
		},
		{	-- 3
			image = helpPath.."help_quest-title-tags",
			imageHeight = 128,
			text = cTitle.."Quest title tags|r\n\n"..
					"At the start of quest titles you see tags like this |cffff8000[100|r|cff00b3ffhc!|r|cffff8000]|r.\n"..
					"Tags are also in quest titles inside Quest Log.\n\n"..
					"|cff00b3ff!|r|T:14:3|t "..cDots..".......|r Daily quest|T:14:121|t|cff00b3ffr|r "..cDots..".......|r Raid quest\n"..
					"|cff00b3ff!!|r "..cDots.."......|r Weekly quest|T:14:108|t|cff00b3ffr10|r "..cDots.."...|r 10-man raid quest\n"..
					"|cff00b3ffg3|r "..cDots..".....|r Group quest w/ group size|T:14:22|t|cff00b3ffr25|r "..cDots.."...|r 25-man raid quest\n"..
					"|cff00b3ffpvp|r "..cDots.."...|r PvP quest|T:14:133|t|cff00b3ffs|r "..cDots..".......|r Scenario quest\n"..
					"|cff00b3ffd|r "..cDots..".......|r Dungeon quest|T:14:97|t|cff00b3ffa|r "..cDots..".......|r Account quest\n"..
					"|cff00b3ffhc|r "..cDots..".....|r Heroic quest|T:14:113|t|cff00b3ffleg|r "..cDots.."....|r Legendary quest",
			shineTop = 11,
			shineBottom = -9,
			shineLeft = -11,
			shineRight = 13,
		},
		{	-- 4
			image = helpPath.."help_tracker-filters",
			text = cTitle.."Tracker Filters|r\n\n"..
					"For open Filters menu "..cBold.."Click|r on the button |T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:16:30:32:46:209:170:0|t.\n\n"..
					"There are two types of filters:\n"..
					cTitle.."Static filter|r - adds quests/achievements to tracker by criterion (e.g. \"Daily\") and then you can add/remove items by hand.\n"..
					cTitle.."Dynamic filter|r - automatically adding quests/achievements to tracker by criterion (e.g. \"|cff00ff00Auto|r Zone\") "..
					"and continuously changing them. This type doesn't allow add/remove items by hand."..
					"When is some Dynamic filter active, header button is green |T"..mediaPath.."UI-KT-HeaderButtons:14:14:-1:2:32:64:16:30:32:46:0:255:0|t.\n\n"..
					"|cff009bffFavorites|r - Quests or Achievements now you can mark as favorites and then filter according to them.\n\n"..
					"For Achievements can change searched categories, it will affect the outcome of the filter.\n\n"..
					"This menu displays other options affecting the content of the tracker (e.g. options for addon PetTracker).",
			textY = 16,
			shine = KTF.FilterButton,
			shineTop = 9,
			shineBottom = -10,
			shineLeft = -10,
			shineRight = 11,
		},
		{	-- 5
			image = helpPath.."help_quest-item-buttons",
			text = cTitle.."Quest Item buttons|r\n\n"..
					"Buttons are out of the tracker, because Blizzard doesn't allow to work with the action buttons in the default UI.\n\n"..
					"|T"..helpPath.."help_quest-item-buttons_2:32:32:1:0:64:32:0:32:0:32|t "..cDots.."...|r  This tag indicates quest item in quest. The number inside is for\n"..
					"              identification moved quest item button.\n\n"..
					"|T"..helpPath.."help_quest-item-buttons_2:32:32:0:3:64:32:32:64:0:32|t "..cDots.."...|r  Real quest item button is moved out of the tracker to the left/right\n"..
					"              side (by selected anchor point). The number is the same as for the tag.\n\n"..
					cWarning.."Warning:|r\n"..
					"In some situation during combat, actions around the quest item buttons paused and carried it up after a player is out of combat.",
			shineTop = 3,
			shineBottom = -2,
			shineLeft = -4,
			shineRight = 3,
		},
		{	-- 6
			image = helpPath.."help_active-button",
			text = cTitle.."Active Button|r\n\n"..
					"Active Button is for a better use of quest items. Displays quest item button for CLOSEST quest as Extra Action Button (like Draenor zone ability).\n\n"..
					"Features:\n"..
					"- "..cBold.."Auto display|r of Active Button, when you approach the place of performance"..
					offs.."of the quest.\n"..
					"- "..cBold.."Manual display|r of Active Button, when selecting the quest using the POI"..
					offs.."button on the Map or in the Tracker.\n"..
					"- You can set "..cBold.."[key bind]|r to use quest item. Key set up in "..KT.title..
					offs.."Options. Active Button uses the same key bind as the Extra Action Button.\n"..
					"- Button is movable using own mover. See Options > section \"Quest item"..
					offs.."buttons\" > button \"Unlock\".\n\n"..
					cWarning.."Warning:|r\n"..
					"- Active Button works only for tracked quests.\n"..
					"- When tracker is collapsed, Active Button feature is paused.",
			shineTop = 30,
			shineBottom = -30,
			shineLeft = -80,
			shineRight = 80,
		},
		{	-- 7
			image = helpPath.."help_tracker-modules",
			text = cTitle.."Order of Modules|r\n\n"..
					"Allows to change the order of modules inside the tracker. Supports all modules including external (e.g. PetTracker).\n\n\n"..
					cTitle.."Collapsible Modules|r\n\n"..
					"All modules, including external ones, can be collapsed by clicking on the module header.",
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		{	-- 8
			image = helpPath.."help_addon-masque",
			text = cTitle.."Support addon Masque|r\n\n"..
					"Masque adds skinning support for Quest Item buttons. It also affects the Active Button (see prev page).\n"..
					AddonInfo("Masque"),
		},
		{	-- 9
			image = helpPath.."help_addon-pettracker",
			text = cTitle.."Support addon PetTracker|r\n\n"..
					"PetTracker support adjusts display of zone pet tracking inside "..KT.title..". It also fix some visual bugs.\n"..
					AddonInfo("PetTracker"),
		},
		{	-- 10
			image = helpPath.."help_addon-tomtom",
			text = cTitle.."Support addon TomTom|r\n\n"..
					"TomTom support combined Blizzard's POI and TomTom's Arrow.\n\n"..
					"|TInterface\\WorldMap\\UI-QuestPoi-NumberIcons:32:32:-2:0:256:256:128:160:96:128|t+"..
					"|T"..mediaPath.."KT-TomTomTag:32:32:-8:0:32:16:0:16:0:16|t"..cDots.."...|r   Active POI button with TomTom Waypoint.\n"..
					"|TInterface\\WorldMap\\UI-QuestPoi-NumberIcons:32:32:-2:0:256:256:128:160:96:128|t+"..
					"|T"..mediaPath.."KT-TomTomTag:32:32:-8:0:32:16:16:32:0:16|t"..cDots.."...|r   Active POI button without TomTom Waypoint (no data).\n\n"..
					"Features:\n"..
					"- Available for Quests and World Quests, but Quest waypoints are only for"..
					offs.."current zone!|r (TomTom and Blizzard limitations)\n"..
					"- "..cBold.."Click|r on POI button (inside the Tracker or World Map) add waypoint for"..
					offs.."the quest.\n"..
					"- The newly tracked or closest quest automatically gets a waypoint.\n"..
					"- Waypoint of untracked or abandoned quest will be removed.\n"..
					AddonInfo("TomTom"),
			shineTop = 10,
			shineBottom = -10,
			shineLeft = -11,
			shineRight = 11,
		},
		{	-- 11
			text = cTitle.."         Hacks|r\n\n"..
					"All hacks are enabled by default, you can disable them in "..KT.title.." Options (section \"Hacks\").\n\n"..
					cWarning.."Warning:|r Hacks may affect other addons!\n\n"..
					cTitle.."LFG Hack|r\n\n"..
					cBold.."Affects the small Eye buttons|r for finding groups inside the tracker. When the hack is active, "..
					"the buttons work without errors. When hack is inactive, the buttons are not available.\n\n"..
					cWarning2.."Negative impacts:|r\n"..
					"- Inside the dialog for create Premade Group is hidden item \"Goal\".\n"..
					"- Tooltips of items in the list of Premade Groups have a hidden 2nd (green) row"..
					offs.."with \"Goal\".\n"..
					"- Inside the dialog for create Premade Group, no automatically set the \"Title\","..
					offs.."e.g. keystone level for Mythic+.\n\n"..
					cTitle.."World Map Hack|r "..beta.."\n\n"..
					cBold.."Affects World Map|r and removes taint errors. The hack removes call of restricted function "..
					"SetPassThroughButtons. When the hack is inactive World Map display causes errors. It is not possible "..
					"to get rid of these errors, since the tracker has a lot of interaction with the game frames.\n\n"..
					cWarning2.."Negative impacts:|r unknown in WoW 11.0.2",
			textY = -20,
		},
		{	-- 12
			image = helpPath.."help_whats-new_logo",
			imageWidth = 256,
			imageHeight = 128,
			imageTexCoords = { 0, 1, 0, 1 },
			imagePoint = "TOPRIGHT",
			imageX = -8,
			imageY = 1,
			imageAbsolute = true,
			text = "          |T"..helpPath.."help_whats-new_title:32:181:0:0:256:32:0:181:0:32|t\n\n"..
					cTitle.."Version 7.4.1|r\n"..
					"- ADDED (quests) - Option for enable/disable Auto focus closest Quest\n"..
					"- ADDED (worldquests) - Option for show/hide Faction name in tracked World quests\n"..
					"- FIXED - TomTom - waypoint tag is sometimes under POI elements\n"..
					"\n"..
					cTitle.."Version 7.4.0|r\n"..
					"- ADDED (quest) - show the Warband bonus icon on the reward in the tooltip (choices)\n"..
					"- ADDED (quests) - auto/manual focus closest quest (manual - Right Click on Minimize Button)\n"..
					"- ADDED (scenario) - skin other widgets (text)\n"..
					"- CHANGED - TomTom - better waypoint update while moving\n"..
					"- CHANGED - TomTom - better getting coordinates for quests/objectives, additional info text to waypoint arrow\n"..
					"- CHANGED (quests) - improvement of zone filtering (instance quests)\n"..
					"- CHANGED (worldquests) - small visual improvements\n"..
					"- CHANGED (scenario) - Delves - small visual improvements\n"..
					"- CHANGED - World Map Hack [Beta] - minor improvement\n"..
					"- CHANGED (quests) - focus closest quest improvements\n"..
					"- CHANGED - TomTom - better switching between waypoint and Blizzard pin (2)\n"..
					"- CHANGED - TomTom - better switching between waypoint and Blizzard pin\n"..
					"- CHANGED (filter) - minor improvements\n"..
					"- FIXED - TomTom - animation bug on POI with waypoint tag\n"..
					"- FIXED (quests) - Bonus objectives - sometimes the title does not appear in the context menu\n"..
					"- FIXED (scenario) - visual bug on Delves spell icons\n"..
					"- PERFORMANCE (quests) - optimization of sorting code (completed quests at end of list)\n"..
					"- REMOVED (scenario) - skin other widgets (taint problem)\n"..
					"\n"..

					cTitle.."Issue reporting|r\n"..
					"For reporting please use "..cBold.."Tickets|r instead of Comments on CurseForge.\n\n\n\n"..

					cWarning.."Before reporting of error, please deactivate all other addons and make sure the bug is not caused by a collision with another addon.|r",
			textY = -20,
			editbox = {
				{
					text = "https://www.curseforge.com/wow/addons/kaliels-tracker/issues",
					width = 450,
					bottom = 40,
				}
			},
			shine = KTF,
			shineTop = 5,
			shineBottom = -5,
			shineLeft = -6,
			shineRight = 6,
		},
		onShow = function(self, i)
			if dbChar.collapsed then
				KT:MinimizeButton_OnClick()
			end
			if i == 2 then
				if KTF.FilterButton then
					self[i].shineLeft = db.hdrOtherButtons and -74 or -34
				else
					self[i].shineLeft = db.hdrOtherButtons and -54 or -14
				end
			elseif i == 3 then
				local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(1)
				local block = KT_QuestObjectiveTracker:GetExistingBlock(questID)
				if block then
					self[i].shine = block
				end
			elseif i == 5 then
				self[i].shine = KTF.Buttons
			elseif i == 10 then
				local superTrackedQuestID = C_SuperTrack.GetSuperTrackedQuestID() or 0
				for j = 1, C_QuestLog.GetNumQuestWatches() do
					local questID = C_QuestLog.GetQuestIDForQuestWatchIndex(j)
					local block = KT_QuestObjectiveTracker:GetExistingBlock(questID)
					if block and block.poiButton then
						if superTrackedQuestID == 0 or superTrackedQuestID == questID then
							self[i].shine = block.poiButton
							break
						end
					end
				end
			end
		end,
		onHide = function()
			T.TriggerTutorial("supporters", 1)
		end
	})

	T.RegisterTutorial("supporters", {
		savedvariable = KT.db.global,
		key = "supportersTutorial",
		title = KT.title.." |cffffffff"..KT.version.."|r",
		icon = helpPath.."KT_logo",
		font = "Fonts\\FRIZQT__.TTF",
		width = 552,
		imageHeight = 256,
		{	-- 1
			text = cTitle.."         Become a Patron|r\n\n"..
					"If you like "..KT.title..", support me on |cfff34a54Patreon|r.\n\n"..
					"Click on button  |T"..helpPath.."help_patreon:20:154:1:0:256:32:0:156:0:20|t  on CurseForge addon page.\n\n"..
					"After 10 years of working on an addon, I started Patreon. It's created as\na compensation for the amount "..
					"of time that addon development requires.\n\n"..
					"                                    Many thanks to all supporters  |T"..helpPath.."help_patreon:16:16:0:0:256:32:157:173:0:16|t\n\n"..
					cTitle.."Active Patrons|r\n"..
					SetFormatedPatronName("Legendary", "Zayah", "Vek'nilash")..
					SetFormatedPatronName("Epic", "Haekwon", "Elune")..
					SetFormatedPatronName("Epic", "Liothen", "Emerald Dream")..
					SetFormatedPatronName("Rare", "A")..
					SetFormatedPatronName("Uncommon", "Anaara", "Auchindoun")..
					SetFormatedPatronName("Uncommon", "Calvin Jones")..
					SetFormatedPatronName("Uncommon", "Charles Howarth")..
					SetFormatedPatronName("Uncommon", "Flex (drantor)")..
					SetFormatedPatronName("Uncommon", "Illidanclone", "Kazzak")..
					SetFormatedPatronName("Uncommon", "Jeffrey Hofer")..
					SetFormatedPatronName("Uncommon", "Mystekal")..
					SetFormatedPatronName("Uncommon", "Semy", "Ravencrest")..
					SetFormatedPatronName("Uncommon", "Sopleb")..
					SetFormatedPatronName("Common", "Darren Divecha")..
					"\n"..
					cTitle.."Testers|r\n"..
					SetFormatedPlayerName("Asimeria", "Drak'thul")..
					SetFormatedPlayerName("Torresman", "Drak'thul"),
			textY = -20,
		},
	})
end

--------------
-- External --
--------------

function M:OnInitialize()
	_DBG("|cffffff00Init|r - "..self:GetName(), true)
	db = KT.db.profile
	dbChar = KT.db.char
end

function M:OnEnable()
	_DBG("|cff00ff00Enable|r - "..self:GetName(), true)
	SetupTutorials()
	local last = false
	if KT.version ~= KT.db.global.version then
		local data = T.GetTutorial(helpName)
		local index = data.savedvariable[data.key]
		if index then
			last = index < helpNumPages and index or true
			T.ResetTutorial(helpName)
		end
	end
	T.TriggerTutorial(helpName, helpNumPages, last)
end

function M:ShowHelp(index)
	HideUIPanel(SettingsPanel)
	T.ResetTutorial(helpName)
	T.TriggerTutorial(helpName, helpNumPages, index or false)
end

function M:ShowSupporters()
	HideUIPanel(SettingsPanel)
	T.ResetTutorial(supportersName)
	T.TriggerTutorial(supportersName, supportersNumPages)
end