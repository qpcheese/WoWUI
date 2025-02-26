----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, ns = ...
local addon = LibStub("AceAddon-3.0"):GetAddon(FOLDER_NAME)
local L = ns.locale

----------------------------------------------------------------------------------------------------
-------------------------------------------DEV CONFIG TAB-------------------------------------------
----------------------------------------------------------------------------------------------------

-- Activate the developer mode with:
-- /script HandyNotes_OribosDB.global.dev = true
-- /reload

local function devmode()
    ns.config.options.args["DEV"] = {
        type = "group",
        name = L["dev_config_tab"],
--      desc = L[""],
        order = 2,
        args = {
                force_nodes = {
                    type = "toggle",
                    name = L["dev_config_force_nodes"],
                    desc = L["dev_config_force_nodes_desc"],
                    order = 0,
                },
                show_prints = {
                    type = "toggle",
                    name = L["dev_config_show_prints"],
                    desc = L["dev_config_show_prints_desc"],
                    order = 1,
                },
        },
    }

    SLASH_ORIBOSREFRESH1 = "/oribosrefresh"
    SlashCmdList["ORIBOSREFRESH"] = function(msg)
        addon:Refresh()
        print("Oribos refreshed")
    end

    SLASH_ORIBOS1 = "/oribos"
    SlashCmdList["ORIBOS"] = function(msg)
        Settings.OpenToCategory('HandyNotes')
        LibStub('AceConfigDialog-3.0'):SelectGroup('HandyNotes', 'plugins', 'Oribos')
    end

end

function addon:debugmsg(msg)

    if (ns.global.dev and ns.db.show_prints) then
        print("|CFFFF6666Oribos: |r"..msg)
    end

end

ns.devmode = devmode
