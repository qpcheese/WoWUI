-- DemonHunterVengeance.lua
-- July 2024

-- TODO: Support soul_fragments.total, .inactive

if UnitClassBase( "player" ) ~= "DEMONHUNTER" then return end

local addon, ns = ...
local Hekili = _G[ addon ]
local class, state = Hekili.Class, Hekili.State

local floor = math.floor
local strformat = string.format

local spec = Hekili:NewSpecialization( 581 )

spec:RegisterResource( Enum.PowerType.Fury, {
    -- Immolation Aura now grants 20 up front, 60 over 12 seconds (5 fps).
    immolation_aura = {
        aura    = "immolation_aura",

        last = function ()
            local app = state.buff.immolation_aura.applied
            local t = state.query_time

            return app + floor( t - app )
        end,

        interval = 1,
        value = 2
    },
} )

-- Talents
spec:RegisterTalents( {
    -- DemonHunter
    aldrachi_design           = { 90999, 391409, 1 }, -- Increases your chance to parry by 3%.
    aura_of_pain              = { 90933, 207347, 1 }, -- Increases the critical strike chance of Immolation Aura by 6%.
    blazing_path              = { 91008, 320416, 1 }, -- Infernal Strike gains an additional charge.
    bouncing_glaives          = { 90931, 320386, 1 }, -- Throw Glaive ricochets to 1 additional target.
    champion_of_the_glaive    = { 90994, 429211, 1 }, -- Throw Glaive has 2 charges and 10 yard increased range.
    chaos_fragments           = { 95154, 320412, 1 }, -- Each enemy stunned by Chaos Nova has a 30% chance to generate a Lesser Soul Fragment.
    chaos_nova                = { 90993, 179057, 1 }, -- Unleash an eruption of fel energy, dealing 2,574 Chaos damage and stunning all nearby enemies for 2 sec. Each enemy stunned by Chaos Nova has a 30% chance to generate a Lesser Soul Fragment.
    charred_warblades         = { 90948, 213010, 1 }, -- You heal for 4% of all Fire damage you deal.
    collective_anguish        = { 95152, 390152, 1 }, -- Fel Devastation summons an allied Havoc Demon Hunter who casts Eye Beam, dealing 24,764 Chaos damage over 1.6 sec. Deals reduced damage beyond 5 targets.
    consume_magic             = { 91006, 278326, 1 }, -- Consume 1 beneficial Magic effect removing it from the target.
    darkness                  = { 91002, 196718, 1 }, -- Summons darkness around you in an 8 yd radius, granting friendly targets a 15% chance to avoid all damage from an attack. Lasts 8 sec. Chance to avoid damage increased by 100% when not in a raid.
    demon_muzzle              = { 90928, 388111, 1 }, -- Enemies deal 8% reduced magic damage to you for 8 sec after being afflicted by one of your Sigils.
    demonic                   = { 91003, 213410, 1 }, -- Fel Devastation causes you to enter demon form for 5 sec after it finishes dealing damage.
    disrupting_fury           = { 90937, 183782, 1 }, -- Disrupt generates 30 Fury on a successful interrupt.
    erratic_felheart          = { 90996, 391397, 2 }, -- The cooldown of Infernal Strike is reduced by 10%.
    felblade                  = { 95150, 232893, 1 }, -- Charge to your target and deal 6,769 Fire damage. Shear has a chance to reset the cooldown of Felblade. Generates 40 Fury.
    felfire_haste             = { 90939, 389846, 1 }, -- Infernal Strike increases your movement speed by 10% for 8 sec.
    flames_of_fury            = { 90949, 389694, 2 }, -- Sigil of Flame deals 35% increased damage and generates 1 additional Fury per target hit.
    illidari_knowledge        = { 90935, 389696, 1 }, -- Reduces magic damage taken by 5%.
    imprison                  = { 91007, 217832, 1 }, -- Imprisons a demon, beast, or humanoid, incapacitating them for 1 min. Damage will cancel the effect. Limit 1.
    improved_disrupt          = { 90938, 320361, 1 }, -- Increases the range of Disrupt to 10 yds.
    improved_sigil_of_misery  = { 90945, 320418, 1 }, -- Reduces the cooldown of Sigil of Misery by 30 sec.
    infernal_armor            = { 91004, 320331, 2 }, -- Immolation Aura increases your armor by 20% and causes melee attackers to suffer 1,133 Fire damage.
    internal_struggle         = { 90934, 393822, 1 }, -- Increases your mastery by 3.0%.
    live_by_the_glaive        = { 95151, 428607, 1 }, -- When you parry an attack or have one of your attacks parried, restore 2% of max health and 10 Fury. This effect may only occur once every 5 sec.
    long_night                = { 91001, 389781, 1 }, -- Increases the duration of Darkness by 3 sec.
    lost_in_darkness          = { 90947, 389849, 1 }, -- Spectral Sight lasts an additional 6 sec if disrupted by attacking or taking damage.
    master_of_the_glaive      = { 90994, 389763, 1 }, -- Throw Glaive has 2 charges and snares all enemies hit by 50% for 6 sec.
    pitch_black               = { 91001, 389783, 1 }, -- Reduces the cooldown of Darkness by 120 sec.
    precise_sigils            = { 95155, 389799, 1 }, -- All Sigils are now placed at your target's location.
    pursuit                   = { 90940, 320654, 1 }, -- Mastery increases your movement speed.
    quickened_sigils          = { 95149, 209281, 1 }, -- All Sigils activate 1 second faster.
    rush_of_chaos             = { 95148, 320421, 2 }, -- Reduces the cooldown of Metamorphosis by 30 sec.
    shattered_restoration     = { 90950, 389824, 1 }, -- The healing of Shattered Souls is increased by 10%.
    sigil_of_misery           = { 90946, 207684, 1 }, -- Place a Sigil of Misery at the target location that activates after 1 sec. Causes all enemies affected by the sigil to cower in fear, disorienting them for 15 sec.
    sigil_of_spite            = { 90997, 390163, 1 }, -- Place a demonic sigil at the target location that activates after 1 sec. Detonates to deal 36,367 Chaos damage and shatter up to 3 Lesser Soul Fragments from enemies affected by the sigil. Deals reduced damage beyond 5 targets.
    soul_rending              = { 90936, 204909, 2 }, -- Leech increased by 6%. Gain an additional 6% leech while Metamorphosis is active.
    soul_sigils               = { 90929, 395446, 1 }, -- Afflicting an enemy with a Sigil generates 1 Lesser Soul Fragment.
    swallowed_anger           = { 91005, 320313, 1 }, -- Consume Magic generates 20 Fury when a beneficial Magic effect is successfully removed from the target.
    the_hunt                  = { 90927, 370965, 1 }, -- Charge to your target, striking them for 43,294 Chaos damage, rooting them in place for 1.5 sec and inflicting 37,949 Chaos damage over 6 sec to up to 5 enemies in your path. The pursuit invigorates your soul, healing you for 25% of the damage you deal to your Hunt target for 20 sec.
    unrestrained_fury         = { 90941, 320770, 1 }, -- Increases maximum Fury by 20.
    vengeful_bonds            = { 90930, 320635, 1 }, -- Vengeful Retreat reduces the movement speed of all nearby enemies by 70% for 3 sec.
    vengeful_retreat          = { 90942, 198793, 1 }, -- Remove all snares and vault away. Nearby enemies take 1,364 Physical damage.
    will_of_the_illidari      = { 91000, 389695, 1 }, -- Increases maximum health by 5%.

    -- Vengeance
    agonizing_flames          = { 90971, 207548, 1 }, -- Immolation Aura increases your movement speed by 10% and its duration is increased by 50%.
    ascending_flame           = { 90960, 428603, 1 }, -- Sigil of Flame's initial damage is increased by 50%. Multiple applications of Sigil of Flame may overlap.
    bulk_extraction           = { 90956, 320341, 1 }, -- Demolish the spirit of all those around you, dealing 3,407 Fire damage to nearby enemies and extracting up to 5 Lesser Soul Fragments, drawing them to you for immediate consumption.
    burning_alive             = { 90959, 207739, 1 }, -- Every 1 sec, Fiery Brand spreads to one nearby enemy.
    burning_blood             = { 90987, 390213, 1 }, -- Fire damage increased by 10%.
    calcified_spikes          = { 90967, 389720, 1 }, -- You take 12% reduced damage after Demon Spikes ends, fading by 1% per second.
    chains_of_anger           = { 90964, 389715, 1 }, -- Increases the duration of your Sigils by 2 sec and radius by 2 yds.
    charred_flesh             = { 90962, 336639, 2 }, -- Immolation Aura damage increases the duration of your Fiery Brand and Sigil of Flame by 0.25 sec.
    cycle_of_binding          = { 90963, 389718, 1 }, -- Afflicting an enemy with a Sigil reduces the cooldown of your Sigils by 2 sec.
    darkglare_boon            = { 90985, 389708, 1 }, -- When Fel Devastation finishes fully channeling, it refreshes 15-30% of its cooldown and refunds 15-30 Fury.
    deflecting_spikes         = { 90989, 321028, 1 }, -- Demon Spikes also increases your Parry chance by 15% for 8 sec.
    down_in_flames            = { 90961, 389732, 1 }, -- Fiery Brand has 12 sec reduced cooldown and 1 additional charge.
    extended_spikes           = { 90966, 389721, 1 }, -- Increases the duration of Demon Spikes by 2 sec.
    fallout                   = { 90972, 227174, 1 }, -- Immolation Aura's initial burst has a chance to shatter Lesser Soul Fragments from enemies.
    feast_of_souls            = { 90969, 207697, 1 }, -- Soul Cleave heals you for an additional 17,317 over 6 sec.
    feed_the_demon            = { 90983, 218612, 2 }, -- Consuming a Soul Fragment reduces the remaining cooldown of Demon Spikes by 0.25 sec.
    fel_devastation           = { 90991, 212084, 1 }, -- Unleash the fel within you, damaging enemies directly in front of you for 31,096 Fire damage over 2 sec. Causing damage also heals you for up to 60,799 health.
    fel_flame_fortification   = { 90955, 389705, 1 }, -- You take 10% reduced magic damage while Immolation Aura is active.
    fiery_brand               = { 90951, 204021, 1 }, -- Brand an enemy with a demonic symbol, instantly dealing 22,013 Fire damage and 20,446 Fire damage over 12 sec. The enemy's damage done to you is reduced by 40% for 12 sec.
    fiery_demise              = { 90958, 389220, 2 }, -- Fiery Brand also increases Fire damage you deal to the target by 25%.
    focused_cleave            = { 90975, 343207, 1 }, -- Soul Cleave deals 50% increased damage to your primary target.
    fracture                  = { 90970, 263642, 1 }, -- Rapidly slash your target for 14,513 Physical damage, and shatter 2 Lesser Soul Fragments from them. Generates 25 Fury.
    frailty                   = { 90990, 389958, 1 }, -- Enemies struck by Sigil of Flame are afflicted with Frailty for 6 sec. You heal for 8% of all damage you deal to targets with Frailty.
    illuminated_sigils        = { 90961, 428557, 1 }, -- Sigil of Flame has 5 sec reduced cooldown and 1 additional charge. You have 15% increased chance to parry attacks from enemies afflicted by your Sigil of Flame.
    last_resort               = { 90979, 209258, 1 }, -- Sustaining fatal damage instead transforms you to Metamorphosis form. This may occur once every 8 min.
    meteoric_strikes          = { 90953, 389724, 1 }, -- Reduce the cooldown of Infernal Strike by 10 sec.
    painbringer               = { 90976, 207387, 2 }, -- Consuming a Soul Fragment reduces all damage you take by 1% for 6 sec. Multiple applications may overlap.
    perfectly_balanced_glaive = { 90968, 320387, 1 }, -- Reduces the cooldown of Throw Glaive by 6 sec.
    retaliation               = { 90952, 389729, 1 }, -- While Demon Spikes is active, melee attacks against you cause the attacker to take 1,500 Physical damage. Generates high threat.
    revel_in_pain             = { 90957, 343014, 1 }, -- When Fiery Brand expires on your primary target, you gain a shield that absorbs up 81,201 damage for 15 sec, based on your damage dealt to them while Fiery Brand was active.
    roaring_fire              = { 90988, 391178, 1 }, -- Fel Devastation heals you for up to 50% more, based on your missing health.
    ruinous_bulwark           = { 90965, 326853, 1 }, -- Fel Devastation heals for an additional 10%, and 100% of its healing is converted into an absorb shield for 10 sec.
    shear_fury                = { 90970, 389997, 1 }, -- Shear generates 10 additional Fury.
    sigil_of_chains           = { 90954, 202138, 1 }, -- Place a Sigil of Chains at the target location that activates after 1 sec. All enemies affected by the sigil are pulled to its center and are snared, reducing movement speed by 70% for 6 sec.
    sigil_of_silence          = { 90988, 202137, 1 }, -- Place a Sigil of Silence at the target location that activates after 1 sec. Silences all enemies affected by the sigil for 4 sec.
    soul_barrier              = { 90956, 263648, 1 }, -- Shield yourself for 15 sec, absorbing 96,210 damage. Consumes all available Soul Fragments to add 19,242 to the shield per fragment.
    soul_carver               = { 90982, 207407, 1 }, -- Carve into the soul of your target, dealing 32,702 Fire damage and an additional 14,192 Fire damage over 3 sec. Immediately shatters 3 Lesser Soul Fragments from the target and 1 additional Lesser Soul Fragment every 1 sec.
    soul_furnace              = { 90974, 391165, 1 }, -- Every 10 Soul Fragments you consume increases the damage of your next Soul Cleave or Spirit Bomb by 40%.
    soulcrush                 = { 90980, 389985, 1 }, -- Multiple applications of Frailty may overlap. Soul Cleave applies Frailty to your primary target for 8 sec.
    soulmonger                = { 90973, 389711, 1 }, -- When consuming a Soul Fragment would heal you above full health it shields you instead, up to a maximum of 67,384.
    spirit_bomb               = { 90978, 247454, 1 }, -- Consume up to 5 available Soul Fragments then explode, damaging nearby enemies for 3,863 Fire damage per fragment consumed, and afflicting them with Frailty for 6 sec, causing you to heal for 8% of damage you deal to them. Deals reduced damage beyond 8 targets.
    stoke_the_flames          = { 90984, 393827, 1 }, -- Fel Devastation damage increased by 35%.
    void_reaver               = { 90977, 268175, 1 }, -- Frailty now also reduces all damage you take from afflicted targets by 3%. Enemies struck by Soul Cleave are afflicted with Frailty for 6 sec.
    volatile_flameblood       = { 90986, 390808, 1 }, -- Immolation Aura generates 5-10 Fury when it deals critical damage. This effect may only occur once per 1 sec.
    vulnerability             = { 90981, 389976, 2 }, -- Frailty now also increases all damage you deal to afflicted targets by 2%.

    -- Aldrachi Reaver
    aldrachi_tactics          = { 94914, 442683, 1 }, -- The second enhanced ability in a pattern shatters an additional Soul Fragment.
    army_unto_oneself         = { 94896, 442714, 1 }, -- Felblade surrounds you with a Blade Ward, reducing damage taken by 10% for 5 sec.
    art_of_the_glaive         = { 94915, 442290, 1, "aldrachi_reaver" }, -- Consuming 30 Soul Fragments or casting The Hunt converts your next Throw Glaive into Reaver's Glaive.  Reaver's Glaive: Throw a glaive enhanced with the essence of consumed souls at your target, dealing 28,863 Physical damage and ricocheting to 3 additional enemies. Begins a well-practiced pattern of glaivework, enhancing your next Fracture and Soul Cleave. The enhanced ability you cast first deals 10% increased damage, and the second deals 20% increased damage.
    evasive_action            = { 94911, 444926, 1 }, -- Vengeful Retreat can be cast a second time within 3 sec.
    fury_of_the_aldrachi      = { 94898, 442718, 1 }, -- When enhanced by Reaver's Glaive, Soul Cleave casts 3 additional glaive slashes to nearby targets. If cast after Fracture, cast 6 slashes instead.
    incisive_blade            = { 94895, 442492, 1 }, -- Soul Cleave deals 15% increased damage.
    incorruptible_spirit      = { 94896, 442736, 1 }, -- Consuming a Soul Fragment also heals you for an additional 15% over time.
    keen_engagement           = { 94910, 442497, 1 }, -- Reaver's Glaive generates 20 Fury.
    preemptive_strike         = { 94910, 444997, 1 }, -- Throw Glaive deals 3,004 damage to enemies near its initial target.
    reavers_mark              = { 94903, 442679, 1 }, -- When enhanced by Reaver's Glaive, Fracture applies Reaver's Mark, which causes the target to take 12% increased damage for 20 sec. If cast after Soul Cleave, Reaver's Mark is increased to 24%.
    thrill_of_the_fight       = { 94919, 442686, 1 }, -- After consuming both enhancements, gain Thrill of the Fight, increasing your attack speed by 15% for 20 sec and your damage and healing by 20% for 10 sec.
    unhindered_assault        = { 94911, 444931, 1 }, -- Vengeful Retreat resets the cooldown of Felblade.
    warblades_hunger          = { 94906, 442502, 1 }, -- Consuming a Soul Fragment causes your next Fracture to deal 1,924 additional damage.
    wounded_quarry            = { 94897, 442806, 1 }, -- While Reaver's Mark is on your target, melee attacks strike with an additional glaive slash for 962 Physical damage and have a chance to shatter a soul.

    -- Fel-Scarred
    burning_blades            = { 94905, 452408, 1 }, -- Your blades burn with Fel energy, causing your Soul Cleave, Throw Glaive, and auto-attacks to deal an additional 10% damage as Fire over 6 sec.
    demonic_intensity         = { 94901, 452415, 1 }, -- Activating Metamorphosis greatly empowers Fel Devastation, Immolation Aura, and Sigil of Flame. Demonsurge damage is increased by 10% for each time it previously triggered while your demon form is active.
    demonsurge                = { 94917, 452402, 1, "felscarred" }, -- Metamorphosis now also greatly empowers Soul Cleave and Spirit Bomb. While demon form is active, the first cast of each empowered ability induces a Demonsurge, causing you to explode with Fel energy, dealing 10,583 Fire damage to nearby enemies.
    enduring_torment          = { 94916, 452410, 1 }, -- The effects of your demon form persist outside of it in a weakened state, increasing maximum health by 5% and Armor by 20%.
    flamebound                = { 94902, 452413, 1 }, -- Immolation Aura has 2 yd increased radius and 30% increased critical strike damage bonus.
    focused_hatred            = { 94918, 452405, 1 }, -- Demonsurge deals 35% increased damage when it strikes a single target.
    improved_soul_rending     = { 94899, 452407, 1 }, -- Leech granted by Soul Rending increased by 2% and an additional 2% while Metamorphosis is active.
    monster_rising            = { 94909, 452414, 1 }, -- Agility increased by 5% while not in demon form.
    pursuit_of_angriness      = { 94913, 452404, 1 }, -- Movement speed increased by 1% per 10 Fury.
    set_fire_to_the_pain      = { 94899, 452406, 1 }, -- 5% of all non-Fire damage taken is instead taken as Fire damage over 6 sec. Fire damage taken reduced by 10%.
    student_of_suffering      = { 94902, 452412, 1 }, -- Sigil of Flame applies Student of Suffering to you, increasing Mastery by 12.0% and granting 5 Fury every 2 sec, for 8 sec.
    untethered_fury           = { 94904, 452411, 1 }, -- Maximum Fury increased by 50.
    violent_transformation    = { 94912, 452409, 1 }, -- When you activate Metamorphosis, the cooldowns of your Sigil of Flame and Fel Devastation are immediately reset.
    wave_of_debilitation      = { 94913, 452403, 1 }, -- Chaos Nova slows enemies by 60% and reduces attack and cast speed 15% for 5 sec after its stun fades.
} )


