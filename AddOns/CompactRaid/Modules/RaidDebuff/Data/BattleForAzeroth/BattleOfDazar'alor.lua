------------------------------------------------------------
-- BattleOfDazar'alor.lua
--
-- Abin
-- 2018/08/31
------------------------------------------------------------

local module = CompactRaid:GetModule("RaidDebuff")
if not module then return end

local TIER = 8 -- BFA
local INSTANCE = 1176 -- Battle of Dazar'alor
local BOSS

BOSS = 2344 -- 圣光勇士
module:RegisterDebuff(TIER, INSTANCE, 2344, 283651, 5)
module:RegisterDebuff(TIER, INSTANCE, 2344, 283582, 4)
module:RegisterDebuff(TIER, INSTANCE, 2344, 283583, 4)

BOSS = 2333 -- 圣光勇士
module:RegisterDebuff(TIER, INSTANCE, 2333, 283651, 5)
module:RegisterDebuff(TIER, INSTANCE, 2333, 283582, 4)
module:RegisterDebuff(TIER, INSTANCE, 2333, 283583, 4)

BOSS = 2323 -- 玉火大师
module:RegisterDebuff(TIER, INSTANCE, 2323, 286988, 5)
module:RegisterDebuff(TIER, INSTANCE, 2323, 284374, 2)
module:RegisterDebuff(TIER, INSTANCE, 2323, 282037, 3)
module:RegisterDebuff(TIER, INSTANCE, 2323, 285632, 5)
module:RegisterDebuff(TIER, INSTANCE, 2323, 288151, 2)
module:RegisterDebuff(TIER, INSTANCE, 2323, 284089, 3)
module:RegisterDebuff(TIER, INSTANCE, 2323, 286369, 1)
module:RegisterDebuff(TIER, INSTANCE, 2323, 284453, 1)
module:RegisterDebuff(TIER, INSTANCE, 2323, 288051, 4)
module:RegisterDebuff(TIER, INSTANCE, 2323, 287747, 3)

BOSS = 2341 -- 玉火大师
module:RegisterDebuff(TIER, INSTANCE, 2341, 286988, 5)
module:RegisterDebuff(TIER, INSTANCE, 2341, 284374, 2)
module:RegisterDebuff(TIER, INSTANCE, 2341, 282037, 3)
module:RegisterDebuff(TIER, INSTANCE, 2341, 285632, 5)
module:RegisterDebuff(TIER, INSTANCE, 2341, 288151, 2)
module:RegisterDebuff(TIER, INSTANCE, 2341, 284089, 3)
module:RegisterDebuff(TIER, INSTANCE, 2341, 286369, 1)
module:RegisterDebuff(TIER, INSTANCE, 2341, 284453, 1)
module:RegisterDebuff(TIER, INSTANCE, 2341, 288051, 4)
module:RegisterDebuff(TIER, INSTANCE, 2341, 287747, 3)


BOSS = 2325 -- 格洛恩
module:RegisterDebuff(TIER, INSTANCE, 2325, 285671, 3)
module:RegisterDebuff(TIER, INSTANCE, 2325, 285875, 2)
module:RegisterDebuff(TIER, INSTANCE, 2325, 289292, 4)
module:RegisterDebuff(TIER, INSTANCE, 2325, 289307, 5)
module:RegisterDebuff(TIER, INSTANCE, 2325, 289412, 4)
module:RegisterDebuff(TIER, INSTANCE, 2325, 285998, 4)
module:RegisterDebuff(TIER, INSTANCE, 2325, 285659, 4)
module:RegisterDebuff(TIER, INSTANCE, 2325, 283069, 5)

BOSS = 2340 -- 格洛恩
module:RegisterDebuff(TIER, INSTANCE, 2340, 285671, 3)
module:RegisterDebuff(TIER, INSTANCE, 2340, 285875, 2)
module:RegisterDebuff(TIER, INSTANCE, 2340, 289292, 4)
module:RegisterDebuff(TIER, INSTANCE, 2340, 289307, 5)
module:RegisterDebuff(TIER, INSTANCE, 2340, 289412, 4)
module:RegisterDebuff(TIER, INSTANCE, 2340, 285998, 4)
module:RegisterDebuff(TIER, INSTANCE, 2340, 285659, 4)
module:RegisterDebuff(TIER, INSTANCE, 2340, 283069, 5)

BOSS = 2342 -- 丰灵
module:RegisterDebuff(TIER, INSTANCE, 2342, 283610, 5)
module:RegisterDebuff(TIER, INSTANCE, 2342, 283609, 5)
module:RegisterDebuff(TIER, INSTANCE, 2342, 283507, 4)
module:RegisterDebuff(TIER, INSTANCE, 2342, 287648, 4)
module:RegisterDebuff(TIER, INSTANCE, 2342, 287648, 5)
module:RegisterDebuff(TIER, INSTANCE, 2342, 284105, 5)
module:RegisterDebuff(TIER, INSTANCE, 2342, 284424, 4)
module:RegisterDebuff(TIER, INSTANCE, 2342, 284470, 5)
module:RegisterDebuff(TIER, INSTANCE, 2342, 285014, 5)
module:RegisterDebuff(TIER, INSTANCE, 2342, 284556, 3)


