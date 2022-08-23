extends Control
onready var click = load("res://Resources/Audios/click3.ogg")
func _on_TextureButton_pressed():
	SceneChanger.change_scene("res://User Interface/main_menu.tscn",0.0)
	AudioManager.play_sfx(click)
