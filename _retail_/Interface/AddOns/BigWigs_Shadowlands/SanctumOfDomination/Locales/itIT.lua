local L = BigWigs:NewBossLocale("The Tarragrue", "itIT")
if not L then return end
if L then
	L.chains = "Catene" -- Chains of Eternity (Chains)
	L.remnants = "Residui" -- Remnant of Forgotten Torments (Remnants)

	L.physical_remnant = "Residuo Fisico"
	L.magic_remnant = "Residuo Magico"
	L.fire_remnant = "Residuo del Fuoco"
	L.fire = "Fuoco"
	L.magic = "Magico"
	L.physical = "Fisico"
end

L = BigWigs:NewBossLocale("The Eye of the Jailer", "itIT")
if L then
	L.chains = "Catene" -- Short for Dragging Chains
	L.death_gaze = "Sguardo della Morte" -- Corto per Sguardo della Morte Titanico
end

L = BigWigs:NewBossLocale("The Nine", "itIT")
if L then
	L.fragments = "Frammenti" -- Short for Fragments of Destiny
	L.fragment = "Frammento" -- Singular Fragment of Destiny
	L.run_away = "Scappa" -- Wings of Rage
	L.song = "Canto" -- Short for Song of Dissolution
	L.go_in = "Entra dentro" -- Reverberating Refrain
	L.valkyr = "Val'kyr" -- Short for Call of the Val'kyr
	L.blades = "Spade" -- Agatha's Eternal Blade
	L.big_bombs = "Bombe Grandi" -- Corto per Impatto Vigoroso di Daschla
	L.big_bomb = "Bomba Grande" -- Attached to the countdown
	L.shield = "Scudo" -- Annhylde's Bright Aegis
	L.soaks = "Assorbire" -- Aradne's Falling Strike
	L.small_bombs = "Bombe Piccole" -- Brynja's Mournful Dirge
	L.recall = "Richiamo" -- Short for Word of Recall

	L.blades_yell = "Cadete sotto i colpi della mia spada!!"
	L.soaks_yell = "Siete tutti inferiori!"
	L.shield_yell = "Il mio scudo non vacilla mai!"

	L.berserk_stage1 = "Berserk Fase 1"
	L.berserk_stage2 = "Berserk Fase 2"

	L.image_special = "%s [Skyja]" -- Stage 2 boss name
end

L = BigWigs:NewBossLocale("Remnant of Ner'zhul", "itIT")
if L then
	L.cones = "Coni" -- Grasp of Malice
end

L = BigWigs:NewBossLocale("Soulrender Dormazain", "itIT")
if L then
	L.custom_off_nameplate_defiance = "Icona Nameplate Ribellione"
	L.custom_off_nameplate_defiance_desc = "Mostra un'icona sul namepalte del Giurafauce che ha Ribellione.\n\nRichiede l'uso dei Nameplates del nemico e un'appon per nameplates supportato (KuiNameplates, Plater)."

	L.custom_off_nameplate_tormented = "Icona nameplate Tormento"
	L.custom_off_nameplate_tormented_desc = "Mostra un'icona sul namepalte del Giurafauce che ha Tormento.\n\nRichiede l'uso dei Nameplates del nemico e un'appon per nameplates supportato (KuiNameplates, Plater)."

	L.cones = "Coni" -- Torment
	L.dance = "Danza" -- Encore of Torment
	L.brands = "Marchiature" -- Brand of Torment
	L.brand = "Marchiatura" -- Single Brand of Torment
	L.spike = "Scheggia" -- Short for Agonizing Spike
	L.chains = "Catene" -- Hellscream
	L.chain = "Catena" -- Soul Manacles
	L.souls = "Anime" -- Rendered Soul

	L.chains_remaining = "%d Catene rimaste"
	L.all_broken = "TUTTE le catene spezzate"
end

