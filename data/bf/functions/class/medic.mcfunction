# 醫療兵
clear @s
sh_health set @s 21

give @s tacz:modern_kinetic_gun{GunId:"tacz:ump45",GunCurrentAmmoCount:26, GunFireMode:"AUTO", AttachmentGRIP:{Count:1b,id:"tacz:attachment",tag:{AttachmentId:"tacz:grip_rk6"}}}
give @s tacz:modern_kinetic_gun{GunId:"tacz:m870",GunCurrentAmmoCount:6, GunFireMode:"AUTO"}
give @s netherite_sword{display:{Name:'{"text":"戰術刀","color":"gold"}'}, Enchantments:[{id:sharpness,lvl:255}]}
give @s ender_pearl 10

item replace entity @s armor.head with lrarmor:medical_helmet{Unbreakable:1b}
item replace entity @s armor.chest with lrarmor:medical_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with lrarmor:medical_leggings{Unbreakable:1b}
item replace entity @s armor.feet with lrarmor:medical_boots{Unbreakable:1b}

give @s scalinghealth:medkit 16
give @s splash_potion{display:{Name:'{"text":"醫療包","color":"green"}'},Potion:"minecraft:strong_healing"} 3
give @s tacz:ammo_box{AllTypeCreative:1b} 1

tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s {"text":"職業: 醫療兵","color":"green","bold":true}
tellraw @s {"text":"裝備: 輕型護甲，治療道具","color":"gray"}

effect give @s speed 999999 1 true