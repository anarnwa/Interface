=============================================================================
-- 
-- Name: Faction Addict
-- Desc: Addon for World of Warcraft
--
-- Author: gmz323(Greg)
-- current version: v1.55
-- (c) 2011-2019
--
=============================================================================


Description: 
============
Faction Addict is a stand-alone addon that provides additional faction information to your characters working towards faction based achievements. Intended for those players who work on gaining exalted with many factions but also helpful to those that do not. There are in game achievements for being exalted with 1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, and 60 factions respectively.

Faction Addict also provides a reputation logging system that allows the player to see what reputation gains they have made in the current and previous sessions.

Use slash commands /fa or /factionaddict or click the new button on the upper right corner of your characters reputation panel to open and/or close the addon window.

Download location:
==================
* wowinterface - http://goo.gl/NtOjh
* curse - http://goo.gl/MNoKm

Official Homepage:
==================
http://goo.gl/R3Ocg

Usage:
======
/fa
/factionaddict
*click button* on upper right corner of character's reputation page

Features:
=========
* Factions - Shows all factions - including those not "known" by your character
* Log - Reputation gain logging - shows reputation gains your character has made in the current and previous sessions.
* Faction info panel - click on a faction in the addon to see more specific info.
* Exalted Count - Shows count of exalted factions and how many required for next achievement.
* Exalted Achievements Tooltip - Show which character earned which achievement on what date
* Paragon Information - shows info and progress towards next Paragon
* Display Ordering - Faction display can be ordered by % to exalted or faction name
* Display Filtering - Faction display can be filtered by standing, expansion, alliance/horde only
* Auto-Change Reputation Bar - reputation bar will auto-change to faction that had last gain
* Hide Inactive Factions - Faction display will hide any factions you mark as inactive in the default reputation ui. (Click 'Move to Inactive')
* Search - click the search icon to toggle the input field to search the factions

Localizations:
==============
Files are in place for basic localization support. If you would like to help complete the Faction Addict localizations please contact us!

In the FactionAddict\Locales addon folder are the following files for localization. They should be your starting point if you want to help out.
* enUS.lua - english client (complete!)
* deDE.lua - deutsch client (Thanks Harry!)
* esES.lua - spanish client (Thanks MrUrkaz!)
* frFR.lua - french client
* zhTW.lua - Chinese (traditional; Taiwan) (Thanks Sop!)
* zhCN.lua - Chinese (simplified; mainland China) (Thanks Sop!)
* itIT.lua - Italian client (Thanks Kemat1an!)
* ptBR.lua - Portuguese client (Thanks Celso!)

My Other Addons:
================
* Tabard Addict - tracks how many tabards have been equipped for the various tabard achievements.
* Below Average Items - an addon that places a small visual indicator on equipped items that are below your current iLvl average.

Changelog:
==========

v1.55 (2019-03-23)
------------------
* Removed Hozen (1243) and The Brewmasters (1351) factions as they have not been implemented in game. (thanks XANTHiDE for report!)

v1.54 (2018-12-15)
------------------
* Update for 8.1 client.
* Make Pearlfin Jinyu (1242) an Alliance Only faction.

v1.53 (2018-12-12)
------------------
* Removed Akama's Trust Faction (1416)

v1.52 (2018-09-01)
------------------
* Attempt to fix the Chromie reputation displaying incorrect "percent to complete". This issue is due to the wow api returning a Friendship Max Rep value of 42000 but the actual max being 15000. This has to be hardcoded internally in the addon for now. (Thanks to TinyPhreak for the bug report and additional details!)
* Updated many of the BFA faction icons to match their reputation reward icon.

v1.51 (2018-08-17)
------------------
* Fixed a bug related to 'Proudmoore Admiralty' faction. Incorrect factionID used by addon. (Thanks to DaBear78 for the bug report and finding the issue!)

v1.50 (2018-07-29)
------------------
* Added 'Paragon' option to the 'Faction Standing Filter' dropdown in the top right of the addon. (Thanks to lisakaps for the suggestion!)

v1.49 (2018-07-24)
------------------
* Addition of Battle for Azeroth factions and config options.
* If you would like to submit localization updates see the release notes for more info and get in touch.

v1.48 (2018-07-18)
------------------
* compatibility update for Battle for Azeroth pre-patch 8.0
* BFA features will be added in a future release

v1.47 (2017-08-30)
------------------
* fix for PlaySound() 7.3 changes

v1.46 (2017-08-29)
------------------
* toc update for patch 7.3
* added factions - Army of the Light and Argussian Reach

v1.45 (2017-08-03)
------------------
* Update to the Italian (itIT) client localization. Thanks Angelo!

v1.44 (2017-04-30)
------------------
* LUA Error fix - lua errors were being thrown when first reaching exalted reputation with a Paragon-able faction.
* Display of Exalted (capped) reputation bars will look full again instead of empty - 42000/42000
* Display of Friend Reputation Text in status bar - ie. Best Friend, Good Friend, Friend, etc...
* Please keep reporting any issues, lua errors you encounter, and suggestions. Thanks! 

