extends Node2D
class_name State

var debug: Label
var player: CharacterBody2D
@onready var animation_player = owner.find_child("AnimationPlayer")

func _ready():
	set_physics_process(false)

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass

func _physics_process(_delta):
	transition()
	# Rimosso aggiornamento debug qui per evitare conflitti
