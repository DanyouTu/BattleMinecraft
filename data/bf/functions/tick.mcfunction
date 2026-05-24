# 子系統執行
scoreboard players enable @a bf_click_id
scoreboard players enable @a bf_click_act
scoreboard players enable @a bf_class

function bf:mechanics/capture
function bf:mechanics/setup_bases
function bf:mechanics/base_protection
function bf:mechanics/bleed
function bf:mechanics/boundary
function bf:mechanics/death
function bf:mechanics/bossbar

# --- 工具偵測 ---
execute as @a[scores={bf_click=1..},nbt={SelectedItem:{tag:{Tags:["bf_update_bound"]}}}] run function bf:mechanics/update_boundary
execute as @a[scores={bf_click=1..},nbt={SelectedItem:{tag:{Tags:["bf_remover"]}}}] run kill @e[tag=bf_corner_a,distance=..5]
execute as @a[scores={bf_click=1..},nbt={SelectedItem:{tag:{Tags:["bf_remover"]}}}] run kill @e[tag=bf_corner_b,distance=..5]
execute as @a[scores={bf_click=1..},nbt={SelectedItem:{tag:{Tags:["bf_remover"]}}}] run kill @e[tag=bf_base_red,distance=..5]
execute as @a[scores={bf_click=1..},nbt={SelectedItem:{tag:{Tags:["bf_remover"]}}}] run kill @e[tag=bf_base_blue,distance=..5]
execute as @a[scores={bf_click=1..},nbt={SelectedItem:{tag:{Tags:["bf_flag"]}}}] run kill @s

execute if score Game bf_gamestate matches 1 run function bf:game/check_win
execute as @a[scores={bf_class=1..}] run function bf:class/select

## --- 冷卻時間處理 (重要！) ---
# 每一幀把冷卻時間 -1，直到歸零
scoreboard players remove @a[scores={bf_cd=1..}] bf_cd 1

# --- 鏡頭系統 ---
# 1. 旋轉
execute as @e[tag=bf_spawn_point] at @s run tp @s ~ ~ ~ ~0.5 ~
execute as @e[tag=bf_spawn_point] at @s run tp @e[tag=bf_cam_anchor,limit=1,distance=..20] ^ ^6 ^-10 facing entity @s

# --- 3. 處理選單點擊 ---
# (A) 處理 [預覽] 點擊
execute as @a[scores={bf_click_id=1..}] run function bf:mechanics/handle_preview

# (B) 處理 [部署] 點擊
execute as @a[scores={bf_click_act=1..}] run function bf:mechanics/handle_deploy_click

execute as @a[tag=in_lobby] run title @s actionbar {"text":"按 [T] 打開聊天欄選擇重生點","color":"yellow","bold":true}

execute store result bossbar bf:red_tickets value run scoreboard players get Red bf_tickets
execute store result bossbar bf:blue_tickets value run scoreboard players get Blue bf_tickets

# --- 系統重置 ---
# 重置選單刷新開關 (防止無限重繪)
scoreboard players set #menu_refresh bf_temp 0