scoreboard players set @s bf_click 0
# 初始化角落
execute as @e[type=armor_stand,tag=bf_corner_a_item] run tag @s add bf_corner_a
execute as @e[type=armor_stand,tag=bf_corner_b_item] run tag @s add bf_corner_b
execute as @e[tag=bf_corner_a_item] run data merge entity @s {Invisible:1b,Marker:1b,NoGravity:1b,CustomNameVisible:1b,CustomName:'{"text":"[邊界 A]","color":"green"}'}
execute as @e[tag=bf_corner_b_item] run data merge entity @s {Invisible:1b,Marker:1b,NoGravity:1b,CustomNameVisible:1b,CustomName:'{"text":"[邊界 B]","color":"aqua"}'}
tag @e remove bf_corner_a_item
tag @e remove bf_corner_b_item

# 獲取座標
execute as @e[tag=bf_corner_a,limit=1] store result score TempAX bf_coord run data get entity @s Pos[0]
execute as @e[tag=bf_corner_a,limit=1] store result score TempAZ bf_coord run data get entity @s Pos[2]
execute as @e[tag=bf_corner_b,limit=1] store result score TempBX bf_coord run data get entity @s Pos[0]
execute as @e[tag=bf_corner_b,limit=1] store result score TempBZ bf_coord run data get entity @s Pos[2]

# 比大小 (X)
execute if score TempAX bf_coord > TempBX bf_coord run scoreboard players operation BoundMaxX bf_coord = TempAX bf_coord
execute if score TempAX bf_coord > TempBX bf_coord run scoreboard players operation BoundMinX bf_coord = TempBX bf_coord
execute if score TempAX bf_coord <= TempBX bf_coord run scoreboard players operation BoundMaxX bf_coord = TempBX bf_coord
execute if score TempAX bf_coord <= TempBX bf_coord run scoreboard players operation BoundMinX bf_coord = TempAX bf_coord
# 比大小 (Z)
execute if score TempAZ bf_coord > TempBZ bf_coord run scoreboard players operation BoundMaxZ bf_coord = TempAZ bf_coord
execute if score TempAZ bf_coord > TempBZ bf_coord run scoreboard players operation BoundMinZ bf_coord = TempBZ bf_coord
execute if score TempAZ bf_coord <= TempBZ bf_coord run scoreboard players operation BoundMaxZ bf_coord = TempBZ bf_coord
execute if score TempAZ bf_coord <= TempBZ bf_coord run scoreboard players operation BoundMinZ bf_coord = TempAZ bf_coord

# ... (上面是原本的比大小邏輯)

# ==========================================
# ★ 新增：計算並生成地圖中心點 (用於安全區導航)
# ==========================================

# 1. 清除舊的中心點
kill @e[tag=bf_map_center]

# 2. 準備常數 (用於除法)
scoreboard players set #CONST_2 bf_coord 2

# 3. 計算中心 X = (MinX + MaxX) / 2
scoreboard players operation #Center_X bf_coord = BoundMinX bf_coord
scoreboard players operation #Center_X bf_coord += BoundMaxX bf_coord
scoreboard players operation #Center_X bf_coord /= #CONST_2 bf_coord

# 4. 計算中心 Z = (MinZ + MaxZ) / 2
scoreboard players operation #Center_Z bf_coord = BoundMinZ bf_coord
scoreboard players operation #Center_Z bf_coord += BoundMaxZ bf_coord
scoreboard players operation #Center_Z bf_coord /= #CONST_2 bf_coord

# 5. 生成中心標記 (先生成在玩家位置，再傳送到計算出的座標)
summon armor_stand ~ ~ ~ {Tags:["bf_map_center"],Marker:1b,Invisible:1b,NoGravity:1b}
execute store result entity @e[tag=bf_map_center,limit=1] Pos[0] double 1 run scoreboard players get #Center_X bf_coord
execute store result entity @e[tag=bf_map_center,limit=1] Pos[2] double 1 run scoreboard players get #Center_Z bf_coord
# 把高度設為跟邊界A一樣 (或者固定高度)，避免掉入虛空
execute as @e[tag=bf_corner_a,limit=1] store result entity @e[tag=bf_map_center,limit=1] Pos[1] double 1 run data get entity @s Pos[1]

# ... (接原本的 playsound 和 tellraw)

playsound minecraft:block.note_block.pling master @a ~ ~ ~ 1 2
tellraw @a {"text":"[BF System] 矩形邊界已更新！","color":"green"}