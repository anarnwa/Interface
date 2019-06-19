-- Daily Tamer Check
-- by Jadya
-- EU-Well of Eternity

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbicon = ldb and LibStub("LibDBIcon-1.0", true)

local DTCversion = 1
local playerfaction = UnitFactionGroup("PLAYER")
-- dtc mainframe
--local DailyTamerCheck_mainframe
-- dtc world map frame
local DailyTamerCheck_mapframe
local DTCTTmenu = {}

-- string colors
local LIGHT_RED    = "|cffFF2020"
local LIGHT_GREEN  = "|cff20FF20"
local LIGHT_BLUE   = "|cff11DDFF"
local LIGHT_YELLOW = "|cffFFFFAA"
local ZONE_BLUE    = "|cff00aacc"
local GREY         = "|cffAAAAAA"
local COORD_GREY   = "|cffDDDDDD"
local GOLD         = "|cffffcc00"
local WHITE        = "|cffffffff"
local function AddColor(str,color)
 return color..str.."|r"
end

local levelcolor = WHITE
local npcnamecolor = LIGHT_BLUE
local zonecolor = GREY
local coordcolor = COORD_GREY

local SAT   = 0 -- satchels table
local EKK   = 1 -- eastern kingdoms, kalimdor
local ONC   = 2 -- outlands, northrend, cataclysm
local ABOUT = 3 -- about frame

-- elite pets daily quests (quest log)
local ep_header = "elite pets"
local ep_quest_missing = AddColor(string.format(ITEM_MISSING,BATTLE_PET_SOURCE_2),LIGHT_RED)
-- elite pets quest objective indexes
local epspecial = "#elitepets#"
--
local WEheader = EVENTS_LABEL
local WEtable  -- world events table
local tables = {} -- tamers tables
local questsdata = nil

local frames_backdrop = {bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                         edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                         tile = true, tileSize = 16, edgeSize = 16, 
                         insets = { left = 4, right = 4, top = 4, bottom = 4 }}

-- pet families icons
local pfme  = "|TInterface\\icons\\Icon_PetFamily_Mechanical:12|t"
local pfbe  = "|TInterface\\icons\\Icon_PetFamily_Beast:12|t"
local pfhu  = "|TInterface\\icons\\Icon_PetFamily_Humanoid:12|t"
local pfdr  = "|TInterface\\icons\\Icon_PetFamily_Dragon:12|t"
local pffl  = "|TInterface\\icons\\Icon_PetFamily_Flying:12|t"
local pfcr  = "|TInterface\\icons\\Icon_PetFamily_Critter:12|t"
local pfma  = "|TInterface\\icons\\Icon_PetFamily_Magical:12|t"
local pfun  = "|TInterface\\icons\\Icon_PetFamily_Undead:12|t"
local pfwa  = "|TInterface\\icons\\Icon_PetFamily_Water:12|t"
local pfel  = "|TInterface\\icons\\Icon_PetFamily_Elemental:12|t"

-- icons
local dtcicon = "Interface\\ICONS\\INV_MISC_PETMOONKINTA"
local icon_firespirit = "Interface\\icons\\INV_Pet_PandarenElemental_Fire"
local icon_waterspirit = "Interface\\icons\\Inv_pet_PandarenElemental"
local icon_earthspirit = "Interface\\icons\\INV_Pet_PandarenElemental_Earth"
local icon_airspirit = "Interface\\icons\\INV_Pet_PandarenElemental_Air"
-- buttons' textures
local tx_btnnorth     = "Interface\\icons\\Achievement_Zone_Northrend_01"
local tx_btnkalim     = "Interface\\icons\\Achievement_Zone_Kalimdor_01"
local tx_btnabout     = "Interface\\icons\\Icon_PetFamily_Beast"
local tx_chkcoords    = "Interface\\icons\\INV_Misc_Map_01"
local tx_chkminimap   = "Interface\\icons\\INV_Misc_Map03"
local tx_chknames     = "Interface\\icons\\Achievement_Character_Pandaren_Female"
local tx_chkicons     = "Interface\\icons\\Icon_PetFamily_Dragon"
local tx_chkmapicons  = "Interface\\icons\\Ability_Hunter_Crossfire"
local tx_chklevel     = "Interface\\icons\\INV_Pet_Achievement_RaiseAPetLevel_25"
local tx_optionsframe = "Interface\\icons\\Icon_PetFamily_Mechanical"
local tx_bagicon      = "Interface\\icons\\INV_Misc_Bag_CenarionHerbBag"
local ep_icon         = "Interface\\icons\\Ability_Mount_WhiteDireWolf"
local tx_faction      = {["Alliance"] = "Interface\\icons\\Achievement_General_AllianceSlayer",
                         ["Horde"] = "Interface\\icons\\Achievement_General_HordeSlayer"}
local opt_framespeed = 20  -- frames animation speed
local centerbuttons_spacing = 80
--local worldeventschecked = false

-- localization
local s_togglecoords
local s_togglenpcnames
local s_toggleminimapbtn
local s_togglenpclevel
local s_togglenpcicons
local s_togglemapicons
local s_tomtomintegration
local s_tomtomset
local s_showfaction
local s_optionsmain = COMPACT_UNIT_FRAME_PROFILE_SUBTYPE_ALL

 if GetLocale() == "itIT" then -- italian
  s_togglecoords = "Attiva coordinate"
  s_togglenpcnames = "Attiva nomi NPC"
  s_toggleminimapbtn = "Attiva pulsante minimappa"
  s_togglenpclevel = "Attiva livello delle mascotte"
  s_togglenpcicons = "Attiva le icone delle mascotte dei tamer"
  s_togglemapicons = "Attiva le icone sulla mappa"
  s_tomtomintegration = "Setta waypoint di TomTom"
  s_tomtomset = "|cff11DDFFDaily Tamer Check|r - Waypoint aggiunto a TomTom"
  s_showfaction = "Mostra tamer dell'altra fazione"
 elseif GetLocale() == "deDE" then -- german
  s_togglecoords = "Koordinaten an/aus"
  s_togglenpcnames = "NPC Namen an/aus"
  s_toggleminimapbtn = "Minikarten Symbol an/aus"
  s_togglenpclevel = "Sortiere Zähmer nach Haustier Level an/aus"
  s_togglenpcicons = "Haustier Kategorie Symbol an/aus"
  s_togglemapicons = "Toggle world map icons" --de
  s_tomtomintegration = "Set TomTom waypoint" --de
  s_tomtomset = "|cff11DDFFDaily Tamer Check|r - Waypoint added to TomTom" --de
  s_showfaction = "Show other faction tamers" --de
 else -- eng
  s_togglecoords = "Toggle coordinates"
  s_togglenpcnames = "Toggle NPC names"
  s_toggleminimapbtn = "Toggle minimap button"
  s_togglenpclevel = "Toggle pet level"
  s_togglenpcicons = "Toggle pets' icons"
  s_togglemapicons = "Toggle world map icons"
  s_tomtomintegration = "Set TomTom waypoint"
  s_tomtomset = "|cff11DDFFDaily Tamer Check|r - Waypoint added to TomTom"
  s_showfaction = "Show other faction tamers"
 end
--

local ZONE = 1
local NPCNAME = 2
local NPCLEVEL = 3
local NPCICONS = 4
local MAPDATA = 5
local MAPDEFAULT = 6
local MAPICON = 7
local FACTION = 8
------- zone -> quests table for the world map frame -------------------------
local mapstable = {}
local function generatezonetomaptable()
 table.foreach(questsdata, function(questID,info)
   if info[MAPDATA] then
    table.foreach(info[MAPDATA], function(mapID, _)
     if not mapstable[mapID] then
      mapstable[mapID] = {}
     end
     if not tContains(mapstable[mapID], questID) then
      table.insert(mapstable[mapID], questID)
     end
    end)
   end
  end)
end
------------------------------------------------------------------------
local function coord(questID)
 return questsdata[questID] and AddColor(questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][1]..","..questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][2],coordcolor) or ""
end
------------------------------------------------------------------------
local function levelformat(lev)
 if lev > 100 then -- elite pets
  return AddColor("["..(lev - 100).."+] ", levelcolor)
 else
  return AddColor("["..lev.."] ", levelcolor)
 end
end
------------------------------------------------------------------------
local function factioncheck(questID)
 if not questsdata[questID][FACTION] or DailyTamerCheck_Options["show_faction"] or
         (not DailyTamerCheck_Options["show_faction"] and questsdata[questID][FACTION]
          and questsdata[questID][FACTION] == playerfaction) then
  return true
 else
  return false
 end
end
--[[
  dtc tables [questID] = {zone name, npc name, petslevel, petsicons, {[mapid] = {x,y}, ... }, defaultmap, custom world map icon }
]]--

