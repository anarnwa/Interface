local config = CreateFrame("Frame");

ExplorerCoordsConfig = config;
function config:SetDefaultConfig()
	ExplorerCoords_Config = {};
	ExplorerCoords_Config.ShowWorldMap = true;
	ExplorerCoords_Config.ShowMiniMap = true;
	ExplorerCoords_Config.DoTracking = true;
	ExplorerCoords_Config.ShowMissingCoords=true;
	
	config.ShowOnMainMap:SetChecked(true);
	config.ShowOnMiniMap:SetChecked(true);
	config.ShowMissingCoords:SetChecked(true);
	config.DoTracking:SetChecked(true);
	
end

function config:SetCurrentConfig()
	
	config.ShowOnMainMap:SetChecked(ExplorerCoords_Config.ShowWorldMap);
	config.ShowOnMiniMap:SetChecked(ExplorerCoords_Config.ShowMiniMap);
	config.ShowMissingCoords:SetChecked(ExplorerCoords_Config.ShowMissingCoords);
	config.DoTracking:SetChecked(ExplorerCoords_Config.DoTracking);
	
end

function config:ChangeState()
	
	 ExplorerCoords_Config[self.id] = self:GetChecked() or false;
	if(self.id == "ShowWorldMap") then
		if(self:GetChecked() == true) then
			ExplorerCoordsFrame:RegisterEvent("QUEST_LOG_UPDATE");
		else
			ExplorerCoordsFrame:UnregisterEvent("QUEST_LOG_UPDATE");
			ExplorerCoords_ClearNotes("world");
		end
	elseif(self.id == "ShowMiniMap") then
		if(self:GetChecked() == true) then
			--ExplorerCoordsFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
			ExplorerCoords_UpdateMap("mini");
		else
			--ExplorerCoordsFrame:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
			ExplorerCoords_ClearNotes("mini");
		end
	end
end

function config:Init()

	config.name = "Explorer Coords";
	
 
 local ShowOnMainMap = CreateFrame( "CheckButton", "ShowOnMainMapCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
	config.ShowOnMainMap = ShowOnMainMap;
	ShowOnMainMap.id = "ShowWorldMap";
	ShowOnMainMap:SetPoint( "TOPLEFT", 16, -16 );
	ShowOnMainMap:SetScript("onClick",config.ChangeState);
	_G[ ShowOnMainMap:GetName().."Text" ]:SetText( EXPLORER_COORD_OPTION_WORLDMAP );
 
  local ShowOnMiniMap = CreateFrame( "CheckButton", "ShowOnMiniMapCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
    config.ShowOnMiniMap = ShowOnMiniMap;
	ShowOnMiniMap.id = "ShowMiniMap";
	ShowOnMiniMap:SetPoint( "TOPLEFT", ShowOnMainMap, "BOTTOMLEFT", 0, -16);
	ShowOnMiniMap:SetScript("onClick",config.ChangeState);
	_G[ ShowOnMiniMap:GetName().."Text" ]:SetText( EXPLORER_COORD_OPTION_MINIMAP );
	
	local ShowMissingCoords = CreateFrame( "CheckButton", "ShowMissingCoordsCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
    config.ShowMissingCoords = ShowMissingCoords;
	ShowMissingCoords.id = "ShowMissingCoords";
	ShowMissingCoords:SetPoint( "TOPLEFT", ShowOnMiniMap, "BOTTOMLEFT", 0, -16);
	ShowMissingCoords:SetScript("onClick",config.ChangeState);
	_G[ ShowMissingCoords:GetName().."Text" ]:SetText( EXPLORER_COORD_SHOW_MISSING );
	
	local DoTracking = CreateFrame( "CheckButton", "DoTrackingCheckBox", config, "InterfaceOptionsCheckButtonTemplate" );
    config.DoTracking = DoTracking;
	DoTracking.id = "DoTracking";
	DoTracking:SetPoint( "TOPLEFT", ShowMissingCoords, "BOTTOMLEFT", 0, -16);
	DoTracking:SetScript("onClick",config.ChangeState);
	_G[ DoTracking:GetName().."Text" ]:SetText( EXPLORER_COORD_DO_TRACKING );

	
 
 InterfaceOptions_AddCategory(config);
   
	 if not (ExplorerCoords_Config)  then
	   config:SetDefaultConfig();
	   ExplorerCoords_Config["confv"] = 1;
	 else
	   if not (ExplorerCoords_Config["confv"]) or (ExplorerCoords_Config["confv"] ~= 1)  then
			config:SetDefaultConfig();
			ExplorerCoords_Config["confv"] = 1;
		else
			config:SetCurrentConfig();
		end
	 end
	
 
 if (ExplorerCoords_Config.ShowMiniMap == true or ExplorerCoords_Config.DoTracking) then
	ExplorerCoordsFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	ExplorerCoords_UpdateMap("mini");
 end
 if (ExplorerCoords_Config.ShowWorldMap == true) then
	ExplorerCoordsFrame:RegisterEvent("QUEST_LOG_UPDATE");
 end
 

end
