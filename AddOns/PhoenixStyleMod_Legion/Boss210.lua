psbossfileLegion210=1




function pscmrbossREPORTLegion2101(wipe,try,reset,checkforwipe)
if reset==nil then
if checkforwipe==nil or (checkforwipe and pswasonbossLegion210 and pswasonbossLegion210==1) then

	if pswasonbossLegion210==1 then
		pssetcrossbeforereport1=GetTime()

		if psraidoptionson[4][2][10][1]==1 then
			strochkavezcrash=psiccdmgfrom.." |s4id206555|id ("..psmainmtotal.."): "
			reportafterboitwotab(psraidchats3[psraidoptionschat[4][2][10][1]], true, vezaxname, vezaxcrash, 1)
		end
		if psraidoptionson[4][2][10][2]==1 then
			strochkavezcrash=psiccdmgfrom.." |s4id206515|id ("..psmainmtotal.."): "
			reportafterboitwotab(psraidchats3[psraidoptionschat[4][2][10][2]], true, vezaxname2, vezaxcrash2, 1)
		end
		if psraidoptionson[4][2][10][3]==1 then
			strochkavezcrash=psiccdmgfrom.." |s4id167819|id ("..psmainmtotal..", check addon to see distance info): "
			reportafterboitwotab(psraidchats3[psraidoptionschat[4][2][10][3]], true, vezaxname3, vezaxcrash3, 1)
		end


	end
	if pswasonbossLegion210==1 or (pswasonbossLegion210==2 and try==nil) then

		psiccsavinginf(psbossnames[4][2][10], try, pswasonbossLegion210)

		strochkavezcrash=psiccdmgfrom.." |s4id206555|id ("..psmainmtotal.."): "
		reportafterboitwotab("raid", true, vezaxname, vezaxcrash, nil, nil,0,1)
		strochkavezcrash=psiccdmgfrom.." |s4id206515|id ("..psmainmtotal.."): "
		reportafterboitwotab("raid", true, vezaxname2, vezaxcrash2, nil, nil,0,1)
		strochkavezcrash=psiccdmgfrom.." |s4id167819|id ("..psmainmtotal.."): "
		reportafterboitwotab("raid", true, vezaxname3, vezaxcrash3, nil, nil,0,1)

		psiccrefsvin()

	end




	if wipe then
		pswasonbossLegion210=2
		pscheckbossincombatmcr_legion1=GetTime()+1
	end
end
end
end


function pscmrbossRESETLegion2101(wipe,try,reset,checkforwipe)
if reset or wipe==nil then
pswasonbossLegion210=nil


table.wipe(vezaxname)
table.wipe(vezaxcrash)
table.wipe(vezaxname2)
table.wipe(vezaxcrash2)
table.wipe(vezaxname3)
table.wipe(vezaxcrash3)

end
end



function pscombatlogbossLegion210(arg1, arg2, hideCaster, guid1, name1, flag1, new1, guid2, name2, flag2, new2, spellid, spellname, arg11,arg12,arg13,arg14,arg15)




if arg2=="SPELL_DAMAGE" and spellid==206555 and name2 then
  if pswasonbossLegion210==nil then
    pswasonbossLegion210=1
  end
  psunitisplayer(guid2,name2)
  if psunitplayertrue then

    pscheckwipe1()
    if pswipetrue and pswasonbossLegion210~=2 then
      psiccwipereport_legion1("wipe", "try")
    end
    addtotwotables1(name2)
    vezaxsort1()
    local tt2=", "..psdamageceil(arg12)
      if arg13>=0 then
        tt2=", "..psdamageceil(arg12-arg13).." |cffff0000("..psoverkill..": "..psdamageceil(arg13)..")|r"
      end
    pscaststartinfo(0,spellname..": "..psaddcolortxt(1,name2)..name2..psaddcolortxt(2,name2)..tt2, -1, "id1", 1, "|s4id"..spellid.."|id - "..psinfo,psbossnames[4][2][10],2)
  end
end

if arg2=="SPELL_PERIODIC_DAMAGE" and spellid==206515 then
  if pswasonbossLegion210==nil then
    pswasonbossLegion210=1
  end
  psunitisplayer(guid2,name2)
  if psunitplayertrue then

    pscheckwipe1()
    if pswipetrue and pswasonbossLegion210~=2 then
      psiccwipereport_legion1("wipe", "try")
    end
    addtotwotables2(name2)
    vezaxsort2()
    local tt2=", "..psdamageceil(arg12)
      if arg13>=0 then
        tt2=", "..psdamageceil(arg12-arg13).." |cffff0000("..psoverkill..": "..psdamageceil(arg13)..")|r"
      end
    pscaststartinfo(0,spellname..": "..psaddcolortxt(1,name2)..name2..psaddcolortxt(2,name2)..tt2, -1, "id1", 2, "|s4id"..spellid.."|id - "..psinfo,psbossnames[4][2][10],2)
  end
end

if arg2=="SPELL_DAMAGE" and (spellid==167819 or spellid==167935 or spellid==177380 or spellid==152987) then
  if pswasonbossLegion210==nil then
    pswasonbossLegion210=1
  end
  _meter="10"
  if spellid==167935 then
	_meter="20"
  end
  if spellid==177380 then
	_meter="30"
  end
  if spellid==152987 then
	_meter="40"
  end
  psunitisplayer(guid2,name2)
  if psunitplayertrue then

    pscheckwipe1()
    if pswipetrue and pswasonbossLegion210~=2 then
      psiccwipereport_legion1("wipe", "try")
    end
    addtotwotables3(name2)
    vezaxsort3()
    local tt2=", "..psdamageceil(arg12)
      if arg13>=0 then
        tt2=", "..psdamageceil(arg12-arg13).." |cffff0000("..psoverkill..": "..psdamageceil(arg13)..")|r"
      end
    pscaststartinfo(0,spellname..": "..psaddcolortxt(1,name2)..name2..psaddcolortxt(2,name2)..tt2.." (".._meter.." yd)", -1, "id1", 3, "|s4id"..spellid.."|id - "..psinfo,psbossnames[4][2][10],2)
  end
end



if arg2=="SPELL_CAST_START" and spellid==208672 then
pscheckrunningbossid(guid1)
pscaststartinfo(spellid,spellname..": %s.", 2, guid1, 91, "|s4id"..spellid.."|id - "..pseventsincomb2,psbossnames[4][2][10])
end



end