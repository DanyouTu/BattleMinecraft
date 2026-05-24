give @s armor_stand{EntityTag:{Tags:["bf_flag_item"]},display:{Name:'{"text":"[據點旗幟]","color":"gold"}'}} 1
give @s armor_stand{EntityTag:{Tags:["bf_corner_a_item"]},display:{Name:'{"text":"[邊界 A]","color":"green"}'}} 1
give @s armor_stand{EntityTag:{Tags:["bf_corner_b_item"]},display:{Name:'{"text":"[邊界 B]","color":"aqua"}'}} 1
give @s armor_stand{EntityTag:{Tags:["bf_base_red_item"]},display:{Name:'{"text":"[紅隊基地]","color":"red"}'}} 1
give @s armor_stand{EntityTag:{Tags:["bf_base_blue_item"]},display:{Name:'{"text":"[藍隊基地]","color":"blue"}'}} 1

give @s carrot_on_a_stick{display:{Name:'{"text":"[更新邊界] (右鍵)","color":"yellow"}'},Tags:["bf_update_bound"]} 1
give @s carrot_on_a_stick{display:{Name:'{"text":"[移除工具] (右鍵)","color":"red"}'},Tags:["bf_remover"]} 1

tellraw @s {"text":"[提示] 請設置邊界 A/B、雙方基地、以及據點旗幟。","color":"yellow"}