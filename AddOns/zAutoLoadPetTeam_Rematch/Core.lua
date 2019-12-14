local AutoTeam = ALPTRematch
local rematch = Rematch
local saved, settings
local CFG = ALPTRematch.alptconfig
local AutoTeamData = {}

local enableTeamLoad = true
local g = {
  npcName = "",
  npcId = 0,
  npcWithTeam = "",
  npcIdWithTeam = 0,
  loadTimes = 0,
  isSkip = false,
  isAuto = false,
  delayCount = 0,
  isLoading = false,
  isDefault = false,
  isCaching = false,
  isPetsReplaced = {false, false, false}
}

local printer = {
  isPrinted = true,
  isDelay = false,
  isIgnored = false,
  count = 0,
  countall = 0,
  countTeam = {}
}

local current = {
  key = "",
  name = "",
  data = nil,
  pets = {{}, {}, {}},
  health = {0, 0, 0},
  healthCheck = nil
}

local PetListCache = {}
local PetGroup = {}
local Alternates = nil --无升级宠物时，升级位的替补
local isInited = false
local hasValidTeam = false
local resurPrinted = false
local isResurable = false
function AutoTeam:DebugFunc()
end

rematch:InitModule(
  function()
    saved = RematchSaved
    settings = RematchSettings
  end
)
local function PrintMessage(msg)
  if CFG.debug or CFG.showTeamMessage then
    print(msg)
  end
end

local function WriteLogToFile(logText)
  if CFG.logToFile and BattleLog then
    tinsert(BattleLog.logs, date("[%H:%M:%S]") .. logText)
    BattleLog.endtime = date("%Y-%m-%d %H:%M:%S")
  end
end
local function _clInfo(msg)
  return BATTLENET_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clError(msg)
  return RED_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clWarn(msg)
  return ORANGE_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clSign(msg)
  return GREEN_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end
local function _clLight(msg)
  return NORMAL_FONT_COLOR_CODE .. msg .. FONT_COLOR_CODE_CLOSE
end

local function isALPTEnable()
  return CFG.enable and enableTeamLoad
end


local function isResurCooldown()
  local start, duration, enabled = GetSpellCooldown(125439)
  return duration == 0
end

local defaultHealthCheck = {100, 100, 100}

local function tcopy(to, from)
  for k, v in pairs(from) do
    if type(v) == "table" then
      if to[k] and type(to[k]) == "table" then
      else
        to[k] = {}
      end
      tcopy(to[k], v)
    else
      to[k] = v
    end
  end
end

local function getTeamConfig(teamKey)

  return ALPTRematch:FixTeamConfig(teamKey)
  
end

local function isTeamDisabled(teamKey)
  if settings.alpt and settings.alpt[teamKey] then
    return settings.alpt[teamKey].disabled
  end
  return false
end

function AutoTeam:findTeamsFromRematch(npcId, npcName)
  local teamName
  local teams = {}
  local index = 1

  if saved[npcId] then
    teamName = saved[npcId].teamName or npcId .. ""
  else
    teamName = npcName
  end

  local matchName = teamName:match("([^%d%p%c]+)")
  if CFG.debug then
    print("解析到队伍名称：" .. (matchName or "无"))
  end
  if matchName and matchName ~= "" then
    teamName = matchName
  end

  local isfind = false
  local teamList = {}
  local name
  for k, v in pairs(saved) do
    local isMatch = false
    if type(k) == "number" and k == npcId then
      isfind = true
      isMatch = true
      name = v.teamName or (k .. "")
    elseif type(k) ~= "number" and k:match(teamName) then
      isfind = true
      isMatch = true
      name = k
    end
    if isMatch then
      local hasUpSlot = false
      for i = 1, 3 do
        local petID = v[i][1]
        if petID == 0 then
          hasUpSlot = true
          break
        end
      end
      if CFG.mode == 2 and hasUpSlot == false then
        isMatch = false
      elseif CFG.mode == 3 and hasUpSlot == true then
        isMatch = false
      end
    end
    if isMatch then
      teamList[index] = {["key"] = k, ["name"] = name}
      index = index + 1
    end
  end

  if not isfind then
    return nil
  end
  table.sort(
    teamList,
    function(a, b)
      return (a.name < b.name)
    end
  )
  for i = 1, #teamList do
    teams[i] = teamList[i].key
  end
  return teams
