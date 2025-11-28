extends CharacterBody2D

# Enemy speed
@export var speed: float = 100.0

# Reference to the player
var player: Node2D

func _ready():
	# Find the player by name
	player = get_tree().get_root().find_node("eva_lol", true, false)

func _physics_process(delta):
	if player != null:
		# Calculate direction
		var direction = (player.global_position - global_position).normalized()
		# Move enemy
		velocity = direction * speed
		move_and_slide()
