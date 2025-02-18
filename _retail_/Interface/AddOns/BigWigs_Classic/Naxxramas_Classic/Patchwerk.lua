--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Patchwerk", 533, 1610)
if not mod then return end
mod:RegisterEnableMob(16028)
mod:SetEncounterID(1118)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		28131, -- Enrage
		"berserk",
	},nil,{
		[28131] = CL.health_percent:format(5), -- Enrage (5% Health)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Enrage", 28131)
end

function mod:OnEngage()
	self:Berserk(420)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Enrage(args)
	self:Message(args.spellId, "orange", CL.percent:format(5, args.spellName))
	self:PlaySound(args.spellId, "long")
end
