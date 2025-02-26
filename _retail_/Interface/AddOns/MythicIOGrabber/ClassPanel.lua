local addonName, miog = ...
local wticc = WrapTextInColorCode

miog.createClassPanel = function()
    miog.ClassPanel = CreateFrame("Frame", "MythicIOGrabber_ClassPanel", miog.pveFrame2 or PVEFrame, "MIOG_ClassPanel")
	miog.ClassPanel:SetPoint("BOTTOMRIGHT", miog.ClassPanel:GetParent(), "TOPRIGHT", 0, 1)
    miog.ClassPanel:SetPoint("BOTTOMLEFT", miog.ClassPanel:GetParent(), "TOPLEFT", 0, 1)

    local classPanel = miog.ClassPanel.Container

    classPanel:SetHeight(classPanel:GetParent():GetHeight() - 5)

    classPanel.classFrames = {}

    --CLASS PANEL FUCKS UP SOMEWHERE, PLEASE FIX XD

    for classID, classEntry in ipairs(miog.CLASSES) do
        local classFrame = CreateFrame("Frame", nil, classPanel, "MIOG_ClassPanelClassFrameTemplate")
        classFrame.layoutIndex = classID
        classFrame:SetSize(classPanel:GetHeight(), classPanel:GetHeight())

        classFrame.Icon:SetTexture(classEntry.icon)
        classFrame.leftPadding = 3
        classPanel.classFrames[classID] = classFrame

        local specPanel = CreateFrame("Frame", nil, classFrame, "VerticalLayoutFrame, BackdropTemplate")
        specPanel:SetPoint("TOP", classFrame, "BOTTOM", 0, -5)
        specPanel.fixedHeight = classFrame:GetHeight() - 3
        specPanel.specFrames = {}
        specPanel:Hide()
        classFrame.specPanel = specPanel

        local specCounter = 1

        for _, specID in ipairs(classEntry.specs) do
            local specFrame = CreateFrame("Frame", nil, specPanel, "MIOG_ClassPanelSpecFrameTemplate")
            specFrame:SetSize(specPanel.fixedHeight, specPanel.fixedHeight)
            specFrame.Icon:SetTexture(miog.SPECIALIZATIONS[specID].squaredIcon)
            specFrame.layoutIndex = specCounter
            specFrame.leftPadding = 0

            specPanel.specFrames[specID] = specFrame

            specCounter = specCounter + 1
        end

        specPanel:MarkDirty()

        classFrame:SetScript("OnEnter", function()
            specPanel:Show()

        end)
        classFrame:SetScript("OnLeave", function()
            specPanel:Hide()

        end)
    end

    classPanel:MarkDirty()

	miog.ClassPanel.LoadingSpinner:SetScript("OnMouseDown", function()
		miog.resetInspectCoroutine()
	end)
end