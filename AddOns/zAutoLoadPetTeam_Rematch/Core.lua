local AutoTeam = CreateFrame("Frame", "AutoLoadPetTeamRematch")
local rematch = Rematch
local saved, settings
local CFG = AutoLoadPetTeamConfig
local AutoTeamData = AutoLoadPetTeamData

local g = {
  npcName = "",
  npcId = 0,
  skipload = false,
  lastTeam = {"", "", ""},
  isloading = false,
  loadTimes = 0,
  teamcount = 0,
  teamcountall = 0,
  teamcountcurrent = {},
  loadingKey = "",
  loadingName = "",
  defaultHealthCheck = {100, 100, 100},
  defaultIgnoreBreed = {false, false, false},
  loadinpets = {{}, {}, {}},
  replacePet = {false, false, false},
  alternates = {},
  lastHealth = {0, 0, 0},
  waittimes = 0,
  updating = false,
  runStep = 0,
  timerPrinted = true,
  delayPrint = false,
  needLoadAgain = false,
  lastHealthCheck = nil
}

local isInited = false

local PetListCache = {}
rematch:InitModule(
  function()
    saved = RematchSaved
    settings = RematchSettings
  end
)

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

local function PrintMessage(msg)
  if CFG.debug or CFG.showTeamMessage then
    print(msg)
  end
end
local function WriteLogToFile(logText)
  if CFG.logToFile and BattleLog then
    tinsert(BattleLog, logText)
  end
end
function ALPTRematchEnable()
  CFG.enable = not CFG.enable
  if CFG.enable then
    print(_clSign("已启用自动换队"))
  else
    print(_clError("已关闭自动换队"))
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
  g.skipload = false
end

function AutoTeam:getSamePets(spId)
  local samepets = PetListCache[spId]
  if not samepets or #samepets < 2 then
    if CFG.debug then
      print("重新检索替补宠物[" .. spId .. "]")
    end
    samepets = {}
    local numall, numPets = C_PetJournal.GetNumPets()
    if numPets and numPets > 0 then
      for n = 1, numPets do
        local petID, speciesID, owned, customName, level, _, _, speciesName, _, _, _, _, _, _, canBattle =
          C_PetJournal.GetPetInfoByIndex(n)
        if owned and speciesID and speciesID == spId then
          local petInfo = {}
          petInfo.petID = petID
          petInfo.level = level
          petInfo.health = 0
          petInfo.attack = 0
          petInfo.speed = 0
          petInfo.percent = 0
          petInfo.speciesName = speciesName
          tinsert(samepets, petInfo)
        end
      end
    else
      if CFG.debug then
        print("数据异常：GetNumPets获取为空(" .. (numPets or 0) .. "/" .. (numall or 0) .. ")")
      end
    end
  end
  return samepets
end

function AutoTeam:getPetStatus(pt)
  local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(pt.petID)
  pt.health = maxHealth
  pt.attack = attack
  pt.speed = speed
  pt.percent = math.floor((health * 100) / maxHealth)
end

