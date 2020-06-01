extends Area2D

export var Health = 5

export var MoveMotion = 1
export var MotionTimer = 0.5
export var MotionTimerOri = 0.5

var Up = true
var Down = false

func _physics_process(delta):
	
	Timers()
	Effects()
	

func Timers():
	var delta = get_process_delta_time()
	MotionTimer -= delta
	
	if MotionTimer <= 0 and !Down:
		MotionTimer = MotionTimerOri
		Down = true
		Up = false
	
	if MotionTimer <= 0 and !Up:
		MotionTimer = MotionTimerOri
		Up = true
		Down = false
	

func Effects():
	
	if Down:
		position.y += MoveMotion
	
	if Up:
		position.y -= MoveMotion

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Global.Health += Health
		queue_free()
