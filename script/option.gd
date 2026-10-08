extends Control

@export var pause_mode_setting: Node.ProcessMode = Node.PROCESS_MODE_ALWAYS
@onready var check_box: CheckBox = $VBoxContainer/CheckBox
@onready var btn_resume: Button = $VBoxContainer/Btn_resume
@onready var btn_back: Button = $VBoxContainer/Btn_back
@onready var check_box_lang: CheckBox = $VBoxContainer/CheckBox_Lang
@onready var label: Label = $Label
@onready var volume_label: Label = $VBoxContainer/Volume_Label
@onready var btn_mainmenu: Button = $VBoxContainer/Mainmenu
@onready var back_to_map: Button = $"VBoxContainer/Back to Map"


var return_to_main: bool = false

func _ready():
	self.process_mode = pause_mode_setting 
	check_box.button_pressed = AudioManager.is_muted
	btn_resume.visible = not return_to_main
	btn_mainmenu.visible = not return_to_main
	back_to_map.visible = not return_to_main
	
	btn_back.visible = return_to_main

	# Set lang checkbox state
	check_box_lang.button_pressed = (LanguageManager.current_language == "fil")
	check_box_lang.toggled.connect(_on_check_box_lang_toggled)

	# Apply translation
	apply_translation()

# === Translation System ===
func apply_translation() -> void:
	btn_resume.text = LanguageManager.get_text("resume")
	btn_back.text = LanguageManager.get_text("back")
	check_box.text = LanguageManager.get_text("mute_music")
	check_box_lang.text = LanguageManager.get_text("language")
	volume_label.text = LanguageManager.get_text("sound")
	label.text = LanguageManager.get_text("options")
	btn_mainmenu.text = LanguageManager.get_text("mainmenu")
	back_to_map.text = LanguageManager.get_text("go_map")
	

# === Button Functions ===
func _on_btn_back_pressed() -> void:
	if return_to_main:
		get_tree().change_scene_to_file("res://scene/mainmenu.tscn")
	else:
		queue_free()
		get_tree().paused = false

func _on_btn_resume_pressed() -> void:
	hide()
	get_tree().paused = false

func _on_back_to_map_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/map.tscn")

func _on_check_box_toggled(button_pressed: bool) -> void:
	AudioManager.set_mute(button_pressed)

# === Language Toggle ===
func _on_check_box_lang_toggled(button_pressed: bool) -> void:
	if button_pressed:
		LanguageManager.set_language("fil")
	else:
		LanguageManager.set_language("en")
	apply_translation()

func _on_mainmenu_pressed() -> void:
	get_tree().paused = false  # ✅ Unpause before changing scene
	get_tree().change_scene_to_file("res://scene/mainmenu.tscn")
