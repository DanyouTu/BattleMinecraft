# 設定兵力
scoreboard players set Red bf_tickets 1000
scoreboard players set Blue bf_tickets 1000
scoreboard players set Global bf_timer 0
scoreboard players set Game bf_gamestate 1

# 重置旗幟
execute as @e[tag=bf_flag] run scoreboard players set @s bf_capture 0
execute as @e[tag=bf_flag] run scoreboard players set @s bf_owner 0
execute as @e[tag=bf_flag] run item replace entity @s armor.head with white_wool

team modify Red nametagVisibility hideForOtherTeams
team modify Blue nametagVisibility hideForOtherTeams

# 傳送基地
execute as @a[team=Red] run tp @e[tag=bf_base_red, limit=1]
execute as @a[team=Blue] run tp @e[tag=bf_base_blue, limit=1]

title @a title {"text":"戰鬥開始！","color":"gold","bold":true}
title @a subtitle {"text":"佔領據點以獲得更多重生點","color":"white"}

function bf:mechanics/menu/print_class_all
execute as @a at @s run playsound minecraft:item.goat_horn.sound_0 master @s ~ ~ ~ 1 0.8