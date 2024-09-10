--=====================================================================================
-- BLU | Better Level Up! - localization.lua
--=====================================================================================
L = L or {}

local colors = {
    prefix = "|cff05dffa",     -- BLU Prefix Color
    debug = "|cff808080",      -- Debug Prefix Color
    success = "|cff00ff00",    -- Success/Enabled/Positive Color
    error = "|cffff0000",      -- Error/Disabled/Negative Color
    highlight = "|cff8080ff",  -- Highlighted Text Color
    info = "|cffffff00",       -- Information/Warning Color
    test = "|cffc586c0",       -- Test Message Color
    sound = "|cffce9178",      -- Sound File Path Color
    white = "|cffffffff",      -- White Color
    warning = "|cffffcc00"     -- Warning Color
}

BLU_PREFIX = string.format("|Tinterface/addons/blu/images/icon:16:16|t - [%sBLU|r] ", colors.prefix)
DEBUG_PREFIX = string.format("[%sDEBUG|r] ", colors.debug)

--=====================================================================================
-- Localization Strings
--=====================================================================================
L = {
    -- Option Colors (Cycle with Color Alternation)
    optionColor1 = colors.prefix,
    optionColor2 = colors.white,

    -- Option Labels and Descriptions
    OPTIONS_PANEL_TITLE = string.format("|Tinterface/addons/blu/images/icon:16:16|t - %sBLU|r %s|| %sB|r%setter %sL|r%svel %sU|r%sp!",
        colors.prefix, colors.white, colors.prefix, colors.white, colors.prefix, colors.white, colors.prefix, colors.white),

    -- Profiles
    PROFILES_TITLE = "Profiles",

    OPTIONS_LIST_MENU_TITLE = string.format("|Tinterface/addons/blu/images/icon:16:16|t - %sB|r%setter %sL|r%svel %sU|r%sp!",
        colors.prefix, colors.white, colors.prefix, colors.white, colors.prefix, colors.white),

    -- General Text
    FUNCTION_USED = string.format("%sFunction %s used.|r", colors.info, colors.highlight),
    ADDON_DISABLED = string.format("Addon %sdisabled|r.", colors.error),
    ADDON_ENABLED = string.format("Addon %senabled|r.", colors.success),
    DEBUG_MODE_ENABLED = string.format("%sDebug Mode Enabled|r", colors.success),
    DEBUG_MODE_DISABLED = string.format("%sDebug Mode Disabled|r", colors.error),
    DEBUG_MODE_TOGGLED = string.format("Debug mode toggled: %s%%s|r.", colors.highlight),
    ERROR_UNKNOWN_GAME_VERSION = string.format("%sUnknown game version detected.|r", colors.error),
    FUNCTIONS_HALTED = string.format("%sFunctions halted. Event not processed.|r", colors.info),
    FUNCTIONS_RESUMED = string.format("Functions %sresumed|r after pause.", colors.success),
    GAME_VERSION = "Detected game version: %s.",
    OPTIONS_REGISTERED = "Options registered successfully.",
    PROCESSING_SLASH_COMMAND = string.format("Processing slash command: %s%%s|r.", colors.highlight),
    SHOW_WELCOME_MESSAGE_TOGGLED = string.format("Welcome message toggled: %s%%s|r.", colors.highlight),
    SLASH_COMMAND_HELP = string.format("Use %s/blu debug|r to toggle debug mode, %s/blu welcome|r to toggle the welcome message, or %s/blu|r to open the options panel.", colors.prefix, colors.prefix, colors.prefix),
    WELCOME_MESSAGE = string.format("Welcome! Use %s/blu|r to open the options panel or %s/blu help|r for more commands.", colors.prefix, colors.prefix),
    WELCOME_MESSAGE_DISPLAYED = string.format("Welcome message %sdisplayed|r.", colors.success),
    WELCOME_MSG_DISABLED = string.format("Welcome message %sdisabled|r.", colors.error),
    WELCOME_MSG_ENABLED = string.format("Welcome message %senabled|r.", colors.success),
    WELCOME_MESSAGE_STATUS = "Welcome message status: %s.",
    VERSION = string.format("%sVersion: %s|r", "|cffffff00", "|cff8080ff%s|r"),

    -- Help Command Text
    HELP_COMMAND = string.format("%sAvailable commands:", "|cffffff00"),
    HELP_DEBUG = " " .. colors.prefix .. "/blu debug|r - Toggle debug mode.",
    HELP_WELCOME = " " .. colors.prefix .. "/blu welcome|r - Toggles the welcome message on/off.",
    HELP_PANEL = " " .. colors.prefix .. "/blu|r - Open the options panel.",




    -- Event Messages
    INCOMING_CHAT_MESSAGE = string.format("%sIncoming chat message: %%s|r", colors.highlight),
    BRANN_LEVEL_FOUND = string.format("%sBrann Bronzebeard has reached Level %%s|r", colors.info),
    DUPLICATE_LEVEL_DETECTED = string.format("%sDuplicate level-up detected, ignoring.|r", colors.warning),
    NO_BRANN_LEVEL_FOUND = string.format("%sNo Delve Level found in chat message.|r", colors.error),
    ACHIEVEMENT_EARNED_TRIGGERED = string.format("%sACHIEVEMENT_EARNED|r %striggered.|r", colors.info, colors.test),
    HONOR_LEVEL_UPDATE_TRIGGERED = string.format("%sHONOR_LEVEL_UPDATE|r %striggered.|r", colors.info, colors.test),
    MAJOR_FACTION_RENOWN_LEVEL_CHANGED_TRIGGERED = string.format("%sMAJOR_FACTION_RENOWN_LEVEL_CHANGED|r %striggered.|r", colors.info, colors.test),
    PERKS_ACTIVITY_COMPLETED_TRIGGERED = string.format("%sPERKS_ACTIVITY_COMPLETED|r %striggered.|r", colors.info, colors.test),
    PERKS_ACTIVITY_COMPLETED_MSG = string.format("%sPerks Activity Completed:|r %s", colors.info, colors.test),
    PERKS_ACTIVITY_ERROR = string.format("%sError: Activity name not found.|r", colors.error),
    PET_BATTLE_LEVEL_CHANGED_TRIGGERED = string.format("%sPET_BATTLE_LEVEL_CHANGED|r %striggered.|r", colors.info, colors.test),
    PLAYER_LEVEL_UP_TRIGGERED = string.format("%sPLAYER_LEVEL_UP|r %striggered.|r", colors.info, colors.test),
    QUEST_ACCEPTED_TRIGGERED = string.format("%sQUEST_ACCEPTED|r %striggered.|r", colors.info, colors.test),
    QUEST_TURNED_IN_TRIGGERED = string.format("%sQUEST_TURNED_IN|r %striggered.|r", colors.info, colors.test),
    REPUTATION_RANK_INCREASE = string.format("%sREPUTATION_RANK_INCREASE|r %striggered for rank: %s|r.", colors.info, colors.test, colors.success),
    REPUTATION_GAINED_TRIGGERED = string.format("%sReputation Gained|r %striggered: %s|r.", colors.info, colors.test, colors.success),

    -- Reputation Ranks with "You are now ... with" pattern
    RANK_EXALTED = "You are now Exalted with",
    RANK_REVERED = "You are now Revered with",
    RANK_HONORED = "You are now Honored with",
    RANK_FRIENDLY = "You are now Friendly with",
    RANK_NEUTRAL = "You are now Neutral with",
    RANK_UNFRIENDLY = "You are now Unfriendly with",
    RANK_HOSTILE = "You are now Hostile with",
    RANK_HATED = "You are now Hated with",

    -- Debug Messages
    COUNTDOWN_TIMER_RESET = string.format("%sHalt timer restarted and countdown reset to 15 seconds.|r", colors.info),
    HALT_TIMER_STARTED = string.format("%sHalt timer started for %%d seconds.|r", colors.info),
    COUNTDOWN_TICK = string.format("%sCountdown: %s%%d%s seconds remaining.|r", colors.info, colors.highlight, colors.info),
    COOLDOWN_ACTIVE = string.format("Cooldown active for rank: %%s.|r", colors.info),
    CURRENT_DB_SETTING = string.format("Current DB setting: %%s.|r", colors.info),
    ERROR_OPTIONS_NOT_INITIALIZED = string.format("%sOptions not initialized properly.|r", colors.error),
    ERROR_SOUND_NOT_FOUND = string.format("%sSound not found for sound ID: %%s.|r", colors.error, colors.highlight),
    EVENTS_REGISTERED = "All shared events registered successfully.",
    HALT_TIMER_RESTARTED = string.format("%sHalt timer restarted.|r", colors.info),
    HALT_TIMER_RUNNING = string.format("Halt timer already running. %sNo new timer started.|r", colors.info),
    MISSING_GROUP_NAME = string.format("%sA group is missing its name field.|r", colors.error),
    MUTING_SOUND = string.format("Muting sound with ID: %s%%s|r.", colors.highlight),
    NO_RANK_FOUND = string.format("%sNo reputation rank increase found in chat message.|r", colors.error),
    NO_SOUNDS_TO_MUTE = string.format("%sNo sounds to mute for this game version.|r", colors.error),
    NO_VALID_SOUND_IDS = string.format("%sNo valid sound IDs found.|r", colors.error),
    OPTIONS_PANEL_OPENED = string.format("Options panel %sopened|r.", colors.success),
    PLAYING_SOUND = string.format("Playing sound with ID: %%s and volume level: %%d.|r", colors.highlight, colors.highlight),
    RANDOM_SOUND_ID_SELECTED = string.format("Random sound ID selected: %%s.|r", colors.highlight),
    SELECTING_SOUND = string.format("Selecting sound with ID: %%s.|r", colors.highlight),
    SOUND_FILE_TO_PLAY = string.format("Sound file to play: %%s.|r", colors.sound),
    UNKNOWN_SLASH_COMMAND = string.format("Unknown slash command: %%s.|r", colors.highlight),
    USING_RANDOM_SOUND_ID = string.format("Using random sound ID: %%s.|r", colors.highlight),
    USING_SPECIFIED_SOUND_ID = string.format("Using specified sound ID: %%s.|r", colors.highlight),
    VOLUME_LEVEL_ZERO = string.format("%sVolume level is %s0|r, sound not played.|r", colors.error, colors.highlight),
    INVALID_VOLUME_LEVEL = string.format("%sInvalid volume level: %%d.|r", colors.error, colors.highlight),

    -- Options Debug
    GROUP_COLOR_APPLIED = string.format("Group: %s%%s|r color applied.", colors.info),
    ARGUMENT_NAME_COLOR_APPLIED = string.format("    Argument: %s%%s|r color applied.", colors.info),
    DESCRIPTION_COLOR_APPLIED = string.format("    Description: %s%%s|r color applied.", colors.info),
    SKIPPING_ARGUMENT_NAME = string.format("%sSkipping argument name due to missing name.|r", colors.warning),
    SKIPPING_ARGUMENT_DESC = string.format("%sSkipping argument description due to missing description.|r", colors.warning),
    SKIPPING_GROUP = string.format("%sSkipping group due to missing name or args.|r", colors.warning),

    -- Test Sound Debug Messages
    TEST_ACHIEVEMENT_SOUND = string.format("%sTestAchievementSound|r %striggered.|r", colors.info, colors.test),
    TEST_BATTLE_PET_LEVEL_SOUND = string.format("%sTestBattlePetLevelSound|r %striggered.|r", colors.info, colors.test),
    TEST_DELVE_LEVEL_UP_SOUND = string.format("%sTestDelveLevelUpSound|r %striggered.|r", colors.info, colors.test),
    TEST_HONOR_SOUND = string.format("%sTestHonorSound|r %striggered.|r", colors.info, colors.test),
    TEST_LEVEL_SOUND = string.format("%sTestLevelSound|r %striggered.|r", colors.info, colors.test),
    TEST_POST_SOUND = string.format("%sTestPostSound|r %striggered.|r", colors.info, colors.test),
    TEST_QUEST_ACCEPT_SOUND = string.format("%sTestQuestAcceptSound|r %striggered.|r", colors.info, colors.test),
    TEST_QUEST_SOUND = string.format("%sTestQuestSound|r %striggered.|r", colors.info, colors.test),
    TEST_RENOWN_SOUND = string.format("%sTestRenownSound|r %striggered.|r", colors.info, colors.test),
    TEST_REP_SOUND = string.format("%sTestRepSound|r %striggered.|r", colors.info, colors.test),

    -- Option Labels and Descriptions for Volume Controls
    ACHIEVEMENT_EARNED = "Achievement Earned!",
    ACHIEVEMENT_VOLUME_LABEL = "Achievement Volume",
    ACHIEVEMENT_VOLUME_DESC = "Adjust the volume for the Achievement Earned! sound.",

    BATTLE_PET_LEVEL_UP = "Battle Pet Level-Up!",
    BATTLE_PET_VOLUME_LABEL = "Battle Pet Volume",
    BATTLE_PET_VOLUME_DESC = "Adjust the volume for the Battle Pet Level-Up! sound.",

    DELVE_COMPANION_LEVEL_UP = "Delve Companion Level-Up!",
    DELVE_VOLUME_LABEL = "Delve Volume",
    DELVE_VOLUME_DESC = "Adjust the volume for the Delve Level-Up! sound.",

    HONOR_RANK_UP = "Honor Rank-Up!",
    HONOR_VOLUME_LABEL = "Honor Volume",
    HONOR_VOLUME_DESC = "Adjust the volume for the Honor Rank-Up! sound.",

    LEVEL_UP = "Level-Up!",
    LEVEL_VOLUME_LABEL = "Level-Up Volume",
    LEVEL_VOLUME_DESC = "Adjust the volume for the Level-Up! sound.",

    QUEST_ACCEPTED = "Quest Accepted!",
    QUEST_ACCEPT_VOLUME_LABEL = "Quest Accept Volume",
    QUEST_ACCEPT_VOLUME_DESC = "Adjust the volume for the Quest Accepted! sound.",

    QUEST_COMPLETE = "Quest Complete!",
    QUEST_COMPLETE_VOLUME_LABEL = "Quest Complete Volume",
    QUEST_COMPLETE_VOLUME_DESC = "Adjust the volume for the Quest Complete! sound.",

    RENOWN_RANK_UP = "Renown Rank-Up!",
    RENOWN_VOLUME_LABEL = "Renown Volume",
    RENOWN_VOLUME_DESC = "Adjust the volume for the Renown Rank-Up! sound.",

    REPUTATION_RANK_UP = "Reputation Rank-Up!",
    REP_VOLUME_LABEL = "Reputation Volume",
    REP_VOLUME_DESC = "Adjust the volume for the Reputation Rank-Up! sound.",

    TRADE_POST_ACTIVITY_COMPLETE = "Trade Post Activity Complete!",
    POST_VOLUME_LABEL = "Trade Post Volume",
    POST_VOLUME_DESC = "Adjust the volume for the Trade Post Activity Complete! sound."
}

-- Debug checks to ensure no strings are missing
for key, value in pairs(L) do
    if not value or value == "" then
        print(string.format("Warning: Localization string for key '%s' is missing or empty.", key))
    end
end
