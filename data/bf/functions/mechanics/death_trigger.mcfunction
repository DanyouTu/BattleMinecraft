# --- 死亡觸發 (穩定版) ---
# 1. 重置死亡計數 (防止重複觸發)
execute as @s[scores={bf_deaths=1..}, team=Red] if score Game bf_gamestate matches 1 run scoreboard players remove Red bf_tickets 1
execute as @s[scores={bf_deaths=1..}, team=Blue] if score Game bf_gamestate matches 1 run scoreboard players remove Blue bf_tickets 1
scoreboard players set @s bf_deaths 0

# 2. 切換模式
gamemode spectator @s

# 3. 設定觀戰倒數計時 (例如 100 tick = 5秒)
scoreboard players set @s bf_cam_timer 100

# 4. 訊息與音效
title @s title {"text":"你已死亡","color":"red","bold":true}
title @s subtitle {"text":"準備重新部署","color":"yellow"}

# 5. 確保清除身上殘留狀態
effect clear @s