# --- A. 退出小隊 (分數為 -1) ---
execute if score @s bf_join_sq matches -1 run scoreboard players set @s bf_squad 0
execute if score @s bf_join_sq matches -1 run title @s actionbar {"text":"你已離開小隊","color":"yellow"}

# --- B. 加入小隊 (分數 1~4) ---
# 先檢查目標小隊是否真的還沒滿 (防止多人同時點擊)
execute if score @s bf_join_sq matches 1..4 run function bf:mechanics/squad/confirm_join

# 重置觸發器
scoreboard players set @s bf_join_sq 0
# 重新印出選單讓玩家看到更新後的成員
function bf:mechanics/menu/page_squad