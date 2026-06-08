scoreboard players set @s bf_click 0

# 檢查是否有節點在範圍內
execute unless entity @e[tag=bf_node,distance=..5] run tellraw @s {"text":"[提示] 5 格內沒有找到任何節點。","color":"yellow"}
execute unless entity @e[tag=bf_node,distance=..5] run return 0

# 尋找 5 格內最近的節點並刪除
execute as @e[tag=bf_node,sort=nearest,limit=1,distance=..5] at @s run particle cloud ~ ~1 ~ 0.5 0.5 0.5 0.1 20
kill @e[tag=bf_node,sort=nearest,limit=1,distance=..5]

playsound minecraft:block.lava.extinguish master @s ~ ~ ~ 1 1
title @s actionbar {"text":"已移除最近的節點","color":"red"}
