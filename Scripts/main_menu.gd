extends Control

func _on_start_pressed() -> void:
	DropManager._ready()
	GameData.difficulty = "easy"
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_hard_pressed() -> void:
	DropManager._ready()
	print("start(hard)")
	GameData.difficulty = "hard"
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_exit_pressed() -> void:
	print("quitting")
	get_tree().quit()
