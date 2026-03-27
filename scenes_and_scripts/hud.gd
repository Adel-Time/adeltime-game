extends CanvasLayer

func _ready() -> void:
	$Hearts.play("three")
	$AdelFace.play("normal_happy")

func _process(_delta: float) -> void:
	if AdelManager.health == 3:
		$Hearts.play("three")
		$AdelFace.play("normal_happy")
	elif AdelManager.health == 2:
		$Hearts.play("two")
		$AdelFace.play("normal")
	elif AdelManager.health == 1:
		$Hearts.play("one")
		$AdelFace.play("what")
	else:
		$Hearts.play("zero")
		$AdelFace.play("eyes_closed")