end

function AutoTeam:getTeamFromRematch(teamName)
  for k, v in pairs(saved) do
    if type(k) == "number" and v.teamName == teamName then
      return v
    elseif k == teamName then
      return v
    end
  end
  return nil
end

--是否预设的npc
function AutoTeam:GetNpcData()
  local npcData = AutoTeamData[g.npcId]
  if npcData == nil then
    if saved[g.npcId] then
      npcData = {}
    end
  end
  current.data = npcData
  return npcData ~= nil
end

function AutoTeam:PrintTeams(teamArray)
  PrintMessage("可用队伍")
  for i = 1, #teamArray do
    if type(teamArray[i]) == "number" then
      local tm = saved[teamArray[i]]
      if tm and tm.teamName then
        PrintMessage("队伍" .. i .. ":" .. tm.teamName)
      end
    else
      PrintMessage("队伍" .. i .. ":" .. teamArray[i])
    end
  end
end

function AutoTeam:getPetStatus(pt)
  local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(pt.petID)
  pt.health = health
  pt.attack = attack
  pt.speed = speed
  pt.percent = math.floor((health * 100) / maxHealth)
end

local speciesIDCur, customNameCur, levelCur, healthCur, maxHealthCur, attackCur, speedCur
local percentCur, percentMinCur
local loadin, pickIndex, petInTeam

function AutoTeam:FillTeamData(team)
  loadin = {{}, {}, {}}
  pickIndex = 1
  petInTeam = {}
  for i = 1, 3 do
    local petID = team[i][1]

    if petID and petID ~= 0 then
      loadin[i][0] = false
      loadin[i][1] = petID
      petInTeam[petID] = true
      local speciesAbilities = rematch:GetAbilities(team[i][5])
      for j = 1, 3 do
        local abilityID = team[i][j + 1]
        if abilityID and abilityID ~= 0 then
          if not speciesAbilities[j] or speciesAbilities[j] == abilityID or speciesAbilities[j + 3] == abilityID then
            loadin[i][j + 1] = abilityID
          end
        end
      end
    elseif petID == 0 then
      loadin[i][0] = true

      local levelUpPet = rematch.topPicks[pickIndex]
      pickIndex = pickIndex + 1
      if not levelUpPet or not C_PetJournal.PetIsSummonable(levelUpPet) then
        loadin[i][1] = Alternates or 0
        if loadin[i][1] ~= 0 then
          petInTeam[loadin[i][1]] = true
        end
      else
        loadin[i][1] = levelUpPet
        petInTeam[levelUpPet] = true
      end
    end
  end
end

function AutoTeam:LoadFromGroup(tcfg, m)
  local success = false
  local replaced = false
  local groupName = tcfg.groups[m]

  local hpcheck = tcfg.hp[m] or {0, 9999}
  local attackcheck = tcfg.attack[m] or {0, 999}
  local speedcheck = tcfg.speed[m] or {0, 999}

  if groupName and PetGroup[groupName] then
    if CFG.debug then
      print(m .. "号宠尝试同组替补")
    end
    --从自定义组取同类型
    local samepets = PetGroup[groupName]

    for n = 1, #samepets do
      local pt = samepets[n]
      self:getPetStatus(pt)
      if
        pt.percent >= percentMinCur and not petInTeam[pt.petID] and pt.health >= (hpcheck[1] or 0) and
          pt.health <= (hpcheck[2] or 99999) and
          pt.attack >= (attackcheck[1] or 0) and
          pt.attack <= (attackcheck[2] or 9999) and
          pt.speed >= (speedcheck[1] or 0) and
          pt.speed <= (speedcheck[2] or 9999)
       then
        loadin[m][1] = pt.petID
        petInTeam[pt.petID] = true
        success = true
        replaced = true
        for tt = 1, 3 do
          loadin[m][tt + 1] = pt.abilityID[tt]
        end
        break
      end
    end
  end

  return success, replaced
