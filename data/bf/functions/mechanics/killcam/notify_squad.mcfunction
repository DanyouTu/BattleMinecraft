# --- 通知同小隊的死亡玩家刷新選單 ---
# 當隊友死亡時，同小隊中正在等待部署的玩家需要更新選單
# (因為可部署的隊友少了一個)

# 標記自己避免自我刷新
tag @s add bf_squad_notify_src

# 找到同隊、同小隊、在大廳且正在看小隊頁面的玩家，刷新他們的選單
execute if entity @s[team=Red] as @a[team=Red,tag=in_lobby,tag=bf_on_squad_page,tag=!bf_squad_notify_src] if score @s bf_squad = @a[tag=bf_squad_notify_src,limit=1] bf_squad run function bf:mechanics/menu/page_squad
execute if entity @s[team=Blue] as @a[team=Blue,tag=in_lobby,tag=bf_on_squad_page,tag=!bf_squad_notify_src] if score @s bf_squad = @a[tag=bf_squad_notify_src,limit=1] bf_squad run function bf:mechanics/menu/page_squad

# 清除標記
tag @s remove bf_squad_notify_src