local tj = GetMapNameByID(945)
------- localized zone and npc names from GetAchievementCriteriaInfo --------
 questsdata = {
     -- Tanaan Jungle --
	  [39157] = {tj,"Felsworn Sentry"      ,25,pfme,{[945] = {26.1,31.6}},945,tx_wod_bagicon}, -- felsworn sentry
	  [39160] = {tj,"Corrupted Thundertail",25,pfbe,{[945] = {53,65.2}},945,tx_wod_bagicon}, -- corrupted thundertail
	  [39161] = {tj,"Chaos Pup"            ,25,pfbe,{[945] = {25,76.4}},945,tx_wod_bagicon}, -- chaos pup
	  [39162] = {tj,"Cursed Spirit"        ,25,pfun,{[945] = {31.2,38.2}},945,tx_wod_bagicon}, -- cursed spirit
	  [39163] = {tj,"Felfly"               ,25,pffl,{[945] = {55.9,80.8}},945,tx_wod_bagicon}, -- felfly
	  [39164] = {tj,"Tainted Maulclaw"     ,25,pfwa,{[945] = {43.2,84.5}},945,tx_wod_bagicon}, -- tainted maulclaw
	  [39165] = {tj,"Direflame"            ,25,pfel,{[945] = {57.6,37.2}},945,tx_wod_bagicon}, -- direflame
	  [39166] = {tj,"Mirecroak"            ,25,pfwa,{[945] = {42.3,71.8}},945,tx_wod_bagicon}, -- mirecroak
	  [39167] = {tj,"Dark Gazer"           ,25,pfma,{[945] = {54,30}},945,tx_wod_bagicon}, -- dark gazer
	  [39168] = {tj,"Bleakclaw"            ,25,pffl,{[945] = {16,44.6}},945,tx_wod_bagicon}, -- bleakclaw
	  [39169] = {tj,"Vile Blood of Draenor",25,pfma,{[945] = {43.8,45.8}},945,tx_wod_bagicon}, -- vile blood of draenor
	  [39170] = {tj,"Dreadwalker"          ,25,pfme,{[945] = {47.2,52.6}},945,tx_wod_bagicon}, -- dreadwalker
	  [39171] = {tj,"Netherfist"           ,25,pfhu,{[945] = {48.4,35.6}},945,tx_wod_bagicon}, -- netherfist
	  [39172] = {tj,"Skrillix"             ,25,pfhu,{[945] = {48.6,31.2}},945,tx_wod_bagicon}, -- skrillix
	  [39173] = {tj,"Defiled Earth"        ,25,pfel,{[945] = {75.4,37.4}},945,tx_wod_bagicon}, -- defiled earth
      
      --[39157] = {tj,GetAchievementCriteriaInfo(10052,1),25,pfme,{[945] = {26.1,31.6}},945,tx_wod_bagicon}, -- felsworn sentry
	  --[39160] = {tj,GetAchievementCriteriaInfo(10052,2),25,pfbe,{[945] = {53,65.2}},945,tx_wod_bagicon}, -- corrupted thundertail
	  --[39161] = {tj,GetAchievementCriteriaInfo(10052,3),25,pfbe,{[945] = {25,76.4}},945,tx_wod_bagicon}, -- chaos pup
	  --[39162] = {tj,GetAchievementCriteriaInfo(10052,4),25,pfun,{[945] = {31.2,38.2}},945,tx_wod_bagicon}, -- cursed spirit
	  --[39163] = {tj,GetAchievementCriteriaInfo(10052,5),25,pffl,{[945] = {55.9,80.8}},945,tx_wod_bagicon}, -- felfly
	  --[39164] = {tj,GetAchievementCriteriaInfo(10052,6),25,pfwa,{[945] = {43.2,84.5}},945,tx_wod_bagicon}, -- tainted maulclaw
	  --[39165] = {tj,GetAchievementCriteriaInfo(10052,7),25,pfel,{[945] = {57.6,37.2}},945,tx_wod_bagicon}, -- direflame
	  --[39166] = {tj,GetAchievementCriteriaInfo(10052,8),25,pfwa,{[945] = {42.3,71.8}},945,tx_wod_bagicon}, -- mirecroak
	  --[39167] = {tj,GetAchievementCriteriaInfo(10052,9),25,pfma,{[945] = {54,30}},945,tx_wod_bagicon}, -- dark gazer
	  --[39168] = {tj,GetAchievementCriteriaInfo(10052,10),25,pffl,{[945] = {16,44.6}},945,tx_wod_bagicon}, -- bleakclaw
	  --[39169] = {tj,GetAchievementCriteriaInfo(10052,11),25,pfma,{[945] = {43.8,45.8}},945,tx_wod_bagicon}, -- vile blood of draenor
	  --[39170] = {tj,GetAchievementCriteriaInfo(10052,12),25,pfme,{[945] = {47.2,52.6}},945,tx_wod_bagicon}, -- dreadwalker
	  --[39171] = {tj,GetAchievementCriteriaInfo(10052,13),25,pfhu,{[945] = {48.4,35.6}},945,tx_wod_bagicon}, -- netherfist
	  --[39172] = {tj,GetAchievementCriteriaInfo(10052,14),25,pfhu,{[945] = {48.6,31.2}},945,tx_wod_bagicon}, -- skrillix
	  --[39173] = {tj,GetAchievementCriteriaInfo(10052,15),25,pfel,{[945] = {75.4,37.4}},945,tx_wod_bagicon}, -- defiled earth

     -- Garrison --
	  [36483] = {GetMapNameByID(971),GARRISON_LOCATION_TOOLTIP,25,"",{[971] = {28.9,42.8},[947] = {28.6,17.1},[962] = {52.3,61.3}},971,tx_wod_bagicon,"Alliance"},
      [36662] = {GetMapNameByID(976),GARRISON_LOCATION_TOOLTIP,25,"",{[976] = {32.06,43.59},[941] = {46.54,65.36},[962] = {33.35,36.83}},976,tx_wod_bagicon,"Horde"},
	  [38299] = {GetMapNameByID(971),"Erris",25,"",{[971] = {28.9,42.8},[947] = {28.6,17.1},[962] = {52.3,61.3}},971,tx_wod_bagicon,"Alliance"},
	  [38300] = {GetMapNameByID(976),"Kura",25,"",{[976] = {32.06,43.59},[941] = {46.54,65.36},[962] = {33.35,36.83}},976,tx_wod_bagicon,"Horde"},
     -- Draenor --
      [37203] = {GetMapNameByID(947),"Ashlei"           ,25,pfma..pfma..pfbe,{[947] = {50,30},[962] = {58.6,65.5}},947,tx_wod_bagicon}, -- ashlei
	  [37205] = {GetMapNameByID(941),"Gargra"           ,25,pfbe..pfbe..pfbe,{[941] = {68.6,64.7},[962] = {39.2,36.7}},941,tx_wod_bagicon}, -- gargra
	  [37206] = {GetMapNameByID(950),"Tarr the Terrible",25,pfhu..pfhu..pfhu,{[950] = {56.2,9.8},[962] = {27,43.8}},950,tx_wod_bagicon}, -- tarr
	  [37208] = {GetMapNameByID(946),"Taralune"         ,25,pffl..pffl..pffl,{[946] = {49.1,80.4},[962] = {41.1,65.7}},946,tx_wod_bagicon}, -- taralune
	  [37201] = {GetMapNameByID(949),"Cymre Brighblade" ,25,pfun..pfma..pfme,{[949] = {51,71},[962] = {50,36}},949,tx_wod_bagicon}, -- cymre
	  [37207] = {GetMapNameByID(948),"Vesharr"          ,25,pffl..pfme..pffl,{[948] = {46.3,45.3},[962] = {45.6,76.8}},948,tx_wod_bagicon}, -- vesharr
      
      --[37203] = {GetMapNameByID(947),{9724,1},25,pfma..pfma..pfbe,{[947] = {50,30},[962] = {58.6,65.5}},947,tx_wod_bagicon}, -- ashlei
	  --[37205] = {GetMapNameByID(941),{9724,2},25,pfbe..pfbe..pfbe,{[941] = {68.6,64.7},[962] = {39.2,36.7}},941,tx_wod_bagicon}, -- gargra
	  --[37206] = {GetMapNameByID(950),{9724,3},25,pfhu..pfhu..pfhu,{[950] = {56.2,9.8},[962] = {27,43.8}},950,tx_wod_bagicon}, -- tarr
	  --[37208] = {GetMapNameByID(946),{9724,4},25,pffl..pffl..pffl,{[946] = {49.1,80.4},[962] = {41.1,65.7}},946,tx_wod_bagicon}, -- taralune
	  --[37201] = {GetMapNameByID(949),{9724,5},25,pfun..pfma..pfme,{[949] = {51,71},[962] = {50,36}},949,tx_wod_bagicon}, -- cymre
	  --[37207] = {GetMapNameByID(948),{9724,6},25,pffl..pfme..pffl,{[948] = {46.3,45.3},[962] = {45.6,76.8}},948,tx_wod_bagicon}, -- vesharr
     -- Pandaren Spirits --
      [32434] = {GetMapNameByID(810),"|T"..icon_firespirit..":12|t Fire Spirit",25,pfdr..pfel..pffl,{[810] = {57,42},[862] = {32,36},[809] = {16,64}},810,icon_firespirit},
      [32439] = {GetMapNameByID(858),"|T"..icon_waterspirit..":12|t Water Spirit",25,pfwa..pfcr..pfel,{[858] = {61,88},[862] = {38,81}},858,icon_waterspirit},
      [32441] = {GetMapNameByID(809),"|T"..icon_earthspirit..":12|t Earth Spirit",25,pfel..pfma..pfbe,{[809] = {65,94},[862] = {51,48},[811] = {67,14},[806] = {9,41}},809,icon_earthspirit},
      [32440] = {GetMapNameByID(806),"|T"..icon_airspirit..":12|t Air Spirit",25,pffl..pfdr..pfel,{[806] = {29,36},[862] = {60,45}, [809] = {86,87}},806,icon_airspirit},
     -- Pandaria --
      [31953] = {GetMapNameByID(806),"Hyuna",25,pffl..pfbe..pfwa,{[806] = {48,54},[862] = {69,54},},806,tx_bagicon},
      [31955] = {GetMapNameByID(807),"Nishi",25,pfel..pfel..pfbe,{[807] = {46,44},[862] = {51,65},},807,tx_bagicon},
      [31954] = {GetMapNameByID(857),"Mo'ruk",25,pfbe..pffl..pfwa,{[857] = {62,45},[862] = {56,79},},857,tx_bagicon},
      [31956] = {GetMapNameByID(809),"Yon",25,pffl..pfcr..pfbe,{[809] = {36,74},[862] = {40,40},},809,tx_bagicon},
      [31991] = {GetMapNameByID(810),"Zusshi",25,pfel..pfcr..pfwa,{[810] = {36,52},[862] = {24,40},},810,tx_bagicon},
      [31957] = {GetMapNameByID(858),"Shu",25,pfwa..pfel..pfbe,{[858] = {55,38},[862] = {36,64},},858,tx_bagicon},
      [31958] = {GetMapNameByID(811),"Aki",25,pfcr..pfdr..pfwa,{[811] = {31,74},[862] = {45,58},[858] = {83,20},[807] = {25,15},},811,tx_bagicon},
     -- Outlands --
      [31922] = {GetMapNameByID(465),"Nicky Tinytech",20,pfme..pfme..pfme,{[465] = {64,49},[466] = {62,52}},465}, -- nicky
      [31923] = {GetMapNameByID(467),"Ras'an",21,pffl..pfhu..pfma,{[467] = {17,50},[466] = {25,48}},467}, -- ras'an
      [31924] = {GetMapNameByID(477),"Narrok",22,pfwa..pfcr..pfbe,{[477] = {61,49},[466] = {35,65}},477}, -- narrok
      [31925] = {GetMapNameByID(481),"Morulu The Elder",23,pfwa..pfwa..pfwa,{[481] = {59,70},[478] = {32,30},[466] = {44,68}},481}, -- morulu
      [31926] = {GetMapNameByID(473),"Grand Master Antari",24,pfma..pfel..pfdr,{[473] = {31,42},[466] = {60,79}},473,tx_bagicon},
       
      --[31922] = {GetMapNameByID(465),{6604,1},20,pfme..pfme..pfme,{[465] = {64,49},[466] = {62,52}},465}, -- nicky
      --[31923] = {GetMapNameByID(467),{6604,2},21,pffl..pfhu..pfma,{[467] = {17,50},[466] = {25,48}},467}, -- ras'an
      --[31924] = {GetMapNameByID(477),{6604,3},22,pfwa..pfcr..pfbe,{[477] = {61,49},[466] = {35,65}},477}, -- narrok
      --[31925] = {GetMapNameByID(481),{6604,4},23,pfwa..pfwa..pfwa,{[481] = {59,70},[478] = {32,30},[466] = {44,68}},481}, -- morulu
      --[31926] = {GetMapNameByID(473),{6604,5},24,pfma..pfel..pfdr,{[473] = {31,42},[466] = {60,79}},473,tx_bagicon},
     -- Northrend --
      [31931] = {GetMapNameByID(491),"Beegle Blastfuse",25,pffl..pfwa..pffl,{[491] = {29,34},[485] = {69,75},},491}, -- beegle
      [31933] = {GetMapNameByID(488),"Okrut Dragonwaste",25,pfdr..pfun..pfun,{[488] = {59,77},[485] = {50,67},},488}, -- okrut
      [31934] = {GetMapNameByID(496),"Gutretch",25,pfbe..pfbe..pfcr,{[496] = {13,67},[485] = {59,44},},496}, -- gutretch
      [31932] = {GetMapNameByID(510),"Nearly Headless Jacob",25,pfun..pfun..pfun,{[510] = {50,59},[485] = {51,44},},510}, -- headless
      [31935] = {GetMapNameByID(492),"Grand Master Payne",25,pfbe..pfme..pfel, {[492] = {77,20},[485] = {49,17},},492,tx_bagicon},
      
      --[31931] = {GetMapNameByID(491),{6605,2},25,pffl..pfwa..pffl,{[491] = {29,34},[485] = {69,75},},491}, -- beegle
      --[31933] = {GetMapNameByID(488),{6605,4},25,pfdr..pfun..pfun,{[488] = {59,77},[485] = {50,67},},488}, -- okrut
      --[31934] = {GetMapNameByID(496),{6605,1},25,pfbe..pfbe..pfcr,{[496] = {13,67},[485] = {59,44},},496}, -- gutrek
      --[31932] = {GetMapNameByID(510),{6605,3},25,pfun..pfun..pfun,{[510] = {50,59},[485] = {51,44},},510}, -- headless
      --[31935] = {GetMapNameByID(492),{6605,5},25,pfbe..pfme..pfel, {[492] = {77,20},[485] = {49,17},},492,tx_bagicon},
     -- Cataclysm --
      [31972] = {GetMapNameByID(606),"Brok",25,pfma..pfbe..pfcr,{[606] = {61,33},[182] = {87,48},[281] = {41,85},[13] = {56,31},},606}, -- 
      [31973] = {GetMapNameByID(640),"Bordin Steadyfist",25,pfel..pfcr..pfel,{[640] = {50,57},[751] = {50,36},},640}, -- bordin
      [31971] = {GetMapNameByID(720),"Grand Master Obalis",25,pfbe..pffl..pfcr,{[720] = {57,42},[13] = {49,92},},720,tx_bagicon},
      [31974] = {GetMapNameByID(700),"Goz Banefury",25,pfel..pfma..pfbe,{[700] = {57,57},[14] = {58,57},},700}, -- goz
      
      --[31972] = {GetMapNameByID(606),{7525,1},25,pfma..pfbe..pfcr,{[606] = {61,33},[182] = {87,48},[281] = {41,85},[13] = {56,31},},606}, -- 
      --[31973] = {GetMapNameByID(640),{7525,2},25,pfel..pfcr..pfel,{[640] = {50,57},[751] = {50,36},},640}, -- bordin
      --[31971] = {GetMapNameByID(720),{7525,4},25,pfbe..pffl..pfcr,{[720] = {57,42},[13] = {49,92},},720,tx_bagicon},
      --[31974] = {GetMapNameByID(700),{7525,3},25,pfel..pfma..pfbe,{[700] = {57,57},[14] = {58,57},},700}, -- goz
     -- Kalimdor --
      [31818] = {GetMapNameByID(4)  ,"Zunta",2,pfbe..pfcr,{[4] = {44,28},[13] = {58,49},[11] = {78,27}},4,nil,"Horde"}, -- zunta
      [31819] = {GetMapNameByID(11) ,"Dagra the Fierce",3,pfbe..pfbe..pfcr,{[11] = {58,53},[13] = {55,53},[4] = {23,58},[607] = {61,9}},11,nil,"Horde"}, -- dagra
      [31909] = {GetMapNameByID(281),"Grand Master Trixxy",19,pfdr..pfbe..pffl,{[281] = {66,65},[13] = {60,27},},281,tx_bagicon}, -- trixxy
      [31904] = {GetMapNameByID(607),"Cassandra Kaboom",11,pfme..pfme..pfme,{[607] = {39,79},[13] = {51,67},[9] = {69,98},[141] = {11,48}},607,nil,"Horde"}, -- cassandra
      [31854] = {GetMapNameByID(43) ,"Analynn",5,pfwa..pfcr..pffl,{[43] = {20,29},[13] = {45,38},[182] = {21,91}},43,nil,"Horde"}, -- analynn
      [31906] = {GetMapNameByID(61) ,"Kela Grimtotem",15,pfbe..pfcr..pfcr,{[61] = {32,33},[13] = {51,72},[141] = {16,83}},61,nil,"Horde"}, -- kela
      [31862] = {GetMapNameByID(81) ,"Zonya the Sadist",7,pfbe..pfbe..pfcr,{[81] = {59,71},[13] = {45,50},},81,nil,"Horde"}, -- zonya
      [31872] = {GetMapNameByID(101),"Merda Stronghoof",9,pfwa..pfcr..pfel,{[101] = {57,45},[13] = {42,56},[9] = {10,21}},101,nil,"Horde"}, -- merda
      [31905] = {GetMapNameByID(141),"Grazzle the Great",14,pfdr..pfdr..pfdr,{[141] = {53,74},[13] = {57,71},[61] = {77,24}},141,nil,"Horde"},
      [31871] = {GetMapNameByID(121),"Traitor Gluk",13,pfbe..pfcr..pfdr,{[121] = {60,50},[13] = {43,72},},121,nil,"Horde"}, -- traitor
      [31907] = {GetMapNameByID(182),"Zoltan",16,pfma..pfma..pfme,{[182] = {40,56},[13] = {48,31},[42] = {56,75},},182,nil,"Horde"}, -- zoltan
      [31908] = {GetMapNameByID(241),"Elena Flutterfly",17,pfdr..pffl..pfma,{[241] = {46,60},[13] = {53,21},[42] = {84,15},},241,nil,"Horde"}, -- elena
      
      --[31818] = {GetMapNameByID(4)  ,{6602,3},2,pfbe..pfcr,{[4] = {44,28},[13] = {58,49},[11] = {78,27}},4,nil,"Horde"}, -- zunta
      --[31819] = {GetMapNameByID(11) ,{6602,2},3,pfbe..pfbe..pfcr,{[11] = {58,53},[13] = {55,53},[4] = {23,58},[607] = {61,9}},11,nil,"Horde"}, -- dagra
      --[31909] = {GetMapNameByID(281),{6602,1},19,pfdr..pfbe..pffl,{[281] = {66,65},[13] = {60,27},},281,tx_bagicon}, -- trixxy
      --[31904] = {GetMapNameByID(607),{6602,9},11,pfme..pfme..pfme,{[607] = {39,79},[13] = {51,67},[9] = {69,98},[141] = {11,48}},607,nil,"Horde"}, -- cassandra
      --[31854] = {GetMapNameByID(43) ,{6602,4},5,pfwa..pfcr..pffl,{[43] = {20,29},[13] = {45,38},[182] = {21,91}},43,nil,"Horde"}, -- analynn
      --[31906] = {GetMapNameByID(61) ,{6602,12},15,pfbe..pfcr..pfcr,{[61] = {32,33},[13] = {51,72},[141] = {16,83}},61,nil,"Horde"}, -- kela
      --[31862] = {GetMapNameByID(81) ,{6602,5},7,pfbe..pfbe..pfcr,{[81] = {59,71},[13] = {45,50},},81,nil,"Horde"}, -- zonya
      --[31872] = {GetMapNameByID(101),{6602,6},9,pfwa..pfcr..pfel,{[101] = {57,45},[13] = {42,56},[9] = {10,21}},101,nil,"Horde"}, -- merda
      --[31905] = {GetMapNameByID(141),{6602,10},14,pfdr..pfdr..pfdr,{[141] = {53,74},[13] = {57,71},[61] = {77,24}},141,nil,"Horde"},
      --[31871] = {GetMapNameByID(121),{6602,7},13,pfbe..pfcr..pfdr,{[121] = {60,50},[13] = {43,72},},121,nil,"Horde"}, -- traitor
      --[31907] = {GetMapNameByID(182),{6602,11},16,pfma..pfma..pfme,{[182] = {40,56},[13] = {48,31},[42] = {56,75},},182,nil,"Horde"}, -- zoltan
      --[31908] = {GetMapNameByID(241),{6602,8},17,pfdr..pffl..pfma,{[241] = {46,60},[13] = {53,21},[42] = {84,15},},241,nil,"Horde"}, -- elena
     -- Eastern Kingdoms --
      [31693] = {GetMapNameByID(30) ,"Julia Stevens",2,pfbe..pfbe,{[30] = {42,84},[14] = {44,78},},30,nil,"Alliance"}, -- julia
      [31914] = {GetMapNameByID(29) ,"Durin Darkhammer",17,pffl..pfcr..pfel,{[29] = {25,47},[14] = {48,70},},29,nil,"Alliance"}, -- durin
      [31850] = {GetMapNameByID(34) ,"Eric Davidson",7,pfbe..pfbe..pfbe,{[34] = {20,44},[14] = {44,80},},34,nil,"Alliance"},
      [31781] = {GetMapNameByID(36) ,"Lindsay",5,pfcr..pfcr..pfcr,{[36] = {33,52},[14] = {50,76},},36,nil,"Alliance"}, -- lindsay
      [31912] = {GetMapNameByID(28) ,"Kortas Darkhammer",15,pfdr..pfdr..pfdr,{[28] = {35,27},[14] = {47,65},},28,nil,"Alliance"}, -- kortas
      [31852] = {GetMapNameByID(37) ,"Steven Lisbane",9,pfbe..pfbe..pfma,{[37] = {46,40},[689] = {47,26},[14] = {45,85},},37,nil,"Alliance"}, -- steven
      [31851] = {GetMapNameByID(673),"Bill Buckler",11,pfhu..pffl..pffl,{[673] = {51,73},[689] = {44,79},[14] = {44,94},},673,nil,"Alliance"}, -- bill
      [31913] = {GetMapNameByID(38) ,"Everessa",16,pffl..pfwa..pfbe,{[38] = {76,41},[14] = {54,79},},38,nil,"Alliance"}, -- everessa
      [31910] = {GetMapNameByID(26) ,"David Kosse",13,pfcr..pfbe..pfma,{[26] = {62,54},[14] = {54,41},},26,nil,"Alliance"}, -- david
      [31780] = {GetMapNameByID(39) ,"Old MacDonald",3,pfme..pffl..pfcr,{[39] = {61,19},[14] = {42,77},},39,nil,"Alliance"}, -- mcdonald
      [31916] = {GetMapNameByID(32) ,"Grand Master Lydia Accoste",19,pfel..pfun..pfun,{[32] = {40,77},[14] = {49,82},},32,tx_bagicon},
      [31911] = {GetMapNameByID(23) ,"Deiza Plaguehorn",14,pfbe..pfbe..pfun,{[23] = {67,54},[14] = {57,32},},23,nil,"Alliance"}, -- deiza
      
      --[31693] = {GetMapNameByID(30) ,{6603,4},2,pfbe..pfbe,{[30] = {42,84},[14] = {44,78},},30,nil,"Alliance"}, -- julia
      --[31914] = {GetMapNameByID(29) ,{6603,12},17,pffl..pfcr..pfel,{[29] = {25,47},[14] = {48,70},},29,nil,"Alliance"}, -- durin
      --[31850] = {GetMapNameByID(34) ,{6603,3},7,pfbe..pfbe..pfbe,{[34] = {20,44},[14] = {44,80},},34,nil,"Alliance"},
      --[31781] = {GetMapNameByID(36) ,{6603,2},5,pfcr..pfcr..pfcr,{[36] = {33,52},[14] = {50,76},},36,nil,"Alliance"}, -- lindsay
      --[31912] = {GetMapNameByID(28) ,{6603,9},15,pfdr..pfdr..pfdr,{[28] = {35,27},[14] = {47,65},},28,nil,"Alliance"}, -- kortas
      --[31852] = {GetMapNameByID(37) ,{6603,5},9,pfbe..pfbe..pfma,{[37] = {46,40},[689] = {47,26},[14] = {45,85},},37,nil,"Alliance"}, -- steven
      --[31851] = {GetMapNameByID(673),{6603,6},11,pfhu..pffl..pffl,{[673] = {51,73},[689] = {44,79},[14] = {44,94},},673,nil,"Alliance"}, -- bill
      --[31913] = {GetMapNameByID(38) ,{6603,10},16,pffl..pfwa..pfbe,{[38] = {76,41},[14] = {54,79},},38,nil,"Alliance"}, -- everessa
      --[31910] = {GetMapNameByID(26) ,{6603,7},13,pfcr..pfbe..pfma,{[26] = {62,54},[14] = {54,41},},26,nil,"Alliance"}, -- david
      --[31780] = {GetMapNameByID(39) ,{6603,1},3,pfme..pffl..pfcr,{[39] = {61,19},[14] = {42,77},},39,nil,"Alliance"}, -- mcdonald
      --[31916] = {GetMapNameByID(32) ,{6603,11},19,pfel..pfun..pfun,{[32] = {40,77},[14] = {49,82},},32,tx_bagicon},
      --[31911] = {GetMapNameByID(23) ,{6603,8},14,pfbe..pfbe..pfun,{[23] = {67,54},[14] = {57,32},},23,nil,"Alliance"}, -- deiza
     -- Timeless Isle --
      [33222] = {GetMapNameByID(951),"Little Tommy",125,pfbe,{[951] = {35,60},[862] = {88,71},[806] = {91,94},},951,nil},
      [33137] = {8410,"",25,"",{[951] = {35,60},[862] = {88,71},[806] = {91,94},},951,nil},
      --8410
     -- Elite Pets --
      [epspecial..1] = {GetMapNameByID(806),ep_quest_missing,125,pfcr,{[806] = {48,71},[862] = {68,61},},806,ep_icon}, -- Kawi I
      [epspecial..2] = {GetMapNameByID(809),ep_quest_missing,125,pfbe,{[809] = {35,56},[862] = {39,32},[810] = {77,33}},809,ep_icon}, -- kafi I
      [epspecial..3] = {GetMapNameByID(809),ep_quest_missing,125,pfwa,{[809] = {68,85},[862] = {52,44},[806] = {12,33}},809,ep_icon}, -- dos ryga I
      [epspecial..4] = {GetMapNameByID(806),ep_quest_missing,125,pfcr,{[806] = {57,29},[862] = {72,42},},806,ep_icon}, -- Nitun I
      [epspecial..5] = {GetMapNameByID(807),ep_quest_missing,125,pfbe,{[807] = {25,78},[862] = {45,73},[857] = {26,27},[858] = {83,66}},807,ep_icon}, -- Greyhoof II
      [epspecial..6] = {GetMapNameByID(807),ep_quest_missing,125,pfcr,{[807] = {40,43},[862] = {49,65},[858] = {94,41}},807,ep_icon}, -- Lucky Yi II
      [epspecial..7] = {GetMapNameByID(857),ep_quest_missing,125,pfwa,{[857] = {36,37},[862] = {48,76},[858] = {91,75},[807] = {36,90},},857,ep_icon}, -- xia II
      [epspecial..8] = {GetMapNameByID(858),ep_quest_missing,125,pfbe,{[858] = {26,50},[862] = {25,68},},858,ep_icon}, -- Gorespine III
      [epspecial..9] = {GetMapNameByID(811),ep_quest_missing,125,pfwa,{[811] = {11,70},[862] = {42,57},[858] = {73,18}, [807] = {12,13},},811,ep_icon}, -- no-no III
     [epspecial..10] = {GetMapNameByID(810),ep_quest_missing,125,pfwa,{[810] = {72,80},[862] = {37,50},[809] = {30,98}},810,ep_icon}, -- ti'un III
    -- Events
    
    -- Darkmoon Fairie
      [32175] = {"|TInterface\\icons\\INV_Misc_Eye_01:12|t "..CALENDAR_FILTER_DARKMOON,"Jeremy Feasel",25,pfma..pfme..pfbe,{[823] = {47,60}}, 823},
	  [36471] = {"|TInterface\\icons\\INV_Misc_Eye_01:12|t "..CALENDAR_FILTER_DARKMOON,"Christoph VonFeasel",25,pfma..pfbe..pfbe,{[823] = {47,60}}, 823}
      }
    
