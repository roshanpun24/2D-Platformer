extends AnimatedSprite
var sound_clip=load("res://Resources/Audios/sfx_coin_double3.wav")
func _on_Area2D_body_entered(body):
	if body.name==("Player"):
		AudioManager.play_sfx(sound_clip,4)
		GameStats.coin_collected()
		self.queue_free()
