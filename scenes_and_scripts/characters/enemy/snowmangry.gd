extends Enemy

func _ready() -> void:
	super()
	$Image.play("walk")
	
func _physics_process(delta: float) -> void:
	super(delta)
	
	if direction == -1:
		$Collision.position.x = 25.0
		$PlayerDetector/Collision.position.x = 25.0
	else:
		$Collision.position.x = 29.0
		$PlayerDetector/Collision.position.x = 29.0

func _on_player_detector_area_entered(area) -> void:
	if area.is_in_group("Stomp"):
		if area.get_parent().velocity.y > 0:
			death()
			print(":3")
			area.get_parent().stomp_bounce()

func _on_player_detector_body_entered(body) -> void:
	if body.is_in_group("Player") and not dead:
		body.damage(1)

func move():
	if not dead:
		velocity.x = direction * speed
	else:
		velocity.x = 0
