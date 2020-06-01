extends Node2D

export var SpeedEc = 2
export var SpeedLimit = 10

var Inverse = false
var Motion = Vector2.ZERO


func _process(delta):
	
	Movement()
	Collision()
	
	pass



func Movement():
	
	if Inverse:
		Motion.x += SpeedEc
	else:	 Motion.x += -SpeedEc
	
	if Motion.x >= SpeedLimit:
		Motion.x = SpeedLimit
	
	if Motion.x <= -SpeedLimit:
		Motion.x = -SpeedLimit
	
	
	self.global_position += Motion

func Collision():
	var RightBody = $RightColl.get_colliding_bodies()
	var LeftBody = $LeftColl.get_colliding_bodies()
	
	for Body in RightBody:
		if Body.is_in_group("MPCollider"):
			Motion.x = 0
			Inverse = true
	
	for Body in LeftBody:
		if Body.is_in_group("MPCollider"):
			Motion.x = 0
			Inverse = false

