local addonName, miog = ...
local wticc = WrapTextInColorCode

local queuedList = {};

local queueSystem = {}
queueSystem.queueFrames = {}
queueSystem.currentlyInUse = 0

local queueFrameIndex = 1
local randomBGFrame, randomEpicBGFrame, skirmish, brawl1, brawl2, specificBox

local formatter = CreateFromMixins(SecondsFormatterMixin)
formatter:SetStripIntervalWhitespace(true)
formatter:Init(0, SecondsFormatter.Abbreviation.OneLetter)

miog.requeue = function()
	local queueInfo = MIOG_NewSettings.lastUsedQueue

	if(queueInfo.type == "pve") then
		if(queueInfo.subtype == "multidng") then
			LFG_JoinDungeon(1, "specific", queueInfo.id, {})
			
		else
			ClearAllLFGDungeons(queueInfo.subtype == "dng" and 1 or 3);
			SetLFGDungeon(queueInfo.subtype == "dng" and 1 or 3, queueInfo.id);
			JoinSingleLFG(queueInfo.subtype == "dng" and 1 or 3, queueInfo.id);

		end

	elseif(queueInfo.type == "pvp") then
		if(queueInfo.subtype == "skirmish") then
			JoinSkirmish(4)
			
		elseif(queueInfo.subtype == "brawl") then
			C_PvP.JoinBrawl()

		elseif(queueInfo.subtype == "brawlSpecial") then
			C_PvP.JoinBrawl(true)

		elseif(queueInfo.subtype == "pet") then
			C_PetBattles.StartPVPMatchmaking()

		end
	end
end

function MIOG_GetCurrentDropdownButton(queueIndex)
	return _G["DropDownList1Button" .. (queueIndex * 2)]

end

local function saveTempButton(queueIndex)
	QueueStatusButton:Click("RightButton")

	local menu = Menu.GetManager():GetOpenMenu()

	if(menu) then
		local children = menu:GetLayoutChildren()

		MIOG_TempButton = children[queueIndex * 2]

		menu:Close()
	end
end

local function resetQueueFrame(_, frame)
	if(not InCombatLockdown()) then
		frame:Hide()
		frame.layoutIndex = nil

		local objectType = frame:GetObjectType()

		if(objectType == "Frame") then
			frame:SetScript("OnMouseDown", nil)
			frame:SetScript("OnEnter", nil)
			frame:SetScript("OnLeave", nil)
			frame.Name:SetText("")
			frame.Name:SetTextColor(1,1,1,1)
			frame.Age:SetText("")
			frame.Background:SetTexture(nil)

			frame:ClearBackdrop()
			
			frame.CancelApplication:RegisterForClicks("LeftButtonDown")
			frame.CancelApplication:SetAttribute("type", nil)
			frame.CancelApplication:SetAttribute("macrotext1", nil)
			frame.CancelApplication:Show()

			frame.Wait:SetText("Wait")
		end

		miog.MainTab.QueueInformation.Panel.ScrollFrame.Container:MarkDirty()

	else
		miog.F.UPDATE_AFTER_COMBAT = true

	end
end

local function createQueueFrame(queueInfo)
	if(not InCombatLockdown()) then
		local queueFrame = queueSystem.queueFrames[queueInfo[18]]

		if(not queueSystem.queueFrames[queueInfo[18]]) then
			queueFrame = queueSystem.framePool:Acquire()
			queueFrame.ActiveIDFrame:Hide()

			--miog.createFrameBorder(queueFrame, 1, CreateColorFromHexString(miog.C.BACKGROUND_COLOR_3):GetRGBA())
			queueSystem.queueFrames[queueInfo[18]] = queueFrame

			queueFrameIndex = queueFrameIndex + 1
			queueFrame.layoutIndex = queueInfo[21] or queueFrameIndex
		
		end

		queueFrame:SetWidth(miog.MainTab.QueueInformation.Panel:GetWidth() - 7)
		
		--queueFrame:SetBackdropColor(CreateColorFromHexString(miog.C.BACKGROUND_COLOR_2):GetRGBA())

		queueFrame.Name:SetText(queueInfo[11])

		local ageNumber = 0

		if(queueFrame.Age.Ticker) then
			queueFrame.Age.Ticker:Cancel()
			queueFrame.Age.Ticker = nil
		end

		if(queueInfo[17]) then
			if(queueInfo[17][1] == "queued") then
				ageNumber = GetTime() - queueInfo[17][2]

				queueFrame.Age.Ticker = C_Timer.NewTicker(1, function()
					ageNumber = ageNumber + 1
					queueFrame.Age:SetText(miog.secondsToClock(ageNumber))

				end)
			elseif(queueInfo[17][1] == "duration") then
				ageNumber = queueInfo[17][2]

				queueFrame.Age.Ticker = C_Timer.NewTicker(1, function()
					ageNumber = ageNumber - 1
					queueFrame.Age:SetText(miog.secondsToClock(ageNumber))

				end)
			
			end
		end

		if(queueInfo[30]) then
			queueFrame.Background:SetTexture(queueInfo[30])

		end

		queueFrame.Age:SetText(miog.secondsToClock(ageNumber or 0))

		--if(queueInfo[20]) then
			--queueFrame.Icon:SetTexture(queueInfo[20])
		--end

		queueFrame.Wait:SetText("(" .. (queueInfo[12] ~= -1 and miog.secondsToClock(queueInfo[12] or 0) or "N/A") .. ")")

		queueFrame:SetShown(true)

	---@diagnostic disable-next-line: undefined-field
		miog.MainTab.QueueInformation.Panel.ScrollFrame.Container:MarkDirty()

		return queueFrame
	else
		miog.F.UPDATE_AFTER_COMBAT = true
	
	end
end

