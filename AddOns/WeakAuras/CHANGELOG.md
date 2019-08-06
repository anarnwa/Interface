# [2.14.0-beta1](https://github.com/WeakAuras/WeakAuras2/tree/2.14.0-beta1) (2019-08-05)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/2.13.4...2.14.0-beta1)

## Highlights

 - Sub-Regions! Add as many texts as you like to every aura
- Tons of more customization options for texts
- You can now use replacement variables to get info from every trigger, i.e. %2.p will be the progress value of Trigger 2!
- So many bug fixes that I actually lost count
- Settings UI overhaul, use the pencil button to find more advanced features!
- Allow usage of multi units (nameplate, boss, arena, group) by custom and generic triggers
- Groups & Dynamic Groups no longer have a generated thumbnail, you can chose your own icons for them!
Dynamic group's growers have a new option "Group by Frame", it can be "unit frame", "nameplates" or a custom function.
- And so much more, there will be blog posts! 

## Commits

InfusOnWoW (21):

- Fix continous anchoring if a anchoring is post poned
- Fix first frame of SubText
- Add a "Show GCD" option to Cooldown Progress (Item/Equipment Slot)
- Fix WeakAuras.ContainsPlaceholders to correctly handle %2.p
- Add a advanced spec load option
- Conditions: Active trigger check: Don't rely on state.show
- Ensure that we don't run init functions for auras that are not shown
- Fix glow size for non masque users
- Tweak new subtexts
- Fix SetJustfiyH call
- Item Count: Make %s return the count
- Fix unit change events for pets
- Generic Trigger: Fix specific unit not showing up in some cases
- Fix cooldown showing up if a icon gets reused
- Sanitize attaching texts to aurabars
- Fix Copy/Paste Dispaly to not copy display/group settings
- Ensure the fake PRD frame actually shows up in the options
- Add PLAYER_ENTERING_WORLD to a few status/conditions triggers
- Switch inputs to custom text function
- Fix Modernize code
- Rework text handling and introduce the concept of sub regions

Stanzilla (14):

- rename icon pencil text
- colorize extra options string for triggers
- capitalize a few strings and call it extra options for glow as well
- fix a typo
- add 8.2 weapon enchants to templates
- change all sub(0,*) calls to sub(1,*)
- replace SetItemRef instead of HandleModifiedItemClick and SetHyperlink to prevent Interface action failed errors
- styling and use prettyPrint
- fix ESC key on profiling dialog
- friendly neighborhood semicolon purge
- Use UIPanelCloseButton here as well
- don't try to load ModelPicker frame on classic
- Revert "install realpath on travis"
- install realpath on travis

emptyrivers (6):

- remove obsolete migration
- provide a more informative message when the login thread fails
- merge migrations into one block
- resort any region which is changed
- improve multiselect validation
- ensure option key exists before trying to say it exists

mrbuds (30):

- No Texture Tweaks
- Icon: tweak icon extra options
- Icon extra settings: show "None" if nothing changed
- AuraBar: move color settings before icon settings
- SubRegions: Add Sub Regions => Add Extra Elements
- SubText: 1. Text => Text 1
- SubText: Visible => Show Text
- glow condition: visibility => show glow
- fix glow identwidth
- fix subtext indentwidth
- Allow usage of multi units (nameplate, boss, arena, group) by custom and generic triggers  - exemple of event for a TSU: UNIT_SPELLCAST_START:nameplate
- Cast trigger: fix events for nameplates
- make profiling data accessible from 3rd party
- add pencil options for icons
- add ability to set own group icon
- improve border options layout
- add ending header line between 2 collapsible groups fix #1465 moved and renamed some icon display options
- Add anchoring to nameplates and unitframes or custom for dynamic groups - require state property unit - new dependency LibGetFrame accesible from WeakAuras.GetUnitFrame - custom function take 2 parameters: frames and activeRegions   it return a table [frame or ""][regionData] = { x, y, show }   where if frame == "" it anchor to the dynamic group region
- Use same border options for dynamic group as normal groups Cleaner default border / backdrop settings
- fix SetItemRef taint
- add some druid spells
- classic: ignore modelPicker from minimize button
- cast trigger: fix cast bar hide on random button press
- fix classic load conditions
- another attempt at fixing packager condition in embeds.xml with this change libclassicdurations & libclassiccast needs to be installed standalone with dev non-packaged build
- fix wrong packager condition for embeds.xml
- remove LibRangeCheck-2.0 and disactivate "Range Check" trigger for classic
- fix embeds.xml & .toc files packaging conditions for classic
- Cast Trigger: add meta units "group", "arena", "boss", "nameplate" (#1436)
- WoW Classic compatibility (#1347)

