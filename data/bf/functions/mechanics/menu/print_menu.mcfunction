# --- 1. 清空舊標記 ---
tag @e[tag=bf_menu_list] remove bf_menu_list

# --- 2. 篩選邏輯 ---

# (A) 基地 (永遠只顯示自己的)
execute if entity @s[team=Red] run tag @e[tag=bf_base_red] add bf_menu_list
execute if entity @s[team=Blue] run tag @e[tag=bf_base_blue] add bf_menu_list

# (B) 己方佔領的據點 (Owner = 自己的 Team ID)
# 假設紅隊ID=1, 藍隊ID=2
execute if entity @s[team=Red] run tag @e[tag=bf_flag,scores={bf_owner=1}] add bf_menu_list
execute if entity @s[team=Blue] run tag @e[tag=bf_flag,scores={bf_owner=2}] add bf_menu_list

# (C) 中立據點 (Owner = 0)
# 這樣雙方都能看到中立點 (僅預覽)
tag @e[tag=bf_flag,scores={bf_owner=0}] add bf_menu_list


# --- 3. 開始列印 ---
tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s ["",{"text":"===== 部署選單 =====","color":"gold","bold":true}]

# 啟動遞迴
execute if entity @e[tag=bf_menu_list] run function bf:mechanics/menu/iterator

# 結尾 (遞迴瞬間執行完畢後顯示)
tellraw @s ["",{"text":"=================","color":"gold","bold":true}]
tellraw @s {"text":"(點擊文字進行操作)","color":"gray","italic":true}