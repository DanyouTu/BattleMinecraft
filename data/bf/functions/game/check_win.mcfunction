# 單方勝利
execute if score Red bf_tickets matches ..0 if score Blue bf_tickets matches 1.. run function bf:game/end_game
execute if score Blue bf_tickets matches ..0 if score Red bf_tickets matches 1.. run function bf:game/end_game

# 平手處理 (雙方同時歸零)
execute if score Red bf_tickets matches ..0 if score Blue bf_tickets matches ..0 run function bf:game/end_game
