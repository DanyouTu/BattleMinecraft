# 暫存想加入的 ID
scoreboard players operation #target_sq bf_temp = @s bf_join_sq

# 再次計算該小隊人數
scoreboard players set #total bf_sq_count 0
execute if entity @s[team=Red] as @a[team=Red] if score @s bf_squad = #target_sq bf_temp run scoreboard players add #total bf_sq_count 1
execute if entity @s[team=Blue] as @a[team=Blue] if score @s bf_squad = #target_sq bf_temp run scoreboard players add #total bf_sq_count 1

# 如果沒滿，成功加入
execute if score #total bf_sq_count matches ..3 run scoreboard players operation @s bf_squad = @s bf_join_sq
execute if score #total bf_sq_count matches ..3 run title @s actionbar {"text":"成功加入小隊！","color":"green"}

# 如果滿了，提示失敗
execute if score #total bf_sq_count matches 4.. run title @s actionbar {"text":"加入失敗：小隊已滿！","color":"red"}
