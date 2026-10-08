extends Control
# ===================== NODES =====================
@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var text4: Label = $Label4
@onready var btn_next: Button = $btn_next
@onready var yes_or_no_choice: VBoxContainer = $yes_or_no_choice
@onready var btn_yes: Button = $yes_or_no_choice/btn_yes
@onready var btn_no: Button = $yes_or_no_choice/btn_no
@onready var anim_player: AnimationPlayer = $AnimationPlayer

# ===================== VARIABLES =====================
var dialogue_stage := 0

# ===================== READY =====================
func _ready() -> void:
	apply_translation()
	text1.visible = true
	text2.visible = false
	text3.visible = false
	text4.visible = false
	yes_or_no_choice.visible = false
	
	btn_next.connect("pressed", Callable(self, "_on_next_pressed"))
	btn_yes.connect("pressed", Callable(self, "_on_yes_pressed"))
	btn_no.connect("pressed", Callable(self, "_on_no_pressed"))
	
	if anim_player.has_animation("text_1"):
		anim_player.play("text_1")

func apply_translation():
	text1.text = LanguageManager.get_text("cong1")
	text2.text = LanguageManager.get_text("cong2")
	text3.text = LanguageManager.get_text("cong3")
	text4.text = LanguageManager.get_text("cong4")
	btn_next.text = LanguageManager.get_text("next")
	btn_yes.text = LanguageManager.get_text("yes")
	btn_no.text = LanguageManager.get_text("no")

# ===================== BUTTON LOGIC =====================
func _on_next_pressed() -> void:
	match dialogue_stage:
		0:
			text1.visible = false
			text2.visible = true
			btn_next.visible = false
			yes_or_no_choice.visible = true
			dialogue_stage = 1
			if anim_player.has_animation("text_2"):
				anim_player.play("text_2")

func _on_yes_pressed() -> void:
	match dialogue_stage:
		1:
			print("🔁 Restarting game automatically...")
			_reset_game_state()  # ✅ Reset all prress
			await get_tree().create_timer(0.5).timeout
			
			# ✅ Load Main Menu (restart game)
			get_tree().change_scene_to_file("res://scene/mainmenu.tscn")
			
			
		2:
			text3.visible = false
			text4.visible = true
			yes_or_no_choice.visible = false
			if anim_player.has_animation("text_4"):
				anim_player.play("text_4")
			await anim_player.animation_finished
			get_tree().quit()

func _on_no_pressed() -> void:
	match dialogue_stage:
		1:
			text2.visible = false
			text3.visible = true
			dialogue_stage = 2
			if anim_player.has_animation("text_3"):
				anim_player.play("text_3")
			
		2:
			text3.visible = false
			text2.visible = true
			dialogue_stage = 1
			if anim_player.has_animation("text_2"):
				anim_player.play("text_2")

# ===================== GAME STATE RESET =====================
func _reset_game_state() -> void:
	print("🧹 Resetting GameState to defaults...")
	GameState.instruction_played = false
	GameState.kalanbanga_done = false
	GameState.ccc_done = false
	GameState.rizal_done = false
	GameState.church_done = false
	GameState.congratulation_ready = false
	GameState.just_came_from_portal = false
	GameState.returned_to_map_after_all_done = false
	GameState.reset_visited_scenes()
	print("✅ GameState reset complete.")

# ===================== AUTO GAME START =====================
func _start_game_automatically() -> void:
	print("🎮 Automatically starting new game...")
	if ResourceLoader.exists("res://scene/map.tscn"):
		get_tree().change_scene_to_file("res://scene/map.tscn")
	else:
		push_error("❌ Map scene not found. Check path.")
