extends Area2D

const FILE_BEGIN = "res://chapter_"

func _on_body_entered(body):
	if body.is_in_group("Players"):
		print("🎉 Portale attraversato")
		var current_scene_path = get_tree().current_scene.scene_file_path
		var filename = current_scene_path.get_file().get_basename()
		var current_level_number = filename.get_slice("_", 1).to_int()
		var next_level_path = FILE_BEGIN + str(current_level_number + 1) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
