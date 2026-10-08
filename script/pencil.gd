extends Area2D

@onready var btn: Button = $Button
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var panel: Panel = $Panel
@onready var text1: Label = $Label   # Assuming your text node is a Label (rename if different)
@onready var text2: Label = $Label2
@onready var text3: Label = $Label3
@onready var collected_label: Label = $CollectedLabel  # New label in your scene
@onready var btn2: Button = $Button2   # The interaction button


var press_count := 0

func _ready() -> void:
	btn.connect("pressed", Callable(self, "_play_animation"))
	btn2.connect("pressed", Callable(self, "_on_btn2_pressed"))
	
	btn2.visible = false   # Hide Button2 at start
	panel.visible = false
	btn.visible = false
	text1.visible = false
	text2.visible = false
	text3.visible = false
	collected_label.visible = false  # Hide it at the start
	
	# Connect area signals
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _play_animation() -> void:
	press_count += 1

	match press_count:
		1:
			print("First press → play Text")
			btn2.visible = false
			anim_player.play("text")

		2:
			print("Second press → hide Text, play Text_2")
			if text1:
				text1.visible = false
			anim_player.play("text_2")

		3:
			print("Third press → hide Text_2, play Text_3")
			if text2:
				text2.visible = false
			anim_player.play("text_3")
		
		4:
			text3.visible = false
			panel.visible = false
			btn.visible = false
			
			# Show the collected label
			collected_label.text = "Pencil Collected!"
			collected_label.visible = true

			# Hide it again after 2 seconds
			await get_tree().create_timer(2.0).timeout
			collected_label.visible = false

			# Free the object
			queue_free()
			
			

# === INTERACTION AREA HANDLERS ===
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):   # Make sure only the player triggers it
		btn2.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		btn2.visible = false
		
# === SHOW MAIN PANEL + BUTTON WHEN PRESSED BTN2 ===
func _on_btn2_pressed():
	panel.visible = true
	btn.visible  = true
	text1.visible = true
	text2.visible = true
	text3.visible =true
