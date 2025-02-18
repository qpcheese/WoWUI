local MER, F, E, I, V, P, G, L = unpack(ElvUI_MerathilisUI)
local module = MER:GetModule("MER_Skins")
local S = E:GetModule("Skins")

local _G = _G
local hooksecurefunc = hooksecurefunc

local CreateFrame = CreateFrame

function module:OmniCD_ConfigGUI()
	local O = _G.OmniCD[1]

	hooksecurefunc(O.Libs.ACD, "Open", function(_, arg1)
		if arg1 == O.AddOn then
			local frame = O.Libs.ACD.OpenFrames.OmniCD.frame
			frame:SetTemplate("Transparent")
			module:CreateShadow(frame)
		end
	end)
end

function module:OmniCD_Party_Icon()
	local O = _G.OmniCD[1]
	hooksecurefunc(O.Party, "SetBorder", function(_, icon)
		module:CreateShadow(icon)
	end)
end

function module:OmniCD_Party_ExtraBars()
	local O = _G.OmniCD[1]
	local colorDB = E.db.mui.gradient

	hooksecurefunc(O.Party, "GetStatusBar", function(_, icon)
		if icon.statusBar then
			if not icon.statusBar.__MER then
				icon.statusBar.__MER = CreateFrame("Frame", nil, icon.statusBar)
				icon.statusBar.__MER:SetFrameLevel(icon.statusBar:GetFrameLevel() - 1)
			end

			local x, _ = icon:GetSize()

			icon.statusBar.__MER:ClearAllPoints()
			icon.statusBar.__MER:SetPoint("TOPLEFT", icon.statusBar, "TOPLEFT", -x - 1, 0)
			icon.statusBar.__MER:SetPoint("BOTTOMRIGHT", icon.statusBar, "BOTTOMRIGHT", 0, 0)
			module:CreateShadow(icon.statusBar.__MER)

			if icon.statusBar.CastingBar then
				S:HandleStatusBar(icon.statusBar.CastingBar)
			end

			if icon.class then
				hooksecurefunc(icon.statusBar.BG, "SetVertexColor", function(bar)
					if colorDB.enable then
						if colorDB.customColor.enableClass then
							bar:SetGradient("HORIZONTAL", F.GradientColorsCustom(bar:GetParent():GetParent().class))
						else
							bar:SetGradient("HORIZONTAL", F.GradientColors(bar:GetParent():GetParent().class))
						end
					end
				end)
			end
		end
	end)
end

function module:OmniCD()
	if not E.private.mui.skins.addonSkins.enable or not E.private.mui.skins.addonSkins.omniCD then
		return
	end

	self:OmniCD_ConfigGUI()
	self:OmniCD_Party_Icon()
	self:OmniCD_Party_ExtraBars()
end

module:AddCallbackForAddon("OmniCD")
