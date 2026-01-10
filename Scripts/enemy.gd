extends CharacterBody2D

@export var speed := 100.0
@export var message_label: Label
@export var drop_item: PackedScene
var health := 40
var player: Node2D

func _ready():
	add_to_group("Enemy")
	player = get_tree().current_scene.get_node("Eva")
	randomize()
	
func show_message(text: String, duration: float = 1.0) -> void:
	if message_label == null:
		return
	message_label.text = text
	message_label.visible = true
	message_label.global_position = global_position + Vector2(0, -50)
	await get_tree().create_timer(duration).timeout
	message_label.visible = false

func _physics_process(delta):
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	
	if velocity.x<0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x>0 :
		$AnimatedSprite2D.flip_h = true
	move_and_slide()

var drop_texts := [
	"LOOT",
	"SCROLL",
	"PAPER",
	"SOMETHING"
]

func get_drop_text() -> String:
	return drop_texts.pick_random()

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		$AnimatedSprite2D.play("Die")
		if drop_item and randf() < 1:
			var item = drop_item.instantiate()
			item.pickup_text = get_drop_text()
			item.position = global_position 
			get_tree().current_scene.add_child(item)
			var text_box = get_tree().get_first_node_in_group("item_text_box")
			if text_box:
				item.picked_up.connect(text_box.show_text)
			else:
				push_error("ItemTextBox not found!")
		speed = 0
		$Shots.queue_free()
		$Area2D/Kill.queue_free()
		await $AnimatedSprite2D.animation_finished
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		if message_label:
			message_label.show_message()
		player.queue_free()
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
