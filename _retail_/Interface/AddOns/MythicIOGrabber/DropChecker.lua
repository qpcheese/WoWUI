local addonName, miog = ...
local wticc = WrapTextInColorCode

local armorTypeInfo = {
    {name = C_Item.GetItemSubClassInfo(4, Enum.ItemArmorSubclass.Cloth)},
    {name = C_Item.GetItemSubClassInfo(4, Enum.ItemArmorSubclass.Leather)},
    {name = C_Item.GetItemSubClassInfo(4, Enum.ItemArmorSubclass.Mail)},
    {name = C_Item.GetItemSubClassInfo(4, Enum.ItemArmorSubclass.Plate)},
}

local currentItemIDs
local selectedArmor, selectedClass, selectedSpec

local itemData

local function fuzzyCheck(text)
    local filterArray = {}

    for k, v in ipairs(itemData) do
        table.insert(filterArray, v.name)

    end

    local result = miog.fzy.filter(text, filterArray)

    table.sort(result, function(k1, k2)
        return k1[3] > k2[3]
    end)

    local returnResults = {}

    for k, v in ipairs(result) do
        table.insert(returnResults, {index = v[1], positions = v[2]})

    end

    return returnResults
end

local function resetLootItemFrames(frame, data)
    if(data.template == "MIOG_AdventureJournalLootItemSingleTemplate") then
        frame.itemLink = nil
        frame.BasicInformation.Name:SetText("")
        frame.BasicInformation.Icon:SetTexture(nil)
        frame:SetScript("OnEnter", nil)

    else
        local x1, x2, x3 = frame.Name:GetFont()
        frame.Name:SetFont(x1, 12, x3)

    end
end

local instanceQueue = {}
local forceSeasonID = 13
local selectedItemClass, selectedItemSubClass

local function checkIfItemIsFiltered(item)
    local _, _, _, _, _, _, _, _, _, _, _, classID, subclassID = C_Item.GetItemInfo(item.link)

    local isSpecialToken = classID == 5 and subclassID == 2 and selectedItemClass == 15 and selectedItemSubClass == 0
    local specialItemCorrectClass = classID == selectedItemClass
    local specialItemCorrectSubClass = selectedItemSubClass ~= nil and subclassID == selectedItemSubClass or selectedItemSubClass == nil and true

    local isSlotCorrect = item.filterType == C_EncounterJournal.GetSlotFilter()
    local isArmorCorrect = selectedArmor == item.armorType

    if(isSpecialToken or specialItemCorrectClass and specialItemCorrectSubClass) then
        return true

    elseif(selectedItemClass == nil and selectedItemSubClass == nil and (isSlotCorrect or isArmorCorrect)) then
        if(selectedArmor ~= nil and C_EncounterJournal.GetSlotFilter() ~= 15 and (not isSlotCorrect or not isArmorCorrect)) then
            return false

        end

        return true

    end

    return false
end

