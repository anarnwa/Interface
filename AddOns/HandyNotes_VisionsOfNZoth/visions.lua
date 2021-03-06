-------------------------------------------------------------------------------
---------------------------------- NAMESPACE ----------------------------------
-------------------------------------------------------------------------------

local ADDON_NAME, ns = ...
local L = ns.locale
local Class = ns.Class
local clone = ns.clone
local isinstance = ns.isinstance

local Map = ns.Map
local Node = ns.node.Node
local NPC = ns.node.NPC
local Rare = ns.node.Rare
local Treasure = ns.node.Treasure
local Mount = ns.reward.Mount
local Toy = ns.reward.Toy
local Path = ns.poi.Path

local options = ns.options.args.VisibilityGroup.args
local defaults = ns.optionDefaults.profile

-------------------------------------------------------------------------------

local Buff = Class('Buff', Node)
local Crystal = Class('Crystal', Node, {icon='orange_crystal', scale=1.5, label=L["odd_crystal"]})

local MAIL = Node({icon='envelope', scale=1.2, label=L["mailbox"], rewards={
    Mount({id=1315, item=174653}) -- Mail Muncher
}, note=L["mail_muncher"]})

local CHEST1 = Treasure({label=L["black_empire_cache"], sublabel=string.format(L["clear_sight"], 1)})
local CHEST2 = Treasure({label=L["black_empire_cache"], sublabel=string.format(L["clear_sight"], 2)})
local CHEST3 = Treasure({label=L["black_empire_cache"], sublabel=string.format(L["clear_sight"], 3)})

-------------------------------------------------------------------------------
------------------------------------- MAP -------------------------------------
-------------------------------------------------------------------------------

local orgrimmar = Map({ id=1469 })

function orgrimmar:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    local profile = ns.addon.db.profile
    if isinstance(node, Treasure) then return profile.chest_visions end
    if isinstance(node, Buff) then return profile.buff_visions end
    if node == MAIL then return profile.mail_visions end
    return profile.misc_visions
end

local stormwind = Map({ id=1470 })

function stormwind:enabled (node, coord, minimap)
    if not Map.enabled(self, node, coord, minimap) then return false end

    local profile = ns.addon.db.profile
    if isinstance(node, Treasure) then return profile.chest_visions end
    if isinstance(node, Buff) then return profile.buff_visions end
    if isinstance(node, Crystal) then return profile.crystal_visions end
    if node == MAIL then return profile.mail_visions end
    return profile.misc_visions
end

-------------------------------------------------------------------------------
----------------------------------- OPTIONS -----------------------------------
-------------------------------------------------------------------------------

defaults['chest_visions'] = true
defaults['buff_visions'] = true
defaults['crystal_visions'] = true
defaults['mail_visions'] = true
defaults['misc_visions'] = true

options.groupVisions = {
    type = "header",
    name = L["horrific_visions"],
    order = 20,
}

options.chestVisions = {
    type = "toggle",
    arg = "chest_visions",
    name = L["options_toggle_chests"],
    desc = L["options_toggle_visions_chest_desc"],
    order = 21,
    width = "normal",
}

options.buffVisions = {
    type = "toggle",
    arg = "buff_visions",
    name = L["options_toggle_visions_buffs"],
    desc = L["options_toggle_visions_buffs_desc"],
    order = 22,
    width = "normal",
}

options.crystalVisions = {
    type = "toggle",
    arg = "crystal_visions",
    name = L["options_toggle_visions_crystals"],
    desc = L["options_toggle_visions_crystals_desc"],
    order = 23,
    width = "normal",
}

options.mailVisions = {
    type = "toggle",
    arg = "mail_visions",
    name = L["options_toggle_visions_mail"],
    desc = L["options_toggle_visions_mail_desc"],
    order = 24,
    width = "normal",
}

options.miscVisions = {
    type = "toggle",
    arg = "misc_visions",
    name = L["options_toggle_misc"],
    desc = L["options_toggle_visions_misc_desc"],
    order = 25,
    width = "normal",
}

-------------------------------------------------------------------------------
---------------------------------- ORGRIMMAR ----------------------------------
-------------------------------------------------------------------------------

-- Valley of Strength
orgrimmar.nodes[46927409] = CHEST1
orgrimmar.nodes[48036506] = CHEST1
orgrimmar.nodes[48197761] = CHEST1
orgrimmar.nodes[49537689] = CHEST1
orgrimmar.nodes[50067075] = CHEST1
orgrimmar.nodes[52967707] = CHEST1

-- Valley of Spirits
orgrimmar.nodes[32046909] = CHEST2
orgrimmar.nodes[34746325] = CHEST2
orgrimmar.nodes[34937546] = CHEST2
orgrimmar.nodes[35556927] = CHEST2
orgrimmar.nodes[35767889] = CHEST2
orgrimmar.nodes[37528493] = CHEST2
orgrimmar.nodes[39388038] = CHEST2

