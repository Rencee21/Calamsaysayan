extends Node2D

var scene_changed: bool = false
var buttons_disabled: bool = false

# === PLAYER & MOVEMENT ===
@onready var player: Player = $player
var astar := AStar2D.new()
var path: Array = []
var path_index := 0
var moving := false
const MOVE_SPEED := 180.0

# === PLAYER LAST MAP POSITION ===
var last_map_position: String = "CCC"  # default starting position

# === ANIMATION PLAYER (for unlock effects) ===
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# === FOR CHECKLIST ===
@onready var checklist_ui = preload("res://scene/checklist_notification.tscn").instantiate()

# === INSTRUCTION ===
@onready var instruction_scene: Node = $instruction

# === MAP BUTTONS ===
@onready var kalanbanga: Button = $kalanbanga
@onready var rizal_shrine_btn: Button = $rizal_shrine_btn
@onready var st_john_church: Button = $st_john_church
@onready var ccc: Button = $ccc

# === CONTROL ===
var pending_scene_key: String = ""
var pending_scene_path: String = ""

# === MAP POINTS (IDs) ===
enum MapPoints { KALANBANGA, RIZAL, KR1, KR2, KC1,KC2, CHURCH, RC1, 
RC2, RCC1, RCC2, CCC, CC1, CC2, CC3 }

func _ready() -> void:
	add_child(checklist_ui)
	checklist_ui.update_checklist()
	
	print("🌍 Map loaded with A* movement.")
	Global.current_scene = "Map"

	_setup_astar_points()

	check_quests_completion(true)
	_check_instruction_status()
	_update_area_locks()

	if not animation_player.is_connected("animation_finished", Callable(self, "_on_animation_finished")):
		animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))

	_check_auto_unlock_on_return()
	GameState.connect("area_unlocked", Callable(self, "_on_area_unlocked"))

func set_last_map_position(area_name: String) -> void:
	last_map_position = area_name
	print("📍 Last map position set to:", area_name)

# === A* SETUP ===
func _setup_astar_points() -> void:
	# === DEFINE MAP POINTS ===
	astar.add_point(MapPoints.KALANBANGA, Vector2(160, 368))
	astar.add_point(MapPoints.KR1, Vector2(312, 384))
	astar.add_point(MapPoints.KR2, Vector2(312, 638))
	astar.add_point(MapPoints.RIZAL, Vector2(494, 638))
	astar.add_point(MapPoints.KC1, Vector2(323, 368))
	astar.add_point(MapPoints.KC2, Vector2(323, 255))
	astar.add_point(MapPoints.CHURCH, Vector2(418, 254))
	astar.add_point(MapPoints.RC2, Vector2(331, 254))
	astar.add_point(MapPoints.RC1, Vector2(331, 638))
	astar.add_point(MapPoints.RCC1, Vector2(331, 638))
	astar.add_point(MapPoints.RCC2, Vector2(331, 391))
	astar.add_point(MapPoints.CC1, Vector2(627, 214))
	astar.add_point(MapPoints.CC2, Vector2(705, 214))
	astar.add_point(MapPoints.CC3, Vector2(705, 388))
	astar.add_point(MapPoints.CCC, Vector2(1018, 388))

	# === HIGH-LEVEL BI-DIRECTIONAL ROUTES ===
	# KalanBanga ↔ Rizal
	astar.connect_points(MapPoints.KALANBANGA, MapPoints.KR1)
	astar.connect_points(MapPoints.KR1, MapPoints.KR2)
	astar.connect_points(MapPoints.KR2, MapPoints.RIZAL)
	astar.connect_points(MapPoints.RIZAL, MapPoints.KR2)
	astar.connect_points(MapPoints.KR2, MapPoints.KR1)
	astar.connect_points(MapPoints.KR1, MapPoints.KALANBANGA)

	# KalanBanga ↔ Church
	astar.connect_points(MapPoints.KALANBANGA, MapPoints.KC1)
	astar.connect_points(MapPoints.KC1, MapPoints.KC2)
	astar.connect_points(MapPoints.KC2, MapPoints.CHURCH)
	astar.connect_points(MapPoints.CHURCH, MapPoints.KC2)
	astar.connect_points(MapPoints.KC2, MapPoints.KC1)
	astar.connect_points(MapPoints.KC1, MapPoints.KALANBANGA)

	# KalanBanga ↔ CCC
	astar.connect_points(MapPoints.KALANBANGA, MapPoints.CCC)
	astar.connect_points(MapPoints.CCC, MapPoints.KALANBANGA)

	# Rizal ↔ Church
	astar.connect_points(MapPoints.RIZAL, MapPoints.RC1)
	astar.connect_points(MapPoints.RC1, MapPoints.RC2)
	astar.connect_points(MapPoints.RC2, MapPoints.CHURCH)
	astar.connect_points(MapPoints.CHURCH, MapPoints.RC2)
	astar.connect_points(MapPoints.RC2, MapPoints.RC1)
	astar.connect_points(MapPoints.RC1, MapPoints.RIZAL)

	# Rizal ↔ CCC
	astar.connect_points(MapPoints.RIZAL, MapPoints.RCC1)
	astar.connect_points(MapPoints.RCC1, MapPoints.RCC2)
	astar.connect_points(MapPoints.RCC2, MapPoints.CCC)
	astar.connect_points(MapPoints.CCC, MapPoints.RCC2)
	astar.connect_points(MapPoints.RCC2, MapPoints.RCC1)
	astar.connect_points(MapPoints.RCC1, MapPoints.RIZAL)

	# Church ↔ CCC
	astar.connect_points(MapPoints.CHURCH, MapPoints.CC1)
	astar.connect_points(MapPoints.CC1, MapPoints.CC2)
	astar.connect_points(MapPoints.CC2, MapPoints.CC3)
	astar.connect_points(MapPoints.CC3, MapPoints.CCC)
	astar.connect_points(MapPoints.CCC, MapPoints.CC3)
	astar.connect_points(MapPoints.CC3, MapPoints.CC2)
	astar.connect_points(MapPoints.CC2, MapPoints.CC1)
	astar.connect_points(MapPoints.CC1, MapPoints.CHURCH)

	# === START POSITION ===
	match GameState.last_map_position:
		"KalanBanga":
			player.global_position = astar.get_point_position(MapPoints.KALANBANGA)
		"RizalShrine":
			player.global_position = astar.get_point_position(MapPoints.RIZAL)
		"Church":
			player.global_position = astar.get_point_position(MapPoints.CHURCH)
		"CCC":
			player.global_position = astar.get_point_position(MapPoints.CCC)
		_:
			player.global_position = astar.get_point_position(MapPoints.CCC)



