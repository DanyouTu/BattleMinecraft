# --- 紅隊基地 ---
execute as @e[type=armor_stand,tag=bf_base_red_item] run tag @s add bf_base_red
execute as @e[type=armor_stand,tag=bf_base_red_item] run tag @s add bf_spawn_point
execute as @e[type=armor_stand,tag=bf_base_red_item] run scoreboard players set @s bf_owner 1
execute as @e[tag=bf_base_red_item] run scoreboard players set @s bf_p_id 1
# 設定名字
execute as @e[type=armor_stand,tag=bf_base_red_item] run data merge entity @s {Invisible:1b,Marker:1b,NoGravity:1b,CustomNameVisible:0b,CustomName:'{"text":"紅隊總部","color":"red"}'}
# 生成鏡頭
execute at @e[type=armor_stand,tag=bf_base_red_item] run summon armor_stand ~ ~ ~ {Tags:["bf_cam_anchor","bf_cam_red_base"],Invisible:1b,Marker:1b,NoGravity:1b}
execute as @e[type=armor_stand,tag=bf_base_red_item] run tag @s remove bf_base_red_item

# --- 藍隊基地 ---
execute as @e[type=armor_stand,tag=bf_base_blue_item] run tag @s add bf_base_blue
execute as @e[type=armor_stand,tag=bf_base_blue_item] run tag @s add bf_spawn_point
execute as @e[type=armor_stand,tag=bf_base_blue_item] run scoreboard players set @s bf_owner 2
execute as @e[tag=bf_base_blue_item] run scoreboard players set @s bf_p_id 2
# 設定名字
execute as @e[type=armor_stand,tag=bf_base_blue_item] run data merge entity @s {Invisible:1b,Marker:1b,NoGravity:1b,CustomNameVisible:0b,CustomName:'{"text":"藍隊總部","color":"blue"}'}
# 生成鏡頭
execute at @e[type=armor_stand,tag=bf_base_blue_item] run summon armor_stand ~ ~ ~ {Tags:["bf_cam_anchor","bf_cam_blue_base"],Invisible:1b,Marker:1b,NoGravity:1b}
execute as @e[type=armor_stand,tag=bf_base_blue_item] run tag @s remove bf_base_blue_item