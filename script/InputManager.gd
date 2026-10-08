extends Node

signal interact_pressed

# Called ONLY when the TouchScreenButton is pressed
func _on_touchscreenbutton_pressed() -> void:
	print("📲 Interact_Touch pressed")
	emit_signal("interact_pressed")
