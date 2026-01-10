extends CanvasLayer

@onready var label := $Panel/Label

func show_text(text: String):
	visible = true
	var Rich_label = $Panel/TextureRect/RichTextLabel
	Rich_label.bbcode_text = text
	Rich_label.visible = true
	get_tree().paused = true
	
func hide_text():
	visible = false
	get_tree().paused = false
	$"../ColorRect".visible = false

func _on_button_pressed() -> void:
	hide_text()
