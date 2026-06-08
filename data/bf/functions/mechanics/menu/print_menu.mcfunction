# --- 1~2. 篩選可部署據點 ---
function bf:utils/filter_menu_list

# --- 3. 開始列印 ---
tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s ["",{"text":"===== 部署選單 =====","color":"gold","bold":true}]

# 啟動遞迴
execute if entity @e[tag=bf_menu_list] run function bf:mechanics/menu/iterator

# 結尾 (遞迴瞬間執行完畢後顯示)
tellraw @s ["",{"text":"=================","color":"gold","bold":true}]
tellraw @s {"text":"(點擊文字進行操作)","color":"gray","italic":true}
