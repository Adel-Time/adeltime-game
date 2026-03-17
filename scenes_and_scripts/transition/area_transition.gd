extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true
	$Animation.play("transition")
	$Background.visible = true

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "transition":
		get_tree().paused = false
