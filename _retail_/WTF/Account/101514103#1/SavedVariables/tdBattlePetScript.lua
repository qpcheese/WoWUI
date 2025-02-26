
TD_DB_BATTLEPETSCRIPT_GLOBAL = {
["profileKeys"] = {
["Flurrq - Ragnaros"] = "Default",
["Fishanus - Ragnaros"] = "Default",
["Qpaladin - Ragnaros"] = "Default",
["Gammelemil - Grim Batol"] = "Default",
["Sikducker - Sylvanas"] = "Default",
["Qpfromage - Ragnaros"] = "Default",
["Qpfromage - Sylvanas"] = "Default",
["Dogson - Ragnaros"] = "Default",
},
["global"] = {
["version"] = "0.0.0.0",
["scripts"] = {
["FirstEnemy"] = {
},
["AllInOne"] = {
},
["Base"] = {
},
["Rematch4"] = {
[150922] = {
["name"] = "Sludge Belcher",
["code"] = "ability(Corpse Explosion:663) [!enemy.aura(Corpse Explosion:664).exists]\nability(Toxic Skin:1087) [!self.aura(Toxic Skin:1086).exists]\nability(#1)\nchange(next)",
},
[200679] = {
["name"] = "Storm-Touched Skitterer",
["code"] = "use(claw:919) [ !enemy.aura(claw:918).exists ]\nuse(flock:581) [ !enemy.aura(flock:542).exists ]\nuse(filler:184)",
},
[71924] = {
["name"] = "Wrathion",
["code"] = "change(next) [self.dead]\nuse(Dodge:312) [self.aura(Ice Tomb:623).duration = 1]\nuse(Stampede:163) [enemy(Cindy:1299).active & enemy.round = 4]\nuse(Stampede:163) [enemy(Alex:1301).active & !self.aura(Ice Tomb:623).exists]\nstandby [enemy.aura(Undead:242).exists]\nuse(Scratch:119)\nuse(Crush:406) [enemy(Alex:1301).aura(Shattered Defenses:542).exists]\nuse(Stoneskin:436) [!self.aura(Stoneskin:435).exists]\nuse(Deflection:490) [self.aura(Elementium Bolt:605).duration = 1]\nuse(Crush:406)\nuse(Dead Man's Party:1093)\nuse(Macabre Maraca:1094)",
},
[175785] = {
["name"] = "Kostos",
["code"] = "use(Blistering Cold:786)\nuse(BONESTORM!!:1762)\nuse(Chop:943)\nuse(Black Claw:919) [ self.round=1 ]\nuse(Flock:581)\nchange(next)",
},
[173267] = {
["name"] = "Uncomfortably Undercover",
["code"] = "change(#3) [enemy(#3).dead]\nability(208)\nability(447) [!enemy.aura(446).exists]\nability(#3)\nability(#2)\nchange(next)",
},
["Are They Not Beautiful? (Aquatic)"] = {
["name"] = "Are They Not Beautiful? (Aquatic)",
["code"] = "quit [ enemy.is(Beeks:3566) & self(#2).dead ]\n--Add -- before next quit when you've faith in critical hits killing Talons\nquit [ self(#3).active & enemy(Talons:3567).active & enemy.hp.full & !enemy.aura(Void Tremors:2359).exists ]\nuse(Rush:567) [ round>3 ]\nuse(Prowl:536) [ self.aura(Pumped Up:296).exists ]\nuse(Pump:297) [ self(#1).active ]\nuse(Void Tremors:2360)\nuse(Feedback:484)\nuse(Sewage Eruption:2062) [ !enemy.aura(Void Tremors:2359).exists & enemy.hp>967 ]\nuse(Moonfire:595)\nuse(Nether Blast:608)\nchange(next)",
},
[173331] = {
["name"] = "The Mind Games of Addius",
["code"] = "use(Blistering Cold:786)\nuse(Mind Games: Health:2388)\nuse(Chop:943)\nuse(Chop:943)\nuse(Blistering Cold:786)\nuse(Chop:943)\nuse(Chop:943)\nchange(#2) [self(#1).dead & !self(#2).played]\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581) \nuse(Mind Games: Health:2388)\nuse(#3)\nuse(#3)",
},
[150923] = {
["name"] = "Belchling",
["code"] = "ability(Acid Rain:1051) [round=1]\nability(Dreadful Breath:668)\nability(Twilight Meteorite:1960)\nability(#1)\nchange(next)",
},
[200680] = {
["name"] = "Storm-Touched Ohuna",
["code"] = "standby [ round = 1 ]\nuse(curse:218)\nuse(haunt:652)\nuse(claw:919) [ !enemy.aura(claw:918).exists ]\nuse(flock:581)\nchange(next)",
},
[204792] = {
["name"] = "Are They Not Beautiful?",
["code"] = "use(Mana Surge:489) [weather(Arcane Winds:590).duration>1]\nuse(Surge of Power:593) [enemy(#3).active & enemy.hp<1099]\nuse(Surge of Power:593) [enemy(#3).active & self.aura(Dragonkin:245).exists]\nuse(Arcane Storm:589)\n\nuse(Arcane Blast:421)\nuse(#1)\n\nchange(next)",
},
["Chi-Chi, Hatchling of Chi-Ji"] = {
["name"] = "Chi-Chi, Hatchling of Chi-Ji",
["code"] = "ability(Immolation:409) [!self.aura(Immolation:408).exists]\nability(Wild Magic:592) [!enemy.aura(Wild Magic:591).exists]\nability(Acidic Goo:369) [self.round=1]\nability(Dive:564) [self.round=4]\nchange(#2)\nability(#1)",
},
[116789] = {
["name"] = "Son of Skum",
["code"] = "ability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(Flock:581)\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
[105840] = {
["name"] = "Fight Night: Stitches Jr. Jr.",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Supercharge) [self.aura(Wind-Up:458).exists]\nability(Wind-Up)\nchange(next)",
},
[115307] = {
["name"] = "Algalon the Observer",
["code"] = "change(#2) [round=3]\nchange(#1) [round=5]\nuse(Explode:282) [round=8]\nuse(Blinding Powder:1015) [round~2,6]\nuse(Sting:359)\n\nuse(Decoy:334) [enemy(#3).active]\nuse(Razor Talons:2237) [!enemy.aura(Razor Talons:2238).exists]\nuse(Flame Breath:501) [enemy(#3).active]\n\nuse(Chop:943) [enemy(#2).active & !enemy.ability(#1).usable]\nuse(Blistering Cold:786) [!enemy(#1).active]\nuse(Chop:943)\n\nchange(#3)",
},
["Are They Not Beautiful? (Critter)"] = {
["name"] = "Are They Not Beautiful? (Critter)",
["code"] = "if [ !enemy.aura(Void Tremors:2359).exists ]\n    use(Void Tremors:2360) [ enemy.hp>1101 ]\n    if [ !enemy.is(Talons:3567) ]\n        use(Void Tremors:2360) [ enemy.hp<735 & self.ability(Early Advantage:405).duration<2 & self.hp.low ]\n        use(Void Tremors:2360) [ enemy.hp<368 ]\n    endif\nendif\nuse(Early Advantage:405) [ self.hp.low ]\nuse(Scratch:119)\nchange(next)",
},
[99035] = {
["name"] = "Training with Durian",
["code"] = "change(#1) [self(#3).played]\n\nuse(Sandstorm:453)\nuse(Stone Rush:621) [round>4]\nuse(Quicksand:912) [round>4]\n\nuse(Cleansing Rain:230) [enemy(#1).active]\nuse(Cleansing Rain:230) [enemy(#3).active & self.hp<667]\nstandby [self(#2).active & enemy(#3).active]\nuse(Pump:297)\n\nchange(next)",
},
[150925] = {
["name"] = "Liz the Tormentor",
["code"] = "use(RazorTalons:2237) [round=2] \nuse(FlameBreath:501) [round<5]\nuse(Armageddon:1025)",
},
[142096] = {
["name"] = "Critters are Friends, Not Food",
["code"] = "ability(Void Nova:2356)\nability(Poison Protocol:1954)\nability(Soulrush:752) [enemy(#2).active]\nability(Moonfire:595) [enemy(#3).active]\nability(#1)\nchange(next)",
},
["To a Land Down Under (Magic)"] = {
["name"] = "To a Land Down Under (Magic)",
["code"] = "change(#3) [enemy(#3).active & enemy.aura(Forboding Curse:1067).exists]\n\nability(Surge of Power:593) [round=2]\n\nstandby [self.aura(Illusionary Barrier:464).exists]\nability(Illusionary Barrier:465) [self.aura(Whirlpool:512).duration=1]\nability(Illusionary Barrier:465) [self(#3).dead]\nstandby [self.aura(Illusionary Barrier:464).exists & self.speed.fast]\nability(Forboding Curse:1068) [enemy(#2).active & enemy.hp>778 &!enemy.aura(Forboding Curse:1067).exists]\nability(Forboding Curse:1068) [!enemy.aura(Forboding Curse:1067).exists & enemy(#3).active]\n\nability(Life Exchange:277) [self.hpp<50 & enemy(#3).active ]\nability(Eyeblast:475) [self.speed.slow]\n\nability(#1)\nchange(next)",
},
[154910] = {
["name"] = "Prince Wiggletail",
["code"] = "ability(Shadow Shock:422) [round=1]\nability(Curse of Doom:218)\nability(Haunt:652)\nability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(Flock:581)\nchange(next)",
},
[141969] = {
["name"] = "What Do You Mean, Mind Controlling Plants?",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\nchange(#2) [self(#1).dead & !self(#2).active]\nuse(Black Claw:919) [round=3]\nuse(Black Claw:919) [round=9]\nstandby [self.aura(Stunned).duration>=1]\nuse(Savage Talon:518) [enemy.aura(Shattered Defenses:542).exists]\nuse(Flock:581)\nuse(Arcane Storm:589)\nchange(#3) [self(#2).dead & !self(#3).active]\nuse(Falcosaur Swarm!:1773)",
},
[197336] = {
["name"] = "The Oldest Dragonfly",
["code"] = "ability(Savage Talon:1370) [enemy.aura(Shattered Defenses:542).exists]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)",
},
[116790] = {
["name"] = "Vilefang",
["code"] = "ability(Ironskin:1758)\nability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(#1)\nchange(next)",
},
[71926] = {
["name"] = "Lorewalker Cho",
["code"] = "ability(Phase Shift:764) [round=1]\nability(Phase Shift:764) [enemy.round=2 & enemy(#2).active]\nability(Twilight Meteorite:1960) [self.aura(Dragonkin:245).exists]\nability(Call Darkness:256) [enemy(#3).active]\nability(Dreadful Breath:668) [enemy(#3).active]\nability(Tail Sweep:122)\n\nchange(next)",
},
[141077] = {
["name"] = "Not So Bad Down Here",
["code"] = "use(Supercharge:208) [self(Runeforged Servitor:1957).active]\nuse(Call Lightning:204)\nchange(#2) [round=3]\nuse(Screech:357) [!enemy.aura(Speed Reduction:154).exists]\nuse(Feathered Frenzy:1398)\nuse(Quills:184)\nchange(#1) [self(#2).dead]\nuse(Wind-Up:459) [ !self.aura(Wind-Up:458).exists ]\nuse(Wind-Up:459) [ self.aura(Supercharged:207).exists ]\nuse(Supercharge:208)\nuse(Toxic Smoke:640)\nstandby\nchange(next)",
},
[154911] = {
["name"] = "Chomp",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652)\nability(Inflation:1002)\nchange(next)",
},
[173303] = {
["name"] = "Ashes Will Fall",
["code"] = "use(Взрыв:282) [round=5]\nuse(Ледяной выстрел:1865)",
},
[200684] = {
["name"] = "Vortex - Legendary",
["code"] = "use(Illuminate:460)\nuse(Murder the Innocent:2223)\nchange(next)",
},
[162466] = {
["name"] = "Watch Where You Step",
["code"] = "ability(Curse of Doom:218)\nability(Inflation:1002) [enemy.aura(Shattered Defenses:542).duration<2]\nability(#1) [self(#3).active]\nability(#3)\nchange(next)",
},
[141588] = {
["name"] = "Crawg in the Bog",
["code"] = "ability(Alert!:1585) [round=1]\nability(Supercharge:208)\nability(Ion Cancon:209)",
},
[154912] = {
["name"] = "Silence",
["code"] = "quit [ round<4 & self(#1).dead & !enemy.aura(Shattered Defenses:542).exists ]\ntest(\"Please finish the fight with standard attacks.\") [ self(#3).active ]\nuse(Black Claw:919) [ round=1 ]\nuse(Swarm:706)\nuse(Flock:581)\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nchange(#2)",
},
["To a Land Down Under (Mech)"] = {
["name"] = "To a Land Down Under (Mech)",
["code"] = "use(Wind up:459)\nchange(#3) [self(#2).dead]\nuse(Supercharge:208) [enemy(#2).active & self(#2).active]\nuse(Supercharge:208) [enemy(#3).active]\nuse(Explode:282) [self(#2).aura(Supercharged:207).exists & enemy(#3).active]\nuse(Water jet:118)\nchange(#2) [enemy(#1).dead]\nuse(Extra plating:392) [round=1]\nuse(Supercharge:208) [round=2]\nuse(Laser:482)",
},
[116791] = {
["name"] = "Dreadcoil",
["code"] = "if [enemy(#1).active]\n    ability(392) [self.round=1]\n    ability(985) [self.round=2]\n    ability(1002)\nendif\nability(1002)\nchange(#2) [self(#1).dead]\n\nability(#3) [enemy.hp<618 & enemy.type !~ 3]\nability(#3) [enemy.hp<406 & enemy.type ~ 3]\nability(#2) [!self(#2).aura(820).exists]\nability(#1)",
},
[71927] = {
["name"] = "Chen Stormstout",
["code"] = "change(next) [ enemy(#2).active & !self(#3).played ]\nability(Decoy:334)\nability(Haywire:916)\nability(Dodge:312) [ enemy(#2).active ]\nability(Dodge:312) [ enemy.aura(Barrel Ready:353).exists ]\nability(Ravage:802) [ enemy(#2).active & enemy.hp<927 ]\nability(Ravage:802) [ enemy(#3).hp<619 ]\nability(#1)\nchange(#1)",
},
[201004] = {
["name"] = "To a Land Down Under",
["code"] = "standby [self(#1).active & round>2]\nstandby [self(#3).active & enemy(#2).active & enemy.round=2]\n\nuse(Poison Protocol:1954)\nuse(Corrosion:447)\nuse(Flame Breath:501) [round=3 & !enemy.aura(Corrosion:446).exists]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nuse(Reckless Strike:186) [enemy(#1).active]\nuse(Counterspell:308)\nuse(Call Lightning:204)\nchange(next)",
},
[154913] = {
["name"] = "Shadowspike Lurker",
["code"] = "use(claw:919) [ round=1 ]\nuse(flock:581)\nuse(pred:518)\nchange(next)",
},
["To a Land Down Under (Humanoid)"] = {
["name"] = "To a Land Down Under (Humanoid)",
["code"] = "change(next) [self.dead]\n\nuse(Jar of Smelly Liquid:1556) [!enemy.aura(Corrosion:446).exists]\nuse(Corrosion:447) [round=2]\nuse(Nether Gate:466) [round=3]\nuse(Corrosion:447)\n\nuse(Clobber:350)\nuse(Fish Slap:1737) [enemy(Bassalt:3560).active]\nuse(Bubble:934) [enemy(Clawz:3559).active]\nuse(Fish Slap:1737)\n\nuse(Ice Tomb:624)\nuse(Call Blizzard:206)\nuse(Ice Lance:413)",
},
[150929] = {
["name"] = "Nefarious Terry",
["code"] = "ability(Wind-Up:459) [round=1]\nability(Supercharge:208) [round=2]\nability(Wind-Up:459) [round=3]\nability(Powerball:566)\nchange(#2) [self(#1).dead]\nability(Bite:110) [self(#2).hp<300]\nability(Howl:362)\nability(Surge of Power:593)\nability(Dodge:312)\nability(Stampede:163) (edited)",
},
[79179] = {
["name"] = "Deebs, Tyri and Puzzle",
["code"] = "change(#3) [self.dead]\nchange(#1) [self(#3).active]\nuse(Sunlight:404) [!weather(Sunny Day:403) & self(#1).active]\nchange(#2) [self(#1).active]\nuse(Explode:282)\nuse(Bite:110) [enemy(Deebs:1400).active]\nuse(Solar Beam:753)",
},
[162468] = {
["name"] = "Tiny Madness",
["code"] = "ability(Shadow Slash:210) [round = 1]\nstandby [round = 2]\nability(Curse of Doom:218)\nability(Haunt:652)\nchange(Infected Squirrel:627)\nability(Rabid Strike:666) [!enemy.aura(Rabies:807).exists] \nability(Stampede:163)\nchange(Graves:1639)\nability(Grave Destruction:1411)\nability(Skull Toss:1483)",
},
[160205] = {
["name"] = "Pixy Wizzle",
["code"] = "use(Sunlight:404) [round=1]\nuse(Photosynthesis:268) [round=2]\nuse(Sunlight:404) [enemy.aura(Shattered Defenses:542).exists]\nuse(Lash:394) [enemy.aura(Healing Jolt:2367).exists]\nuse(Photosynthesis:268) [!self.aura(Photosynthesis:267).exists]\nuse(Sunlight:404)\nuse(Lash:394)",
},
[201802] = {
["name"] = "Sharp as Flint",
["code"] = "ability(Supercharge:208) [round=2]\nability(Toxic Smoke:640) [round>5]\nability(Wind-Up:459)\n\nability(Breath:115) [!enemy(Lord Flappinsby:3451).dead]\n\nability(Flock:581) [enemy.aura(Black Claw:918).exists]\nability(Black Claw:919)\n\nchange(Mechanical Pandaren Dragonling:844) [!enemy(Lord Flappinsby:3451).dead]\nchange(Ikky:1532)",
},
[173274] = {
["name"] = "Failed Experiment",
["code"] = "use(Glowing Toxin:270) [ round=1 ]\nuse(Explode:282)\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nchange(#2)",
},
[204926] = {
["name"] = "Delver Mardei",
["code"] = "use(Time Bomb:602)\nuse(Armageddon:1025) [ enemy.aura(Flame Breath:500).exists ]\nuse(Flame Breath:501)\nuse(Ice Tomb:624) [ !enemy.is(Dustie:3568) ]\nuse(Arcane Storm:589)\nuse(Breath:115)\nif [ enemy.is(Dustie:3568) ]\n    use(Howl:362) [ enemy.hp>1665 & self.aura(Dragonkin).exists ]\n    use(Howl:362) [ enemy.hp>1110 & !self.aura(Dragonkin).exists ]\n    use(Surge of Power:593)\nendif\nuse(Bite:110)\nchange(next)",
},
[202440] = {
["name"] = "Enok the Stinky",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652) [round=3]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(Hunting Party:921)\nability(Leap:364)\nability(#1)\nchange(next)",
},
[119342] = {
["name"] = "Angry Geode",
["code"] = "standby [ self.aura(734).exists ]\nability(513)\nability(123) [ self.round > 5 ]\nability(509)\nchange(#2)\n\nability(#3) [enemy.hp<618 & enemy.type !~ 3]\nability(#3) [enemy.hp<406 & enemy.type ~ 3]\nability(#2) [!self(#2).aura(820).exists]\nability(#1)",
},
[162469] = {
["name"] = "Brain Tickling",
["code"] = "change(#1) [self(#3).active]\n\nuse(Blistering Cold:786)\nuse(Chop:943)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nuse(#1)\nchange(next)",
},
[146181] = {
["name"] = "Living Permafrost",
["code"] = "change(next) [self.dead]\nability(Aged Yolk:667) [self.aura(Blistering Cold:785).exists]\nability(Backflip:669) [enemy.speed<276]\nability(Water Jet:118)",
},
["To a Land Down Under (Aquatic)"] = {
["name"] = "To a Land Down Under (Aquatic)",
["code"] = "quit [self(#1).dead & enemy.aura(Sewage Eruption:2063).exists]\n\nchange(#3) [enemy(#3).active & enemy.aura(Void Tremors:2359).exists & self(#2).active & self.hp>352]\n\nability(Sewage Eruption:2062)\nability(Moonfire:595)\n\nability(Feedback:484) [enemy(#1).active]\n\nability(Pump:297) [!self.aura(Pumped Up:296).exists & enemy(#2).active]\nability(Pump:297) [enemy(#2).active & enemy.hp<1226]\nability(Void Tremors:2360) [enemy.aura(Tough n' Cuddly:1111).exists & enemy(#3).active]\n\nability(Overcharge:2342) [enemy(#3).active & enemy.hp<116]\n\nability(#1)\nchange(next)",
},
["Are They Not Beautiful? (Flyer)"] = {
["name"] = "Are They Not Beautiful? (Flyer)",
["code"] = "quit [round = 2 & !enemy.aura(Stunned:927).exists]\nquit [round = 4 & self.hpp < 100]\n\nuse(Soulrush:752)\nuse(Ethereal:998) [enemy(#2).active]\nuse(Dark Talon:1233)\n\nuse(Shriek:784) [!enemy.aura(Attack Reduction:494).exists]\nuse(Arcane Storm:589)\nuse(Arcane Blast:421)\n\nchange(next)",
},
[201899] = {
["name"] = "A New Vocation",
["code"] = "standby [enemy.aura(Dodge:311).exists]\nability(Bubble:934) [enemy.aura(Flying:341).exists]\nability(Dive:564) [enemy.aura(Flying:341).exists]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
["To a Land Down Under (Elemental)"] = {
["name"] = "To a Land Down Under (Elemental)",
["code"] = "ability(Surge of Power:593) [!enemy.hp.full]\nability(Breath of Sorrow:1055) [enemy(Clawz:3559).active]\nability(Blast of Hatred:472)\nuse(Dive:564) [enemy(#3).active]\nuse(Whirlpool:513) [enemy(#3).active]\nability(Flash Freeze:1955)\nability(Geyser:418) [enemy(Murrey:3558).active]\nability(Water Jet:118)\nability(Call Lightning:204) [enemy.aura(Weakened Defenses:516).exists]\nability(Flyby:515)\nchange(next)",
},
[162470] = {
["name"] = "Living Statues Are Tough",
["code"] = "use(212) [round=1]\nuse(652)\nuse(581) [enemy.aura(918).exists]\nuse(919)\nchange(next)",
},
[160207] = {
["name"] = "Therin Skysong",
["code"] = "use(Disruption:1123) [enemy.aura(Unstable Engineering:2235).exists]\nuse(Life Exchange:277) [self(Ravenous Prideling:2590).hp <= 500]\nuse(Seethe:1056)\n\nuse(Drain Blood:1043) [enemy(Logic:2802).active && enemy(Logic:2802).hp <= 263 && enemy(Logic:2802).aura(Mechanical:244).exists]\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists && enemy.aura(Fel Immolate:900).exists]\nuse(Fel Immolate:901) [!enemy.aura(Fel Immolate:900).exists]\nuse(Drain Blood:1043)\nuse(Fel Immolate:901)\n\nuse(Inflation:1002)\n\nchange(Orphaned Felbat:2050) [self(Ravenous Prideling:2590).dead]",
},
["Do You Even Train? (Magic)"] = {
["name"] = "Do You Even Train? (Magic)",
["code"] = "if [enemy(#3).active]\nability(Ooze Touch:445)\nendif\nability(Void Nova:2356)\nability(Poison Protocol:1954)\nability(Ooze Touch:445)\nstandby [self(Anomalus).aura(Stunned).exists]\nchange(#2) [self(#1).dead]\nchange(#3) [self(#2).dead]",
},
[154916] = {
["name"] = "Ravenous Scalespawn",
["code"] = "use(blackclaw:919) [ round=1 ] \nuse(flock:581) \nuse(strike:504) \nchange(next)",
},
[99150] = {
["name"] = "Tiny Poacher, Tiny Animals",
["code"] = "-- rng in the beginning (<0.5%)\nquit [enemy(#1).dead & round=4]\n--\n-- rare case: too many critical strikes Ice lance Turn4+ 5\nuse(Explode:282) [enemy(#1).dead & enemy(#2).dead]\n--\nuse(Explode:282) [enemy(#1).dead & enemy(#3).dead & enemy(#2).hp<561]\nuse(Ice Tomb:624)\nuse(Call Blizzard:206)\nuse(Ice Lance:413)\nuse(Thunderbolt:779) [enemy(#3).active & enemy.aura(Stunned:927).exists]\nuse(Breath:115)\nchange(next)",
},
["Chen Stormstout"] = {
["name"] = "Chen Stormstout",
["code"] = "change(#2) [ self(#1).dead ]\nuse(Bombing Run:647) [ enemy.hp.full ]\nuse(Explode:282) [ enemy.hp.can_explode ]\nuse(Explode:282) [ enemy.aura(Bomb:819).duration = 1 & enemy.hp <= 1004 ]\nuse(Deflection:490) [ enemy(#2).active & enemy.ability(Lullaby:996).usable & !enemy.aura(Locust Swarm:1011).exists ]\nuse(Deflection:490) [ self.aura(Inebriate:1009).duration = 2 ]\nuse(Crush:406) [ enemy.hp <= 227 ]\nuse(Stoneskin:436) [ self.aura(Stoneskin:435).duration <= 1 ]\nuse(Healing Wave:123) [ self.hpp < 75 ]\nuse(#1)\nstandby",
},
[173372] = {
["name"] = "Natural Defenders",
["code"] = "use(Surge of Power:593) [enemy.hp<1111]\nuse(Tail Sweep:122) [round=1]\nuse(Arcane Storm:589) [round=2]\nuse(Mana Surge:489)\nuse(Wind-Up:459) [!enemy(#2).active]\nuse(Supercharge:208)\nuse(Call Lightning:204)\nuse(Howl:362)\nuse(Surge of Power:593)\nchange(next)",
},
[141529] = {
["name"] = "Marshdwellers",
["code"] = "use(Predatory Strike) [enemy.aura(Shattered Defenses:542).exists]\nuse(Falcosaur Swarm!)\nchange(#2)\nuse(Arcane Storm)\nuse(Mana Surge)\nuse(Tail Sweep)\nchange(#3)",
},
[162471] = {
["name"] = "Flight of the Vil'thik",
["code"] = "change(#3) [self(#2).active]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nuse(Howl:362) [enemy.aura(601).duration=1]\nuse(Surge of Power:593) [enemy.aura(Howl:1725).exists]\nstandby\nchange(next)",
},
[160208] = {
["name"] = "Zuna Skullcrush",
["code"] = "-- just in case\nuse(Predatory Strike:518) [enemy(#3).active]\n--\nchange(#2) [round~4,15]\nchange(#1) [round=12]\nuse(Crouch:165) [round=7]\nuse(Glowing Toxin:270) [round=3]\nuse(Glowing Toxin:270) [!enemy.aura(Glowing Toxin:271).exists]\nuse(Amber Prison:1026)\nuse(Bash:348) [round~5,11]\nuse(Bash:348) [enemy(#3).active]\nuse(Trample:377)\nuse(Twilight Meteorite:1960) [self.aura(Dragonkin:245).exists]\nuse(Phase Shift:764) [enemy.hp>800]\nuse(Tail Sweep:122)\nchange(#3)\nchange(next)",
},
[119407] = {
["name"] = "Cookie's Leftovers",
["code"] = "standby [ self.aura(926).exists & self.speed.fast ]\nability(334)\nability(779)\nability(115)\nchange(#2)\nability(312) [ enemy.ability(#3).usable ]\nability(574) [ self.aura(820).duration < 2 & self.speed.slow ]\nability(574) [ !self.aura(820).exists ]\nability(504)",
},
[72009] = {
["name"] = "Xu-Fu, Cub of Xuen",
["code"] = "if [ self(Alpine Foxling:724).active ]\nability(Dazzling Dance:366) [ !self.aura(Dazzling Dance:365).exists ]\nability(Howl:362)\nchange(next)\nendif\nability(Toxic Smoke:640) [ !enemy.aura(Toxic Smoke:639).exists ]\nability(Explode:282)\nability(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nability(Flock:581)\nability(#1)\nchange(next)",
},
["Are They Not Beautiful? (Dragon)"] = {
["name"] = "Are They Not Beautiful? (Dragon)",
["code"] = "use(Mana Surge:489) [weather(Arcane Winds:590).duration>1]\nuse(Surge of Power:593) [enemy(#3).active & enemy.hp<1099]\nuse(Surge of Power:593) [enemy(#3).active & self.aura(Dragonkin:245).exists]\nuse(Arcane Storm:589)\n\nuse(Arcane Blast:421)\nuse(#1)\n\nchange(next)",
},
[71929] = {
["name"] = "Sully \"The Pickle\" McLeary",
["code"] = "use(Drain Blood:1043) [enemy.aura(Undead:242).exists]\nuse(Lift-Off:170) [enemy.aura(Underground:340).exists]\nuse(Drain Blood:1043) [enemy.aura(Vicious Streak:850).exists]\nuse(Drain Blood:1043) [enemy(Rikki:1290).active]\nuse(Lift-Off:170) [enemy(Rikki:1290).active]\nuse(Call Darkness:256) [enemy(Rikki:1290).active]\nuse(Nocturnal Strike:517) [enemy(Rikki:1290).active]\nuse(Flurry:360)\nuse(Bite:110)\nchange(next)",
},
[141814] = {
["name"] = "Accidental Dread",
["code"] = "if [ !self(#2).active ]\n    ability(Life Exchange:277) [ enemy(#2).active ]\n    ability(Moonfire:595) [ enemy.round<3 ]\n    ability(Arcane Blast:421)\nendif\nchange(#3) [ self(#2).played ]\nchange(#2) [ !self(#2).played ]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(Tail Sweep:122)",
},
[160209] = {
["name"] = "Horu Cloudwatcher",
["code"] = "ability(Bubble:934) [round=1]\nability(Stampede:163) [!enemy.aura(Shattered Defenses:542).exists]\nability(Explode:282) [self.hp<1061 & enemy.round>1 & enemy(#3).active]\nability(Supercharge:208) [enemy(#3).active]\nability(#1)\nchange(next)",
},
[201858] = {
["name"] = "Lyver",
["code"] = "use(919) [round=1] \nuse(581) [round=2] \nuse(1370) [round=5]",
},
[154918] = {
["name"] = "Kelpstone",
["code"] = "change(#2) [self(#1).dead]\nability(Exposed Wounds:305)\nstandby [round=2]\nability(Flock:581) [round=4]\nability(Black Claw:919)",
},
[141945] = {
["name"] = "Snakes on a Terrace",
["code"] = "standby [ round=1 ]\nuse(Magic Sword:1085) [ enemy(Clubber:2355).active ]\nchange(#3)\nstandby [enemy.aura(Underwater:830).exists ]\nuse(Leap:364) [ enemy.hp<730 ]\nuse(Hunting Party:921) [ enemy.aura(claw:918).exists ]\nuse(Leap:364) [ enemy(Squeezer:2353).aura(claw:918).exists ]\nuse(Black Claw:919)\nuse(#1)\nchange(#1)",
},
[200689] = {
["name"] = "Wildfire - Rare",
["code"] = "ability(Blistering Cold:786)\nability(Chop:943) [!enemy.aura(Bleeding:491).exists]\nability(BONESTORM!!:1762) [!self.aura(Undead:242).exists]\nability(Chop:943)\n\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Hunting Party:921)\n\nchange(next)",
},
[196069] = {
["name"] = "The Grand Master (Humanoid)",
["code"] = "change(#2) [round=6]\nuse(Ice Tomb:624) [enemy(#1).active]\nuse(Call Blizzard:206) [round=2]\nuse(Ice Lance:413)\nuse(Poison Protocol:1954)\nuse(Void Nova:2356)\nuse(Corrosion:447)\nchange(#3)",
},
[119344] = {
["name"] = "Klutz's Battle Bird",
["code"] = "ability(589)\nability(489)\nability(122)\nchange(#2)\nability(597) [ self.aura(823).duration < 2 & self.speed.slow ]\nability(597) [ !self.aura(823).exists ]\nability(598) [ self.hpp < 50 ]\nability(525)",
},
[71930] = {
["name"] = "Shademaster Kiryn",
["code"] = "change(#3) [enemy(Eté:1286).active & !self(#3).played]\nchange(#2) [self(#3).active]\n\nuse(Frappé par l’amour:772) [enemy(Stormoen:1287).active]\n\nuse(Malédiction funeste:218) [!enemy(Eté:1286).active]\nuse(Horion de l’ombre:422) [enemy(Nairn:1288).active]\n\nstandby [enemy.aura(Esquive:311).exists]\nuse(Prison de cristal:569) [enemy.aura(Rôder:543).exists]\nuse(Peau de pierre:436) [enemy(Eté:1286).active & !self.aura(Peau de pierre:435).exists ]\nuse(Peau de pierre:436) [enemy(Eté:1286).active & enemy.round =1]\nuse(Brûlure:113)\n\nuse(Frappé par l’amour:772) [enemy.aura(Rôder:543).exists]\nuse(Horion de l’ombre:422)\n\nchange(#1)",
},
[160210] = {
["name"] = "Tasha Riley",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Swarm:706)\nability(Inflation:1002) [enemy(#3).active]\nability(#2)\nability(#3)\nability(#1)\nchange(next)",
},
[72291] = {
["name"] = "Yu'la, Broodling of Yu'lon",
["code"] = "standby [round=5]\nuse(Darkflame:792) [round=7]\nchange(#1) [self(#3).active]\nuse(Murder the Innocent)\nuse(Eyeblast:475)\nchange(next)",
},
[119408] = {
["name"] = "\"Captain\" Klutz",
["code"] = "standby [ enemy.round < 3 ]\nability(218)\nability(652)\nchange(#2)\nability(919) [ !enemy.aura(918).exists ]\nability(581)",
},
[189376] = {
["name"] = "Swog the Elder (Humanoid)",
["code"] = "change(#1) [self(#3).active]\nuse(Sunlight:404) [round=1]\nuse(Murder the Innocent:2223)\nif [self(#3).played]\nuse(Solar Beam:753)\nuse(Skitter:626)\nuse(Darkflame:792)\nuse(Scorched Earth:172)\nuse(Eyeblast:475)\nuse(Eye Beam:1533)\nuse(Trample:377)\nendif\nchange(next)",
},
["Are They Not Beautiful? (Humanoid)"] = {
["name"] = "Are They Not Beautiful? (Humanoid)",
["code"] = "change(#2) [round=4]\nquit [self(#3).active & enemy(#2).active]\nuse(Soulrush:752) [enemy(Beeks:3566).active]\nuse(Creeping Insanity:1760) [!enemy(Beeks:3566).active]\nuse(Spiritfire Bolt:1066)\nuse(Ice Lance:413) [enemy(Fethres:3565).active]\nuse(Gift of Winter's Veil:586)\nuse(Call Blizzard:206)\nuse(Ice Lance:413)\nchange(Void-Scarred Anubisath:2833) [self.dead]\nuse(Weakness:471) [enemy.aura(Creeping Insanity:1759).exists]\nuse(Nether Blast:608)",
},
["Are They Not Beautiful? (Mech)"] = {
["name"] = "Are They Not Beautiful? (Mech)",
["code"] = "ability(Supercharge:208) [round=1]\nability(Ion Cannon:209) [round=2]\n\nability(Powerball:566) [enemy(#3).active]\nability(Powerball:566) [enemy.hp<271]\nability(Supercharge:208) [enemy(#2).active & enemy.hp>893 & self(#2).active & self.aura(Wind-Up:458).exists]\n\nability(Decoy:334) [enemy(#3).active & enemy.ability(Conflagrate:179).duration=1]\nability(Time Bomb:602)\n\nability(#1)\nchange(next)",
},
[200692] = {
["name"] = "Tremblor - Legendary",
["code"] = "use(Blistering Cold:786)\nuse(Chop:943)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nuse(Hunting Party:921)\nuse(Leap:364)\nchange(next)",
},
[68465] = {
["name"] = "Thundering Pandaren Spirit",
["code"] = "change(#1) [enemy(#2).active & enemy.aura(Flame Breath:500).exists & enemy.aura(Razor Talons:2238).exists]\nuse(Feign Death:568) [enemy(#2).active]\nuse(Swarm of Flies:232) [round=4]\nuse(Swarm of Flies:232) [enemy(#3).active & enemy.aura(Poisoned:379).exists]\n\nuse(Flame Breath:501) [self.round=1 & enemy(#2).active]\nuse(Needle Claw:2375)\nuse(Razor Talons:2237) [!enemy.aura(Razor Talons:2238).exists]\n\nuse(Flame Breath:501)\nchange(#2)",
},
[200678] = {
["name"] = "Storm-Touched Slyvern",
["code"] = "use(Arcane Storm:589) [round=1]\nuse(Mana Surge:489)\nchange(Arcane Eye:1160)\nuse(Eyeblast:475)\nuse(#1)\nchange(next)",
},
[119345] = {
["name"] = "Klutz's Battle Monkey",
["code"] = "ability(Ironskin:1758) [ round>2 ]\nability(Predatory Strike:518) [ enemy.aura(Shattered Defenses:542).exists & enemy.hpp>25 ]\nability(#1)\nchange(#2)",
},
[154920] = {
["name"] = "Frenzied Knifefang",
["code"] = "ability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(Falcosaur Swarm!:1773)\nchange(next)",
},
["Do You Even Train? (Elemental)"] = {
["name"] = "Do You Even Train? (Elemental)",
["code"] = "use(Bubble:934)\nuse(Barrel Toss:354)\nuse(Scorched Earth:172)\nuse(Conflagrate:179) [ enemy.is(Swole:3573) ]\nuse(Flame Breath:501)\nuse(Puppies of the Flame:1354) [ enemy.aura(Underwater:830).exists ]\nif [ !enemy.ability(Headbutt:376).usable & enemy.ability(Dive:564).usable ]\n    if [ weather(Scorched Earth:171) ]\n        use(Puppies of the Flame:1354) [ self(#2).power=305 & enemy.hp>380 ]\n        use(Puppies of the Flame:1354) [ self(#2).power=289 & enemy.hp>376 ]\n        use(Puppies of the Flame:1354) [ self(#2).power=276 & enemy.hp>374 ]\n        use(Puppies of the Flame:1354) [ self(#2).power=260 & enemy.hp>371 ]\n    endif\n    use(Puppies of the Flame:1354) [ enemy.hp>315 ]\nendif\nif [ enemy.is(Swole:3573) & !enemy.aura(Underwater:830).exists ]\n    use(Superbark:1357) [ weather(Scorched Earth:171) ]\n    use(Superbark:1357) [ enemy.hp>315 ]\nendif\nuse(Blazing Yip:1359)\nstandby [ self.aura(Stunned:927).exists ]\nchange(next)",
},
[142234] = {
["name"] = "Small Beginnings",
["code"] = "change(Nexus Whelpling:1165) [ self(Iron Starlette:1387).dead ]\nability(Supercharge:208) [ self.round = 2 ]\nability(Wind-Up:459)\nability(Arcane Storm:589) [ self.round = 1 ]\nability(Mana Surge:489)\nability(Tail Sweep:122)\nability(Black Claw:919) [ self.round = 1 ]\nability(Flock:581)",
},
[173376] = {
["name"] = "Lurking In The Shadows",
["code"] = "use(Appel de la foudre:204)\nuse(Détraqué:916)",
},
[200693] = {
["name"] = "Tremblor - Rare",
["code"] = "ability(Blistering Cold:786)\nability(Chop:943) [!enemy.aura(Bleeding:491).exists]\nability(BONESTORM!!:1762)\n\nability(Primal Cry:920)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Hunting Party:921)\n\nability(#1)\nchange(next)",
},
[71931] = {
["name"] = "Taran Zhu",
["code"] = "ability(Call Lightning:204)\nstandby [ round=2 ]\n\nchange(Infernal Pyreclaw:2089)\nability(Great Sting:1966) [ self.round=1 ]\nstandby [ self.round=5 ]\nstandby [ self.round=6 ]\nability(Great Sting:1966) [ self.round=7 ]\nability(Cleave:1273)\n\nchange(Anomalus:2842)\nability(Poison Protocol:1954)\nability(Void Nova:2356)\nability(Corrosion:447)",
},
["Yu'la, Broodling of Yu'lon"] = {
["name"] = "Yu'la, Broodling of Yu'lon",
["code"] = "standby [round=5]\nuse(Darkflame:792) [round=7]\nchange(#1) [self(#3).active]\nuse(Murder the Innocent)\nuse(Eyeblast:475)\nchange(next)",
},
[162461] = {
["name"] = "I Am The One Who Whispers",
["code"] = "ability(Curse of Doom:218) [round=2]\nability(Haunt:652) [round=3]\nability(Black Claw:919) [self.round=1]\nability(Flock:581) [!enemy.aura(Shattered Defenses:542).exists]\nability(#1)\nchange(next)",
},
[119409] = {
["name"] = "Foe Reaper 50",
["code"] = "ability(418)\nability(564)\nability(118)\nchange(#2)\nability(#1)",
},
[141879] = {
["name"] = "Keeyo's Champions of Vol'dun",
["code"] = "change(#2) [enemy(#2).active]\nability(459) [self.aura(458).exists]\nability(1921) [self.round=1]\nability(459) [self.round=2]\nability(#3)\nability(974) [enemy(#3).active]\nability(595) [enemy(#1).active]\nchange(#1) [self(#2).dead]",
},
[141215] = {
["name"] = "Unbreakable",
["code"] = "ability(decoy:334) [round=1]\nchange(#2) [round=2]\nchange(#3) [round=3]\nability(#3) [ enemy.aura(Broken Shell:2111).exists ]\nability(#2)\nability(#1)",
},
[173377] = {
["name"] = "Airborne Defense Force",
["code"] = "use(Void Crash:2358)\nuse(Flame Breath:501) [round=3]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nif [enemy(#2).active]\nstandby [round=6 & !enemy(#1).dead & enemy(#1).hp<207]\nuse(Arcane Explosion:299)\nendif\nuse(Howl:362) [!self.aura(Dragonkin:245).exists]\nuse(Surge of Power:593)\nchange(next)",
},
[140880] = {
["name"] = "What's the Buzz?",
["code"] = "ability(Emerald Presence:597) [ !self.aura(Emerald Presence:823).exists ]\nability(Emerald Presence:597) [ self.aura(Emerald Presence:823).duration = 1 ]\nability(Emerald Dream:598) [ self.hp <750 ]\nstandby",
},
[141046] = {
["name"] = "Captured Evil",
["code"] = "ability(321)\nability(#2)\nability(#3)\nability(#1)\nchange(next)",
},
[104970] = {
["name"] = "Dealing with Satyrs",
["code"] = "standby [round=2]\nuse(Zeitbombe:602) [enemy(#1).active]\nuse(Zeitbombe:602) [enemy(#1).dead]\nuse(Armageddon:1025) [enemy(#3).active & enemy.aura(Zeitbombe:601).duration=1]\n\nuse(Elementiumblitz:606) [enemy(#1).active]\n\nuse(Entzünden:178)\nuse(Flammenatem:501) [enemy.hp>396]\nuse(Armageddon:1025)\n\nchange(#1)",
},
[155145] = {
["name"] = "Plagued Critters",
["code"] = "ability(Rain Dance:1062) [ round>2 ]\nability(Water Jet:118) [enemy(#2).dead & enemy(#3).dead]\nability(Tidal Wave:419)\nchange(next)",
},
["To a Land Down Under (Undead)"] = {
["name"] = "To a Land Down Under (Undead)",
["code"] = "use(Enrage:1392) [!self.aura(Enraged:1391).exists && self.ability(Soulrush:752).usable]\nuse(Reflective Shield:1105) [enemy(Murrey:3558).active]\nuse(Spiritfire Bolt:1066) [enemy.hp < 216]\nuse(Soulrush:752)\nuse(Spiritfire Bolt:1066)\n\nuse(Toxic Smoke:640) [!enemy.aura(Toxic Smoke:639).exists]\nuse(Slime:1763)\n\nchange(next)",
},
[204934] = {
["name"] = "Do You Even Train?",
["code"] = "use(Moonfire:595) [!weather(Moonlight:596)]\nuse(Prowl:536) [enemy(Lifft:3572).active]\nuse(Spirit Claws:974)\n\nuse(Decoy:334) [enemy(Swole:3573).active]\nuse(Breath:115)\n\nuse(Deflection:490) [enemy(Swole:3573).aura(Underwater:830).exists]\nuse(Rampage:124) [!enemy(Swole:3573).ability(Dive:564).usable]\nuse(Triple Snap:355)\n\nstandby\nchange(next)",
},
["Do You Even Train? (Mech)"] = {
["name"] = "Do You Even Train? (Mech)",
["code"] = "change(#3) [ enemy.is(Swole:3573) & self.aura(Decoy:333).exists ]\nchange(#3) [ enemy.is(Swole:3573) & !enemy.ability(Headbutt:376).usable ]\nuse(Powerball:566) [ !self.speed.fast ]\nif [ self.aura(Wind-Up:458).exists ]\n    use(Supercharge:208) [ enemy.is(Lifft:3572) & enemy.ability(Dive:564).duration~2,3,4 ]\n    use(Powerball:566) [ enemy.aura(Underwater:830).exists ]\n    use(Wind-Up:459) [ enemy.is(Brul'dan:3571) ]\nendif\nuse(Powerball:566) [ enemy.is(Brul'dan:3571) & self.aura(Mechanical:244).exists & !enemy.ability(Drain Power:486).usable ]\nuse(Wind-Up:459)\nif [ enemy.is(Brul'dan:3571) ]\n    use(Time Bomb:602) [ enemy.hp<1097 ]\n    use(Decoy:334) [ enemy.hp<549 & !enemy.aura(Flame Breath:500).exists ]\nendif\nuse(Flame Breath:501) [ !enemy.is(Swole:3573) ]\nuse(Alert!:1585) [ enemy.hp>1726 ]\nuse(Alert!:1585) [ enemy.is(Brul'dan:3571) ]\nuse(Ion Cannon:209) [ self.aura(Supercharged:207).exists ]\nuse(Supercharge:208)\nstandby [ self(#2).active ]\nchange(next)",
},
["Chi-Chi, Hatchling of Chi-Ji (2)"] = {
["name"] = "Chi-Chi, Hatchling of Chi-Ji (2)",
["code"] = "ability(Immolation:409) [!self.aura(Immolation:408).exists]\nability(Wild Magic:592) [!enemy.aura(Wild Magic:591).exists]\nability(Acidic Goo:369) [self.round=1]\nability(Dive:564) [self.round=4]\nchange(#2)\nability(#1)",
},
[119346] = {
["name"] = "Unfortunate Defias",
["code"] = "ability(Bubble:934)\nability(Swarm of Flies:232) [ !enemy.aura(Swarm of Flies:231).exists ]\nability(Tongue Lash:228)\nchange(#2)\nability(Nature's Ward:574) [ !self.aura(Nature's Ward:820).exists ]\nability(Alpha Strike:504) [ enemy.hp > 309 ]\nability(Ravage:802)",
},
[71932] = {
["name"] = "Wise Mari",
["code"] = "ability(Blingtron Gift Package:989) [ enemy.aura(Make it Rain:986).duration=1 ]\nability(Make it Rain:985)\nability(Inflation:1002)\nability(Consume Magic:1231) [ self.aura(Whirlpool:512).exists ]\nability(Creeping Ooze:448)\nchange(#2)",
},
[139987] = {
["name"] = "This Little Piggy Has Sharp Tusks",
["code"] = "change(next) [ self(#1).dead & !self(#3).played ] \nability(#2) [ !enemy.aura(217).exists ] \nability(#3) \nability(#1)",
},
[85685] = {
["name"] = "Stitches Jr.",
["code"] = "standby [round~3,7]\nability(Supercharge:208) [round=5]\nability(Wind-Up:459)\nchange(#2)",
},
[154923] = {
["name"] = "Sputtertube",
["code"] = "use(Black Claw:919) [round=1]\nuse(Flock:581)\nchange(#2)\nuse(Flamethrower:503) [!enemy(Sputtertube:2736).aura(Flamethrower:502).exists]\nuse(Burn:113)",
},
[173315] = {
["name"] = "Resilient Survivors",
["code"] = "ability(Prowl:536) [self.aura(Blinding Poison:1048).exists]\nstandby [self.aura(Blinding Poison:1048).exists]\nability(Whirlpool:513) [enemy.round=1]\nability(Dive:564) [round=2]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
[116792] = {
["name"] = "Phyxia",
["code"] = "use(Supercharge:208) [enemy.hp>361]\nuse(Repair:278) [round=3]\nuse(Metal Fist:384)\nuse(#1)\nchange(next)",
},
[161649] = {
["name"] = "Rampage",
["code"] = "ability(Toxic Skin:1087) [self.aura(Toxic Skin:1086).duration<2]\nability(Flyby:515) [!enemy.aura(Weakened Defenses:516).exists]\nability(Infected Claw:117)\n\nability(#1)\nstandby\nchange(next)",
},
[107489] = {
["name"] = "Fight Night: Amalia",
["code"] = "change(#1) [self(#2).active]\nchange(#2) [enemy.aura(Cute Face:904).exists & !self(#2).played]\nchange(#3) [enemy(#3).active]\nuse(Cleansing Rain:230) [self.aura(Pumped Up:296).exists]\nuse(Acid Rain:1051) [self.aura(Pumped Up:296).exists]\nuse(Pump:297)\nuse(Focus:426) [self.aura(Focused:425).duration<2]\nuse(Sandstorm:453)\nuse(Zap:116)",
},
[104553] = {
["name"] = "Snail Fight!",
["code"] = "change(#1) [self(#3).played]\nchange(#2) [round=2]\nchange(#3) [round=4]\nuse(Great Sting:1966)\nstandby [round=5 & self(#2).dead]\nuse(Enrage:1392) [!self.aura(Enraged:1391).exists]\nuse(Impale:800)\nuse(Pheromones:1063)",
},
["Ashes Will Fall"] = {
["name"] = "Ashes Will Fall",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\n\nuse(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nuse(Hunting Party:921)\nuse(#1)\nchange(next)",
},
["Are They Not Beautiful? (Magic)"] = {
["name"] = "Are They Not Beautiful? (Magic)",
["code"] = "change(next) [self.dead]\nuse(#1) [enemy.hp < 300]\nuse(Hatred Manifest:2505)\nuse(Murder the Innocent:2223)\nuse(Nether Gate:466)\nuse(Stampede:163)\nuse(Spectral Spine:913) [enemy(Talons:3567).active]\nuse(#1)\nchange(next)",
},
[154924] = {
["name"] = "Goldenbot XD",
["code"] = "change(#2) [ round=3 ]\nchange(#1) [ self(#2).active ]\nuse(786)\nstandby [self(#1).active]\nuse(919) [ self.round = 1 ]\nuse(581)\nchange(#3)",
},
["Xu-Fu, Cub of Xuen"] = {
["name"] = "Xu-Fu, Cub of Xuen",
["code"] = "use(Call Lightning:204) [round=1]\nchange(#2) [round = 2]\nuse(Make it Rain:985)\nuse(Inflation:1002)\nchange(#3) [self(#2).dead & self(#1).played]\nuse(Shock and Awe:646)\nuse(Ion Cannon:209)",
},
[99210] = {
["name"] = "Fight Night: Bodhi Sunwayver",
["code"] = "use(#1) [round>5]\nuse(#2) [round~1,5]\nuse(#3) [round~2,4]\nchange(next)",
},
[161650] = {
["name"] = "Liz",
["code"] = "ability(Call Lightning:204)\nability(Zap:116) [enemy.aura(Swarm of Flies:231).exists]\nability(Swarm of Flies:232)\nchange(#2)\nuse(Decoy:334)",
},
[200697] = {
["name"] = "Flow - Rare",
["code"] = "use(Haunt:652)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Hunting party:921)\nuse(Leap:364)\nchange(next)\n\n--Script created by Anolaszun#1423",
},
[71933] = {
["name"] = "Blingtron 4000",
["code"] = "ability(Pump:297) [round~1,3]\nability(Water Jet:118)\n\nability(Nature's Ward:574) [!self.aura(Nature's Ward:820).exists]\nability(Hawk Eye:521) [!self.aura(Hawk Eye:520).exists]\nability(Claw:429)\n\nability(Conflagrate:179) [enemy.aura(Immolate:177).exists]\nability(Immolate:178) [!enemy.aura(Immolate:177).exists]\nability(Burn:113)\n\nchange(next)",
},
[162458] = {
["name"] = "Retinus the Seeker",
["code"] = "use(Explode:282) [enemy.hp<610]\nuse(Flock:581) [enemy.aura(Black Claw:918).exists]\nuse(Black Claw:919)\nuse(Thunderbolt:779)\nuse(Missile:777)\nchange(next)",
},
[145968] = {
["name"] = "Leper Rat",
["code"] = "use(Brumes de rénovation:511) [!self.aura(Brumes de rénovation:510).exists]\nuse(Carapace bouclier:310) [enemy.aura(Mort-vivant:242).exists]\nuse(Carapace bouclier:310) [self.aura(Carapace bouclier:309).duration<=1]\n\nuse(#1)\nstandby\nchange(next)",
},
[154925] = {
["name"] = "Creakclank",
["code"] = "standby [round=1]\nchange(Boneshard:1963) [round=2]\nuse(Blistering Cold:786)\nuse(Chop:943) [!enemy.aura(Bleeding:491).exists]\nuse(BONESTORM:1762)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nchange(Ikky:1532)",
},
["Zao, Calfling of Niuzao"] = {
["name"] = "Zao, Calfling of Niuzao",
["code"] = "use(167)\nuse(411)\nuse(919) [ round=3 ]\nuse(921)\nchange(#2)",
},
[154915] = {
["name"] = "Elderspawn of Nalaada",
["code"] = "ability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(#2) [self.round=1]\nability(#3)\nchange(next)",
},
[173381] = {
["name"] = "Ardenweald's Tricksters",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\nchange(Ikky:1532)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)",
},
[99182] = {
["name"] = "Fight Night: Sir Galveston",
["code"] = "change(#3) [self(#2).played]\nuse(Armageddon:1025) [round=4]\nuse(Zeitbombe:602) [round=3]\nuse(Flammenatem:501)\nuse(Tiefer Atem:169) [enemy(#2).active]\nuse(Dunkelheit herbeirufen:256)\nchange(#2)",
},
[105386] = {
["name"] = "Rydyr",
["code"] = "use(Glowing Toxin:270) [ round=1 ]\nuse(Explode:282)\nchange(#2)",
},
[197447] = {
["name"] = "Eye of the Stormling (Dragon)",
["code"] = "ability(Explode:282)\nability(Pump:297)\nchange(next)",
},
[146182] = {
["name"] = "Living Sludge",
["code"] = "change(Chitterspine Skitterling:2648) [enemy.type=4]\nchange(Terrible Turnip:650) [enemy.type=10]\nchange(next) [self.dead]\nability(Dive:564)\nability(Bubble:934)\nability(Pinch:2067)\nability(Black Claw:919) [enemy.aura(Black Claw:918).exists]\nability(Swarm:706)\nability(Skitter:626)\nability(Sons of the Root:828)\nability(Leech Seed:745)\nability(Tidal Wave:419)",
},
[154926] = {
["name"] = "CK-9 Micro-Oppression Unit",
["code"] = "change(#2) [round=3 & enemy.hp>1153]\nchange(#2) [self.aura(Stunned:927).exists]\nuse(Flyby:515) [round=1]\nuse(Thunderbolt:779)\nuse(Explode:282)\nchange(#1)\nchange(#2)",
},
[201878] = {
["name"] = "Paws of Thunder",
["code"] = "use(Toxic Fumes:2349)\nuse(Poison Protocol:1954)\nuse(Time Bomb:602)\nuse(Armageddon:1025)\n\nstandby [enemy(#2).active & enemy.hp<733 & enemy.aura(601).duration=1]\nif [enemy(#2).aura(927).exists]\nuse(Puncture Wound:1050)\nstandby [enemy(#2).active]\nendif\n\nuse(Impale:800)\nuse(Slicing Wind:420)\nchange(next)",
},
[155413] = {
["name"] = "Postmaster Malown",
["code"] = "use(Swarm of Flies:232) [enemy(#1).aura(Undead:242).exists]\nuse(Swarm of Flies:232) [round=1]\nuse(Bubble:934) [self.aura(Curse of Doom:217).duration=1]\nuse(Swarm of Flies:232) [!enemy.aura(Swarm of Flies:231).exists]\nuse(Tongue Lash:228)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nchange(next) [self.dead]",
},
[202452] = {
["name"] = "Right Twice a Day",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(#1)\nchange(next)",
},
[105323] = {
["name"] = "Clear the Catacombs",
["code"] = "use(Extra Plating:392) [!self.aura(Extra Plating:391).exists]\nuse(Make it Rain:985) [!enemy.aura(Make it Rain:986).exists]\nuse(Inflation:1002)\nchange(Ikky:1532) [self(#1).dead]\nuse(Savage Talon:1370) [!enemy(Ancient Catacomb Spider:1860).dead]\nif [enemy(Catacomb Bat:1861).active]\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nendif\nuse(Flock:581)\nchange(Iron Starlette:1387) [enemy(Catacomb Snake:1862).active]\nuse(Supercharge:208) [self.aura(Wind-Up:458).exists]\nuse(Wind-Up:459)",
},
[71934] = {
["name"] = "Dr. Ion Goldbloom",
["code"] = "use(Howl:362) [enemy.aura(Flying:341).exists]\nuse(Surge of Power:593) [enemy.aura(Howl:1725).exists]\nuse(Arcane Explosion:299)\nuse(Conflagrate:179) [enemy(#3).active]\nuse(Flame Breath:501) [!enemy.aura(Flame Breath:500).exists]\nuse(Scorched Earth:172)\nuse(Ion Cannon:209) [enemy(#3).hp<1142]\nuse(#1)\nchange(next)",
},
[160206] = {
["name"] = "Alran Heartshade",
["code"] = "use(Apocalipsis:519) [enemy.hp.full]\nuse(Cauterizar:173)\n\nchange(Putrinfecto:1629)\nuse(Putrefacción:476) [enemy(Ruddy:2805).active]\nuse(Deflagración de cadáver:663) [enemy(Ruddy:2805).active]\nstandby [self.aura(Aturdido:927).exists]\n\nchange(Cucaracha experimental:2664)\nuse(Mordedura enfermiza:499) [enemy.aura(Defensas desarmadas:542).exists]\nuse(Enjambre:706) [self.aura(Glándulas suprarrenales:841).exists]\nuse(Glándulas suprarrenales:197)\n\nuse(#1)",
},
[146002] = {
["name"] = "Gnomeregan Guard Wolf",
["code"] = "use(Sandstorm:453)\nuse(Rupture:814)\nuse(Crush:406)\nuse(#3)\nuse(#2)\nuse(#1)\nchange(#2)\nchange(#3)",
},
[154927] = {
["name"] = "Unit 35",
["code"] = "ability(Rabid Strike:666) [!enemy.aura(Rabies:807).exists]\nability(Corpse Explosion:663)\n\nability(Fire Shield:1754)\nability(Flamethrower:503)\n\nchange(next)",
},
["Are They Not Beautiful? (Beast)"] = {
["name"] = "Are They Not Beautiful? (Beast)",
["code"] = "use(Feathered Frenzy:1398) [ round=1 ]\nuse(Gift of Winter's Veil:586)\nuse(Pounce:535)\nuse(Prowl:536)\nuse(Arcane Dash:1536)\nuse(Moonfire:595)\nchange(next)",
},
[150911] = {
["name"] = "Crypt Fiend",
["code"] = "use(Lightning Shield:906) \nuse(Fire Shield:1754) \nuse(Arcane Blast:421) \nuse(Decoy:334) \nuse(Thunderbolt:779) \nuse(Breath:115) \nuse(#1) \nchange(next)",
},
[72285] = {
["name"] = "Chi-Chi, Hatchling of Chi-Ji",
["code"] = "standby [round=3]\nability(Curse of Doom:218)\nability(Haunt:652)\nability(Creeping Fungus:743) [self.round=2]\nability(#1)\nchange(next)",
},
[145971] = {
["name"] = "Cockroach",
["code"] = "ability(Barkskin:1045) [!self.aura(Barkskin:1044).exists]\nability(Dazzling Dance:366) [enemy.aura(Dodge:2060).exists]\nability(#1)\n\nchange(next)",
},
[197417] = {
["name"] = "Mini Manafiend Melee (Aquatic)",
["code"] = "use(Messerkrallen:2237) [round=2]\nuse(Armageddon:1025) [round=4]\nuse(Flammenatem:501)\nuse(Explodieren:282)\nchange(next)",
},
[142114] = {
["name"] = "Add More to the Collection",
["code"] = "change(#3) [enemy(#3).active]\nability(어슬렁:536) [enemy(#2).active]\nability(비전 폭풍:589)\nability(부정한 희생:321)\nability(#2)\nability(#1) \nchange(next)",
},
[66739] = {
["name"] = "Wastewalker Shu",
["code"] = "change(#3) [ self(#1).active & self.dead ]\nchange(#2) [ self(#3).active ]\nchange(#3) [ self(#2).active & self.dead ]\n\nif [ self(#1).active & enemy(#1).active ]\nuse(Breath:115) [ enemy(#1).hp<248 ]\nuse(Thunderbolt:779)\nuse(Decoy:334) [ round=2 ]\nuse(Decoy:334) [ self.aura(Whirlpool:512).exists ]\nuse(Breath:115)\nendif\n\nif [ self(#1).active & enemy(#2).active ]\nuse(Decoy:334)\nuse(Thunderbolt:779)\nuse(Breath:115)\nendif\n\nstandby [ self.aura(Stunned:927).exists ]\nuse(Wind-Up:459) [ enemy(#3).active ]\nuse(Toxic Smoke:640) [ enemy(#1).active ]\nuse(Toxic Smoke:640) [ enemy(#2).hp<190 ]\nuse(Supercharge:208) [ self.aura(Wind-Up:458).exists ]\nuse(Wind-Up:459) (edited)",
},
[154928] = {
["name"] = "Unit 6",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652)\nability(Black Claw:919) [self.round=1]\nability(Flock:581)\nability(#1)\nchange(next)",
},
["To a Land Down Under (Dragon)"] = {
["name"] = "To a Land Down Under (Dragon)",
["code"] = "ability(Moonfire:595) [self.ability(Moonfire:595).usable]\nability(Life Exchange:277) [enemy(Clawz:3559).active]\nability(Arcane Blast:421)\nability(Howl:362)\nability(Surge of Power:593)\nchange(next)",
},
[146003] = {
["name"] = "Gnomeregan Guard Tiger",
["code"] = "use(Call Blizzard:206)\nuse(Howling Blast:120)\nuse(#1)\nchange(next)",
},
[173129] = {
["name"] = "Thenia's Loyal Companions",
["code"] = "standby [ self.aura(Asleep:498).exists ]\nchange(#2) [ enemy.aura(Stunned:927).exists ]\nchange(#3) [ enemy(#3).active ]\nuse(Ethereal:998) [ round=1 ]\nuse(Soulrush:752)\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nstandby",
},
["Do You Even Train? (Flyer)"] = {
["name"] = "Do You Even Train? (Flyer)",
["code"] = "use(Tail Sweep:122) [enemy(Brul'dan:3571).active]\nuse(Dodge:312) [enemy.aura(Underwater:830).exists]\nuse(Dodge:312) [self.aura(Curse of Doom:217).duration=1]\nuse(Hawk Eye:521) [!self.aura(Hawk Eye:520).exists]\nuse(Claw:429)\nuse(#1)\nchange(next)",
},
[119341] = {
["name"] = "Mining Monkey",
["code"] = "ability(Launch Rocket:293) [ !self.aura(Setup Rocket:294).exists ]\nability(Launch Rocket:293) [ self.round>2 ]\nability(Blingtron Gift Package:989) [ !enemy(#1).active ]\nability(#1)\nchange(next)",
},
[161651] = {
["name"] = "Ralf",
["code"] = "use(Clean-Up:456)\nuse(Soulrush:752)\nchange(#2) [self(#1).active]\nuse(Magic Sword:1085)\nuse(Toxic Smoke:640) [enemy(Ralf:2817).hp<500]\nuse(Supercharge:208) [self.aura(Wind-Up:458).exists]\nuse(Wind-Up:459)\nchange(#1) [self(#2).dead]",
},
[173257] = {
["name"] = "Mighty Minions of Maldraxxus",
["code"] = "if [self(#1).active]\nuse(Curse of Doom:218) [self.round==1]\nuse(Consume Magic:1231) [self.round==2]\nuse(Shadow Shock:422)\nendif\n\nif [enemy(#2).active]\nchange(#2) [self(#1).dead]\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nendif\n\nif [!self(#3).played]\nchange(#3)\nendif\n\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nuse(Tail Sweep:122)\n\nif [enemy(Chipper:2982).ability(Lift-Off:170).usable]\nuse(Supercharge:208)\nendif\n\nif [self(#2).aura(Supercharged:207).exists]\nuse(Ion Cannon:209)\nendif\n\nuse(Alert!:1585)",
},
[154929] = {
["name"] = "Unit 17",
["code"] = "change(#2) [round=3]\nchange(#3) [self(#2).active]\n\nability(Blistering Cold:786)\nability(Black Claw:919) [self.round=1]\nability(#1)\nchange(next)",
},
[201849] = {
["name"] = "Adinakon",
["code"] = "use(Explode:282)\nuse(Murder the Innocent:2223)\nchange(next)",
},
[196264] = {
["name"] = "The Terrible Three",
["code"] = "standby [round=5]\nuse(Corrosion:447) [round=1]\nuse(Void Nova:2356)\nuse(Poison Protocol:1954)\nuse(Corrosion:447)\nuse(Armageddon:1025)\nuse(Surge of Power:593) [self.aura(Dragonkin:245).exists]\nuse(Bite:110)\nchange(next)",
},
[173130] = {
["name"] = "Micro Defense Force",
["code"] = "if [enemy(#3).active]\nchange(#3)\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nendif\n\nchange(#2) [round=5]\nuse(Stun Seed:402) [round=1]\nuse(Poison Lash:398) [round=4]\nuse(Poison Lash:398) [!enemy.aura(Poisoned:379).exists]\nuse(Leech Seed:745)\nuse(Fel Immolate:901) [enemy(#1).active]\nuse(Fel Immolate:901) [enemy(#3).active & enemy.round=1]\nuse(Wing Buffet:1756) [enemy.aura(Prowl:543).exists]\nuse(Wild Magic:592) [!enemy.aura(Wild Magic:591).exists]\nuse(Fel Immolate:901)\nuse(Poison Lash:398)\nchange(#1)",
},
[99077] = {
["name"] = "Training with Bredda",
["code"] = "change(#2) [round=3]\nuse(Prowl:536)\nstandby [self(#1).active & !self.aura(Undead:242).exists & enemy(#3).active]\nuse(Call Darkness:256)\nstandby [self(#2).active & enemy(#3).active]\nuse(Shell Armor:1380)\nstandby [self(#2).active & self.hp>500 & enemy(#2).active & enemy.hp<461]\nuse(Scorched Earth:172)\nuse(Flame Breath:501)\nchange(#1)",
},
[116793] = {
["name"] = "Hiss",
["code"] = "ability(Extra Plating:392) [round=1]\nability(Make it Rain:985)\nability(Inflation:1002)\nability(Moonfire:595)\nability(Soulrush:752)\nability(#1)\nchange(next)",
},
[87124] = {
["name"] = "Ashlei",
["code"] = "use(Armageddon:1025) [enemy.aura(Flammenatem:500).exists & enemy.aura(Messerkrallen:2238).exists & enemy(#3).active]\nuse(Messerkrallen:2237) [enemy.aura(Flammenatem:500).exists & !enemy.aura(Messerkrallen:2238).exists]\nuse(Flammenatem:501)",
},
[146001] = {
["name"] = "Prototype Annoy-O-Tron",
["code"] = "standby [round~2,6,8,12]\nability(624) [round~1,7,11]\nability(206) [round~3,9,13]\nability(413) [round~4,5,10]\nability(#1)\nchange(next)",
},
[146005] = {
["name"] = "Bloated Leper Rat",
["code"] = "ability(Toxic Skin:1087) [!self.aura(Toxic Skin:1086).exists & self.hp>313]\nability(Whirlpool:513) [!enemy.aura(Whirlpool:512).exists]\nability(#1)\n\nchange(next)",
},
[173131] = {
["name"] = "Cliffs of Bastion",
["code"] = "use(Decoy:334) [round=1]\nuse(Explode:282) [enemy.hp<=618]\nuse(Missile:777)\nuse(Wind-Up:459) [enemy(#2).active]\nuse(Toxic Smoke:640)\nuse(Surge of Power:593) [enemy.hp<=1110]\nuse(Howl:362)\nchange(next)",
},
[150914] = {
["name"] = "Wandering Phantasm",
["code"] = "ability(#2) [round=2]\nability(#1) [self(#1).active]\nchange(next) [self.dead]\nability(#2)\nability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(#3)\nstandby",
},
[161656] = {
["name"] = "Splint",
["code"] = "standby [round=1]\nability(#2) [!enemy.aura(Creeping Fungus:742).exists]\nability(Haunt:652)\nability(#1)\nchange(next)",
},
[146004] = {
["name"] = "Gnomeregan Guard Mechanostrider",
["code"] = "use(Sandstorm:453)\nuse(Rupture:814)\nuse(Crush:406)\nuse(#3)\nuse(#2)\nuse(#1)\nchange(#2)\nchange(#3)",
},
[85622] = {
["name"] = "Brutus and Rukus",
["code"] = "ability(Wind-Up:459) [ round=1 ]\nability(Supercharge:208) [ round=2 ]\nability(Wind-Up:459) [ round=3 ]\nability(Wind-Up:459) [ round=4 ]\nability(Wind-Up:459) [ round=5 ]\nability(Toxic Smoke:640) [ round=6 ]\nchange(Mechanical Pandaren Dragonling:844) [ round=7 ]\nability(Thunderbolt:779)\nability(Explode:282) [ enemy.hp<560 ]\nability(Breath:115) [ enemy.hp>560 ]",
},
[161658] = {
["name"] = "Shred",
["code"] = "use(Flamethrower:503) [round~1,3]\nuse(Conflagrate:179)\nuse(Immolate:178) [round=6]\nuse(Burn:113)\nchange(next)",
},
[175779] = {
["name"] = "Chittermaw",
["code"] = "ability(Murder the Innocent:2223)\nability(Explode:282)\nchange(next)",
},
[197102] = {
["name"] = "Two and Two Together",
["code"] = "use(Arcane Storm:589) [!weather(Arcane Winds:590)]\nuse(Mana Surge:489)\nuse(Tail Sweep:122)\nchange(#2)\nuse(Wind-Up:459)\nuse(Wind-Up:459)",
},
[141002] = {
["name"] = "Sea Creatures Are Weird",
["code"] = "quit [ enemy(#1).active & !enemy.ability(Sweep:457).usable ]\nchange(#1) [ self(#3).active ]\nchange(#3) [ self(#1).dead ]\nif [ self(#1).active ]\n    ability(Supercharge:208) [ round~2,6 ]\n    ability(Wind-Up:459) [ enemy(#1).active ]\n    ability(Wind-Up:459) [ round>6 & self.aura(Mechanical:244).exists & self.aura(Wind-Up:458).exists ]\n    ability(Powerball:566)\nendif\nability(Explode:282) [ enemy(#3).active & enemy(#3).hp<561 ]\nability(Thunderbolt:779) [ !enemy(#2).dead & enemy(#2).hp<245 ]\nability(Thunderbolt:779) [ enemy(#3).active ]\nability(Breath:115)",
},
[173133] = {
["name"] = "Mega Bite",
["code"] = "use(Aufladen:208) [ !enemy.ability(Stachelpanzerschale:2324).usable ]\nuse(Aufziehen:459)",
},
[161657] = {
["name"] = "Ninn Jah",
["code"] = "ability(Deflection:490) [self.aura(Whirlpool:512).duration=1]\nability(Sandstorm:453)\nability(Crush:406)",
},
[141799] = {
["name"] = "Pack Leader",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Ion Cannon:209) [enemy(#3).active & enemy.round=2]\nability(Decoy:334)\nability(Haywire:916)\nability(Shock and Awe:646)\nability(Toxic Smoke:640)\nability(#1)\nchange(next)",
},
[85659] = {
["name"] = "The Beakinator",
["code"] = "use(Arcane Storm:589)\nuse(Mana Surge:489)",
},
[175778] = {
["name"] = "Briarpaw",
["code"] = "ability(Dodge:312) [enemy.aura(Dodge:311).exists]\nability(Burrow:159) [self.ability(Dodge:312).duration=2]\nability(#1)",
},
[73626] = {
["name"] = "Little Tommy Newcomer",
["code"] = "use(Curse of Doom:218)\nchange(Unborn Val'kyr:1238)\nuse(Unholy Ascension:321)\nchange(Ikky:1532)\nuse(Black Claw:919)\nuse(Inflation:1002)",
},
[87125] = {
["name"] = "Taralune",
["code"] = "standby [round=1]\nuse(Wind-Up:459) [round~2,4]\nuse(Supercharge:208) [round=3]\nuse(Toxic Smoke:640)\nchange(#3) [!self(#3).played]\nuse(Arcane Explosion:299) [enemy(#2).active]\nuse(Howl:362)\nuse(Surge of Power:593)\nchange(#2)\nchange(next)",
},
[173324] = {
["name"] = "Eyegor's Special Friends",
["code"] = "use(Extra Plating:392) [self.round=1]\nuse(Make it Rain:985) [self.round=2]\nuse(Inflation:1002) [self.round=3]\nuse(Make it Rain:985) [!enemy(Boneclaw:2992).dead]\n\nif [enemy(Boneclaw:2992).dead]\nchange(Iron Starlette:1387)\nendif\n\nif [self(#2).active]\nuse(Wind-Up:459) [self.round=1]\nuse(Supercharge:208) [self.round=2]\nuse(Wind-Up:459) [self.round=3]\nif [self.hp>550]\nuse(Wind-Up:459) [enemy.hp>350]\nendif\nuse(Wind-Up:459) [self.aura(Wind-Up:458).exists]\nif [enemy.hp<350]\nuse(Toxic Smoke:640) [!self.aura(Wind-Up:458).exists]\nendif\nif [self.hp<550]\nuse(Toxic Smoke:640)\nendif\nuse(Wind-Up:459)\nendif\n\nchange(#3)\nuse(Curse Of Doom:218) [self.round=1]\nability(Shadow Slash:210)",
},
[140461] = {
["name"] = "Night Horrors",
["code"] = "change(next) [ self(#1).dead & !self(#3).played ]\nability(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nability(Black Claw:919) [ enemy(#3).active & self.hp>366 ]\nability(Flock:581)\nability(Make it Rain:985)\nability(#1)",
},
[202458] = {
["name"] = "They're Full of Stars!",
["code"] = "use(Shadow Slash:210) [round=1]\nuse(Curse of Doom:218)\nuse(Unholy Ascension:321)\nuse(Time Bomb:602)\nuse(Flame Breath:501) [round=5]\nuse(Armageddon:1025)\nuse(Surge of Power:593) [enemy(#3).active]\nuse(Bite:110)\nchange(next)",
},
[142054] = {
["name"] = "Desert Survivors",
["code"] = "standby [ enemy.speed.fast & enemy.ability(Burrow:159).usable & enemy(#2).active ] \nability(Deflection:490) [ enemy.ability(Mudslide:572).usable ] \nability(Deflection:490) [enemy.aura(Underground:340).exists] \nability(#3) \nability(#1) \nchange(next)",
},
[146932] = {
["name"] = "Door Control Console",
["code"] = "change(#2) [ self(#1).dead ]\nuse(Primal Cry:920) [ !self.speed.fast & round=1 ]\nuse(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nuse(Hunting Party:921)\nuse(Stampede:163)\nuse(Squeeze:1572)\nuse(Tentacle Slap:1570)",
},
["Are They Not Beautiful? (Undead) (2)"] = {
["name"] = "Are They Not Beautiful? (Undead) (2)",
["code"] = "use(beam:1035) [ round = 1 ]\nuse(rush:752)\nuse(filler:1066)\nchange(next)\ntest(Bad RNG, clean up somehow)",
},
[142151] = {
["name"] = "You've Never Seen Jammer Upset",
["code"] = "if [ self(Iron Starlette:1387).active ] \nability(Wind-Up:459) [ round=1 ] \nability(Supercharge:208) [ round=2 ] \nability(Wind-Up:459) [ round=3 ] \nability(Wind-Up:459) [ round=4 ] \nchange(#2) [ round=5 ] \nability(Wind-Up:459) [ round >= 6 ] \nendif \nchange(Iron Starlette:1387) [ self(#2).active ]",
},
[87123] = {
["name"] = "Vesharr",
["code"] = "ability(Arcane Explosion:299)\nability(Explode:282) [enemy.aura(Mechanical:244).exists]\nability(Thunderbolt:779) [!enemy.aura(Flying Mark:1420).exists]\nability(Breath:115)\nchange(#2)",
},
[139489] = {
["name"] = "Crab People",
["code"] = "ability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(Savage Talon:1370) [enemy.aura(Shattered Defenses:542).exists]\nability(Falcosaur Swarm!:1773)\nchange(next)",
},
[150917] = {
["name"] = "Huncher",
["code"] = "use(Exposed Wounds:305)\nuse(Black Claw:919) [ self.round = 1 ]\nuse(Hunting Party:921)\nstandby",
},
[141479] = {
["name"] = "Strange Looking Dogs",
["code"] = "use(Supercharge:208) [ round>1 ]\nuse(Call Lightning:204) [ round>1 ]\nuse(Ion Cannon:209)\nuse(Metal Fist:384) [ !enemy.aura(Undead:242).exists ]\nchange(next)",
},
[97804] = {
["name"] = "Fight Night: Tiffany Nelson",
["code"] = "change(#1) [self(#3).played]\nchange(#2) [round=2]\nuse(Arkaner Sturm:589)\nuse(Manawoge:489)\nuse(Windstoß:2399)\nuse(Minenfeld:634)\nuse(Explodieren:282)\nchange(#3)",
},
[87110] = {
["name"] = "Tarr the Terrible",
["code"] = "change(next) [self(#3).active] \n\nchange(#3) [enemy(#3).active & enemy.aura(217).exists & !self(#3).played] \n\nability(772) [round=3] \n\nability(218) [!enemy.aura(217).exists &!enemy(#2).active & enemy(#3).hpp > 60] \n\nability(652) [round=2] \n\nability(#1) \nchange(next)",
},
["Do You Even Train? (Undead)"] = {
["name"] = "Do You Even Train? (Undead)",
["code"] = "use(#3) [ally(#1).active&round=1]\nuse(#1) [ally(#1).active]\n\nif [ally(#2).active]\nuse(#1)\nuse(#2)\nuse(#3)\nstandby\nendif\n\nuse(#3) [enemy.aura(Underwater:830).exists]\nuse(#2)\nuse(#1)\n\nchange(next)",
},
["Do You Even Train? (Aquatic)"] = {
["name"] = "Do You Even Train? (Aquatic)",
["code"] = "if [ally(#1).active]\nuse(#3)\nuse(#2)\nendif\n\nif [ally(#2).active]\nuse(#2)\nendif\n\nif [ally(#3).active]\nuse(#3) [enemy.aura(Underwater:830).exists]\nuse(#1)\nendif\nchange(next)",
},
["Do You Even Train? (Critter)"] = {
["name"] = "Do You Even Train? (Critter)",
["code"] = "use(Burrow:159) [enemy.aura(Underwater:830).exists]\nuse(Woodchipper:411) [!enemy.aura(Bleeding:491).exists & enemy(#1).dead]\n\nuse(Feign Death:568) [enemy.ability(Headbutt:376).usable]\nuse(#1)\n\nchange(next)",
},
[83837] = {
["name"] = "Cymre Brightblade",
["code"] = "change(#1) [self(#3).played]\nchange(#2) [round=3]\nuse(Nether Gate:466) [round=2]\nuse(Burn:113) [enemy(#3).active]\nuse(Flamethrower:503)\nuse(Flame Breath:501) [enemy(#2).active]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nchange(#3)",
},
[150918] = {
["name"] = "Tommy the Cruel",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Swarm:706)",
},
[116786] = {
["name"] = "Deviate Smallclaw",
["code"] = "ability(Supercharge:208) [enemy.hpp>50]\nability(Laser:482) [enemy(Deviate Flapper:1987).active]\nability(Haywire:916)\nability(#1)\nchange(next)",
},
[141292] = {
["name"] = "That's a Big Carcass",
["code"] = "standby [ enemy(#2).active & enemy.round=1 ]\nability(#2) [ !enemy(#3).active ]\nability(#3) [ enemy.aura(Shattered Defenses:542).exists ]\nability(#1)\nchange(#2)",
},
[116787] = {
["name"] = "Deviate Flapper",
["code"] = "use(#3) [round=1]\nuse(#2) [round=2]\nuse(#1)",
},
["Do You Even Train? (Humanoid)"] = {
["name"] = "Do You Even Train? (Humanoid)",
["code"] = "standby [self(#2).active & self.speed.slow & enemy(#3).active & enemy.ability(Dive:564).usable]\nability(Howl:362) [round=1]\nability(Dodge:312) [enemy.aura(Underwater:830).exists]\nability(Dodge:312) [enemy.aura(Attack Boost:485).exists]\nability(Howl:362) [enemy(#1).active]\nability(Deflection:490) [enemy(#3).active & enemy.ability(Headbutt:376).usable]\nability(Dark Fate:2432)\nability(Rampage:124) [enemy.ability(Headbutt:376).duration>2]\nability(#1)\nchange(next)",
},
[173263] = {
["name"] = "Extra Pieces",
["code"] = "use(Zeitbombe:602)\nuse(Armageddon:1025)\nstandby [self(#2).active & enemy(#2).active & enemy.hp<1000]\nuse(Giftprotokoll:1954) [enemy.aura(Korrosion:446).exists]\nuse(Leerennova:2356) [enemy(#2).active]\nuse(Korrosion:447)\nuse(Ionenkanone:209) [enemy(#3).active]\nstandby\nchange(next)",
},
[116795] = {
["name"] = "Everliving Spore",
["code"] = "ability(Paralyzing Venom:1559)\nability(Acidic Goo:369) [!enemy.aura(Acidic Goo:368).exists]\nability(Swallow You Whole:276)\nability(#1)\nchange(next)",
},
[116788] = {
["name"] = "Deviate Chomper",
["code"] = "ability(Evanescence:440)\nability(Forboding Curse:1068) [!enemy.aura(Forboding Curse:1067).exists]\nability(#1)\nchange(next)",
},
[119343] = {
["name"] = "Klutz's Battle Rat",
["code"] = "ability(124)\nability(202)\nchange(#2)\n\nability(#3) [enemy.hp<618 & enemy.type !~ 3]\nability(#3) [enemy.hp<406 & enemy.type ~ 3]\nability(#2) [!self(#2).aura(820).exists]\nability(#1)",
},
[161661] = {
["name"] = "Wilbur",
["code"] = "ability(Warning Squawk)\nability(Falcosaur Swarm!)\nchange(next)",
},
[105455] = {
["name"] = "Jarrun's Ladder",
["code"] = "if [self(#1).active]\nchange(#2) [round=3]\nchange(#2) [self(#1).dead]\nuse(Poison Protocol:1954)\nuse(Void Nova:2356) [enemy(#2).hp>95]\nstandby [enemy.aura(Undead:242).exists]\nuse(Ooze Touch:445)\nendif\n\nif [self(#2).active]\nstandby [enemy.aura(Undead:242).exists]\nchange(#3) [round=8]\nuse(Great Sting:1966) [round>4]\nuse(Cleave:1273)\nendif\n\nif [self(#3).active]\nchange(#1)\nendif",
},
[197350] = {
["name"] = "You Have to Start Somewhere (Critter)",
["code"] = "change(#2) [round=2]\nuse(Armageddon:1025)\nuse(Surge of Power:593) [enemy(#3).active]\nuse(Bite:110)",
},
["Wrathion"] = {
["name"] = "Wrathion",
["code"] = "ability(#1) [!enemy(Cindy:1299).active & enemy.hp<700]\nability(Consume Magic:1231) [self.aura(Ice Tomb:623).duration=1]\nability(Tidal Wave:419)\nstandby [self.aura(Stunned:927).exists]\nchange(next) [self.dead]",
},
[155414] = {
["name"] = "Ezra Grimm",
["code"] = "use(Bite:110) [round=1]\nuse(Howl:362) [self.ability(Surge of Power:593).usable]\nuse(Surge of Power:593)\nuse(Bite:110)\n\nuse(Deflection:490) [self.aura(Elementium Bolt:605).duration=1]\nuse(Sandstorm:453) [enemy(#2).active]\nuse(Crush:406)\n\nuse(Consume Corpse:665) [self.hpp<55]\nuse(Flurry:360)\n\nchange(next) [self.dead]",
},
[146183] = {
["name"] = "Living Napalm",
["code"] = "ability(Shell Armor:1380) \nability(Swallow You Whole:276) [enemy.hpp < 25]\nability(Deep Bite:1372)\nability(Shell Shield:310) [!self.aura(Shell Shield:309).exists]\nchange(next) [self.dead]\nability(#1)",
},
[200696] = {
["name"] = "Flow - Legendary",
["code"] = "use(#1) [round~1,2]\nuse(#3) [enemy(#1).aura(918).exists]\nuse(#2)\nuse(#3) [enemy(#1).aura(217).exists]\nchange(#2)",
},
[98270] = {
["name"] = "My Beast's Bidding",
["code"] = "quit [!self(#3).exists]\n\nchange(next) [self.dead]\nchange(#3) [self(#2).played]\n\nuse(#2) \nuse(#3) [self(#1).active]\nuse(#3) [enemy(#2).dead]\n\nuse(#1)\nstandby",
},
[161662] = {
["name"] = "Char",
["code"] = "change(#2) [round=3]\nuse(Howl:362)\nuse(Surge of Power:593)\nuse(Time Bomb:602)\nuse(Decoy:334)\nstandby",
},
[161663] = {
["name"] = "Tempton",
["code"] = "ability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)",
},
[140315] = {
["name"] = "Automated Chaos",
["code"] = "standby [enemy(\"Fixed\" Remote Control Rocket Chicken:2204).active]\nability(Call Blizzard:206)\nability(Deep Freeze:481) [enemy.hp>=444]\nability(#1)\nchange(next)",
},
[116794] = {
["name"] = "Growing Ectoplasm 2",
["code"] = "change(#2) [self(#1).dead]\nchange(#3) [self(#2).dead]\nif [enemy(#1).active]\n    ability(919) [!enemy.aura(918).exists]\n    ability(921)\n    ability(364) [enemy.aura(542).exists]\nendif\nability(919) [!enemy.aura(918).exists]\nability(921)\nability(597) [self.aura(823).duration<=1]\nability(598) [self.hp<1000]\nability(525)",
},
["To a Land Down Under (Flyer)"] = {
["name"] = "To a Land Down Under (Flyer)",
["code"] = "ability(Ironskin:1758)\nability(Predatory Strike:518) [round=4]\nability(Falcosaur Swarm!:1773)\n\nability(Quills:184) [enemy(#1).active]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(Quills:184)\n\nability(#2)\nability(#3)\nability(#1)\n\nchange(next)",
},
[162465] = {
["name"] = "Dune Buggy",
["code"] = "ability(Blistering Cold:786) [round=1]\nability(BONESTORM:1762) [round>2]\nability(Chop:943)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Hunting Party:921)\nchange(next)",
},
["Growing Ectoplasm 1"] = {
["name"] = "Growing Ectoplasm 1",
["code"] = "ability(Creeping Fungus:743) [round=1]\nability(Stampede:163) [round=2]\nability(Corpse Explosion:663)\nability(Peck:112) [enemy(Growing Ectoplasm:1995).active]\n\nif [enemy(Deviate Smallclaw:1989).active]\nability(Haywire:916)\nability(#1)\nendif\n\nif [enemy(Deviate Chomper:1988).active]\nability(Lift-Off:170)\nability(#1)\nendif\n\nif [enemy(Deviate Flapper:1987).active]\nability(#1) [enemy.round=1]\nability(Lift-Off:170)\nability(Haywire:916)\nability(#1)\nendif\n\nchange(next)",
},
["Do You Even Train? (Beast)"] = {
["name"] = "Do You Even Train? (Beast)",
["code"] = "change(next) [self.dead]\n\nuse(Ethereal:998) [enemy.aura(Underwater:830).exists]\nuse(Mangle:314) [!enemy.aura(Mangle:313).exists]\nuse(Swipe:2346)\n\nuse(Great Sting:1966) [!enemy(Brul'dan:3571).dead]\nuse(Scorched Earth:172)\nuse(Flame Breath:501)\n\nuse(#1)\nstandby",
},
[72290] = {
["name"] = "Zao, Calfling of Niuzao",
["code"] = "use(167)\nuse(411)\nuse(919) [ round=3 ]\nuse(921)\nchange(#2)",
},
[145988] = {
["name"] = "Pulverizer Bot Mk 6001",
["code"] = "if [self(Fel-Afflicted Skyfin).active]\nuse(#2)\nendif\n\nif [self(Boneshard).active]\nuse(#2)\nuse(#1)\nendif\n\nif [self(Fel-Afflicted Skyfin).active]\nuse(#2)\nendif\n\nchange(next)",
},
["To a Land Down Under (Beast)"] = {
["name"] = "To a Land Down Under (Beast)",
["code"] = "change(#2) [ round=5 ]\nchange(#1) [ self(#2).dead & !enemy(Clawz:3559).dead ]\nuse(Prowl:536) [ !enemy.is(Clawz:3559) & enemy.hp>339 & !weather(Moonlight:596) ]\nuse(Prowl:536) [ !enemy.is(Clawz:3559) & enemy.hp>309 ]\nuse(Arcane Dash:1536)\nuse(Scrabble:2430)\nuse(Moonfire:595)\nuse(Spirit Claws:974)\nuse(Booby-Trapped Presents:1080) [ enemy.is(Clawz:3559) ]\nuse(Huge Fang:930)\nuse(Gift of Winter's Veil:586)\nstandby\nchange(next)",
},
[155267] = {
["name"] = "Risen Guard",
["code"] = "standby [enemy(#2).type=4 & enemy(#1).aura(Undead:242).exists]\nstandby [enemy(#3).type=4 & enemy(#2).aura(Undead:242).exists]\nstandby [enemy(#2).type=2 & enemy(#1).aura(Undead:242).exists]\nstandby [enemy(#3).type=2 & enemy(#2).aura(Undead:242).exists]\nchange(#2) [enemy(#1).aura(Undead:242).exists & enemy(#2).type=6]\nchange(#2) [enemy(#2).aura(Undead:242).exists & enemy(#3).type=6]\n-----------------------\nability(Blinding Poison:1049) [round=1]\nability(Decoy:334) [enemy.round=2]\nability(Thunderbolt:779)\nchange(#1) [self(#2).active & enemy.type=4]\nability(Poison Fang:152) [enemy.is(Plague Whelp:2606) & enemy.round=1]\nability(Blinding Poison:1049) [!enemy(#1).active & !enemy.aura(Undead:242).exists]\nability(Poison Fang:152) [!enemy(#1).active & !enemy.aura(Poisoned:379).exists & enemy.type=6]\nchange(#1) [self(#2).active & enemy.type=4]\nability(#1)\nchange(next)",
},
[154917] = {
["name"] = "Mindshackle",
["code"] = "use(Blistering Cold:786) [ round~1,4 ]\nuse(BONESTORM:1762) [ round=3 ]\nuse(Chop:943)\nuse(Black Claw:919) [ self.round=1 ]\nuse(Hunting Party:921)\nuse(Flock:581)\nuse(Swarm:706)\nchange(next)\nstandby",
},
[150858] = {
["name"] = "Blackmane",
["code"] = "ability(Zusätzlicher Beschlag:392) [round==1]\nability(Goldregen:985)\nability(Inflation:1002)\nability(Schlaghagel:360)\nchange(next)",
},
[200688] = {
["name"] = "Wildfire - Legendary",
["code"] = "use(Illuminate:460)\nuse(Murder the Innocent:2223)\nchange(next)",
},
["Are They Not Beautiful? (Undead)"] = {
["name"] = "Are They Not Beautiful? (Undead)",
["code"] = "use(beam:1035) [ round = 1 ]\nuse(rush:752)\nuse(filler:1066)\nchange(next)\ntest(Bad RNG, clean up somehow)",
},
},
["Rematch"] = {
["team:46"] = {
["name"] = "Therin Skysong",
["code"] = "if [self(#1).active]\n  use(Disruption:1123) [round=1]\n  use(Life Exchange:277) [enemy.hp>=700]\n  change(#2) [enemy(#1).active]\n  use(Seethe:1056)\nendif\n\nif [self(#2).active]\n  use(Howling Blast:120) [weather(Blizzard:205)]\n  use(Call Blizzard:206)\n  use(Snowball:477)\nendif\n\nif [self(#3).active]\n  use(Burn:113) [enemy.hp<=186 & enemy.aura(Mechanical:244).exists]\n  use(Conflagrate:179) [enemy.hp<=333 & enemy.aura(Mechanical:244).exists]\n  use(Conflagrate:179) [weather(Blizzard:205) & enemy.aura(Mechanical:244).exists]\n  use(Conflagrate:179) [enemy(#2).active & enemy.aura(Immolate:177).exists]\n  use(Immolate:178) [!enemy.aura(Immolate:177).exists]\n  use(Burn:113)\nendif\n\nuse(#1)\nchange(next)",
},
["team:203"] = {
["name"] = "Splint",
["code"] = "standby [round=1]\nability(#2) [!enemy.aura(Creeping Fungus:742).exists]\nability(Haunt:652)\nability(#1)\nchange(next)",
},
["team:129"] = {
["name"] = "The Terrible Three",
["code"] = "standby [round=5]\nuse(Corrosion:447) [round=1]\nuse(Void Nova:2356)\nuse(Poison Protocol:1954)\nuse(Corrosion:447)\nuse(Armageddon:1025)\nuse(Surge of Power:593) [self.aura(Dragonkin:245).exists]\nuse(Bite:110)\nchange(next)",
},
["team:229"] = {
["name"] = "Do You Even Train? (Magic)",
["code"] = "if [enemy(#3).active]\nability(Ooze Touch:445)\nendif\nability(Void Nova:2356)\nability(Poison Protocol:1954)\nability(Ooze Touch:445)\nstandby [self(Anomalus).aura(Stunned).exists]\nchange(#2) [self(#1).dead]\nchange(#3) [self(#2).dead]",
},
["team:64"] = {
["name"] = "Shadowspike Lurker",
["code"] = "use(claw:919) [ round=1 ]\nuse(flock:581)\nuse(pred:518)\nchange(next)",
},
["team:268"] = {
["name"] = "Growing Ectoplasm 1",
["code"] = "ability(Creeping Fungus:743) [round=1]\nability(Stampede:163) [round=2]\nability(Corpse Explosion:663)\nability(Peck:112) [enemy(Growing Ectoplasm:1995).active]\n\nif [enemy(Deviate Smallclaw:1989).active]\nability(Haywire:916)\nability(#1)\nendif\n\nif [enemy(Deviate Chomper:1988).active]\nability(Lift-Off:170)\nability(#1)\nendif\n\nif [enemy(Deviate Flapper:1987).active]\nability(#1) [enemy.round=1]\nability(Lift-Off:170)\nability(Haywire:916)\nability(#1)\nendif\n\nchange(next)",
},
["team:286"] = {
["name"] = "Nearly Headless Jacob",
["code"] = "ability(Whirlpool:513) [enemy(#1).active]\nstandby [enemy(Mort:968).aura(Undead:242).exists]\nability(Scratch:119) [enemy(#3).active]\nability(Stampede:163) [self(Coastal Scuttler:2386).active & enemy(Stitch:969).aura(Undead:242).exists]\nability(Frost Spit:528) [enemy.aura(Shattered Defenses:542).exists]\nability(Bubble:934) [round>5]\nability(Stampede:163)\nchange(#1) [self(#2).dead]",
},
["team:211"] = {
["name"] = "Ninn Jah",
["code"] = "ability(Deflection:490) [self.aura(Whirlpool:512).duration=1]\nability(Sandstorm:453)\nability(Crush:406)",
},
["team:84"] = {
["name"] = "Retinus the Seeker",
["code"] = "standby [round=1]\nuse(Blistering Cold:786)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nchange(Ikky:1532) [self.aura(Stunned:927).exists]\nchange(Boneshard:1963)",
},
["team:70"] = {
["name"] = "Ravenous Scalespawn",
["code"] = "use(blackclaw:919) [ round=1 ] \nuse(flock:581) \nuse(strike:504) \nchange(next)",
},
["team:244"] = {
["name"] = "Are They Not Beautiful? (Humanoid)",
["code"] = "change(#2) [round=4]\nquit [self(#3).active & enemy(#2).active]\nuse(Soulrush:752) [enemy(Beeks:3566).active]\nuse(Creeping Insanity:1760) [!enemy(Beeks:3566).active]\nuse(Spiritfire Bolt:1066)\nuse(Ice Lance:413) [enemy(Fethres:3565).active]\nuse(Gift of Winter's Veil:586)\nuse(Call Blizzard:206)\nuse(Ice Lance:413)\nchange(Void-Scarred Anubisath:2833) [self.dead]\nuse(Weakness:471) [enemy.aura(Creeping Insanity:1759).exists]\nuse(Nether Blast:608)",
},
["team:238"] = {
["name"] = "To a Land Down Under (Flyer)",
["code"] = "ability(Ironskin:1758)\nability(Predatory Strike:518) [round=4]\nability(Falcosaur Swarm!:1773)\n\nability(Quills:184) [enemy(#1).active]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(Quills:184)\n\nability(#2)\nability(#3)\nability(#1)\n\nchange(next)",
},
["team:228"] = {
["name"] = "Are They Not Beautiful? (Flyer)",
["code"] = "quit [round = 2 & !enemy.aura(Stunned:927).exists]\nquit [round = 4 & self.hpp < 100]\n\nuse(Soulrush:752)\nuse(Ethereal:998) [enemy(#2).active]\nuse(Dark Talon:1233)\n\nuse(Shriek:784) [!enemy.aura(Attack Reduction:494).exists]\nuse(Arcane Storm:589)\nuse(Arcane Blast:421)\n\nchange(next)",
},
["team:369"] = {
["name"] = "Skitterer Xi'a",
["code"] = "use(Flyby:515) [round=1]\nuse(Thunderbolt:779)\nuse(Explode:282)\nchange(next)",
},
["team:290"] = {
["name"] = "Courageous Yon",
["code"] = "ability(490) [enemy.aura(341).exists]\nability(490) [enemy.aura(340).exists]\nability(490) [enemy.aura(540).exists]\nability(453)\nability(406)",
},
["team:354"] = {
["name"] = "Snail Fight! (Aquatic)",
["code"] = "if [enemy(#1).active]\nability(Whirlpool:513) [enemy.round=4]\nability(Renewing Mists:511) [enemy.aura(Whirlpool:512).duration=2]\nability(Snap:356)\nendif\n\nif [enemy(#2).active]\nability(Renewing Mists:511) [enemy.round=1]\nability(Snap:356)\nstandby\nendif\n\nif [enemy(#3).active]\nability(Whirlpool:513) [enemy.round=2]\nability(Renewing Mists:511) [enemy.aura(Whirlpool).duration=2]\nability(Snap:356)\nchange(#2) [self(#1).dead]\nendif\n\nability(Pump:297) [self.round=1]\nability(Pump:297) [self.round=3]\nability(Cleansing Rain:230)\nability(Water Jet:118)",
},
["team:189"] = {
["name"] = "Gnomeregan Guard Mechanostrider",
["code"] = "change(#2) [ enemy(#1).dead & ! self(#2).played ] \nability(Thorns:318) [ self.aura(Thorns:317).duration < 2 ] \nability(Photosynthesis:268) [ self.aura(Photosynthesis:267).duration < 2 ] \nability(Ironbark:962) \nability(Stoneskin:436) [self.aura(Stoneskin:435).duration < 2 ] \nstandby [ self.speed.slow & enemy.ability(Smoke Cloud:2239).usable ] \nstandby [ enemy.aura(Dodge:2060).exists ] \nstandby [ enemy.aura(Undead:242).exists ] \nability(Poison Spit:380) [self.ability(Poison Spit:380).strong] \nability(Burn:113) \nchange(next)",
},
["team:51"] = {
["name"] = "Ashes Will Fall",
["code"] = "use(Взрыв:282) [round=5]\nuse(Ледяной выстрел:1865)",
},
["team:113"] = {
["name"] = "Pulverizer Bot Mk 6001",
["code"] = "ability(Celestial Blessing:1032)\nability(Fire Shield:1754)\nability(Volcano:176)\nability(Flamethrower:503)\n\nability(Immolate:178) [!enemy.aura(Immolate:177).exists]\nability(Conflagrate:179)\nability(Burn:113)\n\nchange(#3)",
},
["team:77"] = {
["name"] = "Dr. Ion Goldbloom",
["code"] = "change(#2) [round=4]\nability(Extra Plating:392) [round=1]\nability(Call Lightning:204)\nability(Fel Immolate:901)\n\nability(Blingtron Gift Package:989) [enemy(#1).active]\nability(Make It Rain:985) [enemy(#1).active]\nability(Inflation:1002)\n\nchange(#1)\nstandby",
},
["team:214"] = {
["name"] = "Storm-Touched Slyvern",
["code"] = "use(Arcane Storm:589) [round=1]\nuse(Mana Surge:489)\nchange(Arcane Eye:1160)\nuse(Eyeblast:475)\nuse(#1)\nchange(next)",
},
["team:206"] = {
["name"] = "Vortex - Legendary",
["code"] = "use(Illuminate:460)\nuse(Murder the Innocent:2223)\nchange(next)",
},
["team:19"] = {
["name"] = "Strange Looking Dogs",
["code"] = "use(Supercharge:208) [ round>1 ]\nuse(Call Lightning:204) [ round>1 ]\nuse(Ion Cannon:209)\nuse(Metal Fist:384) [ !enemy.aura(Undead:242).exists ]\nchange(next)",
},
["team:114"] = {
["name"] = "Tiny Madness",
["code"] = "ability(Shadow Slash:210) [round = 1]\nstandby [round = 2]\nability(Curse of Doom:218)\nability(Haunt:652)\nchange(Infected Squirrel:627)\nability(Rabid Strike:666) [!enemy.aura(Rabies:807).exists] \nability(Stampede:163)\nchange(Graves:1639)\nability(Grave Destruction:1411)\nability(Skull Toss:1483)",
},
["team:97"] = {
["name"] = "You've Never Seen Jammer Upset",
["code"] = "if [ self(Iron Starlette:1387).active ] \nability(Wind-Up:459) [ round=1 ] \nability(Supercharge:208) [ round=2 ] \nability(Wind-Up:459) [ round=3 ] \nability(Wind-Up:459) [ round=4 ] \nchange(#2) [ round=5 ] \nability(Wind-Up:459) [ round >= 6 ] \nendif \nchange(Iron Starlette:1387) [ self(#2).active ]",
},
["team:267"] = {
["name"] = "To a Land Down Under (Dragon)",
["code"] = "ability(Moonfire:595) [self.ability(Moonfire:595).usable]\nability(Life Exchange:277) [enemy(Clawz:3559).active]\nability(Arcane Blast:421)\nability(Howl:362)\nability(Surge of Power:593)\nchange(next)",
},
["team:398"] = {
["name"] = "Training with the Nightwatchers (Elemental)",
["code"] = "change(#3) [self(#1).dead]\nuse(Magic Hat:478) [round=1]\nuse(Call Blizzard:206)\nuse(Deep Freeze:481)\nuse(Magic Hat:478)\n\nuse(Deep Freeze:481)\nuse(Geyser:418)\nuse(Water Jet:118)\n\nuse(#3)\nuse(#2)\nuse(#1)\n\nstandby\nchange(next)",
},
["team:133"] = {
["name"] = "Wandering Phantasm",
["code"] = "ability(#2) [round=2]\nability(#1) [self(#1).active]\nchange(next) [self.dead]\nability(#2)\nability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(#3)\nstandby",
},
["team:246"] = {
["name"] = "Are They Not Beautiful? (Magic)",
["code"] = "change(next) [self.dead]\nuse(#1) [enemy.hp < 300]\nuse(Hatred Manifest:2505)\nuse(Murder the Innocent:2223)\nuse(Nether Gate:466)\nuse(Stampede:163)\nuse(Spectral Spine:913) [enemy(Talons:3567).active]\nuse(#1)\nchange(next)",
},
["team:217"] = {
["name"] = "CK-9 Micro-Oppression Unit",
["code"] = "change(#2) [round=3 & enemy.hp>1153]\nchange(#2) [self.aura(Stunned:927).exists]\nuse(Flyby:515) [round=1]\nuse(Thunderbolt:779)\nuse(Explode:282)\nchange(#1)\nchange(#2)",
},
["team:396"] = {
["name"] = "Training with the Nightwatchers (Critter)",
["code"] = "use(Swarm:706) [!enemy.aura(Shattered Defenses:542).exists]\nuse(Flank:193)\n\nif [enemy(#2).active]\nuse(Dodge:312) [enemy.round=1]\nendif\nuse(Dodge:312) [enemy.aura(Undead:242).exists]\n\nuse(Stampede:163) [!enemy.aura(Shattered Defenses:542).exists]\nuse(Flurry:360)\n\nuse(Ooze Touch:445)\n\nchange(next)",
},
["team:172"] = {
["name"] = "Small Beginnings",
["code"] = "change(Nexus Whelpling:1165) [ self(Iron Starlette:1387).dead ]\nability(Supercharge:208) [ self.round = 2 ]\nability(Wind-Up:459)\nability(Arcane Storm:589) [ self.round = 1 ]\nability(Mana Surge:489)\nability(Tail Sweep:122)\nability(Black Claw:919) [ self.round = 1 ]\nability(Flock:581)",
},
["team:165"] = {
["name"] = "Ralf",
["code"] = "ability(Black Claw:919) [round=1]\nuse(Flock:581)\nuse(Ion Cannon:209) \nchange(next)",
},
["team:124"] = {
["name"] = "Critters are Friends, Not Food",
["code"] = "ability(Void Nova:2356)\nability(Poison Protocol:1954)\nability(Soulrush:752) [enemy(#2).active]\nability(Moonfire:595) [enemy(#3).active]\nability(#1)\nchange(next)",
},
["team:80"] = {
["name"] = "Fight Night: Tiffany Nelson",
["code"] = "change(#3) [self(#2).active]\nuse(Flame Breath:501) [round=1]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\n\nuse(Sweep:457)\nuse(Mana Surge:489)\n\nuse(#1)\nchange(next)",
},
["team:154"] = {
["name"] = "Automated Chaos",
["code"] = "standby [enemy(\"Fixed\" Remote Control Rocket Chicken:2204).active]\nability(Call Blizzard:206)\nability(Deep Freeze:481) [enemy.hp>=444]\nability(#1)\nchange(next)",
},
["team:10"] = {
["name"] = "Wilbur",
["code"] = "ability(Warning Squawk)\nability(Falcosaur Swarm!)\nchange(next)",
},
["team:403"] = {
["name"] = "Training with the Nightwatchers (Undead)",
["code"] = "use(Curse of Doom:218)\nuse(Unholy Ascension:321) [self.aura(Undead:242).exists]\nuse(Acid Rain:1051) [!weather(Cleansing Rain:229)]\nuse(#1)\nchange(next)",
},
["team:5"] = {
["name"] = "Plagued Critters",
["code"] = "ability(Rain Dance:1062) [ round>2 ]\nability(Water Jet:118) [enemy(#2).dead & enemy(#3).dead]\nability(Tidal Wave:419)\nchange(next)",
},
["Chen Stormstout"] = {
["name"] = "Chen Stormstout",
["code"] = "change(#2) [ self(#1).dead ]\nuse(Bombing Run:647) [ enemy.hp.full ]\nuse(Explode:282) [ enemy.hp.can_explode ]\nuse(Explode:282) [ enemy.aura(Bomb:819).duration = 1 & enemy.hp <= 1004 ]\nuse(Deflection:490) [ enemy(#2).active & enemy.ability(Lullaby:996).usable & !enemy.aura(Locust Swarm:1011).exists ]\nuse(Deflection:490) [ self.aura(Inebriate:1009).duration = 2 ]\nuse(Crush:406) [ enemy.hp <= 227 ]\nuse(Stoneskin:436) [ self.aura(Stoneskin:435).duration <= 1 ]\nuse(Healing Wave:123) [ self.hpp < 75 ]\nuse(#1)\nstandby",
},
["team:17"] = {
["name"] = "Chittermaw",
["code"] = "ability(Murder the Innocent:2223)\nability(Explode:282)\nchange(next)",
},
["team:53"] = {
["name"] = "Sully \"The Pickle\" McLeary",
["code"] = "change(Firewing:1545) [ self(Mr. Bigglesworth:1145).dead ]\nuse(Ice Tomb:624) [ enemy(#1).active & enemy.round=1 ]\nuse(Ice Barrier:479) [ enemy(#1).active & enemy.round=2 ]\nstandby [ round=3 ]\nchange(Elekk Plushie:1426) [ enemy.aura(Underground:340).exists ]\nstandby [ self(Elekk Plushie:1426).active & !self.aura(Bleeding:491).exists ]\nability(Itchin' for a Stitchin':1337) [ self.aura(Bleeding:491).exists ]\nstandby [ self(Firewing:1545).active & self.round=1 ]\nif [ enemy(Rikki:1290).active & self(Firewing:1545).active ]\n    use(Sunlight:404) [ enemy.round=1 ]\n    use(Healing Flame:168) [ enemy.round=2 ]\nendif\nuse(Healing Flame:168)\nuse(Sunlight:404) [weather(Sunny Day:403).duration=1]\nuse(#1)",
},
["team:258"] = {
["name"] = "Do You Even Train? (Aquatic)",
["code"] = "if [ally(#1).active]\nuse(#3)\nuse(#2)\nendif\n\nif [ally(#2).active]\nuse(#2)\nendif\n\nif [ally(#3).active]\nuse(#3) [enemy.aura(Underwater:830).exists]\nuse(#1)\nendif\nchange(next)",
},
["team:216"] = {
["name"] = "Unfortunate Defias",
["code"] = "ability(Bubble:934)\nability(Swarm of Flies:232) [ !enemy.aura(Swarm of Flies:231).exists ]\nability(Tongue Lash:228)\nchange(#2)\nability(Nature's Ward:574) [ !self.aura(Nature's Ward:820).exists ]\nability(Alpha Strike:504) [ enemy.hp > 309 ]\nability(Ravage:802)",
},
["team:291"] = {
["name"] = "Ashlei",
["code"] = "use(Decoy:334) [round=1]\nuse(Bombing Run:647) [enemy(#2).active&!enemy(#3).played]\nuse(#1)\nchange(#3)",
},
["team:73"] = {
["name"] = "Mindshackle",
["code"] = "use(Blistering Cold:786) [ round~1,4 ]\nuse(BONESTORM:1762) [ round=3 ]\nuse(Chop:943)\nuse(Black Claw:919) [ self.round=1 ]\nuse(Hunting Party:921)\nuse(Flock:581)\nuse(Swarm:706)\nchange(next)\nstandby",
},
["team:263"] = {
["name"] = "Are They Not Beautiful? (Critter)",
["code"] = "if [ !enemy.aura(Void Tremors:2359).exists ]\n    use(Void Tremors:2360) [ enemy.hp>1101 ]\n    if [ !enemy.is(Talons:3567) ]\n        use(Void Tremors:2360) [ enemy.hp<735 & self.ability(Early Advantage:405).duration<2 & self.hp.low ]\n        use(Void Tremors:2360) [ enemy.hp<368 ]\n    endif\nendif\nuse(Early Advantage:405) [ self.hp.low ]\nuse(Scratch:119)\nchange(next)",
},
["team:116"] = {
["name"] = "Brain Tickling",
["code"] = "change(#1) [self(#3).active]\n\nuse(Blistering Cold:786)\nuse(Chop:943)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nuse(#1)\nchange(next)",
},
["team:118"] = {
["name"] = "What's the Buzz?",
["code"] = "ability(Emerald Presence:597) [ !self.aura(Emerald Presence:823).exists ]\nability(Emerald Presence:597) [ self.aura(Emerald Presence:823).duration = 1 ]\nability(Emerald Dream:598) [ self.hp <750 ]\nstandby",
},
["team:125"] = {
["name"] = "Fight Night: Amalia",
["code"] = "change(#1) [self(#2).active]\nchange(#2) [enemy.aura(Cute Face:904).exists & !self(#2).played]\nchange(#3) [enemy(#3).active]\nuse(Cleansing Rain:230) [self.aura(Pumped Up:296).exists]\nuse(Acid Rain:1051) [self.aura(Pumped Up:296).exists]\nuse(Pump:297)\nuse(Focus:426) [self.aura(Focused:425).duration<2]\nuse(Sandstorm:453)\nuse(Zap:116)",
},
["team:202"] = {
["name"] = "Risen Guard",
["code"] = "standby [enemy(#2).type=4 & enemy(#1).aura(Undead:242).exists]\nstandby [enemy(#3).type=4 & enemy(#2).aura(Undead:242).exists]\nstandby [enemy(#2).type=2 & enemy(#1).aura(Undead:242).exists]\nstandby [enemy(#3).type=2 & enemy(#2).aura(Undead:242).exists]\nchange(#2) [enemy(#1).aura(Undead:242).exists & enemy(#2).type=6]\nchange(#2) [enemy(#2).aura(Undead:242).exists & enemy(#3).type=6]\n-----------------------\nability(Blinding Poison:1049) [round=1]\nability(Decoy:334) [enemy.round=2]\nability(Thunderbolt:779)\nchange(#1) [self(#2).active & enemy.type=4]\nability(Poison Fang:152) [enemy.is(Plague Whelp:2606) & enemy.round=1]\nability(Blinding Poison:1049) [!enemy(#1).active & !enemy.aura(Undead:242).exists]\nability(Poison Fang:152) [!enemy(#1).active & !enemy.aura(Poisoned:379).exists & enemy.type=6]\nchange(#1) [self(#2).active & enemy.type=4]\nability(#1)\nchange(next)",
},
["team:126"] = {
["name"] = "Crypt Fiend",
["code"] = "use(Lightning Shield:906) \nuse(Fire Shield:1754) \nuse(Arcane Blast:421) \nuse(Decoy:334) \nuse(Thunderbolt:779) \nuse(Breath:115) \nuse(#1) \nchange(next)",
},
["team:191"] = {
["name"] = "Bloated Leper Rat",
["code"] = "use(270) [round=1]\nuse(282)\nuse(404)\nuse(2223)\nchange(next)\nstandby",
},
["team:35"] = {
["name"] = "Cymre Brightblade",
["code"] = "ability(Cleave:1273) [enemy(#1).active & enemy.ability(Dark Rebirth:794).usable & enemy.ability(Rot:476).usable & enemy.hp<300]\nability(Deflection:490) [enemy(#1).active & enemy.ability(Rot:476).usable]\nability(#1)\n\nchange(next)",
},
["team:74"] = {
["name"] = "Airborne Defense Force",
["code"] = "use(Void Crash:2358)\nuse(Flame Breath:501) [round=3]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nif [enemy(#2).active]\nstandby [round=6 & !enemy(#1).dead & enemy(#1).hp<207]\nuse(Arcane Explosion:299)\nendif\nuse(Howl:362) [!self.aura(Dragonkin:245).exists]\nuse(Surge of Power:593)\nchange(next)",
},
["team:112"] = {
["name"] = "Paws of Thunder",
["code"] = "use(Toxic Fumes:2349)\nuse(Poison Protocol:1954)\nuse(Time Bomb:602)\nuse(Armageddon:1025)\n\nstandby [enemy(#2).active & enemy.hp<733 & enemy.aura(601).duration=1]\nif [enemy(#2).aura(927).exists]\nuse(Puncture Wound:1050)\nstandby [enemy(#2).active]\nendif\n\nuse(Impale:800)\nuse(Slicing Wind:420)\nchange(next)",
},
["team:370"] = {
["name"] = "Lucky Yi",
["code"] = "change(#3) [self(#1).dead & !self(#3).played]\nchange(#2) [self(#3).played]\nuse(Curse of doom:218)\nuse(Haunt:652)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)",
},
["team:281"] = {
["name"] = "Morulu the Elder",
["code"] = "ability(Dodge:312) [round=3]\nability(Ravage:802) [round=4]\nability(Dodge:312) [enemy(#3).active & enemy.round=1]\nability(Sandstorm:453)\nability(#1)\nchange(next)",
},
["team:48"] = {
["name"] = "Eye of the Stormling",
["code"] = "ability(Explode:282)\nability(Pump:297)\nchange(next)",
},
["team:207"] = {
["name"] = "Foe Reaper 50",
["code"] = "ability(418)\nability(564)\nability(118)\nchange(#2)\nability(#1)",
},
["team:54"] = {
["name"] = "Tasha Riley",
["code"] = "if [round<24]\nchange(#2) [enemy.ability(Surge of Power:593).duration=5]\nuse(Glowing Toxin:270) [enemy(#2).aura(Stunned:927).exists]\nuse(Amber Prison:1026) [enemy(#1).active]\nuse(Cocoon Strike:506) [enemy(#2).active & !enemy.ability(Howl:362).usable]\nuse(Glowing Toxin:270) [round>8]\nuse(Ice Tomb:624)\nchange(#1)\nstandby\nendif\n\nuse(Roar of the Dead:2071) [self.round=1]\nuse(Tornado Punch:1052)\nuse(Jab:219)\nuse(Call Blizzard:206) [enemy(#3).active]\nuse(Ice Tomb:624) [enemy.aura(Undead:242).exists]\nuse(Call Blizzard:206) [!weather(Blizzard:205)]\nuse(Ice Lance:413)\nuse(Amber Prison:1026)\nuse(Glowing Toxin:270)\nstandby\nchange(#3)",
},
["team:13"] = {
["name"] = "Jarrun's Ladder",
["code"] = "standby [enemy(#1).aura(Undead:242).exists]\nchange(#1) [self(#3).played]\nchange(#2) [round=3]\nuse(Poison Protocol:1954)\nuse(Void Nova:2356)\nuse(Ooze Touch:445)\nuse(Enrage:1392) [!self.aura(Enraged:1391).exists]\nuse(Great Sting:1966)\nuse(Enrage:1392)\nchange(#3)",
},
["team:224"] = {
["name"] = "Are They Not Beautiful? (Aquatic)",
["code"] = "quit [ enemy.is(Beeks:3566) & self(#2).dead ]\n--Add -- before next quit when you've faith in critical hits killing Talons\nquit [ self(#3).active & enemy(Talons:3567).active & enemy.hp.full & !enemy.aura(Void Tremors:2359).exists ]\nuse(Rush:567) [ round>3 ]\nuse(Prowl:536) [ self.aura(Pumped Up:296).exists ]\nuse(Pump:297) [ self(#1).active ]\nuse(Void Tremors:2360)\nuse(Feedback:484)\nuse(Sewage Eruption:2062) [ !enemy.aura(Void Tremors:2359).exists & enemy.hp>967 ]\nuse(Moonfire:595)\nuse(Nether Blast:608)\nchange(next)",
},
["team:6"] = {
["name"] = "Wildfire - Legendary",
["code"] = "use(Illuminate:460)\nuse(Murder the Innocent:2223)\nchange(next)",
},
["team:180"] = {
["name"] = "Sludge Belcher",
["code"] = "ability(Corpse Explosion:663) [!enemy.aura(Corpse Explosion:664).exists]\nability(Toxic Skin:1087) [!self.aura(Toxic Skin:1086).exists]\nability(#1)\nchange(next)",
},
["team:192"] = {
["name"] = "\"Captain\" Klutz",
["code"] = "standby [ enemy.round < 3 ]\nability(218)\nability(652)\nchange(#2)\nability(919) [ !enemy.aura(918).exists ]\nability(581)",
},
["team:109"] = {
["name"] = "Tarr the Terrible",
["code"] = "ability(Explode:282) [enemy(#1).active & enemy.hp.can_explode]\nability(Explode:282) [enemy(#3).active & enemy.hp.can_explode & enemy(#1).dead]\nability(Reanimate:1957) [round=3]\nability(Empowering Strikes:1958) [enemy.round=1 & enemy(#1).active]\nability(Great Cleave:1959)\nability(Shield Block:760) [enemy.aura(Leaping:839).exists]\nability(#1)\nstandby\nchange(next)",
},
["team:101"] = {
["name"] = "Mo'ruk",
["code"] = "ability(Explode:282) [enemy(#3).active & enemy.hp.can_explode]\nability(Surge of Power:593) [round=12]\nability(Evanescence:440) [enemy.aura(Underground:340).exists]\nability(Drill Charge:1921) \nability(#1)\nstandby\nchange(next)",
},
["team:50"] = {
["name"] = "Captured Evil",
["code"] = "ability(Rain Dance:1062)\nability(Squeeze:1572)\nability(Ironskin:1758) \nability(Ancient Blessing:611)\nability(#1)\nchange(next)",
},
["team:40"] = {
["name"] = "Lorewalker Cho",
["code"] = "change(next) [ self.dead ]\nuse(Moonfire:595) [ round=1 ]\nuse(#2) [ enemy.round=1 & enemy(#2).active ]\nuse(#1) [ !enemy(#3).active ]\nuse(#3)\nuse(#2)\nuse(#1)",
},
["team:272"] = {
["name"] = "Brok",
["code"] = "change(Clockwork Gnome:277) [ enemy(Ashtail:981).active ]\nchange(Anubisath Idol:1155) [enemy(Incinderous:980).active & self(Clockwork Gnome:277).dead]\nability(Deflection:490)\nability(Crush:406)\nability(Build Turret:710)\nability(Repair:278) [enemy(Ashtail:981).active ]\nability(Metal Fist:384)",
},
["team:167"] = {
["name"] = "Son of Skum",
["code"] = "ability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(Flock:581)\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
["team:31"] = {
["name"] = "Night Horrors",
["code"] = "change(next) [ self(#1).dead & !self(#3).played ]\nability(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nability(Black Claw:919) [ enemy(#3).active & self.hp>366 ]\nability(Flock:581)\nability(Make it Rain:985)\nability(#1)",
},
["team:178"] = {
["name"] = "Flight of the Vil'thik",
["code"] = "change(#3) [self(#2).active]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nuse(Howl:362) [enemy.aura(601).duration=1]\nuse(Surge of Power:593) [enemy.aura(Howl:1725).exists]\nstandby\nchange(next)",
},
["team:163"] = {
["name"] = "Prototype Annoy-O-Tron",
["code"] = "standby [round~1,4,5,7]\nability(Blistering Cold:786)\nability(Chop:943)\nability(Black Claw:919) [self.round=1]\nability(Hunting Party:921)\nchange(next)",
},
["team:79"] = {
["name"] = "Resilient Survivors",
["code"] = "ability(Prowl:536) [self.aura(Blinding Poison:1048).exists]\nstandby [self.aura(Blinding Poison:1048).exists]\nability(Whirlpool:513) [enemy.round=1]\nability(Dive:564) [round=2]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
["team:288"] = {
["name"] = "Jeremy Feasel",
["code"] = "change(Molten Corgi:1451) [enemy(Honky-Tonk:1067).active]\nability(Decoy:334)\nability(Thunderbolt:779)\nability(Breath:115)\nability(Puppies of the Flame:1354)\nability(Cauterize:173) [!enemy(Honky-Tonk:1067).ability(Lock-On:301).usable]\nability(Cauterize:173) [ally(Molten Corgi:1451).hpp < 50]\nability(Flamethrower:503)\nstandby",
},
["team:399"] = {
["name"] = "Training with the Nightwatchers (Flyer)",
["code"] = "ability(Scorched Earth:172) [round=1]\nability(Deep Burn:1407)\nchange(Sentinel's Companion:1567) [self(Blazing Firehawk:1693).dead]\nability(Ethereal:998)\nability(Soulrush:752)\nability(Dark Talon:1233)\nability(#1)",
},
["team:157"] = {
["name"] = "Marshdwellers",
["code"] = "use(Predatory Strike) [enemy.aura(Shattered Defenses:542).exists]\nuse(Falcosaur Swarm!)\nchange(#2)\nuse(Arcane Storm)\nuse(Mana Surge)\nuse(Tail Sweep)\nchange(#3)",
},
["team:8"] = {
["name"] = "Training with Durian",
["code"] = "change(#1) [self(#3).played]\n\nuse(Sandstorm:453)\nuse(Stone Rush:621) [round>4]\nuse(Quicksand:912) [round>4]\n\nuse(Cleansing Rain:230) [enemy(#1).active]\nuse(Cleansing Rain:230) [enemy(#3).active & self.hp<667]\nstandby [self(#2).active & enemy(#3).active]\nuse(Pump:297)\n\nchange(next)",
},
["team:395"] = {
["name"] = "Training with the Nightwatchers (Beast)",
["code"] = "use(Great Sting:1966) [round=1]\nuse(Flame Breath:501) [enemy(#1).active]\nuse(Great Sting:1966)\nuse(Flame Breath:501) [!enemy.aura(Flame Breath:500).exists]\nuse(Cleave:1273)\nuse(Crouch:165) [enemy.aura(Undead:242).exists]\nuse(Leap:364) [!self.aura(Speed Boost:544).exists & enemy(#3).active]\nuse(Flurry:360)\nchange(next)",
},
["team:397"] = {
["name"] = "Training with the Nightwatchers (Dragon)",
["code"] = "ability(Tail Sweep:122) [enemy(Breezy Book:1897).active]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(Surge of Power:593)\nchange(next)",
},
["team:215"] = {
["name"] = "A New Vocation (2)",
["code"] = "standby [enemy.aura(Dodge:311).exists]\nability(Bubble:934) [enemy.aura(Flying:341).exists]\nability(Dive:564) [enemy.aura(Flying:341).exists]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
["team:159"] = {
["name"] = "Dealing with Satyrs",
["code"] = "standby [round=2]\nuse(Zeitbombe:602) [enemy(#1).active]\nuse(Zeitbombe:602) [enemy(#1).dead]\nuse(Armageddon:1025) [enemy(#3).active & enemy.aura(Zeitbombe:601).duration=1]\n\nuse(Elementiumblitz:606) [enemy(#1).active]\n\nuse(Entzünden:178)\nuse(Flammenatem:501) [enemy.hp>396]\nuse(Armageddon:1025)\n\nchange(#1)",
},
["team:75"] = {
["name"] = "Chi-Chi, Hatchling of Chi-Ji",
["code"] = "standby [round=3]\nability(Curse of Doom:218)\nability(Haunt:652)\nability(Creeping Fungus:743) [self.round=2]\nability(#1)\nchange(next)",
},
["team:86"] = {
["name"] = "Ardenweald's Tricksters",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\nchange(Ikky:1532)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)",
},
["team:65"] = {
["name"] = "Cockroach",
["code"] = "ability(Dodge:312) [round=1]\nability(Howl:362) [round=2]\nability(Howl:362) [enemy.round=1]\nability(Rock Barrage:628) [enemy(#3).active]\nability(Rupture:814)\nability(#1)\nchange(next)",
},
["team:106"] = {
["name"] = "Mega Bite",
["code"] = "use(Aufladen:208) [ !enemy.ability(Stachelpanzerschale:2324).usable ]\nuse(Aufziehen:459)",
},
["team:95"] = {
["name"] = "Creakclank",
["code"] = "standby [round=1]\nchange(Boneshard:1963) [round=2]\nuse(Blistering Cold:786)\nuse(Chop:943) [!enemy.aura(Bleeding:491).exists]\nuse(BONESTORM:1762)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nchange(Ikky:1532)",
},
["team:279"] = {
["name"] = "Ras'an",
["code"] = "ability(Tail Sweep:122) [enemy(Tripod:954).active]\nability(Arcane Storm:589) [enemy.round=1]\nability(Mana Surge:489)\nability(#1)\nchange(next)",
},
["team:230"] = {
["name"] = "Are They Not Beautiful? (Mech)",
["code"] = "ability(Supercharge:208) [round=1]\nability(Ion Cannon:209) [round=2]\n\nability(Powerball:566) [enemy(#3).active]\nability(Powerball:566) [enemy.hp<271]\nability(Supercharge:208) [enemy(#2).active & enemy.hp>893 & self(#2).active & self.aura(Wind-Up:458).exists]\n\nability(Decoy:334) [enemy(#3).active & enemy.ability(Conflagrate:179).duration=1]\nability(Time Bomb:602)\n\nability(#1)\nchange(next)",
},
["team:274"] = {
["name"] = "Gnomefeaster",
["code"] = "ability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nchange(Mechanical Pandaren Dragonling:844)\nability(Breath:115) [self.round=1]\nability(Thunderbolt:779)\nability(Explode:282)",
},
["team:160"] = {
["name"] = "Xu-Fu, Cub of Xuen",
["code"] = "if [ self(Alpine Foxling:724).active ]\nability(Dazzling Dance:366) [ !self.aura(Dazzling Dance:365).exists ]\nability(Howl:362)\nchange(next)\nendif\nability(Toxic Smoke:640) [ !enemy.aura(Toxic Smoke:639).exists ]\nability(Explode:282)\nability(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nability(Flock:581)\nability(#1)\nchange(next)",
},
["team:276"] = {
["name"] = "Stone Cold Trixxy",
["code"] = "change(#2) [!enemy.ability(Surto de Poder:593).usable & !self(#2).played]\nchange(Dragonetinho do Nexus:1165)\nuse(Surto de Mana:489) [self(#2).played]\nuse(Tempestade Arcana:589)\nuse(Sopro Gélido:782)",
},
["team:260"] = {
["name"] = "Xu-Fu, Cub of Xuen (2)",
["code"] = "use(Call Lightning:204) [round=1]\nchange(#2) [round = 2]\nuse(Make it Rain:985)\nuse(Inflation:1002)\nchange(#3) [self(#2).dead & self(#1).played]\nuse(Shock and Awe:646)\nuse(Ion Cannon:209)",
},
["team:45"] = {
["name"] = "Alran Heartshade",
["code"] = "use(Apocalipsis:519) [enemy.hp.full]\nuse(Cauterizar:173)\n\nchange(Putrinfecto:1629)\nuse(Putrefacción:476) [enemy(Ruddy:2805).active]\nuse(Deflagración de cadáver:663) [enemy(Ruddy:2805).active]\nstandby [self.aura(Aturdido:927).exists]\n\nchange(Cucaracha experimental:2664)\nuse(Mordedura enfermiza:499) [enemy.aura(Defensas desarmadas:542).exists]\nuse(Enjambre:706) [self.aura(Glándulas suprarrenales:841).exists]\nuse(Glándulas suprarrenales:197)\n\nuse(#1)",
},
["team:142"] = {
["name"] = "Mini Manafiend Melee",
["code"] = "use(Messerkrallen:2237) [round=2]\nuse(Armageddon:1025) [round=4]\nuse(Flammenatem:501)\nuse(Explodieren:282)\nchange(next)",
},
["team:60"] = {
["name"] = "Snakes on a Terrace",
["code"] = "standby [ round=1 ]\nuse(Magic Sword:1085) [ enemy(Clubber:2355).active ]\nchange(#3)\nstandby [enemy.aura(Underwater:830).exists ]\nuse(Leap:364) [ enemy.hp<730 ]\nuse(Hunting Party:921) [ enemy.aura(claw:918).exists ]\nuse(Leap:364) [ enemy(Squeezer:2353).aura(claw:918).exists ]\nuse(Black Claw:919)\nuse(#1)\nchange(#1)",
},
["team:194"] = {
["name"] = "Klutz's Battle Bird",
["code"] = "ability(589)\nability(489)\nability(122)\nchange(#2)\nability(597) [ self.aura(823).duration < 2 & self.speed.slow ]\nability(597) [ !self.aura(823).exists ]\nability(598) [ self.hpp < 50 ]\nability(525)",
},
["team:99"] = {
["name"] = "Sea Creatures Are Weird",
["code"] = "quit [ enemy(#1).active & !enemy.ability(Sweep:457).usable ]\nchange(#1) [ self(#3).active ]\nchange(#3) [ self(#1).dead ]\nif [ self(#1).active ]\n    ability(Supercharge:208) [ round~2,6 ]\n    ability(Wind-Up:459) [ enemy(#1).active ]\n    ability(Wind-Up:459) [ round>6 & self.aura(Mechanical:244).exists & self.aura(Wind-Up:458).exists ]\n    ability(Powerball:566)\nendif\nability(Explode:282) [ enemy(#3).active & enemy(#3).hp<561 ]\nability(Thunderbolt:779) [ !enemy(#2).dead & enemy(#2).hp<245 ]\nability(Thunderbolt:779) [ enemy(#3).active ]\nability(Breath:115)",
},
["team:184"] = {
["name"] = "Not So Bad Down Here",
["code"] = "use(Supercharge:208) [self(Runeforged Servitor:1957).active]\nuse(Call Lightning:204)\nchange(#2) [round=3]\nuse(Screech:357) [!enemy.aura(Speed Reduction:154).exists]\nuse(Feathered Frenzy:1398)\nuse(Quills:184)\nchange(#1) [self(#2).dead]\nuse(Wind-Up:459) [ !self.aura(Wind-Up:458).exists ]\nuse(Wind-Up:459) [ self.aura(Supercharged:207).exists ]\nuse(Supercharge:208)\nuse(Toxic Smoke:640)\nstandby\nchange(next)",
},
["team:402"] = {
["name"] = "Training with the Nightwatchers (Mech)",
["code"] = "change(Darkmoon Tonk:338) [enemy(Helpful Spirit:1898).active]\nchange(Mechanical Pandaren Dragonling:844) [enemy(Delicate Moth:1899).active]\nability(Decoy:334)\nability(Thunderbolt:779)\nability(Breath:115)\nability(Missile:777) [ enemy.hp >=733 ]\nability(Minefield:634)\nability(Ion Cannon:209)\nability(Missile:777)\nability(#1)\nchange(next)",
},
["team:368"] = {
["name"] = "Gorespine",
["code"] = "change(#2) [self(#1).active & self.dead]\nuse(Metal Fist:384) [self.round>4]\nuse(Launch Rocket:293)\nuse(Howl:362)\nuse(Surge of Power:593)",
},
["team:176"] = {
["name"] = "Cookie's Leftovers",
["code"] = "standby [ self.aura(926).exists & self.speed.fast ]\nability(334)\nability(779)\nability(115)\nchange(#2)\nability(312) [ enemy.ability(#3).usable ]\nability(574) [ self.aura(820).duration < 2 & self.speed.slow ]\nability(574) [ !self.aura(820).exists ]\nability(504)",
},
["team:210"] = {
["name"] = "Phyxia",
["code"] = "use(Supercharge:208) [enemy.hp>361]\nuse(Repair:278) [round=3]\nuse(Metal Fist:384)\nuse(#1)\nchange(next)",
},
["team:225"] = {
["name"] = "Chi-Chi, Hatchling of Chi-Ji (2)",
["code"] = "ability(Immolation:409) [!self.aura(Immolation:408).exists]\nability(Wild Magic:592) [!enemy.aura(Wild Magic:591).exists]\nability(Acidic Goo:369) [self.round=1]\nability(Dive:564) [self.round=4]\nchange(#2)\nability(#1)",
},
["team:242"] = {
["name"] = "To a Land Down Under (Magic)",
["code"] = "change(#3) [enemy(#3).active & enemy.aura(Forboding Curse:1067).exists]\n\nability(Surge of Power:593) [round=2]\n\nstandby [self.aura(Illusionary Barrier:464).exists]\nability(Illusionary Barrier:465) [self.aura(Whirlpool:512).duration=1]\nability(Illusionary Barrier:465) [self(#3).dead]\nstandby [self.aura(Illusionary Barrier:464).exists & self.speed.fast]\nability(Forboding Curse:1068) [enemy(#2).active & enemy.hp>778 &!enemy.aura(Forboding Curse:1067).exists]\nability(Forboding Curse:1068) [!enemy.aura(Forboding Curse:1067).exists & enemy(#3).active]\n\nability(Life Exchange:277) [self.hpp<50 & enemy(#3).active ]\nability(Eyeblast:475) [self.speed.slow]\n\nability(#1)\nchange(next)",
},
["team:174"] = {
["name"] = "Klutz's Battle Rat",
["code"] = "ability(124)\nability(202)\nchange(#2)\n\nability(#3) [enemy.hp<618 & enemy.type !~ 3]\nability(#3) [enemy.hp<406 & enemy.type ~ 3]\nability(#2) [!self(#2).aura(820).exists]\nability(#1)",
},
["team:59"] = {
["name"] = "Chomp",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652)\nability(Inflation:1002)\nchange(next)",
},
["team:115"] = {
["name"] = "Extra Pieces",
["code"] = "use(Zeitbombe:602)\nuse(Armageddon:1025)\nstandby [self(#2).active & enemy(#2).active & enemy.hp<1000]\nuse(Giftprotokoll:1954) [enemy.aura(Korrosion:446).exists]\nuse(Leerennova:2356) [enemy(#2).active]\nuse(Korrosion:447)\nuse(Ionenkanone:209) [enemy(#3).active]\nstandby\nchange(next)",
},
["team:348"] = {
["name"] = "Tiny Poacher, Tiny Animals (Elemental)",
["code"] = "ability(Rip:803) [!enemy.aura(Bleeding:491).exists]\nability(Lightning Shield:906) [!self.aura(Lightning Shield:907).exists]\nability(Blood in the Water:423)\nability(Whirlpool:513)\nability(Dive:564)\nability(Frost Nova:414)\nability(Deep Freeze:481)\nability(#1)\nchange(next)",
},
["team:173"] = {
["name"] = "Liz the Tormentor",
["code"] = "use(RazorTalons:2237) [round=2] \nuse(FlameBreath:501) [round<5]\nuse(Armageddon:1025)",
},
["team:287"] = {
["name"] = "Christoph VonFeasel",
["code"] = "ability(Explode:282) [enemy(#3).active]\nability(Time Bomb:602)\nability(Armageddon:1025) [enemy.aura(Stunned:927).exists]\nability(Minefield:634) [enemy.aura(Trihorn Shield:959).exists]\nability(#1)\nchange(next)",
},
["team:353"] = {
["name"] = "Tiny Poacher, Tiny Animals (Undead)",
["code"] = "ability(Call Darkness:256) [weather(Mudslide:718)]\nability(Spectral Strike:442) [weather(Darkness:257)]\n\nability(Ice Tomb:624) [enemy(#2).hpp<50 & enemy(#2).active]\nability(Frost Nova:414) [enemy(#3).active]\n\nability(Soulrush:752) [enemy(#2).active]\n\nability(#1)\nchange(next)",
},
["team:201"] = {
["name"] = "Enok the Stinky",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652) [round=3]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(Hunting Party:921)\nability(Leap:364)\nability(#1)\nchange(next)",
},
["team:164"] = {
["name"] = "Snail Fight!",
["code"] = "change(#1) [self(#3).played]\nchange(#2) [round=2]\nchange(#3) [round=4]\nuse(Great Sting:1966)\nstandby [round=5 & self(#2).dead]\nuse(Enrage:1392) [!self.aura(Enraged:1391).exists]\nuse(Impale:800)\nuse(Pheromones:1063)",
},
["team:181"] = {
["name"] = "The Oldest Dragonfly",
["code"] = "change(#1) [self(#3).active]\nuse(Illuminate:460)\nuse(Soul Ward:751) [round=6 & self.hp<1063]\nuse(Light:461) [round>2]\nuse(Beam:114) [round>2]\nuse(Blinding Powder:1015)\nuse(Explode:282)\nchange(next)",
},
["team:226"] = {
["name"] = "Do You Even Train? (Humanoid)",
["code"] = "standby [self(#2).active & self.speed.slow & enemy(#3).active & enemy.ability(Dive:564).usable]\nability(Howl:362) [round=1]\nability(Dodge:312) [enemy.aura(Underwater:830).exists]\nability(Dodge:312) [enemy.aura(Attack Boost:485).exists]\nability(Howl:362) [enemy(#1).active]\nability(Deflection:490) [enemy(#3).active & enemy.ability(Headbutt:376).usable]\nability(Dark Fate:2432)\nability(Rampage:124) [enemy.ability(Headbutt:376).duration>2]\nability(#1)\nchange(next)",
},
["Wrathion"] = {
["name"] = "Wrathion",
["code"] = "ability(#1) [!enemy(Cindy:1299).active & enemy.hp<700]\nability(Consume Magic:1231) [self.aura(Ice Tomb:623).duration=1]\nability(Tidal Wave:419)\nstandby [self.aura(Stunned:927).exists]\nchange(next) [self.dead]",
},
["team:11"] = {
["name"] = "Wildfire - Rare",
["code"] = "ability(Blistering Cold:786)\nability(Chop:943) [!enemy.aura(Bleeding:491).exists]\nability(BONESTORM!!:1762) [!self.aura(Undead:242).exists]\nability(Chop:943)\n\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Hunting Party:921)\n\nchange(next)",
},
["team:144"] = {
["name"] = "Greyhoof",
["code"] = "change(#2) [ self(#1).dead ]\nuse(Supercharge:208) [ round = 2 ]\nuse(Toxic Smoke:640) [ round > 3 ]\nuse(Wind-Up:459)\nuse(Explode:282) [ enemy.hp.can_explode ]\nuse(Breath:115)",
},
["team:119"] = {
["name"] = "Living Statues Are Tough",
["code"] = "use(212) [round=1]\nuse(652)\nuse(581) [enemy.aura(918).exists]\nuse(919)\nchange(next)",
},
["team:367"] = {
["name"] = "Ti'un the Wanderer",
["code"] = "use(270) [round=1]\nuse(282)\nuse(2223)\nchange(next)",
},
["team:3"] = {
["name"] = "Nefarious Terry",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Whirlpool:513) [round=1]\nability(Scratch:119) [enemy.aura(Shattered Defenses:542).exists]\nability(Stampede:163)\nability(#1)\nchange(next)",
},
["team:55"] = {
["name"] = "Keeyo's Champions of Vol'dun",
["code"] = "change(#2) [enemy(#2).active]\nability(459) [self.aura(458).exists]\nability(1921) [self.round=1]\nability(459) [self.round=2]\nability(#3)\nability(974) [enemy(#3).active]\nability(595) [enemy(#1).active]\nchange(#1) [self(#2).dead]",
},
["team:186"] = {
["name"] = "Storm-Touched Ohuna",
["code"] = "standby [ round = 1 ]\nuse(curse:218)\nuse(haunt:652)\nuse(claw:919) [ !enemy.aura(claw:918).exists ]\nuse(flock:581)\nchange(next)",
},
["team:285"] = {
["name"] = "Okrut Dragonwaste",
["code"] = "use(Deflection:490) [enemy.aura(Flying:341).exists] \nuse(Deflection:490) [self.aura(Ice Tomb:623).duration=1] \nuse(Stoneskin:436) [self.aura(Stoneskin:435).duration<2] \nuse(Crush:406) \nchange(#3) [self(#1).dead &!self(#3).played] \nchange(#2) [self(#3).played] \nuse(Dodge:312) \nstandby [enemy.aura(Undead:242).exists] \nuse(Flurry:360)",
},
["team:357"] = {
["name"] = "Snail Fight! (Dragon)",
["code"] = "standby [round~2,3]\nuse(Howl:362) [round>1 & !self.aura(Dragonkin:245).exists]\nuse(Ravage:802) [enemy.hp<888]\nuse(Bite:110)\nuse(Arcane Blast:421)\nchange(next)",
},
["team:120"] = {
["name"] = "Living Sludge",
["code"] = "standby [ enemy.aura(Dodge:2060).exists ]\nstandby [ enemy.aura(Undead:242).exists ]\n\nchange(#3) [enemy(Cockroach:2486).active]\n\nability(Shell Armor:1380) [enemy(#2).active & enemy.round=1 & !enemy(Cockroach:2486).active]\nability(Shell Armor:1380) [enemy(#2).active & enemy.round=3 & enemy(Cockroach:2486).active]\n\nability(Shell Armor:1380) [enemy(#3).active & enemy.round=1 & !enemy(Cockroach:2486).active]\nability(Shell Armor:1380) [enemy(#3).active & enemy.round=3 & enemy(Cockroach:2486).active]\n\nability(Dive:564) [round=3]\nability(Dive:564) [self.ability(Shell Armor:1380).duration~1,2,3]\n\nability(Leech Seed:745)\nability(Fist of the Forest:1343)\nability(Lash:394)\n\nability(Cauterize:173) [self.hpp<65]\nability(Brittle Webbing:382) [enemy(Cockroach:2486).active]\nability(Burn:113)\n\nability(#1)\nchange(#2) [!enemy(Cockroach:2486).active]\nchange(#3)",
},
["team:400"] = {
["name"] = "Training with the Nightwatchers (Humanoid)",
["code"] = "ability(Dodge:312) [enemy.round=1]\nability(Dodge:312) [enemy.aura(Undead:242).exists]\nability(#1) [enemy(Delicate Moth:1899).active]\nability(Dodge:312) [enemy(Delicate Moth:1899).active]\nability(Pounce:535)\nchange(next)",
},
["team:208"] = {
["name"] = "Shademaster Kiryn",
["code"] = "if [ self(Sister of Temptation:1628).active & enemy(Nairn:1288).active ]\n    ability(Curse of Doom:218) [ round=1 ]\n    ability(Shadow Shock:422)\nendif\nif [ self(Sister of Temptation:1628).active & enemy(Stormoen:1287).active & !enemy(Summer:1286).played ]\n    ability(Lovestruck:772)\n    ability(Curse of Doom:218)\nendif\nchange(Ashstone Core:1150) [ self(#3).active ]\nchange(#3) [ self(Sister of Temptation:1628).active & enemy(Summer:1286).active & !enemy(Stormoen:1287).dead & enemy.round=1 ]\nif [ self(Ashstone Core:1150).active & enemy(Summer:1286).active & !enemy(Stormoen:1287).dead ]\n    ability(Crystal Prison:569)\n    ability(Stoneskin:436)\nendif\nability(Burn:113) [ self(Ashstone Core:1150).active & enemy(Stormoen:1287).active & !enemy(Summer:1286).dead ]\nif [ self(Ashstone Core:1150).active & enemy(Summer:1286).active & enemy(Stormoen:1287).dead ]\n    ability(Stoneskin:436) [ enemy.round=1 ]\n    standby [ enemy.round=2 ]\n    ability(Crystal Prison:569) [ enemy.round=3 ]\n    ability(Burn:113) [ enemy.round=4 ]\n    ability(Burn:113) [ enemy.round=5 ]\n    change(Sister of Temptation:1628) [ enemy.round=6 ]\nendif\nif [ self(Sister of Temptation:1628).active & enemy(Summer:1286).active & enemy(Stormoen:1287).dead ]\n    standby [ self.round=1 ]\n    ability(Lovestruck:772) [ self.round=3 ]\n    ability(Shadow Shock:422)\nendif",
},
["team:134"] = {
["name"] = "Burning Pandaren Spirit",
["code"] = "use(490) [ enemy.aura(341).exists ]\nuse(490) [ enemy.ability(179).usable ]\nuse(490) [ enemy(#3).active ]\nuse(453)\nuse(406)",
},
["team:212"] = {
["name"] = "Aki the Chosen",
["code"] = "use(Dodge:312) [enemy.aura(Underwater:830).exists]\nif [enemy(#1).active]\nability(436) [!self.aura(435).exists]\nability(406)\nendif\nif [enemy(#2).active]\nability(490) [enemy.round=1]\nability(436) [self.aura(435).duration < 2]\nability(406)\nendif\nif [enemy(#3).active]\nability(436) [enemy.round=1]\nability(490) [enemy.round=2]\nability(406)\nchange(#2) [self(#1).dead]\nability(312) [enemy.aura(830).exists]\nability(574) [!self.aura(820).exists]\nability(504)\nendif",
},
["team:255"] = {
["name"] = "To a Land Down Under (Elemental)",
["code"] = "ability(Surge of Power:593) [!enemy.hp.full]\nability(Breath of Sorrow:1055) [enemy(Clawz:3559).active]\nability(Blast of Hatred:472)\nuse(Dive:564) [enemy(#3).active]\nuse(Whirlpool:513) [enemy(#3).active]\nability(Flash Freeze:1955)\nability(Geyser:418) [enemy(Murrey:3558).active]\nability(Water Jet:118)\nability(Call Lightning:204) [enemy.aura(Weakened Defenses:516).exists]\nability(Flyby:515)\nchange(next)",
},
["team:235"] = {
["name"] = "Do You Even Train? (Undead)",
["code"] = "use(#3) [ally(#1).active&round=1]\nuse(#1) [ally(#1).active]\n\nif [ally(#2).active]\nuse(#1)\nuse(#2)\nuse(#3)\nstandby\nendif\n\nuse(#3) [enemy.aura(Underwater:830).exists]\nuse(#2)\nuse(#1)\n\nchange(next)",
},
["team:110"] = {
["name"] = "Rogue Azerite",
["code"] = "ability(Whirlpool:513) [self(Pandaren Water Spirit:868).active]\nability(Dive:564) [self(Pandaren Water Spirit:868).active]\nability(Water Jet:118) [self(Pandaren Water Spirit:868).active]\nchange(#2) [self(Pandaren Water Spirit:868).dead & !self(#3).active]\nchange(#3)\nability(Shell Shield:310) [self(#3).aura(Shell Shield:309).duration <2]\nability(Dive:564)\nability(Absorb:449)",
},
["team:283"] = {
["name"] = "Gutretch",
["code"] = "change(#3) [self(#1).active & self(#1).dead]\nchange(#2) [self(#3).active & self(#3).played]\n\nif [enemy(#1).active]\n ability(Wind-Up:459) [enemy.round=1]\n standby [self.speed>=260 & enemy.round=2]\n ability(Supercharge:208)\n ability(Wind-Up:459) \nendif\n\nif [enemy(#2).active]\n ability(Wind-Up:459) [enemy.round=1]\n ability(Toxic Smoke:640) [enemy.aura(Toxic Smoke:639).duration<2]\n ability(Wind-Up:459) \nendif\n\nability(Toxic Smoke:640)\nability(Focus:426) [self.speed<=289 &enemy(#2).active]\nability(Rampage:124)\nability(Triple Snap:355)",
},
["team:29"] = {
["name"] = "Everliving Spore",
["code"] = "ability(Paralyzing Venom:1559)\nability(Acidic Goo:369) [!enemy.aura(Acidic Goo:368).exists]\nability(Swallow You Whole:276)\nability(#1)\nchange(next)",
},
["team:247"] = {
["name"] = "Are They Not Beautiful? (Dragon) (2)",
["code"] = "use(Mana Surge:489) [weather(Arcane Winds:590).duration>1]\nuse(Surge of Power:593) [enemy(#3).active & enemy.hp<1099]\nuse(Surge of Power:593) [enemy(#3).active & self.aura(Dragonkin:245).exists]\nuse(Arcane Storm:589)\n\nuse(Arcane Blast:421)\nuse(#1)\n\nchange(next)",
},
["team:151"] = {
["name"] = "Storm-Touched Skitterer",
["code"] = "use(claw:919) [ !enemy.aura(claw:918).exists ]\nuse(flock:581) [ !enemy.aura(flock:542).exists ]\nuse(filler:184)",
},
["team:137"] = {
["name"] = "The Mind Games of Addius",
["code"] = "use(Blistering Cold:786)\nuse(Mind Games: Health:2388)\nuse(Chop:943)\nuse(Chop:943)\nuse(Blistering Cold:786)\nuse(Chop:943)\nuse(Chop:943)\nchange(#2) [self(#1).dead & !self(#2).played]\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581) \nuse(Mind Games: Health:2388)\nuse(#3)\nuse(#3)",
},
["team:200"] = {
["name"] = "Dos-Ryga",
["code"] = "ability(Haunt:652)\nability(Black Claw:919) [self.round=1]\nability(Swarm:706)\nability(Predatory Strike:518)\nability(#1)\nchange(next)",
},
["team:22"] = {
["name"] = "Pack Leader",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Ion Cannon:209) [enemy(#3).active & enemy.round=2]\nability(Decoy:334)\nability(Haywire:916)\nability(Shock and Awe:646)\nability(Toxic Smoke:640)\nability(#1)\nchange(next)",
},
["team:347"] = {
["name"] = "Tiny Poacher, Tiny Animals (Dragon)",
["code"] = "use(Bite:110) [round=1]\nuse(Howl:362)\nuse(Surge of Power:593)\nuse(Ancient Blessing:611) [enemy(#2).active & enemy.hp < 797]\nuse(Ancient Blessing:611) [enemy(#3).active & enemy.hp < 300]\nuse(Proto-Strike:612) [enemy(#3).active & enemy.round=1]\nuse(Tail Sweep:122) [enemy(#3).active & enemy.hp < 300]\nuse(Tail Sweep:122) [enemy(#3).active & enemy.aura(Mechanical:244).exists]\nuse(Tail Sweep:122) [enemy(#2).active & self.aura(Dragonkin:245).exists & enemy.hp < 610]\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nuse(#1)\nchange(next)",
},
["team:89"] = {
["name"] = "Sputtertube",
["code"] = "use(Black Claw:919) [round=1]\nuse(Flock:581)\nchange(#2)\nuse(Flamethrower:503) [!enemy(Sputtertube:2736).aura(Flamethrower:502).exists]\nuse(Burn:113)",
},
["team:196"] = {
["name"] = "Unbreakable",
["code"] = "change(#2) [round=2]\nability(Build Turret)\nability(#1)\nstandby",
},
["team:26"] = {
["name"] = "Fight Night: Stitches Jr. Jr.",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Supercharge) [self.aura(Wind-Up:458).exists]\nability(Wind-Up)\nchange(next)",
},
["team:14"] = {
["name"] = "Char",
["code"] = "ability(#2) [!enemy.aura(Black Claw:918).exists]\nability(#3)\nchange(next)",
},
["team:362"] = {
["name"] = "Snail Fight! (Mech)",
["code"] = "change(next) [self.dead]\nuse(Powerball:566) [enemy.hp<243]\nuse(Powerball:566) [enemy(#2).active & enemy.round=1]\nuse(Powerball:566) [enemy(#3).active & enemy.round=2]\nuse(Supercharge:208) [self.aura(Wind-Up:458).exists]\nuse(#1)",
},
["team:28"] = {
["name"] = "Taralune",
["code"] = "standby [round=1]\nuse(Itchin' for a Stitchin':1337)\nuse(Extra Plating:392)\nuse(Launch Rocket:293) [enemy.hp < 630]\nuse(Inflation:1002)\nuse(Surge of Power:593) [enemy(#3).active & enemy(#3).hp < 1098]\nuse(Arcane Storm:589)\nuse(Arcane Blast:421)\nchange(next)",
},
["team:166"] = {
["name"] = "Deviate Flapper",
["code"] = "use(#3) [round=1]\nuse(#2) [round=2]\nuse(#1)",
},
["team:250"] = {
["name"] = "To a Land Down Under (Undead)",
["code"] = "use(Enrage:1392) [!self.aura(Enraged:1391).exists && self.ability(Soulrush:752).usable]\nuse(Reflective Shield:1105) [enemy(Murrey:3558).active]\nuse(Spiritfire Bolt:1066) [enemy.hp < 216]\nuse(Soulrush:752)\nuse(Spiritfire Bolt:1066)\n\nuse(Toxic Smoke:640) [!enemy.aura(Toxic Smoke:639).exists]\nuse(Slime:1763)\n\nchange(next)",
},
["team:364"] = {
["name"] = "Nitun",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nchange(next)",
},
["team:146"] = {
["name"] = "Shred",
["code"] = "ability(#3) [round>2]\nability(Brittle Webbing:382) [round~1,4,6]\nability(Flame Jet:1041)\nability(#1)\nchange(next)",
},
["team:155"] = {
["name"] = "Rampage",
["code"] = "ability(Toxic Skin:1087) [self.aura(Toxic Skin:1086).duration<2]\nability(Flyby:515) [!enemy.aura(Weakened Defenses:516).exists]\nability(Infected Claw:117)\n\nability(#1)\nstandby\nchange(next)",
},
["team:153"] = {
["name"] = "Thundering Pandaren Spirit",
["code"] = "if [enemy(#1).active]\nability(Dive:564) [self.round =1]\nability(Acidic Goo:369) [self.round =3]\nability(Ooze Touch:445)\nendif\n\nif [enemy(#2).active]\nability(Acidic Goo:369) [enemy.round =1]\nability(Ooze Touch:445)\nchange(#2) [self(#1).dead]\nability(777)\nendif\n\nif [enemy(#3).active]\nability(334) [enemy.round =2]\nability(282) [enemy.hp < 618]\nability(777)\nendif",
},
["team:222"] = {
["name"] = "Lydia Accoste",
["code"] = "change(#3) [ !self(#3).played ]\nchange(#2) [ !self(#2).played ]\nchange(#2) [ self(#1).dead ]\nchange(#1)\nuse(Ancient Blessing:611) [ self.hpp < 70 & !self.aura(Dragonkin:245).exists ]\nuse(Ancient Blessing:611) [ self.hpp < 50 ]\nuse(Moonfire:595) [ weather(Moonlight:596).duration <= 1 ]\nstandby [ enemy.aura(Undead:242).exists ]\nuse(Moonfire:595) [ enemy(#3).active ]\nuse(Moonfire:595) [ enemy.hp > 312 ]\nuse(#1)\nstandby",
},
["team:223"] = {
["name"] = "Little Tommy Newcomer",
["code"] = "use(Curse of Doom:218)\nchange(Unborn Val'kyr:1238)\nuse(Unholy Ascension:321)\nchange(Ikky:1532)\nuse(Black Claw:919)\nuse(Inflation:1002)",
},
["team:232"] = {
["name"] = "Ashes Will Fall (2)",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\n\nuse(Black Claw:919) [ !enemy.aura(Black Claw:918).exists ]\nuse(Hunting Party:921)\nuse(#1)\nchange(next)",
},
["team:170"] = {
["name"] = "Rydyr",
["code"] = "use(Glowing Toxin:270) [ round=1 ]\nuse(Explode:282)\nchange(#2)",
},
["team:7"] = {
["name"] = "Stitches Jr.",
["code"] = "standby [round~3,7]\nability(Supercharge:208) [round=5]\nability(Wind-Up:459)\nchange(#2)",
},
["team:182"] = {
["name"] = "Vilefang",
["code"] = "ability(Ironskin:1758)\nability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(#1)\nchange(next)",
},
["team:344"] = {
["name"] = "Tiny Poacher, Tiny Animals (Aquatic)",
["code"] = "use(Healing Wave:123) [enemy(Egcellent:1793).active & enemy(Egcellent:1793).hpp < 50]\nuse(Dive:564)\nuse(Shell Armor:1380)\nuse(Pinch:2067)\nuse(Pump:297)\nuse(#1)\nchange(next)",
},
["team:39"] = {
["name"] = "The Beakinator",
["code"] = "use(Arcane Storm:589)\nuse(Mana Surge:489)",
},
["team:58"] = {
["name"] = "Leper Rat",
["code"] = "ability(#3) [!enemy.aura(502).exists]\nstandby [enemy.aura(2060).exists] \nstandby [enemy.aura(242).exists]\nability(2067) [enemy.aura(542).exists]\nability(2067) [enemy(2486).active]\nability(163)\nability(179) [enemy.aura(502).exists]\nability(503) [self.ability(503).strong]\nability(#1) \nchange(next)",
},
["team:175"] = {
["name"] = "Gnomeregan Guard Tiger",
["code"] = "change(#3) [self(#2).dead]\nchange(#2) [self(#1).dead]\nability(Fire Shield:1754)\nability(Extra Plating:1733)\nability(Stoneskin:436)\nability(Flame Jet:1041)\nability(Heat Up:945)\nability(Rupture:814)\nability(Burn:113)\nability(Crush:406)",
},
["team:143"] = {
["name"] = "Whispering Pandaren Spirit",
["code"] = "ability(611) [self.round> 2]\nability(299)\nchange(#2) [self(#1).dead]\nability(779)\nability(115)\nstandby",
},
["team:185"] = {
["name"] = "Crab People",
["code"] = "ability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(Savage Talon:1370) [enemy.aura(Shattered Defenses:542).exists]\nability(Falcosaur Swarm!:1773)\nchange(next)",
},
["team:43"] = {
["name"] = "Pixy Wizzle",
["code"] = "use(2223)\nuse(377)\nuse(792)\nuse(1533)\nstandby\nchange(next)",
},
["team:96"] = {
["name"] = "Micro Defense Force",
["code"] = "if [enemy(#3).active]\nchange(#3)\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nendif\n\nchange(#2) [round=5]\nuse(Stun Seed:402) [round=1]\nuse(Poison Lash:398) [round=4]\nuse(Poison Lash:398) [!enemy.aura(Poisoned:379).exists]\nuse(Leech Seed:745)\nuse(Fel Immolate:901) [enemy(#1).active]\nuse(Fel Immolate:901) [enemy(#3).active & enemy.round=1]\nuse(Wing Buffet:1756) [enemy.aura(Prowl:543).exists]\nuse(Wild Magic:592) [!enemy.aura(Wild Magic:591).exists]\nuse(Fel Immolate:901)\nuse(Poison Lash:398)\nchange(#1)",
},
["team:275"] = {
["name"] = "Obalis",
["code"] = "use(501) [round=1]\nuse(347) [round=5]\nuse(602)\nuse(1025)\nuse(348)\nuse(124)\nchange(next)",
},
["team:152"] = {
["name"] = "Tommy the Cruel",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Swarm:706)",
},
["team:252"] = {
["name"] = "Do You Even Train? (Flyer)",
["code"] = "use(Tail Sweep:122) [enemy(Brul'dan:3571).active]\nuse(Dodge:312) [enemy.aura(Underwater:830).exists]\nuse(Dodge:312) [self.aura(Curse of Doom:217).duration=1]\nuse(Hawk Eye:521) [!self.aura(Hawk Eye:520).exists]\nuse(Claw:429)\nuse(#1)\nchange(next)",
},
["team:82"] = {
["name"] = "Frenzied Knifefang",
["code"] = "ability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(Falcosaur Swarm!:1773)\nchange(next)",
},
["team:78"] = {
["name"] = "Kelpstone",
["code"] = "change(#2) [self(#1).dead]\nability(Exposed Wounds:305)\nstandby [round=2]\nability(Flock:581) [round=4]\nability(Black Claw:919)",
},
["team:122"] = {
["name"] = "This Little Piggy Has Sharp Tusks",
["code"] = "change(next) [ self(#1).dead & !self(#3).played ] \nability(#2) [ !enemy.aura(217).exists ] \nability(#3) \nability(#1)",
},
["team:243"] = {
["name"] = "To a Land Down Under (Mech)",
["code"] = "use(Wind up:459)\nchange(#3) [self(#2).dead]\nuse(Supercharge:208) [enemy(#2).active & self(#2).active]\nuse(Supercharge:208) [enemy(#3).active]\nuse(Explode:282) [self(#2).aura(Supercharged:207).exists & enemy(#3).active]\nuse(Water jet:118)\nchange(#2) [enemy(#1).dead]\nuse(Extra plating:392) [round=1]\nuse(Supercharge:208) [round=2]\nuse(Laser:482)",
},
["team:277"] = {
["name"] = "Bloodknight Antari",
["code"] = "if [!enemy(#1).dead]\nuse(#3)\nuse(#1)\nendif\n\nif [!enemy(#2).dead & enemy(#1).dead]\nchange(#2) \nuse(Dive:564)\nuse(Shell Shield:310) [!self(#2).aura(Shell Shield:309).exists]\nuse(Absorb:449)\nendif\n\nif [enemy(#3).active]\nchange(#3) [self(#2).active & enemy(#3).hp>1347]\nchange(#1) [self(#3).active]\nuse(#3) [self(#1).active]\nuse(#2) [self(#1).active]\nuse(#1) [self(#1).active]\nchange(#2) [self(#1).dead]\nuse(Dive:564)\nuse(Shell Shield:310) [!self(#2).aura(Shell Shield:309).exists]\nuse(Absorb:449)\nendif",
},
["team:2"] = {
["name"] = "Add More to the Collection",
["code"] = "change(#3) [enemy(#3).active]\nability(어슬렁:536) [enemy(#2).active]\nability(비전 폭풍:589)\nability(부정한 희생:321)\nability(#2)\nability(#1) \nchange(next)",
},
["team:149"] = {
["name"] = "Gnomeregan Guard Wolf",
["code"] = "ability(Heat Up:945) [round=1]\nability(Heat Up:945) [enemy.round=2]\nability(Immolation:409) [round=2]\nstandby [enemy.aura(Dodge:2060).exists]\nstandby [enemy.aura(Undead:242).exists]\nability(#3) [enemy(#3).active & self.ability(#3).strong]\nability(Claw:429) [enemy(#2).active]\nability(Frenzy:1965) [!self.aura(Frenzy:739).exists]\nability(#1)\nchange(next)",
},
["team:346"] = {
["name"] = "Tiny Poacher, Tiny Animals (Critter)",
["code"] = "ability(Flamethrower:503) [enemy(#3).active]\nability(Crouch:165) [enemy(#2).active & enemy.hp<800]\nability(Rampage:124)\nability(#1)\nchange(next)",
},
["team:233"] = {
["name"] = "Zao, Calfling of Niuzao (2)",
["code"] = "use(167)\nuse(411)\nuse(919) [ round=3 ]\nuse(921)\nchange(#2)",
},
["team:355"] = {
["name"] = "Snail Fight! (Beast)",
["code"] = "standby [self.speed>207 & enemy.aura(Underwater:830).exists]\nuse(Howl:362)\nuse(Maul:345)\nuse(Bite:110)\nstandby\nchange(next)",
},
["team:34"] = {
["name"] = "Flow - Legendary",
["code"] = "use(#1) [round~1,2]\nuse(#3) [enemy(#1).aura(918).exists]\nuse(#2)\nuse(#3) [enemy(#1).aura(217).exists]\nchange(#2)",
},
["team:195"] = {
["name"] = "Mining Monkey",
["code"] = "ability(Launch Rocket:293) [ !self.aura(Setup Rocket:294).exists ]\nability(Launch Rocket:293) [ self.round>2 ]\nability(Blingtron Gift Package:989) [ !enemy(#1).active ]\nability(#1)\nchange(next)",
},
["team:69"] = {
["name"] = "Blingtron 4000",
["code"] = "--Experimental script, untested as of yet\nuse(Bubble) [ round = 1 ]\nuse(Whirlpool) [ round = 2 ]\nuse(Whirlpool) [ enemy(#2).active ]\nuse(Water Jet)\nuse(Stoneskin) [ self.aura(Stoneskin).duration < 2 ]\nuse(Leech Life) [ enemy.aura(Webbed).exists ]\nuse(Sticky Web)\nchange(#2)",
},
["team:56"] = {
["name"] = "Lyver",
["code"] = "use(919) [round=1] \nuse(581) [round=2] \nuse(1370) [round=5]",
},
["team:100"] = {
["name"] = "Zao, Calfling of Niuzao",
["code"] = "use(167)\nuse(411)\nuse(919) [ round=3 ]\nuse(921)\nchange(#2)",
},
["team:220"] = {
["name"] = "They're Full of Stars!",
["code"] = "use(Shadow Slash:210) [round=1]\nuse(Curse of Doom:218)\nuse(Unholy Ascension:321)\nuse(Time Bomb:602)\nuse(Flame Breath:501) [round=5]\nuse(Armageddon:1025)\nuse(Surge of Power:593) [enemy(#3).active]\nuse(Bite:110)\nchange(next)",
},
["team:365"] = {
["name"] = "Ka'wi the Gorger",
["code"] = "use(Howl:362) [ round = 1 ]\nuse(Superbark:1357) [ round = 2 ]\nuse(Bite:110) [ enemy.hp > 560 ]\nchange(#2) [ self(#1).dead ]\nuse(Explode:282) [ enemy.hp.can_explode ]\nuse(Reflective Shield:1105)\nstandby",
},
["team:213"] = {
["name"] = "Desert Survivors",
["code"] = "standby [ enemy.speed.fast & enemy.ability(Burrow:159).usable & enemy(#2).active ] \nability(Deflection:490) [ enemy.ability(Mudslide:572).usable ] \nability(Deflection:490) [enemy.aura(Underground:340).exists] \nability(#3) \nability(#1) \nchange(next)",
},
["team:221"] = {
["name"] = "Wrathion",
["code"] = "ability(Solar Beam:753) [enemy(#2).active & enemy(#3).dead]\nability(Arcane Storm:589)\nability(Consume Magic:1231)\nability(Sunlight:404)\nability(Photosynthesis:268) [!self.aura(Photosynthesis:267).exists]\nchange(#2) [self(#1).active]\nchange(#1) [self(#2).active]",
},
["team:127"] = {
["name"] = "What Do You Mean, Mind Controlling Plants?",
["code"] = "use(Curse of Doom:218)\nuse(Haunt:652)\nchange(#2) [self(#1).dead & !self(#2).active]\nuse(Black Claw:919) [round=3]\nuse(Black Claw:919) [round=9]\nstandby [self.aura(Stunned).duration>=1]\nuse(Savage Talon:518) [enemy.aura(Shattered Defenses:542).exists]\nuse(Flock:581)\nuse(Arcane Storm:589)\nchange(#3) [self(#2).dead & !self(#3).active]\nuse(Falcosaur Swarm!:1773)",
},
["team:16"] = {
["name"] = "Brutus and Rukus",
["code"] = "ability(Wind-Up:459) [ round=1 ]\nability(Supercharge:208) [ round=2 ]\nability(Wind-Up:459) [ round=3 ]\nability(Wind-Up:459) [ round=4 ]\nability(Wind-Up:459) [ round=5 ]\nability(Toxic Smoke:640) [ round=6 ]\nchange(Mechanical Pandaren Dragonling:844) [ round=7 ]\nability(Thunderbolt:779)\nability(Explode:282) [ enemy.hp<560 ]\nability(Breath:115) [ enemy.hp>560 ]",
},
["team:68"] = {
["name"] = "Elderspawn of Nalaada",
["code"] = "ability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(#2) [self.round=1]\nability(#3)\nchange(next)",
},
["team:278"] = {
["name"] = "Nicki Tinytech",
["code"] = "change(#3) [ !self(#3).played ]\nchange(#2) [ !self(#2).played ]\nchange(#2) [ self(#1).dead ]\nchange(#1)\nuse(Ancient Blessing:611) [ self.hpp < 70 & !self.aura(Dragonkin:245).exists ]\nuse(Ancient Blessing:611) [ self.hpp < 50 ]\nuse(Moonfire:595) [ weather(Moonlight:596).duration <= 1 ]\nuse(#1)\nstandby",
},
["team:138"] = {
["name"] = "Wastewalker Shu",
["code"] = "ability(Toxic Fumes:2349) [enemy(#1).active & self(#1).active]\nability(Toxic Fumes:2349) [weather(Sandstorm:454).duration>1]\nability(Poison Protocol:1954) [!enemy.aura(Poisoned:379).exists & enemy(#1).active]\nability(Poison Protocol:1954) [!enemy.aura(Poisoned:379).exists & enemy(#2).active]\nability(#1)\nstandby\nchange(next)",
},
["team:359"] = {
["name"] = "Snail Fight! (Flyer)",
["code"] = "ability(Dodge:312) [enemy.ability(Headbutt:376).usable]\nability(Dodge:312) [enemy.aura(Underwater:830).exists]\nability(Ravage:802) [enemy.hp<500 & enemy(#2).active]\nability(Call Darkness:256)\nability(Nocturnal Strike:517)\nability(#1)\nchange(next)",
},
["team:72"] = {
["name"] = "Door Control Console",
["code"] = "ability(Acidic Goo:369) [ enemy.hp.full ]\nuse(Dive:564) [round=2] \nuse(Dive:564) [self.aura(Ice Tomb:623).duration=1] \nuse(Dive:564) [self.aura(Sewage Eruption:2063).duration=1] \nuse(Ooze Touch:445) \nchange(next)",
},
["team:401"] = {
["name"] = "Training with the Nightwatchers (Magic)",
["code"] = "use(Void Nova:2356)\nuse(Poison Protocol:1954)\nuse(#1)\nchange(next)",
},
["team:168"] = {
["name"] = "Two and Two Together",
["code"] = "use(Arcane Storm:589) [!weather(Arcane Winds:590)]\nuse(Mana Surge:489)\nuse(Tail Sweep:122)\nchange(#2)\nuse(Wind-Up:459)\nuse(Wind-Up:459)",
},
["team:36"] = {
["name"] = "Flow - Rare",
["code"] = "use(Haunt:652)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Hunting party:921)\nuse(Leap:364)\nchange(next)\n\n--Script created by Anolaszun#1423",
},
["team:83"] = {
["name"] = "Fight Night: Bodhi Sunwayver",
["code"] = "change(#3) [self(#2).active]\nchange(#2) [round=2]\n\nuse(Armageddon:1025) [enemy.hp<=439 & self(#1).power=346]\nif [self(#1).power=276]\nuse(Armageddon:1025) [enemy.hp<=532 & self.aura(245).exists]\nuse(Armageddon:1025) [enemy.hp<=355] \nendif\n\nuse(Time Bomb:602) [!self(#3).dead]\nuse(Prowl:536)\nuse(Moonfire:595)\nuse(#1)\nchange(#1)",
},
["team:63"] = {
["name"] = "Natural Defenders",
["code"] = "use(Surge of Power:593) [enemy.hp<1111]\nuse(Tail Sweep:122) [round=1]\nuse(Arcane Storm:589) [round=2]\nuse(Mana Surge:489)\nuse(Wind-Up:459) [!enemy(#2).active]\nuse(Supercharge:208)\nuse(Call Lightning:204)\nuse(Howl:362)\nuse(Surge of Power:593)\nchange(next)",
},
["team:219"] = {
["name"] = "Unit 6",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652)\nability(Black Claw:919) [self.round=1]\nability(Flock:581)\nability(#1)\nchange(next)",
},
["team:271"] = {
["name"] = "Threads of Fate",
["code"] = "ability(#1) [ enemy.round~1,2 ] \nability(#2) [ enemy(#3).hp<556 ] \nability(#3) [ enemy(#3).active & enemy.hp>555 ] \nability(#1) \nchange(#2)",
},
["team:21"] = {
["name"] = "My Beast's Bidding",
["code"] = "quit [!self(#3).exists]\n\nchange(next) [self.dead]\nchange(#3) [self(#2).played]\n\nuse(#2) \nuse(#3) [self(#1).active]\nuse(#3) [enemy(#2).dead]\n\nuse(#1)\nstandby",
},
["team:123"] = {
["name"] = "Living Napalm",
["code"] = "standby [enemy.aura(Dodge:2060).exists]\nstandby [enemy.aura(Undead:242).exists]\n\nchange(#3) [enemy(Cockroach:2486).active]\n\nability(Acidic Goo:369) [!enemy.aura(Acidic Goo:368).exists]\nability(Corrosion:447) [!enemy.aura(Corrosion:446).exists & self(#1).active]\nability(Gnash:2322)\n\nability(Immolate:178) [!enemy.aura(Immolate:177).exists]\nability(Conflagrate:179) [enemy.aura(Immolate:177).exists]\nability(Burn:113)\n\nability(Creeping Ooze:448) [!enemy.aura(Creeping Ooze:781).exists]\nability(Corrosion:447) [!enemy.aura(Corrosion:446).exists]\nability(Poison Spit:380)\n\nchange(next)",
},
["team:105"] = {
["name"] = "Fight Night: Sir Galveston",
["code"] = "change(#3) [self(#2).played]\nuse(Armageddon:1025) [round=4]\nuse(Zeitbombe:602) [round=3]\nuse(Flammenatem:501)\nuse(Tiefer Atem:169) [enemy(#2).active]\nuse(Dunkelheit herbeirufen:256)\nchange(#2)",
},
["team:358"] = {
["name"] = "Snail Fight! (Elemental)",
["code"] = "use(Howl:362)\nuse(Burrow:159)\nuse(#1)\nstandby\nchange(next)",
},
["team:199"] = {
["name"] = "Delver Mardei",
["code"] = "use(Time Bomb:602)\nuse(Armageddon:1025) [ enemy.aura(Flame Breath:500).exists ]\nuse(Flame Breath:501)\nuse(Ice Tomb:624) [ !enemy.is(Dustie:3568) ]\nuse(Arcane Storm:589)\nuse(Breath:115)\nif [ enemy.is(Dustie:3568) ]\n    use(Howl:362) [ enemy.hp>1665 & self.aura(Dragonkin).exists ]\n    use(Howl:362) [ enemy.hp>1110 & !self.aura(Dragonkin).exists ]\n    use(Surge of Power:593)\nendif\nuse(Bite:110)\nchange(next)",
},
["team:92"] = {
["name"] = "Goldenbot XD",
["code"] = "change(#2) [ round=3 ]\nchange(#1) [ self(#2).active ]\nuse(786)\nstandby [self(#1).active]\nuse(919) [ self.round = 1 ]\nuse(581)\nchange(#3)",
},
["team:254"] = {
["name"] = "Do You Even Train? (Critter)",
["code"] = "use(Burrow:159) [enemy.aura(Underwater:830).exists]\nuse(Woodchipper:411) [!enemy.aura(Bleeding:491).exists & enemy(#1).dead]\n\nuse(Feign Death:568) [enemy.ability(Headbutt:376).usable]\nuse(#1)\n\nchange(next)",
},
["team:293"] = {
["name"] = "Stand Up to Bullies",
["code"] = "change(#1) [self(#2).dead]\nuse(#1) [round=1]\nuse(#3) [round=2]\nchange(#2) [round=3]\nuse(Black Claw:919) [!enemy.aura(Black Claw).exists]\nuse(Flock:581)\nuse(Build Turret:710) [enemy.aura(Black Claw).exists]\nuse(Metal Fist:384)",
},
["team:88"] = {
["name"] = "Algalon the Observer",
["code"] = "change(#2) [round=3]\nchange(#1) [round=5]\nuse(Explode:282) [round=8]\nuse(Blinding Powder:1015) [round~2,6]\nuse(Sting:359)\n\nuse(Decoy:334) [enemy(#3).active]\nuse(Razor Talons:2237) [!enemy.aura(Razor Talons:2238).exists]\nuse(Flame Breath:501) [enemy(#3).active]\n\nuse(Chop:943) [enemy(#2).active & !enemy.ability(#1).usable]\nuse(Blistering Cold:786) [!enemy(#1).active]\nuse(Chop:943)\n\nchange(#3)",
},
["team:284"] = {
["name"] = "Beegle Blastfuse",
["code"] = "use(Arcane Storm:589)\nuse(Mana Surge:489)\nuse(Tail Sweep:122)\nchange(Anubis:1155) [self(Nexus Whelpling:1165).dead]\nuse(Sandstorm:453)\nuse(Crush:406)",
},
["team:156"] = {
["name"] = "Deviate Chomper",
["code"] = "ability(Evanescence:440)\nability(Forboding Curse:1068) [!enemy.aura(Forboding Curse:1067).exists]\nability(#1)\nchange(next)",
},
["team:141"] = {
["name"] = "Uncomfortably Undercover",
["code"] = "change(#3) [enemy(#3).dead]\nability(208)\nability(447) [!enemy.aura(446).exists]\nability(#3)\nability(#2)\nchange(next)",
},
["team:38"] = {
["name"] = "Adinakon",
["code"] = "use(Explode:282)\nuse(Murder the Innocent:2223)\nchange(next)",
},
["team:366"] = {
["name"] = "Kafi",
["code"] = "change(#1) [self(#2).active & self.dead]\nchange(#2) [round=2]\nuse(Supercharge:208) [self.aura(Wind-Up:458).exists]\nuse(Wind-Up:459)\nuse(Howl:362) [self.aura(Undead:242).exists]\nuse(Diseased Bite:499)\nuse(Shock and Awe:646)\nuse(Ion Cannon:209)\nstandby",
},
["team:205"] = {
["name"] = "Klutz's Battle Monkey",
["code"] = "ability(Ironskin:1758) [ round>2 ]\nability(Predatory Strike:518) [ enemy.aura(Shattered Defenses:542).exists & enemy.hpp>25 ]\nability(#1)\nchange(#2)",
},
["team:169"] = {
["name"] = "Hiss",
["code"] = "ability(Extra Plating:392) [round=1]\nability(Make it Rain:985)\nability(Inflation:1002)\nability(Moonfire:595)\nability(Soulrush:752)\nability(#1)\nchange(next)",
},
["team:240"] = {
["name"] = "Are They Not Beautiful? (Undead)",
["code"] = "use(beam:1035) [ round = 1 ]\nuse(rush:752)\nuse(filler:1066)\nchange(next)\ntest(Bad RNG, clean up somehow)",
},
["team:292"] = {
["name"] = "Fight Night: Heliosus",
["code"] = "ability(218)\nability(652)\nchange(#2) \nability(919) [self.round=1]\nability(581)",
},
["team:289"] = {
["name"] = "Seeker Zusshi",
["code"] = "if [enemy(#1).active]\nability(453)\nability(490)\nability(406)\nendif\n\nif [enemy(#2).active]\nability(490) [enemy.round=3]\nability(406) [enemy.round <=2]\nchange(#2) [self(#1).active]\nability(597) [!self.aura(823).exists]\nability(612) [enemy.round= 8]\nability(525)\nendif\n\nif [enemy(#3).active]\nability(525)\nchange(#1) [self(#2).dead]\nability(490) [enemy.aura(269).exists]\nability(453)\nability(406)\nstandby\nendif",
},
["team:41"] = {
["name"] = "Postmaster Malown",
["code"] = "use(Swarm of Flies:232) [enemy(#1).aura(Undead:242).exists]\nuse(Swarm of Flies:232) [round=1]\nuse(Bubble:934) [self.aura(Curse of Doom:217).duration=1]\nuse(Swarm of Flies:232) [!enemy.aura(Swarm of Flies:231).exists]\nuse(Tongue Lash:228)\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Flock:581)\nchange(next) [self.dead]",
},
["team:345"] = {
["name"] = "Tiny Poacher, Tiny Animals (Beast)",
["code"] = "standby [enemy(#2).hp<800 & enemy.ability(Feign Death:568).usable]\nability(Rake:492) [enemy.round=1 & enemy(#1).active]\nability(Rake:492) [enemy(#2).active]\nability(Feathered Frenzy:1398)\nability(Burrow:159) [enemy.ability(Flame Jet:1041).duration=2]\nability(Deep Burn:1407) [enemy.aura(Flame Breath:500).exists]\nability(Beaver Dam:325) [enemy(#3).active]\nability(Chew:541) [self.aura(Beaver Dam:326).exists]\nability(#1)\nchange(next)",
},
["team:249"] = {
["name"] = "Yu'la, Broodling of Yu'lon (2)",
["code"] = "standby [round=5]\nuse(Darkflame:792) [round=7]\nchange(#1) [self(#3).active]\nuse(Murder the Innocent)\nuse(Eyeblast:475)\nchange(next)",
},
["team:269"] = {
["name"] = "Do You Even Train? (Beast)",
["code"] = "change(next) [self.dead]\n\nuse(Ethereal:998) [enemy.aura(Underwater:830).exists]\nuse(Mangle:314) [!enemy.aura(Mangle:313).exists]\nuse(Swipe:2346)\n\nuse(Great Sting:1966) [!enemy(Brul'dan:3571).dead]\nuse(Scorched Earth:172)\nuse(Flame Breath:501)\n\nuse(#1)\nstandby",
},
["team:162"] = {
["name"] = "Yu'la, Broodling of Yu'lon",
["code"] = "standby [round=5]\nuse(Darkflame:792) [round=7]\nchange(#1) [self(#3).active]\nuse(Murder the Innocent)\nuse(Eyeblast:475)\nchange(next)",
},
["team:145"] = {
["name"] = "Dreadcoil",
["code"] = "if [enemy(#1).active]\n    ability(392) [self.round=1]\n    ability(985) [self.round=2]\n    ability(1002)\nendif\nability(1002)\nchange(#2) [self(#1).dead]\n\nability(#3) [enemy.hp<618 & enemy.type !~ 3]\nability(#3) [enemy.hp<406 & enemy.type ~ 3]\nability(#2) [!self(#2).aura(820).exists]\nability(#1)",
},
["team:264"] = {
["name"] = "Do You Even Train? (Mech)",
["code"] = "change(#3) [ enemy.is(Swole:3573) & self.aura(Decoy:333).exists ]\nchange(#3) [ enemy.is(Swole:3573) & !enemy.ability(Headbutt:376).usable ]\nuse(Powerball:566) [ !self.speed.fast ]\nif [ self.aura(Wind-Up:458).exists ]\n    use(Supercharge:208) [ enemy.is(Lifft:3572) & enemy.ability(Dive:564).duration~2,3,4 ]\n    use(Powerball:566) [ enemy.aura(Underwater:830).exists ]\n    use(Wind-Up:459) [ enemy.is(Brul'dan:3571) ]\nendif\nuse(Powerball:566) [ enemy.is(Brul'dan:3571) & self.aura(Mechanical:244).exists & !enemy.ability(Drain Power:486).usable ]\nuse(Wind-Up:459)\nif [ enemy.is(Brul'dan:3571) ]\n    use(Time Bomb:602) [ enemy.hp<1097 ]\n    use(Decoy:334) [ enemy.hp<549 & !enemy.aura(Flame Breath:500).exists ]\nendif\nuse(Flame Breath:501) [ !enemy.is(Swole:3573) ]\nuse(Alert!:1585) [ enemy.hp>1726 ]\nuse(Alert!:1585) [ enemy.is(Brul'dan:3571) ]\nuse(Ion Cannon:209) [ self.aura(Supercharged:207).exists ]\nuse(Supercharge:208)\nstandby [ self(#2).active ]\nchange(next)",
},
["team:87"] = {
["name"] = "Hyuna of the Shrines",
["code"] = "if [ enemy(#1).active ]\nability(453) [ self.round=1 ]\nability(406)\nendif\nif [ enemy(#2).active ]\nchange(#2) [ self(#1).active ]\nability(710)\nability(384)\nendif\nif [ enemy(#3).active ]\nability(384)\nchange(#1) [ self(#2).dead ]\nability(406)\nendif\nstandby [ self(#1).aura(Stunned:927).exists ]",
},
["team:197"] = {
["name"] = "To a Land Down Under",
["code"] = "standby [self(#1).active & round>2]\nstandby [self(#3).active & enemy(#2).active & enemy.round=2]\n\nuse(Poison Protocol:1954)\nuse(Corrosion:447)\nuse(Flame Breath:501) [round=3 & !enemy.aura(Corrosion:446).exists]\nuse(Time Bomb:602)\nuse(Armageddon:1025)\nuse(Reckless Strike:186) [enemy(#1).active]\nuse(Counterspell:308)\nuse(Call Lightning:204)\nchange(next)",
},
["team:227"] = {
["name"] = "To a Land Down Under (Humanoid)",
["code"] = "change(next) [self.dead]\n\nuse(Jar of Smelly Liquid:1556) [!enemy.aura(Corrosion:446).exists]\nuse(Corrosion:447) [round=2]\nuse(Nether Gate:466) [round=3]\nuse(Corrosion:447)\n\nuse(Clobber:350)\nuse(Fish Slap:1737) [enemy(Bassalt:3560).active]\nuse(Bubble:934) [enemy(Clawz:3559).active]\nuse(Fish Slap:1737)\n\nuse(Ice Tomb:624)\nuse(Call Blizzard:206)\nuse(Ice Lance:413)",
},
["team:209"] = {
["name"] = "Liz",
["code"] = "ability(Call Lightning:204)\nability(Zap:116) [enemy.aura(Swarm of Flies:231).exists]\nability(Swarm of Flies:232)\nchange(#2)\nuse(Decoy:334)",
},
["team:179"] = {
["name"] = "Blackmane",
["code"] = "if [enemy.aura(Undead:242).exists]\nstandby [self(#3).level=25]\nchange(#1) [self(#3).played]\nchange(#3) [self(#3).level<25]\nendif\nuse(Curse of Doom:218)\nuse(Haunt:652)\nuse(Black Claw:919) [self.round=1]\nuse(Flock:581) [enemy.aura(918).exists & round<7]\nuse(#1)\nchange(next)",
},
["team:236"] = {
["name"] = "Are They Not Beautiful? (Undead) (2)",
["code"] = "use(beam:1035) [ round = 1 ]\nuse(rush:752)\nuse(filler:1066)\nchange(next)\ntest(Bad RNG, clean up somehow)",
},
["team:107"] = {
["name"] = "Watch Where You Step",
["code"] = "ability(Curse of Doom:218)\nability(Inflation:1002) [enemy.aura(Shattered Defenses:542).duration<2]\nability(#1) [self(#3).active]\nability(#3)\nchange(next)",
},
["team:171"] = {
["name"] = "Right Twice a Day",
["code"] = "ability(Curse of Doom:218)\nability(Haunt:652)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(#1)\nchange(next)",
},
["team:102"] = {
["name"] = "Dune Buggy",
["code"] = "ability(Blistering Cold:786) [round=1]\nability(BONESTORM:1762) [round>2]\nability(Chop:943)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Hunting Party:921)\nchange(next)",
},
["team:183"] = {
["name"] = "Clear the Catacombs",
["code"] = "use(Extra Plating:392) [!self.aura(Extra Plating:391).exists]\nuse(Make it Rain:985) [!enemy.aura(Make it Rain:986).exists]\nuse(Inflation:1002)\nchange(Ikky:1532) [self(#1).dead]\nuse(Savage Talon:1370) [!enemy(Ancient Catacomb Spider:1860).dead]\nif [enemy(Catacomb Bat:1861).active]\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nendif\nuse(Flock:581)\nchange(Iron Starlette:1387) [enemy(Catacomb Snake:1862).active]\nuse(Supercharge:208) [self.aura(Wind-Up:458).exists]\nuse(Wind-Up:459)",
},
["team:352"] = {
["name"] = "Tiny Poacher, Tiny Animals (Mech)",
["code"] = "change(#1) [self(#2).dead]\nability(Lock-On:301) [round~1,2]\nability(Minefield:634)\n\nability(Decoy:334)\nability(Thunderbolt:779) [!enemy(#2).active]\nability(Breath:115)\n\nability(Lock-On:301) [enemy(#3).active]\nstandby [self(#3).active]\nchange(next)",
},
["team:57"] = {
["name"] = "Prince Wiggletail",
["code"] = "ability(Shadow Shock:422) [round=1]\nability(Curse of Doom:218)\nability(Haunt:652)\nability(#1) [enemy.aura(Shattered Defenses:542).exists]\nability(Flock:581)\nchange(next)",
},
["team:132"] = {
["name"] = "Crawg in the Bog",
["code"] = "ability(Alert!:1585) [round=1]\nability(Supercharge:208)\nability(Ion Cancon:209)",
},
["team:231"] = {
["name"] = "Do You Even Train? (Elemental)",
["code"] = "use(Bubble:934)\nuse(Barrel Toss:354)\nuse(Scorched Earth:172)\nuse(Conflagrate:179) [ enemy.is(Swole:3573) ]\nuse(Flame Breath:501)\nuse(Puppies of the Flame:1354) [ enemy.aura(Underwater:830).exists ]\nif [ !enemy.ability(Headbutt:376).usable & enemy.ability(Dive:564).usable ]\n    if [ weather(Scorched Earth:171) ]\n        use(Puppies of the Flame:1354) [ self(#2).power=305 & enemy.hp>380 ]\n        use(Puppies of the Flame:1354) [ self(#2).power=289 & enemy.hp>376 ]\n        use(Puppies of the Flame:1354) [ self(#2).power=276 & enemy.hp>374 ]\n        use(Puppies of the Flame:1354) [ self(#2).power=260 & enemy.hp>371 ]\n    endif\n    use(Puppies of the Flame:1354) [ enemy.hp>315 ]\nendif\nif [ enemy.is(Swole:3573) & !enemy.aura(Underwater:830).exists ]\n    use(Superbark:1357) [ weather(Scorched Earth:171) ]\n    use(Superbark:1357) [ enemy.hp>315 ]\nendif\nuse(Blazing Yip:1359)\nstandby [ self.aura(Stunned:927).exists ]\nchange(next)",
},
["team:91"] = {
["name"] = "I Am The One Who Whispers",
["code"] = "ability(Curse of Doom:218) [round=2]\nability(Haunt:652) [round=3]\nability(Black Claw:919) [self.round=1]\nability(Flock:581) [!enemy.aura(Shattered Defenses:542).exists]\nability(#1)\nchange(next)",
},
["team:135"] = {
["name"] = "No-No",
["code"] = "ability(Crouch:165) [round=1]\nability(Falcosaur Swarm!:1773) [enemy.aura(Beaver Dam:326).exists]\nability(Predatory Strike:518) [enemy.aura(Shattered Defenses:542).exists]\nability(Savage Talon:1370) [enemy.aura(Shattered Defenses:542).exists]\nability(Falcosaur Swarm!:1773)\nchange(next)",
},
["team:158"] = {
["name"] = "Accidental Dread",
["code"] = "if [ !self(#2).active ]\n    ability(Life Exchange:277) [ enemy(#2).active ]\n    ability(Moonfire:595) [ enemy.round<3 ]\n    ability(Arcane Blast:421)\nendif\nchange(#3) [ self(#2).played ]\nchange(#2) [ !self(#2).played ]\nability(Arcane Storm:589)\nability(Mana Surge:489)\nability(Tail Sweep:122)",
},
["team:12"] = {
["name"] = "Briarpaw",
["code"] = "ability(Dodge:312) [enemy.aura(Dodge:311).exists]\nability(Burrow:159) [self.ability(Dodge:312).duration=2]\nability(#1)",
},
["team:111"] = {
["name"] = "Farmer Nishi",
["code"] = "if [enemy(#1).active]\nability(453)\nability(490) [self.round> 2]\nability(406)\nendif\nif [enemy(#2).active]\nstandby [enemy.round <= 3]\nstandby [enemy.round=11]\nstandby [enemy.round= 12]\nability(490) [enemy.round=4]\nability(490) [enemy.round=9]\nability(490) [enemy.round=14]\nability(453) [enemy.round=10]\nability(406)\nendif\nif [enemy(#3).active]\nstandby [enemy.round=2]\nability(490) [enemy.round=3]\nability(406) [enemy.round= 1]\nchange(#2) [self(#1).active]\nability(646)\nability(777) [enemy.round = 6]\nability(209)\nendif",
},
["team:15"] = {
["name"] = "Vesharr",
["code"] = "ability(Arcane Explosion:299) [round=1]\nability(Arcane Explosion:299) [round=2]\nability(Ancient Blessing:611) [round=3]\nability(Surge of Power:593) [enemy(Apexis Guardian:1559).active & enemy.aura(Flying Mark:1420).exists]\nability(Ancient Blessing:611)\nability(Arcane Explosion:299)\nchange(Mechanical Pandaren Dragonling:844)\nability(Thunderbolt:779)\nability(Breath:115)",
},
["team:280"] = {
["name"] = "Narrok",
["code"] = "ability(453)\nability(406)\nstandby",
},
["team:47"] = {
["name"] = "Are They Not Beautiful? (Dragon)",
["code"] = "use(Mana Surge:489) [weather(Arcane Winds:590).duration>1]\nuse(Surge of Power:593) [enemy(#3).active & enemy.hp<1099]\nuse(Surge of Power:593) [enemy(#3).active & self.aura(Dragonkin:245).exists]\nuse(Arcane Storm:589)\n\nuse(Arcane Blast:421)\nuse(#1)\n\nchange(next)",
},
["team:76"] = {
["name"] = "Sharp as Flint",
["code"] = "ability(Supercharge:208) [round=2]\nability(Toxic Smoke:640) [round>5]\nability(Wind-Up:459)\n\nability(Breath:115) [!enemy(Lord Flappinsby:3451).dead]\n\nability(Flock:581) [enemy.aura(Black Claw:918).exists]\nability(Black Claw:919)\n\nchange(Mechanical Pandaren Dragonling:844) [!enemy(Lord Flappinsby:3451).dead]\nchange(Ikky:1532)",
},
["team:128"] = {
["name"] = "Flowing Pandaren Spirit",
["code"] = "if [enemy(#1).active]\nability(312) [enemy.round=3]\nability(504)\nendif\n\nif [enemy(#2).active]\nability(312)\nability(504)\nendif\n\nif [enemy(#3).active]\nability(312) [enemy.round=4]\nability(504)\nendif",
},
["team:42"] = {
["name"] = "Ezra Grimm",
["code"] = "ability(Garra negra:919) [!enemy.aura(Garra negra:918).exists]\nability(Grupo de caza:921) [!enemy.aura(Defensas desarmadas:542).exists]\nability(Saltar:364)\n---------------------------------------------------------------\nability(Fiesta de los muertos:1093) [self.aura(No-muerto:242).exists]\nability(Fiesta de los muertos:1093) [!enemy.aura(Defensas desarmadas:542).exists]\nability(Maraca macabra:1094)\n-----------------------------------------------------------------\nability(Excavar:159) [enemy.aura(No-muerto:242).exists]\nability(Esquivar:312) [self.aura(Aullido:1725).exists]\nability(Aluvión:360)\n------------------------------------------------------------------\nstandby [self.aura(Aturdido:927).exists]\nchange(next)",
},
["team:140"] = {
["name"] = "Kostos",
["code"] = "use(Blistering Cold:786)\nuse(BONESTORM!!:1762)\nuse(Chop:943)\nuse(Black Claw:919) [ self.round=1 ]\nuse(Flock:581)\nchange(next)",
},
["team:188"] = {
["name"] = "Belchling",
["code"] = "ability(Acid Rain:1051) [round=1]\nability(Dreadful Breath:668)\nability(Twilight Meteorite:1960)\nability(#1)\nchange(next)",
},
["team:130"] = {
["name"] = "You Have to Start Somewhere",
["code"] = "standby [self(#3).active]\n\nuse(Minefield:634)\nuse(Explode:282)\n \nuse(Time Bomb:602)\nuse(Flame Breath:501) [round=4]\nuse(Armageddon:1025)\n\nchange(next)",
},
["team:218"] = {
["name"] = "Unit 35",
["code"] = "ability(Rabid Strike:666) [!enemy.aura(Rabies:807).exists]\nability(Corpse Explosion:663)\n\nability(Fire Shield:1754)\nability(Flamethrower:503)\n\nchange(next)",
},
["team:161"] = {
["name"] = "Angry Geode",
["code"] = "standby [ self.aura(734).exists ]\nability(513)\nability(123) [ self.round > 5 ]\nability(509)\nchange(#2)\n\nability(#3) [enemy.hp<618 & enemy.type !~ 3]\nability(#3) [enemy.hp<406 & enemy.type ~ 3]\nability(#2) [!self(#2).aura(820).exists]\nability(#1)",
},
["team:66"] = {
["name"] = "Wise Mari",
["code"] = "if [enemy(#1).active]\nability(453)\nability(490)\nability(406)\nendif\nif [enemy(#2).active]\nchange(#2) [self(#1).active]\nability(334) [enemy.round= 2]\nability(779)\nability(115)\nendif\nif [enemy(#3).active]\nchange(#1) [self(#2).active]\nability(453)\nability(490)\nability(406)\nendif",
},
["team:71"] = {
["name"] = "Lurking In The Shadows",
["code"] = "use(Appel de la foudre:204)\nuse(Détraqué:916)",
},
["team:98"] = {
["name"] = "Cliffs of Bastion",
["code"] = "use(Decoy:334) [round=1]\nuse(Explode:282) [enemy.hp<=618]\nuse(Missile:777)\nuse(Wind-Up:459) [enemy(#2).active]\nuse(Toxic Smoke:640)\nuse(Surge of Power:593) [enemy.hp<=1110]\nuse(Howl:362)\nchange(next)",
},
["team:52"] = {
["name"] = "Horu Cloudwatcher",
["code"] = "ability(Bubble:934) [round=1]\nability(Stampede:163) [!enemy.aura(Shattered Defenses:542).exists]\nability(Explode:282) [self.hp<1061 & enemy.round>1 & enemy(#3).active]\nability(Supercharge:208) [enemy(#3).active]\nability(#1)\nchange(next)",
},
["team:108"] = {
["name"] = "Unit 17",
["code"] = "change(#2) [round=3]\nchange(#3) [self(#2).active]\n\nability(Blistering Cold:786)\nability(Black Claw:919) [self.round=1]\nability(#1)\nchange(next)",
},
["team:103"] = {
["name"] = "Eyegor's Special Friends",
["code"] = "use(Call Lightning:204)\nuse(Haywire:916)\nuse(Fel Imolate:901)\n\nuse(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nuse(Quills:184) [enemy(#2).active]\nuse(Flock:581) [enemy(#3).active]\n\nuse(Supercharge:208)\nuse(Ion Cannon:209)\n\nchange(next)",
},
["team:150"] = {
["name"] = "Failed Experiment",
["code"] = "use(Glowing Toxin:270) [ round=1 ]\nuse(Explode:282)\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nchange(#2)",
},
["team:24"] = {
["name"] = "Tremblor - Legendary",
["code"] = "use(Wild Magic:592) [ round=1 ]\nuse(Illuminate:460)\nuse(Explode:282) [ enemy.aura(Glowing Toxin:271).exists ]\nuse(Glowing Toxin:270)\nuse(Murder the Innocent:2223)\nchange(next)",
},
["team:257"] = {
["name"] = "Are They Not Beautiful? (Beast)",
["code"] = "use(Feathered Frenzy:1398) [ round=1 ]\nuse(Gift of Winter's Veil:586)\nuse(Pounce:535)\nuse(Prowl:536)\nuse(Arcane Dash:1536)\nuse(Moonfire:595)\nchange(next)",
},
["team:23"] = {
["name"] = "Growing Ectoplasm 2",
["code"] = "change(#2) [self(#1).dead]\nchange(#3) [self(#2).dead]\nif [enemy(#1).active]\n    ability(919) [!enemy.aura(918).exists]\n    ability(921)\n    ability(364) [enemy.aura(542).exists]\nendif\nability(919) [!enemy.aura(918).exists]\nability(921)\nability(597) [self.aura(823).duration<=1]\nability(598) [self.hp<1000]\nability(525)",
},
["team:117"] = {
["name"] = "Living Permafrost",
["code"] = "ability(Toxic Skin:1087) [!self.aura(Toxic Skin:1086).exists & self.speed.fast]\nability(Toxic Skin:1087) [self.aura(Toxic Skin:1086).duration<2 & self.speed.slow]\n\nstandby [enemy.aura(Dodge:2060).exists]\nstandby [enemy.aura(Undead:242).exists]\n\nability(Burrow:159) [enemy(Cockroach:2486).active]\nability(Scratch:119)\n\nability(Claw:429) [enemy(Cockroach:2486).active]\nability(Flamethrower:503) [!enemy.aura(Flamethrower:502).exists]\nability(Conflagrate:179) [enemy.aura(Flamethrower:502).exists]\nability(Flamethrower:503)\n\nability(Strike:378) [enemy(Cockroach:2486).active]\nability(Frostbite Webbing:2478) [!enemy.aura(Brittle Webbing:381).exists]\nability(Shiverweb Swarm:2477) [enemy.aura(Brittle Webbing:381).exists]\nability(Strike:378)\n\nchange(next)",
},
["team:62"] = {
["name"] = "Silence",
["code"] = "quit [ round<4 & self(#1).dead & !enemy.aura(Shattered Defenses:542).exists ]\ntest(\"Please finish the fight with standard attacks.\") [ self(#3).active ]\nuse(Black Claw:919) [ round=1 ]\nuse(Swarm:706)\nuse(Flock:581)\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nchange(#2)",
},
["team:94"] = {
["name"] = "Mighty Minions of Maldraxxus",
["code"] = "if [self(#1).active]\nuse(Curse of Doom:218) [self.round==1]\nuse(Consume Magic:1231) [self.round==2]\nuse(Shadow Shock:422)\nendif\n\nif [enemy(#2).active]\nchange(#2) [self(#1).dead]\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nendif\n\nif [!self(#3).played]\nchange(#3)\nendif\n\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nuse(Tail Sweep:122)\n\nif [enemy(Chipper:2982).ability(Lift-Off:170).usable]\nuse(Supercharge:208)\nendif\n\nif [self(#2).aura(Supercharged:207).exists]\nuse(Ion Cannon:209)\nendif\n\nuse(Alert!:1585)",
},
["team:93"] = {
["name"] = "Thenia's Loyal Companions",
["code"] = "standby [ self.aura(Asleep:498).exists ]\nchange(#2) [ enemy.aura(Stunned:927).exists ]\nchange(#3) [ enemy(#3).active ]\nuse(Ethereal:998) [ round=1 ]\nuse(Soulrush:752)\nuse(Arcane Storm:589)\nuse(Mana Surge:489)\nuse(Supercharge:208)\nuse(Ion Cannon:209)\nstandby",
},
["team:18"] = {
["name"] = "Tempton",
["code"] = "ability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)",
},
["team:251"] = {
["name"] = "Chi-Chi, Hatchling of Chi-Ji (3)",
["code"] = "ability(Immolation:409) [!self.aura(Immolation:408).exists]\nability(Wild Magic:592) [!enemy.aura(Wild Magic:591).exists]\nability(Acidic Goo:369) [self.round=1]\nability(Dive:564) [self.round=4]\nchange(#2)\nability(#1)",
},
["team:121"] = {
["name"] = "The Grand Master",
["code"] = "change(#2) [round=6]\nuse(Ice Tomb:624) [enemy(#1).active]\nuse(Call Blizzard:206) [round=2]\nuse(Ice Lance:413)\nuse(Poison Protocol:1954)\nuse(Void Nova:2356)\nuse(Corrosion:447)\nchange(#3)",
},
["team:282"] = {
["name"] = "Major Payne",
["code"] = "ability(Extra Plating:392)\nability(Make it Rain:985) [!enemy.aura(Make it Rain:986).exists]\nability(SMCKTHAT.EXE:983)\nstandby [self.aura(Stunned:927).exists]\nability(Shell Shield:310) [self.aura(Shell Shield:309).duration = 1]\nability(Surge:509)\nchange(next)",
},
["team:245"] = {
["name"] = "To a Land Down Under (Aquatic)",
["code"] = "quit [self(#1).dead & enemy.aura(Sewage Eruption:2063).exists]\n\nchange(#3) [enemy(#3).active & enemy.aura(Void Tremors:2359).exists & self(#2).active & self.hp>352]\n\nability(Sewage Eruption:2062)\nability(Moonfire:595)\n\nability(Feedback:484) [enemy(#1).active]\n\nability(Pump:297) [!self.aura(Pumped Up:296).exists & enemy(#2).active]\nability(Pump:297) [enemy(#2).active & enemy.hp<1226]\nability(Void Tremors:2360) [enemy.aura(Tough n' Cuddly:1111).exists & enemy(#3).active]\n\nability(Overcharge:2342) [enemy(#3).active & enemy.hp<116]\n\nability(#1)\nchange(next)",
},
["team:147"] = {
["name"] = "Huncher",
["code"] = "standby [enemy.aura(Undead:242).exists]\nability(Flurry:360) [enemy.aura(Shattered Defenses:542).duration=2]\nability(Dodge:312)\nability(Flurry:360) [enemy.hp<=309]\nability(Stampede:163)\nability(#1)\nchange(next)",
},
["team:190"] = {
["name"] = "Swog the Elder",
["code"] = "change(#1) [self(#3).active]\nuse(Sunlight:404) [round=1]\nuse(Murder the Innocent:2223)\nif [self(#3).played]\nuse(Solar Beam:753)\nuse(Skitter:626)\nuse(Darkflame:792)\nuse(Scorched Earth:172)\nuse(Eyeblast:475)\nuse(Eye Beam:1533)\nuse(Trample:377)\nendif\nchange(next)",
},
["team:4"] = {
["name"] = "Gargra",
["code"] = "ability(Explode:282) [enemy(#3).active & enemy.hp.can_explode]\nability(Decoy:334) [enemy(#3).active & enemy.ability(Howl:362).duration=1]\nability(Make it Rain:985) [round=1]\nability(Extra Plating:392)\nstandby [enemy.aura(Dodge:311).exists]\nability(Make it Rain:985)\nability(#1)\nchange(next)",
},
["team:104"] = {
["name"] = "Tiny Poacher, Tiny Animals",
["code"] = "-- rng in the beginning (<0.5%)\nquit [enemy(#1).dead & round=4]\n--\n-- rare case: too many critical strikes Ice lance Turn4+ 5\nuse(Explode:282) [enemy(#1).dead & enemy(#2).dead]\n--\nuse(Explode:282) [enemy(#1).dead & enemy(#3).dead & enemy(#2).hp<561]\nuse(Ice Tomb:624)\nuse(Call Blizzard:206)\nuse(Ice Lance:413)\nuse(Thunderbolt:779) [enemy(#3).active & enemy.aura(Stunned:927).exists]\nuse(Breath:115)\nchange(next)",
},
["team:136"] = {
["name"] = "Training with Bredda",
["code"] = "quit [!self(#3).exists]\nquit [self(#2).dead]\nquit [self(#1).dead & enemy(#2).hp>963]\n\nif [self(#1).active]\n    use(Smoke Cloud:2239) [round=1]\n    use(Smoke Cloud:2239) [enemy(#1).aura(Undead:242).exists]\n    use(Explode:282) [enemy(#2).active & enemy.round=3]\n    use(Skitter:626)\n    use(Chomp:367)\nendif\n\nif [self(#3).active]\n   use(Alert!:1585) [enemy(#2).active]\n   use(Supercharge:208)\n   use(Ion Cannon:209)\nendif\n\nchange(next)",
},
["team:198"] = {
["name"] = "Deebs, Tyri and Puzzle",
["code"] = "change(#3) [self.dead]\nchange(#1) [self(#3).active]\nuse(Sunlight:404) [!weather(Sunny Day:403) & self(#1).active]\nchange(#2) [self(#1).active]\nuse(Explode:282)\nuse(Bite:110) [enemy(Deebs:1400).active]\nuse(Solar Beam:753)",
},
["team:49"] = {
["name"] = "Zuna Skullcrush",
["code"] = "-- just in case\nuse(Predatory Strike:518) [enemy(#3).active]\n--\nchange(#2) [round~4,15]\nchange(#1) [round=12]\nuse(Crouch:165) [round=7]\nuse(Glowing Toxin:270) [round=3]\nuse(Glowing Toxin:270) [!enemy.aura(Glowing Toxin:271).exists]\nuse(Amber Prison:1026)\nuse(Bash:348) [round~5,11]\nuse(Bash:348) [enemy(#3).active]\nuse(Trample:377)\nuse(Twilight Meteorite:1960) [self.aura(Dragonkin:245).exists]\nuse(Phase Shift:764) [enemy.hp>800]\nuse(Tail Sweep:122)\nchange(#3)\nchange(next)",
},
["team:177"] = {
["name"] = "Tremblor - Rare",
["code"] = "ability(Blistering Cold:786)\nability(Chop:943) [!enemy.aura(Bleeding:491).exists]\nability(BONESTORM!!:1762)\n\nability(Primal Cry:920)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Hunting Party:921)\n\nability(#1)\nchange(next)",
},
["team:33"] = {
["name"] = "That's a Big Carcass",
["code"] = "standby [ enemy(#2).active & enemy.round=1 ]\nability(#2) [ !enemy(#3).active ]\nability(#3) [ enemy.aura(Shattered Defenses:542).exists ]\nability(#1)\nchange(#2)",
},
["team:262"] = {
["name"] = "To a Land Down Under (Beast)",
["code"] = "change(#2) [ round=5 ]\nchange(#1) [ self(#2).dead & !enemy(Clawz:3559).dead ]\nuse(Prowl:536) [ !enemy.is(Clawz:3559) & enemy.hp>339 & !weather(Moonlight:596) ]\nuse(Prowl:536) [ !enemy.is(Clawz:3559) & enemy.hp>309 ]\nuse(Arcane Dash:1536)\nuse(Scrabble:2430)\nuse(Moonfire:595)\nuse(Spirit Claws:974)\nuse(Booby-Trapped Presents:1080) [ enemy.is(Clawz:3559) ]\nuse(Huge Fang:930)\nuse(Gift of Winter's Veil:586)\nstandby\nchange(next)",
},
["team:394"] = {
["name"] = "Training with the Nightwatchers (Aquatic)",
["code"] = "use(564)\nuse(779)\nuse(908)\nuse(509)\nstandby\nchange(next)",
},
["team:356"] = {
["name"] = "Snail Fight! (Critter)",
["code"] = "use(Headbutt:376)\nuse(Shell Shield:310) [!self.aura(Shell Shield:309).exists]\nuse(Ooze Touch:445)\n\nuse(Burrow:159) [enemy.hp > 264]\nuse(Dodge:312)\nuse(Scratch:119)\n\nchange(next)",
},
["team:61"] = {
["name"] = "Taran Zhu",
["code"] = "change(#2) [self(#1).dead]\nif [self(#1).active]\nuse(998) [round=2]\nuse(654) [round=3]\nuse(654) [enemy.hp<840]\nuse(499)\nendif\nif [self(#2).active]\nuse(165) [self.round=1]\nuse(362) [enemy.round=2 & enemy(#2).active]\nuse(499)\nendif\nstandby",
},
["team:360"] = {
["name"] = "Snail Fight! (Humanoid)",
["code"] = "standby [round~2,3]\nability(Deflection:490) [enemy.aura(Underwater:830).exists]\nstandby [enemy.aura(Underwater:830).exists & self(#1).active]\nability(Mangle:314) [round=4]\nability(Mangle:314) [enemy.round=1 & enemy(#2).active]\nability(Rampage:124) [round>3]\nability(#1)\nstandby\nchange(next)",
},
["team:361"] = {
["name"] = "Snail Fight! (Magic)",
["code"] = "use(Void Nova:2356)\nuse(Poison Protocol:1954)\nuse(#1)\nchange(next)",
},
["team:363"] = {
["name"] = "Snail Fight! (Undead)",
["code"] = "ability(Acid Rain:1051)\nability(Dreadful Breath:668)\nability(Prowl:536) [enemy(Rocklick:1842).active]\nability(Pounce:535)\nstandby\nchange(next)",
},
["team:148"] = {
["name"] = "Deviate Smallclaw",
["code"] = "ability(Supercharge:208) [enemy.hpp>50]\nability(Laser:482) [enemy(Deviate Flapper:1987).active]\nability(Haywire:916)\nability(#1)\nchange(next)",
},
["team:44"] = {
["name"] = "Chen Stormstout",
["code"] = "change(next) [ enemy(#2).active & !self(#3).played ]\nability(Decoy:334)\nability(Haywire:916)\nability(Dodge:312) [ enemy(#2).active ]\nability(Dodge:312) [ enemy.aura(Barrel Ready:353).exists ]\nability(Ravage:802) [ enemy(#2).active & enemy.hp<927 ]\nability(Ravage:802) [ enemy(#3).hp<619 ]\nability(#1)\nchange(#1)",
},
["team:350"] = {
["name"] = "Tiny Poacher, Tiny Animals (Humanoid)",
["code"] = "ability(Deflection:490) [enemy.ability(Mudslide:572).usable]\nability(Deflection:490) [enemy.ability(Flame Jet:1041).usable]\nability(Sandstorm:453) [round=2]\nability(Sandstorm:453) [enemy.round=1 & enemy(#2).active]\nability(Frost Shock:416) [self.round~1,3]\nability(Frost Shock:416) [enemy.round=1 & enemy(#3).active]\nability(Deep Freeze:481)\nability(#1)\nstandby\nchange(next)",
},
["team:351"] = {
["name"] = "Tiny Poacher, Tiny Animals (Magic)",
["code"] = "use(Batter:455) [enemy(Gulp:1798).active & enemy.round>3]\nuse(Batter:455) [enemy(Egcellent:1793).active & enemy.round>2]\nuse(Sandstorm:453) [round=2]\nuse(Wind-Up:459)\nuse(Poison Protocol:1954)\nuse(Toxic Fumes:2349) [enemy(Red Wire:1794).active & !weather(Toxic Gas:2350)]\nuse(Corrosion:447)\nuse(Meteor Strike:407) [enemy.aura(Flamethrower:502).exists]\nuse(Flamethrower:503)\nchange(next)",
},
["team:81"] = {
["name"] = "Do You Even Train?",
["code"] = "use(Moonfire:595) [!weather(Moonlight:596)]\nuse(Prowl:536) [enemy(Lifft:3572).active]\nuse(Spirit Claws:974)\n\nuse(Decoy:334) [enemy(Swole:3573).active]\nuse(Breath:115)\n\nuse(Deflection:490) [enemy(Swole:3573).aura(Underwater:830).exists]\nuse(Rampage:124) [!enemy(Swole:3573).ability(Dive:564).usable]\nuse(Triple Snap:355)\n\nstandby\nchange(next)",
},
["team:349"] = {
["name"] = "Tiny Poacher, Tiny Animals (Flyer)",
["code"] = "change(#2) [enemy(#2).active]\nchange(#1) [self(#2).dead]\nability(Dodge:312)\nability(Black Claw:919) [!enemy.aura(Black Claw:918).exists]\nability(Flock:581)\nability(#1)",
},
["team:139"] = {
["name"] = "Goz Banefury",
["code"] = "if [!self(#3).active]\nuse(Explode:282) [enemy(#2).active]\nuse(Supercharge:208) [enemy(#1).hp<1035]\nuse(Water Jet:118)\nuse(Armageddon:1025) [enemy.aura(Stunned:927).exists]\nuse(Time Bomb:602) [enemy(#2).active & enemy(#2).hp<1110]\nuse(Flame Breath:501)\nendif\nchange(next)",
},
},
},
},
["profiles"] = {
["Default"] = {
["settings"] = {
["autoButtonHotKey"] = "NUMPADDIVIDE",
},
["position"] = {
["y"] = 115.0004425048828,
["x"] = -263.999755859375,
["point"] = "RIGHT",
["height"] = 369.9999694824219,
["scale"] = 1,
["width"] = 627.9999389648438,
},
["pluginOrders"] = {
"Rematch",
"Base",
"FirstEnemy",
"AllInOne",
},
},
},
}
