# 檢查遊戲是否進行中
execute unless score Game bf_gamestate matches 1 run tellraw @s {"text":"[系統] 遊戲尚未開始，無法選擇職業。","color":"yellow"}
execute unless score Game bf_gamestate matches 1 run scoreboard players set @s bf_class 0
execute unless score Game bf_gamestate matches 1 run return 0

# 選擇職業
execute as @s[scores={bf_class=1}] run function bf:class/assault
execute as @s[scores={bf_class=2}] run function bf:class/medic
execute as @s[scores={bf_class=3}] run function bf:class/support
execute as @s[scores={bf_class=4}] run function bf:class/recon
execute as @s[scores={bf_class=5}] run function bf:class/assassin

# 無效的職業 ID
execute as @s[scores={bf_class=6..}] run tellraw @s {"text":"[錯誤] 無效的職業選擇。","color":"red"}

scoreboard players set @s bf_class 0
