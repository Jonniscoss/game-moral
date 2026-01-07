extends Node2D

@export var enemy_prefab: PackedScene
@export var message_label: Label
@export var ground_position: Vector2
@export var ground_size: Vector2

func _ready():
	randomize()

func _on_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.message_label = message_label  # now valid

	var spawn_x = randf_range(0, ground_size.x)
	var spawn_y = randf_range(0, ground_size.y)
	enemy.position = ground_position + Vector2(spawn_x, spawn_y)

	add_child(enemy)
