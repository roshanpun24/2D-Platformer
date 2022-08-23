extends KinematicBody2D
const FLOOR_NORMAL: = Vector2.UP
export var speed: = Vector2(40,1000) #maximum horixontal and vertical speed
export var gravity: = 3000.0
var _velocity: = Vector2.ZERO
var sound_clip = load("res://Resources/Audios/coin_SFX.wav")


func _ready():
	_velocity.x = speed.x

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0 
		$AnimatedSprite.offset.x=-$AnimatedSprite.offset.x
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func _on_storm_area_body_entered(body):
	if body.name=="Player":
		GameStats.enemy_dead()
		queue_free()
		AudioManager.play_sfx(sound_clip,2)

func _on_player_detection_body_entered(body):
	if body.name=="Player":
		GameStats.player_hurt()
