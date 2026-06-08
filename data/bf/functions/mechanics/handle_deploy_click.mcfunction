# 1. 冷卻檢查 (防止連續點擊)
execute if score @s bf_cd matches 1.. run tellraw @s {"text":"[系統] 操作冷卻中，請稍後再試。","color":"yellow"}
execute if score @s bf_cd matches 1.. run scoreboard players set @s bf_click_act 0
execute if score @s bf_cd matches 1.. run return 0

# 2. 標記部署中
tag @s add deploying

# 3. 尋找目標並 TP
# 用 deploy_failed 標記追蹤是否找到目標 (預設失敗，找到則移除)
tag @s add deploy_failed
execute as @e[tag=bf_spawn_point] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act at @s run tp @a[tag=deploying] @s
execute as @e[tag=bf_spawn_point] if score @s bf_p_id = @a[tag=deploying,limit=1] bf_click_act run tag @a[tag=deploying] remove deploy_failed

# 4. 如果沒有找到目標 (deploy_failed 仍存在)，回報錯誤並中止
execute if entity @s[tag=deploy_failed] run tellraw @s {"text":"[錯誤] 找不到目標重生點！該據點可能已失去控制。","color":"red"}
execute if entity @s[tag=deploy_failed] run tag @s remove deploying
execute if entity @s[tag=deploy_failed] run scoreboard players set @s bf_click_act 0
execute if entity @s[tag=deploy_failed] run tag @s remove deploy_failed
execute unless entity @s[tag=deploying] run return 0

# 5. 部署成功 - 共用部署流程
tag @s remove deploying
scoreboard players set @s bf_click_act 0
function bf:utils/deploy_player
title @s actionbar {"text":"部署完成！","color":"green","bold":true}
