extends Area2D

const SPEED := 300
const ROTATION_STEP := deg_to_rad(90)

@onready var sprite = $Sprite2D 

func _process(delta):
	position += transform.x * SPEED * delta
	#drotation += ROTATION_STEP * delta
	sprite.rotation += ROTATION_STEP * delta 
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		if GameData.difficulty == "easy":
			print("HIT:", body)
			body.take_damage(20)
			queue_free()
		elif GameData.difficulty == "hard":
			print("HIT:", body)
			body.take_damage(10)
			queue_free()
		else:
			return
