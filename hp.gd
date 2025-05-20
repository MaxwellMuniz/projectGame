extends HBoxContainer

const MAX_HP = 3
var hp := MAX_HP

func set_hp(new_hp: int) -> void:
	hp = clamp(new_hp, 0, MAX_HP)
	update_hearts()

func update_hearts() -> void:
	for i in range(MAX_HP):
		var heart = get_node("Heart" + str(i + 1))
		heart.visible = hp > i
