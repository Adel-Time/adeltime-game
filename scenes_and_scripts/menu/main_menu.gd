extends Node2D

func _ready() -> void:
	AdelManager.health = AdelManager.max_health

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes_and_scripts/intro/present_intro.tscn")
