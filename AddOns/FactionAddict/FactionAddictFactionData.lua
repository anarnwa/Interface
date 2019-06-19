-----------------------------------------------------------------------------
--  Faction Addict Data - FactionAddictFactionData.lua
--
--  This file is used to contain basic info about each faction. Including an
--  icon, alliance/horde, faction id, category and type.
--
--  (c) 2011-2019 gmz323(Greg)
-----------------------------------------------------------------------------


-- Localized Strings
local L = FactionAddictLocalization;

faFactionDataRow = {};
faFactionDataRow[1037] = 1;
faFactionDataRow[1106] = 2;
faFactionDataRow[529]  = 3;
faFactionDataRow[1012] = 4;
faFactionDataRow[1204] = 5;
faFactionDataRow[1177] = 6;
faFactionDataRow[1133] = 7;
faFactionDataRow[87]   = 8;
faFactionDataRow[21]   = 9;
faFactionDataRow[910]  = 10;
faFactionDataRow[609]  = 11;
faFactionDataRow[942]  = 12;
faFactionDataRow[909]  = 13;
faFactionDataRow[530]  = 14;
faFactionDataRow[69]  = 15;
faFactionDataRow[1172]  = 16;
faFactionDataRow[577]  = 17;
faFactionDataRow[930]  = 18;
faFactionDataRow[1068]  = 19;
faFactionDataRow[1104]  = 20;
faFactionDataRow[729]  = 21;
faFactionDataRow[369]  = 22;
faFactionDataRow[92]  = 23;
faFactionDataRow[1134]  = 24;
faFactionDataRow[54]  = 25;
faFactionDataRow[1158]  = 26;
faFactionDataRow[1168]  = 27;
faFactionDataRow[1178]  = 28;
faFactionDataRow[946]  = 29;
faFactionDataRow[1052]  = 30;
faFactionDataRow[749]  = 31;
faFactionDataRow[47]  = 32;
faFactionDataRow[989]  = 33;
faFactionDataRow[1090]  = 34;
faFactionDataRow[1098]  = 35;
faFactionDataRow[978]  = 36;
faFactionDataRow[1011]  = 37;
faFactionDataRow[93]  = 38;
faFactionDataRow[1015]  = 39;
faFactionDataRow[1038]  = 40;
faFactionDataRow[76]  = 41;
faFactionDataRow[1173]  = 42;
faFactionDataRow[470]  = 43;
faFactionDataRow[349]  = 44;
faFactionDataRow[1031]  = 45;
faFactionDataRow[1077]  = 46;
faFactionDataRow[809]  = 47;
faFactionDataRow[911]  = 48;
faFactionDataRow[890]  = 49;
faFactionDataRow[970]  = 50;
faFactionDataRow[730]  = 51;
faFactionDataRow[72]  = 52;
faFactionDataRow[70]  = 53;
faFactionDataRow[932]  = 54;
faFactionDataRow[1156]  = 55;
faFactionDataRow[933]  = 56;
faFactionDataRow[510]  = 57;
faFactionDataRow[1135]  = 58;
faFactionDataRow[1126]  = 59;
faFactionDataRow[1067]  = 60;
faFactionDataRow[1073]  = 61;
faFactionDataRow[509]  = 62;
faFactionDataRow[941]  = 63;
faFactionDataRow[1105]  = 64;
faFactionDataRow[990]  = 65;
faFactionDataRow[934]  = 66;
faFactionDataRow[935]  = 67;
faFactionDataRow[1094]  = 68;
faFactionDataRow[1119]  = 69;
faFactionDataRow[1124]  = 70;
faFactionDataRow[1064]  = 71;
faFactionDataRow[967]  = 72;
faFactionDataRow[1091]  = 73;
faFactionDataRow[1171]  = 74;
faFactionDataRow[59]  = 75;
faFactionDataRow[947]  = 76;
faFactionDataRow[81]  = 77;
faFactionDataRow[576]  = 78;
faFactionDataRow[922]  = 79;
faFactionDataRow[68]  = 80;
faFactionDataRow[1050]  = 81;
faFactionDataRow[1085]  = 82;
faFactionDataRow[889]  = 83;
faFactionDataRow[1174]  = 84;
faFactionDataRow[589]  = 85;
faFactionDataRow[270]  = 86;
faFactionDataRow[1353]  = 87;
faFactionDataRow[1352]  = 88;
faFactionDataRow[1228]  = 89;
faFactionDataRow[1269]  = 90;
--faFactionDataRow[1243]  = 91;
faFactionDataRow[1271]  = 91;
faFactionDataRow[1242]  = 92;
faFactionDataRow[1270]  = 93;
faFactionDataRow[1216]  = 94;
faFactionDataRow[1302]  = 95;
faFactionDataRow[1341]  = 96;
faFactionDataRow[1359]  = 97;
--faFactionDataRow[1351]  = 99;
faFactionDataRow[1337]  = 98;
faFactionDataRow[1345]  = 99;
faFactionDataRow[1272]  = 100;
faFactionDataRow[1357]  = 101;
faFactionDataRow[1277]  = 102;
faFactionDataRow[1275]  = 103;
faFactionDataRow[1283]  = 104;
faFactionDataRow[1282]  = 105;
faFactionDataRow[1281]  = 106;
faFactionDataRow[1279]  = 107;
faFactionDataRow[1273]  = 108;
faFactionDataRow[1358]  = 109;
faFactionDataRow[1276]  = 110;
faFactionDataRow[1278]  = 111;
faFactionDataRow[1280]  = 112;
faFactionDataRow[1375]  = 113;
faFactionDataRow[1376]  = 114;
-- faFactionDataRow[1416]  = 117;
faFactionDataRow[1387]  = 115;
faFactionDataRow[1388]  = 116;
faFactionDataRow[1435]  = 117;
faFactionDataRow[1492]  = 118;
faFactionDataRow[1740]  = 119;
faFactionDataRow[1515]  = 120;
faFactionDataRow[1735]  = 121;
faFactionDataRow[1731]  = 122;
faFactionDataRow[1738]  = 123;
faFactionDataRow[1733]  = 124;
faFactionDataRow[1445]  = 125;
faFactionDataRow[1716]  = 126;
faFactionDataRow[1712]  = 127;
faFactionDataRow[1714]  = 128;
faFactionDataRow[1715]  = 129;
faFactionDataRow[1713]  = 130;
faFactionDataRow[1718]  = 131;
faFactionDataRow[1717]  = 132;
faFactionDataRow[1708]  = 133;
faFactionDataRow[1741]  = 134;

