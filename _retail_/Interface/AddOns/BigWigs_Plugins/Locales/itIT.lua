local L = BigWigsAPI:NewLocale("BigWigs: Plugins", "itIT")
if not L then return end

L.general = "Generale"
--L.advanced = "Advanced"
L.comma = ", "

L.positionX = "Posizione X"
L.positionY = "Posizione Y"
L.positionExact = "Posizionamento Esatto"
L.positionDesc = "Scrivi nel riquadro o sposta l'indicatore se devi posizionare esattamente la barra dell'ancoraggio."
L.width = "Larghezza"
L.height = "Altezza"
L.sizeDesc = "In genere regoli la dimesione trascinando l'ancora. Se hai necessità di una dimensione specifica puoi usare la barra slide o digitare i valori nella casella."
L.fontSizeDesc = "Regola la dimensione del carattere usando la barra slide o digitando i valori nella casella che ha un valore molto maggiore di 200."
L.disabled = "Disabilitato"
L.disableDesc = "Stai per disabilitare la funzionalità '%s' che |cffff4411non è consigliata|r.\n\nSei sicuro di questo?"

-- Anchor Points
--L.UP = "Up"
--L.DOWN = "Down"
--L.TOP = "Top"
--L.RIGHT = "Right"
--L.BOTTOM = "Bottom"
--L.LEFT = "Left"
--L.TOPRIGHT = "Top Right"
--L.TOPLEFT = "Top Left"
--L.BOTTOMRIGHT = "Bottom Right"
--L.BOTTOMLEFT = "Bottom Left"
--L.CENTER = "Center"
--L.customAnchorPoint = "Advanced: Custom anchor point"
--L.sourcePoint = "Source Point"
--L.destinationPoint = "Destination Point"

-----------------------------------------------------------------------
-- AltPower.lua
--

L.altPowerTitle = "Potere Alternativo"
L.altPowerDesc = "Il Potere Alternativo verrà mostrato solo per quei boss che applicano Potere Alternativo ai giocatori, cosa estremamente rara. Il display misura l'ammontare di 'Potere Alternativo' tuo e del tuo gruppo, mostrandolo in una lista. Per muovere il riquadro, usa il pulsante di test qui sotto."
L.toggleDisplayPrint = "Mostra il monitor per la prossima volta. Per disabilitarlo completamente in questo scontro, devi deselezionarlo dalle opzioni dello scontro specifico."
L.disabledDisplayDesc = "Disattiva il monitor per tutti gli scontri che lo usano."
L.resetAltPowerDesc = "Reimposta tutte le opzioni relative al Potere Alternativo, compreso il posizionamento dell'ancora di Potere Alternativo."
L.test = "Test"
L.altPowerTestDesc = "Mostra il display 'Potere Alternativo', permettendoti di muoverlo, e simulando i cambiamenti di potere che potresti vedere durante lo scontro con il boss."
L.yourPowerBar = "La tua Barra Potere"
L.barColor = "Colore Barra"
L.barTextColor = "Colore Testo Barra"
L.additionalWidth = "Profondità Addizionale"
L.additionalHeight = "Altezza Addizionale"
L.additionalSizeDesc = "Regola la dimensione del display predefinito usando la barra slide o digitando i valori nella casella che ha un valore molto maggiore di 100."
L.yourPowerTest = "Tuo Potere: %d" -- Tuo Potere: 42
L.yourAltPower = "Tuo %s: %d" -- esempio: Tua Corruzione: 42
L.player = "Giocatore %d" -- Giocatore 7
L.disableAltPowerDesc = "Disabilita totalmente il display del Potere Alternativo, non verrà mai mostrato in nessuno scontro contro i boss."

-----------------------------------------------------------------------
-- AutoReply.lua
--

L.autoReply = "Risposta automatica"
L.autoReplyDesc = "Risponde automaticamente ai sussuri durante il combattimento con un boss."
L.responseType = "Tipo di risposta"
L.autoReplyFinalReply = "Sussurra anche quando esci dal combattimento"
L.guildAndFriends = "Gilda e Amici"
L.everyoneElse = "Tutti gli altri"

