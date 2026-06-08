# 0. 安全檢查：玩家必須在隊伍中且遊戲進行中
execute unless entity @s[team=Red] unless entity @s[team=Blue] run scoreboard players set @s bf_click_act 0
execute unless entity @s[team=Red] unless entity @s[team=Blue] run return 0
execute unless score Game bf_gamestate matches 1 run scoreboard players set @s bf_click_act 0
execute unless score Game bf_gamestate matches 1 run return 0

# 1. 冷卻檢查 (防止連續點擊)
execute if score @s bf_cd matches 1.. run tellraw @s {"text":"[系統] 操作冷卻中，請稍後再試。","color":"yellow"}
execute if score @s bf_cd matches 1.. run scoreboard players set @s bf_click_act 0
execute if score @s bf_cd matches 1.. run return 0

# 2. 標記部署中
tag @s add deploying

# 3. 驗證目標歸屬權並 TP
# 用 deploy_failed 標記追蹤是否找到目標 (預設失敗，找到則移除)
tag @s add deploy_failed
# 基地永遠可部署 (ID 1 = 紅基, ID 2 = 藍基)
execute if entity @s[team=Red] as @e[tag=bf_spawn_point,tag=bf_base_red] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act at @s run tp @a[tag=deploying] @s
execute if entity @s[team=Red] as @e[tag=bf_spawn_point,tag=bf_base_red] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act run tag @a[tag=deploying] remove deploy_failed
execute if entity @s[team=Blue] as @e[tag=bf_spawn_point,tag=bf_base_blue] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act at @s run tp @a[tag=deploying] @s
execute if entity @s[team=Blue] as @e[tag=bf_spawn_point,tag=bf_base_blue] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act run tag @a[tag=deploying] remove deploy_failed
# 據點：紅隊只能部署到 owner=1，藍隊只能部署到 owner=2
execute if entity @s[team=Red] as @e[tag=bf_spawn_point,tag=bf_flag,scores={bf_owner=1}] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act at @s run tp @a[tag=deploying] @s
execute if entity @s[team=Red] as @e[tag=bf_spawn_point,tag=bf_flag,scores={bf_owner=1}] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act run tag @a[tag=deploying] remove deploy_failed
execute if entity @s[team=Blue] as @e[tag=bf_spawn_point,tag=bf_flag,scores={bf_owner=2}] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act at @s run tp @a[tag=deploying] @s
execute if entity @s[team=Blue] as @e[tag=bf_spawn_point,tag=bf_flag,scores={bf_owner=2}] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act run tag @a[tag=deploying] remove deploy_failed

# 4. 如果沒有找到目標 (deploy_failed 仍存在)，回報錯誤並中止
execute if entity @s[tag=deploy_failed] run tellraw @s {"text":"[錯誤] 找不到目標重生點！該據點可能已失去控制。","color":"red"}
execute if entity @s[tag=deploy_failed] run tag @s remove deploying
execute if entity @s[tag=deploy_failed] run scoreboard players set @s bf_click_act 0
execute if entity @s[tag=deploy_failed] run tag @s remove deploy_failed
execute unless entity @s[tag=deploying] run return 0

# 5. 部署成功 - 切換模式與給裝備
gamemode survival @s
tag @s remove in_lobby
tag @s remove deploying
scoreboard players set @s bf_click_act 0
scoreboard players set @s bf_deaths 0

# 6. 防重生殺與音效
effect give @s resistance 5 255 true
sh_health set @s 21
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1
title @s actionbar {"text":"部署完成！","color":"green","bold":true}

function bf:mechanics/menu/print_class
