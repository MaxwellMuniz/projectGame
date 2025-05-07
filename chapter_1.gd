extends Node2D

func _on_player_gameover() -> void:
	$GameOverSfx.play()
	var timer = get_tree().create_timer(1)
	get_tree().paused = true  
	await timer.timeout
	get_tree().paused = false  
	get_tree().reload_current_scene()