function AutoTeam:TryLoadTeam(teamKey, forced, healthCheck, ignoreBreed, group, disableLoadSamePet, onlyOne)
  local team = saved[teamKey]
  if not team then
    if not g.useDefault then
      local msg = "队伍[" .. teamKey .. "]缺失"
      PrintMessage(_clError(msg))
      WriteLogToFile(msg)
    end
    return false
  end
  g.lastHealthCheck = healthCheck
  local name = team.teamName or teamKey

  local loadin = {{}, {}, {}}
  local pickIndex = 1
  local petInTeam = {}

  g.replacePet = {false, false, false}

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
      if not levelUpPet then
        loadin[i][1] = g.alternates[1] or 0
        if loadin[i][1] ~= 0 then
          petInTeam[loadin[i][1]] = true
        end
      else
        loadin[i][1] = levelUpPet
        petInTeam[levelUpPet] = true
      end
    end
  end

  for m = 1, 3 do
    if not loadin[m][0] then
      --检查血量
      local pid = loadin[m][1]
      if not pid then
        return false
      end

      local speciesID, customName, level = C_PetJournal.GetPetInfoByPetID(pid)
      local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(pid)
      if not speciesID then
        speciesID = team[m][5]
        level = 25
        customName = ""
        health = 0
        maxHealth = 1
        attack = 0
        speed = 0
      end
      if not speciesID then
        return false
      end

      local percent = math.floor((health * 100) / maxHealth)
      local minCheckPercent = (healthCheck[m] or 100)
      local success = false
      if CFG.debug then
        print(m .. "号宠血量:" .. percent .. "%,检测血线:" .. minCheckPercent .. "%")
      end
      if percent < minCheckPercent then
        if group and group[m] and group[m].name and g.petGroup[group[m].name] then
          if CFG.debug then
            print(m .. "号宠尝试同组替补")
          end
          --从自定义组取同类型
          local groupM = group[m]
          local samepets = g.petGroup[groupM.name]

          if not groupM.hp then
            groupM.hp = {0, 99999}
          end
          if not groupM.attack then
            groupM.attack = {0, 99999}
          end
          if not groupM.speed then
            groupM.speed = {0, 99999}
          end

          for n = 1, #samepets do
            local pt = samepets[n]
            self:getPetStatus(pt)
            if
              pt.percent >= minCheckPercent and pt.level == level and not petInTeam[pt.petID] and
                pt.health >= (groupM.hp[1] or 0) and
                pt.health <= (groupM.hp[2] or 99999) and
                pt.attack >= (groupM.attack[1] or 0) and
                pt.attack <= (groupM.attack[2] or 9999) and
                pt.speed >= (groupM.speed[1] or 0) and
                pt.speed <= (groupM.speed[2] or 9999) and
                ((not groupM.tag) or groupM.tag == pt.tag)
             then
              loadin[m][1] = pt.petID
              petInTeam[pt.petID] = true
              success = true
              g.replacePet[m] = true
              for tt = 1, 3 do
                loadin[m][tt + 1] = pt.abilityID[tt]
              end
              break
            end
          end
        end
      end
      if not success and percent < 99 and not disableLoadSamePet then
        if onlyOne or forced then
          -----------------------
          -----------------------
          --单队或强制模式情况，直接加载最高血量
          if CFG.debug then
            print(m .. "号宠尝试加载最高血量")
          end
          local samepets = self:getSamePets(speciesID)
          if samepets ~= nil and #samepets > 0 then
            local minPercent = percent
            local lastPetId = pid
            for n = 1, #samepets do
              local pt = samepets[n]
              if pt.level == level and not petInTeam[pt.petID] then
                self:getPetStatus(pt)
                if pt.percent >= minPercent then
                  if ignoreBreed[m] or (pt.attack == attack and pt.speed == speed) then
                    minPercent = pt.percent + 1
                    if lastPetId then
                      petInTeam[lastPetId] = nil
                    end
                    lastPetId = pt.petID
                    loadin[m][1] = pt.petID
                    petInTeam[pt.petID] = true
                    success = true
                    g.replacePet[m] = true
                    if pt.percent >= 99 then
                      --找到满血直接结束
                      break
                    end
                  end
                end
              end
            end
            if not success then
              --没有找到更高血量，但当前宠物已经符合
              if percent >= minCheckPercent then
                success = true
              end
            end
          end
        else
          if percent < minCheckPercent then
            if CFG.debug then
              print(m .. "号宠尝试同类型替补")
            end
            local samepets = self:getSamePets(speciesID)
            if samepets ~= nil and #samepets > 0 then
              for n = 1, #samepets do
                local pt = samepets[n]
                if pt.level == level and not petInTeam[pt.petID] then
                  self:getPetStatus(pt)
                  if CFG.debug then
                    print(pt.speciesName .. pt.percent .. "%")
                  end
                  if pt.percent >= minCheckPercent then
                    if ignoreBreed[m] or (pt.attack == attack and pt.speed == speed) then
                      loadin[m][1] = pt.petID
                      petInTeam[pt.petID] = true
                      success = true
                      g.replacePet[m] = true
                      break
                    end
                  end
                end
              end
            else
              if CFG.debug then
                print(m .. "号未找到替补")
              end
            end --A
          else
            success = true
          end
        end
        if not success and not forced then
          return false
        end
      end
    end
  end

  g.loadingKey = teamKey
  g.loadingName = name
  g.loadinpets = loadin

  self:LoadTeam()

  return true
