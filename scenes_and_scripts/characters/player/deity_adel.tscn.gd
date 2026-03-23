extends CharacterBody2D

# code from a scrapped game and also a tutorial, but it's probably pretty different now

# Movement
var speed = 600.0
var acceleration = 1500
var deceleration = 1600
var min_jump_height = 512.0
var max_jump_height = 576.0
var decelerate_on_jump_release = 0.5

# Stomp node variable because enemies
@onready var stomp = $Stomp

# Cutscene
var in_cutscene = false
var can_take_damage = true

# Invincibility Frames
var inv_frames = 1

# Animation
var facing_direction = 1

func _ready() -> void:
	AdelManager.health = AdelManager.max_health
	add_to_group("Player")
	stomp.add_to_group("Stomp")

func _physics_process(delta: float) -> void:
	# If position.x is lower than 0, set position to 0.
	# Needed so the player doesn't go off-screen towards the left
	if position.x < 0:
		position.x = 0
	
	if position.y > $Camera.limit_bottom - $Collision.shape.size.y:
		position.y = $Camera.limit_bottom - $Collision.shape.size.y
	
	if position.x > $Camera.limit_right - $Collision.shape.size.x:
		position.x = $Camera.limit_right - $Collision.shape.size.x

	# thanks godot forum
	var direction = Input.get_vector("player_left", "player_right", "player_jump", "player_down")
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		
	if velocity.x > 0:
		facing_direction = 1
	if velocity.x < 0:
		facing_direction = -1
	
	if not facing_direction == 0 and in_cutscene == false:
		$Image.flip_h = facing_direction < 0
	
	animate()

	move_and_slide()

func animate():
	if not in_cutscene:
		if velocity == Vector2(0, 0):
			$Image.play("stand")
		else:
			$Image.play("walk")

func heal(amount: int):
	if not AdelManager.health >= AdelManager.max_health:
		AdelManager.health += amount

func damage(amount: int):
	if can_take_damage:
		print("3:")
		AdelManager.health -= amount
		can_take_damage = false

		await get_tree().create_timer(1).timeout
		can_take_damage = true

func stomp_bounce():
	if Input.is_action_pressed("player_jump"):
		velocity.y = -min_jump_height
	else:
		velocity.y = -min_jump_height / 2