L = BigWigs:NewBossLocale("Painsmith Raznal", "itIT")
if L then
	L.hammer = "Martello" -- Short for Rippling Hammer
	L.axe = "Ascia" -- Short for Cruciform Axe
	L.scythe = "Falce" -- Short for Dualblade Scythe
	L.trap = "Trappola" -- Short for Flameclasp Trap
	L.chains = "Catene" -- Short for Shadowsteel Chains
	L.embers = "Braci" -- Short for Shadowsteel Embers
	L.adds_embers = "Braci (%d) - Adds Tra Poco!"
	L.adds_killed = "Adds uccisi in %.2fs"
	L.spikes = "Palle Chiodate" -- Soft enrage spikes
end

L = BigWigs:NewBossLocale("Guardian of the First Ones", "itIT")
if L then
	L.bomb_missed = "%dx Bombe Mancate"
end

L = BigWigs:NewBossLocale("Fatescribe Roh-Kalo", "itIT")
if L then
	L.rings = "Anelli"
	L.rings_active = "Anelli Attivi" -- for when they activate/are movable
	L.runes = "Rune"

	L.grimportent_countdown = "Conto alla Rovescia"
	L.grimportent_countdown_desc = "Conto alla Rovescia per i giocatori affetti da Portento Tetro"
	L.grimportent_countdown_bartext = "Vai sulla runa!"
end

L = BigWigs:NewBossLocale("Kel'Thuzad", "itIT")
if L then
	L.spikes = "Scheggie" -- Short for Glacial Spikes
	L.spike = "Scheggia"
	L.miasma = "Miasma" -- Short for Sinister Miasma

	L.custom_on_nameplate_fixate = "Fixate Nameplate Icon"
	L.custom_on_nameplate_fixate_desc = "Mostra un'icona sul Devota Vincolagelo che ti sta braccando.\n\nRichiede l'uso dei Nameplates del nemico e un'appon per nameplates supportato (KuiNameplates, Plater)."
end

L = BigWigs:NewBossLocale("Sylvanas Windrunner", "itIT")
if L then
	L.chains_active = "Catene Attive"
	L.chains_active_desc = "Mostra una barra quando Catene del Dominio è attivo"

	L.custom_on_nameplate_fixate = "Icona Nameplate Rabbia"
	L.custom_on_nameplate_fixate_desc = "Mostra un'icona sul nameplate della Sentinella Oscura che ha preso di mira te.\n\nRichiede l'uso dei Nameplates del nemico e un'appon per nameplates supportato (KuiNameplates, Plater)."

	--L.intermission_chains = "Intermission Chains"
	L.chains = "Catene" -- Short for Domination Chains
	L.chain = "Catena" -- Single Domination Chain
	L.darkness = "Oscurità" -- Short for Veil of Darkness
	L.arrow = "Freccia" -- Short for Wailing Arrow
	--L.arrow_done = "DONE" -- Message when the arrow has hit
	L.wave = "Ondata" -- Short for Haunting Wave
	L.dread = "Terrore" -- Short for Crushing Dread
	L.scream = "Urlo" -- Banshee Scream

	L.knife_fling = "Coltelli!" -- "Death-touched blades fling out"
	--L.bridges = "Bridges"
	--L.rive_counter = "%s (%d/%d)"
	--L.soaks = "Soaks" -- Merciless
	--L.count_x = "%s (x%d)(%d)"
	--L.shroud_active = "Shroud (%d) - %.1f%%!"
end

L = BigWigs:NewBossLocale("Sanctum of Domination Affixes", "itIT")
if L then
	L.custom_on_bar_icon = "Icona Barra"
	L.custom_on_bar_icon_desc = "Mostra l'icona dell'Incursione Predestinata sulle barre."

	L.chaotic_essence = "Essenza"
	L.creation_spark = "Scintille"
	L.protoform_barrier = "Barriera"
	L.reconfiguration_emitter = "Interrompi Add"
end
