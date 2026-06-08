# --- 前置檢查 (Pre-game Validation) ---

# 若遊戲已經在進行中，則中止
execute if score Game bf_gamestate matches 1.. run tellraw @a {"text":"[錯誤] 遊戲已在進行中！請先重置。","color":"red"}
execute if score Game bf_gamestate matches 1.. run return 0

# 檢查紅隊基地是否存在
execute unless entity @e[tag=bf_base_red,limit=1] run tellraw @a {"text":"[錯誤] 找不到紅隊基地！請先放置紅隊基地裝甲架。","color":"red"}
execute unless entity @e[tag=bf_base_red,limit=1] run return 0

# 檢查藍隊基地是否存在
execute unless entity @e[tag=bf_base_blue,limit=1] run tellraw @a {"text":"[錯誤] 找不到藍隊基地！請先放置藍隊基地裝甲架。","color":"red"}
execute unless entity @e[tag=bf_base_blue,limit=1] run return 0

# 檢查是否有玩家在隊伍中
execute unless entity @a[team=Red] unless entity @a[team=Blue] run tellraw @a {"text":"[錯誤] 沒有任何玩家加入隊伍！請先分配隊伍。","color":"red"}
execute unless entity @a[team=Red] unless entity @a[team=Blue] run return 0

# --- 設定兵力 & 重置旗幟 ---
function bf:utils/reset_tickets_and_flags
scoreboard players set Global bf_timer 0
scoreboard players set Game bf_gamestate 1

team modify Red nametagVisibility hideForOtherTeams
team modify Blue nametagVisibility hideForOtherTeams

# 傳送基地
execute as @a[team=Red] run tp @s @e[tag=bf_base_red, limit=1]
execute as @a[team=Blue] run tp @s @e[tag=bf_base_blue, limit=1]

title @a title {"text":"戰鬥開始！","color":"gold","bold":true}
title @a subtitle {"text":"佔領據點以獲得更多重生點","color":"white"}

function bf:mechanics/menu/print_class_all
execute as @a at @s run playsound minecraft:item.goat_horn.sound_0 master @s ~ ~ ~ 1 0.8
