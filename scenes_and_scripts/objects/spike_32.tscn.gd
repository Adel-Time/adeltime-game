extends StaticBody2D

# tried out this new thing called "tell godot what the fuck it is", it caused errors.
func _on_collision_body_entered(body) -> void:
	if body.is_in_group("Player"):
		body.damage(1)
