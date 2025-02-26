local addonName, miog = ...
local wticc = WrapTextInColorCode

local panels

local function setActivePanel(_, panel)
	for k, v in pairs(panels) do
		if(v) then
			v:Hide()
		end
	end

	miog.Plugin:Show()

	if(miog.F.LITE_MODE and panel ~= LFGListFrame.CategorySelection) then
		panel:Hide()

	elseif(panel == LFGListFrame.ApplicationViewer or panel == LFGListFrame.SearchPanel) then
		miog.Plugin.ButtonPanel:Hide()

		if(MIOG_NewSettings.activeSidePanel == "filter") then
			miog.FilterPanel.Lock:Hide()
			miog.FilterPanel:Show()

		elseif(MIOG_NewSettings.activeSidePanel == "invites") then
			miog.LastInvites:Show()

		else
			miog.Plugin.ButtonPanel:Show()
		
		end

		miog.setupFiltersForActivePanel()

	end

	if(panel == LFGListFrame.ApplicationViewer) then
		miog.ApplicationViewer:Show()

		if(UnitIsGroupLeader("player")) then
			miog.ApplicationViewer.Delist:Show()
			miog.ApplicationViewer.Edit:Show()

		else
			miog.ApplicationViewer.Delist:Hide()
			miog.ApplicationViewer.Edit:Hide()
			
		end

	elseif(panel == LFGListFrame.SearchPanel) then
		miog.SearchPanel:Show()

	elseif(panel == LFGListFrame.EntryCreation) then
		miog.FilterPanel.Lock:Show()
		miog.EntryCreation:Show()

		if(miog.F.LITE_MODE) then
			miog.initializeActivityDropdown()

		end

	elseif(panel == "AdventureJournal") then
		miog.AdventureJournal:Show()
		miog.FilterPanel.Lock:Show()

	elseif(panel == "RaiderIOChecker") then
		miog.RaiderIOChecker:Show()
		miog.FilterPanel.Lock:Show()

	elseif(panel == "DropChecker") then
		miog.DropChecker:Show()
		miog.FilterPanel.Lock:Show()

	else
		miog.Plugin:Hide()
		miog.FilterPanel.Lock:Show()

	end
end

miog.setActivePanel = setActivePanel

