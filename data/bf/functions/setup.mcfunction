# --- 遊戲規則設定  ---
# 開啟立即重生 (跳過死亡畫面)
gamerule doImmediateRespawn true
# 關閉重生提示
gamerule showDeathMessages true
gamerule keepInventory true
gamerule commandBlockOutput false
gamerule sendCommandFeedback false

# --- 2. 核心記分板 ---
scoreboard objectives add bf_tickets dummy "兵力值"
scoreboard objectives add bf_capture dummy "佔領進度"
scoreboard objectives add bf_owner dummy "歸屬權"
scoreboard objectives add bf_timer dummy "計時器"
scoreboard objectives add bf_deaths deathCount "死亡數"
scoreboard objectives add bf_cam_timer dummy "觀戰計時"
scoreboard objectives add bf_click minecraft.used:minecraft.carrot_on_a_stick "點擊偵測"
scoreboard objectives add bf_temp dummy "臨時變數"
scoreboard objectives add bf_cd dummy
scoreboard objectives add bf_p_id dummy
scoreboard objectives add bf_ui_id dummy
scoreboard objectives add bf_gamestate dummy "遊戲狀態"
scoreboard objectives add bf_base_warn dummy "禁區警告計時"
scoreboard objectives add bf_warn_s dummy "禁區警告(秒)"
scoreboard objectives add bf_warn_d dummy "禁區警告(毫秒)"

# 遊戲狀態(0=未開始, 1=進行中, 2=結束)
scoreboard players set Game bf_gamestate 0

# Trigger 用於讓無OP玩家點擊聊天欄
scoreboard objectives add bf_click_id trigger
scoreboard objectives add bf_click_act trigger
scoreboard objectives add bf_class trigger "職業"

# --- 3. 邊界座標變數 ---
scoreboard objectives add bf_coord dummy "座標運算"
scoreboard players set BoundMinX bf_coord -100
scoreboard players set BoundMaxX bf_coord 100
scoreboard players set BoundMinZ bf_coord -100
scoreboard players set BoundMaxZ bf_coord 100

# --- 4. 隊伍設置 ---
team add Red "紅隊"
team modify Red color red
team modify Red friendlyFire false
team modify Red seeFriendlyInvisibles false

team add Blue "藍隊"
team modify Blue color blue
team modify Blue friendlyFire false
team modify Blue seeFriendlyInvisibles false

# --- 5. Bossbar ---
bossbar add bf:red_tickets "紅隊兵力"
bossbar set bf:red_tickets color red
bossbar set bf:red_tickets style notched_10
bossbar set bf:red_tickets max 1000
bossbar set bf:red_tickets players @a

bossbar add bf:blue_tickets "藍隊兵力"
bossbar set bf:blue_tickets color blue
bossbar set bf:blue_tickets style notched_10
bossbar set bf:blue_tickets max 1000
bossbar set bf:blue_tickets players @a

tellraw @a {"text":"[System] 系統已載入。","color":"green"}