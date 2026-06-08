# --- Killcam: 開始旁觀殺手 (runs AS victim) ---

# 1. 檢查是否有記錄殺手 (bf_last_hit_by > 0)
execute unless score @s bf_last_hit_by matches 1.. run return 0

# 2. 找到 bf_pid 等於我的 bf_last_hit_by 的玩家
scoreboard players operation #find_killer bf_temp = @s bf_last_hit_by
tag @s add bf_finding_killer
execute as @a[tag=!bf_finding_killer] if score @s bf_pid = #find_killer bf_temp run tag @s add bf_my_killer

# 3. 旁觀殺手
execute if entity @a[tag=bf_my_killer] run spectate @a[tag=bf_my_killer,limit=1]
execute if entity @a[tag=bf_my_killer] run tag @s add bf_in_killcam
execute if entity @a[tag=bf_my_killer] run title @s actionbar [{"text":"✦ 擊殺者鏡頭 ","color":"red","bold":true},{"selector":"@a[tag=bf_my_killer,limit=1]","color":"yellow"}]

# 4. 清理
tag @a remove bf_my_killer
tag @s remove bf_finding_killer
scoreboard players set @s bf_last_hit_by 0
