# 1. 標記搜尋
tag @s add looking_for_target

# 2. 尋找目標並 TP (用 preview_failed 追蹤)
tag @s add preview_failed
execute as @e[tag=bf_spawn_point] if score @s bf_p_id = @a[tag=looking_for_target,limit=1] bf_click_id run tp @a[tag=looking_for_target] @s
execute as @e[tag=bf_spawn_point] if score @s bf_p_id = @a[tag=looking_for_target,limit=1] bf_click_id run tag @a[tag=looking_for_target] remove preview_failed

# 3. 如果找不到目標，回報錯誤並中止
execute if entity @s[tag=preview_failed] run tellraw @s {"text":"[錯誤] 找不到該據點，無法預覽。","color":"red"}
execute if entity @s[tag=preview_failed] run tag @s remove looking_for_target
execute if entity @s[tag=preview_failed] run scoreboard players set @s bf_click_id 0
execute if entity @s[tag=preview_failed] run tag @s remove preview_failed
execute unless entity @s[tag=looking_for_target] run return 0

# 4. 附身攝影機
gamemode spectator @s
execute at @s run spectate @e[tag=bf_cam_anchor,distance=..20,limit=1,sort=nearest]

# 5. 收尾
tag @s remove looking_for_target
scoreboard players set @s bf_click_id 0
title @s actionbar [{"text":"◉ ","color":"red"},{"text":"正在預覽據點...","color":"green"}]
playsound minecraft:ui.button.click master @s