--- Elite pets methods ---
local ep_books = { { index = -1, qname = "", completed = false, pets = {1,2,3,4}, questID = 32604},
				   { index = -1, qname = "", completed = false, pets = {5,6,7},   questID = 32868},
                   { index = -1, qname = "", completed = false, pets = {8,9,10},  questID = 32869}
                 }


local function EP_resetbooks()
 table.foreach(ep_books, function(k,v)
  v.index = -1
  v.completed = false
 end)
end

local function EP_GetBook_pet(pet)
 if type(pet) ~= "number" then
  pet = tonumber(pet)
 end

 if pet < 1 or pet > 10 then return nil end
 
 if pet <= 4 then
  return ep_books[1] 
 elseif pet <= 7 then
  return ep_books[2]
 else
  return ep_books[3]
 end
end
  
local function EP_GetBook_index(id)
 if id == "I" then
  return ep_books[1]
 elseif id == "II" then
  return ep_books[2]
 elseif id == "III" then
  return ep_books[3]
 else return nil
 end
end

local function EP_iscriteriacompleted(pet)
 local result = false
 local book = EP_GetBook_pet(pet)
 if book and not book.completed and book.index > -1 then
  local _,_,done = GetQuestLogLeaderBoard(pet - (book.pets[1] - 1), book.index)
  result = done
 end
 return result
