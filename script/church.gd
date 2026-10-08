extends Node2D

# === Father Dialogue Nodes ===
@onready var btn: Button = $father/Button
@onready var anim_player: AnimationPlayer = $father/AnimationPlayer
@onready var panel: Panel = $father/Panel

@onready var text1: Label = $father/Label
@onready var text2: Label = $father/Label2
@onready var text3: Label = $father/Label3
@onready var text4: Label = $father/Label4
@onready var text5: Label = $father/Label5
@onready var text6: Label = $father/Label6
@onready var text7: Label = $father/Label7
@onready var text8: Label = $father/Label8
@onready var text9: Label = $father/Label9
@onready var quest: Sprite2D = $father/Quest
@onready var exclamatio2n: Sprite2D = $Exclamation

# === QUEST : puzzle_btn ===
@onready var puzzle_btn_1: Sprite2D = $puzzle_btn
@onready var puzzle_btn_2: Sprite2D = $puzzle_btn2
@onready var puzzle_btn_3: Sprite2D = $puzzle_btn3

# === Master Registry Nodes ===
@onready var masterreg_sprite: Area2D = $MasterReg
@onready var btn_masterreg: Button = $MasterReg/Button
@onready var anim_player_masterreg: AnimationPlayer = $MasterReg/AnimationPlayer
@onready var panel_masterreg: Panel = $MasterReg/Panel
@onready var text1_masterreg: Label = $MasterReg/Label
@onready var collected_label: Label = $MasterReg/CollectedLabel
@onready var btn_interact: Button = $MasterReg/Interact_btn
@onready var exclamation: Sprite2D = $MasterReg/Exclamation

# === State Tracking ===
var press_count := 0
var press_count_masterreg := 0
var father_dialogue_done := false  # 👈 Track if full dialogue finished
var text9_played_once := false     # 👈 Prevent looping text_9 while still in area
var player_in_area := false   # 👈 track if player is inside Area2D

# === Puzzle State Tracking ===
var puzzle_input := ""
var puzzle_attempts := 0
const MAX_ATTEMPTS := 3
const CORRECT_PASSWORD := "333"


func _ready() -> void:
	exclamation.visible = false
	exclamatio2n.visible = false
	var player = $player
	player.position = Global.get_entry_position("Church")
	QuestNotification.show_notification(LanguageManager.get_text("quest_church1"))
	apply_translation()
	btn.visible = false
	panel.visible = false

	btn.connect("pressed", Callable(self, "_play_animation"))

	# === Hide Puzzle Buttons at Start ===
	puzzle_btn_1.visible = false
	puzzle_btn_2.visible = false
	puzzle_btn_3.visible = false

	# === Hide Master Registry at Start ===
	masterreg_sprite.visible = false
	btn_interact.visible = false
	panel_masterreg.visible = false
	btn_masterreg.visible = false
	text1_masterreg.visible = false
	collected_label.visible = false

	# Connect area signals for Master Registry
	$MasterReg.connect("body_entered", Callable(self, "_on_master_reg_body_entered"))
	$MasterReg.connect("body_exited", Callable(self, "_on_master_reg_body_exited"))

	
	btn_interact.connect("pressed", Callable(self, "_on_btn_interact_pressed"))
	btn_masterreg.connect("pressed", Callable(self, "_play_animation_masterreg"))

	# Connect puzzle_btn signals
	$puzzle_btn/InteractArea.connect("body_entered", Callable(self, "_on_puzzle_btn_entered").bind(puzzle_btn_1))
	$puzzle_btn/InteractArea.connect("body_exited", Callable(self, "_on_puzzle_btn_exited").bind(puzzle_btn_1))
	$puzzle_btn2/InteractArea.connect("body_entered", Callable(self, "_on_puzzle_btn_entered").bind(puzzle_btn_2))
	$puzzle_btn2/InteractArea.connect("body_exited", Callable(self, "_on_puzzle_btn_exited").bind(puzzle_btn_2))
	$puzzle_btn3/InteractArea.connect("body_entered", Callable(self, "_on_puzzle_btn_entered").bind(puzzle_btn_3))
	$puzzle_btn3/InteractArea.connect("body_exited", Callable(self, "_on_puzzle_btn_exited").bind(puzzle_btn_3))


