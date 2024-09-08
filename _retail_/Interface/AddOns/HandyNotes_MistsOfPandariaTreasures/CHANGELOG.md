# HandyNotes: Mists of Pandaria (Treasures and Rares)

## [v35](https://github.com/kemayo/wow-handynotes-lostandfound/tree/v35) (2024-09-06)
[Full Changelog](https://github.com/kemayo/wow-handynotes-lostandfound/compare/v34...v35) [Previous Releases](https://github.com/kemayo/wow-handynotes-lostandfound/releases)

- Update handler submodule to main (5d9e50e)  
    New changes:  
    0292bba Related points: add hide\_before, fix type on requires  
    086157b Related points: fix passing through a texture  
    daf38f9 Options dialog: fix group names not being passed through render\_string  
    2f35f54 Fix opening core handynotes options from dropdown  
    6e7904c Add per-run cache that'll store data for the current GetNodes2  
    0ba0f36 Rearrange the settings in the dialog and dropdown  
    370e8e9 Behavior change: count exact items for transmog, setting to revert  
    932ae80 Rearrange map-providers for less clutter  
    15075c8 Improve atlas\_texture for more complex crops  
    3d1d3c2 Improve "show treasure" so it *only* controls treasure  
    7c65f13 New option to emphasize notable NPCs  
    8ac095d Change how show\_npcs works  
    f50a152 Add a helper for quickly toggling found nodes  
    72a3659 Stop non-npc non-treasure points without completion from being considered "found" always  
    ea41385 Consider whether loot is likely to drop in notability  
    a81c8dc Highlight notable loot in the tooltip if you're emphasizing it for icons  
    18b8280 Fix clearing the appearances cache between runs  
    b1e1659 Enhance classes to cope with calling a superclass better  
    d08d31d Condition summary: option for a short-form without the "requires"  
    019c7d8 Extreme rewrite of the loot system in preparation for expanding it  
    e9c2857 New loot type: currency  
    8f8045f Let currency flag itself as notable  
    5d1022c Add settings to define what counts as notability  
    bc8750a Expose the condition base classes for extension  
    9c8a519 Fix some interactions within notability with transmog + quests  
    4f3030c New setting to allow alt achievement progress to count  
    3692d75 Sprinkle in some usage of color constants for tooltip text  
    7a37d5e Give treasure the same dropdown as NPCs for filter-selection  
    ce2bb5d Improve their tostring, and give explicit classnames to my conditions  
    a77db72 Fix the "found" check from 7a37d5e684410cb9cf12d0010029f763294f3582  
    45de921 Don't need these classic atlas fallbacks any more  
    53ad145 Don't error if we try to check non-existent conditions  
    15ab528 Put the tooltip achievement handling somewhere it can be reused  
    ce2b4bd Check the account quest completion for reputation  
    0805b3b Simple getters helper  
    8adec5b SEMI-BREAKING: Switch class system to a variant of LCS  
    6030470 Refactor some otherwise unused functions into rewards, split that up  
    f7840d3 Add PlayerHasTransmogByItemInfo compatibility shim for cataclysm classic  
    c8035f8 Remove some debug globals that snuck through  
    625ee0b Fix some style issues and typos  
    155255b Show armor-types in tooltip labels  
    5afc365 Fix loot-upgrader to not always require the more-expensive path  
    da81faa Give mounts and pets better tooltips  
    70c737a Bring in some reward enhancements from SilverDragon  
    1e65fed Currency reward AddToItemButton  
    fc92bc6 Allow point.always to override the filter settings  
    af59ade Different less-notable color for mobs that only have transmog  
    a7e6483 Switch the notable icon colors around because purple is transmog  
    d0297cc Toy condition should extend Item  
    0c1308f Add a new recipe reward type  
    1c7c228 Better notoriety-without-transmog calculation  
    5d9e50e nodeMaker should shallow-copy the existing table if needed  
- Remove 110000 from TOC  
