local MER, F, E, I, V, P, G, L = unpack(ElvUI_MerathilisUI)
local module = MER:GetModule("MER_UnitFrames")

function module:Update_RaidFrames(frame)
	local db = E.db.mui.unitframes

	module:CreateHighlight(frame)
end
