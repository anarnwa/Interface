# Deadly Boss Mods Core

## [8.3.3](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/8.3.3) (2020-01-23)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/8.3.2...8.3.3)

- Update zhTW (#114)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Create zhTW (#116)  
- Update TOC (#115)  
- Update zhTW (#113)  
    * Update zhTW  
    * Update zhTW  
    Fix mistakes  
- Bump version and prepare a tag, all the fixes thus far should be pushed out even if only 11/12 completed with live data. Don't worry though, There will be another update as soon as I can get hands on enough Nzoth data (heroic and normal)  
- Significant updates to carapace again.  
    Heroic and normal timer speeds differences now handled correctly by mod  
    ALL timers were further updated for greatly improved accuracy by accounting for all stage resets and all stage differences correctly, in both normal and heroic.  
- Carapace of N'Zoth Update  
    Redid  Stage code to fix some bugs with it. Should reliably transition timers for stage changes now.  
    Added warning for gaze of madness spawn to switch for dps  
    Updated most timers to newest values on live  
    Re-added gaze of madness timer since it was possible to do one again.  
    Disabled the Trashing tentacle timer and warning for now, since currently it is undetectable and may need some elaborate scheduling later  
- Remove api checks from world bosses, and disable Tashara since blizz removed it? all it's spells exist but journal entry for it vanished.  
- Speed up legacy target scanning on Tussle tonks so it doesn't take too long if on a tank  
    Switched King Mechagon to legacy target scanning since 8.3 broke UNIT\_TARGET scanning for taht boss too, not just tonks  
    Added more boss unit IDs to ViqGoth, which should hopefully resolve cases where tentacle timer doesn't show  
- Updated curse urls on voice packs panel in DBM GUI  
- Fixed crush timer on Shadhar. Event I was using is no longer in combat log. There are CLEU events still there but not ones for the sequence starting, so I switched to a reliable UNIT event that is equiv of old CLEU one.  
    Changed umbral breath to START event since it's back and removed SUCCESS handler for it. This will speed up that breath warning a tiny bit  
    Redid breath timer to live update off energy instead of being less reliably hardcoded to speed up over time. It's still not perfect because blizzards energy code is typically garbage (they don't use realtime in even static energy calculations, they use some kind of onupdate/loop method. So you can imagine how it is with scaling energy rates too). Fortunately based on my checks, and how often timer will auto correct when needed, it'll still be off far less than it was.  
- Fixed the fixate warning/yell on Shadhar  
- Fixed ra-den's call essences timer on heroic difficulty  
- Drycode infoframe for checking who has debuff and how much time remaining on it to Drestagath  
    Couple fixes to last hivemind commit  
- Completely redid hivemind timers for live heroic and normal since blizzard redid them again.  
    Restored Add timers on hivemind do to the stupid removal of add spawn combat log events.  
- Updated wrathion timers on all difficulties to match live  
    Updated heroic timers on Xanesh to match live (and other difficulties)  
    Changed Mind Control switch target warnings to off by default on both nzoth encounters. It can get spammy and as such is more of an opt in than an opt out.  
- Maut infoframe should now show mana % instead of mana number  
    Maut Annihilation timer is now 55 seconds (up from 35 it was on PTR)  
    Maut shadow claws and Devour magic timers also adjusted by about 2 seconds each.  
    Porphet Skitra mod should now remove icons when Shred Psyche ends  
- KR Update (Ny'alotha) (#112)  
    * KR Update (Ny'alotha)  