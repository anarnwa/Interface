--[[
	Main.lua handles events and initialization
]]

local tamer = BattlePetDailyTamer

-- event dispatcher
function tamer:OnEvent(event, ...)
	if tamer[event] then
		tamer[event](self, ...)
	end
end

-- initialization event
function tamer:PLAYER_LOGIN()
	-- make sure savedvar exists and load default values
	BattlePetDailyTamerSettings = BattlePetDailyTamerSettings or {}
	local settings = BattlePetDailyTamerSettings
	for _,pawInfo in ipairs(tamer.pawInfo) do
		if settings[pawInfo[2]]==nil then -- setting doesn't exist
			settings[pawInfo[2]] = pawInfo[3] -- give it a default value
		end
	end

	-- setup WorldMapFrame stuff. WorldMapFrame (the frame) is defined in a load-on-demand
	-- module but seems to be loaded on login. to be certain, assuming nothing
	if IsAddOnLoaded("Blizzard_WorldMap") then
		-- this data provider thing generates an insane amount of garbage :(
		WorldMapFrame:AddDataProvider(tamer.dataProvider)
		tamer:SetupTrackingButton()
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end

-- this only runs if the Blizzard_WorldMap wasn't loaded at PLAYER_LOGIN
function tamer:ADDON_LOADED(addon)
	if addon=="Blizzard_WorldMap" then
		self:UnregisterEvent("ADDON_LOADED")
		WorldMapFrame:AddDataProvider(tamer.dataProvider)
		tamer:SetupTrackingButton()
	end
end
