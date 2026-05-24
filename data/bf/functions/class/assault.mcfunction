# 突擊兵
clear @s
effect clear @s
sh_health set @s 21

give @s tacz:modern_kinetic_gun{GunId:"tacz:m4a1",GunCurrentAmmoCount:30,GunFireMode:"AUTO",AttachmentSCOPE:{Count:1b,id:"tacz:attachment",tag:{AttachmentId:"tacz:sight_exp3"}}}
give @s tacz:modern_kinetic_gun{GunId:"tacz:glock_17",GunCurrentAmmoCount:18,GunFireMode:"SEMI",AttachmentMUZZLE:{Count:1b,id:"tacz:attachment",tag:{AttachmentId:"tacz:muzzle_silencer_mirage"}}}
give @s netherite_sword{display:{Name:'{"text":"戰術刀","color":"gold"}'}, Enchantments:[{id:sharpness,lvl:255}]}

item replace entity @s armor.head with lrarmor:attacker_helmet{Unbreakable:1b}
item replace entity @s armor.chest with lrarmor:attacker_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with lrarmor:attacker_leggings{Unbreakable:1b}
item replace entity @s armor.feet with lrarmor:attacker_boots{Unbreakable:1b}

give @s scalinghealth:medkit 16
give @s ender_pearl 4
give @s tacz:ammo_box{AllTypeCreative:1b} 1

tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s {"text":"職業: 突擊兵","color":"gold","bold":true}
tellraw @s {"text":"裝備: 中型護甲，平衡火力","color":"gray"}

effect give @s speed 999999 0 true