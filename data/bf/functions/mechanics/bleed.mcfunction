scoreboard players add Global bf_timer 1
execute if score Global bf_timer matches 20.. run scoreboard players set Global bf_timer 0
execute unless score Global bf_timer matches 0 run return 0

# 統計
scoreboard players set RedCount bf_temp 0
scoreboard players set BlueCount bf_temp 0
execute as @e[tag=bf_flag,scores={bf_owner=1}] run scoreboard players add RedCount bf_temp 1
execute as @e[tag=bf_flag,scores={bf_owner=2}] run scoreboard players add BlueCount bf_temp 1

# 扣分
execute if score Game bf_gamestate matches 1 if score RedCount bf_temp > BlueCount bf_temp run scoreboard players remove Blue bf_tickets 2
execute if score Game bf_gamestate matches 1 if score BlueCount bf_temp > RedCount bf_temp run scoreboard players remove Red bf_tickets 2