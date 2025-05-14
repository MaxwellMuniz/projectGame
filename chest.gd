extends StaticBody2D
class_name  Chest


@export var item = ""


func is_closed():
	return $ChestClosed.visible
	
	
	
func open():
	$ChestClosed.visible = false
	$ChestOpened.visible = true
