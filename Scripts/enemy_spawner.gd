extends Node2D

@export var enemy_prefab: PackedScene
@export var player: CharacterBody2D  # DRAG YOUR PLAYER NODE HERE IN INSPECTOR
@export var message_label: Label
@export var spawn_interval = 0.95
@export var ground_position: Vector2 = Vector2(0, 0)
@export var ground_size: Vector2 = Vector2(2000,1200)
@export var min_spawn_distance = 400
@export var max_spawn_attempts = 6000

var spawn_timer: Timer

func _ready():
	print("========================================")
	print("SPAWNER STARTING")
	print("========================================")
	
	# Check player
	if player == null:
		print("ERROR: Player not assigned! Drag the Eva node into the 'Player' field in the inspector!")
		return
	else:
		print("✓ Player found: ", player.name)
		print("✓ Player position: ", player.global_position)
	
	# Check enemy prefab
	if enemy_prefab == null:
		print("ERROR: enemy_prefab not assigned! Drag your snake scene into 'Enemy Prefab' field!")
		return
	else:
		print("✓ Enemy prefab assigned")
	
	# Create timer
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.timeout.connect(_spawn_enemy)
	add_child(spawn_timer)
	print("✓ Timer created (spawning every ", spawn_interval, " seconds)")
	print("========================================")

func _spawn_enemy() -> void:
	print("\n--- Attempting to spawn enemy ---")
	
	if player == null or not is_instance_valid(player):
		print("ERROR: Player is invalid!")
		return
	
	if enemy_prefab == null:
		print("ERROR: Enemy prefab is null!")
		return
	
	var spawn_pos: Vector2
	var found_valid_position := false
	
	for attempt in range(max_spawn_attempts):
		spawn_pos = ground_position + Vector2(
			randf_range(0, ground_size.x),
			randf_range(0, ground_size.y)
		)
		
		var distance_to_player = spawn_pos.distance_to(player.global_position)
		
		if distance_to_player >= min_spawn_distance and is_position_clear(spawn_pos):
			found_valid_position = true
			print("✓ Found spawn at distance: ", distance_to_player, " (attempt ", attempt + 1, ")")
			break
	
	if found_valid_position:
		var enemy = enemy_prefab.instantiate()
		enemy.global_position = spawn_pos
		if message_label:
			enemy.message_label = message_label
		get_parent().add_child(enemy)
		print("✓ ENEMY SPAWNED at: ", spawn_pos)
	else:
		print("✗ Could not find valid spawn position")

func is_position_clear(pos: Vector2) -> bool:
	var blockers = get_tree().get_nodes_in_group("SpawnBlockers")
	
	for blocker in blockers:
		var collision_shape = blocker.get_node_or_null("CollisionShape2D")
		if collision_shape == null or collision_shape.shape == null:
			continue
		
		var shape = collision_shape.shape
		var blocker_pos = blocker.global_position
		
		if shape is RectangleShape2D:
			var half_size = shape.size / 2.0
			var rect = Rect2(blocker_pos - half_size, shape.size)
			if rect.has_point(pos):
				return false
				
		elif shape is CircleShape2D:
			if pos.distance_to(blocker_pos) <= shape.radius:
				return false
	return true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("\n!!! SPACEBAR - FORCING SPAWN !!!")
		_spawn_enemy()
