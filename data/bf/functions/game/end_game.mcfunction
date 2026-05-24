scoreboard players set Game bf_gamestate 2

execute if score Red bf_tickets matches ..0 run title @a title {"text":"BLUE WINS!","color":"blue","bold":true}
execute if score Blue bf_tickets matches ..0 run title @a title {"text":"RED WINS!","color":"red","bold":true}

execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 0.8
team modify Red nametagVisibility always
team modify Blue nametagVisibility always

schedule function bf:game/reset 10s