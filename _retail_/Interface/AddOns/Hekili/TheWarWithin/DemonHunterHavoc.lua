-- DemonHunterHavoc.lua
-- July 2024

if UnitClassBase( "player" ) ~= "DEMONHUNTER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local strformat, wipe = string.format, table.wipe
local GetSpellInfo = ns.GetUnpackedSpellInfo

local spec = Hekili:NewSpecialization( 577 )

spec:RegisterResource( Enum.PowerType.Fury, {
    -- Immolation Aura now grants 20 up front, 60 over 12 seconds (5 fps).
    immolation_aura = {
        talent  = "burning_hatred",
        aura    = "immolation_aura",

        last = function ()
            local app = state.buff.immolation_aura.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = 1,
        value = 5
    },

    tactical_retreat = {
        talent  = "tactical_retreat",
        aura    = "tactical_retreat",

        last = function ()
            local app = state.buff.tactical_retreat.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = function() return class.auras.tactical_retreat.tick_time end,
        value = 8
    },

    eye_beam = {
        talent = "blind_fury",
        aura   = "eye_beam",

        last = function ()
            local app = state.buff.eye_beam.applied
            local t = state.query_time

            return app + floor( ( t - app ) / state.haste ) * state.haste
        end,

        interval = function () return state.haste end,
        value = 20,
    },
} )

-- Talents
spec:RegisterTalents( {
    -- Demon Hunter
    aldrachi_design          = { 90999, 391409, 1 }, -- Increases your chance to parry by 3%.
    aura_of_pain             = { 90933, 207347, 1 }, -- Increases the critical strike chance of Immolation Aura by 6%.
    blazing_path             = { 91008, 320416, 1 }, -- Fel Rush gains an additional charge.
    bouncing_glaives         = { 90931, 320386, 1 }, -- Throw Glaive ricochets to 1 additional target.
    champion_of_the_glaive   = { 90994, 429211, 1 }, -- Throw Glaive has 2 charges and 10 yard increased range.
    chaos_fragments          = { 95154, 320412, 1 }, -- Each enemy stunned by Chaos Nova has a 30% chance to generate a Lesser Soul Fragment.
    chaos_nova               = { 90993, 179057, 1 }, -- Unleash an eruption of fel energy, dealing 2,956 Chaos damage and stunning all nearby enemies for 2 sec. Each enemy stunned by Chaos Nova has a 30% chance to generate a Lesser Soul Fragment.
    charred_warblades        = { 90948, 213010, 1 }, -- You heal for 3% of all Fire damage you deal.
    collective_anguish       = { 95152, 390152, 1 }, -- Eye Beam summons an allied Vengeance Demon Hunter who casts Fel Devastation, dealing 18,271 Fire damage over 2 sec. Dealing damage heals you for up to 1,641 health.
    consume_magic            = { 91006, 278326, 1 }, -- Consume 1 beneficial Magic effect removing it from the target.
    darkness                 = { 91002, 196718, 1 }, -- Summons darkness around you in an 8 yd radius, granting friendly targets a 15% chance to avoid all damage from an attack. Lasts 8 sec. Chance to avoid damage increased by 100% when not in a raid.
    demon_muzzle             = { 90928, 388111, 1 }, -- Enemies deal 8% reduced magic damage to you for 8 sec after being afflicted by one of your Sigils.
    demonic                  = { 91003, 213410, 1 }, -- Eye Beam causes you to enter demon form for 5 sec after it finishes dealing damage.
    disrupting_fury          = { 90937, 183782, 1 }, -- Disrupt generates 30 Fury on a successful interrupt.
    erratic_felheart         = { 90996, 391397, 2 }, -- The cooldown of Fel Rush is reduced by 10%.
    felblade                 = { 95150, 232893, 1 }, -- Charge to your target and deal 11,329 Chaos damage. Demon Blades has a chance to reset the cooldown of Felblade. Generates 40 Fury.
    felfire_haste            = { 90939, 389846, 1 }, -- Fel Rush increases your movement speed by 10% for 8 sec.
    flames_of_fury           = { 90949, 389694, 2 }, -- Sigil of Flame deals 35% increased damage and generates 1 additional Fury per target hit.
    illidari_knowledge       = { 90935, 389696, 1 }, -- Reduces magic damage taken by 5%.
    imprison                 = { 91007, 217832, 1 }, -- Imprisons a demon, beast, or humanoid, incapacitating them for 1 min. Damage will cancel the effect. Limit 1.
    improved_disrupt         = { 90938, 320361, 1 }, -- Increases the range of Disrupt to 10 yds.
    improved_sigil_of_misery = { 90945, 320418, 1 }, -- Reduces the cooldown of Sigil of Misery by 30 sec.
    infernal_armor           = { 91004, 320331, 2 }, -- Immolation Aura increases your armor by 20% and causes melee attackers to suffer 478 Chaos damage.
    internal_struggle        = { 90934, 393822, 1 }, -- Increases your mastery by 3.6%.
    live_by_the_glaive       = { 95151, 428607, 1 }, -- When you parry an attack or have one of your attacks parried, restore 2% of max health and 10 Fury. This effect may only occur once every 5 sec.
    long_night               = { 91001, 389781, 1 }, -- Increases the duration of Darkness by 3 sec.
    lost_in_darkness         = { 90947, 389849, 1 }, -- Spectral Sight lasts an additional 6 sec if disrupted by attacking or taking damage.
    master_of_the_glaive     = { 90994, 389763, 1 }, -- Throw Glaive has 2 charges and snares all enemies hit by 50% for 6 sec.
    pitch_black              = { 91001, 389783, 1 }, -- Reduces the cooldown of Darkness by 120 sec.
    precise_sigils           = { 95155, 389799, 1 }, -- All Sigils are now placed at your target's location.
    pursuit                  = { 90940, 320654, 1 }, -- Mastery increases your movement speed.
    quickened_sigils         = { 95149, 209281, 1 }, -- All Sigils activate 1 second faster.
    rush_of_chaos            = { 95148, 320421, 2 }, -- Reduces the cooldown of Metamorphosis by 30 sec.
    shattered_restoration    = { 90950, 389824, 1 }, -- The healing of Shattered Souls is increased by 10%.
    sigil_of_misery          = { 90946, 207684, 1 }, -- Place a Sigil of Misery at the target location that activates after 2 sec. Causes all enemies affected by the sigil to cower in fear, disorienting them for 15 sec.
    sigil_of_spite           = { 90997, 390163, 1 }, -- Place a demonic sigil at the target location that activates after 2 sec. Detonates to deal 44,825 Chaos damage and shatter up to 3 Lesser Soul Fragments from enemies affected by the sigil. Deals reduced damage beyond 5 targets.
    soul_rending             = { 90936, 204909, 2 }, -- Leech increased by 6%. Gain an additional 6% leech while Metamorphosis is active.
    soul_sigils              = { 90929, 395446, 1 }, -- Afflicting an enemy with a Sigil generates 1 Lesser Soul Fragment.
    swallowed_anger          = { 91005, 320313, 1 }, -- Consume Magic generates 20 Fury when a beneficial Magic effect is successfully removed from the target.
    the_hunt                 = { 90927, 370965, 1 }, -- Charge to your target, striking them for 51,808 Chaos damage, rooting them in place for 1.5 sec and inflicting 45,412 Chaos damage over 6 sec to up to 5 enemies in your path. The pursuit invigorates your soul, healing you for 10% of the damage you deal to your Hunt target for 20 sec.
    unrestrained_fury        = { 90941, 320770, 1 }, -- Increases maximum Fury by 20.
    vengeful_bonds           = { 90930, 320635, 1 }, -- Vengeful Retreat reduces the movement speed of all nearby enemies by 70% for 3 sec.
    vengeful_retreat         = { 90942, 198793, 1 }, -- Remove all snares and vault away. Nearby enemies take 1,229 Physical damage.
    will_of_the_illidari     = { 91000, 389695, 1 }, -- Increases maximum health by 5%.

    -- Havoc
    a_fire_inside            = { 95143, 427775, 1 }, -- Immolation Aura has 1 additional charge and 25% chance to refund a charge when used. You can have multiple Immolation Auras active at a time.
    accelerated_blade        = { 91011, 391275, 1 }, -- Throw Glaive deals 60% increased damage, reduced by 30% for each previous enemy hit.
    any_means_necessary      = { 90919, 388114, 1 }, -- Mastery: Demonic Presence now also causes your Arcane, Fire, Frost, Nature, and Shadow damage to be dealt as Chaos instead, and increases that damage by 28.9%.
    blind_fury               = { 91026, 203550, 2 }, -- Eye Beam generates 40 Fury every second, and its damage and duration are increased by 10%.
    burning_hatred           = { 90923, 320374, 1 }, -- Immolation Aura generates an additional 40 Fury over 10 sec.
    burning_wound            = { 90917, 391189, 1 }, -- Demon Blades and Throw Glaive leave open wounds on your enemies, dealing 8,140 Chaos damage over 15 sec and increasing damage taken from your Immolation Aura by 40%. May be applied to up to 3 targets.
    chaos_theory             = { 91035, 389687, 1 }, -- Blade Dance causes your next Chaos Strike within 8 sec to have a 14-30% increased critical strike chance and will always refund Fury.
    chaotic_disposition      = { 95147, 428492, 2 }, -- Your Chaos damage has a 7.77% chance to be increased by 17%, occurring up to 3 total times.
    chaotic_transformation   = { 90922, 388112, 1 }, -- When you activate Metamorphosis, the cooldowns of Blade Dance and Eye Beam are immediately reset.
    critical_chaos           = { 91028, 320413, 1 }, -- The chance that Chaos Strike will refund 20 Fury is increased by 30% of your critical strike chance.
    cycle_of_hatred          = { 91032, 258887, 2 }, -- Blade Dance, Chaos Strike, and Glaive Tempest reduce the cooldown of Eye Beam by 0.5 sec.
    dancing_with_fate        = { 91015, 389978, 2 }, -- The final slash of Blade Dance deals an additional 25% damage.
    dash_of_chaos            = { 93014, 427794, 1 }, -- For 2 sec after using Fel Rush, activating it again will dash back towards your initial location.
    deflecting_dance         = { 93015, 427776, 1 }, -- You deflect incoming attacks while Blade Dancing, absorbing damage up to 15% of your maximum health.
    demon_blades             = { 91019, 203555, 1 }, -- Your auto attacks deal an additional 1,719 Chaos damage and generate 7-12 Fury.
    demon_hide               = { 91017, 428241, 1 }, -- Magical damage increased by 3%, and Physical damage taken reduced by 5%.
    desperate_instincts      = { 93016, 205411, 1 }, -- Blur now reduces damage taken by an additional 10%. Additionally, you automatically trigger Blur with 50% reduced cooldown and duration when you fall below 35% health. This effect can only occur when Blur is not on cooldown.
    essence_break            = { 91033, 258860, 1 }, -- Slash all enemies in front of you for 30,395 Chaos damage, and increase the damage your Chaos Strike and Blade Dance deal to them by 80% for 4 sec. Deals reduced damage beyond 8 targets.
    eye_beam                 = { 91018, 198013, 1 }, -- Blasts all enemies in front of you, dealing guaranteed critical strikes for up to 70,852 Chaos damage over 1.9 sec. Deals reduced damage beyond 5 targets. When Eye Beam finishes fully channeling, your Haste is increased by an additional 10% for 10 sec.
    fel_barrage              = { 95144, 258925, 1 }, -- Unleash a torrent of Fel energy, rapidly consuming Fury to inflict 3,755 Chaos damage to all enemies within 12 yds, lasting 8 sec or until Fury is depleted. Deals reduced damage beyond 5 targets.
    first_blood              = { 90925, 206416, 1 }, -- Blade Dance deals 24,200 Chaos damage to the first target struck.
    furious_gaze             = { 91025, 343311, 1 }, -- When Eye Beam finishes fully channeling, your Haste is increased by an additional 10% for 10 sec.
    furious_throws           = { 93013, 393029, 1 }, -- Throw Glaive now costs 25 Fury and throws a second glaive at the target.
    glaive_tempest           = { 91035, 342817, 1 }, -- Launch two demonic glaives in a whirlwind of energy, causing 32,341 Chaos damage over 3 sec to all nearby enemies. Deals reduced damage beyond 8 targets.
    growing_inferno          = { 90916, 390158, 1 }, -- Immolation Aura's damage increases by 10% each time it deals damage.
    improved_chaos_strike    = { 91030, 343206, 1 }, -- Chaos Strike damage increased by 10%.
    improved_fel_rush        = { 93014, 343017, 1 }, -- Fel Rush damage increased by 20%.
    inertia                  = { 91021, 427640, 1 }, -- When empowered by Unbound Chaos, Fel Rush increases your damage done by 18% for 5 sec.
    initiative               = { 91027, 388108, 1 }, -- Damaging an enemy before they damage you increases your critical strike chance by 10% for 5 sec. Vengeful Retreat refreshes your potential to trigger this effect on any enemies you are in combat with.
    inner_demon              = { 91024, 389693, 1 }, -- Entering demon form causes your next Chaos Strike to unleash your inner demon, causing it to crash into your target and deal 22,918 Chaos damage to all nearby enemies. Deals reduced damage beyond 5 targets.
    insatiable_hunger        = { 91019, 258876, 1 }, -- Demon's Bite deals 50% more damage and generates 5 to 10 additional Fury.
    isolated_prey            = { 91036, 388113, 1 }, -- Chaos Nova, Eye Beam, and Immolation Aura gain bonuses when striking 1 target.  Chaos Nova: Stun duration increased by 2 sec.  Eye Beam: Deals 30% increased damage.  Immolation Aura: Always critically strikes.
    know_your_enemy          = { 91034, 388118, 2 }, -- Gain critical strike damage equal to 40% of your critical strike chance.
    looks_can_kill           = { 90921, 320415, 1 }, -- Eye Beam deals guaranteed critical strikes.
    momentum                 = { 91021, 206476, 1 }, -- Fel Rush, The Hunt, and Vengeful Retreat increase your damage done by 6% for 6 sec, up to a maximum of 30 sec.
    mortal_dance             = { 93015, 328725, 1 }, -- Blade Dance now reduces targets' healing received by 50% for 6 sec.
    netherwalk               = { 93016, 196555, 1 }, -- Slip into the nether, increasing movement speed by 100% and becoming immune to damage, but unable to attack. Lasts 6 sec.
    ragefire                 = { 90918, 388107, 1 }, -- Each time Immolation Aura deals damage, 30% of the damage dealt by up to 3 critical strikes is gathered as Ragefire. When Immolation Aura expires you explode, dealing all stored Ragefire damage to nearby enemies.
    relentless_onslaught     = { 91012, 389977, 1 }, -- Chaos Strike has a 10% chance to trigger a second Chaos Strike.
    restless_hunter          = { 91024, 390142, 1 }, -- Leaving demon form grants a charge of Fel Rush and increases the damage of your next Blade Dance by 50%.
    scars_of_suffering       = { 90914, 428232, 1 }, -- Increases Versatility by 4% and reduces threat generated by 8%.
    serrated_glaive          = { 91013, 390154, 1 }, -- Enemies hit by Chaos Strike or Throw Glaive take 15% increased damage from Chaos Strike and Throw Glaive for 15 sec.
    shattered_destiny        = { 91031, 388116, 1 }, -- The duration of your active demon form is extended by 0.1 sec per 12 Fury spent.
    soulscar                 = { 91012, 388106, 1 }, -- Throw Glaive causes targets to take an additional 100% of damage dealt as Chaos over 6 sec.
    tactical_retreat         = { 91022, 389688, 1 }, -- Vengeful Retreat has a 5 sec reduced cooldown and generates 80 Fury over 10 sec.
    trail_of_ruin            = { 90915, 258881, 1 }, -- The final slash of Blade Dance inflicts an additional 7,742 Chaos damage over 4 sec.
    unbound_chaos            = { 91020, 347461, 1 }, -- Activating Immolation Aura increases the damage of your next Fel Rush by 250%. Lasts 12 sec.

    -- Aldrachi Reaver
    aldrachi_tactics         = { 94914, 442683, 1 }, -- The second enhanced ability in a pattern shatters an additional Soul Fragment.
    army_unto_oneself        = { 94896, 442714, 1 }, -- Felblade surrounds you with a Blade Ward, reducing damage taken by 10% for 5 sec.
    art_of_the_glaive        = { 94915, 442290, 1, "aldrachi_reaver" }, -- Consuming 6 Soul Fragments or casting The Hunt converts your next Throw Glaive into Reaver's Glaive.  Reaver's Glaive:
    evasive_action           = { 94911, 444926, 1 }, -- Vengeful Retreat can be cast a second time within 3 sec.
    fury_of_the_aldrachi     = { 94898, 442718, 1 }, -- When enhanced by Reaver's Glaive, Blade Dance casts 3 additional glaive slashes to nearby targets. If cast after Chaos Strike, cast 6 slashes instead.
    incisive_blade           = { 94895, 442492, 1 }, -- Chaos Strike deals 15% increased damage.
    incorruptible_spirit     = { 94896, 442736, 1 }, -- Consuming a Soul Fragment also heals you for an additional 15% over time.
    keen_engagement          = { 94910, 442497, 1 }, -- Reaver's Glaive generates 20 Fury.
    preemptive_strike        = { 94910, 444997, 1 }, -- Throw Glaive deals 3,124 damage to enemies near its initial target.
    reavers_mark             = { 94903, 442679, 1 }, -- When enhanced by Reaver's Glaive, Chaos Strike applies Reaver's Mark, which causes the target to take 12% increased damage for 20 sec. If cast after Blade Dance, Reaver's Mark is increased to 24%.
    thrill_of_the_fight      = { 94919, 442686, 1 }, -- After consuming both enhancements, gain Thrill of the Fight, increasing your attack speed by 15% for 20 sec and your damage and healing by 20% for 10 sec.
    unhindered_assault       = { 94911, 444931, 1 }, -- Vengeful Retreat resets the cooldown of Felblade.
    warblades_hunger         = { 94906, 442502, 1 }, -- Consuming a Soul Fragment causes your next Chaos Strike to deal 1,734 additional damage. Felblade consumes up to 5 nearby Soul Fragments.
    wounded_quarry           = { 94897, 442806, 1 }, -- While Reaver's Mark is on your target, melee attacks strike with an additional glaive slash for 867 Physical damage and have a chance to shatter a soul.

    -- Fel-Scarred
    burning_blades           = { 94905, 452408, 1 }, -- Your blades burn with Fel energy, causing your Chaos Strike, Throw Glaive, and auto-attacks to deal an additional 10% damage as Fire over 6 sec.
    demonic_intensity        = { 94901, 452415, 1 }, -- Activating Metamorphosis greatly empowers Eye Beam, Immolation Aura, and Sigil of Flame. Demonsurge damage is increased by 10% for each time it previously triggered while your demon form is active.
    demonsurge               = { 94917, 452402, 1, "felscarred" }, -- Metamorphosis now also causes Demon Blades to generate 5 additional Fury. While demon form is active, the first cast of each empowered ability induces a Demonsurge, causing you to explode with Fel energy, dealing 12,158 Fire damage to nearby enemies.
    enduring_torment         = { 94916, 452410, 1 }, -- The effects of your demon form persist outside of it in a weakened state, increasing Chaos Strike and Blade Dance damage by 5%, and Haste by 3%.
    flamebound               = { 94902, 452413, 1 }, -- Immolation Aura has 2 yd increased radius and 30% increased critical strike damage bonus.
    focused_hatred           = { 94918, 452405, 1 }, -- Demonsurge deals 35% increased damage when it strikes a single target.
    improved_soul_rending    = { 94899, 452407, 1 }, -- Leech granted by Soul Rending increased by 2% and an additional 2% while Metamorphosis is active.
    monster_rising           = { 94909, 452414, 1 }, -- Agility increased by 5% while not in demon form.
    pursuit_of_angriness     = { 94913, 452404, 1 }, -- Movement speed increased by 1% per 10 Fury.
    set_fire_to_the_pain     = { 94899, 452406, 1 }, -- 5% of all non-Fire damage taken is instead taken as Fire damage over 6 sec. Fire damage taken reduced by 10%.
    student_of_suffering     = { 94902, 452412, 1 }, -- Sigil of Flame applies Student of Suffering to you, increasing Mastery by 14.4% and granting 5 Fury every 2 sec, for 8 sec.
    untethered_fury          = { 94904, 452411, 1 }, -- Maximum Fury increased by 50.
    violent_transformation   = { 94912, 452409, 1 }, -- When you activate Metamorphosis, the cooldowns of your Sigil of Flame and Immolation Aura are immediately reset.
    wave_of_debilitation     = { 94913, 452403, 1 }, -- Chaos Nova slows enemies by 60% and reduces attack and cast speed 15% for 5 sec after its stun fades.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    blood_moon        = 5433, -- (355995)
    chaotic_imprint   = 809 , -- (356510)
    cleansed_by_flame = 805 , -- (205625)
    cover_of_darkness = 1206, -- (357419)
    detainment        = 812 , -- (205596)
    glimpse           = 813 , -- (354489)
    rain_from_above   = 811 , -- (206803) You fly into the air out of harm's way. While floating, you gain access to Fel Lance allowing you to deal damage to enemies below.
    reverse_magic     = 806 , -- (205604) Removes all harmful magical effects from yourself and all nearby allies within 10 yards, and sends them back to their original caster if possible.
    sigil_mastery     = 5523, -- (211489)
    unending_hatred   = 1218, -- (213480)
} )


