# [2.16.0](https://github.com/WeakAuras/WeakAuras2/tree/2.16.0) (2020-01-14)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/2.15.5...2.16.0)

## Highlights

 - More bugfixes than I can count
- Remove "disable import" button
- Add Wiki links to editor
- Raid Marker support in SubText
- Templates for Classic
- Totems and RangeCheck for Classic
- 8.3 Encounter IDs
- Button to turn of snapping alignment
- Quick Action toolbar for import/new
Remember update preferences per aura
- New glow features 

## Commits

InfusOnWoW (57):

- Fix SetMoverSizer trying to set to a nil region
- Revert "Remove a call to ActivateChild that is not needed"
- Fix Expand/Collapse and filtering of DisplayButtons
- Fix glow attachment for bars
- Fix MoverSizer breakage
- Fix various issues around the visibility of option buttons
- Fix nil error on deleting a trigger
- Remove the import button
- Fix a error if the state doesn't contain a id
- BuffTrigger2: Use UNIT_AURA event for multi target tracking
- Fix Thumbnail not being parented to import tooltip
- Fix error on deleting triggers
- Ensure that aura_env.states always contains a entry per trigger
- Fix regression in glow not being visible
- Fix Action Button Glow to look like 2.15.5
- Add a Name condition to Generic Triggers that provide a name info
- Add a Object Type Flag Check to the Combat Log Trigger
- Add a nil check to AddUnitChangeInternalEvents
- Fix various issues around fake states
- Remove code that is no longer needed
- Fix glow Release
- Fix glow Modernize
- Add a magnetic alignment toolbar button and better Icons
- Fix various small issues with Bar glows
- Warn about untrackable units in BuffTrigger2
- Warn against too long up times if that prevents scheduling timers
- Model: Don't call SetCamera
- Rewrite Model regions and thumbnail handling
- Fix BarModel alpha not working in some cases
- Point users to twitch support
- Make the title width scale with the length of the version string
- Glow.lua: Don't load old Masque versions
- Fix FrameStrata for dynamic groups
- Fix anchoring of borders/glows on masque skins
- Fix error for condition in options
- Replace localized raid markers in text with locale-independant strings
- Fix toolbar/search box visible
- Also use ReplaceRaidMarkerSymbols in Text
- squash into toolbar
- Add Raid Markers support to SubText
- Fix WeakAuras.difficulty_info to have a entry for normal
- Add more Options to Status/Conditions
- Add a "toolbar" to the WeakAuras window
- Add a total duration check to bufftrigger2
- Add a "hostility" check to the CLEU trigger
- Fix Truncating Fonts after game launch
- Add a exact spell id option to the spell known load option
- Fix %p in Aura Preview sometimes going missing
- Fix overlays not being updated in some edge cases
- Readd a gcd check for Item Cooldowns
- Set Max/Min Progress: Add a relative mode to it
- Totem: Add a pattern match trigger option
- Add WIKI links to TextEditor
- Remove a call to ActivateChild that is not needed
- Glow
- Fix border anchoring
- Remove unused UpdateAnchor from various sub elements

LiangYuxuan (1):

- fix typo

Stanzilla (4):

- Bump TOCs for Patch 8.3.0
- Fix classic check
- Update Issue Template
- Rename button widget and add GameFontNormal to luacheckrc

emptyrivers (8):

- remember update preferences for each aura
- also bump workflow target version
- toc bump
- Fix feature request template
- adjust repair tool buttons
- ignore desktop.ini
- add control for hiding reorder entry controls
- add array entry naming feature

mrbuds (16):

- add nameFunc to trigger "Spell Known" fixes #1871
- add Ny'alotha, the Waking City encounter ids
- Classic totem (#1863)
- reposition children of dynamic group on unitframes on GETFRAME_REFRES… (#1864)
- remove totem triggers of classic templates
- disable Totem trigger for classic
- Add "Queued Action" trigger for classic fixes #1628
- remove the "Delete" option for groups fixes #1841
- fix pet_behavior_types for classic
- templates: fix glow
- Power trigger: update spell cost on UNIT_SPELLCAST_SUCCEEDED fixes #1822
- Classic templates
- fix nil error in "Charges Changed (Spell)" trigger (#1828)
- Use proper callbacks for classic libraries (#1821)
- Classic: Use LibClassicDurations's UnitAuraDirect instead of Un… (#1816)
- fix stance trigger when form checkbox is not selected fixes #1805

nullKomplex (3):

- Custom Options Author Names Tweaks (#1868)
- Add Relative Offset Property Change (#1866)
- Re-add Range Check to Classic. (#1839)

