kill @e[tag=bf_flag]
kill @e[tag=bf_node]
kill @e[tag=bf_flag_item]
kill @e[tag=bf_node_item]
kill @e[tag=bf_base_red]
kill @e[tag=bf_base_blue]
kill @e[tag=bf_spawn_point]

scoreboard objectives remove bf_tickets
scoreboard objectives remove bf_capture
scoreboard objectives remove bf_owner
scoreboard objectives remove bf_timer
scoreboard objectives remove bf_deaths
scoreboard objectives remove bf_cam_timer
scoreboard objectives remove bf_click
scoreboard objectives remove bf_temp
scoreboard objectives remove bf_p_id
scoreboard objectives remove bf_click_id
scoreboard objectives remove bf_click_act
scoreboard objectives remove bf_coord
scoreboard objectives remove bf_ui_id
scoreboard objectives remove bf_class
scoreboard objectives remove bf_cd
scoreboard objectives remove bf_gamestate
scoreboard objectives remove bf_base_warn
scoreboard objectives remove bf_warn_s
scoreboard objectives remove bf_warn_d

team remove Red
team remove Blue
bossbar remove bf:red_tickets
bossbar remove bf:blue_tickets

tag @a remove IsSafe
tag @a remove in_lobby
effect clear @a
clear @a
schedule clear bf:game/end_game

kill @e[type=armor_stand]

tellraw @a {"text":"[System] 系統已完整卸載。","color":"red"}