local function checkQueues()
	if(not InCombatLockdown()) then
		queueSystem.queueFrames = {}
		queueSystem.framePool:ReleaseAll()

		local queueIndex = 1

		for categoryID = 1, NUM_LE_LFG_CATEGORYS do
			local mode, submode = GetLFGMode(categoryID);

			if (mode and submode ~= "noteleport" ) then
				queuedList = GetLFGQueuedList(categoryID, queuedList) or {}
				
				local length = 0
				for _ in pairs(queuedList) do
					length = length + 1
				end
			
				local activeID = select(18, GetLFGQueueStats(categoryID));
				local isSpecificQueue = categoryID == LE_LFG_CATEGORY_LFD and length > 1
				local specificQueueDungeons = {}

				for queueID, queued in pairs(queuedList) do
					mode, submode = GetLFGMode(categoryID, queueID);
					local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, fileID, difficulty, maxPlayers, description, isHoliday, bonusRep, minPlayersDisband, isTimewalker, name2, minGearLevel, isScalingDungeon, mapID = GetLFGDungeonInfo(queueID)

					table.insert(specificQueueDungeons, {dungeonID = queueID, name = name, difficulty = subtypeID == 1 and "Normal" or subtypeID == 2 and "Heroic"})

					if(mode == "queued" and activeID == queueID or categoryID == LE_LFG_CATEGORY_RF) then
						--local inParty, joined, isQueued, noPartialClear, achievements, lfgComment, slotCount, categoryID2, leader, tank, healer, dps, x1, x2, x3, x4 = GetLFGInfoServer(categoryID, queueID);

						local hasData, leaderNeeds, tankNeeds, healerNeeds, dpsNeeds, totalTanks, totalHealers, totalDPS, instanceType, instanceSubType, instanceName, averageWait, tankWait, healerWait, damageWait, myWait, queuedTime = GetLFGQueueStats(categoryID, queueID)

						local isFollowerDungeon = queueID >= 0 and C_LFGInfo.IsLFGFollowerDungeon(queueID)

						local frameData = {
							[1] = hasData,
							[2] = isFollowerDungeon and LFG_TYPE_FOLLOWER_DUNGEON or subtypeID == 1 and LFG_TYPE_DUNGEON or subtypeID == 2 and LFG_TYPE_HEROIC_DUNGEON or subtypeID == 3 and RAID_FINDER,
							[11] = isSpecificQueue and MULTIPLE_DUNGEONS or name,
							[12] = myWait,
							[17] = {"queued", queuedTime},
							[18] = queueID,
							[20] = miog.DIFFICULTY_ID_INFO[difficulty] and miog.DIFFICULTY_ID_INFO[difficulty].isLFR and fileID
							or mapID and miog.MAP_INFO[mapID] and miog.MAP_INFO[mapID].icon or miog.LFG_ID_INFO[queueID] and miog.LFG_ID_INFO[queueID].icon or fileID or miog.findBattlegroundIconByName(name) or miog.findBrawlIconByName(name) or nil,
							[30] = miog.LFG_ID_INFO[queueID] and miog.LFG_ID_INFO[queueID].horizontal or (isSpecificQueue or mapID == nil) and miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/dungeon.png" or miog.MAP_INFO[mapID].horizontal
						}

						local frame

						if(not hasData) then
							frameData[17] = nil
						end

						frame = createQueueFrame(frameData)

						if(frame) then
							if(categoryID == 3 and activeID == queueID and length > 1) then
								frame.ActiveIDFrame:Show()

							else
								frame.ActiveIDFrame:Hide()

								--[[if(categoryID == 1) then
									frame.CancelApplication:SetScript("OnEnter", function(self)
										GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
										GameTooltip_AddErrorLine(GameTooltip, "This will also cancel all group finder applications!")
										GameTooltip:Show()
									end)

								end]]
							
							end

							--[[frame.CancelApplication:SetScript("OnClick", function()
								LeaveSingleLFG(categoryID, queueID)
							end)]]
							
						
							frame.CancelApplication:SetAttribute("type", "macro")
							frame.CancelApplication:SetAttribute("macrotext1", "/run LeaveSingleLFG(" .. categoryID .. "," .. queueID .. ")")

							if(mapID and not isSpecificQueue) then
								frame:SetScript("OnMouseDown", function()
									EncounterJournal_OpenJournal(difficulty, miog.MAP_INFO[mapID].journalInstanceID, nil, nil, nil, nil)
								end)
							end

							frame:SetScript("OnEnter", function(self)
								local tooltip = GameTooltip
								tooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)
		
								tooltip:SetText(isSpecificQueue and MULTIPLE_DUNGEONS or name, 1, 1, 1, true);

								if(hasData) then
									if(name2 and name ~= name2) then
										tooltip:AddLine(name2)
										
									end

									tooltip:AddLine(string.format(DUNGEON_DIFFICULTY_BANNER_TOOLTIP, miog.DIFFICULTY_ID_INFO[difficulty].name))

									if(IsPlayerAtEffectiveMaxLevel() and minLevel == UnitLevel("player")) then
										tooltip:AddLine("Max level dungeon")
										
									else
										tooltip:AddLine(isScalingDungeon and "Scales with level (" .. string.format("%d - %d", minLevel, maxLevel) .. ")" or "Doesn't scale with level")

									end
									tooltip:AddLine(string.format("%d - %d players", minPlayersDisband and minPlayersDisband > 0 and minPlayersDisband or 1, maxPlayers))
		
									GameTooltip_AddBlankLineToTooltip(GameTooltip)

									if(isTimewalker) then
										tooltip:AddLine(PLAYER_DIFFICULTY_TIMEWALKER)
									end

									if(isHoliday) then
										tooltip:AddLine(CALENDAR_FILTER_HOLIDAYS)
									end

									if(bonusRep > 0) then
										tooltip:AddLine(string.format(LFG_BONUS_REPUTATION, bonusRep))
										
									end
		
									tooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS, totalTanks + totalHealers + totalDPS - tankNeeds - healerNeeds - dpsNeeds, totalTanks - tankNeeds, totalHealers - healerNeeds, totalDPS - dpsNeeds));
		
									if ( queuedTime > 0 ) then
										tooltip:AddLine(string.format("Queued for: |cffffffff%s|r", formatter:Format(GetTime() - queuedTime)));
									end
		
									GameTooltip_AddBlankLineToTooltip(GameTooltip)
									
									tooltip:AddLine("Wait times:");
		
									if ( myWait > 0 ) then
										tooltip:AddLine(string.format("~ |cffffffff%s|r", formatter:Format(myWait)));
									end
		
									if ( averageWait > 0 ) then
										tooltip:AddLine(string.format("Ø |cffffffff%s|r", formatter:Format(averageWait)));
									end
		
									if ( tankWait > 0 ) then
										tooltip:AddLine(string.format("|A:GO-icon-role-Header-Tank:14:14|a |cffffffff%s|r", formatter:Format(tankWait)));
									end
		
									if ( healerWait > 0 ) then
										tooltip:AddLine(string.format("|A:GO-icon-role-Header-Healer:14:14|a |cffffffff%s|r", formatter:Format(healerWait)));
									end
		
									if ( damageWait > 0 ) then
										tooltip:AddLine(string.format("|A:GO-icon-role-Header-DPS:14:14|a |cffffffff%s|r", formatter:Format(damageWait)));
									end
		
									if(isSpecificQueue) then
										GameTooltip_AddBlankLineToTooltip(GameTooltip)
		
										tooltip:AddLine(QUEUED_FOR_SHORT)
		
										table.sort(specificQueueDungeons, function(k1, k2)
											if(k1.difficulty == k2.difficulty) then
												return k1.dungeonID < k2.dungeonID
											end
		
											return k1.difficulty < k2.difficulty
										end)
		
										for _, v in ipairs(specificQueueDungeons) do
											tooltip:AddLine(v.difficulty .. " " .. v.name)
		
										end
									end
		
								else
									tooltip:AddLine(WrapTextInColorCode("Still waiting for data from Blizzard...", miog.CLRSCC.red));
								
								end
		
								GameTooltip:Show()
							end)
							frame:SetScript("OnLeave", function()
								GameTooltip:Hide()
							end)
						end
					end
				end
			
				if(activeID) then
					if ( mode == "queued" ) then

						local inParty, joined, queued, noPartialClear, achievements, lfgComment, slotCount, _, leader, tank, healer, dps = GetLFGInfoServer(categoryID, activeID);
						local hasData,  leaderNeeds, tankNeeds, healerNeeds, dpsNeeds, totalTanks, totalHealers, totalDPS, instanceType, instanceSubType, instanceName, averageWait, tankWait, healerWait, damageWait, myWait, queuedTime = GetLFGQueueStats(categoryID, activeID);
						if(categoryID == LE_LFG_CATEGORY_SCENARIO) then --Hide roles for scenarios
							tank, healer, dps = nil, nil, nil;
							totalTanks, totalHealers, totalDPS, tankNeeds, healerNeeds, dpsNeeds = nil, nil, nil, nil, nil, nil;

						elseif(categoryID == LE_LFG_CATEGORY_WORLDPVP) then
							--QueueStatusEntry_SetMinimalDisplay(entry, GetDisplayNameFromCategory(category), QUEUED_STATUS_IN_PROGRESS, subTitle, extraText);
						else
							--QueueStatusEntry_SetFullDisplay(entry, GetDisplayNameFromCategory(category), queuedTime, myWait, tank, healer, dps, totalTanks, totalHealers, totalDPS, tankNeeds, healerNeeds, dpsNeeds, subTitle, extraText);
							--createQueueFrame(categoryID, {GetLFGDungeonInfo(activeID)}, {GetLFGQueueStats(categoryID)})
						end
					elseif ( mode == "proposal" ) then
						--QueueStatusEntry_SetMinimalDisplay(entry, GetDisplayNameFromCategory(category), QUEUED_STATUS_PROPOSAL, subTitle, extraText);
					elseif ( mode == "listed" ) then
						--QueueStatusEntry_SetMinimalDisplay(entry, GetDisplayNameFromCategory(category), QUEUED_STATUS_LISTED, subTitle, extraText);
					elseif ( mode == "suspended" ) then
						--QueueStatusEntry_SetMinimalDisplay(entry, GetDisplayNameFromCategory(category), QUEUED_STATUS_SUSPENDED, subTitle, extraText);
					elseif ( mode == "rolecheck" ) then
						--QueueStatusEntry_SetMinimalDisplay(entry, GetDisplayNameFromCategory(category), QUEUED_STATUS_ROLE_CHECK_IN_PROGRESS, subTitle, extraText);
					elseif ( mode == "lfgparty" or mode == "abandonedInDungeon" ) then
						--[[local title;
						if (C_PvP.IsInBrawl()) then
							local brawlInfo = C_PvP.GetActiveBrawlInfo();
							if (brawlInfo and brawlInfo.canQueue and brawlInfo.longDescription) then
								title = brawlInfo.name;
								if (subTitle) then
									subTitle = QUEUED_STATUS_BRAWL_RULES_SUBTITLE:format(brawlInfo.longDescription, subTitle);
								else
									subTitle = brawlInfo.longDescription;
								end
							end
						else
							title = GetDisplayNameFromCategory(category);
						end
						
						QueueStatusEntry_SetMinimalDisplay(entry, title, QUEUED_STATUS_IN_PROGRESS, subTitle, extraText);]]
					else
						--QueueStatusEntry_SetMinimalDisplay(entry, GetDisplayNameFromCategory(category), QUEUED_STATUS_UNKNOWN, subTitle, extraText);
					end
				end
				
				queueIndex = queueIndex + 1
			end
		end

		--Try LFGList entries
		local isActive = C_LFGList.HasActiveEntryInfo();
		if ( isActive ) then
			local activeEntryInfo = C_LFGList.GetActiveEntryInfo();
			local numApplicants, numActiveApplicants = C_LFGList.GetNumApplicants();
			--QueueStatusEntry_SetMinimalDisplay(entry, activeEntryInfo.name, QUEUED_STATUS_LISTED, string.format(LFG_LIST_PENDING_APPLICANTS, numActiveApplicants));
			local activityInfo = C_LFGList.GetActivityInfoTable(activeEntryInfo.activityID)
			local groupInfo = C_LFGList.GetActivityGroupInfo(activityInfo.groupFinderActivityGroupID)

			local unitName, unitID = miog.getGroupLeader()

			local frameData = {
				[1] = true,
				[2] = groupInfo or activityInfo.shortName,
				[11] = unitID == "player" and "Your Listing" or (unitName or "Unknown") .. "'s Listing",
				[12] = -1,
				[17] = {"duration", activeEntryInfo.duration},
				[18] = "YOURLISTING",
				[20] = miog.ACTIVITY_INFO[activeEntryInfo.activityID].icon or nil,
				[21] = -2,
				[30] = miog.ACTIVITY_INFO[activeEntryInfo.activityID] and miog.ACTIVITY_INFO[activeEntryInfo.activityID].horizontal or activityInfo.groupFinderActivityGroupID == 0 and miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/dungeon.png" or nil
			}

			local frame = createQueueFrame(frameData)

			if(frame) then
				frame.CancelApplication:SetShown(UnitIsGroupLeader("player"))
				--[[frame.CancelApplication:SetScript("OnClick", function()
					C_LFGList.RemoveListing()
				end)]]

				frame.CancelApplication:SetAttribute("type", "macro")
				frame.CancelApplication:SetAttribute("macrotext1", "/run C_LFGList.RemoveListing()")

				frame:SetScript("OnMouseDown", function()
					PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
					LFGListFrame_SetActivePanel(LFGListFrame, LFGListFrame.ApplicationViewer)
				end)
				frame:SetScript("OnEnter", function(self)
					self.BackgroundHover:Show()
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
					GameTooltip:SetText(string.format(LFG_LIST_PENDING_APPLICANTS, numActiveApplicants))

					if(activeEntryInfo.questID and activeEntryInfo.questID > 0) then
						GameTooltip:AddLine(LFG_TYPE_QUEST .. ": " .. C_QuestLog.GetTitleForQuestID(activeEntryInfo.questID))
						
					end

					GameTooltip:Show()
				end)
				frame:SetScript("OnLeave", function(self)
					self.BackgroundHover:Hide()
					GameTooltip:Hide()
				end)
			end

			--createQueueFrame(categoryID, {GetLFGDungeonInfo(activeID)}, {GetLFGQueueStats(categoryID)})
		end

		--Try LFGList applications
		local applications = C_LFGList.GetApplications()
		if(applications) then
			for _, v in ipairs(applications) do
			--for i=1, #apps do
				local id, appStatus, pendingStatus, appDuration, appRole = C_LFGList.GetApplicationInfo(v)

				if(id) then
					local identifier = "APPLICATION_" .. id
					if(appStatus == "applied" or appStatus == "invited") then
						local searchResultInfo = C_LFGList.GetSearchResultInfo(id);
						--local activityName = C_LFGList.GetActivityFullName(searchResultInfo.activityID, nil, searchResultInfo.isWarMode);

						local activityInfo = C_LFGList.GetActivityInfoTable(searchResultInfo.activityID)
						local groupInfo = C_LFGList.GetActivityGroupInfo(activityInfo.groupFinderActivityGroupID)
				
						local frameData = {
							[1] = true,
							[2] = groupInfo,
							[11] = searchResultInfo.name,
							[12] = -1,
							[17] = {"duration", appDuration},
							[18] = identifier,
							[20] = miog.ACTIVITY_INFO[searchResultInfo.activityID].icon or nil,
							[21] = id,
							[30] = miog.ACTIVITY_INFO[searchResultInfo.activityID] and miog.ACTIVITY_INFO[searchResultInfo.activityID].horizontal or nil
						}

						if(appStatus == "applied") then
							local frame = createQueueFrame(frameData)

							if(frame) then
								frame.CancelApplication:SetAttribute("type", "macro")
								frame.CancelApplication:SetAttribute("macrotext1", "/run C_LFGList.CancelApplication(" .. id .. ")")

								frame:SetScript("OnMouseDown", function()
									PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
									--LFGListSearchPanel_Clear(LFGListFrame.SearchPanel)
									LFGListSearchPanel_SetCategory(LFGListFrame.SearchPanel, activityInfo.categoryID, LFGListFrame.SearchPanel.preferredFilters or 0, LFGListFrame.baseFilters)

									if(LFGListFrame.SearchPanel.filters == 0 or LFGListFrame.SearchPanel.filters == nil or LFGListFrame.SearchPanel.preferredFilters == nil) then
										LFGListSearchPanel_DoSearch(LFGListFrame.SearchPanel)
									end
									
									LFGListFrame_SetActivePanel(LFGListFrame, LFGListFrame.SearchPanel)
								end)

								local eligible, reason = miog.isGroupEligible(id, true)

								if(eligible == false) then
									frame.Name:SetTextColor(1, 0, 0, 1)

									if(reason) then
										frame.Name:SetText(frame.Name:GetText() .. " - " .. reason[2])
									end
								end

								frame:SetScript("OnEnter", function(self)
									miog.createResultTooltip(id, frame)

									GameTooltip:Show()
								end)
								frame:SetScript("OnLeave", function()
									GameTooltip:Hide()
								end)
							end

							queueIndex = queueIndex + 1
						end
					end
				end
			end
		end
	--[[
		local inProgress, _, _, _, _, isBattleground = GetLFGRoleUpdate();

		--Try PvP Role Check
		if ( inProgress and isBattleground ) then
			QueueStatusEntry_SetUpPVPRoleCheck(entry);
		end

		local readyCheckInProgress, readyCheckIsBattleground = GetLFGReadyCheckUpdate();

		-- Try PvP Ready Check
		if ( readyCheckInProgress and readyCheckIsBattleground ) then
			QueueStatusEntry_SetUpPvPReadyCheck(entry);
		end]]

		--Try all PvP queues
		for i=1, GetMaxBattlefieldID() do
			local status, mapName, teamSize, registeredMatch, suspend, queueType, gameType, role, asGroup, shortDescription, longDescription, isSoloQueue = GetBattlefieldStatus(i);

			if ( status and status ~= "none" and status ~= "error" ) then
				local queuedTime = GetTime() - GetBattlefieldTimeWaited(i) / 1000
				local estimatedTime = GetBattlefieldEstimatedWaitTime(i) / 1000
				local assignedSpec = C_PvP.GetAssignedSpecForBattlefieldQueue(i);
				local allowsDecline = PVPHelper_QueueAllowsLeaveQueueWithMatchReady(queueType)
				
				local frameData = {
					[1] = true,
					[2] = gameType,
					[11] = mapName,
					[12] = estimatedTime,
					[17] = {"queued", queuedTime},
					[18] = mapName,
					[20] = miog.findBattlegroundIconByName(mapName) or miog.findBrawlIconByName(mapName) or 525915
				}

				local frame

				if (mapName and queuedTime) then
					frame = createQueueFrame(frameData)
					--frame.CancelApplication:Hide()

					if(frame) then
						local mapIDTable = miog.findBattlegroundMapIDsByName(mapName) or miog.findBrawlMapIDsByName(mapName)

						if(mapName == "Random Epic Battleground") then
							frame.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/epicbgs.png")

						elseif(mapName == "Random Battleground") then
							frame.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/normalbgs.png")

						elseif(mapIDTable and #mapIDTable > 0) then
							local counter = 0
							local randomNumber = random(1, #mapIDTable)

							for k, v in pairs(mapIDTable) do
								counter = counter + 1

								if(counter == randomNumber) then
									frame.Background:SetTexture(miog.MAP_INFO[v].horizontal)
									break
								end
							end
						else
							frame.Background:SetTexture(miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/pvpbattleground.png")
						
						end

						frame:SetScript("OnEnter", function(self)
							local tooltip = GameTooltip
							GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, 0)

							tooltip:SetText(mapName, 1, 1, 1, true);

							if(role ~= "") then
								tooltip:AddLine(LFG_TOOLTIP_ROLES .. " " .. string.lower(role):gsub("^%l", string.upper));
							end

							if(role ~= "") then
								tooltip:AddLine(LFG_TOOLTIP_ROLES .. " " .. string.lower(role):gsub("^%l", string.upper));
							end

							if(assignedSpec) then
								tooltip:AddLine(ASSIGNED_COLON .. miog.SPECIALIZATIONS[assignedSpec].name);
							end
							
							GameTooltip_AddBlankLineToTooltip(GameTooltip)

							if ( queuedTime > 0 ) then
								tooltip:AddLine(string.format("Queued for: |cffffffff%s|r", SecondsToTime(GetTime() - queuedTime, false, false, 1, false)));
							end

							if ( estimatedTime > 0 ) then
								tooltip:AddLine(string.format("Average wait time: |cffffffff%s|r", SecondsToTime(estimatedTime, false, false, 1, false)));
							end

							if(teamSize > 0) then
								tooltip:AddLine(teamSize);
							end


							GameTooltip:Show()
						end)

						frame:SetScript("OnLeave", function()
							GameTooltip:Hide()
						end)
						
						--queueSystem.queueFrames[mapName].CancelApplication:SetScript("OnClick",  SecureActionButton_OnClick)
					end
				end

				
				if (frame and status == "queued" ) then
					if ( suspend ) then
						--QueueStatusEntry_SetMinimalDisplay(entry, mapName, QUEUED_STATUS_SUSPENDED);
					else
						--QueueStatusEntry_SetFullDisplay(entry, mapName, queuedTime, estimatedTime, isTank, isHealer, isDPS, totalTanks, totalHealers, totalDPS, tankNeeds, healerNeeds, dpsNeeds, subTitle, extraText, assignedSpec);


						--local isTank, isHealer, isDPS, totalTanks, totalHealers, totalDPS, tankNeeds, healerNeeds, dpsNeeds, subTitle, extraText = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil;
						--local assignedSpec = C_PvP.GetAssignedSpecForBattlefieldQueue(i);

						--		1		2			3			4			5			6			7				8		9				10				11				12			13			14			15		16			17
						--local hasData, leaderNeeds, tankNeeds, healerNeeds, dpsNeeds, totalTanks, totalHealers, totalDPS, instanceType, instanceSubType, instanceName, averageWait, tankWait, healerWait, damageWait, myWait, queuedTime

						saveTempButton(queueIndex)
						
						--[[if(not MIOG_TempButton.GetElementDescription) then
							MIOG_TempButton.GetElementDescription = function()
								return {
									CanOpenSubmenu = function() return true end,
									ShouldPlaySoundOnSubmenuClick = function() return false end,
									Pick = function() end
								}
							end

						end]]
						
						frame.CancelApplication:SetAttribute("type", "macro")
						frame.CancelApplication:SetAttribute("macrotext1", "/click QueueStatusButton RightButton")
						--frame.CancelApplication:SetAttribute("macrotext1", "/click " .. MIOG_TempButton:GetDebugName() .. " LeftButton")

						queueIndex = queueIndex + 1
						

					end
				elseif ( status == "confirm" ) then
					
					--[[local currentDeclineButton = queueIndex == 1 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button3 Left Button"
					or queueIndex == 2 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button6 Left Button"
					or queueIndex == 3 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button9 Left Button"
					or queueIndex == 4 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button12 Left Button"
					or queueIndex == 5 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button15 Left Button"
					or queueIndex == 6 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button18 Left Button"
					or queueIndex == 7 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button21 Left Button"
					or queueIndex == 8 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button24 Left Button"
					or queueIndex == 9 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button27 Left Button"
					or queueIndex == 10 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button30 Left Button"
					or queueIndex == 11 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button33 Left Button"
					or queueIndex == 12 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button36 Left Button"
					

					local currentAcceptButton = queueIndex == 1 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button2 Left Button"
					or queueIndex == 2 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button4 Left Button"
					or queueIndex == 3 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button6 Left Button"
					or queueIndex == 4 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button8 Left Button"
					or queueIndex == 5 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button10 Left Button"
					or queueIndex == 6 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button12 Left Button"
					or queueIndex == 7 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button14 Left Button"
					or queueIndex == 8 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button16 Left Button"
					or queueIndex == 9 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button18 Left Button"
					or queueIndex == 10 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button20 Left Button"
					or queueIndex == 11 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button22 Left Button"
					or queueIndex == 12 and "/click QueueStatusButton RightButton" .. "\r\n" .. "/click [nocombat]DropDownList1Button24 Left Button"]]

				
				elseif ( status == "active" ) then
					if (mapName) then
						--local hasLongDescription = longDescription and longDescription ~= "";
						--local text = hasLongDescription and longDescription or nil;
						--QueueStatusEntry_SetMinimalDisplay(entry, mapName, QUEUED_STATUS_IN_PROGRESS, text);
					else
						--QueueStatusEntry_SetMinimalDisplay(entry, mapName, QUEUED_STATUS_IN_PROGRESS);
					end
				elseif ( status == "locked" ) then
					--QueueStatusEntry_SetMinimalDisplay(entry, mapName, QUEUED_STATUS_LOCKED, QUEUED_STATUS_LOCKED_EXPLANATION);
				else
					--QueueStatusEntry_SetMinimalDisplay(entry, mapName, QUEUED_STATUS_UNKNOWN);
				end
			elseif(status) then
			
			end
		end

		--Try all World PvP queues
		for i=1, MAX_WORLD_PVP_QUEUES do
			local status, mapName, queueID, expireTime, averageWaitTime, queuedTime, suspended = GetWorldPVPQueueStatus(i)
			if ( status and status ~= "none" ) then
				--QueueStatusEntry_SetUpWorldPvP(entry, i);
				local frameData = {
					[1] = true,
					[2] = "",
					[11] = "World PvP",
					[12] = averageWaitTime,
					[17] = {"queued", queuedTime},
					[18] = mapName or ("WORLDPVP" .. i),
					[30] = miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/pvpbattleground.png",
				}
		
				if (status == "queued") then
					local frame = createQueueFrame(frameData)
					--frame.Icon:Show()
		
					if(frame) then
						frame.CancelApplication:SetAttribute("type", "macro")
						frame.CancelApplication:SetAttribute("macrotext1", "/run BattlefieldMgrExitRequest(" .. queueID .. ")")
		
					end
		
					queueIndex = queueIndex + 1
		
				elseif(status == "proposal") then
					
				
				end
			end
		end

		--World PvP areas we're currently in
		if ( CanHearthAndResurrectFromArea() ) then
			local frameData = {
				[1] = true,
				[2] = "",
				[11] = "Open World PvP",
				[12] = 0,
				[17] = {"queued", GetTime()},
				[18] = GetRealZoneText(),
				[30] = miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/pvpbattleground.png",
			}

			local frame = createQueueFrame(frameData)
			--frame.Icon:Show()

			if(frame) then
				frame.CancelApplication:SetAttribute("type", "macro")
				frame.CancelApplication:SetAttribute("macrotext1", "/run HearthAndResurrectFromArea()")

			end

			queueIndex = queueIndex + 1

		end

		--Pet Battle PvP Queue
		local pbStatus, estimate, queued = C_PetBattles.GetPVPMatchmakingInfo();
		if ( pbStatus ) then
			local frameData = {
				[1] = true,
				[2] = "",
				[11] = "Pet Battle",
				[12] = estimate,
				[17] = {"queued", queued},
				[18] = "PETBATTLE",
				[20] = miog.C.STANDARD_FILE_PATH .. "/infoIcons/petbattle.png",
				[30] = miog.C.STANDARD_FILE_PATH .. "/backgrounds/horizontal/petbattle.png",
			}

			if (pbStatus == "queued") then
				local frame = createQueueFrame(frameData)
				--frame.Icon:Show()

				if(frame) then
					--queueSystem.queueFrames["PETBATTLE"].CancelApplication:SetAttribute("type", "macro")
					--queueSystem.queueFrames["PETBATTLE"].CancelApplication:SetAttribute("macrotext1", "/run C_PetBattles.StopPVPMatchmaking()")
					--[[frame.CancelApplication:SetScript("OnClick", function()
						C_PetBattles.StopPVPMatchmaking()
					end)]]

					frame.CancelApplication:SetAttribute("type", "macro")
					frame.CancelApplication:SetAttribute("macrotext1", "/run C_PetBattles.StopPVPMatchmaking()")

				end

				queueIndex = queueIndex + 1

			elseif(pbStatus == "proposal") then
			
			end
		end
	else
		miog.F.UPDATE_AFTER_COMBAT = true

	end
end

miog.loadQueueSystem = function()
	queueSystem.framePool = CreateFramePool("Frame", miog.MainTab.QueueInformation.Panel.ScrollFrame.Container, "MIOG_QueueFrame", resetQueueFrame)
	hooksecurefunc(QueueStatusFrame, "Update", checkQueues)

	local eventReceiver = CreateFrame("Frame", "MythicIOGrabber_QueueEventReceiver")

	eventReceiver:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
	eventReceiver:RegisterEvent("LFG_UPDATE")
	eventReceiver:RegisterEvent("LFG_LOCK_INFO_RECEIVED")
	eventReceiver:RegisterEvent("GROUP_ROSTER_UPDATE")
	eventReceiver:RegisterEvent("LFG_LIST_AVAILABILITY_UPDATE")
	eventReceiver:RegisterEvent("LFG_QUEUE_STATUS_UPDATE")
	eventReceiver:RegisterEvent("PVP_BRAWL_INFO_UPDATED")
	eventReceiver:RegisterEvent("PLAYER_REGEN_DISABLED")
	eventReceiver:RegisterEvent("PLAYER_REGEN_ENABLED")
	eventReceiver:SetScript("OnEvent", miog.queueEvents)

	if(HonorFrameTypeDropdown_OnClick) then
		hooksecurefunc("HonorFrameTypeDropdown_OnClick", function(self)
			randomBGFrame:SetShown(self.value == "bonus")
			randomEpicBGFrame:SetShown(self.value == "bonus")

			specificBox:SetShown(self.value == "specific")
			specificBox:GetParent():MarkDirty()
		end)
	end

	if(HonorFrame.TypeDropdown) then
		hooksecurefunc("HonorFrame_SetTypeInternal", function(value)
			randomBGFrame:SetShown(value == "bonus")
			randomEpicBGFrame:SetShown(value == "bonus")

			specificBox:SetShown(value == "specific")
			specificBox:GetParent():MarkDirty()
		end)
	end
end

local function updateRandomDungeons(blizzDesc)
	--[[local queueDropDown = miog.MainTab.QueueInformation.DropDown
	local info = {}
	info.entryType = "option"
	info.level = 2
	info.index = nil

	for i=1, GetNumRandomDungeons() do
		local id, name, typeID, subtypeID, _, _, _, _, _, _, _, fileID, difficultyID, _, _, isHolidayDungeon, _, _, isTimewalkingDungeon, name2, minGearLevel, isScalingDungeon = GetLFGRandomDungeonInfo(i)
		
		local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(id);

		if((isAvailableForPlayer or not hideIfNotJoinable)) then
			if(isAvailableForAll) then
				local mode = GetLFGMode(1, id)
				info.text = isHolidayDungeon and "(Event) " .. name or name

				info.checked = mode == "queued"
				info.icon = miog.LFG_ID_INFO[id] and miog.LFG_ID_INFO[id].icon or fileID or miog.LFG_DUNGEONS_INFO[id] and miog.LFG_DUNGEONS_INFO[id].expansionLevel and miog.EXPANSION_INFO[miog.LFG_DUNGEONS_INFO[id].expansionLevel][3] or nil
				info.parentIndex = subtypeID
				info.index = -1
				info.type2 = "random"

				info.func = function()
					ClearAllLFGDungeons(1);
					SetLFGDungeon(1, id);
					JoinSingleLFG(1, id);

					MIOG_NewSettings.lastUsedQueue = {type = "pve", subtype="dng", id = id}
				end
				
				local tempFrame = queueDropDown:CreateEntryFrame(info)
				tempFrame:SetScript("OnShow", function(self)
					local tempMode = GetLFGMode(1, id)
					self.Radio:SetChecked(tempMode == "queued")
					
				end)

				blizzDesc[difficultyID] = blizzDesc[difficultyID] or {}
				blizzDesc[difficultyID][#blizzDesc[difficultyID]+1] = {name = name, id = id, icon = info.icon}
			end
		end
	end]]
end

miog.updateRandomDungeons = updateRandomDungeons

local function sortAndAddDungeonList(list, enableOnShow)
	local queueDropDown = miog.MainTab.QueueInformation.DropDown

	table.sort(list, function(k1, k2)
		if(k1.expansionLevel == k2.expansionLevel) then
			if(k1.type1 == k2.type1) then
				return k1.text < k2.text
			end

			return k1.type1 > k2.type1
		end

		return k1.expansionLevel > k2.expansionLevel
	end)

	local lastExp = nil

	for k, v in pairs(list) do
		if(lastExp and lastExp ~= v.expansionLevel) then
			queueDropDown:CreateSeparator(nil, v.parentIndex)

		end

		local tempFrame = queueDropDown:CreateEntryFrame(v)

		if(enableOnShow) then
			tempFrame:SetScript("OnShow", function(self)
				local tempMode = GetLFGMode(1, v.id)
				self.Radio:SetChecked(tempMode == "queued")
				
			end)
		end
		
		lastExp = v.expansionLevel
	end
end

local function updateDungeons(overwrittenParentIndex, blizzDesc)
	local dungeonList = GetLFDChoiceOrder() or {}

	local normalDungeonList = {}
	local heroicDungeonList = {}
	local followerDungeonList = {}

	-- local mythicDungeonList (we can only hope)

	LFGEnabledList = GetLFDChoiceEnabledState(LFGEnabledList)

	local selectedDungeonsList = {}

	if(not overwrittenParentIndex) then
		for i=1, GetNumRandomDungeons() do
			local id, name, typeID, subtypeID, _, _, _, _, _, expLevel, _, fileID, difficultyID, _, _, isHolidayDungeon, _, _, isTimewalkingDungeon, name2, minGearLevel, isScalingDungeon = GetLFGRandomDungeonInfo(i)
			
			local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(id);
			local isFollowerDungeon = id >= 0 and C_LFGInfo.IsLFGFollowerDungeon(id)

			if((isAvailableForPlayer or not hideIfNotJoinable) and (subtypeID and difficultyID < 3 and not isFollowerDungeon or isFollowerDungeon)) then
				if(isAvailableForAll) then
					local mode = GetLFGMode(1, id)

					local info = {}
					info.text = isHolidayDungeon and "(Event) " .. name or name

					info.checked = mode == "queued"
					info.icon = miog.LFG_ID_INFO[id] and miog.LFG_ID_INFO[id].icon or fileID or miog.LFG_DUNGEONS_INFO[id] and miog.LFG_DUNGEONS_INFO[id].expansionLevel and miog.EXPANSION_INFO[miog.LFG_DUNGEONS_INFO[id].expansionLevel][3] or nil
					info.parentIndex = subtypeID
					info.type1 = typeID
					--info.index = -1
					info.expansionLevel = miog.LFG_DUNGEONS_INFO[id].expansionLevel or expLevel
					info.type2 = "random"

					info.func = function()
						ClearAllLFGDungeons(1);
						SetLFGDungeon(1, id);
						JoinSingleLFG(1, id);

						MIOG_NewSettings.lastUsedQueue = {type = "pve", subtype="dng", id = id}
					end
					
					--[[local tempFrame = queueDropDown:CreateEntryFrame(info)
					tempFrame:SetScript("OnShow", function(self)
						local tempMode = GetLFGMode(1, id)
						self.Radio:SetChecked(tempMode == "queued")
						
					end)]]

					blizzDesc[difficultyID] = blizzDesc[difficultyID] or {}
					blizzDesc[difficultyID][#blizzDesc[difficultyID]+1] = {name = name, id = id, icon = info.icon}

					if(isFollowerDungeon) then
						followerDungeonList[#followerDungeonList + 1] = info

					elseif(subtypeID == 1) then
						normalDungeonList[#normalDungeonList + 1] = info

					elseif(subtypeID == 2) then
						heroicDungeonList[#heroicDungeonList + 1] = info

					end
				end
			end
		end
	end

	for _, dungeonID in pairs(dungeonList) do
		local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(dungeonID);
		local name, typeID, subtypeID, _, _, _, _, _, expLevel, groupID, fileID, difficultyID, _, _, isHolidayDungeon, _, _, isTimewalkingDungeon, name2, minGearLevel, isScalingDungeon, mapID = GetLFGDungeonInfo(dungeonID)

		local isFollowerDungeon = dungeonID >= 0 and C_LFGInfo.IsLFGFollowerDungeon(dungeonID)

		if((isAvailableForPlayer or not hideIfNotJoinable) and (subtypeID and difficultyID < 3 and not isFollowerDungeon or isFollowerDungeon)) then

			if(isAvailableForAll) then
				local info = {}
				info.entryType = "option"
				info.level = 2
				info.id = dungeonID
				info.type1 = typeID
				info.expansionLevel = miog.MAP_INFO[mapID].expansionLevel or expLevel

				info.text = isHolidayDungeon and "(Event) " .. name or name

				info.icon = miog.MAP_INFO[mapID] and miog.MAP_INFO[mapID].icon or miog.LFG_ID_INFO[dungeonID] and miog.LFG_ID_INFO[dungeonID].icon or fileID or nil

				info.parentIndex = overwrittenParentIndex or isFollowerDungeon and 3 or subtypeID

				if(overwrittenParentIndex) then
					info.func = function(self)
						selectedDungeonsList[dungeonID] = not selectedDungeonsList[dungeonID] and dungeonID or nil

						LFGEnabledList[dungeonID] = selectedDungeonsList[dungeonID]
					end
				else
					info.func = function()
						ClearAllLFGDungeons(1);
						SetLFGDungeon(1, dungeonID);
						JoinSingleLFG(1, dungeonID);

						MIOG_NewSettings.lastUsedQueue = {type = "pve", subtype="dng", id = dungeonID}

					end
				end

				blizzDesc[difficultyID] = blizzDesc[difficultyID] or {}
				blizzDesc[difficultyID][#blizzDesc[difficultyID]+1] = {name = name, id = dungeonID, icon = info.icon}

				if(isFollowerDungeon) then
					followerDungeonList[#followerDungeonList + 1] = info

				elseif(subtypeID == 1) then
					normalDungeonList[#normalDungeonList + 1] = info

				elseif(subtypeID == 2) then
					heroicDungeonList[#heroicDungeonList + 1] = info

				end
			end
		end
	end

	local queueDropDown = miog.MainTab.QueueInformation.DropDown

	if(overwrittenParentIndex) then
		if(#normalDungeonList > 0) then
			queueDropDown:CreateTextLine(nil, overwrittenParentIndex, LFG_TYPE_DUNGEON)
		end
	else
		local info = {}
		info.text = LFG_TYPE_DUNGEON
		info.hasArrow = true
		info.level = 1
		info.index = 1
		info.disabled = #normalDungeonList == 0
		queueDropDown:CreateEntryFrame(info)

	end

	sortAndAddDungeonList(normalDungeonList, overwrittenParentIndex == nil)

	if(overwrittenParentIndex) then
		if(#heroicDungeonList > 0) then
			queueDropDown:CreateTextLine(nil, overwrittenParentIndex, LFG_TYPE_HEROIC_DUNGEON)
		end
	else
		local info = {}
		info.text = LFG_TYPE_HEROIC_DUNGEON
		info.hasArrow = true
		info.level = 1
		info.index = 2
		info.disabled = #heroicDungeonList == 0
		queueDropDown:CreateEntryFrame(info)
	end

	sortAndAddDungeonList(heroicDungeonList, overwrittenParentIndex == nil)

	if(overwrittenParentIndex) then
		if(#followerDungeonList > 0) then
			queueDropDown:CreateTextLine(nil, overwrittenParentIndex, LFG_TYPE_FOLLOWER_DUNGEON)
		end
	else
		local info = {}
		info.text = LFG_TYPE_FOLLOWER_DUNGEON
		info.hasArrow = true
		info.level = 1
		info.index = 3
		info.disabled = #followerDungeonList == 0
		queueDropDown:CreateEntryFrame(info)
	end

	sortAndAddDungeonList(followerDungeonList, overwrittenParentIndex == nil)
	
	if(overwrittenParentIndex ~= nil) then
		queueDropDown:CreateFunctionButton(nil, overwrittenParentIndex, "Queue for multiple dungeons", function()
			LFG_JoinDungeon(1, "specific", selectedDungeonsList, {})

			MIOG_NewSettings.lastUsedQueue = {type = "pve", subtype="multidng", id = selectedDungeonsList}
		end)
	
	end
end

miog.updateDungeons = updateDungeons

local function IsRaidFinderDungeonDisplayable(id)
	local name, typeID, subtypeID, minLevel, maxLevel, _, _, _, expansionLevel = GetLFGDungeonInfo(id);
	local myLevel = UnitLevel("player");
	return myLevel >= minLevel and myLevel <= maxLevel and EXPANSION_LEVEL >= expansionLevel;
end


local function updateRaidFinder(blizzDesc)
	---@diagnostic disable-next-line: undefined-field
	local queueDropDown = miog.MainTab.QueueInformation.DropDown

	local info = {}
	info.entryType = "option"
	info.level = 2
	info.index = nil
	info.parentIndex = 5

	local nextLevel = nil;
	local playerLevel = UnitLevel("player")

	local lastRaidName

	local hasAnEntry = false

	for rfIndex = 1, GetNumRFDungeons() do
		local id, name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansion, _, fileID, difficultyID, _, _, isHolidayDungeon, _, _, isTimewalkingDungeon, raidName, minGearLevel, isScaling, mapID = GetRFDungeonInfo(rfIndex)
		local isAvailableForAll, isAvailableForPlayer, hideIfNotJoinable = IsLFGDungeonJoinable(id);

		if( not hideIfNotJoinable or isAvailableForAll ) then
			if ( isAvailableForAll or isAvailableForPlayer or IsRaidFinderDungeonDisplayable(id) ) then
				if (playerLevel >= minLevel and playerLevel <= maxLevel) then
					hasAnEntry = true

					local encounters;
					local numEncounters = GetLFGDungeonNumEncounters(id);
					for j = 1, numEncounters do
						local bossName, _, isKilled = GetLFGDungeonEncounterInfo(id, j);
						local colorCode = "";
						if ( isKilled ) then
							colorCode = RED_FONT_COLOR_CODE;
						end
						if encounters then
							encounters = encounters.."|n"..colorCode..bossName..FONT_COLOR_CODE_CLOSE;
						else
							encounters = colorCode..bossName..FONT_COLOR_CODE_CLOSE;
						end
					end
					
					local modifiedInstanceTooltipText = "";
					local icon = nil

					if(mapID) then
						local modifiedInstanceInfo = C_ModifiedInstance.GetModifiedInstanceInfoFromMapID(mapID)

						if (modifiedInstanceInfo) then
							icon = GetFinalNameFromTextureKit("%s-small", modifiedInstanceInfo.uiTextureKit);
							modifiedInstanceTooltipText = "|n|n" .. modifiedInstanceInfo.description;

						else
						
						end

						--info.iconXOffset = -6;
					end


					if(lastRaidName ~= raidName) then

						local textLine = queueDropDown:CreateTextLine(nil, info.parentIndex, miog.MAP_INFO[mapID].shortName, icon)

						if(icon) then
							textLine:SetTextColor(0.1,0.83,0.77,1)

						end

					end

					local mode = GetLFGMode(3, id)
					info.text = isHolidayDungeon and "(Event) " .. name or name
					info.checked = mode == "queued"
					--info.index = rfIndex
					info.icon = miog.MAP_INFO[mapID] and miog.MAP_INFO[mapID].icon or miog.LFG_ID_INFO[id] and miog.LFG_ID_INFO[id].icon or fileID or nil
					info.func = function()
						ClearAllLFGDungeons(3);
						SetLFGDungeon(3, id);
						JoinSingleLFG(3, id);

						MIOG_NewSettings.lastUsedQueue = {type = "pve", subtype="raid", id = id}
					end
					
					local tempFrame = queueDropDown:CreateEntryFrame(info)

					tempFrame:SetScript("OnShow", function(self)
						local tempMode = GetLFGMode(3, id)
						self.Radio:SetChecked(tempMode == "queued")
						
					end)

					tempFrame:HookScript("OnEnter", function(self)
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
						GameTooltip:SetText(RAID_BOSSES)
						GameTooltip:AddLine(encounters .. modifiedInstanceTooltipText, 1, 1, 1, true)
						GameTooltip:Show()
					end)

					tempFrame:HookScript("OnLeave", function()
						GameTooltip:Hide()
					end)

					if(icon) then
						tempFrame.Name:SetTextColor(0.1,0.83,0.77,1)
					end
					

					blizzDesc[difficultyID] = blizzDesc[difficultyID] or {}
					blizzDesc[difficultyID][#blizzDesc[difficultyID]+1] = {name = name, id = id, index = rfIndex, icon = info.icon}

					nextLevel = nil

					lastRaidName = raidName

				elseif ( playerLevel < minLevel and (not nextLevel or minLevel < nextLevel ) ) then
					nextLevel = minLevel

				end
			end
		end
	end

	local mainInfo = {}
	mainInfo.text = RAID_FINDER
	mainInfo.hasArrow = true
	mainInfo.level = 1
	mainInfo.index = 5
	mainInfo.disabled = not hasAnEntry
	queueDropDown:CreateEntryFrame(mainInfo)
end

miog.updateRaidFinder = updateRaidFinder

local function hideAllPVPButtonAssets(button)
	if(button.Tier) then
		button.Tier:ClearAllPoints()
		button.Tier:SetSize(20, 20)
		button.Tier:SetPoint("LEFT", button, "LEFT")
		button.Tier:Hide()

		button.TierIcon:ClearAllPoints()
		button.TierIcon:SetSize(5, 5)
		button.TierIcon:SetPoint("CENTER", button.Tier, "CENTER")
		button.TierIcon:Hide()
	end

	if(button.TeamSizeText) then
		button.TeamSizeText:ClearAllPoints()
		button.TeamSizeText:SetPoint("LEFT", button.Tier, "RIGHT")
		button.TeamSizeText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
	end

	if(button.TeamTypeText) then
		button.TeamTypeText:ClearAllPoints()
		button.TeamTypeText:SetPoint("LEFT", button.TeamSizeText, "RIGHT")
		button.TeamTypeText:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")
	end

	if(button.CurrentRating) then
		button.CurrentRating:Hide()
	end

	if(button.Title) then
		button.Title:ClearAllPoints()
		button.Title:SetPoint("LEFT", button, "LEFT", 20, 0)
		button.Title:SetFont("Fonts\\FRIZQT__.TTF", 11, "OUTLINE")

	end

	button.Reward:Hide()
end

local function resetPVPFrame(frame, parent, setScript)
	frame:ClearAllPoints()
	frame:SetParent(parent)
	frame:SetWidth(parent:GetWidth())
	frame:SetHeight(20)

	if(setScript) then
		hideAllPVPButtonAssets(frame)
		--frame:HookScript("OnShow", function(self)
		--end)
	end
end

local function updatePVP(parent)
	if(HonorFrame and ConquestFrame) then
		local groupSize = IsInGroup() and GetNumGroupMembers() or 1;

		local token, loopMax, generalTooltip;
		if (groupSize > (MAX_PARTY_MEMBERS + 1)) then
			token = "raid";
			loopMax = groupSize;
		else
			token = "party";
			loopMax = groupSize - 1; -- player not included in party tokens, just raid tokens
		end
		
		local maxLevel = GetMaxLevelForLatestExpansion();
		for i = 1, loopMax do
			if ( not UnitIsConnected(token..i) ) then
				generalTooltip = PVP_NO_QUEUE_DISCONNECTED_GROUP
				break;
			elseif ( UnitLevel(token..i) < maxLevel ) then
				generalTooltip = PVP_NO_QUEUE_GROUP
				break;
			end
		end

		local soloFrame = ConquestFrame.RatedSoloShuffle
		resetPVPFrame(soloFrame, parent, true)
		soloFrame.layoutIndex = 1

		local twoFrame = ConquestFrame.Arena2v2
		resetPVPFrame(twoFrame, parent, true)
		twoFrame.layoutIndex = 2

		local threeFrame = ConquestFrame.Arena3v3
		resetPVPFrame(threeFrame, parent, true)
		threeFrame.layoutIndex = 3

		local ratedBGFrame = ConquestFrame.RatedBG
		resetPVPFrame(ratedBGFrame, parent, true)
		ratedBGFrame.layoutIndex = 4

		local conquestJoinButton = ConquestFrame.JoinButton
		resetPVPFrame(conquestJoinButton, parent, false)
		conquestJoinButton.layoutIndex = 5

		local honorDropdown = HonorFrameTypeDropdown
		resetPVPFrame(honorDropdown, parent, false)
		honorDropdown:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -100)
		--honorDropdown.layoutIndex = 6

		
	end
end

local function updatePVP2()
	if(HonorFrame and ConquestFrame) then
		local queueDropDown = miog.MainTab.QueueInformation.DropDown

		local groupSize = IsInGroup() and GetNumGroupMembers() or 1;

		local token, loopMax, generalTooltip;
		if (groupSize > (MAX_PARTY_MEMBERS + 1)) then
			token = "raid";
			loopMax = groupSize;
		else
			token = "party";
			loopMax = groupSize - 1; -- player not included in party tokens, just raid tokens
		end
		
		local maxLevel = GetMaxLevelForLatestExpansion();
		for i = 1, loopMax do
			if ( not UnitIsConnected(token..i) ) then
				generalTooltip = PVP_NO_QUEUE_DISCONNECTED_GROUP
				break;
			elseif ( UnitLevel(token..i) < maxLevel ) then
				generalTooltip = PVP_NO_QUEUE_GROUP
				break;
			end
		end

		local info = {}
		info.entryType = "option"
		info.index = 1
		info.level = 2
		info.parentIndex = 6
		hideAllPVPButtonAssets(ConquestFrame.RatedSoloShuffle)
		local soloFrame = queueDropDown:InsertCustomFrame(info, ConquestFrame.RatedSoloShuffle)
		soloFrame:HookScript("OnShow", function(self)
			hideAllPVPButtonAssets(self)
		end)
		--ConquestFrame.RatedSoloShuffle:SetAttribute("type", "macro")
		--ConquestFrame.RatedSoloShuffle:SetAttribute("macrotext1", "/click [nocombat] ConquestJoinButton")

		info = {}
		info.entryType = "option"
		info.index = 2
		info.level = 2
		info.parentIndex = 6
		hideAllPVPButtonAssets(ConquestFrame.Arena2v2)
		local twosFrame = queueDropDown:InsertCustomFrame(info, ConquestFrame.Arena2v2)
		twosFrame:HookScript("OnShow", function(self)
			hideAllPVPButtonAssets(self)
		end)

		info = {}
		info.entryType = "option"
		info.index = 3
		info.level = 2
		info.parentIndex = 6
		hideAllPVPButtonAssets(ConquestFrame.Arena3v3)
		local threesFrame = queueDropDown:InsertCustomFrame(info, ConquestFrame.Arena3v3)
		threesFrame:HookScript("OnShow", function(self)
			hideAllPVPButtonAssets(self)
		end)

		info = {}
		info.entryType = "option"
		info.index = 4
		info.level = 2
		info.parentIndex = 6
		hideAllPVPButtonAssets(ConquestFrame.RatedBG)
		local ratedBGFrame = queueDropDown:InsertCustomFrame(info, ConquestFrame.RatedBG)
		ratedBGFrame:HookScript("OnShow", function(self)
			hideAllPVPButtonAssets(self)
		end)

		info = {}
		info.entryType = "option"
		info.index = 5
		info.level = 2
		info.parentIndex = 6
		--hideAllPVPButtonAssets(ConquestFrame.Arena2v2)
		queueDropDown:InsertCustomFrame(info, ConquestFrame.JoinButton)

		--[[soloFrame:SetScript("OnClick", function()
			--PVEFrame_ShowFrame("PVPUIFrame", "ConquestFrame")
			ConquestJoinButton:Click()

			--HideUIPanel(PVEFrame)
		end)]]

		--SlickDropDown:CreateExtraButton(ConquestFrame.RatedSoloShuffle, soloFrame)

		--info.func = function()
		--	JoinArena()
		--end

		--HonorFrame.BonusFrame.Arena1Button:Hide()
		--HonorFrame.BonusFrame.BrawlButton:Hide()
		--HonorFrame.BonusFrame.BrawlButton2:Hide()

		info = {}
		info.entryType = "option"
		info.index = 10
		info.level = 2
		info.parentIndex = 6
		HonorFrameTypeDropdown:SetHeight(20)
		local dropdown = queueDropDown:InsertCustomFrame(info, HonorFrameTypeDropdown)
		dropdown.topPadding = 8
		dropdown.bottomPadding = 8
		dropdown.leftPadding = 0
		--UIDropDownMenu_SetWidth(HonorFrameTypeDropdown, 190)
		dropdown:SetHeight(20)

		for index = 1, 5, 1 do
			local currentBGQueue = index == 1 and C_PvP.GetRandomBGInfo() or index == 2 and C_PvP.GetRandomEpicBGInfo() or index == 3 and C_PvP.GetSkirmishInfo(4) or index == 4 and C_PvP.GetAvailableBrawlInfo() or index == 5 and C_PvP.GetSpecialEventBrawlInfo()

			if(currentBGQueue and (index == 3 or currentBGQueue.canQueue)) then
				info = {}
				info.text = index == 1 and RANDOM_BATTLEGROUNDS or index == 2 and RANDOM_EPIC_BATTLEGROUND or index == 3 and SKIRMISH or currentBGQueue.name
				info.entryType = "option"
				info.checked = false
				info.index = index == 1 and 11 or index == 2 and 12 or index + 4
				--info.disabled = index == 1 or index == 2
				info.icon = index < 3 and miog.findBattlegroundIconByID(currentBGQueue.bgID) or index == 3 and currentBGQueue.icon or index > 3 and (miog.findBrawlIconByID(currentBGQueue.brawlID) or miog.findBrawlIconByName(currentBGQueue.name))
				info.level = 2
				info.parentIndex = 6
				info.disabled = index ~= 3 and currentBGQueue.canQueue == false or index == 3 and not HonorFrame.BonusFrame.Arena1Button.canQueue

				if(currentBGQueue.bgID) then
					if(currentBGQueue.bgID == 32) then
						hideAllPVPButtonAssets(HonorFrame.BonusFrame.RandomBGButton)
						randomBGFrame = queueDropDown:InsertCustomFrame(info, HonorFrame.BonusFrame.RandomBGButton)
						randomBGFrame:HookScript("OnShow", function(self)
							hideAllPVPButtonAssets(self)
							self:SetHeight(20)
						end)

					elseif(currentBGQueue.bgID == 901) then
						hideAllPVPButtonAssets(HonorFrame.BonusFrame.RandomEpicBGButton)
						randomEpicBGFrame = queueDropDown:InsertCustomFrame(info, HonorFrame.BonusFrame.RandomEpicBGButton)
						randomEpicBGFrame:HookScript("OnShow", function(self)
							hideAllPVPButtonAssets(self)
							self:SetHeight(20)
						end)

					end
				else
					if(index == 3) then
						--JoinSkirmish(4)
						--tempFrame:SetAttribute("macrotext1", "/run JoinSkirmish(4)")

						info.func = function()
							JoinSkirmish(4)
							MIOG_NewSettings.lastUsedQueue = {type = "pvp", subtype="skirmish", id = 0}
						end

						--info.tooltipTitle = info.text
						--info.tooltip = info.text

						skirmish = queueDropDown:CreateEntryFrame(info)
						skirmish:SetScript("OnEnter", function(self)
							PVPCasualActivityButton_OnEnter(self)
						end)
						skirmish.tooltipTableKey = "Skirmish"


					elseif(index == 4) then
						--tempFrame:SetAttribute("macrotext1", "/run C_PvP.JoinBrawl()")
						--C_PvP.JoinBrawl()

						info.func = function()
							C_PvP.JoinBrawl()

							MIOG_NewSettings.lastUsedQueue = {type = "pvp", subtype="brawl", id = 0}
						end

						--info.tooltipTitle = info.text
						--info.tooltip = info.text
						
						brawl1 = queueDropDown:CreateEntryFrame(info)
						brawl1:SetScript("OnEnter", function(self)
							PVPCasualActivityButton_OnEnter(self)
						end)
						brawl1.tooltipTableKey = "Brawl"

					elseif(index == 5) then
						--tempFrame:SetAttribute("macrotext1", "/run C_PvP.JoinBrawl(true)")
						--C_PvP.JoinBrawl(true)

						info.func = function()
							C_PvP.JoinBrawl(true)

							MIOG_NewSettings.lastUsedQueue = {type = "pvp", subtype="brawlSpecial", id = 0}
						end
						
						brawl2 = queueDropDown:CreateEntryFrame(info)

						brawl2:SetScript("OnEnter", function(self)
							PVPCasualActivityButton_OnEnter(self)
						end)
						brawl2.tooltipTableKey = "SpecialEventBrawl"
						--info.tooltipTitle = info.text
						--info.tooltip = info.text
					
					end
				end
			end
		end

		info = {}
		info.entryType = "option"
		info.index = 15
		info.level = 2
		info.parentIndex = 6
		specificBox = queueDropDown:InsertCustomFrame(info, HonorFrame.SpecificScrollBox)
		specificBox.leftPadding = -3
		specificBox:SetHeight(120)

		HonorFrame.SpecificScrollBar:ClearAllPoints()
		HonorFrame.SpecificScrollBar:SetPoint("TOPLEFT", HonorFrame.SpecificScrollBox, "TOPRIGHT", -10, 0)
		HonorFrame.SpecificScrollBar:SetPoint("BOTTOMLEFT", HonorFrame.SpecificScrollBox, "BOTTOMRIGHT", -10, 0)
		HonorFrame.SpecificScrollBar:SetParent(HonorFrame.SpecificScrollBox)

		randomBGFrame:SetShown(HonorFrame.type == "bonus")
		randomEpicBGFrame:SetShown(HonorFrame.type == "bonus")

		specificBox:SetShown(HonorFrame.type == "specific")
		specificBox:GetParent():MarkDirty()

		--[[info = {}
		info.entryType = "option"
		info.index = 15
		info.level = 2
		info.parentIndex = 6
		hideAllPVPButtonAssets(ConquestFrame.RatedBG)
		local specific1 = queueDropDown:InsertCustomFrame(info, ConquestFrame.RatedBG)
		ratedBGFrame:HookScript("OnShow", function(self)
			hideAllPVPButtonAssets(self)
		end)]]

		info = {}
		info.entryType = "option"
		info.index = 30
		info.level = 2
		info.parentIndex = 6
		--hideAllPVPButtonAssets(ConquestFrame.Arena2v2)
		queueDropDown:InsertCustomFrame(info, HonorFrame.QueueButton)
	end
end

local function updateDropDown()
	if(not InCombatLockdown()) then
		local blizzardDropDownDescriptions = {}

		local queueDropDown = miog.MainTab.QueueInformation.DropDown
		queueDropDown:ResetDropDown()

		queueDropDown.List.selfCheck = true

		local info = {}
		
		info.text = SPECIFIC_DUNGEONS
		info.hasArrow = true
		info.level = 1
		info.index = 4
		info.hideOnClick = false
		queueDropDown:CreateEntryFrame(info)

		info = {}
		info.text = PLAYER_V_PLAYER
		info.hasArrow = true
		info.level = 1
		info.index = 6
		queueDropDown:CreateEntryFrame(info)

		info = {}
		info.text = PET_BATTLE_PVP_QUEUE
		info.checked = false
		info.entryType = "option"
		info.level = 1
		info.value = "PETBATTLEQUEUEBUTTON"
		info.index = 7
		info.func = function()
			C_PetBattles.StartPVPMatchmaking()

			MIOG_NewSettings.lastUsedQueue = {type = "pvp", subtype="pet", id = 0}
		end

		local tempFrame = queueDropDown:CreateEntryFrame(info)
		tempFrame:SetScript("OnShow", function(self)
			self.Radio:SetChecked(C_PetBattles.GetPVPMatchmakingInfo() ~= nil)
			
		end)

		info = {}
		info.entryType = "option"
		info.level = 2
		info.index = nil

		updateRandomDungeons(blizzardDropDownDescriptions)
		updateDungeons(nil, blizzardDropDownDescriptions)
		updateDungeons(4, blizzardDropDownDescriptions)
		updateRaidFinder(blizzardDropDownDescriptions)

		if(HonorFrameTypeDropdown) then
			updatePVP2()
		end
		
		--[[local blizzardDropDown = miog.pveFrame2.TabFramesPanel.MainTab.QueueInformation.BlizzardDropdown

		local selectedDungeonsList = {}

		blizzardDropDown:SetupMenu(function(dropdown, rootDescription)
			local dungeonButton = rootDescription:CreateButton(LFG_TYPE_DUNGEON)

			for k, v in pairs(blizzardDropDownDescriptions[1]) do
				local entryButton = dungeonButton:CreateButton(v.name, function()
					ClearAllLFGDungeons(1);
					SetLFGDungeon(1, v.id);
					JoinSingleLFG(1, v.id);
				end)

				entryButton:AddInitializer(function(button, description, menu)
					local leftTexture = button:AttachTexture();
					leftTexture:SetSize(18, 18);
					leftTexture:SetPoint("LEFT");
					leftTexture:SetTexture(v.icon);

					button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);

					return button.fontString:GetUnboundedStringWidth() + 18 + 5
				end)
			end

			local heroicButton = rootDescription:CreateButton(LFG_TYPE_HEROIC_DUNGEON)

			for k, v in pairs(blizzardDropDownDescriptions[2]) do
				local entryButton = heroicButton:CreateButton(v.name, function()
					ClearAllLFGDungeons(1);
					SetLFGDungeon(1, v.id);
					JoinSingleLFG(1, v.id);
				end)

				entryButton:AddInitializer(function(button, description, menu)
					local leftTexture = button:AttachTexture();
					leftTexture:SetSize(16, 16);
					leftTexture:SetPoint("LEFT");
					leftTexture:SetTexture(v.icon);

					button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);

					return button.fontString:GetUnboundedStringWidth() + 18 + 5
				end)
			end

			local followerButton = rootDescription:CreateButton(LFG_TYPE_FOLLOWER_DUNGEON)

			for k, v in pairs(blizzardDropDownDescriptions[205]) do
				local entryButton = followerButton:CreateButton(v.name, function()
					ClearAllLFGDungeons(1);
					SetLFGDungeon(1, v.id);
					JoinSingleLFG(1, v.id);
				end)
				entryButton:AddInitializer(function(button, description, menu)
					local leftTexture = button:AttachTexture();
					leftTexture:SetSize(16, 16);
					leftTexture:SetPoint("LEFT");
					leftTexture:SetTexture(v.icon);

					button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);

					return button.fontString:GetUnboundedStringWidth() + 18 + 5
				end)
			end

			local specificButton = rootDescription:CreateButton(SPECIFIC_DUNGEONS)

			specificButton:CreateTitle(LFG_TYPE_DUNGEON)

			for k, v in pairs(blizzardDropDownDescriptions[1]) do
				--LFG_JoinDungeon(1, "specific", selectedDungeonsList, {})
				local entryButton = specificButton:CreateCheckbox(v.name,
				function(dungeonID) return selectedDungeonsList[dungeonID] ~= nil end,
				function(dungeonID)
					selectedDungeonsList[dungeonID] = not selectedDungeonsList[dungeonID] and dungeonID or nil

					LFGEnabledList[dungeonID] = selectedDungeonsList[dungeonID]
				end,
				v.id)

				entryButton:AddInitializer(function(button, description, menu)
					local leftTexture = button:AttachTexture();
					leftTexture:SetSize(16, 16);
					leftTexture:SetPoint("LEFT", button.leftTexture1, "RIGHT", 5, 0);
					leftTexture:SetTexture(v.icon);

					button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);

					return button.fontString:GetUnboundedStringWidth() + 18 + 5
				end)
			end
			
			specificButton:CreateSpacer();
			specificButton:CreateTitle(LFG_TYPE_HEROIC_DUNGEON)

			for k, v in pairs(blizzardDropDownDescriptions[2]) do
				local entryButton = specificButton:CreateCheckbox(v.name,
				function(dungeonID) return selectedDungeonsList[dungeonID] ~= nil end,
				function(dungeonID)
					selectedDungeonsList[dungeonID] = not selectedDungeonsList[dungeonID] and dungeonID or nil

					LFGEnabledList[dungeonID] = selectedDungeonsList[dungeonID]
				end,
				v.id)

				entryButton:AddInitializer(function(button, description, menu)
					local leftTexture = button:AttachTexture();
					leftTexture:SetSize(16, 16);
					leftTexture:SetPoint("LEFT", button.leftTexture1, "RIGHT", 5, 0);
					leftTexture:SetTexture(v.icon);

					button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);

					return button.fontString:GetUnboundedStringWidth() + 18 + 5
				end)
			end

			local queueButton = specificButton:CreateTemplate("UIPanelButtonTemplate")
			queueButton:AddInitializer(function(button, description, menu)
				button:SetScript("OnClick", function(_, buttonName)
					LFG_JoinDungeon(1, "specific", selectedDungeonsList, {})
				end);
				button:SetText("Queue for multiple dungeons")
			end);

			local raidFinderButton = rootDescription:CreateButton(RAID_FINDER)

			local lastRaidName

			for k, v in pairs(blizzardDropDownDescriptions[17]) do
				local id, name, typeID, subtypeID, minLevel, maxLevel, recLevel, _, _, _, _, fileID, difficultyID, _, _, isHolidayDungeon, _, _, isTimewalkingDungeon, raidName, minGearLevel, isScaling, mapID = GetRFDungeonInfo(v.index)

				local isNewRaid = lastRaidName ~= raidName
				local modifiedInstanceInfo, modifiedInstanceTooltipText = nil, ""

				if(mapID) then
					modifiedInstanceInfo = C_ModifiedInstance.GetModifiedInstanceInfoFromMapID(mapID)

					if (modifiedInstanceInfo) then
						--icon = GetFinalNameFromTextureKit("%s-small", modifiedInstanceInfo.uiTextureKit);
						modifiedInstanceTooltipText = "|n|n" .. modifiedInstanceInfo.description;

					else
					
					end

					--info.iconXOffset = -6;
				end

				if(isNewRaid) then
					if(lastRaidName ~= nil) then
						raidFinderButton:CreateSpacer()

					end

					local raidTitle = raidFinderButton:CreateTitle(miog.MAP_INFO[mapID].shortName)

					if(modifiedInstanceInfo) then
						raidTitle:AddInitializer(function(button, description, ...)
							local leftTexture = button:AttachTexture();
							leftTexture:SetSize(16, 16);
							leftTexture:SetPoint("LEFT");
							leftTexture:SetAtlas(GetFinalNameFromTextureKit("%s-small", modifiedInstanceInfo.uiTextureKit));

							button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);
							button.fontString:SetTextColor(0.1,0.83,0.77,1)

							return button.fontString:GetUnboundedStringWidth() + 18 + 5
						end)
					end

				end

				local entryButton = raidFinderButton:CreateButton(v.name, function()
					ClearAllLFGDungeons(3);
					SetLFGDungeon(3, v.id);
					JoinSingleLFG(3, v.id);
				end)
	
				local encounters;
				local numEncounters = GetLFGDungeonNumEncounters(id);
				for j = 1, numEncounters do
					local bossName, _, isKilled = GetLFGDungeonEncounterInfo(id, j);
					local colorCode = "";
					if ( isKilled ) then
						colorCode = RED_FONT_COLOR_CODE;
					end
					if encounters then
						encounters = encounters.."|n"..colorCode..bossName..FONT_COLOR_CODE_CLOSE;
					else
						encounters = colorCode..bossName..FONT_COLOR_CODE_CLOSE;
					end
				end

				entryButton:SetTooltip(function(tooltip, description)
					--GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
					tooltip:SetText(RAID_BOSSES)
					GameTooltip_AddNormalLine(tooltip, encounters .. modifiedInstanceTooltipText, 1, 1, 1, true)
					GameTooltip:Show()
				end)

				entryButton:AddInitializer(function(button, description, menu)
					local leftTexture = button:AttachTexture();
					leftTexture:SetSize(16, 16);
					leftTexture:SetPoint("LEFT");
					leftTexture:SetTexture(v.icon);

					button.fontString:SetPoint("LEFT", leftTexture, "RIGHT", 5, 0);

					return button.fontString:GetUnboundedStringWidth() + 18 + 5
				end)

				lastRaidName = raidName
			end

			local pvpButton = rootDescription:CreateButton(PLAYER_V_PLAYER)

			local listFrame = pvpButton:CreateTemplate("VerticalLayoutFrame")

			listFrame:AddInitializer(function(frame, description, menu)
				frame:SetSize(150, 150)
				local newFrame = CreateFrame("Frame", nil, frame, "BackdropTemplate")
				newFrame.layoutIndex = 2
				newFrame:SetBackdrop(BACKDROP_TEXT_PANEL_0_16)
				updatePVP(frame)
				frame:MarkDirty()
			end)

			
			rootDescription:CreateButton(PET_BATTLE_PVP_QUEUE, function()
				C_PetBattles.StartPVPMatchmaking()
			end)
		end)]]
	
	else
		miog.F.UPDATE_AFTER_COMBAT = true
	
	end
end

miog.updateDropDown = updateDropDown

local function queueEvents(_, event, ...)
	if(event == "LFG_UPDATE_RANDOM_INFO") then
		updateDropDown()

	elseif(event == "LFG_UPDATE") then

	elseif(event == "LFG_LOCK_INFO_RECEIVED") then
		updateDropDown()
		
	elseif(event == "PVP_BRAWL_INFO_UPDATED") then
		updateDropDown()

	elseif(event == "LFG_LIST_AVAILABILITY_UPDATE") then
		updateDropDown()

	elseif(event == "GROUP_ROSTER_UPDATE") then
		--updateDropDown()
		
	elseif(event == "PLAYER_REGEN_ENABLED") then
		if(miog.F.UPDATE_AFTER_COMBAT) then
			miog.F.UPDATE_AFTER_COMBAT = false

			updateDropDown()
			checkQueues()
		end
	end
end

miog.queueEvents = queueEvents