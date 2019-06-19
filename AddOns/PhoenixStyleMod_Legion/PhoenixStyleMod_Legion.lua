function psloadpatchlegion3()

currentExpansion=4

pslocalepatchlegion31()

if GetLocale()=="deDE" or GetLocale()=="ruRU" or GetLocale()=="zhTW" or GetLocale()=="zhCN" or GetLocale()=="frFR" or GetLocale()=="koKR" or GetLocale()=="esES" or GetLocale()=="esMX" then
pslocalepatchlegion3()
end

--description of the menu
psraidoptionstxtLegion1={}
psraidoptionstxtLegion1[1]={
{"|tip2 "..psdidfriendlyf.." |sid203097|id","|tip2 "..psmainmdamagefrom.." |sid202978|id","|tip2 "..psmainmdamagefrom.." |sid203045|id","|tip2 "..psmainmgot.." |sid210850|id"},
{"|tip2 "..psmainmdamagefrom.." |sid212886|id","|tip2 "..psdidfriendlyf.." |sid215143|id"},
{"|tip2 "..psmainmdamagefrom.." |sid213124|id","|tip2 "..psmainmgot.." |sid210850|id"},
{},
{"|tip2 "..psmainmgot.." |sid203110|id","|tip2 "..psmainmdamagefrom.." |sid204122|id","|tip2 "..psmainmgot.." |sid205341|id","|tip2 "..psmainmdamagefrom.." |sid205870|id"},
{"|tip2 "..psmainmgot.." |sid210315|id"},
{"|tip2 "..psmainmdamagefrom.." |sid206656|id"},
}
psraidoptionstxtLegion1[2]={
{"|tip2 "..psmainmdamagefrom.." |sid210074|id","|tip2 "..psmainmdamagefrom.." |sid204483|id"},
{"|tip2 "..psmainmdamagefrom.." |sid206612|id"},
{"|tip2 "..psmainmdamagefrom.." |sid206792|id","|tip2 "..psmainmdamagefrom.." |sid206749|id","|tip2 "..psmainmdamagefrom.." |sid207631|id"}, 
{"|tip2 "..psmainmdamagefrom.." |sid213278|id"},
{"|tip2 "..psmainmdamagefrom.." |sid218155|id","|tip2 "..psmainmdamagefrom.." |sid219950|id"}, 
{"|tip2 "..psdidfriendlyf.." |sid206938|id","|tip2 "..psmainmdamagefrom.." |sid206398|id"},
{},
{"|tip2 "..psmainmdamagefrom.." |sid205391|id"},
{"|tip2 "..psmainmdamagefrom.." |sid209590|id"},
{"|tip2 "..psmainmdamagefrom.." |sid206555|id","|tip2 "..psmainmdamagefrom.." |sid206515|id","|tip2 "..psmainmdamagefrom.." |sid167819|id (check info in the addon to see distance)"},  
}
psraidoptionstxtLegion1[3]={
{"|tip2 "..psdidfriendlyf.." |sid228012|id","|tip2 "..psmainmdamagefrom.." |sid227781|id"},
{},
{"|tip2 "..psdidfriendlyf.." |sid193367|id","|tip2 "..psmainmdamagefrom.." |sid228051|id"},
}
psraidoptionstxtLegion1[4]={
{"|tip2 "..psmainmdamagefrom.." |sid233062|id","|tip2 "..psmainmdamagefrom.." |sid210074|id"},
{},
{"|tip2 "..psmainmdamagefrom.." |sid231768|id"},
{"|tip2 "..psmainmdamagefrom.." |sid236516|id"},
{"|tip2 "..psmainmdamagefrom.." |sid232732|id","|tip2 "..psmainmdamagefrom.." |sid232827|id"},
{"|tip2 "..psdidfriendlyf.." |sid239006|id","|tip2 "..psmainmdamagefrom.." |sid236158|id","|tip2 "..psmainmdamagefrom.." |sid236241|id"},
{"|tip2 "..psdidfriendlyf.." |sid240170|id","|tip2 "..psmainmdamagefrom.." |sid234896|id"},
{"|tip2 "..psmainmdamagefrom.." |sid234062|id","|tip2 "..psmainmdamagefrom.." |sid240970|id"},
{""},
}