end

function AutoTeam:LoadHighest(tcfg, petId, m)
  if CFG.debug then
    print(m .. "号宠尝试加载最高血量>" .. healthCur)
  end
  local samepets = PetListCache[speciesIDCur]
  if samepets == nil or #samepets <= 1 then
    if CFG.debug then
      print(m .. "号宠无可替补宠")
    end
    return false
  end

  local minHealth = healthCur
  local lastPetId = petId
  for n = 1, #samepets do
    repeat
      local pt = samepets[n]
      if petInTeam[pt.petID] then
        break
      end
      self:getPetStatus(pt)
      if pt.health <= minHealth then
        break
      end

      if not (pt.attack == attackCur and pt.speed == speedCur) then
        break
      end

      minHealth = pt.health
      lastPetId = pt.petID
    until true
  end

  if minHealth > healthCur then
    loadin[m][1] = lastPetId
    petInTeam[petId] = false
    petInTeam[lastPetId] = true
    if CFG.debug then
      print(m .. "号宠找到更高血量" .. minHealth)
    end
    return true
  end
  return false
end

function AutoTeam:LoadSame(tcfg, m)
  if CFG.debug then
    print(m .. "号宠尝试同类型替补")
  end
  local success = false
  local replaced = false
  local samepets = PetListCache[speciesIDCur]
  if samepets == nil or #samepets <= 1 then
    return success, replaced
  end
  for n = 1, #samepets do
    repeat
      local pt = samepets[n]
      if petInTeam[pt.petID] then
        break
      end

      self:getPetStatus(pt)

      if CFG.debug then
        print(pt.speciesName .. pt.percent .. "%")
      end

      if tcfg.ignoreBreed[m] or levelCur == 0 then
        if pt.level >= tcfg.minLvl[m] then
          local hpcheck = tcfg.hp[m] or {0, 9999}
          local attackcheck = tcfg.attack[m] or {0, 999}
          local speedcheck = tcfg.speed[m] or {0, 999}
          if
            pt.health >= (hpcheck[1] or 0) and pt.health <= (hpcheck[2] or 99999) and pt.attack >= (attackcheck[1] or 0) and
              pt.attack <= (attackcheck[2] or 9999) and
              pt.speed >= (speedcheck[1] or 0) and
              pt.speed <= (speedcheck[2] or 9999)
           then
            success = true
          end
        end
      else
        if pt.level == levelCur and pt.attack == attackCur and pt.speed == speedCur then
          success = true
        end
      end
      if not success then
        break
      end

      if pt.percent >= percentMinCur then
        loadin[m][1] = pt.petID
        petInTeam[pt.petID] = true
        success = true
        replaced = true
        return success, replaced
      end

      success = false
    until true
  end
  return success, replaced
end

function AutoTeam:CountAndPrint()
  if not printer.isIgnored then
    printer.count = printer.count + 1
    printer.countall = printer.countall + 1
    if not printer.countTeam[current.key] then
      printer.countTeam[current.key] = 0
    end
    printer.countTeam[current.key] = printer.countTeam[current.key] + 1
  end
  if not printer.isPrinted and CFG.enableBattleTimer then
    printer.isDelay = true --推迟到计时消息后输出
  else
    self:PrintCurrentTeam()
  end
end

function AutoTeam:LoadTeam()
  if self:ActiveTeam() then --if1
    g.isSkip = true
    g.isLoading = false

    if CFG.useRematchLoadingDone then
      settings.AutoLoad = true
      rematch:LoadingDone(true)
      settings.AutoLoad = false
      if settings.AutoLoadShow and (not rematch.LoadoutPanel:IsVisible() and not rematch.MiniPanel:IsVisible()) then
        rematch:AutoShow()
      end
    else
      rematch:AssignSpecialSlots()
      rematch:UpdateQueue()
    end

    g.loadTimes = 0

    self:CountAndPrint()
  elseif g.loadTimes < CFG.loadRetries then -- if 2
    g.loadTimes = g.loadTimes + 1
    C_Timer.After(
      CFG.loadRetryInteval,
      function()
        AutoTeam:LoadTeam()
      end
    )
  else
    g.isLoading = false
    g.isSkip = true
    if not g.isAuto then
      local msg = "加载队伍[ " .. current.name .. " ]失败"
      PrintMessage(_clError(msg))
      WriteLogToFile(msg)
    end
  end