end

function AutoTeam:IsTeamAvailable()
  local healthCheck = g.lastHealthCheck or g.defaultHealthCheck
  for slot = 1, 3 do
    local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
    if petId then
      local health, maxHealth, _, _ = C_PetJournal.GetPetStats(petId)
      local percent = math.floor((health * 100) / maxHealth)
      if percent < healthCheck[slot] then
        if CFG.debug then
          print(_clError("队伍还未生效"))
        end
        return false
      end
    end
  end
  return true
end

function AutoTeam:LoadTeamProc()
  local loadin = g.loadinpets
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
  settings.loadedTeam = g.loadingKey
  return true
end

function AutoTeam:PrintCurrentTeam()
  if CFG.showTeamMessage and not g.needLoadAgain then
    local msg = ""
    local logtext = ""
    if CFG.showTeamCount[1] then
      if g.teamcount == 0 then
        g.teamcount = 1
      end
      msg = msg .. "[" .. g.teamcount .. "]"
    end
    if CFG.showTeamCount[2] then
      msg = msg .. "[" .. g.teamcountall .. "]"
    end
    if CFG.showTeamCount[3] then
      msg = msg .. "[" .. (g.teamcountcurrent[g.loadingKey] or 0) .. "]"
    end
    logtext = msg
    msg = msg .. "已加载" .. ACHIEVEMENT_COLOR_CODE .. "[ " .. g.loadingName .. " ]:" .. FONT_COLOR_CODE_CLOSE
    logtext = logtext .. "已加载" .. "[ " .. g.loadingName .. " ]:"
    for slot = 1, 3 do
      local petId, _, _, _ = C_PetJournal.GetPetLoadOutInfo(slot)
      if petId then
        local speciesID, customName, level, _, _, _, _, petName = C_PetJournal.GetPetInfoByPetID(petId)
        local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(petId)
        local percent = math.floor((health * 100) / maxHealth)
        if level < 25 then
          msg = msg .. C_PetJournal.GetBattlePetLink(petId) .. _clSign(level)
          logtext = logtext .. "[" .. petName .. "]" .. level
        else
          msg = msg .. C_PetJournal.GetBattlePetLink(petId)
          logtext = logtext .. "[" .. petName .. "]"
          if g.replacePet[slot] then
            msg = msg .. _clSign("↑")
            logtext = logtext .. "↑"
          end
          if percent < 100 then
            msg = msg .. percent .. "%"
            logtext = logtext .. percent .. "%"
          end
        end
      end
    end
    PrintMessage(msg)
    WriteLogToFile(logtext)
    g.delayPrint = false
  end
end

function AutoTeam:LoadTeam()
  if self:LoadTeamProc() then
    g.skipload = true
    g.isloading = false

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
    if g.runStep == 1 then
      g.needLoadAgain = false
    end
    if not g.ignoreLast and not g.needLoadAgain then
      g.teamcount = g.teamcount + 1
      g.teamcountall = g.teamcountall + 1
      if not g.teamcountcurrent[g.loadingKey] then
        g.teamcountcurrent[g.loadingKey] = 0
      end
      g.teamcountcurrent[g.loadingKey] = g.teamcountcurrent[g.loadingKey] + 1
    end
    if not g.timerPrinted and CFG.enableBattleTimer then
      g.delayPrint = true --推迟到计时消息后输出
    else
      self:PrintCurrentTeam()
    end
  elseif g.loadTimes < CFG.loadRetries then
    g.loadTimes = g.loadTimes + 1
    C_Timer.After(
      CFG.loadRetryInteval,
      function()
        AutoTeam:LoadTeam()
      end
    )
  else
    g.isloading = false
    g.skipload = true
    if g.runStep == 1 then
      local msg = "加载队伍[ " .. g.loadingName .. " ]失败"
      PrintMessage(_clError(msg))
      WriteLogToFile(msg)
    end
  end
