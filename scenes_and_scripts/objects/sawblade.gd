@tool
extends Node2D

## If true, sawblade will not move. Only enable one at a time. If you set this, save the sawblade scene and look back at the level.
@export var not_moving = true
## If true, sawblade will move vertically. Only enable one at a time. If you set this, save the sawblade scene and look back at the level.
@export var moving_vertical = false
## If true, sawblade will move horizontally. Only enable one at a time. If you set this, save the sawblade scene and look back at the level.
@export var moving_horizontal = false
## If true, sawblade will move in a circle. Only enable one at a time. If you set this, save the sawblade scene and look back at the level.
@export var moving_circle = false
# so basically i'm a complete idiot! and it turns out i set up the sawblade wrong. 
# this can't be done right now in this sawblade scene because of that. wow!
# @export var spin = false

func _ready() -> void:
	if not_moving:
		$Tween.play("do_not_move")
		
	if moving_horizontal:
		$Tween.play("horizontal")
	elif moving_vertical:
		$Tween.play("vertical")

func _on_collision_body_entered(body) -> void:
	if body.is_in_group("Player"):
		body.damage(1)