local function loadLoot()
    local allItems = true
    
    for k, v in pairs(currentItemIDs) do
        if(v.hasData ~= true) then
            allItems = false
            break
        end
    end
        
    local dataProvider = CreateDataProvider()
    
    if(allItems) then
        itemData = {}

        for _, v in ipairs(instanceQueue) do
            EJ_SelectInstance(v.journalInstanceID)
            EJ_SetDifficulty(v.isRaid and 16 or 23)

            local numOfLoot = EJ_GetNumLoot()

            if(numOfLoot > 0) then
                for i = 1, numOfLoot, 1 do
                    local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i)

                    if(itemInfo.slot) then
                        table.insert(itemData, itemInfo)

                    end
                end
            end
        end

        local searchBoxText = miog.DropChecker.SearchBox:GetText()

        local results = fuzzyCheck(searchBoxText)

        local noFilter = C_EncounterJournal.GetSlotFilter() == 15

        if(searchBoxText ~= "") then
            for k, v in ipairs(results) do
                local item = itemData[v.index]
                dataProvider:Insert({template = "MIOG_AdventureJournalLootItemSingleTemplate", name = item.name, icon = item.icon, link = item.link, encounterID = item.encounterID, positions = v.positions})

            end

        else
            for k, v in ipairs(instanceQueue) do
                EJ_SelectInstance(v.journalInstanceID)
                EJ_SetDifficulty(v.isRaid and 16 or 23)
    
                local numOfLoot = EJ_GetNumLoot()
    
                local addedInstance = false
                local slotsDone = {}

                if(numOfLoot > 0) then
                    for i = 1, numOfLoot, 1 do
                        local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i)
    
                        if(itemInfo.slot) then
                            if(searchBoxText ~= "") then
        
                            else
                                if(noFilter and selectedArmor == nil or checkIfItemIsFiltered(itemInfo, noFilter)) then
                                    if(not addedInstance) then
                                        local instanceName, _, _, _, _, _, _, _, _, mapID = EJ_GetInstanceInfo()
                                        dataProvider:Insert({
                                            template = "MIOG_AdventureJournalLootSlotLineTemplate",
                                            name = instanceName,
                                            icon = miog.MAP_INFO[mapID].icon,
                                            header = true,
                                        })
                            
                                        addedInstance = true
                                    end

                                    if(not slotsDone[itemInfo.filterType] and noFilter) then
                                        dataProvider:Insert({
                                            template = "MIOG_AdventureJournalLootSlotLineTemplate",
                                            name = itemInfo.slot ~= "" and itemInfo.slot or "Other",
                                        })
                            
                                        slotsDone[itemInfo.filterType] = true
                                    end
                                    
                                    dataProvider:Insert({template = "MIOG_AdventureJournalLootItemSingleTemplate", name = itemInfo.name, icon = itemInfo.icon, link = itemInfo.link, encounterID = itemInfo.encounterID})

                                end
                            end
                        end
                    end
                end
            end


        end

        
    end

    if(dataProvider:GetSize() == 0) then
        dataProvider:Insert({
            template = "MIOG_AdventureJournalLootSlotLineTemplate",
            name = "No loot available for this slot",
        })
    end
    
    miog.DropChecker.ScrollBox:SetDataProvider(dataProvider)
end

local function requestAllLootForMapID(mapID)
    local journalInstanceID = C_EncounterJournal.GetInstanceForGameMap(mapID) or nil

    if(journalInstanceID) then
        EJ_SelectInstance(journalInstanceID)

        for i = 1, EJ_GetNumLoot(), 1 do
            local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i)

            if(not itemInfo.name) then
                currentItemIDs[itemInfo.itemID] = {hasData = false, journalInstanceID = journalInstanceID}

            end
        end

        table.insert(instanceQueue, {journalInstanceID = journalInstanceID, isRaid = EJ_InstanceIsRaid()})
    end
end

local function checkAllItemIDs()
    currentItemIDs = {}
    instanceQueue = {}

    for x, y in pairs(miog.SEASONAL_MAP_IDS) do
        if((forceSeasonID or C_MythicPlus:GetCurrentSeason()) == x) then
            for _, mapID in ipairs((miog.DROPCHECKER_MAP_IDS[x] or y).dungeons) do
                requestAllLootForMapID(mapID)
            end
            
            for _, mapID in ipairs((miog.DROPCHECKER_MAP_IDS[x] or y).raids) do
                requestAllLootForMapID(mapID)
            end
        end
    end
    
    table.sort(instanceQueue, function(k1, k2)
        if(k1.isRaid == k2.isRaid) then
            return k1.journalInstanceID < k2.journalInstanceID
        end

        return not k1.isRaid
    end)
                
    loadLoot()
end