func apply_translation():
	text1.text = LanguageManager.get_text("church1")
	text2.text = LanguageManager.get_text("church2")
	text3.text = LanguageManager.get_text("church3")
	text4.text = LanguageManager.get_text("church4")
	text5.text = LanguageManager.get_text("church5")
	text6.text = LanguageManager.get_text("church6")
	text7.text = LanguageManager.get_text("church7")
	text8.text = LanguageManager.get_text("church8")
	text9.text = LanguageManager.get_text("church9")
	text1_masterreg.text = LanguageManager.get_text("masterreg1")
	


# ========================
# Father Dialogue Animation
# ========================
func _play_animation() -> void:
	# === After full dialogue done, play text_9 once only per interaction ===
	if father_dialogue_done:
		if text9_played_once:
			return  # 👈 prevent looping text_9
		_show_text9_once()
		text9_played_once = true
		return

	press_count += 1
	match press_count:
		1:
			text1.visible = true
			anim_player.play("text_1")
		2:
			text1.visible = false
			text2.visible = true
			anim_player.play("text_2")
		3:
			text2.visible = false
			text3.visible = true
			anim_player.play("text_3")
		4:
			text3.visible = false
			text4.visible = true
			anim_player.play("text_4")
		5:
			text4.visible = false
			text5.visible = true
			anim_player.play("text_5")
		6:
			text5.visible = false
			text6.visible = true
			anim_player.play("text_6")
		7:
			text6.visible = false
			text7.visible = true
			anim_player.play("text_7")
		8:
			text7.visible = false
			text8.visible = true
			anim_player.play("text_8")
		9:
			text8.visible = false
			text9.visible = true
			anim_player.play("text_9")
		10:
			text9.visible = false
			btn.visible = false
			panel.visible = false

			father_dialogue_done = true
			text9_played_once = false  # reset for next time you enter area
			exclamation.visible = true
			quest.visible = false
			QuestNotification.show_notification(LanguageManager.get_text("quest_church2"))


			# === Reveal Puzzle Buttons ===
			puzzle_btn_1.visible = true
			puzzle_btn_2.visible = true
			puzzle_btn_3.visible = true

func _show_text9_once():
	panel.visible = true
	btn.visible = true
	btn.disabled = false

	# Disconnect all button signals to avoid duplicates or interference
	for connection in btn.get_signal_connection_list("pressed"):
		btn.disconnect("pressed", connection.callable)

	# Connect the button only for text9 close action
	btn.connect("pressed", Callable(self, "_on_text9_btn_pressed"))

	# Hide all other texts
	for t in [text1, text2, text3, text4, text5, text6, text7, text8]:
		t.visible = false

	# Show text9 and play animation
	text9.visible = true
	anim_player.play("text_9")

func _on_text9_btn_pressed():
	text9.visible = false
	panel.visible = false
	btn.visible = false

	# Restore button functionality to default dialogue after closing text9
	btn.disconnect("pressed", Callable(self, "_on_text9_btn_pressed"))
	if not btn.is_connected("pressed", Callable(self, "_play_animation")):
		btn.connect("pressed", Callable(self, "_play_animation"))



# ============================
# Father Interact Handlers
# ============================
func _on_father_interact_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if player_in_area:
			return # 👈 prevent re-trigger while still inside

		player_in_area = true
		panel.visible = true
		btn.visible = true
		text9_played_once = false  # reset every time you newly enter

		# === AUTO TRIGGER FIX ===
		if father_dialogue_done:
			_show_text9_once()
			text9_played_once = true
		else:
			# 👇 Automatically trigger the first dialogue
			if press_count == 0:
				_play_animation()
			else:
				# If dialogue was partially played (player left early), resume next line
				btn.disabled = false

