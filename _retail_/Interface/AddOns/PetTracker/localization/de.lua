--[[
	German Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'deDE')
if not L then return end

-- main
L.AddWaypoint = 'Wegpunkt hinzuf\195\188gen'
L.AskForfeit = 'Keine Upgrades verf\195\188gbar. Kampf beenden?'
L.AvailableBreeds = 'Verf\195\188gbare Z\195\188chtungen'
L.Breed = 'Z\195\188chtung'
L.BreedExplanation = 'Legt fest, wie die pro Stufenaufstieg gewonnenen Werte verteilt werden.'
L.CapturedPets = 'Zeige gefangene Haustiere'
L.CommonSearches = 'H\195\164ufige Suchbegriffe'
L.FilterSpecies = 'Haustiere filtern'
L.LoadTeam = 'Team laden'
L.Ninja = 'Ninja'
L.NoHistory = 'PetTracker hat dich noch nie gegen diesen Rivalen k\195\164mpfen sehen'
L.NoneCollected = 'Nicht gesammelt'
L.Rivals = 'Rivalen'
L.ShowJournal = 'Im Wildtierf\195\188hrer anzeigen'
L.ShowPets = 'Kampfhaustiere anzeigen'
L.ShowStables = 'Stallmeister anzeigen'
L.Species = 'Art'
L.StableTip = '|cffffd200Hier k\195\182nnen Haustiere gegen eine|nkleine Geb\195\188hr geheilt werden.|r'
L.TellMore = 'Erz\195\164hle mir mehr über unsere Vergangenheit.'
L.UpgradeAlert = 'Besseres Kampfhaustier entdeckt!'
L.TotalRivals = 'Alle Rivalen'

-- options
L.AlertUpgrades = 'Hinweis bei Upgrades'
L.AlertUpgradesTip = 'Wenn deaktiviert, wird die Upgrade-Hinweismeldung nicht im Kampf gezeigt, aber Upgrades werden immer noch mit einem Symbol gekennzeichnet (|TInterface\\GossipFrame\\AvailableQuestIcon:0:0:-1:-2|t).'
L.FAQDescription = 'Dies sind die am h\195\164ufigsten gestellten Fragen. Um das Tutorial erneut zu betrachten, setze die Einstellungen zur\195\188ck, indem du den "Standard"-Knopf in der unteren linken Ecke benutzt.'
L.Forfeit = 'Aufforderung zum Aufgeben'
L.ForfeitTip = 'Wenn aktiviert, wirst Du aufgefordert, einen Kampf aufzugeben, wenn keine Upgrades verf\195\188gbar sind.'
L.OptionsDescription = 'Diese Optionen erlauben dir PetTracker Funktionen an- und auszuschalten. Schnapp sie dir alle!'
L.RivalPortraits = 'Rivalen-Portraits'
L.RivalPortraitsTip = 'Wenn aktiviert werden Rivalen auf der Welt- und Kampfkarte mit einem Portrait markiert.'
L.SpecieIcons = 'Spezies-Icons'
L.SpecieIconsTip = 'Wenn deaktiviert werden Haustiere auf der Welt- und Kampfkarte nur mit der Familie, nicht dem Icon der Spezies markiert.'
L.Switcher = 'Wechsler'
L.SwitcherTip = 'Wenn aktiviert wird die Standardoberfläche um Haustiere im Kampf zu wechseln mit einer besseren ersetzt.'
L.TrackPetsTip = 'Wenn aktiviert wird eine Liste mit dem Fang-Fortschritt in der aktuellen Zone neben den Questzielen angezeigt.'

L.FAQ = {
	'Wie kann ich alle Haustiere auf der Karte ein- und ausblenden?',
	'Klicke auf die Lupe in der oberen rechten Ecke der Karte. Klicke auf "Kampfhaustiere anzeigen".',

	'Wie zeige ich nur bestimmte Haustiere auf der Karte?',
	'In der rechten oberen Ecke der Karte befindet sich eine Filterbox. Im Tutorial finden sich Suchbeispiele.',

	'Wie kann ich den Zonen-Tracker wieder anzeigen?',
	'Öffne den Wildtierführer und klicke in der rechten unteren Ecke auf "Zonen-Tracker".',

	'Wie kann ich die Haustiere, die ich im Zonen-Tracker erfasst habe, anzeigen lassen?',
	'Klicke auf "Haustiere" im Tracker und aktiviere "Zeige gefangene Haustiere".',
}

L.Tutorial = {
[[Herzlich willkommen! Du benutzt jetzt |cffffd200PetTracker|r, von |cffffd200Jaliborc|r.

Dieses optionale Tutorial hilft dir loszulegen, damit du dich schnell wieder dem wirklich Wichtigen widmen kannst: Sie dir alle zu schnappen... ähm... alle Haustiere einzufangen!]],

[[Der |cffffd200Zonen-Tracker|r zeigt dir noch fehlende Haustiere in deiner aktuellen Zone, ihren Ursprung und die Seltenheit derjenigen, die du gefangen hast.

|A:NPE_LeftClick:14:14|a Klicke auf den Header |cffffd200"Begleiter"|r für zusätzliche Optionen.]],

[[Öffne die |cffffd200Weltkarte|r, um zu sehen, wie dir PetTracker bei deiner Erkundung helfen kann.]],

[[PetTracker zeigt die möglichen Quellen von Haustieren auf der Weltkarte an. Es zeigt auch Stallmeister und zusätzliche Informationen über Zähmer an.

Um diese Orte auszublenden oder zu filtern, |A:NPE_LeftClick:14:14|a öffne das |cffffd200"Filter"-Menü|r.]],

[[Du kannst filtern, welche Haustiere angezeigt werden, indem du im |cffffd200"Filterarten"|r-Feld eingibst. Hier sind einige Beispiele:

• |cffffd200Katze|r für Katzen.
• |cffffd200Fehlt|r für nicht gesammelte Arten.
• |cffffd200Aquatisch|r für aquatische Arten.
• |cffffd200Quest|r für Arten, die als Questbelohnung erhalten werden.
• |cffffd200Wald|r für Arten, die Wälder bewohnen.

Mathematische Operatoren funktionieren auch:
• |cffffd200< Selten|r für Arten, bei denen dir ein Haustier von seltener Qualität fehlt.
• |cffffd200< 15|r für Arten mit Haustieren unter Level 15.]],

[[Öffne den |cffffd200Wildtierführer|r, um zu sehen, wie PetTracker dir beim Durchsuchen hilft.]],

[[Dieses Kästchen ermöglicht es, den |cffffd200Zonen-Tracker|r zu aktivieren. Besonders nützlich, wenn er zuvor versteckt wurde.]],

[[Öffne den |cffffd200Rivalen|r-Reiter, um mehr darüber zu erfahren.]],

[[Der |cffffd200Rivalen|r-Reiter liefert Informationen über vorhandene Haustierkampfbegegnungen, wie z.B.:

• Gegnerische Haustiere und ihre Fähigkeiten.
• Tägliche Quests und ihre Belohnungen.
• Den jeweiligen Ort.]],

[[Du kannst filtern, welche Haustiere angezeigt werden, indem du im Suchfeld eingibst. Hier sind einige Beispiele:

• |cffffd200Aki|r für Aki die Auserwählte.
• |cffffd200Valor|r für Rivalen, die Tapferkeit gewähren.
• |cffffd200Draenor|r für Rivalen in Draenor.
• |cffffd200Episch|r für Rivalen mit Teams von epischer Qualität.
• |cffffd200> 20|r für Rivalen über Level 20.]],

[[PetTracker zeichnet die Kämpfe auf, die du mit jedem Rivalen hattest. Wähle einen Kampf und klicke auf |cffffd200Team laden|r, um schnell die Haustiere zu laden, die du damals benutzt hast.]]
}	