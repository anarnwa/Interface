﻿-- Locale
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local AL = AceLocale:NewLocale("RareScanner", "frFR", false);

if AL then
	AL["ALARM_MESSAGE"] = "Un PNJ rare vient d'apparaître, visible sur votre mini-carte !"
	AL["ALARM_SOUND"] = "Son d'avertissement pour les PNJ rares"
	AL["ALARM_SOUND_DESC"] = "Son joué lorsqu'un PNJ rare apparaît sur votre mini-carte"
	AL["ALARM_TREASURES_SOUND"] = "Son d'avertissement pour les événements / trésors."
	AL["ALARM_TREASURES_SOUND_DESC"] = "Son joué lorsqu'un trésor / coffre ou événement apparaît dans votre mini-carte"
	AL["AUTO_HIDE_BUTTON"] = "Masque automatiquement le bouton et la miniature"
	AL["AUTO_HIDE_BUTTON_DESC"] = "Masque automatiquement le bouton et la miniature après le temps sélectionné (en secondes). Si vous sélectionnez zéro seconde, le bouton et la miniature ne seront pas masqués automatiquement"
	AL["CLASS_HALLS"] = "Domaines de classe."
	AL["CLEAR_FILTERS_SEARCH"] = "Effacez"
	AL["CLEAR_FILTERS_SEARCH_DESC"] = "Réinitialise le formulaire à l'état initial"
	AL["CLICK_TARGET"] = "Cliquez pour cibler le PNJ"
	AL["CMD_DISABLE_ALERTS"] = "RareScanner les PNJ, les trésors et les événements rares sont désactivés"
	AL["CMD_DISABLE_CONTAINERS_ALERTS"] = "Les alertes des trésors de RareScanner sont désactivées"
	AL["CMD_DISABLE_EVENTS_ALERTS"] = "Les alertes des événements de RareScanner sont désactivées"
	AL["CMD_DISABLE_RARES_ALERTS"] = "Les alertes PNJ rares de RareScanner sont désactivées"
	AL["CMD_ENABLE_ALERTS"] = "RareScanner les PNJ rares, les trésors et les événements sont activées"
	AL["CMD_ENABLE_CONTAINERS_ALERTS"] = "RareScanner Alertes des trésors sont activées"
	AL["CMD_ENABLE_EVENTS_ALERTS"] = "RareScanner les événements sont activées"
	AL["CMD_ENABLE_RARES_ALERTS"] = "RareScanner les PNJ rares sont activées"
	AL["CMD_HELP1"] = "Liste des commandes"
	AL["CMD_HELP2"] = "Activer/désactiver tous les icônes sur la carte mondiale "
	AL["CMD_HELP3"] = "Activer/désactiver les icônes des événements sur la carte du monde"
	AL["CMD_HELP4"] = "Activer/désactiver les icônes des trésors sur la carte du monde"
	AL["CMD_HELP5"] = "Activer/désactiver les icônes de PNJ rares sur la carte du monde"
	AL["CMD_HELP6"] = "Activer/désactiver toutes les alertes"
	AL["CMD_HELP7"] = "Activer/désactiver les alertes d'événements"
	AL["CMD_HELP8"] = "Activer/désactiver les alertes des trésors"
	AL["CMD_HELP9"] = "Activer/désactiver les alertes des PNJ rares"
	AL["CMD_HIDE"] = "Désactive les icônes de RareScanner sur la carte du monde"
	AL["CMD_HIDE_EVENTS"] = "Désactive les icônes des événements sur la carte du monde"
	AL["CMD_HIDE_RARES"] = "Désactive les icônes rares sur la carte du monde"
	AL["CMD_HIDE_TREASURES"] = "Désactive les icônes de trésor sur la carte du monde"
	AL["CMD_SHOW"] = "Afficher les icônes de RareScanner sur la carte du monde"
	AL["CMD_SHOW_EVENTS"] = "Affiche des icônes d'événements de RareScanner sur la carte du monde"
	AL["CMD_SHOW_RARES"] = "Affiche des icônes rares de RareScanner sur la carte du monde"
	AL["CMD_SHOW_TREASURES"] = "Affiche les icônes de trésor de RareScanner sur la carte du monde"
	AL["CONTAINER"] = "Conteneur"
	AL["DATABASE_HARD_RESET"] = "Depuis l'extension la plus récente et avec la dernière version de RareScanner, de grands changements se sont produits dans la base de données, ce qui a nécessité une réinitialisation de la base de données afin d'éviter les incohérences. Désolé pour le dérangement."
	AL["DISABLE_SEARCHING_RARE_TOOLTIP"] = "Désactiver les alertes pour ce PNJ rare"
	AL["DISABLE_SOUND"] = "Désactive les alertes audio"
	AL["DISABLE_SOUND_DESC"] = "Lorsque cette option est activée, vous ne recevrez pas d'alertes audio"
	AL["DISABLED_SEARCHING_RARE"] = "Alertes désactivées pour ce PNJ rare:"
	AL["DISPLAY"] = "Affichage"
	AL["DISPLAY_BUTTON"] = "Active l'affichage du bouton et de la miniature"
	AL["DISPLAY_BUTTON_CONTAINERS"] = "Active le bouton pour les trésors et les coffres"
	AL["DISPLAY_BUTTON_CONTAINERS_DESC"] = "Active le bouton pour les trésors et les coffres. Il n'affecte pas la sonnerie d'alarme et les alertes du chat"
	AL["DISPLAY_BUTTON_DESC"] = "Lorsqu'il est désactivé, le bouton et la miniature ne seront plus affichés. Cela n'affecte pas le son de l'alarme et les alertes du chat"
	AL["DISPLAY_BUTTON_SCALE"] = "Échelle du bouton et de la miniature"
	AL["DISPLAY_BUTTON_SCALE_DESC"] = "Cela permettra d'ajuster l'échelle du bouton et de la miniature, soit la valeur de 0,85 de la taille originale"
	AL["DISPLAY_CONTAINER_ICONS"] = "Afficher les icônes des conteneurs sur la carte du monde"
	AL["DISPLAY_CONTAINER_ICONS_DESC"] = "Lorsqu'elles sont désactivées, les icônes des conteneurs et des trésors ne seront pas affichées sur la carte du monde."
	AL["DISPLAY_EVENT_ICONS"] = "Afficher les icônes des événements sur la carte du monde"
	AL["DISPLAY_EVENT_ICONS_DESC"] = "Lorsqu'elles sont désactivées, les icônes des événements ne seront pas affichées sur la carte du monde."
	AL["DISPLAY_LOG_WINDOW"] = "Afficher la fenêtre du journal"
	AL["DISPLAY_LOG_WINDOW_DESC"] = "Lorsqu'elle est désactivée, la fenêtre du journal ne s'affichera plus."
	AL["DISPLAY_LOOT_ON_MAP"] = "Afficher le butin sur les info-bulles de la carte"
	AL["DISPLAY_LOOT_ON_MAP_DESC"] = "Affichage du butin des PNJs/conteneurs dans l'info-bulle qui apparaît lorsque vous passez la souris sur les icônes"
	AL["DISPLAY_LOOT_PANEL"] = "Affiche la barre de butin"
	AL["DISPLAY_LOOT_PANEL_DESC"] = "Lorsqu'il est activé, affiche une barre avec le butin disponible par le PNJ trouvé"
	AL["DISPLAY_MAP_NOT_DISCOVERED_ICONS"] = "Active les icônes non découvertes sur la carte."
	AL["DISPLAY_MAP_NOT_DISCOVERED_ICONS_DESC"] = "Lorsqu'elles sont désactivées, les icônes des PNJ rares non découverts (les icônes rouge et orange), des conteneurs ou des événements ne seront pas affichés sur la carte du monde"
	AL["DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS"] = "Active les icônes non découvertes sur la carte pour les anciennes extensions"
	AL["DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS_DESC"] = "Lorsqu'elles sont désactivées, les icônes des PNJ rares non découverts (les icônes rouge et orange), des conteneurs ou des événements ne seront pas affichés sur la carte du monde pour les zones qui appartiennent à des extensions plus anciennes."
	AL["DISPLAY_MINIATURE"] = "Active l'affichage de la miniature."
	AL["DISPLAY_MINIATURE_DESC"] = "Lorsqu'elle est désactivée, la miniature ne sera plus affichée."
	AL["DISPLAY_NPC_ICONS"] = "Afficher les icônes rares des PNJ sur la carte du monde"
	AL["DISPLAY_NPC_ICONS_DESC"] = "Lorsqu'elles sont désactivées, les icônes des PNJs rares ne seront plus affichées sur la carte du monde."
	AL["DISPLAY_OPTIONS"] = "Options d'affichage"
	AL["DUNGEONS_SCENARIOS"] = "Donjons / Scénarios"
	AL["ENABLE_MARKER"] = "Active l'affichage du marqueur de la cible"
	AL["ENABLE_MARKER_DESC"] = "Lorsque cette fonction est activée, un marqueur apparaîtra en haut de la cible lorsque vous cliquerez sur le bouton principal"
	AL["ENABLE_SCAN_CHAT"] = "Active la recherche de PNJ rares par le biais de messages du chat"
	AL["ENABLE_SCAN_CHAT_DESC"] = "Lorsque cette fonction est activée, vous serez averti visuellement et par un son chaque fois qu'un PNJ rare criera ou qu'un message du chat est en rapport avec le PNJ rare détecté."
	AL["ENABLE_SCAN_CONTAINERS"] = "Active la recherche des trésors ou des coffres"
	AL["ENABLE_SCAN_CONTAINERS_DESC"] = "Lorsque cette fonction est activée, vous serez averti visuellement et par un son chaque fois qu'un trésor ou un coffre apparaîtra sur votre minimap"
	AL["ENABLE_SCAN_EVENTS"] = "Activer la recherche des événements"
	AL["ENABLE_SCAN_EVENTS_DESC"] = "Lorsque cette fonction est activée, vous serez averti visuellement et par un son chaque fois qu'un événement apparaîtra sur votre minimap"
	AL["ENABLE_SCAN_GARRISON_CHEST"] = "Active la recherche de trésor de la garnison."
	AL["ENABLE_SCAN_GARRISON_CHEST_DESC"] = "Lorsque cette fonction est activée, vous serez averti visuellement et par un son chaque fois que votre coffre de garnison apparaîtra sur votre minimap"
	AL["ENABLE_SCAN_IN_INSTANCE"] = "Active le scan dans les instances."
	AL["ENABLE_SCAN_IN_INSTANCE_DESC"] = "Lorsque cette option est activée, l'addon fonctionnera comme d'habitude pendant que vous êtes dans une instance (donjon, raid, etc.)"
	AL["ENABLE_SCAN_ON_TAXI"] = "Active le scan lors de l'utilisation d'un moyen de transport."
	AL["ENABLE_SCAN_ON_TAXI_DESC"] = "Lorsque cette option est activée, l'addon fonctionne comme d'habitude lorsque vous utilisez un moyen de transport (vol, bateau, etc.)."
	AL["ENABLE_SCAN_RARES"] = "Active la recherche des PNJ rares"
	AL["ENABLE_SCAN_RARES_DESC"] = "Lorsque cette fonction est activée, vous serez averti visuellement et par un son chaque fois qu'un PNJ rare apparaîtra dans sur minimap"
	AL["ENABLE_SEARCHING_RARE_TOOLTIP"] = "Active les alertes pour ce PNJ rare"
	AL["ENABLE_TOMTOM_SUPPORT"] = "Active l'aide de l'addon Tomtom"
	AL["ENABLE_TOMTOM_SUPPORT_DESC"] = "Lorsque cette fonction est activée, elle ajoute un point de cheminement Tomtom aux coordonnées trouvées de la créature."
	AL["ENABLED_SEARCHING_RARE"] = "Active l'alerte pour ce PNJ rare :"
	AL["EVENT"] = "Événement"
	AL["FILTER"] = "Filtres des PNJ"
	AL["FILTER_CONTINENT"] = "Continent/Catégorie"
	AL["FILTER_CONTINENT_DESC"] = "Nom du continent ou de la catégorie"
	AL["FILTER_NPCS_ONLY_MAP"] = "Active uniquement les filtres sur la carte mondiale"
	AL["FILTER_NPCS_ONLY_MAP_DESC"] = "Lorsque cette fonction est activée, vous recevrez toujours des alertes de la part des PNJ filtrés, mais elles n'apparaîtront pas sur votre carte du monde. Lorsque cette option est désactivée, vous ne recevrez pas du tout d'alertes de la part des PNJ filtrés."
	AL["FILTER_RARE_LIST"] = "Filtre de recherche pour les PNJ rares"
	AL["FILTER_RARE_LIST_DESC"] = "Active la recherche de ce PNJ rare. Si vous le désactivé, vous ne serez pas alerté lorsque ce PNJ sera trouvé."
	AL["FILTER_ZONE"] = "Zone"
	AL["FILTER_ZONE_DESC"] = "Zone à l'intérieur du continent ou de la catégorie"
	AL["FILTER_ZONES_LIST"] = "Liste des zones"
	AL["FILTER_ZONES_LIST_DESC"] = "Active les alertes dans cette zone. Lorsque cette option est désactivée, vous ne recevrez pas d'alerte lorsqu'un PNJ, un événement ou un trésor rare est trouvé dans la zone."
	AL["FILTER_ZONES_ONLY_MAP"] = "Active les filtres uniquement sur la carte du monde"
	AL["FILTER_ZONES_ONLY_MAP_DESC"] = "Lorsque cette fonction est activée, vous recevrez toujours des alertes de PNJ appartenant à des zones filtrées, mais elles n'apparaîtront pas sur votre carte du monde. Lorsque cette option est désactivée, vous ne recevrez pas du tout d'alertes des PNJs qui appartiennent à des zones filtrées."
	AL["FILTERS"] = "Filtres des PNJ rares"
	AL["FILTERS_SEARCH"] = "Recherche"
	AL["FILTERS_SEARCH_DESC"] = "Tapez le nom du PNJ pour filtrer la liste ci-dessous"
	AL["GENERAL_OPTIONS"] = "Options générales"
	AL["JUST_SPAWNED"] = "%s vient d’apparaître. Visible sur votre mini-carte !"
	AL["LEFT_BUTTON"] = "Clic gauche"
	AL["LOG_WINDOW_AUTOHIDE"] = "Cacher automatiquement les boutons des PNJ enregistrés"
	AL["LOG_WINDOW_AUTOHIDE_DESC"] = "Cache chaque bouton du PNJ après le temps sélectionné (en minutes). Si vous sélectionnez zéro minute, les boutons resteront jusqu'à ce que vous fermiez la fenêtre du journal, ou qu'elle atteigne le nombre maximum du boutons (dans ce cas, le plus ancien sera remplacé)."
	AL["LOG_WINDOW_OPTIONS"] = "Options de la fenêtre du journal"
	AL["LOOT_CATEGORY_FILTERED"] = "Filtre activé pour la catégorie/sous-catégorie : %s/%s. Vous pouvez désactiver ce filtre en cliquant à nouveau sur l'icône du butin ou dans le menu de l'addon RareScanner"
	AL["LOOT_CATEGORY_FILTERS"] = "Filtres par catégorie"
	AL["LOOT_CATEGORY_FILTERS_DESC"] = "Filtre le butin par catégorie"
	AL["LOOT_CATEGORY_NOT_FILTERED"] = "Filtre désactivé pour la catégorie/sous-catégorie: %s/%s"
	AL["LOOT_DISPLAY_OPTIONS"] = "Options d'affichage"
	AL["LOOT_DISPLAY_OPTIONS_DESC"] = "Options d'affichage pour la barre de butin"
	AL["LOOT_FILTER_COLLECTED"] = "Filtre les animaux domestiques, les montures et les jouets collectés."
	AL["LOOT_FILTER_COLLECTED_DESC"] = "Lorsqu'ils sont activés, seuls les montures, les animaux de compagnie et les jouets que vous n'avez pas encore collectés seront affichés sur la barre du butin. Ce filtre n'affecte pas les autres types d'objets à piller, quels qu'ils soient."
	AL["LOOT_FILTER_COMPLETED_QUEST"] = "Filtre les éléments de quête qui ne permettent pas de commencer une nouvelle quête"
	AL["LOOT_FILTER_COMPLETED_QUEST_DESC"] = "Lorsqu'il est activé, tout objet qui est nécessaire à une quête, ou qui commence une quête déjà terminée, n'apparaîtra pas sur la barre de butin"
	AL["LOOT_FILTER_NOT_EQUIPABLE"] = "Filtre les éléments non équipables"
	AL["LOOT_FILTER_NOT_EQUIPABLE_DESC"] = "Lorsqu'ils sont activés, les armures et les armes que ce personnage ne peut pas porter n'apparaîtront pas sur la barre de butin. Ce filtre n'affecte pas les autres types d'objets à piller, quels qu'ils soient."
	AL["LOOT_FILTER_NOT_MATCHING_CLASS"] = "Filtre les éléments qui nécessitent une classe différente de la vôtre"
	AL["LOOT_FILTER_NOT_MATCHING_CLASS_DESC"] = "Une fois activé, tout objet nécessitant l'utilisation d'une classe spécifique qui ne correspond pas à la vôtre, n'apparaîtra pas sur la barre de butin."
	AL["LOOT_FILTER_NOT_TRANSMOG"] = "Afficher que les armures et les armes transmogrifiable"
	AL["LOOT_FILTER_NOT_TRANSMOG_DESC"] = "Lorsqu'elles sont activées, seules les armures et les armes que vous n'avez pas encore collectées seront affichées sur la barre de butin. Ce filtre n'affecte pas les autres types d'objets à piller, quels qu'ils soient."
	AL["LOOT_FILTER_SUBCATEGORY_DESC"] = "Afficher ce type de butin sur la barre du butin. Lorsque cette option est désactivée, vous ne verrez aucun objet correspondant à cette catégorie sur le butin affiché lorsque vous trouvez un PNJ rare"
	AL["LOOT_FILTER_SUBCATEGORY_LIST"] = "Sous-catégories"
	AL["LOOT_ITEMS_PER_ROW"] = "Nombre d'articles à afficher par ligne"
	AL["LOOT_ITEMS_PER_ROW_DESC"] = "Définit le nombre d'articles à afficher par ligne sur la barre de butin. Si le nombre est inférieur au maximum, plusieurs lignes seront affichées."
	AL["LOOT_MAIN_CATEGORY"] = "Catégorie principale"
	AL["LOOT_MAX_ITEMS"] = "Nombre d'objets à afficher"
	AL["LOOT_MAX_ITEMS_DESC"] = "Règle le nombre d'objets maximum à afficher dans la barre de butin"
	AL["LOOT_MIN_QUALITY"] = "Qualité minimale du butin"
	AL["LOOT_MIN_QUALITY_DESC"] = "Définit la qualité minimale du butin à afficher dans la barre de butin"
	AL["LOOT_OPTIONS"] = "Options du butin"
	AL["LOOT_OTHER_FILTERS"] = "Autres filtres"
	AL["LOOT_OTHER_FILTERS_DESC"] = "Autres filtres"
	AL["LOOT_PANEL_OPTIONS"] = "Options de la barre du butin"
	AL["LOOT_SUBCATEGORY_FILTERS"] = "Filtres de sous-catégories"
	AL["LOOT_TOGGLE_FILTER"] = "Alt-Clic-gauche pour activer les filtres"
	AL["LOOT_TOOLTIP_POSITION"] = "Position de l'info-bulle du butin"
	AL["LOOT_TOOLTIP_POSITION_DESC"] = "Définit où afficher l'infobulle du butin qui apparaît lorsque vous passez la souris sur une icône, par rapport au bouton"
	AL["MAIN_BUTTON_OPTIONS"] = "Options du bouton principal"
	AL["MAP_MENU_DISABLE_LAST_SEEN_CONTAINER_FILTER"] = "Affiche les conteneurs que vous avez vus il y a longtemps mais qui ne peuvent se reproduire"
	AL["MAP_MENU_DISABLE_LAST_SEEN_EVENT_FILTER"] = "Affiche les événements que vous avez vus il y a longtemps mais qui peuvent se reproduire"
	AL["MAP_MENU_DISABLE_LAST_SEEN_FILTER"] = "Affiche les PNJ rares que vous avez déjà vus il y a longtemps mais qui peuvent revenir"
	AL["MAP_MENU_SHOW_CONTAINERS"] = "Affiche les icônes des conteneurs sur la carte"
	AL["MAP_MENU_SHOW_EVENTS"] = "Affiche les icônes des événements sur la carte"
	AL["MAP_MENU_SHOW_NOT_DISCOVERED"] = "Entités non découvertes"
	AL["MAP_MENU_SHOW_NOT_DISCOVERED_OLD"] = "Entités non découvertes (anciennes extensions)"
	AL["MAP_MENU_SHOW_RARE_NPCS"] = "Afficher les icônes rares des PNJ sur la carte"
	AL["MAP_NEVER"] = "Jamais"
	AL["MAP_OPTIONS"] = "Options de la carte"
	AL["MAP_SCALE_ICONS"] = "Échelle des icônes"
	AL["MAP_SCALE_ICONS_DESC"] = "Cela permettra d'ajuster l'échelle des icônes, soit la valeur 1 de la taille originale."
	AL["MAP_SHOW_ICON_AFTER_COLLECTED"] = "Continu à afficher les icônes des conteneurs après le pillage"
	AL["MAP_SHOW_ICON_AFTER_COLLECTED_DESC"] = "Lorsqu'elle est désactivée, l'icône disparaîtra après le pillage du conteneur."
	AL["MAP_SHOW_ICON_AFTER_COMPLETED"] = "Continu à afficher les icônes des événements après leur achèvement"
	AL["MAP_SHOW_ICON_AFTER_COMPLETED_DESC"] = "Lorsqu'elle est désactivée, l'icône disparaît une fois que vous avez terminé l'événement."
	AL["MAP_SHOW_ICON_AFTER_DEAD"] = "Continu à afficher les icônes du PNJ après la mort"
	AL["MAP_SHOW_ICON_AFTER_DEAD_DESC"] = "Lorsqu'elle est désactivée, l'icône disparaîtra après avoir tué le PNJ. L'icône réapparaîtra dès que vous retrouverez le PNJ. Cette option ne fonctionne qu'avec les PNJ qui restent rares après avoir été tués."
	AL["MAP_SHOW_ICON_AFTER_DEAD_RESETEABLE"] = "Continu à afficher les icônes des PNJ après la mort (uniquement dans les zones réinitialisables)"
	AL["MAP_SHOW_ICON_AFTER_DEAD_RESETEABLE_DESC"] = "Lorsqu'elle est désactivée, l'icône disparaîtra après que vous aurez tué le PNJ. L'icône réapparaîtra dès que vous retrouverez le PNJ. Cette option ne fonctionne qu'avec les PNJ qui restent rares après avoir été tués dans des zones qui se réinitialisent avec les quêtes mondiales."
	AL["MAP_SHOW_ICON_CONTAINER_MAX_SEEN_TIME"] = "Minuteur pour cacher les icônes des conteneurs (en minutes)"
	AL["MAP_SHOW_ICON_CONTAINER_MAX_SEEN_TIME_DESC"] = "Définis le nombre maximum de minutes écoulées depuis que vous avez vu le conteneur. Après ce délai, l'icône ne sera pas affichée sur la carte du monde tant que vous n'aurez pas retrouvé le conteneur. Si vous sélectionnez zéro minute, les icônes s'afficheront, quel que soit le temps écoulé depuis que vous avez vu le conteneur. Ce filtre ne s'applique pas aux conteneurs qui font partie d'une réalisation."
	AL["MAP_SHOW_ICON_EVENT_MAX_SEEN_TIME"] = "Minuteur pour cacher les icônes des événements (en minutes)"
	AL["MAP_SHOW_ICON_EVENT_MAX_SEEN_TIME_DESC"] = "Définis le nombre maximum de minutes écoulées depuis que vous avez vu l'événement. Après ce délai, l'icône ne sera pas affichée sur la carte du monde tant que vous n'aurez pas retrouvé l'événement. Si vous sélectionnez zéro minute, les icônes s'afficheront quel que soit le temps écoulé depuis que vous avez vu l'événement."
	AL["MAP_SHOW_ICON_MAX_SEEN_TIME"] = "Minuterie pour cacher les icônes rares des PNJ (en minutes)"
	AL["MAP_SHOW_ICON_MAX_SEEN_TIME_DESC"] = "Définis le nombre maximum de minutes écoulées depuis que vous avez vu le NPC. Après ce délai, l'icône ne sera pas affichée sur la carte du monde tant que vous n'aurez pas retrouvé le PNJ. Si vous sélectionnez zéro minute, les icônes s'afficheront quel que soit le temps écoulé depuis que vous avez vu le PNJ rare."
	AL["MAP_TOOLTIP_ACHIEVEMENT"] = "C'est un objectif de Hauts faits %s"
	AL["MAP_TOOLTIP_ALREADY_COMPLETED"] = "Cet événement est déjà terminé. Redémarre dans : %s "
	AL["MAP_TOOLTIP_ALREADY_KILLED"] = "Ce PNJ est déjà mort. Redémarre dans : %s"
	AL["MAP_TOOLTIP_ALREADY_OPENED"] = "Ce conteneur est déjà ouvert. Redémarre dans : %s"
	AL["MAP_TOOLTIP_CONTAINER_LOOTED"] = "Shift-Clic-Gauche pour définir comme pillé."
	AL["MAP_TOOLTIP_DAYS"] = "jours"
	AL["MAP_TOOLTIP_EVENT_DONE"] = "Shift-Clic-Gauche pour définir comme terminé"
	AL["MAP_TOOLTIP_IGNORE_ICON"] = "Shift-Clic-Gauche pour désactiver cette icône pour toujours si elle ne devrait pas être là"
	AL["MAP_TOOLTIP_KILLED"] = "Shift-Clic-Gauche pour définir comme tué"
	AL["MAP_TOOLTIP_NOT_FOUND"] = "Vous n'avez pas encore vu ce PNJ et personne ne l'a encore partagé avec vous."
	AL["MAP_TOOLTIP_SEEN"] = "Vu précédemment : %s"
	AL["MAP_TOOLTIP_SHOW_OVERLAY"] = "Cliquez sur le bouton gauche de la souris pour indiquer les autres zones de spot "
	AL["MARKER"] = "Marqueur de cible"
	AL["MARKER_DESC"] = "Choisissez le marqueur à ajouter au dessus de la cible lorsque vous cliquez sur le bouton principal."
	AL["MESSAGE_OPTIONS"] = "Options de messages"
	AL["MIDDLE_BUTTON"] = "Cliquez sur le bouton du milieu"
	AL["NAVIGATION_ENABLE"] = "Active la navigation"
	AL["NAVIGATION_ENABLE_DESC"] = "Lorsqu'elles sont activées, les flèches de navigation s'affichent à côté du bouton principal pour vous permettre d'accéder aux nouvelles ou anciennes créatures trouvées"
	AL["NAVIGATION_LOCK_ENTITY"] = "Bloquer l'affichage de nouvelles créatures si elle est déjà affichée"
	AL["NAVIGATION_LOCK_ENTITY_DESC"] = "Lorsqu'il est activé, si le bouton principal affiche une entité sur votre écran, il ne se mettra pas automatiquement à jour. Une flèche apparaîtra vous permettant d'accéder à la nouvelle créature lorsque vous serez prêt"
	AL["NAVIGATION_OPTIONS"] = "Options de navigation"
	AL["NAVIGATION_SHOW_NEXT"] = "Afficher la prochaine créature trouvée"
	AL["NAVIGATION_SHOW_PREVIOUS"] = "Afficher la créature précédente trouvée"
	AL["NOT_TARGETEABLE"] = "Non ciblable"
	AL["NOTE_10263"] = "Le [Démoniste du Bouclier balafré] ouvre de temps en temps un portail d'où le PNJ rare peut être invoqué"
	AL["NOTE_130350"] = "Vous devez chevaucher ce rare jusqu'au conteneur que vous trouverez en suivant le chemin à droite de cette position."
	AL["NOTE_131453"] = "Vous devez monter [Gardien de la source] à cette position. Le cheval est d'une rareté amicale que vous trouverez en suivant le chemin à gauche de ce conteneur."
	AL["NOTE_135497"] = "Disponible uniquement dans le cadre de la quête quotidienne [Nordrassil à la rescousse] obtenue auprès de Mylune. Pendant cette quête, vous trouverez des champignons sous les arbres. En cliquant dessus, vous pourrez peut-être faire naître ce PNJ."
	AL["NOTE_149847"] = "Quand vous vous approchez, il vous dit une couleur qu'il déteste. Une fois que vous savez de quelle couleur il s'agit, vous devez vous rendre aux coordonnées 63.41 pour choisir cette couleur. Lorsque vous reviendrez à sa position, il vous attaquera."
	AL["NOTE_150342"] = "Disponible uniquement pendant l'événement  [Foreuse DR-TR35]."
	AL["NOTE_150394"] = "Pour le tuer, vous devez l'amener aux coordonnées 63.38, où se trouve un appareil avec un éclair bleu. Une fois que le PNJ sera touché par la foudre, il explosera et vous pourrez le piller"
	AL["NOTE_151124"] = "Vous devez piller un [Relais de transport démoli] sur des ennemis qui apparaissent pendant l'événement [Foreuse DR-JD99] (coordonnées 59.67) et ensuite l'utiliser sur la machine qui se trouve sur la plate-forme."
	AL["NOTE_151159"] = "Il n'est disponible que lorsque [Orguignard Odipnoticus] se trouve à Mechagon (coordonnées 72.37). Il se promène dans Mechagon, alors vérifiez chaque rue. Si vous le tuez, [Flipflop-OOX/MG] pourra apparaîtrer."
	AL["NOTE_151202"] = "Pour l'invoquer, vous devez connecter les [Fils] sur la rive, avec les [Pylônes] à l'intérieur de l'eau."
	AL["NOTE_151296"] = "Vérifiez d'abord si [Orguignard Odipnoticus] se trouve à Mechagon (coordonnées 72.37). S'il s'y trouve, vous devez trouver et tuer [Flipflop-OOX/MG] (c'est un robot-poulet qui se promène dans Mechagon). Une fois que vous l'avez trouvé et que vous l'avez tué, revenez aux coordonnées de cette icône."
	AL["NOTE_151308"] = "Disponible uniquement lors des événements [Foreuse]."
	AL["NOTE_151569"] = "Il vous faut un [Appât des cent lieues] pour l'invoquer"
	AL["NOTE_151627"] = "Vous devez utiliser un [Bobine évaporatrice exothermique] sur la machine qui se trouve sur la plate-forme."
	AL["NOTE_151933"] = "Pour le tuer, vous devez utiliser le [Bloc d’alimentation de robot-bête] (vous pouvez obtenir le schéma aux coordonnées 60.41)."
	AL["NOTE_152007"] = "Il erre dans cette zone, de sorte que les coordonnées peuvent ne pas être très précises."
	AL["NOTE_152113"] = "Disponible uniquement pendant l'événement [Foreuse DR-CC88]."
	AL["NOTE_152569"] = "Quand vous l'approchez, il vous dit une couleur qu'il déteste. Une fois que vous savez de quelle couleur il s'agit, vous devez vous rendre aux coordonnées 63.41 où l'on vous peindra cette couleur. Lorsque vous reviendrez à sa position, il vous attaquera."
	AL["NOTE_152570"] = "Quand vous l'approchez, il vous dit une couleur qu'il déteste. Une fois que vous savez de quelle couleur il s'agit, vous devez vous rendre aux coordonnées 63.41 où l'on vous peindra cette couleur. Lorsque vous reviendrez à sa position, il vous attaquera."
	AL["NOTE_153000"] = "Disponible uniquement lorsque la quête quotidienne [Insectes à foison] est active."
	AL["NOTE_153200"] = "Disponible uniquement pendant l'événement [Foreuse DR-JD41]."
	AL["NOTE_153205"] = "Disponible uniquement pendant l'événement [Foreuse DR-JD99]. "
	AL["NOTE_153206"] = "Disponible uniquement pendant l'événement [Foreuse DR-TR28]. "
	AL["NOTE_153228"] = "Il apparaît après avoir tué un grand nombre de [Factionnaire amélioré] qui se trouve dans la région."
	AL["NOTE_154225"] = "Il n'est disponible que sur l'interface à laquelle vous pouvez accéder en utilisant [Déplaceur temporel personnel] que vous pouvez créer avec les ressources collectées dans Mechagon. Important : il ne se reproduira pas tant que la quête quotidienne de Chromie sera disponible."
	AL["NOTE_154332"] = "Il est dans une grotte. L'entrée est située aux coordonnées 57,38."
	AL["NOTE_154333"] = "Il est dans une grotte. L'entrée est située aux coordonnées 57,38."
	AL["NOTE_154342"] = "Il est disponible uniquement sur l'interface à laquelle vous pouvez accéder en utilisant [Déplaceur temporel personnel] que vous pouvez créer avec les ressources collectées dans Mechagon."
	AL["NOTE_154559"] = "Il est dans une grotte. L'entrée est située aux coordonnées 70,58."
	AL["NOTE_154604"] = "Il est dans une grotte. L'entrée est située aux coordonnées 36,20."
	AL["NOTE_154701"] = "Disponible uniquement pendant l'événement [Foreuse DR-CC61]."
	AL["NOTE_154739"] = "Disponible uniquement pendant l'événement [Foreuse DR-CC73]."
	AL["NOTE_155531"] = "Vous devez utiliser l'orbe au-dessus de lui (Essence du Soleil) pour obtenir [Aura du Soleil] et être capable de l'attaquer."
	AL["NOTE_156709"] = "Vous devez tuer Spoliateur sans-visage (PNJ normal) pour forcer celui-ci à apparaître."
	AL["NOTE_157162"] = "A l'intérieur du temple. L'entrée est située aux coordonnées 22,24."
	AL["NOTE_158531"] = "Vous devez tuer Neferset déformé par le Vide (PNJ normal) pour forcer celui-ci à apparaître."
	AL["NOTE_158632"] = "Vous devez tuer Bête de chair gargouillante (PNJ normal) pour forcer celui-ci à apparaître."
	AL["NOTE_158706"] = "Il faut tuer la Putréfaction suintante (PNJ normale) pour forcer celle-ci à apparaître."
	AL["NOTE_159087"] = "Il faut tuer Gratte-les-os de N'Zoth (PNJ normal) pour forcer celui-ci à apparaître."
	AL["NOTE_160968"] = "A l'intérieur du temple. L'entrée est située aux coordonnées 22,24."
	AL["NOTE_162171"] = "Il est dans une grotte. L'entrée est située aux coordonnées 45,58."
	AL["NOTE_162352"] = "Il est dans une grotte. L'entrée se trouve sous l'eau aux coordonnées 52,40."
	AL["NOTE_280951"] = "Suivez le chemin de fer jusqu'à ce que vous trouviez une charrette. Conduisez-le pour découvrir le trésor."
	AL["NOTE_287239"] = "Si vous êtes de la horde, vous devez compléter la campagne de Vol'dun pour avoir accès au temple."
	AL["NOTE_289647"] = "Le trésor se trouve dans une grotte. L'entrée se trouve aux coordonnées 65.11, entre quelques arbres presque au sommet de la montagne."
	AL["NOTE_292673"] = "1 sur 5 parchemins. Lisez-les tous pour découvrir le trésor [Secret des profondeurs]. Il se trouve au sous-sol. Cachez cette icône manuellement une fois que vous l'avez lue."
	AL["NOTE_292674"] = "2 sur 5 parchemins. Lisez-les tous pour découvrir le trésor [Secret des profondeurs]. Il se trouve sous le plancher de bois, dans le coin à côté d'un tas de bougies. Cachez cette icône manuellement une fois que vous l'avez lue."
	AL["NOTE_292675"] = "3 sur 5 parchemins. Lisez-les tous pour découvrir le trésor [Secret des profondeurs]. Il se trouve au sous-sol. Cachez cette icône manuellement une fois que vous l'avez lue."
	AL["NOTE_292676"] = "4 sur 5 parchemins. Lisez-les tous pour découvrir le trésor [Secret des profondeurs]. Il se trouve au dernier étage. Cachez cette icône manuellement une fois que vous l'avez lue."
	AL["NOTE_292677"] = "5 parchemins sur 5. Lisez-les tous pour découvrir le trésor [Secret des profondeurs]. Il se trouve dans une grotte souterraine. L'entrée est sous l'eau aux coordonnées 72.40 (bassin d'eau du monastère). Cachez cette icône manuellement une fois que vous l'aurez lue."
	AL["NOTE_292686"] = "Après avoir lu les 5 parchemins, utilisez l'[Autel menaçant] pour obtenir le [Secret des profondeurs]. Attention : L'utilisation de l'autel vous téléportera au milieu de la mer. Cachez cette icône manuellement une fois que vous l'avez utilisée."
	AL["NOTE_293349"] = "Il se trouve à l'intérieur du hangar, sur une étagère."
	AL["NOTE_293350"] = "Ce trésor est caché dans une grotte en dessous. Allez aux coordonnées 61.38, et placez la caméra sur le dessus, puis sautez à l'envers par la petite fente au sol et atterrissez sur le rebord."
	AL["NOTE_293852"] = "Vous ne le verrez pas tant que vous n'aurez pas récupéré la [carte au trésor détrempé] des pirates à Port-Liberté"
	AL["NOTE_293880"] = "Vous ne le verrez pas tant que vous n'aurez pas récupéré [Carte au trésor effacée] des pirates à Port-Liberté"
	AL["NOTE_293881"] = "Vous ne le verrez pas tant que vous n'aurez pas récupéré la [Carte au trésor jaunie] des pirates à Port-Liberté"
	AL["NOTE_293884"] = "Vous ne le verrez pas tant que vous n'aurez pas récupéré la [Carte au trésor roussie] des pirates à Port-Liberté"
	AL["NOTE_297828"] = "Les corbeaux qui volent au-dessus de vous ont la clé. Tuez-les."
	AL["NOTE_297891"] = "Vous devez désactiver les runes dans cet ordre : Gauche, bas, haut, droite"
	AL["NOTE_297892"] = "Vous devez désactiver les runes dans cet ordre : Gauche, droite, bas, haut"
	AL["NOTE_297893"] = "Vous devez désactiver les runes dans cet ordre : Droite, Haut, Gauche, Bas"
	AL["NOTE_326395"] = "Vous devez activer le [dispositif Arcanique] qui se trouve sur une table à côté du coffre pour pouvoir commencer le mini-jeu. Pour réussir le jeu, vous devez séparer les trois triangles. Cliquez sur les orbes pour changer leur position."
	AL["NOTE_326396"] = "Vous devez activer le [dispositif arcanique] qui se trouve sur le sol à côté du coffre afin de lancer le mini-jeu. Pour réussir le jeu, vous devez séparer les deux rectangles. Cliquez sur les orbes pour changer leur position."
	AL["NOTE_326397"] = "Vous devez activer le [dispositif arcanique] qui se trouve sur le sol à côté du coffre afin de lancer le mini-jeu. Pour réussir le jeu, vous devez aligner trois runes rouges."
	AL["NOTE_326398"] = "Vous devez activer le [Dispositif arcanique] qui se trouve sur une table à côté du coffre pour pouvoir commencer le mini-jeu. Pour réussir le jeu, vous devez aligner quatre runes cyan."
	AL["NOTE_326399"] = "Il est dans une grotte sous-marine. Vous devez réaliser un mini-jeu dans lequel vous devez tirer les boules de feu avant qu'elles ne touchent les cercles au sol. Chaque fois qu'une boule touche le sol ou que vous utilisez le sort sans toucher une boule, l'énergie diminue, et si elle atteint zéro, vous devez recommencer."
	AL["NOTE_326400"] = "Il est dans une grotte. Vous devez réaliser un mini-jeu dans lequel vous devez tirer les boules de feu avant qu'elles ne touchent les cercles au sol. Chaque fois qu'une boule touche le sol ou que vous utilisez le sort sans toucher une boule, l'énergie diminue, et si elle atteint zéro, vous devez recommencer."
	AL["NOTE_326403"] = "Il est à l'intérieur du bâtiment. Vous devez y accéder par l'arrière."
	AL["NOTE_326405"] = "Elle se trouve entre les quelques ruines au plus haut niveau de la carte"
	AL["NOTE_326406"] = "Il se trouve au sommet d'une montagne au plus haut niveau de la carte. Il est difficile de s'y rendre à pied, mais c'est possible depuis le côté sud."
	AL["NOTE_326407"] = "Il se trouve au sommet d'une montagne au plus haut niveau de la carte."
	AL["NOTE_326408"] = "Il se trouve dans une grotte sous-marine. L'entrée se trouve dans le lac au sud (coordonnées 57,39)."
	AL["NOTE_326410"] = "Il se trouve dans une grotte au niveau inférieur de la carte."
	AL["NOTE_326411"] = "Elle se trouve entre quelques pierres au niveau le plus élevé de la carte"
	AL["NOTE_326413"] = "Il se trouve dans une grotte au niveau inférieur de la carte."
	AL["NOTE_326415"] = "Il faut voler ou alors utiliser un [kit de planeur gobelin] en haut de la montagne à côté. Le coffre se trouve au sommet du pont de corail."
	AL["NOTE_326416"] = "Il se trouve au plus haut niveau de la carte, à l'intérieur d'une tour en ruine."
	AL["NOTE_329783"] = "Il se trouve sur le toit (accès aux coordonnées 83.33). Vous devez terminer un mini-jeu où vous devez tirer sur les boules de feu avant qu'elles ne touchent les cercles au sol. Chaque fois qu'une boule touche le sol ou que vous utilisez le sort sans toucher une boule, l'énergie diminue, et si elle atteint zéro, vous devez recommencer."
	AL["NOTE_332220"] = "Vous devez terminer un mini-jeu où vous devez tirer sur les boules de feu avant qu'elles ne touchent les cercles au sol. Chaque fois qu'une boule touche le sol ou que vous utilisez le sort sans toucher une boule, l'énergie diminue, et si elle atteint zéro, vous devez recommencer."
	AL["PROFILES"] = "Profils"
	AL["RAIDS"] = "Raids"
	AL["RESET_POSITION"] = "Réinitialise la position"
	AL["RESET_POSITION_DESC"] = "Rétablis la position initiale du bouton principal."
	AL["SHOW_CHAT_ALERT"] = "Affiche les alertes du chat"
	AL["SHOW_CHAT_ALERT_DESC"] = "Affiche un message privé dans le chat à chaque apparition d'un trésor, coffre ou PNJ."
	AL["SHOW_RAID_WARNING"] = "Active les avertissements de raid"
	AL["SHOW_RAID_WARNING_DESC"] = "Affiche un avertissement de raid sur votre écran chaque fois qu'un trésor, un coffre ou un PNJ est trouvé"
	AL["SOUND"] = "Son"
	AL["SOUND_OPTIONS"] = "Options audio"
	AL["SOUND_VOLUME"] = "Volume"
	AL["SOUND_VOLUME_DESC"] = "Règle le niveau du volume sonore"
	AL["SYNCRONIZATION_COMPLETED"] = "Syncronisation terminée"
	AL["SYNCRONIZE"] = "Synchronisation de la base de données."
	AL["SYNCRONIZE_DESC"] = "Cela vous permettra d'analyser les PNJs rares et les trésors qui font partie d'une réussite que vous avez déjà tuée/collectés, et ils disparaîtront de votre carte. Il n'y a aucun moyen de connaître l'état des PNJs et des trésors rares qui ne font pas partie d'une réussite, donc ils resteront dans votre carte tels qu'ils sont actuellement affichés."
	AL["TEST"] = "Lancement du test"
	AL["TEST_DESC"] = "Appuyez sur le bouton pour afficher un exemple d'alerte. Vous pouvez faire glisser le panneau jusqu'à une autre position où il sera désormais affiché."
	AL["TOC_NOTES"] = "Minimap scanner. Vous avertit visuellement grâce à un bouton et une miniature et émet un son chaque fois qu'un PNJ, un trésor ou un événement rare apparaît dans votre minimap"
	AL["TOGGLE_FILTERS"] = "Active les filtres"
	AL["TOGGLE_FILTERS_DESC"] = "Activer tous les filtres à la fois"
	AL["TOOLTIP_BOTTOM"] = "Côté bas"
	AL["TOOLTIP_CURSOR"] = "Suivi du curseur"
	AL["TOOLTIP_LEFT"] = "Côté gauche"
	AL["TOOLTIP_RIGHT"] = "Côté droit"
	AL["TOOLTIP_TOP"] = "Côté haute"
	AL["UNKNOWN"] = "Inconnu"
	AL["UNKNOWN_TARGET"] = "Cible inconnue"
	AL["ZONES_FILTER"] = "Filtres de zone"
	AL["ZONES_FILTERS_SEARCH_DESC"] = "Tapez le nom de la zone pour filtrer la liste ci-dessous"

	-- CONTINENT names
	AL["ZONES_CONTINENT_LIST"] = {
		[9999] = "Class Halls"; --Class Halls
		[9998] = "Île de Sombrelune"; --Darkmoon Island
		[9997] = "Dungeons/Scenarios"; --Dungeons/Scenarios
		[9996] = "Raids"; --Raids
		[9995] = "Unknown"; --Unknown
	}
end