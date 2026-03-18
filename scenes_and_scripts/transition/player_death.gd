extends CanvasLayer

var death = false

func _ready() -> void:
	$BlackRectangle.visible = false

func _process(_delta: float) -> void:
	if AdelManager.health <= 0 && death == false:
		death = true
		get_tree().paused = true
		$Audio.play()
		$Fade.play("fade_in")
		$BlackRectangle.visible = true

func _on_fade_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		await get_tree().create_timer(7).timeout
		get_tree().reload_current_scene()
