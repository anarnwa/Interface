function GottaGoFast.CheckPositions(currentZoneID)
  local isAnyoneOutside = false;
  isAnyoneOutside = isAnyoneOutside or GottaGoFast.CheckUnitPosition(currentZoneID, "player");
  if (GetNumGroupMembers() ~= 0) then
  	for i = 1, GetNumGroupMembers() - 1
  	do
      isAnyoneOutside = isAnyoneOutside or GottaGoFast.CheckUnitPosition(currentZoneID, "party" .. i);
    end
  end
  if isAnyoneOutside then
    --time to start timer
    GottaGoFast.StartTW();
    return true;
  end
  return false;
end

function GottaGoFast.CheckUnitPosition(currentZoneID, unitName)
  if currentZoneID and unitName then
    local dx, dy, distance;
    local posX, posY, posZ, terrainMapID = UnitPosition(unitName);
    local startX = GottaGoFastInstanceInfo[currentZoneID]["startingArea"]["x"];
    local startY = GottaGoFastInstanceInfo[currentZoneID]["startingArea"]["y"];
    local safeZone = GottaGoFastInstanceInfo[currentZoneID]["startingArea"]["safeZone"];
    if (currentZoneID == terrainMapID) then
      dx = startX - posX;
      dy = startY - posY;
      distance = math.sqrt((dx * dx) + (dy * dy));
      return distance > safeZone;
    end
  end
  return false;
end
