# BagSync

## [v12.3](https://github.com/Xruptor/BagSync/tree/v12.3) (2020-01-23)
[Full Changelog](https://github.com/Xruptor/BagSync/compare/v12.2...v12.3)

- -Added a throttle to the Auction scanning.  It was being triggered way too much.  
    -Fixed the mailbox not being able to process Battle pets.  
    -Fixed the guild bank not being able to process Battle pets.  
- -Added support for new battle pet database items to the BagSync Search  
    -Added unique identifiers for auction and battle pet info in DB.  
    -Added ability to click on battle pets in BagSync search window to show Floating Battle Pet tooltip.  
    -Fixed an issue where the new LibQTip was not properly hiding.  
- -Major fix for Battle Pets and how they are stored.  
    -Added a custom tooltip for battle pets because Blizzard has a special tooltip for those.  
    -Fixed an issue with the Auction Expiration function.  
