---
--- @file
--- Localization file for global text strings in enUS language.
---

local NAME, this = ...

-- We add true as last parameter, since this is default language.
local t = this.AceLocale:NewLocale(NAME, 'enUS', true)

if not t then
  return
end

-- Configuration
t['config_name'] = 'Nooks and Crannies'
t['config_description'] = 'Doorways, portals and caves around the World of Warcraft.'
t['config_waypoint'] = 'Waypoint configuration'
t['config_scale'] = 'Instance scale'
t['config_description_scale'] = 'The scale of the icons in instances.'
t['config_opacity'] = 'Instance Opacity'
t['config_description_opacity'] = 'The alpha transparency of the icons in instances.'
t['config_worldscale'] = 'World Scale'
t['config_description_worldscale'] = 'The scale of the icons in world.'
t['config_worldopacity'] = 'World Opacity'
t['config_description_worldopacity'] = 'The alpha transparency of the icons in world.'
t['config_name_cache'] = 'Clear cache'
t['config_description_cache'] = [[
Clear stored data from cache.

Stored data are data, that are pulled from WoW API (item name, quest name etc), so we don't have to query in-game API all the time.

Cache is automatically cleared when new World of Warcraft build is created.
]]
t['config_name_reset_personal'] = 'Reset hidden points for this character'
t['config_name_reset_global'] = 'Reset hidden points for all characters'
t['navigate'] = 'Navigate'
t['waypoint_title'] = 'Navigation'
t['waypoint'] = 'You can also <Shift-Click> on this point to create map pin.'
t['waypoint_fail'] = 'You cannot create waypoints on this map.'
t['point_tooltip'] = 'You can keep this tooltip visible while holding <Alt> button.'
t['hide_personal'] = 'Hide for this character'
t['hide_global'] = 'Hide for all characters'
t['hide_tooltip_title'] = 'Restoring hidden point'
t['hide_tooltip'] = 'Hidden points can restored in Addon configuration (Options -> AddOns -> HandyNotes -> plugins -> Nooks and Crannies -> reset buttons).'
t['fetching_data'] = 'Fetching data'
t['flight_master'] = 'Flight Master'
