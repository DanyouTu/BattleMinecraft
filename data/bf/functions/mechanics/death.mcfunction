# ==========================================
# --- 死亡循環系統 (智慧防刷屏版) ---
# ==========================================

# 1. 偵測剛死亡的玩家 -> 觸發死亡處理
execute as @a[scores={bf_deaths=1..}] run function bf:mechanics/death_trigger

# 2. 觀戰倒數計時
scoreboard players remove @a[scores={bf_cam_timer=1..}] bf_cam_timer 1

# 3. 時間到 -> 強制回到大廳
execute as @a[scores={bf_cam_timer=1},tag=!in_lobby] run function bf:mechanics/return_lobby

# ==========================================
# ★ 新增：智慧刷新選單 (Smart Refresh)
# ==========================================

# 只有當全域變數 #menu_refresh 為 1 時 (代表場上有據點變色了)
# 才對所有 "死亡中" 且 "不在大廳" 的玩家執行選單重繪
# 這樣平時聊天室會很乾淨，只有戰況改變時才會跳動
execute if score #menu_refresh bf_temp matches 1 as @a[scores={bf_cam_timer=1..},tag=!in_lobby] run function bf:mechanics/menu/print_menu

# (注意：我們不在這裡把 #menu_refresh 歸零，因為要讓所有玩家都跑完，我們去 tick 歸零)