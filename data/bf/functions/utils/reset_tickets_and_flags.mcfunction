# --- Shared: Reset tickets & flags ---
# Used by: game/reset, game/game_start
scoreboard players set Red bf_tickets 1000
scoreboard players set Blue bf_tickets 1000

execute as @e[tag=bf_flag] run scoreboard players set @s bf_capture 0
execute as @e[tag=bf_flag] run scoreboard players set @s bf_owner 0
execute as @e[tag=bf_flag] run item replace entity @s armor.head with white_wool
