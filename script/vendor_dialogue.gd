extends Sprite2D

# === MAIN NODES ===
@onready var btn: Button = $Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var main_panel: Panel = $Panel 
@onready var quest: Sprite2D = $Quest
@onready var exclamation: Sprite2D = $Exclamation

# === VENDOR AREA ===
@onready var area_vendor: Area2D = $Area2D_Vendor

# === NPC AREA ===
@onready var area_npc: Area2D = $npc_coin/Area2D_NPC1

# === TEXT LABELS ===
@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var text4: Label = $Label4
@onready var text5: Label = $Label5
@onready var text6: Label = $Label6
@onready var text7: Label = $Label7
@onready var text8: Label = $Label8
@onready var text9: Label = $Label9
@onready var text10: Label = $Label10
@onready var text11: Label = $Label11
@onready var text12: Label = $Label12
@onready var text13: Label = $Label13
@onready var text14: Label = $Label14

# === CHOICES ===
@onready var choice_path: HBoxContainer = $Choice_Path
@onready var button2: Button = $Choice_Path/Button2
@onready var button3: Button = $Choice_Path/Button3

@onready var path_choice: HBoxContainer = $Path_Choice
@onready var button_a: Button = $Path_Choice/Button_A
@onready var button_b: Button = $Path_Choice/Button_B
@onready var button_c: Button = $Path_Choice/Button_C

# === NPC COIN (inside vendor_npc) ===
@onready var quest2: Sprite2D = $npc_coin/Quest
@onready var npc_coin: Sprite2D = $npc_coin
@onready var npc_panel: Panel = $npc_coin/Panel2
@onready var npc_label1: Label = $npc_coin/Label_npc1
@onready var npc_label2: Label = $npc_coin/Label_npc2
@onready var npc_label3: Label = $npc_coin/Label_npc3   
@onready var npc_label4: Label = $npc_coin/Label_npc4   
@onready var npc_label5: Label = $npc_coin/Label_npc5
@onready var npc_label6: Label = $npc_coin/Label_npc6 
@onready var npc_label7: Label = $npc_coin/Label_npc7     
@onready var npc_anim: AnimationPlayer = $npc_coin/AnimationPlayerNPC
@onready var npc_btn: Button = $npc_coin/Button_NPC1


# === NPC CHOICES ===
@onready var choices_npc: HBoxContainer = $npc_coin/Choices_NPC
@onready var button_npc_a: Button = $npc_coin/Choices_NPC/Button_NPC_A
@onready var button_npc_b: Button = $npc_coin/Choices_NPC/Button_NPC_B
@onready var button_npc_c: Button = $npc_coin/Choices_NPC/Button_NPC_C

# === NPC SECOND QUESTION ===
@onready var choices_npc2: HBoxContainer = $npc_coin/Choices_NPC_2
@onready var button_npc2_a: Button = $npc_coin/Choices_NPC_2/Button_NPC2_A
@onready var button_npc2_b: Button = $npc_coin/Choices_NPC_2/Button_NPC2_B
@onready var button_npc2_c: Button = $npc_coin/Choices_NPC_2/Button_NPC2_C

# Track dialogue state
var npc_press_count := 0

#NPC_First Question no return after you finished answering it.
var finished_first_question := false 

# === STATE VARS ===
var press_count := 0
var branch_path := 0       # 0 = none, 2 = Path2, 3 = Path3
var skip_text13 := false   # If true, path3 starts without text13
var finished_npc_coin := false

