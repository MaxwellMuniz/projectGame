extends Node

var players_alive := 2
var ghost_count := 0

func _ready():
	# Aspetta che la scena sia completamente pronta prima di cercare il Portale
	call_deferred("_initialize")

func _initialize():
	ghost_count = get_tree().get_nodes_in_group("ghosts").size()
	print("Fantasmi iniziali:", ghost_count)

	var portal = get_node_or_null("/root/game/Portal")
	if portal:
		portal.visible = false
		portal.monitoring = false
	else:
		print("⚠️ Portal non trovato")

func _on_player1_gameover() -> void:
	players_alive -= 1
	check_game_over()

func _on_player2_gameover() -> void:
	players_alive -= 1
	check_game_over()

func check_game_over():
	if players_alive <= 0:
		$GameOverSfx.play()
		var timer := get_tree().create_timer(2)
		get_tree().paused = true
		await timer.timeout
		get_tree().paused = false
		get_tree().reload_current_scene()

func on_ghost_died():
	ghost_count -= 1
	print("Fantasma eliminato. Rimasti:", ghost_count)
	if ghost_count <= 0:
		activate_portal()

func activate_portal():
	var portal = get_node_or_null("/root/game/Portal")
	if portal:
		print("✅ Tutti i fantasmi sono morti. Portale attivato!")
		portal.visible = true
		portal.monitoring = true
	else:
		print("⚠️ Portal non trovato durante l'attivazione")
