extends CharacterBody2D

@export var speed := 100.0
@export var drop_item: PackedScene
var health := 40
var player: Node2D

func _ready():
	add_to_group("Enemy")
	player = get_tree().current_scene.get_node("Eva")
	randomize()

func _physics_process(delta):
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		$AnimatedSprite2D.play("Die")
		
		if drop_item and randf() <= 0.07:
			var text = DropManager.get_drop_text()
			if text != "null":
				# Spawn the scroll item
				var item = drop_item.instantiate()
				item.pickup_text = text
				item.global_position = global_position
				get_tree().current_scene.add_child(item)

				# Find the popup and counter layers
				var popup = get_tree().get_first_node_in_group("item_text_box")
				var counter_layer = get_tree().get_first_node_in_group("scroll_counter_layer")

				# Connect the pickup signal
				item.picked_up.connect(func(text):
					# Increment collected count **only on pickup**
					DropManager.mark_collected()

					# Update counter
					if counter_layer:
						counter_layer.update_counter()

					# Check if this is the last scroll
					var last = DropManager.is_last_drop()

					# Show the scroll popup
					if popup:
						popup.show_text(text, last)
				)

		# Disable enemy after death
		speed = 0
		$Shots.queue_free()
		$Area2D/Kill.queue_free()
		await $AnimatedSprite2D.animation_finished
		queue_free()
