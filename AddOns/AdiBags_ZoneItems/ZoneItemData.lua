--[[
Datafile for AdiBags Zone Items
]]
local addonName, addon = ...
	--ID^Category^Subcat^ZoneSetID^Item,
	addon.arrEssence = {	"174288^Essence^Essence^10", --Breath of Everlasting Spirit
	"174287^Essence^Essence^10", } --Sparks of Unwavering Strength
addon.arrMechagon = {	"169868^Mechagon^-^5", --Anti-Gravity Pack
	"167062^Mechagon^-^5", --Armored Vaultbot Key
	"168233^Mechagon^-^5", --Bawld-371
	"168045^Mechagon^-^5", --Beastbot Power Pack
	"167832^Mechagon^-^5", --Canned Minnows
	"168327^Mechagon^-^5", --Chain Ignitercoil
	"166972^Mechagon^-^5", --Emergency Powerpack
	"166973^Mechagon^-^5", --Emergency Repair Kit
	"166971^Mechagon^-^5", --Empty Energy Cell
	"166970^Mechagon^-^5", --Energy Cell
	"168961^Mechagon^-^5", --Exothermic Evaporator Coil
	"168832^Mechagon^-^5", --Galvanic Oscillator
	"168217^Mechagon^-^5", --Hardened Spring
	"168952^Mechagon^-^5", --Hardened Spring
	"167649^Mechagon^-^5", --Hundred-Fathom Lure
	"167562^Mechagon^-^5", --Ionized Minnow
	"169872^Mechagon^-^5", --Irontide Lockbox Key
	"169878^Mechagon^-^5", --Irradiated Undercoat
	"168215^Mechagon^-^5", --Machined Gear Assembly
	"168950^Mechagon^-^5", --Machined Gear Assembly
	"169873^Mechagon^-^5", --Mechanized Supply Key
	"167071^Mechagon^-^5", --Mechano-Treat
	"169218^Mechagon^-^5", --Old Rusty Key
	"169675^Mechagon^-^5", --Orange Paint Filled Bladder
	"169114^Mechagon^-^5", --Personal Time Displacer
	"169470^Mechagon^-^5", --Pressure Relief Valve
	"169610^Mechagon^-^5", --S.P.A.R.E. Crate
	"168262^Mechagon^-^5", --Sentry Fish
	"166846^Mechagon^-^5", --Spare Parts
	"168216^Mechagon^-^5", --Tempered Plating
	"168951^Mechagon^-^5", --Tempered Plating
	"168213^Mechagon^-^5", --Tensile Driveshaft
	"167075^Mechagon^-^5", } --Ultrasafe Transporter: Mechagon
