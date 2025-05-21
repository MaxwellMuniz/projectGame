extends Node2D

var current_state: State
var previous_state: State
var debug: Label
var player: CharacterBody2D

func _ready():
	debug = get_tree().get_current_scene().get_node("Debug") as Label
	player = get_tree().get_current_scene().get_node("Players") as CharacterBody2D

	print("Debug node:", debug)
	print("Player node:", player)

	current_state = get_child(0) as State
	previous_state = current_state

	current_state.debug = debug
	current_state.player = player

	current_state.enter()

	set_process(true)

func change_state(state_name: String):
	var next_state = find_child(state_name) as State

	if next_state and next_state != current_state:
		previous_state.exit()

		next_state.debug = debug
		next_state.player = player

		current_state = next_state
		current_state.enter()

		previous_state = current_state

func _process(_delta):
	if debug and current_state:
		debug.text = "%s" % current_state.name
