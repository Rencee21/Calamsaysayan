extends Area2D

@onready var btn_masterreg: Button = $Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var panel: Panel = $Panel
@onready var text1_masterreg: Label = $Label   # Assuming your text node is a Label (rename if different)
@onready var collected_label: Label = $CollectedLabel  # New label in your scene
@onready var btn_interact: Button = $Interact_btn   # The interaction button

var press_count := 0

func _ready() -> void:
	btn_masterreg.connect("pressed", Callable(self, "_play_animation"))
	btn_interact.connect("pressed", Callable(self, "_on_btn_interact_pressed"))
	
	btn_interact.visible = false   # Hide Button2 at start
	panel.visible = false
	btn_masterreg.visible = false
	text1_masterreg.visible = false
	collected_label.visible = false  # Hide it at the start
	
	# Connect area signals
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _play_animation() -> void:
	press_count += 1

	match press_count:
		1:
			print("First press → play Text")
			btn_interact.visible = false
			anim_player.play("text_1")

		2:
			text1_masterreg.visible = false
			panel.visible = false
			btn_masterreg.visible = false
			
			# Show the collected label
			collected_label.text = "Master Registry Collected!"
			collected_label.visible = true

			# Hide it again after 2 seconds
			await get_tree().create_timer(2.0).timeout
			collected_label.visible = false

			# Free the object
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):   # Make sure only the player triggers it
		btn_interact.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):   # Make sure only the player triggers it
		btn_interact.visible = false

# === SHOW MAIN PANEL + BUTTON WHEN PRESSED BTN2 ===
func _on_btn_interact_pressed():
	panel.visible = true
	btn_masterreg.visible  = true
	text1_masterreg.visible = true
