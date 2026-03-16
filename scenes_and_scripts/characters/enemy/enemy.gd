extends CharacterBody2D

class_name Enemy

# Falling
var fall_force = 128
var dieFall = false

# Movement
var speed = 120
## -1 = left, 1 = right
@export var direction = -1

# Gravity
var apply_gravity = true

# imagine if godot was good. i have no idea how this managed to work but i think my brain might have grown
var was_on_wall = false

# this is here to prevent enemies from damaging the player when the player stomps on the enemy 
# because godot said FUCK YOU when i added the death function and refused to let enemies work correctly
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Enemy")
	
	# here to prevent bugs
	if direction > 1:
		direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if apply_gravity:
		if not is_on_floor():
			velocity += get_gravity() * delta
			
	move()
	
	if is_on_wall() and not was_on_wall:
		flip_direction()
	
	if direction == -1:
		$Image.flip_h = true
	else:
		$Image.flip_h = false
	
	# absolutely giant brain
	was_on_wall = is_on_wall()
	
	move_and_slide()

func flip_direction():
	direction = -direction
	
func move():
	pass

func death():
	dead = true
	$Collision.set_deferred("disabled", "true")
	$PlayerDetector.set_deferred("monitoring", "false")
	$PlayerDetector.set_deferred("monitorable", "false")
	$Image.play("squished")
