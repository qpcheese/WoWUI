--============================================================================--
--                          EskaTracker                                       --
-- Author     : Skamer <https://mods.curse.com/members/DevSkamer>             --
-- Website    : https://wow.curseforge.com/projects/eskatracker               --
--============================================================================--
Eska              "EskaTracker.PetTracker.Classes.PetTrackerBlock"            ""
--============================================================================--
namespace                         "EKT"
--============================================================================--
__Block__ "pet-tracker-basic" "pet-tracker"
class "PetTrackerBlock" ( function(_ENV)

    local function CreateStatusBar(self)
      local bar = CreateFrame("StatusBar", nil, self.frame.content)
      bar:SetStatusBarTexture(_Backdrops.Common.bgFile)
      bar:SetStatusBarColor(0, 148/255, 1, 0.6)
      bar:SetMinMaxValues(0, 1)
      bar:SetValue(0.6)

      local text = bar:CreateFontString(nil, "OVERLAY", GameFontHighlightSmall)
      local color = { r = 0, g = 148 / 255, b = 255 / 255 }
      local font = _LibSharedMedia:Fetch("font", "PT Sans Bold Italic")

      text:SetTextColor(1, 1, 1, 1)
      text:SetAllPoints()
      text:SetFont(font, 13) -- 9
      text:SetJustifyH("CENTER")
      text:SetJustifyV("MIDDLE")
      bar.text = text

      local bgFrame = CreateFrame("Frame", nil, bar)
      bgFrame:SetPoint("TOPLEFT", -2, 2)
      bgFrame:SetPoint("BOTTOMRIGHT", 2, -2)
      bgFrame:SetFrameLevel(bgFrame:GetFrameLevel() - 1)

      bgFrame.background = bgFrame:CreateTexture(nil, "BACKGROUND")
      bgFrame.background:SetAllPoints(bgFrame)
      bgFrame.background:SetTexture([[Interface\AddOns\EskaTracker\Media\Textures\Frame-Background-6]])
      bgFrame.background:SetVertexColor(0, 0, 0, 0.5)

      local borderB = bgFrame:CreateTexture(nil,"OVERLAY")
      borderB:SetColorTexture(0,0,0)
      borderB:SetPoint("BOTTOMLEFT")
      borderB:SetPoint("BOTTOMRIGHT")
      borderB:SetHeight(3)

      local borderT = bgFrame:CreateTexture(nil,"OVERLAY")
      borderT:SetColorTexture(0,0,0)
      borderT:SetPoint("TOPLEFT")
      borderT:SetPoint("TOPRIGHT")
      borderT:SetHeight(3)

      local borderL = bgFrame:CreateTexture(nil,"OVERLAY")
      borderL:SetColorTexture(0,0,0)
      borderL:SetPoint("TOPLEFT")
      borderL:SetPoint("BOTTOMLEFT")
      borderL:SetWidth(3)

      local borderR = bgFrame:CreateTexture(nil,"OVERLAY")
      borderR:SetColorTexture(0,0,0)
      borderR:SetPoint("TOPRIGHT")
      borderR:SetPoint("BOTTOMRIGHT")
      borderR:SetWidth(3)


      return bar
    end
  ------------------------------------------------------------------------------
  --                             Methods                                      --
  ------------------------------------------------------------------------------
  __Arguments__ { Pet }
  function AddPet(self, pet)
    pet:SetParent(self.frame.content)

    pet.OnHeightChanged = function(_, new, old)
      self.height = self.height + (new - old)
    end

    self.pets:Insert(pet)
    self:Draw()
  end

  __Arguments__ { Pet }
  function RemovePet(self, pet)
    self.pets:Remove(pet)
    pet:Recycle()
    self:Layout()
  end

  function RemoveAllPets(self)
    for _, pet in self.pets:GetIterator() do
      pet:Recycle()
    end
    self.pets:Clear()
    self:ForceLayout()
  end

  function OnLayout(self)
    local previousFrame
    for index, pet in self.pets:GetIterator() do
      pet:Hide()
      pet:ClearAllPoints()

      if index == 1 then
        if self:HasProgress() then
          pet:SetPoint("TOP", self.frame.fbar, "BOTTOM", 0, -10)
        else
          pet:SetPoint("TOP")
        end
        pet:SetPoint("LEFT", 4, 0)
        pet:SetPoint("RIGHT", 4, 0)
      else
        pet:SetPoint("TOPLEFT", previousFrame, "BOTTOMLEFT", 0, -5)
        pet:SetPoint("TOPRIGHT", previousFrame, "BOTTOMRIGHT")
      end

      previousFrame = pet.frame
      pet:Show()
    end

    self:CalculateHeight()
  end

  function HasProgress(self)
    if self.frame.fbar and self.frame.fbar:IsShown() then
      return true
    else
      return false
    end
  end

  function ShowProgressBar(self)
    if not self.frame.fbar then
      local fbar = CreateStatusBar(self)
      fbar:SetHeight(18)
      fbar:SetPoint("TOP", 0, -4)
      fbar:SetPoint("LEFT", 8, 0)
      fbar:SetPoint("RIGHT", -8, 0)
      self.frame.fbar = fbar
    end

    if self.pets[1] then
      self.pets[1]:SetPoint("TOP", self.frame.fbar, "BOTTOM", 0, -10)
    end

    self.frame.fbar:Show()
    self:CalculateHeight()
  end

  function HideProgress(self)
    if self.frame.fbar then
      self.frame.fbar:Hide()

      if self.pets[1] then
        self.pets[1]:SetPoint("TOP")
      end
    end

    self:CalculateHeight()
  end

  __Arguments__ { String }
  function SetTextProgress(self, text)
    if self.frame.fbar then
      self.frame.fbar.text:SetText(text)
    end
  end

  __Arguments__ { String, Any, Variable.Rest(Any) }
  function SetTextProgress(self, text, ...)
    if self.frame.fbar then
      self.frame.fbar.text:SetFormattedText(text, ...)
    end
  end

  __Arguments__ { Number }
  function SetProgress(self, progress)
    if self.frame.fbar then
      self.frame.fbar:SetValue(progress)
    end
  end

  __Arguments__ { Number, Number }
  function SetMinMaxProgress(self, min, max)
    if self.frame.fbar then
      self.frame.fbar:SetMinMaxValues(min, max)
    end
  end


  function CalculateHeight(self)
    local height = self.baseHeight
    local offset = 5
    for index, pet in self.pets:GetIterator() do
      height = height + pet.height + offset
    end

    -- if it has a progress
    if self:HasProgress() then
      height = height + 30
    end

    self.height = height
  end
  ------------------------------------------------------------------------------
  --                            Constructors                                  --
  ------------------------------------------------------------------------------
  function PetTrackerBlock(self)
    super(self)
    self.text = "Pets"

    self.pets = Array[Pet]()
  end

end)
