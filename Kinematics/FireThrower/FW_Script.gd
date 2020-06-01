extends Area2D

export var MainTimerOri = 3.0
export var MainTimer = 3.0
export var TimerOffset = 0.0
export var DamegePowerOri = 0.2
export var DamegePower = 0.2

var Fire = false
var DMG = false




func _process(delta):
	TimerOffset -= delta
	if TimerOffset <= 0:
		MainTimer -= delta
	
	AnimationandChecking()
	PlayerDamege()
	
	
	pass

func PlayerDamege():
	
	if DMG and $AnimatedSprite.animation == "Fire":
		DamegePower -= get_process_delta_time()
	
	if DamegePower <= 0:
		Global.Health -= 1
		DamegePower = DamegePowerOri
	
	
	pass

func AnimationandChecking():
	
	if TimerOffset <= 0:
		if MainTimer <= 0:
			Fire = !Fire
			MainTimer = MainTimerOri
		TimerOffset = 0
	
	if Fire:
		$AnimatedSprite.animation = "Fire"
	else:	 $AnimatedSprite.animation = "Idle"




func _on_FW_body_entered(body):
	if body.name == "Player":
		if $AnimatedSprite.animation == "Fire":
			Global.Health -= 1
		DMG = true


func _on_FW_body_exited(body):
	if body.name == "Player":
		DMG = false
