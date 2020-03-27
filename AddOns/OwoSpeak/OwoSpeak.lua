local owos = {
	"OwO",
	"owo",
	"UwU",
	"uwu",
	"^w^",
	">w<",
	"(´•ω•`)",
	"(*^▽^*)",
	"┗( ▔, ▔ )┛",
	"∑(っ°Д°;)っ",

}

local defaults = {
	db_version = 1,
	enabled = true,
}

local db
local hyperlinks = {}

local function OnEvent(self, event, addon)
	if addon == "OwoSpeak" then
		if not OwoSpeakDB or OwoSpeakDB.db_version < defaults.db_version then
			OwoSpeakDB = CopyTable(defaults)
		end
		db = OwoSpeakDB
		self:UnregisterEvent("ADDON_LOADED")
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", OnEvent)

local function ReplaceLink(s)
	tinsert(hyperlinks, s)
	return "owo"..#hyperlinks
end

local function RestoreLink(s)
	local n = tonumber(s:match("%d"))
	return hyperlinks[n]
end

local makeowo = SendChatMessage

function SendChatMessage(msg, ...)
	if db.enabled then
		wipe(hyperlinks)
		local owo = owos[random(#owos)]
		local whatsthis = random(10)
		-- tempowawiwy wepwace winks with owos
		local s = msg:gsub("|c.-|r", ReplaceLink)
		s = whatsthis <= 6 and s.." "..owo or s:gsub("!$", " "..owo)
		-- pwease owo wesponsibwy
		s = #s <= 255 and s:gsub("owo%d", RestoreLink) or msg
		makeowo(s, ...)
	else
		makeowo(msg, ...)
	end
end

local EnabledMsg = {
	[true] = "|cffADFF2FEnabwed|r",
	[false] = "|cffFF2424Disabwed|r",
}

SLASH_OWOSPEAK1 = "/owo"
SLASH_OWOSPEAK2 = "/owospeak"

SlashCmdList.OWOSPEAK = function()
	db.enabled = not db.enabled
	print("OwoSpeak: "..EnabledMsg[db.enabled])
end
