extends Node2D


export var WaitngTimer = 5.0

var oneuse = true

func _physics_process(delta):
	
	WaitngTimer -= delta
	
	if WaitngTimer <= 0:
		WaitngTimer = 0
		if oneuse:
			$TextFrame.Starting = true
		oneuse = false
	
	if !has_node("TextFrame"):
		get_tree().quit()
	
	
	