L.autoReplyBasic = "Sono occupato in un combattimento con un boss."
L.autoReplyNormal = "Sono occupato in un combattimento con '%s'."
L.autoReplyAdvanced = "Sono occupato in un combattimento con '%s' (%s) e %d/%d persone sono vive."
L.autoReplyExtreme = "Sono occupato in un combattimento con '%s' (%s) e %d/%d persone sono vive: %s"

L.autoReplyLeftCombatBasic = "Non sono più in combattimento con un boss."
L.autoReplyLeftCombatNormalWin = "Ho sconfitto '%s'."
L.autoReplyLeftCombatNormalWipe = "Sono stato sconfitto da '%s'."
L.autoReplyLeftCombatAdvancedWin = "Ho sconfitto '%s' con %d/%d persone vive."
L.autoReplyLeftCombatAdvancedWipe = "Sono stato sconfitto da '%s' al: %s"

-----------------------------------------------------------------------
-- Bars.lua
--

L.bars = "Barre"
L.style = "Stile"
L.bigWigsBarStyleName_Default = "Predefinito"
L.resetBarsDesc = "Azzera tutte le opzioni delle barre, compresi gli ancoraggi delle barre."
L.testBarsBtn = "Crea Barra Test"
L.testBarsBtn_desc = "Crea una barra test per provare le tue impostazioni attuali."

L.toggleAnchorsBtnShow = "Mostra Ancoraggi"
L.toggleAnchorsBtnHide = "Nascondi Ancoraggi"
L.toggleAnchorsBtnHide_desc = "Nasconde tutti i punti di ancoraggio. bloccando tutto sul posto."
L.toggleBarsAnchorsBtnShow_desc = "Mostra tutti i punti di ancoraggio, permettendoti di muovere le barre."

L.emphasizeAt = "Enfatizza a... (secondi)"
L.growingUpwards = "Cresci verso l'altro"
L.growingUpwardsDesc = "Attiva o disattiva il riempimento crescente o decrescente rispetto al punto di ancoraggio."
L.texture = "Texture"
L.emphasize = "Enfatizza"
L.emphasizeMultiplier = "Moltiplicatore di dimensioni"
L.emphasizeMultiplierDesc = "Se disabiliti le barre muovendole dall'ancora di enfatizzazione, questa opzione deciderà la dimensione delle barre enfatizzate moltiplicando la dimensione delle barre normali."

L.enable = "Attiva"
L.move = "Muovi"
L.moveDesc = "Muovi le Barre Enfatizzate all'Ancoraggio di Enfatizzazione. Se questa opzione non è abilitata, le barre enfatizzate cambieranno semplicemente scalatura e colore."
L.emphasizedBars = "Barre Enfatizzate"
L.align = "Allineamento"
L.alignText = "Allinea il Testo"
L.alignTime = "Allinea il Tempo"
L.left = "Sinistra"
L.center = "Centro"
L.right = "Destra"
L.time = "Tempo Rimasto"
L.timeDesc = "Visualizza o nasconde il tempo rimasto sulle barre."
L.textDesc = "Mostra o nascondi il testo delle barre."
L.icon = "Icona"
L.iconDesc = "Visualizza o nasconde le icone delle Barre."
L.iconPosition = "Posizione Icona"
L.iconPositionDesc = "Scegli dove l'icona deve essere posizionata sulla barra."
L.font = "Carattere"
L.restart = "Riavvia"
L.restartDesc = "Riavvia le barre Enfatizzate in modo che partano dall'inizio e contino fino a 10."
L.fill = "Riempi"
L.fillDesc = "Riempi le barre invece di svuotarle man mano che passano i secondi."
L.spacing = "Spaziatura"
L.spacingDesc = "Cambia la distanza tra le barre."
L.visibleBarLimit = "Limite barre visibili"
L.visibleBarLimitDesc = "Scegli il numero massimo di barre che devono essere visibili contemporaneamente."

L.localTimer = "Locale"
L.timerFinished = "%s: Timer [%s] Terminato."
L.customBarStarted = "Barra personalizzata '%s' creata da utente %s - %s."
L.sendCustomBar = "Invio barra personalizzata '%s' agli utenti di BigWigs e DBM."

L.requiresLeadOrAssist = "Questa funzione richiede Capo Incursione o Assistente Incursione."
L.encounterRestricted = "Questa funzione non può essere usata durante uno scontro con un boss."
L.wrongCustomBarFormat = "Formato non corretto. Un'esempio corretto è: /raidbar 20 testo"
L.wrongTime = "Specificato tempo non valido. <time> può essere sia un numero in secondi, una coppia M:S , o Mm. Per esempio 5, 1:20 or 2m."