miog.createFrames = function()
	EncounterJournal_LoadUI()
	EJ_SelectInstance(1207)

	C_EncounterJournal.OnOpen = miog.dummyFunction

	local settingsButton = CreateFrame("Button")
	settingsButton:SetSize(20, 20)
	settingsButton:SetNormalTexture("Interface/Addons/MythicIOGrabber/res/infoIcons/settingGear.png")
	settingsButton:SetScript("OnClick", function()
		MIOG_OpenInterfaceOptions()
	end)

	if(miog.F.LITE_MODE == true) then
		miog.Plugin = CreateFrame("Frame", "MythicIOGrabber_PluginFrame", LFGListFrame, "MIOG_Plugin")
		miog.Plugin:SetPoint("TOPLEFT", PVEFrameLeftInset, "TOPRIGHT")
		miog.Plugin:SetSize(LFGListFrame:GetWidth(), LFGListFrame:GetHeight() - PVEFrame.TitleContainer:GetHeight() - 7)
		miog.Plugin:SetFrameStrata("HIGH")

		settingsButton:SetParent(PVEFrame)
		settingsButton:SetFrameStrata("HIGH")
		settingsButton:SetPoint("RIGHT", PVEFrameCloseButton, "LEFT", -2, 0)
	else
		miog.createPVEFrameReplacement()
		miog.Plugin = CreateFrame("Frame", "MythicIOGrabber_PluginFrame", miog.MainTab, "MIOG_Plugin")
		miog.Plugin:SetPoint("TOPLEFT", miog.MainTab.QueueInformation, "TOPRIGHT", 0, 0)
		miog.Plugin:SetPoint("TOPRIGHT", miog.MainTab, "TOPRIGHT", 0, 0)
		miog.Plugin:SetHeight(miog.pveFrame2:GetHeight() - miog.pveFrame2.TitleBar:GetHeight() - 5)

		miog.createFrameBorder(miog.Plugin, 1, CreateColorFromHexString(miog.C.BACKGROUND_COLOR_3):GetRGBA())
		miog.Plugin:SetBackdropColor(CreateColorFromHexString(miog.C.BACKGROUND_COLOR):GetRGBA())

		miog.createFrameBorder(miog.MainTab.QueueInformation.LastGroup, 1, CreateColorFromHexString(miog.C.BACKGROUND_COLOR_3):GetRGBA())

		local r,g,b = CreateColorFromHexString(miog.CLRSCC.black):GetRGB()

		miog.MainTab.QueueInformation.LastGroup:SetBackdropColor(r, g, b, 0.9)

		PVEFrame_ShowFrame("PVPUIFrame", "HonorFrame")
		PVEFrame_ShowFrame("PVPUIFrame", "ConquestFrame")

		settingsButton:SetParent(miog.pveFrame2.TitleBar)
		settingsButton:SetPoint("RIGHT", miog.pveFrame2.TitleBar.CloseButton, "LEFT", -2, 0)

		miog.pveFrame2.TitleBar.BlizzardFrame:SetPoint("RIGHT", settingsButton, "LEFT", -2, 0)
	end

	miog.Plugin:SetScript("OnEnter", function()
	
	end)
	
	miog.Plugin.ButtonPanel.FilterButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		miog.Plugin.ButtonPanel:Hide()

		miog.LastInvites:Hide()
		miog.FilterPanel:Show()

		MIOG_NewSettings.activeSidePanel = "filter"

		if(LFGListFrame.activePanel ~= LFGListFrame.SearchPanel and LFGListFrame.activePanel ~= LFGListFrame.ApplicationViewer) then
			miog.FilterPanel.Lock:Show()

		else
			miog.FilterPanel.Lock:Hide()
		
		end
	end)

	miog.Plugin.ButtonPanel.LastInvitesButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		miog.Plugin.ButtonPanel:Hide()

		MIOG_NewSettings.activeSidePanel = "invites"

		miog.LastInvites:Show()
		miog.FilterPanel:Hide()
	end)

	miog.createFrameBorder(miog.Plugin.ButtonPanel.FilterButton, 1, CreateColorFromHexString(miog.C.BACKGROUND_COLOR_3):GetRGBA())
	miog.Plugin.ButtonPanel.FilterButton:SetBackdropColor(CreateColorFromHexString(miog.C.BACKGROUND_COLOR):GetRGBA())

	miog.createFrameBorder(miog.Plugin.ButtonPanel.LastInvitesButton, 1, CreateColorFromHexString(miog.C.BACKGROUND_COLOR_3):GetRGBA())
	miog.Plugin.ButtonPanel.LastInvitesButton:SetBackdropColor(CreateColorFromHexString(miog.C.BACKGROUND_COLOR):GetRGBA())

	miog.Plugin.Resize:SetScript("OnDragStart", function(self, button)
		self:GetParent():StartSizing()
	end)

	miog.Plugin.Resize:SetScript("OnDragStop", function(self)
		self:GetParent():StopMovingOrSizing()

		MIOG_NewSettings.manualResize = miog.Plugin:GetHeight()
	end)

	miog.Plugin:SetResizeBounds(miog.Plugin:GetWidth(), miog.Plugin:GetHeight(), miog.Plugin:GetWidth(), GetScreenHeight() * 0.67)

	miog.Plugin:SetHeight(MIOG_NewSettings.manualResize > 0 and MIOG_NewSettings.manualResize or miog.Plugin:GetHeight())

	miog.createFrameBorder(miog.Plugin.FooterBar, 1, CreateColorFromHexString(miog.C.BACKGROUND_COLOR_3):GetRGBA())
	miog.Plugin.FooterBar:SetBackdropColor(CreateColorFromHexString(miog.C.BACKGROUND_COLOR):GetRGBA())

	miog.MainFrame = miog.F.LITE_MODE and miog.Plugin or miog.pveFrame2
	miog.MainFrame.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/" .. miog.EXPANSION_INFO[MIOG_NewSettings.backgroundOptions][2] .. ".png")

	miog.createApplicationViewer()
	miog.createSearchPanel()
	miog.createEntryCreation()
	miog.loadFilterPanel()
	miog.loadLastInvitesPanel()
	miog.createClassPanel()

	if(not miog.F.LITE_MODE) then
		miog.loadQueueSystem()
		miog.loadCalendarSystem()
		miog.loadGearingChart()
		miog.loadAdventureJournal()
		miog.loadPartyCheck()
		--miog.loadGuildFrame()
		miog.loadDropChecker()

		miog.loadRaiderIOChecker()
		miog.loadLockoutCheck()
		--miog.InviteFrame = CreateFrame("Frame", "MythicIOGrabber_InviteFrame", UIParent, "MIOG_InviteFrame")
		--miog.InviteFrame:SetPoint("TOPLEFT", LFGListInviteDialog, "TOPLEFT")
		--miog.InviteFrame:SetPoint("TOP", UIParent, "TOP", 0, - (GetScreenHeight() * 0.1))
		
	end

	miog.createInspectCoroutine()

	hooksecurefunc("LFGListFrame_SetActivePanel", function(_, panel)
		setActivePanel(_, panel)
	end)

	panels = {
		miog.ApplicationViewer,
		miog.SearchPanel,
		miog.EntryCreation,
		miog.AdventureJournal,
		miog.RaiderIOChecker,
		miog.DropChecker,
	}
end