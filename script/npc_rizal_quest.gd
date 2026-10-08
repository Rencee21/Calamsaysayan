extends Sprite2D

# ================== NODES ==================
@onready var btn: Button = $Button
@onready var btn_next: Button = $Node2D/Panel2/Next
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var anim_playernext: AnimationPlayer = $Node2D/AnimationPlayer
@onready var panel: Panel = $Panel
@onready var panel2: Panel = $Node2D/Panel2
@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var text4: Label = $Label4
@onready var text5: Label = $Label5
@onready var text6: Label = $Label6
@onready var text7: Label = $Label7
@onready var text8: Label = $Label8
@onready var text9: Label = $Node2D/Panel2/Label9
@onready var question1: Label = $Node2D/Panel2/Question_1
@onready var question2: Label = $Node2D/Panel2/Question_2
@onready var text10: Label = $Node2D/Panel2/Label12
@onready var text11: Label = $Node2D/Panel2/Label13
@onready var exclamation_portal: Sprite2D = $"../Exclamation"

# ✅ CHOICE BUTTONS
@onready var btnA: Button = $Node2D/Panel2/Choices/btnA
@onready var btnB: Button = $Node2D/Panel2/Choices/btnB
@onready var btnC: Button = $Node2D/Panel2/Choices/btnC

# ================== COLLECTION AREAS ==================
@onready var book_area: Area2D = $"../book"
@onready var pencil_area: Area2D = $"../pencil"

# BOOK nodes
@onready var exclamation_book: Sprite2D = $"../book/Exclamation"
@onready var btn2_book: Button = $"../book/Button2"
@onready var btn_book: Button = $"../book/Button"
@onready var panel_book: Panel = $"../book/Panel"
@onready var text1_book: Label = $"../book/Label"
@onready var text2_book: Label = $"../book/Label2"
@onready var text3_book: Label = $"../book/Label3"
@onready var text4_book: Label = $"../book/Label4"
@onready var collected_label_book: Label = $"../book/CollectedLabel_book"
@onready var anim_playerbook: AnimationPlayer = $"../book/AnimationPlayer"

# PENCIL nodes
@onready var exclamation_pencil: Sprite2D = $"../pencil/Exclamation"
@onready var btn2_pencil: Button = $"../pencil/Button2"
@onready var btn_pencil: Button = $"../pencil/Button"
@onready var panel_pencil: Panel = $"../pencil/Panel"
@onready var text1_pencil: Label = $"../pencil/Label"
@onready var text2_pencil: Label = $"../pencil/Label2"
@onready var text3_pencil: Label = $"../pencil/Label3"
@onready var collected_label_pencil: Label = $"../pencil/CollectedLabel_pencil"
@onready var anim_playerpencil: AnimationPlayer = $"../pencil/AnimationPlayer"
@onready var quest: Sprite2D = $"../Quest"


# ================== STATE VARIABLES ==================
var press_count := 0
var press_count_book := 0
var press_count_pencil := 0
var has_book := false
var has_pencil := false
var quiz_press_count := 0
var quiz_shown := false
var current_question := 0   # 0 = none, 1 = Q1, 2 = Q2


# ================== READY ==================
func _ready() -> void:
	exclamation_portal.visible = false
	exclamation_book.visible = false
	exclamation_pencil.visible = false
	quest.visible = true
	QuestNotification.show_notification(LanguageManager.get_text("quest_tourguide"))
	apply_translation()
	# Hide panels initially
	panel.visible = false
	btn.visible = false
	_hide_quiz()

	# NPC talk button
	btn.connect("pressed", Callable(self, "_play_npc_animation"))

	# Book signals
	book_area.body_entered.connect(_on_book_body_entered)
	book_area.body_exited.connect(_on_book_body_exited)
	btn2_book.connect("pressed", Callable(self, "_on_btn2_book_pressed"))
	btn_book.connect("pressed", Callable(self, "_play_book_animation"))

	# Pencil signals
	pencil_area.body_entered.connect(_on_pencil_body_entered)
	pencil_area.body_exited.connect(_on_pencil_body_exited)
	btn2_pencil.connect("pressed", Callable(self, "_on_btn2_pencil_pressed"))
	btn_pencil.connect("pressed", Callable(self, "_play_pencil_animation"))

	# ✅ Connect choices
	btnA.connect("pressed", Callable(self, "_on_choice_pressed").bind("A"))
	btnB.connect("pressed", Callable(self, "_on_choice_pressed").bind("B"))
	btnC.connect("pressed", Callable(self, "_on_choice_pressed").bind("C"))

	# Hide Book/Pencil UI
	panel_book.visible = false
	btn_book.visible = false
	btn2_book.visible = false
	panel_pencil.visible = false
	btn_pencil.visible = false
	btn2_pencil.visible = false
	collected_label_book.visible = false
	collected_label_pencil.visible = false

	# Connect quiz Next button
	if not btn_next.is_connected("pressed", Callable(self, "_play_quiz_animation")):
		btn_next.connect("pressed", Callable(self, "_play_quiz_animation"))