L.wrongBreakFormat = "Deve essere tra 1 e 60 minuti. Un'esempio corretto è /break 5"
L.sendBreak = "Invia un timer di pausa a tutti gli utenti BigWigs e DBM."
L.breakStarted = "Pausa annunciata da %s utente %s."
L.breakStopped = "Tempo di pausa cancellato da %s."
L.breakBar = "Tempo di pausa"
L.breakMinutes = "La Pausa finisce tra %d |4minuto:minuti!"
L.breakSeconds = "La Pausa finisce tra %d |4secondo:secondi!"
L.breakFinished = "Il tempo di pausa è finito"

-----------------------------------------------------------------------
-- BossBlock.lua
--

L.bossBlock = "Blocco Boss"
L.bossBlockDesc = "Configura le varie opzioni che puoi bloccare durante gli scontri con i boss.\n\n"
L.bossBlockAudioDesc = "Configura quali audio silenziare durante uno scontro.\n\nQualsiasi opzione che è |cff808080colorata in grigio|r è stata disabilitata nel pannello opzioni suono di WoW.\n\n"
L.movieBlocked = "Hai già visto questo video, lo salto."
L.blockEmotes = "Blocca gli emote a metà schermo"
L.blockEmotesDesc = "Alcuni boss mostrano delle emote per determinate abilità; questi messaggi sono sia troppo lunghi che troppo descrittivi. Cerchiamo di produrre messaggi più compatti e puliti che non interferiscono con lo svolgimento del gioco, e non dicono specificatamente cosa fare.\n\nNota bene: gli emote dei Boss sono sempre visibili nella chat se vuoi leggerli."
L.blockMovies = "Blocca filmati già visti"
L.blockMoviesDesc = "I filmati dei boss (ove presenti) verranno fatti vedere solo la prima volta che si attivano per visualizzarli; dalle volte successive questi video verranno cancellati automaticamente."
L.blockFollowerMission = "Blocca i popup della Guarnigione" -- Rename to follower mission
L.blockFollowerMissionDesc = "I popup della Guarnigione appaiono per certe attività, ma principalmente quando un seguace completa una missione.\n\nQuesti popup possono coprire parti critiche o importanti della tua UI durante il combattimento contro un boss, raccomandiamo quindi di bloccarli."
L.blockGuildChallenge = "Blocca i popup delle sfide di Gilda"
L.blockGuildChallengeDesc = "I popup delle Sfide di Gilda vengono mostrati per vari avvisi, principalmente quando la tua gilda completa una spedizione eroica o una spedizione in modalità sfida.\n\nQuesti popup possono coprire parti critiche o importanti della tua UI durante il combattimento contro un boss, raccomandiamo quindi di bloccarli."
L.blockSpellErrors = "Blocca i messaggi di errore degli incantesimi"
L.blockSpellErrorsDesc = "Messaggi tipo \"Questo incantesimo non è ancora pronto\" che in genere vengono mostrati in alto nello schermo verranno bloccati."
L.blockZoneChanges = "Messaggi di cambio blocco zona"
L.blockZoneChangesDesc = "I messaggi mostrati al centro in alto dello schermo quando ti muovi in una nuova zona come '|cFF33FF99Roccavento|r' o '|cFF33FF99Orgrimmar|r' saranno bloccati."
L.audio = "Audio"
L.music = "Musica"
L.ambience = "Audio ambientale"
L.sfx = "Effetti audio"
L.errorSpeech = "Messaggi d'errore"
L.disableMusic = "Togli la musica (raccomandato)"
L.disableAmbience = "Togli i suoni ambientali (raccomandato)"
L.disableSfx = "Togli gli effetti sonori (non raccomandato)"
L.disableErrorSpeech = "Togli Messaggi d'Errore (raccomandato)"
L.disableAudioDesc = "L'opzione '%s' nel pannello delle opzioni del suono di WoW's verrà disabilitata, per riabilitarla quando lo scontro con il boss si è concluso. Questo ti aiuta a focalizzarti sui suoni di avviso di BigWigs."
L.blockTooltipQuests = "Blocca tooltip obbiettivi missione"
L.blockTooltipQuestsDesc = "Quando devi uccidere un boss per una missione, vedrai qualcosa come '0/1 completato' nel tooltip quando porti il mouse sopra il boss. Questa opzione lo disabilita durante il combattimento, evitando che il tooltip diventi troppo grande."
L.blockObjectiveTracker = "Nascondi registro missioni"
L.blockObjectiveTrackerDesc = "Il registro delle missioni verrà nascosto durante lo scontro con il boss per liberare spazio sullo schermo.\n\nNON FUNZIONA se ti trovi in una Mitica+ o se stai tracciando un'impresa."

