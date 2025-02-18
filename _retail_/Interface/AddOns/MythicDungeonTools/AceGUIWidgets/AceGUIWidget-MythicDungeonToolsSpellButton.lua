local Type, Version = "MDTSpellButton", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

local width, height = 248, 32

local methods = {
  ["OnAcquire"] = function(self)
    self:SetWidth(width);
    self:SetHeight(height);
  end,
  ["Initialize"] = function(self)
    self.callbacks = {}

    function self.callbacks.OnClickNormal(_, mouseButton)
      if (IsControlKeyDown()) then

      elseif (IsShiftKeyDown()) then
        if DEFAULT_CHAT_FRAME.editBox and DEFAULT_CHAT_FRAME.editBox:IsVisible() then
          local old = DEFAULT_CHAT_FRAME.editBox:GetText()
          local link = C_Spell.GetSpellLink(self.spellId) or ""
          DEFAULT_CHAT_FRAME.editBox:SetText(old..link)
        end
      else

      end
    end

    function self.callbacks.OnEnter()
      GameTooltip:SetOwner(self.frame, "ANCHOR_BOTTOMLEFT", 0, self.frame:GetHeight())
      GameTooltip:SetSpellByID(self.spellId)
      if self.interruptible then
        local interruptible = CreateTextureMarkup("Interface\\EncounterJournal\\UI-EJ-Icons", 64, 64, 32, 32, 0.75, 0.88
        , 0, 0.5, 0, 0).."Interruptible"
        GameTooltip:AddLine(interruptible)
      end
      GameTooltip:Show()
      if MDT:GetDB().devMode then
        self.frame:EnableKeyboard(true);
      end
    end

    function self.callbacks.OnLeave()
      GameTooltip:Hide()
      if MDT:GetDB().devMode then
        self.frame:EnableKeyboard(false);
      end
    end

    function self.callbacks.OnKeyDown(_, key)
      local db = MDT:GetDB()
      if db.devMode then
        local enemies = MDT.dungeonEnemies[db.currentDungeonIdx]
        local devBlip = MDT:GetCurrentDevmodeBlip()
        local enemyIdx = MDT:GetEnemyInfoEnemyIdx()
        local enemy = enemies[enemyIdx]
        --toggle interruptible
        if key == "I" then
          local spell = enemy.spells[self.spellId]
          spell.interruptible = not spell.interruptible
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        --remove spell
        if key == "R" then
          enemy.spells[self.spellId] = nil
          MDT:UpdateEnemyInfoFrame(enemyIdx)
        end
        --print spellId
        if key == "S" then
          print(self.spellId)
        end
      end

      if (key == "ESCAPE") then
        --
      end
    end

    function self.callbacks.OnDragStart()
      --
    end

    function self.callbacks.OnDragStop()
      --
    end

    self.frame:SetScript("OnClick", self.callbacks.OnClickNormal);
    self.frame:SetScript("OnKeyDown", self.callbacks.OnKeyDown);
    self.frame:SetScript("OnEnter", self.callbacks.OnEnter);
    self.frame:SetScript("OnLeave", self.callbacks.OnLeave);
    self.frame:EnableKeyboard(false);
    self.frame:SetMovable(true);
    self.frame:RegisterForDrag("LeftButton");
    self.frame:SetScript("OnDragStart", self.callbacks.OnDragStart);
    self.frame:SetScript("OnDragStop", self.callbacks.OnDragStop);
    self:Enable();
  end,
  ["SetSpell"] = function(self, spellId, spellData)
    self.spellId = spellId
    local spellInfo = C_Spell.GetSpellInfo(spellId)
    --spell sometimes only exists on beta / ptr - guard against that here
    if not spellInfo then return end
    self.icon:SetTexture(C_Spell.GetSpellTexture(spellId))
    self.title:SetText(spellInfo.name)
    if spellData.interruptible then
      self.interruptible = true
      self.interruptibleIcon:Show()
    else
      self.interruptible = false
      self.interruptibleIcon:Hide()
    end
  end,
  ["Disable"] = function(self)
    self.background:Hide();
    self.frame:Disable();
  end,
  ["Enable"] = function(self)
    self.background:Show();
    self.frame:Enable();
  end,
  ["Pick"] = function(self)
    self.frame:LockHighlight();
  end,
  ["ClearPick"] = function(self)
    self.frame:UnlockHighlight();
  end,
  ["SetIndex"] = function(self, index)
    self.index = index
  end,
  ["SetTitle"] = function(self, title)
    self.titletext = title;
    self.title:SetText(title);
  end,

}

--Constructor
local function Constructor()
  local name = "MDTSpellButton"..AceGUI:GetNextWidgetNum(Type);
  local button = CreateFrame("BUTTON", name, UIParent, "OptionsListButtonTemplate");
  button:SetHeight(height);
  button:SetWidth(width);
  button.dgroup = nil;
  button.data = {};

  local background = button:CreateTexture(nil, "BACKGROUND", nil, 0);
  button.background = background;
  background:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp");
  background:SetBlendMode("ADD");
  background:SetVertexColor(0.5, 0.5, 0.5, 0.25);
  background:SetPoint("TOP", button, "TOP");
  background:SetPoint("BOTTOM", button, "BOTTOM");
  background:SetPoint("LEFT", button, "LEFT");
  background:SetPoint("RIGHT", button, "RIGHT");

  local icon = button:CreateTexture(nil, "OVERLAY", nil, 0);
  button.icon = icon;
  icon:SetWidth(height);
  icon:SetHeight(height);
  icon:SetPoint("LEFT", button, "LEFT");

  local interruptibleIcon = button:CreateTexture(nil, "OVERLAY", nil, 0);
  interruptibleIcon:SetWidth(height * 0.8);
  interruptibleIcon:SetHeight(height * 0.8);
  interruptibleIcon:SetTexture("Interface\\EncounterJournal\\UI-EJ-Icons")
  interruptibleIcon:SetTexCoord(0.75, 0, 0.75, 0.5, 0.88, 0, 0.88, 0.5)
  interruptibleIcon:SetPoint("BOTTOMLEFT", button.icon, "BOTTOMRIGHT", 0, -5);
  interruptibleIcon:Hide()


  local title = button:CreateFontString(nil, "OVERLAY", "GameFontNormal");
  button.title = title;
  title:SetHeight(14);
  title:SetJustifyH("LEFT");
  title:SetPoint("TOP", button, "TOP", 0, -2);
  title:SetPoint("LEFT", icon, "RIGHT", 2, 0);
  title:SetPoint("RIGHT", button, "RIGHT");

  button.description = {};

  button:SetScript("OnEnter", function()

  end);
  button:SetScript("OnLeave", function()

  end);

  local widget = {
    frame = button,
    title = title,
    icon = icon,
    interruptibleIcon = interruptibleIcon,
    background = background,
    type = Type
  }
  for method, func in pairs(methods) do
    ---@diagnostic disable-next-line: assign-type-mismatch
    widget[method] = func
  end

  return AceGUI:RegisterAsWidget(widget);
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)
