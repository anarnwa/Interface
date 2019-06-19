if GetLocale() == "itIT" then
	if not FactionAddictLocalization then
		FactionAddictLocalization = {}
	end

-- Titoli
FactionAddictLocalization["ADDON_TITLE"] = "Faction Addict"

-- Etichette schede a piè di pagina dell'addon
FactionAddictLocalization["TAB1_LABEL"] = "Fazioni"
FactionAddictLocalization["TAB2_LABEL"] = "Log"
FactionAddictLocalization["TAB3_LABEL"] = "Configurazione"
FactionAddictLocalization["TAB4_LABEL"] = "About"

-- Messaggi di Errore
FactionAddictLocalization["ERROR1"] = "Nessuna fazione da mostrare!\n\nControlla la Configurazione e il Filtro di Prestigio."

-- Didascalie
FactionAddictLocalization["LAUNCHER_TT"] = "Apri/Chiudi Faction Addict"
FactionAddictLocalization["CONFIG_TT_CF"] = "Mostra le fazioni Classiche di WoW."
FactionAddictLocalization["CONFIG_TT_BC"] = "Mostra le fazioni di Burning Crusade."
FactionAddictLocalization["CONFIG_TT_WOTLK"] = "Mostra le fazioni di Wrath of the Lich King."
FactionAddictLocalization["CONFIG_TT_CATA"] = "Mostra le fazioni di Cataclysm."
FactionAddictLocalization["CONFIG_TT_MOP"] = "Mostra le fazioni di Mists of Pandaria."
FactionAddictLocalization["CONFIG_TT_WOD"] = "Mostra le fazioni di Warlords of Draenor."
FactionAddictLocalization["CONFIG_TT_LG"] = "Mostra le fazioni di Legion."
FactionAddictLocalization["CONFIG_TT_BFA"] = "Show Battle for Azeroth factions."
FactionAddictLocalization["CONFIG_TT_OrderPct"] = "Ordina le fazioni in base alla percentuale di Osannato."
FactionAddictLocalization["CONFIG_TT_OrderName"] = "Ordina le fazioni per nome."
FactionAddictLocalization["CONFIG_TT_AO"] = "Mostra solo le fazioni dell'|cFF0070DEAlleanza|r."
FactionAddictLocalization["CONFIG_TT_HO"] = "Mostra solo le fazioni dell'|cFFC41F3BOrda|r."
FactionAddictLocalization["CONFIG_TT_AUTOBAR"] = "Cambia automaticamente la barra della reputazione in base all'ultima reputazione ottenuta."
FactionAddictLocalization["CONFIG_TT_HIDEINACTIVE"] = "Nascondi le fazioni impostate come Inattive nell'addon, altrimenti quest'ultime verrano spostate in fondo all'elenco e verranno evidenziate con uno sfondo rosso."
FactionAddictLocalization["CHECKBUTTON_TT_SETINACTIVE"] = "Sposta questa fazione in fondo all'elenco delle fazioni. (Le fazioni Inattive hanno uno sfondo rosso e possono essere nascoste in base alle impostazioni della Configurazione.)"
FactionAddictLocalization["TAB1_TT"] = FactionAddictLocalization["TAB1_LABEL"]
FactionAddictLocalization["TAB2_TT"] = FactionAddictLocalization["TAB2_LABEL"]
FactionAddictLocalization["TAB3_TT"] = FactionAddictLocalization["TAB3_LABEL"]
FactionAddictLocalization["TAB4_TT"] = FactionAddictLocalization["TAB4_LABEL"]
FactionAddictLocalization["CONFIG_MENU_TT"] = "Filtro di Prestigio"
FactionAddictLocalization["ACHIEVEMENT_TT_TITLE"] = "Imprese Osannato:"
FactionAddictLocalization["SEARCH_TOGGLE"] = "Riquadro di Ricerca"

-- Scheda 1 - Testo della scheda Fazioni
FactionAddictLocalization["TAB1_DESC_TXT"] = "Clicca una fazione per maggiori info."
FactionAddictLocalization["KNOWN_TXT"] = "Conosciute: "
FactionAddictLocalization["SHOWN_TXT"] = "Mostrate: "
FactionAddictLocalization["EXALTED_TXT"] = "Osannate: "
FactionAddictLocalization["NEXT_ACHIEV_TXT"] = "Prossima Impresa: "

