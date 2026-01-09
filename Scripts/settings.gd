extends Control

@onready var main = $"../../"

func _on_continue_pressed() -> void:
	main.pause_menu()

func _on_exit_pressed() -> void:
	if get_tree().paused == true:
		get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
