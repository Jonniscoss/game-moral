extends CharacterBody2D

const SPEED = 100.0

func _physics_process(_delta):
	player_movement()

func player_movement():
	if Input.is_action_pressed("WalkLeft"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("WalkRight"):
		velocity.x = SPEED
	elif Input.is_action_pressed("WalkUp"):
		velocity.y = -SPEED
	elif Input.is_action_pressed("WalkDown"):
		velocity.y = SPEED
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()