L.blockTalkingHead = "Nascondi popup PNG 'Testa Parlante'"
L.blockTalkingHeadDesc = "La 'Testa Palante' è una finestra popup di dialogo composta dalla testa di un PNG e una finestra di testo nella parte inferiore dello schermo che |cffff4411a volte|r mostra quando un PNG sta parlando.\n\nPuoi scegliere in quale tipo di istanza bloccare la sua comparsa.\n\n|cFF33FF99Nota importante:|r\n 1) Questa funzionalità permetterà sempre al PNG di parlare.\n 2) Solo alcune teste parlanti verranno bloccate. Qualsiasi cosa speciale o unica, come una quest non ripetibile, non verrà bloccata."
L.blockTalkingHeadDungeons = "Spedizioni Normali & Eroiche"
L.blockTalkingHeadMythics = "Spedizioni Mitiche & Mitiche+"
L.blockTalkingHeadRaids = "Incursioni"
L.blockTalkingHeadTimewalking = "Viaggi nel Tempo (Spedizioni & Incursioni)"
L.blockTalkingHeadScenarios = "Scenari"

L.redirectPopups = "Reindirizza i banner popup nelle su bigwigs"
--L.redirectPopupsDesc = "Popup banners in the middle of your screen such as the '|cFF33FF99vault slot unlocked|r' banner will instead be displayed as BigWigs messages. Questi banner possono essere abbastanza grandi, durare molto, e bloccare la possibilità di cliccarci attraverso."
L.redirectPopupsColor = "Colore dei messaggi reindirizzati"
L.blockDungeonPopups = "Blocca i banner popup dei dungeon"
L.blockDungeonPopupsDesc = "I banner popup mostrati quando entri in un dungeon a volte possono contenere messaggi molto lunghi. Abilitando questa impostazione li bloccherà completamente."
L.itemLevel = "Livello oggetto: %d"

L.userNotifySfx = "Gli Effetti sonori sono disabilitati dal Blocco Boss, li riattivo forzatamente."
L.userNotifyMusic = "La Musica è stata disabilitata dal Blocco Boss, la riattivo forzatamente."
L.userNotifyAmbience = "Gli Effetti Ambientali sono disabilitati dal Blocco Boss, li riattivo forzatamente."
L.userNotifyErrorSpeech = "I messaggi di Errore sono disabilitati dal Blocco Boss, li riattivo forzatamente."

L.subzone_grand_bazaar = "Gran Bazar" -- Battle of Dazar'alor raid (Battle for Azeroth)
L.subzone_port_of_zandalar = "Porto di Zandalar" -- Battle of Dazar'alor raid (Battle for Azeroth)
L.subzone_eastern_transept = "Transetto Orientale" -- Auchindoun dungeon (Warlords of Draenor)

-----------------------------------------------------------------------
-- Colors.lua
--

L.colors = "Colori"

L.text = "Testo"
L.textShadow = "Ombra Testo"
L.normal = "Normale"
L.emphasized = "Enfatizzato"

L.reset = "Reimposta"
L.resetDesc = "Reimposta i colori qui sopra ai parametri originali."
L.resetAll = "Reimposta tutto"
L.resetAllDesc = "Se hai modificato qualsiasi parametro dei combattimenti, questo pulsante riporterà TUTTO alle impostazioni originali."

L.red = "Rosso"
L.redDesc = "Avvisi generali di combattimento."
L.blue = "Blu"
L.blueDesc = "Avvisi per effetti diretti, come una magia su di te"
L.orange = "Arancione"
L.yellow = "Giallo"
L.green = "Verde"
L.greenDesc = "Avvisi per effetti benefici, come una magia rimossa da te."
L.cyan = "Azzurro"
L.cyanDesc = "Avvisi per modifiche di stato come un cambio di fase."
L.purple = "Viola"
L.purpleDesc = "Avvisi per abilità specifiche da difensore come un maleficio sul tank."