end

local function EP_match_questID(arg)
 table.foreach(ep_books, function(k,v)
  if v.questID == arg then
   return v
  end
 end)
end

local function getelitepetname(pet)
 local desc
 local book = EP_GetBook_pet(pet)
 if book and book.index > -1 then
  desc,_,_ = GetQuestLogLeaderBoard(pet - (book.pets[1] - 1),book.index)
  return desc
 end
end
----------------------------

-- check for active world events
local function AddWorldEventTamers()
 local result = false
 local i
 local _,_,today = CalendarGetDate()
 for i = 1,CalendarGetNumDayEvents(0,today) do
  local title = CalendarGetDayEvent(0, today, i)
  table.foreach(WEtable,function(k,v)
  if title == k then
    if not tables[SAT][WEheader] then tables[SAT][WEheader] = {} end
    table.foreach(v, function(_,questID)
     if not tContains(tables[SAT][WEheader], questID) then
      table.insert(tables[SAT][WEheader],questID)
      result = true
     end
    end)
   end
  end)
 end
 return result
end

-- I had to move the tables generation in the PLAYER_ENTERING_WORLD event
-- because, as patch 5.2 came out, the achievement criterias were no more available
-- on login
local function GenerateTables()
local result = false
 if WEtable == nil then
  WEtable = {}
  WEtable[CALENDAR_FILTER_DARKMOON] = {32175,36471}
  -- future world event tamers here
  result = true
 end

  -- Resolve Achievement Criterias
  table.foreach(questsdata, function(quest, v)
   if type(v[ZONE]) == "table" then
    v[ZONE] = GetAchievementCriteriaInfo(v[ZONE][1],v[ZONE][2])
   end
   if type(v[NPCNAME]) == "table" then
    v[NPCNAME] = GetAchievementCriteriaInfo(v[NPCNAME][1],v[NPCNAME][2])
   end
   -- celestial tournament hack
   if type(v[ZONE]) == "number" then
    v[ZONE] = "|cff55AACC"..select(2,GetAchievementInfo(v[ZONE])).."|r"
   end
   --if type(v[NPCNAME]) == "number" then
    --v[NPCNAME] = select(8,GetAchievementInfo(v[NPCNAME]))
   --end
  end)
 
 if tables[SAT] == nil then
 tables[SAT] = {
              -- Draenor --
               [select(2,GetAchievementInfo(9724))] = 
                 {37201,37203,37205,37208,37206,37207},
			   [GetMapNameByID(945)] = {39157,39160,39161,39162,39163,39164,39165,39166,39167,39168,39169,39170,39171,39172,39173},
			   [GARRISON_LOCATION_TOOLTIP] = {36483,36662,38299,38300},
               }
  AddWorldEventTamers()
  generatezonetomaptable(tables[SAT])
  result = true
 end

 if tables[ONC] == nil then
 ep_header = select(2,GetAchievementInfo(8080)).." "
 tables[ONC] = {
              -- Outlands --
               [select(2,GetAchievementInfo(6604))] = 
               {31923,31925,31924,31922},
              -- Northrend --
               [select(2,GetAchievementInfo(6605))] = 
               {31931,31934,31932,31933},
              -- Cataclysm --
               [select(2,GetAchievementInfo(7525))] = 
               {31973,31972,31974},
              -- Elite Pets --
               [ep_header.."I"] = 
                 {epspecial..1,epspecial..2,
                  epspecial..3,epspecial..4},
               [ep_header.."II"] = 
			     {epspecial..5,epspecial..6,
                  epspecial..7},
               [ep_header.."III"] = 
				  {epspecial..8,epspecial..9,
				  epspecial..10} }
  generatezonetomaptable(tables[ONC])
  result = true
 end
 if tables[EKK] == nil then
 tables[EKK] =  {
 
              -- Pandaren Spirits --
               [select(2,GetAchievementInfo(7936))] = 
                 {32434,32439,32441,32440},
              -- Pandaria Satchels --
               [select(2,GetAchievementInfo(6606))] = 
                 {31957,31991,31956,31955,31954,31953,31958},
               [GetMapNameByID(951)] = {33137,33222},

              -- Other Satchels --
               [select(2,GetAchievementInfo(6607))] = 
                 {31935,31926,31916,31909,31971},
 
              -- Horde only (Kalimdor) --
                [select(2,GetAchievementInfo(6602)).." ("..FACTION_HORDE..")"] =
                 {31854,31904,31819,31908,31905,31906,31872,31871,31907,31862,31818},
              -- Alliance only (Eastern Kingdoms) --
                [select(2,GetAchievementInfo(6603)).." ("..FACTION_ALLIANCE..")"] =
                 {31851,31910,31911,31914,31850,31913,31693,31912,31781,31780,31852} }
  generatezonetomaptable(tables[EKK])
  result = true
 end

 return result
