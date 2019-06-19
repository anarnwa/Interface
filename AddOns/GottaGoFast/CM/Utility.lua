local ggf = GottaGoFast;
local utility = ggf.Utility;
local constants = ggf.Constants;
local colors = constants.Colors;
local wrap = WrapTextInColorCode;
-- Move Court Text In Bigger Update
local courtText = {
  ["There's a rumor that the spy always wears gloves."] = "Gloves",
  ["I heard the spy carefully hides their hands."] = "Gloves",
  ["I heard the spy always dons gloves."] = "Gloves",
  ["Someone said the spy wears gloves to cover obvious scars."] = "Gloves",
  ["There's a rumor that the spy never has gloves on."] = "No Gloves",
  ["You know... I found an extra pair of gloves in the back room. The spy is likely to be bare handed somewhere around here."] = "No Gloves",
  ["I heard the spy dislikes wearing gloves."] = "No Gloves",
  ["I heard the spy avoids having gloves on, in case some quick actions are needed"] = "No Gloves",
  ["Someone mentioned the spy came in earlier wearing a cape."] = "Cape",
  ["I heard the spy enjoys wearing capes."] = "Cape",
  ["I heard the spy dislikes capes and refuses to wear one."] = "No Cape",
  ["I heard that the spy left their cape in the palace before coming here."] = "No Cape",
  ["I heard the spy carries a magical pouch around at all times."] = "Pouch",
  ["A friend said the spy loves gold and a belt pouch filled with it."] = "Pouch",
  ["I heard the spy's belt pouch is filled with gold to show off extravagance."] = "Pouch",
  ["I heard the spy carries a magical pouch around at all times."] = "Pouch",
  ["I heard the spy's belt pouch is lined with fancy threading."] = "Pouch",
  ["A friend said the spy loves gold and a belt pouch filled with it."] = "Pouch",
  ["The spy definitely prefers the style of light colored vests."] = "Light Vest",
  ["I heard that the spy is wearing a lighter vest to tonight's party."] = "Light Vest",
  ["People are saying the spy is not wearing a darker vest tonight."] = "Light Vest",
  ["The spy definitely prefers darker clothing."] = "Dark Vest",
  ["I heard the spy's vest is a dark, rich shade this very night."] = "Dark Vest",
  ["The spy enjoys darker colored vests... like the night."] = "Dark Vest",
  ["Rumor has it the spy is avoiding light colored clothing to try and blend in more."] = "Dark Vest",
  ["They say that the spy is here and she's quite the sight to behold."] = "Female",
  ["I hear some woman has been constantly asking about the district..."] = "Female",
  ["Someone's been saying that our new guest isn't male."] = "Female",
  ["They say that the spy is here and she's quite the sight to behold."] = "Female",
  ["I heard somewhere that the spy isn't female."] = "Male",
  ["I heard the spy is here and he's very good looking."] = "Male",
  ["A guest said she saw him entering the manor alongside the Grand Magistrix."] = "Male",
  ["One of the musicians said he would not stop asking questions about the district."] = "Male",
  ["I heard the spy wears short sleeves to keep their arms unencumbered."] = "Short Sleeves",
  ["Someone told me the spy hates wearing long sleeves."] = "Short Sleeves",
  ["A friend of mine said she saw the outfit the spy was wearing. It did not have long sleeves."] = "Short Sleeves",
  ["I heard the spy enjoys the cool air and is not wearing long sleeves tonight."] = "Short Sleeves",
  ["I heard the spy's outfit has long sleeves tonight."] = "Long Sleeves",
  ["Someone said the spy is covering up their arms with long sleeves tonight."] = "Long Sleeves",
  ["I just barely caught a glimpse of the spy's long sleeves earlier in the evening."] = "Long Sleeves",
  ["A friend of mine mentioned the spy has long sleeves on."] = "Long Sleeves",
  ["I heard the spy brought along potions, I wonder why?"] = "Potions",
  ["I didn't tell you this... but the spy is masquerading as an alchemist and carrying potions at the belt."] = "Potions",
  ["I'm pretty sure the spy has potions at the belt."] = "Potions",
  ["I heared the spy is not carrying any potions around."] = "No Potions",
  ["A musician told me she saw the spy throw away their last potion and no longer has any left."] = "No Potions",
  ["I heard the spy always has a book of written secrets at the belt."] = "Book",
  ["Rumor has is the spy loves to read and always carries around at least one book."] = "Book"
}

local autoExceptionList = {
  [35642] = "Jeeves",
  [101462] = "Reaves"
};

