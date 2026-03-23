@tool
extends Node2D

# this is gonna be way different than sawblade because this is a better way i just thought of. remind me to add this to sawblade if i dont.
enum MovingPlatformStates {no_move, horizontal, vertical, horizontal_reverse, vertical_reverse}

@export var current_state = MovingPlatformStates.no_move:
	set(value):
		current_state = value
		_ready()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# we are in if statement hell
	if current_state == MovingPlatformStates.no_move:
		$MovingPlatform/Tween.play("no_move")
	elif current_state == MovingPlatformStates.horizontal:
		$MovingPlatform/Tween.play("horizontal")
	elif current_state == MovingPlatformStates.vertical:
		$MovingPlatform/Tween.play("vertical")
	elif current_state == MovingPlatformStates.horizontal_reverse:
		$MovingPlatform/Tween.play("horizontal_reverse")
	elif current_state == MovingPlatformStates.vertical_reverse:
		$MovingPlatform/Tween.play("vertical_reverse")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
