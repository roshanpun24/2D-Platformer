extends AnimatedSprite

func _on_Area2D_body_entered(body):
	if body.name =="Player":
		var audio = load("res://Resources/Audios/question_001.ogg")
		AudioManager.play_sfx(audio,1)
		#the reasion to get 3rd child is that gamestats and audioplayer manager are first two
		#children since they are autoload
		GameStats.level_progress(int(get_tree().root.get_child(3).name))