end

function AutoTeam:PreLoadTeam(teamKey, isForce)
  local team = saved[teamKey]
  if not team then
    if not g.useDefault then
      local msg = "队伍[" .. teamKey .. "]缺失"
      PrintMessage(_clError(msg))
      WriteLogToFile(msg)
    end
    return false
  end

  if settings.loadedTeam == teamKey and isForce then
    return true
  end

  self:FillTeamData(team)

  local tcfg = getTeamConfig(teamKey)

  g.isPetsReplaced = {false, false, false}
  current.healthCheck = tcfg.healthCheck

  for m = 1, 3 do
    repeat
      if not loadin[m][0] then
        --检查血量
        local pid = loadin[m][1]
        if not pid then
          return false
        end
        speciesIDCur, customNameCur, levelCur = C_PetJournal.GetPetInfoByPetID(pid)
        healthCur, maxHealthCur, attackCur, speedCur = C_PetJournal.GetPetStats(pid)
        if not speciesIDCur then --宠物丢失的情况
          speciesIDCur = team[m][5]
          levelCur = 0
          customNameCur = ""
          healthCur = 0
          maxHealthCur = 1
          attackCur = 0
          speedCur = 0
        end
        if not speciesIDCur then
          return false
        end
        percentCur = math.floor((healthCur * 100) / maxHealthCur)
        percentMinCur = (tcfg.healthCheck[m] or 100)

        if CFG.debug then
          print(m .. "号宠血量:" .. percentCur .. "%,检测血线:" .. percentMinCur .. "%")
        end
        if percentCur > 99 then
          break
        end

        local success = false
        if percentCur >= percentMinCur then
          --血量符合要求，看看是否加载最高血量
          if tcfg.highest[m] then
            g.isPetsReplaced[m] = self:LoadHighest(tcfg, pid, m)
          end
          success = true
          break --总是认为成功的
        end
        --不满血，先尝试同组替补
        if not tcfg.noAlt[m] and tcfg.useGroup[m] then
          success, g.isPetsReplaced[m] = self:LoadFromGroup(tcfg, m)
        end
        if success then
          --同组替补成功
          break
        end
        if not tcfg.noAlt[m] then
          --尝试加载替补
          success, g.isPetsReplaced[m] = self:LoadSame(tcfg, m)
        end

        if not success then
          if (isResurable and CFG.forceLoadWhenHealOk) or isForce then
            --如果复活可用或强制加载，只要等级有效就认为可用
            if levelCur > 0 then
              printer.count = 0
              break
            end
          end
          --都失败了，退出
          return false
        end
      end
    until true
  end

  current.key = teamKey
  current.name = team.teamName or teamKey
  current.pets = loadin
  current.tcfg = tcfg
  self:LoadTeam()

  return true
end

function AutoTeam:ActiveTeam()
  local loadin = current.pets
  local loadout = rematch.info
  wipe(loadout)
  local done = {{}, {}, {}}

  for slot = 1, 3 do
    if loadin[slot][1] and loadin[slot][1] ~= 0 then
      loadout[1], loadout[2], loadout[3], loadout[4] = C_PetJournal.GetPetLoadOutInfo(slot)
      if loadin[slot][1] ~= loadout[1] then
        rematch:SlotPet(slot, loadin[slot][1])
      end
      for i = 1, 3 do
        local abilityID = loadin[slot][i + 1]
        if abilityID and loadout[i + 1] ~= abilityID then
          C_PetJournal.SetAbility(slot, i, abilityID)
        end
      end
    end
  end
  for slot = 1, 3 do
    if loadin[slot][1] and loadin[slot][1] ~= 0 then
      loadout[1], loadout[2], loadout[3], loadout[4] = C_PetJournal.GetPetLoadOutInfo(slot)
      for i = 1, 4 do
        if loadin[slot][i] == loadout[i] or not loadin[slot][i] then
          --loadin[slot][i] = nil
          done[slot][i] = true
        end
      end
    else
      for i = 1, 4 do
        --loadin[slot][i] = nil
        done[slot][i] = true
      end
    end
  end
  for i = 1, 3 do
    for j = 1, 4 do
      if not done[i][j] then
        return false
      end
    end
  end
  settings.loadedTeam = current.key
  return true
