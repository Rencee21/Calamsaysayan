extends Sprite2D

var current_frame_index := 5
const MIN_FRAME := 5
const MAX_FRAME := 6
var timer := 0.0

func _process(delta: float) -> void:
	timer += delta
	if timer >= 0.2:
		timer = 0.0
		frame = current_frame_index
		current_frame_index += 1
		if current_frame_index > MAX_FRAME:
			current_frame_index = MIN_FRAME
