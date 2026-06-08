# --- 1~2. 篩選可部署據點 ---
function bf:utils/filter_menu_list

# --- 3. 開始列印 ---
tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s ["",{"text":"===== 據點部署 =====","color":"gold","bold":true}]

# 啟動遞迴
execute if entity @e[tag=bf_menu_list] run function bf:mechanics/menu/iterator

# --- 4. 底部翻頁按鈕 ---
tellraw @s ["",{"text":"=================","color":"gold","bold":true}]
tellraw @s ["",{"text":"[↪ 切換至 小隊部署]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_menu_flip set 1"}}]
tellraw @s {"text":"(點擊文字進行操作)","color":"gray","italic":true}