end

function AutoTeam:SelectTeam()
  hasValidTeam = true
  if not self:GetNpcData() then
    return
  end
  g.npcWithTeam = g.npcName
  g.npcIdWithTeam = g.npcId 
  g.isLoading = true

  g.isDefault = false
  local teamArray = self:findTeamsFromRematch(g.npcId, g.npcName)
  if not teamArray then
    if CFG.debug then
      print("未找预设队伍，使用默认队伍")
    end
    teamArray = CFG.defaultTeam
    g.isDefault = true
  end

  local teamCount = 0
  for i = 1, #teamArray do
    if not isTeamDisabled(teamArray[i]) then
      teamCount = teamCount + 1
    end
  end

  if teamCount == 0 then
    if not g.isDefault then
      PrintMessage(_clError("未找到队伍"))
      WriteLogToFile("未找到队伍")
    end
    g.isDefault = false
    g.isLoading = false
    return
  end

  if CFG.debug then
    self:PrintTeams(teamArray)
  end

  for i = 1, #teamArray do
    if not isTeamDisabled(teamArray[i]) then
      if self:PreLoadTeam(teamArray[i], false) then
        return
      end
    end
  end

  if not C_Scenario.IsInScenario() then
    --强制加载第一队
    for i = 1, #teamArray do
      if not isTeamDisabled(teamArray[i]) then
        if self:PreLoadTeam(teamArray[i], true) then
          break
        end
      end
    end
    hasValidTeam = false
    local msg = "所有队伍已失效"
    PrintMessage(_clError(msg))
    WriteLogToFile(msg)
  end

  g.isLoading = false
end

function AutoTeam:SelectTeamWhenTarget()
  isResurable = isResurCooldown()
  local hasData = self:GetNpcData()
  if not resurPrinted and hasData and isResurable then
    PrintMessage(_clSign("复活可用"))
    WriteLogToFile("复活可用")
    resurPrinted = true
  end
  if not isALPTEnable() then
    if not hasData then
      return
    end
    current.key = settings.loadedTeam
    current.name = rematch:GetTeamTitle(RematchSettings.loadedTeam)
    current.tcfg = nil
    current.pets = nil
    self:PrintCurrentTeam()
    return
  end
  g.isAuto = false
  if settings.loadedTeam == current.key and (g.isSkip or g.isLoading) then
    if not g.isLoading and current.pets[1][1] then
      if CFG.debug then
        print("尝试激活队伍")
      end
      AutoTeam:ActiveTeam() --再设置次保证成功
    end
    return
  end

  if C_PetJournal.IsJournalUnlocked() and CFG.selectWhenTarget then
    AutoTeam:SelectTeam()
  end
end

function AutoTeam:SelectTeamAfterBattle()
  isResurable = isResurCooldown()
  if not resurPrinted and isResurable then
    PrintMessage(_clSign("复活可用"))
    WriteLogToFile("复活可用")
    resurPrinted = true
  end
  if not isALPTEnable() then
    return
  end
  g.isAuto = true

  if g.isSkip or g.isLoading then
    return
  end

  if C_Scenario.IsInScenario() then
    return
  end

  if not CFG.selectAfterBattle then
    return
  end

  local changed = (settings.loadedTeam ~= current.key)
  if not changed then
    local health = AutoTeam:getTeamHealth()
    for slot = 1, 3 do
      if health[slot] ~= current.health[slot] then
        changed = true
        break
      end
    end
  end

  if changed then
    AutoTeam:SelectTeam()
  else
    g.delayCount = g.delayCount + 1
    if g.delayCount > 50 then
      g.delayCount = 0
    else
      C_Timer.After(
        0.01,
        function()
          AutoTeam:SelectTeamAfterBattle()
        end
      )
    end
  end
