extends Panel

@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_4: Label = $Label4
@onready var label_5: Label = $Label5
@onready var label_6: Label = $Label6
@onready var label_7: Label = $Label7
@onready var label_8: Label = $Label8
@onready var label_9: Label = $Label9
@onready var label_10: Label = $Label10
@onready var label_11: Label = $Label11
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var map: Button = $Map
@onready var next: Button = $Next

var first_loop_done := false

func _ready() -> void:
	apply_translation()
	# Hide buttons at the start
	next.visible = false
	map.visible = false

	# Connect the animation finished signal
	animation_player.animation_finished.connect(_on_animation_finished)

	# Play "tips_ccc" animation if it exists
	if animation_player.has_animation("tips_ccc"):
		animation_player.play("tips_ccc")
	else:
		print("⚠️ No animation named 'tips_ccc' found in AnimationPlayer.")
		_show_buttons()

func apply_translation():
	label.text = LanguageManager.get_text("trivia")
	label_3.text = LanguageManager.get_text("dyk")
	label_2.text = LanguageManager.get_text("t_ccc1")
	label_4.text = LanguageManager.get_text("facts")
	label_5.text = LanguageManager.get_text("t_ccc2")
	label_6.text = LanguageManager.get_text("dyk")
	label_7.text = LanguageManager.get_text("t_ccc3")
	label_8.text = LanguageManager.get_text("dyk")
	label_9.text = LanguageManager.get_text("t_ccc4")
	label_10.text = LanguageManager.get_text("facts")
	label_11.text = LanguageManager.get_text("t_ccc5")
	next.text = LanguageManager.get_text("next")
	map.text = LanguageManager.get_text("go_map")
	
func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "tips_ccc":
		if not first_loop_done:
			# After the first loop, show the buttons
			_show_buttons()
			first_loop_done = true
		
		# Replay animation to loop continuously
		animation_player.play("tips_ccc")


func _show_buttons() -> void:
	next.visible = true
	map.visible = true


func _on_map_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map.tscn")


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/assessment.tscn")