miog.loadDropChecker = function()
    miog.DropChecker = CreateFrame("Frame", "MythicIOGrabber_DropChecker", miog.Plugin.InsertFrame, "MIOG_DropChecker")
    miog.DropChecker:SetScript("OnShow", function()
        if(miog.DropChecker.ScrollBox:GetDataProvider():GetSize() <= 1) then
            EJ_ResetLootFilter()
            C_EncounterJournal.ResetSlotFilter()
            checkAllItemIDs()
        end
    end)


    miog.DropChecker.SlotDropdown:SetDefaultText("Equipment slots")
    miog.DropChecker.SlotDropdown:SetupMenu(function(dropdown, rootDescription)
        rootDescription:CreateButton("Clear", function(index)
            selectedItemClass = nil
            selectedItemSubClass = nil
            C_EncounterJournal.ResetSlotFilter()

            checkAllItemIDs()

        end)

        
        local sortedFilters = {}

        for k, v in pairs(Enum.ItemSlotFilterType) do
            sortedFilters[v] = k
        end

        for i = 0, #sortedFilters - 1, 1 do
	        rootDescription:CreateRadio(miog.SLOT_FILTER_TO_NAME[i], function(index) return index == C_EncounterJournal.GetSlotFilter() end, function(index)
                selectedItemClass = nil
                selectedItemSubClass = nil
                C_EncounterJournal.SetSlotFilter(index)
                checkAllItemIDs()

            end, i)
        end

        rootDescription:CreateRadio("Mounts", function(data) return selectedItemClass == data.class and selectedItemSubClass == data.subclass end, function(data)
            selectedItemClass = data.class
            selectedItemSubClass = data.subclass
            
            C_EncounterJournal.SetSlotFilter(14)
            checkAllItemIDs()

        end, {class = 15, subclass = 5})

        rootDescription:CreateRadio("Recipes", function(data) return selectedItemClass == data.class and selectedItemSubClass == data.subclass end, function(data)
            selectedItemClass = data.class
            selectedItemSubClass = data.subclass
            
            C_EncounterJournal.SetSlotFilter(14)
            checkAllItemIDs()

        end, {class = 9, subclass = nil})

        rootDescription:CreateRadio("Tokens", function(data) return selectedItemClass == data.class and selectedItemSubClass == data.subclass end, function(data)
            selectedItemClass = data.class
            selectedItemSubClass = data.subclass

            C_EncounterJournal.SetSlotFilter(14)
            checkAllItemIDs()

        end, {class = 15, subclass = 0})
    end)




    miog.DropChecker.ArmorDropdown:SetDefaultText("Armor types")
    miog.DropChecker.ArmorDropdown:SetupMenu(function(dropdown, rootDescription)
        rootDescription:CreateButton("Clear", function(index)
            selectedArmor = nil
            selectedClass = nil
            selectedSpec = nil
            
            EJ_ResetLootFilter()

            checkAllItemIDs()

        end)

        local classButton = rootDescription:CreateButton("Classes")

        classButton:CreateButton("Clear", function(index)
            selectedClass = nil
            selectedSpec = nil
            EJ_ResetLootFilter()

            checkAllItemIDs()

        end)

        for k, v in ipairs(miog.CLASSES) do
	        local classMenu = classButton:CreateRadio(GetClassInfo(k), function(index) return index == selectedClass end, function(name)
                selectedClass = k
                selectedSpec = nil
                EJ_SetLootFilter(selectedClass, selectedSpec)

                checkAllItemIDs()

                if(dropdown:IsMenuOpen()) then
                    dropdown:CloseMenu()
                end
            end, k)

            for x, y in ipairs(v.specs) do
                local id, specName, description, icon, role, classFile, className = GetSpecializationInfoByID(y)

                classMenu:CreateRadio(specName, function(specID) return specID == selectedSpec end, function(name)
                    selectedClass = k
                    selectedSpec = id
                    EJ_SetLootFilter(k, id)
                    checkAllItemIDs()

                    if(dropdown:IsMenuOpen()) then
                        dropdown:CloseMenu()
                    end
                end, id)
            end
        end

        local armorButton = rootDescription:CreateButton("Armor")

        --[[local sortedFilters = {}

        for k, v in pairs(Enum.ItemArmorSubclass) do
            sortedFilters[v] = k
        end

        for k, v in ipairs(sortedFilters) do
            if(k > 0 and k < 5) then
                armorButton:CreateRadio(v, function(index) return index == selectedArmor end, function(index)
                    selectedArmor = index

                    checkAllItemIDs()
                end, v)
            end
            
        end]]

        armorButton:CreateButton("Clear", function(index)
            selectedArmor = nil

            checkAllItemIDs()

        end)

        for k, v in ipairs(armorTypeInfo) do
	        armorButton:CreateRadio(v.name, function(name) return name == selectedArmor end, function(name)
                selectedArmor = v.name

                checkAllItemIDs()
            end, v.name)
            
        end

    end)

    local view = CreateScrollBoxListLinearView(1, 1, 1, 1, 2);

    local function initializeLootFrames(frame, elementData)
        --local elementData = node:GetData()

        if(elementData.template == "MIOG_AdventureJournalLootItemSingleTemplate") then
            local formattedText

            if(elementData.positions) then
                formattedText = ""
    
                local positionArray = {}
    
                for k, v in ipairs(elementData.positions) do
                    positionArray[v] = true
                end
    
                for i = 1, strlen(elementData.name), 1 do
                    if(positionArray[i]) then
                        formattedText = formattedText .. WrapTextInColorCode(strsub(elementData.name, i, i), miog.CLRSCC.green)
    
                    else
                        formattedText = formattedText .. strsub(elementData.name, i, i)
    
                    end
    
                end
            end

            frame.BasicInformation.Name:SetText(formattedText or elementData.name)
            frame.BasicInformation.Icon:SetTexture(elementData.icon)
            frame.itemLink = elementData.link
            
            frame:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(elementData.link)
                GameTooltip_AddBlankLineToTooltip(GameTooltip)

                local encounterName, _, _, _, _, journalInstanceID = EJ_GetEncounterInfo(elementData.encounterID)
                local instanceName = EJ_GetInstanceInfo(journalInstanceID)

                GameTooltip:AddLine("[" .. instanceName .. "]: " .. encounterName)
                GameTooltip:Show()
            end)

        else
            frame.Name:SetText(elementData.name)
            frame.Icon:SetTexture(elementData.icon)
            frame.Icon:SetShown(elementData.icon ~= nil)

            if(elementData.header) then
                local x1, x2, x3 = frame.Name:GetFont()
                frame.Name:SetFont(x1, 16, x3)

            end

        end
    end

    local function CustomFactory(factory, data)
        --local data = node:GetData()
        local template = data.template
        factory(template, initializeLootFrames)
    end

    view:SetElementFactory(CustomFactory)
    view:SetElementResetter(resetLootItemFrames)
    view:SetElementExtentCalculator(function(index, elementData)
		if(elementData.header and index ~= 1) then
            return 35

        else
            return 20

        end
	end);
    
    view:SetPadding(1, 1, 1, 1, 4);
    
    ScrollUtil.InitScrollBoxListWithScrollBar(miog.DropChecker.ScrollBox, miog.DropChecker.ScrollBar, view);

    miog.DropChecker.ScrollBox:SetDataProvider(CreateDataProvider())

    miog.DropChecker.SearchBox:SetScript("OnTextChanged", function(self)
        SearchBoxTemplate_OnTextChanged(self)

        if(key == "ESCAPE" or key == "ENTER") then
            self:Hide()
            self:ClearFocus()
    
        else
            checkAllItemIDs()

        end
    end)
end

local function dcEvents(_, event, ...)
    if(currentItemIDs and currentItemIDs[...]) then
        currentItemIDs[...].hasData = true

        loadLoot()
    end
end

local eventReceiver = CreateFrame("Frame", "MythicIOGrabber_AJEventReceiver")

--eventReceiver:RegisterEvent("EJ_DIFFICULTY_UPDATE")
eventReceiver:RegisterEvent("EJ_LOOT_DATA_RECIEVED")
eventReceiver:SetScript("OnEvent", dcEvents)