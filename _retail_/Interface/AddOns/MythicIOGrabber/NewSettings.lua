local addonName, miog = ...
local wticc = WrapTextInColorCode

MIOG_NewSettings = {}

local defaultSortState = {
    currentLayer = 0,
    currentState = 0,
    active = false,
}

local defaultFilters = {
    classes = {},
    specs = {},
    partyFit = false,
    ressFit = false,
    lustFit = false,
    affixFit = false,
    filterForTanks = false,
    filterForHealers = false,
    filterForDamager = false,
    linkedTanks = false,
    linkedHealers = false,
    linkedDamager = false,
    filterForDifficulty = false,
    filterForRating = false,
    filterForAge = false,
    filterForBossKills = false,
    filterForActivities = false,
    filterForDungeons = false,
    filterForRaids = false,
    filterForRoles = {
        TANK = true,
        HEALER = true,
        DAMAGER = true,
    },
    filterForClassSpecs = true,
    minTanks = 0,
    maxTanks = 0,
    minHealers = 0,
    maxHealers = 0,
    minDamager = 0,
    maxDamager = 0,
    minRating = 0,
    maxRating = 0,
    minAge = 0,
    maxAge = 0,
    minBossKills = 0,
    maxBossKills = 0,
    difficultyID = 0,
    dungeons = {},
    raids = {
        setting = false,
        bosses = {}
    },
    hardDecline = false,
    softDecline = false,
    needsMyClass = true,
}

miog.defaultFilters = defaultFilters

local defaultSettings = {
    {name = "Frame manually resized", variableName = "MIOG_ManualResize", key="manualResize", default=0},
    {name = "Active side panel", variableName = "MIOG_SidePanel", key="activeSidePanel", default="none"},
    {name = "Mythic+ Statistics", variableName = "MIOG_MPlusStats", key="mplusStats", default={}},
    {name = "PVP Statistics", variableName = "MIOG_PVPStats", key="pvpStats", default={}},
    {name = "Raid Statistics", variableName = "MIOG_RaidStats", key="raidStats", default={}},
    {name = "Lite Mode", variableName = "MIOG_LiteMode", key="liteMode", default=false, type="checkbox", tooltip="Enable or disable the lite mode of this addon (use Blizzards \"Dungeons and Raids\" Frame with this addon's frames layered on top", reload=true},
    {name = "Background options", variableName = "MIOG_BackgroundOptions", key="backgroundOptions", default=GetNumExpansions(), type="dropdown", tooltip="Change the default background of the MIOG frames",
    customCallback=function(setting, value)
        miog.MainFrame.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/" .. miog.EXPANSION_INFO[value][2] .. ".png")
        miog.LastInvites.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/" .. miog.EXPANSION_INFO[value][2] .. "_small.png")
        miog.FilterPanel.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/" .. miog.EXPANSION_INFO[value][2] .. "_small.png")
    end},
    {name = "Guild keystone info", variableName = "MIOG_GuildKeystoneInfo", key="guildKeystoneInfo", default={}},
    {name = "Last invited applicants", variableName = "MIOG_LastInvitedApplicants", key="lastInvitedApplicants", default={}},
    {name = "Last used queue", variableName = "MIOG_LastUsedQueue", key="lastUsedQueue", default = {}},
    {name = "Last group", variableName = "MIOG_LastGroup", key="lastGroup", default="No group found"},
    {name = "Enable Search Panel Class Spec Tooltips", variableName = "MIOG_ClassSpecTooltip", key="classSpecTooltip", default=true},
    {name = "Favoured applicants", variableName = "MIOG_FavouredApplicants", key="favouredApplicants", default={}, type="custom"},
    {name = "Filter options", variableName = "MIOG_FilterOptions", key="filterOptions", default={["LFGListFrame.SearchPanel"] = defaultFilters, ["LFGListFrame.ApplicationViewer"] = defaultFilters}},
    {name = "Sort methods", variableName = "MIOG_SortMethods", key="sortMethods", default={
        ["LFGListFrame.SearchPanel"] = {["primary"] = defaultSortState, ["secondary"] = defaultSortState, ["age"] = defaultSortState},

        ["LFGListFrame.ApplicationViewer"] = {["role"] = defaultSortState, ["primary"] = defaultSortState, ["secondary"] = defaultSortState, ["ilvl"] = defaultSortState},

        ["PartyCheck"] = {["group"] = defaultSortState, ["shortName"] = defaultSortState, ["role"] = defaultSortState, ["specID"] = defaultSortState, ["ilvl"] = defaultSortState, ["durability"] = defaultSortState, ["keylevel"] = defaultSortState, ["score"] = defaultSortState, ["progressWeight"] = defaultSortState},

        ["Guild"] = {["level"] = defaultSortState, ["rank"] = defaultSortState, ["class"] = defaultSortState, ["keystone"] = defaultSortState, ["keylevel"] = defaultSortState, ["score"] = defaultSortState, ["progressWeight"] = defaultSortState, }}
    },
    {name = "Search Panel declined groups", variableName = "MIOG_DeclinedGroups", key="declinedGroups", default={}},
    {name = "Account-wide lockouts", variableName = "MIOG_Lockouts", key="lockoutCheck", default={}},
}

