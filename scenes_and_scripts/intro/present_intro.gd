extends Node2D

var textMove = 0.5

func _process(_delta: float) -> void:
	$Text.position.y -= textMove
	
	if Input.is_action_just_pressed("ui_down"):
		textMove += 0.5

	if Input.is_action_just_pressed("ui_up"):
		textMove -= 0.5

	if Input.is_action_just_pressed("ui_space"):
		get_tree().change_scene_to_file("res://scenes_and_scripts/levels/test_level_forest.tscn")
