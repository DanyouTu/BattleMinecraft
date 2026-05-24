# 1. 鎖定一個目標
tag @e[tag=bf_menu_list,limit=1,sort=nearest] add current_target

# 2. 執行列印 (呼叫查表)
function bf:mechanics/menu/print_row

# 3. 移除標籤，換下一個
tag @e[tag=current_target] remove bf_menu_list
tag @e[tag=current_target] remove current_target

# 4. 繼續迴圈
execute if entity @e[tag=bf_menu_list] run function bf:mechanics/menu/iterator