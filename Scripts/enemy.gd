extends CharacterBody2D

@export var speed: float = 100.0
var player: Node2D

func _ready():
	player = get_tree().current_scene.get_node("Eva")

func _physics_process(delta):
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
