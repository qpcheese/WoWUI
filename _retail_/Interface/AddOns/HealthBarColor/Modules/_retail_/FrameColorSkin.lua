local _, addonTable = ...
local addon = addonTable.addon

if C_AddOns.IsAddOnLoaded("FrameColor") then
  local info =
  {
    moduleName = "HealthBarColor",
    color1 =
    {
      name = "Main",
      desc = "",
    },
    color2 =
    {
      name = "Background",
      desc = "",
      hasAlpha = true,
    },
    color3 =
    {
      name = "Tabs",
      desc = "",
    },
  }

  local module = FrameColor_CreateSkinModule(info)

  function module:OnEnable()
    local main_color = self:GetColor1()
    local bg_color = self:GetColor2()
    local tab_color = self:GetColor3()
    self:Recolor(main_color, bg_color, tab_color, 1)
  end

  function module:OnDisable()
    local color = {r=1,g=1,b=1,a=1}
    self:Recolor(color, color, color, 0)
  end

  function module:Recolor(main_color, bg_color, tab_color, desaturation)
    local healthBarColorOptionsFrame = addon:GetOptionsFrame()
    for _, texture in pairs(
      {
        healthBarColorOptionsFrame.NineSlice.TopEdge,
        healthBarColorOptionsFrame.NineSlice.BottomEdge,
        healthBarColorOptionsFrame.NineSlice.TopRightCorner,
        healthBarColorOptionsFrame.NineSlice.TopLeftCorner,
        healthBarColorOptionsFrame.NineSlice.RightEdge,
        healthBarColorOptionsFrame.NineSlice.LeftEdge,
        healthBarColorOptionsFrame.NineSlice.BottomRightCorner,
        healthBarColorOptionsFrame.NineSlice.BottomLeftCorner,
      }
    ) do
      texture:SetDesaturation(desaturation)
      texture:SetVertexColor(main_color.r,main_color.g,main_color.b)
    end
    local backgroundTexture = healthBarColorOptionsFrame.Bg
    if backgroundTexture then
      backgroundTexture:SetDesaturation(desaturation)
      backgroundTexture:SetVertexColor(bg_color.r, bg_color.g, bg_color.b, bg_color.a)
    end
    for _, tab in pairs({ healthBarColorOptionsFrame.TabSystem:GetChildren() }) do
      for _, texture in pairs(
        {
          tab.Left,
          tab.Middle,
          tab.Right,
        }
      ) do
        texture:SetVertexColor(tab_color.r,tab_color.g,tab_color.b,tab_color.a)
      end
    end
  end
end
