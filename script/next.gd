extends Node2D

@onready var btn: Button = $Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var text5: Label = $Label5
@onready var text6: Label = $Label6
@onready var label_7: Label = $Label7

@onready var opt_btn: Button = $Opt_btn
@onready var back: Button = $Back

func _ready() -> void:
	label_7.visible = false
	# Connect signals
	btn.connect("pressed", Callable(self, "_on_next_pressed"))
	back.connect("pressed", Callable(self, "_on_back_pressed"))
	anim_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

	# Connect to LanguageManager signal
	LanguageManager.language_changed.connect(apply_translation)
	apply_translation()

	# Hide buttons at start
	btn.visible = false
	back.visible = false

	# Check if animation has already played
	if not GameState.prologue_played:
		# First time playing → play animation
		anim_player.play("text_5")
		GameState.prologue_played = true
	else:
		# Already played → skip animation, show buttons immediately
		btn.visible = true
		back.visible = true
		label_7.visible = true
		anim_player.stop()

func apply_translation():
	text5.text = LanguageManager.get_text("prologue5")
	text6.text = LanguageManager.get_text("prologue5")
	label_7.text = LanguageManager.get_text("prologue5")
	btn.text = LanguageManager.get_text("next")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "text_5":
		# Show buttons after text_5 animation finishes
		btn.visible = true
		back.visible = true

func _on_next_pressed() -> void:
	# Go to the map scene when Next button is pressed
	get_tree().change_scene_to_file("res://scene/ccc_intro_prologue.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/contro_system_instruction.tscn")
