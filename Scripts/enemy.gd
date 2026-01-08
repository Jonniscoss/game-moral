extends CharacterBody2D

@export var speed := 100.0
@export var message_label: Label
@export var drop_item: PackedScene
var health := 40
var player: Node2D

func _ready():
	add_to_group("enemy")
	player = get_tree().current_scene.get_node("Eva")
	randomize()

func _physics_process(delta):
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func take_damage(amount: int):
	health -= amount
	if message_label:
		message_label.show_message()
	if health <= 0:
		if drop_item and randf() < 0.3:
			var item = drop_item.instantiate()
			item.position = global_position 
			get_tree().current_scene.add_child(item)
		queue_free()