for i=1,#psraidoptionstxtLegion1 do
	for j=1,#psraidoptionstxtLegion1[i] do
		for k=1,#psraidoptionstxtLegion1[i][j] do
			psraidoptionstxtLegion1[i][j][k]=psspellfilter(psraidoptionstxtLegion1[i][j][k])
		end
	end
end

--chat settings 1 or 2 or 3
psraidoptionschatdefLegion1={}
psraidoptionschatdefLegion1[1]={
{1,1,1,1},
{1,1},
{1,1},
{},
{1,1,1,1},
{1},
{1},
}
psraidoptionschatdefLegion1[2]={
{1,1},
{1},
{1,1,1},
{1},
{1,1},
{1,1},
{},
{1},
{1},
{1,1,1},
}
psraidoptionschatdefLegion1[3]={
{1,1},
{},
{1,1},
}
psraidoptionschatdefLegion1[4]={
{1,1},
{},
{1},
{1},
{1,1},
{1,1,1},
{1,1},
{1,1},
{},
}



--chat settings on or off
psraidoptionsondefLegion1={}
psraidoptionsondefLegion1[1]={
{1,1,1,1},
{1,1},
{1,1},
{},
{1,1,1,1},
{1},
{1},
}
psraidoptionsondefLegion1[2]={
{1,1},
{1},
{1,1,1},
{1},
{1,1},
{1,1},
{},
{1},
{1},
{1,1,1},
}
psraidoptionsondefLegion1[3]={
{1,1},
{},
{1,1},
}
psraidoptionsondefLegion1[4]={
{1,1},
{},
{1},
{1},
{1,1},
{1,1,1},
{1,1},
{1,1},
{},
}



--SetMapToCurrentZone()
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[4][1]) or pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[4][2]) or pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[4][3]) or pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[4][4]) then
	PhoenixStyleMod_patchlegion3:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end
	PhoenixStyleMod_patchlegion3:RegisterEvent("PLAYER_REGEN_DISABLED")
	PhoenixStyleMod_patchlegion3:RegisterEvent("PLAYER_REGEN_ENABLED")
	PhoenixStyleMod_patchlegion3:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	PhoenixStyleMod_patchlegion3:RegisterEvent("ADDON_LOADED")
	PhoenixStyleMod_patchlegion3:RegisterEvent("CHAT_MSG_ADDON")
	PhoenixStyleMod_patchlegion3:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	PhoenixStyleMod_patchlegion3:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	

end



--онапдейт
function psonupdatepatchlegion3(curtime)





--тут всякие онапдейт модули









--evade after 3 sec
if pscmrcheckforevade_legion1 and curtime>pscmrcheckforevade_legion1 then
pscmrcheckforevade_legion1=pscmrcheckforevade_legion1+7
local id=0
if UnitGUID("boss1") then
	id=psGetUnitID(UnitGUID("boss1"))
end
local bil=0
if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end
if (UnitName("boss1")==nil and UnitName("boss2")==nil and UnitName("boss3")==nil) or bil==1 or (UnitName("boss1") and UnitName("boss1")=="") then
psiccwipereport_legion1(nil,"try")
end
end



if pscatamrdelayzone_legion1 and curtime>pscatamrdelayzone_legion1 then
pscatamrdelayzone_legion1=nil
local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or (a2=="raid" or (a2=="party" and a3==2)) then
--SetMapToCurrentZone()
end
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][1]) or pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][2]) then
PhoenixStyleMod_patchlegion3:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
else
PhoenixStyleMod_patchlegion3:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end
end

--announce delay for phasing
if psiccrepupdate_legion1 and curtime>psiccrepupdate_legion1 then
psiccrepupdate_legion1=nil
psiccwipereport_legion1(psdelcount1,psdelcount2,psdelcount3)
psdelcount1=nil
psdelcount2=nil
psdelcount3=nil
end


--прерванные бои
if pscheckbossincombatmcr_legion1 and GetTime()>pscheckbossincombatmcr_legion1 then
	pscheckbossincombatmcr_legion1=pscheckbossincombatmcr_legion1+2


local id=0
if UnitGUID("boss1") then
	id=psGetUnitID(UnitGUID("boss1"))
end
local bil=0
if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end

	if UnitGUID("boss1") and bil==0 and UnitName("boss1")~="" then
	else
		pscheckbossincombatmcr_legion1=nil
		pscheckbossincombatmcr_legion12=GetTime()+1
	end
