extends CharacterBody2D

# code from a scrapped game and also a tutorial, but it's probably pretty different now

# Movement
var speed = 450.0
var acceleration = 0.05
var deceleration = 0.06
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

	# If position.x is higher than camera limit, Adel dies.
	# Needed so the player doesn't fall forever.
	if position.y > $Camera.limit_bottom:
		AdelManager.health = 0

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Functions
	move()
	animate()

	move_and_slide()

#func die():
	#get_tree().call_deferred("reload_current_scene")

func move():
	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * deceleration)

	if direction == -1:
		facing_direction = -1
	elif direction == 1:
		facing_direction = 1

	if not direction == 0 and in_cutscene == false:
		$Image.flip_h = direction < 0

	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		var current_speed = velocity.x
		if abs(current_speed) == speed:
			velocity.y = -max_jump_height
		else:
			velocity.y = -min_jump_height

	if Input.is_action_just_released("player_jump") and velocity.y < 0:
		velocity.y *= decelerate_on_jump_release

func animate():
	if not in_cutscene:
		if not is_on_floor():
			$Image.play("jump")
		elif not abs(velocity.x) == 0 and not is_on_wall():
			$Image.play("walk")
		else:
			$Image.play("stand")

		if is_on_wall() and is_on_floor():
			$Image.play("stand")

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
