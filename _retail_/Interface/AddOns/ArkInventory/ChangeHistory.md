﻿# 3.11.01 (27-AUG-2024)
 - fixed - https://github.com/arkayenro/arkinventory/issues/1988 - issue with auction house scanning (i think)
 - added - https://github.com/arkayenro/arkinventory/issues/1994 - keybinding for reputation
 - updated - categories for some items
 - fixed - (regression) codex is nil error with cleanup code
 - fixed - you can move (right click) multiple items from your bags to the accountbank without some of them just swapping positions
 - fixed - https://github.com/arkayenro/arkinventory/issues/1990 - issue with reputations that are also headers
 - fixed - when using the warbank distance inhibitor the non account bank tabs should now be properly locked out
 - fixed - issue with skyriding/steady flight check code due to new users not having either buff active (default is skyriding when neither buff is active)
 - fixed - flying mount summon in khaz algar
 - fixed - (regression) issue when clicking on the close button of the bank window would stop the main (escape) menu from displaying.  if you used escape to close the window it would be fine
 - fixed - dream warden rep tokens should now link to the correct reputation
 - fixed - account wide reputations should now show in the reputation window
 - fixed - account wide reputations should now show in tooltip item counts
 - fixed - issue generating the reputation level text
 - fixed - issue with item stack size for some multi-unique items (eg some protoform synthesis items) not being reported correctly by blizzard.  this impacted restacking the account bank as it tried to create a stack with more items than you were allowed to have
 - fixed - restack will no longer try to move any sized stack of a unique item into an empty slot
 - changed - restack menu options moved to config
 - changed - restack will now only run aginst bags within the same panel
 - fixed - issues with vault restack
 - fixed - added extra checks to handle the Scrap/SellJunk/ReagentRestocker/Peddler addons not loading properly
 - added - guild bank should now re-open on the last tab you had open
 - fixed - issue with SurfaceArgs and TooltipInfo differences across game clients
 - fixed - the panel options from the right click menu should now only display if the game client has those locations
 - fixed - restack should now work properly but may still have some issues
 - fixed - https://github.com/arkayenro/arkinventory/issues/1975 - default bank ui wasnt staying in sync on bank re-opens which altered the destination for right click item moves
 - fixed - https://github.com/arkayenro/arkinventory/issues/1976 - search match fading when offline or with tinted unusable/unwearable was too difficult to see the difference, have reverted to hiding the items that do not match instead
 - fixed - https://github.com/arkayenro/arkinventory/issues/1974 - issue erasing data for locations that arent supported, eg currency in this case


# known issues
 - account bank tabs are currently excluded from restack
 - interacting with the account bank convergence leaves the normal bank and reagent bank slots visible but not usable
 
 - some default frames (vendor/merchant at minimum) that would normally open via the PlayerInteractionFrameManager no longer open if you are in combat, you just get an addon error.  there is currently no workaround.
 - (dragonflight) reagentbank slots are no longer readable unless the bank is open
 - Enum.ItemConsumableSubclass is missing the Flask entry and everything after has moved down a value which screws up the category names (have hardcoded a workaround for the moment)
 - items with an active cooldown dont allow comparison tooltips to generate
 - cooldowns no longer start automatically.  you can close/open the bag to get them to show (if you enable that option).  all of the cooldown events ACTIONBAR_UPDATE_COOLDOWN, BAG_UPDATE_COOLDOWN, PET_BAR_UPDATE_COOLDOWN, SPELL_UPDATE_COOLDOWN, appear to trigger off other players as well, but do not provide any indication whether the event was triggered by you or them, so cooldowns will trigger window refreshes fairly constantly when you are around large numbers of players.  even limiting it to one update per second generated too much lag, especially in massive groups.
 - chat link for a battlepet in the guild bank will not send
 - the first time you click on a hyperlink in chat it wont show the item counts
 
 
 

# to do
 - double check all categories show/hide for the right clients
 - restack disable - maybe change this to require a modifier key instead of a straight disable?  might be easier to shift/alt/ctrl click on it than turning it on/off and its not like youll accidentally do it (which is why the disable was added)
 - backpack tokens to scroll when max width reached on second line
 - extend the categoryset actions to individual items for additional granular control.
 - add action; move (bank to bag, bag to bank, bag to vault, vault to bag)
 - add actions to items
 - allow multiple actions on a category / item
 
 - secure action button for toybox (and keyring)
