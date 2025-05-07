extends HBoxContainer


const MAX_HP = 3
var hp= 3



#func _ready() -> void:
	#set_hp(3)


func set_hp(new_hp):
	hp = new_hp	
	for i in range(MAX_HP):
		var heart = get_node ("Heart" + str(i + 1))
		heart.visible = hp > i 
