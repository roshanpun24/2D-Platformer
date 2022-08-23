extends KinematicBody2D
const FLOOR_NORMAL: = Vector2.UP
const MAX_SPEED = 80
const FRICTION = 20
const ACCELERATION = 20
const JUMP_SPEED =260
const GRAVITY = 12
var _velocity = Vector2.ZERO
var input_dir = 0
var is_near_floor =true
var is_jumpable = true
var is_jump_pressed= false
var have_life = true
onready var animation = get_node("AnimatedSprite")
onready var particles = get_node("particles")
onready var score = get_node("gui/scores/coin_number")
onready var life  = get_node("gui/scores/lives_number")
onready var audio1 = load("res://Resources/Audios/jump_03.wav")
onready var audio2 = load("res://Resources/Audios/sfx_damage_hit1.wav")
onready var flash = get_node("flash")
onready var ray = $RayCast2D
var initial_position = Vector2.ZERO

func _ready():
	
	GameStats.connect("player_died",self,"player_dead")
	GameStats.connect("no_life",self,"no_life")
	GameStats.connect("update_ui",self,"update_ui")
	GameStats.connect("enemy_dead",self,"enemy_dead")
	initial_position = self.get_position()
	GameStats.set_check_post(initial_position)
	#this will set zoom factor for camera2D
	get_node("Camera2D").set_zoom(get_node("Camera2D").get_zoom()*get_node("/root/GameStats").viewport_scale)
	update_ui()
	
func _physics_process(delta):
	#applying gravity
	_velocity.y +=GRAVITY
	
	if _velocity.y>JUMP_SPEED:
		_velocity.y=JUMP_SPEED

	if is_on_floor() or is_near_floor:
		is_jumpable = true
	else :
		cayoteTime()
		
	if is_jump_pressed and is_jumpable:
		is_jump_pressed=false
		is_near_floor =false
		_velocity.y = -JUMP_SPEED
		AudioManager.play_sfx(audio1,2)
	movement(delta)

func _input(event):
	#reguister input only if player have life
	if have_life:
		input_dir = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
		if Input.is_action_just_pressed("jump") :
			is_jump_pressed=true
			#code below is to enable jump if player is near floor
			ray.force_raycast_update()
			if ray.is_colliding():
				is_near_floor = true
	else:
		input_dir = 0
		
func movement(delta):
	if input_dir != 0:
		#apply acccleration
		_velocity.x = move_toward(_velocity.x*input_dir,MAX_SPEED,ACCELERATION)
		_velocity.x=_velocity.x*input_dir
	else:
		#appling fraction
		_velocity.x = move_toward(_velocity.x,0,FRICTION) 
		particles.emitting=false
	
	handle_animation()
	_velocity = move_and_slide(_velocity,FLOOR_NORMAL)

func player_dead():
	AudioManager.play_sfx(audio2,2)
	if !GameStats.player_life==0:
		GameStats.get_check_post()
		self.set_position(GameStats.get_check_post())
		flash.emitting = true
func enemy_dead():
	_velocity.y = -JUMP_SPEED
	
func cayoteTime():
	yield(get_tree().create_timer(0.2),"timeout")
	is_jumpable = false
	is_jump_pressed=false

func handle_animation():
	if input_dir>0 :
		animation.set_flip_h(false)
		if is_on_floor():
			play_animation("run")
	elif input_dir<0 :
		  
		if is_on_floor():
			play_animation("run")
	if _velocity.x==0 and is_on_floor():
		play_animation("idle")
	else:
		particles.emitting=true
	if _velocity.y<0:
		play_animation("jump_start")
	if _velocity.y>GRAVITY:
		play_animation("jump_down")

func play_animation(anim):
	#if current animation is same as playing animation, no need to play animation again
	if animation.is_playing() and animation.get_animation()==anim:
		return
	animation.play(anim)

func no_life():
	have_life = false
	SceneChanger.change_scene("res://User Interface/world_menu.tscn",0.5)
	GameStats.reset_datas()
	#change scene to repeat
func update_ui():
	score.set_text(String(GameStats.total_coin))
	life.set_text(String(GameStats.player_life))
