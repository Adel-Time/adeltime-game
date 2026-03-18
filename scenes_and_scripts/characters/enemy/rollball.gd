extends Enemy

func _ready() -> void:
	super()
	$Image.play("walk")
	speed = 180

func _on_player_detector_area_entered(area) -> void:
	if area.is_in_group("Stomp"):
		# TODO: Prevent player from being damaged by enemy below when on slope
		if area.get_parent().get_real_velocity().y > 0:
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