func apply_translation():
	text1.text = LanguageManager.get_text("rizal1")
	text2.text = LanguageManager.get_text("rizal2")
	text3.text = LanguageManager.get_text("rizal3")
	text4.text = LanguageManager.get_text("rizal4")
	text5.text = LanguageManager.get_text("rizal5")
	text6.text = LanguageManager.get_text("rizal6")
	text7.text = LanguageManager.get_text("rizal7")
	text8.text = LanguageManager.get_text("rizal8")
	text9.text = LanguageManager.get_text("rizal9")
	question1.text = LanguageManager.get_text("rizal10")
	question2.text = LanguageManager.get_text("rizal11")
	text10.text = LanguageManager.get_text("rizal12")
	text11.text = LanguageManager.get_text("rizal13")
	
	text1_book.text = LanguageManager.get_text("book1")
	text2_book.text = LanguageManager.get_text("book2")
	text3_book.text = LanguageManager.get_text("book3")
	text4_book.text = LanguageManager.get_text("book4")
	
	text1_pencil.text = LanguageManager.get_text("pencil1")
	text2_pencil.text = LanguageManager.get_text("pencil2")
	text3_pencil.text = LanguageManager.get_text("pencil3")
	
	
	
# ================== NPC AREA ==================
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	# ✅ Player already collected both → jump to quiz (auto-play)
	if has_book and has_pencil:
		panel.visible = false
		btn.visible = false
		_show_quiz()
		await get_tree().create_timer(0.3).timeout
		_play_quiz_animation()
		return

	# ✅ Player doesn’t have both quest items → show NPC dialogue
	panel.visible = true
	btn.visible = true

	# ✅ Automatically start first or reminder dialogue
	await get_tree().create_timer(0.3).timeout
	if press_count == 0:
		# 🔹 First time talking — auto-play first dialogue
		_on_btn_pressed_start()
	elif press_count >= 6:
		# 🔹 Returning without items — auto-start at text6
		_play_text6_start()

			
func _on_btn_pressed_start() -> void:
	_play_npc_animation()
	
func _play_text6_start() -> void:
	# ✅ Auto-starts at text6, then uses button to continue
	text6.visible = true
	anim_player.play("text_6")
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Only hide first dialogue panel, not quiz panel
		if not (has_book and has_pencil):
			panel.visible = false
			btn.visible = false

# ================== NPC DIALOGUE ==================
func _play_npc_animation() -> void:
	# If both items collected → skip to quiz
	if has_book and has_pencil:
		panel.visible = false
		btn.visible = false
		_show_quiz()
		return

	press_count += 1

	# ✅ First time NPC talk (before quest accepted)
	match press_count:
		1:
			quest.visible = false
			text1.visible = true
			anim_player.play("text")
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

		# ✅ Automatically switch to quest reminder after text6
		7:
			text6.visible = false
			text7.visible = true
			anim_player.play("text_7")

		# ✅ Player presses Next → text8
		8:
			text7.visible = false
			text8.visible = true
			anim_player.play("text_8")

		# ✅ Player presses Next → close reminder
		9:
			text8.visible = false
			panel.visible = false
			btn.visible = false
			# ✅ Show quest accepted notification
			QuestNotification.show_notification(LanguageManager.get_text("quest_collect"))

			# Reset so NPC always goes back to reminder until items are collected
			press_count = 6


# ================== BOOK ==================
func _on_book_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		exclamation_book.visible = true
		btn2_book.visible = true

func _on_book_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		exclamation_book.visible = false
		btn2_book.visible = false

func _on_btn2_book_pressed():
	panel_book.visible = true
	btn_book.visible = true
	btn2_book.visible = false
	press_count_book = 0
	text1_book.visible = true
	text2_book.visible = false
	text3_book.visible = false
	text4_book.visible = false

	# ✅ Auto-play the first dialogue line
	await get_tree().create_timer(0.3).timeout
	_play_book_animation()

func _play_book_animation() -> void:
	press_count_book += 1
	match press_count_book:
		1: anim_playerbook.play("text")
		2: text1_book.visible = false; text2_book.visible = true; anim_playerbook.play("text_2")
		3: text2_book.visible = false; text3_book.visible = true; anim_playerbook.play("text_3")
		4: text3_book.visible = false; text4_book.visible = true; anim_playerbook.play("text_4")
		5:
			text4_book.visible = false
			panel_book.visible = false
			btn_book.visible = false
			collected_label_book.text = LanguageManager.get_text("collected_label_book")
			collected_label_book.visible = true
			has_book = true
			await get_tree().create_timer(2.0).timeout
			collected_label_book.visible = false
			book_area.queue_free()
			_check_item_collection()


# ================== PENCIL ==================
func _on_pencil_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		exclamation_pencil.visible = true
		btn2_pencil.visible = true

func _on_pencil_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		exclamation_pencil.visible = false
		btn2_pencil.visible = false

