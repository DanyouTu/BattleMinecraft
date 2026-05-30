# BattleMinecraft (1.20.1 Vanilla)
[中文](README_zh.md) | [English](README.md)

Recreate the classic Conquest mode from *Battlefield* in Minecraft! This datapack supports multiplayer and features control point capturing, dedicated spawn points, and a battlefield preview camera system.

## ✨ Features

- 🚩 **Core Conquest Mode:** Centered around capturing control points, supporting point-specific respawns and a spectator camera system.
- 🗺️ **High Customizability:** Freely modify the battlefield boundaries, control point names, and their locations.
- 👥 **Multiplayer Support:** Supports team-based combat between the Red and Blue factions.

## ⚙️ Requirements

Before playing, ensure your server or client has the following mods installed:
- **TACZ (Timeless and Classics Zero):** Gun and weapon system.
- **LesRaisins Armor:** Tactical equipment and armor mod.
- **Scaling Health:** Dynamic health and difficulty adjustments.

---

## 🛠️ Setup Guide

> [!WARNING]
> When setting up control points, the distance between them **must not be too close**; otherwise, it will cause the preview camera to glitch.

### Step 1: Obtain Setup Tools
Upon entering the game, type the following command to get all the setup items:
```mcfunction
/function bf:tools

```
### Step 2: Set Battlefield Boundaries
Use the **two Carrot on a Sticks** from the tools and right-click on the "two diagonal corners" of your desired battlefield to set the boundaries.
Then, right-click with the **Update Boundary Carrot on a Stick** to update the coordinate data.
### Step 3: Place Faction Bases
Directly place the base Armor Stands for the Red and Blue teams.
> [!NOTE]
> The armor stands will disappear automatically after placement. This is normal and indicates a successful setup.
> 
### Step 4: Set Control Points
Place the control point armor stands on the map. Please pay attention to the following two important settings:
> [!IMPORTANT]
> The first setting is mandatory; otherwise, the system won't work. Make sure to stand very close to the control point's armor stand (within 3 blocks) when applying these settings.
> 
 1. **Point ID:** The bf_p_id for the control point must start from 10, up to a maximum of 13 (e.g., if setting 4 points, use 10~13):
   ```mcfunction
   /scoreboard players set @e[type=armor_stand, distance=..3, limit=1] bf_p_id 10
   
   ```
 2. **Name the Point:** Enter the following command to name and bind the point. The command below uses "Point A" (A點) as an example; you can freely modify the text inside and the color "gold":
```mcfunction
/data merge entity @e[type=minecraft:armor_stand, distance=..3, limit=1] {CustomName:'{"text":"Point A","color":"gold"}'}

```
### Step 5: Assign Teams and Start the Game
Admins should manually join players into their respective teams (default team names are Red and Blue). Once everything is ready, enter the following command to officially start the game:
```mcfunction
/function bf:game/game_start

```
## 🔧 Troubleshooting & Useful Commands
 * **Misplaced an armor stand?**
> [!TIP]
> If you accidentally place an armor stand in the wrong location, simply get close to it and use a clear command to delete the nearest armor stand.
> 
 * **How to uninstall or reset the game?**
   If you need to clear the datapack settings or reset the battlefield, type:
   ```mcfunction
   /function bf:uninstall
   
   ```