func _ready() -> void:
	quest2.visible = false
	exclamation.visible = false
	QuestNotification.show_notification(LanguageManager.get_text("banga1"))
	apply_translation()
	# Connect signals
	btn.connect("pressed", Callable(self, "_on_btn_pressed"))
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	button3.connect("pressed", Callable(self, "_on_button3_pressed"))
	button_a.connect("pressed", Callable(self, "_on_button_a_pressed"))
	button_b.connect("pressed", Callable(self, "_on_button_b_pressed"))
	button_c.connect("pressed", Callable(self, "_on_button_c_pressed"))
	npc_btn.connect("pressed", Callable(self, "_on_npc_next"))
	button_npc_a.connect("pressed", Callable(self, "_on_button_npc_a_pressed"))
	button_npc_b.connect("pressed", Callable(self, "_on_button_npc_b_pressed"))
	button_npc_c.connect("pressed", Callable(self, "_on_button_npc_c_pressed"))
	button_npc2_a.connect("pressed", Callable(self, "_on_button_npc2_a_pressed"))
	button_npc2_b.connect("pressed", Callable(self, "_on_button_npc2_b_pressed"))
	button_npc2_c.connect("pressed", Callable(self, "_on_button_npc2_c_pressed"))
	area_vendor.connect("body_entered", Callable(self, "_on_vendor_body_entered"))
	area_vendor.connect("body_exited", Callable(self, "_on_vendor_body_exited"))
	area_npc.connect("body_entered", Callable(self, "_on_area_2d_npc_1_body_entered"))
	area_npc.connect("body_exited", Callable(self, "_on_area_2d_npc_1_body_exited"))



	# Hide all text labels initially
	for t in [text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,text11,text12,text13]:
		t.visible = false

	# Hide choices
	choice_path.visible = false
	path_choice.visible = false
	main_panel.visible = false
	btn.visible = false

	# === NPC UI at start ===
	npc_coin.visible = true       # ✅ coin sprite always visible
	npc_panel.visible = false
	npc_label2.visible = false
	npc_label3.visible = false
	npc_label4.visible = false
	npc_label5.visible = false    # ✅ hide npctext_5 at start
	npc_label6.visible = false
	npc_label7.visible = false
	npc_btn.visible = false
	choices_npc.visible = false   # ✅ hide choices
	choices_npc2.visible = false  # ✅ hide second question
	
func apply_translation():
	text1.text = LanguageManager.get_text("vendor1")
	text2.text = LanguageManager.get_text("vendor2")
	text3.text = LanguageManager.get_text("vendor3")
	text4.text = LanguageManager.get_text("vendor4")
	text5.text = LanguageManager.get_text("vendor5")
	text6.text = LanguageManager.get_text("vendor6")
	text7.text = LanguageManager.get_text("vendor7")
	text8.text = LanguageManager.get_text("vendor8")
	text9.text = LanguageManager.get_text("vendor9")
	text10.text = LanguageManager.get_text("vendor10")
	text11.text = LanguageManager.get_text("vendor11")
	text12.text = LanguageManager.get_text("vendor12")
	text13.text = LanguageManager.get_text("vendor13")
	text14.text = LanguageManager.get_text("vendor14")
	npc_label1.text = LanguageManager.get_text("npc_coin1")
	npc_label2.text = LanguageManager.get_text("npc_coin2")
	npc_label3.text = LanguageManager.get_text("npc_coin3")
	npc_label4.text = LanguageManager.get_text("npc_coin4")
	npc_label5.text = LanguageManager.get_text("npc_coin5")
	npc_label6.text = LanguageManager.get_text("npc_coin6")
	npc_label7.text = LanguageManager.get_text("npc_coin7")
	button2.text = LanguageManager.get_text("choice1")
	button3.text= LanguageManager.get_text("choice2")
	button_a.text = LanguageManager.get_text("choice3")
	button_b.text = LanguageManager.get_text("choice4")
	button_c.text = LanguageManager.get_text("choice5")
	button_npc_a.text = LanguageManager.get_text("npcchoice1")
	button_npc_b.text = LanguageManager.get_text("npcchoice2")
	button_npc_c.text = LanguageManager.get_text("npcchoice3")
	button_npc2_a.text = LanguageManager.get_text("npcchoice4")
	button_npc2_b.text = LanguageManager.get_text("npcchoice5")
	button_npc2_c.text = LanguageManager.get_text("npcchoice6")
	

# ========== BTN MAIN ==========
func _on_btn_pressed() -> void:
	# ignore if the button is temporarily disabled (prevents race conditions)
	if btn.disabled:
		print("⚠️ Ignored Next — button disabled while waiting.")
		return
	# 🔹 Hide text12 if it was shown from a wrong choice
	if text12.visible:
		text12.visible = false
		btn.visible = false
		main_panel.visible = false
		print("🔁 Hiding text12 after wrong choice")
	
	# Continue based on current path
	if branch_path == 2:
		_play_path2()
	elif branch_path == 3:
		_play_path3()
	else:
		_play_intro()

# ========== INTRO DIALOG (text1 → text5) ==========
func _play_intro() -> void:
	press_count += 1
	match press_count:
		1:
			quest.visible = false
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
			btn.visible = false
			choice_path.visible = true

