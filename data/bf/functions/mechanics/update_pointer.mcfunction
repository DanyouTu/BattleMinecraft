# 1. 取得當前玩家的 UI ID
scoreboard players operation #temp_id bf_temp = @s bf_ui_id

# 2. 找到 ID 相同的箭頭，傳送到玩家前方
# 修正點：tp @s ~ ~ ~ ~180 ~ (讓它轉身 180 度，屁股對著你，箭頭對著中心)
execute as @e[type=text_display,tag=bf_pointer] if score @s bf_ui_id = #temp_id bf_temp at @p anchored feet facing entity @e[tag=bf_map_center,limit=1] feet positioned ^ ^0.2 ^2.0 run tp @s ~ ~ ~ ~180 ~