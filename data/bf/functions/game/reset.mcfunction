scoreboard players set Game bf_gamestate 0

# 1. 玩家重置
clear @a
effect clear @a
xp set @a 0 levels
xp set @a 0 points
effect give @a minecraft:instant_health 1 255 true
effect give @a minecraft:saturation 1 255 true
gamemode survival @a
scoreboard players set @a bf_deaths 0
scoreboard players set @a bf_cam_timer 0
tag @a remove in_lobby
tag @a remove in_enemy_base
tag @a remove bf_has_pointer
tag @a remove deploying
tag @a remove deploy_failed
tag @a remove looking_for_target
tag @a remove preview_failed
tag @a remove bf_in_killcam
tag @a remove bf_on_squad_page

# 2. 數值 & 旗幟重置
function bf:utils/reset_tickets_and_flags
scoreboard players set Global bf_timer 0
scoreboard players set @a bf_base_warn 0
scoreboard players set @a bf_cd 0

# 4. 清除殘留的導航箭頭
kill @e[type=text_display,tag=bf_pointer]

title @a title {"text":"地圖已重置","color":"yellow"}
tellraw @a {"text":"[系統] 準備就緒。","color":"gray"}
