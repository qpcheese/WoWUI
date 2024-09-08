--============================================================================--
--                          EskaTracker                                       --
-- Author     : Skamer <https://mods.curse.com/members/DevSkamer>             --
-- Website    : https://wow.curseforge.com/projects/eskatracker               --
--============================================================================--
Eska                 "EskaTracker.PetTracker.Classes.Pet"                     ""
--============================================================================--
namespace                        "EKT"
--============================================================================--
PET_HEIGHT_SETTING               = "pet-tracker-pet-height"
--============================================================================--

__Recyclable__()
class "Pet" (function(_ENV)
  inherit "Frame"
  ------------------------------------------------------------------------------
  --                                Handlers                                  --
  ------------------------------------------------------------------------------
  local function UpdateProps(self, new, old, prop)
    if prop == "name" then
      self:Skin(Theme.SkinFlags.TEXT_TRANSFORM, Theme:GetElementID(self.frame.name))
    elseif prop == "icon" then
      self.frame.icon:SetTexture(new)
    elseif prop == "sourceIcon" then
      self.frame.sourceIcon:SetTexture(new)
    elseif prop == "quality" then
      if new then
        if PetTracker.Sets.CapturedPets then
          local r,g,b = PetTracker.GetQualityColor(new)
          self.frame.name:SetTextColor(r,g,b)
        else
          self.frame.name:SetTextColor(0.8, 0.8, 0.8, HIGHLIGHT_FONT_COLOR_CODE:sub(3))
        end
      end
    end
  end

  ------------------------------------------------------------------------------
  --                             Methods                                      --
  ------------------------------------------------------------------------------
  __Arguments__ { Variable.Optional(Theme.SkinFlags, Theme.DefaultSkinFlags), Variable.Optional(String) }
  function OnSkin(self, flags, target)
    super.OnSkin(self, flags, target)

    local state = self:GetCurrentState()

    if Theme:NeedSkin(self.frame, target) then
      Theme:SkinFrame(self.frame, flags, state)
    end

    if Theme:NeedSkin(self.frame.name, target) then
      Theme:SkinText(self.frame.name, Utils.RemoveEnumFlag(flags, Theme.SkinFlags.TEXT_COLOR), self.name, state)
    end
  end


  function Init(self)
    local prefix  = self:GetClassPrefix()
    local state   = self:GetCurrentState()

    -- Register fram in theme system
    Theme:RegisterFrame(prefix..".pet.frame", self.frame)
    Theme:RegisterText(prefix..".pet.name", self.frame.name)

    -- Then skin them
    Theme:SkinFrame(self.frame, nil, state)
    Theme:SkinText(self.frame.name, Utils.RemoveEnumFlag(Theme.DefaultSkinFlags, Theme.SkinFlags.TEXT_COLOR), self.name, state)

    -- Load settings
    self:LoadSetting(PET_HEIGHT_SETTING)

  end
  ------------------------------------------------------------------------------
  --                          Settings                                        --
  ------------------------------------------------------------------------------
  __Arguments__ { String }
  function IsRegisteredSetting(self, setting)
    if setting == PET_HEIGHT_SETTING then
      return true
    end

    return super.IsRegisteredSetting(self, setting)
  end

  __Arguments__ { String, Variable.Optional(), Variable.Optional() }
  function OnSetting(self, setting, new, old)
    if setting == PET_HEIGHT_SETTING then
      self.height = new
      self.baseHeight = new
      self.frame.icon:SetWidth(new)
      self.frame.sourceIcon:SetHeight(ceil(new*(13/22)))
    end
  end

  function OnReset(self)
    self.id         = nil
    self.name       = nil
    self.icon       = nil
    self.quality    = nil
    self.level      = nil
    self.sourceIcon = nil
  end

  ------------------------------------------------------------------------------
  --                         Properties                                       --
  ------------------------------------------------------------------------------
  property "id" { TYPE = Number }
  property "name" { TYPE = String, DEFAULT = "", HANDLER = UpdateProps }
  property "icon" { TYPE = String + Number, HANDLER = UpdateProps  }
  property "quality" { TYPE = Number, HANDLER = UpdateProps }
  property "level" { TYPE = Number }
  property "sourceIcon" { TYPE = String + Number, HANDLER = UpdateProps }

  __Static__() property "_prefix" { DEFAULT = "pet-tracker"}
  ------------------------------------------------------------------------------
  --                            Constructors                                  --
  ------------------------------------------------------------------------------
  function Pet(self)
    super(self, CreateFrame("Button"))
    self.frame:SetBackdrop(_Backdrops.Common)
    self.frame:SetBackdropColor(0, 0, 0, 0)
    self.frame:SetScript("OnClick", function()
      PetTracker.Journal:Display(self.id)
    end)

    local icon = self.frame:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("TOPLEFT")
    icon:SetPoint("BOTTOMLEFT")
    icon:SetWidth(22)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    self.frame.icon = icon

    local name = self.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    name:SetPoint("LEFT", icon, "RIGHT", 10, 0)
    name:SetPoint("TOP")
    name:SetPoint("BOTTOM")
    name:SetPoint("RIGHT")
    self.frame.name = name

    local sourceIcon = self.frame:CreateTexture(nil, "OVERLAY")
    sourceIcon:SetPoint("CENTER", icon, "BOTTOMRIGHT", 0, 5)
    sourceIcon:SetHeight(13)
    sourceIcon:SetWidth(13)
    self.frame.sourceIcon = sourceIcon


    self.baseHeight = 22
    self.height = self.baseHeight

    -- Init things (register, skin elements)
    Init(self)
  end
end)

function OnLoad(self)
  Settings:Register(PET_HEIGHT_SETTING, 22)
end