-- PvP Talents
spec:RegisterPvpTalents( {
    blood_moon        = 5434, -- (355995) Consume Magic now affects all enemies within 8 yards of the target and generates a Lesser Soul Fragment. Each effect consumed has a 5% chance to upgrade to a Greater Soul.
    chaotic_imprint   = 5439, -- (356510) Throw Glaive now deals damage from a random school of magic, and increases the target's damage taken from the school by 10% for 20 sec.
    cleansed_by_flame =  814, -- (205625) Immolation Aura dispels a magical effect on you when cast.
    cover_of_darkness = 5520, -- (357419) The radius of Darkness is increased by 4 yds, and its duration by 2 sec.
    demonic_trample   = 3423, -- (205629) Transform to demon form, moving at 175% increased speed for 3 sec, knocking down all enemies in your path and dealing 1003.7 Physical damage. During Demonic Trample you are unaffected by snares but cannot cast spells or use your normal attacks. Shares charges with Infernal Strike.
    detainment        = 3430, -- (205596) Imprison's PvP duration is increased by 1 sec, and targets become immune to damage and healing while imprisoned.
    everlasting_hunt  =  815, -- (205626) Dealing damage increases your movement speed by 15% for 3 sec.
    glimpse           = 5522, -- (354489) Vengeful Retreat provides immunity to loss of control effects, and reduces damage taken by 35% until you land.
    illidans_grasp    =  819, -- (205630) You strangle the target with demonic magic, stunning them in place and dealing 67,347 Shadow damage over 5 sec while the target is grasped. Can move while channeling. Use Illidan's Grasp again to toss the target to a location within 40 yards, stunning them and all nearby enemies for 3 sec and dealing 20,011 Shadow damage.
    jagged_spikes     =  816, -- (205627) While Demon Spikes is active, melee attacks against you cause Physical damage equal to 30% of the damage taken back to the attacker.
    rain_from_above   = 5521, -- (206803) You fly into the air out of harm's way. While floating, you gain access to Fel Lance allowing you to deal damage to enemies below.
    reverse_magic     = 3429, -- (205604) Removes all harmful magical effects from yourself and all nearby allies within 10 yards, and sends them back to their original caster if possible.
    sigil_mastery     = 1948, -- (211489) Reduces the cooldown of your Sigils by an additional 25%.
    tormentor         = 1220, -- (207029) You focus the assault on this target, increasing their damage taken by 3% for 6 sec. Each unique player that attacks the target increases the damage taken by an additional 3%, stacking up to 5 times. Your melee attacks refresh the duration of Focused Assault.
    unending_hatred   = 3727, -- (213480) Taking damage causes you to gain Fury based on the damage dealt.
} )