faFactionDataRow[1710]  = 135;
faFactionDataRow[1520]  = 136;
faFactionDataRow[1732]  = 137;
faFactionDataRow[1711]  = 138;
faFactionDataRow[1737]  = 139;
faFactionDataRow[1736]  = 140;
faFactionDataRow[1739]  = 141;
faFactionDataRow[1681]  = 142;
faFactionDataRow[1682]  = 143;
faFactionDataRow[1690]  = 144;
faFactionDataRow[1691]  = 145;
faFactionDataRow[1847]  = 146;
faFactionDataRow[1849]  = 147;
faFactionDataRow[1848]  = 148;
faFactionDataRow[1850]  = 149;

faFactionDataRow[1900]  = 150;
faFactionDataRow[1883]  = 151;
faFactionDataRow[1815]  = 152;
faFactionDataRow[1828]  = 153;
faFactionDataRow[1947]  = 154;
faFactionDataRow[1888]  = 155;
faFactionDataRow[1989]  = 156;
faFactionDataRow[1984]  = 157;
faFactionDataRow[1859]  = 158;
faFactionDataRow[1894]  = 159;
faFactionDataRow[1948]  = 160;

faFactionDataRow[1975]  = 161;
faFactionDataRow[2018]  = 162;
faFactionDataRow[2045]  = 163;
faFactionDataRow[2097]  = 164;
faFactionDataRow[2098]  = 165;
faFactionDataRow[2099]  = 166;
faFactionDataRow[2100]  = 167;
faFactionDataRow[2101]  = 168;
faFactionDataRow[2102]  = 169;
faFactionDataRow[2135]  = 170;
faFactionDataRow[2165]  = 171;
faFactionDataRow[2170]  = 172;