end

local function GenerateLine(questID)
    local s1 = "";
    if not questsdata[questID] then return "<quest data missing>" end

    -- npc level
    if DailyTamerCheck_Options["show_npclevel"] and questsdata[questID][NPCLEVEL] then
     s1 = s1..levelformat(questsdata[questID][NPCLEVEL])
    end
    -- npc pets
    if DailyTamerCheck_Options["show_npcicons"] and questsdata[questID][NPCICONS] then
     s1 = s1..questsdata[questID][NPCICONS].." "
    end
    -- zone name
    if questsdata[questID][ZONE] then
     s1 = s1..AddColor(questsdata[questID][ZONE],zonecolor)
    else
     s1 = s1.."<zone missing>"
    end
    -- npc name
    if DailyTamerCheck_Options["show_npcnames"] and questsdata[questID][NPCNAME] then
     s1 = s1.." "..AddColor(questsdata[questID][NPCNAME],npcnamecolor)
    end
    -- coordinates
    if DailyTamerCheck_Options["show_coordinates"] then
     s1 = s1.." "..AddColor(coord(questID),coordcolor)
    end
    return s1
end

local function isquestcompleted(questID)
 local result = false
 if tostring(questID):find(epspecial) then
  result = EP_iscriteriacompleted(string.gsub(tostring(questID), epspecial, ""))
 else
  result = IsQuestFlaggedCompleted(questID)
 end
 return result
end

-- main "tooltip template" frame
local function DrawTCheckMainframe(obj, tab, istooltip)
 if AddWorldEventTamers() then
  generatezonetomaptable(tables[SAT])
 end
 obj:ClearLines()
 obj:AddDoubleLine("Daily Tamer Check","|T"..dtcicon..":32|t")
 local s1,s2
  table.foreach(tab,function(k,v)
  --min width
   obj:AddLine("                                                      ")
   obj:AddLine(k)
   table.foreach(v,
            function(i,questID)
            if factioncheck(questID) then
             s2 = isquestcompleted(questID) and AddColor(COMPLETE,LIGHT_GREEN) or AddColor(INCOMPLETE,LIGHT_RED)
             s1 = GenerateLine(questID)    
             obj:AddDoubleLine(s1,s2)
            end
        end)
  end)
  if not istooltip then
  -- create some space for the bottom buttons
   obj:AddLine(" ")
   obj:AddLine(" ")
   obj:AddLine(" ")
   if TomTom then
    obj:AddLine(" ")
   end
  end
end

-- lateral frames
local function DrawTCheckFrame(obj, tab)
 local s1,s2
 local tmpleft  = ""
 local tmpright = ""
 obj.maxwidth = 1

 local function adddoubleline(left,right)
  tmpleft  = tmpleft.."\n"..left
  tmpright = tmpright.."\n"..right
  
  local lefttmp
  lefttmp = string.gsub(left,"|c........","")
  lefttmp = string.gsub(lefttmp,"|r","")
  obj.leftfont:SetText(lefttmp..right)
  local tmplen = obj.leftfont:GetStringWidth(obj.leftfont)+40
  if (tmplen > obj.maxwidth) then
   obj.maxwidth = tmplen
  end
 end

  table.foreach(tab,function(k,v)
   adddoubleline("","")
   if k:find(ep_header) then -- elite pets special
    local book = EP_GetBook_index(string.gsub(k, ep_header, ""))
    if IsQuestFlaggedCompleted(book.questID) then
     s2 = AddColor(COMPLETE,LIGHT_GREEN)
     book.completed = true
    else
     s2 = AddColor(INCOMPLETE,LIGHT_RED)
    end
    adddoubleline(AddColor(book.qname ~= "" and book.qname or k,GOLD).." "..s2,"")
   else
    adddoubleline(AddColor(k,GOLD),"")
   end
   local wrotesomething = false
   local qmissing = true
   table.foreach(v,
           function(_,questID)
            if factioncheck(questID) then
         -- elite pets special
            if tostring(questID):find(epspecial) then
             local book = EP_GetBook_pet(string.gsub(questID,epspecial,""))
             if book ~= nil then
              if not book.completed and book.index > -1 then
               s2 = isquestcompleted(questID) and AddColor(COMPLETE,LIGHT_GREEN) or AddColor(INCOMPLETE,LIGHT_RED)
               s1 = GenerateLine(questID,info)
               adddoubleline(s1,s2)
              elseif book.index == -1 and not book.completed and qmissing then
               qmissing = false
               adddoubleline(ep_quest_missing,"")
              end
             end
            else
             s2 = isquestcompleted(questID) and AddColor(COMPLETE,LIGHT_GREEN) or AddColor(INCOMPLETE,LIGHT_RED)
             s1 = GenerateLine(questID,info)
             adddoubleline(s1,s2)
            end
            wrotesomething = true
            end
        end)
       if not wrotesomething then
        adddoubleline(AddColor(ADDON_DISABLED,LIGHT_RED),"")
       end
   end)

 obj.leftfont:SetText(tmpleft)
 obj.rightfont:SetText(tmpright)
 obj.maxwidth = math.max(100, obj.leftfont:GetWidth() + obj.rightfont:GetWidth() + 30)
 obj:SetHeight(math.max(DailyTamerCheck_mainframe:GetHeight(), obj.leftfont:GetHeight() + 30))
 
 --obj.leftfont:SetText(tmpleft)
 --obj.rightfont:SetText(tmpright)
