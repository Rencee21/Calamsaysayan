extends AudioStreamPlayer2D

var level_music = preload("res://background_music.mp3")

func _ready() -> void:
	level_music.loop = true
	
func _play_music(music : AudioStream, volume = 0.0) :
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()

func _play_music_level():
	_play_music(level_music)
