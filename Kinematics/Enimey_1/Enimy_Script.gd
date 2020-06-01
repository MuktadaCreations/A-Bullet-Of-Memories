extends RigidBody2D

export (NodePath) var _Player
export (PackedScene) var EnemyBullet

export var OriginalShootingTImer = 1.0
export var ShootingTImer = 1.0
export var PlayerDetector = 800

var Health = 3
var DamegeTimer = 1.0

func _ready():
	$Enemy_Sprite_Damaged.visible = false
	$Enemy_Sprite_Damaged.modulate.a = 0
	pass


func _process(delta):
	
	Collision()
	Effects()
	Shooting()
	

func Effects():
	$EnemyHand.look_at(get_node(_Player).global_position)
	
	ShootingTImer -= get_process_delta_time()
	
	DamegeTimer -= 0.1
	$Enemy_Sprite_Damaged.modulate.a = DamegeTimer
	
	$Label.text = str(Health)
	
	if Health <= 0:
		queue_free()
	
	if DamegeTimer < 0:
		DamegeTimer = 0
		$Enemy_Sprite_Damaged.visible = false


func Collision():
	var Colliders = get_colliding_bodies()
	
	for body in Colliders:
		if body.is_in_group("PlayerBullet"):
			Health -= 1
			$Enemy_Sprite_Damaged.visible = true
			DamegeTimer = 1
		else:	pass

func Shooting():
	if ShootingTImer <= 0 and (self.global_position - get_node(_Player).global_position) <= Vector2(PlayerDetector, PlayerDetector):
		ShootingTImer = OriginalShootingTImer
		var Bul = EnemyBullet.instance()
		add_child(Bul)
		#Bul.look_at(get_node(_Player).global_position)
		Bul.global_position = $EnemyHand/Gun/BulletSpawn.global_position
		Bul.look_at(get_node(_Player).global_position)

