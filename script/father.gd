extends Sprite2D
@onready var btn: Button = $Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var panel: Panel = $Panel

@onready var text1: Label = $Label
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var text4: Label = $Label4
@onready var text5: Label = $Label5
@onready var text6: Label = $Label6
@onready var text7: Label = $Label7
@onready var text8: Label = $Label8
@onready var text9: Label = $Label9

var press_count := 0

func _ready() -> void:
	# Hide everything if already played
	if GameState.instruction_played:
		btn.visible = false
		panel.visible = false
	else:
		btn.connect("pressed", Callable(self, "_play_animation"))

func _play_animation() -> void:
	if GameState.instruction_played:
		return
	
	press_count += 1

	match press_count:
		1:
			print("First press → play text_1")
			anim_player.play("text_1")

		2:
			if text1: text1.visible = false
			anim_player.play("text_2")

		3:
			if text2: text2.visible = false
			anim_player.play("text_3")

		4:
			if text3: text3.visible = false
			anim_player.play("text_4")

		5:
			if text4: text4.visible = false
			anim_player.play("text_5")

		6:
			if text5: text5.visible = false
			anim_player.play("text_6")

		7:
			if text6: text6.visible = false
			anim_player.play("text_7")

		8:
			if text7: text7.visible = false
			anim_player.play("text_8")

		9:
			if text8: text8.visible = false
			anim_player.play("text_9")

		10:
			if text9: text9.visible = false
			btn.visible = false
			panel.visible = false
			GameState.instruction_played = true
