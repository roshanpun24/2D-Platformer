extends Control
var is_restart = false
func _input(event):
	if event.is_action_pressed("pause") or is_restart:
		is_restart =false
		var new_pause_state =not get_tree().paused
		get_tree().paused = not get_tree().paused
		self.visible = new_pause_state

	if Input.is_action_just_pressed("quit"):
		get_tree().paused = false
		get_tree().change_scene("res://User Interface/main_menu.tscn") 
		GameStats.reset_datas()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
		GameStats.level_restarted()
		