faFactionDataRow[2159]  = 173;
faFactionDataRow[2164]  = 174;
faFactionDataRow[2233]  = 175;
faFactionDataRow[2264]  = 176;
faFactionDataRow[2265]  = 177;
faFactionDataRow[2120]  = 178;
faFactionDataRow[2161]  = 179;
faFactionDataRow[2160]  = 180;
faFactionDataRow[2162]  = 181;
faFactionDataRow[2156]  = 182;
faFactionDataRow[2157]  = 183;
faFactionDataRow[2163]  = 184;
faFactionDataRow[2158]  = 185;
faFactionDataRow[2111]  = 186;
faFactionDataRow[2103]  = 187;

faFactionData = {
	{1037, "Interface\\ICONS\\spell_misc_hellifrepvphonorholdfavor",
			2,1,14},
	{1106, "Interface\\ICONS\\inv_jewelry_talisman_08",
			2,0,14},
	{529,  "Interface\\ICONS\\inv_jewelry_talisman_07",
			0,0,4},
	{1012, "Interface\\ICONS\\achievement_reputation_ashtonguedeathsworn",
			1,0,13},
	{1204, "Interface\\ICONS\\inv_neck_hyjaldaily_04",
			3,0,3},
	{1177, "Interface\\ICONS\\inv_misc_tabard_baradinwardens",
			3,1,3},
	{1133, "Interface\\ICONS\\inv_misc_tabard_kezan",
			3,2,6},
	{87,   "Interface\\ICONS\\inv_helmet_66",
			0,0,4},
	{21,   "Interface\\ICONS\\inv_helmet_66",
			0,0,11},
	{910,  "Interface\\ICONS\\inv_misc_head_dragon_bronze",
			0,0,4},
	{609,  "Interface\\ICONS\\ability_mount_warhippogryph",
			0,0,4},
	{942,  "Interface\\ICONS\\ability_racial_ultravision",
			1,0,13},
	{909,  "Interface\\ICONS\\inv_misc_ticket_darkmoon_01",
			0,0,4},
	{530,  "Interface\\ICONS\\inv_misc_tournaments_banner_troll",
			0,2,6},
	{69,   "Interface\\ICONS\\inv_misc_tournaments_symbol_nightelf",
			0,1,0},
	{1172, "Interface\\ICONS\\inv_misc_tabard_dragonmawclan",
			3,2,3},
	{577, "Interface\\ICONS\\inv_misc_enggizmos_07",
			0,0,11},
	{930, "Interface\\ICONS\\inv_misc_tournaments_symbol_draenei",
			1,1,0},
	{1068, "Interface\\ICONS\\inv_misc_lantern_01",
			2,1,2}, -- need better icon for explorers league
	{1104, "Interface\\ICONS\\ability_mount_whitedirewolf",
			2,0,10},
	{729, "Interface\\ICONS\\inv_jewelry_frostwolftrinket_05",
			0,2,15},
	{369, "Interface\\ICONS\\inv_misc_enggizmos_12",
			0,0,11}, 
	{92, "Interface\\ICONS\\achievement_zone_desolace",
			0,0,4}, -- need better icon for gelkis clan
	{1134, "Interface\\ICONS\\inv_misc_tabard_gilneas",
			3,1,0},
	{54, "Interface\\ICONS\\inv_misc_tournaments_symbol_gnome",
			0,1,0},
	{1158, "Interface\\ICONS\\inv_misc_tabard_guardiansofhyjal",
			3,0,3},
	{1168, "Interface\\ICONS\\inv_epicguildtabard",
			3,0,5},
	{1178, "Interface\\ICONS\\inv_misc_tabard_hellscream",
			3,2,3},
	{946, "Interface\\ICONS\\inv_misc_token_honorhold",
			1,1,13},
	{1052, "Interface\\ICONS\\spell_misc_hellifrepvpthrallmarfavor",
			2,2,14},
	{749, "Interface\\ICONS\\spell_frost_summonwaterelemental_2",
			0,0,4},
	{47, "Interface\\ICONS\\inv_misc_tournaments_symbol_dwarf",
			0,1,0},
	{989, "Interface\\ICONS\\inv_shirt_guildtabard_01",
			1,0,13}, -- need better icon for keepers of time
	{1090, "Interface\\ICONS\\achievement_reputation_kirintor",
			2,0,14},
	{1098, "Interface\\ICONS\\achievement_reputation_knightsoftheebonblade",
			2,0,14},
	{978, "Interface\\ICONS\\inv_misc_foot_centaur",
			1,1,13},
	{1011, "Interface\\ICONS\\inv_feather_06",
			1,0,9},
	{93, "Interface\\ICONS\\achievement_zone_desolace",
			0,0,4}, -- better icon for Magram Clan
	{1015, "Interface\\ICONS\\ability_mount_netherdrakepurple",
			1,0,13},
	{1038, "Interface\\ICONS\\inv_misc_apexis_crystal",
			1,0,13},
	{76, "Interface\\ICONS\\inv_misc_tournaments_symbol_orc",
			0,2,6},
	{1173, "Interface\\ICONS\\inv_misc_tabard_tolvir",
			3,0,3},
	{470, "Interface\\ICONS\\ability_mage_brainfreeze",
			0,0,11}, -- better icon for ratchet
	{349, "Interface\\ICONS\\ability_rogue_preparation",
			0,0,4},
	{1031, "Interface\\ICONS\\ability_hunter_pet_netherray",
			1,0,9},
	{1077, "Interface\\ICONS\\inv_shield_48",
			1,0,9},
	{809, "Interface\\ICONS\\inv_misc_book_17",
			0,0,4},
	{911, "Interface\\ICONS\\inv_misc_tournaments_symbol_bloodelf",
			1,2,6},
	{890, "Interface\\ICONS\\ability_racial_shadowmeld",
			0,1,1},
	{970, "Interface\\ICONS\\inv_mushroom_11",
			1,0,13},
	{730, "Interface\\ICONS\\inv_jewelry_stormpiketrinket_05",
			0,1,1},
	{72, "Interface\\ICONS\\inv_misc_tournaments_symbol_human",
			0,1,0},
	{70, "Interface\\ICONS\\inv_misc_armorkit_03",
			0,0,12},
	{932, "Interface\\ICONS\\inv_shield_30",
			1,0,9},
	{1156, "Interface\\ICONS\\inv_jewelry_talisman_08",
			2,0,14},
	{933, "Interface\\ICONS\\inv_enchant_shardprismaticlarge",
			1,0,13},
	{510, "Interface\\ICONS\\spell_shadow_psychichorrors",
			0,2,15},
	{1135, "Interface\\ICONS\\inv_misc_tabard_earthenring",
			3,0,3},
	{1126, "Interface\\ICONS\\spell_frost_frostward",
			2,1,2}, -- better icon for frostborn
	{1067, "Interface\\ICONS\\inv_jewelry_trinket_04",
			2,2,7},
	{1073, "Interface\\ICONS\\achievement_reputation_tuskarr",
			2,0,14},
	{509, "Interface\\ICONS\\ability_warrior_rallyingcry",
			0,1,1},
	{941, "Interface\\ICONS\\inv_misc_foot_centaur",
			1,2,13},
	{1105, "Interface\\ICONS\\inv_misc_head_murloc_01",
			2,0,10},
	{990, "Interface\\ICONS\\inv_enchant_dustillusion",
			1,0,13},
	{934, "Interface\\ICONS\\inv_jewelry_ring_36",
			1,0,9},
	{935, "Interface\\ICONS\\inv_shield_30",
			1,0,9},
	{1094, "Interface\\ICONS\\inv_misc_tabardpvp_01",
			2,1,2},
	{1119, "Interface\\ICONS\\ability_mount_mammoth_white",
			2,0,14},
	{1124, "Interface\\ICONS\\inv_misc_tabardpvp_02",
			2,2,7},
	{1064, "Interface\\ICONS\\achievement_character_tauren_male",
			2,2,7},
	{967, "Interface\\ICONS\\spell_holy_mindsooth",
			1,0,13},
	{1091, "Interface\\ICONS\\achievement_reputation_wyrmresttemple",
			2,0,14},
	{1171, "Interface\\ICONS\\inv_misc_tabard_therazane",
			3,0,3},
	{59, "Interface\\ICONS\\spell_nature_earthquake",
			0,0,4}, -- better icon for thorium brotherhood
	{947, "Interface\\ICONS\\inv_misc_token_thrallmar",
			1,2,13},
	{81, "Interface\\ICONS\\inv_misc_tournaments_symbol_tauren",
			0,2,6},
	{576, "Interface\\ICONS\\achievement_reputation_timbermaw",
			0,0,4},
	{922, "Interface\\ICONS\\inv_sword_07",
			1,2,13}, -- better icon for tranquillien
	{68, "Interface\\ICONS\\inv_misc_tournaments_symbol_scourge",
			0,2,6},
	{1050, "Interface\\ICONS\\achievement_reputation_05",
			2,1,2}, -- better icon for valiance expedition
	{1085, "Interface\\ICONS\\inv_bannerpvp_01",
			2,2,7},
	{889, "Interface\\ICONS\\ability_warrior_warcry",
			0,2,15},
	{1174, "Interface\\ICONS\\inv_misc_tabard_wildhammerclan",
			3,1,3},
	{589, "Interface\\ICONS\\ability_mount_pinktiger",
			0,1,8},
	{270, "Interface\\ICONS\\inv_bijou_green",
			0,0,4},
	-- NEW for MOP 
	{1353, "Interface\\ICONS\\inv_misc_tournaments_tabard_human", --++
			4,1,0},
	{1352, "Interface\\ICONS\\inv_misc_tournaments_tabard_orc", --++
			4,2,6},
	{1228, "Interface\\ICONS\\achievement_brewery_4", --++
			4,2,16}, 
	{1269, "Interface\\ICONS\\achievement_faction_goldenlotus",
			4,0,16},
	-- Hozen - not in game
	--{1243, "Interface\\ICONS\\achievement_faction_lorewalkers", 4,0,16},
	{1271, "Interface\\ICONS\\achievement_faction_serpentriders",
			4,0,16},
	{1242, "Interface\\ICONS\\inv_misc_enchantedpearla", --++
			4,1,16},
	{1270, "Interface\\ICONS\\achievement_faction_shadopan",
			4,0,16},
	{1216, "Interface\\ICONS\\inv_staff_08", --++
			4,0,16},
	{1302, "Interface\\ICONS\\achievement_faction_anglers",
			4,0,16},
	{1341, "Interface\\ICONS\\achievement_faction_celestials",
			4,0,16},
	{1359, "Interface\\ICONS\\inv_legendary_theblackprince",
			4,0,16},
	-- The Brewmasters not implemented
	--{1351, "Interface\\ICONS\\spell_monk_brewmastertraining", 4,0,16},
	{1337, "Interface\\ICONS\\achievement_faction_klaxxi",
			4,0,16},
	{1345, "Interface\\ICONS\\inv_misc_tabard_lorewalkers",
			4,0,16},
	{1272, "Interface\\ICONS\\achievement_faction_tillers",
			4,0,16},
	{1357, "Interface\\ICONS\\inv_misc_bag_satchelofcenarius",
			4,0,16}, -- Hidden faction? Nomi - Cooking
	{1277, "Interface\\ICONS\\inv_misc_gift_02", --++
			4,0,16},
	{1275, "Interface\\ICONS\\inv_misc_beer_01",
			4,0,16},
	{1283, "Interface\\ICONS\\inv_misc_food_vendor_carrot",
			4,0,16},
	{1282, "Interface\\ICONS\\inv_misc_boarshead",
			4,0,16},
	{1281, "Interface\\ICONS\\achievement_guildperk_gmail",
			4,0,16},
	{1279, "Interface\\ICONS\\trade_archaeology_trolllizardfootcharm",
			4,0,16},
	{1273, "Interface\\ICONS\\inv_drink_04",
			4,0,16},
	{1358, "Interface\\ICONS\\inv_helmet_50",
			4,0,16},
	{1276, "Interface\\ICONS\\spell_magic_polymorphchicken",
			4,0,16},
	{1278, "Interface\\ICONS\\spell_nature_insectswarm",
			4,0,16},
	{1280, "Interface\\ICONS\\inv_misc_birdbeck_02", --++
			4,0,16},
	-- Added for MOP 5.1 -
	{1375, "Interface\\ICONS\\pvpcurrency-honor-horde",
			4,2,16},
	{1376, "Interface\\ICONS\\pvpcurrency-conquest-alliance",
			4,1,16},
	-- {1416, "Interface\\ICONS\\achievement_reputation_ashtonguedeathsworn", --verify in future patch
	--		4,0,16},
	-- Added for MOP 5.2 -
	{1387, "Interface\\ICONS\\achievement_reputation_kirintor_offensive",
			4,1,16},
	{1388, "Interface\\ICONS\\achievement_faction_sunreaveronslaught", 
			4,2,16},
	{1435, "Interface\\ICONS\\achievement_faction_shadopan_assault",
			4,0,16},
	{1492, "Interface\\ICONS\\ability_monk_quipunch",
			4,0,16},
	-- Added for WOD 6.0 -
	{1740, "Interface\\Garrison\\Portraits\\FollowerPortrait_59874",
			5,2,18},
	{1515, "Interface\\ICONS\\inv_tabard_a_76arakkoaoutcast",
			5,0,17},
	{1735, "Interface\\ICONS\\ability_hanzandfranz_chestbump",
			5,0,17},
	{1731, "Interface\\ICONS\\inv_tabard_a_81exarchs",
			5,1,17},
	{1738, "Interface\\Garrison\\Portraits\\FollowerPortrait_59839",
			5,1,18},
	{1733, "Interface\\Garrison\\Portraits\\FollowerPortrait_59353",
			5,1,18},
	{1445, "Interface\\ICONS\\inv_tabard_a_01frostwolfclan", 
			5,2,17},
	{1716, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1712, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1714, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1715, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1713, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1718, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1717, "Interface\\ICONS\\inv_apexis_draenor", -- not in game?
			5,0,17},
	{1708, "Interface\\ICONS\\inv_tabard_a_80laughingskull",
			5,2,17},
	{1741, "Interface\\Garrison\\Portraits\\FollowerPortrait_61487",
			5,0,18},
	{1710, "Interface\\ICONS\\inv_tabard_a_shataridefense",
			5,1,17},
	{1520, "Interface\\ICONS\\inv_helm_cloth_shadowmoonclan_b_01", 
			5,0,17},
	{1732, "Interface\\ICONS\\inv_misc_bag_15", -- not in game?
			5,0,17},
	{1711, "Interface\\ICONS\\inv_misc_tabard_a_01steamwheedlepreservationsociety",
			5,0,17},
	{1737, "Interface\\Garrison\\Portraits\\FollowerPortrait_59461",
			5,0,18},
	{1736, "Interface\\Garrison\\Portraits\\FollowerPortrait_57173",
			5,0,18},
	{1739, "Interface\\Garrison\\Portraits\\FollowerPortrait_56610", 
			5,2,18},
	{1681, "Interface\\ICONS\\inv_tabard_a_77voljinsspear",
			5,2,17},
	{1682, "Interface\\ICONS\\inv_tabard_a_78wrynnvanguard", 
			5,1,17},
	{1690, "Interface\\ICONS\\warrior_talent_icon_furyintheblood",
			5,2,17},
	{1691, "Interface\\ICONS\\warrior_talent_icon_furyintheblood",
			5,1,17},
	-- New 6.2 Factions
	{1847, "Interface\\ICONS\\inv_guild_standard_alliance_c",
			5,1,17},
	{1849, "Interface\\ICONS\\inv_tabard_a_82awakenedorder",
			5,0,17},
	{1848, "Interface\\ICONS\\inv_guild_standard_horde_c",
			5,2,17},
	{1850, "Interface\\ICONS\\inv_tabard_a_83saberstalkers",
			5,0,17},
	-- New 7.0 Factions
	{1900, "Interface\\ICONS\\inv_tabard_a_91courtfarondis",
			6,0,19},
	{1883, "Interface\\ICONS\\inv_tabard_a_89dreamweaver_green",
			6,0,19},
	{1815, "Interface\\ICONS\\inv_helm_cloth_legionquest100_b_01",
			6,0,19},
	{1828, "Interface\\ICONS\\inv_tabard_a_87hightmountain",
			6,0,19},
	{1947, "Interface\\ICONS\\inv_tabard_a_84illidari",
			6,0,19},
	{1888, "Interface\\ICONS\\inv_misc_head_vrykul", -- no icon
			6,0,19},
	{1989, "Interface\\ICONS\\ability_shaman_freedomwolf", -- no icon
			6,0,19},
	{1984, "Interface\\ICONS\\inv_bracer_74v4", -- no icon
			6,0,19},
	{1859, "Interface\\ICONS\\inv_tabard_a_90nightfallen",
			6,0,19},
	{1894, "Interface\\ICONS\\inv_tabard_a_86warden",
			6,0,19},
	{1948, "Interface\\ICONS\\inv_tabard_a_88valarjar",
			6,0,19},
	{1975, "Interface\\ICONS\\inv_g_fishingbobber_05",
			6,0,19},
	{2018, "Interface\\ICONS\\inv_ability_mount_cockatricemount_white",
			6,0,19},
	{2045, "Interface\\ICONS\\inv_tabard_a_92legionfall",
			6,0,19},
	{2097, "Interface\\ICONS\\achievement_character_nightelf_female",
			6,0,19},
	{2098, "Interface\\ICONS\\ability_druid_improvedtreeform",
			6,0,19},
	{2099, "Interface\\ICONS\\spell_shaman_totemrecall",
			6,0,19},
	{2100, "Interface\\ICONS\\inv_helm_plate_pvppaladin_c_01",
			6,0,19},
	{2101, "Interface\\ICONS\\creatureportrait_darkshoreboat",
			6,0,19},
	{2102, "Interface\\ICONS\\ability_warlock_demonicempowerment",
			6,0,19},
	-- New 7.2.5 Factions
	{2135, "Interface\\ICONS\\achievement_reputation_wyrmresttemple",
			6,0,19},
	-- New 7.3 Factions
	{2165, "Interface\\ICONS\\inv_tabard_a_93armyofthelight",
			6,0,19},
	{2170, "Interface\\ICONS\\inv_tabard_a_94argussianreach",
			6,0,19},
	-- New 8.0 Factions - Battle for Azeroth
	{2159, "Interface\\ICONS\\inv__faction_alliancewareffort",
			7,1,20},
	{2164, "Interface\\ICONS\\inv__faction_championsofazeroth",
			7,0,20},
	{2233, "Interface\\ICONS\\inv_pterrordax2mount_yellow",
			7,2,20}, -- VERIFY side AND icon in future
	{2264, "Interface\\ICONS\\inv_misc_questionmark",
			7,0,20}, -- VERIFY
	{2265, "Interface\\ICONS\\inv_misc_questionmark",
			7,0,20}, -- VERIFY
	{2120, "Interface\\ICONS\\inv_misc_questionmark",
			7,0,20}, -- VERIFY
	{2161, "Interface\\ICONS\\inv__faction_orderofembers",
			7,1,20},
	{2160, "Interface\\ICONS\\inv__faction_proudmooreadmiralty",
			7,1,20},
	{2162, "Interface\\ICONS\\inv__faction_stormswake",
			7,1,20},
	{2156, "Interface\\ICONS\\inv__faction_talanjisexpedition",
			7,2,20},
	{2157, "Interface\\ICONS\\inv__faction_hordewareffort",
			7,2,20},
	{2163, "Interface\\ICONS\\inv__faction_tortollanseekers",
			7,0,20},
	{2158, "Interface\\ICONS\\inv_tabard_vulpera",
			7,2,20},
	{2111, "Interface\\ICONS\\inv_misc_questionmark",
			7,0,20}, -- VERIFY - 
	{2103, "Interface\\ICONS\\inv__faction_zandalariempire",
			7,2,20},
	-- 2370 - Dino Training - Direhorn - Not a "real" faction?
};

