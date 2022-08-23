extends Node2D

func _ready():
	var gamestats = get_node("/root/GameStats")
	var buttons = self.get_node("buttons")
	buttons.set_position(Vector2(gamestats.view_port.x/2,gamestats.view_port.y/2-15))
	buttons.set_scale(buttons.get_scale()/gamestats.viewport_scale)
