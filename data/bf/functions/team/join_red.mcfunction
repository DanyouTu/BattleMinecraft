team join Red @s
tellraw @a {"text":"玩家 ","color":"white","extra":[{"selector":"@s","color":"aqua"},{"text":" 加入了紅隊！","color":"white"}]}
playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 1 0.5
gamemode survival @s

effect clear @s
effect give @s instant_health 1 10 true