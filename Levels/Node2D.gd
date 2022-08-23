extends Node2D
export (AudioStream) var audio  = load("res://Resources/Audios/04 - Sanctuary.ogg")
func _ready():
	print(audio)
	AudioManager.play_music(audio)
