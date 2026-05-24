# --- 1. 視覺化邊界 (創造模式才看得到) ---
execute as @a[gamemode=creative] at @e[tag=bf_corner_a] run particle dust 0 1 0 1 ~ ~1 ~ 0 1 0 0 5
execute as @a[gamemode=creative] at @e[tag=bf_corner_b] run particle dust 0 1 1 1 ~ ~1 ~ 0 1 0 0 5

# --- 2. 玩家座標獲取 ---
execute as @a[gamemode=survival] store result score @s bf_coord run data get entity @s Pos[0]
execute as @a[gamemode=survival] store result score @s bf_temp run data get entity @s Pos[2]

# --- 3. 初始化：分配專用的 UI ID ---
execute as @a unless score @s bf_ui_id = @s bf_ui_id run scoreboard players add #global_ui_id bf_temp 1
execute as @a unless score @s bf_ui_id = @s bf_ui_id run scoreboard players operation @s bf_ui_id = #global_ui_id bf_temp

# --- 4. 安全判定邏輯 ---
tag @a[gamemode=survival] add IsSafe
execute as @a[gamemode=survival] if score @s bf_coord < BoundMinX bf_coord run tag @s remove IsSafe
execute as @a[gamemode=survival] if score @s bf_coord > BoundMaxX bf_coord run tag @s remove IsSafe
execute as @a[gamemode=survival] if score @s bf_temp < BoundMinZ bf_coord run tag @s remove IsSafe
execute as @a[gamemode=survival] if score @s bf_temp > BoundMaxZ bf_coord run tag @s remove IsSafe

# ==========================================
# ★ 實體化導航箭頭 (Text Display 版) - 修正大小
# ==========================================

# 1. 生成箭頭 (如果玩家出界 + 沒箭頭)
# 修正點：scale 改為 [2f, 2f, 2f] (原本是 8)
execute as @a[gamemode=survival,tag=!IsSafe,nbt=!{Health:0.0f},tag=!bf_has_pointer] at @s run summon text_display ~ ~ ~ {Tags:["bf_pointer"],text:'{"text":"▲","color":"red","bold":true}',background:0,billboard:"fixed",teleport_duration:0,transformation:{left_rotation:[-0.707f,0f,0f,0.707f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[2f,2f,2f]}}

# 綁定 ID
execute as @a[gamemode=survival,tag=!IsSafe,tag=!bf_has_pointer] at @s run scoreboard players operation @e[type=text_display,tag=bf_pointer,distance=..2,limit=1,sort=nearest] bf_ui_id = @s bf_ui_id

# 標記玩家有箭頭
execute as @a[gamemode=survival,tag=!IsSafe,tag=!bf_has_pointer] run tag @s add bf_has_pointer

# 更新位置
execute as @a[gamemode=survival,tag=!IsSafe,tag=bf_has_pointer,nbt=!{Health:0.0f}] run function bf:mechanics/update_pointer


# 2. 自動清理機制 (Garbage Collection)
tag @e[type=text_display,tag=bf_pointer] add bf_garbage
execute as @a[gamemode=survival,tag=!IsSafe,nbt=!{Health:0.0f}] run scoreboard players operation #temp_gc_id bf_temp = @s bf_ui_id
execute as @a[gamemode=survival,tag=!IsSafe,nbt=!{Health:0.0f}] run execute as @e[type=text_display,tag=bf_pointer] if score @s bf_ui_id = #temp_gc_id bf_temp run tag @s remove bf_garbage
kill @e[type=text_display,tag=bf_pointer,tag=bf_garbage]
tag @a[tag=IsSafe] remove bf_has_pointer
tag @a[nbt={Health:0.0f}] remove bf_has_pointer


# 3. 懲罰與警告
execute as @a[gamemode=survival,tag=!IsSafe,nbt=!{Health:0.0f}] if score Game bf_gamestate matches 1 run title @s actionbar {"text":"⚠ 警告！返回戰場範圍！(F5查看方向)","color":"red","bold":true}
execute as @a[gamemode=survival,tag=!IsSafe,nbt=!{Health:0.0f}] if score Game bf_gamestate matches 1 run effect give @s minecraft:wither 1 1 true
execute as @a[gamemode=survival,tag=!IsSafe,nbt=!{Health:0.0f}] if score Game bf_gamestate matches 1 run playsound minecraft:block.note_block.didgeridoo master @s ~ ~ ~ 1 0.5