extends Node2D

export var MoveMotion = 1.0
export var MotionTimer = 0.5
export var MotionTimerOri = 0.5

export var Part1 = false
export var Part2 = false
export var Part3 = false

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
	#----------Timer Effect
	if Down:
		position.y += MoveMotion
	
	if Up:
		position.y -= MoveMotion
	#----------Timer Effect
	
	#----------Other
	
	if Part1:
		$Part1.visible = true
		$Part2.visible = false
		$Part3.visible = false
	
	if Part2:
		$Part2.visible = true
		$Part3.visible = false
		$Part1.visible = false
	
	if Part3:
		$Part3.visible = true
		$Part2.visible = false
		$Part1.visible = false
	
	#----------Other

func _on_PicturePiece_body_entered(body):
	if body.name == "Player":
		if Part1:
			Global.PicPart1 = true
			queue_free()
		
		if Part2:
			Global.PicPart2 = true
			queue_free()
		
		if Part3:
			Global.PicPart3 = true
			queue_free()