end
function AutoTeam:LogTeamTime(avg1, avg2)
  if current.tcfg then
    current.tcfg.avg1 = avg1
    current.tcfg.avg2 = avg2
  end
end
function ALPTRematch:GetCurrentTeamAvg()
  if current.tcfg then
    return current.tcfg.avg1
  end
  return nil
end

function AutoTeam:GetTargetNPC()
  local GUID = UnitGUID("target")
  if not GUID then
    return nil, nil
  end
  local unit_type, npcid = GUID:match("(%a+)-%d+-%d+-%d+-%d+-(%d+)-.+")
  return unit_type, tonumber(npcid)
end
function AutoTeam:PLAYER_TARGET_CHANGED()
  if CFG.debug then
    AutoTeam:DebugFunc()
  end
  if UnitExists("target") then
    local name = UnitName("target")
    if g.npcName ~= name then
      --只有目标变化时才触发加载
      g.isSkip = false
    end
    if
      not UnitIsPlayer("target") and not UnitIsEnemy("player", "target") and
        not (InCombatLockdown() or C_PetBattles.IsInBattle() or C_PetBattles.GetPVPMatchmakingInfo())
     then
      local unit_type, npcid = AutoTeam:GetTargetNPC()
      if unit_type == "Creature" or unit_type == "BattlePet" then
        g.npcName = name
        g.npcId = tonumber(npcid)
        local npcStr = g.npcId .. ""
        if rematch.notableRedirects[g.npcId] then
          g.npcId = rematch.notableRedirects[g.npcId]
          npcStr = npcStr .. "=>" .. g.npcId
        end
        if CFG.debug then
          print("目标[ " .. npcStr .. " ][ " .. g.npcName .. " ]")
        end
        AutoTeam:SelectTeamWhenTarget()
      end
    end
  end
end

function AutoTeam:getTeamHealth()
  local health = {0, 0, 0}
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      health[slot] = C_PetJournal.GetPetStats(petId)
    else
      health[slot] = 0
    end
  end
  return health
end

function AutoTeam:PrintCurrentTeam()
  if not CFG.showTeamMessage then
    return
  end

  local msg = ""
  local logtext = ""
  if CFG.showTeamCount[1] and isALPTEnable() then
    if printer.count == 0 then
      printer.count = 1
    end
    msg = msg .. "[" .. printer.count .. "]"
  end
  if CFG.showTeamCount[2] and isALPTEnable() then
    msg = msg .. "[" .. printer.countall .. "]"
  end
  if CFG.showTeamCount[3] and isALPTEnable() then
    msg = msg .. "[" .. (printer.countTeam[current.key] or 0) .. "]"
  end
  logtext = msg
  msg = msg .. "已加载" .. ACHIEVEMENT_COLOR_CODE .. "[ " .. current.name .. " ]:" .. FONT_COLOR_CODE_CLOSE
  logtext = logtext .. "已加载" .. "[ " .. current.name .. " ]:"
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      local speciesID, customName, level, _, _, _, _, petName = C_PetJournal.GetPetInfoByPetID(petId)
      local health, maxHealth, attack, speed, rarity = C_PetJournal.GetPetStats(petId)
      local percent = math.floor((health * 100) / maxHealth)

      local breadStr = ""
      if BPBID_Internal then
        local breedNum =
          BPBID_Internal.CalculateBreedID(
          tonumber(speciesID),
          tonumber(rarity),
          tonumber(level),
          tonumber(maxHealth),
          tonumber(attack),
          tonumber(speed),
          false,
          false
        )
        local breed = BPBID_Internal.RetrieveBreedName(breedNum)
        if breed and breed ~= "NEW" then
          breadStr = breed
        end
      end

      if level < 25 then
        msg =
          msg ..
          C_PetJournal.GetBattlePetLink(petId) ..
            BATTLENET_FONT_COLOR_CODE .. "[" .. breadStr .. "]" .. FONT_COLOR_CODE_CLOSE .. _clSign(level)
        logtext = logtext .. "[" .. petName .. "]" .. breadStr .. level
      else
        msg = msg .. C_PetJournal.GetBattlePetLink(petId) .. breadStr
        logtext = logtext .. "[" .. petName .. "]" .. breadStr
        if g.isPetsReplaced[slot] then
          msg = msg .. _clSign("↑")
          logtext = logtext .. "↑"
        end
        if percent < 100 then
          msg = msg .. RED_FONT_COLOR_CODE .. percent .. "%" .. FONT_COLOR_CODE_CLOSE
          logtext = logtext .. percent .. "%"
        end
      end
    end
  end
  PrintMessage(msg)
  WriteLogToFile(logtext)
  printer.isDelay = false
