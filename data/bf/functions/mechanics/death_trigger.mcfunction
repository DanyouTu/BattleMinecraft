# --- 死亡觸發 (穩定版 + Killcam) ---
# 1. 重置死亡計數 (防止重複觸發)
execute as @s[scores={bf_deaths=1..}, team=Red] if score Game bf_gamestate matches 1 run scoreboard players remove Red bf_tickets 1
execute as @s[scores={bf_deaths=1..}, team=Blue] if score Game bf_gamestate matches 1 run scoreboard players remove Blue bf_tickets 1
scoreboard players set @s bf_deaths 0

# 2. 切換模式
gamemode spectator @s

# 3. 確保清除身上殘留狀態
effect clear @s

# 4. Killcam: 旁觀殺手 (如果有記錄)
function bf:mechanics/killcam/start_spectate

# 5. 設定觀戰倒數計時
#    killcam 階段 = 60 tick (3秒看殺手)，之後轉入大廳
scoreboard players set @s bf_cam_timer 160

# 6. 訊息與音效
title @s title {"text":"你已死亡","color":"red","bold":true}
title @s subtitle {"text":"準備重新部署","color":"yellow"}
