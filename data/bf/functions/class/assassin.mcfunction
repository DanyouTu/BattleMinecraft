# 刺客
clear @s
sh_health set @s 3

give @s netherite_sword{display:{Name:'{"text":"戰術刀","color":"gold"}'}, Enchantments:[{id:sharpness,lvl:255}]}

item replace entity @s armor.head with lrarmor:joker_helmet{Unbreakable:1b,display:{color:5658198}}
item replace entity @s armor.chest with lrarmor:joker_chestplate{Unbreakable:1b,display:{color:5658198}}
item replace entity @s armor.legs with lrarmor:joker_leggings{Unbreakable:1b,display:{color:5658198}}
item replace entity @s armor.feet with lrarmor:joker_boots{Unbreakable:1b}

tellraw @s "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
tellraw @s {"text":"職業: 刺客","color":"dark_aqua","bold":true}
tellraw @s {"text":"裝備: 戰術刀，高機動但只有3格血量","color":"gray"}

effect give @s speed 999999 5 true