extends Control

func _on_start_pressed() -> void:
	GameData.difficulty = "easy"
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_hard_pressed() -> void:
	print("start(hard)")
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	
func _on_exit_pressed() -> void:
	print("quitting")
	get_tree().quit()
