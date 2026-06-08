# 1. 將自己的小隊號碼存入暫存 (bf_temp)
scoreboard players operation #my_squad bf_temp = @s bf_squad
tag @a remove is_teammate

# 2. 【防間諜機制】只標記同隊伍、且同小隊的人
execute if entity @s[team=Red] as @a[team=Red] if score @s bf_squad = #my_squad bf_temp run tag @s add is_teammate
execute if entity @s[team=Blue] as @a[team=Blue] if score @s bf_squad = #my_squad bf_temp run tag @s add is_teammate

# 排除自己 (你不可以部署在自己身上)
tag @s remove is_teammate

# 3. 給這最多 3 位隊友隨機分配 Slot 1~3
tag @a remove sq_slot_1
tag @a remove sq_slot_2
tag @a remove sq_slot_3
execute as @a[tag=is_teammate,limit=1,sort=random] run tag @s add sq_slot_1
execute as @a[tag=is_teammate,tag=!sq_slot_1,limit=1,sort=random] run tag @s add sq_slot_2
execute as @a[tag=is_teammate,tag=!sq_slot_1,tag=!sq_slot_2,limit=1,sort=random] run tag @s add sq_slot_3

# 4. 列印隊友名單
# --- Slot 1 ---
execute if entity @a[tag=sq_slot_1,gamemode=survival] run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@a[tag=sq_slot_1]"},{"text":" (存活) ","color":"green"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_sq_prev set 1"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_sq_dep set 1"}}]
execute if entity @a[tag=sq_slot_1,gamemode=!survival] run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@a[tag=sq_slot_1]"},{"text":" (陣亡/交戰中) ","color":"red"}]

# --- Slot 2 ---
execute if entity @a[tag=sq_slot_2,gamemode=survival] run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@a[tag=sq_slot_2]"},{"text":" (存活) ","color":"green"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_sq_prev set 2"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_sq_dep set 2"}}]
execute if entity @a[tag=sq_slot_2,gamemode=!survival] run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@a[tag=sq_slot_2]"},{"text":" (陣亡/交戰中) ","color":"red"}]

# --- Slot 3 ---
execute if entity @a[tag=sq_slot_3,gamemode=survival] run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@a[tag=sq_slot_3]"},{"text":" (存活) ","color":"green"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_sq_prev set 3"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_sq_dep set 3"}}]
execute if entity @a[tag=sq_slot_3,gamemode=!survival] run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@a[tag=sq_slot_3]"},{"text":" (陣亡/交戰中) ","color":"red"}]
