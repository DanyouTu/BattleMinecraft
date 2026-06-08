# --- Shared: Post-join team effects ---
# Used by: team/join_red, team/join_blue
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.5
gamemode survival @s

effect clear @s
effect give @s instant_health 1 10 true
