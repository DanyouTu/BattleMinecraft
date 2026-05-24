# 2. 尋找目標並 TP
tag @s add looking_for_target
# 比對分數：找那個 bf_p_id 等於我剛剛點擊 ID 的實體
execute as @e[tag=bf_spawn_point] if score @s bf_p_id = @a[tag=looking_for_target,limit=1] bf_click_id run tp @a[tag=looking_for_target] @s
# execute as @a[tag=bf_spawn_point] at @s if score @s bf_p_id = @e[tag=looking_for_target,limit=1] bf_click_id run tp @e[tag=looking_for_target] @s
# execute as @a[tag=looking_for_target] at @s if score @s bf_click_id = @e[tag=bf_spawn_point,limit=1] bf_p_id run tp @s @e[tag=bf_spawn_point,limit=1]

# 3. 附身攝影機
gamemode spectator @s
execute at @s run spectate @e[tag=bf_cam_anchor,distance=..20,limit=1,sort=nearest]

# 4. 收尾
tag @s remove looking_for_target
scoreboard players set @s bf_click_id 0
title @s actionbar {"text":"[預覽模式]","color":"aqua"}
playsound minecraft:ui.button.click master @s