# ========== PATH CHOICES ==========
func _on_button2_pressed() -> void:
	branch_path = 2
	choice_path.visible = false
	btn.visible = true
	text5.visible = false
	press_count = 0

	# ✅ Automatically start the first dialogue in Path2
	await get_tree().create_timer(0.3).timeout
	_on_btn_pressed()  # Simulate first press to start Path2 automatically

func _on_button3_pressed() -> void:
	branch_path = 3
	choice_path.visible = false
	btn.visible = true
	text5.visible = false
	press_count = 0
	quest2.visible = true
	print("➡️ Path3 chosen → Player must walk to npc_coin to continue")
	
	await get_tree().create_timer(0.5).timeout
	main_panel.visible = true
	btn.visible = true
	_on_btn_pressed()  # simulate first press for autoplay
	
	QuestNotification.show_notification(LanguageManager.get_text("banga2"))

# ========== PATH 2 FLOW ==========
func _play_path2() -> void:
	press_count += 1
	match press_count:
		1:
			text6.visible = true
			anim_player.play("text_6")
		2:
			text6.visible = false
			text7.visible = true
			anim_player.play("text_7")
		3:
			text7.visible = false
			text8.visible = true
			anim_player.play("text_8")
		4:
			text8.visible = false
			text9.visible = true
			anim_player.play("text_9")
		5:
			text9.visible = false
			text10.visible = true
			anim_player.play("text_10")
			btn.visible = false
			path_choice.visible = true

# ========== PATH 2 FINAL CHOICE (A/B/C) ==========
func _on_button_a_pressed() -> void:
	path_choice.visible = false
	text10.visible = false
	text11.visible = true
	anim_player.play("text_11")

	btn.visible = true
	btn.disabled = false

	branch_path = 0
	press_count = 0
	print("✅ Correct choice → Text11 (player must press Next to finish)")

	# Temporarily block the main Next logic
	btn.disconnect("pressed", Callable(self, "_on_btn_pressed"))

	# Connect to our custom final handler
	if not btn.pressed.is_connected(_on_path2_final_next_pressed):
		btn.pressed.connect(_on_path2_final_next_pressed)
	
func _on_path2_final_next_pressed() -> void:
	# Hide all text and UI elements to prevent overlap
	for t in [text1, text2, text3, text4, text5, text6, text7, text8, text9, text10, text11, text12, text13, text14]:
		t.visible = false
	btn.visible = false
	main_panel.visible = false

	# Finish the quest
	complete_quest()
	print("🎉 Path2 final dialogue finished — quest complete!")

	# Clean up connections to avoid triggering _on_btn_pressed again
	if btn.pressed.is_connected(_on_path2_final_next_pressed):
		btn.pressed.disconnect(_on_path2_final_next_pressed)

	# Reconnect the default Next logic for future interactions (optional)
	if not btn.pressed.is_connected(_on_btn_pressed):
		btn.pressed.connect(Callable(self, "_on_btn_pressed"))


func _on_button_b_pressed() -> void:
	_wrong_choice_path2()

func _on_button_c_pressed() -> void:
	_wrong_choice_path2()

func _wrong_choice_path2() -> void:
	print("❌ Wrong choice → Text12, then must go to npc_coin manually")
	path_choice.visible = false
	btn.visible = true
	text10.visible = false
	text12.visible = true
	quest2.visible = true
	anim_player.play("text_12")

	# ❌ Player must now go to the NPC manually (no auto start)
	branch_path = 3
	skip_text13 = true
	press_count = 0
	
	QuestNotification.show_notification(LanguageManager.get_text("banga2"))
# ========== PATH 3 FLOW ==========
func _play_path3() -> void:
	press_count += 1
	match press_count:
		1:
			if not skip_text13:
				text13.visible = true
				anim_player.play("text_13")
				print("🟢 Playing text13 normally before NPC.")
			else:
				# 🟠 Skip text13 (wrong Path2), wait for player to go to NPC manually
				print("⚠️ Skipping text13 — player must walk to NPC manually.")
				btn.visible = false
				main_panel.visible = false
		2:
			if text13.visible:
				text13.visible = false
				main_panel.visible = false
				btn.visible = false
				print("✅ text13 hidden, player control restored.")


