extends CharacterBody2D

const SPEED = 120.0

signal gameover
var has_sword = false
var is_attacking = false

func _physics_process(_delta): 
	var movement = Vector2()
	movement.x = Input.get_axis("p2_left", "p2_right")
	movement.y = Input.get_axis("p2_up", "p2_down")
	movement = movement.normalized()

	if movement != Vector2.ZERO:
		$RayCast2D.target_position = movement * 32
		$HurtBox.position = $RayCast2D.target_position

	update_animation(movement)
	velocity = movement * SPEED

	if Input.is_action_just_pressed("p2_interact"):
		if $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider is Chest and collider.is_closed(): 
				collider.open()
				if collider.item == "sword":
					has_sword = true

	if not is_attacking and has_sword and Input.is_action_just_pressed("p2_attack"):
		attack()

	if not is_attacking:	
		move_and_slide()

func attack():
	$AttackSfx.play()
	$HurtBox.monitoring = true
	is_attacking = true
	$AnimationPlayer.play("attack_" + get_direction_as_string())
	await $AnimationPlayer.animation_finished
	is_attacking = false
	$HurtBox.monitoring = false

func get_direction_as_string():
	var dir = $RayCast2D.target_position
	if dir.x > 0:
		return "right"
	elif dir.x < 0:
		return "left"
	elif dir.y > 0:
		return "down"
	elif dir.y < 0:
		return "up"

func update_animation(movement):
	if movement != Vector2.ZERO:
		$AnimatedSprite2D.play("walk_" + get_direction_as_string())
	else: 
		$AnimatedSprite2D.play("idle_" + get_direction_as_string())

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Ghost:
		body.die()


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body is Ghost:
		var hp_control = get_node("/root/game/CanvasLayer/HP2")
		hp_control.set_hp(hp_control.hp - 1)
		if hp_control.hp == 0:
			emit_signal("gameover")