func _on_btn2_pencil_pressed():
	panel_pencil.visible = true
	btn_pencil.visible = true
	btn2_pencil.visible = false
	press_count_pencil = 0
	text1_pencil.visible = true
	text2_pencil.visible = false
	text3_pencil.visible = false

	# ✅ Auto-play first dialogue line
	await get_tree().create_timer(0.3).timeout
	_play_pencil_animation()

func _play_pencil_animation() -> void:
	press_count_pencil += 1
	match press_count_pencil:
		1: anim_playerpencil.play("text")
		2: text1_pencil.visible = false; text2_pencil.visible = true; anim_playerpencil.play("text_2")
		3: text2_pencil.visible = false; text3_pencil.visible = true; anim_playerpencil.play("text_3")
		4:
			text3_pencil.visible = false
			panel_pencil.visible = false
			btn_pencil.visible = false
			collected_label_pencil.text = LanguageManager.get_text("collected_label_pencil")
			collected_label_pencil.visible = true
			has_pencil = true
			await get_tree().create_timer(2.0).timeout
			collected_label_pencil.visible = false
			pencil_area.queue_free()
			_check_item_collection()

func _check_item_collection():
	if has_book and has_pencil:
		quest.visible = true
		QuestNotification.show_notification(LanguageManager.get_text("quest_return"))
		
# ================== QUIZ ==================
func _show_quiz() -> void:
	quiz_shown = true
	panel2.visible = true
	btn_next.visible = true
	btn_next.disabled = false
	btn_next.grab_focus()

	quiz_press_count = 0
	current_question = 0

	# Show intro only
	text9.visible = true
	question1.visible = false
	question2.visible = false
	text10.visible = false
	text11.visible = false
	_hide_choices()

var retrying_wrong := false   # retry flag
var retry_question := 0       # which question to retry

func _play_quiz_animation() -> void:
	if retrying_wrong:
		# ✅ Reset back to the same question after wrong answer
		text11.visible = false
		if retry_question == 1:
			question1.visible = true
			_show_choices()
			btn_next.visible = false
			retrying_wrong = false
		elif retry_question == 2:
			question2.visible = true
			_show_choices()
			btn_next.visible = false
			retrying_wrong = false
		return
	
	quiz_press_count += 1
	match quiz_press_count:
		1: 
			quest.visible = false
			text9.visible = true
			anim_playernext.play("text_9")
		2:
			# Hide intro, show Question 1
			text9.visible = false
			question1.visible = true
			anim_playernext.play("text_10")
			_show_choices()
			btn_next.visible = false
			current_question = 1
		3:
			# Choices handle the rest
			pass

# ================== QUIZ LOGIC ==================
func _on_choice_pressed(choice: String) -> void:
	if current_question == 1:
		if choice == "C":  # ✅ Correct Answer for Q1
			question1.visible = false
			question2.visible = true
			anim_playernext.play("text_11")
			current_question = 2
			_show_choices()
			btn_next.visible = false
		else:  # ❌ Wrong Answer for Q1
			_hide_choices()
			question1.visible = false
			text11.visible = true     # Label13 (wrong msg)
			anim_playernext.play("text_13")
			await anim_playernext.animation_finished
			btn_next.visible = true
			retrying_wrong = true
			retry_question = 1

	elif current_question == 2:
		if choice == "B":  # ✅ Correct Answer for Q2
			question2.visible = false
			text10.visible = true     # Label12 (final success)
			anim_playernext.play("text_12")
			_hide_choices()
			btn_next.visible = true   # end dialogue, no more next
			current_question = 0
			await anim_playernext.animation_finished
			panel2.visible = false     # ✅ close quiz

			
			complete_quest()
		else:  # ❌ Wrong Answer for Q2
			_hide_choices()
			question2.visible = false
			text11.visible = true     # Label13 (wrong msg)
			anim_playernext.play("text_13")
			await anim_playernext.animation_finished
			btn_next.visible = true
			retrying_wrong = true
			retry_question = 2

# ================== HELPERS ==================
func _show_choices() -> void:
	btnA.visible = true
	btnB.visible = true
	btnC.visible = true

func _hide_choices() -> void:
	btnA.visible = false
	btnB.visible = false
	btnC.visible = false
			
func _hide_quiz() -> void:
	panel2.visible = false
	btn_next.visible = false
	text9.visible = false
	question1.visible = false
	question2.visible = false
	text10.visible = false
	text11.visible = false
	
func complete_quest():
	GameState.rizal_done = true
	print("🏛️ Rizal Shrine Quest Complete:", GameState.rizal_done)

	# Recheck all quest completion
	GameState.check_all_quests()

	# --- NEW: Only mark congratulation as ready, do NOT teleport yet ---
	if GameState.all_quests_done():
		GameState.congratulation_ready = true
		print("🎯 All quests are complete! Player must return to the Map to continue.")

	# --- Show the portal back to the map ---
	var portal = $"../portal"
	if portal:
		portal.show_portal()
		exclamation_portal.visible = true
		QuestNotification.show_notification(LanguageManager.get_text("portal"))
	else:
		push_warning("⚠️ Portal node not found in RizalShrine scene")
	
	quest.visible = false
