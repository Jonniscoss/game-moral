extends Node2D

@export var pickup_text: String = ""
signal picked_up(text: String)
@export var pickup_radius := 24.0

func _process(_delta):
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return

	if global_position.distance_to(player.global_position) <= pickup_radius:
		picked_up.emit(pickup_text)
		queue_free()
