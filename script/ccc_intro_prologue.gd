extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var panel: Panel = $Panel
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_4: Label = $Label4
@onready var label_5: Label = $Label5
@onready var label_6: Label = $Label6
@onready var label_7: Label = $Label7
@onready var back: Button = $Back
@onready var button: Button = $Button

func _ready() -> void:
	apply_translation()
	print("🎬 CCC Intro Prologue loaded.")

	# Hide buttons at start
	button.visible = false
	back.visible = false

	# Check if animation has already played
	if not GameState.ccc_intro_played:
		if animation_player.has_animation("ccc_intro_anim"):
			print("▶️ Playing CCC intro animation for the first time.")
			animation_player.play("ccc_intro_anim")
			GameState.ccc_intro_played = true
			animation_player.animation_finished.connect(_on_animation_finished)
		else:
			push_warning("⚠️ Animation 'ccc_intro_anim' not found in AnimationPlayer!")
			button.visible = true
			back.visible = true
	else:
		# Already played → skip animation, show buttons immediately
		print("⏩ CCC intro already played. Skipping animation.")
		button.visible = true
		back.visible = true
		if animation_player.is_playing():
			animation_player.stop()

func apply_translation():
	label.text = LanguageManager.get_text("ccc_prologue")
	label_2.text = LanguageManager.get_text("ccc_prologue2")
	label_3.text = LanguageManager.get_text("ccc_prologue3")
	label_4.text = LanguageManager.get_text("ccc_prologue4")
	label_5.text = LanguageManager.get_text("ccc_prologue5")
	label_6.text = LanguageManager.get_text("ccc_prologue6")
	label_7.text = LanguageManager.get_text("ccc_prologue7")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "ccc_intro_anim":
		print("✅ CCC intro animation finished. Showing buttons.")
		button.visible = true
		back.visible = true

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/cut_scene_prologue.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/map.tscn")
