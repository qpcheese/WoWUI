-- German localization file for deDE by Ragnar_F and Google translator, announce corrections by Salty
local _
-- global functions and variebles to locals to keep LINT happy
local assert = _G.assert
local LibStub = _G.LibStub; assert(LibStub ~= nil,'LibStub')
-- local AddOn
local ADDON = ...
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale(ADDON, "deDE");
if not L then return; end
--
L["NOP_TITLE"] = "New Openables"
L["NOP_VERSION"] = "|cFFFFFFFF%s - benutze |cFFFF00FF/nop|cFFFFFFFF"
L["CLICK_DRAG_MSG"] = "ALT-Linksklick und ziehen, um zu verschieben."
L["CLICK_OPEN_MSG"] = "Linksklick, um Gegenstand zu öffnen oder zu benutzen."
L["CLICK_SKIP_MSG"] = "Rechtsklick, um Gegenstand zu überspringen."
L["CLICK_BLACKLIST_MSG"] = "STRG-Rechtsklick, um Gegenstand dauerhaft zu ignorieren."
L["No openable items!"] = "Keine Gegenstände, die geöffnet werden können!"
L["BUTTON_RESET"] = "Schaltfläche auf die Mitte des Bildschirms zurückgesetzt!"
L["NOP_USE"] = "Benutze: "
L["Spell:"] = "Zauber:"
L["BLACKLISTED_ITEMS"] = "|cFFFF00FFDauerhaft ignorierte Gegenstände:"
L["BLACKLIST_EMPTY"] = "|cFFFF00FFKeine ignorierten Gegenstände"
L["PERMA_BLACKLIST"] = "Dauerhaft ignoriert:|cFF00FF00"
L["SESSION_BLACKLIST"] = "Für diese Session ignoriert:|cFF00FF00"
L["TEMP_BLACKLIST"] = "Temporär ignoriert:|cFF00FF00"
L["|cFFFF0000Error loading tooltip for|r "] = "|cFFFF0000Fehler beim Laden des Tooltips für|r "
L["Plans, patterns and recipes cache update."] = "Cache-Aktualisierung von Plänen, Mustern und Rezepten."
L["Spell patterns cache update."] = "Cache-Aktualisierung von Zaubern."
L["|cFFFF0000Error loading tooltip for spell |r "] = "|cFFFF0000Fehler beim Laden des Tooltips für Zauber |r "
L["|cFFFF0000Error loading tooltip for spellID %d"] = "|cFFFF0000Fehler beim Laden des Tooltips für Zauber-ID %d"
L["TOGGLE"] = "Optionen"
L["Skin Button"] = "Schaltfläche mit Skin versehen"
L["Masque Enable"] = "Masque aktivieren"
L["Need UI reload or relogin to activate."] = "Sie müssen das Nutzerinterface neu laden oder sich neu einloggen, um es zu aktivieren."
L["Lock Button"] = "Schaltfläche sperren"
L["Lock button in place to disbale drag."] = "Schaltfläche auf aktueller Position sperren, um ein Verschieben zu verhindern."
L["Glow Button"] = "Schaltfläche aufleuchten lassen"
L["When item is placed by zone change, button will have glow effect."] = "Gegenstand leuchtet beim Zonenwechsel auf."
L["Backdrop Button"] = "Schaltfläche einrahmen"
L["Create or remove backdrop around button, need reload UI."] = "Erstellt oder entfernt den Rahmen um die Schaltfläche; benötigt /reload."
L["Session skip"] = "Die ganze Session lang überspringen"
L["Skipping item last until relog."] = "Gegenstände werden bis zum nächsten Einloggen übersprungen."
L["Clear Blacklist"] = "Ignorierliste leeren"
L["Reset Permanent blacklist."] = "Alle Gegenstände auf der Ignorierliste werden von dieser dauerhaft entfernt."
L["Zone unlock"] = "Zonenabhängigkeit entsperren"
L["Don't zone restrict openable items"] = "Gegenstände können überall geöffnet werden."
L["Profession"] = "Beruf"
L["Place items usable by lockpicking"] = "Gegenstände anzeigen, die durch 'Schloss knacken' geöffnet werden können"
L["Button"] = "Schaltfläche"
L["Button location"] = "Position der Schaltfläche"
L["Button size"] = "Größe der Schaltfläche"
L["Width and Height"] = "Breite und Höhe"
L["Button size in pixels"] = "Größe der Schaltfläche in Pixel"
L["Miner's Coffee stacks"] = "Stapelmenge von Minenarbeiterkaffee"
L["Allow buff up to this number of stacks"] = "Die maximal erlaubte Stapelmenge des Minenarbeiterkaffee-Buffs."
L["Quest bar"] = "Quest-Leiste"
L["Quest items placed on bar"] = "In einer Reihe angezeigte Quest-Gegenstände"
L["Visible"] = "Sichtbar machen"
L["Make button visible by placing fake item on it"] = "Macht die Schaltfläche mithilfe eines Platzhalters sichtbar."
L["Swap"] = "Tauschen"
L["Swap location of numbers for count and cooldown timer"] = "Tauscht die Position von Anzahl und Abklingzeit."
L["AutoQuest"]  = "Automatische Suche"
L["Auto accept or hand out quests from AutoQuestPopupTracker!"] = "Automatische Annahme oder Abgabe von Quests aus AutoQuestPopupTracker."
L["Strata"] = "Strata"
L["Set strata for items button to HIGH, place it over normal windows."] = "Setzt die Ebene für die Schaltfläche auf HIGH und legt ihn damit über normale Fenster."
L["Herald"] = "Herold"
L["Announce completed work orders, artifact points etc.."] = "Meldet abgeschlossene Arbeitsaufträge, Artefaktpunkte usw."
L["Skip on Error"] = "Überspringen bei Fehler"
L["Temporary blacklist item when click produce error message"] = "Setzt den Gegenstand temporär auf die Ignorierliste, wenn das Anklicken der Schaltfläche eine Fehlermeldung erzeugt hat."
L["HIDE_IN_COMBAT"] = "Im Kampf verstecken"
L["HIDE_IN_COMBAT_HELP"] = "Versteckt die Schaltfläche im Kampf."
L["SHOW_REPUTATION"] = "Zeige Ruf"
L["SHOW_REPUTATION_HELP"] = "Zeigt den aktuellen Ruf im Tooltip von Legion Ruf-Gegenständen; benötigt /reload."
L["SKIP_EXALTED"] = "Verstecke Ehrfürchtig"
L["SKIP_EXALTED_HELP"] = "Ignoriert Legion Ruf-Gegenstände, wenn bereits ehrfürchtig."
L["SKIP_MAXPOWER"] = "Verstecke Artefakt"
L["SKIP_MAXPOWER_HELP"] = "Ignoriert Artefaktpunkt-Gegenstände, wenn dein Artefakt das Maximum erreicht hat."
L["Buttons per row"] = "Schaltflächen pro Reihe"
L["Number of buttons placed in one row"] = "Anzahl von in einer Reihe angezeigter Schaltflächen."
L["Spacing"] = "Abstand"
L["Space between buttons"] = "Abstand zwischen den einzelnen Schaltflächen."
L["Sticky"] = "Anheften"
L["Anchor to Item button"] = "Verankert die Quest-Leiste mit der Gegenstand-Schaltfläche."
L["Direction"] = "Richtung"
L["Expand bar to"] = "Richtung in welche die Leiste erweitert werden soll."
L["Up"] = "Nach oben"
L["Down"] = "Nach unten"
L["Left"] = "Nach links"
L["Right"] = "Nach rechts"
L["Add new row"] = "Neue Reihe hinzufügen"
L["Above or below last one"] = "Ober- oder unterhalb der letzten Reihe"
L["Hot-Key"] = "Tastenbelegung"
L["Key to use for automatic key binding."] = "Taste zum automatischen Aktivieren des Gegenstandes."
L["Quest"] = "Quest"
L["Quest not found for this item."] = "Quest für diesen Gegenstand nicht gefunden."
L["Items cache update run |cFF00FF00%d."] = "Cache-Aktualisierung von Gegenständen |cFF00FF00%d."
L["Spells cache update run |cFF00FF00%d."] = "Cache-Aktualisierung von Zaubern |cFF00FF00%d."
L["TOGO_ANNOUNCE"] = "%s: %d fertig, %d startbereit!"
L["REWARD_ANNOUNCE"] = "Paragon-Belohnung für %s ist bereit!"
L["SHIPYARD_ANNOUNCE"] = "Werft hat %d/%d Schiffe!"
L["ARTIFACT_ANNOUNCE"] = "%s hat %d unverteilte(n) Talentpunkt(e)!"
L["ARCHAELOGY_ANNOUNCE"] = "Archäologie %s ist fertig!"
L["TALENT_ANNOUNCE"] = "%s ist fertig!"
L["RESTARTED_LOOKUP"] = "Temporäre Ignorierliste gelöscht, Neustart der Suche!"
L["CONSOLE_USAGE"] = [=[ [reset|skin|lock|clear|list|unlist|skip|glow|zone|quest|show]
reset  - setzt die Schaltfläche auf die Mitte des Bildschirms zurück
skin   - versieht die Schaltfläche mit einem Skin
lock   - sperrt/entsperrt die Position der Schaltfläche
clear  - leert die Liste von dauerhaft ignorierten Gegenständen
list   - listet dauerhaft ignorierte Gegenstände auf
unlist - entfernt einzelnen Gegenständ von der Ignorierliste per item ID
skip   - schaltet das Rechtsklick-Überspringen zwischen 'temporär' und 'bis zum Neu-Einloggen' um
glow   - aktiviert/deaktiviert Aufleuchten der Schaltfläche bei Zonenwechsel
zone   - aktiviert/deaktiviert Zonenabhängigkeit bei Gegenständen
quest  - aktiviert/deaktiviert Quest-Leiste
show   - macht die Schaltfläche sichtbar]=];