BOSS = 2330 -- 神选者教团
module:RegisterDebuff(TIER, INSTANCE, 2330, 285945, 3)
module:RegisterDebuff(TIER, INSTANCE, 2330, 282209, 5)
module:RegisterDebuff(TIER, INSTANCE, 2330, 282444, 3)
module:RegisterDebuff(TIER, INSTANCE, 2330, 282135, 4)
module:RegisterDebuff(TIER, INSTANCE, 2330, 282592, 3)
module:RegisterDebuff(TIER, INSTANCE, 2330, 286838, 3)
module:RegisterDebuff(TIER, INSTANCE, 2330, 285879, 5)
module:RegisterDebuff(TIER, INSTANCE, 2330, 284663, 5)
module:RegisterDebuff(TIER, INSTANCE, 2330, 286811, 5)
module:RegisterDebuff(TIER, INSTANCE, 2330, 282834, 3)
module:RegisterDebuff(TIER, INSTANCE, 2330, 282447, 3)


BOSS = 2335 -- 拉斯塔哈大王
module:RegisterDebuff(TIER, INSTANCE, 2335, 285044, 5)
module:RegisterDebuff(TIER, INSTANCE, 2335, 284831, 4)
module:RegisterDebuff(TIER, INSTANCE, 2335, 289858, 4)
module:RegisterDebuff(TIER, INSTANCE, 2335, 284781, 5)
module:RegisterDebuff(TIER, INSTANCE, 2335, 285349, 3)
module:RegisterDebuff(TIER, INSTANCE, 2335, 284995, 5)
module:RegisterDebuff(TIER, INSTANCE, 2335, 288449, 5)
module:RegisterDebuff(TIER, INSTANCE, 2335, 284455, 3)
module:RegisterDebuff(TIER, INSTANCE, 2335, 284455, 3)
module:RegisterDebuff(TIER, INSTANCE, 2335, 288415, 4)
module:RegisterDebuff(TIER, INSTANCE, 2335, 285213, 4)
module:RegisterDebuff(TIER, INSTANCE, 2335, 287147, 3)
module:RegisterDebuff(TIER, INSTANCE, 2335, 286742, 3)
module:RegisterDebuff(TIER, INSTANCE, 2335, 286779, 4)


BOSS = 2334 -- Mekkatorque
module:RegisterDebuff(TIER, INSTANCE, 2334, 289699, 2)
module:RegisterDebuff(TIER, INSTANCE, 2334, 286646, 5)
module:RegisterDebuff(TIER, INSTANCE, 2334, 288806, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 284168, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 284168, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 282182, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 287891, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 284214, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 286516, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 286480, 4)
module:RegisterDebuff(TIER, INSTANCE, 2334, 282408, 3)
module:RegisterDebuff(TIER, INSTANCE, 2334, 289023, 3)
module:RegisterDebuff(TIER, INSTANCE, 2334, 287167, 5)


BOSS = 2337 -- Stormwall Blockade
module:RegisterDebuff(TIER, INSTANCE, 2337, 284405, 5)
module:RegisterDebuff(TIER, INSTANCE, 2337, 284410, 5)
module:RegisterDebuff(TIER, INSTANCE, 2337, 284121, 4)
module:RegisterDebuff(TIER, INSTANCE, 2337, 284369, 4)
module:RegisterDebuff(TIER, INSTANCE, 2337, 285000, 3)
module:RegisterDebuff(TIER, INSTANCE, 2337, 285382, 2)
module:RegisterDebuff(TIER, INSTANCE, 2337, 285075, 3)
module:RegisterDebuff(TIER, INSTANCE, 2337, 285420, 3)


BOSS = 2343 -- Lady Jaina Proudmoore
module:RegisterDebuff(TIER, INSTANCE, 2343, 287993, 3)
module:RegisterDebuff(TIER, INSTANCE, 2343, 287490, 5)
module:RegisterDebuff(TIER, INSTANCE, 2343, 288038, 5)
module:RegisterDebuff(TIER, INSTANCE, 2343, 287365, 2)
module:RegisterDebuff(TIER, INSTANCE, 2343, 285254, 2)
module:RegisterDebuff(TIER, INSTANCE, 2343, 288394, 3)
module:RegisterDebuff(TIER, INSTANCE, 2343, 288212, 4)
module:RegisterDebuff(TIER, INSTANCE, 2343, 288374, 4)
module:RegisterDebuff(TIER, INSTANCE, 2343, 288297, 2)
module:RegisterDebuff(TIER, INSTANCE, 2343, 289219, 4)






BOSS = 0 -- Trash
