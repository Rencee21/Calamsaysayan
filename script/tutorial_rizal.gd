extends Panel

@onready var panel: Panel = $Panel
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_4: Label = $Label4
@onready var setting_icon: Sprite2D = $SettingIcon
@onready var exclamation: Sprite2D = $Exclamation
@onready var portal: Sprite2D = $portal
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var map: Button = $Map
@onready var next: Button = $Next

var first_loop_done := false

func _ready() -> void:
	apply_translation()
	# Hide buttons at the start
	next.visible = false
	map.visible = false

	# Connect signal for animation finished
	animation_player.animation_finished.connect(_on_animation_finished)

	# Play "tips_rizal" animation if it exists
	if animation_player.has_animation("tips_rizal"):
		animation_player.play("tips_rizal")
	else:
		print("⚠️ No animation named 'tips_rizal' found in AnimationPlayer.")
		_show_buttons()

func apply_translation():
	label.text = LanguageManager.get_text("tips")
	label_2.text = LanguageManager.get_text("t_rizal1")
	label_3.text = LanguageManager.get_text("t_rizal2")
	label_4.text = LanguageManager.get_text("t_rizal3")
	next.text = LanguageManager.get_text("next")
	map.text = LanguageManager.get_text("go_map")
	
	
func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "tips_rizal":
		if not first_loop_done:
			# After the first loop, show the buttons
			_show_buttons()
			first_loop_done = true
		
		# Replay animation to loop forever
		animation_player.play("tips_rizal")


func _show_buttons() -> void:
	next.visible = true
	map.visible = true


func _on_map_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map.tscn")


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/rizal_shrine.tscn")
