# --- 1. 清除實體 ---
kill @e[tag=bf_flag]
kill @e[tag=bf_node]
kill @e[tag=bf_flag_item]
kill @e[tag=bf_node_item]
kill @e[tag=bf_base_red]
kill @e[tag=bf_base_blue]
kill @e[tag=bf_spawn_point]
kill @e[tag=bf_cam_anchor]
kill @e[tag=bf_map_center]
kill @e[tag=bf_pointer]
kill @e[tag=bf_corner_a]
kill @e[tag=bf_corner_b]
kill @e[type=text_display,tag=bf_pointer]

# --- 2. 移除記分板 ---
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
scoreboard objectives remove bf_squad
scoreboard objectives remove bf_sq_count
scoreboard objectives remove bf_join_sq
scoreboard objectives remove bf_sq_dep
scoreboard objectives remove bf_sq_prev
scoreboard objectives remove bf_menu_flip
scoreboard objectives remove bf_join_team
scoreboard objectives remove bf_pid
scoreboard objectives remove bf_last_hit_by

# --- 3. 移除隊伍與 Bossbar ---
team remove Red
team remove Blue
bossbar remove bf:red_tickets
bossbar remove bf:blue_tickets

# --- 4. 清除玩家狀態 ---
tag @a remove IsSafe
tag @a remove in_lobby
tag @a remove in_enemy_base
tag @a remove bf_has_pointer
tag @a remove deploying
tag @a remove deploy_failed
tag @a remove looking_for_target
tag @a remove preview_failed
tag @a remove is_teammate
tag @a remove sq_slot_1
tag @a remove sq_slot_2
tag @a remove sq_slot_3
tag @a remove bf_in_killcam
tag @a remove bf_attacker
tag @a remove bf_my_killer
tag @a remove bf_finding_killer
effect clear @a
clear @a

# --- 5. 清除排程 ---
schedule clear bf:game/reset

tellraw @a {"text":"[System] 系統已完整卸載。","color":"red"}
