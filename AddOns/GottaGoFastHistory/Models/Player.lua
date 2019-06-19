-- Define Objects
-- Player
local Player = {}

local Icons = {
	TANK = "Interface\\AddOns\\GottaGoFastHistory\\Media\\tank",
	HEALER = "Interface\\AddOns\\GottaGoFastHistory\\Media\\healer",
	DAMAGER = "Interface\\AddOns\\GottaGoFastHistory\\Media\\dps"
}

local Ranks = {
  TANK = 1,
  HEALER = 2,
  DAMAGER = 3
}

function Player.New(name, class, role)
  local self = {}
  self.name = name;
  self.class = class;
  self.role = role;
  return self
end

function Player.GetName(self)
  return self.name
end

function Player.SetName(self, name)
  self.name = name
end

function Player.GetClass(self)
  return self.class
end

function Player.SetClass(self, class)
  self.class = class
end

function Player.GetRole(self)
  return self.role
end

function Player.SetRole(self, role)
  self.role = role
end

function GottaGoFastHistory:InitModelPlayer()
  GottaGoFastHistory.Models.Player = Player;
end

function GottaGoFastHistory:GetGroupPrefix()
  if IsInRaid() then
    return "raid";
  else
    return "party";
  end
end

function GottaGoFastHistory:GetPlayer(unit)
  local name = GetUnitName(unit, false);
  local class = UnitClass(unit);
  local role = UnitGroupRolesAssigned(unit);
  return GottaGoFastHistory.Models.Player.New(name, class, role);
end

function GottaGoFastHistory:GetPlayersFromGroup()
  local players = {};
  local members = GetNumGroupMembers();
  local prefix = GottaGoFastHistory:GetGroupPrefix();
  for i = 1, members - 1 do
    table.insert(players, GottaGoFastHistory:GetPlayer(prefix .. i));
  end
  table.insert(players, GottaGoFastHistory:GetPlayer("player"));
  return players;
end

function GottaGoFastHistory:GetRoleIcon(player)
  return Icons[player["role"]];
end

function GottaGoFastHistory:GetRoleRank(player)
  return Ranks[player["role"]];
end
