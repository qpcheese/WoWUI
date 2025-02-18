-- Default locale
local ADDON_NAME, PRIVATE_TABLE = ...

if GetLocale() ~= "frFR" then
	return
end

local L = PRIVATE_TABLE.L

L["${n} seconds"] = "${n} secondes"
L["(Automatically in category)"] = "(Automatiquement dans la catégorie)"
L["Active Addons"] = "Addons actifs"
L["Add search results to category"] = "Ajouter des résultats de recherche à la catégorie"
L["AddOn binary search"] = "Recherche binaire AddOn"
L["Addons being modified"] = "Addons en cours de modification"
L["Addons being modified in this session"] = "Addons en cours de modification dans cette session"
L["Addons enabled and loaded, or ready to be loaded on demand."] = "Addons activés et chargés, ou prêts à être chargés à la demande."
L["Addons not in any category. It will be taken into account if you are viewing or not auto-generated categories."] = "Les addons ne font partie d’aucune catégorie. Il sera pris en compte si vous visualisez ou non des catégories générées automatiquement."
L["AddOns Total Memory"] = "Mémoire totale des Addons"
L["AddOns: "] = "AddOns:"
L["Also disable Simple Addon Manager?"] = "Désactiver aussi Simple Addon Manager?"
--[[Translation missing --]]
L["Are you sure you want to remove all automatic character profiles?"] = "Are you sure you want to remove all automatic character profiles?"
L["Author"] = "Auteur"
L["Author: "] = "Auteur:"
L["Autofocus searchbar when opening the UI"] = "Focus la barre de recherche quand l'UI s'ouvre"
L["Automatically added:"] = "Ajouté automatiquement:"
L["Be careful with this option, enabling/disabling Blizzard Addons might have unintended consequences!"] = "Soyez prudent avec cette option, l’activation/désactivation des addons Blizzard peut avoir des conséquences inattendues !"
L["Categories"] = "Catégories"
L["Category created from addons metadata"] = "Catégorie créée à partir des métadonnées des addons"
L["Category Options"] = "Options de catégorie"
L["Characters"] = "Personnages"
L["Circular dependency detected!"] = "Dépendance détectée !"
--[[Translation missing --]]
L["Clear list"] = "Clear list"
L["Collapse all"] = "Tout réduire"
--[[Translation missing --]]
L["Create new profile"] = "Create new profile"
--[[Translation missing --]]
L["Currently Disabled Addons"] = "Currently Disabled Addons"
--[[Translation missing --]]
L["Currently Enabled Addons"] = "Currently Enabled Addons"
--[[Translation missing --]]
L["Delete"] = "Delete"
--[[Translation missing --]]
L["Delete category '${category}'?"] = "Delete category '${category}'?"
--[[Translation missing --]]
L["Delete the profile '${profile}'?"] = "Delete the profile '${profile}'?"
--[[Translation missing --]]
L["Disable this and every AddOn that depends on it"] = "Disable this and every AddOn that depends on it"
--[[Translation missing --]]
L["Disabled Addons"] = "Disabled Addons"
--[[Translation missing --]]
L["Enable Addons"] = "Enable Addons"
--[[Translation missing --]]
L["Enable addons from the profile '${profile}'?"] = "Enable addons from the profile '${profile}'?"
--[[Translation missing --]]
L["Enable this Addon and its dependencies"] = "Enable this Addon and its dependencies"
--[[Translation missing --]]
L["Enable this and every AddOn that depends on it"] = "Enable this and every AddOn that depends on it"
--[[Translation missing --]]
L["Enabled Addons"] = "Enabled Addons"
--[[Translation missing --]]
L["Enter the category name"] = "Enter the category name"
--[[Translation missing --]]
L["Enter the name for the new profile"] = "Enter the name for the new profile"
--[[Translation missing --]]
L["Enter the new name for the category '${category}'"] = "Enter the new name for the category '${category}'"
--[[Translation missing --]]
L["Enter the new name for the profile "] = "Enter the new name for the profile "
--[[Translation missing --]]
L["Expand all"] = "Expand all"
--[[Translation missing --]]
L["Fixed category"] = "Fixed category"
--[[Translation missing --]]
L["Hide autogenerated categories"] = "Hide autogenerated categories"
--[[Translation missing --]]
L["Hide icons"] = "Hide icons"
--[[Translation missing --]]
L["Ignore addons included in dependent profiles."] = "Ignore addons included in dependent profiles."
--[[Translation missing --]]
L["Internal name"] = "Internal name"
--[[Translation missing --]]
L["Left-click to open"] = "Left-click to open"
--[[Translation missing --]]
L["List Options"] = "List Options"
--[[Translation missing --]]
L["Load"] = "Load"
--[[Translation missing --]]
L["Load AddOn"] = "Load AddOn"
--[[Translation missing --]]
L["Load Profile"] = "Load Profile"
--[[Translation missing --]]
L["Load profile '${profile}' and reload UI?"] = "Load profile '${profile}' and reload UI?"
--[[Translation missing --]]
L["Load the AddOns from '${char}'?"] = "Load the AddOns from '${char}'?"
--[[Translation missing --]]
L["Load the profile '${profile}'?"] = "Load the profile '${profile}'?"
--[[Translation missing --]]
L["Localize autogenerated categories name"] = "Localize autogenerated categories name"
--[[Translation missing --]]
L["Manually added:"] = "Manually added:"
--[[Translation missing --]]
L["Memory Update"] = "Memory Update"
--[[Translation missing --]]
L["Memory: "] = "Memory: "
--[[Translation missing --]]
L["Name (improved)"] = "Name (improved)"
--[[Translation missing --]]
L["New Category"] = "New Category"
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Not Found!"] = "Not Found!"
--[[Translation missing --]]
L["Options"] = "Options"
--[[Translation missing --]]
L["Profile dependencies"] = "Profile dependencies"
--[[Translation missing --]]
L["Profiles"] = "Profiles"
--[[Translation missing --]]
L["Reload UI"] = "Reload UI"
--[[Translation missing --]]
L["Remove search results from category"] = "Remove search results from category"
--[[Translation missing --]]
L["Rename"] = "Rename"
--[[Translation missing --]]
L["Replace original Addon wow menu button"] = "Replace original Addon wow menu button"
--[[Translation missing --]]
L["Result: ${name}"] = "Result: ${name}"
--[[Translation missing --]]
L["Results: ${results}"] = "Results: ${results}"
--[[Translation missing --]]
L["Right-click to edit"] = "Right-click to edit"
--[[Translation missing --]]
L["Right-click to show profile menu"] = "Right-click to show profile menu"
--[[Translation missing --]]
L["Save"] = "Save"
--[[Translation missing --]]
L["Save (*)"] = "Save (*)"
--[[Translation missing --]]
L["Save current addons in profile '${profile}'?"] = "Save current addons in profile '${profile}'?"
--[[Translation missing --]]
L["Save current addons, ignoring addons included in dependent profiles, into profile '${profile}'?"] = "Save current addons, ignoring addons included in dependent profiles, into profile '${profile}'?"
--[[Translation missing --]]
L["Search By"] = "Search By"
--[[Translation missing --]]
L[ [=[Search in progress...
Status: enabled: ${enabled}, disabled: ${disabled}
The addon you are looking for has been disabled?]=] ] = [=[Search in progress...
Status: enabled: ${enabled}, disabled: ${disabled}
The addon you are looking for has been disabled?]=]
--[[Translation missing --]]
L["Search Options"] = "Search Options"
--[[Translation missing --]]
L["Select All"] = "Select All"
--[[Translation missing --]]
L["Select None"] = "Select None"
--[[Translation missing --]]
L["Show Blizzard addons found in dependencies"] = "Show Blizzard addons found in dependencies"
--[[Translation missing --]]
L["Show memory usage in broker/minimap tooltip"] = "Show memory usage in broker/minimap tooltip"
--[[Translation missing --]]
L["Show minimap button"] = "Show minimap button"
--[[Translation missing --]]
L["Show versions in AddOns list"] = "Show versions in AddOns list"
--[[Translation missing --]]
L["Sort by"] = "Sort by"
--[[Translation missing --]]
L[ [=[Start binary search?
Make sure to save your profile first, just in case.]=] ] = [=[Start binary search?
Make sure to save your profile first, just in case.]=]
--[[Translation missing --]]
L["This addons is not installed!"] = "This addons is not installed!"
--[[Translation missing --]]
L["Title"] = "Title"
--[[Translation missing --]]
L["Uncategorized Addons"] = "Uncategorized Addons"
--[[Translation missing --]]
L["Update only when opening the main window"] = "Update only when opening the main window"
--[[Translation missing --]]
L["User created category"] = "User created category"
--[[Translation missing --]]
L["Utilities"] = "Utilities"
--[[Translation missing --]]
L["Version: "] = "Version: "
--[[Translation missing --]]
L["View AddOn list as dependency tree"] = "View AddOn list as dependency tree"
--[[Translation missing --]]
L["Your AddOns were restored, reload UI?"] = "Your AddOns were restored, reload UI?"

