--=====================================================================================
-- Default Profile Settings
--=====================================================================================
BLU.defaults = {
    profile = {
        debugMode = false,
        showWelcomeMessage = true,
        AchievementSoundSelect = 35,
        AchievementVolume = 2.0,
        BattlePetLevelSoundSelect = 37,
        BattlePetLevelVolume = 2.0,
        DelveLevelUpSoundSelect = 50,
        DelveLevelUpVolume = 2.0,
        HonorSoundSelect = 27,
        HonorVolume = 2.0,
        LevelSoundSelect = 24,
        LevelVolume = 2.0,
        PostSoundSelect = 55,
        PostVolume = 2.0,
        QuestAcceptSoundSelect = 26,
        QuestAcceptVolume = 2.0,
        QuestSoundSelect = 25,
        QuestVolume = 2.0,
        RenownSoundSelect = 21,
        RenownVolume = 2.0,
        RepSoundSelect = 15,
        RepVolume = 2.0,
    },
}

--=====================================================================================
-- Options Definition
--=====================================================================================
BLU.options = {
    type = "group",
    name = "",
    handler = BLU,
    args = {
        group1 = {
            type = "header",
            order = 1,
            name = L["OPTIONS_PANEL_TITLE"],
        },
        group2 = {
            type = "group",
            order = 2,
            name = L["ACHIEVEMENT_EARNED"], --COLOR SHOULD BE BLU
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                AchievementSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestAchievementSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestAchievementSound() end,
                },
                AchievementVolume = {
                    type = "range",
                    order = 3,
                    name = L["ACHIEVEMENT_VOLUME_LABEL"], -- COLOR SHOULD BE BLU
                    desc = L["ACHIEVEMENT_VOLUME_DESC"], -- color should be white
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group3 = {
            type = "group",
            order = 3,
            name = L["BATTLE_PET_LEVEL_UP"], -- color should be white
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                BattlePetLevelSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestBattlePetLevelSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestBattlePetLevelSound() end,
                },
                BattlePetLevelVolume = {
                    type = "range",
                    order = 3,
                    name = L["BATTLE_PET_VOLUME_LABEL"], -- color should be white
                    desc = L["BATTLE_PET_VOLUME_DESC"], -- color should be blu
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group4 = {
            type = "group",
            order = 4,
            name = L["DELVE_COMPANION_LEVEL_UP"],-- COLOR SHOULD BE BLU
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                DelveLevelUpSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestDelveLevelUpSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestDelveLevelUpSound() end,
                },
                DelveLevelUpVolume = {
                    type = "range",
                    order = 3,
                    name = L["DELVE_VOLUME_LABEL"],-- COLOR SHOULD BE BLU
                    desc = L["DELVE_VOLUME_DESC"],-- color should be white
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group5 = {
            type = "group",
            order = 5,
            name = L["HONOR_RANK_UP"],-- color should be white
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                HonorSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestHonorSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestHonorSound() end,
                },
                HonorVolume = {
                    type = "range",
                    order = 3,
                    name = L["HONOR_VOLUME_LABEL"],-- color should be white
                    desc = L["HONOR_VOLUME_DESC"],-- COLOR SHOULD BE BLU
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group6 = {
            type = "group",
            order = 6,
            name = L["LEVEL_UP"],
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                LevelSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestLevelSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestLevelSound() end,
                },
                LevelVolume = {
                    type = "range",
                    order = 3,
                    name = L["LEVEL_VOLUME_LABEL"],
                    desc = L["LEVEL_VOLUME_DESC"],
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group7 = {
            type = "group",
            order = 7,
            name = L["QUEST_ACCEPTED"],
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                QuestAcceptSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestQuestAcceptSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestQuestAcceptSound() end,
                },
                QuestAcceptVolume = {
                    type = "range",
                    order = 3,
                    name = L["QUEST_ACCEPT_VOLUME_LABEL"],
                    desc = L["QUEST_ACCEPT_VOLUME_DESC"],
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group8 = {
            type = "group",
            order = 8,
            name = L["QUEST_COMPLETE"],
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                QuestSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestQuestSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestQuestSound() end,
                },
                QuestVolume = {
                    type = "range",
                    order = 3,
                    name = L["QUEST_COMPLETE_VOLUME_LABEL"],
                    desc = L["QUEST_COMPLETE_VOLUME_DESC"],
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group9 = {
            type = "group",
            order = 9,
            name = L["RENOWN_RANK_UP"],
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                RenownSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestRenownSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestRenownSound() end,
                },
                RenownVolume = {
                    type = "range",
                    order = 3,
                    name = L["RENOWN_VOLUME_LABEL"],
                    desc = L["RENOWN_VOLUME_DESC"],
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group10 = {
            type = "group",
            order = 10,
            name = L["REPUTATION_RANK_UP"],
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                RepSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestRepSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestRepSound() end,
                },
                RepVolume = {
                    type = "range",
                    order = 3,
                    name = L["REP_VOLUME_LABEL"],
                    desc = L["REP_VOLUME_DESC"],
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        group11 = {
            type = "group",
            order = 11,
            name = L["TRADE_POST_ACTIVITY_COMPLETE"],
            inline = true,
            get = "GetValue",
            set = "SetValue",
            args = {
                PostSoundSelect = {
                    type = "select",
                    order = 1,
                    name = "",  -- Can leave blank if desired
                    desc = "",  -- Blank sound description
                    values = soundOptions,
                },
                TestPostSound = {
                    type = "execute",
                    order = 2,
                    image = "Interface\\Addons\\BLU\\images\\play.blp",
                    imageWidth = 20,
                    imageHeight = 20,
                    name = "",
                    desc = "",  -- Description not needed for button
                    func = function() BLU:TestPostSound() end,
                },
                PostVolume = {
                    type = "range",
                    order = 3,
                    name = L["POST_VOLUME_LABEL"],
                    desc = L["POST_VOLUME_DESC"],
                    min = 0,
                    max = 3,
                    step = 1,
                },
            },
        },
        versionHeader = {
            type = "header",
            order = 12,
            name = "|cff8080ff" .. BLU.VersionNumber .. "|r",
        },
    },
}
