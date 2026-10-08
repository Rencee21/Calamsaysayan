extends Node

# === ENUM FOR ENTRY DIRECTIONS ===
enum EntryDirection {
	NONE,
	FROM_KALANBANGA,
	FROM_CCC,
	FROM_CHURCH,
	FROM_RIZAL,
	START
}

# === SCENE TRACKING ===
var current_scene = ""
var transition_scene = false
var target_scene = ""
var entry_direction = EntryDirection.START  # default on first load

# === PLAYER ENTRY POSITIONS ===
var player_enter_kalanbanga_posx = 232.0
var player_enter_kalanbanga_posy = 592.0
var player_enter_ccc_posx = 82.0
var player_enter_ccc_posy = 362.0
var player_enter_church_posx = 728.0
var player_enter_church_posy = 664.0
var player_enter_rizal_posx = 1150.0
var player_enter_rizal_posy = 228.0

# === QUEST PROGRESS ===
var instruction_played = false
var kalanbanga_done = false
var ccc_done = false
var church_done = false
var rizal_done = false
var returned_to_map_after_all_done = false

# === NEW: STARTUP TRACKER ===
var first_game_loading := false

func _ready() -> void:
	check_first_game_load()

# === FUNCTIONS ===
func check_first_game_load() -> void:
	if first_game_loading:
		first_game_loading = false
		get_tree().change_scene_to_file("res://scene/mainmenu.tscn")

func finished_changescene():
	if transition_scene:
		current_scene = target_scene
		transition_scene = false
		target_scene = ""

func get_entry_position(scene_name: String) -> Vector2:
	match scene_name:
		"KalanBanga":
			entry_direction = EntryDirection.FROM_KALANBANGA
			return Vector2(player_enter_kalanbanga_posx, player_enter_kalanbanga_posy)
		"CCC":
			entry_direction = EntryDirection.FROM_CCC
			return Vector2(player_enter_ccc_posx, player_enter_ccc_posy)
		"Church":
			entry_direction = EntryDirection.FROM_CHURCH
			return Vector2(player_enter_church_posx, player_enter_church_posy)
		"RizalShrine":
			entry_direction = EntryDirection.FROM_RIZAL
			return Vector2(player_enter_rizal_posx, player_enter_rizal_posy)
		_:
			entry_direction = EntryDirection.NONE
			return Vector2.ZERO
