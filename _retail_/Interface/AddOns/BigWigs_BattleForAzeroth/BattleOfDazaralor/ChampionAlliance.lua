if UnitFactionGroup("player") ~= "Alliance" then return end

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Champion of the Light Alliance", 2070, 2344)
if not mod then return end
mod:RegisterEnableMob(144683)
mod.engageId = 2265
mod.respawnTime = 19

--------------------------------------------------------------------------------
-- Locals
--

local waveofLightCounter = 0
local faithCaster = nil

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{283573, "TANK"}, -- Sacred Blade
		283598, -- Wave of Light
		284469, -- Seal of Retribution
		283933, -- Judgement: Righteousness
		284436, -- Seal of Reckoning
		284474, -- Judgement: Reckoning
		283662, -- Call to Arms
		282113, -- Avenging Wrath
		284595, -- Penance
		283628, -- Heal
		{283650, "CASTBAR", "CASTBAR_COUNTDOWN"}, -- Blinding Faith
		283582, -- Consecration
		-- Mythic
		287469, -- Prayer for the Fallen
	}, {
		[283573] = CL.general,
		[287469] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "SacredBladeApplied", 283573)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SacredBladeApplied", 283573)
	self:Log("SPELL_CAST_START", "WaveofLight", 283598)
	self:Log("SPELL_AURA_APPLIED", "SealofRetributionApplied", 284469)
	self:Log("SPELL_CAST_START", "JudgementRighteousness", 283933)
	self:Log("SPELL_AURA_APPLIED", "SealofReckoning", 284436)
	self:Log("SPELL_CAST_START", "JudgmentReckoning", 284474)
	self:Log("SPELL_CAST_START", "CalltoArms", 283662)
	self:Log("SPELL_AURA_APPLIED", "AvengingWrathApplied", 282113)
	self:Log("SPELL_CAST_START", "Penance", 284595)
	self:Log("SPELL_CAST_START", "Heal", 283628)
	self:Log("SPELL_CAST_START", "BlindingFaith", 283650)
	self:Death("CrusaderDeath", 147896) -- Zandalari Crusader

	self:Log("SPELL_AURA_APPLIED", "ConsecrationDamage", 283582)
	self:Log("SPELL_PERIODIC_DAMAGE", "ConsecrationDamage", 283582)
	self:Log("SPELL_PERIODIC_MISSED", "ConsecrationDamage", 283582)

	-- Mythic
	self:Log("SPELL_CAST_START", "PrayerfortheFallen", 287469)
end

function mod:OnEngage()
	waveofLightCounter = 1
	faithCaster = nil

	self:CDBar(283650, 12) -- Blinding Faith
	self:Bar(283598, 13, CL.count:format(self:SpellName(283598), waveofLightCounter)) -- Wave of Light
	self:CDBar(283662, 100) -- Call to Arms
	if self:Mythic() then
		self:CDBar(287469, 25) -- Prayer for the Fallen
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SacredBladeApplied(args)
	local amount = args.amount or 1
	if amount > 6 then
		self:StackMessageOld(args.spellId, args.destName, args.amount, "purple")
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:WaveofLight(args)
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, waveofLightCounter))
	self:PlaySound(args.spellId, "alert")
	waveofLightCounter = waveofLightCounter + 1
	self:Bar(args.spellId, 11, CL.count:format(args.spellName, waveofLightCounter))
end

function mod:SealofRetributionApplied(args)
	if self.isEngaged then -- Casted after boss respawns
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "info")
		self:CDBar(283933, 51) -- Judgement: Righteousness
	end
end

function mod:JudgementRighteousness(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:SealofReckoning(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(284474, 51) -- Judgement: Reckoning
end

function mod:JudgmentReckoning(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
end

function mod:CalltoArms(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 100)
end

function mod:AvengingWrathApplied(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
end

function mod:Penance(args)
	if self:Interrupter() then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:Heal(args)
	if self:Interrupter(args.sourceGUID) then
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:BlindingFaith(args)
	faithCaster = args.sourceGUID
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "warning")
	self:CastBar(args.spellId, 4)
	self:CDBar(args.spellId, 15)
end

function mod:CrusaderDeath(args)
	if args.destGUID == faithCaster then
		self:StopBar(CL.cast:format(self:SpellName(283650))) -- Blinding Faith
	end
end

do
	local prev = 0
	function mod:ConsecrationDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then
				prev = t
				self:PlaySound(args.spellId, "alarm")
				self:PersonalMessage(args.spellId, "underyou")
			end
		end
	end
end

function mod:PrayerfortheFallen(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 50)
end
