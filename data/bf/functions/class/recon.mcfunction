# 偵察兵
clear @s
sh_health set @s 21

give @s tacz:modern_kinetic_gun{GunId:"tacz:ai_awp",GunCurrentAmmoCount:5, GunFireMode:"SEMI", AttachmentSCOPE:{Count:1b,id:"tacz:attachment",tag:{AttachmentId:"tacz:scope_elcan_4x"}}}
give @s ender_pearl 4
give @s netherite_sword{display:{Name:'{"text":"戰術刀","color":"gold"}'}, Enchantments:[{id:sharpness,lvl:255}]}

item replace entity @s armor.head with lrarmor:sniper_helmet{Unbreakable:1b,display:{color:5658198}}
item replace entity @s armor.chest with lrarmor:sniper_chestplate{Unbreakable:1b,display:{color:5658198}}
item replace entity @s armor.legs with lrarmor:sniper_leggings{Unbreakable:1b,display:{color:5658198}}
item replace entity @s armor.feet with lrarmor:sniper_boots{Unbreakable:1b}

give @s scalinghealth:medkit 16
give @s spyglass 1
give @s tacz:ammo_box{AllTypeCreative:1b} 1

tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s {"text":"職業: 偵察兵","color":"dark_aqua","bold":true}
tellraw @s {"text":"裝備: 輕型護甲，遠程狙擊","color":"gray"}

effect give @s speed 999999 2 true