addon.arrMissions = {	"127889^Missions^Garrison^11", --Ammo Reserves
	"125787^Missions^Garrison^11", --Bilge Pump
	"127882^Missions^Garrison^11", --Blast Furnace
	"127891^Missions^Garrison^11", --Extra Quarters
	"127884^Missions^Garrison^11", --Felsmoke Launcher
	"128257^Missions^Garrison^11", --Ghostly Spyglass
	"127881^Missions^Garrison^11", --Gyroscopic Internal Stabilizer
	"127662^Missions^Garrison^11", --High Intensity Fog Lights
	"127880^Missions^Garrison^11", --Ice Cutter
	"127892^Missions^Garrison^11", --Q-43 Noisemaker Mines
	"122596^Missions^Garrison^11", --Rush Order: The Tannery
	"127883^Missions^Garrison^11", --True Iron Rudder
	"127894^Missions^Garrison^11", --Tuskarr Fishing Net
	"127886^Missions^Garrison^11", --Unsinkable
	"140590^Missions^Garrison^11", --Large Crate of Salvage
	"139593^Missions^Garrison^11", --Sack of Salvaged Goods
	"120301^Missions^Garrison^11", --Armor Enhancement Token
	"114116^Missions^Garrison^11", --Bag of Salvaged Goods
	"125787^Missions^Garrison^11", --Bilge Pump
	"124099^Missions^Garrison^11", --Blackfang Claw
	"114806^Missions^Garrison^11", --Blackrock Armor Set
	"114081^Missions^Garrison^11", --Blackrock Weaponry
	"128308^Missions^Garrison^11", --Draenic Armor Set
	"128307^Missions^Garrison^11", --Draenic Weaponry
	"122272^Missions^Garrison^11", --Follower Ability Retraining Manual
	"122273^Missions^Garrison^11", --Follower Trait Retraining Guide
	"128314^Missions^Garrison^11", --Frozen Arms of a Hero
	"139419^Missions^Garrison^11", --Golden Banana
	"118099^Missions^Garrison^11", --Gorian Artifact Fragment
	"122582^Missions^Garrison^11", --Guide to Arakkoa Relations
	"118475^Missions^Garrison^11", --Hearthstone Strategy Guide
	"128313^Missions^Garrison^11", --Huge Ogre Cache
	"113681^Missions^Garrison^11", --Iron Horde Scraps
	"140760^Missions^Garrison^11", --Libram of Truth
	"118897^Missions^Garrison^11", --Miner's Coffee
	"122514^Missions^Garrison^11", --Mission Completion Orders
	"122580^Missions^Garrison^11", --Ogre Buddy Handbook
	"117491^Missions^Garrison^11", --Ogre Waystone
	"118903^Missions^Garrison^11", --Preserved Mining Pick
	"122576^Missions^Garrison^11", --Rush Order: Alchemy Lab
	"122590^Missions^Garrison^11", --Rush Order: Enchanter's Study
	"122591^Missions^Garrison^11", --Rush Order: Engineering Works
	"122592^Missions^Garrison^11", --Rush Order: Gem Boutique
	"122593^Missions^Garrison^11", --Rush Order: Scribe's Quarters
	"122594^Missions^Garrison^11", --Rush Order: Tailoring Emporium
	"122595^Missions^Garrison^11", --Rush Order: The Forge
	"139594^Missions^Garrison^11", --Salvage Crate
	"120302^Missions^Garrison^11", --Weapon Enhancement Token
	"139428^Missions^Legion Missions^9", --A Master Plan
	"139418^Missions^Legion Missions^9", --Healing Stream Totem
	"139376^Missions^Legion Missions^9", --Healing Well
	"140749^Missions^Legion Missions^9", --Horn of Winter
	"138412^Missions^Legion Missions^9", --Iresoul's Healthstone
	"152095^Missions^Legion Missions^9", --Krokul Ridgestalker
	"152097^Missions^Legion Missions^9", --Lightforged Bulwark
	"138883^Missions^Legion Missions^9", --Meryl's Conjured Refreshment
	"140767^Missions^Legion Missions^9", --Pile of Bits and Bones
	"140656^Missions^Legion Missions^9", --Rod of the Ascended
	"139177^Missions^Legion Missions^9", --Shattered Soul
	"143605^Missions^Legion Missions^9", --Strange Ball of Energy
	"143605^Missions^Legion Missions^9", --Strange Ball of Energy
	"143850^Missions^Legion Missions^9", --Summon Grimtotem Warrior
	"138410^Missions^Legion Missions^9", --Summoning Portal
	"141332^Missions^Legion Missions^9", --The Annals of Light and Shadow
	"152096^Missions^Legion Missions^9", --Void-Purged Krokul
	"139420^Missions^Legion Missions^9", } --Wild Mushroom
