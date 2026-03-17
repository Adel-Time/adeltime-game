extends CanvasLayer

func _ready() -> void:
	$Hearts.play("three")

func _process(_delta: float) -> void:
	if AdelManager.health == 3:
		$Hearts.play("three")
	elif AdelManager.health == 2:
		$Hearts.play("two")
	elif AdelManager.health == 1:
		$Hearts.play("one")
	else:
		$Hearts.play("zero")
