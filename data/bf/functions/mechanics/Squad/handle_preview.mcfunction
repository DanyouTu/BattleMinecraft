# 根據點擊的 Slot 強制旁觀對應隊友
execute if score @s bf_sq_prev matches 1 as @a[tag=sq_slot_1,limit=1] run spectate @s @p[scores={bf_sq_prev=1}]
execute if score @s bf_sq_prev matches 2 as @a[tag=sq_slot_2,limit=1] run spectate @s @p[scores={bf_sq_prev=2}]
execute if score @s bf_sq_prev matches 3 as @a[tag=sq_slot_3,limit=1] run spectate @s @p[scores={bf_sq_prev=3}]

title @s actionbar [{"text":"◉ ","color":"red"},{"text":"正在預覽隊友視角...","color":"green"}]
scoreboard players set @s bf_sq_prev 0
playsound minecraft:ui.button.click master @s
