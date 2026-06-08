# 傳送到隊友身邊
execute if score @s bf_sq_dep matches 1 if entity @a[tag=sq_slot_1,gamemode=survival,limit=1] run tp @s @a[tag=sq_slot_1,limit=1]
execute if score @s bf_sq_dep matches 1 if entity @a[tag=sq_slot_1,gamemode=survival,limit=1] run tag @s add deploying

execute if score @s bf_sq_dep matches 2 if entity @a[tag=sq_slot_2,gamemode=survival,limit=1] run tp @s @a[tag=sq_slot_2,limit=1]
execute if score @s bf_sq_dep matches 2 if entity @a[tag=sq_slot_2,gamemode=survival,limit=1] run tag @s add deploying

execute if score @s bf_sq_dep matches 3 if entity @a[tag=sq_slot_3,gamemode=survival,limit=1] run tp @s @a[tag=sq_slot_3,limit=1]
execute if score @s bf_sq_dep matches 3 if entity @a[tag=sq_slot_3,gamemode=survival,limit=1] run tag @s add deploying

# --- 如果部署失敗 (隊友不存活)，通知玩家 ---
execute unless entity @s[tag=deploying] run tellraw @s {"text":"[錯誤] 無法部署：該隊友已陣亡或不在戰場上。","color":"red"}
execute unless entity @s[tag=deploying] run scoreboard players set @s bf_sq_dep 0
execute unless entity @s[tag=deploying] run return 0

# --- 執行重生手續 (共用部署流程) ---
execute as @s[tag=deploying] run spectate
execute as @s[tag=deploying] run function bf:utils/deploy_player
execute as @s[tag=deploying] run title @s actionbar {"text":"已部署至小隊！","color":"green","bold":true}

# 收尾
tag @s remove deploying
scoreboard players set @s bf_sq_dep 0