local category = Settings.RegisterVerticalLayoutCategory(addonName)

local function OnSettingChanged(setting, value)
	-- This callback will be invoked whenever a setting is modified.
	--print("[MIOG] Setting changed:", setting:GetVariable(), value)
end

local function createDefaultSettings()
    for k, v in ipairs(defaultSettings) do
        local setting = Settings.RegisterAddOnSetting(category, v.variableName, v.key, MIOG_NewSettings, type(v.default), v.name, v.default)

        if(v.type) then
            if(v.type == "checkbox") then
                Settings.CreateCheckbox(category, setting, v.tooltip)

            elseif(v.type == "dropdown") then
                local GetOptions

                if(v.key == "backgroundOptions") then
                    GetOptions = function()
                        local container = Settings.CreateControlTextContainer();
                        for x, y in ipairs(miog.EXPANSION_INFO) do
                            container:Add(x, y[1])
                        end
                        return container:GetData();
                    end
                end

                Settings.CreateDropdown(category, setting, GetOptions, v.tooltip);
            elseif(v.type == "custom") then
                if(v.key == "favouredApplicants") then
                    local scrollBox = miog.loadFavouredPlayersPanel(SettingsPanel)

                    local subcategory, subcategoryLayout = Settings.RegisterCanvasLayoutSubcategory(category, scrollBox, "Favour");
                    
                    subcategoryLayout:AddAnchorPoint("TOPLEFT", 10, -10);
                    subcategoryLayout:AddAnchorPoint("BOTTOMRIGHT", -10, 10);
                end
            end
        
        end

        if(v.reload) then
            setting:SetValueChangedCallback(function() C_UI.Reload() end)

        else
            setting:SetValueChangedCallback(v.customCallback)

        end

        if(v.key == "filterOptions") then
            local categories = C_LFGList.GetAvailableCategories(LFGListFrame.CategorySelection.baseFilters)

            for x, y in ipairs(categories) do
                local categoryInfo = C_LFGList.GetLfgCategoryInfo(y)

                -- /dump MIOG_NewSettings.filterOptions["LFGListFrame.SearchPanel"][1]

                for i = 1, 2, 1 do
                    local panel = i == 1 and "LFGListFrame.SearchPanel" or "LFGListFrame.ApplicationViewer"
                    if(not MIOG_NewSettings.filterOptions[panel][y]) then
                        MIOG_NewSettings.filterOptions[panel][y] = defaultFilters

                    else
                        for a, b in pairs(defaultFilters) do
                            if(MIOG_NewSettings.filterOptions[panel][y][a] == nil) then
                                MIOG_NewSettings.filterOptions[panel][y][a] = b

                            end
                        end
                    end
                end
            end
        elseif(v.key == "declinedGroups") then
            
            for x, y in pairs(MIOG_NewSettings.declinedGroups) do
                if(y.timestamp < time() - 900) then
                    MIOG_NewSettings.declinedGroups[x] = nil
                    
                end
            end
        end
    end
end

miog.loadNewSettings = function()
    createDefaultSettings()

    miog.F.LITE_MODE = MIOG_NewSettings.liteMode

    miog.refreshFavouredPlayers()

   
end

miog.loadNewSettingsAfterFrames = function()
    for k, v in pairs(MIOG_NewSettings.sortMethods) do
        local buttonArray = k == "LFGListFrame.ApplicationViewer" and miog.ApplicationViewer.ButtonPanel.sortByCategoryButtons
        or k == "LFGListFrame.SearchPanel" and miog.SearchPanel.ButtonPanel.sortByCategoryButtons
        or k == "PartyCheck" and miog.PartyCheck and miog.PartyCheck.sortByCategoryButtons
        or k == "Guild" and miog.Guild and miog.Guild.sortByCategoryButtons

        if(buttonArray) then
            for sortKey, row in pairs(v) do
                if(buttonArray[sortKey]) then
                    if(row.active == true) then
                        buttonArray[sortKey]:SetState(row.active, row.currentState)
                        buttonArray[sortKey].FontString:SetText(row.currentLayer)

                    else
                        buttonArray[sortKey]:SetState(false)

                    end
                end
            end
        end
    end
end

function MIOG_OpenInterfaceOptions()
	Settings.OpenToCategory(category:GetID())
end

Settings.RegisterAddOnCategory(category)