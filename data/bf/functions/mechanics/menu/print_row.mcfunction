# ================= 基地 (ID 1, 2) =================
# 基地沒有中立狀態，必定可部署

# ID 1 (紅基)
execute if score @e[tag=current_target,limit=1] bf_p_id matches 1 run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 1"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_act set 1"}}]

# ID 2 (藍基)
execute if score @e[tag=current_target,limit=1] bf_p_id matches 2 run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 2"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_act set 2"}}]


# ================= 據點 (ID 10+) =================
# 包含兩種狀態：己方(部署) / 中立(未佔領)

# --- ID 10  ---
# A. 己方佔領 (Owner >= 1) -> 顯示綠色部署
execute if score @e[tag=current_target,limit=1] bf_p_id matches 10 if score @e[tag=current_target,limit=1] bf_owner matches 1.. run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 10"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_act set 10"}}]
# B. 中立 (Owner = 0) -> 顯示灰色未佔領
execute if score @e[tag=current_target,limit=1] bf_p_id matches 10 if score @e[tag=current_target,limit=1] bf_owner matches 0 run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 10"}},{"text":" [未佔領]","color":"gray"}]

# --- ID 11  ---
execute if score @e[tag=current_target,limit=1] bf_p_id matches 11 if score @e[tag=current_target,limit=1] bf_owner matches 1.. run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 11"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_act set 11"}}]
execute if score @e[tag=current_target,limit=1] bf_p_id matches 11 if score @e[tag=current_target,limit=1] bf_owner matches 0 run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 11"}},{"text":" [未佔領]","color":"gray"}]

# --- ID 12  ---
execute if score @e[tag=current_target,limit=1] bf_p_id matches 12 if score @e[tag=current_target,limit=1] bf_owner matches 1.. run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 12"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_act set 12"}}]
execute if score @e[tag=current_target,limit=1] bf_p_id matches 12 if score @e[tag=current_target,limit=1] bf_owner matches 0 run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 12"}},{"text":" [未佔領]","color":"gray"}]

# --- ID 13  ---
execute if score @e[tag=current_target,limit=1] bf_p_id matches 13 if score @e[tag=current_target,limit=1] bf_owner matches 1.. run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 13"}},{"text":" [部署]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_act set 13"}}]
execute if score @e[tag=current_target,limit=1] bf_p_id matches 13 if score @e[tag=current_target,limit=1] bf_owner matches 0 run tellraw @s ["",{"text":" ▶ ","color":"gray"},{"selector":"@e[tag=current_target,limit=1]"},{"text":":  ","color":"white"},{"text":"[預覽] ","color":"aqua","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_click_id set 13"}},{"text":" [未佔領]","color":"gray"}]

# (若有更多點，請複製 ID 11 的區塊並修改數字)