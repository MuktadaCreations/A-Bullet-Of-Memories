extends KinematicBody2D

export var Enabled = false

export var SpeedEc = 10
export var SpeedLimit = 100
export var StoppingEc = 1
var Speed = 0

export var GravityEc = 10
export var GravityLimit = 100
const FixableGravity = 4
var Gravity = 0

export var JumpSpeed = 10
export var JumpLimit = 100
var JumpTrigger = false

export var Idle_Speed = 1
export var Running_Speed = 3

onready var Bullet = preload("res://Kinematics/Player/Extra/Bullet.tscn")
#onready var PistolAmmo = Global.Ammo
export var BulletTimeEffect = 30
var Time = false
export var StaminaTimerOri = 0.1
export var StaminaTimer = 0.1

export (AudioStream) var ShootingSound

var Motion = Vector2.ZERO
var GravFix = Vector2(0,-1)

 
func _ready():
	$PlayerRig/AnimationPlayer.current_animation = "Idle"

func _physics_process(delta):
	
	if !Enabled:
		MovementAndChecking()
	
	EffectsAndOthers()
	Animations()
	

func MovementAndChecking():
	var delta = get_process_delta_time()
	#-------------------------------------------------Horizantol Movement
	if Speed > 0 and !Input.is_action_pressed("Right"):
		Speed -= StoppingEc
		$PlayerRig/AnimationPlayer.current_animation = "Idle"
	
	if Input.is_action_pressed("Right"):
		Speed += SpeedEc
		$PlayerRig/AnimationPlayer.current_animation = "Running"
		$PlayerRig.scale = Vector2(1,1)
	
	if Speed < 0 and !Input.is_action_pressed("Left"):
		Speed += StoppingEc
		$PlayerRig/AnimationPlayer.current_animation = "Idle"
	
	if Input.is_action_pressed("Left"):
		Speed -= SpeedEc
		$PlayerRig/AnimationPlayer.current_animation = "Running"
		$PlayerRig.scale = Vector2(-1,1)
	
	
	if Speed >= SpeedLimit:
		Speed = SpeedLimit
		$PlayerRig/AnimationPlayer.current_animation = "Running"
	
	if Speed <= -SpeedLimit:
		Speed = -SpeedLimit
		$PlayerRig/AnimationPlayer.current_animation = "Running"
	
	
	if !Input.is_action_pressed("Left") and !Input.is_action_pressed("Right") and is_on_floor():
		Speed = 0
		$PlayerRig/AnimationPlayer.current_animation = "Idle"
	#-------------------------------------------------Horizantol Movement
	
	#-------------------------------------------------Vertocal Movement
	if Input.is_action_pressed("Accept") and is_on_floor() and JumpTrigger == false:
		JumpTrigger = true
	
	if Input.is_action_just_released("Accept") and JumpTrigger == true:
		JumpTrigger = false
	
	if JumpTrigger == true:
		Gravity -= JumpSpeed
	
	if Gravity <= -JumpLimit and JumpTrigger:
		JumpTrigger = false
	#-------------------------------------------------Vertocal Movement
	
	#-------------------------------------------------Compat
	if Input.is_action_pressed("RightClick"):
		$PlayerRig/Shooter.look_at(get_global_mouse_position())
		$PlayerRig/Shooter.rotation_degrees -= 90
		$PlayerRig/Hand.visible = false
		$PlayerRig/Shooter.visible = true
	
	if Input.is_action_just_pressed("LeftCLick") and Input.is_action_pressed("RightClick") and Global.Ammo > 0:
		Global.Ammo -= 1
		var Bul = Bullet.instance()
		get_parent().add_child(Bul)
		$PlayerRig/Shooter/AudioPlayer.stream = ShootingSound
		$PlayerRig/Shooter/AudioPlayer.play()
		if $PlayerRig.scale == Vector2(-1,1):
			Bul.look_at(get_global_mouse_position())
	
	if Input.is_action_just_released("RightClick"):
		$PlayerRig/Hand.visible = true
		$PlayerRig/Shooter.visible = false
	
	if Input.is_action_pressed("TimeButton") and Global.Stamina > 0:
		Global.Time = true
	
	if !Input.is_action_pressed("TimeButton") and Global.Stamina < 100:
		Global.Time = false
	#-------------------------------------------------Compat
	pass

func EffectsAndOthers():
	#-------------------------------------------------Checking Gravity
	if !is_on_floor() and !JumpTrigger:
		Gravity += GravityEc
	elif is_on_floor() and !JumpTrigger:
		Gravity = FixableGravity
	
	
	Motion.x = Speed
	Motion.y = Gravity
	move_and_slide(Motion, GravFix)
	#-------------------------------------------------Checking Gravity
	
	#-------------------------------------------------Other Effects
	$Label.text = str(Global.Ammo)
	$Label2.text = str(Global.Health)
	$Label3.text = str(Global.Stamina)
	
	if Global.Health <= 0:
		Global.Health = 10
		get_tree().reload_current_scene()
	
	
	if Time:
		StaminaTimer -= get_process_delta_time()
	else: StaminaTimer -= get_process_delta_time()
	
	if Global.Time and StaminaTimer <= 0 and Global.Stamina > 0:
		Global.Stamina -= 1
		StaminaTimer = StaminaTimerOri
	
	if !Global.Time and Global.Stamina < 100 and StaminaTimer <= 0:
		Global.Stamina += 1
		StaminaTimer = StaminaTimerOri
	
	
	
	

func Animations():
	if $PlayerRig/AnimationPlayer.current_animation_position == $PlayerRig/AnimationPlayer.current_animation_length:
		$PlayerRig/AnimationPlayer.play($PlayerRig/AnimationPlayer.current_animation)
	
	if $PlayerRig/AnimationPlayer.current_animation == "Idle":
		$PlayerRig/AnimationPlayer.playback_speed = Idle_Speed
	
	if $PlayerRig/AnimationPlayer.current_animation == "Running":
		$PlayerRig/AnimationPlayer.playback_speed = Running_Speed




