# --- 佔領計算 (拉鋸戰版) ---
# 以據點身份執行，位於據點位置
# 紅藍人數差決定佔領速度與方向

# 1. 計算區域內各隊人數
execute store result score #red_count bf_temp run execute if entity @a[team=Red,distance=..8,gamemode=survival]
execute store result score #blue_count bf_temp run execute if entity @a[team=Blue,distance=..8,gamemode=survival]

# 2. 計算淨差值 (正=紅方優勢, 負=藍方優勢)
scoreboard players operation #net bf_temp = #red_count bf_temp
scoreboard players operation #net bf_temp -= #blue_count bf_temp

# 3. 根據差值調整佔領進度 (有人才動)
execute if score #net bf_temp matches 1.. if score @s bf_capture matches ..99 run scoreboard players operation @s bf_capture += #net bf_temp
execute if score #net bf_temp matches ..-1 if score @s bf_capture matches -99.. run scoreboard players operation @s bf_capture += #net bf_temp

# 4. 限制範圍 -100 ~ 100
execute if score @s bf_capture matches 101.. run scoreboard players set @s bf_capture 100
execute if score @s bf_capture matches ..-101 run scoreboard players set @s bf_capture -100
