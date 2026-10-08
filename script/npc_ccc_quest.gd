extends Sprite2D

# === MAIN NODES ===
@onready var btn: Button = $Button
@onready var panel: Panel = $Panel
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var text4: Label = $Label4
@onready var text5: Label = $Label5
@onready var text6: Label = $Label6
@onready var text7: Label = $Label7
@onready var quest: Sprite2D = $Quest
@onready var exclamation: Sprite2D = $Exclamation

@onready var choices_panel: HBoxContainer = $Choices2
@onready var interact_area: Area2D = $InteractArea

# === ICONS FOR CHOICE COMPARISON ===
const B_ICON = preload("res://art/Icon_Control/b_icon.png")
const C_ICON = preload("res://art/Icon_Control/c_icon-removebg-preview.png")

# === VARIABLES ===
var choice_buttons: Array = []
var press_count := 0
var current_question := 0
var lang_manager

# ================== READY ==================
func _ready() -> void:
	QuestNotification.show_notification(LanguageManager.get_text("quest_ccc1"))
	
	btn.visible = false
	choices_panel.visible = false
	panel.visible = false
	exclamation.visible = false
	
	btn.connect("pressed", Callable(self, "_play_animation"))

	# Connect all choice buttons
	for child in choices_panel.get_children():
		if child is Button:
			child.connect("pressed", Callable(self, "_on_choice_pressed").bind(child))
			choice_buttons.append(child)

	# Connect area triggers
	interact_area.connect("body_entered", Callable(self, "_on_interact_area_body_entered"))
	interact_area.connect("body_exited", Callable(self, "_on_interact_area_body_exited"))

	# Language setup
	lang_manager = get_node_or_null("/root/LanguageManager")
	if lang_manager:
		lang_manager.language_changed.connect(apply_translation)
		apply_translation(lang_manager.current_language)

# ================= LANGUAGE HANDLER =================
func apply_translation(lang: String) -> void:
	if not lang_manager:
		return
	
	text1.text = lang_manager.get_text("ccc1")
	text2.text = lang_manager.get_text("ccc2")
	text3.text = lang_manager.get_text("ccc3")
	text4.text = lang_manager.get_text("ccc4")
	text5.text = lang_manager.get_text("ccc5")
	text6.text = lang_manager.get_text("ccc6")
	text7.text = lang_manager.get_text("ccc7")

	if choices_panel.visible:
		if current_question == 1:
			text7.text = lang_manager.get_text("ccc_q1")
		elif current_question == 2:
			text7.text = lang_manager.get_text("ccc_q2")

# ================= AREA INTERACTION =================
func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		panel.visible = true
		btn.visible = true

		# ✅ Automatically start first dialogue line
		await get_tree().create_timer(0.3).timeout
		_on_first_auto_start()

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		btn.visible = false
		choices_panel.visible = false
		panel.visible = false

# ================= AUTO START DIALOGUE =================
func _on_first_auto_start() -> void:
	press_count = 0
	_play_animation()

# ================= MAIN DIALOGUE PROGRESSION =================
func _play_animation() -> void:
	press_count += 1

	match press_count:
		1:
			quest.visible = false
			anim_player.play("text")
		2:
			text1.visible = false
			anim_player.play("text_2")
		3:
			text2.visible = false
			anim_player.play("text_3")
		4:
			text3.visible = false
			anim_player.play("text_4")
		5:
			text4.visible = false
			anim_player.play("text_5")
		6:
			text5.visible = false
			anim_player.play("text_6")
		7:
			text6.visible = false
			anim_player.play("text_7")
			btn.visible = false
			_show_question(1)

# ================= QUESTIONS HANDLER =================
func _show_question(num: int) -> void:
	current_question = num
	choices_panel.visible = true
	
	if num == 1:
		QuestNotification.show_notification(LanguageManager.get_text("quest_ccc2"))
		text7.text = lang_manager.get_text("ccc_q1")
	elif num == 2:
		text7.text = lang_manager.get_text("ccc_q2")

# ================= CHOICE HANDLER =================
func _on_choice_pressed(button: Button) -> void:
	var icon = button.icon
	
	if current_question == 1:
		if icon == B_ICON:
			text7.text = lang_manager.get_text("ccc_correct1")
			await get_tree().create_timer(2.0).timeout
			_show_question(2)
		else:
			text7.text = lang_manager.get_text("ccc_incorrect1")
			await get_tree().create_timer(2.0).timeout
			_show_question(1)

	elif current_question == 2:
		if icon == C_ICON:
			text7.text = lang_manager.get_text("ccc_correct2")
			await get_tree().create_timer(2.0).timeout
			_end_dialogue()
		else:
			text7.text = lang_manager.get_text("ccc_incorrect2")
			await get_tree().create_timer(2.0).timeout
			_show_question(2)

# ================= END DIALOGUE =================
func _end_dialogue() -> void:
	choices_panel.visible = false
	text7.visible = false
	panel.visible = false
	gain_artifact()
	QuestNotification.show_notification(LanguageManager.get_text("portal"))
	complete_quest()

func gain_artifact() -> void:
	print("Artifact added to player inventory!")

# ================= QUEST COMPLETION =================
func complete_quest():
	GameState.ccc_done = true
	print("🏫 CCC Quest Complete:", GameState.ccc_done)
	GameState.check_all_quests()

	if GameState.all_quests_done():
		GameState.congratulation_ready = true
		print("🎯 All quests are complete! Player must return to the Map to continue.")

	var portal = $portal
	if portal:
		exclamation.visible = true
		portal.show_portal()
		QuestNotification.show_notification(LanguageManager.get_text("portal"))
	else:
		push_warning("⚠️ Portal node not found in CCC scene")
