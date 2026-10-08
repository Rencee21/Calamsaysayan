extends Panel

@onready var mainmenu: Button = $Mainmenu
@onready var next: Button = $Next

@onready var downlabel: Label = $downlabel
@onready var leftlabel: Label = $leftlabel
@onready var uplabel: Label = $uplabel
@onready var rightlabel: Label = $rightlabel
@onready var down_icon: Sprite2D = $DownIcon
@onready var left_icon: Sprite2D = $LeftIcon
@onready var up_icon: Sprite2D = $UpIcon
@onready var right_icon: Sprite2D = $RightIcon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var first_loop_done := false

func _ready() -> void:
	apply_translation()

	# Hide buttons at the start
	mainmenu.visible = false
	next.visible = false

	# Connect animation finished signal
	animation_player.animation_finished.connect(_on_animation_finished)

	# Automatically play animation when scene starts
	if animation_player.has_animation("down"):
		animation_player.play("down")
	else:
		print("⚠️ No animation named 'down' found in AnimationPlayer.")
		_show_buttons()


func apply_translation():
	next.text = LanguageManager.get_text("next")
	mainmenu.text = LanguageManager.get_text("mainmenu")
	downlabel.text = LanguageManager.get_text("control1")
	leftlabel.text = LanguageManager.get_text("control2")
	uplabel.text = LanguageManager.get_text("control3")
	rightlabel.text = LanguageManager.get_text("control4")


func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "down":
		if not first_loop_done:
			# After the first loop, show the buttons
			_show_buttons()
			first_loop_done = true
		
		# Replay animation to loop continuously
		animation_player.play("down")


func _show_buttons() -> void:
	mainmenu.visible = true
	next.visible = true


func _on_mainmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/mainmenu.tscn")


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/cut_scene_prologue.tscn")