v1.43 (2017-04-27)
------------------
* Logging of Paragon Rep gains - the logging tab will now include your paragon rep gains. 
* Reward Bag Icons added to UI - the same reward bag icons that are in the default ui (and reward available indicator) is now part of the faction display.
* Please report any issues you run into. I've only been able to do minimal testing as I don't have many Legion factions at Exalted to test with.

v1.42 (2017-04-25)
------------------
* Paragon Rep Info - Faction Addict now displays info and progress for Paragon reputations. The faction info window shows the reward for completing the paragon.
* New Localization Strings - for non-english users please note there are 2 new strings that will need to be localized into your language. Look for PCT_TO_REWARD_TXT and MISC_PARAGON_TXT in files.
* FYI - Logging NOT yet updated to include paragon repuation. Due to the actual value of paragon reputation gains not being printed in the chat log a new logging method will need to be created for paragon logging.
* Future Update - more UI polish for paragon reputations coming soon. Hope to include the paragon reward bag icons similar to default UI.
* Please report any issues you run into with the new changes.

v1.41 (2017-04-09)
------------------
* Added the 7.2 factions to the addon that were left out. Please let me know if run into other missing factions.
* PARAGON REP Note - The addon currently does NOT display info about Paragon reputations. Still working on how best to integrate this into the UI in an easily useable way.

v1.40 (2017-03-28)
------------------
* update for WoW 7.2 patch

v1.39 (2016-10-25)
------------------
* update for WoW 7.1 patch
* added ptBR locale (Portuguese) - Thanks Celso!

v1.38 (2016-10-19)
------------------
* update Italian (itIT) locale. Thanks to Kemat1an!

v1.37 (2016-10-12)
------------------
* updated Spanish (esES) Locale. Thanks MrUrkaz!
* removed Operation: Aardvark faction that did not end up in the game.

v1.36 (2016-10-09)
------------------
* Localization updates in this release!
* Added Italian (itIT) Locale. Thanks to Kemat1an!
* Added Spanish (esES) Locale. Thanks to MrUrkaz!
* Can now also be localized (see locale files) - Category names shown in Info Window, Standing Filter (dropdown) text and number values, Date Format shown in Log section (Thanks MrUrkaz!) These new sections require localization. Feel free to get in touch if you have any updates. Thanks!

v1.35 (2016-08-29)
------------------
* updates to China/Taiwan localizations for Legion expansion - Thanks Sop!

v1.34 (2016-08-10)
------------------
* added config option for Legion expansion factions
* added info for Legion factions
* added new locales for China/Taiwan - Thanks Sop!

v1.33 (2016-07-19)
------------------
* updates to work with WoW 7.0+ - Legion pre-expansion patch
* NOTE: The addon changes have been tested on PTR version 7.0.3.22210. Please report any issues you find on Live version.

v1.32 (2015-12-18)
------------------
* no functional changes - code cleanup

v1.31 (2015-06-23)
------------------
* Updated for wow 6.2
* New 6.2 Factions Added - Hand of the Prophet, Order of the Awakened, Vol'jin's Headhunters, The Saberstalkers
* minor bug fixes

v1.30 (2015-04-22)
------------------
* NEW FEATURE ADDED! - Move Faction to Inactive
* Factions can now be marked as inactive in the addon by clicking the 'Move to Inactive' checkbox on the detailed faction info window. 
* Inactive factions are moved to the bottom of the faction list and have a red background. 
* Inactive factions can be hidden from the faction list by clicking 'Hide Inactive Factions' in the Config.
* Any 'Move to Inactive' setting you've made in the default client reputation window is now ignored.
* Feedback/Issues - Please let me know (comments or email) if you run into any issues with the new feature. I wanted to get it out before 6.2 to iron out any issues there might be. Thanks!

v1.29 (2015-03-15)
------------------
* Forest Hozen faction (1228) updated to be Horde Only.

v1.28 (2015-02-24)
------------------
* Updated for wow 6.1

v1.27 (2015-01-06)
------------------
* 'Last Gain' entry at the top of the Log page of the addon has been modified to better accomodate long faction names. For example - displaying 'Steamwheedle Preservation Society' would cause the gain digits to be chopped off. Now long faction names will be truncated so that at least 4 gain digits can be displayed on that line.

v1.26 (2014-12-22)
------------------
* Added Brawler's Guild Factions: Brawl'gar Arena (Horde) and Bizmo's Brawlpub (Alliance).
* Updated Icons for: Delvar Ironfist, Aeda Brightdawn, Defender Illona, Leorajh, Talonpriest Ishaal, Tormmok, and Vivianne.

