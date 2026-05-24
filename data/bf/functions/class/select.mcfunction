execute as @s[scores={bf_class=1}] run function bf:class/assault
execute as @s[scores={bf_class=2}] run function bf:class/medic
execute as @s[scores={bf_class=3}] run function bf:class/support
execute as @s[scores={bf_class=4}] run function bf:class/recon
execute as @s[scores={bf_class=5}] run function bf:class/assassin

scoreboard players set @s bf_class 0