# === MOVEMENT ===
func move_to(target_id: int, scene_key: String, scene_path: String):
	if moving: return

	var start_id = astar.get_closest_point(player.global_position)
	path = astar.get_point_path(start_id, target_id)

	if path.is_empty(): return

	pending_scene_key = scene_key
	pending_scene_path = scene_path
	path_index = 0
	moving = true
	buttons_disabled = true
	_disable_map_buttons()
	player._disable_input() # prevent manual input while auto-walking

func _physics_process(delta: float) -> void:
	if moving and path.size() > 0:
		var target_pos = path[path_index]
		var reached = player.move_towards(target_pos, delta)

		if reached:
			path_index += 1
			if path_index >= path.size():
				moving = false
				player.play_anim(false)
				player._enable_input()
				_on_reach_destination()
	else:
		if not moving:
			player.play_anim(false)

# === REACH DESTINATION ===
func _on_reach_destination() -> void:
	if checklist_ui:
		checklist_ui.update_checklist()
		
	print("✅ Player reached destination.")
	_enable_map_buttons()

	if pending_scene_key != "" and pending_scene_path != "":
		print("➡️ Entering scene:", pending_scene_key)

		# 🧭 Save the player's last visited map area before changing scenes
		GameState.set_last_map_position(pending_scene_key)

		_enter_scene(pending_scene_key, pending_scene_path)
		pending_scene_key = ""
		pending_scene_path = ""


# === AREA UNLOCK SIGNAL HANDLER ===
func _on_area_unlocked(area_name: String):
	match area_name:
		"Rizal": animation_player.play("rizal_unlock")
		"Church": animation_player.play("church_unlock")
		"CCC": animation_player.play("ccc_unlock")

# === INSTRUCTION LOGIC ===
func _check_instruction_status() -> void:
	if not GameState.instruction_played:
		print("⚠️ Instruction not finished. Only KalanBanga is available.")
		buttons_disabled = true
		_disable_map_buttons()
		kalanbanga.disabled = false
		if instruction_scene.has_signal("instruction_finished"):
			instruction_scene.connect("instruction_finished", Callable(self, "_on_instruction_finished"))
	else:
		print("✅ Instruction already finished. Map buttons enabled.")
		_enable_map_buttons()

func _disable_map_buttons() -> void:
	for button in get_tree().get_nodes_in_group("map_buttons"):
		button.disabled = true

func _enable_map_buttons() -> void:
	for button in get_tree().get_nodes_in_group("map_buttons"):
		button.disabled = false
	buttons_disabled = false

func _on_instruction_finished() -> void:
	print("🎓 Instruction completed. Enabling map buttons!")
	GameState.instruction_played = true
	_enable_map_buttons()
	QuestNotification.show_notification(LanguageManager.get_text("map_instruction_complete"))

# === BUTTON HANDLERS ===
func _on_kalanbanga_pressed() -> void:
	if buttons_disabled: return
	# Always allow visiting KalanBanga
	if GameState.kalanbanga_done:
		QuestNotification.show_notification(LanguageManager.get_text("quest_already_finished"))
	move_to(MapPoints.KALANBANGA, "KalanBanga", "res://scene/tutorial_kalan_banga.tscn")

