GottaGoFastHistory = LibStub("AceAddon-3.0"):NewAddon("GottaGoFastHistory", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceSerializer-3.0", "AceComm-3.0");
GottaGoFastHistory.AceGUI = LibStub("AceGUI-3.0", true);

local ggf = GottaGoFast;
local ggfh = GottaGoFastHistory;
local utility = GottaGoFast.Utility;

function GottaGoFastHistory:OnInitialize()
    -- Called when the addon is loaded
end

function GottaGoFastHistory:OnEnable()
    -- Called when the addon is enabled

    -- Register Events
    C_ChatInfo.RegisterAddonMessagePrefix("GGFHistory");
    self:RegisterChatCommand("ggfh", "ChatCommand");
    self:RegisterChatCommand("GottaGoFastHistory", "ChatCommand");
    self:RegisterComm("GGFHistory", "ChatComm");

    GottaGoFastHistory:InitOptions();
    GottaGoFastHistory:InitModels();
    GottaGoFastHistory:BugFixes();
    GottaGoFastHistory:SendCommMessage("GottaGoFast", "HistoryLoaded", "WHISPER", GetUnitName("player"), "ALERT");
end

function GottaGoFastHistory:OnDisable()
  -- Called when the addon is disabled
end

function GottaGoFastHistory:ChatCommand(input)
  -- Chat Commands Go Here
  ggfh:HistoryPanel();
end

function GottaGoFastHistory:ChatComm(prefix, input, distribution, sender)
  if (prefix == "GGFHistory" and sender == GetUnitName("player")) then
    utility.DebugPrint("History Message Received");
    local status, data = GottaGoFastHistory:Deserialize(input);
    if (status and data ~= nil and next(data) ~= nil and data["msg"] ~= nil) then
      if (data["msg"] == "CreateDungeon" and data["name"] ~= nil and data["zoneID"] ~= nil and data["objectives"] ~= nil and next(data["objectives"]) ~= nil) then
        utility.DebugPrint("Calling Create Dungeon");
        GottaGoFastHistory:InitDungeon(data["name"], data["zoneID"], data["objectives"]);
      elseif (data["msg"] == "CreateRun") then
        utility.DebugPrint("Calling Create Run");
        GottaGoFastHistory:StoreRun(data);
      elseif (data["msg"] == "InitHistory") then
        utility.DebugPrint("Calling Init History");
        GottaGoFastHistory:InitHistory(data);
      elseif (data["msg"] == "OpenHistory") then
        GottaGoFastHistory:HistoryPanel();
      elseif (data["msg"] == "AskForBestRun") then
        local run = GottaGoFastHistory:FindBestRun(data["zoneID"], data["level"], data["affixes"]);
        GottaGoFastHistory:SendBestRun(run);
      end
    end
  end
end
