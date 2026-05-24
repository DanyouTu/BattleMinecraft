# --- 1. 初始化 (保持不變) ---
execute as @e[type=armor_stand,tag=bf_flag_item] run tag @s add bf_flag
execute as @e[type=armor_stand,tag=bf_flag_item] run tag @s add bf_spawn_point
# 生成鏡頭
execute at @e[type=armor_stand,tag=bf_flag_item] run summon armor_stand ~ ~ ~ {Tags:["bf_cam_anchor"],Invisible:1b,Marker:1b,NoGravity:1b}

# 設定名字 (顯示為金色的"前線據點")
execute as @e[type=armor_stand,tag=bf_flag_item] run data merge entity @s {Invisible:1b,Marker:1b,NoGravity:1b,CustomNameVisible:0b,CustomName:'{"text":"前線據點","color":"gold"}'}

execute as @e[type=armor_stand,tag=bf_flag_item] run scoreboard players set @s bf_capture 0
execute as @e[type=armor_stand,tag=bf_flag_item] run scoreboard players set @s bf_owner 0
execute as @e[type=armor_stand,tag=bf_flag_item] run tag @s remove bf_flag_item


# --- 2. 佔領計算 (邏輯保持不變) ---
execute as @e[tag=bf_flag] at @s if entity @a[team=Red,distance=..8,gamemode=survival] unless entity @a[team=Blue,distance=..8,gamemode=survival] if score @s bf_capture matches ..99 if score Game bf_gamestate matches 1 run scoreboard players add @s bf_capture 1
execute as @e[tag=bf_flag] at @s if entity @a[team=Blue,distance=..8,gamemode=survival] unless entity @a[team=Red,distance=..8,gamemode=survival] if score @s bf_capture matches -99.. if score Game bf_gamestate matches 1 run scoreboard players remove @s bf_capture 1


# ==================================================
# --- 3. 音效與歸屬 (修改：當歸屬權變更時，觸發選單刷新) ---
# ==================================================

# (A) 紅隊佔領瞬間 (分數=100 且 原本不是紅隊)
# 播放音效 + 設定歸屬 + ★觸發選單刷新 (#menu_refresh = 1)
execute as @e[tag=bf_flag,scores={bf_capture=100}] unless score @s bf_owner matches 1 run playsound minecraft:entity.experience_orb.pickup master @p[distance=..6] ~ ~ ~ 1 0.5
execute as @e[tag=bf_flag,scores={bf_capture=100}] unless score @s bf_owner matches 1 run scoreboard players set #menu_refresh bf_temp 1
execute as @e[tag=bf_flag,scores={bf_capture=100}] unless score @s bf_owner matches 1 run tellraw @a {"text":"據點 ","color":"white","extra":[{"selector":"@s","color":"gold"},{"text":" 已被","color":"white"},{"text":" 紅隊","color":"red"},{"text":" 佔領 !","color":"white"}]}
execute as @e[tag=bf_flag,scores={bf_capture=100}] run scoreboard players set @s bf_owner 1

# (B) 藍隊佔領瞬間 (分數=-100 且 原本不是藍隊)
execute as @e[tag=bf_flag,scores={bf_capture=-100}] unless score @s bf_owner matches 2 run playsound minecraft:entity.experience_orb.pickup master @p[distance=..6] ~ ~ ~ 1 0.5
execute as @e[tag=bf_flag,scores={bf_capture=-100}] unless score @s bf_owner matches 2 run scoreboard players set #menu_refresh bf_temp 1
execute as @e[tag=bf_flag,scores={bf_capture=-100}] unless score @s bf_owner matches 2 run tellraw @a {"text":"據點 ","color":"white","extra":[{"selector":"@s","color":"gold"},{"text":" 已被","color":"white"},{"text":" 藍隊","color":"blue"},{"text":" 佔領 !","color":"white"}]}
execute as @e[tag=bf_flag,scores={bf_capture=-100}] run scoreboard players set @s bf_owner 2

# (C) 失去控制瞬間 (分數回到 -50~50 且 原本不是中立)
# 這裡需要多一點判斷，防止每一幀都觸發。我們只在 "原本不是0，但現在變成0" 時觸發
# 為了簡化邏輯，我們可以反過來寫：只要分數進入中立區，且 owner 不等於 0，就觸發
execute as @e[tag=bf_flag,scores={bf_capture=-50..50}] unless score @s bf_owner matches 0 run scoreboard players set #menu_refresh bf_temp 1
execute as @e[tag=bf_flag,scores={bf_capture=-50..50}] unless score @s bf_owner matches 0 run tellraw @a {"text":"據點 ","color":"white","extra":[{"selector":"@s","color":"gold"},{"text":" 已失去控制 !","color":"white"}]}
execute as @e[tag=bf_flag,scores={bf_capture=-50..50}] run scoreboard players set @s bf_owner 0

# --- 4. 視覺 ---
# 給予持續的發光效果 (Glowing)
execute as @e[tag=bf_flag] run effect give @s minecraft:glowing 2 0 true

# (A) 中立 (Owner=0): 戴白羊毛 + 離開隊伍 (默認白色輪廓)
execute as @e[tag=bf_flag,scores={bf_owner=0}] run item replace entity @s armor.head with white_wool
execute as @e[tag=bf_flag,scores={bf_owner=0}] run team leave @s

# (B) 紅隊 (Owner=1): 戴紅羊毛 + 加入紅隊 (紅色輪廓)
execute as @e[tag=bf_flag,scores={bf_owner=1}] run item replace entity @s armor.head with red_wool
execute as @e[tag=bf_flag,scores={bf_owner=1}] run team join Red @s

# (C) 藍隊 (Owner=2): 戴藍羊毛 + 加入藍隊 (藍色輪廓)
execute as @e[tag=bf_flag,scores={bf_owner=2}] run item replace entity @s armor.head with blue_wool
execute as @e[tag=bf_flag,scores={bf_owner=2}] run team join Blue @s

# (粒子效果保留，增加氛圍)
execute as @e[tag=bf_flag] at @s run particle dust 1 1 1 1 ^5 ^0.2 ^ 0 0 0 0 1
execute as @e[tag=bf_flag] at @s run particle dust 1 1 1 1 ^ ^0.2 ^5 0 0 0 0 1
execute as @e[tag=bf_flag] at @s run particle dust 1 1 1 1 ^-5 ^0.2 ^ 0 0 0 0 1
execute as @e[tag=bf_flag] at @s run particle dust 1 1 1 1 ^ ^0.2 ^-5 0 0 0 0 1


# --- 5. Action Bar (整合上一則對話的修正：讓旗幟顯示自己的名字) ---
# 這裡使用 selector:@s 來直接讀取該旗幟的 CustomName
execute as @e[tag=bf_flag] at @s run title @a[distance=..10,gamemode=survival] actionbar ["",{"text":"[區域] ","color":"gold","bold":true},{"selector":"@s","color":"yellow"},{"text":"  |  佔領進度: ","color":"gray"},{"score":{"name":"@s","objective":"bf_capture"},"color":"white"},{"text":"%","color":"white"}]