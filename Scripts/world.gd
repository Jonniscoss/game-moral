extends Node2D

@onready var pauseMenu = $Camera2D/Settings
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Settings"):
		pause_menu()

func pause_menu():
	if paused:
		pauseMenu.hide()
		get_tree().paused = false
	else:
		pauseMenu.show()
		get_tree().paused = true
	paused = !paused
