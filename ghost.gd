extends CharacterBody2D
class_name Ghost

const SPEED = 100.0
var movement = Vector2()

func _ready():
	add_to_group("ghosts")

func _physics_process(_delta):
	velocity = movement * SPEED
	move_and_slide()

func _on_timer_timeout() -> void:
	movement = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	).normalized()
	$Timer.wait_time = randi_range(1, 2)
	$Timer.start()

func die():
	print("Fantasma morto")
	var gm = get_node_or_null("/root/game/gameManager")
	if gm:
		gm.on_ghost_died()
	else:
		print("⚠️ GameManager non trovato!")
	queue_free()