addon.arrNazjatar = {	"170186^Nazjatar^-^6", --Abyss Pearl
	"167910^Nazjatar^-^6", --Bag of Who-Knows-What
	"169782^Nazjatar^-^6", --Beckoner's Rosetta Stone
	"170189^Nazjatar^-^6", --Blind Eye
	"167012^Nazjatar^-^6", --Brinestone Pickaxe
	"168081^Nazjatar^-^6", --Brinestone Pickaxe
	"167059^Nazjatar^-^6", --Chum
	"167060^Nazjatar^-^6", --Chum
	"168155^Nazjatar^-^6", --Chum
	"168159^Nazjatar^-^6", --Chum
	"167923^Nazjatar^-^6", --Clean Murloc Sock
	"169783^Nazjatar^-^6", --Cultist Pinky Finger
	"167905^Nazjatar^-^6", --Curious Murloc Horn
	"167916^Nazjatar^-^6", --Dirty Murloc Sock
	"167903^Nazjatar^-^6", --Disintegrating Sand Sculpture
	"170472^Nazjatar^-^6", --Encrusted Coin
	"167907^Nazjatar^-^6", --Extra-Slimy Snail
	"168094^Nazjatar^-^6", --Faintly Humming Sea Stones
	"167906^Nazjatar^-^6", --Flatulent Fish
	"166888^Nazjatar^-^6", --Germinating Seed
	"167786^Nazjatar^-^6", --Germinating Seed
	"167909^Nazjatar^-^6", --Ghost Food
	"167913^Nazjatar^-^6", --Healthy Murloc Lunch
	"168666^Nazjatar^-^6", --Hefty Glimmershell
	"170100^Nazjatar^-^6", --Hungry Herald's Tentacle Taco
	"167914^Nazjatar^-^6", --Jar of Fish Faces
	"167911^Nazjatar^-^6", --Just Regular Butter
	"170512^Nazjatar^-^6", --Lesser Benthic Arcanocrystal
	"170547^Nazjatar^-^6", --Mardivas's Arcane Cache Key
	"168161^Nazjatar^-^6", --Molted Shell
	"168232^Nazjatar^-^6", --Murloco's 'Fish' Tacos
	"170153^Nazjatar^-^6", --Ominous Looking Tome
	"169781^Nazjatar^-^6", --Overwhelmingly-Alluring Idol
	"167902^Nazjatar^-^6", --Particularly Dense Rock
	"168097^Nazjatar^-^6", --Pilfered Armor Crate
	"167893^Nazjatar^-^6", --Prismatic Crystal
	"169780^Nazjatar^-^6", --Pulsating Blood Stone
	"170180^Nazjatar^-^6", --Razorshell
	"168261^Nazjatar^-^6", --Reinforced Cache Key
	"167077^Nazjatar^-^6", --Scrying Stone
	"167908^Nazjatar^-^6", --Sea Giant Foot Dust
	"170191^Nazjatar^-^6", --Skeletal Hand
	"167896^Nazjatar^-^6", --Slimy Naga Eyeball
	"167904^Nazjatar^-^6", --Smelly Pile of Gloop
	"169332^Nazjatar^-^6", --Strange Mineralized Water
	"169334^Nazjatar^-^6", --Strange Oceanic Sediment
	"169333^Nazjatar^-^6", --Strange Volcanic Rock
	"167915^Nazjatar^-^6", --Sweet Sea Vegetable
	"170181^Nazjatar^-^6", --Tidal Guard
	"167912^Nazjatar^-^6", --Unidentified Mass
	"170158^Nazjatar^-^6", --Unspeakable Pearl Idol
	"168053^Nazjatar^-^6", --Unusually Wise Hermit Crab
	"170162^Nazjatar^-^6", --Waterlogged Toolbox
	"170502^Nazjatar^-^6", --Waterlogged Toolbox
	"170079^Nazjatar^Reputation^6", --Abyssal Conch
	"170184^Nazjatar^Reputation^6", --Ancient Reefwalker Bark
	"170167^Nazjatar^Reputation^6", --Eel Fillet
	"170176^Nazjatar^Reputation^6", --Fathom Ray Wing
	"170171^Nazjatar^Reputation^6", --Giant Crab Leg
	"170085^Nazjatar^Reputation^6", --Naga Deployment Orders
	"170183^Nazjatar^Reputation^6", --Reefwalker Bark
	"170161^Nazjatar^Reputation^6", --Unusually Wise Hermit Crab
	"169942^Nazjatar^Reputation^6", } --Vibrant Sea Blossom
