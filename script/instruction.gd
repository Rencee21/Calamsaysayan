extends Node2D

signal instruction_finished

@onready var btn: Button = $Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var panel: Panel = $Panel
@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var text4: Label = $Label4
@onready var text5: Label = $Label5
@onready var text6: Label = $Label6

var press_count := 0
var instruction_done := false


func _ready() -> void:
	apply_translation()
	
	# Hide all texts at start
	for t in [text1, text2, text3, text4, text5, text6]:
		t.visible = false
	
	btn.visible = false
	panel.visible = false
	
	# If already done, hide everything
	if GameState.instruction_played:
		panel.visible = false
		btn.visible = false
		return
	
	# === AUTO TRIGGER like in Father Dialogue ===
	panel.visible = true
	btn.visible = true
	_play_animation()
	
	btn.connect("pressed", Callable(self, "_play_animation"))


func apply_translation():
	text1.text = LanguageManager.get_text("instruct1")
	text2.text = LanguageManager.get_text("instruct2")
	text3.text = LanguageManager.get_text("instruct3")
	text4.text = LanguageManager.get_text("instruct4")
	text5.text = LanguageManager.get_text("instruct5")
	text6.text = LanguageManager.get_text("instruct6")


# ========================
# Instruction Dialogue Flow
# ========================
func _play_animation() -> void:
	if instruction_done:
		return
	
	press_count += 1
	match press_count:
		1:
			text1.visible = true
			anim_player.play("txt")
		2:
			text1.visible = false
			text2.visible = true
			anim_player.play("txt_2")
		3:
			text2.visible = false
			text3.visible = true
			anim_player.play("txt_3")
		4:
			text3.visible = false
			text4.visible = true
			anim_player.play("txt_4")
		5:
			text4.visible = false
			text5.visible = true
			anim_player.play("txt_5")
		6:
			text5.visible = false
			text6.visible = true
			anim_player.play("txt_6")
		7:
			text6.visible = false
			btn.visible = false
			panel.visible = false
			instruction_done = true
			GameState.instruction_played = true
			emit_signal("instruction_finished")
			print("✅ Instruction dialogue finished.")
