extends Node
var player_life= 5
var total_coin = 0
var all_collected_coin = 0
var total_death = 0
var all_death = 0

var previous_coin=0
var previous_life=5

signal player_died
signal no_life
signal check_post
signal update_ui
signal enemy_dead

var next_scene
var check_post = Vector2.ZERO
var viewport_scale
var viewport_res
var view_port
var current_level
var player_data ={
	"total_coin":0,
	"total_death":0,
	"complected_level":1,
	"total_level":9
}

var player_data_path = "user://player_data.json"
func _ready():
	#get the size of current window
	view_port = get_node("/root").get_children()[3].get_viewport_rect().size
	#get view resolution
	viewport_res = get_node("/root").get_children()[3].get_viewport_rect().size
	#this will generate scale value for camera to zoom if resolution height is different
	viewport_scale = 144/view_port.y
	
	
	#disable bwlow for web export
	player_data = get_data(player_data_path)
	if player_data ==null:
		reset_saved_data()
	

func coin_collected():
	total_coin=total_coin+1
	player_data["total_coin"]=player_data["total_coin"]+1
	update_data()
	update_ui()
	
	
func level_restarted():
	total_coin=previous_coin
	player_life=previous_life
	
func level_progress(level :int):
	previous_coin=total_coin
	previous_life=player_life
	
	if level==player_data["complected_level"]:
		if level==player_data["total_level"]:
			player_data["complected_level"]=level
			SceneChanger.change_scene("res://User Interface/world_menu.tscn",0.0)
		else:
			player_data["complected_level"]=level+1
			SceneChanger.change_scene(level_to_string(level+1),0.0)
	else:
		SceneChanger.change_scene(level_to_string(level+1),0.0)
	update_data()
	
func play_next_level():
	SceneChanger.change_scene(level_to_string(player_data["complected_level"]),0.0)
	
func set_check_post(value):
	check_post=value

func set_current_level(a :int):
	current_level = a
	
func get_player_data() -> Dictionary:
	return player_data
	
func get_check_post()->Vector2:
	return check_post
	
func player_hurt():
	player_life-=1
	emit_signal("player_died")
	total_death=total_death+1
	update_ui()
	if player_life==0:
		emit_signal("no_life")
	player_data["total_death"]=player_data["total_death"]+1
	update_data()
	#write to file
	
func update_ui():
	emit_signal("update_ui")
func enemy_dead():
	emit_signal("enemy_dead")
	
func increase_life(value):
	player_life+=value
	update_ui()
	
func update_checkpoint(position):
	check_post=position

func reset_datas():
	player_life=5
	total_coin=0
	
	
func reset_saved_data():
	player_data ={
	"total_coin":0,
	"total_death":0,
	"complected_level":1,
	"total_level":10
	}
	update_data()

func get_data(path:String) -> Dictionary:
	var dict = {}
	var file = File.new()
	file.open(path, file.READ)
	dict = parse_json(file.get_as_text())
	file.close()
	return dict

func update_data():
	var file = File.new()
	file.open(player_data_path, file.WRITE)
	file.store_string(to_json(player_data))
	file.close()

func level_to_string(level:int):
	var level_path = "res://Levels/"+str(level)+".tscn"
	return level_path