-- The Drag
orgrimmar.nodes[56915817] = clone(CHEST2, {note=L["inside_building"]})
orgrimmar.nodes[57116273] = CHEST2
orgrimmar.nodes[57415604] = CHEST2
orgrimmar.nodes[57554961] = CHEST2
orgrimmar.nodes[60175638] = CHEST2
orgrimmar.nodes[60745806] = clone(CHEST2, {note=L["inside_building"]})
orgrimmar.nodes[60985254] = CHEST2

-- Valley of Wisdom
orgrimmar.nodes[39474727] = CHEST3
orgrimmar.nodes[41224994] = CHEST3
orgrimmar.nodes[42064971] = CHEST3
orgrimmar.nodes[45195352] = CHEST3
orgrimmar.nodes[46895101] = CHEST3
orgrimmar.nodes[48474897] = CHEST3
orgrimmar.nodes[48874617] = CHEST3

-- Valley of Honor
orgrimmar.nodes[66283141] = CHEST3
orgrimmar.nodes[66763903] = CHEST3
orgrimmar.nodes[69164858] = CHEST3
orgrimmar.nodes[69384572] = CHEST3

-------------------------------------------------------------------------------

-- Valley of Strength
orgrimmar.nodes[48708380] = Crystal({note=L["c_behind_bank_counter"]})
orgrimmar.nodes[49406870] = Crystal({note=L["c_hidden_boxes"]})
orgrimmar.nodes[53508200] = Crystal({note=L["c_inside_hut"]})

-- Valley of Spirits
orgrimmar.nodes[33406570] = Crystal({note=L["c_center_building"]})
orgrimmar.nodes[35406940] = Crystal({note=L["c_top_building"]})
orgrimmar.nodes[37908450] = Crystal({note=L["c_behind_pillar"]})
orgrimmar.nodes[38508070] = Crystal({note=L["c_behind_boss"]})

-- The Drag
orgrimmar.nodes[57605860] = Crystal({note=L["c_inside_orphanage"]})
orgrimmar.nodes[57706510] = Crystal({note=L["c_inside_transmog"]})
orgrimmar.nodes[57904860] = Crystal({note=L["c_behind_boss"]})
orgrimmar.nodes[60405510] = Crystal({note=L["c_inside_leatherwork"]})

-- Valley of Wisdom
orgrimmar.nodes[38904990] = Crystal({note=L["c_inside_big_tent"]})
orgrimmar.nodes[41704480] = Crystal({note=L["c_inside_hut"]})
orgrimmar.nodes[48404410] = Crystal({note=L["c_on_small_hill"]})
orgrimmar.nodes[51004520] = Crystal({note=L["c_by_pillar_boxes"]})

-- Valley of Honor
orgrimmar.nodes[63903040] = Crystal({note=L["c_behind_rexxar"]})
orgrimmar.nodes[65805060] = Crystal({note=L["c_inside_cacti"]})
orgrimmar.nodes[67003740] = Crystal({note=L["c_inside_auction"]})
orgrimmar.nodes[68204290] = Crystal({note=L["c_underneath_bridge"]})

-------------------------------------------------------------------------------

orgrimmar.nodes[39304900] = MAIL
orgrimmar.nodes[39708030] = MAIL
orgrimmar.nodes[52707580] = MAIL
orgrimmar.nodes[60105130] = MAIL
orgrimmar.nodes[67673924] = MAIL

-------------------------------------------------------------------------------

orgrimmar.nodes[32106430] = Buff({icon=461119, label=L["spirit_of_wind"],
    note=L["spirit_of_wind_note"]..'\n\n'..L["buffs_change"]})
orgrimmar.nodes[44667697] = Buff({icon=133044, label=L["smiths_strength"],
    note=L["smiths_strength_note"]..'\n\n'..L["buffs_change"]})
orgrimmar.nodes[54277833] = Buff({icon=134991, label=L["heroes_bulwark"],
    note=L["heroes_bulwark_note"]..'\n\n'..L["buffs_change"]})
orgrimmar.nodes[57676513] = Buff({icon=1717106, label=L["ethereal_essence"],
    note=L["ethereal_essence_note"]..'\n\n'..L["buffs_change"]})

-------------------------------------------------------------------------------

orgrimmar.nodes[54027044] = NPC({id=162358, icon=2823166, note=L["ethereal_note"]})
orgrimmar.nodes[46828078] = Node({icon=967522, label=L["colored_potion"],
    note=string.format(L["colored_potion_note"], L["yelmak"])})

local SHAVE_KIT = Node({icon=1001616, label=L["shave_kit"], note=L["shave_kit_note"], rewards={
    Toy({item=174920}) -- Coifcurl's Close Shave Kit
}})

function SHAVE_KIT:enabled (map, coord, minimap)
    if not Node.enabled(self, map, coord, minimap) then return false end
    return ns.addon.db.profile.always_show_treasures or (not self:done())
end

orgrimmar.nodes[39906120] = SHAVE_KIT

-------------------------------------------------------------------------------
---------------------------------- STORMWIND ----------------------------------
-------------------------------------------------------------------------------

-- Cathedral Square
stormwind.nodes[51955788] = CHEST1
stormwind.nodes[55085027] = CHEST1
stormwind.nodes[55845275] = CHEST1
stormwind.nodes[57034974] = CHEST1

