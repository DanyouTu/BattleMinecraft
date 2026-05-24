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

# 2. 數值重置
scoreboard players set Red bf_tickets 1000
scoreboard players set Blue bf_tickets 1000

# 3. 旗幟重置
execute as @e[tag=bf_flag] run scoreboard players set @s bf_capture 0
execute as @e[tag=bf_flag] run scoreboard players set @s bf_owner 0
execute as @e[tag=bf_flag] run item replace entity @s armor.head with white_wool

title @a title {"text":"地圖已重置","color":"yellow"}
tellraw @a {"text":"[系統] 準備就緒。","color":"gray"}