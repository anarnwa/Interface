--[[
************************************************************************
ToyDB.lua
************************************************************************
File date: 2019-11-28T2:02:16Z
File hash: 7965d53
Project hash: 7965d53
Project version: 8.2.5.2
************************************************************************
Please see http://www.wowace.com/addons/collectinator/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]] --

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Libraries
local table = _G.table

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub	= _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-------------------------------------------------------------------------------
-- Filter flags. Acquire types, and Reputation levels.
-------------------------------------------------------------------------------
local F = private.FILTER_IDS
local A = private.ACQUIRE_TYPES
local Q = private.ITEM_QUALITIES
local REP = private.REP_LEVELS
local FAC = private.FACTION_IDS
local V = private.GAME_VERSIONS
local Z = private.ZONE_NAMES
local PROF = private.LOCALIZED_PROFESSION_NAMES

--------------------------------------------------------------------------------------------------------------------
-- Initialize!
--------------------------------------------------------------------------------------------------------------------


function addon:InitToys()
	local function AddToy(spell_id, genesis, quality)
		return addon:AddCollectable(spell_id, "TOY", genesis, quality)
	end

	local toy

-- World of Warcraft Classic
	-- Orb of Deception -- 1973
	toy = AddToy(1973, V.ORIG, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_DROP)
	toy:AddWorldDrop(Z.KALIMDOR, Z.EASTERN_KINGDOMS)

	-- Piccolo of the Flaming Fire -- 13379
	toy = AddToy(13379, V.ORIG, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(10558)

	-- Winter Veil Disguise Kit -- 17712
	toy = AddToy(17712, V.ORIG, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddQuest(6983, 7043)

	-- Snowmaster 9000 -- 17716
	toy = AddToy(17716, V.ORIG, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- World Enlarger -- 18660
	toy = AddToy(18660, V.ORIG, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Dimensional Ripper - Everlook -- 18984
	toy = AddToy(18984, V.ORIG, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Ultrasafe Transporter: Gadgetzan -- 18986
	toy = AddToy(18986, V.ORIG, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Elune's Lantern -- 21540
	toy = AddToy(21540, V.ORIG, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddQuest(8868)

-- The Burning Crusade
	-- Crashin' Thrashin' Robot -- 23767
	toy = AddToy(23767, V.TBC, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Dimensional Ripper - Area 52 -- 30542
	toy = AddToy(30542, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Ultrasafe Transporter: Toshley's Station -- 30544
	toy = AddToy(30544, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Power Converter -- 30690
	toy = AddToy(30690, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:AddQuest(10675)

	-- Imp in a Ball -- 32542
	toy = AddToy(32542, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Picnic Basket -- 32566
	toy = AddToy(32566, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Time-Lost Figurine -- 32782
	toy = AddToy(32782, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(21838)

	-- Murloc Costume -- 33079
	toy = AddToy(33079, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROMO)
	toy:AddCustom("BLIZZCON")

	-- Goblin Gumbo Kettle -- 33219
	toy = AddToy(33219, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Fishing Chair -- 33223
	toy = AddToy(33223, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Brewfest Pony Keg -- 33927
	toy = AddToy(33927, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(23710, 24495, 27478, 27489)
	toy:AddWorldEvent("BREWFEST")

	-- Romantic Picnic Basket -- 34480
	toy = AddToy(34480, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("LOVE_IS_IN_THE_AIR")
	toy:AddCustom("CITY")

	-- Paper Flying Machine Kit -- 34499
	toy = AddToy(34499, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Brazier of Dancing Flames -- 34686
	toy = AddToy(34686, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("MIDSUMMER_FIRE_FESTIVAL")
	toy:AddCustom("CITY")

	-- Goblin Weather Machine - Prototype 01-B -- 35227
	toy = AddToy(35227, V.TBC, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Orb of the Sin'dorei -- 35275
	toy = AddToy(35275, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.INSTANCE, F.MOB_DROP)
	toy:AddWorldDrop(Z.MAGISTERS_TERRACE)
	toy:AddCustom("HEROIC")

	-- Crashin' Thrashin' Racer Controller -- 37710
	toy = AddToy(37710, V.TBC, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddQuest(6983, 7043)

	-- D.I.S.C.O. -- 38301
	toy = AddToy(38301, V.TBC, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

-- Wrath of the Lich King
	-- Worn Troll Dice -- 36862
	toy = AddToy(36862, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.MISC)
	toy:AddCustom("PICKPOCKET")

	-- Decahedral Dwarven Dice -- 36863
	toy = AddToy(36863, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.MISC)
	toy:AddCustom("PICKPOCKET")

	-- Super Simian Sphere -- 37254
	toy = AddToy(37254, V.WOTLK, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_DROP)
	toy:AddWorldDrop(Z.NORTHREND)

	-- Rope Pet Leash -- 37460
	toy = AddToy(37460, V.WOTLK, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(28951)

	-- The Flag of Ownership -- 38578
	toy = AddToy(38578, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- MOLL-E -- 40768
	toy = AddToy(40768, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Gnomish X-Ray Specs -- 40895
	toy = AddToy(40895, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Iron Boot Flask -- 43499
	toy = AddToy(43499, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29744, 30472)

	-- The Schools of Arcane Magic - Mastery -- 43824
	toy = AddToy(43824, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(1956)

	-- Titanium Seal of Dalaran -- 44430
	toy = AddToy(44430, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(2096)

	-- Toy Train Set -- 44606
	toy = AddToy(44606, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Frenzyheart Brew -- 44719
	toy = AddToy(44719, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(31911)
	toy:AddCustom("DISGUSTING_JAR")

	-- Red Ribbon Pet Leash -- 44820
	toy = AddToy(44820, V.WOTLK, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(28951)

	-- Stormwind Banner -- 45011
	toy = AddToy(45011, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(33307)

	-- Thunder Bluff Banner -- 45013
	toy = AddToy(45013, V.WOTLK, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(33556)

	-- Orgrimmar Banner -- 45014
	toy = AddToy(45014, V.WOTLK, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(33553)

	-- Sen'jin Banner -- 45015
	toy = AddToy(45015, V.WOTLK, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(33554)

	-- Undercity Banner -- 45016
	toy = AddToy(45016, V.WOTLK, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(33555)

	-- Silvermoon City Banner -- 45017
	toy = AddToy(45017, V.WOTLK, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(33557)

	-- Ironforge Banner -- 45018
	toy = AddToy(45018, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(33310)

	-- Gnomeregan Banner -- 45019
	toy = AddToy(45019, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(33650)

	-- Exodar Banner -- 45020
	toy = AddToy(45020, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(33657)

	-- Darnassus Banner -- 45021
	toy = AddToy(45021, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(33653)

	-- Wind-Up Train Wrecker -- 45057
	toy = AddToy(45057, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Foam Sword Rack -- 45063
	toy = AddToy(45063, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Unusual Compass -- 45984
	toy = AddToy(45984, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.FISHING)
	toy:AddCustom("FISHING_DAILIES")

	-- Ogre Pinata -- 46780
	toy = AddToy(46780, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG", "BMAH")

	-- Argent Crusader's Banner -- 46843
	toy = AddToy(46843, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(34885)

	-- Wormhole Generator: Northrend -- 48933
	toy = AddToy(48933, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Perpetual Purple Firework -- 49703
	toy = AddToy(49703, V.WOTLK, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Carved Ogre Idol -- 49704
	toy = AddToy(49704, V.WOTLK, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- The Heartbreaker -- 50471
	toy = AddToy(50471, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.MOB_DROP, F.IBOP, F.WORLD_EVENTS)
	toy:AddMobDrop(36296)
	toy:AddWorldEvent("LOVE_IS_IN_THE_AIR")

	-- Muradin's Favor -- 52201
	toy = AddToy(52201, V.WOTLK, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.QUEST)
	toy:AddQuest(24917)

	-- Sylvanas' Music Box -- 52253
	toy = AddToy(52253, V.WOTLK, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.QUEST)
	toy:AddQuest(24918)

	-- Instant Statue Pedestal -- 54212
	toy = AddToy(54212, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Blue Crashin' Thrashin' Racer Controller -- 54343
	toy = AddToy(54343, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Tiny Green Ragdoll -- 54437
	toy = AddToy(54437, V.WOTLK, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Tiny Blue Ragdoll -- 54438
	toy = AddToy(54438, V.WOTLK, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Ethereal Portal -- 54452
	toy = AddToy(54452, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Gnomeregan Pride -- 54651
	toy = AddToy(54651, V.WOTLK, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP)
	toy:SetRequiredFaction("Alliance")
	toy:Retire()

	-- Darkspear Pride -- 54653
	toy = AddToy(54653, V.WOTLK, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP)
	toy:SetRequiredFaction("Horde")
	toy:Retire()

-- Cataclysm
	-- Gnomish Gravity Well -- 40727
	toy = AddToy(40727, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- MiniZep Controller -- 46709
	toy = AddToy(46709, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddQuest(6983, 7043)

	-- Faded Wizard Hat -- 53057
	toy = AddToy(53057, V.CATA, Q.COMMON)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(14392)

	-- Loot-A-Rang -- 60854
	toy = AddToy(60854, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Tol Barad Searchlight -- 63141
	toy = AddToy(63141, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.VENDOR, F.REPUTATION, F.IBOP, F.CATACOMMON2)
	toy:AddRepVendor(FAC.BARADINS_WARDENS, REP.HONORED, 47328)

	-- Loaded Gnomish Dice -- 63269
	toy = AddToy(63269, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_DROP, F.MISC)
	toy:AddWorldDrop(Z.TOL_BARAD, Z.TWILIGHT_HIGHLANDS)
	toy:AddCustom("PICKPOCKET")

	-- Highborne Soul Mirror -- 64358
	toy = AddToy(64358, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Druid and Priest Statue Set -- 64361
	toy = AddToy(64361, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Chalice of the Mountain Kings -- 64373
	toy = AddToy(64373, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Kaldorei Wind Chimes -- 64383
	toy = AddToy(64383, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Arrival of the Naaru -- 64456
	toy = AddToy(64456, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Blessing of the Old God -- 64481
	toy = AddToy(64481, V.CATA, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Puzzle Box of Yogg-Saron -- 64482
	toy = AddToy(64482, V.CATA, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- The Innkeeper's Daughter -- 64488
	toy = AddToy(64488, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Bones of Transformation -- 64646
	toy = AddToy(64646, V.CATA, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Wisp Amulet -- 64651
	toy = AddToy(64651, V.CATA, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Pendant of the Scarab Storm -- 64881
	toy = AddToy(64881, V.CATA, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Tol Barad Searchlight -- 64997
	toy = AddToy(64997, V.CATA, Q.RARE)
	toy:AddFilters(F.HORDE, F.VENDOR, F.REPUTATION, F.IBOP, F.CATACOMMON2)
	toy:AddRepVendor(FAC.HELLSCREAMS_REACH, REP.HONORED, 48531)

	-- Stave of Fur and Claw -- 66888
	toy = AddToy(66888, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TIMBERMAW_HOLD, F.VENDOR)
	toy:AddRepVendor(FAC.TIMBERMAW_HOLD, REP.EXALTED, 11557)

	-- Grim Campfire -- 67097
	toy = AddToy(67097, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Kalytha's Haunted Locket -- 68806
	toy = AddToy(68806, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(36375)

	-- War Party Hitching Post -- 69215
	toy = AddToy(69215, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Fool's Gold -- 69227
	toy = AddToy(69227, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Vrykul Drinking Horn -- 69775
	toy = AddToy(69775, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Ancient Amber -- 69776
	toy = AddToy(69776, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Haunted War Drum -- 69777
	toy = AddToy(69777, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Green Balloon -- 69895
	toy = AddToy(69895, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(52358, 52809)
	toy:AddWorldEvent("CHILDRENS_WEEK")

	-- Yellow Balloon -- 69896
	toy = AddToy(69896, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(52358, 52809)
	toy:AddWorldEvent("CHILDRENS_WEEK")

	-- Mylune's Call -- 70159
	toy = AddToy(70159, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(53882)

	-- Mushroom Chair -- 70161
	toy = AddToy(70161, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(53881)

	-- Little Wickerman -- 70722
	toy = AddToy(70722, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(53728, 53757)
	toy:AddWorldEvent("HALLOWS_END")

	-- Brewfest Keg Pony -- 71137
	toy = AddToy(71137, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(23710, 24495, 27478, 27489)
	toy:AddWorldEvent("BREWFEST")

	-- Leyara's Locket -- 71259
	toy = AddToy(71259, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(29311)

	-- Sack of Starfish -- 71628
	toy = AddToy(71628, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Magical Ogre Idol -- 72159
	toy = AddToy(72159, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Spurious Sarcophagus -- 72161
	toy = AddToy(72161, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Flimsy Yellow Balloon -- 75042
	toy = AddToy(75042, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(55305)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Demon Hunter's Aspect -- 79769
	toy = AddToy(79769, V.CATA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

-- Mists of Pandaria
	-- The Golden Banana -- 80822
	toy = AddToy(80822, V.MOP, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30675)

	-- Ruthers' Harness -- 82467
	toy = AddToy(82467, V.MOP, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30930)

	-- Anglers Fishing Raft -- 85500
	toy = AddToy(85500, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.REPUTATION, FAC.THE_ANGLERS)
	toy:AddRepVendor(FAC.THE_ANGLERS, REP.REVERED, 63721)

	-- Ancient Pandaren Fishing Charm -- 85973
	toy = AddToy(85973, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.VALLEY_OF_THE_FOUR_WINDS, nil, "46.1:29.1")

	-- Battle Horn -- 86565
	toy = AddToy(86565, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(51059, 72875)

	-- Mr. Smite's Brass Compass -- 86568
	toy = AddToy(86568, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50336)

	-- Kang's Bindstone -- 86571
	toy = AddToy(86571, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50349)

	-- Shard of Archstone -- 86573
	toy = AddToy(86573, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50354)

	-- Chalice of Secrets -- 86575
	toy = AddToy(86575, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50359)

	-- Eternal Warrior's Signil -- 86578
	toy = AddToy(86578, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50739)

	-- Farwater Conch -- 86581
	toy = AddToy(86581, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50769)

	-- Aqua Jewel -- 86582
	toy = AddToy(86582, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50780)

	-- Salyin Battle Banner -- 86583
	toy = AddToy(86583, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50783)

	-- Hardened Shell -- 86584
	toy = AddToy(86584, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50789)

	-- Panflute of Pandaria -- 86586
	toy = AddToy(86586, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50806)

	-- Pandaren Firework Launcher -- 86588
	toy = AddToy(86588, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50817)

	-- Ai-Li's Skymirror - 86589
	toy = AddToy(86589, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50821)

	-- Essence of the Breeze - 86590
	toy = AddToy(86590, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50822)

	-- Hozen Beach Ball -- 86593
	toy = AddToy(86593, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50836)

	-- Helpful Wikky's Whistle -- 86594
	toy = AddToy(86594, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50840)

	-- Nat's Fishing Chair -- 86596
	toy = AddToy(86596, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(7274)

	-- Blingtron 4000 -- 87214
	toy = AddToy(87214, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Wormhole Generator: Pandaria -- 87215
	toy = AddToy(87215, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Honorary Brewmaster Keg -- 87528
	toy = AddToy(87528, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(7385)

	-- Puntable Marmot -- 88370
	toy = AddToy(88370, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(29910)

	-- Turnip Punching Bag -- 88375
	toy = AddToy(88375, V.MOP, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(29944)

	-- Turnip Paint "Gun" -- 88377
	toy = AddToy(88377, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(29945)

	-- Silversage Incense -- 88381
	toy = AddToy(88381, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30617)

	-- Hozen Idol -- 88385
	toy = AddToy(88385, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30599)

	-- Shushen's Spittoon -- 88387
	toy = AddToy(88387, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30169)

	-- Gokk'lok's Shell -- 88417
	toy = AddToy(88417, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(31083)

	-- Lao Chin's Last Mug -- 88531
	toy = AddToy(88531, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.QUEST)
	toy:AddQuest(30991)

	-- Krastinov's Bag of Horrors -- 88566
	toy = AddToy(88566, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(59369)

	-- Jin Warmkeg's Brew -- 88579
	toy = AddToy(88579, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30682)

	-- Ken-Ken's Mask -- 88580
	toy = AddToy(88580, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30090)

	-- Totem of Harmony -- 88584
	toy = AddToy(88584, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(30783)

	-- Cremating Torch -- 88589
	toy = AddToy(88589, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(31032)

	-- Flippable Table -- 88801
	toy = AddToy(88801, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(64395)

	-- Foxicopter Controller -- 88802
	toy = AddToy(88802, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(55143)

	-- Chain Pet Leash -- 89139
	toy = AddToy(89139, V.MOP, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("PET_SUPPLY_BAGS")

	-- Mini Mana Bomb -- 89205
	toy = AddToy(89205, V.WOD, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP)
	toy:Retire()

	-- Cloud Ring -- 89222
	toy = AddToy(89222, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.REPUTATION, F.ORDER_OF_THE_CLOUD_SERPENT)
	toy:AddRepVendor(FAC.ORDER_OF_THE_CLOUD_SERPENT, REP.REVERED, 58414)

	-- Anatomical Dummy -- 89614
	toy = AddToy(89614, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Pandaren Scarecrow -- 89869
	toy = AddToy(89869, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.REPUTATION, F.THE_TILLERS)
	toy:AddRepVendor(FAC.THE_TILLERS, REP.REVERED, 58706)

	-- Everlasting Alliance Firework -- 89999
	toy = AddToy(89999, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Everlasting Horde Firework -- 90000
	toy = AddToy(90000, V.MOP, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- B. F. F. Necklace -- 90067
	toy = AddToy(90067, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(66900)

	-- Gin-Ji Knife Set -- 90175
	toy = AddToy(90175, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.REPUTATION, F.THE_TILLERS)
	toy:AddRepVendor(FAC.THE_TILLERS, REP.EXALTED, 58706)

	-- Pandaren Brewpack -- 90427
	toy = AddToy(90427, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(23710, 24495, 27478, 27489)
	toy:AddWorldEvent("BREWFEST")

	-- The Pigskin -- 90883
	toy = AddToy(90883, V.MOP, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Foot Ball -- 90888
	toy = AddToy(90888, V.MOP, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Darkmoon Whistle -- 90899
	toy = AddToy(90899, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(14828)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Stackable Stag -- 91904
	toy = AddToy(91904, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(55143)

	-- Safari Hat -- 92738
	toy = AddToy(92738, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(7499)

	-- Dark Portal -- 93672
	toy = AddToy(93672, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.TCG)
	toy:AddCustom("TCG")

	-- Kirin Tor Beacon -- 95567
	toy = AddToy(95567, V.MOP, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:AddQuest(32681)

	-- Sunreaver Beacon -- 95568
	toy = AddToy(95568, V.MOP, Q.COMMON)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(32680)

	-- Glorious Standard of the Kirin Tor Offensive -- 95589
	toy = AddToy(95589, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:AddQuest(32599)

	-- Glorious Standard of the Sunreaver Onslaught -- 95590
	toy = AddToy(95590, V.MOP, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(32589)

	-- Whole-Body Shrinka' -- 97919
	toy = AddToy(97919, V.MOP, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:SetRequiredFaction("Horde")
	toy:Retire()

	-- Sen'jin Spirit Drum -- 97942
	toy = AddToy(97942, V.MOP, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:SetRequiredFaction("Horde")
	toy:Retire()

	-- Darkmoon Seesaw -- 97994
	toy = AddToy(97994, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(14828)

	-- Shado-Pan Geyser Gun -- 98132
	toy = AddToy(98132, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOA, F.MISC)
	toy:AddCustom("GEYSER_GUN")

	-- Gastropod Shell -- 98136
	toy = AddToy(98136, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOA, F.MOB_DROP)
	toy:AddMobDrop(68220)

	-- Xan'tish's Flute -- 98552
	toy = AddToy(98552, V.MOP, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:SetRequiredFaction("Horde")
	toy:Retire()

	-- Moonfang Shroud -- 101571
	toy = AddToy(101571, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.MOB_DROP, F.WORLD_EVENTS)
	toy:AddMobDrop(71992)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Censer of Eternal Agony -- 102467
	toy = AddToy(102467, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOA, F.MOB_DROP)
	toy:AddVendor(73307)

	-- Celestial Defender's Medallion -- 103685
	toy = AddToy(103685, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.EMPEROR_SHAOHAO)
	toy:AddRepVendor(FAC.EMPEROR_SHAOHAO, REP.REVERED, 73306)

	-- Odd Polished Stone -- 104262
	toy = AddToy(104262, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(72809, 72970)

	-- Rime of the Time-Lost Mariner -- 104294
	toy = AddToy(104294, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(73281)

	-- Blackflame Daggers -- 104302
	toy = AddToy(104302, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(73171)

	-- Eternal Kiln -- 104309
	toy = AddToy(104309, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(72896)

	-- Crashin' Thrashin' Flyer Controller -- 104318
	toy = AddToy(104318, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC, F.WORLD_EVENTS)
	toy:AddCustom("WINTERVEIL_GIFT")

	-- The Pigskin -- 104323
	toy = AddToy(104323, V.MOP, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Foot Ball -- 104324
	toy = AddToy(104324, V.MOP, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 29716, 52358, 52809)

	-- Ash-Covered Horn -- 104329
	toy = AddToy(104329, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(72898)

	-- Warning Sign -- 104331
	toy = AddToy(104331, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(73169)

	-- Moonfang's Paw -- 105898
	toy = AddToy(105898, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.MOB_DROP, F.WORLD_EVENTS)
	toy:AddMobDrop(71992)
	toy:AddWorldEvent("DARKMOON_FAIRE")

-- Warlords of Draenor
	-- Crashin' Thrashin' Roller Controller -- 108631
	toy = AddToy(108631, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(98283)

	-- Crashin' Thrashin' Flamer Controller -- 108632
	toy = AddToy(108632, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Crashin' Thrashin' Cannon Controller -- 108633
	toy = AddToy(108633, V.WOD, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(98284)

	-- Crashin' Thrashin' Mortar Controller -- 108634
	toy = AddToy(108634, V.WOD, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(98285)

	-- Crashin' Thrashin' Killdozer Controller -- 108635
	toy = AddToy(108635, V.WOD, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Arena Master's War Horn -- 108735
	toy = AddToy(108735, V.WOD, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.FROSTFIRE_RIDGE, nil, "23.1:25.0")

	-- Pretty Draenor Pearl -- 108739
	toy = AddToy(108739, V.WOD, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.QUEST, F.PROFESSION)
	toy:AddQuest(34907)
	toy:AddProfession(PROF.FISHING)

	-- Deceptia's Smoldering Boots -- 108743
	toy = AddToy(108743, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TALADOR, nil, "58.9:12.0")

	-- Personal Hologram -- 108745
	toy = AddToy(108745, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Findle's Loot-A-Rang -- 109167
	toy = AddToy(109167, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- World Shrinker -- 109183
	toy = AddToy(109183, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Star Chart -- 109739
	toy = AddToy(109739, V.MOP, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.SHADOWMOON_VALLEY_DRAENOR, nil, "49.5:37.5")

	-- Stolen Breath -- 111476
	toy = AddToy(111476, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(78867)

	-- Blingtron 5000 -- 111821
	toy = AddToy(111821, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Wormhole Centrifuge -- 112059
	toy = AddToy(112059, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Nightmarish Hitching Post -- 112324
	toy = AddToy(112324, V.WOD, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.STORE)
	toy:AddCustom("STORE")

	-- Bloodmane Charm -- 113096
	toy = AddToy(113096, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddLimitedVendor(82459, 1, 84243, 1)

	-- Vindicator's Armor Polish Kit -- 113375
	toy = AddToy(113375, V.WOD, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.SHADOWMOON_VALLEY_DRAENOR, nil, "51.1:79.1")

	-- Ba'ruun's Bountiful Bloom -- 113540
	toy = AddToy(113540, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(82326)

	-- Whispers of Rai'Vosh -- 113542
	toy = AddToy(113542, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(82374)

	-- Spirit of Shinri -- 113543
	toy = AddToy(113543, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(82415)

	-- Ancient's Bloom -- 113570
	toy = AddToy(113570, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(75435)

	-- Hypnosis Goggles -- 113631
	toy = AddToy(113631, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(79524)

	-- Mournful Moan of Murmur -- 113670
	toy = AddToy(113670, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(77828)

	-- Bubble Wand -- 114227
	toy = AddToy(114227, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(80725)

	-- Permanent Frost Essence -- 115468
	toy = AddToy(115468, V.WOD, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR, F.DRAENORCOMMON2)
	toy:AddRepVendor(FAC.FROSTWOLF_ORCS, REP.HONORED, 86036)

	-- Permanent Time Bubble -- 115472
	toy = AddToy(115472, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR, F.DRAENORCOMMON2)
	toy:AddRepVendor(FAC.COUNCIL_OF_EXARCHS, REP.HONORED, 85932)

	-- Blazing Diamond Pendant -- 115503
	toy = AddToy(115503, V.WOD, Q.UNCOMMON)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(36380)
	toy:AddProfession(PROF.JEWELCRAFTING)

	-- Treessassin's Guise -- 115506
	toy = AddToy(115506, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("LUMBER_MILL")

	-- Ring of Broken Promises -- 116067
	toy = AddToy(116067, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP, F.WORLD_EVENTS)
	toy:AddMobDrop(85531)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Breath of Talador -- 116113
	toy = AddToy(116113, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(77719)

	-- Blazing Wings -- 116115
	toy = AddToy(116115, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9252)

	-- Tasty Talador Lunch -- 116120
	toy = AddToy(116120, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TALADOR, nil, "57.4:28.7")

	-- Burning Legion Missive -- 116122
	toy = AddToy(116122, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(78710, 78713, 78715)

	-- Klikixx's Webspinner -- 116125
	toy = AddToy(116125, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(78872)

	-- Haunting Memento -- 116139
	toy = AddToy(116139, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddWorldEvent("DARKMOON_FAIRE")
	toy:AddVendor(85484)

	-- Silver-Plated Turkey Shooter -- 116400
	toy = AddToy(116400, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("PILGRIMS_BOUNTY")
	toy:AddCustom("PILGRIMS_BOUNTY")

	-- Cozy Bonfire -- 116435
	toy = AddToy(116435, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("MIDSUMMER_FIRE_FESTIVAL")
	toy:AddCustom("CITY")

	-- Burning Defender's Medallion -- 116440
	toy = AddToy(116440, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("MIDSUMMER_FIRE_FESTIVAL")
	toy:AddCustom("CITY")

	-- Scroll of Storytelling -- 116456
	toy = AddToy(116456, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddQuest(6983, 7043)

	-- True Love Prism -- 116651
	toy = AddToy(116651, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("LOVE_IS_IN_THE_AIR")
	toy:AddCustom("CITY")

	-- Pineapple Lounge Cushion -- 116689
	toy = AddToy(116689, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Safari Lounge Cushion -- 116690
	toy = AddToy(116690, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Zhevra Lounge Cushion -- 116691
	toy = AddToy(116691, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Fuzzy Green Lounge Cushion -- 116692
	toy = AddToy(116692, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Steamworks Sausage Grill -- 116757
	toy = AddToy(116757, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(23710, 24495, 27478, 27489)
	toy:AddWorldEvent("BREWFEST")

	-- Brewfest Banner -- 116758
	toy = AddToy(116758, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(23710, 24495, 27478, 27489)
	toy:AddWorldEvent("BREWFEST")

	-- Crashin' Thrashin' Shredder Controller -- 116763
	toy = AddToy(116763, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOE, F.WORLD_EVENTS, F.MISC)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- "Blooming Rose" Contender's Costume -- 116856
	toy = AddToy(116856, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DAY_OF_THE_DEAD")
	toy:AddCustom("CHAPMAN")

	-- "Night Demon" Contender's Costume -- 116888
	toy = AddToy(116888, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DAY_OF_THE_DEAD")
	toy:AddCustom("CHAPMAN")

	-- "Purple Phantom" Contender's Costume -- 116889
	toy = AddToy(116889, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DAY_OF_THE_DEAD")
	toy:AddCustom("CHAPMAN")

	-- "Santo's Sun" Contender's Costume -- 116890
	toy = AddToy(116890, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DAY_OF_THE_DEAD")
	toy:AddCustom("CHAPMAN")

	-- "Snowy Owl" Contender's Costume -- 116891
	toy = AddToy(116891, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DAY_OF_THE_DEAD")
	toy:AddCustom("CHAPMAN")

	-- Angry Beehive -- 117550
	toy = AddToy(117550, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.SHADOWMOON_VALLEY_DRAENOR, nil, "55.3:74.8")

	-- Giant Deathweb Egg -- 117569
	toy = AddToy(117569, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TALADOR, nil, "66.5:89.9")

	-- Wayfarer's Bonfire -- 117573
	toy = AddToy(117573, V.WOD, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Archmage Vargoth's Spare Staff -- 118191
	toy = AddToy(118191, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddGarrisonMission(330)

	-- Petrification Stone -- 118221
	toy = AddToy(118221, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(85250)

	-- Spirit of Bashiok -- 118222
	toy = AddToy(118222, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(82085)

	-- Ogre Brewing Kit -- 118224
	toy = AddToy(118224, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(79629)

	-- Iron Buccaneer's Hat -- 118244
	toy = AddToy(118244, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(79725)

	-- Autographed Hearthstone Card -- 118427
	toy = AddToy(118427, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Goren Garb -- 118716
	toy = AddToy(118716, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.GORGROND, nil, "48.9:47.3")

	-- Ever-Blooming Frond -- 118935
	toy = AddToy(118935, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Gamon's Braid -- 118937
	toy = AddToy(118937, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Manastorm's Duplicator -- 118938
	toy = AddToy(118938, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Mystery Keg -- 119001
	toy = AddToy(119001, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddQuest(37287, 37292)

	-- Void Totem -- 119003
	toy = AddToy(119003, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Lilian's Warning Sign -- 119039
	toy = AddToy(119039, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Fruit Basket -- 119083
	toy = AddToy(119083, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("INN")

	-- Moroes' Famous Polish -- 119092
	toy = AddToy(119092, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddCustom("INN")

	-- Aviana's Feather -- 119093
	toy = AddToy(119093, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddCustom("INN")

	-- Sargerei Disguise -- 119134
	toy = AddToy(119134, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(35195)

	-- Touch of the Naaru -- 119144
	toy = AddToy(119144, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:AddQuest(36169)

	-- Firefury Totem -- 119145
	toy = AddToy(119145, V.WOD, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(32985)

	-- Tickle Totem -- 119160
	toy = AddToy(119160, V.WOD, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR, F.DRAENORCOMMON3)
	toy:AddRepVendor(FAC.LAUGHING_SKULL_ORCS, REP.HONORED, 86698)
	toy:AddCustom("TRADING_POST")

	-- Soul Inhaler -- 119163
	toy = AddToy(119163, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(82618)

	-- Black Whirlwind -- 119178
	toy = AddToy(119178, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(85026)

	-- Goren "Log" Roller -- 119180
	toy = AddToy(119180, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(87352)

	-- Soul Evacuation Crystal -- 119182
	toy = AddToy(119182, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP)
	toy:AddRepVendor(FAC.SHATARI_DEFENSE, REP.HONORED, 85427)
	toy:AddCustom("TRADING_POST")

	-- Hearthstone Board -- 119210
	toy = AddToy(119210, V.WOD, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(88779)

	-- Winning Hand -- 119212
	toy = AddToy(119212, V.WOD, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(88779)

	-- Robo-Gnomebulator -- 119215
	toy = AddToy(119215, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9673)

	-- Alliance Flag of Victory -- 119217
	toy = AddToy(119217, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9639)
	toy:AddCustom("GLADIATORS_SANCTUM")

	-- Horde Flag of Victory -- 119218
	toy = AddToy(119218, V.WOD, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9639)
	toy:AddCustom("GLADIATORS_SANCTUM")

	-- Warlord's Flag of Victory -- 119219
	toy = AddToy(119219, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9725)
	toy:AddCustom("GLADIATORS_SANCTUM")

	-- Sha'tari Defender's Medallion -- 119421
	toy = AddToy(119421, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR, F.DRAENORCOMMON3)
	toy:AddRepVendor(FAC.SHATARI_DEFENSE, REP.REVERED, 85427)

	-- Botani Camouflage -- 119432
	toy = AddToy(119432, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(86257)

	-- Outrider's Bridle Chain -- 120276
	toy = AddToy(120276, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(81330)

	-- Barrel of Bandanas -- 120857
	toy = AddToy(120857, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:SetRequiredClass("Rogue")
	toy:AddVendor(83006)

	-- Cursed Feather of Ikzan -- 122117
	toy = AddToy(122117, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(90777)

	-- Everlasting Darkmoon Firework -- 122119
	toy = AddToy(122119, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9764)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Gaze of the Darkmoon -- 122120
	toy = AddToy(122120, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9785)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Darkmoon Gazer -- 122121
	toy = AddToy(122121, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9811)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Darkmoon Tonk Controller -- 122122
	toy = AddToy(122122, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9885)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Darkmoon Ring-Flinger -- 122123
	toy = AddToy(122123, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9894)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Attraction Sign -- 122126
	toy = AddToy(122126, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9792)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Fire-Eater's Vial -- 122129
	toy = AddToy(122129, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT, F.WORLD_EVENTS)
	toy:AddAchievement(9761)
	toy:AddWorldEvent("DARKMOON_FAIRE")

	-- Rukhmar's Sacred Memory -- 122283
	toy = AddToy(122283, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:Retire()

	-- Trans-Dimensional Bird Whistle -- 122293
	toy = AddToy(122293, V.WOD, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9838)

	-- Bodyguard Miniaturization Device -- 122298
	toy = AddToy(122298, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.MISC)
	toy:AddVendor(77379, 79812)
	toy:AddCustom("BARRACKS")

	-- Fandral's Seed Pouch -- 122304
	toy = AddToy(122304, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(52571)

	-- S.E.L.F.I.E. Camera MkII -- 122674
	toy = AddToy(122674, V.WOD, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddGarrisonMission(502)

	-- Portable Audiophone -- 122700
	toy = AddToy(122700, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(9912, 9914)

	-- Photo B.O.M.B. -- 123851
	toy = AddToy(123851, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("BLINGTRON_5000")

	-- Seafarer's Slidewhistle -- 126931
	toy = AddToy(126931, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DARKMOON_FAIRE")
	toy:AddVendor(55103)

	-- Podling Camouflage -- 127394
	toy = AddToy(127394, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "64.0:42.0")

	-- Felflame Campfire -- 127652
	toy = AddToy(127652, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddMobDrop(91093)

	-- Sassy Imp -- 127655
	toy = AddToy(127655, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(90429)

	-- Ghostly Iron Buccaneer's Hat -- 127659
	toy = AddToy(127659, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddMobDrop(93076)

	-- Vial of Red Goo -- 127666
	toy = AddToy(127666, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddMobDrop(91227)

	-- Jewel of Hellfire -- 127668
	toy = AddToy(127668, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "28.73:23.3")

	-- Skull of the Mad Chief -- 127669
	toy = AddToy(127669, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "34.6:34.7")

	-- Accursed Tome of the Sargerei -- 127670
	toy = AddToy(127670, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "32.4:70.4")

	-- Spirit Wand -- 127695
	toy = AddToy(127695, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(94512, 94516, 98723, 98724)

	-- Magic Pet Mirror -- 127696
	toy = AddToy(127696, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(94512, 94516, 98723, 98724)

	-- Indestructible Bone -- 127707
	toy = AddToy(127707, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(94512, 94516, 98723, 98724)

	-- Throbbing Blood Orb -- 127709
	toy = AddToy(127709, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "26.7:44.3")

	-- The Perfect Blossom -- 127766
	toy = AddToy(127766, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "40.8:75.5")

	-- Dazzling Rod -- 127859
	toy = AddToy(127859, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "42.84:35.38")

	-- Personal Spotlight -- 127864
	toy = AddToy(127864, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddVendor(95470, 95471)

	-- Bottomless Stygana Mushroom Brew -- 128223
	toy = AddToy(128223, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "49.9:76.8")

	-- Burning Blade -- 128310
	toy = AddToy(128310, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddGarrisonMission(680)

	-- Skoller's Bag of Squirrel Treats -- 128328
	toy = AddToy(128328, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TANAAN_JUNGLE, nil, "55.1:75.0")

	-- Karabor Councilor's Attire -- 128462
	toy = AddToy(128462, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR, F.DRAENORCOMMON4)
	toy:AddRepVendor(FAC.HAND_OF_THE_PROPHET, REP.REVERED, 90974)

	-- Frostwolf Grunt's Battlegear -- 128471
	toy = AddToy(128471, V.WOD, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR, F.DRAENORCOMMON4)
	toy:AddRepVendor(FAC.VOLJINS_HEADHUNTERS, REP.REVERED, 96014)

	-- Endothermic Blaster -- 128636
	toy = AddToy(128636, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Red Wooden Sled -- 128776
	toy = AddToy(128776, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")
	toy:AddCustom("WINTERVEIL_GIFT")

	-- Sack of Spectral Spiders -- 128794
	toy = AddToy(128794, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("HALLOWS_END")
	toy:AddCustom("SPECTRAL_SPIDERS")

	-- Coin of Many Faces -- 128807
	toy = AddToy(128807, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP, F.WORLD_EVENTS)
	toy:AddMobDrop(96536, 96637)
	toy:AddWorldEvent("HALLOWS_END")

	-- Mark of the Ashtongue -- 129926
	toy = AddToy(129926, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98685)

	-- Ever-Shifting Mirror -- 129929
	toy = AddToy(129929, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98685)

	-- Will of Northrend -- 129938
	toy = AddToy(129938, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98690)

	-- Hourglass of Eternity -- 129952
	toy = AddToy(129952, V.WOD, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98690)

	-- Gurboggle's Gleaming Bauble -- 133511
	toy = AddToy(133511, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(101759, 101760)

	-- Tosselwrench's Mega-Accurate Simulation Viewfinder -- 133542
	toy = AddToy(133542, V.WOD, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(101759, 101760)

-- Legion

	-- Golden Hearthstone Card: Lord Jaraxxus -- 119211
	toy = AddToy(119211, V.LEGION, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddMobDrop(105503)

	-- Sternfathom's Pet Journal -- 122681
	toy = AddToy(122681, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.AZSUNA, nil, "49.4:45.4")

	-- Leylight Brazier -- 128536
	toy = AddToy(128536, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENCHANTING)

	-- Shoe Shine Kit -- 129055  -- Needs updating
	toy = AddToy(129055, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.DALARAN_BROKENISLES, nil, "44.8:47.3")

	-- Dalaran Disc -- 129057
	toy = AddToy(129057, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(96483)

	-- Ravenbear Disguise -- 129093
	toy = AddToy(129093, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(38317)

	-- Faintly Glowing Flagon of Mead -- 129113
	toy = AddToy(129113, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(91892)

	-- Death's Door Charm -- 129149
	toy = AddToy(129149, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VALARJAR)
	toy:AddRepVendor(FAC.VALARJAR, REP.REVERED, 106904)

	-- Barcle-Encrusted Gem -- 129165
	toy = AddToy(129165, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddGarrisonMission(1381)

	-- Steamy Romance Novel Kit -- 129211
	toy = AddToy(129211, V.LEGION, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.INSCRIPTION)

	-- Enchanted Stone Whistle -- 129279
	toy = AddToy(129279, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.COURT_OF_FARONDIS)
	toy:AddRepVendor(FAC.COURT_OF_FARONDIS, REP.HONORED, 107376)

	-- Leather Love Seat-- 129956
	toy = AddToy(129956, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.LEATHERWORKING)

	-- Leather Pet Leash -- 129958
	toy = AddToy(129958, V.LEGION, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.LEATHERWORKING)

	-- Leather Pet Bed -- 129960
	toy = AddToy(129960, V.LEGION, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.LEATHERWORKING)

	-- Flaming Hoop -- 129961
	toy = AddToy(129961, V.LEGION, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.LEATHERWORKING)

	-- Thistleleaf Branch -- 130147
	toy = AddToy(130147, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.VALSHARAH, nil, "41.0:80.0")

	-- The "Devilsaur" Lunchbox -- 130151
	toy = AddToy(130151, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddVendor(112064)

	-- Syxsehnz Rod -- 130157
	toy = AddToy(130157, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.THE_WARDENS)
	toy:AddRepVendor(FAC.THE_WARDENS, REP.HONORED, 107379)

	-- Path of Elothir -- 130158
	toy = AddToy(130158, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.DREAMWEAVERS)
	toy:AddRepVendor(FAC.DREAMWEAVERS, REP.FRIENDLY, 106901)

	-- Tournament Favor -- 130169
	toy = AddToy(130169, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddGarrisonMission(1382)

	-- Tear of the Green Aspect -- 130170
	toy = AddToy(130170, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.DREAMWEAVERS)
	toy:AddRepVendor(FAC.DREAMWEAVERS, REP.HONORED, 106901)

	-- Cursed Orb -- 130171
	toy = AddToy(130171, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(92180)

	-- Trapped Treasure Chest Kit -- 130191
	toy = AddToy(130191, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.THE_WARDENS)
	toy:AddRepVendor(FAC.THE_WARDENS, REP.HONORED, 107379)

	-- Legion Pocket Portal -- 130199
	toy = AddToy(130199, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddRepVendor(FAC.ARMIES_OF_LEGIONFALL, REP.EXALTED, 120898)

	-- Never Ending Toy Chest -- 130209
	toy = AddToy(130209, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(42722)

	-- Worn Doll -- 130214
	toy = AddToy(130214, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(95221)

	-- Moonfeather Statue -- 130232
	toy = AddToy(130232, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.DREAMWEAVERS)
	toy:AddRepVendor(FAC.DREAMWEAVERS, REP.REVERED, 106901)

	-- JewelCraft -- 130251
	toy = AddToy(130251, V.LEGION, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.JEWELCRAFTING)

	-- Chatterstone -- 130254
	toy = AddToy(130254, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.JEWELCRAFTING)

	-- Waywatcher's Boon -- 130249
	toy = AddToy(130249, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.VALSHARAH, nil, "58.2:69.8")

	-- Crystalline Eye of Undravius -- 131724
	toy = AddToy(131724, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Rocfeather Skyhorn Kite -- 131811
	toy = AddToy(131811, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.HIGHMOUNTAIN, nil, "50:58")
	toy:AddZoneLocations(Z.HIGHMOUNTAIN, nil, "47:43")
	toy:AddZoneLocations(Z.HIGHMOUNTAIN, nil, "48:51")
	toy:AddZoneLocations(Z.HIGHMOUNTAIN, nil, "54:51")

	-- Darkshard Fragment -- 131812
	toy = AddToy(131812, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.HIGHMOUNTAIN_TRIBE)
	toy:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.REVERED, 106902)

	-- Whitewater Carp -- 131814
	toy = AddToy(131814, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.HIGHMOUNTAIN_TRIBE)
	toy:AddRepVendor(FAC.HIGHMOUNTAIN_TRIBE, REP.FRIENDLY, 106902)

	-- Majestic Elderhorn Hoof -- 131900
	toy = AddToy(131900, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(96410)

	-- Critter Hand Cannon -- 131933
	toy = AddToy(131933, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(39656)

	-- Blingtron's Circuit Design Tutorial -- 132518
	toy = AddToy(132518, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ENGINEERING)

	-- Black Ice -- 133997
	toy = AddToy(133997, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(29155, 29253)

	-- Rainbow Generator -- 133998
	toy = AddToy(133998, V.LEGION, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(28288)

	-- Noble's Eternal Elementium Signet -- 134004
	toy = AddToy(134004, V.LEGION, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(18756)

	-- Eternal Black Diamond Ring -- 134007
	toy = AddToy(134007, V.LEGION, Q.COMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(18756)

	-- Don Carlos' Famous Hat -- 134019
	toy = AddToy(134019, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(28132)

	-- Chef's Hat -- 134020
	toy = AddToy(134020, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(31031, 31032, 33595)

	-- X-52 Rocket Helmet -- 134021
	toy = AddToy(134021, V.LEGION, Q.UNCOMMON)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(10249)

	-- Burgy Blackheart's Handsome Hat -- 134022
	toy = AddToy(134022, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50052)

	-- Bottled Tornado -- 134023
	toy = AddToy(134023, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(50749)

	-- Cursed Swabby Helmet -- 134024
	toy = AddToy(134024, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddZoneLocations(Z.TIMELESS_ISLE, nil, "40.4:92.3")

	-- Familiar Stone -- 136846
	toy = AddToy(136846, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Mage")
	toy:AddVendor(28715)

	-- Hunter's Call -- 136855
	toy = AddToy(136855, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Hunter")
	toy:AddVendor(28040)

	-- Nature's Beacon -- 136849
	toy = AddToy(136849, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Druid")
	toy:AddVendor(12022)

	-- Scarlet Confessional Book -- 136927
	toy = AddToy(136927, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Priest")
	toy:AddVendor(106887)

	-- Thaumaturgist's Orb -- 136928
	toy = AddToy(136928, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:SetRequiredClass("Priest")
	toy:AddVendor(11536)

	-- Raging Elemental Stone -- 136934
	toy = AddToy(136934, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Shaman")
	toy:AddVendor(18072)

	-- Tadpole Cloudseeder -- 136935
	toy = AddToy(136935, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Shaman")
	toy:AddVendor(18072)

	-- Vol'jin's Serpent Totem -- 136937
	toy = AddToy(136937, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Shaman")
	toy:AddVendor(18072)

	-- Dalaran Initiates' Pin -- 137294
	toy = AddToy(137294, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Mage")
	toy:AddVendor(28715)

	-- Soft Foam Sword -- 137663
	toy = AddToy(137663, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(29478, 96483)

	-- Sparklepony XL -- 138202
	toy = AddToy(138202, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(55278)

	-- Slightly-Chewed Insult Book -- 138415
	toy = AddToy(138415, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP, F.WORLD_EVENTS)
	toy:AddMobDrop(108715)
	toy:AddWorldEvent("PIRATES_DAY")

	-- Waterspeaker's Totem -- 138490
	toy = AddToy(138490, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("Shaman")
	toy:AddVendor(18072)

	-- Mystical Frost Hat -- 138873
	toy = AddToy(138873, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(37736)

	-- Runas' Crystal Grinder -- 138876
	toy = AddToy(138876, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(37959)

	-- Copy of Daglop's Contract -- 138878
	toy = AddToy(138878, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(38237)

	-- Gravil Goldbraid's Famous Sausage Hat -- 138900
	toy = AddToy(138900, V.LEGION, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(23605)

	-- Disposable Winter Veil Suits -- 139337
	toy = AddToy(139337, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Suspicious Crate -- 139587
	toy = AddToy(139587, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredClass("Rogue")
	toy:AddCustom("CLASS_HALL")

	-- Emerald Winds -- 139773
	toy = AddToy(139773, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(10774)

	-- Stormforged Vrykul Horn -- 140160
	toy = AddToy(140160, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredClass("Warrior")
	toy:AddCustom("CLASS_HALL")

	-- Narcissa's Mirror -- 140231
	toy = AddToy(140231, V.LEGION, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(107326)

	-- Prismatic Bauble -- 140309
	toy = AddToy(140309, V.LEGION, Q.EPIC)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(108468)

	-- Crab Shank -- 140314
	toy = AddToy(140314, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(107846)

	-- Mobile Telemancy Beacon -- 140324
	toy = AddToy(140324, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.THE_NIGHTFALLEN)
	toy:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.HONORED, 97140)

	-- Home Made Party Mask -- 140325
	toy = AddToy(140325, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.THE_NIGHTFALLEN)
	toy:AddRepVendor(FAC.THE_NIGHTFALLEN, REP.REVERED, 97140)

	-- Brulfist Idol -- 140336
	toy = AddToy(140336, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(99574)

	-- Pocket Fel Spreader -- 140363
	toy = AddToy(140363, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddWorldEvent("LEGION_INVASION")
	toy:Retire()

	-- Lava Fountain -- 140632
	toy = AddToy(140632, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredClass("Shaman")
	toy:AddCustom("CLASS_HALL")

	-- Fal'dorei Egg -- 140780
	toy = AddToy(140780, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Ley Spider Eggs -- 140786
	toy = AddToy(140786, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Ancient Mana Basin -- 141296
	toy = AddToy(141296, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Arcano-Shower -- 141297
	toy = AddToy(141297, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Displacer Meditation Stone -- 141298
	toy = AddToy(141298, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Kal'dorei Light Globe -- 141299
	toy = AddToy(141299, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Magi Focusing Crystal -- 141300
	toy = AddToy(141300, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Unstable Powder Box -- 141301
	toy = AddToy(141301, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Wisp in a Bottle -- 141306
	toy = AddToy(141306, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("WITHERED_ARMY")

	-- Berglrgl Perrgl Girggrlf -- 141879
	toy = AddToy(141879, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddQuest(41143)

-- 7.1 Toys
	-- Bom'bay's Color-Seein' Sauce -- 97921
	toy = AddToy(97921, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP)
	toy:AddVendor(2795)

	-- Grizzlesnout's Fang -- 129965
	toy = AddToy(129965, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98690)

	-- Mother's Skinning Knife -- 130102
	toy = AddToy(130102, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(40149)
	toy:AddProfession(PROF.SKINNING)

	-- Set of Matches -- 141649
	toy = AddToy(141649, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("MIDSUMMER_FIRE_FESTIVAL")
	toy:AddCustom("CITY")

	-- Mote of Light -- 141862
	toy = AddToy(141862, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(107109)

	-- Big Red Raygun -- 142265
	toy = AddToy(142265, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(15552)

	-- Love Boat -- 142341
	toy = AddToy(142341, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("LOVE_IS_IN_THE_AIR")
	toy:AddCustom("CITY")

	-- Purple Blossom -- 142494
	toy = AddToy(142494, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(45008)
	toy:AddCustom("HATCHLING_CHAIN")

	-- Fake Teeth -- 142495
	toy = AddToy(142495, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(44982)
	toy:AddCustom("HATCHLING_CHAIN")

	-- Dirty Spoon -- 142496
	toy = AddToy(142496, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(45007)
	toy:AddCustom("HATCHLING_CHAIN")

	-- Tiny Pack -- 142497
	toy = AddToy(142497, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(44959)
	toy:AddCustom("HATCHLING_CHAIN")

	-- Crate of Bobbers: Can of Worms -- 142528
	toy = AddToy(142528, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.FISHING)
	toy:AddWorldDrop(Z.BROKEN_ISLES)

	-- Crate of Bobbers: Cat Head -- 142529
	toy = AddToy(142529, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.FISHING)
	toy:AddWorldDrop(Z.BROKEN_ISLES)

	-- Crate of Bobbers: Tugboat -- 142530
	toy = AddToy(142530, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.FISHING)
	toy:AddWorldDrop(Z.BROKEN_ISLES)

	-- Crate of Bobbers: Squeaky Duck -- 142531
	toy = AddToy(142531, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.CONJURER_MARGOSS)
	toy:AddRepVendor(FAC.CONJURER_MARGOSS, REP.FRIENDLY, 108825)

	-- Crate of Bobbers: Murloc Head -- 142532
	toy = AddToy(142532, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.CONJURER_MARGOSS)
	toy:AddRepVendor(FAC.CONJURER_MARGOSS, REP.FRIENDLY, 108825)

	-- Memory Cube -- 142536
	toy = AddToy(142536, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddMobDrop(104415)

	-- Tome of Town Portal -- 142542
	toy = AddToy(142542, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(11395)

	-- Wand of Simulated Life -- 143534
	toy = AddToy(143534, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddZoneLocations(Z.DALARAN_BROKENISLES, nil, "47.4:41.1")

	-- Twelve-String Guitar -- 143543
	toy = AddToy(143543, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(11395)

	-- Skull of Corruption -- 143544
	toy = AddToy(143544, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:SetRequiredClass("DEMONHUNTER")
	toy:AddMobDrop(105503)

	-- Mrgrglhjorn -- 143660
	toy = AddToy(143660, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(11427)

	-- Crate of Bobbers: Wooden Pepe -- 143662
	toy = AddToy(143662, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.FISHING)
	toy:AddWorldDrop(Z.BROKEN_ISLES)

	-- Dragon Head Costume -- 143827
	toy = AddToy(143827, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Dragon Body Costume -- 143828
	toy = AddToy(143828, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Dragon Tail Costume -- 143829
	toy = AddToy(143829, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Sturdy Love Fool -- 144339
	toy = AddToy(144339, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("LOVE_IS_IN_THE_AIR")
	toy:AddCustom("CITY")

	-- Portable Yak Wash -- 144393
	toy = AddToy(144393, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(118828)


-- 7.2
	-- Champion's Salute -- 143727
	toy = AddToy(143727, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("CLASS_HALL")

	-- A Tiny Set of Warglaives -- 147537
	toy = AddToy(147537, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredClass("Death Knight")
	toy:AddCustom("LEGION_ASCENDED")

	-- Legion Invasion Simulator -- 147708
	toy = AddToy(147708, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddRepVendor(FAC.ARMIES_OF_LEGIONFALL, REP.EXALTED, 120898)

	-- Magical Saucer -- 147832
	toy = AddToy(147832, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredClass("Mage")
	toy:AddCustom("LEGION_ASCENDED")

	-- Akazamzarak's Spare Hat -- 147838
	toy = AddToy(147838, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredClass("Mage")
	toy:AddCustom("CLASS_HALL")

	-- Sira's Extra Cloak -- 147843
	toy = AddToy(147843, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST, F.MISC)
	toy:AddQuest(46749)

	-- Pilfered Sweeper -- 147867
	toy = AddToy(147867, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("CURIOUS_WYRMTONGUE")

	-- Lingering Wyrmtongue Essence -- 142452
	toy = AddToy(142452, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)
	toy:AddVendor(120076)

	-- Adopted Puppy Crate -- 144072
	toy = AddToy(144072, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(118828)

	-- Melia Globespanner's Guide to Kalimdor -- 150743
	toy = AddToy(150743, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP)
	toy:SetRequiredFaction("Alliance")
	toy:AddVendor(6294)

	-- Threadbare Kalimdor Flightmap -- 150744
	toy = AddToy(150744, V.LEGION, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP)
	toy:SetRequiredFaction("Horde")
	toy:AddVendor(6566)

	-- Aged Eastern Kingdoms Flightmap -- 150745
	toy = AddToy(150745, V.LEGION, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP)
	toy:SetRequiredFaction("Horde")
	toy:AddVendor(6566)

	-- Bran's Travel Guide to the Eastern Kingdoms -- 150746
	toy = AddToy(150746, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP)
	toy:SetRequiredFaction("Alliance")
	toy:AddVendor(6294)

	-- Fractured Necrolyte Skull -- 151016
	toy = AddToy(151016, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98685)

	-- Verdant Throwing Sphere -- 151184
	toy = AddToy(151184, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(98685)

	-- Blight Boar Microphone -- 151265
	toy = AddToy(151265, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP, F.WORLD_EVENTS)
	toy:AddWorldEvent("DARKMOON_FAIRE")
	toy:AddMobDrop(122899)

-- 7.2.5
	-- Honorable Pennant -- 134026
	toy = AddToy(134026, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PVP, F.MISC)
	toy:AddCustom("PRESTIGE")

	-- Prestigious Pennant -- 134031
	toy = AddToy(134031, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PVP, F.MISC)
	toy:AddCustom("PRESTIGE")

	-- Elite Pennant -- 134032
	toy = AddToy(134032, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PVP, F.MISC)
	toy:AddCustom("PRESTIGE")

	-- Esteemed Pennant -- 134034
	toy = AddToy(134034, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PVP, F.MISC)
	toy:AddCustom("PRESTIGE")

	-- Vrykul Toy Boat Kit -- 129367
	toy = AddToy(129367, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.REPUTATION, F.VALARJAR)
	toy:AddRepVendor(FAC.VALARJAR, REP.HONORED, 106904)

	-- Carved Wooden Helm -- 147307
	toy = AddToy(147307, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.CORBYN)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.CORBYN, REP.EXALTED, 120458)

	-- Enchanted Bobber -- 147308
	toy = AddToy(147308, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.ILYSSIA_OF_THE_WATERS)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.ILYSSIA_OF_THE_WATERS, REP.EXALTED, 120266)

	-- Face of the Forest -- 147309
	toy = AddToy(147309, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.KEEPER_RAYNAE)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.KEEPER_RAYNAE, REP.EXALTED, 120456)

	-- Floating Totem -- 147310
	toy = AddToy(147310, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.AKULE_RIVERHORN)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.AKULE_RIVERHORN, REP.EXALTED, 120457)

	-- Replica Gondola -- 147311
	toy = AddToy(147311, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.SHALETH)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.SHALETH, REP.EXALTED, 120459)

	-- Demon Noggin -- 147312
	toy = AddToy(147312, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.IMPUS)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.IMPUS, REP.EXALTED, 120460)

	-- Horse Tail Costume -- 151270
	toy = AddToy(151270, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(53728, 53757)
	toy:AddWorldEvent("HALLOWS_END")

	-- Horse Head Costume -- 151271
	toy = AddToy(151271, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddVendor(53728, 53757)
	toy:AddWorldEvent("HALLOWS_END")

	-- 7.3 - 7.3.5

	-- Doomsayer's Robes -- 134831
	toy = AddToy(134831, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)

	-- Hearthstation -- 151343
	toy = AddToy(151343, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.WORLD_EVENTS)
	toy:SetRequiredFaction("Alliance")
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Hearthstation -- 151344
	toy = AddToy(151344, V.LEGION, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:SetRequiredFaction("Horde")
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Toy Weapon Set -- 151348
	toy = AddToy(151348, V.LEGION, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:SetRequiredFaction("Horde")
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Toy Weapon Set -- 151349
	toy = AddToy(151349, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.WORLD_EVENTS)
	toy:SetRequiredFaction("Alliance")
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Trawler Totem -- 152556
	toy = AddToy(152556, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.AKULE_RIVERHORN)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.AKULE_RIVERHORN, REP.REVERED, 120457)

	-- Corbyn's Beacon -- 152574
	toy = AddToy(152574, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION, F.REPUTATION, F.CORBYN)
	toy:AddProfession(PROF.FISHING)
	toy:AddRepVendor(FAC.CORBYN, REP.HONORED, 120458)

	-- Crystalline Campfire -- 153039
	toy = AddToy(153039, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ARGUSSIAN_REACH)
	toy:AddRepVendor(FAC.ARGUSSIAN_REACH, REP.HONORED, 127151)

	-- Spire of Spite -- 153124
	toy = AddToy(153124, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(123464)

	-- Micro-Artillery Controller -- 153126
	toy = AddToy(153126, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(126338)

	-- Blue Conservatory Scroll -- 153179
	toy = AddToy(153179, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(126900)

	-- Yellow Conservatory Scroll -- 153180
	toy = AddToy(153180, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(126900)

	-- Red Conservatory Scroll -- 153181
	toy = AddToy(153181, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(126900)

	-- Holy Lightsphere -- 153182
	toy = AddToy(153182, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST, F.MISC)
	toy:AddQuest(48977)

	-- Barrier Generator -- 153183
	toy = AddToy(153183, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(126865, 126866)

	-- Baarut the Brisk -- 153193
	toy = AddToy(153193, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(126862)

	-- Legion Communication Orb -- 153194
	toy = AddToy(153194, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(127703)

	-- All-Seer's Eye -- 153204
	toy = AddToy(153204, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(128134)

	-- S.F.E. Interceptor -- 153253
	toy = AddToy(153253, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(127700)

	-- Sightless Eye -- 153293
	toy = AddToy(153293, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(127706)

	-- Katy's Stampwhistle -- 156833
	toy = AddToy(156833, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(12439)


-- Battle for Azeroth

	-- Zandalari Effigy Amulet -- 156649
	toy = AddToy(156649, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ZAND_AMULET")

	-- Spitzy -- 156871
	toy = AddToy(156871, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(49285)

	-- Overtuned Corgi Goggles -- 158149
	toy = AddToy(158149, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(12827)

	-- Haw'li's Hot & Spicy Chili -- 159749
	toy = AddToy(159749, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(129597)

	-- Desert Flute -- 159753
	toy = AddToy(159753, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Horde")
	toy:AddFilters(F.HORDE, F.IBOP, F.REPUTATION, F.BFACOMMON2)
	toy:AddRepVendor(FAC.VOLDUNAI, REP.HONORED, 135804)

	-- Echoes of Rezan -- 160509
	toy = AddToy(160509, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(50855, 50957)

	-- Croak Crock -- 160740
	toy = AddToy(160740, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Dance of the Dead -- 160751
	toy = AddToy(160751, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.PROFESSION)
	toy:AddProfession(PROF.ARCHAEOLOGY)

	-- Gem of Acquiescence -- 161342
	toy = AddToy(161342, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("SECRETDISCORD")

	-- Hot Buttered Popcorn -- 162539
	toy = AddToy(162539, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(14845)

	-- Toy Armor Set -- 162642a
	toy = AddToy(162642, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Horde")
	toy:AddFilters(F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Toy Armor Set -- 162643
	toy = AddToy(162643, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Greatfather Winter's Hearthstone -- 162973
	toy = AddToy(162973, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("FEAST_OF_WINTER_VEIL")

	-- Headless Horseman's Hearthstone -- 163045
	toy = AddToy(163045, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.QUEST, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("HALLOWS_END")

	-- Cursed Spyglass -- 163200
	toy = AddToy(163200, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.REPUTATION, F.BFACOMMON3)
	toy:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.REVERED, 135808)

	-- Gnoll Targetting Barrel -- 163201
	toy = AddToy(163201, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.REPUTATION, F.BFACOMMON3)
	toy:AddRepVendor(FAC.PROUDMOORE_ADMIRALTY, REP.HONORED, 135808)

	-- Party Totem -- 163210
	toy = AddToy(163210, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Horde")
	toy:AddFilters(F.HORDE, F.IBOP, F.REPUTATION, F.BFACOMMON4)
	toy:AddRepVendor(FAC.ZANDALARI_EMPIRE, REP.REVERED, 131287)

	-- Akunda's Firesticks -- 163211
	toy = AddToy(163211, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Horde")
	toy:AddFilters(F.HORDE, F.IBOP, F.REPUTATION, F.BFACOMMON2)
	toy:AddRepVendor(FAC.VOLDUNAI, REP.HONORED, 135804)

	-- Dead Ringer -- 163463
	toy = AddToy(163463, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.REPUTATION, F.BFACOMMON2)
	toy:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)

	-- Lucille's Handkerchief -- 163603
	toy = AddToy(163603, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:AddCustom("SECRETDISCORD")

	-- Lucille's Sewing Needle -- 163607
	toy = AddToy(163607, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:AddQuest(49804)

	-- Laser Pointer -- 163697
	toy = AddToy(163697, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(12936)

	-- Tiny Mechanical Mouse -- 163704
	toy = AddToy(163704, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(132097, 136674)

	-- Imaginary Gun -- 163705
	toy = AddToy(163705, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(132097, 136674)

	-- Brazier Cap -- 163713
	toy = AddToy(163713, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142662)

	-- Foul Belly -- 163735
	toy = AddToy(163735, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142686)

	-- Spectral Visage -- 163736
	toy = AddToy(163736, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142725)

	-- Syndicate Mask -- 163738
	toy = AddToy(163738, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142690)

	-- Drust Ritual Knife -- 163740
	toy = AddToy(163740, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddZoneLocations(Z.DRUSTVAR, nil, "33.7:71.7")

	-- Magic Fun Rock -- 163741
	toy = AddToy(163741, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142683)

	-- Heartsbane Grimoire -- 163742
	toy = AddToy(163742, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddZoneLocations(Z.DRUSTVAR, nil, "44.2:27.7")

	-- Coldrage's Cooler -- 163744
	toy = AddToy(163744, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142112)

	-- Witherbark Gong -- 163745
	toy = AddToy(163745, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142682)

	-- Kovork Kostume -- 163750
	toy = AddToy(163750, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(142684)

	-- Molok Morion -- 163775
	toy = AddToy(163775, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(141942)

	-- Oomgut Ritual Drum -- 163795
	toy = AddToy(163795, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

	-- Toy Siege Tower -- 163828
	toy = AddToy(163828, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(138122)

	-- Toy War Machine -- 163829
	toy = AddToy(163829, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Horde")
	toy:AddFilters(F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(137374)

	-- Whiskerwax Candle -- 163924
	toy = AddToy(163924, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

	-- Orgrimmar Hero's War Banner -- 163986
	toy = AddToy(163986, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.PROMO)
	toy:SetRequiredFaction("Horde")
	toy:AddCustom("BLIZZCON")

	-- Stormwind Champion's War Banner -- 163987
	toy = AddToy(163987, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.PROMO)
	toy:SetRequiredFaction("Alliance")
	toy:AddCustom("BLIZZCON")

	-- Glorious Pennant -- 164310
	toy = AddToy(164310, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(12912)

	-- Enchanted Soup Stone -- 164373
	toy = AddToy(164373, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

	-- Magic Monkey Banana -- 164374
	toy = AddToy(164374, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

	-- Bad Mojo Banana -- 164375
	toy = AddToy(164375, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

-- 8.1

	-- Rhan'ka's Escape Plan -- 164983
	toy = AddToy(164983, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(129354)

	-- Lunar Elder's Hearthstone -- 165669
	toy = AddToy(165669, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("LUNAR_FESTIVAL")

	-- Peddlefeet's Lovely Hearthstone -- 165670
	toy = AddToy(165670, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("LOVE_IS_IN_THE_AIR")

	-- Blue Dragon Head Costume -- 165671
	toy = AddToy(165671, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS, F.VENDOR)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Blue Dragon Body Costume -- 165672
	toy = AddToy(165672, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS, F.VENDOR)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Blue Dragon Tail Costume -- 165673
	toy = AddToy(165673, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS, F.VENDOR)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Green Dragon Head Costume -- 165674
	toy = AddToy(165674, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS, F.VENDOR)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Green Dragon Body Costume -- 165675
	toy = AddToy(165675, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS, F.VENDOR)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Green Dragon Tail Costume -- 165676
	toy = AddToy(165676, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS, F.VENDOR)
	toy:AddWorldEvent("LUNAR_FESTIVAL")
	toy:AddVendor(15909)

	-- Worn Cloak -- 165791
	toy = AddToy(165791, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54108)

	-- Citizens Brigade Whistle -- 166247
	toy = AddToy(166247, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.ACHIEVEMENT)
	toy:SetRequiredFaction("Alliance")
	toy:AddAchievement(13285)

	-- For da Blood God! -- 166308
	toy = AddToy(166308, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54460)

	-- Gnarlwood Waveboard -- 166461
	toy = AddToy(166461, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(148922, 148923)

	-- Dark Ranger's Spare Cowl -- 166544
	toy = AddToy(166544, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54043)

	-- Cranky Crab -- 166662
	toy = AddToy(166662, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(148922, 148923)

	-- Hand Anchor -- 166663
	toy = AddToy(166663, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(148922, 148923)

	-- Brynja's Beacon -- 166678
	toy = AddToy(166678, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54050)

	-- Warbeast Kraal Dinner Bell -- 166701
	toy = AddToy(166701, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54462)

	-- Proudmoore Music Box -- 166702
	toy = AddToy(166702, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Alliance")
	toy:AddQuest(54458)

	-- Goldtusk Inn Breakfast Buffet -- 166703
	toy = AddToy(166703, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54461)

	-- Bowl of Glowing Pufferfish -- 166704
	toy = AddToy(166704, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(54451)

	-- Blight Bomber -- 166743
	toy = AddToy(166743, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(148924)

	-- Glaive Tosser -- 166744
	toy = AddToy(166744, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(148927)

	-- Narassin's Soul Gem -- 166784
	toy = AddToy(166784, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(147708)

	-- Detoxified Blight Grenade -- 166785
	toy = AddToy(166785, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(148031)

	-- Twiddle Twirler: Sentinel's Glaive -- 166787
	toy = AddToy(166787, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(148025)

	-- Twiddle Twirler: Shredder Blade -- 166788
	toy = AddToy(166788, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(148103, 149141)

	-- Highborne Memento -- 166790
	toy = AddToy(166790, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(147435, 147845)

	-- Bewitching Tea Set -- 166808
	toy = AddToy(166808, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Alliance")
	toy:AddQuest(54456)

--[[ Not yet implemented
	-- Kojo's Master Matching Set -- 166851
	toy = AddToy(166851, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(54451)
]]--
	-- Azerite Firework Launcher -- 166877
	toy = AddToy(166877, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(54453)

	-- Rallying War Banner -- 166879
	toy = AddToy(166879, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(54454, 54455)

	-- Meerah's Jukebox -- 166880
	toy = AddToy(166880, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.QUEST)
	toy:SetRequiredFaction("Horde")
	toy:AddQuest(54461)

-- 8.1.5
	-- Noble Gardener's Hearthstone -- 165802
	toy = AddToy(165802, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.VENDOR, F.WORLD_EVENTS, F.IBOP)
	toy:AddWorldEvent("NOBLEGARDEN")
	toy:AddVendor(32836, 32837)
	toy:AddCustom("NOBLE_VENDOR")

	-- Fire Eater's Hearthstone -- 166746
	toy = AddToy(166746, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.VENDOR, F.WORLD_EVENTS, F.IBOP)
	toy:AddWorldEvent("MIDSUMMER_FIRE_FESTIVAL")
	toy:AddVendor(26123, 26124)
	toy:AddCustom("CITY")

	-- Brewfest Reveler's Hearthstone -- 166747
	toy = AddToy(166747, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.VENDOR, F.WORLD_EVENTS, F.IBOP)
	toy:AddVendor(23710, 24495)
	toy:AddWorldEvent("BREWFEST")

	-- Transmorpher Beacon -- 166779
	toy = AddToy(166779, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.STORE)
	toy:AddCustom("STORE")

	-- Apexis Focusing Shard -- 168012
	toy = AddToy(168012, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(151955, 151987)

	-- Banner of the Burning Blade -- 168014
	toy = AddToy(168014, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(151955, 151987)

	-- Twitching Eyeball -- 168123
	toy = AddToy(168123, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(53765, 53766)

--8.2

	-- Mechagonian Sawblades -- 167931
	toy = AddToy(167931, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(152007)

	-- Hyper-Compressed Ocean -- 168016
	toy = AddToy(168016, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.ACHIEVEMENT)
	toy:AddAchievement(13502)

	-- Ocean Simulator -- 168824
	toy = AddToy(168824, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("SCRYING_STONE")

	-- Holographic Digitalization Hearthstone -- 168907
	toy = AddToy(168907, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(150359)

	-- Rustbolt Banner -- 169108
	toy = AddToy(169108, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.REPUTATION, F.RUSTBOLT_RESISTANCE)
	toy:AddRepVendor(FAC.RUSTBOLT_RESISTANCE, REP.REVERED, 150716)

	-- Alliance War Banner -- 169275
	toy = AddToy(169275, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(154653)

	-- Alliance War Standard -- 169278
	toy = AddToy(169278, V.BFA, Q.RARE)
	toy:SetRequiredFaction("Alliance")
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.VENDOR)
	toy:AddVendor(154653)

	-- Judgment of Mechagon -- 169347
	toy = AddToy(169347, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(154225)

	-- Heart of a Champion -- 169768
	toy = AddToy(169768, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(55752)

	-- Azeroth Mini Collection: Mechagon -- 169796
	toy = AddToy(169796, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(56572)

	-- Brewfest Chowdown Trophy -- 169865
	toy = AddToy(169865, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.VENDOR, F.WORLD_EVENTS, F.IBOP)
	toy:AddVendor(23710, 24495)
	toy:AddWorldEvent("BREWFEST")

	-- Book of the Unshackled -- 170154
	toy = AddToy(170154, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.MISC)
	toy:SetRequiredFaction("Horde")
	toy:AddCustom("NAZJATAR_BODYGUARDS")

	-- Carved Ankoan Charm -- 170155
	toy = AddToy(170155, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.MISC)
	toy:SetRequiredFaction("Alliance")
	toy:AddCustom("NAZJATAR_BODYGUARDS")

	-- Shadescale -- 170187
	toy = AddToy(170187, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(152552)

	-- Shirakess Warning Sign -- 170196
	toy = AddToy(170196, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MOB_DROP)
	toy:AddMobDrop(154148)

	-- Eternal Palace Dining Set -- 170198
	toy = AddToy(170198, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_DROP)
	toy:AddWorldDrop(Z.NAZJATAR)

	-- Zanj'ir Weapon Rack -- 170199
	toy = AddToy(170199, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_DROP)
	toy:AddWorldDrop(Z.NAZJATAR)

	-- Flopping Fish -- 170203
	toy = AddToy(170203, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(53982, 55976)

	-- Symbol of Gral -- 170204
	toy = AddToy(170204, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)
	toy:AddVendor(153509, 153512)

	-- Jar of Sunwarmed Sand -- 170380
	toy = AddToy(170380, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR, F.WORLD_EVENTS)
	toy:AddWorldEvent("TIMEWALKING")
	toy:AddVendor(155944)

	-- Underlight Sealamp -- 170476
	toy = AddToy(170476, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.WORLD_DROP)
	toy:AddWorldDrop(Z.NAZJATAR)

	-- Memento of the Deeps -- 170469
	toy = AddToy(170469, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.QUEST)
	toy:AddQuest(53982, 55976)

	-- Eternal Traveler's Hearthstone -- 172179
	toy = AddToy(172179, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.COLLECTORS_EDITION)
	toy:AddCustom("CE_E")

--[[  Didn't actually make it into the ToyBox panel

	-- "Guy Incognito" Costume -- 134831
	toy = AddToy(134831, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.VENDOR)

	-- Falanaar Echo -- 140779
	toy = AddToy(140779, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)

	-- Kvaldir Raiding Horn -- 129111
	toy = AddToy(129111, V.LEGION, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)

	-- Weary Spirit Binding -- 163206
	toy = AddToy(163206, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.IBOP, F.REPUTATION, F.BFACOMMON2)
	toy:SetRequiredFaction("Alliance")
	toy:AddRepVendor(FAC.ORDER_OF_EMBERS, REP.REVERED, 135815)

	-- Vulpera Scrapper's Armor -- 163565
	toy = AddToy(163565, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.REPUTATION, F.BFACOMMON2)
	toy:SetRequiredFaction("Horde")
	toy:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Vulpera Battle Banner -- 163566
	toy = AddToy(163566, V.BFA, Q.RARE)
	toy:AddFilters(F.HORDE, F.IBOP, F.REPUTATION, F.BFACOMMON2)
	toy:SetRequiredFaction("Horde")
	toy:AddRepVendor(FAC.VOLDUNAI, REP.REVERED, 135804)

	-- Yaungol Oil Stove -- 164371
	toy = AddToy(164371, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

	-- Jinyu Light Globe -- 164372
	toy = AddToy(164372, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

	-- Regenerating Banana Bunch -- 164377
	toy = AddToy(164377, V.BFA, Q.RARE)
	toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP, F.MISC)
	toy:AddCustom("ISLAND_EXPEDITIONS")

]]--

	self.InitToys = nil

end

function private.UpdateToyList(toys)
	local toyCount = _G.C_ToyBox.GetNumToys()
	local toyIDs = {}
	local toyItemIDs = {}
	local toyNames = {}

	for index = 1, toyCount do
		local toyID = _G.C_ToyBox.GetToyFromIndex(index)

		if toyID > -1 then
			local itemID, toyName, icon = _G.C_ToyBox.GetToyInfo(toyID)
			local toy = toys[toyID]

			if toy then
				toy:SetIcon(icon)
				toy:SetItemID(itemID)
				toy:SetName(toyName)

				if _G.PlayerHasToy(toyID) then
					toy:AddState("KNOWN")
				end
			else
				toyIDs[#toyIDs + 1] = toyID
				toyItemIDs[toyID] = itemID
				toyNames[toyID] = toyName or ("%s_%d"):format(_G.UNKNOWN, toyID)
			end
		end
	end

	table.sort(toyIDs)

	--[===[@debug@
	private.TextDump:Clear()
	for index = 1, #toyIDs do
		local toyID = toyIDs[index]

		private.TextDump:AddLine(("-- %s -- %d"):format(toyNames[toyID], toyID))
		private.TextDump:AddLine(("toy = AddToy(%d, V.BFA, Q.RARE)"):format(toyID))
		private.TextDump:AddLine(("toy:AddFilters(F.ALLIANCE, F.HORDE, F.IBOP)\n"))
	end

	local lineCount = private.TextDump:Lines()
	if lineCount > 0 then
		private.TextDump:InsertLine(1, ("Untracked: %d\n"):format(lineCount / 2))
		private.TextDump:Display()
	end
	--@end-debug@]===]
end
