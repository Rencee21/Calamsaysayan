# AudioManager.gd
extends Node

var music_player: AudioStreamPlayer
var is_muted: bool = false

func _ready():
	# Create a global AudioStreamPlayer if not existing
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.stream = preload("res://background_music.mp3") # your background music
	music_player.play()

func set_mute(value: bool) -> void:
	is_muted = value
	music_player.volume_db = -80 if value else 0  # -80 dB is basically silence

func toggle_mute() -> void:
	set_mute(!is_muted)
