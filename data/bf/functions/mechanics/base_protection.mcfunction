# ==========================================
# --- 基地保護邏輯 (小數點精準倒數版) ---
# ==========================================

# 1. 先無條件移除所有人的標籤 (防詐屍保險)
tag @a remove in_enemy_base

# 2. 偵測玩家是否在敵方基地禁區 (半徑 25 格，無視高度的 50x50 方形柱體)
execute as @e[tag=bf_base_blue] at @s positioned ~-25 -64 ~-25 as @a[team=Red,dx=50,dy=400,dz=50,gamemode=survival] run tag @s add in_enemy_base
execute as @e[tag=bf_base_red] at @s positioned ~-25 -64 ~-25 as @a[team=Blue,dx=50,dy=400,dz=50,gamemode=survival] run tag @s add in_enemy_base

# 3. 倒數計時與重置
# (A) 在禁區內的人：累加計時 (1秒 = 20 ticks)
scoreboard players add @a[tag=in_enemy_base] bf_base_warn 1
# (B) 不在禁區內的人：立刻歸零
scoreboard players set @a[tag=!in_enemy_base] bf_base_warn 0


# ==========================================
# 4. 視覺警告與運算系統
# ==========================================

execute as @a[tag=in_enemy_base] run effect give @s minecraft:darkness 2 0 true

# --- 階段一：純警告 (前 3 秒 / 1~60 ticks) ---
execute as @a[tag=in_enemy_base,scores={bf_base_warn=1..60}] run title @s actionbar {"text":"⚠ 警告：進入敵方戰區！請立即撤離！","color":"red","bold":true}


# --- 階段二：小數點精準倒數 (後 10 秒 / 101~300 ticks) ---

# 設定除法用的常數 (利用 bf_temp)
scoreboard players set #20 bf_temp 20
scoreboard players set #2 bf_temp 2

# [運算1] 算出剩餘總 Ticks：260 - 目前經過時間
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run scoreboard players set @s bf_warn_s 260
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run scoreboard players operation @s bf_warn_s -= @s bf_base_warn

# [運算2] 算出小數點 (0~9)：剩餘Ticks除以20的餘數，再除以2
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run scoreboard players operation @s bf_warn_d = @s bf_warn_s
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run scoreboard players operation @s bf_warn_d %= #20 bf_temp
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run scoreboard players operation @s bf_warn_d /= #2 bf_temp

# [運算3] 算出整數秒：剩餘Ticks除以20
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run scoreboard players operation @s bf_warn_s /= #20 bf_temp

# [顯示] 將算出來的「秒(bf_warn_s)」和「小數(bf_warn_d)」組合顯示
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61..260}] run title @s actionbar ["",{"text":"⚠ 倒數 ","color":"dark_red","bold":true},{"score":{"name":"@s","objective":"bf_warn_s"},"color":"red","bold":true},{"text":".","color":"red","bold":true},{"score":{"name":"@s","objective":"bf_warn_d"},"color":"red","bold":true},{"text":" 秒後強制死亡...","color":"dark_red","bold":true}]


# ==========================================
# 5. 播放警報聲 (保持節奏不變)
# ==========================================

# 階段一：平穩的警報音 (每秒一聲)
execute as @a[tag=in_enemy_base,scores={bf_base_warn=1}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.5
execute as @a[tag=in_enemy_base,scores={bf_base_warn=21}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.5
execute as @a[tag=in_enemy_base,scores={bf_base_warn=41}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.5

# 階段二：越來越急促高昂的警報音 (每秒一聲，音調爬升)
execute as @a[tag=in_enemy_base,scores={bf_base_warn=61}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.6
execute as @a[tag=in_enemy_base,scores={bf_base_warn=81}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.7
execute as @a[tag=in_enemy_base,scores={bf_base_warn=101}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.8
execute as @a[tag=in_enemy_base,scores={bf_base_warn=121}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 0.9
execute as @a[tag=in_enemy_base,scores={bf_base_warn=141}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 1.0
execute as @a[tag=in_enemy_base,scores={bf_base_warn=161}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 1.1
execute as @a[tag=in_enemy_base,scores={bf_base_warn=181}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 1.2
execute as @a[tag=in_enemy_base,scores={bf_base_warn=201}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 1.3
execute as @a[tag=in_enemy_base,scores={bf_base_warn=221}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 1.4
execute as @a[tag=in_enemy_base,scores={bf_base_warn=241}] run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 1 1.5


# ==========================================
# 6. 處決 (滿 260 ticks 即 13 秒)
# ==========================================
execute as @a[tag=in_enemy_base,scores={bf_base_warn=260..}] run damage @s 1000 minecraft:out_of_world