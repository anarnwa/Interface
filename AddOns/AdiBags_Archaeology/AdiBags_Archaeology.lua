local addon_name, addon = ...
local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")

-- localization table; returns English phrase if translation is not found -----
-- see https://phanx.net/addons/tutorials/localize for details ----------------
local L = setmetatable({}, {
    __index = function(t, k)
        local v = tostring(k)
        rawset(t, k, v)
        return v
    end
})

local LOCALE = GetLocale()
if LOCALE == "enUS" then
L["Archaeology Bought Items"] = true
L["Archaeology Items"] = true
L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = true
L["Purchasable things from vendors."] = true
L["Put the artifact on display."] = true
L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = true
L["Use: Carefully crate the restored artifact."] = true
elseif LOCALE == "deDE" then
L["Archaeology Bought Items"] = "Archäologie - gekaufte Gegenstände"
L["Archaeology Items"] = "Archäologie-Gegenstände"
L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = "Filtere alle Kisten, Schlüsselsteine, vollständige und wiederhergestelle Artefakte in ihre eigene Kategorie"
L["Purchasable things from vendors."] = "Kaufbare Dinge von Händlern."
L["Put the artifact on display."] = "Stelle das Artefakt zur Schau."
L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = "Belohnungen von Legion-Archäologie-Quests. Beinhaltet nicht Spielzeuge oder Reittiere."
L["Use: Carefully crate the restored artifact."] = "Benutzen: Das restaurierte Artefakt vorsichtig in eine Kiste packen."