# ========== NPC COIN ==========
func _show_npc_coin() -> void:
	npc_coin.visible = true
	npc_panel.visible = true
	npc_label2.visible = true
	npc_btn.visible = true
	npc_label3.visible = false
	npc_label4.visible = false
	npc_label5.visible = false
	choices_npc.visible = false   # hide choices until needed
	choices_npc2.visible = false 
	npc_press_count = 0

# === NPC DIALOGUE FLOW (NEXT BUTTON) ===
func _on_npc_next() -> void:
	npc_press_count += 1
	match npc_press_count:
		1:
			quest2.visible = false
			npc_anim.play("npctext_2")
		2:
			npc_label2.visible = false
			npc_label3.visible = true
			npc_anim.play("npctext_3")
		3:
			npc_label3.visible = false
			npc_label4.visible = true
			npc_anim.play("npctext_4")
			choices_npc.visible = true
			npc_btn.visible = false     # disable Next, wait for choice
		4:
			# Retry loop after wrong answer in 1st question
			npc_label5.visible = false
			npc_label4.visible = true
			npc_anim.play("npctext_4")
			choices_npc.visible = true
			npc_btn.visible = false
			npc_press_count = 3   # reset back to question

		5:
			# Retry loop after wrong answer in 2nd question
			npc_label5.visible = false
			npc_label6.visible = true
			npc_anim.play("npctext_6")
			choices_npc2.visible = true
			npc_btn.visible = false
			npc_press_count = 5   # reset back to second question
		

# ================= First Question (npctext_4) =================
func _on_button_npc_a_pressed() -> void:
	# ✅ Correct answer for first question
	choices_npc.visible = false
	npc_label4.visible = false
	npc_label6.visible = true
	npc_anim.play("npctext_6")
	finished_first_question = true   # 🔑 lock Q1 forever
	choices_npc2.visible = true
	npc_btn.visible = false
	


func _on_button_npc_b_pressed() -> void:
	_wrong_choice_npc_first()

func _on_button_npc_c_pressed() -> void:
	_wrong_choice_npc_first()
	
func _wrong_choice_npc_first() -> void:
	# ❌ Wrong answer for first question
	choices_npc.visible = false
	npc_label4.visible = false
	npc_label5.visible = true
	npc_anim.play("npctext_5")
	npc_btn.visible = true
	# Here, finished_first_question is still FALSE


# ================= Second Question (npctext_6) =================
func _on_button_npc2_a_pressed() -> void:
	# ✅ Correct answer for second question
	choices_npc2.visible = false
	npc_label6.visible = false
	npc_label7.visible = true  # ✅ show the npctext_7 label
	npc_anim.play("npctext_7")
	npc_btn.visible = true     # 🟩 show Next button for player to end dialogue
	QuestNotification.show_notification(LanguageManager.get_text("banga3"))

	# 🔹 Connect the Next button to finish this dialogue only once
	if not npc_btn.pressed.is_connected(_on_npc2_final_next_pressed):
		npc_btn.pressed.connect(_on_npc2_final_next_pressed)

func _on_npc2_final_next_pressed() -> void:
	# 🔸 Hide everything after pressing Next
	npc_label7.visible = false
	npc_panel.visible = false
	npc_btn.visible = false
	npc_label4.visible = false
	choices_npc.visible = false
	finished_npc_coin = true   # 🔑 Mark NPC completed
	quest.visible = true
	
	

	# 🔹 Disconnect so it won’t trigger again next time
	if npc_btn.pressed.is_connected(_on_npc2_final_next_pressed):
		npc_btn.pressed.disconnect(_on_npc2_final_next_pressed)

	print("🎉 NPC dialogue finished — player control restored.")



func _on_button_npc2_b_pressed() -> void:
	_wrong_choice_npc_second()

func _on_button_npc2_c_pressed() -> void:
	_wrong_choice_npc_second()

func _wrong_choice_npc_second() -> void:
	choices_npc2.visible = false
	npc_label6.visible = false
	npc_label5.visible = true
	npc_anim.play("npctext_5")
	npc_btn.visible = true
	# ✅ Always loop back to npctext_6 (second question)
	npc_press_count = 4

func _on_area_2d_vendor_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		main_panel.visible = true
		btn.visible = true

		if finished_npc_coin:
			# 🔹 Hide all previous texts
			for t in [text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,text11,text12,text13]:
				t.visible = false

			# 🔹 Show the final text (text_14)
			text14.visible = true
			anim_player.play("text_14")
			quest.visible = false
			print("🍢 Player returned after NPC → Showing text14 (buy food)")

			# 🟩 Connect button for next action (only once)
			if not btn.pressed.is_connected(_on_vendor_next_pressed):
				btn.pressed.connect(_on_vendor_next_pressed)
		else:
			print("👤 Player entered vendor area → Showing main dialogue UI")
			if press_count == 0:
				await get_tree().create_timer(0.5).timeout
				_on_btn_pressed()

