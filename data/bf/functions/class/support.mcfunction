# 支援兵
clear @s
sh_health set @s 21

give @s tacz:modern_kinetic_gun{GunId:"tacz:m249",GunCurrentAmmoCount:75, GunFireMode:"AUTO", AttachmentSCOPE:{Count:1b,id:"tacz:attachment",tag:{AttachmentId:"tacz:sight_deltapoint_rifle"}}}
give @s tacz:modern_kinetic_gun{GunId:"tacz:rpg7",GunCurrentAmmoCount:1, GunFireMode:"SEMI"}
give @s netherite_sword{display:{Name:'{"text":"戰術刀","color":"gold"}'}, Enchantments:[{id:sharpness,lvl:255}]}

item replace entity @s armor.head with lrarmor:defender_helmet{Unbreakable:1b}
item replace entity @s armor.chest with lrarmor:defender_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with lrarmor:defender_leggings{Unbreakable:1b}
item replace entity @s armor.feet with lrarmor:defender_boots{Unbreakable:1b}

give @s scalinghealth:medkit 16
give @s ender_pearl 4
give @s tacz:ammo_box{AllTypeCreative:1b} 1

tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s {"text":"職業: 支援兵","color":"red","bold":true}
tellraw @s {"text":"裝備: 重型護甲，強大火力","color":"gray"}

effect give @s resistance 999999 0 true
effect give @s speed 999999 0 true