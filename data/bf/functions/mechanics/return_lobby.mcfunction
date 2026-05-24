# --- 2. 初始鏡頭 ---
# 優先吸附到自家基地
# execute if entity @s[team=Red] run spectate @e[tag=bf_cam_red_base,limit=1]
# execute if entity @s[team=Blue] run spectate @e[tag=bf_cam_blue_base,limit=1]


# 1. 重置死亡分數
scoreboard players set @s bf_deaths 0
scoreboard players set @s bf_cam_timer 0
scoreboard players set @s bf_cd 0

# 2. 設定狀態
gamemode spectator @s
tag @s add in_lobby

# 4. 呼叫選單
function bf:mechanics/menu/print_menu