-- Trade District
stormwind.nodes[61027547] = CHEST2
stormwind.nodes[61886605] = CHEST2
stormwind.nodes[63687447] = CHEST2
stormwind.nodes[66617039] = CHEST2

-- Dwarven District
stormwind.nodes[60573394] = CHEST2
stormwind.nodes[62522946] = CHEST2
stormwind.nodes[63424206] = CHEST2
stormwind.nodes[66223412] = CHEST2
stormwind.nodes[66694422] = CHEST2

-- Mage Quarter
stormwind.nodes[43018320] = CHEST3
stormwind.nodes[44658694] = CHEST3
stormwind.nodes[47478888] = CHEST3
stormwind.nodes[50169002] = CHEST3
stormwind.nodes[54048542] = CHEST3

-- Old Town
stormwind.nodes[72056202] = CHEST3
stormwind.nodes[73565625] = CHEST3
stormwind.nodes[75286476] = CHEST3
stormwind.nodes[76475374] = clone(CHEST3, {note=L["inside_building"]})

-------------------------------------------------------------------------------

-- Cathedral Square
stormwind.nodes[53005190] = Crystal({note=L["c_left_cathedral"]})
stormwind.nodes[54605940] = Crystal({note=L["c_behind_boxes"]})
stormwind.nodes[58405510] = Crystal({note=L["c_on_small_hill"]})

-- Trade District
stormwind.nodes[60406880] = Crystal({note=L["c_alley_corner"]})
stormwind.nodes[62007690] = Crystal({note=L["c_behind_mailbox"]})
stormwind.nodes[66107570] = Crystal({note=L["c_behind_cart"]})
stormwind.nodes[69007310] = Crystal({note=L["c_left_inquisitor"]})

-- Dwarven District
stormwind.nodes[62703700] = Crystal({note=L["c_forge_corner"]})
stormwind.nodes[63404170] = Crystal()
stormwind.nodes[64603090] = Crystal({note=L["c_behind_boxes"]})
stormwind.nodes[67304470] = Crystal({note=L["c_forge_corner"]})

-- Mage Quarter
stormwind.nodes[44208790] = Crystal({note=L["c_walkway_corner"]})
stormwind.nodes[47408160] = Crystal({note=L["c_behind_house_counter"]})
stormwind.nodes[47708940] = Crystal({note=L["c_walkway_platform"]})
stormwind.nodes[52408340] = Crystal({note=L["c_behind_house_counter"]})

-- Old Town
stormwind.nodes[74605920] = Crystal({note=L["c_behind_boxes"]})
stormwind.nodes[75605340] = Crystal({note=L["c_bar_upper"]})
stormwind.nodes[75606460] = Crystal({note=L["c_behind_mailbox"]})
stormwind.nodes[76506850] = Crystal({note=L["c_behind_stables"]})

-------------------------------------------------------------------------------

stormwind.nodes[49688700] = MAIL
stormwind.nodes[54635751] = MAIL
stormwind.nodes[61687604] = MAIL
stormwind.nodes[62073082] = MAIL
stormwind.nodes[75716456] = MAIL

-------------------------------------------------------------------------------

stormwind.nodes[58404919] = Buff({icon=132183, label=L["bear_spirit"],
    note=L["bear_spirit_note"]..'\n\n'..L["buffs_change"]})
stormwind.nodes[53545906] = Buff({icon=1621334, label=L["requited_bulwark"],
    note=L["requited_bulwark_note"]..'\n\n'..L["buffs_change"]})
stormwind.nodes[59553713] = Buff({icon=133035, label=L["empowered"],
    note=L["empowered_note"]..'\n\n'..L["buffs_change"]})
stormwind.nodes[63107740] = Buff({icon=133784, label=L["enriched"],
    note=L["enriched_note"]..'\n\n'..L["buffs_change"]})

-------------------------------------------------------------------------------

stormwind.nodes[57204620] = NPC({id=162358, icon=2823166, note=L["ethereal_note"]})
stormwind.nodes[51765852] = Node({icon=967522, label=L["colored_potion"],
    note=string.format(L["colored_potion_note"], L["morgan_pestle"])})

local VOID_SKULL = Node({icon=237272, label=L["void_skull"], note=L["void_skull_note"], rewards={
    Toy({item=174921}) -- Void-Touched Skull
}})

function VOID_SKULL:enabled (map, coord, minimap)
    if not Node.enabled(self, map, coord, minimap) then return false end
    return ns.addon.db.profile.always_show_treasures or (not self:done())
end

stormwind.nodes[58905290] = VOID_SKULL

stormwind.nodes[59106390] = Rare({id=158284, note=L["craggle"], pois={
    Path({
        58707630, 57507290, 56406950, 56706670, 59106390, 62306130, 64706190,
        67006490, 68406710
    })
}, rewards={
    Toy({item=174926}) -- Overly Sensitive Void Spectacles
}}) -- Craggle Wobbletop

-------------------------------------------------------------------------------

ns.maps[orgrimmar.id] = orgrimmar
ns.maps[stormwind.id] = stormwind
