extends Node2D
class_name Level

## Shows up in the level intro. The word "Area" is automatically added at the end, so no need to add it here.
@export var area_name = "Add Name"
## Shows up in the level intro.
@export var part_number = "0"

func _ready() -> void:
	AdelManager.health = AdelManager.max_health
	$Misc/AreaTransition/Area.clear()
	$Misc/AreaTransition/Area.add_text(area_name + " Area")
	$Misc/AreaTransition/Part.append_text(part_number)