-- Scheda 2 - Testo della scheda Log
FactionAddictLocalization["TAB2_DESC_TXT"] = "Log Reputazione"
FactionAddictLocalization["TAB2_LASTGAIN_TXT"] = "Ultimo ottenimento"
FactionAddictLocalization["TAB2_NOGAIN_TXT"] = "Niente in questa sessione"
FactionAddictLocalization["TAB2_SESSIONTOTAL_TXT"] = "Totale Sessione: "

-- Scheda 3 - Testo della scheda Configurazione
FactionAddictLocalization["TAB3_DESC_TXT"] = "Configurazione"
FactionAddictLocalization["TAB3_DISPLAY_CONFIG_TXT"] = "Quali fazioni devo mostrare?"
FactionAddictLocalization["TAB3_DISPLAY_ORDER_TXT"] = "Ordina fazioni per"
FactionAddictLocalization["TAB3_DISPLAY_FILTER"] = "Filtro fazione"
FactionAddictLocalization["TAB3_DISPLAY_OPTIONS"] = "Opzioni"
FactionAddictLocalization["TAB3_CONFIG_CF"] = "Fazioni Classiche"
FactionAddictLocalization["TAB3_CONFIG_BC"] = "Fazioni Burning Crusade"
FactionAddictLocalization["TAB3_CONFIG_WOTLK"] = "Fazioni Wrath of the Lich King"
FactionAddictLocalization["TAB3_CONFIG_CATA"] = "Fazioni Cataclysm"
FactionAddictLocalization["TAB3_CONFIG_MOP"] = "Fazioni Mists of Pandaria"
FactionAddictLocalization["TAB3_CONFIG_WOD"] = "Fazioni Warlords of Draenor"
FactionAddictLocalization["TAB3_CONFIG_LG"] = "Fazioni Legion"
FactionAddictLocalization["TAB3_CONFIG_BFA"] = "Battle for Azeroth Factions"
FactionAddictLocalization["TAB3_CONFIG_ORDER_PCT"] = "% di Osannato"
FactionAddictLocalization["TAB3_CONFIG_ORDER_NAME"] = "Nome fazione"
FactionAddictLocalization["TAB3_CONFIG_ALLIANCE_ONLY"] = "Mostra solo fazioni |cFF0070DEAlleanza|r"
FactionAddictLocalization["TAB3_CONFIG_HORDE_ONLY"] = "Mostra solo fazioni |cFFC41F3BOrda|r"
FactionAddictLocalization["TAB3_CONFIG_AUTOBAR"] = "Cambia automaticamente la barra reputazione"
FactionAddictLocalization["TAB3_CONFIG_HIDEINACTIVE"] = "Nascondi fazioni Inattive"

-- Scheda 4 - Testo della scheda About
FactionAddictLocalization["TAB4_DESC_TXT"] = "About Faction Addict"
FactionAddictLocalization["VERSION_TXT"] = "versione: "
FactionAddictLocalization["ABOUT_TXT"] = "Faction Addict è un addon che aiuta il giocatore a visualizzare e tenere traccia facilmente delle informazioni relative alle varie fazioni nel gioco. Grandioso per coloro che puntano a osannare le reputazioni con fazioni differenti. |n|nUsa i comandi slash |cFFFF0000/fa|r oppure |cFFFF0000/factionaddict|r per aprire e/o chiudere la finestra. Il pannello UI predefinito ha un pulsante di lancio nell'angolo superiore destro.|n|nScarica gli aggiornamenti e lascia dei commenti su: |cFFFFFF00wowinterface.com|r e |cFFFFFF00wow.curse.com|r|n|nScritto da: |cFFFFFF00gmz323 (Greg)|r"

-- Finestra Informativa
FactionAddictLocalization["LAUNCH_WATCH_PANEL_TXT"] = "Lancia Pannello di Osservazione"
FactionAddictLocalization["FACTION_URL_TXT"] = "https://it.wowhead.com/faction="
FactionAddictLocalization["PCT_TO_EXALTED_TXT"] = "% di Osannato: "
FactionAddictLocalization["PCT_TO_REWARD_TXT"] = "% alla Prossima Impresa: "
FactionAddictLocalization["CATEGORY_TXT"] = "Categoria: "

