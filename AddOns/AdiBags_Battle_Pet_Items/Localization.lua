local addonName, addon = ...

local L = setmetatable({}, {
	__index = function(self, key)
		if key then
			rawset(self, key, tostring(key))
		end
		return tostring(key)
	end,
})
addon.L = L

local locale = GetLocale()

if locale == "deDE" then
--Translation missing
elseif locale == "enUS" then
L["Battle Pet Items"] = true
L["Items that are connected to Battle Pets and not actual pets."] = true
L["Miscellaneous Items"] = true
L["Items that dont fall into any other categorys"] = true
L["Battle Pet Currency Items"] = true
L["Items used to buy Battle Pet related Items"] = true
L["Drop Battle Pet containers"] = true
L["Items that drop that can contain Battle Pets"] = true
L["Bags and Supplies"] = true
L["Bags that are obtained that contain Battle Pet Items"] = true
L["Rarity Stones"] = true
L["Items that increase rarity of Battle Pets"] = true
L["Training Stones"] = true
L["Items that add levels to Battle Pets"] = true
L["Pet Toys"] = true
L["Toys usable with all Battle Pets"] = true
L["Pug Costumes"] = true
L["All items for your Perky Pugs"] = true
elseif locale == "esES" then
--Translation missing
elseif locale == "esMX" then
--Translation missing
elseif locale == "frFR" then
--Translation missing
elseif locale == "itIT" then
--Translation missing
elseif locale == "koKR" then
	-- From Comiluv
L["Battle Pet Items"] = "전투 애완동물 물품"
L["Items that are connected to Battle Pets and not actual pets."] = "전투 애완동물과 관련이 있지만 실제 전투 애완동물이 아닌 물품."
L["Miscellaneous Items"] = "기타 물품"
L["Items that dont fall into any other categorys"] = "다른 분류에 속하지 않는 물품"
L["Battle Pet Currency Items"] = "전투 애완동물 화폐"
L["Items used to buy Battle Pet related Items"] = "전투 애완동물 관련 상품을 사는데 필요한 물품"
L["Drop Battle Pet containers"] = "전투 애완동물 상자를 생성"
L["Items that drop that can contain Battle Pets"] = "전투 애완동물을 포함할 수 있는 물품"
L["Bags and Supplies"] = "가방과 도구들"
L["Bags that are obtained that contain Battle Pet Items"] = "전투 애완동물 물품을 담은 가방"
L["Rarity Stones"] = "훈련석"
L["Items that increase rarity of Battle Pets"] = "전투 애완동물의 등급를 상승하는 물품"
L["Training Stones"] = "전투석"
L["Items that add levels to Battle Pets"] = "전투 애완동물의 레벨을 상승하는 물품"
L["Pet Toys"] = "전투 애완동물 장난감"
L["Toys usable with all Battle Pets"] = "모든 전투 애완동물에 사용할 수 있는 물품"
L["Pug Costumes"] = "막공이 의상"
L["All items for your Perky Pugs"] = "명랑한 막공이가 사용할 수 있는 물품"
elseif locale == "ptBR" then
--Translation missing
elseif locale == "ruRU" then
--Translation missing
elseif locale == "zhCN" then
	L["Battle Pet Items"] = "宠物用品"
L["Items that are connected to Battle Pets and not actual pets."] = "与战斗宠物相关的物品"
L["Miscellaneous Items"] = "杂物"
L["Items that dont fall into any other categorys"] = "不属于任何其他类别的项目"
L["Battle Pet Currency Items"] = "宠物货币"
L["Items used to buy Battle Pet related Items"] = "用于购买宠物物品的物品"
L["Drop Battle Pet containers"] = true
L["Items that drop that can contain Battle Pets"] = true
L["Bags and Supplies"] = true
L["Bags that are obtained that contain Battle Pet Items"] = true
L["Rarity Stones"] = true
L["Items that increase rarity of Battle Pets"] = true
L["Training Stones"] = true
L["Items that add levels to Battle Pets"] = true
L["Pet Toys"] = "宠物玩具"
L["Toys usable with all Battle Pets"] = true
L["Pug Costumes"] = true
L["All items for your Perky Pugs"] = true
--Translation missing
elseif locale == "zhTW" then
--Translation missing
end

-- Replace remaining true values by their key
for k,v in pairs(L) do
	if v == true then
		L[k] = k
	end
end