addon.arrPatch8_3 = {	"174352^Patch8_3^Horrific Visions^8", --Baked Voidfin
	"167788^Patch8_3^Horrific Visions^8", --Detoxifying Vial
	"174350^Patch8_3^Horrific Visions^8", --Dubious Delight
	"174279^Patch8_3^Horrific Visions^8", --Encrypted Ny'alothan Text
	"172072^Patch8_3^Horrific Visions^8", --Experimental Vial
	"172947^Patch8_3^Horrific Visions^8", --Faceless Mask of Dark Imagination
	"174349^Patch8_3^Horrific Visions^8", --Ghastly Goulash
	"174348^Patch8_3^Horrific Visions^8", --Grilled Gnasher
	"171352^Patch8_3^Horrific Visions^9", --Horrific Core
	"171335^Patch8_3^Horrific Visions^9", --Horrific Core
	"174351^Patch8_3^Horrific Visions^8", --K'Bab
	"174045^Patch8_3^Horrific Visions^8", --Orb of Dark Portents
	"174046^Patch8_3^Horrific Visions^8", --Orb of Visions
	"167027^Patch8_3^Horrific Visions^8", --Portable Clarity Beam
	"169294^Patch8_3^Horrific Visions^8", --Resilient Soul
	"171212^Patch8_3^Horrific Visions^8", --Sanity Restoration Orb
	"173888^Patch8_3^Horrific Visions^8", --Shard of Self Sacrifice
	"173363^Patch8_3^Horrific Visions^8", --Vessel of Horrific Visions
	"173293^Patch8_3^Horrific Visions^8", --Vial of Self Preservation
	"172494^Patch8_3^Patch 8.3^3", --Baruk Idol
	"171347^Patch8_3^Patch 8.3^8", --Corrupted Bone Fragment
	"174768^Patch8_3^Patch 8.3^3", --Cursed Relic
	"175150^Patch8_3^Patch 8.3^2", --Self-Shaping Amber
	"171334^Patch8_3^Patch 8.3^8", --Void-Touched Cloth
	"174761^Patch8_3^Uldum^2", --Aqir Relic
	"174756^Patch8_3^Uldum^2", --Aqir Relic Fragment
	"174837^Patch8_3^Uldum^2", --Decaying Fusion Core
	"174325^Patch8_3^Uldum^2", --Fire Bomb
	"174858^Patch8_3^Uldum^2", --Gersahl Greens
	"168160^Patch8_3^Uldum^2", --Jeweled Scarab Figurine
	"174867^Patch8_3^Uldum^2", --Shard of Corruption
	"168271^Patch8_3^Uldum^2", --Stolen Ramkahen Banner
	"171208^Patch8_3^Uldum^2", --Suntouched Amulet
	"168267^Patch8_3^Uldum^2", --Suntouched Figurine
	"174765^Patch8_3^Uldum^2", --Tol'vir Relic
	"174764^Patch8_3^Uldum^2", --Tol'vir Relic Fragment
	"172495^Patch8_3^Vale^1", --Anima Orb
	"174766^Patch8_3^Vale^1", --Mantid Relic
	"174760^Patch8_3^Vale^1", --Mantid Relic Fragment
	"174767^Patch8_3^Vale^1", --Mogu Relic
	"174759^Patch8_3^Vale^1", --Mogu Relic Fragment
	"174758^Patch8_3^Vale^1", --Voidwarped Relic Fragment
	"174927^Patch8_3^Vale^1", } --Zan-Tien Lasso
addon.arrTimeless = {	"103642^Timeless^Timeless Isle^4", --Book of the Ages
	"103643^Timeless^Timeless Isle^4", --Dew of Eternal Morning
	"104287^Timeless^Timeless Isle^4", --Windfeather Plume
	"104346^Timeless^Timeless Isle^4", --Golden Glider
	"103641^Timeless^Timeless Isle^4", } --Singing Crystal
	