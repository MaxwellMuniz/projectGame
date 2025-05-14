extends CharacterBody2D
class_name ghost


const SPEED = 100.0

var movement = Vector2()



func _physics_process(_delta):
	velocity = movement * SPEED
	move_and_slide()


func _on_timer_timeout() -> void:
	movement= Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	).normalized()
	$Timer.wait_time = randi_range(1,2)
	$Timer.start()
	pass # Replace with function body.