-- Finestra Informativa - Categorie
FactionAddictLocalization["CATEGORY_ALLIANCE_TXT"] = "Alleanza"
FactionAddictLocalization["CATEGORY_ALLIANCEFORCES_TXT"] = "Forze dell'Alleanza"
FactionAddictLocalization["CATEGORY_ALLIANCEVANGUARD_TXT"] = "Avanguardia dell'Alleanza"
FactionAddictLocalization["CATEGORY_CATACLYSM_TXT"] = "Cataclysm"
FactionAddictLocalization["CATEGORY_CLASSIC_TXT"] = "Classiche"
FactionAddictLocalization["CATEGORY_GUILD_TXT"] = "Gilda"
FactionAddictLocalization["CATEGORY_HORDE_TXT"] = "Orda"
FactionAddictLocalization["CATEGORY_HORDEEXP_TXT"] = "Spedizione dell'Orda"
FactionAddictLocalization["CATEGORY_OTHER_TXT"] = "Altro"
FactionAddictLocalization["CATEGORY_SHATTRATH_TXT"] = "Shattrath"
FactionAddictLocalization["CATEGORY_SHOLAZAR_TXT"] = "Bacino di Sholazar"
FactionAddictLocalization["CATEGORY_STEAMWHEEDLE_TXT"] = "Cartello degli Spargifumo"
FactionAddictLocalization["CATEGORY_TBC_TXT"] = "The Burning Crusade"
FactionAddictLocalization["CATEGORY_WOTLK_TXT"] = "Wrath of the Lich King"
FactionAddictLocalization["CATEGORY_HORDEFORCES_TXT"] = "Forze dell'Orda"
FactionAddictLocalization["CATEGORY_MOP_TXT"] = "Mists of Pandaria"
FactionAddictLocalization["CATEGORY_WOD_TXT"] = "Warlords of Draenor"
FactionAddictLocalization["CATEGORY_BARRACKSBODYGUARDS_TXT"] = "Guardie del Corpo della Caserma"
FactionAddictLocalization["CATEGORY_LEGION_TXT"] = "Legion"
FactionAddictLocalization["CATEGORY_BFA_TXT"] = "Battle for Azeroth"

-- FIltro di Prestigio (Scheda 1 - Menu a tendina)
FactionAddictLocalization["STANDING_FILTER_TITLE_TXT"] =    "Filtro di Prestigio"
FactionAddictLocalization["STANDING_FILTER_LABEL_8_TXT"] =  "(42,000+)"
FactionAddictLocalization["STANDING_FILTER_LABEL_7_TXT"] =  "(21,000 to 42,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_6_TXT"] =  "(9,000 to 21,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_5_TXT"] =  "(3,000 to 9,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_4B_TXT"] = "(1 to 3,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_4A_TXT"] = "(=0)"
FactionAddictLocalization["STANDING_FILTER_LABEL_3_TXT"] =  "(-3,000 to 0)"
FactionAddictLocalization["STANDING_FILTER_LABEL_2_TXT"] =  "(-6,000 to -3,000)"
FactionAddictLocalization["STANDING_FILTER_LABEL_1_TXT"] =  "(-42,000 to -6,000)"

-- Data della scheda Log (Formato: D = giorno della settimana, d = giorno, m = mese, y = anno)
FactionAddictLocalization["Monday"] = "Lunedì"
FactionAddictLocalization["Tuesday"] = "Martedì"
FactionAddictLocalization["Wednesday"] = "Mercoledì"
FactionAddictLocalization["Thursday"] = "Giovedì"
FactionAddictLocalization["Friday"] = "Venerdì"
FactionAddictLocalization["Saturday"] = "Sabato"
FactionAddictLocalization["Sunday"] = "Domenica"
FactionAddictLocalization["DATE_FORMAT"] = "D d/m/y"

-- Misc Strings
FactionAddictLocalization["MISC_PARAGON_TXT"] = "Eccellenza"
end;