function GottaGoFast.PlayerStr(name, class)
  class = string.upper(string.gsub(class, "%s+", ""));
  local color = select(4, GetClassColor(class));
  if (color == nil) then
    color = colors.White;
  end
  local text = string.format("%s", wrap(name, color));
  return text;
end

function GottaGoFast.PrintBestRun(run)
  if (GottaGoFast.GetBestReport(nil)) then
    local time = GottaGoFast.SecsToTimeMS(GottaGoFast.CalculateRunTime(run["startTime"], run["endTime"], run["deaths"], run["corrupt"]));
    local str = "Your Best Run At This Difficulty Is " .. wrap(time, colors.Gold) .. " (";
    for k, v in pairs(run["players"]) do
      str = str .. GottaGoFast.PlayerStr(v["name"], v["class"]) .. ", ";
    end
    str = utility.ShortenStr(str, 2) .. ")";
    ggf:Print(str);
  end
end

function GottaGoFast.PrintNewBest(cm)
  if (cm["BestRun"] ~= nil and next(cm["BestRun"]) ~= nil and GottaGoFast.GetBestReport(nil)) then
    local startTime = cm["StartTime"];
    local corrupt = false;
    if (startTime == nil and cm["Time"] ~= nil) then
      startTime = GottaGoFast.StringToTime(cm["Time"]);
      corrupt = true;
    end
    local currentRunTime = GottaGoFast.CalculateRunTime(startTime, GetTime(), cm["Deaths"], corrupt);
    local bestRunTime = GottaGoFast.CalculateRunTime(cm["BestRun"]["startTime"], cm["BestRun"]["endTime"], cm["BestRun"]["deaths"], cm["BestRun"]["corrupt"]);
    if (currentRunTime < bestRunTime) then
      local runTime = GottaGoFast.SecsToTimeMS(currentRunTime)
      ggf:Print("New Record! " .. wrap(runTime, colors.Gold));
    end
  end
end

function GottaGoFast.EmpoweredString()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    local empowered = GottaGoFast.CurrentCM["Empowered"];
    if (empowered) then
      return "Empowered";
    else
      return "Depleted";
    end
  end
  return "?";
end

function GottaGoFast.BuildCMTooltip()
  if (GottaGoFast.CurrentCM and next(GottaGoFast.CurrentCM)) then
    local newTooltip;
    local cmLevel = GottaGoFast.CurrentCM["Level"];
    local empowered = GottaGoFast.EmpoweredString();
    local bonus = GottaGoFast.CurrentCM["Bonus"];
    if (cmLevel) then
      newTooltip = empowered .. ": Level " .. cmLevel .. " - " .. tostring(bonus) .. "%\n\n";
      if (next(GottaGoFast.CurrentCM["Affixes"])) then
        for i, affixID in pairs(GottaGoFast.CurrentCM["Affixes"]) do
          local affixName = affixID["name"];
          local affixDesc = affixID["desc"];
          newTooltip = newTooltip .. affixName .. "\n" .. affixDesc .. "\n\n";
        end
      end
      newTooltip = GottaGoFast.Utility.ShortenStr(newTooltip, 2);
      GottaGoFast.tooltip = newTooltip;
    else
      GottaGoFast.tooltip = GottaGoFast.defaultTooltip;
    end
  end
end

function GottaGoFast.InitCM(currentZoneID)
  GottaGoFast.Utility.DebugPrint("Player Entered Challenge Mode");
  GottaGoFast.WipeCM();
  GottaGoFast.Utility.DebugPrint("Wiping CM");
  GottaGoFast.SetupCM(currentZoneID);
  GottaGoFast.Utility.DebugPrint("Setting Up CM");
  GottaGoFast.UpdateCMTimer();
  GottaGoFast.Utility.DebugPrint("Setting Up Timer");
  GottaGoFast.UpdateCMObjectives();
  GottaGoFast.Utility.DebugPrint("Setting Up Objectives");
  GottaGoFast.inCM = true;
  GottaGoFast.inTW = false;
  GottaGoFastFrame:SetScript("OnUpdate", GottaGoFast.UpdateCM);
  GottaGoFast.Utility.DebugPrint("Setting Up Update Script");
  GottaGoFast.ShowFrames();
  GottaGoFast.Utility.DebugPrint("Showing Frames");
end

function GottaGoFast.HandleSpy(mobID)
  if (GottaGoFast.GetSpyHelper(nil)) then
    if (GossipTitleButton1:IsVisible()) then
      GossipTitleButton1:Click();
    elseif (GossipGreetingText ~= nil) then
      local text = GossipGreetingText:GetText();
      local short = "";
      if (courtText[text] ~= nil) then
        short = " [" .. courtText[text] .. "]";
      end
      SendChatMessage("GGF" .. short .. ": " .. text, "PARTY");
    end
  end