local faFactionDataDesc = { -- column descriptions - info only, no need to localize
	{"Faction ID"},
	{"Faction Icon Path"},
	{"Expansion"},
	{"Side"},
	{"Category"},
};
local faFactionDataExpansionValues = { -- column value descriptions - info only, no need to localize
	[0] = "Classic",
	[1] = "The Burning Crusade",
	[2] = "Wrath of the Lich King",
	[3] = "Cataclysm",
	[4] = "Mists of Pandaria",
	[5] = "Warlords of Draenor",
	[6] = "Legion",
	[7] = "Battle for Azeroth"
};
local faFactionDataSideValues = { -- column value descriptions - info only, no need to localize
	[0] = "Both Sides",
	[1] = "Alliance Only",
	[2] = "Horde Only"
};

faFactionDataCategoryValues = { -- displayed in info window - LOCALIZED
	[0]  = L.CATEGORY_ALLIANCE_TXT,
	[1]  = L.CATEGORY_ALLIANCEFORCES_TXT,
	[2]  = L.CATEGORY_ALLIANCEVANGUARD_TXT,
	[3]  = L.CATEGORY_CATACLYSM_TXT,
	[4]  = L.CATEGORY_CLASSIC_TXT,
	[5]  = L.CATEGORY_GUILD_TXT,
	[6]  = L.CATEGORY_HORDE_TXT,
	[7]  = L.CATEGORY_HORDEEXP_TXT,
	[8]  = L.CATEGORY_OTHER_TXT,
	[9]  = L.CATEGORY_SHATTRATH_TXT,
	[10] = L.CATEGORY_SHOLAZAR_TXT,
	[11] = L.CATEGORY_STEAMWHEEDLE_TXT,
	[12] = L.CATEGORY_OTHER_TXT,
	[13] = L.CATEGORY_TBC_TXT,
	[14] = L.CATEGORY_WOTLK_TXT,
	[15] = L.CATEGORY_HORDEFORCES_TXT,
	[16] = L.CATEGORY_MOP_TXT,
	[17] = L.CATEGORY_WOD_TXT,
	[18] = L.CATEGORY_BARRACKSBODYGUARDS_TXT,
	[19] = L.CATEGORY_LEGION_TXT,
	[20] = L.CATEGORY_BFA_TXT
};