-----------------------------------------------------------------------
-- Countdown.lua
--

L.textCountdown = "Testo conto alla rovescia"
L.textCountdownDesc = "Mostra un conteggio visuale durante il conto alla rovescia."
L.countdownColor = "Colore conto alla rovescia"
L.countdownVoice = "Voce contro alla rovescia"
L.countdownTest = "Test conto alla rovescia"
L.countdownAt = "Conto alla rovescia in... (secondi)"
L.countdownAt_desc = "Scegli quanto tempo dovrebbe rimanere su un'abilità di un boss (in secondi) quando inizia il conto alla rovescia."
L.countdown = "Conto alla rovescia"
L.countdownDesc = "La funzionalità Conto alla rovescia prevede un conteggio scritto e un messaggio audio. Raramente è abilitata come opzione predefinita, ma puoi abilitarla per qualsiasi abilità del boss nelle opzioni specifiche di quel boss."
L.countdownAudioHeader = "Conto alla Rovescia Audio"
L.countdownTextHeader = "Conto alla Rovescia Visivo"
L.resetCountdownDesc = "Reimposta tutte le impostazioni dei Conti alla Rovescia alle loro opzioni predefinite."
L.resetAllCountdownDesc = "Se hai scelto delle voci personalizzate in qualsiasi impostazione dei boss, questo pulsante le cancellerà TUTTE così come tutte le altre modifiche riportandole ai valori predefiniti."

-----------------------------------------------------------------------
-- InfoBox.lua
--

L.infoBox = "InfoBox"

-----------------------------------------------------------------------
-- Messages.lua
--

L.sinkDescription = "Indirizza l'uscita dei messaggi sul visualizzatore di Messaggi Normali di BigWigs. Questa visualizzazione supporta icone, colori e può visualizzare fino a 4 messaggi sullo schermo. I messaggi più recenti cresceranno in dimensioni per avvertire l'utente."
L.emphasizedSinkDescription = "Indirizza l'uscita dei messaggi attraverso il visualizzatore di Messaggi ENFATIZZATI di BigWigs. Questo metodo supporta testi, colori e può visualizzare un solo messaggio per volta."
L.resetMessagesDesc = "Reimposta tutte le opzioni relative ai messaggi, compresa la posizione dei messaggi d'ancoraggio."
L.toggleMessagesAnchorsBtnShow_desc = "Mostra tutti i punti di ancoraggio, permettendoti di muovere i messaggi."

--L.testMessagesBtn = "Create Test Message"
--L.testMessagesBtn_desc = "Creates a message for you to test your current display settings with."

L.bwEmphasized = "BigWigs Enfatizzato"
L.messages = "Messaggi"
L.emphasizedMessages = "Messaggi Enfatizzati"
L.emphasizedDesc = "Lo scopo dei messaggi enfatizzati è richiamare la tua attenzione con un messaggio a grandezza maggiore rispetto al solito. Raramente è abilitata come opzione predefinita, ma puoi abilitarla per qualsiasi abilità del boss nelle opzioni specifiche di quel boss."
L.uppercase = "TUTTO MAIUSCOLO"
L.uppercaseDesc = "Tutti i messaggi enfatizzati verranno convertiti in MAIUSCOLO."

L.useIcons = "Usa Icone"
L.useIconsDesc = "Mostra le icone accanto ai messaggi."
L.classColors = "Colore delle Classi"
L.classColorsDesc = "I messaggi possono contenere i nomi dei giocatori. Attivando questa opzione verranno colorati con il colore della classe."
L.chatFrameMessages = "Messaggi Riquadro Chat"
L.chatFrameMessagesDesc = "Invia tutti i messaggi di BigWigs alla chat oltre che nei settaggi di visualizzazione."

L.fontSize = "Dimensione Carattere"
L.none = "Nessuno"
L.thin = "Fine"
L.thick = "Spesso"
L.outline = "Sottolineato"
L.monochrome = "Monocromatico"
L.monochromeDesc = "Abilita il flag monocromatico, rimuovendo ogni effetto di smussatura degli angoli dei caratteri."
L.fontColor = "Colore carattere"

