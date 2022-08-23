extends AnimatedSprite
var Position =Vector2.ZERO
var _is_already_checked = false
onready var sprite = get_node(".")
func _on_Area2D_body_entered(body):
	if body.name =="Player" and !_is_already_checked:
		Position = self.get_position()
		_is_already_checked=true
		GameStats.update_checkpoint(Position)
		sprite.play("flag_out")
		yield(get_tree().create_timer(1),"timeout")
		sprite.play("flag_idle")
