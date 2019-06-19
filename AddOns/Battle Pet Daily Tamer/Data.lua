--[[
	Data.lua contains the info about dailies (questID, coordinates, etc) and other static tables

	Tables contained in this file:
		tamer.pawInfo, the table that describes each daily type and its option
		tamer.dailyInfo, the main table indexed by questID that contains all data for all questIDs
		tamer.parentIDs, a lookup table of all mapIDs that define a "continent" grouping
		tamer.badParentIDs, a lookup table of mapIDs that require special handling
		tamer.questIDsWithObjectives, a list of questIDs that have objectives (Beasts of Fable)
		tamer.questIDsByParentMapID, a table indexed by parentMapID with all questIDs in that group
]]

local tamer = BattlePetDailyTamer

--[[
	pawInfo describes the paws and the settings that control them, indexed by the daily type
	(1=reward dailies, 2=normal dailies, 3=legendary, 4=WQs used in dailyInfo) and also the
	order that they're displayed in options.
	Note: changing index 1-3 means changing dailyInfo 10th parameter (daily type) too!

	[optionIndex] = {
		[1] = name as it should appear on map options menu/interface options panel
		[2] = name of savedvar key into BattlePetDailyTamerSettings
		[3] = default value of this setting
		[4] = icon
		[5] = red icon color
		[6] = green icon color
		[7] = blue icon color
	}
]]
tamer.pawInfo = {
	{"Reward Dailies","TrackSatchels",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.5,1.0,0.25},
	{"Normal Dailies","TrackNonSatchels",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.5,0.85,1.0},
	{"Legendary","TrackFables",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",1.0,0.5,0},
	{"World Quests","TrackWorldQuests",true,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.5,1.0,0.25},
	{"Inactive Dailies","TrackCompleted",false,"Interface\\AddOns\\Battle Pet Daily Tamer\\paw",0.75,0.75,0.75},
	{"On Azeroth Map","OnAzerothMap",false,"Interface\\Minimap\\Tracking\\Innkeeper",1.0,1.0,1.0},
	--{"On Flight Maps Too","TaxiPaws",false,"Interface\\TaxiFrame\\UI-Taxi-Icon-White",1.0,1.0,1.0},
	--{"Stable Masters","StableMasters",false,"Interface\\Minimap\\Tracking\\Stablemaster",1.0,1.0,1.0},
}

--[[
	dailyInfo describes all dailies. It's indexed by the questID of each daily quest.

	[questID] = {
		[1] = tamer numeric npcID or name of event like "Celestial Tournament"
		[2] = text about daily ("Darkmoon Faire", "Beasts of Fable Book II", etc)
		[3] = parentMapID (the mapID of the "continent" the questIDs are grouped under)
		[4] = instanceID (the fourth return of UnitPosition; though continent-wide ones are okay too)
		[5] = worldY continent-level y coordinate (first return of UnitPosition)
		[6] = worldX continent-level x coordinate (second return of UnitPosition)
		[7] = mapID (uiMapID, zone-level mapID)
		[8] = mapX zone-level x map coordinate (first return of GetPlayerMapPosition)
		[9] = mapY zone-level y map coordinate (second return of GetPlayerMapPosition)
		[10] = daily type, 1=satchel, 2=non-satchel, 3=legendary, 4=world quest (this is an index to tamer.pawInfo above)
		[11] = level of pets for this tamer (1-25)
		[12] = speciesID of tamer's first pet
		[13] = speciesID of tamer's second pet
		[14] = speciesID of tamer's third pet
	}

	Notes:
		When a questID is Number1:Number2, Number1 is the questID and Number2 is the objective number.
		When a questID is Alliance|Horde:Number1, Number1 is a questID shared by both factions. (Only one faction's
			version of those quests survives removal of faction-specific quests; the index will become a number)
		If mapX and mapY are ever removed, keep mapID. It's used to prevent pins underneath world quest pins.
		Any dailyInfo with a **NEEDS PETS** comment needs its speciesID populated
	
]]
tamer.dailyInfo = {
	-- Kalimdor
	[31818] = {66126,nil,12,1,789.60822,-4283.7124,1,0.439,0.289,2,2,889,890}, -- Zunta (Durotar)
	[31819] = {66135,nil,12,1,-223.97717,-3164.97534,10,0.586,0.531,2,3,891,893,892}, -- Dagra the Fierce (Northern Barrens)
	[45083] = {115286,nil,12,1,438.3999,-3451.4001,10,0.636,0.358,1,25,1983,1981,1982}, -- Crysa (Northern Barrens)
	[45539] = {nil,nil,12,1,-798.90002,-2036.5,10,0.39,0.681,1,25,1996}, -- Pet Battle Challenge: Wailing Caverns (Northern Barrens)
	[31854] = {66136,nil,12,1,3539.01025,535.13318,63,0.202,0.295,2,5,894,896,895}, -- Analynn (Ashenvale)
	[31906] = {66452,nil,12,1,-4931.73291,-1836.93311,64,0.319,0.329,2,15,915,917,916}, -- Kela Grimtotem (Thousand Needles)
	[31862] = {66137,nil,12,1,587.8999,379.7832,65,0.597,0.716,2,7,897,899,898}, -- Zonya the Sadist (Stonetalon Mountains)
	[31872] = {66372,nil,12,1,-917.96454,1666.2124,66,0.571,0.457,2,9,901,902,900}, -- Merda Stronghoof (Desolace)
	[31871] = {66352,nil,12,1,-4664.7998,1292.5166,69,0.597,0.496,2,13,906,904,905}, -- Traitor Gluk (Feralas)
	[31905] = {66436,nil,12,1,-4654.83398,-3804.74976,70,0.539,0.749,2,14,913,911,912}, -- Grazzle the Great (Dustwallow Marsh)
	[31907] = {66442,nil,12,1,4949.9165,-627.08313,77,0.4,0.566,2,16,922,923,921}, -- Zoltan (Felwood)
	[31908] = {66412,nil,12,1,7563.29736,-2445.3916,80,0.461,0.603,2,17,924,925,926}, -- Elena Flutterfly (Moonglade)
	[31909] = {66466,nil,12,1,6149.25,-5026.06689,83,0.656,0.645,1,19,928,927,929}, -- Stone Cold Trixxy (Winterspring)
	[31972] = {66819,nil,12,1,5270.01416,-3536.1084,198,0.614,0.327,2,25,982,980,981}, -- Brok (Mount Hyjal)
	[31904] = {66422,nil,12,1,-3704.69141,-1579.1001,199,0.396,0.791,2,11,908,909,907}, -- Cassandra Kaboom (Southern Barrens)
	[31971] = {66824,nil,12,1,-9763.41602,-1063.99585,249,0.566,0.42,1,25,989,991,990}, -- Obalis (Uldum)
	-- Eastern Kingdom
	[31911] = {66512,nil,13,0,2295.9165,-4988.4375,23,0.67,0.524,2,14,935,936,934}, -- Deiza Plaguehorn (Eastern Plaguelands)
	[31910] = {66478,nil,13,0,65.26672,-4000.5,26,0.63,0.546,2,13,932,931,933}, -- David Kosse (The Hinterlands)
	[47895] = {124617,nil,13,0,-5144.8003,825.6,27,0.268,0.369,1,25,2068,2067,2066}, -- Environeer Bert (Dun Morogh)
	[31912] = {66515,nil,13,0,-6512.0376,-1110.54773,32,0.353,0.277,2,15,939,937,938}, -- Kortas Darkhammer (Searing Gorge)
	[31914] = {66520,nil,13,0,-7982.91602,-1268.3645,36,0.255,0.475,2,17,946,945,944}, -- Durin Darkhammer (Burning Steppes)
	[31693] = {64330,nil,13,0,-9876.88867,88.07922,37,0.417,0.837,2,2,873,872}, -- Julia Stevens (Elwynn Forest)
	[31916] = {66522,nil,13,0,-11141.66602,-1835.83325,42,0.401,0.765,1,19,948,949,947}, -- Lydia Accoste (Deadwind Pass)
	[31850] = {65655,nil,13,0,-10519.46582,296.03333,47,0.199,0.446,2,7,881,880,882}, -- Eric Davidson (Duskwood)
	[31781] = {65651,nil,13,0,-9415.3584,-2334.5603,49,0.333,0.526,2,5,878,877,879}, -- Lindsay (Redridge Mountains)
	[31852] = {63194,nil,13,0,-12120.93262,-142.25012,50,0.46,0.404,2,9,885,884,883}, -- Steven Lisbane (Northern Stranglethorn)
	[31913] = {66518,nil,13,0,-10229.67676,-4007.6499,51,0.768,0.415,2,16,941,943,942}, -- Everessa (Swamp of Sorrows)
	[31780] = {65648,nil,13,0,-9831.66699,885.1665,52,0.609,0.185,2,3,875,876,874}, -- Old MacDonald (Westfall)
	[46292] = {nil,nil,13,0,-11059.5,1562.3,52,0.416,0.711,1,25,2023}, -- Pet Battle Challenge: Deadmines (Westfall)
	[31851] = {65656,nil,13,0,-14448.00391,76.22937,210,0.515,0.734,2,11,887,886,888}, -- Bill Buckler (The Cape of Stranglethorn)
	[31974] = {66822,nil,13,0,-4152.5332,-5420.7915,241,0.566,0.568,2,25,987,986,988}, -- Goz Banefury (Twilight Highlands)
	[54186] = {nil,nil,13,0,-5134.1,893.2,27,0.2551,0.3648,1,25,2488}, -- Pet Battle Challenge: Gnomeregan (Dun Morogh)
	-- Outland
	[31922] = {66550,nil,101,530,-216.5188,2218.7561,100,0.643,0.493,2,20,952,951,950}, -- Nicki Tinytech (Hellfire Peninsula)
	[31923] = {66551,nil,101,530,242.61462,8610.3418,102,0.172,0.505,2,21,953,955,954}, -- Ras'an (Zangarmarsh)
	[31926] = {66557,nil,101,530,-3480.58325,2547.5,104,0.305,0.418,1,24,964,963,962}, -- Bloodknight Antari (Shadowmoon Valley)
	[31924] = {66552,nil,101,530,-1777.8999,6925.58301,107,0.61,0.494,2,22,957,958,956}, -- Narrok (Nagrand)
	[31925] = {66553,nil,101,530,-2083.5,5368.2002,111,0.587,0.7,2,23,961,959,960}, -- Morulu The Elder (Shattrath City)
	-- Northrend
	[31933] = {66638,nil,113,571,2691.78101,318.16699,115,0.59,0.771,2,25,973,971,972}, -- Okrut Dragonwaste (Dragonblight)
	[31931] = {66635,nil,113,571,1750.07288,-3127.0249,117,0.286,0.339,2,25,967,966,965}, -- Beegle Blastfuse (Howling Fjord)
	[31935] = {66675,nil,113,571,8607.55762,590.125,118,0.774,0.196,1,25,978,977,979}, -- Major Payne (Icecrown)
	[31934] = {66639,nil,113,571,5444.86621,-1259.17505,121,0.132,0.668,2,25,976,974,975}, -- Gutretch (Zul'Drak)
	[31932] = {66636,nil,113,571,5431.479,79.56885,127,0.501,0.59,2,25,968,970,969}, -- Nearly Headless Jacob (Crystalsong Forest)
	-- Maelstrom
	[31973] = {66815,nil,207,646,857.83325,507.18311,207,0.499,0.57,2,25,984,983,985}, -- Bordin Steadyfist (Deepholm)
	-- Pandaria: Dailies
	[31953] = {66730,nil,424,870,1134.17871,-1899.91675,371,0.48,0.541,1,25,992,993,994}, -- Hyuna of the Shrines (The Jade Forest)
	[32440] = {68464,"Pandarian Spirits",424,870,1976.58276,-566.10022,371,0.289,0.36,1,25,1135,1140,1136}, -- Whispering Pandaren Spirit (The Jade Forest)
	[31955] = {66734,nil,424,870,-47.65051,869.74158,376,0.461,0.437,1,25,995,997,996}, -- Farmer Nishi (Valley of the Four Winds)
	[31956] = {66738,nil,424,870,2547.48315,2599.09961,379,0.358,0.736,1,25,1001,1002,1003}, -- Courageous Yon (Kun-Lai Summit)
	[31991] = {66918,nil,424,870,2559.5083,4994.18506,388,0.363,0.522,1,25,1006,1005,1004}, -- Seeker Zusshi (Townlong Steppes)
	[32434] = {68463,"Pandarian Spirits",424,870,2946.25415,3799.48535,388,0.571,0.421,1,25,1130,1131,1139}, -- Burning Pandaren Spirit (Townlong Steppes)
	[31958] = {66741,nil,424,870,697.29309,1689.17773,390,0.313,0.741,1,25,1012,1011,1010}, -- Aki the Chosen (Vale of Eternal Blossoms)
	[32441] = {68465,"Pandarian Spirits",424,870,1704.91687,776.31628,390,0.673,0.144,1,25,1137,1141,1134}, -- Thundering Pandaren Spirit (Vale of Eternal Blossoms)
	[31954] = {66733,nil,424,870,-1544.79102,32.2915,418,0.622,0.459,1,25,1000,999,998}, -- Mo'ruk (Krasarang Wilds)
	[31957] = {66739,nil,424,870,74.81665,3190.58521,422,0.551,0.376,1,25,1009,1007,1008}, -- Wastewalker Shu (Dread Wastes)
	[32439] = {68462,"Pandarian Spirits",424,870,-1705.99023,2869.46021,422,0.611,0.875,1,25,1132,1138,1133}, -- Flowing Pandaren Spirit (Dread Wastes)
	-- Pandaria: Beasts of Fable
	["Alliance:32604"] = {64572,"Beasts of Fable Book I",424,870,935.61896,287.66138,390,0.866,0.600,1}, -- Sara Finkleswitch (Vale of Eternal Blossoms)
	["Alliance:32868"] = {64572,"Beasts of Fable Book II",424,870,935.61896,287.66138,390,0.866,0.600,1}, -- Sara Finkleswitch (Vale of Eternal Blossoms)
	["Alliance:32869"] = {64572,"Beasts of Fable Book III",424,870,935.61896,287.66138,390,0.866,0.600,1}, -- Sara Finkleswitch (Vale of Eternal Blossoms)
	["Horde:32604"] = {64582,"Beasts of Fable Book I",424,870,1547.01733,944.17493,390,0.607,0.238,1}, -- Gentle San (Vale of Eternal Blossoms)
	["Horde:32868"] = {64582,"Beasts of Fable Book II",424,870,1547.01733,944.17493,390,0.607,0.238,1}, -- Gentle San (Vale of Eternal Blossoms)
	["Horde:32869"] = {64582,"Beasts of Fable Book III",424,870,1547.01733,944.17493,390,0.607,0.238,1}, -- Gentle San (Vale of Eternal Blossoms)
	["32604:1"] = {68555,"Beasts of Fable Book I",424,870,348.97412,-1929.52612,371,0.484,0.71,3,25,1129}, -- Ka'wi the Gorger (The Jade Forest)
	["32604:2"] = {68563,"Beasts of Fable Book I",424,870,3274.94775,2637.15039,379,0.352,0.562,3,25,1192}, -- Kafi (Kun-Lai Summit)
	["32604:3"] = {68564,"Beasts of Fable Book I",424,870,2084.66479,592.42773,379,0.679,0.847,3,25,1193}, -- Dos-Ryga (Kun-Lai Summit)
	["32604:4"] = {68565,"Beasts of Fable Book I",424,870,2296.97583,-2531.62939,371,0.57,0.291,3,25,1194}, -- Nitun (The Jade Forest)
	["32868:1"] = {68560,"Beasts of Fable Book II",424,870,-959.08789,1686.4165,376,0.253,0.785,3,25,1189}, -- Greyhoof (Valley of the Four Winds)
	["32868:2"] = {68561,"Beasts of Fable Book II",424,870,-46.65613,1088.71741,376,0.405,0.437,3,25,1190}, -- Lucky Yi (Valley of the Four Winds)
	["32868:3"] = {68566,"Beasts of Fable Book II",424,870,-1277.22852,1248.79163,418,0.362,0.373,3,25,1195}, -- Skitterer Xi'a (Krasarang Wilds)
	["32869:1"] = {68558,"Beasts of Fable Book III",424,870,-378.52185,4738.46094,422,0.262,0.503,3,25,1187}, -- Gorespine (Dread Wastes)
	["32869:2"] = {68559,"Beasts of Fable Book III",424,870,751.22571,2202.00049,390,0.11,0.709,3,25,1188}, -- No-No (Vale of Eternal Blossoms)
	["32869:3"] = {68562,"Beasts of Fable Book III",424,870,1503.73071,2929.30713,388,0.723,0.798,3,25,1191}, -- Ti'un the Wanderer (Townlong Steppes)
	[33137] = {nil,nil,424,870,-720.93799,-4916.58984,554,0.347,0.596,1}, -- The Celestial Tournament (Timeless Isle)
	[33222] = {73626,nil,424,870,-732.74603,-4913.56592,554,0.346,0.604,2,25,1339}, -- Little Tommy Newcomer (Timeless Isle)
	-- Draenor: Dailies
	[37205] = {87122,nil,572,1116,5634.64209,3312.50439,525,0.686,0.648,1,25,1552,1553,1550}, -- Gargra (Frostfire Ridge)
	[37208] = {87125,nil,572,1116,1234.73755,2905.98291,535,0.491,0.804,1,25,1562,1561,1560}, -- Taralune (Talador)
	[37203] = {87124,nil,572,1116,1264.13892,-1083.52783,539,0.5,0.313,1,25,1548,1547,1549}, -- Ashlei (Shadowmoon Valley)
	[37207] = {87123,nil,572,1116,-447.3269,1875.76025,542,0.463,0.453,1,25,1559,1557,1558}, -- Vesharr (Spires of Arak)
	[37201] = {83837,nil,572,1116,5743.67871,890.87549,543,0.511,0.706,1,25,1424,1443,1444}, -- Cymre Brightblade (Gorgrond)
	[37206] = {87110,nil,572,1116,4551.96338,6117.27734,550,0.562,0.098,1,25,1554,1555,1556}, -- Tarr the Terrible (Nagrand)
	-- Draenor: Tanaan Jungle
	[39157] = {94601,nil,572,1116,4827.5,336,534,0.261,0.316,3,25,1671}, -- Felsworn Sentry (Tanaan Jungle)
	[39160] = {94637,nil,572,1116,3651.5,-1074.900024,534,0.53,0.652,3,25,1673}, -- Corrupted Thundertail (Tanaan Jungle)
	[39161] = {94638,nil,572,1116,3265.199951,394.200012,534,0.25,0.762,3,25,1674}, -- Chaos Pup (Tanaan Jungle)
	[39162] = {94639,nil,572,1116,4600.100098,61.200001,534,0.314,0.381,3,25,1675}, -- Cursed Spirit (Tanaan Jungle)
	[39163] = {94640,nil,572,1116,3105.400146,-1226.5,534,0.559,0.808,3,25,1676}, -- Felfly (Tanaan Jungle)
	[39164] = {94641,nil,572,1116,2977.600098,-568.400024,534,0.434,0.845,3,25,1677}, -- Tainted Maulclaw (Tanaan Jungle)
	[39165] = {94642,nil,572,1116,4625.899902,-1323.200073,534,0.577,0.374,3,25,1678}, -- Direflame (Tanaan Jungle)
	[39166] = {94643,nil,572,1116,3419.800049,-508.399994,534,0.422,0.718,3,25,1679}, -- Mirecroak (Tanaan Jungle)
	[39167] = {94644,nil,572,1116,4889.100098,-1130.200073,534,0.541,0.298,3,25,1680}, -- Dark Gazer (Tanaan Jungle)
	[39168] = {94645,nil,572,1116,4366.700195,868.400024,534,0.16,0.447,3,25,1681}, -- Bleakclaw (Tanaan Jungle)
	[39169] = {94646,nil,572,1116,4333,-603.299988,534,0.44,0.457,3,25,1682}, -- Vile Blood of Draenor (Tanaan Jungle)
	[39170] = {94647,nil,572,1116,4085.100098,-776.100037,534,0.473,0.528,3,25,1683}, -- Dreadwalker (Tanaan Jungle)
	[39171] = {94648,nil,572,1116,4692.700195,-831.200012,534,0.484,0.355,3,25,1684}, -- Netherfist (Tanaan Jungle)
	[39172] = {94649,nil,572,1116,4839.100098,-841,534,0.486,0.313,3,25,1685}, -- Skrillix (Tanaan Jungle)
	[39173] = {94650,nil,572,1116,4625.899902,-2253.100098,534,0.755,0.374,3,25,1686}, -- Defiled Earth (Tanaan Jungle)
	-- Broken Isles: Dalaran
	[40277] = {97804,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1748,1746,1745}, -- Tiffany Nelson (Dalaran)
	[40298] = {99182,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1795,1797,1796}, -- Sir Galveston (Dalaran)
	[40299] = {99210,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1800,1801,1799}, -- Bodhi Sunwayver (Dalaran)
	[41881] = {99742,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1815}, -- Heliosus (Dalaran)
	[41886] = {105241,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1855}, -- Splint Jr. (Dalaran)
	[42062] = {105840,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1880}, -- Stitches Jr. Jr. (Dalaran)
	[42442] = {107489,nil,619,1220,-714.5,4641.30029,627,0.282,0.239,4,25,1904,1905,1906}, -- Amalia (Dalaran)
	-- Broken Isles: Azsuna
	[42063] = {105898,nil,619,1220,48.75,5548.021,630,0.65,0.4,4,25,1883}, -- Blottis (Azsuna)
	[42146] = {106476,nil,619,1220,-12.76257,6536.4585,630,0.5,0.414,4,25,1893,1894,1892}, -- Beguiling Orb (Azsuna)
	[42148] = {106417,nil,619,1220,1454.75,6997.72949,630,0.43,0.08,4,25,1891}, -- Vinu (Azsuna)
	[42154] = {106542,nil,619,1220,1103.25,6338.77148,630,0.53,0.16,4,25,1895,1896}, -- Wounded Azurewing Whelpling (Azsuna)
	[42159] = {106552,nil,619,1220,48.75,6800.04199,630,0.46,0.4,4,25,1897,1898,1899}, -- Nightwatcher Merayl (Azsuna)
	[42165] = {nil,nil,619,1220,-243,7657.80029,630,0.474,0.419,4,25,1729,1728,1731}, -- Azsuna Specimens (Azsuna)
	-- Broken Isles: Stormhelm
	[40278] = {98270,nil,619,1220,2971.89258,507.70801,634,0.78,0.57,4,25,1770,1772,1771}, -- Robert Craig (Stormheim)
	[41935] = {nil,nil,619,1220,3165.33008,1436.04028,634,0.62,0.52,4,25,1867,1866}, -- Beasts of Burden (Stormheim)
	[41944] = {105455,nil,619,1220,3396.80005,1774.09998,634,0.56,0.46,4,25,1868,1869,1870}, -- Trapper Jarrun (Stormheim)
	[41948] = {105512,nil,619,1220,2572,1394,634,0.62,0.67,4,25,1871,1872}, -- Envoy of the Hunt (Stormheim)
	[41958] = {99878,nil,619,1220,3443.90015,2228.40015,634,0.446,0.448,4,25,1816,1817,1818}, -- Ominitron Defense System (Stormheim)
	[42067] = {105842,nil,619,1220,4120.6001,2804.90015,634,0.384,0.273,4,25,1882}, -- Chromadon (Stormheim)
	-- Broken Isles: Val'sharah
	[40279] = {99035,nil,619,1220,3506.19995,7019.7002,641,0.469,0.397,4,25,1789,1787,1788}, -- Durian Strongfruit (Val'sharah)
	[41855] = {105009,nil,619,1220,1705,6527,641,0.55,0.88,4,25,1850}, -- Thistleleaf Bully (Val'sharah)
	[41860] = {104970,nil,619,1220,2732,6095,641,0.63,0.6,4,25,1847,1846,1848}, -- Xorvasc (Val'sharah)
	[41861] = {104992,nil,619,1220,3526.80005,5968.1001,641,0.66,0.391,4,25,1849}, -- The Maw (Val'sharah)
	[41862] = {105093,nil,619,1220,2577.18774,6520.4165,641,0.56,0.65,4,25,1851,1852,1853}, -- Fragment of Fire (Val'sharah)
	[42190] = {nil,nil,619,1220,1906.40002,6621.89990,641,0.562,0.484,4,25,1734,1737,1739}, -- Wildlife Conservationist (Val'sharah)
	-- Broken Isles: Highmountain
	[40280] = {99077,nil,619,1220,3708,4315,650,0.477,0.691,4,25,1790,1791,1792}, -- Bredda Tenderhide (Highmountain)
	[40282] = {99150,nil,619,1220,5313.125,4790.5415,650,0.41,0.35,4,25,1798,1793,1794}, -- Grixis Tinypop (Highmountain)
	[41624] = {98572,nil,619,1220,4242,5050,650,0.373,0.577,4,25,1811}, -- Rocko (Highmountain)
	[41687] = {104553,nil,619,1220,5898.8999,4538.3999,650,0.446,0.226,4,25,1842,1841,1840}, -- Odrogg (Highmountain)
	[41766] = {104782,nil,619,1220,4464.875,3729.9165,650,0.56,0.53,4,25,1843}, -- Hungry Icefang (Highmountain)
	[42064] = {105841,nil,619,1220,6606.30029,4634,650,0,0,4,25,1881}, -- Lil'idan (Highmountain)
	-- Broken Isles: Suramar
	[40337] = {97709,nil,619,1220,1150.54053,5270.31006,680,0.25,0.62,4,25,1742}, -- Master Tamer Flummox (Suramar)
	[41895] = {105250,nil,619,1220,1409.68604,3826.76929,680,0.51,0.55,4,25,1857,1858,1859}, -- Aulier (Suramar)
	[41914] = {105323,nil,619,1220,1890.95654,3382.60303,680,0.59,0.42,4,25,1860,1861,1862}, -- Ancient Catacomb Eggs (Suramar)
	[41931] = {105352,nil,619,1220,2150.10205,5603.43506,680,0.19,0.35,4,25,1863,1864,1865}, -- Surging Mana Crystal (Suramar)
	[41990] = {105674,nil,619,1220,1224.58203,3216.04028,680,0.62,0.6,4,25,1873,1874,1875}, -- Varenne (Suramar)
	[42015] = {105779,nil,619,1220,368,4788,680,0.337,0.831,4,25,1877,1878,1879}, -- Felsoul Seer (Suramar)
	-- Broken Isles: Broken Shore
	[46111] = {117934,nil,619,1220,-1226.20007,2222.19995,646,0.7,0.476,4,25,2014,2015,2016}, -- Sissix (Broken Shore)
	[46112] = {117950,nil,619,1220,-534.70001,3130,646,0.464,0.207,4,25,2011,2012,2013}, -- Madam Viciosa (Broken Shore)
	[46113] = {117951,nil,619,1220,-1850.90002,3396.40015,646,0.395,0.72,4,25,2008,2009,2010}, -- Nameless Mystic (Broken Shore)
	-- Argus: Krokuun
	[49041] = {128007,nil,830,1669,855.806,1295.291,830,0.667,0.726,3,25,2095}, -- Ruinhoof (Krokuun)
	[49042] = {128008,nil,830,1669,1073.789,1859.908,830,0.515,0.638,3,25,2096}, -- Foulclaw (Krokuun)
	[49044] = {128010,nil,830,1669,1918.475,1607.316,830,0.583,0.297,3,25,2098}, -- Retch (Krokuun)
	[49045] = {128011,nil,830,1669,1219.937,2673.402,830,0.296,0.579,3,25,2099}, -- Deathscreech (Krokuun)
	[49043] = {128009,nil,830,1669,1366.085,2175.648,830,0.43,0.52,3,25,2092}, -- Baneglow (Krokuun)
	[49046] = {128012,nil,830,1669,1006.908,2301.944,830,0.396,0.665,3,25,2100}, -- Gnasher (Krokuun)
	-- Argus: Mac'Aree
	[49051] = {128017,nil,882,1669,5944.969,10506.402,882,0.319,0.312,3,25,2105}, -- Corrupted Blood of Argus (Mac'Aree)
	[49052] = {128018,nil,882,1669,5836.323,9111.85,882,0.747,0.362,3,25,2106}, -- Mar'cuus (Mac'Aree)
	[49047] = {128013,nil,882,1669,5669.008,9343.189,882,0.676,0.439,3,25,2101}, -- Bucky (Mac'Aree)
	[49048] = {128014,nil,882,1669,5495.174,9274.765,882,0.697,0.519,3,25,2102}, -- Snozz (Mac'Aree)
	[49049] = {128015,nil,882,1669,5077.974,9590.82,882,0.6,0.711,3,25,2103}, -- Gloamwing (Mac'Aree)
	[49050] = {128016,nil,882,1669,5447.37,10372.812,882,0.36,0.541,3,25,2104}, -- Shadeflicker (Mac'Aree)
	-- Argus: Antoran Wastes
	[49053] = {128019,nil,885,1669,-2727.981,9524.785,885,0.516,0.414,3,25,2107}, -- Watcher (Antoran Wastes)
	[49057] = {128023,nil,885,1669,-3464.649,8671.377,885,0.767,0.739,3,25,2111}, -- Minixis (Antoran Wastes)
	[49058] = {128024,nil,885,1669,-2703.048,9245.982,885,0.598,0.403,3,25,2110}, -- One-of-Many (Antoran Wastes)
	[49054] = {128020,nil,885,1669,-3018.115,9354.783,885,0.566,0.542,3,25,2108}, -- Bloat (Antoran Wastes)
	[49055] = {128021,nil,885,1669,-2440.114,9371.783,885,0.561,0.287,3,25,2109}, -- Earseeker (Antoran Wastes)
	[49056] = {128022,nil,885,1669,-3285.582,9099.781,885,0.641,0.66,3,25,2112}, -- Pilfer (Antoran Wastes)
	-- Kul Tiras: Drustvar (896)
	[52278] = {140813,nil,876,1643,-212.4000,3115.1000,896,0.381,0.386,4,25,2210,2211,2212}, -- Fizzie Sparkwhistle (Drustvar)
	[52009] = {139489,nil,876,1643,-1275.2163,4076.3413,896,0.214,0.664,4,25,2193,2194,2195}, -- Captain Hermes (Drustvar)
	[52218] = {140461,nil,876,1643,-1015.1165,1655.1162,896,0.636,0.596,4,25,2209,2208,2206}, -- Dilbert McClint (Drustvar)
	[52297] = {140880,nil,876,1643,591.3832,1804.2910,896,0.610,0.176,4,25,2213,2214,2215}, -- Michael Skarn (Drustvar)
	-- Kul Tiras: Stormsong Valley (942)
	[52165] = {140315,nil,876,1643,3891.3003,1265.9373,942,0.366,0.336,4,25,2205,2203,2204}, -- Eddie Fixit (Stormsong Valley)
	[52316] = {141002,nil,876,1643,3240.5669,-346.3544,942,0.650,0.508,4,25,2220,2221,2222}, -- Ellie Vern (Stormsong Valley)
	[52126] = {139987,nil,876,1643,2264.4670,936.6662,942,0.424,0.766,4,25,2200}, -- Bristlespine (Stormsong Valley)
	[52325] = {141046,nil,876,1643,4065.3335,-1038.9590,942,0.772,0.290,4,25,2223,2225,2226}, -- Leana Darkwind (Stormsong Valley)
	-- Kul Tiras: Tiragarde Sound (895)
	[52430] = {141077,nil,876,1643,412.8169,-1405.9536,895,0.862,0.384,4,25,2229,2228,2227}, -- Kwint (Tiragarde Sound)
	[52471] = {141292,nil,876,1643,669.7834,581.1544,895,0.594,0.332,4,25,2233,2232,2231}, -- Delia Hanako (Tiragarde Sound)
	[52455] = {141215,nil,876,1643,-1642.9166,-1583.9034,895,0.886,0.800,4,25,2230}, -- Chitara (Tiragarde Sound)
	[52751] = {141479,nil,876,1643,1677.8835,-26.8414,895,0.676,0.128,4,25,2330,2332,2333}, -- Burly (Tiragarde Sound)
	-- Zandalar: Nazmir (863)
	[52754] = {141529,nil,875,1642,1825.0707,-377.6833,863,0.728,0.486,4,25,2334,2335,2336}, -- Lozu (Nazmir)
	[52799] = {141799,nil,875,1642,1614.9457,1555.0830,863,0.360,0.546,4,25,2338,2339,2340}, -- Grady Prett (Nazmir)
	[52779] = {141588,nil,875,1642,942.5458,998.3625,863,0.466,0.738,4,25,2157}, -- Bloodtusk (Nazmir)
	[52803] = {141814,nil,875,1642,2168.2747,1187.4373,863,0.430,0.388,4,25,2341,2343,2344}, -- Korval Darkbeard (Nazmir)
	-- Zandalar: Vol'dun (864)
	[52850] = {141879,nil,875,1642,2112.0837,2806.4585,864,0.570,0.490,4,25,2345,2346,2347}, -- Keeyo (Vol'dun)
	[52864] = {141969,nil,875,1642,1530.7506,4618.5830,864,0.304,0.618,4,25,2356}, -- Spineleaf (Vol'dun)
	[52856] = {141945,nil,875,1642,1848.6671,4877.4580,864,0.266,0.548,4,25,2355,2354,2353}, -- Sizzik (Vol'dun)
	[52878] = {142054,nil,875,1642,2230.1670,3623.9585,864,0.450,0.464,4,25,2359,2357,2358}, -- Kusa (Vol'dun)
	-- Zandalar: Zuldazar (862)
	[52892] = {142096,nil,875,1642,-290.7665,-265.5787,862,0.706,0.296,4,25,2360,2361,2363}, -- Karaga (Zuldazar)	
	[52937] = {142151,nil,875,1642,-538.9999,-45.4998,862,0.680,0.340,4,25,2367}, -- Jammer (Zuldazar)
	[52923] = {142114,nil,875,1642,-595.4166,1613.5587,862,0.484,0.350,4,25,2364,2365,2366}, -- Talia Sparkbrow (Zuldazar)
	[52938] = {142234,nil,875,1642,25.1668,1427.3376,862,0.506,0.240,4,25,2368,2370,2371}, -- Zujai (Zuldazar)
}

--[[
	parentMapIDs is a lookup table to control the grouping of quests.
	
	In dailyInfo, all questIDs have a worldPos that only has meaning in the "continent" of
	connected zones. However, some maps don't support a worldPos (Maelstrom, Azeroth, Argus)
	and Argus' three zones share an instanceID but the worldPos has problems mapping a worldPos
	to a sibling zone.

	When a map is shown, the addon will determine which "continent" it's on by going up the
	parent chain until it hits one of the mapIDs in this table. All quests in dailyInfo that
	have this parentMapID are in the same "continent" and can be handled together.

	Any new parentMapID added in dailyInfo MUST be added to this table as well.
]]
tamer.parentMapIDs = {
	[13] = true, -- EK
	[12] = true, -- Kalimdor
	[101] = true, -- Outland
	[113] = true, -- Northrend
	[207] = true, -- Deepholm (Maelstrom can't use worldPos)
	[424] = true, -- Pandaria
	[572] = true, -- Draenor
	[619] = true, -- Broken Isles
	[882] = true, -- Mac'Aree (Argus can't use worldPos)
	[830] = true, -- Krokuun (Argus can't use worldPos)
	[885] = true, -- Antoran Wastes (Argus can't use worldPos)
	[876] = true, -- Kul Tiras
	[875] = true, -- Zandalar
}

--[[
	badParentMapIDs are maps that can't work with worldPos and require special handling.
	
	Any time the map shows one of these mapIDs, paws will need to be added from mapPos
	to that specific mapID. (Except the Argus world map which is not an accurate map and is just art.)

	Also, if a search for a parentMapID encounters one of these, the search ends with no valid
	map found. (The parent map of Argus is Broken Isles which is a valid grouping on its own but
	not at all valid for Argus.)
]]
tamer.badParentMapIDs = {
	[947] = true, -- Azeroth
	[948] = true, -- Maelstrom
	[905] = true, -- Argus
}

--[[
	questIDsWithObjectives is a list of all questIDs that have objectives.

	For instance "Beasts of Fables I" has Ka'wi, Kafi, Dos-Ryga and Nitun.
	In dailyInfo these are questIDs like "32869:1" but in this table it's
	the numeric 32869.
]]
tamer.questIDsWithObjectives = {
	32604, -- Beasts of Fable Book I
	32868, -- Beasts of Fable Book II
	32869, -- Beasts of Fable Book III	
}

--[[
	Remove wrong-faction dailies.

	Some quests are Alliance-only and some are Horde-only. This will remove the wrong-factioned
	quests from dailyInfo.

	If the player is Pandaren, then both faction's quests will show up.
]]
do
	local wrongQuests = {
		-- Alliance table is horde quests to remove and vice versa
		["Alliance"] = {31818,31854,31872,31862,31819,31871,31904,31908,31905,31906,31907,32604,32868,32869,"Horde:32604","Horde:32868","Horde:32869"},
		["Horde"] = {31693,31780,31781,31850,31852,31851,31910,31911,31912,31913,31914,32604,32868,32869,"Alliance:32604","Alliance:32868","Alliance:32869"}
	}
	local faction = UnitFactionGroup("player")

	if wrongQuests[faction] then -- possible the player is Pandaren
		-- remove from dailyInfo all of the wrong-factioned quests in wrongQuests
		for _,questID in ipairs(wrongQuests[faction]) do
			tamer.dailyInfo[questID] = nil
		end
	end
end


--[[
	questIDsByParentMapID is a table indexed by parentMapID that lists all questIDs for that parent.

	This is used for quickly pulling out all quests (questIDs are indexes for dailyInfo) for a
	parentMapID without running down every questID in dailyInfo during map updates.
	
	The table is generated as the addon loads from the dailyInfo and parentMapIDs tables.
	It should be run after any quests are added/removed from dailyInfo.

	NOTE: IF QUESTS ARE ADDED TO DAILYINFO AFTER THIS RUNS, THEY WILL NOT BE SHOWN ON THE MAP!
	(without manually inserting them into questIDsbyParentMapID too)
]]
tamer.questIDsByParentMapID = {}
do
	-- create empty tables for all parent mapIDs
	for mapID in pairs(tamer.parentMapIDs) do
		tamer.questIDsByParentMapID[mapID] = {}
	end
	-- populate each parentID index with its questIDs
	for questID,info in pairs(tamer.dailyInfo) do
		local parentMapID = info[3]
		if tamer.parentMapIDs[parentMapID] then
			tinsert(tamer.questIDsByParentMapID[parentMapID], questID)
		else
			print("QuestID", questID, "has an unknown parent mapID")
		end
	end
end

--[[
	azerothTransforms is used to transform worldPos from various continents on Azeroth to a map
	position suitable for pinning to the Azeroth world map.

	When the azeroth world map changes, use tamer:CreateNewTransform() described below
	to generate new transformation numbers.

	Each entry describes a transformation for each continent on Azeroth:
		[parentMapID] = {xTranslate, xScale, yTranslate, yScale}

	To get an Azeroth map position, tamer:GetAzerothMapPos(y, x, transform) or::
		x = xTranslate + x / xScale
		y = yTranslate + y / yScale
	where y and x are the worldPos or 5th and 6th fields of dailyInfo (note y and x order!)
]]
tamer.azerothTransforms = {
	[13] = {0.85365118296567, -76152.453330774, 0.4695208057772, -50748.794706265}, -- Eastern Kingdom
	[12] = {0.16911260783241, -77802.44067993, 0.54055773731634, -51855.032712979},	-- Kalimdor
	[113] = {0.50444615734089, -71773.554110481, 0.24706796621993, -50054.668309561}, -- Northrend
	[424] = {0.4957260119189, -67710.779270464, 0.84269312541936, -45116.88334164}, -- Pandaria
	[619] = {0.63973998454309, -82749.228234964, 0.44395578475265, -55150.849793565}, -- Broken Isles
	[876] = {0.72816786278544, -76061.329666318, 0.50840062348235, -50696.806738398}, -- Kul Tiras
	[875] = {0.56795148861312, -77934.786988231, 0.63157847607271, -51988.565671475}, -- Zandalar
}

--[[
	CreateNewTransform takes a sample of coordinates from two points on a continent, calculates
	worldPos to mapPos transformations from those samples, and displays an entry for the
	azerothTransforms table above.

		parentMapID = the mapID of the continent on azeroth (13 for EK, 12 for Kalimdor, etc)
		samples = { -- table of four pairs of values like this example:
			{-14472.79980, 459}, -- UnitPosition returns at booty bay
			{0.8476238, 0.7547059}, -- GetPlayerMapPosition at booty bay for Azeroth world map
			{2273.80004, -5333.30029}, -- UnitPosition returns at light hope's chapel
			{0.9236857, 0.4247158}, -- GetPlayerMapPosition at light hope's chapel for Azeroth world map
		}
	(Note: UnitPosition is exact returns, don't swap or rotate the values!)

	To use:
	- Go to any point on a continent and the note the returns of these:
		UnitPosition("player") -- precise returns; don't negate or swap
		C_Map.GetPlayerMapPosition(947, "player") -- 947 is Azeroth world map
		(Can run BattlePetDailyTamer:CreateSample() to do this automatically)
	- Go to another point on the continent (some distance away) and repeat.
	- Create a table with those values and run this function.
	- The result will be sent to TinyPad if the addon is enabled, or printed to chat otherwise.
]]
function tamer:CreateNewTransform(parentMapID, samples)

	-- this calculates the translate and scale on either X or Y separately
	-- s1|2 is x|y of source(worldPos), t1|2 is x|y of target(mapPos)
	local function singleTransform(s1,t1,s2,t2)
		local translate = (t2*s1 - t1*s2) / (s1 - s2)
		local scale = (s2 - s1) / (t2 - t1)
		return translate, scale
	end

	-- before doing anything, swap x and y UnitPosition coordinates ([1] and [3] in samples)
	local temp = samples[1][1]
	samples[1][1] = samples[1][2]
	samples[1][2] = temp
	temp = samples[3][1]
	samples[3][1] = samples[3][2]
	samples[3][2] = temp

 	-- output will build on this
	local transform = "["..parentMapID.."] = {"
	-- calculating x translate and scale first
	local translate, scale = singleTransform(samples[1][1], samples[2][1], samples[3][1], samples[4][1])
	transform = transform .. translate .. ", " .. scale
	-- calculating y translate and scale next
	translate, scale = singleTransform(samples[1][2], samples[2][2], samples[3][2], samples[4][2])
	transform = transform .. ", " .. translate .. ", " .. scale .. "},"

	-- if TinyPad loaded, send output to a new page for copy-pasting
	if IsAddOnLoaded("TinyPad") then
		TinyPad.Insert(transform)
	else -- otherwise print to chat
		print(transform)
	end
end

-- this creates a sample data for wherever the player currently is, sending it to TinyPad
-- if it's loaded, or prints to chat frame otherwise.
function tamer:CreateSample()
	local uy,ux = UnitPosition("player")
	local mx,my = C_Map.GetPlayerMapPosition(947, "Player"):GetXY()
	local mapID = C_Map.GetBestMapForUnit("player")
	local zone = C_Map.GetMapInfo(mapID).name
	local subZone = GetMinimapZoneText()
	local txt = string.format("{%.7f,%7f}, -- %s (%s)\n{%.7f,%.7f},", uy, ux, subZone, zone, mx, my)
	if IsAddOnLoaded("TinyPad") then
		TinyPad.Insert(txt)
	else
		print(txt)
	end
end