extends Node2D

func _ready():

	$Player.connect("gameover", Callable(self, "_on_player_gameover"))
	$Player2.connect("gameover", Callable(self, "_on_player_gameover"))

func _on_player_gameover() -> void:
	$GameOverSfx.play()
	var timer = get_tree().create_timer(2)
	get_tree().paused = true
	await timer.timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
