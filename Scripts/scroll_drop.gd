extends Node2D

var pickup_radius = 30
var pickup_text : String

signal picked_up(text : String)

func _process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		print("Player not found")
		return
	if global_position.distance_to(player.global_position) <= pickup_radius:
		picked_up.emit(pickup_text)
		queue_free()
