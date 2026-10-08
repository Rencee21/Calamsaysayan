extends Node2D

func _ready() -> void:
	var player = $player
	player.position = Global.get_entry_position("RizalShrine")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):   # Detect ESC key press
		_open_options_menu()

func _open_options_menu() -> void:
	get_tree().paused = true
	var options = preload("res://scene/option.tscn").instantiate()
	options.return_to_main = false
	add_child(options)
	options.grab_focus()
