﻿-- Locale
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local AL = AceLocale:NewLocale("RareScanner", "zhTW", false);

if AL then
	AL["ALARM_MESSAGE"] = "一個稀有NPC剛剛出現，檢查你的地圖！"
	AL["ALARM_SOUND"] = "稀有NPC的通告聲音"
	AL["ALARM_SOUND_DESC"] = "稀有NPC出現在小地圖上時撥放的聲音。"
	AL["ALARM_TREASURES_SOUND"] = "事件/寶箱的通告聲音"
	AL["ALARM_TREASURES_SOUND_DESC"] = "事件/寶箱出現在小地圖上時撥放的聲音。"
	AL["AUTO_HIDE_BUTTON"] = "自動隱藏按鈕與小圖像"
	AL["AUTO_HIDE_BUTTON_DESC"] = "超過選擇的時間後自動隱藏按鈕與小圖像 (以秒為單位)。設為0秒時不會自動隱藏。"
	AL["CLASS_HALLS"] = "職業大廳"
	AL["CLEAR_FILTERS_SEARCH"] = "顯示全部"
	AL["CLEAR_FILTERS_SEARCH_DESC"] = "重設之前的搜尋並且顯示完整的清單"
	AL["CLICK_TARGET"] = "點一下將NPC設為目標"
	AL["CONTAINER"] = "箱子"
	AL["DATABASE_HARD_RESET"] = "由於最近的資料片以及最新版的RareScanner在數據庫上發生很大的變化，這需要重置數據庫以避免矛盾。 抱歉給你帶來不便。"
	AL["DISABLE_SEARCHING_RARE_TOOLTIP"] = "停用這個稀有NPC的通知"
	AL["DISABLE_SOUND"] = "停用音效通知"
	AL["DISABLE_SOUND_DESC"] = "啟用時，將不會收到音效通知。"
	AL["DISABLED_SEARCHING_RARE"] = "已停用通知的稀有NPC:"
	AL["DISPLAY"] = "顯示"
	AL["DISPLAY_BUTTON"] = "顯示按鈕與小圖像"
	AL["DISPLAY_BUTTON_CONTAINERS"] = "切換是否顯示寶箱的按鈕"
	AL["DISPLAY_BUTTON_CONTAINERS_DESC"] = "切換是否顯示寶箱的按鈕。不會影響警報聲和聊天通知"
	AL["DISPLAY_BUTTON_DESC"] = "取消按鈕與小圖像後不會再次顯示。它不影響通告聲音和聊天通知。"
	AL["DISPLAY_CONTAINER_ICONS"] = "世界地圖顯示寶箱圖示開關"
	AL["DISPLAY_CONTAINER_ICONS_DESC"] = "當停用時，寶箱的圖示不會顯示在世界地圖上。"
	AL["DISPLAY_EVENT_ICONS"] = "世界地圖顯示事件圖示開關"
	AL["DISPLAY_EVENT_ICONS_DESC"] = "當停用時，事件圖示不會顯示在世界地圖上。"
	AL["DISPLAY_LOG_WINDOW"] = "切換是否顯示紀錄視窗"
	AL["DISPLAY_LOG_WINDOW_DESC"] = "當停用紀錄視窗就不會再出現。"
	AL["DISPLAY_LOOT_ON_MAP"] = "在地圖提示上顯示戰利品"
	AL["DISPLAY_LOOT_ON_MAP_DESC"] = "切換當你把鼠標移到圖示上時，是否在提示上顯示NPC/包含的戰利品。"
	AL["DISPLAY_LOOT_PANEL"] = "切換顯示戰利品"
	AL["DISPLAY_LOOT_PANEL_DESC"] = "啟用時，會顯示NPC掉落的戰利品。"
	AL["DISPLAY_MAP_NOT_DISCOVERED_ICONS"] = "切換是否在地圖上顯示未發現的圖示。"
	AL["DISPLAY_MAP_NOT_DISCOVERED_ICONS_DESC"] = "停用後，還未發現的NPC(紅色與橘色圖示)，箱子以及事件不會在世界地圖上顯示。"
	AL["DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS"] = "切換是否在地圖上顯示舊資料片的未發現圖示。"
	AL["DISPLAY_MAP_OLD_NOT_DISCOVERED_ICONS_DESC"] = "取消以後，對於舊資料片的區域，未探索的稀有NPC圖示(紅色與橘色圖示)、箱子或事件不會顯示在地圖上。"
	AL["DISPLAY_MINIATURE"] = "顯示小畫像"
	AL["DISPLAY_MINIATURE_DESC"] = "停用後小畫像將不在顯示。"
	AL["DISPLAY_NPC_ICONS"] = "世界地圖顯示稀有NPC圖示開關"
	AL["DISPLAY_NPC_ICONS_DESC"] = "當停用時，稀有NPC圖示不會顯示在世界地圖上。"
	AL["DISPLAY_OPTIONS"] = "顯示選項"
	AL["DUNGEONS_SCENARIOS"] = "地城/事件"
	--[[Translation missing --]]
	AL["ENABLE_SCAN_CHAT"] = "Toggle searching for rare NPCs through chat messages"
	--[[Translation missing --]]
	AL["ENABLE_SCAN_CHAT_DESC"] = "When this is activated you will be warned visually and with a sound everytime a rare NPC yells or a chat message related with a rare NPCs is detected."
	AL["ENABLE_SCAN_CONTAINERS"] = "搜尋寶藏或寶箱"
	AL["ENABLE_SCAN_CONTAINERS_DESC"] = "啟用時，每當你的小地圖上有寶藏或寶箱出現，都會有視覺警告與聲音提醒。"
	AL["ENABLE_SCAN_EVENTS"] = "搜尋事件"
	AL["ENABLE_SCAN_EVENTS_DESC"] = "啟用時，每當你的小地圖上有事件出現，都會有視覺警告與聲音提醒。"
	AL["ENABLE_SCAN_GARRISON_CHEST"] = "搜尋要塞寶箱"
	AL["ENABLE_SCAN_GARRISON_CHEST_DESC"] = "啟用時，每當你的要塞寶箱顯示在小地圖上，都會有視覺警告與聲音提醒。"
	AL["ENABLE_SCAN_IN_INSTANCE"] = "切換副本中是否掃描"
	AL["ENABLE_SCAN_IN_INSTANCE_DESC"] = "當啟用後在副本中（地城、團隊、等等）也會如常運作。"
	AL["ENABLE_SCAN_ON_TAXI"] = "使用交通工具時掃描開關"
	AL["ENABLE_SCAN_ON_TAXI_DESC"] = "當啟用時，如果您正在使用交通工具(鳥、船、或其他)仍會正常提示。"
	AL["ENABLE_SCAN_RARES"] = "搜尋稀有NPC"
	AL["ENABLE_SCAN_RARES_DESC"] = "啟用時，每當你的小地圖上有稀有NPC出現，都會有視覺警告與聲音提醒。"
	AL["ENABLE_SEARCHING_RARE_TOOLTIP"] = "啟用這個稀有NPC的通知"
	AL["ENABLED_SEARCHING_RARE"] = "已啟用通知的稀有NPC:"
	AL["EVENT"] = "事件"
	AL["FILTER"] = "過濾NPC"
	AL["FILTER_CONTINENT"] = "大陸/類別"
	AL["FILTER_CONTINENT_DESC"] = "大陸或類別名稱"
	AL["FILTER_RARE_LIST"] = "過濾要搜尋的稀有NPC"
	AL["FILTER_RARE_LIST_DESC"] = "搜尋這個稀有NPC。|n停用後，發現這個NPC時不會通知。"
	AL["FILTER_ZONE"] = "區域"
	AL["FILTER_ZONE_DESC"] = "大陸或類別內的區域"
	AL["FILTER_ZONES_LIST"] = "區域清單"
	AL["FILTER_ZONES_LIST_DESC"] = "啟用/停用這個區域的通知。停用後，在這個區域中發現稀有NPC、事件或寶箱不會通知。"
	AL["FILTERS"] = "過濾稀有NPC"
	AL["FILTERS_SEARCH"] = "搜尋"
	AL["FILTERS_SEARCH_DESC"] = "輸入NPC名字來過濾下方的清單"
	AL["GENERAL_OPTIONS"] = "一般選項"
	AL["JUST_SPAWNED"] = "%s 剛剛出現了，檢查你的地圖！"
	AL["LEFT_BUTTON"] = "左鍵點擊"
	AL["LOG_WINDOW_AUTOHIDE"] = "自動隱藏紀錄NPC的按鈕"
	AL["LOG_WINDOW_AUTOHIDE_DESC"] = "在選定的時間過後(以分計)隱藏每個NPC的按鈕。如果選擇0分，按鈕將會維持直到你關閉紀錄視窗或是達到最大按鈕數量為止(此時舊的會被新的替換掉)。"
	AL["LOG_WINDOW_OPTIONS"] = "紀錄視窗選項"
	AL["LOOT_CATEGORY_FILTERED"] = "為類別/子類別啟用過濾器：%s/%s。您可以再次單擊戰利品圖示或RareScanner插件選單來禁用此過濾器"
	AL["LOOT_CATEGORY_FILTERS"] = "類別過濾"
	AL["LOOT_CATEGORY_FILTERS_DESC"] = "依據戰利品類別過濾"
	AL["LOOT_CATEGORY_NOT_FILTERED"] = "禁用過濾的類別/子類別：%s/%s"
	AL["LOOT_DISPLAY_OPTIONS"] = "顯示選項"
	AL["LOOT_DISPLAY_OPTIONS_DESC"] = "顯示戰利品列的選項"
	AL["LOOT_FILTER_COLLECTED"] = "過濾已收藏的寵物、坐騎以及玩具。"
	AL["LOOT_FILTER_COLLECTED_DESC"] = "啟用以後，只有您尚未收集的坐騎、寵物和玩具才會顯示在戰利品欄上。此過濾器不會影響任何其他類別的戰利品。"
	AL["LOOT_FILTER_NOT_EQUIPABLE"] = "過濾不可裝備物品"
	AL["LOOT_FILTER_NOT_EQUIPABLE_DESC"] = "取消以後，此角色無法裝備的護甲與武器不會出現在戰利品欄上。此過濾器不會影響其他類別任何的戰利品。"
	AL["LOOT_FILTER_NOT_TRANSMOG"] = "只顯示可塑形的護甲與武器"
	AL["LOOT_FILTER_NOT_TRANSMOG_DESC"] = "啟用以後，只有你尚未收集外觀的護甲與武器才會顯示在戰利品欄上。此過濾器不會影響任何其他類別的戰利品。"
	AL["LOOT_FILTER_SUBCATEGORY_DESC"] = "切換是否在戰利品欄上顯示這類戰利品。停用以後，當您找到稀有NPC時不會看見與此類別匹配的任何物品。"
	AL["LOOT_FILTER_SUBCATEGORY_LIST"] = "子類別"
	AL["LOOT_ITEMS_PER_ROW"] = "每行顯示物品的數目"
	AL["LOOT_ITEMS_PER_ROW_DESC"] = "設置戰利品欄上每行顯示的物品數。如果該數字小於要顯示的最大行數。"
	AL["LOOT_MAIN_CATEGORY"] = "主類別"
	AL["LOOT_MAX_ITEMS"] = "要顯示物品的數目"
	AL["LOOT_MAX_ITEMS_DESC"] = "設置戰利品欄上顯示的最大物品數。"
	AL["LOOT_MIN_QUALITY"] = "戰利品最低品質"
	AL["LOOT_MIN_QUALITY_DESC"] = "設定要顯示的戰利品的最低品質"
	AL["LOOT_OPTIONS"] = "戰利品選項"
	AL["LOOT_OTHER_FILTERS"] = "其他過濾器"
	AL["LOOT_OTHER_FILTERS_DESC"] = "其他過濾器"
	AL["LOOT_PANEL_OPTIONS"] = "戰利品選項"
	AL["LOOT_SUBCATEGORY_FILTERS"] = "子類別過濾器"
	AL["LOOT_TOGGLE_FILTER"] = "點擊Alt+滑鼠左鍵以切換過濾"
	AL["LOOT_TOOLTIP_POSITION"] = "戰利品滑鼠提示位置"
	AL["LOOT_TOOLTIP_POSITION_DESC"] = "設定滑鼠指向戰利品圖示時，滑鼠提示出現的位置 (相對於按鈕)。"
	AL["MAIN_BUTTON_OPTIONS"] = "主按鈕選項"
	--[[Translation missing --]]
	AL["MAP_MENU_DISABLE_LAST_SEEN_FILTER"] = "Show rare NPCs that you saw a long time ago but that can respawn"
	AL["MAP_MENU_SHOW_CONTAINERS"] = "在地圖上顯示寶箱圖示"
	AL["MAP_MENU_SHOW_EVENTS"] = "在地圖上顯示事件圖示"
	AL["MAP_MENU_SHOW_NOT_DISCOVERED"] = "未發現的實體"
	AL["MAP_MENU_SHOW_NOT_DISCOVERED_OLD"] = "未發現的實體 (舊資料片)"
	AL["MAP_MENU_SHOW_RARE_NPCS"] = "在地圖上顯示稀有NPC圖示"
	AL["MAP_NEVER"] = "從未"
	AL["MAP_OPTIONS"] = "地圖選項"
	AL["MAP_SCALE_ICONS"] = "圖示大小"
	AL["MAP_SCALE_ICONS_DESC"] = "這將調整地圖上的圖示大小，數值1表示原始大小"
	AL["MAP_SHOW_ICON_AFTER_COLLECTED"] = "拾取後仍保持顯示箱子圖示"
	AL["MAP_SHOW_ICON_AFTER_COLLECTED_DESC"] = "停用以後，在拾取箱子之後圖示將會消失。"
	AL["MAP_SHOW_ICON_AFTER_DEAD"] = "在擊殺後仍然顯示圖示"
	AL["MAP_SHOW_ICON_AFTER_DEAD_DESC"] = "停用後，圖示將在殺死NPC後消失。再次找到NPC後，圖標就會出現。這個選項只適用於在殺死它們後繼續進行追蹤的NPC。"
	AL["MAP_SHOW_ICON_CONTAINER_MAX_SEEN_TIME"] = "隱藏箱子圖示的計時器(以分計)"
	AL["MAP_SHOW_ICON_CONTAINER_MAX_SEEN_TIME_DESC"] = "設置自從你看到箱子以來最大的分鐘數。在此時間之後，再次找到箱子以前，圖示不再顯示在世界地圖上。如果你選擇0分鐘，則不論你看過箱子有多長時間都會顯示圖示，此過濾器不適用於包含於成就的箱子。"
	AL["MAP_SHOW_ICON_MAX_SEEN_TIME"] = "自從你遇見稀有NPC以來的最長時間"
	AL["MAP_SHOW_ICON_MAX_SEEN_TIME_DESC"] = "設置您看過NPC後的最長小時數。 在那之後，圖示將不會顯示在世界地圖上，直到您再次找到NPC。 如果您選擇零小時，則無論您看到稀有NPC以來多長時間，都會顯示圖示。"
	AL["MAP_TOOLTIP_ACHIEVEMENT"] = "這是成就 %s 的一個目標"
	AL["MAP_TOOLTIP_ALREADY_KILLED"] = "此NPC已經擊殺過。重新開始在：%s"
	AL["MAP_TOOLTIP_ALREADY_OPENED"] = "此箱子已經開啟過。重新開始在：%s"
	AL["MAP_TOOLTIP_CONTAINER_LOOTED"] = "Shift-左鍵點擊來設置為已拾取。"
	AL["MAP_TOOLTIP_DAYS"] = "天"
	AL["MAP_TOOLTIP_EVENT_DONE"] = "Shift-左鍵點擊來設置為已完成"
	AL["MAP_TOOLTIP_IGNORE_ICON"] = "Shift-左鍵點擊來永遠隱藏圖示，如果它不該出現在這。"
	AL["MAP_TOOLTIP_KILLED"] = "Shift-左鍵點擊來設置為已擊殺"
	AL["MAP_TOOLTIP_NOT_FOUND"] = "你還沒見過此NPC並且也還沒有人跟你分享。"
	AL["MAP_TOOLTIP_SEEN"] = "多久前見過：%s"
	--[[Translation missing --]]
	AL["MARKER"] = "Target marker"
	--[[Translation missing --]]
	AL["MARKER_DESC"] = "Choose the marker to add on top of the target when you click the main button."
	AL["MESSAGE_OPTIONS"] = "訊息選項"
	AL["MIDDLE_BUTTON"] = "中鍵點擊"
	AL["NOT_TARGETEABLE"] = "無法設為目標"
	AL["NOTE_130350"] = "你必須沿著這個位置右邊的路徑騎上稀有到此箱子。"
	AL["NOTE_131453"] = "你必須騎上[春天守護者-暫譯]到這個位置，這匹馬是友善的稀有怪，通常可在箱子左邊的路徑找到。"
	AL["NOTE_150342"] = "在事件[鑽探機 DR-TR35]進行期間可用"
	AL["NOTE_150394"] = "你需要把他帶到坐標63.38，那裡有一個藍色閃電裝置，當NPC觸碰到閃電時他會爆炸，然後你就可以拾取戰利品。"
	AL["NOTE_151124"] = "你需要在事件[鑽探機 DR-JD99]進行期間（坐標59.67）從小怪身上拾取[砸壞的運輸繼電器]，然後在這個機器上使用"
	AL["NOTE_151202"] = "你需要在岸邊用水里的電線塔連接電線才能召喚他"
	AL["NOTE_151308"] = "在事件[鑽探機]進行期間可用"
	AL["NOTE_151569"] = "你需要一个[百噚誘餌]来召唤他。"
	AL["NOTE_151627"] = "你需要在平台的機器上使用一個[發熱蒸發器線圈]。"
	AL["NOTE_151884"] = "僅在蜜露恩發放日常任務[來自諾達希爾的援助]時有效。該日常要求你在樹底下找蘑菇，當你點擊一個蘑菇時它會停滯，你需要在它消失前再點2個蘑菇，NPC才會出現"
	AL["NOTE_151933"] = "你需要使用[野獸機器人動力包]才能擊殺他（你可以在坐標60.41找到圖紙）"
	AL["NOTE_152007"] = "它會在這個區域遊蕩，所以坐標可能不太精確。"
	AL["NOTE_152113"] = "在事件[鑽探機 DR-CC88]進行期間可用"
	AL["NOTE_152569"] = "你靠近他時他會告訴你一個他討厭的顏色，你要到坐標63.41被染成這個顏色，然後回來找他，他就會攻擊你。"
	AL["NOTE_153000"] = "它會在這個區域遊蕩，所以坐標可能不太精確。"
	AL["NOTE_153200"] = "在事件[鑽探機 DR-JD41]進行期間可用"
	AL["NOTE_153205"] = "在事件[鑽探機 DR-JD99]進行期間可用"
	AL["NOTE_153206"] = "在事件[鑽探機 DR-TR28]進行期間可用"
	AL["NOTE_153228"] = "需要擊殺很多[升級版哨衛]才會在這個區域出現"
	AL["NOTE_154225"] = "需要使用[個人時光轉移裝置]訪問他的接口，這個物品是克羅米發放日常任務[另一個地方]的獎勵品"
	AL["NOTE_154342"] = "需要使用[個人時光轉移裝置]訪問他的接口，這個物品是克羅米發放日常任務[另一個地方]的獎勵品"
	AL["NOTE_154701"] = "在事件[鑽探機 DR-CC61]進行期間可用"
	AL["NOTE_154739"] = "在事件[鑽探機 DR-CC73]進行期間可用"
	AL["NOTE_280951"] = "沿著鐵路走直到你找到推車，然後騎上他來發現財寶。"
	AL["NOTE_287239"] = "如果您是部落，您必須完成沃魯敦活動才能進入神殿。"
	AL["NOTE_289647"] = "財寶在洞穴內。入口位於座標65.11，介於快到山頂的一些樹中間。"
	AL["NOTE_292673"] = "5個卷軸的第1個，閱讀所有卷軸來發現寶藏[深淵的秘密-暫譯]。它位於地下室。閱讀後請手動隱藏此圖示。"
	AL["NOTE_292674"] = "5個卷軸的第2個，閱讀所有卷軸來發現寶藏[深淵的秘密-暫譯]。它位於木地板下，在一堆蠟燭旁邊的角落裡。 閱讀後，請手動隱藏此圖示。"
	AL["NOTE_292675"] = "5個卷軸的第3個，閱讀所有卷軸來發現寶藏[深淵的秘密-暫譯]。它位於地下室。閱讀後請手動隱藏此圖示。"
	AL["NOTE_292676"] = "5個卷軸的第4個，閱讀所有卷軸來發現寶藏[深淵的秘密-暫譯]。它位於頂層。閱讀後請手動隱藏此圖示。"
	AL["NOTE_292677"] = "5個卷軸的第5個，閱讀所有卷軸來發現寶藏[深淵的秘密-暫譯]。它在一個地下洞穴裡。 入口位於坐標72.40處的水下（修道院的水池）。。閱讀後請手動隱藏此圖示。"
	AL["NOTE_292686"] = "閱讀完5個卷軸後，使用[不祥的祭壇]來獲取[深淵的秘密](以上暫譯)。警告：使用祭壇會將你傳送到海中。 使用後，請手動隱藏此圖示。"
	AL["NOTE_293349"] = "它在棚子裡的架子上面。"
	AL["NOTE_293350"] = "這寶藏藏在下面的洞穴裡。 轉到坐標61.38，將視角置於頂部，然後向後跳過地板上的小裂縫並落在窗台上。"
	AL["NOTE_293852"] = "在你從自由港的海盜那拿到[溼透的藏寶圖]之前你不會看到"
	AL["NOTE_293880"] = "在你從自由港的海盜那拿到[褪色的藏寶圖]之前你不會看到"
	AL["NOTE_293881"] = "在你從自由港的海盜那拿到[泛黃的藏寶圖]之前你不會看到"
	AL["NOTE_293884"] = "在你從自由港的海盜那拿到[罪惡的藏寶圖]之前你不會看到"
	AL["NOTE_297828"] = "飛在上面的烏鴉握著鑰匙。 殺了它。"
	AL["NOTE_297891"] = "您必須按以下順序停用符文：左，下，上，右"
	AL["NOTE_297892"] = "您必須按以下順序停用符文：左，右，下，上"
	AL["NOTE_297893"] = "您必須按以下順序停用符文：右，上，左，下"
	AL["NOTE_326395"] = "點擊桌上箱子旁的[秘法裝置]開始小遊戲。需要將三個三角形分開，點擊寶珠交換位置。"
	AL["NOTE_326396"] = "點擊桌上箱子旁的[秘法裝置]開始小遊戲。需要將二個長方形分開，點擊寶珠交換位置。"
	AL["NOTE_326397"] = "點擊桌上箱子旁的[秘法裝置]開始小遊戲。需要將三個紅色的符文連成一線。。"
	AL["NOTE_326398"] = "點擊桌上箱子旁的[秘法裝置]開始小遊戲。需要將四個青色的符文連成一線。。"
	AL["NOTE_326399"] = "在水下的洞裡。你需要完成一個小遊戲，在火球碰到地上到圓圈前射擊他們。當火球碰到地面或者你的技能沒有打到火球時能量會減少，當能量歸零你需要從頭開始遊戲。"
	AL["NOTE_326400"] = "在洞裡。你需要完成一個小遊戲，在火球碰到地上到圓圈前射擊他們。當火球碰到地面或者你的技能沒有打到火球時能量會減少，當能量歸零你需要從頭開始遊戲。"
	AL["NOTE_326403"] = "在建築物內，你需要從建築物後面進入"
	AL["NOTE_326405"] = "在地圖最頂層的一堆廢墟中間"
	AL["NOTE_326406"] = "在地圖最頂層的山頂上，非常難以到達，但是從地圖南邊上去是可行的。"
	AL["NOTE_326407"] = "在地圖最頂層的山頂上"
	AL["NOTE_326408"] = "入口在南方湖面水下的洞裡(坐標57,39)"
	AL["NOTE_326410"] = "在地圖最底層的洞裡"
	AL["NOTE_326411"] = "在地圖最頂層的一堆石頭中間"
	AL["NOTE_326413"] = "在地圖最底層的洞裡"
	AL["NOTE_326415"] = "需要解鎖飛行，或者你可以用[哥布林滑翔工具組]從旁邊的高山頂上滑過去。寶箱在珊瑚橋的頂部。"
	AL["NOTE_326416"] = "在地圖的最高層，廢墟中的塔內"
	AL["NOTE_329783"] = "在坐標83.33的屋頂上。你需要完成一個小遊戲，在火球碰到地上到圓圈前射擊他們。當火球碰到地面或者你的技能沒有打到火球時能量會減少，當能量歸零你需要從頭開始遊戲。"
	AL["NOTE_332220"] = "你需要完成一個小遊戲，在火球碰到地上到圓圈前射擊他們。當火球碰到地面或者你的技能沒有打到火球時能量會減少，當能量歸零你需要從頭開始遊戲。"
	AL["PROFILES"] = "設定檔"
	AL["RAIDS"] = "團隊"
	AL["SHOW_CHAT_ALERT"] = "顯示聊天通知"
	AL["SHOW_CHAT_ALERT_DESC"] = "每當寶藏、寶箱或NPC出現時，在聊天視窗中顯示一則私人訊息。"
	AL["SHOW_RAID_WARNING"] = "切換是否顯示團隊警告"
	AL["SHOW_RAID_WARNING_DESC"] = "每當財寶、箱子或NPC發現的時候顯示團隊警告在螢幕上。"
	AL["SOUND"] = "聲音"
	AL["SOUND_OPTIONS"] = "聲音選項"
	AL["SOUND_VOLUME"] = "音量"
	AL["SOUND_VOLUME_DESC"] = "設置音效的音量等級"
	AL["SYNCRONIZATION_COMPLETED"] = "同步已完成"
	AL["SYNCRONIZE"] = "同步數據"
	AL["SYNCRONIZE_DESC"] = "這會分析哪些是成就要求的一部分的稀有NPC和寶箱已經被你擊殺或打開，他們會從你的地圖中移除。插件無法得知不在成就追蹤中的稀有NPC和寶箱的擊殺狀態，他們還會保留在地圖上。"
	AL["TEST"] = "開始測試"
	AL["TEST_DESC"] = "按下按鈕以顯示通知範例，將面板拖曳到你想要擺放的合適位置。"
	AL["TOC_NOTES"] = "小地圖掃描器。當稀有NPC、寶藏/寶箱或事件出現在您的小地圖上時，使用一個按鈕與縮小的模型用視覺化的方式提醒您並播放聲音。"
	AL["TOGGLE_FILTERS"] = "切換過濾器"
	AL["TOGGLE_FILTERS_DESC"] = "一次切換所有過濾器"
	AL["TOOLTIP_BOTTOM"] = "下方"
	AL["TOOLTIP_CURSOR"] = "跟隨游標"
	AL["TOOLTIP_LEFT"] = "左側"
	AL["TOOLTIP_RIGHT"] = "右側"
	AL["TOOLTIP_TOP"] = "上方"
	AL["UNKNOWN"] = "未知"
	AL["UNKNOWN_TARGET"] = "未知目標"
	AL["ZONES_FILTER"] = "過濾區域"
	AL["ZONES_FILTERS_SEARCH_DESC"] = "輸入區域名稱來過濾下方的清單"
	
	-- CONTINENT names
	AL["ZONES_CONTINENT_LIST"] = {
		[9999] = "職業大廳"; --Class Halls
		[9998] = "暗月島"; --Darkmoon Island
		[9997] = "地城/事件"; --Dungeons/Scenarios
		[9996] = "團隊"; --Raids
		[9995] = "未知"; --Unknown
	}
end