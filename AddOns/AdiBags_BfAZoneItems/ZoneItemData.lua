--[[
Datafile for AdiBags_BfAZoneItems
]]
local addonName, addon = ...
local L = addon.L


-- Zone Item Data
addon.ZONE_ITEMS = {
    "169478^BfA^Benthic^Benthic Bracers", 
    "169480^BfA^Benthic^Benthic Chestguard", 
    "169481^BfA^Benthic^Benthic Cloak", 
    "169477^BfA^Benthic^Benthic Girdle", 
    "169485^BfA^Benthic^Benthic Guantlets", 
    "169479^BfA^Benthic^Benthic Helm", 
    "169482^BfA^Benthic^Benthic Leggings", 
    "169484^BfA^Benthic^Benthic Spaulders", 
    "169483^BfA^Benthic^Benthic Treads", 
    "169868^Mechagon^^Anti-Gravity Pack", 
    "167062^Mechagon^^Armored Vaultbot Key", 
    "168233^Mechagon^^Bawld-371", 
    "168045^Mechagon^^Beastbot Power Pack", 
    "168327^Mechagon^^Chain Ignitercoil", 
    "166972^Mechagon^^Emergency Powerpack", 
    "166973^Mechagon^^Emergency Repair Kit", 
    "166971^Mechagon^^Empty Energy Cell", 
    "166970^Mechagon^^Energy Cell", 
    "168961^Mechagon^^Exothermic Evaporator Coil", 
    "168832^Mechagon^^Galvanic Oscillator", 
    "169674^Mechagon^^Green Paint Filled Bladder", 
    "168217^Mechagon^^Hardened Spring", 
    "168952^Mechagon^^Hardened Spring", 
    "167649^Mechagon^^Hundred-Fathom Lure", 
    "167562^Mechagon^^Ionized Minnow", 
    "169872^Mechagon^^Irontide Lockbox Key", 
    "169878^Mechagon^^Irradiated Undercoat", 
    "168215^Mechagon^^Machined Gear Assembly", 
    "168950^Mechagon^^Machined Gear Assembly", 
    "169873^Mechagon^^Mechanized Supply Key", 
    "167071^Mechagon^^Mechano-Treat", 
    "169218^Mechagon^^Old Rusty Key", 
    "169675^Mechagon^^Orange Paint Filled Bladder", 
    "169114^Mechagon^^Personal Time Displacer", 
    "169470^Mechagon^^Pressure Relief Valve", 
    "169610^Mechagon^^S.P.A.R.E. Crate", 
    "168262^Mechagon^^Sentry Fish", 
    "166846^Mechagon^^Spare Parts", 
    "168216^Mechagon^^Tempered Plating", 
    "168951^Mechagon^^Tempered Plating", 
    "168213^Mechagon^^Tensile Driveshaft", 
    "167075^Mechagon^^Ultrasafe Transporter: Mechagon", 
    "170186^Nazjatar^^Abyss Pearl", 
    "170079^Nazjatar^Reputation^Abyssal Conch", 
    "170184^Nazjatar^Reputation^Ancient Reefwalker Bark", 
    "167910^Nazjatar^^Bag of Who-Knows-What", 
    "169782^Nazjatar^^Beckoner's Rosetta Stone", 
    "170189^Nazjatar^^Blind Eye", 
    "167012^Nazjatar^^Brinestone Pickaxe", 
    "168081^Nazjatar^^Brinestone Pickaxe", 
    "167059^Nazjatar^^Chum", 
    "167060^Nazjatar^^Chum", 
    "168155^Nazjatar^^Chum", 
    "168159^Nazjatar^^Chum", 
    "167923^Nazjatar^^Clean Murloc Sock", 
    "169783^Nazjatar^^Cultist Pinky Finger", 
    "167905^Nazjatar^^Curious Murloc Horn", 
    "167916^Nazjatar^^Dirty Murloc Sock", 
    "167903^Nazjatar^^Disintegrating Sand Sculpture", 
    "170167^Nazjatar^Reputation^Eel Fillet", 
    "170472^Nazjatar^^Encrusted Coin", 
    "167907^Nazjatar^^Extra-Slimy Snail", 
    "168094^Nazjatar^^Faintly Humming Sea Stones", 
    "170176^Nazjatar^Reputation^Fathom Ray Wing", 
    "167906^Nazjatar^^Flatulent Fish", 
    "166888^Nazjatar^^Germinating Seed", 
    "167786^Nazjatar^^Germinating Seed", 
    "167909^Nazjatar^^Ghost Food", 
    "170171^Nazjatar^Reputation^Giant Crab Leg", 
    "167913^Nazjatar^^Healthy Murloc Lunch", 
    "170100^Nazjatar^^Hungry Herald's Tentacle Taco", 
    "167914^Nazjatar^^Jar of Fish Faces", 
    "167911^Nazjatar^^Just Regular Butter", 
    "170512^Nazjatar^^Lesser Benthic Arcanocrystal", 
    "170547^Nazjatar^^Mardivas's Arcane Cache Key", 
    "168161^Nazjatar^^Molted Shell", 
    "170085^Nazjatar^^Naga Deployment Orders", 
    "170153^Nazjatar^^Ominous Looking Tome", 
    "169781^Nazjatar^^Overwhelmingly-Alluring Idol", 
    "167902^Nazjatar^^Particularly Dense Rock", 
    "168097^Nazjatar^^Pilfered Armor Crate", 
    "167893^Nazjatar^^Prismatic Crystal", 
    "169780^Nazjatar^^Pulsating Blood Stone", 
    "170180^Nazjatar^^Razorshell", 
    "168261^Nazjatar^^Reinforced Cache Key", 
    "167077^Nazjatar^^Scrying Stone", 
    "167908^Nazjatar^^Sea Giant Foot Dust", 
    "170191^Nazjatar^^Skeletal Hand", 
    "167896^Nazjatar^^Slimy Naga Eyeball", 
    "167904^Nazjatar^^Smelly Pile of Gloop", 
    "169332^Nazjatar^^Strange Mineralized Water", 
    "169334^Nazjatar^^Strange Oceanic Sediment", 
    "169333^Nazjatar^^Strange Volcanic Rock", 
    "167915^Nazjatar^^Sweet Sea Vegetable", 
    "170181^Nazjatar^^Tidal Guard", 
    "167912^Nazjatar^^Unidentified Mass", 
    "170158^Nazjatar^^Unspeakable Pearl Idol", 
    "168053^Nazjatar^^Unusually Wise Hermit Crab", 
    "170161^Nazjatar^Reputation^Unusually Wise Hermit Crab", 
    "169942^Nazjatar^Reputation^Vibrant Sea Blossom", 
    "170162^Nazjatar^^Waterlogged Toolbox", 
    "170502^Nazjatar^^Waterlogged Toolbox",
      }