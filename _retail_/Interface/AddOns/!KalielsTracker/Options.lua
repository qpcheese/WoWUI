--- Kaliel's Tracker
--- Copyright (c) 2012-2024, Marouan Sabbagh <mar.sabbagh@gmail.com>
--- All Rights Reserved.
---
--- This file is part of addon Kaliel's Tracker.

local addonName, KT = ...

local ACD = LibStub("MSA-AceConfigDialog-3.0")
local ACR = LibStub("AceConfigRegistry-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local WidgetLists = AceGUIWidgetLSMlists
local _DBG = function(...) if _DBG then _DBG("KT", ...) end end

-- Lua API
local abs = math.abs
local floor = math.floor
local fmod = math.fmod
local format = string.format
local gsub = string.gsub
local ipairs = ipairs
local pairs = pairs
local round = function(n) return floor(n + 0.5) end
local strlen = string.len
local strsplit = string.split
local strsub = string.sub

local db, dbChar
local mediaPath = "Interface\\AddOns\\"..addonName.."\\Media\\"
local anchors = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT" }
local strata = { "BACKGROUND", "LOW", "MEDIUM", "HIGH" }
local flags = { [""] = "None", ["OUTLINE"] = "Outline", ["OUTLINE, MONOCHROME"] = "Outline Monochrome" }
local textures = { "None", "Default (Blizzard)", "One line", "Two lines" }
local modifiers = { [""] = "None", ["ALT"] = "Alt", ["CTRL"] = "Ctrl", ["ALT-CTRL"] = "Alt + Ctrl" }
local realmZones = { ["EU"] = "Europe", ["NA"] = "North America" }

local cTitle = " "..NORMAL_FONT_COLOR_CODE
local cBold = "|cff00ffe3"
local cWarning = "|cffff7f00"
local cWarning2 = "|cffff4200"
local beta = "|cffff7fff[Beta]|r"
local warning = cWarning.."Warning:|r UI will be re-loaded!"

local KTF = KT.frame
local OTF = KT_ObjectiveTrackerFrame

local overlay
local overlayShown = false

local OverlayFrameUpdate, OverlayFrameHide, GetModulesOptionsTable, MoveModule, SetSharedColor, IsSpecialLocale, UpdateOptions  -- functions

local defaults = {
	profile = {
		anchorPoint = "TOPRIGHT",
		xOffset = -115,
		yOffset = -280,
		width = 305,
		maxHeight = 400,
		frameScrollbar = true,
		frameStrata = "LOW",
		
		bgr = "Solid",
		bgrColor = { r=0, g=0, b=0, a=0.7 },
		border = "None",
		borderColor = KT.TRACKER_DEFAULT_COLOR,
		classBorder = false,
		borderAlpha = 1,
		borderThickness = 16,
		bgrInset = 4,
		progressBar = "Blizzard",

		font = LSM:GetDefault("font"),
		fontSize = 12,
		fontFlag = "",
		fontShadow = 1,
		colorDifficulty = false,
		textWordWrap = false,
		objNumSwitch = false,

		hdrBgr = 2,
		hdrBgrColor = KT.TRACKER_DEFAULT_COLOR,
		hdrBgrColorShare = false,
		hdrTxtColor = KT.TRACKER_DEFAULT_COLOR,
		hdrTxtColorShare = false,
		hdrBtnColor = KT.TRACKER_DEFAULT_COLOR,
		hdrBtnColorShare = false,
		hdrQuestsTitleAppend = true,
		hdrAchievsTitleAppend = true,
		hdrPetTrackerTitleAppend = true,
		hdrTrackerBgrShow = true,
		hdrCollapsedTxt = 2,
		hdrOtherButtons = true,
		keyBindMinimize = "",

		qiBgrBorder = false,
		qiXOffset = -5,
		qiActiveButton = true,
		qiActiveButtonBindingShow = true,

		hideEmptyTracker = false,
		collapseInInstance = false,
		tooltipShow = true,
		tooltipShowRewards = true,
		tooltipShowID = true,
        menuWowheadURL = true,
        menuWowheadURLModifier = "ALT",
        questDefaultActionMap = true,
		questShowTags = true,
		questShowZones = true,
		taskShowFactions = true,
		questAutoFocusClosest = true,

		messageQuest = true,
		messageAchievement = true,
		sink20OutputSink = "UIErrorsFrame",
		sink20Sticky = false,
		soundQuest = true,
		soundQuestComplete = "KT - Default",

		modulesOrder = KT.MODULES,

		addonMasque = false,
		addonPetTracker = false,
		addonTomTom = false,

		hackLFG = true,
		hackWorldMap = true,
	},
	char = {
		collapsed = false,
		quests = {
			num = 0,
			favorites = {},
			cache = {}
		},
		achievements = {
			favorites = {}
		}
	}
}

local options = {
	name = "|T"..mediaPath.."KT_logo:22:22:-1:7|t"..KT.title,
	type = "group",
	get = function(info) return db[info[#info]] end,
	args = {
		general = {
			name = "Options",
			type = "group",
			args = {
				sec0 = {
					name = "Info",
					type = "group",
					inline = true,
					order = 0,
					args = {
						version = {
							name = " |cffffd100Version:|r  "..KT.version,
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 0.11,
						},
						build = {
							name = " |cffffd100Build:|r  Retail",
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 0.12,
						},
						slashCmd = {
							name = cBold.." /kt|r  |cff808080..............|r  Toggle expand/collapse the tracker\n"..
									cBold.." /kt hide|r  |cff808080......|r  Toggle show/hide the tracker\n"..
									cBold.." /kt config|r  |cff808080...|r  Show this config window\n",
							type = "description",
							width = "double",
							order = 0.3,
						},
						news = {
							name = "What's New",
							type = "execute",
							disabled = function()
								return not KT.Help:IsEnabled()
							end,
							func = function()
								KT.Help:ShowHelp(true)
							end,
							order = 0.2,
						},
						help = {
							name = "Help",
							type = "execute",
							disabled = function()
								return not KT.Help:IsEnabled()
							end,
							func = function()
								KT.Help:ShowHelp()
							end,
							order = 0.4,
						},
						supportersSpacer = {
							name = " ",
							type = "description",
							width = "normal",
							order = 0.51,
						},
						supportersLabel = {
							name = "                |cff00ff00Become a Patron",
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 0.52,
						},
						supporters = {
							name = "Supporters",
							type = "execute",
							disabled = function()
								return not KT.Help:IsEnabled()
							end,
							func = function()
								KT.Help:ShowSupporters()
							end,
							order = 0.53,
						},
					},
				},
				sec1 = {
					name = "Position / Size",
					type = "group",
					inline = true,
					order = 1,
					args = {
						anchorPoint = {
							name = "Anchor point",
							desc = "- Default: "..defaults.profile.anchorPoint,
							type = "select",
							values = anchors,
							get = function()
								for k, v in ipairs(anchors) do
									if db.anchorPoint == v then
										return k
									end
								end
							end,
							set = function(_, value)
								db.anchorPoint = anchors[value]
								db.xOffset = 0
								db.yOffset = 0
								UpdateOptions()
								KT:MoveTracker()
								OverlayFrameUpdate()
								OTF:Update()
							end,
							order = 1.1,
						},
						xOffset = {
							name = "X offset",
							desc = "- Default: "..defaults.profile.xOffset.."\n- Step: 1",
							type = "range",
							min = 0,
							max = 0,
							step = 1,
							set = function(_, value)
								db.xOffset = value
								KT:MoveTracker()
							end,
							order = 1.2,
						},
						yOffset = {
							name = "Y offset",
							desc = "- Default: "..defaults.profile.yOffset.."\n- Step: 2",
							type = "range",
							min = 0,
							max = 0,
							step = 2,
							set = function(_, value)
								db.yOffset = value
								UpdateOptions(true)
								KT:MoveTracker()
								KT:SetSize()
								OverlayFrameUpdate()
							end,
							order = 1.3,
						},
						maxHeight = {
							name = "Max. height",
							desc = "- Default: "..defaults.profile.maxHeight.."\n- Step: 2",
							type = "range",
							min = 100,
							max = 100,
							step = 2,
							set = function(_, value)
								db.maxHeight = value
								KT:SetSize()
								OverlayFrameUpdate()
							end,
							order = 1.4,
						},
						maxHeightShowOverlay = {
							name = "Show Max. height overlay",
							desc = "Show overlay, for better visualisation Max. height value.",
							type = "toggle",
							width = 1.3,
							get = function()
								return overlayShown
							end,
							set = function()
								overlayShown = not overlayShown
								if overlayShown and not overlay then
									overlay = CreateFrame("Frame", KTF:GetName().."Overlay", KTF)
									overlay:SetFrameLevel(KTF:GetFrameLevel() + 12)
									overlay:EnableMouse(true)
									overlay.texture = overlay:CreateTexture(nil, "BACKGROUND")
									overlay.texture:SetAllPoints()
									overlay.texture:SetColorTexture(0, 1, 0, 0.3)
									OverlayFrameUpdate()
								end
								overlay:SetShown(overlayShown)
							end,
							order = 1.5,
						},
						maxHeightNote = {
							name = cBold.."\n  Max. height is related with value Y offset.\n"..
								"  Content is lesser ... tracker height is automatically increases.\n"..
								"  Content is greater ... tracker enables scrolling.",
							type = "description",
							order = 1.6,
						},
						frameScrollbar = {
							name = "Show scroll indicator",
							desc = "Show scroll indicator when srolling is enabled. Color is shared with border.",
							type = "toggle",
							set = function()
								db.frameScrollbar = not db.frameScrollbar
								KTF.Bar:SetShown(db.frameScrollbar)
								KT:SetSize()
							end,
							order = 1.7,
						},
						frameStrata = {
							name = "Strata",
							desc = "- Default: "..defaults.profile.frameStrata,
							type = "select",
							values = strata,
							get = function()
								for k, v in ipairs(strata) do
									if db.frameStrata == v then
										return k
									end
								end
							end,
							set = function(_, value)
								db.frameStrata = strata[value]
								KTF:SetFrameStrata(strata[value])
								KTF.Buttons:SetFrameStrata(strata[value])
							end,
							order = 1.8,
						},
					},
				},
				sec2 = {
					name = "Background / Border",
					type = "group",
					inline = true,
					order = 2,
					args = {
						bgr = {
							name = "Background texture",
							type = "select",
							dialogControl = "LSM30_Background",
							values = WidgetLists.background,
							set = function(_, value)
								db.bgr = value
								KT:SetBackground()
							end,
							order = 2.1,
						},
						bgrColor = {
							name = "Background color",
							type = "color",
							hasAlpha = true,
							get = function()
								return db.bgrColor.r, db.bgrColor.g, db.bgrColor.b, db.bgrColor.a
							end,
							set = function(_, r, g, b, a)
								db.bgrColor.r = r
								db.bgrColor.g = g
								db.bgrColor.b = b
								db.bgrColor.a = a
								KT:SetBackground()
							end,
							order = 2.2,
						},
						bgrNote = {
							name = cBold.." For a custom background\n texture set white color.",
							type = "description",
							width = "normal",
							order = 2.21,
						},
						border = {
							name = "Border texture",
							type = "select",
							dialogControl = "LSM30_Border",
							values = WidgetLists.border,
							set = function(_, value)
								db.border = value
								KT:SetBackground()
								KT:MoveButtons()
							end,
							order = 2.3,
						},
						borderColor = {
							name = "Border color",
							type = "color",
							disabled = function()
								return db.classBorder
							end,
							get = function()
								if not db.classBorder then
									SetSharedColor(db.borderColor)
								end
								return db.borderColor.r, db.borderColor.g, db.borderColor.b
							end,
							set = function(_, r, g, b)
								db.borderColor.r = r
								db.borderColor.g = g
								db.borderColor.b = b
								KT:SetBackground()
								KT:SetText()
								SetSharedColor(db.borderColor)
							end,
							order = 2.4,
						},
						classBorder = {
							name = "Border color by |cff%sClass|r",
							type = "toggle",
							get = function(info)
								if db[info[#info]] then
									SetSharedColor(KT.classColor)
								end
								return db[info[#info]]
							end,
							set = function()
								db.classBorder = not db.classBorder
								KT:SetBackground()
								KT:SetText()
							end,
							order = 2.5,
						},
						borderAlpha = {
							name = "Border transparency",
							desc = "- Default: "..defaults.profile.borderAlpha.."\n- Step: 0.05",
							type = "range",
							min = 0.1,
							max = 1,
							step = 0.05,
							set = function(_, value)
								db.borderAlpha = value
								KT:SetBackground()
							end,
							order = 2.6,
						},
						borderThickness = {
							name = "Border thickness",
							desc = "- Default: "..defaults.profile.borderThickness.."\n- Step: 0.5",
							type = "range",
							min = 1,
							max = 24,
							step = 0.5,
							set = function(_, value)
								db.borderThickness = value
								KT:SetBackground()
							end,
							order = 2.7,
						},
						bgrInset = {
							name = "Background inset",
							desc = "- Default: "..defaults.profile.bgrInset.."\n- Step: 0.5",
							type = "range",
							min = 0,
							max = 10,
							step = 0.5,
							set = function(_, value)
								db.bgrInset = value
								KT:SetBackground()
								KT:MoveButtons()
							end,
							order = 2.8,
						},
						progressBar = {
							name = "Progress bar texture",
							type = "select",
							dialogControl = "LSM30_Statusbar",
							values = WidgetLists.statusbar,
							set = function(_, value)
								db.progressBar = value
								KT:Update(true)
								-- TODO: Update
								--[[if PetTracker then
									PetTracker.Objectives:Update()
								end]]
							end,
							order = 2.9,
						},
					},
				},
				sec3 = {
					name = "Texts",
					type = "group",
					inline = true,
					order = 3,
					args = {
						font = {
							name = "Font",
							type = "select",
							dialogControl = "LSM30_Font",
							values = WidgetLists.font,
							set = function(_, value)
								db.font = value
								KT:SetText(true)
								KT:Update()
								-- TODO: Update
								--[[if PetTracker then
									PetTracker.Objectives:Update()
								end]]
							end,
							order = 3.1,
						},
						fontSize = {
							name = "Font size",
							type = "range",
							min = 10,
							max = 20,
							step = 1,
							set = function(_, value)
								db.fontSize = value
								KT:SetText(true)
								KT:Update()
								-- TODO: Update
								--[[if PetTracker then
									PetTracker.Objectives:Update()
								end]]
							end,
							order = 3.2,
						},
						fontFlag = {
							name = "Font flag",
							type = "select",
							values = flags,
							get = function()
								for k, v in pairs(flags) do
									if db.fontFlag == k then
										return k
									end
								end
							end,
							set = function(_, value)
								db.fontFlag = value
								KT:SetText(true)
								KT:Update()
								-- TODO: Update
								--[[if PetTracker then
									PetTracker.Objectives:Update()
								end]]
							end,
							order = 3.3,
						},
						fontShadow = {
							name = "Font shadow",
							desc = warning,
							type = "toggle",
							confirm = true,
							confirmText = warning,
							get = function()
								return (db.fontShadow == 1)
							end,
							set = function(_, value)
								db.fontShadow = value and 1 or 0
								ReloadUI()	-- WTF
							end,
							order = 3.4,
						},
						colorDifficulty = {
							name = "Color by difficulty",
							desc = "Quest titles color by difficulty.",
							type = "toggle",
							set = function()
								db.colorDifficulty = not db.colorDifficulty
								OTF:Update()
								QuestMapFrame_UpdateAll()
							end,
							order = 3.5,
						},
						textWordWrap = {
							name = "Wrap long texts",
							desc = "Long texts shows on two lines or on one line with ellipsis (...).",
							type = "toggle",
							set = function()
								db.textWordWrap = not db.textWordWrap
								KT:Update(true)
							end,
							order = 3.6,
						},
						objNumSwitch = {
							name = "Objective numbers at the beginning",
							desc = "Changing the position of objective numbers at the beginning of the line. "..
								   cBold.."Only for deDE, esES, frFR, ruRU locale.",
							descStyle = "inline",
							type = "toggle",
							width = 2.2,
							disabled = function()
								return not IsSpecialLocale()
							end,
							set = function()
								db.objNumSwitch = not db.objNumSwitch
								OTF:Update()
							end,
							order = 3.7,
						},
					},
				},
				sec4 = {
					name = "Headers",
					type = "group",
					inline = true,
					order = 4,
					args = {
						hdrBgrLabel = {
							name = " Texture",
							type = "description",
							width = "half",
							fontSize = "medium",
							order = 4.01,
						},
						hdrBgr = {
							name = "",
							type = "select",
							values = textures,
							get = function()
								for k, v in ipairs(textures) do
									if db.hdrBgr == k then
										return k
									end
								end
							end,
							set = function(_, value)
								db.hdrBgr = value
								KT:SetBackground()
							end,
							order = 4.011,
						},
						hdrBgrColor = {
							name = "Color",
							desc = "Sets the color to texture of the header.",
							type = "color",
							width = "half",
							disabled = function()
								return (db.hdrBgr < 3 or db.hdrBgrColorShare)
							end,
							get = function()
								return db.hdrBgrColor.r, db.hdrBgrColor.g, db.hdrBgrColor.b
							end,
							set = function(_, r, g, b)
								db.hdrBgrColor.r = r
								db.hdrBgrColor.g = g
								db.hdrBgrColor.b = b
								KT:SetBackground()
							end,
							order = 4.012,
						},
						hdrBgrColorShare = {
							name = "Use border color",
							desc = "The color of texture is shared with the border color.",
							type = "toggle",
							disabled = function()
								return (db.hdrBgr < 3)
							end,
							set = function()
								db.hdrBgrColorShare = not db.hdrBgrColorShare
								KT:SetBackground()
							end,
							order = 4.013,
						},
						hdrTrackerBgrSpacer1 = {
							name = " ",
							type = "description",
							width = "half",
							order = 4.014,
						},
						hdrTrackerBgrShow = {
							name = "Show tracker header texture",
							type = "toggle",
							width = "normal+half",
							disabled = function()
								return (db.hdrBgr == 1)
							end,
							set = function()
								db.hdrTrackerBgrShow = not db.hdrTrackerBgrShow
								KT:SetBackground()
							end,
							order = 4.015,
						},
						hdrTrackerBgrSpacer2 = {
							name = " ",
							type = "description",
							width = "normal",
							order = 4.016,
						},
						hdrTxtLabel = {
							name = " Text",
							type = "description",
							width = "half",
							fontSize = "medium",
							order = 4.02,
						},
						hdrTxtColor = {
							name = "Color",
							desc = "Sets the color to header texts.",
							type = "color",
							width = "half",
							disabled = function()
								KT:SetText()
								return (db.hdrBgr == 2 or db.hdrTxtColorShare)
							end,
							get = function()
								return db.hdrTxtColor.r, db.hdrTxtColor.g, db.hdrTxtColor.b
							end,
							set = function(_, r, g, b)
								db.hdrTxtColor.r = r
								db.hdrTxtColor.g = g
								db.hdrTxtColor.b = b
								KT:SetText()
							end,
							order = 4.021,
						},
						hdrTxtColorShare = {
							name = "Use border color",
							desc = "The color of header texts is shared with the border color.",
							type = "toggle",
							disabled = function()
								return (db.hdrBgr == 2)
							end,
							set = function()
								db.hdrTxtColorShare = not db.hdrTxtColorShare
								KT:SetText()
							end,
							order = 4.022,
						},
						hdrTxtSpacer = {
							name = " ",
							type = "description",
							width = "normal",
							order = 4.023,
						},
						hdrBtnLabel = {
							name = " Buttons",
							type = "description",
							width = "half",
							fontSize = "medium",
							order = 4.03,
						},
						hdrBtnColor = {
							name = "Color",
							desc = "Sets the color to all header buttons.",
							type = "color",
							width = "half",
							disabled = function()
								return (db.hdrBgr == 2 or db.hdrBtnColorShare)
							end,
							get = function()
								return db.hdrBtnColor.r, db.hdrBtnColor.g, db.hdrBtnColor.b
							end,
							set = function(_, r, g, b)
								db.hdrBtnColor.r = r
								db.hdrBtnColor.g = g
								db.hdrBtnColor.b = b
								KT:SetBackground()
							end,
							order = 4.032,
						},
						hdrBtnColorShare = {
							name = "Use border color",
							desc = "The color of all header buttons is shared with the border color.",
							type = "toggle",
							disabled = function()
								return (db.hdrBgr == 2)
							end,
							set = function()
								db.hdrBtnColorShare = not db.hdrBtnColorShare
								KT:SetBackground()
							end,
							order = 4.033,
						},
						hdrBtnSpacer = {
							name = " ",
							type = "description",
							width = "normal",
							order = 4.034,
						},
						sec4SpacerMid1 = {
							name = " ",
							type = "description",
							order = 4.035,
						},
						hdrQuestsTitleAppend = {
							name = "Show number of Quests",
							desc = "Show number of Quests inside the Quests header.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.hdrQuestsTitleAppend = not db.hdrQuestsTitleAppend
								KT:SetQuestsHeaderText(true)
							end,
							order = 4.04,
						},
						hdrAchievsTitleAppend = {
							name = "Show Achievement points",
							desc = "Show Achievement points inside the Achievements header.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.hdrAchievsTitleAppend = not db.hdrAchievsTitleAppend
								KT:SetAchievsHeaderText(true)
							end,
							order = 4.05,
						},
						-- TODO: Update
						--[[hdrPetTrackerTitleAppend = {	-- Addon - PetTracker
							name = "Show number of owned Pets",
							desc = "Show number of owned Pets inside the PetTracker header.",
							type = "toggle",
							width = "normal+half",
							disabled = function()
								return not KT.AddonPetTracker.isLoaded
							end,
							set = function()
								db.hdrPetTrackerTitleAppend = not db.hdrPetTrackerTitleAppend
								KT.AddonPetTracker:SetPetsHeaderText(true)
							end,
							order = 4.06,
						},]]
						sec4SpacerMid2 = {
							name = " ",
							type = "description",
							order = 4.07,
						},
						hdrCollapsedTxtLabel = {
							name = " Collapsed tracker text",
							type = "description",
							width = "normal",
							fontSize = "medium",
							order = 4.09,
						},
						hdrCollapsedTxt1 = {
							name = "None",
							desc = "Reduces the tracker width when minimized.",
							type = "toggle",
							width = "half",
							get = function()
								return (db.hdrCollapsedTxt == 1)
							end,
							set = function()
								db.hdrCollapsedTxt = 1
								OTF:Update()
							end,
							order = 4.091,
						},
						hdrCollapsedTxt2 = {
							name = "|T"..mediaPath.."KT_logo:22:22:2:0|t "..KT.title,
							type = "toggle",
							width = "normal",
							get = function()
								return (db.hdrCollapsedTxt == 2)
							end,
							set = function()
								db.hdrCollapsedTxt = 2
								OTF:Update()
							end,
							order = 4.092,
						},
						hdrOtherButtons = {
							name = "Show Quest Log and Achievements buttons",
							type = "toggle",
							width = "double",
							set = function()
								db.hdrOtherButtons = not db.hdrOtherButtons
								KT:SetOtherButtons()
								KT:SetBackground()
								OTF:Update()
							end,
							order = 4.10,
						},
						keyBindMinimize = {
							name = "Key - Minimize button",
							type = "keybinding",
							set = function(_, value)
								SetOverrideBinding(KTF, false, db.keyBindMinimize, nil)
								if value ~= "" then
									local key = GetBindingKey("EXTRAACTIONBUTTON1")
									if key == value then
										SetBinding(key)
										SaveBindings(GetCurrentBindingSet())
									end
									SetOverrideBindingClick(KTF, false, value, KTF.MinimizeButton:GetName())
								end
								db.keyBindMinimize = value
							end,
							order = 4.11,
						},
					},
				},
				sec5 = {
					name = "Quest item buttons",
					type = "group",
					inline = true,
					order = 5,
					args = {
						qiBgrBorder = {
							name = "Show buttons block background and border",
							type = "toggle",
							width = "double",
							set = function()
								db.qiBgrBorder = not db.qiBgrBorder
								KT:SetBackground()
								KT:MoveButtons()
							end,
							order = 5.1,
						},
						qiXOffset = {
							name = "X offset",
							type = "range",
							min = -10,
							max = 10,
							step = 1,
							set = function(_, value)
								db.qiXOffset = value
								KT:MoveButtons()
							end,
							order = 5.2,
						},
						qiActiveButton = {
							name = "Enable Active button",
							desc = "Show Quest item button for CLOSEST quest as \"Extra Action Button\".\n"..
								   cBold.."Key bind is shared with EXTRAACTIONBUTTON1.",
							descStyle = "inline",
							width = "double",
							type = "toggle",
                            confirm = true,
                            confirmText = warning,
							set = function()
								db.qiActiveButton = not db.qiActiveButton
								if db.qiActiveButton then
									KT.ActiveButton:Enable()
								else
									KT.ActiveButton:Disable()
                                end
                                ReloadUI()
							end,
							order = 5.3,
						},
						keyBindActiveButton = {
							name = "Key - Active button",
							type = "keybinding",
							disabled = function()
								return not db.qiActiveButton
							end,
							get = function()
								local key = GetBindingKey("EXTRAACTIONBUTTON1")
								return key
							end,
							set = function(_, value)
								local key = GetBindingKey("EXTRAACTIONBUTTON1")
								if key then
									SetBinding(key)
								end
								if value ~= "" then
									if db.keyBindMinimize == value then
										SetOverrideBinding(KTF, false, db.keyBindMinimize, nil)
										db.keyBindMinimize = ""
									end
									SetBinding(value, "EXTRAACTIONBUTTON1")
								end
								SaveBindings(GetCurrentBindingSet())
							end,
							order = 5.4,
						},
						qiActiveButtonBindingShow = {
							name = "Show Active button Binding text",
							width = "normal+half",
							type = "toggle",
							disabled = function()
								return not db.qiActiveButton
							end,
							set = function()
								db.qiActiveButtonBindingShow = not db.qiActiveButtonBindingShow
								KTF.ActiveFrame:Hide()
								KT.ActiveButton:Update()
							end,
							order = 5.5,
						},
						qiActiveButtonSpacer = {
							name = " ",
							type = "description",
							width = "half",
							order = 5.51,
						},
						qiActiveButtonUnlock = {
							name = UNLOCK,
							type = "execute",
							disabled = function()
								return not db.qiActiveButton
							end,
							func = function()
								HideUIPanel(SettingsPanel)
								KTF.ActiveFrame.overlay:Show()
								StaticPopup_Show(addonName.."_LockUI", nil, "Addon UI elements unlocked.\nMove them and click Lock when you are done.\n\n"..cBold.."Right Click|r on mover restore the default position.")
							end,
							order = 5.6,
						},
						addonMasqueLabel = {
							name = " Skin options - for Quest item buttons or Active button",
							type = "description",
							width = "double",
							fontSize = "medium",
							order = 5.7,
						},
						addonMasqueOptions = {
							name = "Masque",
							type = "execute",
							disabled = function()
								return (not C_AddOns.IsAddOnLoaded("Masque") or not db.addonMasque or not KT.AddonOthers:IsEnabled())
							end,
							func = function()
								SlashCmdList["MASQUE"]()
							end,
							order = 5.71,
						},
					},
				},
				sec6 = {
					name = "Other options",
					type = "group",
					inline = true,
					order = 6,
					args = {
						trackerTitle = {
							name = cTitle.."Tracker",
							type = "description",
							fontSize = "medium",
							order = 6.1,
						},
						hideEmptyTracker = {
							name = "Hide empty tracker",
							type = "toggle",
							set = function()
								db.hideEmptyTracker = not db.hideEmptyTracker
								OTF:Update()
							end,
							order = 6.11,
						},
						collapseInInstance = {
							name = "Collapse in instance",
							desc = "Collapses the tracker when entering an instance. Note: Enabled Auto filtering can expand the tracker.",
							type = "toggle",
							set = function()
								db.collapseInInstance = not db.collapseInInstance
							end,
							order = 6.12,
						},
						tooltipTitle = {
							name = "\n"..cTitle.."Tooltips",
							type = "description",
							fontSize = "medium",
							order = 6.2,
						},
						tooltipShow = {
							name = "Show tooltips",
							desc = "Show Quest / World Quest / Achievement / Scenario tooltips.",
							type = "toggle",
							set = function()
								db.tooltipShow = not db.tooltipShow
							end,
							order = 6.21,
						},
						tooltipShowRewards = {
							name = "Show Rewards",
							desc = "Show Quest Rewards inside tooltips - Artifact Power, Order Resources, Money, Equipment etc.",
							type = "toggle",
							disabled = function()
								return not db.tooltipShow
							end,
							set = function()
								db.tooltipShowRewards = not db.tooltipShowRewards
							end,
							order = 6.22,
						},
						tooltipShowID = {
							name = "Show ID",
							desc = "Show Quest / World Quest / Achievement ID inside tooltips.",
							type = "toggle",
							disabled = function()
								return not db.tooltipShow
							end,
							set = function()
								db.tooltipShowID = not db.tooltipShowID
							end,
							order = 6.23,
						},
						menuTitle = {
							name = "\n"..cTitle.."Menu items",
							type = "description",
							fontSize = "medium",
							order = 6.3,
						},
                        menuWowheadURL = {
							name = "Wowhead URL",
							desc = "Show Wowhead URL menu item inside the tracker and Quest Log.",
							type = "toggle",
							set = function()
								db.menuWowheadURL = not db.menuWowheadURL
							end,
							order = 6.31,
						},
                        menuWowheadURLModifier = {
							name = "Wowhead URL click modifier",
							type = "select",
							values = modifiers,
							get = function()
								for k, v in pairs(modifiers) do
									if db.menuWowheadURLModifier == k then
										return k
									end
								end
							end,
							set = function(_, value)
								db.menuWowheadURLModifier = value
							end,
							order = 6.32,
						},
                        questTitle = {
                            name = cTitle.."\n Quests",
                            type = "description",
                            fontSize = "medium",
                            order = 6.4,
                        },
                        questDefaultActionMap = {
                            name = "Quest default action - World Map",
                            desc = "Set the Quest default action as \"World Map\". Otherwise is the default action \"Quest Details\".",
                            type = "toggle",
                            width = "normal+half",
                            set = function()
                                db.questDefaultActionMap = not db.questDefaultActionMap
                            end,
                            order = 6.41,
                        },
						questShowTags = {
							name = "Show Quest tags",
							desc = "Show / Hide Quest tags (quest level, quest type) inside the tracker.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.questShowTags = not db.questShowTags
								OTF:Update()
							end,
							order = 6.42,
						},
						questShowZones = {
							name = "Show Quest Zones",
							desc = "Show / Hide Quest Zones inside the tracker.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.questShowZones = not db.questShowZones
								OTF:Update()
							end,
							order = 6.43,
						},
						taskShowFactions = {
							name = "Show World Quest Factions",
							desc = "Show / Hide World Quest Factions inside the tracker.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.taskShowFactions = not db.taskShowFactions
								OTF:Update()
							end,
							order = 6.44,
						},
						questAutoTrack = {
							name = "Auto Quest tracking",
							desc = "Quests are automatically watched when accepted. Uses Blizzard's value \"autoQuestWatch\".\n"..warning,
							type = "toggle",
							width = "normal+half",
							confirm = true,
							confirmText = warning,
							get = function()
								return GetCVarBool("autoQuestWatch")
							end,
							set = function(_, value)
								SetCVar("autoQuestWatch", value)
								ReloadUI()
							end,
							order = 6.45,
						},
						questProgressAutoTrack = {
							name = "Auto Quest progress tracking",
							desc = "Quests are automatically watched when progress updated. Uses Blizzard's value \"autoQuestProgress\".\n"..warning,
							type = "toggle",
							width = "normal+half",
							confirm = true,
							confirmText = warning,
							get = function()
								return GetCVarBool("autoQuestProgress")
							end,
							set = function(_, value)
								SetCVar("autoQuestProgress", value)
								ReloadUI()
							end,
							order = 6.46,
						},
						questAutoFocusClosest = {
							name = "Auto focus closest Quest                            ",  -- space for a wider tooltip
							desc = "Closest Quest is automatically focussed in specific situations:\n"..
									"- Quest was turned in and was focused,\n"..
									"- Quest was abandoned and was focused,\n"..
									"- Quest was untracked and was focused,\n"..
									"- World Quest was untracked and was focus,\n"..
									"- you manually or automatically select a Zone Filter and nothing is focused.",
							type = "toggle",
							width = "normal+half",
							set = function()
								db.questAutoFocusClosest = not db.questAutoFocusClosest
							end,
							order = 6.47,
						},
					},
				},
				sec7 = {
					name = "Notification messages",
					type = "group",
					inline = true,
					order = 7,
					args = {
						messageQuest = {
							name = "Quest messages",
							type = "toggle",
							set = function()
								db.messageQuest = not db.messageQuest
							end,
							order = 7.1,
						},
						messageAchievement = {
							name = "Achievement messages",
							width = 1.1,
							type = "toggle",
							set = function()
								db.messageAchievement = not db.messageAchievement
							end,
							order = 7.2,
						},
						-- LibSink
					},
				},
				sec8 = {
					name = "Notification sounds",
					type = "group",
					inline = true,
					order = 8,
					args = {
						soundQuest = {
							name = "Quest sounds",
							type = "toggle",
							set = function()
								db.soundQuest = not db.soundQuest
							end,
							order = 8.1,
						},
						soundQuestComplete = {
							name = "Complete Sound",
							desc = "Addon sounds are prefixed \"KT - \".",
							type = "select",
							width = 1.2,
							disabled = function()
								return not db.soundQuest
							end,
							dialogControl = "LSM30_Sound",
							values = WidgetLists.sound,
							set = function(_, value)
								db.soundQuestComplete = value
							end,
							order = 8.11,
						},
					},
				},
			},
		},
		modules = {
			name = "Modules",
			type = "group",
			args = {
				sec1 = {
					name = "Order of Modules",
					type = "group",
					inline = true,
					order = 1,
				},
			},
		},
		addons = {
			name = "Supported addons",
			type = "group",
			args = {
				desc = {
					name = "|cff00d200Green|r - compatible version - this version was tested and support is inserted.\n"..
							"|cffff0000Red|r - incompatible version - this version wasn't tested, maybe will need some code changes.\n"..
							"Please report all problems.",
					type = "description",
					order = 0,
				},
				sec1 = {
					name = "Addons",
					type = "group",
					inline = true,
					order = 1,
					args = {
						addonMasque = {
							name = "Masque",
							desc = "Version: %s",
							descStyle = "inline",
							type = "toggle",
							width = 1.05,
							confirm = true,
							confirmText = warning,
							disabled = function()
								return (not C_AddOns.IsAddOnLoaded("Masque") or not KT.AddonOthers:IsEnabled())
							end,
							set = function()
								db.addonMasque = not db.addonMasque
								ReloadUI()
							end,
							order = 1.11,
						},
						addonMasqueDesc = {
							name = "Masque adds skinning support for Quest Item buttons.\nIt also affects the Active Button.",
							type = "description",
							width = "double",
							order = 1.12,
						},
						addonPetTracker = {
							name = "PetTracker",
							desc = "Version: %s",
							descStyle = "inline",
							type = "toggle",
							width = 1.05,
							confirm = true,
							confirmText = warning,
							disabled = function()
								-- TODO: Update
								return true
							end,
							set = function()
								-- TODO: Update
								db.addonPetTracker = false
								ReloadUI()
							end,
							order = 1.21,
						},
						addonPetTrackerDesc = {
							name = "PetTracker support adjusts display of zone pet tracking inside "..KT.title..". It also fix some visual bugs.",
							type = "description",
							width = "double",
							order = 1.22,
						},
						addonTomTom = {
							name = "TomTom",
							desc = "Version: %s",
							descStyle = "inline",
							type = "toggle",
							width = 1.05,
							confirm = true,
							confirmText = warning,
							disabled = function()
								return not C_AddOns.IsAddOnLoaded("TomTom")
							end,
							set = function()
								db.addonTomTom = not db.addonTomTom
								ReloadUI()
							end,
							order = 1.31,
						},
						addonTomTomDesc = {
							name = "TomTom support combined Blizzard's POI and TomTom's Arrow.",
							type = "description",
							width = "double",
							order = 1.32,
						},
					},
				},
				sec2 = {
					name = "User Interfaces",
					type = "group",
					inline = true,
					order = 2,
					args = {
						elvui = {
							name = "ElvUI",
							type = "toggle",
							disabled = true,
							order = 2.1,
						},
						tukui = {
							name = "Tukui",
							type = "toggle",
							disabled = true,
							order = 2.2,
						},
						nibrealui = {
							name = "RealUI",
							type = "toggle",
							disabled = true,
							order = 2.3,
						},
					},
				},
			},
		},
		hacks = {
			name = "Hacks",
			type = "group",
			args = {
				desc = {
					name = cWarning.."Warning:|r Hacks may affect other addons!\n\nPlease report any negative impacts that are not described.",
					type = "description",
					order = 0,
				},
				sec1 = {
					name = DUNGEONS_BUTTON,
					type = "group",
					inline = true,
					order = 1,
					args = {
						hackLFG = {
							name = "LFG Hack",
							desc = cBold.."Affects the small Eye buttons|r for finding groups inside the tracker. When the hack is active, "..
									"the buttons work without errors. When hack is inactive, the buttons are not available.\n\n"..
									cWarning2.."Negative impacts:|r\n"..
									"- Inside the dialog for create Premade Group is hidden item \"Goal\".\n"..
									"- Tooltips of items in the list of Premade Groups have a hidden 2nd (green) row with \"Goal\".\n"..
									"- Inside the dialog for create Premade Group, no automatically set the \"Title\",\n"..
									"  e.g. keystone level for Mythic+.\n",
							descStyle = "inline",
							type = "toggle",
							width = "full",
							confirm = true,
							confirmText = warning,
							set = function()
								db.hackLFG = not db.hackLFG
								ReloadUI()
							end,
							order = 1.1,
						},
					},
				},
				sec2 = {
					name = WORLDMAP_BUTTON,
					type = "group",
					inline = true,
					order = 2,
					args = {
						hackWorldMap = {
							name = "World Map Hack "..beta,
							desc = cBold.."Affects World Map|r and removes taint errors. The hack removes call of restricted "..
									"function SetPassThroughButtons. When the hack is inactive World Map display causes errors. "..
									"It is not possible to get rid of these errors, since the tracker has a lot of interaction "..
									"with the game frames.\n\n"..
									cWarning2.."Negative impacts:|r unknown in WoW 11.0.2\n",
							descStyle = "inline",
							type = "toggle",
							width = "full",
							confirm = true,
							confirmText = warning,
							set = function()
								db.hackWorldMap = not db.hackWorldMap
								ReloadUI()
							end,
							order = 2.1,
						},
					},
				},
			},
		},
	},
}

local general = options.args.general.args
local modules = options.args.modules.args
local addons = options.args.addons.args
local hacks = options.args.hacks.args

function KT:CheckAddOn(addon, version, isUI)
	local name = strsplit("_", addon)
	local ver = isUI and "" or "---"
	local result = false
	local path
	if C_AddOns.IsAddOnLoaded(addon) then
		local actualVersion = C_AddOns.GetAddOnMetadata(addon, "Version") or "unknown"
		actualVersion = gsub(actualVersion, "(.*%S)%s+", "%1")
		ver = isUI and "  -  " or ""
		ver = (ver.."|cff%s"..actualVersion.."|r"):format(actualVersion == version and "00d200" or "ff0000")
		result = true
	end
	if not isUI then
		path =  addons.sec1.args["addon"..name]
		path.desc = path.desc:format(ver)
	else
		local path =  addons.sec2.args[strlower(name)]
		path.name = path.name..ver
		path.disabled = not result
		path.get = function() return result end
	end
	return result
end

function KT:OpenOptions()
	if not EditModeManagerFrame:IsEditModeActive() then
		Settings.OpenToCategory(self.optionsFrame.general.name, true)
	end
end

function KT:InitProfile(event, database, profile)
	ReloadUI()
end

function KT:SetupOptions()
	self.db = LibStub("AceDB-3.0"):New(strsub(addonName, 2).."DB", defaults, true)
	self.options = options
	db = self.db.profile
	dbChar = self.db.char

	general.sec2.args.classBorder.name = general.sec2.args.classBorder.name:format(self.RgbToHex(self.classColor))

	general.sec7.args.messageOutput = self:GetSinkAce3OptionsDataTable()
	general.sec7.args.messageOutput.inline = true
	general.sec7.args.messageOutput.disabled = function() return not (db.messageQuest or db.messageAchievement) end
	self:SetSinkStorage(db)

	options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profiles.confirm = true
	options.args.profiles.args.reset.confirmText = warning
	options.args.profiles.args.new.confirmText = warning
	options.args.profiles.args.choose.confirmText = warning
	options.args.profiles.args.copyfrom.confirmText = warning
	if not options.args.profiles.plugins then
		options.args.profiles.plugins = {}
	end
	options.args.profiles.plugins[addonName] = {
		clearTrackerDataDesc1 = {
			name = "Clear the data (no settings) of the tracked content (Quests, Achievements etc.) for current character.",
			type = "description",
			order = 0.1,
		},
		clearTrackerData = {
			name = "Clear Tracker Data",
			desc = "Clear the data of the tracked content.",
			type = "execute",
			confirmText = "Clear Tracker Data - "..cBold..self.playerName,
			func = function()
				dbChar.quests.cache = {}
				for i = 1, #db.filterAuto do
					db.filterAuto[i] = nil
				end
				self:SetBackground()
				KT.QuestsCache_Init()
				OTF:Update()
			end,
			order = 0.2,
		},
		clearTrackerDataDesc2 = {
			name = "Current Character: "..cBold..self.playerName,
			type = "description",
			width = "double",
			order = 0.3,
		},
		clearTrackerDataDesc4 = {
			name = "",
			type = "description",
			order = 0.4,
		}
	}

	ACR:RegisterOptionsTable(addonName, options, nil)
	
	self.optionsFrame = {}
	self.optionsFrame.general = ACD:AddToBlizOptions(addonName, self.title, nil, "general")
	self.optionsFrame.modules = ACD:AddToBlizOptions(addonName, options.args.modules.name, self.title, "modules")
	self.optionsFrame.addons = ACD:AddToBlizOptions(addonName, options.args.addons.name, self.title, "addons")
	self.optionsFrame.hacks = ACD:AddToBlizOptions(addonName, options.args.hacks.name, self.title, "hacks")
	self.optionsFrame.profiles = ACD:AddToBlizOptions(addonName, options.args.profiles.name, self.title, "profiles")

	self.db.RegisterCallback(self, "OnProfileChanged", "InitProfile")
	self.db.RegisterCallback(self, "OnProfileCopied", "InitProfile")
	self.db.RegisterCallback(self, "OnProfileReset", "InitProfile")

	-- Disable some options
	if not IsSpecialLocale() then
		db.objNumSwitch = false
	end
end

SettingsPanel:HookScript("OnHide", function(self)
	OverlayFrameHide()
end)

function OverlayFrameUpdate()
	if overlay then
		overlay:SetSize(db.width, db.maxHeight)
		overlay:ClearAllPoints()
		overlay:SetPoint(db.anchorPoint, 0, 0)
	end
end

function OverlayFrameHide()
	if overlayShown then
		overlay:Hide()
		overlayShown = false
	end
end

function GetModulesOptionsTable()
	local numModules = #db.modulesOrder
	local text
	local defaultModule, defaultText
	local numSkipped = 0
	local args = {
		descCurOrder = {
			name = cTitle.."Current Order",
			type = "description",
			width = "double",
			fontSize = "medium",
			order = 0.1,
		},
		descDefOrder = {
			name = "|T:1:20|t"..cTitle.."Default Order",
			type = "description",
			width = "normal",
			fontSize = "medium",
			order = 0.2,
		},
		descModules = {
			name = "\n * "..TRACKER_HEADER_DUNGEON.." / "..CHALLENGE_MODE.." / "..TRACKER_HEADER_SCENARIO.." / "..TRACKER_HEADER_PROVINGGROUNDS.."\n",
			type = "description",
			order = 20,
		},
	}

	for i, module in ipairs(db.modulesOrder) do
		if _G[module].Header then
			text = _G[module].Header.Text:GetText()
			if module == "KT_ScenarioObjectiveTracker" then
				text = text.." *"
			elseif module == "KT_UIWidgetObjectiveTracker" then
				text = "[ "..ZONE.." ]"
			end

			defaultModule = numSkipped == 0 and _G[KT.MODULES[i]] or _G[KT.MODULES[i - numSkipped]]
			defaultText = defaultModule.Header.Text:GetText()
			if defaultModule == KT_ScenarioObjectiveTracker then
				defaultText = defaultText.." *"
			elseif defaultModule == KT_UIWidgetObjectiveTracker then
				defaultText = "[ "..ZONE.." ]"
			end

			args["pos"..i] = {
				name = " "..text,
				type = "description",
				width = "normal",
				fontSize = "medium",
				order = i,
			}
			args["pos"..i.."up"] = {
				name = (i > 1) and "Up" or " ",
				desc = text,
				type = (i > 1) and "execute" or "description",
				width = "half",
				func = function()
					MoveModule(i, "up")
				end,
				order = i + 0.1,
			}
			args["pos"..i.."down"] = {
				name = (i < numModules) and "Down" or " ",
				desc = text,
				type = (i < numModules) and "execute" or "description",
				width = "half",
				func = function()
					MoveModule(i)
				end,
				order = i + 0.2,
			}
			args["pos"..i.."default"] = {
				name = "|T:1:24|t|cff808080"..defaultText,
				type = "description",
				width = "normal",
				fontSize = "medium",
				order = i + 0.3,
			}
		else
			numSkipped = numSkipped + 1
		end
	end
	return args
end

function MoveModule(idx, direction)
	local text = strsub(modules.sec1.args["pos"..idx].name, 2)
	local tmpIdx = (direction == "up") and idx-1 or idx+1
	local tmpText = strsub(modules.sec1.args["pos"..tmpIdx].name, 2)
	modules.sec1.args["pos"..tmpIdx].name = " "..text
	modules.sec1.args["pos"..tmpIdx.."up"].desc = text
	modules.sec1.args["pos"..tmpIdx.."down"].desc = text
	modules.sec1.args["pos"..idx].name = " "..tmpText
	modules.sec1.args["pos"..idx.."up"].desc = tmpText
	modules.sec1.args["pos"..idx.."down"].desc = tmpText

	local module = tremove(db.modulesOrder, idx)
	tinsert(db.modulesOrder, tmpIdx, module)

	OTF.modules[tmpIdx].uiOrder = idx
	OTF.modules[idx].uiOrder = tmpIdx
	OTF.needsSorting = true
	OTF:Update()
end

function SetSharedColor(color)
	local name = "Use border |cff"..KT.RgbToHex(color).."color|r"
	local sec4 = general.sec4.args
	sec4.hdrBgrColorShare.name = name
	sec4.hdrTxtColorShare.name = name
	sec4.hdrBtnColorShare.name = name
end

function IsSpecialLocale()
	return (KT.locale == "deDE" or
			KT.locale == "esES" or
			KT.locale == "frFR" or
			KT.locale == "ruRU")
end

function UpdateOptions(updateValues)
	local options = options.args.general.args.sec1.args
	local screenWidth = round(GetScreenWidth())
	local screenHeight = round(GetScreenHeight())
	local xOffsetMax = screenWidth - db.width
	local yOffsetMax = screenHeight - options.maxHeight.min
	local anchorLeft = (db.anchorPoint == "TOPLEFT" or db.anchorPoint == "BOTTOMLEFT")
	local directionUp = (db.anchorPoint == "BOTTOMLEFT" or db.anchorPoint == "BOTTOMRIGHT")

	if anchorLeft then
		options.xOffset.min = 0
		options.xOffset.max = xOffsetMax
	else
		options.xOffset.min = xOffsetMax * -1
		options.xOffset.max = 0
	end

	if directionUp then
		options.yOffset.min = 0
		options.yOffset.max = yOffsetMax
	else
		options.yOffset.min = yOffsetMax * -1
		options.yOffset.max = 0
	end

	options.maxHeight.max = screenHeight - abs(db.yOffset)

	if updateValues then
		if abs(db.yOffset) + db.maxHeight > screenHeight then
			db.maxHeight = options.maxHeight.max
		end
	end
end

local function SetAlert(type)
	if not type then return end

	if type == "trackedQuests" then
		local trackedQuests = GetCVar("trackedQuests")
		if trackedQuests ~= "" and trackedQuests ~= "v11" then
			local character = UnitName("player")
			local realm = GetRealmName()
			general.alert = {
				name = "Alert - Automatically tracked quests",
				type = "group",
				inline = true,
				order = 0.1,
				args = {
					alertIcon = {
						name = "|T"..STATICPOPUP_TEXTURE_ALERT..":36:36:8:-2|t",
						type = "description",
						width = 0.2,
						order = 1.1,
					},
					alertText = {
						name = "You are probably having problem with automatically tracked quests after every Login or Reload UI, try the following steps to fix it.",
						type = "description",
						width = 2.8,
						fontSize = "medium",
						order = 1.2,
					},
					alertSpacer = {
						name = " ",
						type = "description",
						width = 0.2,
						order = 2.1,
					},
					alertText2 = {
						name = "- Go to the directory:  ...\\World of Warcraft\\_retail_\\WTF\\Account\\...ACCOUNT...\\"..realm.."\\"..character.."\n"..
								"- Open the file:  "..cBold.."config-cache.wtf|r\n"..
								"- Search for the string:  "..cBold.."SET trackedQuests \""..trackedQuests.."\"|r\n"..
								"- Change it to:  "..cBold.."SET trackedQuests \"v11\"|r\n"..
								"- Restart WoW",
						type = "description",
						width = 2.8,
						order = 2.2,
					},
				},
			}
		end
	end
end

-- Init
KT:RegEvent("PLAYER_ENTERING_WORLD", function(eventID)
	SetAlert("trackedQuests")
	modules.sec1.args = GetModulesOptionsTable()
	UpdateOptions()
	KT:RegEvent("UI_SCALE_CHANGED", function()
		UpdateOptions()
	end)
	KT:UnregEvent(eventID)
end)

hooksecurefunc(UIParent, "SetScale", function(self)
	UpdateOptions()
end)