L.displayTime = "Tempo di Visualizzazione"
L.displayTimeDesc = "Per quanto tempo deve essere visualizzato il messaggio, in secondi"
L.fadeTime = "Tempo di Scomparsa"
L.fadeTimeDesc = "Dopo quanti secondi il messaggio deve scomparire, in secondi"

-----------------------------------------------------------------------
-- Nameplates.lua
--

--L.nameplates = "Nameplates"
--L.testNameplateIconBtn = "Show Test Icon"
--L.testNameplateIconBtn_desc = "Creates a test icon for you to test your current display settings with on your targeted nameplate."
--L.testNameplateTextBtn = "Show Text Test"
--L.testNameplateTextBtn_desc = "Creates a test text for you to test your current text settings with on your targeted nameplate."
--L.stopTestNameplateBtn = "Stop Tests"
--L.stopTestNameplateBtn_desc = "Stops the icon and text tests on your nameplates."
--L.noNameplateTestTarget = "You need to have a hostile target which is attackable selected to test nameplate functionality."
--L.anchoring = "Anchoring"
--L.growStartPosition = "Grow Start Position"
--L.growStartPositionDesc = "The starting position for the first icon."
--L.growDirection = "Grow Direction"
--L.growDirectionDesc = "The direction the icons will grow from the starting position."
--L.iconSpacingDesc = "Change the space between each icon."
--L.nameplateIconSettings = "Icon Settings"
--L.keepAspectRatio = "Keep Aspect Ratio"
--L.keepAspectRatioDesc = "Keep the aspect ratio of the icon 1:1 instead of stretching it to fit the size of the frame."
--L.iconColor = "Icon Color"
--L.iconColorDesc = "Change the color of the icon texture."
--L.desaturate = "Desaturate"
--L.desaturateDesc = "Desaturate the icon texture."
--L.zoom = "Zoom"
--L.zoomDesc = "Zoom the icon texture."
--L.showBorder = "Show Border"
--L.showBorderDesc = "Show a border around the icon."
--L.borderColor = "Border Color"
--L.borderSize = "Border Size"
--L.showNumbers = "Show Numbers"
--L.showNumbersDesc = "Show numbers on the icon."
--L.cooldown = "Cooldown"
--L.showCooldownSwipe = "Show Swipe"
--L.showCooldownSwipeDesc = "Show a swipe on the icon when the cooldown is active."
--L.showCooldownEdge = "Show Edge"
--L.showCooldownEdgeDesc = "Show an edge on the cooldown when the cooldown is active."
--L.inverse = "Inverse"
--L.inverseSwipeDesc = "Invert the cooldown animations."
--L.glow = "Glow"
--L.enableExpireGlow = "Enable Expire Glow"
--L.enableExpireGlowDesc = "Show a glow around the icon when the cooldown has expired."
--L.glowColor = "Glow Color"
--L.glowType = "Glow Type"
--L.glowTypeDesc = "Change the type of glow that is shown around the icon."
--L.resetNameplateIconsDesc = "Reset all the options related to nameplate icons."
--L.nameplateTextSettings = "Text Settings"
--L.fixate_test = "Fixate Test" -- Text that displays to test on the frame
--L.resetNameplateTextDesc = "Reset all the options related to nameplate text."
--L.autoScale = "Auto Scale"
--L.autoScaleDesc = "Automatically change scale according to the nameplate scale."

-- Glow types as part of LibCustomGlow
--L.pixelGlow = "Pixel Glow"
--L.autocastGlow = "Autocast Glow"
--L.buttonGlow = "Button Glow"
--L.procGlow = "Proc Glow"
--L.speed = "Speed"
--L.animation_speed_desc = "The speed at which the glow animation plays."
--L.lines = "Lines"
--L.lines_glow_desc = "The number of lines in the glow animation."
--L.intensity = "Intensity"
--L.intensity_glow_desc = "The intensity of the glow effect, higher means more sparks."
--L.length = "Length"
--L.length_glow_desc = "The length of the lines in the glow animation."
--L.thickness = "Thickness"
--L.thickness_glow_desc = "The thickness of the lines in the glow animation."
--L.scale = "Scale"
--L.scale_glow_desc = "The scale of the sparks in the animation."
--L.startAnimation = "Start Animation"
--L.startAnimation_glow_desc = "This glow has a starting animation, this will enable/disable that animation."