func _on_father_interact_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false   # 👈 reset so it can trigger again next time
		panel.visible = false
		btn.visible = false
		text9.visible = false

# ============================
# Master Registry Interactions
# ============================
func _on_master_reg_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		btn_interact.visible = true


func _on_master_reg_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		btn_interact.visible = false


func _on_btn_interact_pressed() -> void:
	btn_interact.visible = false
	
	# Show the Master Registry dialogue UI
	panel_masterreg.visible = true
	btn_masterreg.visible = true
	text1_masterreg.visible = true
	
	# Reset press count (in case you re-enter later)
	press_count_masterreg = 0
	_play_animation_masterreg()

# ============================
# Master Registry Collectible
# ============================
func _play_animation_masterreg() -> void:
	press_count_masterreg += 1

	match press_count_masterreg:
		1:
			btn_interact.visible = false
			anim_player_masterreg.play("text_1")
		2:
			text1_masterreg.visible = false
			panel_masterreg.visible = false
			btn_masterreg.visible = false
			
			collected_label.text = LanguageManager.get_text("masstereg")
			collected_label.visible = true

			await get_tree().create_timer(2.0).timeout
			collected_label.visible = false

			$MasterReg.queue_free()
			complete_quest()


# =======================
# Puzzle Logic (unchanged)
# =======================
func press(sprite: Sprite2D):
	sprite.frame = 2
	
	if sprite == puzzle_btn_3:
		puzzle_input += "3"
	else:
		puzzle_attempts += 1
		_check_puzzle()
		return

	if puzzle_input.length() == 3:
		if puzzle_input == CORRECT_PASSWORD:
			_on_puzzle_solved()
		else:
			puzzle_attempts += 1
			_check_puzzle()

func unpress(sprite: Sprite2D):
	sprite.frame = 1

func _on_puzzle_btn_entered(body: Node2D, sprite: Sprite2D) -> void:
	if body.is_in_group("player"):
		press(sprite)

func _on_puzzle_btn_exited(body: Node2D, sprite: Sprite2D) -> void:
	if body.is_in_group("player"):
		unpress(sprite)

func _check_puzzle():
	if puzzle_attempts >= MAX_ATTEMPTS:
		print("Puzzle failed! Restarting scene.")
		_restart_logic()
	else:
		print("Wrong attempt! Tries left: %d" % (MAX_ATTEMPTS - puzzle_attempts))
		puzzle_input = ""

func _on_puzzle_solved():
	print("Puzzle solved! Master Registry unlocked.")
	masterreg_sprite.visible = true
	puzzle_btn_1.queue_free()
	puzzle_btn_2.queue_free()
	puzzle_btn_3.queue_free()
	QuestNotification.show_notification(LanguageManager.get_text("quest_church3"))

func _restart_logic():
	print("Reloading scene... Puzzle failed.")
	get_tree().reload_current_scene()


# ========================
# Utility + Other Handlers
# ========================

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		_open_options_menu()

func _open_options_menu() -> void:
	get_tree().paused = true
	var options = preload("res://scene/option.tscn").instantiate()
	options.return_to_main = false
	add_child(options)
	options.grab_focus()
	
func complete_quest():
	GameState.church_done = true # change this line per scene
	print("⛪ Church Quest Complete:", GameState.church_done)

	# Recheck all quest completion status
	GameState.check_all_quests()

	# If all quests are done, mark congratulation as ready
	if GameState.all_quests_done():
		GameState.congratulation_ready = true
		print("🎯 All quests are complete! Player will return to map, then proceed to congratulation.")

	# --- Show portal (optional visual) ---
	var portal = $portal
	if portal:
		portal.show_portal()
		exclamatio2n.visible = true
		QuestNotification.show_notification(LanguageManager.get_text("portal"))
	else:
		push_warning("⚠️ Portal node not found in Church scene")