v1.25 (2014-11-25)
------------------
* BUGFIX: Auto-Change Reputation Bar - auto-change would not work if the Faction Addict window had not been opened prior to there being a CHAT_MSG_COMBAT_FACTION_CHANGE event. (for example - 'Reputation with Lower City increased by 300.' in the chat) Changed to make sure required data is loaded prior to addon window being opened.

v1.24 (2014-11-12)
------------------
* NEW: Key Bindings support - you can now setup a custom keybinding to open/close Faction Addict via the 'AddOns' category of the Key Bindings menu in-game. 
* Enjoy Warlords of Draenor everyone!

v1.23 (2014-11-11)
------------------
* NEW FEATURE: a search feature has been added to the main factions tab. Click the search icon in the top right of the addon (next to standing filter) to toggle the search field

v1.22 (2014-10-28)
------------------
* BUGFIX: exalted achievements tooltip - there was a case where character name was not returned by server when getting achievement data causing the name to be blank () in tooltip. This usually occurs on lower lever characters with few addons where the character loads into the game very quickly.

v1.21 (2014-10-27)
------------------
* German Localization Added - All credit and thanks to Harry! for submitting the changes for the german [deDE] localization.
* Exalted Achievements Tooltip UPDATED! - Now more easily tell which character on your account earned which exalted achievement and the date it was earned. To show this summary tooltip hover the mouse over the Next/Shown/Exalted text at the bottom of the main addon tab.

v1.20 (2014-10-24)
------------------
* BUGFIX: fix for error 'attempt to concatenate local faction a nil value' - lua error when the first reputation gain of the sessions was for your guild

v1.19 (2014-10-14)
------------------
* BUGFIX: fix for error 'attempt to concatenate upvalue lfgBonusFactionID' if you were seeing that one

v1.18 (2014-10-14)
------------------
* Added 'Star' indicator from default UI to support LFG Bonus Faction
* [ESC] will now close the addon with all other UI elements.
* Clean up some unnecessary table allocations.
* Force data update on PLAYER_LOGIN event - client was not getting all faction data on initial addon load
* Other minor bugfixes

v1.17 (2014-09-19)
------------------
* Add config option for display of Warlords of Draenor factions.
* Add new Warlords of Draenor and Barracks Bodyguards factions.

v1.16 (2014-09-17)
------------------
* WoW version 6.0 compatibility release.

v1.15 (2013-09-16)
------------------
* Added Emperor Shaohao faction
* Order/Filter modes updated to support game changes to Tillers subfactions (Ella, Gina Mudclaw, Jogu, etc...)

v1.14 (2013-09-10)
------------------
* Updated for WoW 5.4

v1.13 (2013-05-21)
------------------
* Updated for WoW 5.3

v1.12 (2013-04-06)
------------------
* New Feature! - Auto-Change Reputation Bar - reputation bar will now auto-change to faction that had last gain, not including your guild faction gains. This feature can be turned on/off via the config tab.
* New Feature! - Hide Inactive Factions - Faction display will hide any factions your mark as inactive in the default reputation ui. (Click 'Move to Inactive') This feature can be turned on/off via the config tab.
* Much credit to Phanx for help on this update. Thanks Phanx!

v1.11 (2013-03-28)
------------------
* Added indicator on reputation bars for account wide 'bonus reputation'. This is the bonus unlocked when you buy the various Grand Commendations from faction quartermasters. (Same indicator as used in the default ui)
* NOTE - 'Champion a faction' star indicators still to be added in future release

v1.10 (2013-03-05)
------------------
* Updated for client 5.2
* Added new factions - Shado-Pan Assault, Sunreaver Onslaught, and Kirin Tor Offensive
* NOTE! - Indicators for account 'Bonus Reputation and 'Champion a faction' will be added in future release.

v1.09 (2012-12-03)
------------------
* Added new 5.1 factions - Dominance Offensive, Operation: Shieldwall, and Akama's Trust.

v1.08 (2012-11-28)
------------------
* update toc for client 5.1

v1.07 (2012-10-20)
------------------
* Minor tweaks to layout of faction logos.

v1.06 (2012-8-28)
------------------
* Changes to support Mists of Pandaria.
* Added many new factions identified in MoP. More sorting and config options will be added for them in the future.

v1.05 (2012-4-16)
------------------
* (bugfix) Fix generic reputation gain case where reputation gain message didn't include a value. - ie "Reputation with FACTION increased" instead of "Reputation with FACTION increased by VALUE".
* (bugfix) Fix reputation gains that include a "refer-a-friend" bonus in chat message.

v1.04 (2012-3-7)
------------------
* Added new tooltip containing list of all the exalted reputation achievements. Tooltip is shown when mouse over "Next Achievement" text at bottom of addon.

v1.03 (2012-2-20)
------------------
* increased reputation logging to hold more previous days of reputation gains
* changes to make addon more localization friendly in the future
* fixed refresh issue with info panel

v1.02 (2012-2-1)
------------------
* (bugfix) Fix handling of guild name faction on character load.

v1.01 (2012-1-30)
------------------
* Initial release of Faction Addict