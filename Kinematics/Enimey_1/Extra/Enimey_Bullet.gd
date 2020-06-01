extends RigidBody2D

export var OriginalBulletSpeed = 200
export var BulletSpeed = 20
export var BulletLife = 10.0
export var ParticlesSpeed = -1000
export var StartingPosOffset = Vector2(-155, -10)


export (AudioStream) var BullethittingSound
export (AudioStream) var BulletShootingSound
export (AudioStream) var TimeSlow
export (AudioStream) var TimeFast
var oneuse = false
export var BulletTimeSlowSpeed = 35

var BulletCollisionTimer = 0.1
var Point = Vector2.ZERO
var ParticlesDisabler = false

onready var BulletPoint = get_parent().get_node("EnemyHand/Gun/BulletSpawn")
onready var BulletGo = get_parent().get_node("EnemyHand/Gun/BulletPoint")

func _ready():
	position = BulletPoint.global_position + StartingPosOffset
	Point = (BulletGo.get_global_position() + StartingPosOffset - position).normalized()
	look_at(Point)
	$AudioPlayer.stream = BulletShootingSound
	$AudioPlayer.play()
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	
	Movement()
	Effects()
	

func Movement():
	if Input.is_action_pressed("TimeButton") and !ParticlesDisabler and Global.Stamina > 0:
		BulletSpeed = BulletTimeSlowSpeed
		$"Bullet Particles".gravity.x = ParticlesSpeed / 2
		if !$AudioPlayer.stream == TimeSlow:
			$AudioPlayer.stream = TimeSlow
			$AudioPlayer.play()
	elif Input.is_action_just_released("TimeButton") and !ParticlesDisabler:
		$"Bullet Particles".gravity.x = ParticlesSpeed
		BulletSpeed = OriginalBulletSpeed
		$AudioPlayer.stream = TimeFast
		$AudioPlayer.play()
		
		if Global.Stamina <= 0:
			BulletSpeed = OriginalBulletSpeed
	
	
	position += Point * BulletSpeed
	pass

func Effects():
	var Colliders = get_colliding_bodies()
	BulletLife -= get_physics_process_delta_time()
	BulletCollisionTimer -= get_physics_process_delta_time()
	
	for body in Colliders:
		if body.name == "Player":
			Global.Health -= 1
			$"Bullet Collision".queue_free()
			$Bullet.queue_free()
			ParticlesDisabler = true
			$"Bullet Particles".queue_free()
			$AudioPlayer.stream = BullethittingSound
			$AudioPlayer.play()
			oneuse = true
		else:
			$"Bullet Collision".queue_free()
			$Bullet.queue_free()
			ParticlesDisabler = true
			$"Bullet Particles".queue_free()
			$AudioPlayer.stream = BullethittingSound
			$AudioPlayer.play()
			oneuse = true
	
	if BulletLife <=0:
		queue_free()
	
	if oneuse == true:
		if !$AudioPlayer.playing:
			queue_free()
	
	if BulletCollisionTimer <= 0:
		set_collision_mask_bit(0, true)
		set_collision_layer_bit(0, true)