end

if pscheckbossincombatmcr_legion12 and GetTime()>pscheckbossincombatmcr_legion12 then
	pscheckbossincombatmcr_legion12=nil
	if psbossblock==nil then
		psiccwipereport_legion1(nil, nil, "reset")
	end
end

if pscatadelaycheckboss and curtime>pscatadelaycheckboss then
pscatadelaycheckboss=nil
if psdevmode then
print("пытаюсь понять что за босс в бою")
end

	if UnitGUID("boss1") then
		local id2=UnitGUID("boss1")
		local id=psGetUnitID(id2)
local bil=0
if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end
		if bil==0 and UnitName("boss1")~="" then
			pscmroncombatstartcheckboss_legion1(id)
		else
			pscmrdelayofbosccheck_legion1=GetTime()+1
		end
	else
		pscmrdelayofbosccheck_legion1=GetTime()+1
	end
end


--постоянная проверка по ходу боя...
if pscmrdelayofbosccheck_legion1 and curtime>pscmrdelayofbosccheck_legion1 then
pscmrdelayofbosccheck_legion1=curtime+1
if psdevmode then
print("пытаюсь понять что за босс в бою2")
end

	if UnitGUID("boss1") then
		local id2=UnitGUID("boss1")
		local id=psGetUnitID(id2)
local bil=0
if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end
		if bil==0 and UnitName("boss1")~="" then
			pscmroncombatstartcheckboss_legion1(id)
			pscmrdelayofbosccheck_legion1=nil
		end
	end
end


--hunter die delay

if psicchunterdiedelay and curtime>psicchunterdiedelay then
psicchunterdiedelay=nil


psicchunterdiedelaytable=nil
psicchunterdiedelayboss=nil
end







end

function pscmroncombatstartcheckboss_legion1(id)

if psbossblock==nil then

--SetMapToCurrentZone()
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][1]) or pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][2]) then
  pscmrcheckforevade_legion1=GetTime()+10
end


--ыыытест новые боссы прописывать тут (2 места)
if psdevmode then
print ("ID BOSSA: "..id)
end


if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][1]) then
	if (id==102672) and psbossfileLegion11 then
		pswasonbossLegion11=1
	end
	if (id==105393) and psbossfileLegion12 then
		pswasonbossLegion12=1
	end
	if (id==106087) and psbossfileLegion13 then
		pswasonbossLegion13=1
	end
	if (id==100497) and psbossfileLegion14 then
		pswasonbossLegion14=1
	end
	if (id==39407) and psbossfileLegion15 then
		pswasonbossLegion15=1
	end
	if (id==106912 or id==104636) and psbossfileLegion16 then
		pswasonbossLegion16=1
	end
	if (id==103769) and psbossfileLegion17 then
		pswasonbossLegion17=1
	end
end

if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][2]) then
	if (id==102263) and psbossfileLegion21 then
		pswasonbossLegion21=1
	end
	if (id==104415) and psbossfileLegion22 then
		pswasonbossLegion22=1
	end
	if (id==104288) and psbossfileLegion23 then
		pswasonbossLegion23=1
	end
	if (id==110908) and psbossfileLegion24 then
		pswasonbossLegion24=1
	end
	if (id==104528) and psbossfileLegion25 then
		pswasonbossLegion25=1
	end
	if (id==103758) and psbossfileLegion26 then
		pswasonbossLegion26=1
	end
	if (id==103685) and psbossfileLegion27 then
		pswasonbossLegion27=1
	end
	if (id==101002) and psbossfileLegion28 then
		pswasonbossLegion28=1
	end
	if (id==110965) and psbossfileLegion29 then
		pswasonbossLegion29=1
	end
	if (id==110533) and psbossfileLegion210 then
		pswasonbossLegion210=1
	end
end
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][3]) then
	if (id==114263) and psbossfileLegion31 then
		pswasonbossLegion31=1
	end
	if (id==114344) and psbossfileLegion32 then
		pswasonbossLegion32=1
	end
	if (id==96759) and psbossfileLegion33 then
		pswasonbossLegion33=1
	end
