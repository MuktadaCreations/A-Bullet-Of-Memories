extends RigidBody2D

export var OriginalBulletSpeed = 200
export var BulletSpeed = 200
export var BulletLife = 10.0
export var ParticlesSpeed = -1000


var oneuse = false
export (AudioStream) var TimeSlow
export (AudioStream) var TimeFast
export (AudioStream) var BullethittingSound

var BulletCollisionTimer = 0.2
var Point = Vector2.ZERO
var ParticlesDisabler = false

onready var BulletPont = get_parent().get_node("Player/PlayerRig/Shooter/BulletPoint")
onready var BulletGo = get_parent().get_node("Player/PlayerRig/Shooter/BulletGo")
onready var Player = get_parent().get_node("Player")

func _ready():
	position = BulletPont.get_global_position()
	rotate(get_parent().get_node("Player/PlayerRig/Shooter").rotation)
	Point = (BulletGo.get_global_position() - position).normalized()

# warning-ignore:unused_argument
func _physics_process(delta):
	
	Movement()
	Effects()
	

func Movement():
	if Input.is_action_pressed("TimeButton") and !ParticlesDisabler and Global.Stamina > 0:
		BulletSpeed = Player.BulletTimeEffect
		$"Bullet Particles".gravity.x = ParticlesSpeed / 2
		if !Player.get_node("AudioPlayer").stream == TimeSlow:
			Player.get_node("AudioPlayer").stream = TimeSlow
			Player.get_node("AudioPlayer").play()
	elif Input.is_action_just_released("TimeButton") and !ParticlesDisabler:
		$"Bullet Particles".gravity.x = ParticlesSpeed
		BulletSpeed = OriginalBulletSpeed
		Player.get_node("AudioPlayer").stream = TimeFast
		Player.get_node("AudioPlayer").play()
	
	if Global.Stamina <= 0:
		BulletSpeed = OriginalBulletSpeed
	
	position += Point * BulletSpeed

func Effects():
	var Colliders = get_colliding_bodies()
	BulletLife -= get_physics_process_delta_time()
	BulletCollisionTimer -= get_physics_process_delta_time()
	
	for C in Colliders:
		if C.name == "Player":
			pass
		else:
			$"Bullet Collision".queue_free()
			$Bullet.queue_free()
			ParticlesDisabler = true
			$"Bullet Particles".queue_free()
			$AudioPlayer.stream = BullethittingSound
			$AudioPlayer.play()
			$LightOccluder2D.queue_free()
			oneuse = true
	
	if BulletLife <=0:
		queue_free()
	
	if oneuse == true:
		if !$AudioPlayer.playing:
			queue_free()
	
	if BulletCollisionTimer <= 0:
		set_collision_mask_bit(0, true)
		set_collision_layer_bit(0, true)


