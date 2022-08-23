extends Control
onready var click = load("res://Resources/Audios/click3.ogg")
func _ready():
	update_data()

func _input(event):
	if Input.is_action_just_released("quit"):
		_on_exit2_pressed()
	if Input.is_action_just_released("restart"):
		_on_reset2_pressed()


func update_data():
	var player_data = GameStats.get_player_data()
	get_node("MarginContainer/GridContainer/coin2").set_text(str(player_data["total_coin"]))
	get_node("MarginContainer/GridContainer/life2").set_text(str(player_data["total_death"]))
	get_node("MarginContainer/GridContainer/current_level2").set_text(str(player_data["complected_level"]))
	get_node("MarginContainer/GridContainer/total_level2").set_text(str(player_data["total_level"]))
	


func _on_exit2_pressed():
	SceneChanger.change_scene("res://User Interface/main_menu.tscn",0.0)
	AudioManager.play_sfx(click,1)


func _on_reset2_pressed():
	GameStats.reset_saved_data()
	update_data()
	AudioManager.play_sfx(click,1)
