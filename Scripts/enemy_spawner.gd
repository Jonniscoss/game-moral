extends Node2D

@export var enemy_prefab: PackedScene
@export var message_label: Label
@export var ground_position: Vector2
@export var ground_size: Vector2
@export var player_path: NodePath

@onready var player: CharacterBody2D = get_node(player_path)

const MIN_SPAWN_DISTANCE := 150.0

func _ready():
	randomize()
	
func get_player_radius() -> float:
	var shape = player.get_node("Area2D/Spawn").shape
	if shape is CircleShape2D:
		return shape.radius
	if shape is CapsuleShape2D:
		return shape.radius
	return 0.0

func _on_timer_timeout() -> void:
	if player == null:
		return

	var enemy = enemy_prefab.instantiate()
	enemy.message_label = message_label

	var min_distance = get_player_radius() + 50.0
	var spawn_position: Vector2
	var attempts := 0

	while attempts < 40:
		attempts += 1

		spawn_position = ground_position + Vector2(
			randf_range(0, ground_size.x),
			randf_range(0, ground_size.y)
		)

		if spawn_position.distance_to(player.global_position) >= min_distance:
			enemy.global_position = spawn_position
			add_child(enemy)
			return

func is_spawn_allowed(pos: Vector2) -> bool:
	for area in get_tree().get_nodes_in_group("SpawnBlockers"):
		if area.get_global_rect().has_point(pos):
			return false
	return true