end

local function CheckFramesAnimation(frame,id)
 if (frame) and (frame:IsVisible()) and (frame.maxwidth ~= nil) and (frame.width ~= nil) and (frame.opening ~= nil) then
  if frame.opening then
   if frame.width < frame.maxwidth then
    frame.width = frame.width + opt_framespeed
    if id == ABOUT then
     frame:SetHeight(frame.width)
    else
     frame:SetWidth(frame.width)
    end
   elseif (not frame.leftfont:IsVisible()) then
    frame.leftfont:Show()
    frame.rightfont:Show()
   end
  else -- closing
   if frame.width > opt_framespeed then
    frame.width = frame.width - opt_framespeed
    if id == ABOUT then
     frame:SetHeight(frame.width)
    else
     frame:SetWidth(frame.width)
    end
    if (frame.leftfont:IsVisible()) then
     frame.leftfont:Hide()
     frame.rightfont:Hide()
    end
   else
    frame:Hide()
   end
  end
 end
end

local function OnOptionChanged(opt)
 if opt == "show_npclevel" then
  table.foreach(tables, function(_,x)
   table.foreach(x, function(k,v)
    table.sort(v,function (a,b)
     if (DailyTamerCheck_Options["show_npclevel"]) then    
      if (questsdata[a][NPCLEVEL] and questsdata[b][NPCLEVEL]) then
       return questsdata[a][NPCLEVEL] < questsdata[b][NPCLEVEL]
      end
      else
       return a < b
     end
    end)
   end)
  end)
 end
end

local ID_MINIMAP_SPECIAL = 99
local function CreateCheckbox(parent,id,option,mo_tooltip,tx,offsetX,offsetY)

 local chkbox

 local function setcheckboxtexture(flag)
  local shaderSupported = chkbox.texture:SetDesaturated(not flag);
  if not shaderSupported then
   if not flag then
     chkbox.texture:SetVertexColor(0.5, 0.5, 0.5);
   else
     chkbox.texture:SetVertexColor(1.0, 1.0, 1.0);
   end
  end
 end

  if not parent.checkbox[id] then
   chkbox = CreateFrame("FRAME", nil, parent.optionsframe)
   chkbox.texture = chkbox:CreateTexture()
  else 
   chkbox = parent.checkbox[id]
  end

  chkbox:SetPoint("CENTER", parent.optionsframe, "CENTER",offsetX,offsetY)
  --chkbox:SetFrameStrata("HIGH")
  chkbox:SetWidth(20)
  chkbox:SetHeight(20)
  chkbox.texture:SetPoint("LEFT", chkbox, "LEFT")
  chkbox.texture:SetTexture(tx)
  chkbox.texture:SetWidth(20)
  chkbox.texture:SetHeight(20)
  if id == ID_MINIMAP_SPECIAL then
   setcheckboxtexture(not DailyTamerCheck_Options["minimap_icon"].hide)
  else
   setcheckboxtexture(DailyTamerCheck_Options[option])
  end

  chkbox:SetScript("OnMouseUp", function(self)
   if id == ID_MINIMAP_SPECIAL then -- it's pretty rough.. I know :p
    DailyTamerCheck_Options["minimap_icon"].hide = not DailyTamerCheck_Options["minimap_icon"].hide;
    ldbicon:Refresh("DailyTamerCheck", DailyTamerCheck, DailyTamerCheck_Options["minimap_icon"])
    setcheckboxtexture(not DailyTamerCheck_Options["minimap_icon"].hide)
   else
    DailyTamerCheck_Options[option] = not DailyTamerCheck_Options[option]
    OnOptionChanged(option)
    DrawTCheckMainframe(DailyTamerCheck_mainframe,tables[SAT],false)
    setcheckboxtexture(DailyTamerCheck_Options[option])
    DailyTamerCheck_mainframe:Show()
   end
  end)
  
  chkbox:SetScript("OnEnter", function(self)
   GameTooltip:SetOwner(chkbox,"ANCHOR_BOTTOM",0,-5)
   GameTooltip:ClearLines()
   GameTooltip:AddLine(mo_tooltip)
   GameTooltip:Show()
  end)  

  chkbox:SetScript("OnLeave", function(self)
   GameTooltip:Hide()
  end)
  
  parent.checkbox[id] = chkbox
  chkbox:Hide()
end --CreateCheckBox

local function CreateNewFrameButton(id,pos,tx)
local result, button
 if not DailyTamerCheck_mainframe.buttons[id] then
  button = CreateFrame("FRAME", nil, DailyTamerCheck_mainframe)
 else button = DailyTamerCheck_mainframe.buttons[id]
 end
 if not button.texture then
  button.texture = button:CreateTexture()
 end
 if not DailyTamerCheck_mainframe.frames[id] then
  result = CreateFrame("Frame")
 else result = DailyTamerCheck_mainframe.frames[id]
 end
 result:SetParent(DailyTamerCheck_mainframe)
 result:SetBackdrop(frames_backdrop);
 result:SetBackdropColor(0,0,0,0.8);
 if not result.leftfont then
  result.leftfont = result:CreateFontString(nil, "OVERLAY", "GameTooltipText")
 end
 result.leftfont:SetParent(result)
 result.leftfont:SetPoint("TOPLEFT",10,-10)
 if not result.rightfont then
  result.rightfont = result:CreateFontString(nil, "OVERLAY", "GameTooltipText")
 end
 result.rightfont:SetParent(result)
 result.rightfont:SetPoint("TOPRIGHT",-10,-10)
 result.width = 1
 if id == ABOUT then
   result.leftfont:SetText(AddColor(" Daily Tamer Check ",GOLD).."\n"..
                                         AddColor(" by\n",GREY)..
                                         AddColor(" Jadya",LIGHT_BLUE)..
                                         AddColor(" EU-Well of Eternity",GREY))
   result.rightfont:SetText("|T"..dtcicon..":24|t\n")
   result.maxwidth = 140
  else
   result.maxwidth = 200
  end

 result.leftfont:Hide()
 result.rightfont:Hide()

 result:SetFrameStrata("DIALOG")
 result:SetScale(0.9)
 result:SetClampedToScreen(true)
 result:ClearAllPoints()
 if pos == "left" then
   result:SetPoint("RIGHT", DailyTamerCheck_mainframe, "LEFT")
  --result:SetPoint("TOPRIGHT", DailyTamerCheck_mainframe, "TOPLEFT")
  --result:SetPoint("BOTTOMRIGHT", DailyTamerCheck_mainframe, "BOTTOMLEFT")
 elseif pos == "right" then
 result:SetPoint("LEFT", DailyTamerCheck_mainframe, "RIGHT")
  --result:SetPoint("TOPLEFT", DailyTamerCheck_mainframe, "TOPRIGHT")
  --result:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMRIGHT")
 elseif pos == "bottomright" or pos == "bottomleft" then
  result:SetPoint("TOPLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT")
  result:SetPoint("TOPRIGHT", DailyTamerCheck_mainframe, "BOTTOMRIGHT")
 end
 -- frame's opening/closing animation
 result:SetScript("OnUpdate", function(self)
   CheckFramesAnimation(result,id)
  end)

  if pos == "left" then
   button:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT",10,10)
  elseif pos == "right" then
   button:SetPoint("BOTTOMRIGHT", DailyTamerCheck_mainframe, "BOTTOMRIGHT",-10,10)
  elseif pos == "bottomright" then
   button:SetPoint("BOTTOM", DailyTamerCheck_mainframe, "BOTTOM",centerbuttons_spacing,10)
  elseif pos == "bottomleft" then
   button:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT",45,10)
  end
  button:SetWidth(25)
  button:SetHeight(25)
  button.texture:SetAllPoints()
  button.texture:SetTexture(tx)

  button:SetScript("OnEnter", function(self)
  result.opening = true
  result:SetWidth(result.width)
  if id == EKK or id == ONC then
   DrawTCheckFrame(result,tables[id])
  end
  result:Show()
 end)

  button:SetScript("OnLeave", function(self)
   if result then 
    result.opening = false 
   end
  end)

 button:Show()
 if result.opening then result:Show() else result:Hide() end
 DailyTamerCheck_mainframe.frames[id] = result;
 DailyTamerCheck_mainframe.buttons[id] = button;
end --CreateNewFrameButton

local function tamerquestcheck()
if DailyTamerCheck_mainframe and DailyTamerCheck_mainframe:IsVisible() then
 DailyTamerCheck_mainframe:Hide()
 if DTCMenuFrame then DTCMenuFrame:Hide() end
 collectgarbage()
