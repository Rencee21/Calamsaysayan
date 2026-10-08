extends Panel

@onready var panel: Panel = $Panel
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_4: Label = $Label4
@onready var label_5: Label = $Label5
@onready var label_6: Label = $Label6
@onready var label_7: Label = $Label7

@onready var player: Sprite2D = $player
@onready var quest: Sprite2D = $Quest
@onready var a_icon: Sprite2D = $AIcon
@onready var c_icon: Sprite2D = $"CIcon-removebg-preview"
@onready var x_icon: Sprite2D = $XIcon
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var next: Button = $Next
@onready var map: Button = $Map

var first_loop_done := false

func _ready() -> void:
	apply_translation()
	# Hide buttons at the start
	next.visible = false
	map.visible = false

	# Connect the animation_finished signal
	animation_player.animation_finished.connect(_on_animation_finished)

	# Play animation if it exists
	if animation_player.has_animation("tips_kalanbanga"):
		animation_player.play("tips_kalanbanga")
	else:
		print("⚠️ No animation named 'tips_kalanbanga' found in AnimationPlayer.")
		_show_buttons()

func apply_translation():
	label.text = LanguageManager.get_text("tips")
	label_2.text = LanguageManager.get_text("t_banga2")
	label_3.text = LanguageManager.get_text("t_banga3")
	label_4.text = LanguageManager.get_text("t_banga4")
	label_5.text = LanguageManager.get_text("t_banga5")
	label_6.text = LanguageManager.get_text("t_banga6")
	label_7.text = LanguageManager.get_text("t_banga7")
	next.text = LanguageManager.get_text("next")
	map.text = LanguageManager.get_text("go_map")
	


func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "tips_kalanbanga":
		if not first_loop_done:
			# Show buttons after the first full loop
			_show_buttons()
			first_loop_done = true
		
		# Replay the animation (loop effect)
		animation_player.play("tips_kalanbanga")


func _show_buttons() -> void:
	next.visible = true
	map.visible = true


func _on_map_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map.tscn")


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/kalan_banga.tscn")
