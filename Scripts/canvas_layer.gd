extends CanvasLayer

@onready var rich_label := $Panel/TextureRect/RichTextLabel
@onready var close_button := $Panel/Button

var last_drop := false

func _ready():
	visible = false
	rich_label.visible = false

func show_text(text: String, is_last := false):
	visible = true
	rich_label.bbcode_enabled = true
	rich_label.bbcode_text = text
	rich_label.visible = true

	last_drop = is_last
	get_tree().paused = true

func hide_text():
	rich_label.visible = false
	visible = false
	get_tree().paused = false

	if last_drop:
		last_drop = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_close_pressed() -> void:
	hide_text()
