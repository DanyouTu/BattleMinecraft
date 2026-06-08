# --- Shared: Finalize player deployment ---
# Used by: mechanics/handle_deploy_click, mechanics/Squad/handle_deploy
gamemode survival @s
tag @s remove in_lobby
scoreboard players set @s bf_deaths 0

# 防重生殺與音效
effect give @s resistance 5 255 true
sh_health set @s 21
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1
function bf:mechanics/menu/print_class
