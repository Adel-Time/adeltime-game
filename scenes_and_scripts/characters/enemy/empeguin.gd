extends Enemy

# Empeguin doesn't entirely work yet.

var rollball_jump = 256

const rollball = preload("res://scenes_and_scripts/characters/enemy/rollball_projectile.tscn")
var busy = false

func _ready() -> void:
	super()
	$Image.play("stand")

func _physics_process(delta: float) -> void:
	super(delta)
	
	if direction == -1:
		$Collision.position.x = 56.5
		$PlayerDetector/Collision.position.x = 56.5
	else:
		$Collision.position.x = 39.5
		$PlayerDetector/Collision.position.x = 39.5

func move():
	# i dont trust godot so that's why $Enabler.is_on_screen() is there
	# i hope this code doesn't look like a mess! although as long as it works, it's fine.
	if not dead and $Enabler.is_on_screen() and not busy:
		busy = true
		await get_tree().create_timer(0.25).timeout
		$Image.play("throw")
		var rollball2 = rollball.instantiate()
		get_tree().current_scene.add_child(rollball2)
		rollball2.position = self.position + Vector2(0, 27)
		rollball2.velocity.y = -rollball_jump
		rollball2.direction = direction
		await get_tree().create_timer(0.2).timeout
		if not dead:
			$Image.play("stand")
			await get_tree().create_timer(2.8).timeout
		busy = false
		
		if dead:
			$Image.play("squished")

func _on_player_detector_area_entered(area) -> void:
	if area.is_in_group("Stomp"):
		if area.get_parent().velocity.y > 0:
			death()
			print(":3")
			area.get_parent().stomp_bounce()

func _on_player_detector_body_entered(body) -> void:
	if body.is_in_group("Player") and not dead:
		body.damage(1)
