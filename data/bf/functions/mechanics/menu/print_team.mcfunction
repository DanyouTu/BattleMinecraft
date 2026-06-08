tellraw @a "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

tellraw @s ["",{"text":"===== 隊伍選擇 =====","color":"gold","bold":true}]
tellraw @a ["",{"text":" ▶ ","color":"gray"},{"text":"紅隊","color":"red","bold":true},{"text":"[加入]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_team set 1"}}]
tellraw @a ["",{"text":" ▶ ","color":"gray"},{"text":"藍隊","color":"blue","bold":true},{"text":"[加入]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/trigger bf_join_team set 2"}}]
tellraw @s ["",{"text":"=================","color":"gold","bold":true}]
tellraw @s {"text":"(點擊文字進行操作)","color":"gray","italic":true}
