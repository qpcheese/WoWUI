--============================================================================--
--                          EskaTracker                                       --
-- Author     : Skamer <https://mods.curse.com/members/DevSkamer>             --
-- Website    : https://wow.curseforge.com/projects/eskatracker               --
--============================================================================--
Eska                        "EskaTracker.PetTracker"                          ""
--============================================================================--
import                            "EKT"
--============================================================================--
_Active = false

PetTracker  = PetTracker
PetJournal  = PetTracker.Journal

Blocks:RegisterCategory(BlockCategory("pet-tracker", "Pet Tracker", 20, "pet-tracker-basic"))

-- Register some status functions
StatusFunctions:Register(StatusFunction("pet-tracker-has-progress", "Has progress", function()
  if PetJournal then
      return PetJournal:GetCurrentProgress().total > 0
  end

  return false
end, "PetTracker"))


function OnActive(self)
  if not _PetTrackerBlock then
    _PetTrackerBlock = block "pet-tracker"
  end

  _PetTrackerBlock.isActive = true
end

function OnInactive(self)
  _PetTrackerBlock.isActive = false
  _PetTrackerBlock:RemoveAllPets()
end

function LoadPets(self)
  local progress = PetJournal:GetCurrentProgress()
  for quality = 0, PetTracker.Tracker:MaxQuality() do
    for level = 0, PetTracker.MaxLevel do
      for i, specie in ipairs(progress[quality][level] or {}) do
        self:AddSpecie(specie, quality, level)
      end
    end
  end

  self:UpdateProgress(progress)
end

function AddSpecie(self, specie, quality, level)
  local sourceIcon = PetJournal:GetSourceIcon(specie)
  if sourceIcon then
    local name, icon = PetJournal:GetInfo(specie)

    local pet = ObjectManager:Get(Pet)
    pet.id          = specie
    pet.name        = name
    pet.icon        = icon
    pet.quality     = quality
    pet.sourceIcon  = sourceIcon

    _PetTrackerBlock:AddPet(pet)
  end
end

function UpdateProgress(self, progress)
  local owned = 0
  for i = PetTracker.MaxQuality, 1, -1 do
    owned = owned + progress[i].total
  end

  if progress.total > 0 then
    _PetTrackerBlock:ShowProgressBar()
    _PetTrackerBlock:SetMinMaxProgress(0, progress.total)
    _PetTrackerBlock:SetProgress(owned)
    _PetTrackerBlock:SetTextProgress("%i/%i", owned, progress.total)
  else
    _PetTrackerBlock:HideProgress()
  end
end

__SystemEvent__()
function EKT_PET_TRACKER_RELOAD()
  if _PetTrackerBlock then
    _PetTrackerBlock:RemoveAllPets()
    _M:LoadPets()
  end
end

__SecureHook__(PetTracker.Tracker, "Update")
function Hook_PetTrackerUpdate()
  _Active = PetJournal:GetCurrentProgress().total > 0

  if _Active then
    _PetTrackerBlock:RemoveAllPets()
    _M:LoadPets()
  end
end


