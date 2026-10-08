extends Sprite2D

@export var map_scene_path: String = "res://scene/map.tscn"
@export var player_group: String = "player"
@onready var portal_area: Area2D = $Area2D

func _ready() -> void:
	visible = false
	portal_area.connect("body_entered", Callable(self, "_on_body_entered"))

func show_portal():
	visible = true
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.5)
	print("✨ Portal appeared!")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(player_group):
		print("🌀 Player entered portal — teleporting to map...")
		GameState.just_came_from_portal = true
		await get_tree().create_timer(1.0).timeout
		teleport_to_map()

func teleport_to_map():
	var map_scene = load(map_scene_path)
	get_tree().change_scene_to_packed(map_scene)