else
  if not DailyTamerCheck_mainframe then
   DailyTamerCheck_mainframe = CreateFrame("GameTooltip", "DailyTamerCheck_mainframe", UIParent, "GameTooltipTemplate")
   DailyTamerCheck_mainframe:EnableMouse(true)
   DailyTamerCheck_mainframe:SetMovable(true)
   DailyTamerCheck_mainframe:RegisterForDrag("LeftButton")
   DailyTamerCheck_mainframe:SetScript("OnDragStart", function(self)  
		self:StartMoving()
   end)
   DailyTamerCheck_mainframe:SetScript("OnDragStop", function(self) 
		self:StopMovingOrSizing()
		local a1, _, a2, x, y = DailyTamerCheck_mainframe:GetPoint()
        DailyTamerCheck_Options["frame_position"] = {a1, p, a2, x, y}
   end)
  end
 
  DailyTamerCheck_mainframe:SetOwner(UIParent,"ANCHOR_NONE")
  local a1, _, a2, x, y = unpack(DailyTamerCheck_Options["frame_position"] or {})
  if not a1 then 
   DailyTamerCheck_mainframe:SetPoint("CENTER")
  else
   DailyTamerCheck_mainframe:SetPoint(a1, UIParent, a2, x, y)
  end
  DailyTamerCheck_mainframe:SetFrameStrata("HIGH")
  --DailyTamerCheck_mainframe:SetScale(0.9)

  if not DailyTamerCheck_mainframe.buttons then
   DailyTamerCheck_mainframe.buttons  = {}
  end
  if not DailyTamerCheck_mainframe.frames then
   DailyTamerCheck_mainframe.frames = {}
  end
  CreateNewFrameButton(EKK,"left",tx_btnkalim)
  CreateNewFrameButton(ONC,"right",tx_btnnorth)
  CreateNewFrameButton(ABOUT,"bottomright",tx_btnabout)
  
   -- options' checkboxes
   if not DailyTamerCheck_mainframe.optionsframe then
    DailyTamerCheck_mainframe.optionsframe = CreateFrame("FRAME", nil, DailyTamerCheck_mainframe)
    DailyTamerCheck_mainframe.optionsframe.texture = DailyTamerCheck_mainframe.optionsframe:CreateTexture()
    --DailyTamerCheck_mainframe.optionsframe:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT",45,10)
    DailyTamerCheck_mainframe.optionsframe:SetPoint("BOTTOM",DailyTamerCheck_mainframe,"BOTTOM",-centerbuttons_spacing,10)
    DailyTamerCheck_mainframe.optionsframe:SetWidth(25)
    DailyTamerCheck_mainframe.optionsframe:SetHeight(25)
    DailyTamerCheck_mainframe.optionsframe.texture:SetAllPoints()
    DailyTamerCheck_mainframe.optionsframe.texture:SetTexture(tx_optionsframe)
    DailyTamerCheck_mainframe.optionsframe:SetScript("OnLeave", function(self)
     GameTooltip:Hide()
    end)
    DailyTamerCheck_mainframe.optionsframe:SetScript("OnEnter", function(self)
     GameTooltip:SetOwner(DailyTamerCheck_mainframe.optionsframe,"ANCHOR_TOP",0,5)
     GameTooltip:ClearLines()
     GameTooltip:AddLine(s_optionsmain)
     GameTooltip:Show()
    end)
    
    DailyTamerCheck_mainframe.optionsframe:SetScript("OnMouseUp", function(self)
     if not DailyTamerCheck_mainframe.optionsframe.open then
      table.foreach(DailyTamerCheck_mainframe.checkbox, function(k,v) if not v:IsVisible() then v:Show() end end)
      DailyTamerCheck_mainframe.optionsframe.open = true;
      DailyTamerCheck_mainframe.optionsframe.texture:SetVertexColor(0.5,1,0.5,1)
     else
      table.foreach(DailyTamerCheck_mainframe.checkbox, function(k,v) if v:IsVisible() then v:Hide() end end)
      DailyTamerCheck_mainframe.optionsframe.open = false;
      DailyTamerCheck_mainframe.optionsframe.texture:SetVertexColor(1,1,1,1)
     end
    end)
   end
   DailyTamerCheck_mainframe.optionsframe.texture:SetVertexColor(1,1,1,1)
   DailyTamerCheck_mainframe.optionsframe.open = false;
   if not DailyTamerCheck_mainframe.checkbox then DailyTamerCheck_mainframe.checkbox = {} end
   CreateCheckbox(DailyTamerCheck_mainframe,0,"show_coordinates",
                         s_togglecoords,tx_chkcoords,-20,-25)
   CreateCheckbox(DailyTamerCheck_mainframe,1,"show_npcnames",
                         s_togglenpcnames,tx_chknames,0,-25)
CreateCheckbox(DailyTamerCheck_mainframe,2,"show_npclevel",
                         s_togglenpclevel,tx_chklevel,40,-25)
CreateCheckbox(DailyTamerCheck_mainframe,3,"show_npcicons",
                         s_togglenpcicons,tx_chkicons,-40,-25)
CreateCheckbox(DailyTamerCheck_mainframe,4,"show_mapicons",
                         s_togglemapicons,tx_chkmapicons,0,-45)
CreateCheckbox(DailyTamerCheck_mainframe,5,"show_faction",
                         s_showfaction,tx_faction[playerfaction == "Alliance" and "Horde" or "Alliance"],-20,-45)
   CreateCheckbox(DailyTamerCheck_mainframe,ID_MINIMAP_SPECIAL,"",
                         s_toggleminimapbtn,tx_chkminimap,20,-25)

 DrawTCheckMainframe(DailyTamerCheck_mainframe,tables[SAT],false)

 if not btnclose then
  btnclose = CreateFrame("Button", "dtcclosebtn", DailyTamerCheck_mainframe, "UIPanelButtonTemplate")
  btnclose:SetPoint("BOTTOM", DailyTamerCheck_mainframe, "BOTTOM",0,10)
  btnclose:SetWidth(100)
  btnclose:SetText(CLOSE)
  btnclose:SetScript("OnClick", function(self)
  if DailyTamerCheck_mainframe.frames then
   table.foreach(DailyTamerCheck_mainframe.frames,function(k,v) v:Hide() end)
  end
  DailyTamerCheck_mainframe:Hide()
  if DTCMenuFrame then DTCMenuFrame:Hide() end
  collectgarbage()
 end)
 end

-- TomTom Integration --
 if TomTom and DTCMenuFrame then
   local function CreateSubMenu(q)  
    local submenu = {}
    table.foreach(q, function(_,questID)
     if questsdata[questID] then
      table.insert(submenu, { text = questsdata[questID][NPCNAME].." - "..questsdata[questID][ZONE].." "..coord(questID),
                              disabled = isquestcompleted(questID),
                              notCheckable = 1,
                              keepShownOnClick = true,
                       func = function(self)
                               if questsdata[questID][MAPDATA] then
                                 TomTom:AddMFWaypoint(questsdata[questID][MAPDEFAULT], nil,
                                          questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][1] / 100,
                                          questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][2] / 100,
                                          { title = questsdata[questID][NPCNAME]})
                                 print(s_tomtomset.." ("..AddColor(questsdata[questID][NPCNAME],LIGHT_BLUE)..")")
                               end
                              end
                              })
     end
    end)
    return submenu
   end

  DTCTTmenu = {}
  table.insert(DTCTTmenu, {text = AddColor("- TomTom Waypoints -",GOLD),notCheckable = 1, isTitle = true})
  table.insert(DTCTTmenu, {text = AddColor("Click either a single quest or a group",LIGHT_BLUE),notCheckable = 1, isTitle = true})
  table.insert(DTCTTmenu, {text = AddColor("to set TomTom waypoints",LIGHT_BLUE),notCheckable = 1, isTitle = true})
  table.insert(DTCTTmenu, {text = "",notCheckable = 1, isTitle = true})

  table.foreach(tables, function(k,tab)
   local pref = k == SAT and "|T"..tx_bagicon..":12|t" or ""
   table.foreach(tab, function(header,quests)
    table.insert(DTCTTmenu, { text = pref..header,
                              keepShownOnClick = true,
                              notCheckable = 1,
                       func = function(self)
                               table.foreach(quests, function(_,questID)
                                if questsdata[questID][MAPDATA] and not isquestcompleted(questID) then
                                 TomTom:AddMFWaypoint(questsdata[questID][MAPDEFAULT], nil,
                                          questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][1] / 100,
                                          questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][2] / 100,
                                          { title = questsdata[questID][NPCNAME] } )
                                 print(s_tomtomset.." ("..AddColor(questsdata[questID][NPCNAME],LIGHT_BLUE)..")")
                                end
                               end)
                              end,
                       hasArrow = true, 
		               menuList = CreateSubMenu(quests)})
   end)
  end)
  table.insert(DTCTTmenu, {text = "", isTitle = true, notCheckable = 1})
  table.insert(DTCTTmenu, {text = "Close", notCheckable = 1})

  DailyTamerCheck_mainframe.Itomtomframe = CreateFrame("FRAME", nil, DailyTamerCheck_mainframe)
  DailyTamerCheck_mainframe.Itomtomframe:SetPoint("BOTTOMLEFT",DailyTamerCheck_mainframe,"BOTTOMLEFT",5,40)
  DailyTamerCheck_mainframe.Itomtomframe:SetWidth(60)
  DailyTamerCheck_mainframe.Itomtomframe:SetHeight(25)
  DailyTamerCheck_mainframe.Itomtomframe.text = DailyTamerCheck_mainframe.Itomtomframe:CreateFontString(nil, "OVERLAY")
  DailyTamerCheck_mainframe.Itomtomframe.text:SetAllPoints()
  DailyTamerCheck_mainframe.Itomtomframe.text:SetFont("Fonts\\FRIZQT__.TTF", 12)
  DailyTamerCheck_mainframe.Itomtomframe.text:SetText("TomTom")
  DailyTamerCheck_mainframe.Itomtomframe:SetBackdrop(frames_backdrop);
  DailyTamerCheck_mainframe.Itomtomframe:SetBackdropColor(1,0,0.3,1);
  DailyTamerCheck_mainframe.Itomtomframe:SetScript("OnLeave", function(self)
     GameTooltip:Hide()
    end)
    DailyTamerCheck_mainframe.Itomtomframe:SetScript("OnEnter", function(self)
     GameTooltip:SetOwner(DailyTamerCheck_mainframe.Itomtomframe,"ANCHOR_TOP",0,5)
     GameTooltip:ClearLines()
     GameTooltip:AddLine(s_tomtomintegration)
     GameTooltip:Show()
    end)
  DailyTamerCheck_mainframe.Itomtomframe:SetScript("OnMouseUp", function()
    if DTCMenuFrame then
     if DTCMenuFrame:IsVisible() then
      DTCMenuFrame:Hide()
     end
     DTCMenuFrame:SetPoint("TOP",DailyTamerCheck_mainframe.Itomtomframe,"BOTTOM",0,-5)
     EasyMenu(DTCTTmenu, DTCMenuFrame, DTCMenuFrame, 0 , 0, "MENU")
    end
    end)
 end
