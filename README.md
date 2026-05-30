# BattleMinecraft

在 Minecraft 中還原《戰地風雲》的經典佔點模式！本資料包支援多人連線，具備據點佔領、專屬重生點與戰場攝影機預覽系統

## ✨ 遊戲特色

- 🚩 **核心佔點模式：** 以據點爭奪為核心，支援據點復活與戰場預覽攝影機。
- 🗺️ **高自由度自定義：** 戰場範圍、據點名稱與位置皆可自由修改。
- 👥 **多人遊戲支援：** 支援 Red 與 Blue 兩方陣營對抗。

## ⚙️ 前置 (Requirement)

在遊玩之前，請確保你的伺服器或客戶端已安裝以下模組（Mods）：
- **TACZ (Timeless and Classics Zero):** 槍械武器系統
- **LesRaisins Armor:** 戰術裝備與護甲模組
- **Scaling Health:** 血量與難度動態調整

---

## 🛠️ 遊戲設定流程 (Setup Guide)

> [!WARNING]
> 設定據點時，點與點之間的距離**不能過近**，否則會導致預覽攝影機視角錯亂。

### Step 1: 取得設定工具
進入遊戲後，輸入以下指令取得所有設定用的道具：
```mcfunction
/function bf:tools

```
### Step 2: 設定戰場邊界
使用工具中的**兩個胡蘿蔔釣竿**，依序在戰場的「兩個對角線位置」點擊右鍵，設定戰場範圍。
再用**更新邊界胡蘿蔔釣竿**右鍵更新座標資訊。
### Step 3: 放置陣營基地
直接放置紅方（Red）與藍方（Blue）的基地盔甲架。
   > [!NOTE]
   > 放置後盔甲架會自動消失，這是正常現象，代表已設定成功。
### Step 4: 設定佔領據點
將據點盔甲架放置在地圖中。請留意以下兩項重要設定：
> [!IMPORTANT]
> 第一項設定必做，否則系統不起作用
 1. **據點編號：** 據點的`bf_p_id`必須從 10 號開始，最多設定至 13 號（例如設定 4 個點就是 10~13）:
    ```mcfunction
    /scoreboard players set @e[type=armor_stand, distance=..3, limit=1] bf_p_id 10
    ```
 3. **命名據點：** 請務必靠近點位的盔甲架 (距離 3 格以內)，並輸入以下指令來為據點命名與綁定。以下指令以設定「A點」為例，你可以自由修改裡面的 A點 與顏色 gold：
   ```mcfunction
   /data merge entity @e[type=minecraft:armor_stand, distance=..3, limit=1] {CustomName:'{"text":"A點","color":"gold"}'}
   
   ```
### Step 5: 分配隊伍與開始遊戲
請管理員手動將玩家加入隊伍（預設隊伍名稱為 Red 與 Blue）。一切就緒後，輸入以下指令正式開始遊戲：
```mcfunction
/function bf:game/game_start

```
## 🔧 疑難排解與實用指令
 * **放錯盔甲架怎麼辦？**
> [!TIP]
> 如果不小心放錯位置，請靠近該盔甲架並使用清除指令刪除最近的盔甲架即可。
 * **如何解除安裝/重置遊戲？**
   若需清除資料包的設定或重置場地，請輸入：
   ```mcfunction
   /function bf:uninstall
   
   ```
