-- ========================================================================== --
-- 										 EskaQuestTracker                                       --
-- @Author   : Skamer <https://mods.curse.com/members/DevSkamer>              --
-- @Website  : https://wow.curseforge.com/projects/eska-quest-tracker         --
-- ========================================================================== --
import "EKT"
--============================================================================--
local EskaTheme = Themes:Get("Eska")

if not EskaTheme then return end

EskaTheme:SetElementProperty("pet-tracker.pet.name", "text-size", 12)
EskaTheme:SetElementProperty("pet-tracker.pet.name", "text-font", "PT Sans Narrow Bold")
EskaTheme:SetElementProperty("pet-tracker.pet.name", "text-color", { r = 1, g = 1, b = 1 })
EskaTheme:SetElementProperty("pet-tracker.pet.name", "text-transform", "none")
