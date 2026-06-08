# --- Killcam: 記錄攻擊者 (runs AS attacker) ---
# 每次打到玩家時觸發，把自己的 bf_pid 寫到被害者身上

# 1. 標記自己為攻擊者
tag @s add bf_attacker

# 2. 找到最近的剛受傷玩家 (HurtTime:10s)，把自己的 bf_pid 寫上去
#    sort=nearest,limit=1 確保多人混戰時配對最可能的目標
execute at @s as @a[nbt={HurtTime:10s},tag=!bf_attacker,sort=nearest,limit=1] run scoreboard players operation @s bf_last_hit_by = @a[tag=bf_attacker,limit=1] bf_pid

# 3. 清除標記
tag @s remove bf_attacker

# 4. 撤銷進度 (讓下次攻擊還能再觸發)
advancement revoke @s only bf:hurt_player