-----------------------------------------------------------------------
-- Proximity.lua
--

L.customRange = "Indicatore di Distanza Personalizzato"
L.proximityTitle = "%d m / %d |4giocatore:giocatori;" -- yd = yards (short)
L.proximity_name = "Prossimità"
L.soundDelay = "Ritardo del Suono"
L.soundDelayDesc = "Specifica per quanto tempo BigWigs dovrebbe aspettare per ripetere il suono quando qualcuno è vicino a te."

L.resetProximityDesc = "Reimposta tutte le opzione relative alla prossimità, compreso il posizionamento dell'ancora di prossimità."

L.close = "Chiudi"
L.closeProximityDesc = "Chiude il Monitor di Prossimità.\n\nPer disabilitarlo completamente per tutti gli incontri, devi andare nelle impostazioni dei singoli combattimenti e disabilitare l'opzione 'Prossimità"
L.lock = "Blocca"
L.lockDesc = "Blocca il Monitor, impedendo che venga spostato e ridimensionato."
L.title = "Titolo"
L.titleDesc = "Visualizza o nasconde il titolo"
L.background = "Sfondo"
L.backgroundDesc = "Visualizza o nasconde il titolo"
L.toggleSound = "Abilita Suono"
L.toggleSoundDesc = "Abilita quando il monitor di prossimità deve emettere un suono se sei troppo vicino ad altri giocatori."
L.soundButton = "Pulsante del Suono"
L.soundButtonDesc = "Visualizza o nasconde il pulsante del Suono"
L.closeButton = "Pulsante di Chiusura"
L.closeButtonDesc = "Visualizza o nasconde il pulsante di Chiusura"
L.showHide = "Visulizza/Nascondi"
L.abilityName = "Nome dell'Abilità"
L.abilityNameDesc = "Visualizza o nasconde il nome dell'abilità sopra la finestra"
L.tooltip = "ToolTip"
L.tooltipDesc = "Visualizza o nasconde il tooltip dell'abilità nel display di prossimità ed è strettamente legato all'abilità del boss."

-----------------------------------------------------------------------
-- Pull.lua
--

L.countdownType = "Tipo di conto alla rovescia"
L.combatLog = "Registro di combattimento automatico"
L.combatLogDesc = "Inizia a registrare il combattimento automaticamente quando parte un pull timer e lo interrompe quando termina lo scontro."

L.pull = "Ingaggio"
L.engageSoundTitle = "Riproduci un suono quando inizia il combattimento con un boss"
L.pullStartedSoundTitle = "Riproduci un suono quando comincia il timer di ingaggio"
L.pullFinishedSoundTitle = "Riproduci un suono quando termina il timer di ingaggio"
--L.pullStartedBy = "Pull timer started by %s."
L.pullStopped = "Timer ingaggio cancellato da %s."
L.pullStoppedCombat = "Timer ingaggio cancellato perchè è iniziato il combattimento."
L.pullIn = "Ingaggio tra %d sec"
--L.sendPull = "Sending a pull timer to your group."
--L.wrongPullFormat = "Invalid pull timer. A correct example is: /pull 5"
L.countdownBegins = "Inizia Conto alla Rovescia"
L.countdownBegins_desc = "Scegli quanto tempo dovrebbe rimanere al timer di Ingaggio (in secondi) quando inizia il conto alla rovescia."

-----------------------------------------------------------------------
-- RaidIcon.lua
--

L.icons = "Icone"
L.raidIconsDescription = "Alcuni combattimenti possono includere elementi come bombe su giocatori specifici, un giocatore inseguito da qualcosa, o un giocatore che può essere fondamentale seguire. Qui puoi personalizzare quali Simboli devono essere applicati sui giocatori\n\nSe uno scontro ha una sola abilità che deve essere marchiata, verrà usata solo la prima icona. Un'icona non verrà mai usata due volte per due abilità differenti nello stesso scontro, e tutte queste abilità useranno la stessa icona negli scontri successivi.\n\n|cffff4411Da segnalare che se un giocatore è stato marchiato manualmente, BigWigs non cambierà mai quell'icona.|r"
L.primary = "Primario"
L.primaryDesc = "Il primo Simbolo che l'automazione del combattimento dovrebbe usare."
L.secondary = "Secondario"
L.secondaryDesc = "Il secondo Simbolo che l'automazione del combattimento dovrebbe usare."