func _on_vendor_next_pressed() -> void:
	# 🔸 Hide elements after pressing the button
	text14.visible = false
	main_panel.visible = false
	btn.visible = false
	complete_quest()
	print("✅ Vendor dialogue finished — player control restored.")

	# 🔹 Disconnect to avoid multiple triggers
	if btn.pressed.is_connected(_on_vendor_next_pressed):
		btn.pressed.disconnect(_on_vendor_next_pressed)

func _on_area_2d_vendor_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Hide Main Dialogue UI (Panel, Labels, Choices)
		main_panel.visible = false
		btn.visible = false
		choice_path.visible = false
		path_choice.visible = false

func _on_area_2d_npc_1_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	# Case 1: No vendor yet, go straight to npc_coin → only show npctext_1
	if branch_path == 0:
		npc_panel.visible = true
		npc_label1.visible = true
		npc_anim.play("npctext_1")
		npc_btn.visible = true   # 🟩 show Next button
		print("📜 Player skipped vendor → Show npctext_1 only")

		# 🟦 Connect button for ending dialogue (only once)
		if not npc_btn.pressed.is_connected(_on_npc1_next_pressed):
			npc_btn.pressed.connect(_on_npc1_next_pressed)

	# Case 2: Path3 chosen → start npc_coin flow
	elif branch_path == 3:
		_show_npc_coin()
		print("➡️ Path3 → NPC coin dialogue starts automatically")
		# 👇 Automatically start the first NPC line
		await get_tree().create_timer(0.5).timeout
		_on_npc_next()

	# Case 3: Path2 correct answer → only npctext_1
	elif branch_path == 2 and finished_first_question:
		npc_panel.visible = true
		npc_label1.visible = true
		npc_anim.play("npctext_1")
		npc_btn.visible = false
		print("✅ Path2 correct → Show npctext_1 only")

	# Case 4: Path2 wrong answer → npc_coin flow
	elif branch_path == 2 and not finished_first_question:
		_show_npc_coin()
		print("❌ Path2 wrong → NPC coin dialogue starts")

func _on_npc1_next_pressed() -> void:
	# 🔸 Hide dialogue and restore player control
	npc_label1.visible = false
	npc_label2.visible = false
	npc_label3.visible = false
	npc_label4.visible = false
	npc_label5.visible = false
	npc_label6.visible = false
	npc_label7.visible = false
	choices_npc.visible = false
	choices_npc2.visible = false
	npc_panel.visible = false
	npc_btn.visible = false

	print("✅ NPC dialogue ended — player control restored.")

	# 🔹 Disconnect to avoid multiple triggers later
	if npc_btn.pressed.is_connected(_on_npc1_next_pressed):
		npc_btn.pressed.disconnect(_on_npc1_next_pressed)


func _on_area_2d_npc_1_body_exited(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	
	# Hide everything when leaving NPC coin area
	npc_panel.visible = false
	npc_label1.visible = false
	npc_label2.visible = false
	npc_label3.visible = false
	npc_label4.visible = false
	npc_label5.visible = false
	npc_label6.visible = false
	npc_label7.visible = false
	npc_btn.visible = false
	choices_npc.visible = false
	choices_npc2.visible = false
	
	
	print("👋 Player exited NPC coin area → Dialogue hidden")
	

func complete_quest():
	GameState.kalanbanga_done = true
	QuestNotification.show_notification(LanguageManager.get_text("portal"))
	print("🏺 KalanBanga Quest Complete:", GameState.kalanbanga_done)

	# Recheck quest status
	GameState.check_all_quests()

	# --- New condition: only mark congratulation as ready, do NOT go there yet ---
	if GameState.all_quests_done():
		GameState.congratulation_ready = true
		print("🎯 All quests are complete! Player must return to the Map to continue.")

	# --- Show portal to return to the Map scene ---
	var portal = $portal
	if portal:
		exclamation.visible = true
		portal.show_portal()
	else:
		push_warning("⚠️ Portal node not found in KalanBanga scene")
