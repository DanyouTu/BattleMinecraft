# --- Killcam: 結束旁觀殺手，轉入大廳等待部署 ---

# 1. 停止旁觀
spectate

# 2. 移除 killcam 標記
tag @s remove bf_in_killcam

# 3. 提示玩家
title @s actionbar {"text":"選擇重生點...","color":"yellow"}
