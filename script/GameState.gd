extends Node

# === GLOBAL QUEST STATES ===
var instruction_played: bool = false
var prologue_played: bool = false
var ccc_intro_played: bool = false


# === ASSESSMENT FLAG (for CCC only) ===
var assessment_done: bool = false

# === QUEST COMPLETION FLAGS ===
var kalanbanga_done: bool = false
var rizal_done: bool = false
var church_done: bool = false
var ccc_done: bool = false

# === CONTROL FLAGS ===
var congratulation_ready: bool = false
var just_came_from_portal: bool = false
var returned_to_map_after_all_done: bool = false

# === TRACK WHICH SCENES HAVE BEEN VISITED ===
var visited_scenes = {
	"KalanBanga": false,
	"RizalShrine": false,
	"Church": false,
	"CCC": false
}



# === AREA LOCK/UNLOCK STATES ===
# These track whether an area is currently accessible on the Map
var rizal_unlocked: bool = false
var church_unlocked: bool = false
var ccc_unlocked: bool = false

# ✅ === PLAYER LAST MAP POSITION ===
# This stores where the player was last located on the map
var last_map_position: String = "CCC"

# Helper function to update position when moving to a new area
func set_last_map_position(area_name: String) -> void:
	last_map_position = area_name
	print("📍 Last map position set to:", area_name)
# === SIGNALS (optional but helpful for Map) ===
signal area_unlocked(area_name: String)
signal all_quests_finished

# === CALLED EVERY TIME YOU COMPLETE A QUEST ===
func check_all_quests() -> void:
	if all_quests_done():
		if not congratulation_ready:
			congratulation_ready = true
			print("🎯 All quests completed! Player must return to the Map first.")
			emit_signal("all_quests_finished")
	else:
		print("🔹 Not all quests done yet.")
		_update_unlocks()

# === RESET VISITED SCENES ===
func reset_visited_scenes() -> void:
	for key in visited_scenes.keys():
		visited_scenes[key] = false

# === RETURN TRUE IF ALL QUESTS ARE DONE ===
func all_quests_done() -> bool:
	return kalanbanga_done and rizal_done and church_done and ccc_done

# === UPDATE UNLOCK CONDITIONS ===
func _update_unlocks() -> void:
	# 🔓 Unlock Rizal when KalanBanga is done
	if kalanbanga_done and not rizal_unlocked:
		rizal_unlocked = true
		print("🎬 Rizal Shrine unlocked after finishing KalanBanga!")
		emit_signal("area_unlocked", "Rizal")

	# 🔓 Unlock Church when Rizal is done
	if rizal_done and not church_unlocked:
		church_unlocked = true
		print("🎬 Church unlocked after finishing Rizal!")
		emit_signal("area_unlocked", "Church")

	# 🔓 Unlock CCC when Church is done
	if church_done and not ccc_unlocked:
		ccc_unlocked = true
		print("🎬 CCC unlocked after finishing Church!")
		emit_signal("area_unlocked", "CCC")

# === RESET ALL GAME PROGRESS (OPTIONAL) ===
func reset_game() -> void:
	instruction_played = false
	kalanbanga_done = false
	rizal_done = false
	church_done = false
	ccc_done = false
	congratulation_ready = false
	just_came_from_portal = false
	returned_to_map_after_all_done = false
	rizal_unlocked = false
	church_unlocked = false
	ccc_unlocked = false
	reset_visited_scenes()
	print("🔁 GameState has been fully reset.")

# === UNLOCK AN AREA (PLAYS ONLY ONCE) ===
func unlock_area(area_name: String) -> bool:
	match area_name:
		"Rizal":
			if not rizal_unlocked:
				rizal_unlocked = true
				print("🔓 Rizal area unlocked manually!")
				emit_signal("area_unlocked", "Rizal")
				return true
		"Church":
			if not church_unlocked:
				church_unlocked = true
				print("🔓 Church area unlocked manually!")
				emit_signal("area_unlocked", "Church")
				return true
		"CCC":
			if not ccc_unlocked:
				ccc_unlocked = true
				print("🔓 CCC area unlocked manually!")
				emit_signal("area_unlocked", "CCC")
				return true
	return false