end

function AutoTeam:PrintTimer(msg)
  PrintMessage(_clLight(msg))
  WriteLogToFile(msg)
  printer.isPrinted = true
  if printer.isDelay then
    self:PrintCurrentTeam()
  end
end

local timeStart
function AutoTeam:PET_BATTLE_OPENING_START()
  g.isSkip = false
  current.health = AutoTeam:getTeamHealth()
  timeStart = time()
  printer.isPrinted = false
  printer.isDelay = false
  resurPrinted = false
  isResurable = false
  if BattleLog and not BattleLog.starttime then
    BattleLog.starttime = date("%Y-%m-%d %H:%M:%S")
  end
end
function AutoTeam:PET_BATTLE_CLOSE()
  if not C_PetBattles.IsInBattle() then
    if CFG.loadAfterBattle >= 0 then
      C_Timer.After(
        CFG.loadAfterBattle,
        function()
          g.delayCount = 0
          if time() - timeStart < 12 then
            printer.isIgnored = true
          else
            printer.isIgnored = false
          end
          AutoTeam:SelectTeamAfterBattle()
        end
      )
    end
  end
end

function AutoTeam:UpdateAlternates()
  if not CFG.alternates or CFG.alternates == "" then
    Alternates = nil
    return
  end
  for petID in rematch.Roster:AllOwnedPets() do
    local speciesID, _, _, _, _, _, _, speciesName, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByPetID(petID)
    if canBattle and speciesName == CFG.alternates then
      Alternates = petID
      return
    end
  end
  Alternates = nil
end

--缓存宠物数据
function AutoTeam:updatePetListCache()
  if not isInited then
    --从rematch导入数据
    local npcs = rematch.notableNPCs
    for x = 1, #npcs do
      if npcs[x] and npcs[x][3] then
        if not AutoTeamData[npcs[x][1]] then
          AutoTeamData[npcs[x][1]] = {}
        end
      end
    end
    BattleLog = {logs = {}, starttime = nil, endtime = date("%Y-%m-%d %H:%M:%S")}
    isInited = true
  end

  local petlist = {}
  local alternates = nil
  local idTable
  local petGroup = {}

  local highestHPPet = nil
  local highestHP = 0
 
  for petID in rematch.Roster:AllOwnedPets() do
    local speciesID, customName, level, _, _, _, _, speciesName, _, _, _, _, _, _, canBattle =
      C_PetJournal.GetPetInfoByPetID(petID)
    if speciesID and canBattle then
      local health, maxHealth, attack, speed = rematch:GetPetStats(petID)
      if not petlist[speciesID] then
        petlist[speciesID] = {}
      end
      local petInfo = {}
      petInfo.petID = petID
      petInfo.health = health
      petInfo.level = level
      petInfo.attack = attack
      petInfo.speed = speed
      petInfo.percent = math.floor((health * 100) / maxHealth)
      petInfo.speciesName = speciesName
      tinsert(petlist[speciesID], petInfo)

      if maxHealth>highestHP then
        highestHP = maxHealth
        highestHPPet = petID
      end

      if maxHealth > 0 and speciesName == CFG.alternates then
        alternates = petID
      end

      if CFG.petGroups then
        for k, v in pairs(CFG.petGroups) do
          for kk, vv in pairs(v) do
            if kk == speciesID then
              if not petGroup[k] then
                petGroup[k] = {}
              end
              idTable = rematch:GetAbilities(speciesID)
              petInfo.abilityID = {}
              for yy = 1, 3 do
                local idxy
                if vv[yy] == 1 then
                  idxy = yy
                else
                  idxy = yy + 3
                end
                petInfo.abilityID[yy] = idTable[idxy]
              end
              tinsert(petGroup[k], petInfo)
              break
            end
          end
        end
      end
    --PetGroup
    end
  end
  
  if not alternates then
    alternates = highestHPPet
  end

  PetGroup = petGroup
  Alternates = alternates
  PetListCache = petlist
  g.isCaching = false