-- Auras
spec:RegisterAuras( {
    -- $w1 Soul Fragments consumed. At $?a212612[$442290s1~][$442290s2~], Reaver's Glaive is available to cast.
    art_of_the_glaive = {
        id = 444661,
        duration = 30.0,
        max_stack = 6,
    },
    -- Dodge chance increased by $s2%.
    -- https://wowhead.com/beta/spell=188499
    blade_dance = {
        id = 188499,
        duration = 1,
        max_stack = 1
    },
    -- Damage taken reduced by $s1%.
    blade_ward = {
        id = 442715,
        duration = 5.0,
        max_stack = 1,
    },
    blazing_slaughter = {
        id = 355892,
        duration = 12,
        max_stack = 20,
    },
    -- Versatility increased by $w1%.
    -- https://wowhead.com/beta/spell=355894
    blind_faith = {
        id = 355894,
        duration = 20,
        max_stack = 1
    },
    -- Dodge increased by $s2%. Damage taken reduced by $s3%.
    -- https://wowhead.com/beta/spell=212800
    blur = {
        id = 212800,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Taking $w1 Chaos damage every $t1 seconds.  Damage taken from $@auracaster's Immolation Aura increased by $s2%.
    -- https://wowhead.com/beta/spell=391191
    burning_wound_391191 = {
        id = 391191,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
    },
    burning_wound_346278 = {
        id = 346278,
        duration = 15,
        tick_time = 3,
        max_stack = 1,
    },
    burning_wound = {
        alias = { "burning_wound_391191", "burning_wound_346278" },
        aliasMode = "first",
        aliasType = "buff",
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=179057
    chaos_nova = {
        id = 179057,
        duration = function () return talent.isolated_prey.enabled and active_enemies == 1 and 4 or 2 end,
        type = "Magic",
        max_stack = 1
    },
    chaos_theory = {
        id = 390195,
        duration = 8,
        max_stack = 1,
    },
    chaotic_blades = {
        id = 337567,
        duration = 8,
        max_stack = 1
    },
    darkness = {
        id = 196718,
        duration = function () return pvptalent.cover_of_darkness.enabled and 10 or 8 end,
        max_stack = 1,
    },
    death_sweep = {
        id = 210152,
        duration = 1,
        max_stack = 1,
    },
    demon_soul = {
        id = 347765,
        duration = 15,
        max_stack = 1,
    },
    demonsurge = {
        id = 452416,
        duration = 12,
        max_stack = 10
    },
    demonsurge_demonic = {
        id = 452435,
        duration = 3600,
        max_stack = 1
    },
    demonsurge_hardcast = {
        id = 452489,
        duration = 3600,
        max_stack = 1
    },
    demonsurge_soul_sunder = {

    },
    demonsurge_spirit_burst = {

    },
    demonsurge_sigil_of_doom = {

    },
    demonsurge_consuming_fire = {

    },
    demonsurge_fel_desolation = {

    },
    demonsurge_abyssal_gaze = {

    },
    demonsurge_annihilation = {

    },
    demonsurge_death_sweep = {

    },
    elysian_decree = { -- TODO: This aura determines sigil pop time.
        id = 390163,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    essence_break = {
        id = 320338,
        duration = 4,
        max_stack = 1,
        copy = "dark_slash" -- Just in case.
    },
    -- Vengeful Retreat may be cast again.
    evasive_action = {
        id = 444929,
        duration = 3.0,
        max_stack = 1,
    },
    -- https://wowhead.com/beta/spell=198013
    eye_beam = {
        id = 198013,
        duration = function () return 2 * ( 1 + 0.1 * talent.blind_fury.rank ) * haste end,
        generate = function( t )
            if buff.casting.up and buff.casting.v1 == 198013 then
                t.applied  = buff.casting.applied
                t.duration = buff.casting.duration
                t.expires  = buff.casting.expires
                t.stack    = 1
                t.caster   = "player"
                forecastResources( "fury" )
                return
            end

            t.applied  = 0
            t.duration = class.auras.eye_beam.duration
            t.expires  = 0
            t.stack    = 0
            t.caster   = "nobody"
        end,
        tick_time = 0.2,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Unleashing Fel.
    -- https://wowhead.com/beta/spell=258925
    fel_barrage = {
        id = 258925,
        duration = 8,
        tick_time = 0.25,
        max_stack = 1
    },
    -- Legendary.
    fel_bombardment = {
        id = 337849,
        duration = 40,
        max_stack = 5,
    },
    -- Legendary
    fel_devastation = {
        id = 333105,
        duration = 2,
        max_stack = 1,
    },
    furious_gaze = {
        id = 343312,
        duration = 12,
        max_stack = 1,
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=211881
    fel_eruption = {
        id = 211881,
        duration = 4,
        max_stack = 1
    },
    -- Talent: Movement speed increased by $w1%.
    -- https://wowhead.com/beta/spell=389847
    felfire_haste = {
        id = 389847,
        duration = 8,
        max_stack = 1,
        copy = 338804
    },
    -- Branded, dealing $204021s1% less damage to $@auracaster$?s389220[ and taking $w2% more Fire damage from them][].
    -- https://wowhead.com/beta/spell=207744
    fiery_brand = {
        id = 207744,
        duration = 10,
        max_stack = 1
    },
    -- Talent: Battling a demon from the Theater of Pain...
    -- https://wowhead.com/beta/spell=391430
    fodder_to_the_flame = {
        id = 391430,
        duration = 25,
        max_stack = 1,
        copy = { 329554, 330910 }
    },
    -- The demon is linked to you.
    fodder_to_the_flame_chase = {
        id = 328605,
        duration = 3600,
        max_stack = 1,
    },
    -- This is essentially the countdown before the demon despawns (you can Imprison it for a long time).
    fodder_to_the_flame_cooldown = {
        id = 342357,
        duration = 120,
        max_stack = 1,
    },
    -- Falling speed reduced.
    -- https://wowhead.com/beta/spell=131347
    glide = {
        id = 131347,
        duration = 3600,
        max_stack = 1
    },
    -- Burning nearby enemies for $258922s1 $@spelldesc395020 damage every $t1 sec.$?a207548[    Movement speed increased by $w4%.][]$?a320331[    Armor increased by $w5%. Attackers suffer $@spelldesc395020 damage.][]
    -- https://wowhead.com/beta/spell=258920
    immolation_aura_1 = {
        id = 258920,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_2 = {
        id = 427912,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_3 = {
        id = 427913,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_4 = {
        id = 427914,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura_5 = {
        id = 427915,
        duration = function() return talent.felfire_heart.enabled and 8 or 6 end,
        tick_time = 1,
        max_stack = 1
    },
    immolation_aura = {
        alias = { "immolation_aura_1", "immolation_aura_2", "immolation_aura_3", "immolation_aura_4", "immolation_aura_5" },
        aliasMode = "longest",
        aliasType = "buff",
        max_stack = 5,
    },
    -- Talent: Incapacitated.
    -- https://wowhead.com/beta/spell=217832
    imprison = {
        id = 217832,
        duration = 60,
        mechanic = "sap",
        type = "Magic",
        max_stack = 1
    },
    -- Damage done increased by $w1%.
    inertia = {
        id = 427641,
        duration = 5,
        max_stack = 1,
    },
    initiative = {
        id = 391215,
        duration = 5,
        max_stack = 1,
    },
    initiative_tracker = {
        duration = 3600,
        max_stack = 1
    },
    inner_demon = {
        id = 337313,
        duration = 10,
        max_stack = 1,
        copy = 390145
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=213405
    master_of_the_glaive = {
        id = 213405,
        duration = 6,
        mechanic = "snare",
        max_stack = 1
    },
    -- Chaos Strike and Blade Dance upgraded to $@spellname201427 and $@spellname210152.  Haste increased by $w4%.$?s235893[  Versatility increased by $w5%.][]$?s204909[  Leech increased by $w3%.][]
    -- https://wowhead.com/beta/spell=162264
    metamorphosis = {
        id = 162264,
        duration = function () return 24 + ( pvptalent.demonic_origins.enabled and -15 or 0 ) end,
        max_stack = 1,
        meta = {
            extended_by_demonic = function ()
                return false -- disabled in 8.0:  talent.demonic.enabled and ( buff.metamorphosis.up and buff.metamorphosis.duration % 15 > 0 and buff.metamorphosis.duration > ( action.eye_beam.cast + 8 ) )
            end,
        },
    },
    momentum = {
        id = 208628,
        duration = 6,
        max_stack = 1,
    },
    -- Agility increased by $w1%.
    monster_rising = {
        id = 452550,
        duration = 3600,
        max_stack = 1,
    },
    -- Stunned.
    -- https://wowhead.com/beta/spell=200166
    metamorphosis_stun = {
        id = 200166,
        duration = 3,
        type = "Magic",
        max_stack = 1
    },
    -- Dazed.
    -- https://wowhead.com/beta/spell=247121
    metamorphosis_daze = {
        id = 247121,
        duration = 3,
        type = "Magic",
        max_stack = 1
    },
    misery_in_defeat = {
        id = 391369,
        duration = 5,
        max_stack = 1,
    },
    -- Talent: Healing effects received reduced by $w1%.
    -- https://wowhead.com/beta/spell=356608
    mortal_dance = {
        id = 356608,
        duration = 6,
        max_stack = 1
    },
    -- Talent: Immune to damage and unable to attack.  Movement speed increased by $s3%.
    -- https://wowhead.com/beta/spell=196555
    netherwalk = {
        id = 196555,
        duration = 6,
        max_stack = 1
    },
    -- $w3
    pursuit_of_angriness = {
        id = 452404,
        duration = 0.0,
        tick_time = 1.0,
        max_stack = 1,
    },
    ragefire = {
        id = 390192,
        duration = 30,
        max_stack = 1,
    },
    rain_from_above_immune = {
        id = 206803,
        duration = 1,
        tick_time = 1,
        max_stack = 1,
        copy = "rain_from_above_launch"
    },
    rain_from_above = { -- Gliding/floating.
        id = 206804,
        duration = 10,
        max_stack = 1
    },
    reavers_glaive = {
        id = 444686,
        duration = 15,
        max_stack = 2
    },
    restless_hunter = {
        id = 390212,
        duration = 12,
        max_stack = 1
    },
    -- Damage taken from Chaos Strike and Throw Glaive increased by $w1%.
    serrated_glaive = {
        id = 390155,
        duration = 15,
        max_stack = 1,
    },
    -- Taking $w1 Fire damage every $t1 sec.
    set_fire_to_the_pain = {
        id = 453286,
        duration = 6.0,
        tick_time = 1.0,
    },
    -- Movement slowed by $s1%.
    -- https://wowhead.com/beta/spell=204843
    sigil_of_chains = {
        id = 204843,
        duration = function() return 6 + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Suffering $w2 $@spelldesc395020 damage every $t2 sec.
    -- https://wowhead.com/beta/spell=204598
    sigil_of_flame_dot = {
        id = 204598,
        duration = function() return ( talent.felfire_heart.enabled and 8 or 6 ) + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Sigil of Flame is active.
    -- https://wowhead.com/beta/spell=389810
    sigil_of_flame = {
        id = 389810,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1,
        copy = 204596
    },
    -- Talent: Disoriented.
    -- https://wowhead.com/beta/spell=207685
    sigil_of_misery_debuff = {
        id = 207685,
        duration = function() return 15 + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        mechanic = "flee",
        type = "Magic",
        max_stack = 1
    },
    sigil_of_misery = { -- TODO: Model placement pop.
        id = 207684,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    -- Silenced.
    -- https://wowhead.com/beta/spell=204490
    sigil_of_silence_debuff = {
        id = 204490,
        duration = function() return 6 + talent.extended_sigils.rank + ( talent.precise_sigils.enabled and 2 or 0 ) end,
        type = "Magic",
        max_stack = 1
    },
    sigil_of_silence = { -- TODO: Model placement pop.
        id = 202137,
        duration = function () return talent.quickened_sigils.enabled and 1 or 2 end,
        max_stack = 1
    },
    -- Consume to heal for $210042s1% of your maximum health.
    -- https://wowhead.com/beta/spell=203795
    soul_fragment = {
        id = 203795,
        duration = 20,
        max_stack = 1
    },
    -- Talent: Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=390181
    soulscar = {
        id = 390181,
        duration = 6,
        tick_time = 2,
        max_stack = 1
    },
    -- Can see invisible and stealthed enemies.  Can see enemies and treasures through physical barriers.
    -- https://wowhead.com/beta/spell=188501
    spectral_sight = {
        id = 188501,
        duration = 10,
        max_stack = 1
    },
    -- Mastery increased by ${$w1*$mas}.1%. ; Generating $453236s1 Fury every $t2 sec.
    student_of_suffering = {
        id = 453239,
        duration = 8.0,
        max_stack = 1,
    },
    tactical_retreat = {
        id = 389890,
        duration = 8,
        tick_time = 1,
        max_stack = 1
    },
    -- Talent: Suffering $w1 $@spelldesc395042 damage every $t1 sec.
    -- https://wowhead.com/beta/spell=345335
    the_hunt_dot = {
        id = 370969,
        duration = function() return set_bonus.tier31_4pc > 0 and 12 or 6 end,
        tick_time = 2,
        type = "Magic",
        max_stack = 1,
        copy = 345335
    },
    -- Talent: Marked by the Demon Hunter, converting $?c1[$345422s1%][$345422s2%] of the damage done to healing.
    -- https://wowhead.com/beta/spell=370966
    the_hunt = {
        id = 370966,
        duration = 30,
        max_stack = 1,
        copy = 323802
    },
    the_hunt_root = {
        id = 370970,
        duration = 1.5,
        max_stack = 1,
        copy = 323996
    },
    -- Attack Speed increased by $w1%
    thrill_of_the_fight = {
        id = 442695,
        duration = 20.0,
        max_stack = 1,
    },
    -- Taunted.
    -- https://wowhead.com/beta/spell=185245
    torment = {
        id = 185245,
        duration = 3,
        max_stack = 1
    },
    -- Talent: Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=258883
    trail_of_ruin = {
        id = 258883,
        duration = 4,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    unbound_chaos = {
        id = 347462,
        duration = 20,
        max_stack = 1
    },
    vengeful_retreat_movement = {
        duration = 1,
        max_stack = 1,
        generate = function( t )
            if action.vengeful_retreat.lastCast > query_time - 1 then
                t.applied  = action.vengeful_retreat.lastCast
                t.duration = 1
                t.expires  = action.vengeful_retreat.lastCast + 1
                t.stack    = 1
                t.caster   = "player"
                return
            end

            t.applied  = 0
            t.duration = 1
            t.expires  = 0
            t.stack    = 0
            t.caster   = "nobody"
        end,
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=198813
    vengeful_retreat = {
        id = 198813,
        duration = 3,
        max_stack = 1,
        copy = "vengeful_retreat_snare"
    },
    -- Your next $?a212612[Chaos Strike]?s263642[Fracture][Shear] will deal $442507s1 additional Physical damage.
    warblades_hunger = {
        id = 442503,
        duration = 30.0,
        max_stack = 1,
    },

    -- Conduit
    exposed_wound = {
        id = 339229,
        duration = 10,
        max_stack = 1,
    },

    -- PvP Talents
    chaotic_imprint_shadow = {
        id = 356656,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_nature = {
        id = 356660,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_arcane = {
        id = 356658,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_fire = {
        id = 356661,
        duration = 20,
        max_stack = 1,
    },
    chaotic_imprint_frost = {
        id = 356659,
        duration = 20,
        max_stack = 1,
    },
    -- Conduit
    demonic_parole = {
        id = 339051,
        duration = 12,
        max_stack = 1
    },
    glimpse = {
        id = 354610,
        duration = 8,
        max_stack = 1,
    },
} )


local sigils = setmetatable( {}, {
    __index = function( t, k )
        t[ k ] = 0
        return t[ k ]
    end
} )

spec:RegisterStateFunction( "create_sigil", function( sigil )
    sigils[ sigil ] = query_time + activation_time

    local effect = sigil == "elysian_dcreee" and "elysian_decree" or ( "sigil_of_" .. sigil )
    applyDebuff( "target", effect )
    debuff[ effect ].applied = debuff[ effect ].applied + 1
    debuff[ effect ].expires = debuff[ effect ].expires + 1
end )

spec:RegisterStateExpr( "soul_fragments", function ()
    return buff.soul_fragments.stack
end )

spec:RegisterStateTable( "fragments", {
    real = 0,
    realTime = 0,
} )

spec:RegisterStateFunction( "queue_fragments", function( num, extraTime )
    fragments.real = fragments.real + num
    fragments.realTime = GetTime() + 1.25 + ( extraTime or 0 )
end )

spec:RegisterStateFunction( "purge_fragments", function()
    fragments.real = 0
    fragments.realTime = 0
end )

local last_darkness = 0
local last_metamorphosis = 0
local last_eye_beam = 0

spec:RegisterStateExpr( "darkness_applied", function ()
    return max( class.abilities.darkness.lastCast, last_darkness )
end )

spec:RegisterStateExpr( "metamorphosis_applied", function ()
    return max( class.abilities.darkness.lastCast, last_metamorphosis )
end )

spec:RegisterStateExpr( "eye_beam_applied", function ()
    return max( class.abilities.eye_beam.lastCast, last_eye_beam )
end )

spec:RegisterStateExpr( "extended_by_demonic", function ()
    return buff.metamorphosis.up and buff.metamorphosis.extended_by_demonic
end )

local activation_time = function ()
    return talent.quickened_sigils.enabled and 1 or 2
end

spec:RegisterStateExpr( "activation_time", activation_time )

local sigil_placed = function ()
    return sigils.flame > query_time
end

spec:RegisterStateExpr( "sigil_placed", sigil_placed )

spec:RegisterStateExpr( "meta_cd_multiplier", function ()
    return 1
end )


local furySpent = 0

local FURY = Enum.PowerType.Fury
local lastFury = -1

spec:RegisterUnitEvent( "UNIT_POWER_FREQUENT", "player", nil, function( event, unit, powerType )
    if powerType == "FURY" and state.set_bonus.tier30_2pc > 0 then
        local current = UnitPower( "player", FURY )

        if current < lastFury - 3 then
            furySpent = ( furySpent + lastFury - current )
        end

        lastFury = current
    end
end )

spec:RegisterStateExpr( "fury_spent", function ()
    if set_bonus.tier30_2pc == 0 then return 0 end
    return furySpent
end )

local queued_frag_modifier = 0
local initiative_actual, initiative_virtual = {}, {}

local death_events = {
    UNIT_DIED               = true,
    UNIT_DESTROYED          = true,
    UNIT_DISSIPATES         = true,
    PARTY_KILL              = true,
    SPELL_INSTAKILL         = true,
}

spec:RegisterHook( "COMBAT_LOG_EVENT_UNFILTERED", function( _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
    if sourceGUID == GUID then
        if subtype == "SPELL_CAST_SUCCESS" then
            -- Fracture:  Generate 2 frags.
            if spellID == 263642 then
                queue_fragments( 2 )
            end

            -- Shear:  Generate 1 frag.
            if spellID == 203782 then
                queue_fragments( 1 )
            end

            if spellID == 198793 and talent.initiative.enabled then
                wipe( initiative_actual )
            end

        elseif spellID == 203981 and fragments.real > 0 and ( subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_APPLIED_DOSE" ) then
            fragments.real = fragments.real - 1

        elseif state.set_bonus.tier30_2pc > 0 and subtype == "SPELL_AURA_APPLIED" and spellID == 408737 then
            furySpent = max( 0, furySpent - 175 )

        elseif state.talent.initiative.enabled and subtype == "SPELL_DAMAGE" then
            initiative_actual[ destGUID ] = true
        end
    elseif destGUID == GUID and ( subtype == "SPELL_DAMAGE" or subtype == "SPELL_PERIODIC_DAMAGE" ) then
        initiative_actual[ sourceGUID ] = true

    elseif death_events[ subtype ] then
        initiative_actual[ destGUID ] = nil
    end
end, false )

spec:RegisterEvent( "PLAYER_REGEN_ENABLED", function()
    wipe( initiative_actual )
end )

spec:RegisterHook( "UNIT_ELIMINATED", function( id )
    initiative_actual[ id ] = nil
end )

-- Gear Sets
spec:RegisterGear( "tier29", 200345, 200347, 200342, 200344, 200346 )
spec:RegisterAura( "seething_chaos", {
    id = 394934,
    duration = 6,
    max_stack = 1
} )

-- Tier 30
spec:RegisterGear( "tier30", 202527, 202525, 202524, 202523, 202522 )
-- 2 pieces (Havoc) : Every 175 Fury you spend, gain Seething Fury, increasing your Agility by 8% for 6 sec.
-- TODO: Track Fury spent toward Seething Fury.  New expressions: seething_fury_threshold, seething_fury_spent, seething_fury_deficit.
spec:RegisterAura( "seething_fury", {
    id = 408737,
    duration = 6,
    max_stack = 1
} )
-- 4 pieces (Havoc) : Each time you gain Seething Fury, gain 15 Fury and the damage of your next Eye Beam is increased by 15%, stacking 5 times.
spec:RegisterAura( "seething_potential", {
    id = 408754,
    duration = 60,
    max_stack = 5
} )

spec:RegisterGear( "tier31", 207261, 207262, 207263, 207264, 207266, 217228, 217230, 217226, 217227, 217229 )
-- (2) Blade Dance automatically triggers Throw Glaive on your primary target for $s3% damage and each slash has a $s2% chance to Throw Glaive an enemy for $s1% damage.
-- (4) Throw Glaive reduces the remaining cooldown of The Hunt by ${$s1/1000}.1 sec, and The Hunt's damage over time effect lasts ${$s2/1000} sec longer.


local sigil_types = {
    chains         = "sigil_of_chains" ,
    flame          = "sigil_of_flame"  ,
    misery         = "sigil_of_misery" ,
    silence        = "sigil_of_silence",
    spite          = "sigil_of_spite",
    elysian_decree = "elysian_decree"
}

spec:RegisterHook( "reset_precast", function ()
    last_metamorphosis = nil
    last_infernal_strike = nil

    wipe( initiative_virtual )
    active_dot.initiative_tracker = 0

    for k, v in pairs( initiative_actual ) do
        initiative_virtual[ k ] = v

        if k == target.unit then
            applyDebuff( "target", "initiative_tracker" )
        else
            active_dot.initiative_tracker = active_dot.initiative_tracker + 1
        end
    end

    -- Unbound Chaos effect remains even after the buff falls off, so we'll reapply the buff whenever Immo Aura has been used more recently than Fel Rush.
    if talent.unbound_chaos.enabled and buff.unbound_chaos.remains < gcd.max and action.immolation_aura.lastCast > action.fel_rush.lastCast then
        applyBuff( "unbound_chaos", nil, gcd.max )
    end

    for s, a in ipairs( sigil_types ) do
        local activation = ( action[ a ].lastCast or 0 ) + ( talent.quickened_sigils.enabled and 2 or 1 )
        if activation > now then sigils[ s ] = activation
        else sigils[ s ] = 0 end
    end

    last_darkness = 0
    last_metamorphosis = 0
    last_eye_beam = 0

    local rps = 0

    if equipped.convergence_of_fates then
        rps = rps + ( 3 / ( 60 / 4.35 ) )
    end

    if equipped.delusions_of_grandeur then
        -- From SimC model, 1/13/2018.
        local fps = 10.2 + ( talent.demonic.enabled and 1.2 or 0 )

        -- SimC uses base haste, we'll use current since we recalc each time.
        fps = fps / haste

        -- Chaos Strike accounts for most Fury expenditure.
        fps = fps + ( ( fps * 0.9 ) * 0.5 * ( 40 / 100 ) )

        rps = rps + ( fps / 30 ) * ( 1 )
    end

    meta_cd_multiplier = 1 / ( 1 + rps )

    if IsActiveSpell( 442294 ) then applyBuff( "reavers_glaive" ) end

    fury_spent = nil
end )


spec:RegisterHook( "runHandler", function( action )
    local ability = class.abilities[ action ]

    if ability.startsCombat and not debuff.initiative_tracker.up then
        applyBuff( "initiative" )
        applyDebuff( "target", "initiative_tracker" )
    end
end )


spec:RegisterHook( "advance_end", function( time )
    if query_time - time < sigils.flame and query_time >= sigils.flame then
        -- SoF should've applied.
        applyDebuff( "target", "sigil_of_flame", debuff.sigil_of_flame.duration - ( query_time - sigils.flame ) )
        active_dot.sigil_of_flame = active_enemies
        sigils.flame = 0
    end
end )


spec:RegisterHook( "spend", function( amt, resource )
    if set_bonus.tier30_2pc == 0 or amt < 0 or resource ~= "fury" then return end

    fury_spent = fury_spent + amt
    if fury_spent > 175 then
        fury_spent = fury_spent - 175
        applyBuff( "seething_fury" )
        if set_bonus.tier30_4pc > 0 then
            gain( 15, "fury" )
            applyBuff( "seething_potential" )
        end
    end
end )




spec:RegisterGear( "tier19", 138375, 138376, 138377, 138378, 138379, 138380 )
spec:RegisterGear( "tier20", 147130, 147132, 147128, 147127, 147129, 147131 )
spec:RegisterGear( "tier21", 152121, 152123, 152119, 152118, 152120, 152122 )
    spec:RegisterAura( "havoc_t21_4pc", {
        id = 252165,
        duration = 8
    } )

spec:RegisterGear( "class", 139715, 139716, 139717, 139718, 139719, 139720, 139721, 139722 )

spec:RegisterGear( "convergence_of_fates", 140806 )

spec:RegisterGear( "achor_the_eternal_hunger", 137014 )
spec:RegisterGear( "anger_of_the_halfgiants", 137038 )
spec:RegisterGear( "cinidaria_the_symbiote", 133976 )
spec:RegisterGear( "delusions_of_grandeur", 144279 )
spec:RegisterGear( "kiljaedens_burning_wish", 144259 )
spec:RegisterGear( "loramus_thalipedes_sacrifice", 137022 )
spec:RegisterGear( "moarg_bionic_stabilizers", 137090 )
spec:RegisterGear( "prydaz_xavarics_magnum_opus", 132444 )
spec:RegisterGear( "raddons_cascading_eyes", 137061 )
spec:RegisterGear( "sephuzs_secret", 132452 )
spec:RegisterGear( "the_sentinels_eternal_refuge", 146669 )

spec:RegisterGear( "soul_of_the_slayer", 151639 )
spec:RegisterGear( "chaos_theory", 151798 )
spec:RegisterGear( "oblivions_embrace", 151799 )


do
    local wasWarned = false

    spec:RegisterEvent( "PLAYER_REGEN_DISABLED", function ()
        if state.talent.demon_blades.enabled and not state.settings.demon_blades_acknowledged and not wasWarned then
            Hekili:Notify( "|cFFFF0000WARNING!|r  Demon Blades cannot be forecasted.\nSee /hekili > Havoc for more information." )
            wasWarned = true
        end
    end )
end

-- SimC documentation reflects that there are still the following expressions, which appear unused:
-- greater_soul_fragments, lesser_soul_fragments, blade_dance_worth_using, death_sweep_worth_using
-- They are not implemented becuase that documentation is from mid-2016.


-- Abilities
spec:RegisterAbilities( {
    annihilation = {
        id = 201427,
        known = 162794,
        flash = { 201427, 162794 },
        cast = 0,
        cooldown = 0,
        gcd = "spell",

        spend = function () return 40 - buff.thirsting_blades.stack end,
        spendType = "fury",

        startsCombat = true,
        texture = 1303275,

        bind = "chaos_strike",
        buff = "metamorphosis",

        handler = function ()
            removeBuff( "thirsting_blades" )
            removeBuff( "inner_demon" )
            if buff.rending_strike.up then applyDebuff( "target", "rending_strike" ) end
            if azerite.thirsting_blades.enabled then applyBuff( "thirsting_blades", nil, 0 ) end

            if buff.chaotic_blades.up then gain( 20, "fury" ) end -- legendary
        end,
    },

    -- Strike $?a206416[your primary target for $<firstbloodDmg> Chaos damage and ][]all nearby enemies for $<baseDmg> Physical damage$?s320398[, and increase your chance to dodge by $193311s1% for $193311d.][. Deals reduced damage beyond $199552s1 targets.]
    blade_dance = {
        id = 188499,
        flash = { 188499, 210152 },
        cast = 0,
        cooldown = function() return ( level > 21 and 10 or 15 ) * haste end,
        gcd = "spell",
        school = "physical",

        spend = 35,
        spendType = "fury",

        startsCombat = true,

        bind = "death_sweep",
        nobuff = "metamorphosis",

        handler = function ()
            applyBuff( "blade_dance" )
            removeBuff( "restless_hunter" )
            removeBuff( "glaive_flurry" )
            setCooldown( "death_sweep", action.blade_dance.cooldown )
            if talent.chaos_theory.enabled then applyBuff( "chaos_theory" ) end
            if talent.cycle_of_hatred.enabled and cooldown.eye_beam.remains > 0 then reduceCooldown( "eye_beam", 0.5 * talent.cycle_of_hatred.rank ) end
            if set_bonus.tier31_2pc > 0 then spec.abilities.throw_glaive.handler() end
            if pvptalent.mortal_dance.enabled or talent.mortal_dance.enabled then applyDebuff( "target", "mortal_dance" ) end
        end,

        copy = "blade_dance1"
    },

    -- Increases your chance to dodge by $212800s2% and reduces all damage taken by $212800s3% for $212800d.
    blur = {
        id = 198589,
        cast = 0,
        cooldown = function () return 60 + ( conduit.fel_defender.mod * 0.001 ) end,
        gcd = "off",
        school = "physical",

        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            applyBuff( "blur" )
        end,
    },

    -- Talent: Unleash an eruption of fel energy, dealing $s2 Chaos damage and stunning all nearby enemies for $d.$?s320412[    Each enemy stunned by Chaos Nova has a $s3% chance to generate a Lesser Soul Fragment.][]
    chaos_nova = {
        id = 179057,
        cast = 0,
        cooldown = 45,
        gcd = "spell",
        school = "chromatic",

        spend = 25,
        spendType = "fury",

        talent = "chaos_nova",
        startsCombat = true,

        toggle = "cooldowns",

        handler = function ()
            applyDebuff( "target", "chaos_nova" )
        end,
    },

    -- Slice your target for ${$222031s1+$199547s1} Chaos damage. Chaos Strike has a ${$min($197125h,100)}% chance to refund $193840s1 Fury.
    chaos_strike = {
        id = 162794,
        flash = { 162794, 201427 },
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "chaos",

        spend = function () return 40 - buff.thirsting_blades.stack end,
        spendType = "fury",

        startsCombat = true,

        bind = "annihilation",
        nobuff = "metamorphosis",

        cycle = function () return ( talent.burning_wound.enabled or legendary.burning_wound.enabled ) and "burning_wound" or nil end,

        handler = function ()
            removeBuff( "thirsting_blades" )
            removeBuff( "inner_demon" )
            if buff.rending_strike.up then
                applyDebuff( "target", "reavers_mark" )
                removeBuff( "rending_strike" )
            end
            if azerite.thirsting_blades.enabled then applyBuff( "thirsting_blades", nil, 0 ) end
            if talent.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
            if buff.chaos_theory.up then
                gain( 20, "fury" )
                removeBuff( "chaos_theory" )
            end
            removeBuff( "chaotic_blades" )
            if talent.cycle_of_hatred.enabled and cooldown.eye_beam.remains > 0 then reduceCooldown( "eye_beam", 0.5 * talent.cycle_of_hatred.rank ) end
        end,
    },

    -- Talent: Consume $m1 beneficial Magic effect removing it from the target$?s320313[ and granting you $s2 Fury][].
    consume_magic = {
        id = 278326,
        cast = 0,
        cooldown = 10,
        gcd = "spell",
        school = "chromatic",

        startsCombat = false,
        talent = "consume_magic",

        toggle = "interrupts",

        usable = function () return buff.dispellable_magic.up end,
        handler = function ()
            removeBuff( "dispellable_magic" )
            if talent.swallowed_anger.enabled then gain( 20, "fury" ) end
        end,
    },

    -- Summons darkness around you in a$?a357419[ 12 yd][n 8 yd] radius, granting friendly targets a $209426s2% chance to avoid all damage from an attack. Lasts $d.; Chance to avoid damage increased by $s3% when not in a raid.
    darkness = {
        id = 196718,
        cast = 0,
        cooldown = 300,
        gcd = "spell",
        school = "physical",

        talent = "darkness",
        startsCombat = false,

        toggle = "defensives",

        handler = function ()
            last_darkness = query_time
            applyBuff( "darkness" )
        end,
    },


    death_sweep = {
        id = 210152,
        known = 188499,
        flash = { 210152, 188499 },
        cast = 0,
        cooldown = function() return 9 * haste end,
        gcd = "spell",

        spend = 35,
        spendType = "fury",

        startsCombat = true,
        texture = 1309099,

        bind = "blade_dance",
        buff = "metamorphosis",

        handler = function ()
            applyBuff( "death_sweep" )
            removeBuff( "restless_hunter" )
            setCooldown( "blade_dance", action.death_sweep.cooldown )
            if buff.rending_strike.up then
                applyDebuff( "target", "reavers_mark" )
                removeBuff( "rending_strike" )
            end

            if talent.cycle_of_hatred.enabled and cooldown.eye_beam.remains > 0 then reduceCooldown( "eye_beam", 0.5 * talent.cycle_of_hatred.rank ) end
            if set_bonus.tier31_2pc > 0 then spec.abilities.throw_glaive.handler() end
            if pvptalent.mortal_dance.enabled or talent.mortal_dance.enabled then
                applyDebuff( "target", "mortal_dance" )
            end
        end,
    },

    -- Quickly attack for $s2 Physical damage.    |cFFFFFFFFGenerates $?a258876[${$m3+$258876s3} to ${$M3+$258876s4}][$m3 to $M3] Fury.|r
    demons_bite = {
        id = 162243,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "physical",

        spend = function () return talent.insatiable_hunger.enabled and -25 or -20 end,
        spendType = "fury",

        startsCombat = true,

        notalent = "demon_blades",
        cycle = function () return ( talent.burning_wound.enabled or legendary.burning_wound.enabled ) and "burning_wound" or nil end,

        handler = function ()
            if talent.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
        end,
    },

    -- Interrupts the enemy's spellcasting and locks them from that school of magic for $d.|cFFFFFFFF$?s183782[    Generates $218903s1 Fury on a successful interrupt.][]|r
    disrupt = {
        id = 183752,
        cast = 0,
        cooldown = 15,
        gcd = "off",
        school = "chromatic",

        startsCombat = true,

        toggle = "interrupts",

        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            interrupt()
            if talent.disrupting_fury.enabled then gain( 30, "fury" ) end
        end,
    },

    -- Talent: Slash all enemies in front of you for $s1 Chaos damage, and increase the damage your Chaos Strike and Blade Dance deal to them by $320338s1% for $320338d. Deals reduced damage beyond $s2 targets.
    essence_break = {
        id = 258860,
        cast = 0,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        talent = "essence_break",
        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "essence_break" )
            active_dot.essence_break = max( 1, active_enemies )
        end,

        copy = "dark_slash"
    },

    -- Blasts all enemies in front of you,$?s320415[ dealing guaranteed critical strikes][] for up to $<dmg> Chaos damage over $d. Deals reduced damage beyond $s5 targets.$?s343311[; When Eye Beam finishes fully channeling, your Haste is increased by an additional $343312s1% for $343312d.][]
    eye_beam = {
        id = 198013,
        cast = function () return ( talent.blind_fury.enabled and 3 or 2 ) * haste end,
        channeled = true,
        cooldown = 40,
        gcd = "spell",
        school = "chromatic",

        spend = 30,
        spendType = "fury",

        talent = "eye_beam",
        startsCombat = true,

        start = function ()
            last_eye_beam = query_time

            applyBuff( "eye_beam" )
            removeBuff( "seething_potential" )

            if talent.demonic.enabled then
                if buff.metamorphosis.up then
                    buff.metamorphosis.duration = buff.metamorphosis.remains + 8
                    buff.metamorphosis.expires = buff.metamorphosis.expires + 8
                else
                    applyBuff( "metamorphosis", action.eye_beam.cast + 8 )
                    buff.metamorphosis.duration = action.eye_beam.cast + 8
                    stat.haste = stat.haste + 25

                    if talent.inner_demon.enabled then
                        applyBuff( "inner_demon" )
                    end
                end
            end

            if pvptalent.isolated_prey.enabled and active_enemies == 1 then
                applyDebuff( "target", "isolated_prey" )
            end

            -- This is likely repeated per tick but it's not worth the CPU overhead to model each tick.
            if legendary.agony_gaze.enabled and debuff.sinful_brand.up then
                debuff.sinful_brand.expires = debuff.sinful_brand.expires + 0.75
            end
        end,

        finish = function ()
            if talent.furious_gaze.enabled then applyBuff( "furious_gaze" ) end
        end,

        copy = { "abyssal_gaze", 452497 }
    },

    -- Talent: Unleash a torrent of Fel energy over $d, inflicting ${(($d/$t1)+1)*$258926s1} Chaos damage to all enemies within $258926A1 yds. Deals reduced damage beyond $258926s2 targets.
    fel_barrage = {
        id = 258925,
        cast = 3,
        channeled = true,
        cooldown = 90,
        gcd = "spell",
        school = "chromatic",

        spend = 10,
        spendType = "fury",

        talent = "fel_barrage",
        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "fel_barrage" )
        end,
    },

    -- Impales the target for $s1 Chaos damage and stuns them for $d.
    fel_eruption = {
        id = 211881,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "chromatic",

        spend = 10,
        spendType = "fury",

        startsCombat = true,

        handler = function ()
            applyDebuff( "target", "fel_eruption" )
        end,
    },


    fel_lance = {
        id = 206966,
        cast = 1,
        cooldown = 0,
        gcd = "spell",

        pvptalent = "rain_from_above",
        buff = "rain_from_above",

        startsCombat = true,
    },

    -- Rush forward, incinerating anything in your path for $192611s1 Chaos damage.
    fel_rush = {
        id = 195072,
        cast = 0,
        charges = function() return talent.blazing_path.enabled and 2 or nil end,
        cooldown = function () return ( legendary.erratic_fel_core.enabled and 7 or 10 ) * ( 1 - 0.1 * talent.erratic_felheart.rank ) end,
        recharge = function () return talent.blazing_path.enabled and ( ( legendary.erratic_fel_core.enabled and 7 or 10 ) * ( 1 - 0.1 * talent.erratic_felheart.rank ) ) or nil end,
        gcd = "off",
        icd = 0.5,
        school = "physical",

        startsCombat = true,
        nodebuff = "rooted",

        readyTime = function ()
            if prev[1].fel_rush then return 3600 end
            if ( settings.fel_rush_charges or 1 ) == 0 then return end
            return ( ( 1 + ( settings.fel_rush_charges or 1 ) ) - cooldown.fel_rush.charges_fractional ) * cooldown.fel_rush.recharge
        end,

        handler = function ()
            setDistance( 5 )
            setCooldown( "global_cooldown", 0.25 )
            if buff.unbound_chaos.up then
                removeBuff( "unbound_chaos" )
                if talent.inertia.enabled then applyBuff( "inertia" ) end
            end
            if cooldown.vengeful_retreat.remains < 1 then setCooldown( "vengeful_retreat", 1 ) end
            if talent.momentum.enabled then applyBuff( "momentum" ) end
            if active_enemies == 1 and talent.isolated_prey.enabled then gain( 25, "fury" ) end
            if conduit.felfire_haste.enabled then applyBuff( "felfire_haste" ) end
        end,
    },

    -- Talent: Charge to your target and deal $213243sw2 $@spelldesc395020 damage.    $?s203513[Shear has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]?a203555[Demon Blades has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r][Demon's Bite has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]
    felblade = {
        id = 232893,
        cast = 0,
        cooldown = 15,
        hasteCD = true,
        gcd = "spell",
        school = "physical",

        spend = -40,
        spendType = "fury",

        talent = "felblade",
        startsCombat = true,
        nodebuff = "rooted",

        handler = function ()
            setDistance( 5 )
        end,
    },

    -- Talent: Launch two demonic glaives in a whirlwind of energy, causing ${14*$342857s1} Chaos damage over $d to all nearby enemies. Deals reduced damage beyond $s2 targets.
    glaive_tempest = {
        id = 342817,
        cast = 0,
        cooldown = 25,
        gcd = "spell",
        school = "magic",

        spend = 30,
        spendType = "fury",

        talent = "glaive_tempest",
        startsCombat = true,

        handler = function ()
            if talent.cycle_of_hatred.enabled and cooldown.eye_beam.remains > 0 then reduceCooldown( "eye_beam", 0.5 * talent.cycle_of_hatred.rank ) end
        end,
    },

    -- Engulf yourself in flames, $?a320364 [instantly causing $258921s1 $@spelldesc395020 damage to enemies within $258921A1 yards and ][]radiating ${$258922s1*$d} $@spelldesc395020 damage over $d.$?s320374[    |cFFFFFFFFGenerates $<havocTalentFury> Fury over $d.|r][]$?(s212612 & !s320374)[    |cFFFFFFFFGenerates $<havocFury> Fury.|r][]$?s212613[    |cFFFFFFFFGenerates $<vengeFury> Fury over $d.|r][]
    immolation_aura = {
        id = 258920,
        cast = 0,
        cooldown = function() return 30 * haste end,
        charges = function()
            if talent.a_fire_inside.enabled then return 2 end
        end,
        recharge = function()
            if talent.a_fire_inside.enabled then return 30 * haste end
        end,
        gcd = "spell",
        school = "fire",

        spend = -20,
        spendType = "fury",

        startsCombat = false,

        handler = function ()
            applyBuff( "immolation_aura" )
            if talent.unbound_chaos.enabled then applyBuff( "unbound_chaos" ) end
            if talent.ragefire.enabled then applyBuff( "ragefire" ) end
        end,

        copy = { 427917, "consuming_fire", 452487, 456640 },
    },

    -- Talent: Imprisons a demon, beast, or humanoid, incapacitating them for $d. Damage will cancel the effect. Limit 1.
    imprison = {
        id = 217832,
        cast = 0,
        gcd = "spell",
        school = "shadow",

        talent = "imprison",
        startsCombat = false,

        handler = function ()
            applyDebuff( "target", "imprison" )
        end,
    },

    -- Leap into the air and land with explosive force, dealing $200166s2 Chaos damage to enemies within 8 yds, and stunning them for $200166d. Players are Dazed for $247121d instead.    Upon landing, you are transformed into a hellish demon for $162264d, $?s320645[immediately resetting the cooldown of your Eye Beam and Blade Dance abilities, ][]greatly empowering your Chaos Strike and Blade Dance abilities and gaining $162264s4% Haste$?(s235893&s204909)[, $162264s5% Versatility, and $162264s3% Leech]?(s235893&!s204909[ and $162264s5% Versatility]?(s204909&!s235893)[ and $162264s3% Leech][].
    metamorphosis = {
        id = 191427,
        cast = 0,
        cooldown = function () return ( 180 - ( talent.rush_of_chaos.enabled and 30 or 0 ) ) * ( essence.vision_of_perfection.enabled and 0.87 or 1 ) - ( pvptalent.demonic_origins.enabled and 120 or 0 ) end,
        gcd = "spell",
        school = "physical",

        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "metamorphosis" )
            last_metamorphosis = query_time

            setDistance( 5 )

            if IsSpellKnownOrOverridesKnown( 317009 ) then
                applyDebuff( "target", "sinful_brand" )
                active_dot.sinful_brand = active_enemies
            end

            if level > 19 then stat.haste = stat.haste + 25 end

            if azerite.chaotic_transformation.enabled or talent.chaotic_transformation.enabled then
                setCooldown( "eye_beam", 0 )
                setCooldown( "blade_dance", 0 )
                setCooldown( "death_sweep", 0 )
            end
        end,

        meta = {
            adjusted_remains = function ()
                --[[ if level < 116 and ( equipped.delusions_of_grandeur or equipped.convergeance_of_fates ) then
                    return cooldown.metamorphosis.remains * meta_cd_multiplier
                end ]]

                return cooldown.metamorphosis.remains
            end
        }
    },

    -- Talent: Slip into the nether, increasing movement speed by $s3% and becoming immune to damage, but unable to attack. Lasts $d.
    netherwalk = {
        id = 196555,
        cast = 0,
        cooldown = 180,
        gcd = "spell",
        school = "physical",

        talent = "netherwalk",
        startsCombat = false,

        toggle = "interrupts",

        handler = function ()
            applyBuff( "netherwalk" )
            setCooldown( "global_cooldown", buff.netherwalk.remains )
        end,
    },


    rain_from_above = {
        id = 206803,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        pvptalent = "rain_from_above",

        startsCombat = false,
        texture = 1380371,

        handler = function ()
            applyBuff( "rain_from_above" )
        end,
    },


    reverse_magic = {
        id = 205604,
        cast = 0,
        cooldown = 60,
        gcd = "spell",

        -- toggle = "cooldowns",
        pvptalent = "reverse_magic",

        startsCombat = false,
        texture = 1380372,

        debuff = "reversible_magic",

        handler = function ()
            if debuff.reversible_magic.up then removeDebuff( "player", "reversible_magic" ) end
        end,
    },


    -- Talent: Place a Sigil of Flame at your location that activates after $d.    Deals $204598s1 Fire damage, and an additional $204598o3 Fire damage over $204598d, to all enemies affected by the sigil.    |CFFffffffGenerates $389787s1 Fury.|R
    sigil_of_flame = {
        id = function ()
            if talent.precise_sigils.enabled then return 389810 end
            if talent.concentrated_sigils.enabled then return 204513 end -- TODO: Remove?
            return 204596
        end,
        known = 204596,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "physical",

        spend = -30,
        spendType = "fury",

        startsCombat = false,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "flame" )
        end,

        copy = { 204596, 204513, 389810, "sigil_of_doom", 452490 }
    },

    -- Talent: Place a Sigil of Misery at your location that activates after $d.    Causes all enemies affected by the sigil to cower in fear. Targets are disoriented for $207685d.
    sigil_of_misery = {
        id = function ()
            if talent.precise_sigils.enabled then return 389813 end
            if talent.concentrated_sigils.enabled then return 202140 end
            return 207684
        end,
        known = 207684,
        cast = 0,
        cooldown = function () return 120 * ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) end,
        gcd = "spell",
        school = "physical",

        talent = "sigil_of_misery",
        startsCombat = false,

        toggle = function()
            if talent.misery_in_defeat.enabled then return "cooldowns" end
            return "interrupts"
        end,

        handler = function ()
            create_sigil( "misery" )
        end,

        copy = { 389813, 207684, 202140 }
    },

    -- Place a demonic sigil at the target location that activates after $d.; Detonates to deal $389860s1 Chaos damage and shatter up to $s3 Lesser Soul Fragments from
    sigil_of_spite = {
        id = 390163,
        cast = 0.0,
        cooldown = function() return 60 * ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) end,
        gcd = "spell",

        talent = "sigil_of_spite",
        startsCombat = false,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "spite" )
        end,
    },

    -- Allows you to see enemies and treasures through physical barriers, as well as enemies that are stealthed and invisible. Lasts $d.    Attacking or taking damage disrupts the sight.
    spectral_sight = {
        id = 188501,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "physical",

        startsCombat = false,

        handler = function ()
            applyBuff( "spectral_sight" )
        end,
    },

    -- Talent / Covenant (Night Fae): Charge to your target, striking them for $370966s1 $@spelldesc395042 damage, rooting them in place for $370970d and inflicting $370969o1 $@spelldesc395042 damage over $370969d to up to $370967s2 enemies in your path.     The pursuit invigorates your soul, healing you for $?c1[$370968s1%][$370968s2%] of the damage you deal to your Hunt target for $370966d.
    the_hunt = {
        id = function() return talent.the_hunt.enabled and 370965 or 323639 end,
        cast = 1,
        cooldown = function() return talent.the_hunt.enabled and 90 or 180 end,
        gcd = "spell",
        school = "nature",

        startsCombat = true,
        toggle = "cooldowns",
        nodebuff = "rooted",

        handler = function ()
            applyDebuff( "target", "the_hunt" )
            applyDebuff( "target", "the_hunt_dot" )
            setDistance( 5 )

            if talent.momentum.enabled then applyBuff( "momentum" ) end

            if legendary.blazing_slaughter.enabled then
                applyBuff( "immolation_aura" )
                applyBuff( "blazing_slaughter" )
            end
        end,

        copy = { 370965, 323639 }
    },

    -- Throw a demonic glaive at the target, dealing $337819s1 Physical damage. The glaive can ricochet to $?$s320386[${$337819x1-1} additional enemies][an additional enemy] within 10 yards.
    throw_glaive = {
        id = 185123,
        known = 185123,
        cast = 0,
        charges = function () return talent.champion_of_the_glaive.enabled and 2 or nil end,
        cooldown = 9,
        recharge = function () return talent.champion_of_the_glaive.enabled and 9 or nil end,
        gcd = "spell",
        school = "physical",

        spend = function() return talent.furious_throws.enabled and 25 or 0 end,
        spendType = "fury",

        startsCombat = true,
        nobuff = "reavers_glaive",

        readyTime = function ()
            if ( settings.throw_glaive_charges or 1 ) == 0 then return end
            return ( ( 1 + ( settings.throw_glaive_charges or 1 ) ) - cooldown.throw_glaive.charges_fractional ) * cooldown.throw_glaive.recharge
        end,

        handler = function ()
            if talent.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
            if talent.champion_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
            if talent.serrated_glaive.enabled then applyDebuff( "target", "serrated_glaive" ) end
            if talent.soulscar.enabled then applyDebuff( "target", "soulscar" ) end
            if set_bonus.tier31_4pc > 0 then reduceCooldown( "the_hunt", 2 ) end
        end,

        bind = "reavers_glaive"
    },

    -- Taunts the target to attack you.
    torment = {
        id = 185245,
        cast = 0,
        cooldown = 8,
        gcd = "off",
        school = "shadow",

        startsCombat = false,

        handler = function ()
            applyBuff( "torment" )
        end,
    },

    -- Talent: Remove all snares and vault away. Nearby enemies take $198813s2 Physical damage$?s320635[ and have their movement speed reduced by $198813s1% for $198813d][].$?a203551[    |cFFFFFFFFGenerates ${($203650s1/5)*$203650d} Fury over $203650d if you damage an enemy.|r][]
    vengeful_retreat = {
        id = 198793,
        cast = 0,
        cooldown = function () return talent.tactical_retreat.enabled and 20 or 25 end,
        gcd = "spell",

        startsCombat = true,
        nodebuff = "rooted",

        readyTime = function ()
            if settings.retreat_and_return == "fel_rush" or settings.retreat_and_return == "either" and not talent.felblade.enabled then
                return max( 0, cooldown.fel_rush.remains - 1 )
            end
            if settings.retreat_and_return == "felblade" and talent.felblade.enabled then
                return max( 0, cooldown.felblade.remains - 0.4 )
            end
            if settings.retreat_and_return == "either" then
                return max( 0, min( cooldown.felblade.remains, cooldown.fel_rush.remains ) - 1 )
            end
        end,

        handler = function ()
            applyBuff( "vengeful_retreat_movement" )
            if cooldown.fel_rush.remains < 1 then setCooldown( "fel_rush", 1 ) end
            applyDebuff( "target", "vengeful_retreat" )
            applyDebuff( "target", "vengeful_retreat_snare" )
            -- Assume that we retreated away.
            setDistance( 15 )

            if talent.evasive_action.enabled then
                if buff.evasive_action.down then applyBuff( "evasive_action" )
                else
                    removeBuff( "evasive_action" )
                    setCooldown( "vengeful_retreat", 0 )
                end
            end
            if talent.tactical_retreat.enabled then applyBuff( "tactical_retreat" ) end
            if talent.momentum.enabled then applyBuff( "momentum" ) end
            if pvptalent.glimpse.enabled then applyBuff( "glimpse" ) end
        end,
    }
} )


spec:RegisterRanges( "disrupt", "felblade", "fel_eruption", "torment", "throw_glaive", "the_hunt" )

spec:RegisterOptions( {
    enabled = true,

    aoe = 3,
    cycle = false,

    nameplates = true,
    nameplateRange = 10,
    rangeFilter = false,

    damage = true,
    damageExpiration = 8,

    potion = "phantom_fire",

    package = "Havoc",
} )


spec:RegisterSetting( "demon_blades_text", nil, {
    name = function()
        return strformat( "|cFFFF0000WARNING!|r  If using the %s talent, Fury gains from your auto-attacks will be forecast conservatively and updated when you "
            .. "actually gain resources.  This prediction can result in Fury spenders appearing abruptly since it was not guaranteed that you'd have enough Fury on "
            .. "your next melee swing.", Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    type = "description",
    width = "full"
} )

spec:RegisterSetting( "demon_blades_acknowledged", false, {
    name = function()
        return strformat( "I understand that Fury generation from %s is unpredictable.", Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    desc = function()
        return strformat( "If checked, %s will not trigger a warning when entering combat.", Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    type = "toggle",
    width = "full",
    arg = function() return false end,
} )


-- Fel Rush
spec:RegisterSetting( "fel_rush_head", nil, {
    name = Hekili:GetSpellLinkWithTexture( 195072, 20 ),
    type = "header"
} )

spec:RegisterSetting( "fel_rush_warning", nil, {
    name = strformat( "The %s, %s, and/or %s talents require the use of %s.  If you do not want |W%s|w to be recommended to trigger these talents, you may want to "
        .. "consider a different talent build.\n\n"
        .. "You can reserve |W%s|w charges to ensure recommendations will always leave you with charge(s) available to use, but failing to use |W%s|w may ultimately "
        .. "cost you DPS.", Hekili:GetSpellLinkWithTexture( 388113 ), Hekili:GetSpellLinkWithTexture( 206476 ), Hekili:GetSpellLinkWithTexture( 347461 ),
        Hekili:GetSpellLinkWithTexture( 195072 ), spec.abilities.fel_rush.name, spec.abilities.fel_rush.name, spec.abilities.fel_rush.name ),
    type = "description",
    width = "full",
} )

spec:RegisterSetting( "fel_rush_charges", 0, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( 195072 ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer (fractional) charges.", Hekili:GetSpellLinkWithTexture( 195072 ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = "full"
} )

spec:RegisterSetting( "fel_rush_filler", true, {
    name = strformat( "%s: Filler and Movement", Hekili:GetSpellLinkWithTexture( 195072 ) ),
    desc = strformat( "When enabled, %s may be recommended as a filler ability or for movement.\n\n"
        .. "These recommendations may occur with %s talented, when your other abilities are on cooldown, and/or because you are out of range of your target.",
        Hekili:GetSpellLinkWithTexture( 195072 ), Hekili:GetSpellLinkWithTexture( 203555 ) ),
    type = "toggle",
    width = "full"
} )

-- Throw Glaive
spec:RegisterSetting( "throw_glaive_head", nil, {
    name = Hekili:GetSpellLinkWithTexture( 185123, 20 ),
    type = "header"
} )

spec:RegisterSetting( "throw_glaive_charges_text", nil, {
    name = strformat( "You can reserve charges of %s to ensure that it is always available for %s or |W|T1385910:0::::64:64:4:60:4:60|t |cff71d5ff%s (affix)|r|w procs. "
        .. "If set to your maximum charges (2 with %s, 1 otherwise), |W%s|w will never be recommended.  Failing to use |W%s|w when appropriate may impact your DPS.",
        Hekili:GetSpellLinkWithTexture( 185123 ), Hekili:GetSpellLinkWithTexture( 391429 ), GetSpellInfo( 396363 ) or "Thundering", Hekili:GetSpellLinkWithTexture( 389763 ),
        spec.abilities.throw_glaive.name, spec.abilities.throw_glaive.name ),
    type = "description",
    width = "full",
} )

spec:RegisterSetting( "throw_glaive_charges", 0, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( 185123 ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer (fractional) charges.", Hekili:GetSpellLinkWithTexture( 185123 ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = "full"
} )

--[[ Retired 20240712:
spec:RegisterSetting( "footloose", true, {
    name = strformat( "%s before %s", Hekili:GetSpellLinkWithTexture( 185123 ) , Hekili:GetSpellLinkWithTexture( 188499 ) ),
    desc = strformat( "When enabled, %s may be recommended without having %s on cooldown.\n\n"
        .. "This setting deviates from the default SimulationCraft profile, but performs equally on average with higher top-end damage.",
        Hekili:GetSpellLinkWithTexture( 185123 ) , Hekili:GetSpellLinkWithTexture( 188499 ) ),
    type = "toggle",
    width = "full"
} ) ]]

-- Vengeful Retreat
spec:RegisterSetting( "retreat_head", nil, {
    name = Hekili:GetSpellLinkWithTexture( 198793, 20 ),
    type = "header"
} )

spec:RegisterSetting( "retreat_warning", nil, {
    name = strformat( "The %s, %s, and/or %s talents require the use of %s.  If you do not want |W%s|w to be recommended to trigger the benefit of these talents, you "
        .. "may want to consider a different talent build.", Hekili:GetSpellLinkWithTexture( 388108 ),Hekili:GetSpellLinkWithTexture( 206476 ),
        Hekili:GetSpellLinkWithTexture( 389688 ), Hekili:GetSpellLinkWithTexture( 198793 ), spec.abilities.vengeful_retreat.name ),
    type = "description",
    width = "full",
} )

spec:RegisterSetting( "retreat_and_return", "off", {
    name = strformat( "%s: %s and %s", Hekili:GetSpellLinkWithTexture( 198793 ), Hekili:GetSpellLinkWithTexture( 195072 ), Hekili:GetSpellLinkWithTexture( 232893 ) ),
    desc = function()
        return strformat( "When enabled, %s will |cFFFF0000NOT|r be recommended unless either %s or %s are available to quickly return to your current target.  This "
            .. "requirement applies to all |W%s|w and |W%s|w recommendations, regardless of talents.\n\n"
            .. "If |W%s|w is not talented, its cooldown will be ignored.\n\n"
            .. "This option does not guarantee that |W%s|w or |W%s|w will be the first recommendation after |W%s|w but will ensure that either/both are available immediately.",
            Hekili:GetSpellLinkWithTexture( 198793 ), Hekili:GetSpellLinkWithTexture( 195072 ), Hekili:GetSpellLinkWithTexture( 232893 ),
            spec.abilities.fel_rush.name, spec.abilities.vengeful_retreat.name, spec.abilities.felblade.name,
            spec.abilities.fel_rush.name, spec.abilities.felblade.name, spec.abilities.vengeful_retreat.name )
    end,
    type = "select",
    values = {
        off = "Disabled (default)",
        fel_rush = "Require " .. Hekili:GetSpellLinkWithTexture( 195072 ),
        felblade = "Require " .. Hekili:GetSpellLinkWithTexture( 232893 ),
        either = "Either " .. Hekili:GetSpellLinkWithTexture( 195072 ) .. " or " .. Hekili:GetSpellLinkWithTexture( 232893 )
    },
    width = "full"
} )

spec:RegisterSetting( "retreat_filler", false, {
    name = strformat( "%s: Filler and Movement", Hekili:GetSpellLinkWithTexture( 198793 ) ),
    desc = function()
        return strformat( "When enabled, %s may be recommended as a filler ability or for movement.\n\n"
            .. "These recommendations may occur with %s talented, when your other abilities being on cooldown, and/or because you are out of range of your target.",
            Hekili:GetSpellLinkWithTexture( 198793 ), Hekili:GetSpellLinkWithTexture( 203555 ) )
    end,
    type = "toggle",
    width = "full"
} )

spec:RegisterPack( "Havoc", 20240903, [[Hekili:L3txVTnss(BXyXPiAhRLKsYjzpBn4U5LBcomV4zX(WHtu0s02CTKOgsQKXhm0V9R7MF1Fuv1KusjtWIfyNyXMvxD113v1nN7n)3MF)QW8O5)QVR)e3p5oEKNR34PFy(95VUlA(97cx(s4tS)X2WnS)))RWVKSK)RVUojCf)TZs2NUK9K7J3SFDyECY2Fon8X853)W(415)Y25papd3WE1DrlN)Rt)aBYEoE1QOIXgLXMa(yV29tx769(dl4)3X)TdlytXpFyX(DCWD4Zh(CXG(41(3WE4FV4NxKSlABu6HfRtEkEPYOMudIDPXjPX5VcbmpF2W(5NJw(cdMBFiz)2v8)omj7WI8W1rBZpS4Xe2e8lB2KCyX)X(0WMx)dx7Zr0F7zgI8pczd6FeN)C8wgbln5X41mYu4sojkB0U0OLjBEim)Q7(RFjmno8H1rVNtJVBt4)mjnipnE7lr5V)lHR3hDx5FnYB0YKK1Rs(62rRytmhu359r33ERAa(Wd4WNTpVLGii71TldYwNun3EVp(rje45WSGS8W8rHBFny1USbdVOzY1FydIbG5ZUJaRDogu2xgLnXkju2C9qslNrSCAfgN(uWQS3Vk6XW9RZVZ99j7Ulnklkh(DdtxgUnkipjnLZ3boMS4NIxhK8yWJRzta8yIzSQfYMbHmSLtDEy)Jpos73hXxpCM5)YF5WIs4WE70O8W0NyK5W95jbH55mvcVFDmdXwUIXDu(qgm3eVDvKaWpSpDB82Nc(kx8zuA0MW4TzInfHeK6Zhu(JRI2WqKhwhYubmGp9FjkyvI2GVDitRX61bfZA2SFASZXGVxu8xJIZcEij70GI3bHInONbdr82LC(GSAPDbjKTJVIdYmgl3lrITMbIh806q(0(469PPVoA)Ub1CIc8kyv42Lr8F)PL1K(7yQiQM3rft5agdYxc4JXJTScZFoi7Rrr70jM7Ix(sW(DbpMg(0ggj497ZIyCBpYFZ78WxxpgTo4HWu2BfPU4kPKspFWW6vG0VwH63YrXnH)XLFyWWskotb)M4OSz3X2fItJwvrPVknmEvq0x4WpC1QmMm6(T5V9M(phVTbOqpD2NCDKqQnm(PnjP7EojloRcTE7nnKX35T3e7pYRH97CgCHgAFN3Gl0NZO)iolptHnzvCw6(D5Y)ehYP7ZEUw(DFH9PGLCZt8TCGFvNm6ldrXqkzXQHQgNxfyn47gkZrTk7oFaAI8KfUDB8ZXf6Bo7twAu4xIsZckau90Pc3gHkuPT8NtJxl0VM)m79IF65CMe2gig0jxzGKox1WgXF)Nz8JgV3yNlhlnUOxJcEikCJ54Q0cL9mtPweNXNjaKhV9vgamiqAs8R48DiAkmgPp8ilriMSHnsdhMxaRGH9annrodu3jVD8Glk2ihPUloADywEatb0QBNoO0stuwwed3cEGn0xe7BV9wbQur(8C)oXxm5mtNM5tVuxgYM1I)mynt)sHI5QDw7JSWtAojcG5KJ5iAivEK6(dxFyE8MOB9MoyiGI3jUkcX1(2KTloxSzHURxXpuT)Ujm9LQDIz35FDPOZVVNzpJTSwfiGDMcRX(TMebz7yS5VElr2(L(cz)ozWc48L((yLGnhApYSObPhxSizoUAy(uIydy(CgZnWN5Mhd40DhCXMbOkGubXvtlzRv30lK8aEqfqM6yHO8CuAclSNibTnBjBzeTAaTrygdpoAZF4qeczHXJKckg3K6OIvOqTjHQ4FIgFCUDQt1EzyaFNKj3MfVk6y5hm5Wm(P6v9uShnJqPz3CZWaFR5lzEzNMhhkRaqJgEL)mCVuuDuoAlB5VNHmrm2IqnxpLCvpEBmBo5O0a89UzmcJKhX36oA8BVP(d(emt3jnuq2kUwVsMk9WQuKFMDdtZUo1Q8V3KWDXE)gREFoZZvIedyJUXDVbdTmzGsTmf1ofQQNPz)SNkjBw0kXqbfnaGx0i644Mtq0fzfN5VY75M1xMxWmbsf6MCHkLUa1k)dnDSqBztiubpTi4haMRsfxZCBh73v(3IolesTeYSxR64TmvsJtJq8cm6eanLqkxrTwY0DWvEiT6LflaC)W8fmIYqlKtBg1OFBC78AVx)J0fynzdNH4IbWr8nZPNx8VXAJIDmuNoRrlN(SYvKFRNzf6rPgutAKZanxNWL9ivnytVXzLC7mOufdphqcQx46zEJCDTqm55tBGw8jtPxMyMQQ8dco4arIpL2(YY3VI9FfXnW2xIszbWzx1JSRdGSp1H53yktzGNqJ2QjmScJ5lrWzUHTKZ6LhVK5gD42Shts3i2sqJuRwY4QXxILBbBVmBv5yWaQX)DPpiV2y3QWYw(6Y1CF7cyZo79yB4BF5spCYamvOLBG(xnLy1I9Kb0qVGmqU7cKRrUdms(ox5gRenx3jyfMjn)ihCHHRDGtO6M1vJpg9fw2dVXbi2GU59CDKzdAJ)nS4mzZO5Y2e5RiKF0HonksBLCwpCxKA8Tal1rDp1RAEwjWfeNvlD5HN(kMYYLX5ZMOSoktXvE0MDmoAaNtocUavkMPMzTzACnNkKU6sgKK9IFMXg9uzI3QC(lnVkzAfRjkYkyeV7nkZr3mMmKifbtSKZIz(UoK5yOYEecy4rMrYvyq3yS34Cf5pNM8vPSHQTt5vhH2(04K9zbIXNrrXBHasbgntu4AqLhwCTqxV3PXxEJ0AyXDdeUu8mS1JS35pLXROIxe1psTas84SZcEiopIAdhZ9E14MW9BLy5IZj8r2Yg0PsVYa6njR6mMDiY8VVRhkexTa)9IPIljXSy5YRBFjGR7nb2mOO8Gpbd7N)goul)78DrdkdrbC5(SmpFbrgSQamHauZ3nUbjbmZAL40momVKbIyzSRtvyGmDnbczknH5uM101SLNO4ErPV9gC9CCCgG5UMMBSnjcpC9kg30ZXbfv1O0WyHG9EoVSe8ld4SiLDtpZ8c0rXneRIw1)UpYVpwHIHh0wx52WDR)hi(WHimIyEB2mrTMf1bneC9qDpBmP7s4)escegpfjB1O78ko6jppXB)sYlS9L)GrqykRd4VDrMH3L8vgfoE7J7ZIL6ubZPeabzAcbxv8sxWmeVPQf)wf877JI2YRt5wEhiAwBdOISvXRbtfkOTdl7OjonMzyjyvmJuZDJW83VLhZQyVWfok0sgUQFOqqQiil6vjVx8QAappG1wlC)v3SjwzkaLujAtVR9MshlOwVbkM1qEMba2U9frBg977J3TJfY7xJzbLKYe9FH9EmH6Lpd2nHsrc0xY)ajSKrhmzOA)(J)3X9hGwSS97p(N09hVZ0(JFh2FQAri0axlu4Rr6pI42h6D1fzr5bpKSDFgt1qu6yVa)DlDUCcNYb1tfIwwbv7VZaL3OSVDKSt1zfAGeQU0yiGRIgpxX6me6vjPdq1M3AW9IEPrsemd4zgf8MTUW6stJx2W5omNWSKSyKeswmFMUeUkoJxQ3vTWTrfFFe(hWBqFJfICcnq3vR7N3BCbarHpeapaixcvPx0V7f3PYHSMcer1uInybyJqk7xhVFhT5KiE6HaMr5CNJlPGfOdI7puYaqibqLHRtGtBOKqvICpKOGSAunOOPQeuP4e3RM6EjOErisRmDe450sTYScGVSuoCAEUuagxP341pXF1W8K0G97u78A5enj2Y0TPlTLQMTl9b2omHNzIag6OIfE)Bd9hDZLfTLFaZcEEKZLE(xvWbOLA)m(GU8MIhMZN0LHn6v2V7sPepttvwYI4JTxRHm1fCZhdmTqwf7vLf6eVMzqM6orb0OxiSOoOZQm)i(udktJbtjEyuiI9UaQC7UIwDDbWTApgkyw5dyAI(Ubg80QiuNihpQ2QuI8G756c6L8NCPo7c4EjpHit2aOdDpnjWqFxZ0KGZUyMQCTcq0fG9OE9nuFn0kErZcZFRRR7tTATdxpE6mxGoqRo)dsTkVSIwPcA008BLQ)M59XoWzIIyUFtrmnw8)KqUmtx(XXyrZ6J9IYUxiwhS590gtgsiz4k9r8tGRFhr9nCJGyyFVecGwbpoqmeSFVfawk3HYVvr2eSMzIlhtgDMT(zbQjCQwdwzz07aukePzIiNNsiw3dLfK(Y)Yaw(gWImKhd)pS3G4O7NaEg9DE7YWvirP)QSLz)e8uxW6jqUlvNcHM((anMSMNiNm8QLqfeuB4qzfqylOkJZNSopZ3H4mtOHEg9FeuTB1tByTVFunAMrbgNq1JovuNA3owLKiC6MmjnTNth70t3OMAu1Xwu6NmzZ11TTK)p2WlAdV3gH2VbM5wC(DawTvCYx5oAkAd9QP7sz3wmaZwQ4QXevsNqMzkLnkt2((N9ct1wp8AwglgYNc))SK3W2bptp4AtdeqSfv3Dm3a0xLhHBfEUMkiT2Ow(DqmrVXsQKZt2lSUd3irNslq0MrkPPuNrTBLAp5QWoGelrAfiewDKgAbYOFVBKlCmZc)TD0ct7NzpQO2HnuNIoCY1jLLN6Op0cxTiz4SY(JPL97wFiHSRPla2vNE)XCrHeWK9kiyuJgZINcx4Lk7j1vlSsAWh2sJz5fREbUn8sczZt51hy5lrPk1oGQJR5ZbVFpG7Kg8RAG3EBi4lG6xNJujNm7QEWz3bQ8b2P8aQvKD9guHdwB9l)IgSXORgqkZqZSQlkBzJTjIkncqi0T71NaPBUpCGQFw3J)8M6gfI4yJ1eFS653ZS6pWPN(T3GwQeNP92T0OX4larzq8dy6KZveYAcv2ag7R9ra)u4lAj0jUsvYvb5LjJTGDl14gZaQG6IDTUSravxG6etCnmvN2dpyMJHxGlFaDYlrPQ06rCGNF0iZf9pMmBVzK4uxwdfVku1YUDkaXgQIfgxXoDHrCzRo9ker7dXPPqHAHcDOW6bTLIXe05E41O5glO5357y70NH3bQyhNqacKzBVaTSQ7fYu1(2rQNcupTfezEXI1tsKSknmWBj9lrgaZNrzwHeETjjzWW0YCsQ70aO96wNYHUUY1thi95pSkfC4oJHyHQ3ChiYDMTiSI3jCacrhpvDsX875sfShxFLK6n)(VgkUb)YMFV4Y7mEZUK0QB6Z3vaL3DyrkVvc5NpPfzmpGoSGFddUjmN)dmnIm)tZgD4Z)3mv6hwWVhq)5KTSPs843vj6b2opmqNNyBqJI2kA1k2Gh69ho2MPMyd0GUuifDdIL9SLg4k)vmyDdmSum9QbrvZYiW9dFZOVFcJ(kmCBqClmNJalpeYXjfyk6f0aPQwNocydngAa345DDc(XfZp7tWXtAqKyoDyoYeC8yoIeyvuOAWSo40ocU(jdIamLax0aPYZWaSV7jelXa2XJLENzMkF)ZfMp5Cb4PNBsY5wfKpIGSwusAGx7PDf4NDS)Ovd5)rexouJMsd06xlgyUCHWNFcilh(mGlTLxb5VRt(0IGJs9IKg2j3jwDZpUtW6UubnIgk9Z7Hg81Fmk4r8vMVK5kl0fsk)5UcUJIe7DUu15HOQRVl(tQZXimwhryr4G8eIF91PM)mJBikoLVji1aP8J6kypkzLtRBxi6E6jD8BUVq9BrJaSJ3(lI2M(HLia7OZlbM3z9dlrawpvWI67fWLCKgOHgsxNMJNdarI)Sb4Zq2KWMQtMdp(irKE8ejeaF2X8Z(eCe(eGdY(iUFAt0Xjf3gJOw)eR7aBAmU030MdJNJobikNu7lrnOR(quqFwdq8uUzobXlNE66eyeM1FaQExNIX0WLj8RYJAuSCi5WJr1PXtm4TcyGR4cdadpMwH39f8nkjqji6Fz0aOhadrvdekwBf4GdPvaVVBLNzWBfW9DRSL4DFbFJgOZ5MjgWpjSH4yE)ijNzWBfW9LfSL4DFbpMLavRkDWwGgRCYUOIzkJndBza(uFxcuTk9(RNy4wVIq8q4iI6eKIxT30nYns2kocVJrG4rhkccC7P7lKW8meciYmDskVc6Eyp8s8CT7HKgRJGpdbINlm90fq6zGpgbMNb(yKz6KWhJYJ0d(4Zf3bAwt7nFmhI)9Tz73XvMZHz11fw1vy5Hf)phwyEBY9)(VFybBgsF9WIQlKRAyAKOZJ0kVgkFQbFlaS81(ham1EClX2wau(MbFiTfOMx5JgagCiNrGJd2JM3fN0cEbicqJXgNY0yKr8J0z7Zm4BbGj58mEClX2waum2zmGAEdzsjqJWoFAbooypA2zCsB7yNXhNY0GeqWr3DcIGcEmz96KVgV9jUB)PHSWM(kZReHvLvfHqLZhwLPf(hhVdlEyFE142MiIOGf9H8OxTIpy2Ij8HWSO)gleKfxZ(z(5ebmyeEVH)UofiYPSCKik66zk1pLjH9CxTdVtPpuyfBV649RJKL)Cxb3jil8y1FUZ74h(8VSPYpSBuLs4SQZVNXb)Cs687VpEZpp)EXVp)3MFFXPfG9V(vp(Fw8EZVV(MFD(9Lt18)Z55Z)vF(GA(L7xMYgvAC487Hpesnqu)eXYH24ocTdlE7n2k(WIlyKL2eeWHfohwmq7vmvNwa3cmf)wJTyu1Q1XU5ypSygBFvmZ8X3mVAN9GgsJY5rHtxMGsxqpoonqR6yxY3KfhB253FJlhQtL3GloZ4A7U3GoVLh2XdlUtS20jPGP9Py9JC2fL2zuozHfpRA7O5yXxtvBwcA52IVa(a6cW4KtTFN5YWgZKY(VXbQvg3KpGpCe7JDFhvGEGh4ljeh8qqPHOqNplzCT6GsXXZpHINWAE73EyZst)emRWglo7ZCSYZffTaMHvQ3bhfyI5nUHyStCpS4kMDx2)5sbbf62SRbPQoH0cKsrHPY(NMyLNV8iv0oQoUXYJtHfsBGtubO0PftDC2f59WL5zBRyQHB4m1VWhoS42knei8U1kfqEz3rtfVo1TgbKsDn(sB6EQv)OagWuPigPnhAQv4pSfa7IUbVwn8bTyD4Oi4Bys(EPBPcUdbC(dlQun19mavhz9US8quXuDaOFioB5wXaBeIIT(6Pb(UUO2ao6vqq3jN4gcGo8PnYr43ogyAmQT(7jS(7zv1UUZLntU(nOHqo9McYdHDbqn8YBoG97jHjLbKg8GjGoYktS43uTbhFCdo9A9ErlwYGRme0ZRRcLQEIIk5aBPZh3R)HG4DJIE(T7HGBHBOfWxCeYH62jLqxT3UC8epEcSBbK2YCKQCVIiMmCN0hkssGS)Yx3I18aBUSzJhFOMUki1iqgdLe3W2gTPq3Hc7001cZCQiTlRMP6k6L7FMVKL7243muXVfaDkzue(tPfV0VmsARj9MjvA)vmH4oHvY2Q)L21qqIYpIM5DP0nHIyIpkR7GCPdSh0cfBsZkcP2BfSlyoM6iXnPFXNujm6yWsQYePiWzN8QQAfZXlIO997Qpb8ze(wtXKkI0WMAI1GUzzvOVznP6)KyrH7Ubo7bTmnfFhaQiUvjfzzc3yoPsV2OHbHj3UICc)FrcnFmUr)tbDtzQin4tV4Kvz3o1I28R7i5sTQ4bqHH5D8I62IsW(Cc242fH)4jTmc)XtBve(58NjoBSZRYGR0UwcB6ZIYLIqP87xa)FTEFeS1fvoCqBDGCaLpJV5xt8zkCDliW1F6esFI55ZsXqXszmBSb8peom3UedwOpPZRTs2oGMqXqk9rZpheg(E8HQ3YiJt3bKYPRmZ4K4QFfpzuMthrAR(KlKzmejaYeXvZ8)O63HIsWFb4sMTI9QEm8x3BH4sZ(OeWfC3km3XzP73LRjaG7DnEuwapb1ts4aRS44hSFy4Yjdv57xvhpaXwcUZA9YjXZfYPNGBlosQIbQQyi1)y)dFGXE7eH4h6YZP6X1YnvX6IcXXI3Q4FO9UM2KmF3bTXgOJ0OHXDanPRKfgr1kJ8w(w9o4GwrAi2mKsYavT7UaWsqXCOZXDBfX4I6kZPge(O1Hz5bfDhapKoBEqkshH8NLbXR55sfKpUN5Ft4QN8DJ6pRwtqxjz6(9xRnlKH7f)raV6Zf1GU0(qftOirL4URdk4z4MOnVinD4UqenM3Oh8130kYorrJCA5kRS(65v1lQh(VdfQxtTMRtWuPkgSUTHkynpC)9B(Kx1ycxGvMF8)K4k2VfLGO5kGhEo7G5jBuMQFaYX8bqoWSMWra9luHrb0RWz8EdAzZ9hF7shfH5ctaEvLYmBzLd4HYGD6blvl3d3jl0u0yZztH(bBR5MbnKyhRYpKKITcUpAJKZRAP9qlwJ)j74StLbehz2lW00stpXDFSx8YMIyG)SczDk9qMz1qj9k0IpOGULJU2hATaUeBSxjGYmAV(DGDZNOOM1yJzpcnWgV2SA6VsqWIAApUybz(aFRcl3P9AOInvM6kfA0t)TMAMz1LWZYMaA5bBDeOZkK3v2rTM8OlLyt6f6HOIS0IVJQD)zQ(1CK1Yf2QPkTg6wdswLarIladyh12vJloiwt6NHBlj41SsMCpHxYFZ2nFCaiY8JL03svGz0Q0AuxzR8LtSjNotYSnIeyT1Rz1wVANSAHYUBjNFl6lTOP8A9a8Bz9MP6DG2hKms6yik8S1APs5iO53AjCvpiXaabcKeNyKCqAVYiQIDBaULL(5lbMiefllwCxqTjcJSaPz6M(9HiO7SdsvcjItvBr4yLWI7lQncRHUrfuV)T6lyyo060SQy26aKZIY3298If9sJpgyf(AmY1LE)JWt7KSIvoqQzM2cssRDPYmOel8CwDRM6YvQfsVYfwCyRev0YlSQhy4nj5GZQBTJpaw786cwt0qawrEDX1L9VL21u5CLaXVSn5YUnaTK45GkCciBEzDwjrKdh7kNkm9EFGrcEraep1Da5sFt03cTHW3rws)k1GTMSAFudSJf60ERCVivJSjYcTq5HpGn1td5rNPsKIiQ0bYpfoWpsuvNxRG1(0zoOLSH3Gq9AxNSBjAFTmLnOTHAmtktydbRWB1etLKPpEOQ4Y01pqPRtWd0JoUgt)2XQatZeR1bEenxdeSKt2TEzAjAEg0S5oOOtzR(A5kwvtCvckQUlxh3H4dozC0Y7zQFfPfOeUx8aQ1hRjat7uqn3V5x)xoyQIde7gvKYo7yCFKbtpk5UULmJcG9cPJwVRJ7Bfaj2tM2aFsuBMg5pgWIPc39JojhwT(kui4Qy)cPTejOV42LPnuCEcHFqlArcapKNyjxwW8401w6evvl)PfdeW8yRA3hl(0or50YHFK1Myr7jsu)MjZHoQsRKuAo9pwsurdUZtjLRWBRqYT4sLtWv7)djHHE1lNfWjw6fS(i0uFUu8KJdpmDz4wgPkjLzVNBzlxCs0lUzyN3RoSe6cbP6(wPqYQwZiXnZs1iL7PUnH)ZK0GY3se6sNropLWBuV)GKVIkL1ZOETSOokLLb4cM7rc9cvPVblhAq2RBxgKTob8wdW(60hCDcTcmxNqud7BxZSriSVm1565lZ0i0fQulZUkRPTGV38O)RXLRQ)9g5rQPgxDK2oR9AHzO6(TPTX8Yk(aiLr6anqO1Y2zAARyajK(dy92Fex58qBhjl8t2jue6wlLsH310r03M8ZqMZk9LFF6wxcF2SMpcfmd2QH18F3XJ7AlkxvxU(mqDAVFnMbUW4W6S6RE3x8JcRfEWi1E0472S31MoRCMrEHhyPzQUdkjdilt9ZiHKoijsWDQzZwPWlYXzACutWJdQowlFxJ92tCgSLpfDOEFwh5EZ6YAM9WCAgergOf8tBZinONRtABgR03qi6xvAAA7e2ndLIOrs1mOOCiaK(zAbCDRsl5)Jn8SFjkgKm3julIHBKTL9ijiXswM9QMljeQqF6CDoHsiqrQHTg2eP2dBN3yVwE6Xi6xZECwfLyPLsclrpmE6MdCdLTp8tRCjajH6gYcoDctwQIfnZ8Ls0)Ha(f4FeQkiSEwQZu7UVtwYboXHhT7l6z2GOtYS7RHYEBTfhYczoqnBycqpc9Euj3EhOr2c2GMZSTVz7c(4yZMmrJv1cP8UTuSK3k4S3yM2klEQ(t078FdK6phn)KEmkWXD4RgEp(Pk229mXpA5qKGbcsbfUkiB3dg)ldHrHT6JQULGFg0RqB6K3m801MaTj4vXjJQosiRnodFMrQ6NcvvU(jYBDeNvSYYQyPE5Qrgbwih0mN3CwU7wN)q0kzJDvw2exNlLZxFVVwkMK22ThKDFdXvgvTRbsb2ihzEXAs)ebi53U512Y3ogDRXrwmJuh9Z6N5t8SXgBodSPs7OfTe5s3A87)lTaiuk8Kx5IhcEEJvrOJqcTgrOAsjAUaNVlsPeEFsq6NIglrflR1geP82wvp54paLBwYaiqqezsHyFH776iorjipjyvCjTPQS(qp)w52aSMCcyYetbwjxz9dRLNL7KS53xvVs9pVaqhQk90pu7XwrjYyUQiQpM0FRbdd9WTm)2iUgrYi4yr3dDjaVUOFTHcPqtZKKQf1Ysw9vXWQYeFTE6J)5ny3UOvJ(ACotEKPO7fMVDmfvlFUCleO8MYyL)5NXP2YFZAog6RubuPx0yB81yB8)XGTbS0YhfBJ)3k2gZV)jF3yBq(4Mqx2mRHQD(sKWqb)ZvIfb01rUynYRBL8Md29byjda1LPAJRvPQxWkg(yCe2PKJ9U5MLTVxl(ily1y)AZTIr7jqw9bh0FeJ7AJC1dsBV6PiZSxcQAIVYQhQAI5GEb5Mi5jgPIPVjjnypyJtyhhzCW)vX(K)OBeCRYFFsR4G9ko)dfI1WxwRfTjF1Ga(ILwaiLoJINg0a2saY)p7yUsbX8vOklzrMWeABtlpOwUD8ClB5ghdlyhyBodAFZ6dFv2ixLgl5keeZan4jbE9ANAjTB6ZXCWIKrQhrXUs)p7IWKCFP314e3tM6xlhEEqIlDM7aQYKLYwGtD1oCeefCUU8lEUUw8Q5tU4CI6QTOCSzcgXW88RlFDf0P(kUSU56DubWgnCQtjUvJaQrJDyduzpl6F0zhh0HQdrud4ckY1s3Jy1kff)mpYzzF6mWfLWSl2SBaLKvNIhzC8bAUynk1XxW89rLTEnLdeLB26YX9pblNov)yRRO)mSbPRFbx9DVKwmAJBRxwjT7ZqerDGRPdtC)ggGaz0bUOED73UZIr1)B())p]] )