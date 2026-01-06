extends CharacterBody2D

@export var speed: float = 120.0
@export var message_label: Label
var player: Node2D

func _ready():
	randomize()
	player = get_tree().current_scene.get_node("Eva")
	var time = randf_range(8.0, 12.0)
	$Timer.wait_time = time
	$Timer.start()

func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func _on_timer_timeout() -> void:
	speed += 25

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Eva" and message_label != null:
		message_label.show_message()
	else:
		queue_free()
