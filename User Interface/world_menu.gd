extends Control
onready var click = load("res://Resources/Audios/click3.ogg")

func _ready():
	var button_count = get_node("MarginContainer/HBoxContainer/HBoxContainer/GridContainer").get_child_count()
	var player_data = GameStats.get_player_data()
	for i in range(1,button_count+1):
		if i>player_data["complected_level"]:
			var button = get_node("MarginContainer/HBoxContainer/HBoxContainer/GridContainer/"+str(i))
			button.disabled = true
			
func change_scene(a:int):
	SceneChanger.change_scene(GameStats.level_to_string(a),0.0)
	AudioManager.play_sfx(click)
func _on_TextureButton_pressed():
	change_scene(1)


func _on_TextureButton2_pressed():
	change_scene(2)


func _on_TextureButton3_pressed():
	change_scene(3)


func _on_TextureButton4_pressed():
	change_scene(4)


func _on_TextureButton5_pressed():
	change_scene(5)


func _on_TextureButton6_pressed():
	change_scene(6)


func _on_TextureButton7_pressed():
	change_scene(7)


func _on_TextureButton8_pressed():
	change_scene(8)


func _on_TextureButton9_pressed():
	change_scene(9)


func _on_return_pressed():
	SceneChanger.change_scene("res://User Interface/main_menu.tscn",0.0)
	AudioManager.play_sfx(click)
