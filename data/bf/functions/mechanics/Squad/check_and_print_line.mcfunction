# 1. 歸零計數
scoreboard players set #total bf_sq_count 0

# 2. 統計跟「點擊者」同隊伍，且在該小隊編號的人數
execute if entity @s[team=Red] as @a[team=Red] if score @s bf_squad = #current_id bf_temp run scoreboard players add #total bf_sq_count 1
execute if entity @s[team=Blue] as @a[team=Blue] if score @s bf_squad = #current_id bf_temp run scoreboard players add #total bf_sq_count 1

# 3. 印出按鈕 (針對 1~4 號小隊，直接寫死對應的數值！)
execute if score #current_id bf_temp matches 1 if score #total bf_sq_count matches ..3 run tellraw @s ["",{"text":" ▶ 小隊 #1 - ","color":"gray"},{"text":"[點我加入] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_sq set 1"}},{"text":"(","color":"gray"},{"score":{"name":"#total","objective":"bf_sq_count"}},{"text":"/4)","color":"gray"}]
execute if score #current_id bf_temp matches 2 if score #total bf_sq_count matches ..3 run tellraw @s ["",{"text":" ▶ 小隊 #2 - ","color":"gray"},{"text":"[點我加入] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_sq set 2"}},{"text":"(","color":"gray"},{"score":{"name":"#total","objective":"bf_sq_count"}},{"text":"/4)","color":"gray"}]
execute if score #current_id bf_temp matches 3 if score #total bf_sq_count matches ..3 run tellraw @s ["",{"text":" ▶ 小隊 #3 - ","color":"gray"},{"text":"[點我加入] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_sq set 3"}},{"text":"(","color":"gray"},{"score":{"name":"#total","objective":"bf_sq_count"}},{"text":"/4)","color":"gray"}]
execute if score #current_id bf_temp matches 4 if score #total bf_sq_count matches ..3 run tellraw @s ["",{"text":" ▶ 小隊 #4 - ","color":"gray"},{"text":"[點我加入] ","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_sq set 4"}},{"text":"(","color":"gray"},{"score":{"name":"#total","objective":"bf_sq_count"}},{"text":"/4)","color":"gray"}]

# 4. 印出按鈕 (如果已滿，就不用寫點擊事件，直接抓 #current_id 印出來即可)
execute if score #total bf_sq_count matches 4.. run tellraw @s ["",{"text":" ▶ 小隊 #","color":"gray"},{"score":{"name":"#current_id","objective":"bf_temp"}},{"text":" - ","color":"red"},{"text":"[小隊已滿] ","color":"red","bold":true},{"text":" (4/4)","color":"gray"}]