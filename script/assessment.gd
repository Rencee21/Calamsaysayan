extends Panel

signal assessment_finished

# === NODES ===
@onready var btn_next: Button = $btn_next
@onready var btn_map: Button = $btn_map
@onready var btn_a: Button = $HBoxContainer/btn_A
@onready var btn_b: Button = $HBoxContainer/btn_B
@onready var btn_c: Button = $HBoxContainer/btn_C
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var text_1: Label = $Label
@onready var text_2: Label = $Label2
@onready var text_3: Label = $Label3
@onready var text_4: Label = $Label4
@onready var text_5: Label = $Label5
@onready var text_6: Label = $Label6   # Correct feedback for last question
@onready var text_7: Label = $Label7   # Wrong feedback

# === STATE ===
var current_step := 1
var awaiting_answer := false
var last_correct_done := false
var retrying_question := false

# === GLOBAL REFERENCE ===
var game_state: Node = null


# ========================
# READY
# ========================
func _ready():
	game_state = get_node_or_null("/root/GameState")
	apply_translation()

	# Hide all labels initially
	for t in [text_1, text_2, text_3, text_4, text_5, text_6, text_7]:
		t.visible = false

	# Initial button visibility setup
	btn_next.visible = true
	btn_map.visible = true
	btn_map.disabled = false
	btn_a.visible = false
	btn_b.visible = false
	btn_c.visible = false

	# Connect buttons
	btn_next.connect("pressed", Callable(self, "_on_next_pressed"))
	btn_map.connect("pressed", Callable(self, "_on_btn_map_pressed"))
	btn_a.connect("pressed", Callable(self, "_on_btn_a_pressed"))
	btn_b.connect("pressed", Callable(self, "_on_btn_b_pressed"))
	btn_c.connect("pressed", Callable(self, "_on_btn_c_pressed"))

	_show_step(current_step)


# ========================
# Apply Translation
# ========================
func apply_translation():
	text_1.text = LanguageManager.get_text("assessment1")
	text_2.text = LanguageManager.get_text("assessment2")
	text_3.text = LanguageManager.get_text("assessment3")
	text_4.text = LanguageManager.get_text("assessment4")
	text_5.text = LanguageManager.get_text("assessment5")
	text_6.text = LanguageManager.get_text("assessment6")
	text_7.text = LanguageManager.get_text("assessment7")
	btn_next.text = LanguageManager.get_text("next")
	btn_map.text = LanguageManager.get_text("go_map")


# ========================
# Show Step
# ========================
func _show_step(step: int):
	for t in [text_1, text_2, text_3, text_4, text_5, text_6, text_7]:
		t.visible = false

	match step:
		1:
			text_1.visible = true
			animation_player.play("text_1")
		2:
			text_2.visible = true
			animation_player.play("text_2")
		3:
			text_3.visible = true
			animation_player.play("text_3")
		4:
			text_4.visible = true
			animation_player.play("text_4")
			_show_choices(true)
			awaiting_answer = true
		5:
			text_5.visible = true
			animation_player.play("text_5")
			_show_choices(true)
			awaiting_answer = true


# ========================
# Button Handlers
# ========================
func _on_next_pressed():
	if last_correct_done:
		_finish_assessment()
		return

	if retrying_question:
		retrying_question = false
		_show_step(current_step)
		return

	if not awaiting_answer:
		current_step += 1
		_show_step(current_step)


func _on_btn_map_pressed() -> void:
	if last_correct_done:
		# ✅ Player finished the assessment successfully
		get_tree().change_scene_to_file("res://scene/map.tscn")
	else:
		# ⚠️ Player quits before finishing — assessment not marked as done
		print("⚠️ Player exited the assessment early. Progress not saved.")
		get_tree().change_scene_to_file("res://scene/map.tscn")
	


func _on_btn_a_pressed(): _check_answer("A")
func _on_btn_b_pressed(): _check_answer("B")
func _on_btn_c_pressed(): _check_answer("C")


# ========================
# Check Answer
# ========================
func _check_answer(selected: String):
	_show_choices(false)
	awaiting_answer = false

	var correct := ""
	if current_step == 4:
		correct = "B"
	elif current_step == 5:
		correct = "A"

	if selected == correct:
		if current_step == 5:
			# ✅ Last question correct → mark assessment as passed
			text_5.visible = false
			text_6.visible = true
			animation_player.play("text_6")

			btn_next.visible = true
			btn_map.visible = true
			btn_map.disabled = false
			last_correct_done = true
		else:
			# Move to next question
			current_step = 5
			_show_step(current_step)
	else:
		# ❌ Wrong answer → show feedback and retry
		text_4.visible = false
		text_5.visible = false
		text_7.visible = true
		animation_player.play("text_7")

		btn_next.visible = true
		btn_map.visible = true  # Allow quitting anytime
		btn_map.disabled = false
		retrying_question = true


# ========================
# Helper: Show/Hide Choices
# ========================
func _show_choices(state: bool):
	btn_a.visible = state
	btn_b.visible = state
	btn_c.visible = state
	btn_next.visible = not state
	btn_map.visible = false
	btn_map.disabled = false


# ========================
# Finish Assessment
# ========================
func _finish_assessment():
	if game_state:
		game_state.assessment_done = true
		print("✅ Assessment passed! assessment_done = true")

	self.visible = false
	get_tree().change_scene_to_file("res://scene/ccc_inside.tscn")
	emit_signal("assessment_finished")
