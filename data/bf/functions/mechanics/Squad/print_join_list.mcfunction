# 確保變數有初始值 (將 NULL 強制轉為 0)
scoreboard players add @s bf_squad 0

# 2. 顯示小隊清單 (這裡示範 4 個小隊)
# 我們呼叫一個小函數來計算人數並印出每一行
scoreboard players set #current_id bf_temp 1
function bf:mechanics/squad/check_and_print_line

scoreboard players set #current_id bf_temp 2
function bf:mechanics/squad/check_and_print_line

scoreboard players set #current_id bf_temp 3
function bf:mechanics/squad/check_and_print_line

scoreboard players set #current_id bf_temp 4
function bf:mechanics/squad/check_and_print_line
