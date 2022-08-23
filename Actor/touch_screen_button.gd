extends CanvasLayer

func _ready():
	var gamestats = get_node("/root/GameStats")
	var left = get_node("left")
	var right=get_node("right")
	var up=get_node("up")
	var pause = get_node("pause")
	var score_lifes = get_node("scores")

	left.set_global_position(Vector2(10,gamestats.view_port.y-30))
	left.set_scale(left.get_scale()/gamestats.viewport_scale)
	
	right.set_position(Vector2(50,gamestats.view_port.y-30))
	right.set_scale(right.get_scale()/gamestats.viewport_scale)

	up.set_position(Vector2(gamestats.view_port.x-30,gamestats.view_port.y-30))
	up.set_scale(up.get_scale()/gamestats.viewport_scale)
	
	pause.set_position(Vector2(gamestats.view_port.x-16,1))
	pause.set_scale(pause.get_scale()/gamestats.viewport_scale)
	
	score_lifes.set_position(Vector2(6,6))
	score_lifes.set_scale(score_lifes.get_scale()/gamestats.viewport_scale)