-----------------------------------------------------------------------
-- Sound.lua
--

L.Sounds = "Suoni"
L.soundsDesc = "BigWigs usa il canale audio 'Master' per riprodurre tutti i suoni. Se il suono risulta troppo debole o alto, apri le impostazioni audio di WoW e aggiusta il 'Volume principale' ad un livello soddisfacente per te.\n\nSotto puoi configurare globalmente i vari suoni riprodotti per specifiche azioni, o impostare 'Nessuno' per disabilitarli. Se vuoi solo cambiare un suono per un'abilità specifica di un boss, puoi farlo dal pannello opzioni per quel boss.\n\n"
L.oldSounds = "Vecchi Suoni"

L.Alarm = "Allarme"
L.Info = "Informazioni"
L.Alert = "Avvertimento"
L.Long = "Lungo"
L.Warning = "Avviso"
L.onyou = "Un'Incantesimo, un potenziamento o un depotenziamento su di te"
L.underyou = "Devi muoverti fuori dall'incantesimo sotto di te"
--L.privateaura = "Whenever a 'Private Aura' is on you"

L.sound = "Suono"

L.customSoundDesc = "Riproduci il suono personalizzato scelto invece che quelli proposti dal modulo."
L.resetSoundDesc = "Reimposta i suoni precedenti ai loro valori predefiniti."
L.resetAllCustomSound = "Se hai personalizzzato i suoni per qualsiasi boss, questo pulsante reimposterà TUTTI i suoni predefiniti e quindi verranno usati i suoni definiti qui."

-----------------------------------------------------------------------
-- Statistics.lua
--

L.bossStatistics = "Statistiche del Boss"
L.bossStatsDescription = "Recording of various boss-related statistics such as the amount of times you were victorious, the amount of times you were defeated, date of first victory, and the fastest victory. Queste statistiche possono essere viste nella finestra di configurazione di ogni singolo boss, ma saranno nascoste per quei boss di cui non c'é nessuna informazione statistica."
L.createTimeBar = "Mostra la barra 'Miglior Tempo'"
L.bestTimeBar = "Migliore"
L.healthPrint = "Salute: %s."
L.healthFormat = "%s (%.1f%%)"
L.chatMessages = "Messaggi Riquadro Chat"
--L.newFastestVictoryOption = "New fastest victory"
--L.victoryOption = "You were victorious"
--L.defeatOption = "You were defeated"
L.bossHealthOption = "Salute Boss"
--L.bossVictoryPrint = "You were victorious against '%s' after %s." -- You were victorious against 'BOSS_NAME' after COMBAT_DURATION.
--L.bossDefeatPrint = "You were defeated by '%s' after %s." -- You were defeated by 'BOSS_NAME' after COMBAT_DURATION.
--L.newFastestVictoryPrint = "New fastest victory: (-%s)" -- New fastest victory: (-COMBAT_DURATION)

-----------------------------------------------------------------------
-- Victory.lua
--

L.Victory = "Vittoria"
L.victoryHeader = "Configura le azioni da eseguire quando sconfiggi un boss."
L.victorySound = "Riproduci un suono quando hai vinto"
L.victoryMessages = "Mostra i messaggi alla sconfitta di un boss"
L.victoryMessageBigWigs = "Mostra il messaggio BigWigs"
L.victoryMessageBigWigsDesc = "Il messaggio BigWigs è un semplice \"Il boss è stato sconfitto\"."
L.victoryMessageBlizzard = "Mostra il messaggio Blizzard"
L.victoryMessageBlizzardDesc = "Il messaggio Blizzard è un'animazione molto grande \"Il boss è stato sconfitto\" al centro dello schermo."
L.defeated = "%s è stato sconfitto!"

-----------------------------------------------------------------------
-- Wipe.lua
--

L.wipe = "Fallimento"
L.wipeSoundTitle = "Riproduci un suono dopo un tentativo fallito"
L.respawn = "Rinascita"
L.showRespawnBar = "Mostra barra di rinascita"
L.showRespawnBarDesc = "Mostra una barra dopo un fallimento dal boss che mostra il tempo rimanente prima che il boss ricompaia."