func _on_rizal_shrine_btn_pressed() -> void:
	if buttons_disabled: return
	if not GameState.kalanbanga_done:
		QuestNotification.show_notification(LanguageManager.get_text("need_finish_kalanbanga"))
		return
	# Always allow visiting even if done
	if GameState.rizal_done:
		QuestNotification.show_notification(LanguageManager.get_text("quest_already_finished"))
	move_to(MapPoints.RIZAL, "RizalShrine", "res://scene/tutorial_rizal.tscn")

func _on_st_john_church_pressed() -> void:
	if buttons_disabled: return
	if not GameState.rizal_done:
		QuestNotification.show_notification(LanguageManager.get_text("need_finish_rizal"))
		return
	# Always allow revisiting
	if GameState.church_done:
		QuestNotification.show_notification(LanguageManager.get_text("quest_already_finished"))
	move_to(MapPoints.CHURCH, "Church", "res://scene/tutorial_church.tscn")

func _on_ccc_pressed() -> void:
	if buttons_disabled: return
	if not GameState.church_done:
		QuestNotification.show_notification(LanguageManager.get_text("need_finish_church"))
		return
	# Always allow revisiting
	if GameState.ccc_done:
		QuestNotification.show_notification(LanguageManager.get_text("quest_already_finished"))
	move_to(MapPoints.CCC, "CCC", "res://scene/tutorial_ccc.tscn")


# === SCENE CHANGE ===
func _enter_scene(scene_key: String, scene_path: String) -> void:
	Global.transition_scene = true
	Global.target_scene = scene_key
	get_tree().change_scene_to_file(scene_path)

# === QUEST CHECK + AUTO UNLOCK ===
func check_quests_completion(initial := false) -> void:
	print("🧭 Checking quest completion status...")

	if not initial:
		if GameState.kalanbanga_done and not GameState.rizal_unlocked:
			GameState.unlock_area("Rizal")
			animation_player.play("rizal_unlock")
		if GameState.rizal_done and not GameState.church_unlocked:
			GameState.unlock_area("Church")
			animation_player.play("church_unlock")
		if GameState.church_done and not GameState.ccc_unlocked:
			GameState.unlock_area("CCC")
			animation_player.play("ccc_unlock")

	if GameState.all_quests_done() and GameState.congratulation_ready and GameState.just_came_from_portal and not scene_changed:
		scene_changed = true
		GameState.congratulation_ready = false
		GameState.just_came_from_portal = false
		QuestNotification.show_notification(LanguageManager.get_text("all_quests_complete"))
		await get_tree().create_timer(4.0).timeout
		get_tree().change_scene_to_file("res://scene/congratulation.tscn")
	else:
		GameState.just_came_from_portal = false

func _check_auto_unlock_on_return() -> void:
	print("🔍 Checking auto unlocks after returning to map...")
	if animation_player.is_playing(): return
	_disable_map_buttons()

	if GameState.kalanbanga_done and not GameState.rizal_done:
		if not GameState.rizal_unlocked: GameState.unlock_area("Rizal")
		await _play_unlock_sequence(["rizal_unlock"])
		_enable_map_buttons()
		return

	if GameState.rizal_done and not GameState.church_done:
		if not GameState.church_unlocked: GameState.unlock_area("Church")
		await _play_unlock_sequence(["rizal_unlock"])
		await _play_unlock_sequence(["church_unlock"])
		_enable_map_buttons()
		return

	if GameState.church_done and not GameState.ccc_done:
		if not GameState.ccc_unlocked: GameState.unlock_area("CCC")
		await _play_unlock_sequence(["rizal_unlock"])
		await _play_unlock_sequence(["church_unlock"]) 
		await _play_unlock_sequence(["ccc_unlock"])
		_enable_map_buttons()
		return

	if GameState.all_quests_done():
		if not scene_changed:
			scene_changed = true
			await get_tree().create_timer(1.5).timeout
			get_tree().change_scene_to_file("res://scene/congratulation.tscn")
			return

	_enable_map_buttons()

func _play_unlock_sequence(anims: Array) -> void:
	for anim in anims:
		if animation_player.has_animation(anim):
			print("▶️ Playing animation:", anim)
			animation_player.play(anim)
			await animation_player.animation_finished

func _update_area_locks() -> void:
	kalanbanga.disabled = false
	
	# ✅ Rizal stays permanently unlocked once it's unlocked
	if GameState.rizal_unlocked or GameState.kalanbanga_done:
		rizal_shrine_btn.disabled = false
	else:
		rizal_shrine_btn.disabled = true
	
	# Church unlocks only after Rizal is done
	st_john_church.disabled = not GameState.rizal_done
	
	# CCC unlocks only after Church is done
	ccc.disabled = not GameState.church_done


# === OPTIONS MENU ===
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		_open_options_menu()

func _open_options_menu() -> void:
	get_tree().paused = true
	var options = preload("res://scene/option.tscn").instantiate()
	options.return_to_main = false
	add_child(options)
	options.grab_focus()
