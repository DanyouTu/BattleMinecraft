tag @s add bf_on_squad_page
tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s ["",{"text":"===== 小隊部署 =====","color":"green","bold":true}]

# --- A. 如果玩家還沒小隊 ---
execute if score @s bf_squad matches 0 run function bf:mechanics/squad/print_join_list

# 2. 開始分配隊友編號 (Slot) 並列印
execute if score @s bf_squad matches 1.. run function bf:mechanics/menu/squad_assign
execute if score @s bf_squad matches 1.. run tellraw @s ["",{"text":"[↺ 退出當前小隊]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_sq set -1"}}]

# --- 3. 底部翻頁按鈕 ---
tellraw @s ["",{"text":"=================","color":"green","bold":true}]
tellraw @s ["",{"text":"[↩ 切換至 據點部署]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_menu_flip set 2"}}]
tellraw @s {"text":"(點擊文字進行操作)","color":"gray","italic":true}
