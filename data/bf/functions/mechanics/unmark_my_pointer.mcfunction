# 以「出界玩家」的身份執行，取消自己箭頭的 GC 標記
scoreboard players operation #temp_gc_id bf_temp = @s bf_ui_id
execute as @e[type=text_display,tag=bf_pointer] if score @s bf_ui_id = #temp_gc_id bf_temp run tag @s remove bf_garbage
