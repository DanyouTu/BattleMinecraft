# ==========================================
# --- 死亡循環系統 (智慧防刷屏版 + Killcam) ---
# ==========================================

# 1. 偵測剛死亡的玩家 -> 觸發死亡處理
execute as @a[scores={bf_deaths=1..}] run function bf:mechanics/death_trigger

# 2. 觀戰倒數計時
scoreboard players remove @a[scores={bf_cam_timer=1..}] bf_cam_timer 1

# 3. Killcam 結束 -> 解除旁觀殺手，轉入大廳等待
#    cam_timer 從 160 開始，到 100 時 killcam 結束 (60 tick = 3秒)
execute as @a[scores={bf_cam_timer=100},tag=bf_in_killcam,tag=!in_lobby] run function bf:mechanics/killcam/end_spectate

# 4. 時間到 -> 強制回到大廳
execute as @a[scores={bf_cam_timer=1},tag=!in_lobby] run function bf:mechanics/return_lobby

# ==========================================
# ★ 智慧刷新選單 (Smart Refresh)
# ==========================================

# 當據點歸屬變更時 (#menu_refresh=1)，刷新所有等待部署的玩家選單
# 包含已在大廳的玩家 + 死亡倒數中（非 killcam）的玩家
execute if score #menu_refresh bf_temp matches 1 as @a[tag=in_lobby] run function bf:mechanics/menu/page_points
execute if score #menu_refresh bf_temp matches 1 as @a[scores={bf_cam_timer=1..},tag=!in_lobby,tag=!bf_in_killcam] run function bf:mechanics/menu/page_points

# (注意：我們不在這裡把 #menu_refresh 歸零，因為要讓所有玩家都跑完，我們去 tick 歸零)
