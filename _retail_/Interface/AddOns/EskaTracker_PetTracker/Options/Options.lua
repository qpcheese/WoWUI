--============================================================================--
--                         EskaTracker : PetTracker                           --
-- Author     : Skamer <https://mods.curse.com/members/DevSkamer>             --
-- Website    : https://wow.curseforge.com/projects/eskatracker-objectives    --
--============================================================================--
Eska                  "EskaTracker.PetTracker.Options"                        ""
--============================================================================--
import                        "EKT"
--============================================================================--
function  OnLoad(self)
  self:AddPetTrackerRecipes()
end

function AddPetTrackerRecipes(self)
  -- Create the pet tracker tree item
  OptionBuilder:AddRecipe(TreeItemRecipe():SetID("pet-tracker"):SetText("Pet Tracker"):SetBuildingGroup("pet-tracker/children"):SetOrder(105), "RootTree")


  local petTrackerShowCapture = CheckBoxRecipe()
  petTrackerShowCapture:SetText("Show captured pets")
  petTrackerShowCapture:Set(function(_, value)
    PetTracker.Sets.CapturedPets = value
    PetTracker:ForAllModules('TrackingChanged')
    Scorpio.FireSystemEvent("EKT_PET_TRACKER_RELOAD")
  end)
  petTrackerShowCapture:Get(function() return PetTracker.Sets.CapturedPets end)
  petTrackerShowCapture:SetOrder(10)
  OptionBuilder:AddRecipe(petTrackerShowCapture, "pet-tracker/children")

  OptionBuilder:AddRecipe(HeadingRecipe():SetOrder(20), "pet-tracker/children")
  local petHeightRecipe = RangeRecipe()
  petHeightRecipe:SetRange(6, 32)
  petHeightRecipe:BindSetting("pet-tracker-pet-height")
  petHeightRecipe:SetOrder(21)
  petHeightRecipe:SetText("Pet Height")
  OptionBuilder:AddRecipe(petHeightRecipe, "pet-tracker/children")

  OptionBuilder:AddRecipe(HeadingRecipe():SetText("Pet Frame"):SetOrder(50), "pet-tracker/children")
  OptionBuilder:AddRecipe(ThemePropertyRecipe():SetElementID("pet-tracker.pet.frame"):SetOrder(51), "pet-tracker/children")

  -- Name
  OptionBuilder:AddRecipe(HeadingRecipe():SetText("Pet Name"):SetOrder(60), "pet-tracker/children")
  OptionBuilder:AddRecipe(ThemePropertyRecipe()
  :SetElementID("pet-tracker.pet.name")
  :SetOrder(61)
  :ClearFlags()
  :AddFlag(Theme.SkinFlags.TEXT_SIZE)
  :AddFlag(Theme.SkinFlags.TEXT_FONT)
  :AddFlag(Theme.SkinFlags.TEXT_TRANSFORM)
  :AddFlag(Theme.SkinFlags.TEXT_JUSTIFY_HORIZONTAL), "pet-tracker/children")

end
