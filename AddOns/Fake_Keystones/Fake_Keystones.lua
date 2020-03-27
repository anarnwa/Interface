local ADDON, ns = ...
local FakeKeystone = LibStub("AceAddon-3.0"):NewAddon(ADDON, "AceConsole-3.0","AceEvent-3.0","AceHook-3.0","AceComm-3.0")

local mapIDs = {
	244,	-- 阿塔达萨 
	245,	-- 自由镇 
	246,	-- 托尔达戈 
	247,	-- 暴富矿区！！ 
	248,	-- 维克雷斯庄园 
	249,	-- 诸王之眠 
	250,	-- 塞塔里斯神庙 
	251,	-- 地渊孢林 
	252,	-- 风暴神殿 
	353,	-- 围攻伯拉勒斯
	369,	-- 麦卡贡行动 - 垃圾场 
	370,	-- 麦卡贡行动 - 车间
}

local affixes  = {
	1,		-- 溢出 
	2,		-- 无常 
	3,		-- 火山 
	4,		-- 死疽 
	5,		-- 繁盛 
	6,		-- 暴怒 
	7,		-- 激励 
	8,		-- 血池 
	9,		-- 残暴 
	10,		-- 强韧 
	11,		-- 崩裂 
	12,		-- 重伤 
	13,		-- 易爆 
	14,		-- 震荡 
	15,		-- 冷酷 
	16,		-- 共生 
	117,	-- 收割 
	119,	-- 迷醉
	120,	-- 觉醒
}

local mapNames = {}
local affixNames = {}

local defaults = {
	["mapId"] = 245,
	["mythiclevel"] = 18,
	["affixId1"] = 9,
	["affixId2"] = 11,
	["affixId3"] = 4,
	["affixId4"] = 120,
	["angrykeystone"] = true,
}

function FakeKeystone:LoadCurrentAffixes()
	local affixes = C_MythicPlus.GetCurrentAffixes() 
    if not affixes then return end 
	for index in ipairs(affixes) do 
       self.db["affixId"..index] = affixes[index].id
	end 
end

function FakeKeystone:PrintKeyStone()
	self:SendKeystone()
	local mapId, level, affixId1, affixId2, affixId3, affixId4 = self.db["mapId"], self.db["mythiclevel"], self.db["affixId1"], self.db["affixId2"], self.db["affixId3"], self.db["affixId4"]
	local keystone = string.format(CHALLENGE_MODE_KEYSTONE_HYPERLINK, C_ChallengeMode.GetMapUIInfo(mapId), level)
	if not keystone then return end
	local str = "|cffa335ee|Hkeystone:158923:"..mapId..":"..level..":"..affixId1..":"..affixId2..":"..affixId3..":"..affixId4.."|h["..keystone.."]|h|r"

	DEFAULT_CHAT_FRAME:AddMessage(str)
end

