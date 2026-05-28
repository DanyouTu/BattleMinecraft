# BattleMinecraft

A BattleField datapack for Minecraft

## Features

- 可自定義點位名稱與位置
- 自由修改的戰場範圍
- 以佔點模式為主 擁有據點復活與預覽系統
- 支援多人遊戲

## Before Use
> [!TIP]
> 如有放錯盔甲架，請用指令刪掉最近的盔甲架

- **前置模組: TACZ槍械模組、LesRaisins Armor-(A Tactical Armor Mod)、Scaling Health**
- .txt文件為設定據點用的

## Settings
> [!WARNING]
> 一定要靠近點位的盔甲架，且.txt檔裡的**第二條指令**一定要設定
> 數字從10號開始，最多到13號

比如設定四個點 每個據點的編號就要設定為10~13
- 邊界設定請個自放在對角線的位置，在右鍵使用胡蘿蔔釣竿設定
- 點與點之間的距離不能過近，不然預覽的攝影機會出現錯亂
- 紅藍兩方的基地可直接放置，不需額外設定(放置後消失是正常的)
- 全部設定完畢(隊伍請手動將玩家加入，預設隊伍有Red與Blue ) 請使用/function bf:game/game_start來啟動
- 解除安裝請使用/function bf:uninstall
- **取得設定工具請使用/function bf:tools**