elseif LOCALE == "koKR" then
--[[Translation missing --]]
--[[ L["Archaeology Bought Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Archaeology Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = ""--]] 
L["Purchasable things from vendors."] = "공급 업체가 구매할 수있는 것."
L["Put the artifact on display."] = "유물을 전시에 놓으십시오."
--[[Translation missing --]]
--[[ L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = ""--]] 
--[[Translation missing --]]
--[[ L["Use: Carefully crate the restored artifact."] = ""--]] 

elseif LOCALE == "ruRU" then
L["Archaeology Bought Items"] = "Археология куплены предметы"
L["Archaeology Items"] = "Предметы археологии"
L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = "Отфильтруйте все ящики, завершенные артефакты, ключевые камни и восстановленные артефакты в свою категорию."
L["Purchasable things from vendors."] = "Покупные предметы у продавцов."
L["Put the artifact on display."] = "Поместите экспонат на дисплей."
L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = "Награды от археологических заданий Легиона. Не включает игрушки или маунтов."
L["Use: Carefully crate the restored artifact."] = "Использование: аккуратно сложите восстановленный артефакт."

elseif LOCALE == "esES" then
L["Archaeology Bought Items"] = "Archaeology Bought Items"
L["Archaeology Items"] = "Archaeology Items"
L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = "Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."
L["Purchasable things from vendors."] = "Cosas comprables de los vendedores."
L["Put the artifact on display."] = "Ponga el artefacto en la pantalla."
L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = "Rewards from Legion Archaeology quests. Does not include toys or mounts."
L["Use: Carefully crate the restored artifact."] = "Use: Carefully crate the restored artifact."

elseif LOCALE == "esMX" then
--[[Translation missing --]]
--[[ L["Archaeology Bought Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Archaeology Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = ""--]] 
L["Purchasable things from vendors."] = "Cosas comprables de los vendedores."
L["Put the artifact on display."] = "Ponga el artefacto en la pantalla."
--[[Translation missing --]]
--[[ L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = ""--]] 
--[[Translation missing --]]
--[[ L["Use: Carefully crate the restored artifact."] = ""--]] 

elseif LOCALE == "itIT" then
L["Archaeology Bought Items"] = "Articoli acquistati di archeologia"
L["Archaeology Items"] = "Articoli di archeologia"
L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = "Filtra tutte le casse, gli artefatti, le pietre chiave e gli artefatti ripristinati nella loro categoria."
L["Purchasable things from vendors."] = "Cose acquistabili dai venditori."
L["Put the artifact on display."] = "Mettere in mostra l'artefatto."
L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = "Premi ottenuti dalle missioni di Archeologia della Legione. Non include giocattoli o supporti."
L["Use: Carefully crate the restored artifact."] = "Usa: Accuratamente la cassa del manufatto restaurato"

elseif LOCALE == "ptBR" then
--[[Translation missing --]]
--[[ L["Archaeology Bought Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Archaeology Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = ""--]] 
L["Purchasable things from vendors."] = "Coisas compráveis de fornecedores."
L["Put the artifact on display."] = "Coloque o artefato em exibição."
--[[Translation missing --]]
--[[ L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = ""--]] 
--[[Translation missing --]]
--[[ L["Use: Carefully crate the restored artifact."] = ""--]] 

elseif LOCALE == "zhTW" then
L["Archaeology Bought Items"] = "考古學購買物品"
L["Archaeology Items"] = "考古學物品"
L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = "將所有集裝箱、完成的聖物、鑰石以及恢復的聖物過濾到自己的類別中。"
L["Purchasable things from vendors."] = "從供應商處購買東西。"
L["Put the artifact on display."] = "顯示神器。"
L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = "從軍團考古任務得來的獎勵。不包含玩具或坐騎。"
L["Use: Carefully crate the restored artifact."] = "使用：小心的修復已恢復的聖物。"

elseif LOCALE == "zhCN" then
--[[Translation missing --]]
--[[ L["Archaeology Bought Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Archaeology Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = ""--]] 
L["Purchasable things from vendors."] = "从供应商处购买东西。"
L["Put the artifact on display."] = "显示神器。"
--[[Translation missing --]]
--[[ L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = ""--]] 
--[[Translation missing --]]
--[[ L["Use: Carefully crate the restored artifact."] = ""--]] 

elseif LOCALE == "frFR" then
--[[Translation missing --]]
--[[ L["Archaeology Bought Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Archaeology Items"] = ""--]] 
--[[Translation missing --]]
--[[ L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."] = ""--]] 
L["Purchasable things from vendors."] = "Les choses achetables des fournisseurs."
L["Put the artifact on display."] = "Mettez l'artefact sur l'affichage."
--[[Translation missing --]]
--[[ L["Rewards from Legion Archaeology quests. Does not include toys or mounts."] = ""--]] 
--[[Translation missing --]]
--[[ L["Use: Carefully crate the restored artifact."] = ""--]] 

end

-- Replace remaining true values by their key
for k, v in pairs(L) do
	if v == true then
		L[k] = k
	end
end

local MatchIDs
local Tooltip
local Result = {}

local function AddToSet(Set, List)
	for _, v in ipairs(List) do
		Set[v] = true
	end
end

-- known Archaeology items list -----------------------------------------------
local items = {
    -- crates
    87536,      -- Night Elf
    87533,      -- Dwarf
    87534,      -- Draenei
    87535,      -- Fossil
    87537,      -- Nerubian
    87538,      -- Orc
    87539,      -- Tol'vir
    87540,      -- Troll
    87541,      -- Vrykul
    117386,     -- Pandaren
    117387,     -- Mogu
    117388,     -- Mantid
    142113,     -- Arakkoa
    142114,     -- Draenor Clans
    142115,     -- Ogre
    164625,     -- Demon
    164626,     -- Highborne
    164627,     -- Tauren
    -- Restored Artifact
    87399,
    -- key stones
    109584,     -- Ogre Missive
    79869,      -- Mogu Statue Piece
    79868,      -- Pandaren Pottery Shard
    64397,      -- Tol'vir Hieroglypic
    52843,      -- Dwarf Rune Stone
    63128,      -- Troll Tablet
    63127,      -- Highborne Scroll
    64394,      -- Draenei Tome
    64392,      -- Orc Blood Text
    64395,      -- Vrykul Rune Stick
    64396,      -- Nerubian Obelisk
    95373,      -- Mantid Amber Sliver
    109585,     -- Arakkoa Cipher
    108439,     -- Draenor Clan Orator Cane
    130905,     -- Mark of the Deceiver
    130903,     -- Ancient Suramar Scroll
    130904,     -- Highmountain Ritual-Stone
    154989,     -- Zandalari Idol
    154990,     -- Etched Drust Bone
}

local purchases = {
    122606,     -- Explorer's Notebook
    87548,      -- Lorewalker's Lodestone
    87549,      -- Lorewalker's Map
    117389,     -- Draenor Achaeologist's Lodestone
    117390,     -- Draenor Archaeologist's Map
    104198,     -- Mantid Artifact Hunter's Kit
}

local quest_items = {
    136362,     -- Ancient War Remnants
    130924,     -- Pristine Pre-War Highborne Tapestry
    130931,     -- Pristine Imp's Cup
    130933,     -- Pristine Malformed Abyssal
    130935,     -- Pristine Houndstooth Hauberk
    130922,     -- Pristine Inert Leystone Charm
    130926,     -- Pristine Trailhead Drum
    130928,     -- Pristine Hand-Smoothed Pyrestone
    130930,     -- Pristine Stonewood Bow
    130932,     -- Pristine Flayed-Skin Chronicle
    130934,     -- Pristine Orb of Inner Chaos
    130921,     -- Pristine Violetglass Vessel
    130923,     -- Pristine Quietwine Vial
    130925,     -- Pristine Nobleman's Letter Opener
    130927,     -- Pristine Moosebone Fish-Hook
    130929,     -- Pristine Drogbar Gem-Roller
    51951,      -- Pristine Ancient Runebound Tome
    51950,      -- Pristine Ceremonial Bonesaw
    51952,      -- Pristine Disembowling Sickle
    51953,      -- Pristine Jagged Blade of the Drust
    51954,      -- Pristine Ritual Fetish
    51955,      -- Pristine Soul Coffer
    51926,      -- Pristine Akun'Jar Vase
    51937,      -- Pristine Blowgun of the Sethrak
    51936,      -- Pristine Bwonsamdi Voodoo Mask
    51934,      -- Pristine High Apothecary's Hood
    51932,      -- Pristine Rezan Idol
    51929,      -- Pristine Urn of Passage
}

local function MatchIDs_Init(self)
    table.wipe(Result)
    if self.db.profile.moveItems then
        AddToSet(Result, items)
    end

    if self.db.profile.moveCurrency then
        AddToSet(Result, purchases)
    end

    if self.db.profile.moveQuestItems then
        AddToSet(Result, quest_items)
    end

    return Result
end

local function Tooltip_Init()
	local tip, leftside = CreateFrame("GameTooltip"), {}
	for i = 1, 6 do
		local Left, Right = tip:CreateFontString(), tip:CreateFontString()
		Left:SetFontObject(GameFontNormal)
		Right:SetFontObject(GameFontNormal)
		tip:AddFontStrings(Left, Right)
		leftside[i] = Left
	end
	tip.leftside = leftside
	return tip
end

local setFilter = AdiBags:RegisterFilter("Archaeology", 90, "ABEvent-1.0")
setFilter.uiName = PROFESSIONS_ARCHAEOLOGY
setFilter.uiDesc = L["Archaeology Items"]

function setFilter:OnInitialize()
    self.db = AdiBags.db:RegisterNamespace("Archaeology", {
        profile = {
            moveItems = true,
            moveCurrency = true,
            moveQuestItems = true,
        }
    })
end

function setFilter:Update()
	MatchIDs = nil
	self:SendMessage("AdiBags_FiltersChanged")
end

function setFilter:OnEnable()
	AdiBags:UpdateFilters()
end

function setFilter:OnDisable()
	AdiBags:UpdateFilters()
end

function setFilter:Filter(slotData)
	MatchIDs = MatchIDs or MatchIDs_Init(self)
	if MatchIDs[slotData.itemId] then
		return PROFESSIONS_ARCHAEOLOGY
	end

	Tooltip = Tooltip or Tooltip_Init()
	Tooltip:SetOwner(UIParent,"ANCHOR_NONE")
	Tooltip:ClearLines()

	if slotData.bag == BANK_CONTAINER then
		Tooltip:SetInventoryItem("player", BankButtonIDToInvSlotID(slotData.slot, nil))
	else
		Tooltip:SetBagItem(slotData.bag, slotData.slot)
	end

    for i = 1, 6 do
        local t = Tooltip.leftside[i]:GetText()
        if self.db.profile.moveItems and t == L["Put the artifact on display."] or t == L["Use: Carefully crate the restored artifact."] then
            return PROFESSIONS_ARCHAEOLOGY
        end
    end

	Tooltip:Hide()
end

function setFilter:GetOptions()
    return{
        moveItems = {
            name = L["Archaeology Items"],
            desc = L["Filter all crates, completed artifacts, key stones, and restored artifacts into their own category."],
            type = "toggle",
            order = 10
        },
        moveCurrency = {
            name = L["Archaeology Bought Items"],
            desc = L["Purchasable things from vendors."],
            type = "toggle",
            order = 20,
        },
        moveQuestItems = {
            name = AUCTION_CATEGORY_QUEST_ITEMS,
            desc = L["Rewards from Legion Archaeology quests. Does not include toys or mounts."],
            type = "toggle",
            order = 30
        }
    },
    AdiBags:GetOptionHandler(self, false, function()
		return self:Update()
	end)
end
