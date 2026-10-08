extends Sprite2D

func press():
	frame = 2
func unpress():
	frame = 1
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		unpress()
