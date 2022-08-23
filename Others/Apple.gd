extends AnimatedSprite
var value = 1
var sound_clip=load("res://Resources/Audios/jump_03.wav")
func _on_Area2D_body_entered(body):
	if body.name=="Player":
		AudioManager.play_sfx(sound_clip,3)
		GameStats.increase_life(value)
		self.queue_free()