-- Auras
spec:RegisterAuras( {
    -- $w1 Soul Fragments consumed. At $?a212612[$442290s1~][$442290s2~], Reaver's Glaive is available to cast.
    art_of_the_glaive = {
        id = 444661,
        duration = 30.0,
        max_stack = 30,
    },
    -- Damage taken reduced by $s1%.
    blade_ward = {
        id = 442715,
        duration = 5.0,
        max_stack = 1,
    },
    -- Versatility increased by $w1%.
    -- https://wowhead.com/beta/spell=355894
    blind_faith = {
        id = 355894,
        duration = 20,
        max_stack = 1
    },
    -- Taking $w1 Chaos damage every $t1 seconds.  Damage taken from $@auracaster's Immolation Aura increased by $s2%.
    -- https://wowhead.com/beta/spell=391191
    burning_wound = {
        id = 391191,
        duration = 15,
        tick_time = 3,
        max_stack = 1
    },
    calcified_spikes = {
        id = 391171,
        duration = 12,
        max_stack = 1
    },
    -- Talent: Stunned.
    -- https://wowhead.com/beta/spell=179057
    chaos_nova = {
        id = 179057,
        duration = 2,
        type = "Magic",
        max_stack = 1
    },
    -- Talent:
    -- https://wowhead.com/beta/spell=196718
    darkness = {
        id = 196718,
        duration = function() return ( talent.long_night.enabled and 11 or 8 ) + ( talent.cover_of_darkness.enabled and 2 or 0 ) end,
        max_stack = 1
    },
    demon_soul = {
        id = 347765,
        duration = 15,
        max_stack = 1,
    },
    -- Armor increased by ${$W2*$AGI/100}.$?s321028[  Parry chance increased by $w1%.][]
    -- https://wowhead.com/beta/spell=203819
    demon_spikes = {
        id = 203819,
        duration = function() return 6 + talent.extended_spikes.rank end,
        max_stack = 1
    },
    demonsurge_hardcast = {
        id = 452489,
    },
    demonsurge_spirit_burst = {
    },
    demonsurge_soul_sunder = {

    },
    demonsurge_fel_desolation = {

    },
    demonsurge_consuming_fire = {

    },
    demonsurge_sigil_of_doom = {

    },

    -- Vengeful Retreat may be cast again.
    evasive_action = {
        id = 444929,
        duration = 3.0,
        max_stack = 1,
    },
    feast_of_souls = {
        id = 207693,
        duration = 6,
        max_stack = 1
    },
    -- Talent:
    -- https://wowhead.com/beta/spell=212084
    fel_devastation = {
        id = 212084,
        duration = 2,
        tick_time = 0.2,
        max_stack = 1
    },
    fel_flame_fortification = {
        id = 337546,
        duration = function () return class.auras.immolation_aura.duration end,
        max_stack = 1
    },
    -- Talent: Movement speed increased by $w1%.
    -- https://wowhead.com/beta/spell=389847
    felfire_haste = {
        id = 389847,
        duration = 8,
        max_stack = 1
    },
    -- Talent: Branded, taking $w3 Fire damage every $t3 sec, and dealing $204021s1% less damage to $@auracaster$?s389220[ and taking $w2% more Fire damage from them][].
    -- https://wowhead.com/beta/spell=207744
    fiery_brand = {
        id = 207771,
        duration = 12,
        type = "Magic",
        max_stack = 1,
        copy = "fiery_brand_dot"
    },
    -- Talent: Battling a demon from the Theater of Pain...
    -- https://wowhead.com/beta/spell=391430
    fodder_to_the_flame = {
        id = 391430,
        duration = 25,
        max_stack = 1,
        copy = 329554
    },
    -- Talent: $@auracaster is healed for $w1% of all damage they deal to you.$?$w3!=0[  Dealing $w3% reduced damage to $@auracaster.][]$?$w4!=0[  Suffering $w4% increased damage from $@auracaster.][]
    -- https://wowhead.com/beta/spell=247456
    frailty = {
        id = 247456,
        duration = 5,
        tick_time = 1,
        type = "Magic",
        max_stack = 1
    },
    glaive_flurry = {
        id = 442435,
        duration = 30,
        max_stack = 1
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
    immolation_aura = {
        id = 258920,
        duration = function () return talent.agonizing_flames.enabled and 9 or 6 end,
        tick_time = 1,
        max_stack = 1
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
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=213405
    master_of_the_glaive = {
        id = 213405,
        duration = 6,
        mechanic = "snare",
        max_stack = 1
    },
    -- Maximum health increased by $w2%.  Armor increased by $w8%.  $?s235893[Versatility increased by $w5%. ][]$?s263642[Fracture][Shear] generates $w4 additional Fury and one additional Lesser Soul Fragment.
    -- https://wowhead.com/beta/spell=187827
    metamorphosis = {
        id = 187827,
        duration = 15,
        max_stack = 1
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
    -- Agility increased by $w1%.
    monster_rising = {
        id = 452550,
        duration = 3600,
        max_stack = 1
    },
    painbringer = {
        id = 212988,
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
    reavers_glaive = {
        id = 444764,
        duration = 15,
        max_stack = 2
    },
    reavers_mark = {
        id = 442624,
        duration = 20,
        max_stack = 1
    },
    rending_strike = {
        id = 442442,
        duration = 30,
        max_stack = 1
    },
    ruinous_bulwark = {
        id = 326863,
        duration = 10,
        max_stack = 1
    },
    -- Taking $w1 Fire damage every $t1 sec.
    set_fire_to_the_pain = {
        id = 453286,
        duration = 6.0,
        tick_time = 1.0,
        max_stack = 1,
    },
    -- Talent: Movement slowed by $s1%.
    -- https://wowhead.com/beta/spell=204843
    sigil_of_chains = {
        id = 204843,
        duration = function () return 6 + ( 2 * talent.chains_of_anger.rank ) end,
        type = "Magic",
        max_stack = 1
    },
    sigil_of_doom = {
        id = 462030,
        duration = 8,
        max_stack = 1
    },
    sigil_of_doom_active = {
        id = 452490,
        duration = 2,
        max_stack = 1
    },
    -- Talent: Sigil of Flame is active.
    -- https://wowhead.com/beta/spell=204596
    sigil_of_flame_active = {
        id = 204596,
        duration = 2,
        max_stack = 1,
        copy = 389810
    },
    -- Talent: Suffering $w2 $@spelldesc395020 damage every $t2 sec.
    -- https://wowhead.com/beta/spell=204598
    sigil_of_flame = {
        id = 204598,
        duration = function () return 6 + ( 2 * talent.chains_of_anger.rank ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Disoriented.
    -- https://wowhead.com/beta/spell=207685
    sigil_of_misery_debuff = {
        id = 207685,
        duration = function () return 15 + ( 2 * talent.chains_of_anger.rank ) end,
        mechanic = "flee",
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Silenced.
    -- https://wowhead.com/beta/spell=204490
    sigil_of_silence = {
        id = 204490,
        duration = function () return 4 + ( 2 * talent.chains_of_anger.rank ) end,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Absorbs $w1 damage.
    -- https://wowhead.com/beta/spell=263648
    soul_barrier = {
        id = 263648,
        duration = 15,
        type = "Magic",
        max_stack = 1
    },
    -- Talent: Suffering $s1 Fire damage every $t1 sec.
    -- TODO: Trigger more Lesser Soul Fragments...
    -- https://wowhead.com/beta/spell=207407
    soul_carver = {
        id = 207407,
        duration = 3,
        tick_time = 1,
        max_stack = 1
    },
    -- Consume to heal for $210042s1% of your maximum health.
    -- https://wowhead.com/beta/spell=203795
    soul_fragment = {
        id = 203795,
        duration = 20,
        max_stack = 5
    },
    soul_fragments = {
        id = 203981,
        duration = 3600,
        max_stack = 5,
    },
    -- Talent: $w1 Soul Fragments consumed. At $u, the damage of your next Soul Cleave is increased by $391172s1%.
    -- https://wowhead.com/beta/spell=391166
    soul_furnace_stack = {
        id = 391166,
        duration = 30,
        max_stack = 10,
        copy = 339424
    },
    soul_furnace = {
        id = 391172,
        duration = 30,
        max_stack = 1,
        copy = "soul_furnace_damage_amp"
    },
    -- Suffering $w1 Chaos damage every $t1 sec.
    -- https://wowhead.com/beta/spell=390181
    soulrend = {
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
    -- Talent:
    -- https://wowhead.com/beta/spell=247454
    spirit_bomb = {
        id = 247454,
        duration = 1.5,
        max_stack = 1
    },
    spirit_of_the_darkness_flame = {
        id = 337542,
        duration = 3600,
        max_stack = 15
    },
    -- Mastery increased by ${$w1*$mas}.1%. ; Generating $453236s1 Fury every $t2 sec.
    student_of_suffering = {
        id = 453239,
        duration = 8.0,
        max_stack = 1,
    },
    -- Talent: Suffering $w1 $@spelldesc395042 damage every $t1 sec.
    -- https://wowhead.com/beta/spell=345335
    the_hunt_dot = {
        id = 370969,
        duration = 6,
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
        copy = "thrill_of_the_fight_attack_speed"
    },
    thrill_of_the_fight_damage = {
        id = 442688,
        duration = 10,
        max_stack = 1
    },
    -- Taunted.
    -- https://wowhead.com/beta/spell=185245
    torment = {
        id = 185245,
        duration = 3,
        max_stack = 1
    },
    -- Talent: Movement speed reduced by $s1%.
    -- https://wowhead.com/beta/spell=198813
    vengeful_retreat = {
        id = 198813,
        duration = 3,
        max_stack = 1
    },
    void_reaver = {
        id = 268178,
        duration = 12,
        max_stack = 1,
    },
    -- Your next $?a212612[Chaos Strike]?s263642[Fracture][Shear] will deal $442507s1 additional Physical damage.
    warblades_hunger = {
        id = 442503,
        duration = 30.0,
        max_stack = 1,
    },

    -- PvP Talents
    demonic_trample = {
        id = 205629,
        duration = 3,
        max_stack = 1,
    },
    everlasting_hunt = {
        id = 208769,
        duration = 3,
        max_stack = 1,
    },
    focused_assault = { -- Tormentor.
        id = 206891,
        duration = 6,
        max_stack = 5,
    },
    illidans_grasp = {
        id = 205630,
        duration = 6,
        type = "Magic",
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

    if sigil ~= "spite" then
        local effect = "sigil_of_" .. sigil
        applyDebuff( "target", effect )
        debuff[ effect ].applied = debuff[ effect ].applied + 1
        debuff[ effect ].expires = debuff[ effect ].expires + 1
    end
end )

spec:RegisterStateExpr( "soul_fragments", function ()
    return buff.soul_fragments.stack
end )

spec:RegisterStateExpr( "last_metamorphosis", function ()
    return action.metamorphosis.lastCast
end )

spec:RegisterStateExpr( "last_infernal_strike", function ()
    return action.infernal_strike.lastCast
end )


local activation_time = function ()
    return talent.quickened_sigils.enabled and 1 or 2
end

spec:RegisterStateExpr( "activation_time", activation_time )

local sigil_placed = function ()
    return sigils.flame > query_time
end

spec:RegisterStateExpr( "sigil_placed", sigil_placed )
-- Also add to infernal_strike, sigil_of_flame.

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


-- Variable to track the total bonus timed earned on fiery brand from immolation aura.
local bonus_time_from_immo_aura = 0
-- Variable to track the GUID of the initial target
local initial_fiery_brand_guid = ""

spec:RegisterHook( "COMBAT_LOG_EVENT_UNFILTERED", function( _ , subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, destFlags, _, spellID, spellName )
    if sourceGUID ~= GUID then return end

    if talent.charred_flesh.enabled and subtype == "SPELL_DAMAGE" and spellID == 258922 and destGUID == initial_fiery_brand_guid then
        bonus_time_from_immo_aura = bonus_time_from_immo_aura + ( 0.25 * talent.charred_flesh.rank )

    elseif subtype == "SPELL_CAST_SUCCESS" then
        if talent.charred_flesh.enabled and spellID == 204021 then
            bonus_time_from_immo_aura = 0
            initial_fiery_brand_guid = destGUID
        end

        -- Fracture:  Generate 2 frags.
        if spellID == 263642 then
            queue_fragments( 2 )
        end

        -- Shear:  Generate 1 frag.
        if spellID == 203782 then
            queue_fragments( 1 )
        end

        -- We consumed or generated a fragment for real, so let's purge the real queue.
    elseif spellID == 203981 and fragments.real > 0 and ( subtype == "SPELL_AURA_APPLIED" or subtype == "SPELL_AURA_APPLIED_DOSE" ) then
        fragments.real = fragments.real - 1

    end
end, false )


local sigil_types = { "chains", "flame", "misery", "silence" }

spec:RegisterHook( "reset_precast", function ()
    last_metamorphosis = nil
    last_infernal_strike = nil

    for i, sigil in ipairs( sigil_types ) do
        local activation = ( action[ "sigil_of_" .. sigil ].lastCast or 0 ) + ( talent.quickened_sigils.enabled and 2 or 1 )
        local time_to_proc = activation - query_time
        if time_to_proc > 0 then
            local effect = "sigil_of_" .. sigil

            sigils[ sigil ] = activation
            applyDebuff( "target", effect )
            debuff[ effect ].applied = activation
            debuff[ effect ].expires = debuff[ effect ].expires + time_to_proc
        else sigils[ sigil ] = 0 end
    end

    if action.elysian_decree.known then
        local activation = ( action.elysian_decree.lastCast or 0 ) + ( talent.quickened_sigils.enabled and 2 or 1 )
        local time_to_proc = activation - query_time
        if time_to_proc > 0 then
            sigils.elysian_decree = activation
            applyDebuff( "target", "elysian_decree" )
            debuff.elysian_decree.applied = activation
            debuff.elysian_decree.expires = debuff.elysian_decree.expires + time_to_proc
        else sigils.elysian_decree = 0 end
    else
        sigils.elysian_decree = 0
    end

    if talent.abyssal_strike.enabled then
        -- Infernal Strike is also a trigger for Sigil of Flame.
        local activation = ( action.infernal_strike.lastCast or 0 ) + ( talent.quickened_sigils.enabled and 2 or 1 )
        if activation > now and activation > sigils[ sigil ] then sigils.flame = activation end
    end

    if fragments.realTime > 0 and fragments.realTime < now then
        fragments.real = 0
        fragments.realTime = 0
    end

    if buff.demonic_trample.up then
        setCooldown( "global_cooldown", max( cooldown.global_cooldown.remains, buff.demonic_trample.remains ) )
    end

    if buff.illidans_grasp.up then
        setCooldown( "illidans_grasp", 0 )
    end

    if buff.soul_fragments.down then
        -- Apply the buff with zero stacks.
        applyBuff( "soul_fragments", nil, 0 + fragments.real )
    elseif fragments.real > 0 then
        addStack( "soul_fragments", nil, fragments.real )
    end

    if IsActiveSpell( 442294 ) then applyBuff( "reavers_glaive" ) end

    fiery_brand_dot_primary_expires = nil
    fury_spent = nil
end )


spec:RegisterHook( "spend", function( amt, resource )
    if set_bonus.tier31_4pc == 0 or amt < 0 or resource ~= "fury" then return end

    fury_spent = fury_spent + amt
    if fury_spent > 40 then
        reduceCooldown( "sigil_of_flame", floor( fury_spent / 40 ) )
        fury_spent = fury_spent % 40
    end
end )


spec:RegisterHook( "advance_end", function( time )
    if query_time - time < sigils.flame and query_time >= sigils.flame then
        -- SoF should've applied.
        applyDebuff( "target", "sigil_of_flame", debuff.sigil_of_flame.duration - ( query_time - sigils.flame ) )
        active_dot.sigil_of_flame = active_enemies
        if talent.frailty.enabled then
            applyDebuff( "target", "frailty", 6 - ( query_time - sigils.flame ), debuff.frailty.stack + 1 )
            active_dot.frailty = active_enemies
        end
        sigils.flame = 0
    end
end )


-- approach that actually calculated time remaining of fiery_brand via combat log. last modified 1/27/2023.
spec:RegisterStateExpr( "fiery_brand_dot_primary_expires", function()
    return action.fiery_brand.lastCast + bonus_time_from_immo_aura + class.auras.fiery_brand.duration
end )

spec:RegisterStateExpr( "fiery_brand_dot_primary_remains", function()
    return max( 0, fiery_brand_dot_primary_expires - query_time )
end )

spec:RegisterStateExpr( "fiery_brand_dot_primary_ticking", function()
    return fiery_brand_dot_primary_remains > 0
end )


-- Incoming Souls calculation added to APL in August 2023.
spec:RegisterVariable( "incoming_souls", function()
    -- actions+=/variable,name=incoming_souls,op=reset
    local souls = 0
    
    -- actions+=/variable,name=incoming_souls,op=add,value=2,if=prev_gcd.1.fracture&!buff.metamorphosis.up
    if action.fracture.time_since < ( 0.25 + gcd.max ) and not buff.metamorphosis.up then souls = souls + 2 end

    -- actions+=/variable,name=incoming_souls,op=add,value=3,if=prev_gcd.1.fracture&buff.metamorphosis.up
    if action.fracture.time_since < ( 0.25 + gcd.max ) and buff.metamorphosis.up then souls = souls + 3 end

    -- actions+=/variable,name=incoming_souls,op=add,value=2,if=talent.soul_sigils&(prev_gcd.2.sigil_of_flame|prev_gcd.2.sigil_of_silence|prev_gcd.2.sigil_of_chains|prev_gcd.2.elysian_decree)
    if talent.soul_sigils.enabled and ( ( action.sigil_of_flame.time_since < ( 0.25 + 2 * gcd.max ) and action.sigil_of_flame.time_since > gcd.max ) or
        ( action.sigil_of_silence.time_since < ( 0.25 + 2 * gcd.max ) and action.sigil_of_silence.time_since > gcd.max ) or
        ( action.sigil_of_chains.time_since  < ( 0.25 + 2 * gcd.max ) and action.sigil_of_chains.time_since  > gcd.max ) or
        ( action.elysian_decree.time_since   < ( 0.25 + 2 * gcd.max ) and action.elysian_decree.time_since   > gcd.max ) ) then
        souls = souls + 2
    end

    -- actions+=/variable,name=incoming_souls,op=add,value=active_enemies>?3,if=talent.elysian_decree&prev_gcd.2.elysian_decree
    if talent.elysian_decree.enabled and ( action.elysian_decree.time_since < ( 0.25 + 2 * gcd.max ) and action.elysian_decree.time_since > gcd.max ) then
        souls = souls + min( 3, active_enemies )
    end

    -- actions+=/variable,name=incoming_souls,op=add,value=0.6*active_enemies>?5,if=talent.fallout&prev_gcd.1.immolation_aura
    if talent.fallout.enabled and action.immolation_aura.time_since < ( 0.25 + gcd.max ) then souls = souls + ( 0.6 * min( 5, active_enemies ) ) end

    -- actions+=/variable,name=incoming_souls,op=add,value=active_enemies>?5,if=talent.bulk_extraction&prev_gcd.1.bulk_extraction
    if talent.bulk_extraction.enabled and action.bulk_extraction.time_since < ( 0.25 + gcd.max ) then souls = souls + min( 5, active_enemies ) end

    -- actions+=/variable,name=incoming_souls,op=add,value=3-(cooldown.soul_carver.duration-ceil(cooldown.soul_carver.remains)),if=talent.soul_carver&cooldown.soul_carver.remains>57
    if talent.soul_carver.enabled and cooldown.soul_carver.true_remains > 57 then souls = souls + ( 3 - ( cooldown.soul_carver.duration - ceil( cooldown.soul_carver.remains ) ) ) end

    return souls
end )






-- Gear Sets
spec:RegisterGear( "tier29", 200345, 200347, 200342, 200344, 200346 )
spec:RegisterAura( "decrepit_souls", {
    id = 394958,
    duration = 8,
    max_stack = 1
} )

-- Tier 30
spec:RegisterGear( "tier30", 202527, 202525, 202524, 202523, 202522 )
-- 2 pieces (Vengeance) : Soul Fragments heal for 10% more and generating a Soul Fragment increases your Fire damage by 2% for 6 sec. Multiple applications may overlap.
-- TODO: Track each application to keep count for Recrimination.
spec:RegisterAura( "fires_of_fel", {
    id = 409645,
    duration = 6,
    max_stack = 1
} )
-- 4 pieces (Vengeance) : Shear and Fracture deal Fire damage, and after consuming 20 Soul Fragments, your next cast of Shear or Fracture will apply Fiery Brand for 6 sec to its target.
spec:RegisterAura( "recrimination", {
    id = 409877,
    duration = 30,
    max_stack = 1
} )

spec:RegisterGear( "tier31", 207261, 207262, 207263, 207264, 207266, 217228, 217230, 217226, 217227, 217229 )
-- (2) When you attack a target afflicted by Sigil of Flame, your damage and healing are increased by 2% and your Stamina is increased by 2% for 8 sec, stacking up to 5.
-- (4) Sigil of Flame's periodic damage has a chance to flare up, shattering an additional Soul Fragment from a target and dealing $425672s1 additional damage. Each $s1 Fury you spend reduces its cooldown by ${$s2/1000}.1 sec.
spec:RegisterAura( "fiery_resolve", {
    id = 425653,
    duration = 8,
    max_stack = 5
} )


local furySpent = 0

local FURY = Enum.PowerType.Fury
local lastFury = -1

spec:RegisterUnitEvent( "UNIT_POWER_FREQUENT", "player", nil, function( event, unit, powerType )
    if powerType == "FURY" and state.set_bonus.tier31_4pc > 0 then
        local current = UnitPower( "player", FURY )

        if current < lastFury - 3 then
            furySpent = ( furySpent + lastFury - current )
        end

        lastFury = current
    end
end )

spec:RegisterStateExpr( "fury_spent", function ()
    if set_bonus.tier31_4pc == 0 then return 0 end
    return furySpent
end )


spec:RegisterGear( "tier19", 138375, 138376, 138377, 138378, 138379, 138380 )
spec:RegisterGear( "tier20", 147130, 147132, 147128, 147127, 147129, 147131 )
spec:RegisterGear( "tier21", 152121, 152123, 152119, 152118, 152120, 152122 )
spec:RegisterGear( "class", 139715, 139716, 139717, 139718, 139719, 139720, 139721, 139722 )

spec:RegisterGear( "convergence_of_fates", 140806 )


-- Abilities
spec:RegisterAbilities( {
    -- Talent: Demolish the spirit of all those around you, dealing $s1 Fire damage to nearby enemies and extracting up to $s2 Lesser Soul Fragments, drawing them to you for immediate consumption.
    bulk_extraction = {
        id = 320341,
        cast = 0,
        cooldown = 60,
        gcd = "spell",
        school = "fire",

        talent = "bulk_extraction",
        startsCombat = true,

        toggle = "cooldowns",

        handler = function ()
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

        handler = function ()
            applyDebuff( "target", "chaos_nova" )
        end,
    },

    -- Talent: Consume $m1 beneficial Magic effect removing it from the target$?s320313[ and granting you $s2 Fury][].
    consume_magic = {
        id = 278326,
        cast = 0,
        cooldown = 10,
        gcd = "spell",
        school = "chromatic",

        talent = "consume_magic",
        startsCombat = false,

        toggle = "interrupts",
        buff = "dispellable_magic",

        handler = function ()
            removeBuff( "dispellable_magic" )
            if talent.swallowed_anger.enabled then gain( 20, "fury" ) end
        end,
    },

    -- Summons darkness around you in a$?a357419[ 12 yd][n 8 yd] radius, granting friendly targets a $209426s2% chance to avoid all damage from an attack. Lasts $d.; Chance to avoid damage increased by $s3% when not in a raid.
    darkness = {
        id = 196718,
        cast = 0,
        cooldown = function() return talent.pitch_black.enabled and 180 or 300 end,
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

    -- Surge with fel power, increasing your Armor by ${$203819s2*$AGI/100}$?s321028[, and your Parry chance by $203819s1%, for $203819d][].
    demon_spikes = {
        id = 203720,
        cast = 0,
        charges = 2,
        cooldown = 20,
        recharge = 20,
        icd = 1.5,
        gcd = "off",
        school = "physical",

        startsCombat = false,

        toggle = "defensives",
        defensive = true,

        handler = function ()
            applyBuff( "demon_spikes", buff.demon_spikes.remains + buff.demon_spikes.duration )
        end,
    },


    demonic_trample = {
        id = 205629,
        cast = 0,
        charges = 2,
        cooldown = 12,
        recharge = 12,
        gcd = "spell",
        icd = 0.8,

        pvptalent = "demonic_trample",
        nobuff = "demonic_trample",

        startsCombat = false,
        texture = 134294,
        nodebuff = "rooted",

        handler = function ()
            spendCharges( "infernal_strike", 1 )
            setCooldown( "global_cooldown", 3 )
            applyBuff( "demonic_trample" )
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
        interrupt = true,

        debuff = "casting",
        readyTime = state.timeToInterrupt,

        handler = function ()
            if talent.disrupting_fury.enabled then gain( 30, "fury" ) end
            interrupt()
        end,
    },

    -- Talent: Unleash the fel within you, damaging enemies directly in front of you for ${$212105s1*(2/$t1)} Fire damage over $d.$?s320639[ Causing damage also heals you for up to ${$212106s1*(2/$t1)} health.][]
    fel_devastation = {
		id = function ()
			if talent.demonic_intensity.enabled and buff.metamorphosis.up then return 452486 end
			return 212084
		end,
        cast = 0,
        channeled = true,
        cooldown = 40,
        fixedCast = true,
        gcd = "spell",
        school = "fire",

        spend = 50,
        spendType = "fury",

        talent = "fel_devastation",
        startsCombat = true,

        start = function ()
            applyBuff( "fel_devastation" )

            -- This is likely repeated per tick but it's not worth the CPU overhead to model each tick.
            if legendary.agony_gaze.enabled and debuff.sinful_brand.up then
                debuff.sinful_brand.expires = debuff.sinful_brand.expires + 0.75
            end
        end,

        finish = function ()
            if talent.demonic.enabled then applyBuff( "metamorphosis", 6 ) end
            if talent.ruinous_bulwark.enabled then applyBuff( "ruinous_bulwark" ) end
            if talent.darkglare_boon.enabled then
                gain( 15, "fury" )
                reduceCooldown( "fel_devastation", 6 )
            end
        end,

        copy = { "fel_desolation", 452486, 212084 }
    },

    -- Talent: Charge to your target and deal $213243sw2 $@spelldesc395020 damage.    $?s203513[Shear has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]?a203555[Demon Blades has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r][Demon's Bite has a chance to reset the cooldown of Felblade.    |cFFFFFFFFGenerates $213243s3 Fury.|r]
    felblade = {
        id = 232893,
        cast = 0,
        cooldown = 15,
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

    -- Talent: Brand an enemy with a demonic symbol, instantly dealing $sw2 Fire damage$?s320962[ and ${$207771s3*$207744d} Fire damage over $207744d][]. The enemy's damage done to you is reduced by $s1% for $207744d.
    fiery_brand = {
        id = 204021,
        cast = 0,
        charges = function() return talent.down_in_flames.enabled and 2 or nil end,
        cooldown = function() return ( talent.down_in_flames.enabled and 48 or 60 ) + ( conduit.fel_defender.mod * 0.001 ) end,
        recharge = function() return talent.down_in_flames.enabled and ( 48 + ( conduit.fel_defender.mod * 0.001 ) ) or nil end,
        gcd = "spell",
        school = "fire",

        talent = "fiery_brand",
        startsCombat = true,

        readyTime = function ()
            if ( settings.brand_charges or 1 ) == 0 then return end
            return ( ( 1 + ( settings.brand_charges or 1 ) ) - cooldown.fiery_brand.charges_fractional ) * cooldown.fiery_brand.recharge
        end,

        handler = function ()
            applyDebuff( "target", "fiery_brand_dot" )
            fiery_brand_dot_primary_expires = query_time + class.auras.fiery_brand.duration
            removeBuff( "spirit_of_the_darkness_flame" )

            if talent.charred_flesh.enabled then applyBuff( "charred_flesh" ) end
        end,
    },

    -- Talent: Rapidly slash your target for ${$225919sw1+$225921sw1} Physical damage, and shatter $s1 Lesser Soul Fragments from them.    |cFFFFFFFFGenerates $s4 Fury.|r
    fracture = {
        id = 263642,
        cast = 0,
        charges = 2,
        cooldown = 4.5,
        recharge = 4.5,
        hasteCD = true,
        gcd = "spell",
        school = "physical",

        spend = function() return ( buff.metamorphosis.up and -45 or -25 ) * ( set_bonus.tier29_2pc > 0 and 1.2 or 1 ) end,
        spendType = "fury",

        talent = "fracture",
        bind = "shear",
        startsCombat = true,

        handler = function ()
            if buff.rending_strike.up then
                applyDebuff( "target", "reavers_mark" )
                removeBuff( "rending_strike" )
            end
            if buff.recrimination.up then
                applyDebuff( "target", "fiery_brand", 6 )
                removeBuff( "recrimination" )
            end
            addStack( "soul_fragments", nil, buff.metamorphosis.up and 3 or 2 )
        end,
    },


    illidans_grasp = {
        id = function () return debuff.illidans_grasp.up and 208173 or 205630 end,
        known = 205630,
        cast = 0,
        channeled = true,
        cooldown = function () return buff.illidans_grasp.up and ( 54 + buff.illidans_grasp.remains ) or 0 end,
        gcd = "off",

        pvptalent = "illidans_grasp",
        aura = "illidans_grasp",
        breakable = true,

        startsCombat = true,
        texture = function () return buff.illidans_grasp.up and 252175 or 1380367 end,

        start = function ()
            if buff.illidans_grasp.up then removeBuff( "illidans_grasp" )
            else applyBuff( "illidans_grasp" ) end
        end,

        copy = { 205630, 208173 }
    },

    -- Engulf yourself in flames, $?a320364 [instantly causing $258921s1 $@spelldesc395020 damage to enemies within $258921A1 yards and ][]radiating ${$258922s1*$d} $@spelldesc395020 damage over $d.$?s320374[    |cFFFFFFFFGenerates $<havocTalentFury> Fury over $d.|r][]$?(s212612 & !s320374)[    |cFFFFFFFFGenerates $<havocFury> Fury.|r][]$?s212613[    |cFFFFFFFFGenerates $<vengeFury> Fury over $d.|r][]
    immolation_aura = {
        id = 258920,
        cast = 0,
        cooldown = function () return level > 26 and 15 or 30 end,
        gcd = "spell",
        school = "fire",

        spend = -8,
        spendType = "fury",
        startsCombat = true,

        handler = function ()
            applyBuff( "immolation_aura" )
            if legendary.fel_flame_fortification.enabled then applyBuff( "fel_flame_fortification" ) end
            if pvptalent.cleansed_by_flame.enabled then
                removeDebuff( "player", "reversible_magic" )
            end
        end,
    },

    -- Talent: Imprisons a demon, beast, or humanoid, incapacitating them for $d. Damage will cancel the effect. Limit 1.
    imprison = {
        id = 217832,
        cast = 0,
        cooldown = function () return pvptalent.detainment.enabled and 60 or 45 end,
        gcd = "spell",
        school = "shadow",

        talent = "imprison",
        startsCombat = false,

        handler = function ()
            applyDebuff( "target", "imprison" )
        end,
    },

    -- Leap through the air toward a targeted location, dealing $189112s1 Fire damage to all enemies within $189112a1 yards.
    infernal_strike = {
        id = 189110,
        cast = 0,
        charges = function() return talent.blazing_path.enabled and 2 or nil end,
        cooldown = function() return ( talent.meteoric_strikes.enabled and 12 or 20 ) * ( 1 - 0.1 * talent.erratic_felheart.rank ) end,
        recharge = function() return talent.blazing_path.enabled and ( ( talent.meteoric_strikes.enabled and 12 or 20 ) * ( 1 - 0.1 * talent.erratic_felheart.rank ) ) or nil end,
        gcd = "off",
        school = "physical",
        icd = 0.8,

        startsCombat = false,
        nodebuff = "rooted",

        sigil_placed = function() return sigil_placed end,

        readyTime = function ()
            if ( settings.infernal_charges or 1 ) == 0 then return end
            return ( ( 1 + ( settings.infernal_charges or 1 ) ) - cooldown.infernal_strike.charges_fractional ) * cooldown.infernal_strike.recharge
        end,

        handler = function ()
            setDistance( 5 )
            spendCharges( "demonic_trample", 1 )

            if talent.abyssal_strike.enabled then
                create_sigil( "flame" )
            end

            if talent.felfire_haste.enabled or conduit.felfire_haste.enabled then applyBuff( "felfire_haste" ) end
        end,
    },

    -- Transform to demon form for $d, increasing current and maximum health by $s2% and Armor by $s8%$?s235893[. Versatility increased by $s5%][]$?s321067[. While transformed, Shear and Fracture generate one additional Lesser Soul Fragment][]$?s321068[ and $s4 additional Fury][].
    metamorphosis = {
        id = 187827,
        cast = 0,
        cooldown = function()
            return ( 180 - ( talent.first_of_the_illidari.enabled and 60 or 0 ) - ( talent.rush_of_chaos.enabled and 30 or 0 ) ) * ( essence.vision_of_perfection.enabled and 0.87 or 1 )
        end,
        gcd = "off",
        school = "chaos",

        startsCombat = false,

        toggle = "cooldowns",

        handler = function ()
            applyBuff( "metamorphosis" )

            if action.sinful_brand.known then
                applyDebuff( "target", "sinful_brand" )
                active_dot.sinful_brand = active_enemies
            end

            last_metamorphosis = query_time
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

        buff = "reversible_magic",

        handler = function ()
            if debuff.reversible_magic.up then removeDebuff( "player", "reversible_magic" ) end
        end,
    },

    -- Shears an enemy for $s1 Physical damage, and shatters $?a187827[two Lesser Soul Fragments][a Lesser Soul Fragment] from your target.    |cFFFFFFFFGenerates $m2 Fury.|r
    shear = {
        id = 203782,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "physical",

        spend = function () return ( ( level > 47 and buff.metamorphosis.up and -30 or -10 ) - ( talent.shear_fury.enabled and 20 or 0 ) ) * ( set_bonus.tier29_2pc > 0 and 1.2 or 1 ) end,

        notalent = "fracture",
        bind = "fracture",
        startsCombat = true,

        handler = function ()
            if buff.rending_strike.up then
                applyDebuff( "target", "reavers_mark" )
                removeBuff( "rending_strike" )
            end
            if buff.recrimination.up then
                applyDebuff( "target", "fiery_brand", 6 )
                removeBuff( "recrimination" )
            end
            addStack( "soul_fragments", nil, buff.metamorphosis.up and 2 or 1 )
        end,
    },

    -- Talent: Place a Sigil of Chains at the target location that activates after $d.    All enemies affected by the sigil are pulled to its center and are snared, reducing movement speed by $204843s1% for $204843d.
    sigil_of_chains = {
        id = function() return talent.precise_sigils.enabled and 389807 or 202138 end,
        known = 202138,
        cast = 0,
        cooldown = function () return ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) * 90 end,
        gcd = "spell",
        school = "physical",

        talent = "sigil_of_chains",
        startsCombat = false,

        handler = function ()
            create_sigil( "chains" )
        end,

        copy = { 202138, 389807 }
    },

    -- Talent: Place a Sigil of Flame at your location that activates after $d.    Deals $204598s1 Fire damage, and an additional $204598o3 Fire damage over $204598d, to all enemies affected by the sigil.    |CFFffffffGenerates $389787s1 Fury.|R
    sigil_of_flame = {
        id = function () return talent.precise_sigils.enabled and 389810 or 204596 end,
        known = 204596,
        cast = 0,
        cooldown = function() return talent.illuminated_sigils.enabled and 25 or 30 end,
        charges = function () return talent.illuminated_sigils.enabled and 2 or 1 end,
        recharge = function() return talent.illuminated_sigils.enabled and 25 or 30 end,
        gcd = "spell",
        icd = function() return 0.25 + ( talent.quickened_sigils.enabled and 1 or 2 ) end,
        school = "physical",

        spend = -30,
        spendType = "fury",

        startsCombat = false,

        readyTime = function ()
            return sigils.flame - query_time
        end,

        sigil_placed = function() return sigil_placed end,

        handler = function ()
            create_sigil( "flame" )
        end,

        copy = { 204596, 389810 }
    },

    -- Talent: Place a Sigil of Misery at your location that activates after $d.    Causes all enemies affected by the sigil to cower in fear. Targets are disoriented for $207685d.
    sigil_of_misery = {
        id = function () return talent.precise_sigils.enabled and 389813 or 207684 end,
        known = 207684,
        cast = 0,
        cooldown = function () return ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) * 120 - ( talent.improved_sigil_of_misery.enabled and 30 or 0 ) end,
        gcd = "spell",
        school = "physical",

        talent = "sigil_of_misery",
        startsCombat = false,

        toggle = "interrupts",

        handler = function ()
            create_sigil( "misery" )
        end,

        copy = { 207684, 389813 }
    },



    sigil_of_silence = {
        id = function () return talent.precise_sigils.enabled and 389809 or 202137 end,
        known = 202137,
        cast = 0,
        cooldown = function () return ( pvptalent.sigil_mastery.enabled and 0.75 or 1 ) * 60 end,
        gcd = "spell",

        startsCombat = true,
        texture = 1418288,

        toggle = "interrupts",

        usable = function () return debuff.casting.remains > ( talent.quickened_sigils.enabled and 1 or 2 ) end,
        handler = function ()
            interrupt() -- early, but oh well.
            create_sigil( "silence" )
        end,

        copy = { 202137, 389809 },

        auras = {
            -- Conduit, applies after SoS expires.
            demon_muzzle = {
                id = 339589,
                duration = 6,
                max_stack = 1
            }
        }
    },

    -- Place a demonic sigil at the target location that activates after $d.; Detonates to deal $389860s1 Chaos damage and shatter up to $s3 Lesser Soul Fragments from enemies affected by the sigil. Deals reduced damage beyond $s1 targets.
    sigil_of_spite = {
        id = 390163,
        cast = 0.0,
        cooldown = function() return talent.sigil_mastery.enabled and 45 or 60 end,
        gcd = "spell",

        talent = "sigil_of_spite",
        startsCombat = false,

        handler = function()
            create_sigil( "spite" )
        end,

        -- Effects:
        -- #0: { 'type': DUMMY, 'subtype': NONE, 'radius': 8.0, 'target': TARGET_DEST_DEST, }
        -- #1: { 'type': CREATE_AREATRIGGER, 'subtype': NONE, 'points': 50.0, 'value': 26752, 'target': TARGET_DEST_DEST, }
        -- #2: { 'type': DUMMY, 'subtype': NONE, 'target': TARGET_DEST_DEST, }

        -- Affected by:
        -- quickened_sigils[209281] #0: { 'type': APPLY_AURA, 'subtype': ADD_FLAT_MODIFIER, 'points': -1000.0, 'target': TARGET_UNIT_CASTER, 'modifies': BUFF_DURATION, }
        -- chains_of_anger[389715] #0: { 'type': APPLY_AURA, 'subtype': ADD_FLAT_MODIFIER, 'points': 2.0, 'target': TARGET_UNIT_CASTER, 'modifies': RADIUS, }
        -- sigil_mastery[211489] #0: { 'type': APPLY_AURA, 'subtype': ADD_PCT_MODIFIER, 'points': -25.0, 'target': TARGET_UNIT_CASTER, 'modifies': COOLDOWN, }
    },

    -- Talent: Shield yourself for $d, absorbing $<baseAbsorb> damage.    Consumes all Soul Fragments within 25 yds to add $<fragmentAbsorb> to the shield per fragment.
    soul_barrier = {
        id = 263648,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "shadow",

        talent = "soul_barrier",
        startsCombat = false,


        toggle = "defensives",

        handler = function ()
            if talent.feed_the_demon.enabled then
                gainChargeTime( "demon_spikes", 0.5 * buff.soul_fragments.stack )
            end

            -- TODO: Soul Fragment consumption mechanics.
            buff.soul_fragments.count = 0
            applyBuff( "soul_barrier" )
        end,
    },

    -- Talent: Carve into the soul of your target, dealing ${$s2+$214743s1} Fire damage and an additional $o1 Fire damage over $d.  Immediately shatters $s3 Lesser Soul Fragments from the target and $s4 additional Lesser Soul Fragment every $t1 sec.
    soul_carver = {
        id = 207407,
        cast = 0,
        cooldown = 30,
        gcd = "spell",
        school = "fire",

        talent = "soul_carver",
        startsCombat = true,

        handler = function ()
            addStack( "soul_fragments", nil, 3 )
            applyBuff( "soul_carver" )
        end,
    },

    -- Viciously strike up to $228478s2 enemies in front of you for $228478s1 Physical damage and heal yourself for $s4.    Consumes up to $s3 available Soul Fragments$?s321021[ and heals you for an additional $s5 for each Soul Fragment consumed][].
    soul_cleave = {
		id = function ()
			if talent.demonsurge.enabled and buff.metamorphosis.up then return 452436 end
			return 228477
		end,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "physical",

        spend = 30,
        spendType = "fury",

        startsCombat = true,

        handler = function ()
            removeBuff( "soul_furnace" )
            removeBuff( "glaive_flurry" )

            if talent.feed_the_demon.enabled then
                gainChargeTime( "demon_spikes", 0.5 * buff.soul_fragments.stack )
            end

            if talent.feast_of_souls.enabled then applyBuff( "feast_of_souls" ) end
            if talent.soulcrush.enabled then applyDebuff( "target", "frailty" ) end
            if talent.soul_furnace.enabled then
                addStack( "soul_furnace_stack", nil, min( 2, buff.soul_fragments.stack ) )
                if buff.soul_furnace_stack.up and buff.soul_furnace_stack.stack == 10 then
                    removeBuff( "soul_furnace_stack" )
                    applyBuff( "soul_furnace" )
                end
            end
            if talent.void_reaver.enabled then active_dot.frailty = true_active_enemies end

            buff.soul_fragments.count = max( 0, buff.soul_fragments.stack - 2 )

            if legendary.fiery_soul.enabled then reduceCooldown( "fiery_brand", 2 * min( 2, buff.soul_fragments.stack ) ) end
        end,

        copy = { "soul_sunder", 452436, 228477 }
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

    -- Talent: Consume up to $s2 available Soul Fragments then explode, damaging nearby enemies for $247455s1 Fire damage per fragment consumed, and afflicting them with Frailty for $247456d, causing you to heal for $247456s1% of damage you deal to them. Deals reduced damage beyond $s3 targets.
    spirit_bomb = {
		id = function ()
			if talent.demonsurge.enabled and buff.metamorphosis.up then return 452437 end
			return 247454
		end,
        cast = 0,
        cooldown = 0,
        gcd = "spell",
        school = "fire",

        spend = 40,
        spendType = "fury",

        talent = "spirit_bomb",
        startsCombat = false,
        buff = "soul_fragments",

        handler = function ()
            if talent.feed_the_demon.enabled then
                gainChargeTime( "demon_spikes", 0.5 * buff.soul_fragments.stack )
            end

            applyDebuff( "target", "frailty" )
            active_dot.frailty = active_enemies

            removeBuff( "soul_furnace" )
            if talent.soul_furnace.enabled then
                addStack( "soul_furnace_stack", nil, min( 5, buff.soul_fragments.stack ) )
                if buff.soul_furnace_stack.up and buff.soul_furnace_stack.stack == 10 then
                    removeBuff( "soul_furnace_stack" )
                    applyBuff( "soul_furnace" )
                end
            end
            buff.soul_fragments.count = max( 0, buff.soul_fragments.stack - 5 )
        end,

        copy = { "spirit_burst", 452437, 247454 }
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


    reavers_glaive = {
        id = 442294,
        cast = 0,
        charges = function()
            local c = talent.champion_of_the_glaive.rank + talent.master_of_the_glaive.rank
            if c > 0 then return 1 + c end
        end,
        cooldown = function() return talent.perfectly_balanced_glaive.enabled and 3 or 9 end,
        recharge = function()
            local c = talent.champion_of_the_glaive.rank + talent.master_of_the_glaive.rank
            if c > 0 then return ( talent.perfectly_balanced_glaive.enabled and 3 or 9 ) end
        end,
        gcd = "spell",
        school = "physical",

        spend = function() return talent.furious_throws.enabled and 25 or nil end,
        spendType = function() return talent.furious_throws.enabled and "fury" or nil end,

        startsCombat = true,
        buff = "reavers_glaive",

        handler = function ()
            removeBuff( "reavers_glaive" )
            if talent.serrated_glaive.enabled or conduit.serrated_glaive.enabled then applyDebuff( "target", "exposed_wound" ) end
            if talent.master_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
        end,

        bind = "throw_glaive"
    },

    -- Throw a demonic glaive at the target, dealing $337819s1 Physical damage. The glaive can ricochet to $?$s320386[${$337819x1-1} additional enemies][an additional enemy] within 10 yards.
    throw_glaive = {
        id = 204157,
        cast = 0,
        charges = function()
            local c = talent.champion_of_the_glaive.rank + talent.master_of_the_glaive.rank
            if c > 0 then return 1 + c end
        end,
        cooldown = function() return talent.perfectly_balanced_glaive.enabled and 3 or 9 end,
        recharge = function()
            local c = talent.champion_of_the_glaive.rank + talent.master_of_the_glaive.rank
            if c > 0 then return ( talent.perfectly_balanced_glaive.enabled and 3 or 9 ) end
        end,
        gcd = "spell",
        school = "physical",

        spend = function() return talent.furious_throws.enabled and 25 or nil end,
        spendType = function() return talent.furious_throws.enabled and "fury" or nil end,

        startsCombat = true,
        nobuff = "reavers_glaive",

        handler = function ()
            if talent.burning_wound.enabled then applyDebuff( "target", "burning_wound" ) end
            if talent.champion_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
            if talent.master_of_the_glaive.enabled then applyDebuff( "target", "master_of_the_glaive" ) end
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
        nopvptalent = "tormentor",

        handler = function ()
            applyDebuff( "target", "torment" )
        end,
    },


    tormentor = {
        id = 207029,
        cast = 0,
        cooldown = 20,
        gcd = "spell",

        startsCombat = true,
        texture = 1344654,

        pvptalent = "tormentor",

        handler = function ()
            applyDebuff( "target", "focused_assault" )
        end,
    },

    -- Talent: Remove all snares and vault away. Nearby enemies take $198813s2 Physical damage$?s320635[ and have their movement speed reduced by $198813s1% for $198813d][].$?a203551[    |cFFFFFFFFGenerates ${($203650s1/5)*$203650d} Fury over $203650d if you damage an enemy.|r][]
    vengeful_retreat = {
        id = 198793,
        cast = 0,
        cooldown = function () return talent.momentum.enabled and 20 or 25 end,
        gcd = "spell",

        startsCombat = true,
        nodebuff = "rooted",

        readyTime = function ()
            if settings.recommend_movement then return 0 end
            return 3600
        end,

        handler = function ()
            if talent.evasive_action.enabled and buff.evasive_action.down then
                applyBuff( "evasive_action" )
                setCooldown( "vengeful_retreat", 0 )
            end

            if talent.vengeful_bonds.enabled and action.chaos_strike.in_range then -- 20231116: and target.within8 then
                applyDebuff( "target", "vengeful_retreat" )
            end

            if talent.momentum.enabled then applyBuff( "momentum" ) end

            if pvptalent.glimpse.enabled then applyBuff( "glimpse" ) end
        end,
    }
} )


spec:RegisterRanges( "disrupt", "fiery_brand", "torment", "throw_glaive", "the_hunt" )

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

    package = "Vengeance",
} )


spec:RegisterSetting( "infernal_charges", 1, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( 189110 ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer charges.", Hekili:GetSpellLinkWithTexture( 189110 ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = "full"
} )


spec:RegisterSetting( "brand_charges", 0, {
    name = strformat( "Reserve %s Charges", Hekili:GetSpellLinkWithTexture( spec.abilities.fiery_brand.id ) ),
    desc = strformat( "If set above zero, %s will not be recommended if it would leave you with fewer charges.", Hekili:GetSpellLinkWithTexture( spec.abilities.fiery_brand.id ) ),
    type = "range",
    min = 0,
    max = 2,
    step = 0.1,
    width = "full"
} )


spec:RegisterSetting( "frailty_stacks", 2, {
    name = strformat( "Require %s Stacks", Hekili:GetSpellLinkWithTexture( 389958 ) ),
    desc = function()
        return strformat( "If set above zero, the default priority will not recommend certain abilities unless you have at least this many stacks of %s on your target.\n\n"
            .. "If %s is not talented, then |cFFFFD100frailty_threshold_met|r will always be |cFF00FF00true|r.\n\n"
            .. "If %s is not talented, then |cFFFFD100frailty_threshold_met|r will be |cFF00FF00true|r even with only one stack of %s.\n\n"
            .. "This is an experimental setting.  Requiring too many stacks may result in a loss of DPS due to delaying use of your major cooldowns.",
            Hekili:GetSpellLinkWithTexture( 389958 ), Hekili:GetSpellLinkWithTexture( 389976 ), Hekili:GetSpellLinkWithTexture( 389985 ), spec.auras.frailty.name )
    end,
    type = "range",
    min = 0,
    max = 6,
    step = 1,
    width = "full"
} )

spec:RegisterStateExpr( "frailty_threshold_met", function()
    if settings.frailty_stacks == 0 or not talent.vulnerability.enabled then return true end
    if not talent.soulcrush.enabled then return debuff.frailty.up end
    return debuff.frailty.stack >= settings.frailty_stacks
end )



spec:RegisterPack( "Vengeance", 20240901, [[Hekili:T3Z2UnooY(TeSaEKs64XxI7o9c7SaN5PTXbZlzXEEZok2YjcX2YRKC3tde4V9djLiflYQOO8L0z2PbgmiTevXQkw3zr6P9N(VME)IOI4P)(GEdUP3N71VB)(3C7OP3x89TXtVFB08xIEI9hBIwZ())74npfhTzU4nFFvA0coaYt3LXF0ZffBZ)7)6V(usXZ7ES7801)AEY6DRIkss3mplAzb)Fp)xNE)J7swv8p3m9r0z)MpZG5245t)9r32Nb2KflIlhBC(8P3Zh719(8196)33)W9jR)T9pSBlhm7)Y(Vu(YpD9GHSx(VEoE)d)FrzS)hdLs2WW6S0LjRy4A0CosL3DBwmdpFmQ4Qj)6xJYsIECv8h4e7K8KnpTkEwru2tXfF4RrR2XE224vRQEuE38TjzjfZEK99t6V)lEaY1rSppknUjWD3KbDiF54jJ8zYEm5j)MQpIdTOS5rBy0FAww8Mc8XKN8uYQzPlNTCfBk)qYYjphNLoRiloUB0QfzrZFozwwC0xJZE91vXFnE14p1)1xdQh1Y4v5ZJytXIofrRytu38IDSL7couZ3TCzCgBDieF6twVoTu6Aw0USi(6F1WS4gB2TEw(2OVTH)Ozmj2v5FiD7KS4C2I7I4Lr7wvmPxR)(1r)rfdUpN6LKa71Ze8M8oZttxTi9BB6c5vD3T9iMSbAt2sgxUyxwC9mjFs35pZxVZNjEaBMIwD3K(DU4rgBT764IO1PzBFonpj)4WMHhd2CAqMOflOwhysxmXVob1le1pTBw86OKn53H)2fmHkoAC9WWqDuArsE2UTfLZexJQ7IybDmpkVGjUAqbjBysXmYDwErwYlXFyxEmtoy5SNMVqZUbhUXRzIYmLZxIZHJIpvLRB6JHnpmTMnVWMsDWKTJPpi(xZwLKxuY4IY(aF6Nxucmp0tBeKlZjazTsTMkz3OmBdIBFCwXZmLWNzCF(6itBmz5hMNUzrc)JusvjXzFFgJ0tYJ7Siv(GhZI2SOBrYCohOA9pqodDbgWVCu4vAVsAi(YB0FCLjt2dlb2mgD0AiochIo5dmlTSL0hDWb0SylTOZfuz6spTM9(87MuJkaMQgH0ZhCGPtLU5DbIKY8(We(BfUearMRu4cIDJWJhvxKYCuvAXyfx7PclSrVob1Yev03RVA(ebRh5XvmIWxFL587R8)SBFLzv3cwls3XP3S1ZI)dg2eNxXnLiAY64Rg0JR9Ia6ovw1knmKpBDu2lm3ZSqczHNG9oL10b9UMdkMlIWk3nSyiwW0EQmbYnCv(8NwfL81yMpXDzzFx3UPBQPAMWKnQz0we)1C6n8UEvuFdd0qm4V932)WvTf52YIEPWjnLX4jX)NDXSGQNj93axKk)4A)OX)r88DfmZq8fVQxQjdI(E5Yuj7gmKdc7Q93wTolCqvj3)sC8MzSmfyjoSoUbYNjo80tXzZszO3YvPFds69Q97zkOqjx1e5eV5zEcmsfwebitJ3V(6YKNEUqUSo(wnvul0xgeI3MqKbEml)7BMlTI5s5QIH7u5u8gM9SKvIiolEMX4e0WIO1SvftyfAsIdmX5TPIvERys4aO6JM0RJMnoDQIfWpHna0v2qttA8znPiEnsmr4tyPYkagZfUNnJGj(pkerML7cwa4GgiKMwchqOu1RV6L8kisyQyandxUdCzqfllFD)5Dmns569Oox0ULctrxE()lzMAYIzb6fvyJGvMa2THLU9IyweGZIYZ5jx15I6mcIx94QOfIPniiaZB5YDzFF8najkNEnddzYWOqYo)l2RluQaJRubE9vx5hmw5nlqNkyrK(vwe)rvMylhAq1yVCqyyhbDmQNa7e)9qgnbJrz8KbAtUJSLg3p0s1qUcxlByyPNZIfppkRqAkO6vcJfxbrMqBvFJKSfZuqReXnrA7Qg0wa2rUuhLpV6LcyX4YxG)MoxOfGdeb6eWZOWi9C1Qz)RQa4)zhlpJ4nmj6Ym7dTxnWnYWSoOCpiToyVk1KjBpgIeNvAiyEV5ACbb97o4QG(xMf9TzpZKGJNTDEry4LyXovb1RDc1WqdbPRCj0XI8EqpUkraPPQWXUWLaNiJmOhfm1d3X7LTOSzvFhFvRb)J65aWgTdCF8KaqaAnWwnTwCN07obR9Uj8GV5MEK2qF91lmnzAPqQLh1jg7BHThHqHbM94UvVWwgkQmc(MIDbGAME3)yuiggc1Kvk4hVA6fKWjQGJFSfY44fcRKozjUzcA(tTco2Ku1k6IE4(6fNP2jmOKnkN8IWQs2uAKnVtLtU74ftCw1)GBxGpTmhbgv6zspBDxOxDD0stOgp0aU(XDtArqgV(QPN7GbxBxY3UmC9femfQKzodM8Ay0f6f1uJeS0STPLkmhZ7NGLbFvDOpwOF9RO5YMLFzy44jJWHKYwjFzO7I4LjZtkgpyKjFOkEicgG)lDwpwwvLoYynjcq9cYqARfRCgURzqZyP4GSCxV2ck7yvmroJuOzJOqtBtS46vmaH92FgH(XeHUlP9jdgPfXkqv6cnt6WAmAj6uHpMZ7ZXrzelRwjrKL(TkhyWc2lJaYDIPeFb0ZiXG8ibgIVSzP6HnePemkonqdZfGyqAoMAcmc5zQbvlltnrqXy(kKE5nu1WGNR2MVM(s8m5JMXP)QDA57RFmvGmpNUn(qGW20VfNX8DVCxEfwi)(keuZh3US8cmNC8NB6fL5cUYMgSSgiAROtPWX7oU1xOvtt9MJAsSIYWYcrPSMy35Y3XeaNPZlasXg4ETpvByIM0QahoKPt3x6jb)TTNypzickZyu12R8TOI6BmbMkNbqncsfpAuUv4RuXKgL9cZWqwmZ0l3lbl6TlhmmKLFCVldkNflxjO1GV2(DRQrpZNX1bgWqW0NNMxa(4sXCWZnrm(7y5P0l02XCPYh2trJULPxg2HplybIR5LLqHcJd4KlQ7v2wjuT8AhO0pxo9D5KKRIKf15D(msM4umzUmww)QbDP8kBlOPcb(I)siIrZk08BCswQyH3(xCokLJttwoW7PD3qXy0mk9)6AHgci6Kvuj3XRUsBAyetHZASXK1IVJUoXKtBV0C8OZBCh1CGiS06XpLQvlEI8PAZQMl5idMR3RlMw2FxHqVXI2hkkB1Wyi4l(w8BME2Zrzl4TBk7D0DD2fwj1P5cRC33nQwwE1E9QcKxpBSRaUmllD2TInYRLbfW)K2xrAGY3jHATRn4evAi3eYcP8VeHPGTakkcjYdvlF4sPwlbAIPnvHHduOWP(MM7GzpY30ShJxMYw(4iUdBfWTPQs)cBZQyOmEBTxlOP5qA5Uv8DbO8lelOouVibDqGgcCnYGUUFy4LOiGAB)gpXD(7avnNGQji5C5HB8KjrT0LzBKJdI0(TqGcBaQgEk4g5g0z3(goAwehDeItqgIVrBYEtP67swTA36KnrfQVuUrOSvxHur9(kIH2emCPJaJfnZbXLRiotkAYv31VdfVXNp)AYb1K4QXWvsS31GalF3hDW7p0fudXxhTIydhRMYVhTzQixQ6qsqcxt2XyQzYUkatKchrUbDg4ksBAP(qPIRXN4vhcGxswulVTUbb6OWqxw(Tiv8oaAzUEha9yAEEh62aAj9XKP0VRQ1qANtZa3b1uTRgo8Q6dkc3CpXH6rEQEAD0O(mF6v7Ow3HIdqg0g0ywZH0nWwHMKDOWTMQ0na8WMiWazBmav73tUhmCCxU3PMkHGnVVPDxxpMJg2IDy0)nY3HBbGA)5LB4UP1gyjHd832brA)mlF4BToEw7eDNGJIkB3TlJNms1vrC4bFpZ6u5l7pk0wq0Ue8NaShIaJN0x2Ld499uzt8GRXJLlxiDkcTcoYgebtKOERDXPCuXiv7w4334XUwt8jP4nZf7XUPfYMEcJiCpyG6UQRCi4(TorDruYEcl35mkIoUQdBmjb9nya7GOHiAh8UNwBJcq9r8JcdWMl5x1GIdDpr4wUZ7VtxeuxyLBLHyP2YvgElivhc2vE2csGVaZdPh95dyq4nDakym3rX8M6Zh4eb9JQZgubK4MlW5)nK314(Wdle(C4vtu0Qi25ZcAh9IJaE1Ai4FQ5IkSxNaCVRA8CHbNc9p06UNGAGW6QsesTvFinm0jebQBSOP6GzSbbOwHTPQ3RE0LwtOM9z5es0TSNv0WItAgFZWo0vq0bdvnWfPPRf(rDu8jxNKi0xXbANMRv14gkSuWXM9G9aMZ)J1Is7KKfJoeRLhKes1j0YCYSrfJX0bT0Mc60pji)0oE7s)XAFt8o7hsHX83XNOblK2JqOBQ()oGorUHEMyeXXsOMDrNKxRwNAbV0xJCnWtQJXRPQe1uIqhYcQF6GeYPONDGMIq3pxuQVVQgOOPpaxS47RILZepnYyLttdlv(ewn181mdqpSrTtE6vT7IxOpfqSpUBT9(9aaz5bsJmsm9dT2YKvRQSaOoPg1mtRJVg(rAVdo666CWrDvtekReDAdNkenbDcS0ZZJV(5cHcnDDDka5466m)qXqkeuCgwE)IDWSL)XkksOxvPZGKwKZbtMq)WEW0Pq)6VfLu8H845t61vK0MhQi96E7pwLKMyi6vOchzMEp3Wide13MLtV)BrzByJkF69I7IYK1BtZk2)WY0S9p8llZ)L9pKXMRe(nL2d5PS1LhI2vKUMV1W7FGXN2W4tD3)L)3KnSxXVVl)T0nSPr86FbjTCgalsXFv3yr7mTGnKG()rOcQdWHQMZsdGcAEfCyo8maZBodWC0zHJ(XZaM(PZamV9maZp)Ney2VhoqHvZYaUWxscAc9uSK)nrCS6d0YPXS4bgtH5RBl4nAhedOB822c8ZmUB34ngtG9aA7uCMPG)uW9ppwvFJb7jWqWac3Ghjg)gd2JYm75bONJqbolaD4Pn4Q9FbjksqHa(LwfqjvGkNwhveZYjYAZ5iiMZbmPc444akHXRJdON24xrfARUX1BN4kLYuDXvnXlTYUsPHsylTkFpt7OQ7GvCOryd5aHg1IBD1WXO3QDTWV1HTYBt)2TsqHzNkdhKg6eBYB7WvcPMJ1B5ziQbuQokRDK7plsWPgMNdBSeP0ACZjBaxJ3sA)MOwb2xsvgW3EaTDkokEYzbOdiC7EssK6hcWprXnnGGBFSgkEBb7rzVTc0NJO9olaD45ieYHuvR6Oa65W2ofqpH21ElMItB01NtGEAThJgDJ(bb5xAvCoN6W62)L)PaZ4aR)q5oCT)b(wrZN1P3l(l(V3zl5))Fx8BNwfyM()m9(0TtVxCggL)4In9E52qj(Rz89ZM)dBgN9uF2XNE)CgpJfhC007DGO7FOZ(hioPdCWlp3FtVpy)den7XdxYcMz)dH7F4kgzRpm55htmKBWgsvRuOgq1C(MnDft)9bhgdVUFPry1isSqUzpfHcBpK9pC3eDsYCvLHVdpw8v0ZlVXi9nhnsx1u6hhEhWTaar9R0WCKlObHuuJK3OdJ8YnVXh(PwRxthJJ)XdJJR16xhNKutAagRRmm(thng)gO4AJ23E8O97jvxBc8ZhgbA2KD6uhsVgVBRqP1SFk1oqQqcNMbjGZf2Gc2AMIrfi)VMouL7Fy8eXaRAOynDXq58vcjEB7ivqL5dzF7Li((bd1uM73t8SazeqoVpteFu14aCaQXuVmymMq5)DT(ClHP6ooXcyA3Zj6Vd7UorjM1toxV(k0(L2P3t8oKxiuT1)yAriKLE9JjnMugGE5JPEEiBr5YrGF7OusOkvZZQSQzhWxkQQDGDeRpwR6DKIQJ3)WT9CTSiA5y01fLn3tfdJzTPFVdZCJMNER7DaedR41OaAIX59VsjB29zuxjau15DLQbAhqlftZU18khBFXcLNxQnEUY71uwkQbq1Rj)SRfFvPU9LeOBnFl0hwNuA4aZ2tEpzG5s1XoHqS(BBMrYdB(gzHXuL80keGOoKASDVa71ohABwMm(uWk1DESqPyheA)LD(Qyq0xhmIPkq4u9AfRIQOQk)w6r)iSH66KEDqtrfPDHVlFNAk02QjcBTowd6oPQ0sIu6rPOxz4qaJbTbZ4ZlPgIq31SWb1QIxq4)UwPwDH)u(NvhgvE1F4q2mfFaKdCGxcs2bZ0iyoSKWaocvzEfkx)n9rI75S2RzynnBC0wfuQzDbauQcQ1M7KWcsycqzMdoauotMMtbnLTDGUuiU3vOeOLRWALnoryFOLfcT9earr4U86BYE1gRGFyMHSw6jP55LriPFTdj0sg0RgGMNCMYsvkJhrDeZftMzYT(KlKhbYg0COJCEAZX7wtvg3mpqIQm8EbfzM3RpuKZS7QU(JMEFF)qgWmiqjZmvTn44Mv64oeY2LFBYuCGMdlFin9YZlkbRzqX1ugT1oVqOsXmNeU3zOGnkOGMFuVQHteKUicq5NjVyj0zg8br7QHkIQC9JJSq1ggOmW9MEd(q)jHgbRtkGiqjRC1vRpgzNnQh0mw1zesq30ocbXSC4M1jkIQMdpWeHMIlWbOrvpdndGXrsYoYSuHkiLaByPgWinUk33ZnGKEn)oLRM6pO)iTGY0wq0eoeRj0USFJyvM0Y4jYa)R(EitapUfvXycCvRf8Afe2uzCoi4QfZeK)dKfelb0H6GZCnxmllyjhs0bj0wirhbagXQbN6vzbCO97IWVPbdTVs9dEyzmpJiPQH0oMAfymtZhOZOSewlT6u4brA23Aybs4RvZGFfVeKuNIUg2d38(qNzqHCHDvMrNBRdbAMa(VpEA7TQuT5lEJNy4Iom0DvxTSiwlDMZQcO27AcLkJFzg6p8OTzc1KlDBqiW(r9G1uKpmyTHFcgrx9nqgCGCBGQFp(Mk78dJQbOGdmBaJWd1Nq4nPGjU1ygew)mjIeCAH9(5xdiWpwILSZH1jhr8JMy540t(04NHr(CosNmnkaaKmHltA5fdh2NqbyPBw4iVfmsTaIGd7ZG5fgFS1IVmztKE(XTVZs9ySDY9gT0HPswcnxjA)OhKw4janm0EPf3qcgCaAY4K5QzhGLdPBYPRXa49hFGbCtB46eq76MW)OH0BPzphQm4gaf21WKQ9CVn4Lp8DCdXGoK3bneZX1gBi85w0Bgy2IQPNTN0gy7nOjyoLTU27QMFXRMwdNS8zJ(dqJY15oeG(kZqwrZeiuNzBfgybzhI5I8KLQIhis9YfvIilIbrmTok7fz0mkdXyJXy)Yg0tSTugLhRoEmJ7dgWBnVVzG8KDCPHS1SWOylyX5k73TxyUgwQT(hKcRwKagtA5wUjRFiJI7rjJ7bmuHI1QL1YxODSiBDxevpgJWJ1hMo)s)Y(rUFZQaenq(OflCG8vIfgrEvPisCYT8btO6dfhOspS8fSUi2Ck8QJzM3uCcS6aJzW6(ycngALBtr1jS27RBnmhzHGecUL7zlH)xh8ZGMnpOmk4P5gXiyg5twTsMMvjDUiAntibh2HumKb9ao0Qk8)S8VVzUGKPJkh0KoQAndCoOdnyTnWn5riTbRir597m6EQthtpoovdu37vpD45eySk1ieTd5u6A7J00OfiaDjCDwNh8Li1U7it2hiYmsQDFylvtPQMbcBLUCYv2(OpAusKe7MKwloLaFkLisDeBv8nMfVR5z0NTYtP6YHAJ7INrKfb(VhEuBPkCV70PpTA(kNmISubO(s67Wpb0u91LMm0xzo(IxUJ3KGfmJIfOIr07MazbVK4T76vDLnHfA1bf6vmZ9U3hqQ1qBUyFdnxJJDv)WNrj3PPUfRUuZnns6ANu10sLtORgpRuATVyvXZ27cklz3ordORjNdXMM8)65W0jmLHfSi5GMZk)V(DhOA6EHMBw03M9mtfpE225fsI)sOTmRa8fXC3WChkRnbsUPU1EcLf8v32rGt3pHYL5gW5Ggr76O5vZcXHgqtcXzZqPDxglKDORA6r0XvABwqrtTgHlEuv7YyLHJxl24M0VdgaQZI8hOY4DaeOaxTCrIlW81sxJy3nMWzMJ0ANfkX)PKLENoYY3b0dxkWyNE(hYcAIqBiBNJJEp4KBF8ch2CJk4eft6koErxToHRjoCZCtqCHwPOc4pg7AxHZgQWNgFkO5EFkqFuN1wA1YAQrVQ6OPp8OHIcAmSAFAiOgltjwCSbgnvUymvbCuEo4Od1OUDEOJm0eDinw4OrvAUXZSzf4SinMXHEkOMQVbtGThTWzBY4NyaIRPYgKlCVSh5OBSnhDJsR61hAhZnN8xRfkTELETZ7yN)AdPfxZMDLEnuPRfjIBMYgsfCa9uIF9aIX(QPsFXzC4UfeDSNR2T3WiNU5gs7MlWWg8pRdXFgRdbObHODABydHp5JqstM08M7(TWrRta6DfQEwc05kIFFmmgXn9aGbV7aUXOz2D06t1nbVZ(FPHZ)NCrPds9mBr1gPT8)Mfdvdbqrg6ulQbVpLj)gGCGJESQW4uC4CveVwZ67RQEpA1mwESRx)8smOHlXaCpmE1rSyHkx1BALa2TKUHJbNTpgfNSXvfkxkhIA2pLO(rkr5mmoNHpEEXg7S8CE8uphiJm6B3DLO(ag01SjyHXuOsvY5wo(tfcpuiWdF0zjFopYivHw(ZfT2TOPLL6TEey8NBog8cZ4uLruj)mZD4dod0HeH0caosVAytgvP9ecYgtRmYTAULgUmsnu7xkyCvhAB9MOvdLa5mJYAcoTRXUhkrqh2ZDVY5SqeY0pDC7X4YHs9w1sma(pqZawS7BYKso9HCvIeC6oo3udZ633AQbAjia4alO)DS2jPyn268lXUTJaCN2lDtMoOt)vL(t8PgsNNJLoYTgMaJofNk9)sVzf(VxfLbN0PrTmTzdUNgwTOkq8YdEnvfId13WGap2Za81f3XwtVrdwn5QBd)ESS5AbR)aJ4tOpuAU6OZMmOsZVjRmPxTKzTSeTCcTJuVu1CwvDVcXMWqHJwZubmvpj3PrddisQvM47GRWpKmMvhTxzJNAB39uhznQPfdmp1KybqpONxrqx97)ew1i59JDwmzhzl7YzKJstnyVVhwO2CilArFm4w1H4iYKAQX6RYuv8g288yOjsW5nJAdWQEQXpGugoyDThj1cKxq08XEqfyN4k3uXWZfvCOKa2zRY9b9Gugb(dVL0sG7GKUJEm1DOY1Q0x8GGOnLvALVB1XtGFLtXJKx3V(IK8SDBlurmsDg3t2WsdGTau1WPgMaAUvEfUN4E(Ejw1M7fmpKIdbQcz0ge2ElqhGZZXzPZkYIJ7gTAbtA55KzLTTtP)HvXFnUCxc)eJMe32xfaYZvt9hL1qep1toZczoBTmJnI2ollZlntQ(5zJYqP7dUcypW1DxvEVlQlnbJeGW45bpB19DOJbnUCl61Wj5bSLYI5rHpFuFQQ8URmQjbAuglicgBjLTmADBFrhotlKavH4Ij4aI2Wzg)ot)dCGXDwEQc4brR83)(PMv4Y1(n6Oaxg3FhoUVzA0cIJJKJw4tqQbthcKPcsViCH7gdSdzV53HU18bXOIdusY0OakL0SpDdHrqZoOLwDuHmB4b3KttNkSM6DBt5sNsBVljx8O89RfXFhseLnGcsKGMvaWhI4TujIkjhE3sKF6VRFiUUih6TrvGtj6lkh8BENCKlkhGlb96Eahg8AePHlkh9txXbfVciIeSJDCZ3KZT9y4RIgZSVUlVFu2v8CkJNWCA(BINm9))]] )