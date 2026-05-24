# 1. 歸零觸發
# 注意：這裡使用 bf_click_act (deploy 的分數)
tag @s add deploying

# 2. 尋找目標並 TP
execute as @e[tag=bf_spawn_point] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act run tp @a[tag=deploying] @s

# 3. 切換模式與給裝備
gamemode survival @s
tag @s remove in_lobby
tag @s remove deploying
scoreboard players set @s bf_click_act 0
scoreboard players set @s bf_deaths 0

# 5. 防重生殺與音效
effect give @s resistance 5 255 true
sh_health set @s 21
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1
title @s actionbar {"text":"部署完成！","color":"green","bold":true}

function bf:mechanics/menu/print_class