end

function GottaGoFast.HandleGossip()
  local mobID = GottaGoFast.UnitID(UnitGUID("target"));
  if (GottaGoFast.GetAutoDialog(nil) and GossipTitleButton1:IsVisible() and autoExceptionList[mobID] == nil) then
    GossipTitleButton1:Click();
  end
  if (GottaGoFast.CurrentCM["ZoneID"] == 1571 and mobID == 107486) then
    GottaGoFast.HandleSpy(mobID);
  end
end

-- Mob Point Utilities

function GottaGoFast.MobPointsToInteger(mobPoints)
  return tonumber(utility.ShortenStr(mobPoints, 1));
end

function GottaGoFast.IsAlternate(cmID, mapID)
  -- isAlternate is for upper kara, or the horde version of siege of boralus
  local isAlternate = cmID == 234;
  if (not isAlternate and mapID == 1822) then
    isAlternate = ggf.PlayerIsHorde();
  end

  return isAlternate;
end

function GottaGoFast.PlayerIsHorde()
  return UnitFactionGroup("player") == "Horde"
end

function GottaGoFast.HasTeeming(affixes)
  if (next(affixes) ~= nil) then
    for k, v in pairs(affixes) do
      if k == 5 or v.name == "Teeming" then
        return true;
      end
    end
  end
  return false;
end

function GottaGoFast.MouseoverUnitID()
  local guid = UnitGUID("mouseover");
  if (guid ~= nil) then
    local guidSplit = utility.ExplodeStr("-", guid);
    return tonumber(guidSplit[6]);
  end
  return nil;
end

function GottaGoFast.UnitID(guid)
  if (guid ~= nil) then
    local guidSplit = utility.ExplodeStr("-", guid);
    return tonumber(guidSplit[6]);
  end
  return nil;
end

-- Checks Nil And Gathers Data
-- Mob Percentage Is Expected 10x Too High
-- I.E 7% = 7 instead of .7
function GottaGoFast.CalculateIndividualMobPointsWrapper(mobPercentage)
  if (ggf.inCM == true and ggf.CurrentCM ~= nil 
      and next(ggf.CurrentCM) ~= nil and ggf.CurrentCM["Steps"] ~= nil
      and ggf.CurrentCM["FinalValues"] ~= nil and ggf.CurrentCM["FinalValues"][ggf.CurrentCM["Steps"]] ~= nil) then
        mobPercentage = mobPercentage * .1
        local totalMobPoints = ggf.MobPointsToInteger(ggf.CurrentCM["FinalValues"][ggf.CurrentCM["Steps"]]);
        return ggf.CalculateIndividualMobPoints(mobPercentage, totalMobPoints);
  else 
    ggf.Utility.DebugPrint("Trying to calculate individual mob points, but a value is nil!");
    return nil;
  end
end

-- Expecting 2 Numbers, Non Nil
function GottaGoFast.CalculateIndividualMobPoints(mobPercentage, totalMobPoints)
  return mobPercentage * totalMobPoints;
end

function GottaGoFast.AddMobPointsToTooltip()
  local npcID = GottaGoFast.MouseoverUnitID();
  local mapID = ggf.CurrentCM["ZoneID"];
  local cmID = ggf.CurrentCM["CmID"]
  local isTeeming = ggf.HasTeeming(ggf.CurrentCM["Affixes"]);
  if (npcID ~= nil and mapID ~= nil and isTeeming ~= nil) then
    local weight = nil;

    if (ggf.GetUseMdt() and MethodDungeonTools ~= nil and MethodDungeonTools.GetEnemyForces ~= nil) then
      local count, max, maxTeeming = MethodDungeonTools:GetEnemyForces(npcID);

      if (count ~= nil and max ~= nil and maxTeeming ~= nil) then
        if (isTeeming) then
          weight = count / maxTeeming;
        else
          weight = count / max;
        end
        weight = weight * 100;
      end
    else
      local isAlternate = GottaGoFast.IsAlternate(cmID, mapID);
      weight = ggf.LOP:GetNPCWeightByMap(mapID, npcID, isTeeming, isAlternate);
    end

    if (weight ~= nil) then
      local appendString = string.format(" (%.2f%%)", weight);

      -- Give Point Estimate
      if (GottaGoFast.GetMobPoints(nil)) then
        local mobPoints = ggf.CalculateIndividualMobPointsWrapper(weight)
        if (mobPoints ~= nil) then
          appendString = appendString .. string.format(" [%.2f]", mobPoints)
        end
      end
      GameTooltip:AppendText(appendString);
    end
  end
end