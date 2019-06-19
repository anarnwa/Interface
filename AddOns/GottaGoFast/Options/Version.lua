local ggf = GottaGoFast;
local constants = ggf.Constants;
local utility = ggf.Utility;
local version = constants.Version;

function GottaGoFast.VersionCheck()
  local lastVersion = ggf.GetVersion(nil);
  utility.DebugPrint("Last Version: " .. lastVersion);
  utility.DebugPrint("Current Version: " .. version);
  if (lastVersion == nil or lastVersion == 0) then
    -- First Time Run
    ggf.VersionFirstRun();
  elseif (lastVersion < version) then
    ggf:Print("Welcome To v" .. constants.VersionName);
    ggf:Print("Check The Changelog For Information About The Update!");
  end
  ggf.SetVersion(nil, version);
end

function GottaGoFast.VersionFirstRun()
  utility.DebugPrint("First Run");
  GottaGoFast.SendHistoryFlag = true;
end