end
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][4]) then
	if (id==115844) and psbossfileLegion41 then
		pswasonbossLegion41=1
	end
	if (id==120996) and psbossfileLegion42 then
		pswasonbossLegion42=1
	end
	if (id==116407) and psbossfileLegion43 then
		pswasonbossLegion43=1
	end
	if (id==118523) and psbossfileLegion44 then
		pswasonbossLegion44=1
	end
	if (id==115767) and psbossfileLegion45 then
		pswasonbossLegion45=1
	end
	if (id==118460) and psbossfileLegion46 then
		pswasonbossLegion46=1
	end
	if (id==118289) and psbossfileLegion47 then
		pswasonbossLegion47=1
	end
	if (id==120436) and psbossfileLegion48 then
		pswasonbossLegion48=1
	end
	if (id==108573) and psbossfileLegion49 then
		pswasonbossLegion49=1
	end
end




end

end


function psoneventpatchlegion3(self,event,...)


if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18 = CombatLogGetCurrentEventInfo()

--Inst 6
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][1]) then

if pswasonbossLegion11 then
pscombatlogbossLegion11(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion12 then
pscombatlogbossLegion12(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion13 then
pscombatlogbossLegion13(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion14 then
pscombatlogbossLegion14(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion15 then
pscombatlogbossLegion15(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion16 then
pscombatlogbossLegion16(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion17 then
pscombatlogbossLegion17(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

else

pscombatlogbossLegion11(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion12(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion13(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion14(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion15(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion16(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion17(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

end

end
--inst 6 end


--Inst 6 -- ЫЫТЕСТ ВРЕМЕННО ОТКЛЮЧЕН ВТОРОЙ ИНСТ ЧТОБ НЕ БЫЛО ОШИБОК.
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][2]) then


if pswasonbossLegion21 then
pscombatlogbossLegion21(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion22 then
pscombatlogbossLegion22(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion23 then
pscombatlogbossLegion23(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion24 then
pscombatlogbossLegion24(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion25 then
pscombatlogbossLegion25(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion26 then
pscombatlogbossLegion26(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion27 then
pscombatlogbossLegion27(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion28 then
pscombatlogbossLegion28(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion29 then
pscombatlogbossLegion29(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion210 then
pscombatlogbossLegion210(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

else

pscombatlogbossLegion21(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion22(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion23(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion24(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion25(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion26(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion27(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion28(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion29(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion210(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

end

end


--Inst 6
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][3]) then

if pswasonbossLegion31 then
pscombatlogbossLegion31(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion32 then
pscombatlogbossLegion32(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion33 then
pscombatlogbossLegion33(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

else

pscombatlogbossLegion31(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion32(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion33(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

end

end
--inst 6 end


--Inst 6
if pscheckzoneId2(C_Map.GetBestMapForUnit("player"),pslocations[currentExpansion][4]) then

if pswasonbossLegion41 then
pscombatlogbossLegion41(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion42 then
pscombatlogbossLegion42(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion43 then
pscombatlogbossLegion43(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion44 then
pscombatlogbossLegion44(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion45 then
pscombatlogbossLegion45(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion46 then
pscombatlogbossLegion46(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion47 then
pscombatlogbossLegion47(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion48 then
pscombatlogbossLegion48(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
elseif pswasonbossLegion49 then
pscombatlogbossLegion49(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

else

pscombatlogbossLegion41(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion42(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion43(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion44(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion45(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion46(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion47(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion48(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)
pscombatlogbossLegion49(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)

end

end
--inst 6 end





--res to reset info
if arg2=="SPELL_RESURRECT" and (spellid==83968 or spellid==7328 or spellid==50769 or spellid==2008 or spellid==2006) then
psiccwipereport_legion1(nil,"try")
end


else

--остальные евенты

local arg1, arg2, arg3,arg4,arg5,arg6 = ...

if event == "PLAYER_REGEN_DISABLED" then


if (psbilresnut and GetTime()<psbilresnut+3) or pscheckbossincombat then


else

--тут резет всего в начале боя ыытест


pselegontabldamage3={{},{},{},{}}
table.wipe (pselegontabldamage3[1])
table.wipe (pselegontabldamage3[2])
table.wipe (pselegontabldamage3[3])
table.wipe (pselegontabldamage3[4])



if UnitGUID("boss1") then
local id2=UnitGUID("boss1")
local id=psGetUnitID(id2)
local bil=0
if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end
if bil==0 and UnitName("boss1")~="" then
pscmroncombatstartcheckboss_legion1(id)
else
pscatadelaycheckboss=GetTime()+2
end

else
pscatadelaycheckboss=GetTime()+2
end


end
end


if event=="PLAYER_REGEN_ENABLED" then
	if UnitAffectingCombat("player")==false and UnitIsDeadOrGhost("player")==false then --and UnitName("boss1")==nil
    --if pswasonbossp42 then
    --  psrezetnotcombp3=GetTime()+3
    --else
      psrezetnotcombp3=GetTime()+5
    --end
	end
end



if event == "ZONE_CHANGED_NEW_AREA" then


psiccwipereport_legion1(nil,"try")
pscatamrdelayzone_legion1=GetTime()+3

pscmrdelayofbosccheck_legion1=nil


end


if event == "CHAT_MSG_ADDON" then


end

if event =="CHAT_MSG_MONSTER_EMOTE" then



end

if event=="CHAT_MSG_RAID_BOSS_EMOTE" then



end




if event == "ADDON_LOADED" then

if arg1=="PhoenixStyleMod_Legion" then



local psiccnewveranoncet={}
if GetLocale()=="ruRU" then
psiccnewveranoncet={}
end 




pslastmoduleloadtxt="Raids Legion"


--перенос переменных

pscmrpassvariables_legion1()


for i=1,#psraidoptionsonLegion1 do
	if psraidoptionson[currentExpansion][i]==nil then psraidoptionson[currentExpansion][i]={}
	end
	for j=1,#psraidoptionsonLegion1[i] do
		if psraidoptionson[currentExpansion][i][j]==nil then
			psraidoptionson[currentExpansion][i][j]={}
		end
		for t=1,#psraidoptionsonLegion1[i][j] do
			if psraidoptionson[currentExpansion][i][j][t]==nil then
				psraidoptionson[currentExpansion][i][j][t]=psraidoptionsonLegion1[i][j][t]
			end
		end
	end

	if psraidoptionstxt[i]==nil then psraidoptionstxt[i]={}
	end
	for j=1,#psraidoptionstxtLegion1[i] do
		if psraidoptionstxt[i][j]==nil then
			psraidoptionstxt[i][j]={}
		end
		for t=1,#psraidoptionstxtLegion1[i][j] do
			if psraidoptionstxt[i][j][t]==nil then
				psraidoptionstxt[i][j][t]=psraidoptionstxtLegion1[i][j][t]
			end
		end
	end




	if psraidoptionschat[currentExpansion][i]==nil then psraidoptionschat[currentExpansion][i]={}
	end
	for j=1,#psraidoptionschatLegion1[i] do
		if psraidoptionschat[currentExpansion][i][j]==nil then
			psraidoptionschat[currentExpansion][i][j]={}
		end
		for t=1,#psraidoptionschatLegion1[i][j] do
			if psraidoptionschat[currentExpansion][i][j][t]==nil then
				psraidoptionschat[currentExpansion][i][j][t]=psraidoptionschatLegion1[i][j][t]
			end
		end
	end
end



--boss manual localization update



end
end
--остальные евенты конец





end --рейд


end --КОНЕЦ ОНЕВЕНТ


--tryorkill - if try then true, if kill - nil, reset - only reset no report
--pswasonboss42 1 если мы в бою с боссом и трекерим, 2 если вайпнулись и продолжаем трекерить ПОСЛЕ анонса
function psiccwipereport_legion1(wipe, tryorkill, reset, checkforwipe)
local aa=""
if wipe then
aa=aa.."wipe:"..wipe.."."
end
if tryorkill then
aa=aa.."tryorkill:"..tryorkill.."."
end
if reset then
aa=aa.."reset:"..reset.."."
end
if checkforwipe then
aa=aa.."checkforwipe:"..checkforwipe.."."
end


	if pszapuskdelayphasing>0 then
	psiccrepupdate_legion1=pszapuskdelayphasing
	pszapuskdelayphasing=0
	if psiccrepupdate_legion1>7 then psiccrepupdate_legion1=7 end
	psiccrepupdate_legion1=psiccrepupdate_legion1+GetTime()
	psdelcount1=wipe
	psdelcount2=tryorkill
	psdelcount3=reset
	else

		if psiccrepupdate_legion1==nil then

--ыыытест новые боссы прописывать тут (2 места)
pscmrcheckforevade_legion1=nil



if (pswasonbossLegion11) then
pscmrbossREPORTLegion111(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion111(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion12) then
pscmrbossREPORTLegion121(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion121(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion13) then
pscmrbossREPORTLegion131(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion131(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion14) then
pscmrbossREPORTLegion141(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion141(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion15) then
pscmrbossREPORTLegion151(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion151(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion16) then
pscmrbossREPORTLegion161(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion161(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion17) then
pscmrbossREPORTLegion171(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion171(wipe, tryorkill, reset, checkforwipe)
end




if (pswasonbossLegion21) then
pscmrbossREPORTLegion211(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion211(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion22) then
pscmrbossREPORTLegion221(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion221(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion23) then
pscmrbossREPORTLegion231(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion231(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion24) then
pscmrbossREPORTLegion241(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion241(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion25) then
pscmrbossREPORTLegion251(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion251(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion26) then
pscmrbossREPORTLegion261(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion261(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion27) then
pscmrbossREPORTLegion271(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion271(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion28) then
pscmrbossREPORTLegion281(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion281(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion29) then
pscmrbossREPORTLegion291(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion291(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion210) then
pscmrbossREPORTLegion2101(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion2101(wipe, tryorkill, reset, checkforwipe)
end




if (pswasonbossLegion31) then
pscmrbossREPORTLegion311(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion311(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion32) then
pscmrbossREPORTLegion321(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion321(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion33) then
pscmrbossREPORTLegion331(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion331(wipe, tryorkill, reset, checkforwipe)
end




if (pswasonbossLegion41) then
pscmrbossREPORTLegion411(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion411(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion42) then
pscmrbossREPORTLegion421(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion421(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion43) then
pscmrbossREPORTLegion431(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion431(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion44) then
pscmrbossREPORTLegion441(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion441(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion45) then
pscmrbossREPORTLegion451(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion451(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion46) then
pscmrbossREPORTLegion461(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion461(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion47) then
pscmrbossREPORTLegion471(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion471(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion48) then
pscmrbossREPORTLegion481(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion481(wipe, tryorkill, reset, checkforwipe)
end

if (pswasonbossLegion49) then
pscmrbossREPORTLegion491(wipe, tryorkill, reset, checkforwipe)
pscmrbossRESETLegion491(wipe, tryorkill, reset, checkforwipe)
end



		end

	end

if wipe==nil and psbossblock==nil then
psbossblock=GetTime()
end

end


function pscmrpassvariables_legion1()

if psraidoptionschatLegion1==nil then psraidoptionschatLegion1={} end

for i=1,#psraidoptionschatdefLegion1 do
	if psraidoptionschatLegion1[i]==nil then
		psraidoptionschatLegion1[i]={}
	end
	for j=1,#psraidoptionschatdefLegion1[i] do
		if psraidoptionschatLegion1[i][j]==nil then
			psraidoptionschatLegion1[i][j]={}
		end
		for t=1,#psraidoptionschatdefLegion1[i][j] do
			if psraidoptionschatLegion1[i][j][t]==nil or (psraidoptionschatLegion1[i][j][t] and psraidoptionschatLegion1[i][j][t]==0) then
				psraidoptionschatLegion1[i][j][t]=psraidoptionschatdefLegion1[i][j][t]
			end
		end
	end
end

if psraidoptionsonLegion1==nil then psraidoptionsonLegion1={} end

for i=1,#psraidoptionstxtLegion1 do
	if psraidoptionsonLegion1[i]==nil then
		psraidoptionsonLegion1[i]={}
	end
	for j=1,#psraidoptionschatdefLegion1[i] do
		if psraidoptionsonLegion1[i][j]==nil then
			psraidoptionsonLegion1[i][j]={}
		end
		for t=1,#psraidoptionschatdefLegion1[i][j] do
			if psraidoptionsonLegion1[i][j][t]==nil then
				psraidoptionsonLegion1[i][j][t]=psraidoptionschatdefLegion1[i][j][t]
			end
		end
	end
end

end