end

function AutoTeam:updatePetGroup()
  AutoTeam:updatePetListCache()
end

local function OnEvent(self, event, ...)
  if event == "PLAYER_TARGET_CHANGED" then
    AutoTeam:PLAYER_TARGET_CHANGED()
  elseif event == "PET_BATTLE_OPENING_START" then
    AutoTeam:PET_BATTLE_OPENING_START()
  elseif event == "PET_BATTLE_OPENING_DONE" then
    if C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) < 3 then
      PrintMessage(_clError("队伍不完整"))
      WriteLogToFile("队伍不完整")
    end
  elseif event == "PET_BATTLE_CLOSE" then
    AutoTeam:PET_BATTLE_CLOSE()
  elseif event == "PET_JOURNAL_LIST_UPDATE" then
    if not g.isCaching then
      g.isCaching = true
      C_Timer.After(
        0.005,
        function()
          AutoTeam:updatePetListCache()
        end
      )
    end
  elseif event == "ADDON_LOADED" then
  end
end

function AutoTeam:getCurrentTarget()
  return g.npcName
end

function AutoTeam:GetLastNpcData()
  return g.npcName, g.npcWithTeam, g.npcIdWithTeam
end

function AutoTeam:GetCurrentKey()
  return current.key
end

function AutoTeam:GetCurrentNpcId()
  return g.npcId
end

function AutoTeam:HasValidTeam()
  return hasValidTeam
end

function AutoTeam:IsTeamAvailable()
  if g.isLoading then
    return false
  end
  local healthCheck = current.healthCheck or defaultHealthCheck
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      local health, maxHealth, _, _ = C_PetJournal.GetPetStats(petId)
      local percent = math.floor((health * 100) / maxHealth)
      local percentMin = healthCheck[slot] or 100
      if percent < percentMin then
        if CFG.debug then
          print(_clError("队伍还未生效"))
        end
        return false
      end
    end
  end
  return true
end

function ALPTRematchEnable()
  enableTeamLoad = not enableTeamLoad
  if enableTeamLoad then
    print(_clSign("已取消临时关闭自动换队"))
  else
    print(_clError("已临时关闭自动换队"))
  end
end

function ALPTRematchDebug()
  CFG.debug = not CFG.debug
  if CFG.debug then
    print(_clSign("启用Debug输出"))
  else
    print(_clSign("禁用Debug输出"))
  end
end

function ALPTRematchSwitchMode()
  CFG.mode = CFG.mode + 1
  if CFG.mode > 3 then
    CFG.mode = 1
  end
  print("换队模式：" .. _clInfo(CFG.modeName[CFG.mode]))
  g.isSkip = false
end

SLASH_ALPTREMATCH1 = "/alpt"
SlashCmdList["ALPTREMATCH"] = function(cmd, editbox)
  if cmd == "switch" then
    ALPTRematchSwitchMode()
  elseif cmd == "enable" then
    ALPTRematchEnable()
  elseif cmd == "debug" then
    ALPTRematchDebug()
  elseif cmd == "option" then
    ALPTRematch:OpenOptions()
  end
end

local frame = CreateFrame("FRAME", nil, UIParent)
frame:SetScript("OnEvent", OnEvent)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_TARGET_CHANGED")
frame:RegisterEvent("PET_BATTLE_OPENING_START")
frame:RegisterEvent("PET_BATTLE_OPENING_DONE")
frame:RegisterEvent("PET_BATTLE_CLOSE")
frame:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
