extends Control
extends Control
onready var click = load("res://Resources/Audios/click3.ogg")

func _on_exit_pressed():
	AudioManager.play_sfx(click,1)
	get_tree().quit()

func _on_achivements_pressed():
	AudioManager.play_sfx(click,1)
	SceneChanger.change_scene("res://Others/data.tscn",0.0) 

func _on_play_pressed():
	AudioManager.play_sfx(click,1)
	GameStats.play_next_level()

func _on_world_pressed():
	AudioManager.play_sfx(click,1)
	SceneChanger.change_scene("res://User Interface/world_menu.tscn",0.0)

func _on_setting_pressed():
	AudioManager.play_sfx(click,1)




func _on_others_pressed():
	SceneChanger.change_scene("res://User Interface/Settings.tscn",0.0)
	AudioManager.play_sfx(click,1)

