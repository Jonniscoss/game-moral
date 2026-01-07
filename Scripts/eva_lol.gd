extends CharacterBody2D

const SPEED = 150.0
var LastDir := Vector2.ZERO

func _ready():
	add_to_group("player")

func _physics_process(_delta):
	player_movement()

func player_movement():
	#reset velocity
	velocity = Vector2.ZERO
	
	#Last direction input
	if Input.is_action_just_pressed("WalkLeft"):
		LastDir = Vector2(-1,0)
	elif Input.is_action_just_pressed("WalkRight"):
		LastDir = Vector2(1,0)
	elif Input.is_action_just_pressed("WalkUp"):
		LastDir = Vector2(0,-1)
	elif Input.is_action_just_pressed("WalkDown"):
		LastDir = Vector2(0,1)
	
	#movement
	if Input.is_action_pressed("WalkLeft") and LastDir == Vector2(-1,0):
		velocity.x = -SPEED
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Walk")
	elif Input.is_action_pressed("WalkRight")  and LastDir == Vector2(1,0):
		velocity.x = SPEED
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Walk")
	elif Input.is_action_pressed("WalkUp")  and LastDir == Vector2(0,-1):
		velocity.y = -SPEED
		$AnimatedSprite2D.play("WalkUp")
	elif Input.is_action_pressed("WalkDown")  and LastDir == Vector2(0, 1):
		velocity.y = SPEED
		$AnimatedSprite2D.play("Walk Down")
	else:
		$AnimatedSprite2D.play("Idle")
	move_and_slide()
