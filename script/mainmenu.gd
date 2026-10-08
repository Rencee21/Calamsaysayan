extends Node2D
@onready var start: Button = $"Button Manager/Start"
@onready var options: Button = $"Button Manager/Options"
@onready var quit: Button = $"Button Manager/Quit"

func _ready() -> void:
	apply_translation()
	if Engine.has_singleton("QuestNotification"):
		QuestNotification.visible = false
	
func apply_translation():
	start.text = LanguageManager.get_text("start")
	options.text = LanguageManager.get_text("options")
	quit.text = LanguageManager.get_text("quit")
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/contro_system_instruction.tscn")
	
func _on_options_pressed() -> void:
	var options = preload("res://scene/option.tscn").instantiate()
	options.return_to_main = true
	add_child(options)
	
func _on_quit_pressed() -> void:
	get_tree().quit()