local function get_function(info)
	return FakeKeystone.db[info[#info]]
end

local function set_function(info, val)
	FakeKeystone.db[info[#info]] = val
end

local options_table = {
	keystone = {
		order = 1,
		name = CHALLENGES,
		type = "group",
		args = {
			mapId = {
				name = DUNGEONS,
				order = 1,
				type = "select",
				values = mapNames,
				get = get_function,
				set = set_function,
				width = "double"
			},
			mythiclevel = {
				name = "钥石等级",
				order = 2,
				type = "range",
				min = 2,
				max = 30,
				step = 1,
				get = get_function,
				set = set_function,
				width = "double"
			},
			affixId1 = {
				name = "词缀1",
				order = 3,
				type = "select",
				values = affixNames,
				get = get_function,
				set = set_function,
			},
			affixId2 = {
				name = "词缀2",
				order = 4,
				type = "select",
				values = affixNames,
				get = get_function,
				set = set_function,
			},
			affixId3 = {
				name = "词缀3",
				order = 5,
				type = "select",
				values = affixNames,
				get = get_function,
				set = set_function,
			},
			affixId4 = {
				name = "词缀4",
				order = 6,
				type = "select",
				values = affixNames,
				get = get_function,
				set = set_function,
			},
			printKS = {
				name = "打印",
				desc = "打印钥石链接到聊天栏, 并发送AngryKeystones信息",
				order = 7,
				type = "execute",
				func = function() FakeKeystone:PrintKeyStone() end,
			},
			reset = {
				name = RESET,
				desc = "重置词缀为本周词缀",
				order = 8,
				type = "execute",
				func = function() FakeKeystone:LoadCurrentAffixes() end,
			},
		}
	},
	angrykeystone = {
		order = 2,
		name = "AngryKeystones",
		type = "group",
		args = {
			enable = {
				name = ENABLE,
				order = 1,
				type = "toggle",
				get = function() return FakeKeystone.db["angrykeystone"] end,
				set = function(_, val)
					FakeKeystone.db["angrykeystone"] = val 
				end,
			},
			description = {
				name = "伪装AngryKeystones自动发送钥石信息",
				order = 2,
				type = "description",
			}
		}
	}
}

local function getKeystone(current)
	local keystoneMapID = FakeKeystone.db["mapId"]
	local keystoneLevel = FakeKeystone.db["mythiclevel"]
	if current and type(current) == "boolean" then
		keystoneMapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
		keystoneLevel = C_MythicPlus.GetOwnedKeystoneLevel()
	end

	local message = "0"
	if keystoneLevel and keystoneMapID then
		message = string.format("%d:%d", keystoneMapID, keystoneLevel)
	end

	return message
end

function FakeKeystone:SendKeystone()
	if not FakeKeystone.db["angrykeystone"] then return end
	local message = getKeystone()
	FakeKeystone:SendCommMessage("AngryKeystones", "Schedule|"..message, "PARTY")
	FakeKeystone:SendCommMessage("FakeKeystones", getKeystone(true), "PARTY")
end

function FakeKeystone:ShowConfig()
	LibStub("AceConfigDialog-3.0"):SetDefaultSize(ADDON, 600, 400)
	LibStub("AceConfigDialog-3.0"):Open(ADDON)
end

function FakeKeystone:OnInitialize()
	self.db = FakeKeystones_DB or {}
    FakeKeystones_DB = self.db

	for key in pairs(self.db) do
		if defaults[key] == nil then
			self.db[key] = nil
		end
	end

	for key, value in pairs(defaults) do
		if self.db[key] == nil then
			if type(value) == "table" then
				self.db[key] = {}
				for k in pairs(value) do
					self.db[key][k] = value[k]
				end
			else
				self.db[key] = value
			end
		end
	end

	for i=1,#mapIDs do
		mapNames[mapIDs[i]] = C_ChallengeMode.GetMapUIInfo(mapIDs[i])
	end

	for i=1,#affixes do
		affixNames[affixes[i]] = C_ChallengeMode.GetAffixInfo(affixes[i])
	end
	affixNames[0] = NONE

	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(ADDON, {
		type = "group",
		name = "Fake Keystones",
		args = options_table,
	})
	self:RegisterChatCommand("fks", "ShowConfig")
	self:RegisterChatCommand("fakekeystones", "ShowConfig")
	self:RegisterComm("FakeKeystones")
end

function FakeKeystone:OnEnable()
	self:LoadCurrentAffixes()

	if IsAddOnLoaded("AngryKeystones") then 
	    local mod = AngryKeystones.Modules.Schedule
		if mod then
			self:RawHook(mod, "SendCurrentKeystone", function()
				if self.db["angrykeystone"] then
					self:SendKeystone()
				else
					self.hooks[mod].SendCurrentKeystone(mod)
				end
			end, true)
		end
	else
		self:RegisterComm("AngryKeystones")
		self:RegisterEvent("GROUP_ROSTER_UPDATE", "SendKeystone")
		self:RegisterEvent("CHALLENGE_MODE_START", "SendKeystone")
		self:RegisterEvent("CHALLENGE_MODE_COMPLETED", "SendKeystone")
	end
end

function FakeKeystone:OnCommReceived(prefix, message, distribution, sender)
	if string.match(message, "quest") then
		self.SendKeystone()
	end
end