end

local function getHealthCheck(npcData, i, teamKey)
  local hk = (npcData.healthCheck and npcData.healthCheck[i])
  if not hk then
    if settings.alpt and settings.alpt[teamKey] then
      hk = settings.alpt[teamKey].healthCheck
    end
  end
  return hk or g.defaultHealthCheck
end
local function getIgnoreBreed(npcData, i, teamKey)
  local ib = (npcData.ignoreBreed and npcData.ignoreBreed[i])
  if ib == true then
    ib = {true, true, true}
  end
  if not ib then
    if settings.alpt and settings.alpt[teamKey] then
      ib = settings.alpt[teamKey].ignoreBreed
    end
  end
  return ib or g.defaultIgnoreBreed
end

local function isDisableLoadSamePet(npcData, i, teamKey)
  if CFG.disableLoadSamePet or npcData.disableLoadSamePet then
    return true
  end
  if settings.alpt and settings.alpt[teamKey] then
    return settings.alpt[teamKey].noAlt
  end
  return false
end

local function isTeamDisabled(teamKey)
  if settings.alpt and settings.alpt[teamKey] then
    return settings.alpt[teamKey].disabled
  end
  return false
end

function AutoTeam:SelectTeam()
  local npcData = AutoTeamData[g.npcId]
  if npcData == nil then
    if saved[g.npcId] then
      npcData = {}
    else
      return
    end
  end

  g.npcWithTeam = g.npcName
  g.isloading = true

  local start, duration, enabled = GetSpellCooldown(125439)
  if duration == 0 then
    g.teamcount = 0
  -- if g.runStep == 2 then --复活CD好了，在选中NPC时再加载一次
  --   g.needLoadAgain = true
  -- end
  end

  g.useDefault = false
  local teamArray = npcData["teams"] or self:findTeamsFromRematch(g.npcId, g.npcName)
  if not teamArray then
    if CFG.debug then
      print("未找预设队伍，使用默认队伍")
    end
    teamArray = CFG.defaultTeam
    g.useDefault = true
  end

  if CFG.debug then
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
  local onlyOne = (#teamArray == 1)
  if duration > 0 then
    for i = 1, #teamArray do
      if not isTeamDisabled(teamArray[i]) then
        local healthCheck = getHealthCheck(npcData, i, teamArray[i])
        local ignoreBreed = getIgnoreBreed(npcData, i, teamArray[i])
        local disableLoadSamePet = isDisableLoadSamePet(npcData, i, teamArray[i])
        if
          self:TryLoadTeam(
            teamArray[i],
            false,
            healthCheck,
            ignoreBreed,
            npcData.groups and npcData.groups[i],
            disableLoadSamePet,
            onlyOne
          )
         then
          return true
        end
      end
    end
  end

  if #teamArray > 0 then
    if duration > 0 then
      local msg = "所有队伍已失效"
      if not C_Scenario.IsInScenario() then
        PrintMessage(_clError(msg))
        WriteLogToFile(msg)
      end
    else
      PrintMessage(_clSign("复活可用"))
      WriteLogToFile("复活可用")
    end
    local ignoreBreed = getIgnoreBreed(npcData, 1, teamArray[1])
    local disableLoadSamePet = isDisableLoadSamePet(npcData, 1, teamArray[i])
    self:TryLoadTeam(
      teamArray[1],
      true,
      g.defaultHealthCheck,
      ignoreBreed,
      npcData.groups and npcData.groups[1],
      disableLoadSamePet,
      onlyOne
    )
    return true
  else
    PrintMessage(_clError("未找到队伍"))
    WriteLogToFile("未找到队伍")
    g.isloading = false
    return false
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

function AutoTeam:SelectTeamWhenTarget()
  g.runStep = 1
  if settings.loadedTeam == g.loadingKey and (g.skipload or g.isloading) and not g.needLoadAgain then
    if not g.isloading and g.loadinpets[1][1] then
      AutoTeam:LoadTeamProc() --再设置次保证成功
    end
    return
  end

  if C_PetJournal.IsJournalUnlocked() then
    AutoTeam:SelectTeam()
  end
end

function AutoTeam:SelectTeamAfterBattle()
  g.runStep = 2
  if g.skipload or g.isloading then
    return
  end

  if C_Scenario.IsInScenario() then
    return
  end

  local changed = (settings.loadedTeam ~= g.loadingKey)
  if not changed then
    local health = AutoTeam:getTeamHealth()
    for slot = 1, 3 do
      if health[slot] ~= g.lastHealth[slot] then
        changed = true
        break
      end
    end
  end

  if changed then
    AutoTeam:SelectTeam()
  else
    g.waittimes = g.waittimes + 1
    if g.waittimes > 50 then
      g.waittimes = 0
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
    print("解析到队伍名称：" .. (matchName or "空白"))
  end
  if not matchName or matchName == "" then
    --teamName = npcName
  else
    teamName = matchName
  end

  local isfind = false
  local teamList = {}
  local name
  for k, v in pairs(saved) do
    --print(k..":"..npcId)
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

function AutoTeam:UpdateTeam()
  return true
end

function AutoTeam:getCurrentTarget()
  return g.npcName
end

function AutoTeam:InitData(npcDatas)
  for k, v in pairs(npcDatas) do
    AutoLoadPetTeamData[k] = v
  end
end

function AutoTeam:updatePetListCache()
  if not isInited then
    --从rematch导入数据
    local npcs = rematch.notableNPCs
    for x = 1, #npcs do
      if npcs[x] and npcs[x][3] then
        if not AutoLoadPetTeamData[npcs[x][1]] then
          AutoLoadPetTeamData[npcs[x][1]] = {}
        end
      end
    end
    for k, v in pairs(AutoLoadPetTeamNpcs) do
      if k and not AutoLoadPetTeamData[k] then
        AutoLoadPetTeamData[k] = {}
      end
    end
    isInited = true
  end

  local _, numPets = C_PetJournal.GetNumPets()
  if not numPets or numPets == 0 then
    g.updating = false
    return
  end
  local petlist = {}
  local alternates = {}
  local idx = 1
  local idTable
  local petGroup = {}

  --for n = 1, numPets do
  for petID in rematch.Roster:AllOwnedPets() do
    local speciesID, customName, level, _, _, _, _, speciesName, _, _, _, _, _, _, canBattle =
      C_PetJournal.GetPetInfoByPetID(petID)
    -- local petID, speciesID, owned, customName, level, _, _, speciesName, _, _, _, _, _, _, canBattle =
    --   C_PetJournal.GetPetInfoByIndex(n)
    if speciesID and canBattle then
      --local health, maxHealth, attack, speed = C_PetJournal.GetPetStats(petID)
      local health, maxHealth, attack, speed = rematch:GetPetStats(petID)
      if not petlist[speciesID] then
        petlist[speciesID] = {}
      end
      local petInfo = {}
      petInfo.petID = petID
      petInfo.health = maxHealth
      petInfo.level = level
      petInfo.attack = attack
      petInfo.speed = speed
      petInfo.percent = math.floor((health * 100) / maxHealth)
      petInfo.speciesName = speciesName
      tinsert(petlist[speciesID], petInfo)

      if CFG.alternates then
        for y = 1, #CFG.alternates do
          if health > 0 and customName == CFG.alternates[y] or speciesName == CFG.alternates[y] then
            alternates[idx] = petID
            idx = idx + 1
            break
          end
        end
      end
      if CFG.petGroups then
        for k, v in pairs(CFG.petGroups) do
          for xx = 1, #v do
            if v[xx] and v[xx][1] == speciesName then
              if not petGroup[k] then
                petGroup[k] = {}
              end
              idTable = rematch:GetAbilities(speciesID)
              petInfo.abilityID = {}
              petInfo.tag = v[xx][5]

              for yy = 1, 3 do
                local idxy
                if v[xx][yy + 1] == 1 then
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
  g.petGroup = petGroup
  g.alternates = alternates
  g.updating = false
  PetListCache = petlist
end

function AutoTeam:PLAYER_TARGET_CHANGED()
  if CFG.debug then
    AutoTeam:DebugFunc()
  end
  if UnitExists("target") then
    local name = UnitName("target")
    if g.npcName ~= name then
      g.skipload = false
    end
    if
      not UnitIsPlayer("target") and not UnitIsEnemy("player", "target") and
        not (InCombatLockdown() or C_PetBattles.IsInBattle() or C_PetBattles.GetPVPMatchmakingInfo())
     then
      local GUID = UnitGUID("target")
      local unit_type, npcid = GUID:match("(%a+)-%d+-%d+-%d+-%d+-(%d+)-.+")
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

local function OnEvent(self, event, ...)
  if not CFG.enable then
    return
  end
  if event == "PLAYER_TARGET_CHANGED" then
    AutoTeam:PLAYER_TARGET_CHANGED()
  elseif event == "PET_BATTLE_OPENING_START" then
    g.skipload = false
    g.lastHealth = AutoTeam:getTeamHealth()
    g.timeLastStart = time()
    g.timerPrinted = false
    g.delayPrint = false
    g.needLoadAgain = false
  elseif event == "PET_BATTLE_OPENING_DONE" then
    if C_PetBattles.GetNumPets(LE_BATTLE_PET_ALLY) < 3 then
      PrintMessage(_clError("队伍不完整"))
      WriteLogToFile("队伍不完整")
    end
  elseif event == "PET_BATTLE_CLOSE" then
    if not C_PetBattles.IsInBattle() then
      if CFG.loadAfterBattle >= 0 then
        C_Timer.After(
          CFG.loadAfterBattle,
          function()
            g.waittimes = 0
            if time() - g.timeLastStart < 12 then
              g.ignoreLast = true
            else
              g.ignoreLast = false
            end
            AutoTeam:SelectTeamAfterBattle()
          end
        )
      end
    end
  elseif event == "PET_JOURNAL_LIST_UPDATE" then
    if not g.updating then
      g.updating = true
      C_Timer.After(
        0.005,
        function()
          AutoTeam:updatePetListCache()
        end
      )
    end
  elseif event == "ADDON_LOADED" then
    BattleLog = {}
  end
end

function AutoTeam:DebugFunc()
end

function AutoTeam:GetLastNpcData()
  return g.npcName, g.npcWithTeam
end

function AutoTeam:GetCurrentKey()
  return g.loadingKey
end

function AutoTeam:GetCurrentNpcId()
  return g.npcId
end

function AutoTeam:PrintTimer(msg)
  PrintMessage(_clLight(msg))
  WriteLogToFile(msg)
  g.timerPrinted = true
  if g.delayPrint then
    self:PrintCurrentTeam()
  end
end

SLASH_ALPTREMATCH1 = "/alpt"
SlashCmdList["ALPTREMATCH"] = function(cmd, editbox)
  if cmd == "switch" then
    ALPTRematchSwitchMode()
  elseif cmd == "enable" then
    ALPTRematchEnable()
  elseif cmd == "debug" then
    ALPTRematchDebug()
  end
end
AutoTeam:SetScript("OnEvent", OnEvent)
AutoTeam:RegisterEvent("ADDON_LOADED")
AutoTeam:RegisterEvent("PLAYER_TARGET_CHANGED")
AutoTeam:RegisterEvent("PET_BATTLE_OPENING_START")
AutoTeam:RegisterEvent("PET_BATTLE_OPENING_DONE")
AutoTeam:RegisterEvent("PET_BATTLE_CLOSE")
AutoTeam:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