faStandingCapsTxt = {
	[1] = "36000",  -- hated
	[2] = "3000",   -- hostile
	[3] = "3000",   -- unfriendly
	[4] = "3000",   -- neutral
	[5] = "6000",   -- friendly
	[6] = "12000",  -- honored
	[7] = "21000",  -- revered
	[8] = "999" 	-- exalted
};

faFactionAddictTooltips = {
	CheckButton_CF = L.CONFIG_TT_CF,
	CheckButton_BC = L.CONFIG_TT_BC,
	CheckButton_WOTLK = L.CONFIG_TT_WOTLK,
	CheckButton_CATA = L.CONFIG_TT_CATA,
	CheckButton_MOP = L.CONFIG_TT_MOP,
	CheckButton_WOD = L.CONFIG_TT_WOD,
	CheckButton_LG = L.CONFIG_TT_LG,
	CheckButton_BFA = L.CONFIG_TT_BFA,
	CheckButton_OrderPct = L.CONFIG_TT_OrderPct,
	CheckButton_OrderName = L.CONFIG_TT_OrderName,
	CheckButton_AO = L.CONFIG_TT_AO,
	CheckButton_HO = L.CONFIG_TT_HO,
	CheckButton_AUTOBAR = L.CONFIG_TT_AUTOBAR,
	CheckButton_HIDEINACTIVE = L.CONFIG_TT_HIDEINACTIVE,
	frameFactionAddictTab1 = L.TAB1_TT,
	frameFactionAddictTab2 = L.TAB2_TT,
	frameFactionAddictTab3 = L.TAB3_TT,
	frameFactionAddictTab4 = L.TAB4_TT,
	FactionAddict_ConfigMenuButton = L.CONFIG_MENU_TT,
	FactionInfo_CheckButton_MoveInactive = L.CHECKBUTTON_TT_SETINACTIVE,
}

-- Values referenced from FrameXML/Constants.lua
--NORMAL_FONT_COLOR_CODE      = "|cffffd200";
--HIGHLIGHT_FONT_COLOR_CODE   = "|cffffffff";
--RED_FONT_COLOR_CODE         = "|cffff2020";
--GREEN_FONT_COLOR_CODE       = "|cff20ff20";
--GRAY_FONT_COLOR_CODE        = "|cff808080";
--YELLOW_FONT_COLOR_CODE      = "|cffffff00";
--LIGHTYELLOW_FONT_COLOR_CODE = "|cffffff9a";
--ORANGE_FONT_COLOR_CODE      = "|cffff7f3f";
--ACHIEVEMENT_COLOR_CODE      = "|cffffff00";
--FONT_COLOR_CODE_CLOSE       = "|r";

-- Unknown Icon - question mark
-- inv_misc_questionmark

-- Not in game
-- 2010 Brawlgar Arena
-- 2011 Bizmos Brawlpub