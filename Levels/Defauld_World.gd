extends Node2D
export (AudioStream) var audio =null
func _ready():
	AudioManager.play_music(audio)