--
 
 DailyTamerCheck_mainframe:Show()
 -------------------------
end
end

--- world map section
DailyTamerCheck_mapframe = CreateFrame("Frame")
DailyTamerCheck_mapframe:SetParent(WorldMapButton)
DailyTamerCheck_mapframe:SetAllPoints()
DailyTamerCheck_mapframe.framespool = {}
CreateFrame("GameTooltip","DailyTamerCheck_maptooltip", nil, "GameTooltipTemplate")
DailyTamerCheck_maptooltip:SetFrameStrata("TOOLTIP")
DailyTamerCheck_maptooltip:SetScale(0.8)

local function createmapbutton()
 local f = CreateFrame("FRAME")
 f:SetParent(DailyTamerCheck_mapframe)
 f:SetPoint("CENTER",DailyTamerCheck_mapframe,"CENTER")
 f.data = {}
 f:SetScript("OnMouseUp", function(_, mousebutton)
   --if IsControlKeyDown() and mousebutton == "LeftButton" then
    -- actually TomTom can set waypoints by Ctrl-Rightclicking, so no need of it
    --return
   --end
   WorldMapButton_OnClick(WorldMapButton, mousebutton)
  end)
 f:SetScript("OnEnter", function()
  DailyTamerCheck_maptooltip:SetOwner(f,"ANCHOR_BOTTOM")
  DailyTamerCheck_maptooltip:ClearLines()
  DailyTamerCheck_maptooltip:AddLine((questsdata[f.data][NPCNAME] ~= nil and questsdata[f.data][NPCLEVEL] ~= nil) and levelformat(questsdata[f.data][NPCLEVEL]).." "..questsdata[f.data][NPCNAME] or "")
  DailyTamerCheck_maptooltip:AddLine(questsdata[f.data][NPCICONS] ~= nil and questsdata[f.data][NPCICONS] or "")
  DailyTamerCheck_maptooltip:Show()
 end)
 f:SetScript("OnLeave", function()
  DailyTamerCheck_maptooltip:Hide()
 end)
 f.tex = f:CreateTexture()
 f.tex:SetAllPoints()
 table.insert(DailyTamerCheck_mapframe.framespool,f)
 return f
end

local mapID
local active_buttons = 1
local function DTCworldmapupdate()
  DailyTamerCheck_mapframe:Hide()
  DailyTamerCheck_maptooltip:Hide()

 local d = GetCurrentMapDungeonLevel()

  -- no tamers in the cosmic map or in dungeons, no needs of dtc updates if the map is not visible
  if not DailyTamerCheck_Options["show_mapicons"] or GetCurrentMapContinent() == WORLDMAP_COSMIC_ID 
     or d ~= 0 or not WorldMapButton:IsVisible() then
   return
  end
  if mapID ~= GetCurrentMapAreaID() then
   for k,v in pairs(DailyTamerCheck_mapframe.framespool) do
    v:Hide()
   end
   active_buttons = 1
   mapID = GetCurrentMapAreaID()
   if mapstable[mapID] then
    table.foreach(mapstable[mapID], function(_,v)
     if not isquestcompleted(v) and questsdata[v] then
      if questsdata[v][MAPDATA] and questsdata[v][MAPDATA][mapID] and factioncheck(v) then
       local tex = questsdata[v][MAPICON] and questsdata[v][MAPICON] or dtcicon
       -- pick up an unused frame or create a new one
       local f = DailyTamerCheck_mapframe.framespool[active_buttons] ~= nil and DailyTamerCheck_mapframe.framespool[active_buttons] or createmapbutton()
       local x = questsdata[v][MAPDATA][mapID][1]
       local y = questsdata[v][MAPDATA][mapID][2]
       f:SetWidth(questsdata[v][MAPDEFAULT] == mapID and 22 or 14)
       f:SetHeight(questsdata[v][MAPDEFAULT] == mapID and 22 or 14)
       f:SetPoint("CENTER",DailyTamerCheck_mapframe,"TOPLEFT",
         -- I simply treat coordinates as a percentage of the width/height of the map frame
              DailyTamerCheck_mapframe:GetWidth()  * x / 100,
             -DailyTamerCheck_mapframe:GetHeight() * y / 100)
       f.data = v
       f.tex:SetTexture(tex,1)
       f:Show()
       active_buttons = active_buttons + 1
      end
     end
    end)
   end
  end

  if active_buttons > 1 then
   DailyTamerCheck_mapframe:Show()
  end
end

-- resizing the map through those buttons does not fire the world_map_update event,
-- even if that changes the mapID to the player's current map, so I hook them
WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MinimizeButton:HookScript("OnClick", DTCworldmapupdate)
WorldMapFrame.BorderFrame.MaximizeMinimizeFrame.MaximizeButton:HookScript("OnClick", DTCworldmapupdate)
--- world map section end

local ldbset = false
local epnameset = {}
local eventframe = CreateFrame("FRAME","DTCEventFrame")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:RegisterEvent("VARIABLES_LOADED")
eventframe:RegisterEvent("QUEST_LOG_UPDATE")
eventframe:RegisterEvent("WORLD_MAP_UPDATE")
local function eventhandler(self, event, ...)
 if event=="WORLD_MAP_UPDATE" and WorldMapFrame:IsVisible() then
  DTCworldmapupdate()
 elseif event == "QUEST_LOG_UPDATE" then -- elite pets check
  local i, j, s, book
  EP_resetbooks()
  for i = 1, GetNumQuestLogEntries() do
   book = nil
   s = GetQuestLink(i)
   if s then
   table.foreach(ep_books, function(k,v)
     if tonumber(string.match(s, "Hquest:(%d+)")) == v.questID then
      book = v
     end
    end)
   end

   if book then
    book.index = i
    book.qname = select(1,GetQuestLogTitle(book.index))
	for _,j in pairs(book.pets) do
     if not epnameset[j] then
      local petname = getelitepetname(j)
      if petname ~= nil then
       questsdata[epspecial..j][NPCNAME] = petname
       epnameset[j] = true
      end
     end
    end
   end -- quest found
  end
 elseif event == "PLAYER_ENTERING_WORLD" then
  OpenCalendar()
  if GenerateTables() then
   -- initial sorting
   OnOptionChanged("show_npclevel")
   --
  end
  --eventframe:UnregisterEvent("PLAYER_ENTERING_WORLD")
 elseif event == "VARIABLES_LOADED" then
  if DailyTamerCheck_Options == nil then
   DailyTamerCheck_Options = {}
  end
  if DailyTamerCheck_Options["show_coordinates"] == nil then -- show coords
   DailyTamerCheck_Options["show_coordinates"] = false
  end
  if DailyTamerCheck_Options["show_npcnames"] == nil then -- show npcnames
   DailyTamerCheck_Options["show_npcnames"] = false
  end
  if DailyTamerCheck_Options["show_npclevel"] == nil then -- sort by pet level
   DailyTamerCheck_Options["show_npclevel"] = false
  end
  if DailyTamerCheck_Options["show_npcicons"] == nil then -- show pet icons
   DailyTamerCheck_Options["show_npcicons"] = false
  end
  if DailyTamerCheck_Options["show_mapicons"] == nil then -- show world map icons
   DailyTamerCheck_Options["show_mapicons"] = false
  end
  if DailyTamerCheck_Options["show_faction"] == nil then -- show other faction tamers
   DailyTamerCheck_Options["show_faction"] = true
  end
  --- TomTom integration ---
  if TomTom then
   CreateFrame("Frame", "DTCMenuFrame", UIParent, "UIDropDownMenuTemplate")
  end
  ---
  
  -- Frame position --
  if DailyTamerCheck_Options["frame_position"] == nil then
   DailyTamerCheck_Options["frame_position"] = {"CENTER"}
  end
  --
  
  if DailyTamerCheck_Options["minimap_icon"] == nil then -- show minimap icon
    DailyTamerCheck_Options["minimap_icon"] = {
        hide = false,
        minimapPos = 220,
    }
  end
  if DailyTamerCheck_Options["DTC_Version"] == nil then -- addon version
   DailyTamerCheck_Options["DTC_Version"] = 0
  end
  DailyTamerCheck_Options["DTC_Version"] = DTCversion

  if ldb and not ldbset then
        local DailyTamerCheck = ldb:NewDataObject("DailyTamerCheck", {
	        type = "data source",
	        icon = dtcicon,
	        label = "Daily Tamer Check",
	        OnClick = function(self,button)
                tamerquestcheck()
	        end,
	        OnTooltipShow = function(tooltip)
		    DrawTCheckMainframe(tooltip,tables[SAT],true)
	    end,
        })
        if ldbicon then
            ldbicon:Register("DailyTamerCheck", DailyTamerCheck, DailyTamerCheck_Options["minimap_icon"])
        end
   ldbset = true;
  end

 end
end
eventframe:SetScript("OnEvent", eventhandler);
-- slash command
SLASH_DAILYTAMERCHECK1 = "/dtcheck"
SLASH_DAILYTAMERCHECK2 = "/dtc"
SlashCmdList["DAILYTAMERCHECK"] = tamerquestcheck
