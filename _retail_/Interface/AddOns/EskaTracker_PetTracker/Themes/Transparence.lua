-- ========================================================================== --
-- 										 EskaQuestTracker                                       --
-- @Author   : Skamer <https://mods.curse.com/members/DevSkamer>              --
-- @Website  : https://wow.curseforge.com/projects/eska-quest-tracker         --
-- ========================================================================== --
import "EKT"
--============================================================================--
local TransparenceTheme = Themes:Get("Transparence")

if not TransparenceTheme then return end

TransparenceTheme:SetElementProperty("block.pet-tracker.content", "background-color", { r = 0, g = 0, b = 0, a = 0.3})
TransparenceTheme:SetElementProperty("pet-tracker.pet.name", "text-size", 9)
TransparenceTheme:SetElementProperty("pet-tracker.pet.name", "text-font", "DejaVuSansCondensed Bold")
TransparenceTheme:SetElementProperty("pet-tracker.pet.name", "text-color", { r = 1, g = 1, b = 1 })
TransparenceTheme:SetElementProperty("pet-tracker.pet.name", "text-transform", "none")
