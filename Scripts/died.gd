extends Label

@export var fade_time: float = 1.5
@export var message_text: String = "Enemy touched you!"

func _ready():
	modulate.a = 0

func show_message():
	text = message_text
	modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, fade_time)
