extends CanvasLayer

@onready var panel: Panel = $Panel
@onready var label: Label = $Panel/Label

var is_showing := false
var hidden_scenes := ["Mainmenu", "Option", "Congratulation"]

func _ready() -> void:
	layer = 10
	process_mode = Node.PROCESS_MODE_ALWAYS

	panel.visible = false
	panel.modulate.a = 1.0
	visible = false  # Start hidden just in case

	# 🔹 Hide immediately if first game load (safe null check)
	if Engine.has_singleton("Global") and Global.first_game_loading:
		hide_completely()
	
	# 🔹 Listen for scene changes
	if not get_tree().is_connected("current_scene_changed", Callable(self, "_on_scene_changed")):
		get_tree().connect("current_scene_changed", Callable(self, "_on_scene_changed"))

	_on_scene_changed(get_tree().current_scene)


func _on_scene_changed(scene: Node) -> void:
	if not scene:
		return

	var scene_name = scene.name
	print("📜 Current Scene:", scene_name)

	# 🔹 Also check if still first load or in hidden list
	'''if Global.first_game_loading or scene_name in hidden_scenes:
		hide_completely()
	else:
		show_ready_state()'''


func hide_completely() -> void:
	visible = false
	panel.visible = false
	is_showing = false


func show_ready_state() -> void:
	visible = true
	panel.visible = false
	is_showing = false


func show_notification(text: String, duration: float = 3.0) -> void:
	if is_showing:
		return

	# 🔹 Double safety: skip if first load or hidden scenes
	if Global.first_game_loading:
		return
	var current_scene = get_tree().current_scene
	if current_scene and current_scene.name in hidden_scenes:
		return

	is_showing = true
	label.text = text

	visible = true
	panel.visible = true
	panel.modulate.a = 0.0

	if panel.has_method("raise"):
		panel.raise()

	print("✅ QuestNotification showing:", text)

	var tween_in = get_tree().create_tween()
	tween_in.tween_property(panel, "modulate:a", 1.0, 0.3)
	await tween_in.finished

	await get_tree().create_timer(duration).timeout

	var tween_out = get_tree().create_tween()
	tween_out.tween_property(panel, "modulate:a", 0.0, 0.3)
	await tween_out.finished

	panel.visible = false
	is_showing = false
