extends Panel

@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_4: Label = $Label4
@onready var label_5: Label = $Label5
@onready var label_6: Label = $Label6
@onready var label_7: Label = $Label7
@onready var label_9: Label = $Label9
@onready var label_10: Label = $Label10

@onready var button_puzzle: Sprite2D = $button_puzzle
@onready var button_puzzle_2: Sprite2D = $button_puzzle2
@onready var button_puzzle_3: Sprite2D = $button_puzzle3
@onready var button_puzzle_4: Sprite2D = $button_puzzle4
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var map: Button = $Map
@onready var next: Button = $Next

var first_loop_done := false

func _ready() -> void:
	apply_translation()
	# Hide buttons at the start
	next.visible = false
	map.visible = false

	# Connect the signal to detect animation completion
	animation_player.animation_finished.connect(_on_animation_finished)

	# Play "tips_church" animation if it exists
	if animation_player.has_animation("tips_church"):
		animation_player.play("tips_church")
	else:
		print("⚠️ No animation named 'tips_church' found in AnimationPlayer.")
		_show_buttons()

func apply_translation():
	label.text = LanguageManager.get_text("tips")
	label_2.text = LanguageManager.get_text("t_church1")
	label_3.text = LanguageManager.get_text("t_church2")
	label_4.text = LanguageManager.get_text("t_church3")
	label_9.text = LanguageManager.get_text("t_church4")
	label_10.text = LanguageManager.get_text("t_church5")
	
	next.text = LanguageManager.get_text("next")
	map.text = LanguageManager.get_text("go_map")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "tips_church":
		if not first_loop_done:
			# Show buttons after the first loop
			_show_buttons()
			first_loop_done = true
		
		# Loop the animation forever
		animation_player.play("tips_church")


func _show_buttons() -> void:
	next.visible = true
	map.visible = true


func _on_map_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map.tscn")


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/church.tscn")
