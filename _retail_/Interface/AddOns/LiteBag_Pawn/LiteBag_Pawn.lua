-- LiteBag Pawn Support Plugin

local function UpdateButton(button)
    if not (button and button:IsShown() and PawnIsContainerItemAnUpgrade and button.UpgradeIcon) then
        return;
    end

    button.UpgradeIcon:Hide();

    if not button.count or button.count <= 0 then
        return;
    end

    local bag  = button:GetBagID();
    local slot = button:GetID();

    if not bag or not slot then
        bag = button.bankTabID;
        slot = button.containerSlotID;
    end

    local isUpgrade = PawnIsContainerItemAnUpgrade(bag, slot);

    button.UpgradeIcon:SetShown(isUpgrade);
end

if LiteBag_RegisterHook then
    LiteBag_RegisterHook('LiteBagItemButton_Update', UpdateButton, true);
end