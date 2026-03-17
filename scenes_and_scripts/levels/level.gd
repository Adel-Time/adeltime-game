extends Node2D
class_name Level

@export var area_name = "Add Name"
@export var part_number = "0"

func _ready() -> void:
	AdelManager.health = AdelManager.max_health
	$Misc/AreaTransition/Area.clear()
	$Misc/AreaTransition/Area.add_text(area_name + " Area")
	$Misc/AreaTransition/Part.append_text(part_number)
